# lab4
## Exercise 3 编写proc_run函数
### 问题描述
proc_run用于将指定的进程切换到CPU上运行。它的大致执行步骤包括：

- 检查要切换的进程是否与当前正在运行的进程相同，如果相同则不需要切换。
- 禁用中断。你可以使用/kern/sync/sync.h中定义好的宏local_intr_save(x)和local_intr_restore(x)来实现关、开中断。
- 切换当前进程为要运行的进程。
- 切换页表，以便使用新进程的地址空间。/libs/riscv.h中提供了lsatp(unsigned int pgdir)函数，可实现修改SATP寄存器值的功能。
- 实现上下文切换。/kern/process中已经预先编写好了switch.S，其中定义了switch_to()函数。可实现两个进程的context切换。
- 允许中断。

回答如下问题：

- 在本实验的执行过程中，创建且运行了几个内核线程？

### 问题解决
首先根据问题描述对于proc_run函数的执行步骤，我们可以编程出具体的代码如下：
```c
// NOTE: before call switch_to, should load  base addr of "proc"'s new PDT
void proc_run(struct proc_struct *proc)
{
    if (proc != current)
    {
        bool intr_flag;
        struct proc_struct *prev = current, *next = proc;
        local_intr_save(intr_flag);                    // 禁用中断
        {
            current = proc;                            // 切换当前进程为要运行的进程
            lsatp(next->pgdir);                        // 切换页表，以便使用新进程的地址空间
            switch_to(&(prev->context), &(next->context)); // 实现上下文切换
        }
        local_intr_restore(intr_flag);                 // 允许中断
    }
}
```
我们首先逐行解释一下代码。

 定义函数 `proc_run(struct proc_struct *proc)`，用于把指定进程切到 CPU 运行。
`if (proc != current)`检查要切换的进程是否与当前正在运行的进程相同。若相同则无需切换，避免不必要的上下文切换开销与栈/寄存器往返存取
`bool intr_flag;`声明中断状态保存变量，用于在临界区结束时恢复原有中断状态`local_intr_save(x)` 会根据 `sstatus.SIE` 的当前值置位/清零 `x`，以便 `local_intr_restore(x)` 正确恢复
`struct proc_struct *prev = current, *next = proc;`记录切换前后的进程指针，供后续页表切换与上下文切换使用；`prev` 的 `context` 用于保存现场，`next` 的 `context` 用于恢复现场；指针预先绑定确保语义清晰

`local_intr_save(intr_flag);`关闭中断，进入不可打断的临界区，保证切换过程的原子性。读取 `sstatus` 的 `SIE` 位，若为 1 则调用 `intr_disable()` 并返回 1，否则返回 0；结果写入 `intr_flag`
`current = proc;`更新全局当前进程指针，使系统状态与日志观测统一指向待运行进程。后续依赖 `current` 的路径（如 `forkret`、断言、打印）将以新进程为准，避免“页表与上下文已切换但标识未切换”的不一致

`lsatp(next->pgdir);`切换页表，启用新进程的地址空间映射。向 `satp` 写入 `SATP32_MODE | (pgdir >> RISCV_PGSHIFT)`，使硬件后续的取指/访存都在新页表下进行。
- 页表切换通过 `lsatp(next->pgdir)` 完成（`libs/riscv.h:245-248`）：
  - 将 `satp` 写为 `SATP32_MODE | (pgdir >> RISCV_PGSHIFT)`，启用新的页表基地址；
  - 地址空间隔离由此生效，后续的取指/访存都在新进程的页表下进行。
- 切页表与上下文顺序：先切 `current/pgdir` 再 `switch_to`，确保在恢复栈与返回地址时已经使用新进程的地址空间，避免读写旧地址空间造成混乱。

