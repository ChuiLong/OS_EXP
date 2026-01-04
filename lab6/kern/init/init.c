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
#include <dtb.h>
#include <vmm.h>
#include <proc.h>
#include <kmonitor.h>

int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
    cons_init(); // init the console

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);

    print_kerninfo();                     // 打印内核信息
    dtb_init();                           // 初始化设备树
    pmm_init();                           // 初始化物理内存管理
    pic_init();                           // 初始化中断控制器
    idt_init();                           // 初始化中断描述符表
    vmm_init();                           // 初始化虚拟内存管理
    sched_init();                         // 初始化调度器
    proc_init();                          // 初始化进程管理
    clock_init();                         // 初始化时钟中断
    intr_enable();                        // 使能中断
    
    cpu_idle();                           // 进入空闲进程循环
}
