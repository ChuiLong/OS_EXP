# Lab2 分支任务

首先，我们运行以下的指令来重新编译qemu项目。

```apl
# 进入QEMU源码目录
cd qemu-4.1.1

# 清理之前的编译结果
make distclean

# 重新配置，启用调试选项
./configure --target-list=riscv32-softmmu,riscv64-softmmu --enable-debug

# 重新编译
make -j$(nproc)
```

随后，我们修改`ucore`项目中的`Makefile`，否则可能会链接到\usr目录下的QEMU，本人就是在此卡了很久，始终无法找到对应的`get_physical_address`指令，这是由于而在 C 语言中，`static` 函数的作用域仅限于定义它的文件内部，因此 GDB 默认在全局符号表中找不到它，我们必须使用上方启用了调试选项的QEMU：

```makefile
ifndef QEMU
QEMU := /root/qemu-4.1.1/riscv64-softmmu/qemu-system-riscv64
endif
```

随后我们启用三个终端窗口，终端1运行调试版QEMU，显示虚拟机控制台输出：

```
make debug
```

终端2使用标准GDB调试QEMU进程:

```
pgrep -f qemu-system-riscv64 
sudo gdb
(gdb) attach <刚才查到的PID>
(gdb) handle SIGPIPE nostop noprint
(gdb) # 你可以在这里执行一些操作，设置一些断点等
(gdb) continue # 之后就启动执行
```

终端3使用交叉编译工具链的GDB调试运行在QEMU中的ucore内核

```
make gdb
```

为了防止链接超时，我们unlimited对应的时间

```
set remotetimeout unlimited
```

在终端三中连接QEMU内建的GDB stub，开始调试ucore内核：

```apl
make gdb
set remotetimeout unlimited   # 设置无限超时，避免连接断开
break kern_init
c
```

此时，我们完成了三个终端的初始化配置，此时ucore内核停止在了kern_init内核初始化函数的入口，接下来我们开始真正的调试。

首先运行`x/8i $pc`命令可以先查看一下接下来的指令序列：

```apl
(gdb) x/8i $pc
=> 0xffffffffc02000d8 <kern_init>:
    auipc       a0,0x6
   0xffffffffc02000dc <kern_init+4>:
    addi        a0,a0,-192
   0xffffffffc02000e0 <kern_init+8>:
    auipc       a2,0x6
   0xffffffffc02000e4 <kern_init+12>:
    addi        a2,a2,-104
   0xffffffffc02000e8 <kern_init+16>:
    addi        sp,sp,-16
   0xffffffffc02000ea <kern_init+18>:
    sub a2,a2,a0
   0xffffffffc02000ec <kern_init+20>:
    li  a1,0
   0xffffffffc02000ee <kern_init+22>:
    sd  ra,8(sp)
```

通过单步执行直到到达sd指令：

```apl
(gdb) si      
0xffffffffc02000ee      28      int kern_init(void) {
(gdb) x/8i $pc
=> 0xffffffffc02000ee <kern_init+22>:
    sd  ra,8(sp)
   0xffffffffc02000f0 <kern_init+24>:
    jal ra,0xffffffffc020171c <memset>
   0xffffffffc02000f4 <kern_init+28>:
    jal ra,0xffffffffc0200220 <dtb_init>
   0xffffffffc02000f8 <kern_init+32>:
    jal ra,0xffffffffc0200216 <cons_init>
   0xffffffffc02000fc <kern_init+36>:
    auipc       a0,0x1
   0xffffffffc0200100 <kern_init+40>:
    addi        a0,a0,1796
   0xffffffffc0200104 <kern_init+44>:
    jal ra,0xffffffffc0200182 <cputs>
   0xffffffffc0200108 <kern_init+48>:
    jal ra,0xffffffffc020004a <print_kerninfo>
```

我们重点关注需要访存的`sd`指令，该指令将保存返回地址到栈中。我们在对于QEMU的调试中打入断点，然后continue恢复执行观察后续动作。

```apl
(gdb) b get_physical_address
Breakpoint 1 at 0x64b124e9c775: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 158.
(gdb) c
Continuing.
```

接下来我们就要运行我们的sd指令，使用si执行这条指令。直到跳过这一个读取物理地址的断点，其中我们经历的断点如下所示（很长）：

```apl
Thread 1 "qemu-system-ris" hit Breakpoint 1, get_physical_address (env=0x64b14c80d2a0, physical=0x7fffe412fe28, prot=0x7fffe412fe20, addr=18446744072637907160, access_type=0, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:158
158     {
(gdb) p/x addr
$1 = 0xffffffffc02000d8
(gdb) c
Continuing.
[Switching to Thread 0x73b184bfe640 (LWP 96721)]

Thread 3 "qemu-system-ris" hit Breakpoint 1, get_physical_address (env=0x64b14c80d2a0, physical=0x73b184bfd220, prot=0x73b184bfd214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:158
158     {
(gdb) p/x addr
$2 = 0xffffffffc0204ff8
(gdb) c
Continuing.
[Switching to Thread 0x73b1856d4b00 (LWP 96719)]

Thread 1 "qemu-system-ris" hit Breakpoint 1, get_physical_address (env=0x64b14c80d2a0, physical=0x7fffe412fe68, prot=0x7fffe412fe60, addr=18446744072637923328, access_type=0, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:158
158     {
(gdb) p/x addr
$3 = 0xffffffffc0204000
(gdb) c
Continuing.

Thread 1 "qemu-system-ris" hit Breakpoint 1, get_physical_address (env=0x64b14c80d2a0, physical=0x7fffe412fe08, prot=0x7fffe412fe00, addr=18446744072637907160, access_type=0, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:158
158     {
(gdb) c
Continuing.
(gdb) 
```

访问对应的sp栈地址

```
(gdb) i r sp  
sp             0xffffffffc0204ff0       0xffffffffc0204ff0
```

我们发现中间的一次执行才命中对应是store地址$2 = 0xffffffffc0204ff8(sp+8)，前后都是一点很奇怪的地址，这是为什么呢？来让我们问问大模型来：

### 1. 第一次调用：取指 (Instruction Fetch)

```gdb
$1 = 0xffffffffc02000d8
```

* **地址分析**：这个地址 `0xffffffffc02000d8` 正是 `kern_init` 函数的入口地址！

  ```assembly
  => 0xffffffffc02000d8 <kern_init>:    auipc       a0,0x6
  ```

* **原因**：CPU 要执行指令，首先必须从内存中读取指令。因此，QEMU 需要将 PC 指针指向的虚拟地址转换为物理地址，以便读取指令内容。

* **结论**：这是为了读取 `auipc` 这条指令本身。

### 2. 第二次调用：数据访存 (Data Access) - 您的目标

```gdb
$2 = 0xffffffffc0204ff8
```

*   **地址分析**：这个地址是 `sp + 8`。
    *   `sp` = `0xffffffffc0204ff0`
    *   `sp + 8` = `0xffffffffc0204ff8`
*   **原因**：这是 `sd ra, 8(sp)` 指令在执行“存储”操作。它需要将 `ra` 寄存器的值写入到栈内存中。
*   **结论**：这是您预期的 `sd` 指令产生的写内存操作。

### 3. 第三次调用：页表访问 (Page Table Walk)

```gdb
$3 = 0xffffffffc0204000
```

*   `0xffffffffc0204000` 是 **页表 (Page Table)** 所在的地址。
*   **原因**：当 CPU 尝试访问上述的虚拟地址（无论是取指还是存数据）时，如果 TLB（快表）中没有缓存该映射，MMU 硬件（在 QEMU 中由软件模拟）就需要去查询页表。
    *   查询页表本身也是一次内存访问！
    *   MMU 需要读取页表项 (PTE) 来获取物理页号。
*   **结论**：这是 MMU 为了完成前两次地址转换而进行的“查表”操作。

诶你还真别说，还挺有道理！那么具体是怎么填入TLB的呢？让我们继续观察来：

