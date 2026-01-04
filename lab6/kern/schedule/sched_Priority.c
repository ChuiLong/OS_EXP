/*
 * Priority Scheduling Algorithm (Non-preemptive)
 * 优先级调度算法（非抢占式）
 * 
 * 特点：
 * - 非抢占式静态优先级调度
 * - lab6_priority 值越大优先级越高（与SJF相反）
 * - 使用斜堆实现高效的最大值查找
 */

#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sched.h>
#include <skew_heap.h>

#define PRIORITY_TIME_SLICE 100  // 较长时间片模拟非抢占

/*
 * 优先级比较函数：priority值大的优先级高
 * 为了使用最小堆找最大值，我们取负值比较
 */
static int
proc_priority_comp_f(void *a, void *b)
{
    struct proc_struct *p = le2proc(a, lab6_run_pool);
    struct proc_struct *q = le2proc(b, lab6_run_pool);
    // 优先级高的在前面（取负值使高优先级在堆顶）
    int32_t c = (int32_t)q->lab6_priority - (int32_t)p->lab6_priority;
    if (c > 0) return 1;
    else if (c == 0) return 0;
    else return -1;
}

/*
 * Priority_init: 初始化运行队列
 */
static void
Priority_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->lab6_run_pool = NULL;
    rq->proc_num = 0;
}

/*
 * Priority_enqueue: 将进程加入优先队列
 */
static void
Priority_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_priority_comp_f);
    proc->time_slice = PRIORITY_TIME_SLICE;
    proc->rq = rq;
    rq->proc_num++;
}

/*
 * Priority_dequeue: 将进程从队列中移除
 */
static void
Priority_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_priority_comp_f);
    rq->proc_num--;
}

/*
 * Priority_pick_next: 选择优先级最高的进程
 */
static struct proc_struct *
Priority_pick_next(struct run_queue *rq)
{
    if (rq->lab6_run_pool == NULL) {
        return NULL;
    }
    struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
    return p;
}

/*
 * Priority_proc_tick: 时钟中断处理
 */
static void
Priority_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}

struct sched_class Priority_sched_class = {
    .name = "Priority_scheduler",
    .init = Priority_init,
    .enqueue = Priority_enqueue,
    .dequeue = Priority_dequeue,
    .pick_next = Priority_pick_next,
    .proc_tick = Priority_proc_tick,
};
