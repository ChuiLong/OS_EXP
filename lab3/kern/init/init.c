#include <clock.h>
#include <console.h>
#include <defs.h>
#include <intr.h>
#include <kdebug.h>
#include <kmonitor.h>
#include <pmm.h>
#include <stdio.h>
#include <string.h>
#include <trap.h>
#include <dtb.h>

int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
    dtb_init();
    cons_init();  // init the console
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);

    print_kerninfo();

    // grade_backtrace();
    idt_init();  // init interrupt descriptor table

    pmm_init();  // init physical memory management

    idt_init();  // init interrupt descriptor table

    // LAB3 CHALLENGE3: 测试异常处理
    cprintf("\n========== Testing Exception Handlers ==========\n");
    
    // 测试1: 触发断点异常 (ebreak)
    cprintf("\n--- Test 1: Triggering breakpoint exception ---\n");
    asm volatile("ebreak");
    cprintf("Breakpoint exception handled successfully!\n");
    
    // 测试2: 触发非法指令异常
    cprintf("\n--- Test 2: Triggering illegal instruction exception ---\n");
    // 使用一个标准的非法32位指令 (低2位为11，表示32位指令格式)
    // 0xFFFFFFFF 是一个保留的非法指令编码
    asm volatile(".word 0xFFFFFFFF");
    cprintf("Illegal instruction exception handled successfully!\n");
    
    cprintf("\n========== Exception Tests Completed ==========\n\n");

    cprintf("\n--- Test 3: Triggering illegal instruction exception ---\n");
    // 使用一个标准的非法32位指令 (低2位为11，表示32位指令格式)
    // 0xFFFFFFFF 是一个保留的非法指令编码
    asm volatile(".word 0x00000000");
    cprintf("Illegal instruction exception handled successfully!\n");
    
    cprintf("\n========== Exception Tests Completed ==========\n\n");
    clock_init();   // init clock interrupt
    intr_enable();  // enable irq interrupt

    /* do nothing */
    while (1)
        ;
}

/*
这里添加了测试代码和字符串常量！这些额外的代码和字符串会增加 .rodata 和 .text 段的大小，
导致后续的 .data 和 .bss 段向后移动，最终影响 boot_page_table_sv39 的地址。
*/


void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
    mon_backtrace(0, NULL, NULL);
}

void __attribute__((noinline)) grade_backtrace1(int arg0, int arg1) {
    grade_backtrace2(arg0, (uintptr_t)&arg0, arg1, (uintptr_t)&arg1);
}

void __attribute__((noinline)) grade_backtrace0(int arg0, int arg1, int arg2) {
    grade_backtrace1(arg0, arg2);
}

void grade_backtrace(void) { grade_backtrace0(0, (uintptr_t)kern_init, 0xffff0000); }

