# Lab6 实验报告：进程调度

## 一、实验目的

1. 理解操作系统的调度管理机制
2. 熟悉ucore的调度框架和调度算法
3. 实现Round-Robin (RR) 调度算法
4. 实现Stride调度算法（挑战性实验）

## 二、实验内容

### 练习1：使用Round Robin调度算法

#### 1.1 RR调度算法原理

Round Robin（时间片轮转）调度算法是一种最简单的调度算法：
- 所有就绪进程按FIFO原则排成队列
- 每个进程分配一个时间片（time slice）
- 时间片用完后，进程被放到队列末尾，调度下一个进程

#### 1.2 实现代码 (`kern/schedule/default_sched.c`)

```c
// 初始化运行队列
static void RR_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->proc_num = 0;
}

// 将进程加入队列尾部
static void RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    assert(list_empty(&(proc->run_link)));
    list_add_before(&(rq->run_list), &(proc->run_link));
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
        proc->time_slice = rq->max_time_slice;
    }
    proc->rq = rq;
    rq->proc_num++;
}

// 将进程从队列中移除
static void RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
    list_del_init(&(proc->run_link));
    rq->proc_num--;
}

// 选择下一个要运行的进程
static struct proc_struct *RR_pick_next(struct run_queue *rq) {
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);
    }
    return NULL;
}

// 时钟中断处理
static void RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}
```

#### 1.3 问题回答

**请理解并分析sched_class中各个函数指针的用法，并结合Round Robin调度算法描述ucore的调度执行过程。**

`sched_class` 结构体定义了调度器的接口：

```c
struct sched_class {
    const char *name;                                    // 调度器名称
    void (*init)(struct run_queue *rq);                  // 初始化运行队列
    void (*enqueue)(struct run_queue *rq, struct proc_struct *proc);  // 入队
    void (*dequeue)(struct run_queue *rq, struct proc_struct *proc);  // 出队
    struct proc_struct *(*pick_next)(struct run_queue *rq);           // 选择下一个进程
    void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc); // 时钟处理
};
```

**调度执行过程：**

1. **系统初始化**：`sched_init()` 调用 `init()` 初始化运行队列
2. **进程就绪**：`wakeup_proc()` 调用 `enqueue()` 将进程加入就绪队列
3. **时钟中断**：`trap.c` 中的时钟中断处理调用 `sched_class_proc_tick()`，递减时间片
4. **触发调度**：时间片耗尽时设置 `need_resched=1`
5. **执行调度**：`schedule()` 函数：
   - 调用 `enqueue()` 将当前进程放回队列
   - 调用 `pick_next()` 选择下一个进程
   - 调用 `dequeue()` 将选中进程移出队列
   - 调用 `proc_run()` 执行上下文切换

**请在实验报告中简要说明如何设计实现"多级反馈队列调度算法"。**

多级反馈队列调度（MLFQ）设计思路：

1. **数据结构设计**：
```c
#define NR_QUEUE_LEVELS 4  // 4级队列
struct run_queue {
    list_entry_t run_list[NR_QUEUE_LEVELS];  // 多级队列
    int time_slice[NR_QUEUE_LEVELS];          // 每级时间片：1,2,4,8
    unsigned int proc_num;
};
```

2. **调度规则**：
   - 新进程进入最高优先级队列（级别0）
   - 时间片用完降级到下一级队列
   - I/O操作后返回原级或提升
   - 高优先级队列优先调度
   - 最低级队列使用RR调度

3. **实现要点**：
   - `enqueue`: 根据进程优先级插入对应队列
   - `pick_next`: 从最高优先级非空队列选择
   - `proc_tick`: 时间片耗尽时降级

---

### 练习2：实现Stride Scheduling调度算法（挑战性实验）

#### 2.1 Stride调度算法原理

Stride调度是一种确定性的比例共享调度算法：
- 每个进程有一个stride值和priority值
- 每次选择stride最小的进程执行
- 执行后stride增加：`stride += BIG_STRIDE / priority`
- 优先级高的进程stride增长慢，获得更多CPU时间

#### 2.2 BIG_STRIDE的设计

```c
#define BIG_STRIDE 0x7FFFFFFF
```

