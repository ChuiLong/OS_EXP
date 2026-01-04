#include <list.h>
#include <sync.h>
#include <proc.h>
#include <sched.h>
#include <assert.h>

void
wakeup_proc(struct proc_struct *proc) {
    assert(proc->state != PROC_ZOMBIE && proc->state != PROC_RUNNABLE);
    proc->state = PROC_RUNNABLE;
}

void
schedule(void) {
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
        // 如果当前是 idleproc，从 proc_list（链表头）开始扫描整个链表（从头查找可运行进程）
        // 否则从 current 的节点开始扫描
        last = (current == idleproc) ? &proc_list : &(current->list_link);
        le = last;
        do {
            if ((le = list_next(le)) != &proc_list) {
                // 通过链表节点 le 获取进程结构体 proc
                next = le2proc(le, list_link);
                // 寻找并尽早停止在“第一个可运行进程”
                if (next->state == PROC_RUNNABLE) {
                    break;
                }
            }
        } while (le != last);
        // 即使循环内刚判断过，loop 结束后 next 也可能不是 RUNNABLE(再进行检查一次)
        if (next == NULL || next->state != PROC_RUNNABLE) {
            next = idleproc;
        }
        // 该进程被选中的次数加一
        next->runs ++;
        /*
        若选中的不是当前进程，
        调用 proc_run 执行上下文切换
        （proc_run 会处理页表切换、
        更新 current 并最终调用 switch_to 完成寄存器恢复）
        */
        if (next != current) {
            proc_run(next);
        }
    }
    local_intr_restore(intr_flag);
}

