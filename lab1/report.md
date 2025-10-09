# 操作系统
# 练习解答
## 练习1：理解内核启动中的程序入口操作
### 题目描述
阅读 kern/init/entry.S内容代码，结合操作系统内核启动流程，说明指令 la sp, bootstacktop 完成了什么操作，目的是什么？ tail kern_init 完成了什么操作，目的是什么？
```c
#include <mmu.h>
#include <memlayout.h>

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    la sp, bootstacktop

    tail kern_init

.section .data
    # .align 2^12
    .align PGSHIFT
    .global bootstack
bootstack:
    .space KSTACKSIZE
    .global bootstacktop
bootstacktop:
```
### 问题解答
我们首先完整分析一下这个文件做了什么，这个文件需要结合其他文件一起阅读,才能明白其实际的意义。我们知道加载一个操作系统到内核上必须要首先通过bootloader加载OpenSBI，随后OpenSBI会加载内存镜像，那么此时在程序编写时必须要经过一个链接的过程，告诉链接器并最终让 OpenSBI 跳转，我们的内核入口在哪里、各段应该放到什么地址。通常通过链接脚本把入口符号设置为 ENTRY(kern_entry)，并按内核的虚拟内存布局（见 memlayout.h）把 .text/.data/.bss 等段放到期望的内核地址区间。OpenSBI 将内核镜像加载到物理内存后，在 S 模式把控制权转交给 kern_entry。于是我们查找kernel.ld文件，可以知道kern_entry是整个内核的入口。

接下来我们先逐行分析一下这份代码：
首先引入的两个库是让汇编文件走 C 预处理器（CPP），把两个头文件里的常量与宏（如 PGSHIFT、KSTACKSIZE、PGSIZE 等）引进来。这是因为后面要用到页大小相关的位数 PGSHIFT 和内核栈大小 KSTACKSIZE，这些通常定义在内存布局相关的头文件里，保持与 C 端一致。

接下来，由于下面是需要执行的代码，因此代码首先切换到 .text 段，并给这个段打上 ELF 标志："a"（alloc，可装载到内存），"x"（executable，可执行）。%progbits 表示该段是程序内容而非符号/重定位等。

随后，把符号 kern_entry 导出为全局可见，并定义了一个标签作为真正的入口。链接脚本通常会 ENTRY(kern_entry)，OpenSBI（或上一级引导）把控制权移交到这个符号。

接下来，我们跳过要分析的两句，分析数据段的代码。首先切到 .data 段，下面要放可写的全局数据（这里用于预留栈空间）。随后按 PGSHIFT 做$2^{PGSHIFT}$ 的对齐。GAS 在 RISC-V 上的 .align 等价于 .p2align，让后续的 bootstack 页对齐，保证栈跨页时不至于踩到奇怪的边界，也便于页表映射/保护。导出符号 bootstack，并在此打标签，表示“栈区的起始地址”。在当前段保留 KSTACKSIZE 字节的空间（内容默认清零/由加载器置零，视段而定）。导出 bootstacktop，并在 .space 之后打标签，等价于“bootstack + KSTACKSIZE”这个地址——即这块预留区的末尾，根据语义我们可以推知这个变量表示栈顶。

好了，有了上面的这些前置分析，我们就可以分析下面的两句代码了。
### 问题解答： la sp, bootstacktop
#### 做了什么：

la 是加载地址（load address）的伪指令，会被展开成取符号地址的指令序列（通常是 auipc + addi），把标签 bootstacktop 的绝对地址装入寄存器。sp 是 RISC-V ABI 规定的栈指针寄存器（x2）。把 bootstacktop 的地址放进 sp，等价于把内核的初始栈指针设置到 Boot 栈的顶部。我们从此处就可以知道我们对于这个变量的推断是正确的。

#### 目的：
在进入 C 代码之前建立一个可用且对齐良好的内核栈，确保后续 C 函数（包括 kern_init）的调用、保存返回地址、压栈/出栈等都能正常进行；如果不先设栈，任何函数调用或局部变量访问都会崩溃。

