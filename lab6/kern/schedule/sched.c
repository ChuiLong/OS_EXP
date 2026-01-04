#include <list.h>
#include <sync.h>
#include <proc.h>
#include <sched.h>
#include <stdio.h>
#include <assert.h>
#include <default_sched.h>
#include <sched_all.h>

// the list of timer
static list_entry_t timer_list;

static struct sched_class *sched_class;

static struct run_queue *rq;

/**
 * @brief 需要入队的进程放在调度队列的尾端
 * 
 * 该函数将指定的进程加入到调度队列中，但会排除idle进程（空闲进程）
 * 
 * @param proc 要加入调度队列的进程结构体指针
 * @return 无返回值
 */
static inline void
sched_class_enqueue(struct proc_struct *proc)
{
    // 检查进程是否为idle进程，如果不是则加入调度队列
    if (proc != idleproc)
    {
        sched_class->enqueue(rq, proc);
    }
}

static inline void
sched_class_dequeue(struct proc_struct *proc)
{
    sched_class->dequeue(rq, proc);
}

static inline struct proc_struct *
sched_class_pick_next(void)
{
    return sched_class->pick_next(rq);
}

void sched_class_proc_tick(struct proc_struct *proc)
{
    if (proc != idleproc)
    {
        sched_class->proc_tick(rq, proc);// 调用具体调度算法的 proc_tick
    }
    else
    {
        proc->need_resched = 1;// idle 进程总是需要调度
    }
}

static struct run_queue __rq;

void sched_init(void)
{
    list_init(&timer_list); // 初始化定时器列表

    // 根据sched_all.h中的CURRENT_SCHED选择调度算法
#if CURRENT_SCHED == SCHED_RR
    sched_class = &default_sched_class;
#elif CURRENT_SCHED == SCHED_STRIDE
    sched_class = &stride_sched_class;
#elif CURRENT_SCHED == SCHED_FIFO
    sched_class = &FIFO_sched_class;
#elif CURRENT_SCHED == SCHED_SJF
    sched_class = &SJF_sched_class;
#elif CURRENT_SCHED == SCHED_PRIORITY
    sched_class = &Priority_sched_class;
#elif CURRENT_SCHED == SCHED_MLFQ
    sched_class = &MLFQ_sched_class;
#else
    sched_class = &default_sched_class;
#endif

    rq = &__rq;                             // 初始化运行队列
    rq->max_time_slice = MAX_TIME_SLICE;    // 设置最大时间片
    sched_class->init(rq);                  // 调用具体调度算法的初始化函数

    cprintf("sched class: %s\n", sched_class->name);
}

// 设为 RUNNABLE 并加入调度队列
void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
        {
            proc->state = PROC_RUNNABLE;
            proc->wait_state = 0;
            if (proc != current)
            {
                sched_class_enqueue(proc);
            }
        }
        else
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}

void schedule(void)
{
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag); // 关闭中断
    {
        current->need_resched = 0;  // 清除调度标志
        
        // 如果当前进程可运行，加入调度队列
        if (current->state == PROC_RUNNABLE)
        {
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL)
        {
            sched_class_dequeue(next);
        }
        if (next == NULL)
        {
            next = idleproc;
        }
        next->runs++;
        if (next != current)
        {
            proc_run(next);
        }
    }
    local_intr_restore(intr_flag);
}