AI告诉我这些：要跟踪 TLB (Translation Lookaside Buffer) 的写入过程，您需要关注 QEMU 源代码中负责填充 TLB 的函数。在 QEMU 的 RISC-V 实现中，这个函数通常是 **`tlb_fill`**。

当 `get_physical_address` 成功计算出物理地址后，QEMU 会调用 `tlb_fill`（或其底层实现 `tlb_set_page`）将这个映射关系缓存到 TLB 中，以便下次访问同一页面时能更快地完成转换。







首先中断终端二中QEMU的执行，设置断点`break riscv_cpu_tlb_fill`。

```apl
(gdb) break riscv_cpu_tlb_fill
Breakpoint 1 at 0x596094bc238a: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 438.
(gdb) c
Continuing.
```

然后单步执行终端三的这条sd指令。

```apl
Thread 3 "qemu-system-ris" hit Breakpoint 1, riscv_cpu_tlb_fill (cs=0x5960cde8d890, address=18446744072637927416, size=8, access_type=MMU_DATA_STORE, mmu_idx=1, probe=false, retaddr=140191029260613) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:438
438     {
(gdb) break get_physical_address
Breakpoint 2 at 0x596094bc1775: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 158.
(gdb) c
Continuing.
```

可以看到终端二停在了我们设置的断点处，且查看地址信息确实为`sd`访存的虚拟地址（`sp+8`），再设置一个断点`break get_physical_address` 。

```apl
(gdb) break get_physical_address
Breakpoint 2 at 0x596094bc1775: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 158.
(gdb) c
Continuing.
```

继续执行，断点命中。

```apl
Thread 3 "qemu-system-ris" hit Breakpoint 2, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:158
158     {
```

此时我们进入到了get_physical_address函数中，再设置三个断点，方便我们监测在查询页表的过程中，页表项的物理地址`pte_addr`、物理页号`ppn`、以及最后计算得到的物理基址`*physical`这三个值的变化。

```apl
(gdb) b /root/qemu-4.1.1/target/riscv/cpu_helper.c:242
Breakpoint 3 at 0x596094bc1c01: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 242.
(gdb) b /root/qemu-4.1.1/target/riscv/cpu_helper.c:254
Breakpoint 4 at 0x596094bc1c86: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 254.
(gdb) b /root/qemu-4.1.1/target/riscv/cpu_helper.c:334
Breakpoint 5 at 0x596094bc1ed9: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 334.
(gdb) c
Continuing.
```

首先停在了刚更新完`pte_addr`的时刻，

```apl
Thread 3 "qemu-system-ris" hit Breakpoint 3, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:242
242             target_ulong pte_addr = base + idx * ptesize;
(gdb) p/x pte_addr
$1 = 0x8aa40ca594b06270
(gdb) n
244             if (riscv_feature(env, RISCV_FEATURE_PMP) &&
(gdb) p/x pte_addr
$2 = 0x80205ff8
(gdb) c
Continuing.
```

可以看到，`pte_addr`被更新为0x80205ff8，对应的上下文代码是：

```c++
        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
                           ((1 << ptidxbits) - 1);

        /* check that physical address of PTE is legal */
        target_ulong pte_addr = base + idx * ptesize;
```

由于查看`satp`寄存器得到页表基址为0x80205000，通过页内偏移（`索引×页表项大小`）即可得到页表项的地址为80205ff8。

然后中断在了刚刚更新完物理页号PPN的位置，

```apl
Thread 3 "qemu-system-ris" hit Breakpoint 4, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:254
254             target_ulong ppn = pte >> PTE_PPN_SHIFT;
(gdb) n
256             if (!(pte & PTE_V)) {
(gdb) p/x ppn
$3 = 0x80000
(gdb) c
Continuing.


```

对应的代码为：

```c++
#if defined(TARGET_RISCV32)
        target_ulong pte = ldl_phys(cs->as, pte_addr);
#elif defined(TARGET_RISCV64)
        target_ulong pte = ldq_phys(cs->as, pte_addr);
#endif
        target_ulong ppn = pte >> PTE_PPN_SHIFT;
```

通过页表项的地址拿到其对应的页信息，然后拿到对应的物理页号，通过调试信息可以看到此时物理页号PPN被更新为 0x80000。

然后停在了最后更新*physical物理基址的地方，只进行了一轮映射，说明这是**大页映射**，可能因为这是内核启动早期的页表，故只需一轮映射即可拿到物理基址。

```apl
Thread 3 "qemu-system-ris" hit Breakpoint 5, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:334
334                 *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
(gdb) n
337                 if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
(gdb) p/x *physical
$4 = 0x80204000
(gdb) p/x ppn
$5 = 0x80000
(gdb) p/x vpn
$6 = 0xffffffffc0204
(gdb) p/x ptshift
$7 = 0x12
(gdb) 
```

并且我们可以通过 `p/x ptshift`查看到当前层级的虚拟地址位偏移量`ptshift`的值为0x12，代表了这是1GB大页映射，在**第一级页表**就找到了叶子PTE，内核早期使用1GB大页可以简化页表管理，提高性能。

对应的上下文代码为：

```c++
            target_ulong vpn = addr >> PGSHIFT;
            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
```

通过调试信息，我们可以看到**物理页号PPN**、**虚拟页号VPN**、**当前层级的虚拟地址位偏移量`ptshift`的值**，以及我们已知的PGSHIFT，可求出物理基址*physical，通过计算验证确实为我们读出的0x80204000。

以上所述就是QEMU进行的完整的地址翻译的过程。

完整调试过程如下：

```
root@DESKTOP-7DG58RU:~/qemu-4.1.1# sudo gdb
GNU gdb (Ubuntu 12.1-0ubuntu1~22.04.2) 12.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word".
warning: File "/root/qemu-4.1.1/.gdbinit" auto-loading has been declined by your `auto-load safe-path' set to "$debugdir:$datadir/auto-load".
To enable execution of this file add
        add-auto-load-safe-path /root/qemu-4.1.1/.gdbinit
line to your configuration file "/root/.config/gdb/gdbinit".
To completely disable this security protection add
        set auto-load safe-path /
line to your configuration file "/root/.config/gdb/gdbinit".
For more information about this security protection see the
"Auto-loading safe path" section in the GDB manual.  E.g., run from the shell:
        info "(gdb)Auto-loading safe path"
