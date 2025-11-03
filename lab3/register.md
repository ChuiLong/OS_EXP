# 本项目用到的 RISC‑V 寄存器与作用速查

本文汇总了本仓库中实际出现/使用到的寄存器及其用途，按“通用寄存器”“控制状态寄存器（CSR）”“位掩码/常量与约定”分类说明。

## 一、通用寄存器（GPR，x0–x31，ABI 名称）

- x0 zero
  - 恒为 0。仅为保持 trapframe 布局，会在保存时写入对应槽位。
- x1 ra（Return Address）
  - 函数返回地址。trap 入口保存，返回前恢复。
- x2 sp（Stack Pointer）
  - 栈指针。进入陷入时在 SAVE_ALL 前先把“旧 sp”暂存到 sscratch，然后分配 trapframe 空间再保存其他寄存器；返回前最后恢复。
- x3 gp（Global Pointer）、x4 tp（Thread Pointer）
  - 全局/线程指针。统一在陷入时保存恢复。
- x5–x7 t0–t2、x28–x31 t3–t6（Temporaries）
  - 临时寄存器。在 entry.S、trapentry.S 中大量用于地址计算/搬运（如 t0/t1 计算 satp、页表、栈地址）。
- x8 s0/fp–x9 s1、x18–x27 s2–s11（Saved）
  - 被调用者保存寄存器。SAVE_ALL/RESTORE_ALL 统一处理。s0 在入口用来接回 sscratch 中保存的旧 sp。
- x10–x17 a0–a7（Arguments/Return）
  - 函数参数/返回值：
  - 在 trapentry.S 中用 a0 传递 trapframe 指针给 C 函数 trap(tf)。
  - 在 libs/sbi.c 中用于 SBI 调用约定：
    - a7(x17)=sbi_type，a0(x10)/a1(x11)/a2(x12)=参数，返回值在 a0(x10)。

## 二、控制状态寄存器（CSR）

- sstatus（Supervisor Status）
  - 总览：S 态全局状态。
  - 本项目使用的关键位：
    - SIE：S 态中断“总开关”。intr_enable() 置 1 放行、intr_disable() 清 0 屏蔽。硬件在陷入时会自动清 SIE，sret 按 SPIE 恢复。
    - SPIE：记住陷入前 SIE 的状态，sret 时用于恢复。
    - SPP：记住陷入前特权级（0=U，1=S）。trap_in_kernel(tf) 通过 tf->status 的 SPP 位判断是否来自内核态。
- sie（Supervisor Interrupt Enable）
  - 中断“分开关”。按来源单独使能：
    - 代码中 set_csr(sie, MIP_STIP) 打开“定时器中断来源”（STIE）。
- stvec（Supervisor Trap Vector Base Address）
  - 陷入入口地址。idt_init 中 write_csr(stvec, &__alltraps) 设置统一入口（Direct 模式）。
- sscratch
  - 供陷入入口使用的临时存储。__alltraps 进来先把旧 sp 放进去，随后再读回到 s0 用于保存/恢复原始 sp。
- sepc（Supervisor Exception PC）
  - 陷入前的 PC。保存到 trapframe，RESTORE_ALL 时写回；异常处理里（非法指令/断点）会根据指令长度前移 epc 实现“跳过”。
- scause
  - 陷入原因。最高位为“中断标志”，其余位为异常/中断号。trap.c 中通过 (tf->cause<<1)>>1 抹掉最高位再 switch 分发。
- stval（又名 sbadaddr，Trap Value）
  - 附加的异常相关值。保存为 trapframe.badvaddr；在异常处理里用其低两位判断指令长度（压缩/非压缩）。
- satp（Supervisor Address Translation and Protection）
  - 地址转换控制。entry.S 中设置 MODE=Sv39，并写入页表物理页号，随后 sfence.vma 刷新 TLB。
- time（rdtime/rdtimeh）
  - 只读时间计数器。clock.c 的 get_cycles() 读取它；配合 SBI set_timer 形成时钟中断节拍。
- 相关指令（非寄存器，但与上面配套）
  - sret：从 S 态 trap 返回，按 sepc/sstatus 恢复。
  - sfence.vma：刷新 TLB（启用分页后）。

## 三、位掩码/常量与约定（用于 CSR/编码）

- SSTATUS_SIE
  - sstatus 寄存器的 SIE 位掩码。用于 set_csr/clear_csr 操作“中断总开关”。
- MIP_STIP
  - 用作 sie 的位掩码，打开 STIE（允许“定时器中断来源”）。时间到时硬件会在 sip 中置位 STIP 表示“有定时器中断待处理”。
- IRQ_*（中断号，trap.h/编码）
  - IRQ_S_TIMER 等，用于根据 scause 分发中断类型。你的 interrupt_handler 在 IRQ_S_TIMER 分支里续约并统计 ticks。
- CAUSE_*（异常号，trap.h/编码）
  - CAUSE_ILLEGAL_INSTRUCTION、CAUSE_BREAKPOINT 等，用于 exception_handler 分支处理。

## 四、这些寄存器在项目中的“闭环用法”

- 设入口：stvec=__alltraps，sscratch=0（idt_init）。
- 开分闸：sie|=STIE（定时器来源），clock_set_next_event() 通过 SBI 预约下一次时间点。
- 开总闸：sstatus.SIE=1（intr_enable）。
- 触发与续约：time 达到预约值→硬件置位 STIP→进入 __alltraps 保存 gpr/sstatus/sepc/stval/scause→trap()：
  - IRQ_S_TIMER 分支中 ticks++、每 100 次 print_ticks()、并再次 clock_set_next_event() 续约。
- 返回：更新后的 epc/status 写回，RESTORE_ALL 恢复通用寄存器，sret 返回。

## 五、与 trapframe 的字段对应关系

- gpr 内含 zero/ra/sp/…/t6 共 32 个通用寄存器的快照。
- status ↔ sstatus，epc ↔ sepc，badvaddr ↔ stval，cause ↔ scause。
- 汇编的 SAVE_ALL/RESTORE_ALL 与 struct trapframe 的字段布局一一对应，顺序不可随意更改。

