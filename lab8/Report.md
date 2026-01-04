# Lab8-Report

## Ex1： 完成读文件操作的实现

### 问题描述

首先了解打开文件的处理流程，然后参考本实验后续的文件读写操作的过程分析，填写在 kern/fs/sfs/sfs_inode.c中 的sfs_io_nolock()函数，实现读文件中数据的代码。

### 问题解决

我们首先完成这一份代码，那么我们首先对这一个实现完成之后的函数进行展示：

```C
static int
sfs_io_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, void *buf, off_t offset, size_t *alenp, bool write) {
    struct sfs_disk_inode *din = sin->din;
    assert(din->type != SFS_TYPE_DIR);
    off_t endpos = offset + *alenp, blkoff;
    *alenp = 0;
	// calculate the Rd/Wr end position
    if (offset < 0 || offset >= SFS_MAX_FILE_SIZE || offset > endpos) {
        return -E_INVAL;
    }
    if (offset == endpos) {
        return 0;
    }
    if (endpos > SFS_MAX_FILE_SIZE) {
        endpos = SFS_MAX_FILE_SIZE;
    }
    if (!write) {
        if (offset >= din->size) {
            return 0;
        }
        if (endpos > din->size) {
            endpos = din->size;
        }
    }

    int (*sfs_buf_op)(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset);
    int (*sfs_block_op)(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks);
    if (write) {
        sfs_buf_op = sfs_wbuf, sfs_block_op = sfs_wblock;
    }
    else {
        sfs_buf_op = sfs_rbuf, sfs_block_op = sfs_rblock;
    }

    int ret = 0;
    size_t size, alen = 0;
    uint32_t ino;
    uint32_t blkno = offset / SFS_BLKSIZE;          // The NO. of Rd/Wr begin block
    uint32_t nblks = endpos / SFS_BLKSIZE - blkno;  // The size of Rd/Wr blocks
    // (1) 处理第一个块（可能不对齐）
    if ((blkoff = offset % SFS_BLKSIZE) != 0) {
        size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_buf_op(sfs, buf, size, ino, blkoff)) != 0) {
            goto out;
        }
        alen += size;
        if (nblks == 0) {
            goto out;
        }
        buf += size;
        blkno++;
        nblks--;
    }

    // (2) 处理对齐的中间块
    while (nblks != 0) {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_block_op(sfs, buf, ino, 1)) != 0) {
            goto out;
        }
        alen += SFS_BLKSIZE;
        buf += SFS_BLKSIZE;
        blkno ++;
        nblks --;
    }

    // (3) 处理最后一个块（可能不对齐）
    if ((size = endpos % SFS_BLKSIZE) != 0) {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_buf_op(sfs, buf, size, ino, 0)) != 0) {
            goto out;
        }
        alen += size;
    }

out:
    *alenp = alen;
    if (offset + alen > sin->din->size) {
        sin->din->size = offset + alen;
        sin->dirty = 1;
    }
    return ret;
}
```

接下来我们就来详细分析一下这一个函数。
          
`sfs_io_nolock` 是 SFS (Simple File System) 文件系统中用于执行**底层文件读写操作**的核心函数。

该函数的主要作用是在**不加锁**的情况下（调用者需保证互斥），将数据从磁盘读入内存（read），或者将内存数据写入磁盘（write）。它处理了文件偏移量（offset）、块对齐（alignment）以及逻辑块到物理块的映射。其对应的参数含义如下：

- `sfs`: 文件系统实例。
- `sin`: 对应的文件内存 inode。
- `buf`: 数据缓冲区（读操作的目标，写操作的源）。
- `offset`: 文件内的读写起始偏移量。
- `alenp`: 输入期望读写的长度，输出实际完成的长度。
- `write`: 标志位，`1` 表示写，`0` 表示读。

该函数将一次 I/O 请求拆分为三个部分来处理，这是文件系统处理未对齐 I/O 的典型模式：

1.  **处理起始非对齐部分 (Head)**
    -   如果 `offset` 不是从块的起始位置开始（即 `offset % SFS_BLKSIZE != 0`），函数会先处理这第一个不完整的块。
    -   它计算该块中需要读写的大小，调用 `sfs_bmap_load_nolock` 获取对应的磁盘物理块号，然后使用 `sfs_buf_op`（`sfs_wbuf` 或 `sfs_rbuf`）进行部分块的读写。
2.  **处理中间对齐的块 (Body)**
    -   对于中间完整的块（`nblks > 0`），直接按块进行读写。
    -   它计算涉及的块数，获取物理块号，然后调用 `sfs_block_op`（`sfs_wblock` 或 `sfs_rblock`）进行整块数据传输。
    -   *注意：代码中的实现看似假设了这部分物理块是连续的，或者通过循环调用（具体取决于 `sfs_block_op` 的实现，但在标准 ucore lab 实现中，这里通常需要循环处理每个块，因为文件在磁盘上可能是不连续存储的）。*
3.  **处理末尾非对齐部分 (Tail)**
    -   如果结束位置 `endpos` 不是块的边界，处理最后一个不完整的块。
    -   同样获取物理块号，并读写剩余的数据。

除此之外，这个函数还可以：

-   **边界检查**：检查 offset 是否越界，是否超过最大文件大小等。
-   **文件大小更新**：如果是写操作（`write` 为 true）且写入位置超过了当前文件大小，会更新 inode 中的 `size` 字段，并将 inode 标记为 dirty（脏），以便后续同步到磁盘。

简单来说，`sfs_io_nolock` 的作用就是：**算出你要读写的数据对应磁盘上的哪些块，处理好头尾不对齐的情况，然后把数据搬运过去。**

接下来我们逐行分析一下这个代码：

### 函数签名与初始化 (553-557 行)

```c
553 sfs_io_nolock(struct sfs_fs *sfs, struct sfs_inode *sin, void *buf, off_t offset, size_t *alenp, bool write) {
554    struct sfs_disk_inode *din = sin->din;
555    assert(din->type != SFS_TYPE_DIR);
556    off_t endpos = offset + *alenp, blkoff;
557    *alenp = 0;
```

*   **L553**: 参数包括文件系统指针 `sfs`、内存 inode `sin`、数据缓冲区 `buf`、文件偏移量 `offset`、长度指针 `alenp`（输入期望长度，输出实际长度）以及读写标志 `write`。
*   **L554**: 获取磁盘 inode 指针 `din`，它包含文件大小、类型等元数据。
*   **L555**: 断言文件类型不是目录，这么处理的原因是目录的读写通常有专门函数，且指导书里声明该函数仅支持普通文件。
*   **L556**: 计算结束位置 `endpos`。
*   **L557**: 将实际传输长度 `*alenp` 初始化为 0，用于累加。

### 边界检查与修正 (559-575 行)

```c
559    if (offset < 0 || offset >= SFS_MAX_FILE_SIZE || offset > endpos) {
560        return -E_INVAL;
561    }
562    if (offset == endpos) {
563        return 0;
564    }
565    if (endpos > SFS_MAX_FILE_SIZE) {
566        endpos = SFS_MAX_FILE_SIZE;
567    }
568    if (!write) {
569        if (offset >= din->size) {
570            return 0;
571        }
572        if (endpos > din->size) {
573            endpos = din->size;
574        }
575    }
```

*   **L559-561**: 基本合法性检查，偏移量不能为负，不能超过 SFS 允许的最大文件大小。
*   **L562-564**: 如果读写长度为 0（offset == endpos），直接返回成功。
*   **L565-567**: 截断结束位置，防止超出文件系统支持的最大限制。
*   **L568-575**: **读操作特有的检查**。
    *   如果是**读**，你不能读取超过文件实际大小 `din->size` 的部分。
    *   如果偏移量已经超过文件大小，读不到数据，返回 0。
    *   如果结束位置超过文件大小，将结束位置截断到文件大小（即只读到文件末尾）。
    *   **注意**：写操作不需要这个检查，因为写操作可以扩展文件大小。

### 操作函数选择 (577-584 行)

```c
577    int (*sfs_buf_op)(struct sfs_fs *sfs, void *buf, size_t len, uint32_t blkno, off_t offset);
578    int (*sfs_block_op)(struct sfs_fs *sfs, void *buf, uint32_t blkno, uint32_t nblks);
579    if (write) {
580        sfs_buf_op = sfs_wbuf, sfs_block_op = sfs_wblock;
581    }
582    else {
583        sfs_buf_op = sfs_rbuf, sfs_block_op = sfs_rblock;
584    }
```

*   这里使用了**函数指针**来实现多态。
*   `sfs_buf_op`: 用于处理**部分块**的读写（对应 `sfs_wbuf` / `sfs_rbuf`）。
*   `sfs_block_op`: 用于处理**整块**的读写（对应 `sfs_wblock` / `sfs_rblock`）。
*   根据 `write` 标志选择对应的底层驱动函数。

### 块计算 (586-590 行)

```c
589    uint32_t blkno = offset / SFS_BLKSIZE;          // The NO. of Rd/Wr begin block
590    uint32_t nblks = endpos / SFS_BLKSIZE - blkno;  // The size of Rd/Wr blocks
```

*   **L589**: 计算起始的**逻辑块号**（Logical Block Number）。例如 offset 是 4097，块大小 4096，则 `blkno` 为 1。
*   **L590**: 计算中间包含的**完整块**的数量。注意这里只是初步计算，具体的逻辑在后面细分。