(gdb) attach 171509
Attaching to process 171509
[New LWP 171510]
[New LWP 171511]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
0x00007f80c7118d3e in __ppoll (fds=0x5960cded9bf0, nfds=7, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
42      ../sysdeps/unix/sysv/linux/ppoll.c: No such file or directory.
(gdb) c
Continuing.
^C
Thread 1 "qemu-system-ris" received signal SIGINT, Interrupt.
0x00007f80c7118d3e in __ppoll (fds=0x5960cded9bf0, nfds=6, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
42      in ../sysdeps/unix/sysv/linux/ppoll.c
(gdb) break riscv_cpu_tlb_fill
Breakpoint 1 at 0x596094bc238a: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 438.
(gdb) c
Continuing.
[Switching to Thread 0x7f80bffff640 (LWP 171511)]

Thread 3 "qemu-system-ris" hit Breakpoint 1, riscv_cpu_tlb_fill (cs=0x5960cde8d890, address=18446744072637927416, size=8, access_type=MMU_DATA_STORE, mmu_idx=1, probe=false, retaddr=140191029260613) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:438
438     {
(gdb) break get_physical_address
Breakpoint 2 at 0x596094bc1775: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 158.
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 2, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:158
158     {
(gdb) break /home/lin/workspace/qemu-4.1.1/target/riscv/cpu_helper.c:242
No source file named /home/lin/workspace/qemu-4.1.1/target/riscv/cpu_helper.c.
Make breakpoint pending on future shared library load? (y or [n]) n
(gdb) file /root/qemu-4.1.1/riscv64-softmmu/qemu-system-riscv64
A program is being debugged already.
Are you sure you want to change the file? (y or n) n
File not changed.
(gdb) break /home/lin/workspace/qemu-4.1.1/target/riscv/cpu_helper.c:243
No source file named /home/lin/workspace/qemu-4.1.1/target/riscv/cpu_helper.c.
Make breakpoint pending on future shared library load? (y or [n]) n
(gdb) b /root/qemu-4.1.1/target/riscv/cpu_helper.c:242
Breakpoint 3 at 0x596094bc1c01: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 242.
(gdb) b /root/qemu-4.1.1/target/riscv/cpu_helper.c:254
Breakpoint 4 at 0x596094bc1c86: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 254.
(gdb) b /root/qemu-4.1.1/target/riscv/cpu_helper.c:334
Breakpoint 5 at 0x596094bc1ed9: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 334.
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 3, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:242
242             target_ulong pte_addr = base + idx * ptesize;
(gdb) p/x pte_addr
$1 = 0x8aa40ca594b06270
(gdb) n
244             if (riscv_feature(env, RISCV_FEATURE_PMP) &&
(gdb) p/x pte_addr
$2 = 0x80205ff8
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 4, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:254
254             target_ulong ppn = pte >> PTE_PPN_SHIFT;
(gdb) n
256             if (!(pte & PTE_V)) {
(gdb) p/x ppn
$3 = 0x80000
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 5, get_physical_address (env=0x5960cde962a0, physical=0x7f80bfffe220, prot=0x7f80bfffe214, addr=18446744072637927416, access_type=1, mmu_idx=1) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:334
334                 *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
(gdb) n
337                 if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
(gdb) p/x *physical
$4 = 0x80204000
(gdb) p/x ppn
$5 = 0x80000
(gdb) p/x vpn
$6 = 0xffffffffc0204
(gdb) p/x ptshift
$7 = 0x12
(gdb) 
```

### 步骤 1：在 QEMU 调试终端 (sudo gdb) 设置断点

请在您的 **终端 2 (sudo gdb)** 中执行以下操作：

1. **查找 `tlb_fill` 函数**：
   RISC-V 的 `tlb_fill` 实现通常位于 cpu_helper.c 或 `target/riscv/op_helper.c` 中。

   ```gdb
   (gdb) break riscv_cpu_tlb_fill
   ```

   *(注意：函数名可能是 `riscv_cpu_tlb_fill`，这是 QEMU 中架构特定的命名惯例)*

2. **查找 `tlb_set_page` 函数**：
   这是更底层的函数，用于实际将条目写入 QEMU 的软 TLB。

   ```gdb
   (gdb) break tlb_set_page
   ```

### 步骤 2：继续执行并观察

设置好断点后，继续运行：

```gdb
(gdb) c
```

当断点触发时，您可以查看参数：

*   **`vaddr`**: 虚拟地址
*   **`paddr`**: 物理地址
*   **`prot`**: 保护位 (读/写/执行)
*   **`mmu_idx`**: MMU 索引 (内核态/用户态)

```gdb
(gdb) break riscv_cpu_tlb_fill
Breakpoint 1 at 0x56ab5fe2538a: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 438.
(gdb) break tlb_set_page
Breakpoint 2 at 0x56ab5fd6b5c4: file /root/qemu-4.1.1/accel/tcg/cputlb.c, line 847.
(gdb) c
Continuing.
[Switching to Thread 0x7461c9d7d640 (LWP 118194)]

Thread 3 "qemu-system-ris" hit Breakpoint 1, riscv_cpu_tlb_fill (cs=0x56ab8cf73890, address=18446744072637927416, size=8, access_type=MMU_DATA_STORE, mmu_idx=1, probe=false, retaddr=127963347018053) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:438
438     {
(gdb) p/x address
$1 = 0xffffffffc0204ff8
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 2, tlb_set_page (cpu=0x56ab8cf73890, vaddr=18446744072637923328, paddr=2149597184, prot=7, mmu_idx=1, size=4096) at /root/qemu-4.1.1/accel/tcg/cputlb.c:847
847         tlb_set_page_with_attrs(cpu, vaddr, paddr, MEMTXATTRS_UNSPECIFIED,
(gdb) p/x address
No symbol "address" in current context.
(gdb) p/x vaddr
$2 = 0xffffffffc0204000
(gdb) p/x paddr
$3 = 0x80204000
(gdb) p prot
$4 = 7
(gdb) p mmu_idx
$5 = 1
(gdb) p size
$6 = 4096
```



接下来我们来看是否在qemu-4.1.1的源码中模拟cpu查找tlb的C代码细节。

在 QEMU 中，CPU 访问内存（Load/Store）时，会先查找软件 TLB。如果未命中，才会调用硬件相关的 `tlb_fill` 进行页表查询。

* **文件**: cputlb.c

* **函数**: `load_helper` (用于读取数据)

* **关键逻辑**:

  ```c
  // accel/tcg/cputlb.c : line 1271
  if (!tlb_hit(tlb_addr, addr)) {
      // TLB Miss!
      if (!victim_tlb_hit(...)) {
           // Victim TLB 也 Miss，调用 tlb_fill 查页表
           tlb_fill(env_cpu(env), addr, size, access_type, mmu_idx, retaddr);
      }
  }
  ```

1. **终端 1**: `make debug` (启动 QEMU)

2. **终端 2**:

   ```bash
   pgrep -f qemu-system-riscv64
   sudo gdb
   (gdb) attach <PID>
   (gdb) handle SIGPIPE nostop noprint
   ```

3. **终端 3**:

   ```bash
   make gdb
   (gdb) set remotetimeout unlimited
   (gdb) break kern_init
   (gdb) c
   ```

我们需要在 QEMU 内部设置两个断点：一个是 **TLB 查找入口**，一个是 **页表查询入口**。

在 **终端 2** 中输入：

```gdb
# 断点 1: 内存读取的入口 (查 TLB)
# 注意：load_helper 是 static 函数，可能需要通过文件名指定，或者断点在 helper_lduw_mmu
break accel/tcg/cputlb.c:1271
# 或者
break load_helper

# 断点 2: 页表查询入口 (TLB Miss 后)
break riscv_cpu_tlb_fill
```

1.  在 **终端 2** 中输入 `c` 让 QEMU 继续运行。
2.  在 **终端 3** (ucore 调试器) 中执行单步 `si` 或 `c`，触发一次内存访问。

```
Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (full_load=0x5eccf807b7f1 <full_le_ldul_cmmu>, code_read=true, big_endian=false, size=4, retaddr=0, oi=33, addr=18446744072637907182, env=0x5ecd316332a0) at /root/qemu-4.1.1/accel/tcg/cputlb.c:1252
1252        uintptr_t mmu_idx = get_mmuidx(oi);
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 2, riscv_cpu_tlb_fill (cs=0x5ecd3162a890, address=18446744072637927416, size=8, access_type=MMU_DATA_STORE, mmu_idx=1, probe=false, retaddr=127893660754245) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:438
438     {

Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (full_load=0x5eccf807b7f1 <full_le_ldul_cmmu>, code_read=true, big_endian=false, size=4, retaddr=0, oi=33, addr=18446744072637907182, env=0x5ecd316332a0) at /root/qemu-4.1.1/accel/tcg/cputlb.c:1252
1252        uintptr_t mmu_idx = get_mmuidx(oi);
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 2, riscv_cpu_tlb_fill (cs=0x5ecd3162a890, address=18446744072637927416, size=8, access_type=MMU_DATA_STORE, mmu_idx=1, probe=false, retaddr=127893660754245) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:438
438     {

Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (full_load=0x565ac47337f1 <full_le_ldul_cmmu>, code_read=true, big_endian=false, size=4, retaddr=0, oi=33, addr=18446744072637912866, env=0x565ae6d682a0) at /root/qemu-4.1.1/accel/tcg/cputlb.c:1252
1252        uintptr_t mmu_idx = get_mmuidx(oi);
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (full_load=0x565ac47337f1 <full_le_ldul_cmmu>, code_read=true, big_endian=false, size=4, retaddr=0, oi=33, addr=18446744072637907490, env=0x565ae6d682a0) at /root/qemu-4.1.1/accel/tcg/cputlb.c:1252
1252        uintptr_t mmu_idx = get_mmuidx(oi);
```

调试输出非常清晰地展示了 QEMU 模拟 CPU 内存访问的完整流程。

### 1. TLB Hit (命中) 的情况

```gdb
Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (...) addr=18446744072637907178 ...
(gdb) c
Continuing.
Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (...) addr=18446744072637907182 ...
```

*   **现象**：连续命中了 `load_helper` 断点，但**没有**紧接着命中 `riscv_cpu_tlb_fill`。
*   **含义**：这说明这些地址（`...07178`, `...07182`）在 TLB 中已经存在了。
    *   `load_helper` 被调用。
    *   `tlb_hit` 返回 `true`。
    *   函数直接返回物理地址，**不需要**去查页表。
*   **场景**：这通常发生在 CPU 顺序执行指令时（`code_read=true`），因为指令通常在同一个页面内，第一次访问后 TLB 就有了缓存，后续指令取指都能命中。

### 2. TLB Miss (未命中) 的情况

```gdb
Thread 3 "qemu-system-ris" hit Breakpoint 2, riscv_cpu_tlb_fill (..., address=18446744072637927416, ...)
```

*   **现象**：直接命中了 `riscv_cpu_tlb_fill` 断点（注意：这里可能是因为 `store_helper` 没有打断点，或者 `load_helper` 的断点被跳过了，但结果是一样的）。
*   **含义**：这是一个 **TLB Miss** 事件。
    *   CPU 尝试访问地址 `...927416`。
    *   TLB 中没有这个映射。
    *   QEMU 调用 `riscv_cpu_tlb_fill` 来处理这个缺失。
    *   该函数会调用 `get_physical_address` 去查页表，然后填入 TLB。

### 3. 混合场景 (Miss 后 Hit)

```gdb
Thread 3 "qemu-system-ris" hit Breakpoint 2, riscv_cpu_tlb_fill (..., address=18446744072637912860, ...)
...
Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (..., addr=18446744072637912862, ...)
Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (..., addr=18446744072637912866, ...)
```

*   **现象**：
    1.  先发生了一次 Miss (`...12860`)，触发了 `tlb_fill`。
    2.  紧接着访问临近地址 (`...12862`, `...12866`) 时，只触发了 `load_helper`，没有触发 `tlb_fill`。
*   **含义**：这完美验证了 TLB 的**缓存作用**！
    *   第一次访问页面内的某个地址，TLB Miss，查页表并填充 TLB。
    *   后续访问**同一个页面**内的其他地址，TLB Hit，直接从缓存读取，速度极快。

1.  **Fast Path**: `load_helper` -> `tlb_hit` (成功) -> 返回。
2.  **Slow Path**: `load_helper` -> `tlb_hit` (失败) -> `tlb_fill` -> 查页表 -> 填充 TLB。

这就是现代 CPU 内存管理单元 (MMU) 的核心工作机制。



### 查 TLB 的核心过程 (C 代码逻辑)

在 QEMU 中，模拟 CPU 查找 TLB 的过程非常像硬件逻辑，主要包含三个步骤：**哈希索引** -> **读取条目** -> **比较标签 (Tag)**。

这段逻辑主要在 cputlb.c 的 `load_helper` 函数中：

```c
// accel/tcg/cputlb.c

// 1. 计算索引 (Index)
// 使用虚拟地址的低位作为哈希索引，去数组中找对应的槽位
uintptr_t index = tlb_index(env, mmu_idx, addr);

// 2. 获取条目 (Entry)
// 从 TLB 数组中取出对应的 CPUTLBEntry 结构体
CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);

// 3. 取出缓存的虚拟地址 (Tag)
// 根据是读数据还是取指令，取出对应的比较地址
target_ulong tlb_addr = code_read ? entry->addr_code : entry->addr_read;

// 4. 比较 (Compare)
// 检查 TLB 条目中记录的虚拟地址是否与我们要访问的地址一致
if (!tlb_hit(tlb_addr, addr)) {
    //如果不一致 -> TLB Miss -> 调用 tlb_fill 查页表
}
```

---

### 怎么调试？ (手把手操作)

我们将在 **终端 2 (sudo gdb)** 中进行精细的单步调试，观察这个“查表”过程。

### 第一步：准备工作 (终端 2 - sudo gdb)

确保您已经 attach 到了 QEMU 进程。

```gdb
# 如果还没 attach
attach <PID>
```

### 第二步：设置断点 (终端 2)

我们需要捕捉两个关键点：

1.  **取指**：`load_helper`
2.  **存数据**：`store_helper`

```gdb
# 清除之前的断点，避免干扰
delete breakpoints

# 断点 1: 取指 (load_helper)
break load_helper

# 断点 2: 存数据 (store_helper)
break store_helper
```

### 第三步：定位到目标指令 (终端 3 - ucore gdb)

在 ucore 的调试终端中，确保 PC 正好停在 `sd` 指令上。

```gdb
# 如果还没到，先单步走到这里
(gdb) x/i $pc
=> 0xffffffffc02000ee <kern_init+22>:    sd      ra,8(sp)
```

### 第四步：开始调试 (交互操作)

现在，我们在 **终端 2 (sudo gdb)** 中输入 `c` 让 QEMU 跑起来。
然后，在 **终端 3 (ucore gdb)** 中输入 `si` (单步执行一条指令)。

此时，**终端 2** 应该会命中断点。

#### 阶段 1：取指 (Instruction Fetch)

1. **命中断点**：

   ```gdb
   Thread 3 hit Breakpoint 1, load_helper (..., code_read=true, ...)
   ```

   *   `code_read=true` 确认这是在取指令。

2. **单步执行以初始化变量**：
   输入 `n` (next) 约 3-5 次，直到看到代码行：

   ```c
   if (!tlb_hit(tlb_addr, addr)) {
   ```

3. **观察变量**：

   ```gdb
   p/x addr       # 应该是 0xffffffffc02000ee (PC地址)
   p/x tlb_addr   # TLB 中的地址
   p tlb_hit(tlb_addr, addr)  # 检查是否命中
   ```

4. **继续运行**：
   输入 `c`。

#### 阶段 2：存数据 (Data Store)

由于 `sd` 指令需要写内存，QEMU 会再次触发断点。

1. **命中断点**：

   ```gdb
   Thread 3 hit Breakpoint 2, store_helper (...)
   ```

   *   这次是 `store_helper`，说明是在写数据。

2. **单步执行以初始化变量**：
   同样输入 `n` (next) 约 3-5 次，直到走到 `tlb_hit` 判断处。

3. **观察变量**：

   ```gdb
   p/x addr       # 应该是 sp + 8 的值 (例如 0xffffffffc0204ff8)
   p/x tlb_addr   # TLB 中的地址
   ```

4. **验证 TLB Miss (如果发生)**：
   如果 `tlb_hit` 返回 false，继续输入 `n`，您会看到代码进入 `if` 分支，最终调用 `tlb_fill`。

### 第五步：总结

通过这个流程，您将完整地看到一条 `sd` 指令在微观层面的两个动作：

1.  **Load Helper**: CPU 拿着 PC 地址去查 TLB，为了读取指令码。
2.  **Store Helper**: CPU 拿着计算出的栈地址去查 TLB，为了写入 `ra` 寄存器的值。

这就是最底层的硬件模拟细节！



```
Thread 3 "qemu-system-ris" hit Breakpoint 1, load_helper (full_load=0x6102a76367f1 <full_le_ldul_cmmu>, code_read=true, big_endian=false, size=4, retaddr=0, oi=33, addr=18446744072637907182, env=0x6102da9d42a0) at /root/qemu-4.1.1/accel/tcg/cputlb.c:1252
1252        uintptr_t mmu_idx = get_mmuidx(oi);
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 2, store_helper (big_endian=false, size=8, retaddr=140185482293573, oi=49, val=2147486210, addr=18446744072637927416, env=0x6102da9d42a0) at /root/qemu-4.1.1/accel/tcg/cputlb.c:1504
1504        uintptr_t mmu_idx = get_mmuidx(oi);
(gdb) n
1505        uintptr_t index = tlb_index(env, mmu_idx, addr);
(gdb) n
1506        CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
(gdb) n
1507        target_ulong tlb_addr = tlb_addr_write(entry);
(gdb) n
1508        const size_t tlb_off = offsetof(CPUTLBEntry, addr_write);
(gdb) n
1509        unsigned a_bits = get_alignment_bits(get_memop(oi));
(gdb) n
1513        if (addr & ((1 << a_bits) - 1)) {
(gdb) n
1519        if (!tlb_hit(tlb_addr, addr)) {
(gdb) p/x addr 
$1 = 0xffffffffc0204ff8
(gdb) p/x tlb_addr 
$2 = 0xffffffffffffffff
(gdb) p tlb_hit(tlb_addr, addr)
$3 = false
(gdb) c
Continuing.
```

### 1. 场景确认

*   **函数**: `store_helper` —— 正在执行写操作。
*   **地址 (`addr`)**: `0xffffffffc0204ff8` —— 这正是 `sp + 8` 的地址（栈地址）。
*   **值 (`val`)**: `2147486210` (即 `0x80001202`) —— 这是要写入的数据（`ra` 寄存器的值）。

### 2. 关键变量分析

*   **`addr`**: `0xffffffffc0204ff8`
    *   这是目标虚拟地址。
*   **`tlb_addr`**: `0xffffffffffffffff` (-1)
    *   这是从 TLB 表项中取出的地址。
    *   **-1 (全F)** 在 QEMU TLB 中通常表示 **无效条目 (Invalid Entry)**。这意味着该 TLB 槽位是空的，或者被标记为无效。

### 3. 命中判断

*   **`tlb_hit(tlb_addr, addr)`**: `false`
    *   因为 `0xffffffffc0204ff8` (目标) 不等于 `0xffffffffffffffff` (缓存)。
    *   **结论**: **TLB Miss!**

### 4. 后续流程预测

由于 `tlb_hit` 返回 `false`，代码将进入 `if` 分支：

```c
if (!tlb_hit(tlb_addr, addr)) {
    if (!victim_tlb_hit(...)) {
        // 接下来一定会调用这个！
        tlb_fill(env_cpu(env), addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
    }
}
```

QEMU 的软 TLB (Soft TLB) 和真实 CPU 的硬件 TLB 在**逻辑功能**上是一致的（都是为了加速地址转换），但在**实现机制**和**性能特性**上有显著区别。

以下是主要的逻辑区别：

### 1. 结构与查找方式

*   **真实 CPU (硬件 TLB)**:
    *   通常是 **全相联 (Fully Associative)** 或 **组相联 (Set Associative)**。
    *   查找是**并行**的：硬件电路同时比较所有（或一组）条目的 Tag，速度极快（通常 1 个时钟周期）。
    *   容量非常有限（例如 64~2048 个条目）。
*   **QEMU (软 TLB)**:
    *   是一个 **直接映射 (Direct Mapped)** 的哈希表（数组）。
    *   查找是**串行**的：计算哈希 -> 查数组 -> 比较 Tag。
    *   容量相对较大（QEMU 默认可能是几千到几万个条目，取决于配置），因为它存储在主存中，成本低。
    *   **逻辑区别**：由于是直接映射，QEMU 的 TLB 更容易发生**哈希冲突**。如果两个频繁访问的页面哈希到同一个槽位，它们会互相驱逐（Thrashing），而硬件的组相联结构能更好地处理这种情况。

### 2. 缺失处理 (Miss Handling)

*   **真实 CPU**:
    *   **硬件遍历 (Hardware Walker)**: 现代 CPU（如 x86, ARM, RISC-V）通常有专门的硬件单元自动查页表，操作系统感知不到 TLB Miss，只感知到 Page Fault（缺页异常）。
    *   **软件遍历 (Software Managed)**: 某些架构（如 MIPS, 旧版 RISC-V）TLB Miss 会触发异常，由操作系统软件查表填入。
*   **QEMU**:
    *   完全是**软件模拟**。
    *   当 `tlb_hit` 失败时，QEMU 会调用 C 函数 (`tlb_fill`) 来模拟硬件的 Page Walker。
    *   **逻辑区别**：QEMU 有一个 **Victim TLB**（受害者缓存）。这是一个小型的全相联缓存（通常 8 个条目），用于存放刚被驱逐出的 TLB 条目。这在逻辑上是为了弥补直接映射哈希表冲突率高的问题，起到类似“组相联”的作用。

### 3. 刷新机制 (TLB Flush)

*   **真实 CPU**:
    *   操作系统执行特定指令（如 `sfence.vma`）时，硬件会按需刷新。
    *   支持 ASID (Address Space ID) / PCID，切换进程时不需要刷新整个 TLB。
*   **QEMU**:
    *   刷新操作通常比较“重”。
    *   虽然也支持 ASID，但由于软 TLB 结构简单，某些复杂的刷新操作可能导致 QEMU 简单粗暴地清空整个数组。

### 4. 包含的信息

*   **真实 CPU**:
    *   只存储物理页号 (PPN) 和权限位。
*   **QEMU**:
    *   为了加速模拟，QEMU 的 TLB 条目 (`CPUTLBEntry`) 存储了更多信息：
        *   **`addend`**: 这是一个“偏移量”。
        *   **逻辑区别**：真实 CPU 拿到物理地址后还要去访问 L1 Cache/内存。而 QEMU 拿到 `addend` 后，直接 `Host_Virtual_Address = Guest_Virtual_Address + addend`，就能直接算出宿主机（Host）的内存地址，从而直接读写宿主机的 RAM。这是 QEMU TCG 加速的核心技巧。

### 总结

| 特性         | 真实 CPU TLB        | QEMU 软 TLB              |
| :----------- | :------------------ | :----------------------- |
| **本质**     | 硬件电路 (SRAM/CAM) | 软件数据结构 (数组)      |
| **查找**     | 并行比较 (极快)     | 哈希计算 + 比较 (较慢)   |
| **映射**     | 组相联 / 全相联     | 直接映射 (Direct Mapped) |
| **冲突缓解** | 多路组相联          | Victim TLB (二级缓存)    |
| **地址转换** | 得到物理地址 (PA)   | 得到宿主机虚拟地址 (HVA) |

虽然实现不同，但它们对操作系统呈现的**行为模型**是一样的：**查不到就去查页表，查到了就直接用。** 这就是为什么您可以在 QEMU 上调试出与真机一致的操作系统逻辑。




相关函数

#### 1. 函数定义与初始化

```c++
static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                int *prot, target_ulong addr,
                                int access_type, int mmu_idx)
{
    int mode = mmu_idx;

    if (mode == PRV_M && access_type != MMU_INST_FETCH) {
        if (get_field(env->mstatus, MSTATUS_MPRV)) {
            mode = get_field(env->mstatus, MSTATUS_MPP);
        }
    }

    if (mode == PRV_M || !riscv_feature(env, RISCV_FEATURE_MMU)) {
        *physical = addr;
        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
        return TRANSLATE_SUCCESS;
    }

    *prot = 0;
```

**分析：**

1. **获取初始特权级**：取当前 MMU 索引为初始 `mode`。
2. **处理 MPRV**：若在 M-Mode 且 `MPRV` 开启（非取指），则使用 `mstatus.MPP` 作为特权级，允许以低权限视角访问内存。
3. **直通模式判断**：若最终为 M-Mode 或无 MMU，直接映射物理地址并赋予全权限（如启动早期），不查页表。
4. **准备翻译**：若需查页表，先初始化权限 `*prot` 为 0。

#### 2. 读取 SATP 寄存器与页表参数配置

```c++
    target_ulong base;
    int levels, ptidxbits, ptesize, vm, sum;
    int mxr = get_field(env->mstatus, MSTATUS_MXR);

    if (env->priv_ver >= PRIV_VERSION_1_10_0) {
        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
        sum = get_field(env->mstatus, MSTATUS_SUM);
        vm = get_field(env->satp, SATP_MODE);
        switch (vm) {
        case VM_1_10_SV32:
          levels = 2; ptidxbits = 10; ptesize = 4; break;
        case VM_1_10_SV39:
          levels = 3; ptidxbits = 9; ptesize = 8; break;
        case VM_1_10_SV48:
          levels = 4; ptidxbits = 9; ptesize = 8; break;
        case VM_1_10_SV57:
          levels = 5; ptidxbits = 9; ptesize = 8; break;
        case VM_1_10_MBARE:
            *physical = addr;
            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
            return TRANSLATE_SUCCESS;
        default:
          g_assert_not_reached();
        }
    } else {
        base = env->sptbr << PGSHIFT;
        sum = !get_field(env->mstatus, MSTATUS_PUM);
        vm = get_field(env->mstatus, MSTATUS_VM);
        switch (vm) {
        case VM_1_09_SV32:
          levels = 2; ptidxbits = 10; ptesize = 4; break;
        case VM_1_09_SV39:
          levels = 3; ptidxbits = 9; ptesize = 8; break;
        case VM_1_09_SV48:
          levels = 4; ptidxbits = 9; ptesize = 8; break;
        case VM_1_09_MBARE:
            *physical = addr;
            *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
            return TRANSLATE_SUCCESS;
        default:
          g_assert_not_reached();
        }
    }
```

**分析：**
此段代码从控制寄存器提取页表参数。根据 `vm` 值配置：**SV39** 模式设为 3 级页表、9 位索引、8 字节页表项；`MBARE` 模式关闭 MMU 直通物理地址。同时兼容旧版 1.09 规范（如 `sptbr`）。

#### 3. 虚拟地址规范性检查 (Canonical Address Check)

```c++
    CPUState *cs = env_cpu(env);
    int va_bits = PGSHIFT + levels * ptidxbits;
    target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
    target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
    if (masked_msbs != 0 && masked_msbs != mask) {
        return TRANSLATE_FAIL;
    }
```

**分析：**
RISC-V SV39 模式下，虚拟地址仅低 39 位有效，高位（63-39）须与第 38 位一致（符号扩展）。代码计算有效位 `va_bits` 并用掩码 `mask` 检查高位 `masked_msbs`：若非全 0 或全 1，则地址非法，翻译失败。

#### 4. 多级页表遍历循环 (Hardware Page Walk)

```c++
    int ptshift = (levels - 1) * ptidxbits;
    int i;

#if !TCG_OVERSIZED_GUEST
restart:
#endif
    for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
        //1.索引计算与读取
        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
                           ((1 << ptidxbits) - 1);
        target_ulong pte_addr = base + idx * ptesize;
        //1.1计算出页表项 (PTE) 的物理地址 `pte_addr`
        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
            !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
            1 << MMU_DATA_LOAD, PRV_S)) {
            return TRANSLATE_PMP_FAIL;
        }
        //1.2 提取页表项内容 并获取物理页号PPN
#if defined(TARGET_RISCV32)
        target_ulong pte = ldl_phys(cs->as, pte_addr);
#elif defined(TARGET_RISCV64)
        target_ulong pte = ldq_phys(cs->as, pte_addr);
#endif
        target_ulong ppn = pte >> PTE_PPN_SHIFT;
	//2.有效性与目录项判断
        if (!(pte & PTE_V)) {//2.1缺页
            return TRANSLATE_FAIL;
        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {//2.2是目录项 不是叶子节点 提取出的 PPN 左移作为下一级页表的基址 base ，并继续下一次循环
            base = ppn << PGSHIFT;
        //2.3否则是叶子节点 依次进行检查
        //3.1检查是否只有写权限 ( PTE_W ) 或同时有写和执行权限 ( PTE_W | PTE_X )，这些在 RISC-V 中是保留或非法的。
        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
            return TRANSLATE_FAIL;
        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
            return TRANSLATE_FAIL;
      //3.2检查用户/内核权限。
        } else if ((pte & PTE_U) && ((mode != PRV_U) &&
                   (!sum || access_type == MMU_INST_FETCH))) {//如果 PTE 是用户页 ( PTE_U ) 但当前不在 U 模式（且 SUM 未开启或正在取指），则禁止访问。
            return TRANSLATE_FAIL;
        } else if (!(pte & PTE_U) && (mode != PRV_S)) {//反之，如果 PTE 是内核页但当前在 U 模式，也禁止访问。  
            return TRANSLATE_FAIL;
        } else if (ppn & ((1ULL << ptshift) - 1)) {//3.3如果是超级页（Superpage，即 ptshift > 0 的叶子节点），检查 PPN 是否对齐。
            return TRANSLATE_FAIL;
      //3.4根据具体的 access_type （读、写、取指），对比 PTE 的 R/W/X 位，确保权限足够。注意读取时如果 MXR 置位，则允许读取只执行页面。
        } else if (access_type == MMU_DATA_LOAD && !((pte & PTE_R) ||
                   ((pte & PTE_X) && mxr))) {
            return TRANSLATE_FAIL;
        } else if (access_type == MMU_DATA_STORE && !(pte & PTE_W)) {
            return TRANSLATE_FAIL;
        } else if (access_type == MMU_INST_FETCH && !(pte & PTE_X)) {
            return TRANSLATE_FAIL;
        } else {//4.如果所有检查通过，进入最后的 else 块。
            target_ulong updated_pte = pte | PTE_A |//4.1 A/D 位维护
                (access_type == MMU_DATA_STORE ? PTE_D : 0);

            if (updated_pte != pte) {//PTE 值发生了变化（例如第一次访问或第一次写），需要将其写回物理内存
                MemoryRegion *mr;
                hwaddr l = sizeof(target_ulong), addr1;
                mr = address_space_translate(cs->as, pte_addr,&addr1, &l, false, MEMTXATTRS_UNSPECIFIED);
                if (memory_region_is_ram(mr)) {
                    target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
#if TCG_OVERSIZED_GUEST
                    *pte_pa = pte = updated_pte;
#else
                    target_ulong old_pte = atomic_cmpxchg(pte_pa, pte, updated_pte);
                    if (old_pte != pte) {
                        goto restart;//原子更新失败（说明期间被其他核修改），跳转回 restart 重新开始查找
                    } else {
                        pte = updated_pte;
                    }
#endif
                } else {
                    return TRANSLATE_FAIL;
                }
            }
            //物理地址计算
            target_ulong vpn = addr >> PGSHIFT;
            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
			//TLB 填充
            if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
                *prot |= PAGE_READ;
            }
            if ((pte & PTE_X)) {
                *prot |= PAGE_EXEC;
            }
            if ((pte & PTE_W) &&
                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
                *prot |= PAGE_WRITE;
            }
            return TRANSLATE_SUCCESS;
        }
    }
    return TRANSLATE_FAIL;
}
```

**分析：**

这是 MMU 地址翻译的核心循环：

1. **索引与读取**：根据层级提取虚拟地址索引，计算 PTE 物理地址（含 PMP 检查），读取 PTE 并提取 PPN。
2. **有效性与遍历**：若 `PTE_V` 为 0 则缺页。若 R/W/X 全 0 为目录项，更新基址继续下一级；否则为叶子节点，进入权限检查。
3. **权限检查**：验证非法权限组合（如仅写）、U/S 模式隔离（含 SUM/MXR 逻辑）、大页对齐及读写执行权限匹配。
4. **更新与生成**：检查通过后，原子更新 A/D 位。结合 PPN 和页内偏移计算物理地址（兼容大页），设置 TLB 权限 `*prot` 并返回成功。

# Lab5分支任务

与LAb2高度相似的步骤这里就不说了，我们首先查找QEMU代码（大模型之力），找到了处理ecall指令的逻辑函数`trans_ecall`,于是我们很自然地在QEMU中在这个函数的位置打了一个断点。

```
break trans_ecall
```

然后我们就停在了这个位置，又考虑到在执行ecall和sret这类汇编指令的时候，qemu进行了很关键的一步——指令翻译（TCG Translation），因此我特地关注了一下这一过程。由于在翻译缓存块TB中查询不到，故需要一次完整的翻译过程，下次执行相同 PC 范围内的指令时会直接执行缓存的本地代码，就不需要走这个翻译过程了，除非 TB 被刷新。

因此我们关注函数调用链

```
#0  trans_ecall (ctx=0x7fe0a1f7c760, 
    a=0x7fe0a1f7c660)
    at /root/qemu-4.1.1/target/riscv/insn_trans/trans_privileged.inc.c:24
#1  0x000056b530b6bd9e in decode_insn32 (
    ctx=0x7fe0a1f7c760, insn=115)
    at target/riscv/decode_insn32.inc.c:1614
#2  0x000056b530b743e6 in decode_opc (
    ctx=0x7fe0a1f7c760)
    at /root/qemu-4.1.1/target/riscv/translate.c:746
#3  0x000056b530b745f5 in riscv_tr_translate_insn (dcbase=0x7fe0a1f7c760, cpu=0x56b564c89890)
    at /root/qemu-4.1.1/target/riscv/translate.c:800
#4  0x000056b530ae6f79 in translator_loop (
    ops=0x56b5313c8420 <riscv_tr_ops>, 
    db=0x7fe0a1f7c760, cpu=0x56b564c89890, 
    tb=0x7fe09a000040 <code_gen_buffer+19>, 
    max_insns=1)
    at /root/qemu-4.1.1/accel/tcg/translator.c:95
--Type <RET> for more, q to quit, c to continue without paging--
#5  0x000056b530b74770 in gen_intermediate_code
    (cs=0x56b564c89890, 
    tb=0x7fe09a000040 <code_gen_buffer+19>, 
    max_insns=1)
    at /root/qemu-4.1.1/target/riscv/translate.c:848
#6  0x000056b530ae536a in tb_gen_code (
    cpu=0x56b564c89890, pc=8388868, cs_base=0, 
    flags=24576, cflags=-16252928)
    at /root/qemu-4.1.1/accel/tcg/translate-all.c:1738
#7  0x000056b530ae1b51 in tb_find (
    cpu=0x56b564c89890, last_tb=0x0, 
    tb_exit=0, cf_mask=524288)
    at /root/qemu-4.1.1/accel/tcg/cpu-exec.c:409
#8  0x000056b530ae245a in cpu_exec (
    cpu=0x56b564c89890)
    at /root/qemu-4.1.1/accel/tcg/cpu-exec.c:731
#9  0x000056b530a94ad6 in tcg_cpu_exec (
    cpu=0x56b564c89890)
--Type <RET> for more, q to quit, c to continue without paging--
    at /root/qemu-4.1.1/cpus.c:1435
#10 0x000056b530a9538f in qemu_tcg_cpu_thread_fn (arg=0x56b564c89890)
    at /root/qemu-4.1.1/cpus.c:1743
#11 0x000056b530f17457 in qemu_thread_start (
    args=0x56b564c9ff30)
    at util/qemu-thread-posix.c:502