### 问题解答： tail kern_init
#### 做了什么：
tail 是 RISC-V 的尾调用伪指令，效果等价于无返回跳转到目标符号相当于 jal x0, kern_init 或“j kern_init”的可重定位形式，跳转到 kern_init，不写入返回地址寄存器 ra（x1），因此无法返回到 kern_entry。这与普通的 call（会写 ra）不同，tail 不会创建新的调用层级/返回路径。

#### 目的：

明确表明启动入口不会返回；kern_entry 完成最小初始化（建立栈）后，直接把控制权永久移交给 C 语言的内核主初始化函数 kern_init。由于没有返回，就不需要为 kern_entry 保留调用帧/保存 ra，更省栈、更简洁；避免以后误走回 kern_entry 的路径，符合“只前进不后退”的单向启动流程语义。

从启动流程角度：在设置好栈之后，通过尾跳转进入 kern_init，随后 kern_init 会完成更高层次的初始化（如控制台初始化、内存管理/页表建立、异常向量/中断启用、调度器/进程子系统等），最终进入内核的主循环/第一个进程。tail 确保这一步是最后一级的跳转。
## 练习2: 使用GDB验证启动流程

### 题目描述
为了熟悉使用 QEMU 和 GDB 的调试方法，请使用 GDB 跟踪 QEMU 模拟的 RISC-V 从加电开始，直到执行内核第一条指令（跳转到 0x80200000）的整个过程。通过调试，请思考并回答：RISC-V 硬件加电后最初执行的几条指令位于什么地址？它们主要完成了哪些功能？请在报告中简要记录你的调试过程、观察结果和问题的答案。

### 问题解答
使用GDB来调试操作系统内核不是一件容易的事，但是我们可以通过使用GDB调试QEMU来达到调试那个虚拟CPU的效果。因此此时我们需要启动两个东西：一个是GDB调试工具，另一个就是QEMU。启动这两个工具的代码可以见Makefile，这里我们简要分析一下两个指令。
qemu 目标有前置依赖：\$(UCOREIMG)（即 bin/ucore.img）,\$(SWAPIMG)、\$(SFSIMG)（这两个变量在当前文件里没定义→等价于空，不会触发任何动作），所以 make qemu = 先生成 bin/ucore.img ，然后启动 QEMU。

`UCOREIMG := $(call totarget,ucore.img)`，通常会展开到 `bin/ucore.img`。它的规则是：

```make
$(UCOREIMG): $(kernel)
	$(OBJCOPY) $(kernel) --strip-all -O binary $@
```

也就是：**先生成 `kernel` 可执行文件**，再用 `objcopy` 把它剥离成**纯二进制镜像** `ucore.img`。

`kernel` 的规则：

```make
$(kernel): tools/kernel.ld
$(kernel): $(KOBJS)
	$(LD) $(LDFLAGS) -T tools/kernel.ld -o $@ $(KOBJS)
	@$(OBJDUMP) -S $@ > obj/kernel.asm
	@$(OBJDUMP) -t $@ | sed ... > obj/kernel.sym
```

* **输入**：

  * `tools/kernel.ld`（链接脚本，决定段布局/入口等）
  * `$(KOBJS)`（把源码编成的一堆 `.o`）
* **动作**：

  1. 用 `riscv64-unknown-elf-ld` **链接**出 `bin/kernel`（带 `--gc-sections` 丢弃未引用段）；
  2. 用 `objdump -S` 生成**反汇编**到 `obj/kernel.asm`；
  3. 用 `objdump -t` 生成**符号表**到 `obj/kernel.sym`。
* **关键链接选项**：`-m elf64lriscv -nostdlib --gc-sections -T tools/kernel.ld`



* 上面通过

  ```make
  KINCLUDE += kern/debug/ kern/driver/ kern/trap/ kern/libs/ kern/mm/ kern/arch/
  KSRCDIR  += kern/init kern/debug kern/libs kern/driver kern/trap kern/mm
  LIBDIR   += libs
  ```

  再用 `$(call add_files_cc, ...)` 把这些目录下的 `*.c`/`*.S` 都纳入编译。
