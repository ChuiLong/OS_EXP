#include <defs.h>
#include <stdio.h>
#include <string.h>
#include <console.h>
#include <kdebug.h>
#include <picirq.h>
#include <trap.h>
#include <clock.h>
#include <intr.h>
#include <pmm.h>
#include <vmm.h>
#include <proc.h>
#include <kmonitor.h>
#include <dtb.h>

int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
    dtb_init();
    cons_init(); // init the console

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);

    print_kerninfo();

    // grade_backtrace();

    // 完成物理内存管理初始化，建立空闲物理页管理机制，为后续页表建立和线程栈分配提供支持
    pmm_init(); // init physical memory management

    /*
    执行中断和异常相关的初始化工作，
    此过程涉及调用 pic_init 和 idt_init 函数，
    用于初始化处理器中断控制器（PIC）和中断描述符表（IDT），
    与之前的 lab3 中断和异常初始化工作相同
    */
    pic_init(); // init interrupt controller
    idt_init(); // init interrupt descriptor table

    // 进行虚拟内存管理机制的初始化
    /*
    在此阶段，将建立内核的页表结构，并完成内核地址空间的虚拟地址到物理地址的静态映射。
    这里仅实现基础的页表映射机制，保证虚拟内存能够正常访问，
    并不会处理缺页异常，也不涉及将页面换入或换出。
    通过这些初始化工作，系统完成了内存的虚拟化，建立了基本的内存访问机制。
    */
    vmm_init();  // init virtual memory management
    /*
    初始化进程子系统的数据结构，
    建立 idleproc（CPU 空闲进程）和 initproc（第一个内核线程/用户 init），
    并把它们放入调度表，使系统能进入调度/运行态。
    */
    proc_init(); // init process table

    clock_init();  // init clock interrupt
    intr_enable(); // enable irq interrupt

    cpu_idle(); // run idle process
}

static void
lab1_print_cur_status(void)
{
    static int round = 0;
    round++;
}