---

### 核心处理逻辑：三段式 (Head - Body - Tail)

这是文件系统 IO 最经典的处理方式，因为用户请求的 offset 和 length 很少恰好对齐块边界。

#### 第一段：处理不对齐的头部 (Head) (604-619 行)

```c
604    if ((blkoff = offset % SFS_BLKSIZE) != 0) {
605        size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
606        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
607            goto out;
608        }
609        if ((ret = sfs_buf_op(sfs, buf, size, ino, blkoff)) != 0) {
610            goto out;
611        }
...
617        blkno++;
618        nblks--;
619    }
```

*   **L604**: `blkoff` 是块内偏移。如果不为 0，说明起始位置不在块边界。
*   **L605**: 计算这次需要处理的大小 `size`。
    *   如果跨越了多个块 (`nblks != 0`)，则读取该块剩余部分 (`SFS_BLKSIZE - blkoff`)。
    *   如果总操作就在这一个块内，则读取到 `endpos` (`endpos - offset`)。
*   **L606**: `sfs_bmap_load_nolock` 是关键函数。它将文件的**逻辑块号** `blkno` 映射为磁盘的**物理块号** `ino`。如果是写操作且块不存在，它还会负责分配新块。
*   **L609**: 调用 `sfs_buf_op`（读或写 buffer），从块内偏移 `blkoff` 处开始操作 `size` 字节。
*   **L617-618**: 处理完头部后，逻辑块号加 1，剩余完整块数减 1。

#### 第二段：处理对齐的中间块 (Body) (622-632 行)

```c
    // (2) 处理对齐的中间块
    while (nblks != 0) {  // 改动点1：将 if 改为 while 循环
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        if ((ret = sfs_block_op(sfs, buf, ino, 1)) != 0) { // 改动点2：每次只操作 1 个块
            goto out;
        }
        alen += SFS_BLKSIZE;     // 改动点3：累加 1 个块的大小
        buf += SFS_BLKSIZE;      // 指针后移 1 个块
        blkno ++;                // 逻辑块号 +1
        nblks --;                // 剩余块数 -1
    }
```

1.  **`while (nblks != 0) {`**
    *   意味着我们将**逐块**处理。这是为了应对文件在磁盘上**物理存储不连续**的情况。SFS 文件系统虽然简单，但文件块通过索引节点（inode）映射，逻辑上连续的 `blkno`（如 0, 1, 2）对应的物理块 `ino`（如 100, 500, 102）完全可能是离散的。
2.  **`if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0)`**
    *   **作用**: 将当前文件的**逻辑块号** (`blkno`) 映射为磁盘上的**物理块号** (`ino`)。
    *   **关键点**: 在循环中调用这一步至关重要。因为每次循环 `blkno` 都会递增，我们需要查询**每一个**逻辑块对应的物理地址。
3.  **`if ((ret = sfs_block_op(sfs, buf, ino, 1)) != 0)`**
    *   **原代码**: `sfs_block_op(sfs, buf, ino, nblks)`
    *   **分析**:
        *   `sfs_block_op` 指向 `sfs_rblock` (读) 或 `sfs_wblock` (写)。
        *   我们将最后一个参数从 `nblks` 改为 `1`。
        *   这意味着我们命令底层驱动：“请把物理块 `ino` 的数据读/写到 `buf` 中，只操作 **1个块**”。
    *   **为什么这样做**: 因为 `ino` 是当前这一个块的物理地址。下一个逻辑块的物理地址未知（需要下一次循环 `bmap` 才知道），所以不能一次性操作多个块。
4.  **`alen += SFS_BLKSIZE;`**
    *   **作用**: 累加实际已传输的字节数。
    *   **数值**: `SFS_BLKSIZE` 通常是 4096 字节。
5.  **`buf += SFS_BLKSIZE;`**
    *   **作用**: 内存缓冲区指针前移，为读取/写入下一个块的数据腾出位置。
6.  **`blkno ++;`**
    *   **作用**: 逻辑块号加 1，准备处理文件中的下一个块。
7.  **`nblks --;`**
    *   **作用**: 剩余需要处理的块数减 1。循环直到 `nblks` 归零。

#### 第三段：处理不对齐的尾部 (Tail) (635-643 行)

```c
635    if ((size = endpos % SFS_BLKSIZE) != 0) {
636        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
637            goto out;
638        }
639        if ((ret = sfs_buf_op(sfs, buf, size, ino, 0)) != 0) {
640            goto out;
641        }
642        alen += size;
643    }
```

*   **L635**: 如果结束位置不在块边界（`endpos % SFS_BLKSIZE != 0`），说明最后还有一个残缺的块要处理。
*   **L636**: 映射最后一个块的物理地址。
*   **L639**: 从块的起始位置（偏移 0）读写 `size` 字节。

```c
645 out:
646    *alenp = alen;
647    if (offset + alen > sin->din->size) {
648        sin->din->size = offset + alen;
649        sin->dirty = 1;
650    }
```

*   **L646**: 返回实际读写的字节数。
*   **L647-649**: 如果是写操作导致文件变大（当前偏移 + 写入长度 > 原文件大小），则更新 inode 中的文件大小 `size`，并标记 inode 为 `dirty`，以便后续将 inode 元数据写回磁盘。

## Ex2——完成基于文件系统的执行程序机制的实现

### 问题描述

改写proc.c中的load_icode函数和其他相关函数，实现基于文件系统的执行程序机制。执行：make qemu。如果能看看到sh用户程序的执行界面，则基本成功了。如果在sh用户界面上可以执行`exit`, `hello`（更多用户程序放在`user`目录下）等其他放置在`sfs`文件系统中的其他执行程序，则可以认为本实验基本成功。

### 问题解决

本次修改的核心目标是**引入文件系统支持**，使得 `load_icode` 函数能够从文件系统中读取 ELF 程序文件并加载执行，而不是像 Lab5/Lab6/Lab7 那样直接从内核内存（链接进去的二进制数组）中加载。

#### 1. `proc_struct` 结构体初始化 (`alloc_proc`)

在 `alloc_proc` 函数中，增加了对文件系统相关字段的初始化。

*   **修改前**: 仅初始化进程基本状态。
*   **修改后**:
    *   增加了 `proc->filesp = NULL;`，初始化文件描述符表指针为空。

```C
alloc_proc(void)
{
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
    if (proc != NULL)
    {
        proc->state = PROC_UNINIT;
        proc->pid = -1;
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&(proc->context), 0, sizeof(struct context));
        proc->tf = NULL;
        proc->pgdir = boot_pgdir_pa;
        proc->flags = 0;
        memset(proc->name, 0, PROC_NAME_LEN);
        // lab5 add:
        proc->wait_state = 0;
        proc->cptr = proc->optr = proc->yptr = NULL;
        proc->rq = NULL;              // 初始化运行队列为空
        list_init(&(proc->run_link)); // 初始化运行队列的指针
        proc->time_slice = 0;
        proc->lab6_run_pool.left = proc->lab6_run_pool.right = proc->lab6_run_pool.parent = NULL;
        proc->lab6_stride = 0;
        proc->lab6_priority = 0;
        proc->filesp = NULL;
    }
```

#### 2. `do_fork` 函数增强

`do_fork` 增加了对文件系统资源（文件描述符表）的复制处理。

```C
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
    {
        goto fork_out;
    }
    ret = -E_NO_MEM;
    //    1. call alloc_proc to allocate a proc_struct
    if ((proc = alloc_proc()) == NULL) {
        goto fork_out;
    }
    proc->parent = current;                            // 设置子进程的父进程为当前进程
    assert(current->wait_state == 0);                  // 确保当前进程没有在等待
    
    //    2. call setup_kstack to allocate a kernel stack for child process
    if (setup_kstack(proc) != 0) {
        goto bad_fork_cleanup_proc;
    }
    
    //    3. call copy_mm to dup OR share mm according clone_flag
    if (copy_mm(clone_flags, proc) != 0) {
        goto bad_fork_cleanup_kstack;
    }
    
    //    4. call copy_thread to setup tf & context in proc_struct
    copy_thread(proc, stack, tf);
    
    // LAB8: copy files_struct
    if (copy_files(clone_flags, proc) != 0)
    { 
        goto bad_fork_cleanup_kstack;
    }
    
    //    5. insert proc_struct into hash_list && proc_list, set the relation links of process
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        proc->pid = get_pid();
        hash_proc(proc);
        set_links(proc);                               // 使用 set_links 建立进程间的关系
    }
    local_intr_restore(intr_flag);
    
    //    6. call wakeup_proc to make the new child process RUNNABLE
    wakeup_proc(proc);
    
    //    7. set ret vaule using child proc's pid
    ret = proc->pid;
    
fork_out:
    return ret;

bad_fork_cleanup_fs: // for LAB8
    put_files(proc);
bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
```



*   **新增逻辑**:
    *   调用了 `copy_files(clone_flags, proc)`。
    *   如果 `CLONE_FS` 标志被设置，子进程将共享父进程的文件系统信息；否则，会复制一份新的文件描述符表。
    *   增加了对应的错误处理路径 `bad_fork_cleanup_fs`。

