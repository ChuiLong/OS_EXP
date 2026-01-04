/*
 * MLFQ (Multi-Level Feedback Queue) Scheduling Algorithm
 * 多级反馈队列调度算法
 * 
 * 特点：
 * - 多级优先级队列（本实现使用4级）
 * - 新进程从最高优先级队列开始
 * - 时间片用完降级到下一级队列
 * - 高优先级队列时间片短，低优先级队列时间片长
 * - 使用 lab6_stride 字段存储当前队列级别
 */

#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sched.h>

#define MLFQ_LEVELS 4                    // 队列级别数
#define MLFQ_BASE_SLICE 2                // 基础时间片

// 由于run_queue只有一个run_list，我们使用链表遍历模拟多级队列
// lab6_stride 存储进程当前所在的队列级别（0最高，3最低）

/*
 * MLFQ_init: 初始化运行队列
 */
static void
MLFQ_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->proc_num = 0;
}

/*
 * 获取指定级别的时间片
 * 级别0: 2, 级别1: 4, 级别2: 8, 级别3: 16
 */
static int
get_level_time_slice(int level)
{
    return MLFQ_BASE_SLICE << level;
}

/*
 * MLFQ_enqueue: 将进程加入队列
 * 新进程从级别0开始
 */
static void
MLFQ_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(list_empty(&(proc->run_link)));
    
    // 如果是新进程（lab6_stride未设置），从最高优先级开始
    if (proc->lab6_stride >= MLFQ_LEVELS) {
        proc->lab6_stride = 0;
    }
    
    // 设置该级别对应的时间片
    if (proc->time_slice == 0) {
        proc->time_slice = get_level_time_slice(proc->lab6_stride);
    }
    
    // 按级别顺序插入队列，保持高优先级在前
    // 遍历队列找到合适的位置
    list_entry_t *le = list_next(&(rq->run_list));
    while (le != &(rq->run_list)) {
        struct proc_struct *p = le2proc(le, run_link);
        if (p->lab6_stride > proc->lab6_stride) {
            break;
        }
        le = list_next(le);
    }
    list_add_before(le, &(proc->run_link));
    
    proc->rq = rq;
    rq->proc_num++;
}

/*
 * MLFQ_dequeue: 将进程从队列中移除
 */
static void
MLFQ_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    list_del_init(&(proc->run_link));
    rq->proc_num--;
}

/*
 * MLFQ_pick_next: 选择最高优先级队列中的第一个进程
 */
static struct proc_struct *
MLFQ_pick_next(struct run_queue *rq)
{
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);
    }
    return NULL;
}

/*
 * MLFQ_proc_tick: 时钟中断处理
 * 时间片用完后降级
 */
static void
MLFQ_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        // 时间片用完，降级到下一级队列
        if (proc->lab6_stride < MLFQ_LEVELS - 1) {
            proc->lab6_stride++;
        }
        // 设置新级别的时间片
        proc->time_slice = get_level_time_slice(proc->lab6_stride);
        proc->need_resched = 1;
    }
}

struct sched_class MLFQ_sched_class = {
    .name = "MLFQ_scheduler",
    .init = MLFQ_init,
    .enqueue = MLFQ_enqueue,
    .dequeue = MLFQ_dequeue,
    .pick_next = MLFQ_pick_next,
    .proc_tick = MLFQ_proc_tick,
};