#12 0x00007fe0a2894ac3 in start_thread (
    arg=<optimized out>)
    at ./nptl/pthread_create.c:442
#13 0x00007fe0a29268c0 in clone3 ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
```

我们顺次执行，可以看到tb的搜索函数

```
0x000056b530ae1b51 in tb_find (cpu=0x56b564c89890, last_tb=0x0, tb_exit=0, cf_mask=524288) at /root/qemu-4.1.1/accel/tcg/cpu-exec.c:409
409             tb = tb_gen_code(cpu, pc, cs_base, flags, cf_mask);
Value returned is $3 = (TranslationBlock *) 0x7fe09a000040 <code_gen_buffer+19>
(gdb) 
```

诶！那我们就去找这个函数，发现果然是TB相关的逻辑。

也就是执行完TB之后，由于此时触发了异常，cpu_handle_exception()函数检测到exception_index=8，从而回去调用cpu_do_interrupt()这个函数，也就是riscv_cpu_do_interrupt()这个函数。

那我们的核心就应该放在**riscv_cpu_do_interrupt()**这个函数，通过为这个函数打下断点，我们可以进入到这个函数内部：

```c++
void riscv_cpu_do_interrupt(CPUState *cs)//1.
{
#if !defined(CONFIG_USER_ONLY)
    RISCVCPU *cpu = RISCV_CPU(cs);
    CPURISCVState *env = &cpu->env;
    
    bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
    target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
    target_ulong deleg = async ? env->mideleg : env->medeleg;
    target_ulong tval = 0;

    static const int ecall_cause_map[] = {
        [PRV_U] = RISCV_EXCP_U_ECALL,
        [PRV_S] = RISCV_EXCP_S_ECALL,
        [PRV_H] = RISCV_EXCP_H_ECALL,
        [PRV_M] = RISCV_EXCP_M_ECALL
    };

    if (!async) {
        /* set tval to badaddr for traps with address information */
        switch (cause) {
        case RISCV_EXCP_INST_ADDR_MIS:
        case RISCV_EXCP_INST_ACCESS_FAULT:
        case RISCV_EXCP_LOAD_ADDR_MIS:
        case RISCV_EXCP_STORE_AMO_ADDR_MIS:
        case RISCV_EXCP_LOAD_ACCESS_FAULT:
        case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
        case RISCV_EXCP_INST_PAGE_FAULT:
        case RISCV_EXCP_LOAD_PAGE_FAULT:
        case RISCV_EXCP_STORE_PAGE_FAULT:
            tval = env->badaddr;
            break;
        default:
            break;
        }
        /* ecall is dispatched as one cause so translate based on mode */
        if (cause == RISCV_EXCP_U_ECALL) {
            assert(env->priv <= 3);
            cause = ecall_cause_map[env->priv];
        }
    }

    trace_riscv_trap(env->mhartid, async, cause, env->pc, tval, cause < 16 ?
        (async ? riscv_intr_names : riscv_excp_names)[cause] : "(unknown)");

    if (env->priv <= PRV_S &&
            cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
        /* handle the trap in S-mode */
        target_ulong s = env->mstatus;
        s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
            get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
        s = set_field(s, MSTATUS_SPP, env->priv);
        s = set_field(s, MSTATUS_SIE, 0);
        env->mstatus = s;
        env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
        env->sepc = env->pc;
        env->sbadaddr = tval;
        env->pc = (env->stvec >> 2 << 2) +
            ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
        riscv_cpu_set_mode(env, PRV_S);
    } else {
        /* handle the trap in M-mode */
        target_ulong s = env->mstatus;
        s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
            get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
        s = set_field(s, MSTATUS_MPP, env->priv);
        s = set_field(s, MSTATUS_MIE, 0);
        env->mstatus = s;
        env->mcause = cause | ~(((target_ulong)-1) >> async);
        env->mepc = env->pc;
        env->mbadaddr = tval;
        env->pc = (env->mtvec >> 2 << 2) +
            ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
        riscv_cpu_set_mode(env, PRV_M);
    }

#endif
    cs->exception_index = EXCP_NONE; /* mark handled to qemu */
}
```

我直接我就发现了最终的函数！接下来我们进行调用来看看这个函数前后两者的变化。

```bash
Thread 3 "qemu-system-ris" hit Breakpoint 2, riscv_cpu_do_interrupt (cs=0x5d8b88e64890) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:513
513         bool async = !!(cs->exception_index & RISCV_EXCP_INT_FLAG);
(gdb) p env->priv
$1 = 0
(gdb) p env->pc
$2 = 8388868
(gdb) p cs->exception
There is no member named exception.
(gdb) p cs->exception_index
$3 = 8
(gdb) p env->stvec
$4 = 18446744072637910676
(gdb) p/x env->pc
$5 = 0x800104
(gdb) p/x cs->exception_index
$6 = 0x8
(gdb) p/x env->stvec
$7 = 0xffffffffc0200e94
(gdb) p/x env->matatus
There is no member named matatus.
(gdb) p/x env->mstatus
$8 = 0x8000000000046002
```

```
(gdb) break /root/qemu-4.1.1/target/riscv/cpu_helper.c:588
Breakpoint 1 at 0x5a816d7bbac1: file /root/qemu-4.1.1/target/riscv/cpu_helper.c, line 590.
(gdb) c
Continuing.
[Switching to Thread 0x7801b95fe640 (LWP 11143)]