#### 3. 辅助函数：`copy_files` 和 `put_files` (新增)

为了支持 `do_fork` 和进程退出，新增了两个辅助函数：

* **`copy_files`**: 用于在 fork 时复制父进程的打开文件表。

* ```C
  static int
  copy_files(uint32_t clone_flags, struct proc_struct *proc)
  {
      struct files_struct *filesp, *old_filesp = current->filesp;
      assert(old_filesp != NULL);
  
      if (clone_flags & CLONE_FS)
      {
          filesp = old_filesp;
          goto good_files_struct;
      }
  
      int ret = -E_NO_MEM;
      if ((filesp = files_create()) == NULL)
      {
          goto bad_files_struct;
      }
  
      if ((ret = dup_files(filesp, old_filesp)) != 0)
      {
          goto bad_dup_cleanup_fs;
      }
  
  good_files_struct:
      files_count_inc(filesp);
      proc->filesp = filesp;
      return 0;
  
  bad_dup_cleanup_fs:
      files_destroy(filesp);
  bad_files_struct:
      return ret;
  }
  ```

* **`put_files`**: 用于在进程退出或出错时减少文件表的引用计数，并在计数为 0 时销毁它。

  ```C
  static void
  put_files(struct proc_struct *proc)
  {
      struct files_struct *filesp = proc->filesp;
      if (filesp != NULL)
      {
          if (files_count_dec(filesp) == 0)
          {
              files_destroy(filesp);
          }
      }
  }
  ```

#### 4. `load_icode` 函数重构 (核心修改)

这是改动最大的部分。函数的签名和实现逻辑都发生了根本变化。

* **函数签名**:

  *   **修改前**: `static int load_icode(unsigned char *binary, size_t size)`
      *   直接接收内存中的二进制数据指针和大小。
  *   **修改后**: `static int load_icode(int fd, int argc, char **kargv)`
      *   接收**文件描述符 (fd)**，以及参数个数和参数列表。
      *   这意味着 `load_icode` 不再关心文件在哪里，只关心通过 `fd` 读取数据。

* **读取方式**:

  * **修改前**: 直接通过指针访问内存，如 `struct elfhdr *elf = (struct elfhdr *)binary;` 和 `memcpy`。

  * **修改后**: 必须通过文件 I/O 函数读取。

    * 引入了辅助函数 `load_icode_read(fd, buf, len, offset)`，它内部封装了 `sysfile_seek` 和 `sysfile_read`。

      ```C
      ret = load_icode_read(fd, elf, sizeof(struct elfhdr), 0)) != 0
      ```

      

    * 所有的 ELF 头读取 (`elfhdr`)、程序头读取 (`proghdr`) 以及段数据加载，都从 `memcpy` 变成了 `load_icode_read` 调用。

      ```C
      static int
      load_icode_read(int fd, void *buf, size_t len, off_t offset)
      {
          int ret;
          if ((ret = sysfile_seek(fd, offset, LSEEK_SET)) != 0)
          {
              return ret;
          }
          if ((ret = sysfile_read(fd, buf, len)) != len)
          {
              return (ret < 0) ? ret : -1;
          }
          return 0;
      }
      ```

      

* **参数处理 (argc/argv)**:

  * **修改前**: `load_icode` 不处理用户态参数栈的构建（或者说 Lab5-7 比较简化）。

  * **修改后**: 增加了完整的用户栈参数构建逻辑。

    *   计算参数所需的栈空间。
    *   将内核中的参数字符串 (`kargv`) 拷贝到用户栈 (`uargv`)。
    *   设置 `tf->gpr.a0 = argc` 和 `tf->gpr.a1 = uargv`，符合 RISC-V 的 C 语言函数调用约定（main 函数的参数）。

    ```C
        // setup argc and argv in x10 (a0) and x11 (a1)
        tf->gpr.a0 = argc;
        tf->gpr.a1 = (uintptr_t)uargv;
    ```

#### 5. `do_execve` 函数重构

`do_execve` 是 `sys_exec` 系统调用的内核实现，它负责打开文件并调用 `load_icode`。

* **修改前**: `int do_execve(const char *name, size_t len, unsigned char *binary, size_t size)`

  *   主要用于测试，直接传递二进制数据。

* **修改后**: `int do_execve(const char *name, int argc, const char **argv)`

  * 更接近标准的 execve 系统调用。

  * **流程**:

    1.  将用户空间的参数 (`argv`) 拷贝到内核空间 (`kargv`)。
    2.  调用 `sysfile_open(path, O_RDONLY)` 打开可执行文件，获取 `fd`。
    3.  清理当前进程的内存空间 (`exit_mmap` 等)。
    4.  调用新的 `load_icode(fd, argc, kargv)` 加载文件。
    5.  关闭文件，设置新的进程名。

    ```C
    int do_execve(const char *name, int argc, const char **argv)
    {
        static_assert(EXEC_MAX_ARG_LEN >= FS_MAX_FPATH_LEN);
        struct mm_struct *mm = current->mm;
        if (!(argc >= 1 && argc <= EXEC_MAX_ARG_NUM))
        {
            return -E_INVAL;
        }
    
        char local_name[PROC_NAME_LEN + 1];
        memset(local_name, 0, sizeof(local_name));
    
        char *kargv[EXEC_MAX_ARG_NUM];
        const char *path;
    
        int ret = -E_INVAL;
    
        lock_mm(mm);
        if (name == NULL)
        {
            snprintf(local_name, sizeof(local_name), "<null> %d", current->pid);
        }
        else
        {
            if (!copy_string(mm, local_name, name, sizeof(local_name)))
            {
                unlock_mm(mm);
                return ret;
            }
        }
        if ((ret = copy_kargv(mm, argc, kargv, argv)) != 0)
        {
            unlock_mm(mm);
            return ret;
        }
        path = argv[0];
        unlock_mm(mm);
        files_closeall(current->filesp);
    
        /* sysfile_open will check the first argument path, thus we have to use a user-space pointer, and argv[0] may be incorrect */
        int fd;
        if ((ret = fd = sysfile_open(path, O_RDONLY)) < 0)
        {
            goto execve_exit;
        }
        if (mm != NULL)
        {
            lsatp(boot_pgdir_pa);
            if (mm_count_dec(mm) == 0)
            {
                exit_mmap(mm);
                put_pgdir(mm);
                mm_destroy(mm);
            }
            current->mm = NULL;
        }
        ret = -E_NO_MEM;
        ;
        if ((ret = load_icode(fd, argc, kargv)) != 0)
        {
            goto execve_exit;
        }
        put_kargv(argc, kargv);
        set_proc_name(current, local_name);
        return 0;
    
    execve_exit:
        put_kargv(argc, kargv);
        do_exit(ret);
        panic("already exit: %e.\n", ret);
    }
    ```

#### 6. 内核线程入口 `user_main` 的变化

*   **修改前**: 使用宏 `KERNEL_EXECVE` 直接引用链接进内核的 `_binary_obj___user_...` 符号。
*   **修改后**: 使用 `KERNEL_EXECVE` 宏（定义变了），最终调用 `kernel_execve`，传入的是文件名字符串（如 "sh"）。这表明现在是通过文件名在文件系统中查找程序，而不是通过符号地址。

```C
#define __KERNEL_EXECVE(name, path, ...) ({              \
    const char *argv[] = {path, ##__VA_ARGS__, NULL};    \
    cprintf("kernel_execve: pid = %d, name = \"%s\".\n", \
            current->pid, name);                         \
    kernel_execve(name, argv);                           \
})

#define KERNEL_EXECVE(x, ...) __KERNEL_EXECVE(#x, #x, ##__VA_ARGS__)

#define KERNEL_EXECVE2(x, ...) KERNEL_EXECVE(x, ##__VA_ARGS__)

#define __KERNEL_EXECVE3(x, s, ...) KERNEL_EXECVE(x, #s, ##__VA_ARGS__)

#define KERNEL_EXECVE3(x, s, ...) __KERNEL_EXECVE3(x, s, ##__VA_ARGS__)

// user_main - kernel thread used to exec a user program
static int
user_main(void *arg)
{
#ifdef TEST
#ifdef TESTSCRIPT
    KERNEL_EXECVE3(TEST, TESTSCRIPT);
#else
    KERNEL_EXECVE2(TEST);
#endif
#else
    KERNEL_EXECVE(sh);
#endif
    panic("user_main execve failed.\n");
}
```

```C
static int
kernel_execve(const char *name, const char **argv)
{
    int64_t argc = 0, ret;
    while (argv[argc] != NULL)
    {
        argc++;
    }
    struct trapframe *old_tf = current->tf;
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
    current->tf = new_tf;
    ret = do_execve(name, argc, argv);
    asm volatile(
        "mv sp, %0\n"
        "j __trapret\n"
        :
        : "r"(new_tf)
        : "memory");
    return ret;
}
```

#### 7. `init_main` 初始化流程

*   **修改后**: 增加了 `vfs_set_bootfs("disk0:")`，这是初始化文件系统的关键步骤，挂载了磁盘设备。

将 ucore 的进程执行机制从**“静态内存加载”**升级为了**“动态文件系统加载”**。这使得操作系统能够从磁盘运行任意编译好的用户程序，并支持标准的命令行参数传递，是操作系统向实用化迈出的关键一步。

