/*
 * 所有调度算法的统一头文件
 * 包含各种调度算法的声明
 */

#ifndef __KERN_SCHEDULE_SCHED_ALL_H__
#define __KERN_SCHEDULE_SCHED_ALL_H__

#include <sched.h>

// Round Robin (时间片轮转)
extern struct sched_class default_sched_class;

// Stride Scheduling (步进调度)
extern struct sched_class stride_sched_class;

// FIFO (先来先服务)
extern struct sched_class FIFO_sched_class;

// SJF (短作业优先)
extern struct sched_class SJF_sched_class;

// Priority (优先级调度)
extern struct sched_class Priority_sched_class;

// MLFQ (多级反馈队列)
extern struct sched_class MLFQ_sched_class;

/*
 * 调度算法选择宏
 * 修改下面的定义来切换不同的调度算法
 * 
 * 选项:
 *   SCHED_RR       - Round Robin (默认)
 *   SCHED_STRIDE   - Stride Scheduling
 *   SCHED_FIFO     - First In First Out
 *   SCHED_SJF      - Shortest Job First
 *   SCHED_PRIORITY - Priority Scheduling
 *   SCHED_MLFQ     - Multi-Level Feedback Queue
 */

#define SCHED_RR       0
#define SCHED_STRIDE   1
#define SCHED_FIFO     2
#define SCHED_SJF      3
#define SCHED_PRIORITY 4
#define SCHED_MLFQ     5

// 当前选择的调度算法（修改此值来切换）
#define CURRENT_SCHED SCHED_STRIDE

#endif /* !__KERN_SCHEDULE_SCHED_ALL_H__ */