Thread 3 "qemu-system-ris" hit Breakpoint 1, riscv_cpu_do_interrupt (cs=0x5a816f5b5890) at /root/qemu-4.1.1/target/riscv/cpu_helper.c:590
590         cs->exception_index = EXCP_NONE; /* mark handled to qemu */
(gdb) p/x env->mstatus
$1 = 0x8000000000046020
(gdb) p/x (env->mstatus >> 8) & 1
$2 = 0x0
(gdb) p/x (env->mstatus >> 5) & 1
$3 = 0x1
(gdb) p/x (env->mstatus >> 1) & 1
$4 = 0x0
(gdb) p/x env->scause
$5 = 0x8
(gdb) p/x env->sepc
$6 = 0x800104
(gdb) p/x  env->sbadaddr
$7 = 0x0
(gdb) p/x env->pc
$8 = 0xffffffffc0200e94
(gdb) p/x
$9 = 0xffffffffc0200e94
(gdb) p/x env->priv
$10 = 0x1
```



对于sret指令，我们故技重施，只不过现在需要显示指定断点的位置

```
b kern/trap/trapentry.S:133
```

```bash
(gdb) bt
#0  trans_sret (ctx=0x7bc88dffe760, 
    a=0x7bc88dffe660)
    at /root/qemu-4.1.1/target/riscv/insn_trans/trans_privileged.inc.c:46