```C
static int
init_main(void *arg)
{
    int ret;
    if ((ret = vfs_set_bootfs("disk0:")) != 0)
    {
        panic("set boot fs failed: %e.\n", ret);
    }
    size_t nr_free_pages_store = nr_free_pages();
    size_t kernel_allocated_store = kallocated();

    int pid = kernel_thread(user_main, NULL, 0);
    if (pid <= 0)
    {
        panic("create user_main failed.\n");
    }
    extern void check_sync(void);
    // check_sync();                // check philosopher sync problem

    while (do_wait(0, NULL) == 0)
    {
        schedule();
    }

    fs_cleanup();

    cprintf("all user-mode processes have quit.\n");
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
    assert(nr_process == 2);
    assert(list_next(&proc_list) == &(initproc->list_link));
    assert(list_prev(&proc_list) == &(initproc->list_link));

    cprintf("init check memory pass.\n");
    return 0;
}
```

但是为什么需要这么多宏呢？我仔细阅读代码之后了解到如下信息：

### 1. 核心基础：`kernel_execve` 与 `__KERNEL_EXECVE`

首先，真正干活的函数是 `kernel_execve`，它接收程序名和参数数组：

```c
static int kernel_execve(const char *name, const char **argv);
```

为了方便调用，定义了一个基础宏 `__KERNEL_EXECVE`：

```c
#define __KERNEL_EXECVE(name, path, ...) ({              \
    const char *argv[] = {path, ##__VA_ARGS__, NULL};    \
    cprintf("kernel_execve: pid = %d, name = \"%s\".\n", \
            current->pid, name);                         \
    kernel_execve(name, argv);                           \
})
```

*   **作用**：它帮你构造了 `argv` 数组。
*   `argv` 的第一个元素必须是程序路径 (`path`)，后面跟着可变参数 (`__VA_ARGS__`)，最后必须以 `NULL` 结尾（这是 `exec` 系统调用的约定）。
*   它打印一条日志，然后调用 `kernel_execve`。

---

### 2. 三个宏的详细解释

这三个宏提供了不同灵活度的调用方式，主要用于测试或启动 shell。

#### 宏 1: `KERNEL_EXECVE(x, ...)`

```c
#define KERNEL_EXECVE(x, ...) __KERNEL_EXECVE(#x, #x, ##__VA_ARGS__)
```

*   **含义**：**程序名** 和 **可执行文件路径** 是一样的。
*   **展开逻辑**：
    *   `#x`：将参数 `x` 转换为字符串。例如 `KERNEL_EXECVE(sh)` -> `__KERNEL_EXECVE("sh", "sh", ...)`。
    *   这里传递了两次 `#x`，第一次作为 `name`（用于查找文件），第二次作为 `path`（即 `argv[0]`）。
*   **使用场景**：这是最常用的方式。比如 `KERNEL_EXECVE(sh)`，意思是“加载名为 `sh` 的文件，且 `argv[0]` 也是 `sh`”。

#### 宏 2: `KERNEL_EXECVE2(x, ...)`

```c
#define KERNEL_EXECVE2(x, ...) KERNEL_EXECVE(x, ##__VA_ARGS__)
```

*   **含义**：它其实就是 `KERNEL_EXECVE` 的别名。
*   **为什么存在？**：这可能是为了代码风格的对称性（对应下面的 `EXECVE3`），或者在旧版本中有特殊用途。在当前代码中，它等同于 `KERNEL_EXECVE`。
*   **使用场景**：在 `user_main` 中用于运行测试程序：`KERNEL_EXECVE2(TEST)`。如果 `TEST` 宏定义为 `exit`，则展开为加载 `exit` 程序。

#### 宏 3: `KERNEL_EXECVE3(x, s, ...)`

```c
#define __KERNEL_EXECVE3(x, s, ...) KERNEL_EXECVE(x, #s, ##__VA_ARGS__)
#define KERNEL_EXECVE3(x, s, ...) __KERNEL_EXECVE3(x, s, ##__VA_ARGS__)
```

*   **含义**：**程序名** 和 **第一个参数 (argv[1])** 是指定的。
*   **参数解析**：
    *   `x`: 程序名（也是 `argv[0]`）。
    *   `s`: 脚本名或第一个参数（作为 `argv[1]`）。
*   **展开逻辑**：
    *   `KERNEL_EXECVE3(TEST, TESTSCRIPT)` 会调用 `__KERNEL_EXECVE3`。
    *   `__KERNEL_EXECVE3` 会调用 `KERNEL_EXECVE(x, #s, ...)`。
    *   最终展开为 `__KERNEL_EXECVE("TEST", "TEST", "TESTSCRIPT", ...)`。
    *   构造出的 `argv` 数组为：`{"TEST", "TESTSCRIPT", NULL}`。
*   **使用场景**：这通常用于**运行脚本**或**带参数的测试**。例如，你可能想运行一个解释器程序 `sh`，并让它执行脚本 `script.sh`。那么调用就是 `KERNEL_EXECVE3(sh, script.sh)`。

---

### 3. 项目中的实际应用 (`user_main`)

在 `user_main` 函数中，我们看到了这三个宏的实战用法：

```c
static int user_main(void *arg) {
#ifdef TEST
#ifdef TESTSCRIPT
    // 情况 A: 定义了测试程序名(TEST) 和 测试脚本参数(TESTSCRIPT)
    // 例如: make run-test TEST=sh TESTSCRIPT=script.sh
    // 效果: 执行 sh script.sh
    KERNEL_EXECVE3(TEST, TESTSCRIPT);
#else
    // 情况 B: 只定义了测试程序名(TEST)
    // 例如: make run-test TEST=exit
    // 效果: 执行 exit
    KERNEL_EXECVE2(TEST);
#endif
#else
    // 情况 C: 默认情况，启动 shell
    // 效果: 执行 sh
    KERNEL_EXECVE(sh);
#endif
    panic("user_main execve failed.\n");
}
```

### 总结

*   **`KERNEL_EXECVE`**: 最标准用法，运行一个程序，无额外参数。
*   **`KERNEL_EXECVE2`**: 目前等同于标准用法，主要用于条件编译分支中保持语义一致。
*   **`KERNEL_EXECVE3`**: 运行一个程序，并给它传递一个特定的字符串参数（通常是脚本文件名）。

这一套宏的设计初衷是为了让内核启动第一个用户进程的代码（`user_main`）能够灵活地通过编译选项（`TEST`, `TESTSCRIPT`）来改变行为，方便进行自动化测试。

## Challenge 1——完成基于“UNIX的PIPE机制”的设计方案

### 问题描述

如果要在ucore里加入UNIX的管道（Pipe）机制，至少需要定义哪些数据结构和接口？（接口给出语义即可，不必具体实现。数据结构的设计应当给出一个（或多个）具体的C语言struct定义。在网络上查找相关的Linux资料和实现，请在实验报告中给出设计实现”UNIX的PIPE机制“的概要设方案，你的设计应当体现出对可能出现的同步互斥问题的处理。）

### 基于 UNIX 的 Pipe 机制设计方案

#### 1. 设计思路概述

管道在逻辑上是一个先进先出（FIFO）的队列。在 UNIX 系统中，管道被抽象为一种特殊的文件。用户进程通过系统调用 `pipe()` 创建管道，获得两个文件描述符：一个用于读（reader），一个用于写（writer）。

* **内存模型**：管道本质上是内核中的一段内存缓冲区（Buffer）。

* **文件抽象**：管道通过虚拟文件系统（VFS）接口暴露，这意味着它需要实现 `read`、`write`、`close` 等标准文件操作。

* **并发控制**：管道涉及典型的“生产者-消费者”模型，必须处理好读写指针的同步、缓冲区满/空的等待与唤醒。

  上述管道的基本语义参考了 UNIX / Linux 的标准定义。根据 Linux man-pages 的说明，
  pipe() 系统调用创建一个单向数据通道，返回读端和写端两个文件描述符；
  当所有写端关闭后，读操作在缓冲区为空时返回 EOF；
  当所有读端关闭后，写操作会触发 SIGPIPE 信号并返回 EPIPE 错误。
  此外，POSIX 规定当单次写入的数据量不超过 PIPE_BUF 时，应保证写操作的原子性。

  参考资料：

  - Linux pipe 手册：https://www.man7.org/linux/man-pages/man2/pipe.2.html
  - GNU libc 关于 PIPE_BUF 原子性的说明：
    https://www.gnu.org/software/libc/manual/html_node/Pipe-Atomicity.html

#### 2. 核心数据结构设计

参考资料：Linux 内核源码（fs/pipe.c）：
https://github.com/torvalds/linux/blob/master/fs/pipe.c

我们需要定义一个 `pipe_inode` 结构体来管理管道的状态。这个结构体通常会挂载在 ucore 现有的 `inode` 结构之上（或者作为 `inode` 的私有数据）。

