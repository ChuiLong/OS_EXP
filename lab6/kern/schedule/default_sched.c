#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <default_sched.h>

/*
 * RR_init initializes the run-queue rq with correct assignment for
 * member variables, including:
 *
 *   - run_list: should be an empty list after initialization.
 *   - proc_num: set to 0
 *   - max_time_slice: no need here, the variable would be assigned by the caller.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
static void
RR_init(struct run_queue *rq)
{
    // LAB6: 孙沐赟：2311534
    list_init(&(rq->run_list)); // 初始化运行队列链表
    rq->proc_num = 0;           // 进程数量初始化为0
}

/*
 * RR_enqueue inserts the process ``proc'' into the tail of run-queue
 * ``rq''. The procedure should verify/initialize the relevant members
 * of ``proc'', and then put the ``run_link'' node into the queue.
 * The procedure should also update the meta data in ``rq'' structure.
 *
 * proc->time_slice denotes the time slices allocation for the
 * process, which should set to rq->max_time_slice.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
/**
 * @brief 将进程加入到运行队列中
 * 
 * @param rq 运行队列指针，指向要加入的运行队列
 * @param proc 进程结构体指针，指向要加入队列的进程
 * 
 * @return 无返回值
 */
static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 孙沐赟：2311534
    // 确保进程的运行链表项为空，即进程当前不在任何运行队列中
    assert(list_empty(&(proc->run_link)));
    // 将进程添加到运行队列的链表中
    list_add_before(&(rq->run_list), &(proc->run_link));
    // 检查并设置进程的时间片
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice)
    {
        // 如果时间片为0或大于最大时间片，则设置时间片为最大时间片
        proc->time_slice = rq->max_time_slice;
    }
    // 设置进程所属的运行队列
    proc->rq = rq;
    // 增加运行队列中的进程数量计数
    rq->proc_num++;
}

/*
 * RR_dequeue removes the process ``proc'' from the front of run-queue
 * ``rq'', the operation would be finished by the list_del_init operation.
 * Remember to update the ``rq'' structure.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
/**
 * @brief 从运行队列中移除指定进程
 * 
 * 该函数将指定的进程从运行队列中出队，更新队列中的进程数量
 * 
 * @param rq 运行队列指针，指向要操作的运行队列
 * @param proc 进程结构体指针，指向要从队列中移除的进程
 * @return 无返回值
 */
static void
RR_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 孙沐赟：2311534
    // 检查进程的运行链表不为空且进程确实属于当前运行队列
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    // 从链表中删除进程节点并初始化链表节点
    list_del_init(&(proc->run_link));
    // 减少运行队列中的进程数量计数
    rq->proc_num--;
}

/*
 * RR_pick_next picks the element from the front of ``run-queue'',
 * and returns the corresponding process pointer. The process pointer
 * would be calculated by macro le2proc, see kern/process/proc.h
 * for definition. Return NULL if there is no process in the queue.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
/**
 * RR_pick_next - 选择下一个要运行的进程（轮转调度算法）
 * @rq: 运行队列指针
 *
 * 从运行队列中按照轮转调度算法选择下一个要运行的进程
 * 返回值: 指向选中的进程控制块的指针，如果没有可运行进程则返回NULL
 */
static struct proc_struct *
RR_pick_next(struct run_queue *rq)
{
    // LAB6: 孙沐赟：2311534
    // 获取运行队列中的第一个进程节点
    list_entry_t *le = list_next(&(rq->run_list));
    // 检查队列是否为空，如果不为空则返回第一个进程
    if (le != &(rq->run_list))
    {
        return le2proc(le, run_link);
    }
    // 队列为空，返回NULL
    return NULL;
}

/*
 * RR_proc_tick works with the tick event of current process. You
 * should check whether the time slices for current process is
 * exhausted and update the proc struct ``proc''. proc->time_slice
 * denotes the time slices left for current process. proc->need_resched
 * is the flag variable for process switching.
 */
static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 孙沐赟：2311534
    if (proc->time_slice > 0)
    {
        proc->time_slice--; // 时间片减一
    }
    if (proc->time_slice == 0)
    {
        proc->need_resched = 1; // 时间片用完，需要调度
    }
}

struct sched_class default_sched_class = {
    .name = "RR_scheduler",
    .init = RR_init,
    .enqueue = RR_enqueue,
    .dequeue = RR_dequeue,
    .pick_next = RR_pick_next,
    .proc_tick = RR_proc_tick,
};
