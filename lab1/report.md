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