```c
#include <defs.h>
#include <sem.h>
#include <wait.h>
#include <list.h>

#define PIPE_SIZE 4096  // 定义管道缓冲区大小，通常为一页或几页

/* 管道的核心控制结构 */
struct pipe_state {
    char buffer[PIPE_SIZE];     // 环形数据缓冲区
    uint32_t head;              // 写入位置指针 (Producer index)
    uint32_t tail;              // 读取位置指针 (Consumer index)
    
    bool is_closed;             // 管道是否已被关闭（某端完全关闭）
    uint32_t readers;           // 当前打开的读者计数
    uint32_t writers;           // 当前打开的写者计数

    /* 同步互斥机制 */
    semaphore_t mutex;          // 互斥锁：保护 buffer、head、tail 的原子操作
    
    /* 等待队列 (ucore 使用 wait_queue_t) */
    wait_queue_t wait_read;     // 读等待队列：缓冲区空时，读者在此等待
    wait_queue_t wait_write;    // 写等待队列：缓冲区满时，写者在此等待
};

/* 
 * ucore 的 inode 扩展
 * 在 ucore 中，管道可以被视为一种特殊的设备或内存文件系统
 */
struct pipe_inode_info {
    struct pipe_state *state;   // 指向共享的管道状态
};
```

**设计说明：**

*   **环形缓冲区**：`buffer` 配合 `head` 和 `tail` 使用，实现循环队列。
    *   数据量 = `head - tail`
    *   空：`head == tail`
    *   满：`head - tail == PIPE_SIZE`
*   **引用计数**：`readers` 和 `writers` 用于判断管道的生命周期。当 `readers == 0 && writers == 0` 时，释放 `pipe_state`。
*   **同步原语**：
    *   `mutex`：保证多进程同时操作管道元数据时的安全性。
    *   `wait_read` / `wait_write`：实现阻塞 I/O。当读空时，读者挂入 `wait_read`；当写满时，写者挂入 `wait_write`。

#### 3. 接口设计（语义层）

我们需要实现两个层面的接口：提供给用户的系统调用，以及内核内部 VFS 层的操作函数。

##### 3.1 用户层接口 (System Call)

```c
/* 
 * 创建管道
 * fd[0]: 返回读端的文件描述符
 * fd[1]: 返回写端的文件描述符
 * 返回值: 0 成功, -1 失败
 */
int pipe(int fd[2]);
```

##### 3.2 内核 VFS 接口 (File Operations)

这些函数需要注册到 `inode->in_ops` 或 `file->f_ops` 中。

1. **`pipe_read(struct file *file, void *buf, size_t len)`**

   *   **语义**：从管道读取 `len` 字节到 `buf`。
   *   **逻辑**：
       1.  获取互斥锁 `mutex`。
       2.  **循环检查**：如果缓冲区为空 (`head == tail`)：
           *   如果 `writers == 0` (写端已全关闭)，返回 0 (EOF)。
           *   如果非阻塞模式，返回 -EAGAIN。
           *   否则，释放锁，将当前进程加入 `wait_read` 队列并休眠（等待被写者唤醒）。被唤醒后重新获取锁并检查。
       3.  **读取数据**：从 `buffer[tail % PIPE_SIZE]` 复制数据到用户 `buf`，更新 `tail`。
       4.  **唤醒**：如果读取前缓冲区是满的（或者读走了一些数据有了空间），唤醒 `wait_write` 队列中的写者。
       5.  释放锁，返回实际读取字节数。

2. **`pipe_write(struct file *file, const void *buf, size_t len)`**

   * **语义**：将 `buf` 中的 `len` 字节写入管道。

   * **逻辑**：

     1.  获取互斥锁 `mutex`。
     2.  **检查读者**：如果 `readers == 0`，说明读端已关闭，写入无意义。发送 `SIGPIPE` 信号给进程，并返回 -EPIPE。

     > 该行为与 Linux 的管道语义一致：当管道不存在任何读端时，
     > 写操作会触发 SIGPIPE 信号并返回 EPIPE 错误。
     >
     > 参考资料：
     >
     > - https://www.man7.org/linux/man-pages/man7/pipe.7.html

     1.  **循环检查**：如果缓冲区已满 (`head - tail == PIPE_SIZE`)：
         *   释放锁，将当前进程加入 `wait_write` 队列并休眠。
     2.  **写入数据**：将数据复制到 `buffer[head % PIPE_SIZE]`，更新 `head`。
     3.  **唤醒**：唤醒 `wait_read` 队列中的读者（因为现在有数据可读了）。
     4.  释放锁，返回写入字节数。

3. **`pipe_close(struct file *file)`**

   *   **语义**：关闭管道的一端。
   *   **逻辑**：
       1.  获取锁。
       2.  根据 `file` 是读端还是写端，递减 `readers` 或 `writers`。
       3.  如果关闭的是读端，唤醒所有等待的写者（让它们知道由于无读者，写入将失败）。
       4.  如果关闭的是写端，唤醒所有等待的读者（让它们读完剩余数据后收到 EOF）。
       5.  如果 `readers == 0 && writers == 0`，释放 `pipe_state` 内存缓冲区。
       6.  释放锁。

#### 4. 同步互斥问题的详细处理

在管道实现中，最棘手的是并发竞争（Race Conditions）。以下是关键场景的处理方案：

**场景 A：多写者写入 (Multiple Writers)**

*   **问题**：两个进程同时向同一个管道写入，数据可能交错。
*   **处理**：POSIX 标准规定，当写入数据量小于 `PIPE_BUF` (通常 4KB) 时，写入必须是原子的。
*   **实现**：在 `pipe_write` 中，获取 `mutex` 后，直到数据完全写入缓冲区前不释放锁。这保证了小块数据写入的连续性。

> POSIX 标准规定，当写入数据量小于 PIPE_BUF 时，写入必须是原子的，
> 即不会与其他进程的写操作交错。
> 该规则在 Linux 的用户态文档中也有明确说明。
>
> 参考资料：
>
> - https://www.gnu.org/software/libc/manual/html_node/Pipe-Atomicity.html

**场景 B：读写指针的竞态 (Read/Write Pointer Race)**

*   **问题**：读进程修改 `tail`，写进程修改 `head`。如果仅仅用 `head` 和 `tail` 判断空满，在多核下可能出现缓存一致性问题或逻辑错误。
*   **处理**：所有对 `head`、`tail`、`buffer` 的访问都必须在 `mutex` 保护的临界区内进行。

**场景 C：休眠与唤醒的死锁 (Sleep/Wakeup Deadlock)**

*   **问题**：读者准备休眠时，写者刚好写入数据并发送唤醒信号。如果读者还没进入休眠状态就错过了唤醒信号，可能会永远睡下去（Lost Wakeup）。
*   **处理**：ucore 的 `wait` 机制通常包含关中断或自旋锁保护。
    *   标准流程：
        1.  持有 `mutex`。
        2.  检查条件（如缓冲区空）。
        3.  将进程状态设为 `SLEEPING` 并加入等待队列。
        4.  释放 `mutex` 并调用 `schedule()`。
        5.  被唤醒后，重新获取 `mutex` 并再次检查条件。

> 上述同步与唤醒机制与 Linux 内核中管道的实现思想一致。
> 在 Linux 的 fs/pipe.c 中，读写双方通过等待队列进行阻塞与唤醒，
> 并在锁保护下反复检查缓冲区条件，以避免丢失唤醒（lost wakeup）问题。
> ucore 中采用的 mutex + wait_queue 机制在语义上与其保持一致。
>
> 参考资料：
>
> - https://github.com/torvalds/linux/blob/master/fs/pipe.c

#### 5. 总结

要在 ucore 中实现 UNIX Pipe，需要：

1.  **数据结构**：定义包含环形缓冲区、读写指针、引用计数、互斥锁和等待队列的 `pipe_state`。
2.  **VFS 适配**：实现 `pipe` 虚拟文件系统操作集 (`read`/`write`/`close`)。
3.  **同步机制**：利用互斥锁保护缓冲区状态，利用条件变量（等待队列）实现阻塞 I/O 和进程间通知。

这个设计既满足了 FIFO 的数据传输需求，也通过完善的同步机制保证了多进程环境下的健壮性。

### 参考资料

[1] Linux pipe 系统调用手册  
https://www.man7.org/linux/man-pages/man2/pipe.2.html

[2] Linux pipe 行为说明（EOF / SIGPIPE）  
https://www.man7.org/linux/man-pages/man7/pipe.7.html

[3] GNU libc：Pipe 原子性（PIPE_BUF）  
https://www.gnu.org/software/libc/manual/html_node/Pipe-Atomicity.html

[4] Linux 内核源码：fs/pipe.c  
https://github.com/torvalds/linux/blob/master/fs/pipe.c

## Challenge 2——完成基于“UNIX的软连接和硬连接机制”的设计方案

### 问题描述

如果要在ucore里加入UNIX的软连接和硬连接机制，至少需要定义哪些数据结构和接口？（接口给出语义即可，不必具体实现。数据结构的设计应当给出一个（或多个）具体的C语言struct定义。在网络上查找相关的Linux资料和实现，请在实验报告中给出设计实现”UNIX的软连接和硬连接机制“的概要设方案，你的设计应当体现出对可能出现的同步互斥问题的处理。）

### 基于 UNIX 的软连接与硬连接设计方案

#### 1. 概念辨析与设计思路

*   **硬连接 (Hard Link)**：
    *   **本质**：多个目录项（Directory Entry）指向同一个磁盘索引节点（Disk Inode）。
    *   **特性**：所有硬连接地位平等。删除其中一个，只是减少引用计数。只有当引用计数降为 0 时，才真正删除文件数据。
    *   **限制**：通常不能跨文件系统，且为了防止循环，通常不允许对目录创建硬连接。
    *   **设计核心**：在 Inode 中维护 `nlinks` 引用计数。