* 编译器与参数：

  * `CC = riscv64-unknown-elf-gcc`
  * **CFLAGS（核心）**：

    * `-mcmodel=medany`（RISC-V 位置无关/中等地址模型，便于高/低地址混合访问）
    * `-std=gnu99 -Werror -Wall -O2`
    * `-nostdinc`（不用系统头），`-fno-builtin`（不隐式内建函数）
    * `-fno-stack-protector`（禁用栈保护 canary，方便早期内核）
    * `-ffunction-sections -fdata-sections`（配合链接时 `--gc-sections` 清掉没用的段）
    * `-g`（带符号，便于调试）
  * 头文件搜索路径：`-I libs -I kern/debug ... -I kern/arch/`（通过 `KINCLUDE/INCLUDE` 叠加）

* `$(OBJCOPY) bin/kernel --strip-all -O binary bin/ucore.img`
* 得到**没有 ELF 头**的纯二进制镜像，适合直接放进内存被固件/引导代码跳转执行。


生成好 `bin/ucore.img` 后，才会执行 `qemu` 目标里的命令：

```make
$(QEMU) \
  -machine virt \
  -nographic \
  -bios default \
  -device loader,file=$(UCOREIMG),addr=0x80200000
```

逐项解释：

* `-machine virt`
  选择通用的 RISC-V 虚拟开发板（有 UART、PLIC、CLINT、DRAM 等标准外设），内存基址通常是 `0x8000_0000`。
* `-nographic`
  不开图形显示，所有串口/调试信息走 **stdio**（终端）。
* `-bios default`
  使用 QEMU 自带的 OpenSBI 固件（M 模式运行，初始化硬件，最终把控制权交给 S 模式的“payload”）。
* `-device loader,file=bin/ucore.img,addr=0x80200000`
  让 QEMU 在启动时**把你的裸镜像直接拷贝到物理内存地址 `0x8020_0000`**。

  * 这和 `-kernel` 类似但更“原始”：它**不加 ELF 解析**，就按你给的地址放数据。
  * 在 `-bios default`（OpenSBI）下，OpenSBI 的“跳转固件”（fw\_jump）会把 S 模式入口设到一个常见约定地址（通常就是你放内核镜像的 `0x8020_0000` 一带），从而跳入你的 `kern_entry`。
  * 因为你的链接脚本 `tools/kernel.ld` 会把内核的起始虚/物理地址也放在这一带，二者一致，就能**无缝开跑**。

> 如果改用被注释掉的那行：
> `# $(QEMU) -kernel $(UCOREIMG) -nographic`
> 则由 QEMU 解析 `ucore.img`（但它是纯 binary，不是 ELF），通常需要 `-bios`/`-machine` 的搭配更明确地告诉 QEMU/固件怎么跳。当前写法用 `-device loader + addr` 是最可控的。

在这一步完成后，我们会在目录看到：

* `bin/kernel`：已链接的 RISC-V ELF 内核（带符号，便于 `gdb`/`objdump`）
* `bin/ucore.img`：纯二进制镜像（喂给 QEMU 放到内存）
* `obj/*.o`：各个源文件编译后的目标文件
* `obj/kernel.asm`：`objdump -S` 的反汇编（源码/汇编交叉）
* `obj/kernel.sym`：符号表（方便定位 `kern_entry`、`kern_init` 等）

但是，由于使用这个会直接运行全部代码，因此我们需要调整一下，使用 `make debug`，这条指令和 `qemu` 相同，但追加 `-s -S`（在 1234 端口开 gdb stub，并在 CPU 启动前暂停）。我们最终使用这个用于调试。


接下来分析make gdb，它的目标定义很简单：

```make
gdb:
	riscv64-unknown-elf-gdb \
    -ex 'file bin/kernel' \
    -ex 'set arch riscv:rv64' \
    -ex 'target remote localhost:1234'
```

等价于在终端执行一条命令，启动交叉版 GDB，并预置三条启动脚本（`-ex`）：

1. `file bin/kernel`

   * **加载可执行文件与符号表**。
   * 用 ELF（`bin/kernel`）里的符号/行号做源码级调试（`break kern_entry`、`break kern_init` 等都可用）。
   * 注意：**不是**把程序“加载进 QEMU”，只是让 GDB 知道符号和调试信息。