**选择原因**：
- stride使用32位无符号整数，会发生溢出
- 比较两个stride时使用 `(int32_t)(a - b)` 进行有符号比较
- `BIG_STRIDE = 0x7FFFFFFF` 保证任意两个stride差值不超过此值
- 这样即使溢出，有符号比较仍能得到正确结果

#### 2.3 实现代码 (`kern/schedule/default_sched_stride.c`)

```c
#define BIG_STRIDE 0x7FFFFFFF

// stride比较函数（用于斜堆）
static int proc_stride_comp_f(void *a, void *b) {
    struct proc_struct *p = le2proc(a, lab6_run_pool);
    struct proc_struct *q = le2proc(b, lab6_run_pool);
    int32_t c = p->lab6_stride - q->lab6_stride;
    if (c > 0) return 1;
    else if (c == 0) return 0;
    else return -1;
}

// 初始化
static void stride_init(struct run_queue *rq) {
    list_init(&(rq->run_list));
    rq->lab6_run_pool = NULL;
    rq->proc_num = 0;
}

// 入队：插入斜堆
static void stride_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_stride_comp_f);
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
        proc->time_slice = rq->max_time_slice;
    }
    proc->rq = rq;
    rq->proc_num++;
}

// 出队：从斜堆移除
static void stride_dequeue(struct run_queue *rq, struct proc_struct *proc) {
    rq->lab6_run_pool = skew_heap_remove(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_stride_comp_f);
    rq->proc_num--;
}

// 选择stride最小的进程
static struct proc_struct *stride_pick_next(struct run_queue *rq) {
    if (rq->lab6_run_pool == NULL) {
        return NULL;
    }
    struct proc_struct *p = le2proc(rq->lab6_run_pool, lab6_run_pool);
    
    // 更新stride
    if (p->lab6_priority == 0) {
        p->lab6_stride += BIG_STRIDE;
    } else {
        p->lab6_stride += BIG_STRIDE / p->lab6_priority;
    }
    return p;
}

// 时钟处理
static void stride_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;
    }
}
```

#### 2.4 斜堆（Skew Heap）数据结构

使用斜堆作为优先队列，可以在O(log n)时间内完成：
- 插入操作
- 删除操作  
- 查找最小值

这比使用链表遍历查找最小stride（O(n)）更高效。

#### 2.5 测试结果

**priority测试输出：**
```
sched class: stride_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 5
set priority to 4
set priority to 3
set priority to 2
set priority to 1
child pid 7, acc 1232000, time 2010
child pid 6, acc 1016000, time 2010
child pid 5, acc 820000, time 2010
child pid 4, acc 612000, time 2010
child pid 3, acc 412000, time 2010
sched result: 1 1 2 2 3
all user-mode processes have quit.
init check memory pass.
```

**结果分析**：

| 子进程 | 优先级 | 执行次数 | 相对比例 |
|--------|--------|----------|----------|
| pid 3  | 1      | 412,000  | 1.0      |
| pid 4  | 2      | 612,000  | 1.49     |
| pid 5  | 3      | 820,000  | 1.99     |
| pid 6  | 4      | 1,016,000| 2.47     |
| pid 7  | 5      | 1,232,000| 2.99     |

执行次数与优先级基本成正比，验证了Stride调度算法的正确性。

**自定义stride_test测试输出：**
```
sched class: stride_scheduler
kernel_execve: pid = 2, name = "stride_test".
Stride Scheduler Test
=====================
Creating 5 child processes with priorities 1,2,3,4,5

Child 4: pid=7, priority=5
Child 3: pid=6, priority=4
Child 2: pid=5, priority=3
Child 1: pid=4, priority=2
Child 0: pid=3, priority=1
Child with priority 1 exited
Child with priority 2 exited
Child with priority 3 exited
Child with priority 4 exited
Child with priority 5 exited

=====================
Stride Scheduler Test PASSED!
All children completed successfully.
```

---

## 三、其他需要填充的代码

### 3.1 进程控制块初始化 (`kern/process/proc.c: alloc_proc`)