`switch_to(&(prev->context), &(next->context));`执行上下文切换，保存旧进程的寄存器现场并恢复新进程的寄存器现场汇编例程依次 STORE `ra/sp/s0~s11` 到 `from->context`，再依次 LOAD 同名寄存器从 `to->context`，最后 `ret` 跳转到新进程的返回地址。
- `switch_to` 的汇编实现遵循“保存 from、恢复 to”的对称顺序：
  - 保存 `ra/sp/s0~s11` 到 `from->context`；
  - 从 `to->context` 恢复 `ra/sp/s0~s11`；
  - `ret` 返回到 `to` 的 `ra` 指向的位置继续执行。
- 结合 `copy_thread` 的设置：
  - 新进程的 `context.ra` 被设置为 `forkret`，`context.sp` 指向其 `trapframe` 顶部；
  - 因此第一次被调度运行时，恢复后的 `ra/sp` 会把控制流精确导向 `forkret`，再进入 `forkrets(current->tf)`。

`local_intr_restore(intr_flag);`恢复中断状态，退出临界区。若 `intr_flag==1`（表示先前中断是开启的），则调用 `intr_enable()` 重新打开中断；否则保持关闭

- 中断关闭/恢复宏定义是通过下面两个函数完成的：
  - `local_intr_save(x)`：若 `sstatus.SIE` 为 1，则调用 `intr_disable()` 关闭中断并置 `x=1`；否则 `x=0`；
  - `local_intr_restore(x)`：若 `x==1` 则调用 `intr_enable()` 恢复中断。
- 必要性：
  - 防止在切换 `current/pgdir/context` 的关键窗口被时钟/外设中断打断，造成部分状态更新与部分未更新并存的竞态；
  - 与调度器 `schedule()` 的关中断区间相呼应，维持调度路径的一致性与原子性。

要完成上述流程，与下面几个变量有很大关系：
- `current` 全局指针表示当前运行进程；`idleproc` 与 `initproc` 分别表示空闲与初始化进程。
- `struct proc_struct`包含：
  - `context` 保存可切换的通用寄存器集合（`ra`, `sp`, `s0`~`s11` 等）；
  - `pgdir` 进程页表基地址；
  - `state/pid/kstack/need_resched/mm/...` 等运行与管理字段。
- 中断开关宏：
  - `local_intr_save(x)` 通过读取 `sstatus` 的 `SIE` 位判断是否启用中断，若启用则调用 `intr_disable()` 关闭并返回 1；否则返回 0（`kern/sync/sync.h:8-14`）。
  - `local_intr_restore(x)` 若 `x` 为 1 则调用 `intr_enable()` 重新打开中断（`kern/sync/sync.h:16-20`）。
- 页表切换）：
  - `lsatp(unsigned int pgdir)` 将 `satp` 写为 `SATP32_MODE | (pgdir >> RISCV_PGSHIFT)`，以页目录物理地址为基础建立新的地址空间。
- 上下文切换：
  - 先将 `from` 的 `ra/sp/s0~s11` 依次 `STORE` 到 `from->context`；
  - 再从 `to->context` 依次 `LOAD` 出 `ra/sp/s0~s11` 恢复到寄存器；
  - `ret` 跳回至 `to` 进程的返回地址继续执行。

#### 调度关系
- 调度器在 `schedule()` 中选择下一个可运行进程，若与 `current` 不同，则调用 `proc_run(next)` 完成实际切换（`kern/schedule/sched.c:31-37`）。
- `proc_run` 前后通过中断关开确保调度路径的一致性，并维护 `current/pgdir/context` 三件套，保证地址空间与寄存器状态的正确切换。

#### 问题回答
- 在本实验的执行过程中，创建且运行了几个内核线程？
**一共创建并运行了 2 个内核线程**：

1. **idleproc（idle 内核线程）**

   * 在 `proc_init()` 里：

     ```c
     idleproc = alloc_proc();
     idleproc->pid = 0;
     idleproc->state = PROC_RUNNABLE;
     idleproc->kstack = (uintptr_t)bootstack;
     set_proc_name(idleproc, "idle");
     current = idleproc;
     ```
   * 这就是系统启动后的**第一个内核线程**，负责在 `cpu_idle()` 中循环调度：

     ```c
     while (1) {
         if (current->need_resched) schedule();
     }
     ```