*   **软连接 (Symbolic Link / Soft Link)**：
    *   **本质**：一个特殊类型的文件，其**数据内容**是指向另一个文件的**路径字符串**。
    *   **特性**：可以跨文件系统，可以指向不存在的文件。
    *   **设计核心**：引入新的文件类型 `SFS_TYPE_LINK`，并在读取时进行路径重定向。

> 上述硬连接/软连接的语义依据参考 Linux man-pages：
>
> - link() 创建硬链接，本质是给同一 inode 增加一个新名字；硬链接通常不能跨文件系统（跨设备会返回 EXDEV）。
> - symlink() 创建软连接，软连接本身是一个独立对象，其内容是目标路径字符串。
> - readlink() 读取软连接保存的目标路径（注意 readlink 不会自动添加 '\0'，实现时要注意缓冲区和长度）。
> - unlink() 删除的是“目录项名字”，对硬连接表现为减少链接计数；对软连接则删除软连接文件本身，不影响目标。
>
> 参考资料：
>
> - link(2): https://www.man7.org/linux/man-pages/man2/link.2.html
> - symlink(2): https://www.man7.org/linux/man-pages/man2/symlink.2.html
> - readlink(2): https://www.man7.org/linux/man-pages/man2/readlink.2.html
> - unlink(2): https://www.man7.org/linux/man-pages/man2/unlink.2.html

#### 2. 核心数据结构设计

我们需要修改 SFS 的磁盘结构定义，并扩展 VFS 的接口。

##### 2.1 磁盘索引节点扩展 (`sfs_disk_inode`)

在 `kern/fs/sfs/sfs.h` 中，现有的 `sfs_disk_inode` 已经包含 `nlinks`，这是硬连接的基础。我们需要定义新的文件类型。

```c
/* 文件类型扩展 */
#define SFS_TYPE_INVAL  0 
#define SFS_TYPE_FILE   1
#define SFS_TYPE_DIR    2
#define SFS_TYPE_LINK   3   // 新增：软连接类型

/* 磁盘上的 Inode 结构 (已存在，确认定义) */
struct sfs_disk_inode {
    uint32_t size;                  // 文件大小
    uint16_t type;                  // 文件类型 (FILE, DIR, LINK)
    uint16_t nlinks;                // 硬连接计数 (Hard Link Count)
    uint32_t blocks;                // 块数
    uint32_t direct[SFS_NDIRECT];   // 直接块索引
    uint32_t indirect;              // 间接块索引
};
```

**对于软连接的数据存储**：

*   如果路径名很短（例如小于 `SFS_NDIRECT * 4` 字节），可以直接存储在 `direct` 数组的空间里（这叫 **Inline Data** 优化，ext4 就这么干）。
*   在 ucore 的 SFS 简化设计中，为了统一，可以像普通文件一样，将路径字符串存储在数据块中。`size` 字段记录路径字符串的长度。

> nlinks 的语义对应“同一 inode 的名字数量”。unlink() 删除一个名字会使链接计数减少，
> 当链接计数降为 0 且无进程持有打开引用时，文件数据才可被回收（具体回收时机由实现决定）。
> 该语义与 Linux unlink(2) / link(2) 的描述一致。
>
> 参考资料：
>
> - unlink(2): https://www.man7.org/linux/man-pages/man2/unlink.2.html
> - link(2): https://www.man7.org/linux/man-pages/man2/link.2.html

##### 2.2 内存索引节点扩展 (`sfs_inode`)

内存中的 `sfs_inode` 不需要太大变化，主要依靠 `din->type` 来区分行为。

```c
struct sfs_inode {
    struct sfs_disk_inode *din; // 指向磁盘 inode 副本
    uint32_t ino;               // Inode 编号
    bool dirty;                 // 脏位
    int reclaim_count;          // 内存引用计数
    semaphore_t sem;            // 互斥锁 (用于同步互斥)
    list_entry_t inode_link;    // Inode 链表
    list_entry_t hash_link;     // Hash 链表
};
```

> 这里的 sem（或 inode 锁）用于保护 nlinks、目录项增删、以及软连接内容写入等元数据更新的原子性，
> 避免 link/unlink 并发导致的悬空目录项或错误回收。Linux 内核在路径解析与链接/删除相关逻辑中
> 同样会通过锁与引用计数配合保证一致性（实现集中在 fs/namei.c）。
>
> 参考资料：
>
> - Linux 内核源码 fs/namei.c: https://github.com/torvalds/linux/blob/master/fs/namei.c

并在 VFS 层增加对 Link 的感知。

```C
struct inode_ops {
    // 现有接口...
    int (*vop_link)(struct inode *dir, const char *name, struct inode *node);
    int (*vop_symlink)(struct inode *dir, const char *name, const char *path);
    int (*vop_readlink)(struct inode *node, struct iobuf *iob);
    // ...
};
```

#### 3. 接口设计（语义层）

我们需要实现用户层系统调用和内核层 VFS 操作。

##### 3.1 用户层接口 (System Calls)

1. **`link(const char *oldpath, const char *newpath)`**

   *   **语义**：创建一个指向 `oldpath` 的硬连接 `newpath`。
   *   **逻辑**：
       1.  解析 `oldpath` 找到对应的 Inode。
       2.  在 `newpath` 所在的目录中创建一个新目录项（Entry）。
       3.  将新目录项指向 `oldpath` 的 Inode 编号。
       4.  增加该 Inode 的 `nlinks` 计数。
       5.  回写 Inode 到磁盘。

   ```C
   int sfs_link(struct inode *dir, const char *name, struct inode *node) {
       struct sfs_fs *sfs = fsop_info(vop_fs(dir), sfs);
       struct sfs_inode *sin_dir = vop_info(dir, sfs_inode);
       struct sfs_inode *sin_node = vop_info(node, sfs_inode);
   
       // 1. 同步互斥：锁住目录和目标文件
       // 注意：为防止死锁，可以规定按 inode 编号大小顺序加锁，或者只锁目录
       lock_sin(sin_dir); 
       lock_sin(sin_node);
   
       // 2. 检查目标文件是否允许硬连接 (目录通常不允许)
       if (sin_node->din->type == SFS_TYPE_DIR) {
           unlock_sin(sin_node);
           unlock_sin(sin_dir);
           return -EISDIR;
       }
   
       // 3. 检查目标文件是否已被删除 (nlinks == 0?)
       // 这是一个边缘情况：文件已被 unlink 但因为有 fd 打开所以还在内存中
       // 此时不允许再创建硬连接
       if (sin_node->din->nlinks == 0) {
            unlock_sin(sin_node);
            unlock_sin(sin_dir);
            return -ENOENT;
       }
   
       // 4. 在目录中创建新条目 (Directory Entry)
       int ret = sfs_dirent_create_nolock(sfs, sin_dir, name, sin_node->ino);
       if (ret != 0) {
           // 创建失败
       } else {
           // 5. 成功：增加硬连接计数并标记 Dirty
           sin_node->din->nlinks++;
           sin_node->dirty = 1;
       }
   
       unlock_sin(sin_node);
       unlock_sin(sin_dir);
       return ret;
   }
   ```

   

2. **`symlink(const char *target, const char *linkpath)`**

   *   **语义**：创建一个软连接 `linkpath`，其内容为 `target` 字符串。
   *   **逻辑**：
       1.  创建一个新文件（Inode），类型设为 `SFS_TYPE_LINK`。
       2.  将 `target` 字符串写入该文件的数据块。
       3.  在 `linkpath` 所在目录添加指向新 Inode 的目录项。

   ```C
   int sfs_symlink(struct inode *dir, const char *name, const char *path) {
       // 1. 分配一个新的 Inode
       struct inode *node;
       int ret = sfs_create(dir, name, &node); // 内部会处理目录项创建
       if (ret != 0) return ret;
       
       struct sfs_inode *sin = vop_info(node, sfs_inode);
       
       // 2. 设置类型为 LINK
       sin->din->type = SFS_TYPE_LINK;
       
       // 3. 将 target path 写入数据块
       // ucore 的 sfs_write 应该能处理 buffer 到 disk block 的写入
       struct iobuf iob;
       iobuf_init(&iob, (void*)path, strlen(path), 0);
       ret = sfs_write(node, &iob);
       
       vop_ref_dec(node); // 释放 inode 引用
       return ret;
   }
   ```

   

