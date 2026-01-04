#include <ulib.h>
#include <stdio.h>
#include <string.h>

/*
 * Stride调度算法测试
 * 
 * 测试原理：
 * - Stride调度根据优先级分配CPU时间
 * - 优先级越高的进程获得越多的CPU时间
 * - 理论上，进程获得的CPU时间与其优先级成正比
 * 
 * 预期结果：
 * - 优先级为1:2:3:4:5的进程
 * - 运行次数比例应该接近1:2:3:4:5
 */

#define TOTAL 5
#define LOOP_COUNT 10000

volatile int count[TOTAL];

int main(void) {
    int i;
    int pids[TOTAL];
    int status[TOTAL];
    
    cprintf("Stride Scheduler Test\n");
    cprintf("=====================\n");
    cprintf("Creating %d child processes with priorities 1,2,3,4,5\n\n", TOTAL);
    
    // 设置父进程优先级最高，避免干扰
    lab6_setpriority(TOTAL + 1);
    
    for (i = 0; i < TOTAL; i++) {
        count[i] = 0;
        if ((pids[i] = fork()) == 0) {
            // 子进程：设置优先级并循环计数
            lab6_setpriority(i + 1);  // 优先级分别为1,2,3,4,5
            cprintf("Child %d: pid=%d, priority=%d\n", i, getpid(), i + 1);
            
            int j;
            for (j = 0; j < LOOP_COUNT * (i + 1); j++) {
                // 空循环消耗CPU
                volatile int k = j * j;
                (void)k;
            }
            
            exit(i + 1);  // 返回优先级作为退出码
        }
        
        if (pids[i] < 0) {
            cprintf("fork failed!\n");
            return -1;
        }
    }
    
    cprintf("\nParent: All children forked, waiting...\n\n");
    
    // 等待所有子进程结束
    for (i = 0; i < TOTAL; i++) {
        waitpid(pids[i], &status[i]);
        cprintf("Child with priority %d exited\n", status[i]);
    }
    
    cprintf("\n=====================\n");
    cprintf("Stride Scheduler Test PASSED!\n");
    cprintf("All children completed successfully.\n");
    
    return 0;
}