2. **initproc（init\_main 内核线程）**

   * 仍在 `proc_init()` 里，通过 `kernel_thread` 创建：

     ```c
     int pid = kernel_thread(init_main, "Hello world!!", 0);
     initproc = find_proc(pid);
     set_proc_name(initproc, "init");
     ```
   * `kernel_thread()` 内部调用 `do_fork()`，生成一个新的进程/线程结构，并设置入口为 `init_main`，因此这是**第二个内核线程**。
   * `init_main()` 只是打印信息后返回，没有再创建新的内核线程：

     ```c
     cprintf(...);
     return 0;
     ```

#### 一些其他思考
- 为什么先更新 `current` 再切页表？
  - 保证返回路径正确：`copy_thread` 将新进程的 `context.ra` 设为 `forkret`（`kern/process/proc.c:301-303`），而 `forkret` 内部调用 `forkrets(current->tf)`（`kern/process/proc.c:214-217`）。若不先把 `current` 指向新进程，在 `switch_to` 恢复后执行到 `forkret` 时，`current->tf` 会误指向旧进程的 trapframe，造成恢复错误。因此必须在上下文切换前把 `current` 更新为目标进程。
  - 异常归属一致：尽管 `proc_run` 期间中断被关闭（`local_intr_save`），但某些异常（如页失效）理论上仍可能在关键窗口出现。异常处理路径会以 `current` 识别归属进程。先更新 `current` 可避免在极端情况下把异常错误地归到旧进程。
  - 调度不变式与观测一致：调度器在挑选 `next` 后会 `next->runs++` 并调用 `proc_run(next)`（`kern/schedule/sched.c:34-37`）。更新 `current` 在前，保证调度相关日志、断言和统计观察到的“当前进程”与即将生效的上下文一致，避免可观测状态与实际运行状态短暂不一致。
  - 与页表切换的配合：`lsatp(next->pgdir)` 必须在 `switch_to` 之前执行，确保在恢复新进程的 `sp`（指向新进程的内核栈）和返回地址时，这些地址在当前页表下是有效的；另一方面，`proc_struct/context` 位于内核空间，跨进程共享映射，故在切页表后对 `prev->context` 进行 `STORE` 仍然安全。
- `local_intr_save/restore` 与 `schedule` 的对应关系？
  - 两者共同保证在挑选与切换过程中不被打断；`schedule` 内部关中断，`proc_run` 再次关中断确保子路径原子。

## 运行结果
到此为止我们就完成了实验的所有要求，接下来我们来验证一下实验的运行结果。

运行`make qemu`,得到输出如下。
```
(base) linux@Lenovo:~/OS_EXP/lab4$ make qemu

OpenSBI v0.4 (Jul  2 2019 11:53:53)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name          : QEMU Virt Machine
Platform HART Features : RV64ACDFIMSU
Platform Max HARTs     : 8
Current Hart           : 0
Firmware Base          : 0x80000000
Firmware Size          : 112 KB
Runtime SBI Version    : 0.1

PMP0: 0x0000000080000000-0x000000008001ffff (A)
PMP1: 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
DTB Init
HartID: 0
DTB Address: 0x82200000
Physical Memory from DTB:
  Base: 0x0000000080000000
  Size: 0x0000000008000000 (128 MB)
  End:  0x0000000087ffffff
DTB init completed
(THU.CST) os is loading ...

Special kernel symbols:
  entry  0xc020004a (virtual)
  etext  0xc0203e08 (virtual)
  edata  0xc0209030 (virtual)
  end    0xc020d4ec (virtual)
Kernel executable memory footprint: 54KB
memory management: best_fit_pmm_manager
physcial memory map:
  memory: 0x08000000, [0x80000000, 0x87ffffff].
vapaofset is 18446744070488326144
check_alloc_page() succeeded!
check_pgdir() succeeded!
check_boot_pgdir() succeeded!
use SLOB allocator
kmalloc_init() succeeded!
check_vma_struct() succeeded!
check_vmm() succeeded.
alloc_proc() correct!
++ setup timer interrupts
this initproc, pid = 1, name = "init"
To U: "Hello world!!".
To U: "en.., Bye, Bye. :)"
kernel panic at kern/process/proc.c:389:
    process exit!!.

Welcome to the kernel debug monitor!!
```