3. **`unlink(const char *pathname)`**

   *   **语义**：删除一个文件名。如果是硬连接，减少计数；如果是软连接，直接删除软连接文件本身。
   *   **逻辑**：
       1.  找到 `pathname` 对应的 Inode。
       2.  从目录中删除对应的目录项。
       3.  `Inode->nlinks--`。
       4.  如果 `nlinks == 0` 且没有进程打开该文件，释放 Inode 及其占用的数据块。

   ```C
   /*
    * sfs_unlink - 删除目录 dir 下名为 name 的文件/连接
    * 对应 VFS 接口: vop_unlink
    */
   int sfs_unlink(struct inode *dir, const char *name) {
       struct sfs_fs *sfs = fsop_info(vop_fs(dir), sfs);
       struct sfs_inode *sin_dir = vop_info(dir, sfs_inode);
       struct sfs_inode *sin_node;
       struct inode *node;
       int ret;
   
       // 1. 锁住目录 (保护目录项的查找和删除)
       lock_sin(sin_dir);
   
       // 2. 查找要删除的目标 Inode
       // sfs_lookup_once 会在目录中查找 name，如果找到则加载对应的 inode
       if ((ret = sfs_lookup_once(sfs, sin_dir, name, &node, NULL)) != 0) {
           unlock_sin(sin_dir);
           return ret; // 文件不存在
       }
       sin_node = vop_info(node, sfs_inode);
   
       // 3. 锁住目标文件 (我们要修改它的 nlinks)
       lock_sin(sin_node);
   
       // 4. 检查是否允许 unlink
       if (sin_node->din->type == SFS_TYPE_DIR) {
           // 通常不允许 unlink 一个目录 (应该用 rmdir)
           ret = -EISDIR;
           goto out;
       }
   
       // 5. 从父目录中删除目录项 (Directory Entry)
       // 这个操作会释放目录块中的 entry 空间
       if ((ret = sfs_dirent_delete_nolock(sfs, sin_dir, name)) != 0) {
           goto out;
       }
   
       // 6. 减少硬连接计数
       sin_node->din->nlinks--;
       sin_node->dirty = 1;
   
       // 7. 判断是否需要真正的空间回收
       // 只有当硬连接数为0，且内存中没有其他进程引用该文件时，才回收
       // 注意：在 ucore 中，vop_ref_dec(node) 会处理内存引用计数。
       // 如果 nlinks == 0，当最后一个内存引用释放时，vfs 会调用 sfs_reclaim 来做真正的块释放。
       // 所以这里我们主要负责 nlinks--，不需要直接调用 sfs_block_free 等底层函数，
       // 除非我们想在这里立即截断文件。
       
       // 如果 nlinks == 0，通常会调用 truncate 把文件大小截为0，释放所有数据块
       if (sin_node->din->nlinks == 0) {
           // 释放所有数据块
           if ((ret = sfs_truncate_nolock(sfs, sin_node, 0)) != 0) {
               // 截断失败虽然很罕见，但也要记录
           }
       }
   
   out:
       unlock_sin(sin_node);
       // 释放 lookup 查找到的 inode 引用
       vop_ref_dec(node); 
       unlock_sin(sin_dir);
       return ret;
   }
   ```

   >  Hard link cannot span filesystems; if attempted, return EXDEV.
   >  Semantic reference: link(2) NOTES section ("cannot span filesystems").
   >  Ref: https://www.man7.org/linux/man-pages/man2/link.2.html

   >  软连接的实现遵循 Linux 语义：symlink 创建的是一个独立对象，其“数据内容”是目标路径字符串；
   >  读出该字符串可通过 readlink 完成。

   >  参考资料：
   >
   >  - symlink(2): https://www.man7.org/linux/man-pages/man2/symlink.2.html
   >  - readlink(2): https://www.man7.org/linux/man-pages/man2/readlink.2.html
   >
   >  unlink 的语义是“删除目录项中的一个名字（link）”，并不等价于立刻删除 inode 数据；
   >  当最后一个硬链接被删除后，文件才具备被回收条件（回收时机取决于是否还有打开引用）。
   >  对软连接而言，unlink 删除的是软连接对象本身，不会删除其指向的目标。
   >
   >  参考资料：
   >
   >  - unlink(2): https://www.man7.org/linux/man-pages/man2/unlink.2.html
   >  - symlink(2): https://www.man7.org/linux/man-pages/man2/symlink.2.html

##### 3.2 内核 VFS 接口扩展

在 `vfs_ops` 或 `inode_ops` 中需要增加对 Link 的支持。

1. **`vop_link(struct inode *dir, const char *name, struct inode *node)`**

   *   **功能**：在目录 `dir` 下创建一个名为 `name` 的硬连接，指向 `node`。
   *   **同步处理**：需要锁住目录 `dir` 和目标 `node`。防止 `node` 在连接过程中被删除。

   ```C
   /*
    * vop_link - 在目录 dir 中创建一个名为 name 的硬连接指向 node
    *
    * @dir:  目标目录的 inode
    * @name: 新硬连接的文件名
    * @node: 要链接到的目标文件的 inode
    */
   int vop_link(struct inode *dir, const char *name, struct inode *node) {
       // 1. 检查目录是否有效且实现了 vop_link 操作
       if (dir == NULL || dir->in_ops == NULL || dir->in_ops->vop_link == NULL) {
           return -E_NOSYS; // 不支持该操作
       }
       
       // 2. 检查目标节点是否有效
       if (node == NULL) {
           return -EINVAL;
       }
   
       // 3. 实际上，这里可以做一些通用的检查，比如是否跨文件系统
       // 硬连接通常不允许跨文件系统 (dir 和 node 必须属于同一个 fs)
       if (vop_fs(dir) != vop_fs(node)) {
           return -EXDEV; // Cross-device link
       }
   
       // 4. 调用具体文件系统的实现 (如 sfs_link)
       // 注意：具体的锁机制 (lock_sin) 是在下层 (sfs_link) 实现的，这里不需要加锁
       return dir->in_ops->vop_link(dir, name, node);
   }
   ```

   

2. **`vop_symlink(struct inode *dir, const char *name, const char *path)`**

   *   **功能**：在目录 `dir` 下创建名为 `name` 的软连接，内容为 `path`。

   ```C
   /*
    * vop_symlink - 在目录 dir 中创建一个名为 name 的软连接，内容为 path
    *
    * @dir:  目标目录的 inode
    * @name: 软连接的文件名
    * @path: 软连接指向的目标路径字符串
    */
   int vop_symlink(struct inode *dir, const char *name, const char *path) {
       // 1. 基本检查
       if (dir == NULL || dir->in_ops == NULL || dir->in_ops->vop_symlink == NULL) {
           return -E_NOSYS;
       }
       
       // 2. 调用具体文件系统的实现 (如 sfs_symlink)
       return dir->in_ops->vop_symlink(dir, name, path);
   }
   ```

   

3. **`vop_readlink(struct inode *node, struct iobuf *iob)`**

   *   **功能**：读取软连接的内容（即目标路径）。
   *   **注意**：普通 `read` 操作通常也能读取软连接内容，但专门的 `readlink` 更语义化。

   ```C
   /*
    * vop_readlink - 读取软连接 node 的内容
    *
    * @node: 软连接文件的 inode
    * @iob:  IO 缓冲区描述符 (用于存储读出的路径)
    */
   int vop_readlink(struct inode *node, struct iobuf *iob) {
       // 1. 基本检查
       // 注意：有些文件系统可能不支持软连接
       if (node == NULL || node->in_ops == NULL || node->in_ops->vop_readlink == NULL) {
           return -E_NOSYS;
       }
       
       // 2. 检查 inode 类型是否真的是软连接 (可选，取决于下层是否重复检查)
       // 但 VFS 层通常只负责分发
       
       // 3. 调用具体实现 (如 sfs_readlink)
       return node->in_ops->vop_readlink(node, iob);
   }
   ```

   

4. **`vop_lookup` (路径解析的修改)**

   * **功能**：这是最关键的修改点。当 VFS 解析路径时（如 `open("/tmp/foo")`），如果发现中间某个分量是软连接：

     1.  检测到 `inode->type == SFS_TYPE_LINK`。
     2.  读取该 Inode 的内容（目标路径）。
     3.  **递归解析**：用新的目标路径替换当前路径的剩余部分，重新开始解析。
     4.  **循环检测**：必须限制递归深度（如 Linux 的 `MAX_SYMLINKS` 通常为 40），防止 `A -> B -> A` 这种死循环导致内核栈溢出。

     ```C
     /* 
      * 递归解析路径
      * path: 待解析路径
      * node_store: 返回结果 inode
      * link_count: 递归深度计数 (防止死循环)
      */
     int vfs_lookup_recurse(const char *path, struct inode **node_store, int link_count) {
         if (link_count > MAX_SYMLINKS) return -ELOOP; // 防止无限递归
     
         // ... 标准路径解析循环 ...
         while (*path != '\0') {
             // 获取下一个分量 next_part
             // 查找 next_part 对应的 inode
             struct inode *next_inode;
             vop_lookup(cur_inode, next_part, &next_inode);
             
             // 【关键逻辑】检查是否是软连接
             struct sfs_disk_inode *din = vop_info(next_inode, sfs_inode)->din;
             if (din->type == SFS_TYPE_LINK) {
                 // 1. 读取软连接内容 (目标路径)
                 char target_path[MAX_PATH_LEN];
                 struct iobuf iob;
                 iobuf_init(&iob, target_path, MAX_PATH_LEN, 0);
                 vop_readlink(next_inode, &iob);
                 
                 // 2. 释放当前找到的软连接 inode (不需要它了，我们需要它指向的目标)
                 vop_ref_dec(next_inode);
                 
                 // 3. 处理绝对路径 vs 相对路径
                 if (target_path[0] == '/') {
                     cur_inode = root_inode; // 从根开始
                 }
                 // 如果是相对路径，cur_inode 保持不变（即软连接所在的目录）
                 
                 // 4. 递归调用解析目标路径
                 // 注意：这里需要将 target_path 和 path 的剩余部分拼接起来
                 // 比如 lookup("a/link/b"), link -> "target", 则新路径是 "target/b"
                 char new_full_path[MAX_PATH_LEN];
                 snprintf(new_full_path, ...); // 拼接逻辑
                 
                 return vfs_lookup_recurse(new_full_path, node_store, link_count + 1);
             }
             
             cur_inode = next_inode;
         }
         // ...
     }
     ```

