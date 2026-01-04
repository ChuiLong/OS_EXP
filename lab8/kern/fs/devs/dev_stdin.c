#include <defs.h>
#include <stdio.h>
#include <wait.h>
#include <sync.h>
#include <proc.h>
#include <sched.h>
#include <dev.h>
#include <vfs.h>
#include <iobuf.h>
#include <inode.h>
#include <unistd.h>
#include <error.h>
#include <assert.h>

// stdin 设备：提供一个“字符流输入”的虚拟设备。
// 设计要点：
// - 用一个固定大小的环形缓冲区保存键盘/串口输入的字符。
// - 读操作在没有数据时睡眠，等待输入到来后被唤醒。
// - 写入/读取缓冲区的关键路径需要关中断保护（避免中断上下文/并发访问破坏 p_rpos/p_wpos）。

#define STDIN_BUFSIZE               4096        // stdin 环形缓冲区容量（字节/字符）

static char stdin_buffer[STDIN_BUFSIZE];        // 环形缓冲区本体
static off_t p_rpos, p_wpos;                    // 读指针/写指针（逻辑位置，允许一直递增，用 % 做环绕）
static wait_queue_t __wait_queue, *wait_queue = &__wait_queue; // 等待队列：读不到数据时把当前进程挂在这里

void
dev_stdin_write(char c) {
    bool intr_flag;                              // 保存并恢复中断开关状态
    if (c != '\0') {                            // 约定：'\0' 作为“无输入/无效输入”，不写入缓冲
        local_intr_save(intr_flag);              // 关中断：保护缓冲区与 p_rpos/p_wpos 的一致性
        {
            stdin_buffer[p_wpos % STDIN_BUFSIZE] = c;   // 写入环形缓冲（用取模实现回绕）
            if (p_wpos - p_rpos < STDIN_BUFSIZE) {      // 若缓冲未满，则推进写指针
                p_wpos ++;                               // 注意：这里 p_wpos/p_rpos 是“逻辑位置”，不直接回绕
            }
            // 如果有进程正在等待键盘输入，则唤醒它们（WT_KBD 作为唤醒原因/事件类型）
            if (!wait_queue_empty(wait_queue)) {
                wakeup_queue(wait_queue, WT_KBD, 1);    // 1 表示唤醒一个（或按实现定义）
            }
        }
        local_intr_restore(intr_flag);           // 恢复中断状态
    }
}

static int
dev_stdin_read(char *buf, size_t len) {
    int ret = 0;                                 // 实际读到的字节数
    bool intr_flag;                              // 保存并恢复中断状态
    local_intr_save(intr_flag);                  // 关中断：保护对 p_rpos/p_wpos 的检查与更新
    {
        // 循环读取最多 len 个字符：每成功读取一个字符，ret++，并推进读指针 p_rpos
        for (; ret < len; ret ++, p_rpos ++) {
        try_again:
            if (p_rpos < p_wpos) {               // 缓冲区里有数据可读
                *buf ++ = stdin_buffer[p_rpos % STDIN_BUFSIZE]; // 取出一个字符并写入用户提供的 buf
            }
            else {
                // 没有数据：把当前进程挂到 wait_queue 上，然后让出 CPU 等待输入
                wait_t __wait, *wait = &__wait;  // 在栈上构造一个 wait 结点，描述当前进程的等待状态
                wait_current_set(wait_queue, wait, WT_KBD); // 将当前进程加入等待队列，等待事件 WT_KBD
                local_intr_restore(intr_flag);   // 睡眠前必须开中断：否则系统无法响应外设中断/唤醒

                schedule();                      // 主动调度：当前进程进入睡眠，切换到其他可运行进程

                local_intr_save(intr_flag);      // 被唤醒后重新关中断，恢复对共享状态的保护
                wait_current_del(wait_queue, wait); // 将当前进程从等待队列移除（避免重复挂载/悬挂指针）
                if (wait->wakeup_flags == WT_KBD) { // 如果确实是键盘输入唤醒，回去重新检查（防止虚假唤醒）
                    goto try_again;
                }
                break;                            // 否则是其他原因唤醒（如被信号/杀死），提前结束读
            }
        }
    }
    local_intr_restore(intr_flag);               // 结束读操作，恢复中断状态
    return ret;                                  // 返回实际读到的字节数（可能小于 len）
}

static int
stdin_open(struct device *dev, uint32_t open_flags) {
    // stdin 只支持只读打开：对 stdin 写入没有意义（写入由内核/驱动通过 dev_stdin_write 完成）
    if (open_flags != O_RDONLY) {
        return -E_INVAL;                         // 非法打开方式
    }
    return 0;                                    // 打开成功
}

static int
stdin_close(struct device *dev) {
    return 0;                                    // 关闭 stdin：无资源需要释放
}

static int
stdin_io(struct device *dev, struct iobuf *iob, bool write) {
    // 设备 I/O 入口：由 VFS/设备层调用，iob 描述用户缓冲区与剩余长度
    if (!write) {                                // read 路径
        int ret;                                 // 本次读取字节数
        if ((ret = dev_stdin_read(iob->io_base, iob->io_resid)) > 0) {
            iob->io_resid -= ret;                // 更新 iobuf 剩余未读长度
        }
        return ret;                              // 返回读取结果（>0 或错误码）
    }
    return -E_INVAL;                             // write 路径：stdin 不支持写
}

static int
stdin_ioctl(struct device *dev, int op, void *data) {
    return -E_INVAL;                             // stdin 不支持 ioctl
}

static void
stdin_device_init(struct device *dev) {
    // 初始化 device 抽象层的回调与属性
    dev->d_blocks = 0;                           // 字符设备：不按块组织
    dev->d_blocksize = 1;                        // 以字节为最小单位
    dev->d_open = stdin_open;                    // open 回调
    dev->d_close = stdin_close;                  // close 回调
    dev->d_io = stdin_io;                        // read/write 回调
    dev->d_ioctl = stdin_ioctl;                  // ioctl 回调

    p_rpos = p_wpos = 0;                         // 初始化读写指针
    wait_queue_init(wait_queue);                 // 初始化等待队列
}

void
dev_init_stdin(void) {
    struct inode *node;                          // 用 inode 抽象挂载一个设备节点
    if ((node = dev_create_inode()) == NULL) {   // 为设备创建一个 inode
        panic("stdin: dev_create_node.\n");    // 创建失败直接崩溃（启动阶段必须成功）
    }
    stdin_device_init(vop_info(node, device));   // 把 inode 里的 device 结构初始化为 stdin 设备

    int ret;                                     // 注册到 VFS 的返回码
    if ((ret = vfs_add_dev("stdin", node, 0)) != 0) { // 把该设备以名字 "stdin" 注册到 VFS 设备表
        panic("stdin: vfs_add_dev: %e.\n", ret);      // 注册失败直接崩溃
    }
}