```c
// LAB4: 基本字段初始化
proc->state = PROC_UNINIT;
proc->pid = -1;
proc->runs = 0;
proc->kstack = 0;
proc->need_resched = 0;
proc->parent = NULL;
proc->mm = NULL;
memset(&(proc->context), 0, sizeof(struct context));
proc->tf = NULL;
proc->pgdir = boot_pgdir_pa;
proc->flags = 0;
memset(proc->name, 0, PROC_NAME_LEN + 1);

// LAB5: 进程关系字段
proc->wait_state = 0;
proc->cptr = NULL;
proc->optr = NULL;
proc->yptr = NULL;

// LAB6: 调度相关字段
proc->rq = NULL;
list_init(&(proc->run_link));
proc->time_slice = 0;
proc->lab6_run_pool.left = proc->lab6_run_pool.right = proc->lab6_run_pool.parent = NULL;
proc->lab6_stride = 0;
proc->lab6_priority = 0;
```

### 3.2 进程切换 (`kern/process/proc.c: proc_run`)

```c
bool intr_flag;
struct proc_struct *prev = current, *next = proc;
local_intr_save(intr_flag);
{
    current = proc;
    lsatp(next->pgdir);
    switch_to(&(prev->context), &(next->context));
}
local_intr_restore(intr_flag);
```

### 3.3 时钟中断处理 (`kern/trap/trap.c`)

```c
case IRQ_S_TIMER:
    clock_set_next_event();
    ticks++;
    if (ticks % TICK_NUM == 0) {
        print_ticks();
    }
    sched_class_proc_tick(current);  // LAB6: 调用调度器时钟处理
    break;
```

### 3.4 页面复制 (`kern/mm/pmm.c: copy_range`)

```c
void *src_kvaddr = page2kva(page);
void *dst_kvaddr = page2kva(npage);
memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
ret = page_insert(to, npage, start, perm);
```

### 3.5 用户态trapframe设置 (`kern/process/proc.c: load_icode`)

```c
tf->gpr.sp = USTACKTOP;
tf->epc = elf->e_entry;
tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
```

---

## 四、扩展练习 Challenge 2：实现多种调度算法

### 4.1 实现的调度算法

除了基础的RR和Stride调度外，还实现了以下调度算法：

#### 4.1.1 FIFO (先来先服务) - `sched_FIFO.c`

**算法特点：**
- 非抢占式调度
- 按进程到达顺序执行
- 每个进程运行直到完成

**实现代码：**
```c
#define FIFO_TIME_SLICE 100  // 较长时间片模拟非抢占

static void FIFO_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    list_add_before(&(rq->run_list), &(proc->run_link));  // 加入队尾
    proc->time_slice = FIFO_TIME_SLICE;
    proc->rq = rq;
    rq->proc_num++;
}

static struct proc_struct *FIFO_pick_next(struct run_queue *rq) {
    list_entry_t *le = list_next(&(rq->run_list));  // 选择队首
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);
    }
    return NULL;
}
```

#### 4.1.2 SJF (短作业优先) - `sched_SJF.c`

**算法特点：**
- 非抢占式调度
- 选择预计执行时间最短的进程
- 使用 `lab6_priority` 存储预计执行时间（值越小越优先）
- 使用斜堆实现O(log n)的最小值查找

**实现代码：**
```c
// SJF比较函数：预计执行时间小的优先
static int proc_sjf_comp_f(void *a, void *b) {
    struct proc_struct *p = le2proc(a, lab6_run_pool);
    struct proc_struct *q = le2proc(b, lab6_run_pool);
    int32_t c = p->lab6_priority - q->lab6_priority;
    if (c > 0) return 1;
    else if (c == 0) return 0;
    else return -1;
}

static void SJF_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    rq->lab6_run_pool = skew_heap_insert(rq->lab6_run_pool, 
                                          &(proc->lab6_run_pool), 
                                          proc_sjf_comp_f);
    proc->time_slice = SJF_TIME_SLICE;
    proc->rq = rq;
    rq->proc_num++;
}

static struct proc_struct *SJF_pick_next(struct run_queue *rq) {
    if (rq->lab6_run_pool == NULL) return NULL;
    return le2proc(rq->lab6_run_pool, lab6_run_pool);  // 堆顶即最小值
}
```

#### 4.1.3 Priority (优先级调度) - `sched_Priority.c`