2. `set arch riscv:rv64`

   * **显式设定目标架构**为 RISC-V 64 位，避免多架构 GDB 误判/警告。
   * 有了它，反汇编/寄存器视图等都会按 RV64 指令集解码。

3. `target remote localhost:1234`

   * **连接远程目标**：通过 TCP 连接到本机 `:1234` 的 GDB stub。
   * 这个 stub 是由 QEMU 在加了 `-s`（等价于 `-gdb tcp::1234`）时提供的。
   * 连接成功后，GDB 就能读写目标寄存器/内存、下断点、单步等。

`make gdb` 只是把“GDB 侧”准备好并连上 1234 端口的调试目标；真正让 QEMU 开启调试端口、并停在第一条指令处，需要配合 `make debug`。

接下来我们来正式调试对应的内核，看从加载完OPENSBI到进入内核前操作系统到底做了什么操作。


## 任务二

以下是我们认为本次实验中重要的几个知识点：

#### 1. 操作系统启动流程 (Bootstrapping)

*   **实验中的体现**:
    *   entry.S: 这是内核的入口点。它首先设置了初始的内核栈指针 `sp` 指向 `bootstacktop`，然后直接跳转到 C 语言的 `kern_init` 函数。
    *   init.c: `kern_init` 函数是 C 代码的起点。它首先清理了 BSS 段（未初始化的全局变量），然后调用 `cprintf` 打印启动信息。
*   **对应的OS原理**:
    *   **操作系统引导 (OS Booting)**: 任何 OS 都需要一个引导过程。通常由 Bootloader 将内核加载到内存，然后跳转到内核的入口点。本实验简化了这个过程，直接从内核入口 `kern_entry` 开始。
*   **理解与分析**:
    *   **关系**: 实验中的 entry.S 和 `kern_init` 是 OS 引导过程在内核阶段的微观实现。它展示了从机器相关的汇编代码（设置栈）过渡到高级语言（C函数）的关键一步。
    *   **差异**: 完整的 OS 引导过程要复杂得多，涉及 BIOS/UEFI、Bootloader（如 GRUB）等多个阶段。本实验聚焦于内核自身初始化的第一步，省略了前面的加载过程。

#### 2. SBI (Supervisor Binary Interface)

*   **实验中的体现**:
    *   sbi.h 和 sbi.c: 定义了 SBI 调用的接口和实现。`sbi_call` 函数通过 `ecall` 指令触发一次到 M-Mode (Machine Mode) 的陷入，请求底层固件的服务。
    *   `sbi_console_putchar` 函数就是一个具体的例子，它通过 SBI 调用来在控制台输出一个字符。这是上层 `cprintf` 函数最终依赖的底层输出能力。
*   **对应的OS原理**:
    *   **系统调用 (System Call)** 和 **特权级 (Privilege Levels)**: OS 原理中，用户程序通过系统调用（如 `int 0x80` 或 `syscall` 指令）陷入内核态，请求内核服务。这是一种跨越特权级的通信方式。
*   **理解与分析**:
    *   **关系**: SBI 调用和系统调用在机制上高度相似。它们都是通过特定的“陷入 (trap)”指令，从一个较低的特权级向一个较高的特权级请求服务。在 RISC-V 中，内核运行在 S-Mode (Supervisor Mode)，它通过 `ecall` 请求 M-Mode 固件的服务；而用户程序未来也会通过 `ecall` 请求 S-Mode 内核的服务。
    *   **差异**:
        *   **通信双方不同**: SBI 是 **内核 (S-Mode) 到 监视器/固件 (M-Mode)** 的通信。而常规的系统调用是 **用户程序 (U-Mode) 到 内核 (S-Mode)** 的通信。
        *   **目的不同**: SBI 的目的是让内核能使用硬件相关的底层功能（如电源管理、多核中断、控制台IO）。系统调用的目的是让应用程序能使用操作系统提供的抽象服务（如文件系统、进程管理）。

#### 3. 内核态的格式化输出

