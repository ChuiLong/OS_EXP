/*
 * FIFO (First In First Out) Scheduling Algorithm
 * 先来先服务调度算法
 * 
 * 特点：
 * - 非抢占式调度
 * - 按进程到达顺序执行
 * - 每个进程运行直到完成（在本实现中使用较长的时间片模拟）
 */

#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sched.h>

#define FIFO_TIME_SLICE 100  // 使用较长的时间片模拟非抢占

/* 
 * FIFO_init: 初始化运行队列
 */
static void
FIFO_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->proc_num = 0;
}

/*
 * FIFO_enqueue: 将进程加入队列尾部（FIFO顺序）
 */
static void
FIFO_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(list_empty(&(proc->run_link)));
    // 加入队列尾部
    list_add_before(&(rq->run_list), &(proc->run_link));
    // FIFO使用较长的时间片，模拟非抢占行为
    proc->time_slice = FIFO_TIME_SLICE;
    proc->rq = rq;
    rq->proc_num++;
}

/*
 * FIFO_dequeue: 将进程从队列中移除
 */
static void
FIFO_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    list_del_init(&(proc->run_link));
    rq->proc_num--;
}

/*
 * FIFO_pick_next: 选择队首进程（最先到达的进程）
 */
static struct proc_struct *
FIFO_pick_next(struct run_queue *rq)
{
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);
    }
    return NULL;
}

/*
 * FIFO_proc_tick: 时钟中断处理
 * FIFO理论上是非抢占的，但为了系统能正常运行，仍需处理时间片
 */
static void
FIFO_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}

struct sched_class FIFO_sched_class = {
    .name = "FIFO_scheduler",
    .init = FIFO_init,
    .enqueue = FIFO_enqueue,
    .dequeue = FIFO_dequeue,
    .pick_next = FIFO_pick_next,
    .proc_tick = FIFO_proc_tick,
};