#1  0x000059bc0a60be76 in decode_insn32 (
    ctx=0x7bc88dffe760, insn=270532723)
    at target/riscv/decode_insn32.inc.c:1638
#2  0x000059bc0a6143e6 in decode_opc (
    ctx=0x7bc88dffe760)
    at /root/qemu-4.1.1/target/riscv/translate.c:746
#3  0x000059bc0a6145f5 in riscv_tr_translate_insn (dcbase=0x7bc88dffe760, 
    cpu=0x59bc3537d890)
    at /root/qemu-4.1.1/target/riscv/translate.c:800
#4  0x000059bc0a586f79 in translator_loop (
    ops=0x59bc0ae68420 <riscv_tr_ops>, 
    db=0x7bc88dffe760, cpu=0x59bc3537d890, 
    tb=0x7bc88e000040 <code_gen_buffer+19>, 
    max_insns=1)
    at /root/qemu-4.1.1/accel/tcg/translator.c--Type <RET> for more, q to quit, c to continue without paging--
:95
#5  0x000059bc0a614770 in gen_intermediate_code (cs=0x59bc3537d890, 
    tb=0x7bc88e000040 <code_gen_buffer+19>, 
    max_insns=1)
    at /root/qemu-4.1.1/target/riscv/translate.c:848