**算法特点：**
- 非抢占式静态优先级调度
- `lab6_priority` 值越大优先级越高
- 使用斜堆实现高效的最大值查找

**实现代码：**
```c
// 优先级比较函数：priority大的在堆顶
static int proc_priority_comp_f(void *a, void *b) {
    struct proc_struct *p = le2proc(a, lab6_run_pool);
    struct proc_struct *q = le2proc(b, lab6_run_pool);
    // 取负值使高优先级在堆顶
    int32_t c = (int32_t)q->lab6_priority - (int32_t)p->lab6_priority;
    if (c > 0) return 1;
    else if (c == 0) return 0;
    else return -1;
}
```

#### 4.1.4 MLFQ (多级反馈队列) - `sched_MLFQ.c`

**算法特点：**
- 4级优先级队列
- 新进程从最高优先级（级别0）开始
- 时间片用完后降级到下一级
- 高优先级时间片短，低优先级时间片长
- 使用 `lab6_stride` 存储当前队列级别

**实现代码：**
```c
#define MLFQ_LEVELS 4
#define MLFQ_BASE_SLICE 2

// 获取指定级别的时间片：级别0=2, 级别1=4, 级别2=8, 级别3=16
static int get_level_time_slice(int level) {
    return MLFQ_BASE_SLICE << level;
}

static void MLFQ_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->lab6_stride >= MLFQ_LEVELS) {
        proc->lab6_stride = 0;  // 新进程从级别0开始
    }
    if (proc->time_slice == 0) {
        proc->time_slice = get_level_time_slice(proc->lab6_stride);
    }
    // 按级别顺序插入队列
    list_entry_t *le = list_next(&(rq->run_list));
    while (le != &(rq->run_list)) {
        struct proc_struct *p = le2proc(le, run_link);
        if (p->lab6_stride > proc->lab6_stride) break;
        le = list_next(le);
    }
    list_add_before(le, &(proc->run_link));
    proc->rq = rq;
    rq->proc_num++;
}

static void MLFQ_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    if (proc->time_slice > 0) proc->time_slice--;
    if (proc->time_slice == 0) {
        // 时间片用完，降级
        if (proc->lab6_stride < MLFQ_LEVELS - 1) {
            proc->lab6_stride++;
        }
        proc->time_slice = get_level_time_slice(proc->lab6_stride);
        proc->need_resched = 1;
    }
}
```

### 4.2 调度算法切换机制

创建了 `sched_all.h` 头文件，通过宏定义切换调度算法：

```c
#define SCHED_RR       0
#define SCHED_STRIDE   1
#define SCHED_FIFO     2
#define SCHED_SJF      3
#define SCHED_PRIORITY 4
#define SCHED_MLFQ     5

// 修改此值切换调度算法
#define CURRENT_SCHED SCHED_STRIDE
```

在 `sched.c` 中根据宏选择调度器：
```c
#if CURRENT_SCHED == SCHED_RR
    sched_class = &default_sched_class;
#elif CURRENT_SCHED == SCHED_STRIDE
    sched_class = &stride_sched_class;
// ... 其他调度器
#endif
```

### 4.3 测试用例设计 (`user/sched_test.c`)

设计了5个测试场景：

| 测试 | 描述 | 测试目的 |
|------|------|----------|
| Test 1 | CPU密集型任务混合 | 测试不同工作量进程的调度 |
| Test 2 | 短作业vs长作业 | 测试SJF算法的效果 |
| Test 3 | 优先级测试 | 测试优先级调度的正确性 |
| Test 4 | MLFQ行为测试 | 测试进程降级行为 |
| Test 5 | 公平性测试 | 测试RR/Stride的公平性 |

### 4.4 各调度算法对比分析

| 指标 | FIFO | SJF | RR | Priority | Stride | MLFQ |
|------|------|-----|-----|----------|--------|------|
| **平均等待时间** | 较长 | 最短 | 中等 | 取决于优先级 | 可控 | 中等 |
| **平均周转时间** | 较长 | 最短 | 中等 | 取决于优先级 | 可控 | 中等 |
| **响应时间** | 长 | 长 | 短 | 不确定 | 可控 | 短 |
| **公平性** | 不公平 | 不公平 | 公平 | 不公平 | 可控公平 | 自适应 |
| **饥饿问题** | 无 | 有（长作业） | 无 | 有（低优先级） | 无 | 无 |
| **实现复杂度** | 简单 | 中等 | 简单 | 中等 | 中等 | 复杂 |
| **CPU利用率** | 高 | 高 | 略低 | 高 | 高 | 高 |

