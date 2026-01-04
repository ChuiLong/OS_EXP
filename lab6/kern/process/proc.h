#ifndef __KERN_PROCESS_PROC_H__
#define __KERN_PROCESS_PROC_H__

#include <defs.h>
#include <list.h>
#include <trap.h>
#include <memlayout.h>
#include <skew_heap.h>

// process's state in his life cycle
enum proc_state
{
    PROC_UNINIT = 0,    // 未初始化
    PROC_SLEEPING,      // 睡眠
    PROC_RUNNABLE,      // 可运行（可能正在运行）
    PROC_ZOMBIE,        // 僵尸状态（等待父进程回收）
};

struct context
{
    uintptr_t ra;
    uintptr_t sp;
    uintptr_t s0;
    uintptr_t s1;
    uintptr_t s2;
    uintptr_t s3;
    uintptr_t s4;
    uintptr_t s5;
    uintptr_t s6;
    uintptr_t s7;
    uintptr_t s8;
    uintptr_t s9;
    uintptr_t s10;
    uintptr_t s11;
};

#define PROC_NAME_LEN 15
#define MAX_PROCESS 4096
#define MAX_PID (MAX_PROCESS * 2)

extern list_entry_t proc_list;

struct proc_struct
{
    enum proc_state state;              // 进程状态
    int pid;                            // 进程ID
    int runs;                           // 运行次数
    uintptr_t kstack;                   // 内核栈地址
    volatile bool need_resched;         // 是否需要重新调度
    struct proc_struct *parent;         // 父进程
    struct mm_struct *mm;               // 内存管理结构
    struct context context;             // 上下文（用于进程切换）
    struct trapframe *tf;               // 中断帧
    uintptr_t pgdir;                    // 页目录表基地址
    uint32_t flags;                     // 进程标志
    char name[PROC_NAME_LEN + 1];       // 进程名
    list_entry_t list_link;             // 进程链表
    list_entry_t hash_link;             // 进程哈希表
    int exit_code;                      // 退出码
    uint32_t wait_state;                // 等待状态
    struct proc_struct *cptr, *yptr, *optr;  // 进程树关系
    struct run_queue *rq;               // 所属运行队列
    list_entry_t run_link;              // 运行队列链表
    int time_slice;                     // 时间片
    skew_heap_entry_t lab6_run_pool;    // LAB6: 运行池入口
    uint32_t lab6_stride;               // LAB6: 当前步进值
    uint32_t lab6_priority;             // LAB6: 优先级
};

#define PF_EXITING 0x00000001 // getting shutdown

#define WT_CHILD (0x00000001 | WT_INTERRUPTED)
#define WT_INTERRUPTED 0x80000000 // the wait state could be interrupted

#define le2proc(le, member) \
    to_struct((le), struct proc_struct, member)

extern struct proc_struct *idleproc, *initproc, *current;

void proc_init(void);
void proc_run(struct proc_struct *proc);
int kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags);

char *set_proc_name(struct proc_struct *proc, const char *name);
char *get_proc_name(struct proc_struct *proc);
void cpu_idle(void) __attribute__((noreturn));

// FOR LAB6, set the process's priority (bigger value will get more CPU time)
void lab6_set_priority(uint32_t priority);

struct proc_struct *find_proc(int pid);
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf);
int do_exit(int error_code);
int do_yield(void);
int do_execve(const char *name, size_t len, unsigned char *binary, size_t size);
int do_wait(int pid, int *code_store);
int do_kill(int pid);
#endif /* !__KERN_PROCESS_PROC_H__ */