#6  0x000059bc0a58536a in tb_gen_code (
    cpu=0x59bc3537d890, 
    pc=18446744072637910874, cs_base=0, 
    flags=24577, cflags=-16252928)
    at /root/qemu-4.1.1/accel/tcg/translate-all.c:1738
#7  0x000059bc0a581b51 in tb_find (
    cpu=0x59bc3537d890, last_tb=0x0, 
    tb_exit=0, cf_mask=524288)
    at /root/qemu-4.1.1/accel/tcg/cpu-exec.c:409
#8  0x000059bc0a58245a in cpu_exec (
    cpu=0x59bc3537d890)
    at /root/qemu-4.1.1/accel/tcg/cpu-exec.c:731
--Type <RET> for more, q to quit, c to continue without paging--
#9  0x000059bc0a534ad6 in tcg_cpu_exec (
    cpu=0x59bc3537d890)
    at /root/qemu-4.1.1/cpus.c:1435
#10 0x000059bc0a53538f in qemu_tcg_cpu_thread_fn (arg=0x59bc3537d890)
    at /root/qemu-4.1.1/cpus.c:1743
#11 0x000059bc0a9b7457 in qemu_thread_start (
    args=0x59bc35393f30)
    at util/qemu-thread-posix.c:502
#12 0x00007bc895094ac3 in start_thread (
    arg=<optimized out>)
    at ./nptl/pthread_create.c:442