*   **实验中的体现**:
    *   printfmt.c: 实现了 `vprintfmt` 核心格式化逻辑，支持 `%d`, `%s`, `%x` 等多种格式。
    *   stdio.c: 基于 printfmt.c 封装了 `cprintf` 函数，将其输出目标设定为控制台（通过 `cputch` -> `cons_putc` -> `sbi_console_putchar`）。
*   **对应的OS原理**:
    *   **I/O 子系统** 和 **分层设计**: 操作系统通过分层的驱动程序和接口来管理复杂的 I/O 设备。上层应用使用统一的接口（如 `printf`），而底层驱动负责与具体硬件交互。
*   **理解与分析**:
    *   **关系**: 实验中的 `cprintf` -> `vprintfmt` -> `cputch` -> `sbi_console_putchar` 的调用链完美地展示了分层设计的思想。`cprintf` 提供了高级、易用的接口，而 `sbi_console_putchar` 负责与“硬件”（此处为 M-Mode 固件）打交道，中间各层负责不同的抽象。
    *   **差异**: 实验中实现的是一个简化的、内核专用的 `printf`，它不能在用户态直接使用，并且直接输出到物理控制台。而通用 OS 中的 `printf` 是标准库函数，它通过系统调用将数据写入内核，再由内核根据文件描述符决定输出到控制台、文件还是管道等。

#### 4. 初始内存布局

*   **实验中的体现**:
    *   memlayout.h: 定义了内核栈的大小 `KSTACKSIZE`。
    *   entry.S: 在 `.data` 段中分配了 `KSTACKSIZE` 大小的 `bootstack`，并将栈顶设置为 `bootstacktop`。
    *   init.c: `memset(edata, 0, end - edata)` 这行代码清空了 BSS 段。`edata` 和 `end` 是链接器脚本定义的符号，分别代表已初始化数据段的结束和整个内核镜像的结束。
*   **对应的OS原理**:
    *   **进程/内核内存映像 (Memory Image)**: 一个程序（包括内核本身）在加载到内存时，其地址空间会被划分为代码段 (.text)、数据段 (.data)、BSS 段 (.bss)、栈 (stack)、堆 (heap) 等区域。
*   **理解与分析**:
    *   **关系**: 实验中的代码是对 OS 原理中内存映像概念的直接实践。设置栈、清空 BSS 段都是内核为了正确运行而必须执行的内存初始化步骤。
    *   **差异**: 这只是内核最最原始的静态内存布局。一个完整的 OS 很快会建立复杂的动态内存管理机制（如伙伴系统、slab 分配器）和虚拟内存管理（页表），来为进程和内核自身动态分配和管理内存。当前的布局只是万里长征的第一步。

## 任务三

### 1.上下文切换

上下文（Context）中包含了进程运行状态相关的信息，包括寄存器、CPU的状态、内存地址空间。

PCB：管理进程的数据结构，保存进程的运行状态，如进程的PC、CPU的寄存器值、进程的优先级、进程的调度状态、进程的资源使用情况等。

#### 1.1 上下文切换的概念

上下文切换（Context Switch）是操作系统在运行多任务时，为了在多个任务之间切换执行而进行的操作。它涉及到保存当前任务的执行状态，并加载下一个任务的执行状态。上下文切换通常发生在以下几种情况：任务调度、中断处理、系统调用等。

#### 1.2 上下文切换的步骤

1. 保存当前进程1状态到PCB中。
2. 从进程2的PCB中加载进程2的运行状态。
3. 执行进程2的指令。
4. 保存进程2状态到PCB中。
5. 从进程1的PCB中恢复进程1的运行状态。
6. 执行进程1的指令。

### 2.进程调度

在上面的上下文切换中，我们通过将运行中的进程保存到PCB中，并切换到下一个进程的运行状态，实现了进程的切换。那么现在我们就会面临一个问题，当许多程序在运行时，我们在中断了原来的进程之后，操作系统内核中的调度器 (Scheduler) 会如何选择下一个进程进行运行呢？