> 路径解析与符号链接跟随的规则可参考 Linux 的 path_resolution(7) 与内核实现（fs/namei.c）。
> 实现上需要对符号链接跟随次数设上限，超过上限返回 ELOOP，以防止循环链接导致无限解析。
>
> 参考资料：
>
> - path_resolution(7): https://www.man7.org/linux/man-pages/man7/path_resolution.7.html
> - Linux 内核源码 fs/namei.c: https://github.com/torvalds/linux/blob/master/fs/namei.c

#### 4. 同步互斥问题的详细处理

引入链接机制后，文件系统的并发一致性面临更大挑战。

**场景 A：硬连接创建与文件删除的竞态**

*   **问题**：进程 A 试图给文件 X 创建硬连接 (`link`)，同时进程 B 试图删除文件 X (`unlink`)。
*   **风险**：如果 B 先执行完，X 的 `nlinks` 变为 0 并被释放；然后 A 继续执行，增加 `nlinks` 为 1，导致一个目录项指向了已释放的 Inode（悬空指针/UAF）。
*   **处理**：
    1.  **Inode 锁**：`vop_link` 操作必须先获取目标 Inode 的锁 (`sin->sem`)。
    2.  **有效性检查**：获取锁后，再次检查 Inode 的 `nlinks` 是否已经为 0（或者检查是否被标记为删除）。如果已为 0，则禁止创建硬连接，返回错误。

**场景 B：目录操作的死锁**

*   **问题**：`rename` 或 `link` 操作可能涉及两个不同的目录（源目录和目的目录）。
*   **风险**：如果进程 A 执行 `rename(dir1/a, dir2/b)`，进程 B 执行 `rename(dir2/c, dir1/d)`，且分别先锁住了 `dir1` 和 `dir2`，就会死锁。
*   **处理**：**全局统一加锁顺序**。
    *   通常按照 Inode 编号的大小顺序加锁（例如先锁 ID 小的，再锁 ID 大的）。
    *   或者使用 `lock_directory_pair(dir1, dir2)` 这样的封装函数来处理加锁顺序。

**场景 C：软连接的无限递归**

*   **问题**：解析软连接时，软连接指向自己，或者两个软连接互相指向。
*   **处理**：在 `vfs_lookup` 函数中维护一个计数器 `link_count`。
    *   每次遇到软连接，`link_count++`。
    *   如果 `link_count > MAX_SYMLINKS` (如 5 或 8)，停止解析并返回 `ELOOP` 错误。
    *   这不是并发问题，但是是软连接机制特有的逻辑安全问题。

> 上述并发处理要点与 Linux VFS 的实现思路一致：在“目录项修改 + inode 引用计数变化”期间，
> 需要通过锁与引用计数配合避免竞态条件（例如 link/unlink 并发导致悬空目录项或错误回收）。
> Linux 将路径解析、链接创建/删除等关键逻辑集中在 fs/namei.c 中实现，可作为实现对照。
>
> 参考资料：
>
> - Linux 内核源码 fs/namei.c: https://github.com/torvalds/linux/blob/master/fs/namei.c

#### 5. 总结

在 ucore 中实现软硬连接，核心工作量在于：

1.  **SFS 修改**：识别 `SFS_TYPE_LINK`，并在删除文件时正确处理 `nlinks`。
2.  **VFS 路径解析**：重写 `vfs_lookup` 以支持遇到软连接时的自动跳转（Symlink Resolution），并处理好递归深度限制。
3.  **并发保护**：在 `link` 和 `unlink` 操作中严格加锁，防止 Inode 在引用计数变更期间被错误释放。

这个方案无需对 ucore 的现有架构进行伤筋动骨的修改，是对现有 VFS 和 SFS 的自然扩展。

> 参考资料（Linux / UNIX 语义与实现对照）
>
> [1] link(2) — Linux manual page
> https://www.man7.org/linux/man-pages/man2/link.2.html
>
> [2] symlink(2) — Linux manual page
> https://www.man7.org/linux/man-pages/man2/symlink.2.html
>
> [3] readlink(2) — Linux manual page
> https://www.man7.org/linux/man-pages/man2/readlink.2.html
>
> [4] unlink(2) — Linux manual page
> https://www.man7.org/linux/man-pages/man2/unlink.2.html
>
> [5] path_resolution(7) — pathname 解析规则（含符号链接跟随相关说明）
> https://www.man7.org/linux/man-pages/man7/path_resolution.7.html
>
> [6] Linux kernel source: fs/namei.c（路径解析/链接相关核心实现）
> https://github.com/torvalds/linux/blob/master/fs/namei.c

## 与OS的关系

| 实验中的知识点            | 对应的 OS 原理知识点       | 含义理解                                                     | 二者关系、联系与差异                                         |
| ------------------------- | -------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 文件系统整体框架（FS）    | 文件系统的层次化设计       | 文件系统负责对持久化存储进行管理，为用户提供统一的文件访问接口 | 实验中以 uCore 的文件系统为例，体现了“分层设计”的思想，但实现较简化，没有涉及日志、缓存优化等复杂机制 |
| VFS（虚拟文件系统）       | 文件系统抽象层             | VFS 通过统一接口屏蔽不同具体文件系统的差异                   | 实验中通过 VFS 连接 SFS 与设备文件，直观体现“抽象”的价值；原理中更强调可扩展性和多文件系统共存 |
| SFS（Simple File System） | 具体文件系统实现           | SFS 是一种简单的磁盘文件系统，用于管理磁盘块和 inode         | 实验中的 SFS 是教学用文件系统，重点在结构清晰而非性能，与真实 OS 中的 ext4、xfs 等差异较大 |
| “设备即文件”              | Unix 一切皆文件思想        | 将设备抽象为文件，统一使用文件接口访问                       | 实验中通过设备文件演示这一思想，但未涉及复杂设备驱动和异步 I/O |
| inode 结构                | 文件控制块（FCB / inode）  | inode 用于描述文件的元信息和数据位置                         | 实验中 inode 结构较简单，只体现核心思想；原理中 inode 可能包含权限、时间戳、链接计数等更多信息 |
| 目录项（dentry）          | 目录与路径解析             | 目录项用于将文件名映射到 inode                               | 实验中路径解析流程较清晰，帮助理解“路径查找”的本质；真实系统中有缓存等优化 |
| open 系统调用             | 系统调用机制               | open 是用户态访问文件的入口                                  | 实验中清晰展示了从用户态 → 内核态 → VFS → 文件系统的完整调用链 |
| read 系统调用             | 用户态 / 内核态数据拷贝    | read 将文件内容从内核拷贝到用户空间                          | 实验中强调流程正确性，未涉及零拷贝、页缓存等高级优化         |
| 文件描述符（fd）          | 进程资源管理               | fd 是进程访问文件的索引                                      | 实验中 fd 以数组形式实现，帮助理解“每进程独立”的资源视角     |
| execve + shell            | 程序加载与进程地址空间重建 | execve 用新程序替换当前进程映像                              | 实验中将文件系统与进程管理联系起来，但省略了 ELF 解析的复杂细节 |
| 用户程序从文件系统加载    | 程序的持久化与执行         | 程序本身也是文件                                             | 实验很好地体现了“程序即文件”的思想，是文件系统与进程管理的交汇点 |

------

## 二、OS 原理中很重要，但在本次实验中没有直接对应的知识点

| OS 原理中的重要知识点      | 为什么重要                      | 为什么实验中未涉及                     |
| -------------------------- | ------------------------------- | -------------------------------------- |
| 页缓存（Page Cache）       | 提高文件 I/O 性能，减少磁盘访问 | 教学实验侧重功能正确性，未实现缓存机制 |
| 日志文件系统（Journaling） | 保证文件系统一致性与崩溃恢复    | 实现复杂，不适合教学型内核             |
| 文件系统一致性检查（fsck） | 系统崩溃后修复文件系统          | 需要模拟异常场景，实验环境中不常见     |
| 多用户与权限管理           | 支撑多用户系统安全性            | uCore 实验为单用户、简化模型           |
| 硬链接 / 软链接            | 文件共享与路径抽象              | 实验中 inode 引用关系较简单            |
| 异步 I/O                   | 提升 I/O 并发能力               | 实验未涉及复杂并发与事件驱动           |
| 文件锁（File Lock）        | 进程间文件访问同步              | 教学实验中进程竞争较少                 |
| 复杂设备驱动模型           | 支撑真实硬件                    | 实验设备以抽象模型为主                 |
| NUMA / 分布式文件系统      | 大规模系统性能                  | 超出课程实验设计目标                   |

通过本次实验，我从代码层面理解了文件系统中 VFS、具体文件系统以及系统调用之间的关系。实验虽然对文件系统的实现进行了简化，但完整呈现了操作系统中文件访问的核心思想，为理解更复杂的真实操作系统文件系统奠定了基础。





