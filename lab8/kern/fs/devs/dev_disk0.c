#include <defs.h>
#include <mmu.h>
#include <sem.h>
#include <ide.h>
#include <inode.h>
#include <kmalloc.h>
#include <dev.h>
#include <vfs.h>
#include <iobuf.h>
#include <error.h>
#include <assert.h>

// disk0 设备：块设备（block device）实现。
// 设计要点：
// - 对外暴露为“按块读写”的设备：一次 I/O 必须块对齐。
// - 底层 IDE 驱动按“扇区（SECTSIZE）”读写，这里负责把“块号/块数”转换成“扇区号/扇区数”。
// - 通过一个信号量把 disk0 的并发 I/O 串行化，避免多个线程同时操作同一块 bounce buffer。
// - 使用 bounce buffer（disk0_buffer）：
//   - 读：先把磁盘数据读入 disk0_buffer，再拷到 iobuf。
//   - 写：先把 iobuf 数据拷到 disk0_buffer，再写回磁盘。

#define DISK0_BLKSIZE                   PGSIZE               // 设备“块大小”：这里选用一个页大小（通常 4KB）
#define DISK0_BUFSIZE                   (4 * DISK0_BLKSIZE)  // bounce buffer 大小：一次最多缓存 4 个块
#define DISK0_BLK_NSECT                 (DISK0_BLKSIZE / SECTSIZE) // 一个块等于多少个扇区

static char *disk0_buffer;              // bounce buffer：I/O 临时缓冲区（内核态）
static semaphore_t disk0_sem;           // 互斥：保护 disk0_buffer 和 IDE 访问的串行化

static void
lock_disk0(void) {
    down(&(disk0_sem));                 // P(down)：获取互斥锁（可能睡眠）
}

static void
unlock_disk0(void) {
    up(&(disk0_sem));                   // V(up)：释放互斥锁
}

static int
disk0_open(struct device *dev, uint32_t open_flags) {
    return 0;                           // disk0 不需要特殊 open 逻辑
}

static int
disk0_close(struct device *dev) {
    return 0;                           // disk0 不需要特殊 close 逻辑
}

static void
disk0_read_blks_nolock(uint32_t blkno, uint32_t nblks) {
    int ret;                             // IDE 读扇区返回码
    // 把“块号/块数”转换为“扇区号/扇区数”
    uint32_t sectno = blkno * DISK0_BLK_NSECT, nsecs = nblks * DISK0_BLK_NSECT;
    // 读：把 nsecs 个扇区从磁盘读入 bounce buffer
    if ((ret = ide_read_secs(DISK0_DEV_NO, sectno, disk0_buffer, nsecs)) != 0) {
        panic("disk0: read blkno = %d (sectno = %d), nblks = %d (nsecs = %d): 0x%08x.\n",
                blkno, sectno, nblks, nsecs, ret);
    }
}

static void
disk0_write_blks_nolock(uint32_t blkno, uint32_t nblks) {
    int ret;                             // IDE 写扇区返回码
    // 把“块号/块数”转换为“扇区号/扇区数”
    uint32_t sectno = blkno * DISK0_BLK_NSECT, nsecs = nblks * DISK0_BLK_NSECT;
    // 写：把 bounce buffer 的内容写回磁盘（nsecs 个扇区）
    if ((ret = ide_write_secs(DISK0_DEV_NO, sectno, disk0_buffer, nsecs)) != 0) {
        panic("disk0: write blkno = %d (sectno = %d), nblks = %d (nsecs = %d): 0x%08x.\n",
                blkno, sectno, nblks, nsecs, ret);
    }
}