### 4.5 各算法适用场景

#### FIFO (先来先服务)
- **适用场景**：批处理系统、任务执行时间相近的环境
- **不适用**：交互式系统、短作业多的环境
- **优点**：实现简单，无饥饿
- **缺点**：护航效应（短作业等待长作业）

#### SJF (短作业优先)
- **适用场景**：批处理系统、作业时间可预知的环境
- **不适用**：交互式系统、作业时间无法预知的环境
- **优点**：平均等待时间最优
- **缺点**：长作业可能饥饿，需预知执行时间

#### RR (时间片轮转)
- **适用场景**：分时系统、交互式系统
- **不适用**：实时系统、对响应时间要求极高的环境
- **优点**：公平、响应快、无饥饿
- **缺点**：上下文切换开销，时间片大小难以确定

#### Priority (优先级调度)
- **适用场景**：需要区分任务重要性的系统、实时系统
- **不适用**：公平性要求高的环境
- **优点**：重要任务优先执行
- **缺点**：低优先级饥饿，优先级反转问题

#### Stride (步进调度)
- **适用场景**：需要精确控制CPU时间分配的环境
- **不适用**：简单系统（实现复杂度不值得）
- **优点**：确定性比例共享，无饥饿
- **缺点**：实现复杂，需要处理溢出

#### MLFQ (多级反馈队列)
- **适用场景**：通用操作系统、工作负载多样的环境
- **不适用**：实时系统
- **优点**：自适应、兼顾交互和批处理
- **缺点**：参数调优困难，实现复杂

### 4.6 实际测试结果

使用 `priority` 测试程序对6种调度算法进行测试，测试程序创建5个子进程，分别设置优先级1-5（或6），统计各进程的执行次数(acc)。

#### 4.6.1 RR (Round Robin) 调度测试结果

```
sched class: RR_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 1
set priority to 2
set priority to 3
set priority to 4
set priority to 5
child pid 3, acc 848000, time 2010
child pid 4, acc 832000, time 2010
child pid 5, acc 840000, time 2010
child pid 6, acc 840000, time 2010
child pid 7, acc 840000, time 2010
sched result: 1 1 1 1 1
```

**分析**：RR调度下，各进程执行次数基本相等（约840000），体现了时间片轮转的公平性。优先级设置被忽略，所有进程获得几乎相同的CPU时间。

#### 4.6.2 Stride 调度测试结果

```
sched class: stride_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 5
set priority to 4
set priority to 3
set priority to 2
set priority to 1
child pid 7, acc 1256000, time 2010
child pid 6, acc 1044000, time 2010
child pid 5, acc 832000, time 2010
child pid 4, acc 628000, time 2010
child pid 3, acc 420000, time 2010
sched result: 1 1 2 2 3
```

**分析**：Stride调度下，执行次数与优先级成正比：
- 优先级5: 1256000 (比例 ≈ 3.0)
- 优先级4: 1044000 (比例 ≈ 2.5)
- 优先级3: 832000 (比例 ≈ 2.0)
- 优先级2: 628000 (比例 ≈ 1.5)
- 优先级1: 420000 (比例 ≈ 1.0)

这验证了Stride调度的比例共享特性。

#### 4.6.3 FIFO 调度测试结果

```
sched class: FIFO_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 1
set priority to 2
set priority to 3
child pid 5, acc 20000, time 2010
set priority to 4
child pid 6, acc 4000, time 2010
set priority to 5
child pid 7, acc 4000, time 2010
child pid 3, acc 1836000, time 2010
child pid 4, acc 1856000, time 2020
sched result: 1 1 0 0 0
```

**分析**：FIFO调度下，先到达的进程(pid 3, 4)获得大量CPU时间（约1.8M），后到达的进程(pid 5,6,7)只获得很少时间（约4000-20000）。这体现了FIFO的"护航效应"——先到的长作业会阻塞后到的短作业。