#13 0x00007bc8951268c0 in clone3 ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
```

同样的手段找到helper_sret，接下来我们就可以进行断点调试了！

打下断点break helper_sret，我们进入helper_sret函数：

```c++
target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
{
    if (!(env->priv >= PRV_S)) {
        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
    }

    target_ulong retpc = env->sepc;
    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
    }

    if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
        get_field(env->mstatus, MSTATUS_TSR)) {
        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
    }

    target_ulong mstatus = env->mstatus;
    target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
    mstatus = set_field(mstatus,
        env->priv_ver >= PRIV_VERSION_1_10_0 ?
        MSTATUS_SIE : MSTATUS_UIE << prev_priv,
        get_field(mstatus, MSTATUS_SPIE));
    mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
    mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
    riscv_cpu_set_mode(env, prev_priv);
    env->mstatus = mstatus;

    return retpc;
}
```
```bash
(gdb) break helper_sret
Breakpoint 1 at 0x5c3b9c715bb5: file /root/qemu-4.1.1/target/riscv/op_helper.c, line 76.
(gdb) c
Continuing.
[Switching to Thread 0x727028b7d640 (LWP 1153)]

Thread 3 "qemu-system-ris" hit Breakpoint 1, helper_sret (env=0x5c3ba56122a0, cpu_pc_deb=18446744072637910874) at /root/qemu-4.1.1/target/riscv/op_helper.c:76
76          if (!(env->priv >= PRV_S)) {
(gdb) p/x env->priv
$1 = 0x1
(gdb) p/x env->sepc
$2 = 0x800108
(gdb) p/x env->mstatus
$3 = 0x8000000000046020
(gdb) p/x (env->mstatus >> 8) & 1
$4 = 0x0
(gdb) p/x (env->mstatus >> 5) &
 1
$5 = 0x1
(gdb) p/x (env->mstatus >> 1) &
 1
$6 = 0x0
```

```bash
(gdb) break /root/qemu-4.1.1/target/riscv/op_helper.c:100
Breakpoint 2 at 0x5c3b9c715d90: file /root/qemu-4.1.1/target/riscv/op_helper.c, line 101.
(gdb) c
Continuing.

Thread 3 "qemu-system-ris" hit Breakpoint 2, helper_sret (env=0x5c3ba56122a0, cpu_pc_deb=18446744072637910874) at /root/qemu-4.1.1/target/riscv/op_helper.c:101
101         return retpc;
(gdb) p/x env->mstatus
$7 = 0x8000000000046002
(gdb) p/x (env->mstatus >> 8) & 1
$8 = 0x0
(gdb) p/x (env->mstatus >> 5) & 1
$9 = 0x0
(gdb) p/x (env->mstatus >> 1) & 1
$10 = 0x1
(gdb) p/x env->sepc
$11 = 0x800108
(gdb) p/x  retpc
$12 = 0x800108
(gdb) p/x  env->priv
$13 = 0x0
(gdb) 

```



