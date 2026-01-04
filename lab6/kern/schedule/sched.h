#ifndef __KERN_SCHEDULE_SCHED_H__
#define __KERN_SCHEDULE_SCHED_H__

#include <defs.h>
#include <list.h>
#include <skew_heap.h>

#define MAX_TIME_SLICE 5

struct proc_struct;

struct run_queue;

// The introduction of scheduling classes is borrrowed from Linux, and makes the
// core scheduler quite extensible. These classes (the scheduler modules) encapsulate
// the scheduling policies.
struct sched_class
{
    // the name of sched_class
    const char *name;
    // Init the run queue
    void (*init)(struct run_queue *rq);
    // put the proc into runqueue, and this function must be called with rq_lock
    // 需要入队的进程放在调度队列的尾端
    void (*enqueue)(struct run_queue *rq, struct proc_struct *proc);
    // get the proc out runqueue, and this function must be called with rq_lock
    // 将相应的项从队列中删除即可
    void (*dequeue)(struct run_queue *rq, struct proc_struct *proc);
    // choose the next runnable task
    // 选取队列头的表项，用le2proc函数获得对应的进程控制块
    struct proc_struct *(*pick_next)(struct run_queue *rq);
    // dealer of the time-tick
    // 函数在每一次时钟中断调用。在这里，我们需要对当前正在运行的进程的剩余时间片减一
    void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc);
    /* for SMP support in the future
     *  load_balance
     *     void (*load_balance)(struct rq* rq);
     *  get some proc from this rq, used in load_balance,
     *  return value is the num of gotten proc
     *  int (*get_proc)(struct rq* rq, struct proc* procs_moved[]);
     */
};

struct run_queue
{
    list_entry_t run_list; // 进程队列，存放所有可运行的进程
    unsigned int proc_num; // 进程数量
    int max_time_slice;    // 最大时间片
    // For LAB6 ONLY
    skew_heap_entry_t *lab6_run_pool; // 优先级队列
};

void sched_init(void);  // 初始化调度器
void wakeup_proc(struct proc_struct *proc); // 将进程加入运行队列
void schedule(void); // 调度器
void sched_class_proc_tick(struct proc_struct *proc); // 调度器类的时间片处理函数
#endif /* !__KERN_SCHEDULE_SCHED_H__ */