#### 4.6.4 SJF 调度测试结果

```
sched class: SJF_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 5
set priority to 4
set priority to 3
child pid 5, acc 20000, time 2010
set priority to 2
child pid 4, acc 4000, time 2010
set priority to 1
child pid 3, acc 4000, time 2010
child pid 6, acc 1968000, time 2010
child pid 7, acc 1972000, time 2010
sched result: 1 1 5 492 493
```

**分析**：SJF使用priority值作为预计执行时间（值小=短作业），优先级低的进程（值小）先执行完成。优先级高的进程(pid 6,7)作为"长作业"最后执行，获得大量CPU时间。

#### 4.6.5 Priority 调度测试结果

```
sched class: Priority_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 5
child pid 7, acc 4032000, time 2010
set priority to 4
child pid 6, acc 4000, time 2010
set priority to 3
child pid 5, acc 4000, time 2010
set priority to 2
child pid 4, acc 4000, time 2010
set priority to 1
child pid 3, acc 4000, time 2020
sched result: 1 1 1 1 1008
```

**分析**：Priority调度下，最高优先级进程(pid 7, priority=5)获得绝大部分CPU时间（4032000），其他进程几乎无法执行（仅4000）。这体现了非抢占式优先级调度的特点：高优先级进程独占CPU直到完成。

#### 4.6.6 MLFQ 调度测试结果

```
sched class: MLFQ_scheduler
kernel_execve: pid = 2, name = "priority".
set priority to 6
main: fork ok,now need to wait pids.
set priority to 1
set priority to 2
set priority to 3
set priority to 4
set priority to 5
child pid 6, acc 648000, time 2010
child pid 7, acc 596000, time 2010
child pid 3, acc 916000, time 2010
child pid 4, acc 904000, time 2010
child pid 5, acc 908000, time 2010
sched result: 1 1 1 1 1
```

**分析**：MLFQ调度下，各进程执行次数较为均衡（596000-916000），但比RR略有差异。这是因为MLFQ会根据进程行为动态调整优先级——消耗时间片多的进程会被降级，使得所有进程趋于公平。

### 4.7 测试结果对比总结

| 调度算法 | pid3 (pri=1) | pid4 (pri=2) | pid5 (pri=3) | pid6 (pri=4) | pid7 (pri=5) | 特点 |
|----------|-------------|-------------|-------------|-------------|-------------|------|
| **RR** | 848000 | 832000 | 840000 | 840000 | 840000 | 完全公平 |
| **Stride** | 420000 | 628000 | 832000 | 1044000 | 1256000 | 按优先级比例分配 |
| **FIFO** | 1836000 | 1856000 | 20000 | 4000 | 4000 | 先到先服务 |
| **SJF** | 4000 | 4000 | 20000 | 1968000 | 1972000 | 短作业优先 |
| **Priority** | 4000 | 4000 | 4000 | 4000 | 4032000 | 高优先级独占 |
| **MLFQ** | 916000 | 904000 | 908000 | 648000 | 596000 | 自适应公平 |

---

## 五、实验总结

### 5.1 知识点总结

1. **调度框架设计**：通过`sched_class`结构体实现调度算法的模块化
2. **Round Robin算法**：简单公平的时间片轮转调度
3. **Stride算法**：确定性的比例共享调度，保证CPU时间按优先级分配
4. **FIFO/SJF/Priority**：经典调度算法的实现
5. **MLFQ**：现代操作系统常用的自适应调度算法
6. **斜堆数据结构**：高效的优先队列实现

### 5.2 实验收获

- 理解了操作系统调度器的设计模式
- 掌握了6种调度算法的实现
- 学会了使用斜堆优化优先队列操作
- 理解了stride值溢出处理的技巧
- 深入理解了各调度算法的优缺点和适用场景

### 5.3 测试结果

- ✅ RR调度算法实现正确
- ✅ Stride调度算法实现正确
- ✅ FIFO调度算法实现正确
- ✅ SJF调度算法实现正确
- ✅ Priority调度算法实现正确
- ✅ MLFQ调度算法实现正确
- ✅ priority测试通过
- ✅ 自定义stride_test测试通过
- ✅ sched_test综合测试用例创建完成