static int
disk0_io(struct device *dev, struct iobuf *iob, bool write) {
    off_t offset = iob->io_offset;        // I/O 起始偏移（字节）
    size_t resid = iob->io_resid;         // 剩余需要传输的字节数
    uint32_t blkno = offset / DISK0_BLKSIZE; // 起始块号
    uint32_t nblks = resid / DISK0_BLKSIZE;  // 总块数（因为要求块对齐，所以应为整数）

    /* 不允许非块对齐的 I/O：否则无法用 blkno/nblks 精确表达 */
    if ((offset % DISK0_BLKSIZE) != 0 || (resid % DISK0_BLKSIZE) != 0) {
        return -E_INVAL;
    }

    /* 不允许越过 disk0 末尾：blkno+nblks 不能超过设备总块数 */
    if (blkno + nblks > dev->d_blocks) {
        return -E_INVAL;
    }

    /* 读/写 0 字节：直接成功返回 */
    if (nblks == 0) {
        return 0;
    }

    lock_disk0();                          // 串行化 disk0 I/O（保护 bounce buffer 和 IDE 操作）
    while (resid != 0) {                   // 分批处理：每次最多处理 DISK0_BUFSIZE 字节
        size_t copied, alen = DISK0_BUFSIZE; // alen：本轮期望处理的字节数；copied：实际处理字节数
        if (write) {                       // 写：iob -> bounce buffer -> disk
            // 从 iobuf 把数据搬到 disk0_buffer（direction=0 表示从 iobuf 到 buffer）
            iobuf_move(iob, disk0_buffer, alen, 0, &copied);
            // copied 必须为块对齐、且不超过 resid
            assert(copied != 0 && copied <= resid && copied % DISK0_BLKSIZE == 0);
            nblks = copied / DISK0_BLKSIZE; // 本轮写多少块
            disk0_write_blks_nolock(blkno, nblks); // 写回磁盘
        }
        else {                             // 读：disk -> bounce buffer -> iob
            if (alen > resid) {            // 最后一轮可能不足一个 DISK0_BUFSIZE
                alen = resid;
            }
            nblks = alen / DISK0_BLKSIZE;  // 本轮读多少块
            disk0_read_blks_nolock(blkno, nblks); // 先读到 bounce buffer
            // 再把 bounce buffer 搬到 iobuf（direction=1 表示从 buffer 到 iobuf）
            iobuf_move(iob, disk0_buffer, alen, 1, &copied);
            assert(copied == alen && copied % DISK0_BLKSIZE == 0);
        }
        resid -= copied;                   // 更新剩余字节数
        blkno += nblks;                    // 推进块号
    }
    unlock_disk0();                        // 释放互斥锁
    return 0;                              // 块设备 I/O 成功
}

static int
disk0_ioctl(struct device *dev, int op, void *data) {
    return -E_UNIMP;                       // 本实验未实现 ioctl
}

static void
disk0_device_init(struct device *dev) {
    static_assert(DISK0_BLKSIZE % SECTSIZE == 0); // 确保块大小能被扇区大小整除（否则无法整扇区读写）
    if (!ide_device_valid(DISK0_DEV_NO)) {        // 检查 IDE 设备是否存在
        panic("disk0 device isn't available.\n");
    }
    // 设备总块数 = 设备总扇区数 / 每块扇区数
    dev->d_blocks = ide_device_size(DISK0_DEV_NO) / DISK0_BLK_NSECT;
    dev->d_blocksize = DISK0_BLKSIZE;             // 对外暴露的块大小
    dev->d_open = disk0_open;                     // 注册 open 回调
    dev->d_close = disk0_close;                   // 注册 close 回调
    dev->d_io = disk0_io;                         // 注册 I/O 回调
    dev->d_ioctl = disk0_ioctl;                   // 注册 ioctl 回调
    sem_init(&(disk0_sem), 1);                    // 初始化信号量为 1（互斥锁）

    static_assert(DISK0_BUFSIZE % DISK0_BLKSIZE == 0); // 缓冲区大小必须是块大小的整数倍
    if ((disk0_buffer = kmalloc(DISK0_BUFSIZE)) == NULL) { // 分配 bounce buffer
        panic("disk0 alloc buffer failed.\n");
    }
}

void
dev_init_disk0(void) {
    struct inode *node;                      // 用 inode 抽象包装设备，便于挂到 VFS
    if ((node = dev_create_inode()) == NULL) { // 创建一个设备 inode
        panic("disk0: dev_create_node.\n");
    }
    disk0_device_init(vop_info(node, device)); // 初始化 inode 内部的 device 为 disk0 设备

    int ret;                                 // 注册返回值
    if ((ret = vfs_add_dev("disk0", node, 1)) != 0) { // 注册到 VFS：名字为 "disk0"，1 表示可作为块设备/默认设备（依实现）
        panic("disk0: vfs_add_dev: %e.\n", ret);
    }
}

