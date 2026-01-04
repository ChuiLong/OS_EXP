/*
 * SJF (Shortest Job First) Scheduling Algorithm
 * 短作业优先调度算法
 * 
 * 特点：
 * - 非抢占式调度
 * - 选择预计执行时间最短的进程
 * - 使用 lab6_priority 字段存储预计执行时间（值越小优先级越高）
 * - 使用斜堆实现高效的最小值查找
 */

#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sched.h>
#include <skew_heap.h>

#define SJF_TIME_SLICE 100  // 较长时间片模拟非抢占

/*
 * SJF比较函数：根据预计执行时间（存储在lab6_priority中）比较
 * 返回值：a > b 返回正数，a < b 返回负数，a == b 返回0
 */
static int
proc_sjf_comp_f(void *a, void *b)
{
    struct proc_struct *p = le2proc(a, lab6_run_pool);
    struct proc_struct *q = le2proc(b, lab6_run_pool);
    // lab6_priority 存储预计执行时间，值越小越优先
    int32_t c = p->lab6_priority - q->lab6_priority;
    if (c > 0) return 1;
    else if (c == 0) return 0;
    else return -1;
}

/*
 * SJF_init: 初始化运行队列
 */
static void
SJF_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->lab6_run_pool = NULL;
    rq->proc_num = 0;
}

/*
 * SJF_enqueue: 将进程加入优先队列
 */
static void
SJF_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    // 使用斜堆插入，按预计执行时间排序
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_sjf_comp_f);
    // 设置较长时间片
    proc->time_slice = SJF_TIME_SLICE;
    proc->rq = rq;
    rq->proc_num++;
}

/*
 * SJF_dequeue: 将进程从队列中移除
 */
static void
SJF_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_sjf_comp_f);
    rq->proc_num--;
}

/*
 * SJF_pick_next: 选择预计执行时间最短的进程
 */
static struct proc_struct *
SJF_pick_next(struct run_queue *rq)
{
    if (rq->lab6_run_pool == NULL) {
        return NULL;
    }
    // 斜堆堆顶就是最小值
    struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
    return p;
}

/*
 * SJF_proc_tick: 时钟中断处理
 */
static void
SJF_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}

struct sched_class SJF_sched_class = {
    .name = "SJF_scheduler",
    .init = SJF_init,
    .enqueue = SJF_enqueue,
    .dequeue = SJF_dequeue,
    .pick_next = SJF_pick_next,
    .proc_tick = SJF_proc_tick,
};
