#ifndef __KERN_PROCESS_PROC_H__
#define __KERN_PROCESS_PROC_H__

#include <defs.h>
#include <list.h>
#include <trap.h>
#include <memlayout.h>

// process's state in his life cycle
enum proc_state
{
    PROC_UNINIT = 0, // uninitialized
    PROC_SLEEPING,   // sleeping
    PROC_RUNNABLE,   // runnable(maybe running)
    PROC_ZOMBIE,     // almost dead, and wait parent proc to reclaim his resource
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
    enum proc_state state;        // Process state
    int pid;                      // Process ID
    int runs;                     // 统计该进程被调度运行的次数
    uintptr_t kstack;             // 该进程的内核栈基址
    volatile bool need_resched;   // bool value: 进程是否需要被抢占/重新调度。调度器检查此标志决定是否切换
    struct proc_struct *parent;   // the parent process
    struct mm_struct *mm;         // 指向进程的内存管理结构 struct mm_struct
    struct context context;       // 保存进行上下文切换时需要恢复的寄存器
    struct trapframe *tf;         // 指向当前进程的 trapframe 
    uintptr_t pgdir;              // 进程页面目录/页表基址
    uint32_t flags;               // 进程标志位集合
    char name[PROC_NAME_LEN + 1]; // Process name
    list_entry_t list_link;       // Process link list，链表节点，用于把 proc 插入全局进程链表 proc_list
    list_entry_t hash_link;       // Process hash list，链表节点，用于按 pid 哈希表（hash_list[]）链接，便于按 pid 查找
};

#define le2proc(le, member) \
    to_struct((le), struct proc_struct, member)

extern struct proc_struct *idleproc, *initproc, *current;

void proc_init(void);
void proc_run(struct proc_struct *proc);
int kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags);

char *set_proc_name(struct proc_struct *proc, const char *name);
char *get_proc_name(struct proc_struct *proc);
void cpu_idle(void) __attribute__((noreturn));

struct proc_struct *find_proc(int pid);
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf);
int do_exit(int error_code);

#endif /* !__KERN_PROCESS_PROC_H__ */