#### 2.1 五状态模型
**状态**：创建、就绪、等待、运行、退出
创建：进程创建时，操作系统会为进程分配资源，并创建进程控制块（PCB）并保存进程信息。
就绪：进程创建成功后，操作系统会将进程加入就绪队列，等待CPU调度。
等待：进程等待某个事件发生，如文件I/O、网络I/O、设备I/O等。
运行：进程开始执行，CPU开始调度进程。
退出：进程执行完毕，操作系统会回收进程所占用的资源，并删除进程控制块。

#### 2.2 挂起进程模型
某进程长时间不能运行可以换至外存——就是挂起状态
1. 单挂起模型
**状态**：创建、就绪、阻塞、挂起、运行、退出
与五状态模型相比，单挂起模型增加了挂起状态。当进程处于挂起状态时，操作系统会将进程从内存中移除，并将其保存到外存中。当进程被唤醒时，操作系统会将进程从外存中加载到内存中，并将其状态设置为就绪状态。

2. 双挂起模型
**状态**：创建、就绪、阻塞、阻塞挂起、就绪挂起、就绪、运行、退出
双挂起模型在单挂起模型的基础上，进一步细化了挂起状态。它将挂起状态分为阻塞挂起和就绪挂起两种状态。

+ 当一个在内存中的阻塞进程因为内存紧张被换出时，它进入“阻塞挂起”状态，此时它位于外存。

- 如果这个处于“阻塞挂起”的进程，它所等待的事件完成了，它的状态就会变为“就绪挂起”，但它依然停留在外存。

* “就绪挂起”状态的进程，表明它已经准备好运行，只等待被换入内存。

+ 当操作系统有空闲内存时，会将“就绪挂起”的进程换入内存，此时它的状态就变成了“就绪”，可以等待被调度器选中并在CPU上运行。

### 3.进程调度算法

#### 3.1 先来先服务（FCFS）

先来先服务（First Come First Serve，FCFS）调度算法是一种简单的进程调度算法，它按照进程到达的顺序来调度进程。也就是说，先到达的进程先被调度执行，后到达的进程后执行。

#### 3.2 短进程优先（SPN）

短进程优先（Shortest Process Next，SPN）调度算法是一种进程调度算法，它按照进程执行时间长短来调度进程。也就是说，执行时间最短的进程优先被调度执行。

#### 3.3 最高响应比优先（HRRN）

最高响应比优先（Highest Response Ratio Next，HRRN）调度算法是一种进程调度算法，它根据进程的响应比来调度进程。响应比 = (等待时间 + 要求服务时间) / 要求服务时间。响应比越高的进程优先被调度执行。

#### 3.4 时间片轮转（RR）

时间片轮转（Round Robin，RR）调度算法是一种进程调度算法，它按照进程到达的顺序来调度进程，并为每个进程分配一个固定的时间片。当一个进程的时间片用完时，操作系统会将其从就绪队列中移除，并将其加入等待队列。然后，操作系统会从等待队列中选择下一个进程进行调度执行。

#### 3.5 多级队列调度（MQ）

多级队列调度（Multilevel Queue，MQ）是一种进程调度算法，它将进程按照优先级划分为多个队列，并使用不同的调度算法来调度每个队列中的进程。

#### 3.6 多级反馈队列调度（MLFQ）

多级反馈队列调度（Multilevel Feedback Queue，MLFQ）是一种进程调度算法，它将进程按照优先级划分为多个队列，并使用不同的调度算法来调度每个队列中的进程。

与多级队列调度不同的是，MLFQ算法允许进程在队列之间移动。当一个进程在一个队列中等待的时间过长时，操作系统会将该进程移动到下一个队列中。

#### 3.7 优先级调度（Priority）
1. 静态优先级调度
静态优先级调度算法是一种进程调度算法，它根据进程的优先级来调度进程。进程的优先级越高，越优先被调度执行。
静态优先级调度算法的优点是，它可以避免进程的饿死问题。
静态优先级调度算法的缺点是，如果一个进程的优先级过高，可能会导致其他进程被饿死。
2. 动态优先级调度
动态优先级调度算法是一种进程调度算法，它根据进程的实际运行情况来动态调整进程的优先级。
动态优先级调度算法的优点是，它可以避免进程的饿死问题。
缺点是，动态优先级调度算法需要额外的资源来维护进程的优先级信息。