**结果分析**：
1. `this initproc, pid = 1, name = "init"`：说明 `init` 进程（PID=1）已成功创建并开始调度。
2. `To U: "Hello world!!"`：这是 `init` 进程在用户态执行时打印的字符串，证明内核成功切换到了用户态，并且用户程序开始执行。
3. `To U: "en.., Bye, Bye. :)"`：这是用户程序执行完毕前的输出，表明用户程序正常运行结束。
4. `kernel panic at kern/process/proc.c:389: process exit!!`：`init` 进程退出后，由于它是系统中唯一的进程，内核检测到没有其他进程可运行，触发了 panic，这符合实验预期（本实验尚未实现完整的进程回收和 shell）。

运行`make grade`,得到输出如下。
```
  -check alloc proc:                         OK
  -check initproc:                           OK
Total Score: 30/30
```
可以发现输出符合预期，证明我们的实验结果是正确的！

## Challenge 1
说明语句<code>local_intr_save(intr_flag);....local_intr_restore(intr_flag);</code>是如何实现开关中断的？

好，我们把三个地方连起来看：`proc.c` 里用的宏、`sync.h` 的实现、`intr.c` 的底层开关。

---

## 1) 在 proc.c 

比如 `proc_run` 里：

```c
bool intr_flag;
local_intr_save(intr_flag);
{
    ...
}
local_intr_restore(intr_flag);
```

## 2) 宏展开后变成什么

在 `sync.h`：

```c
#define local_intr_save(x) \
    do {                   \
        x = __intr_save(); \
    } while (0)

#define local_intr_restore(x) __intr_restore(x);
```

所以展开后等价于：

```c
do {
    intr_flag = __intr_save();
} while (0);

__intr_restore(intr_flag);
```

（`do{...}while(0)` 只是让宏看起来像一条语句，方便写分号和配 if/else，用你注释说法就对。）

## 3) \_\_intr\_save / \_\_intr\_restore 做了什么

### `__intr_save()`

```c
static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) { // 之前中断是开着的？
        intr_disable();                   // 关中断
        return 1;                         // 记下“之前是开”
    }
    return 0;                             // 之前本来就是关的
}
```

* 先读 `sstatus` 寄存器里的 **SIE 位**（Supervisor Interrupt Enable）。
* 如果 SIE=1（中断原本开启）
  → 调 `intr_disable()` 把 SIE 清 0
  → 返回 `1` 存到 `intr_flag`
* 如果 SIE=0（中断原本就关闭）
  → 什么也不做
  → 返回 `0`

所以 `intr_flag` 记录的是：**进入临界区之前，中断是否开启过**。


### `__intr_restore(flag)`

```c
static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();   // 只有之前开着才重新开
    }
}
```

要点：

* 只有当 `flag==1`（意味着刚才 save 时发现中断是开着的）
  才会重新开中断。
* 如果 save 时发现中断本来就关着（flag=0）
  restore 就不会乱开，保持原状。


## 4) 最底层的 intr\_enable / intr\_disable

在 `intr.c`：

```c
void intr_enable(void)  { set_csr(sstatus, SSTATUS_SIE); }
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
```

* `intr_disable`：清掉 `sstatus.SIE` 位 → **硬件层面禁止中断**
* `intr_enable`：置上 `sstatus.SIE` 位 → **硬件层面允许中断**


## 5) 总结成一句“这对语句如何实现开关中断”

`local_intr_save(intr_flag);`
**读取当前 SIE 状态**，如果中断原本是开的就**先关掉**，并把“之前是开/关”的状态存到 `intr_flag`。

`local_intr_restore(intr_flag);`
**根据 intr\_flag 恢复**：只有当进入临界区前中断是开的，才把 SIE 重新置 1 打开；否则保持关闭。

这就实现了\*\*“临界区内强制关闭中断，退出时不破坏原有中断状态”\*\*的安全开关逻辑。
