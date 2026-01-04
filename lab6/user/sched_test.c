/*
 * 调度算法性能测试程序
 * 用于比较不同调度算法在各指标上的差异
 */

#include <stdio.h>
#include <ulib.h>

#define WORK_UNIT 100000   // 基础工作单元

// 模拟CPU密集型任务
static void cpu_bound_work(int units) {
    volatile int sum = 0;
    for (int i = 0; i < units * WORK_UNIT; i++) {
        sum += i;
    }
}

// 测试进程信息
struct test_proc_info {
    int priority;       // 优先级（用于优先级调度和Stride）
    int burst_time;     // 预计执行时间（用于SJF）
    int work_units;     // 实际工作量
};

// 测试场景1：CPU密集型任务混合
void test_cpu_bound_mix(void) {
    cprintf("\n========================================\n");
    cprintf("Test 1: CPU-Bound Tasks Mix\n");
    cprintf("========================================\n");
    cprintf("Creating 4 processes with different workloads\n");
    cprintf("P1: 3 units, P2: 1 unit, P3: 2 units, P4: 4 units\n\n");
    
    int pids[4];
    int start_time = 0;  // 简化：用计数器模拟时间
    
    // 创建进程，设置不同的工作量
    int work_units[] = {3, 1, 2, 4};
    int priorities[] = {3, 1, 2, 4};  // 对应优先级
    
    for (int i = 0; i < 4; i++) {
        int pid = fork();
        if (pid == 0) {
            // 子进程
            cprintf("Process %d (pid=%d) started, work_units=%d\n", 
                    i+1, getpid(), work_units[i]);
            
            // 设置优先级（用于Stride/Priority调度）
            lab6_setpriority(priorities[i]);
            
            // 执行工作
            cpu_bound_work(work_units[i]);
            
            cprintf("Process %d (pid=%d) completed\n", i+1, getpid());
            exit(0);
        } else {
            pids[i] = pid;
        }
    }
    
    // 等待所有子进程
    for (int i = 0; i < 4; i++) {
        waitpid(pids[i], NULL);
    }
    
    cprintf("\nTest 1 completed.\n");
}

// 测试场景2：短作业与长作业混合
void test_sjf_scenario(void) {
    cprintf("\n========================================\n");
    cprintf("Test 2: Short Job vs Long Job\n");
    cprintf("========================================\n");
    cprintf("Creating jobs: Short(1), Long(5), Medium(2)\n\n");
    
    int pids[3];
    int work_units[] = {1, 5, 2};
    
    for (int i = 0; i < 3; i++) {
        int pid = fork();
        if (pid == 0) {
            cprintf("Job %d started (work=%d units)\n", i+1, work_units[i]);
            
            // 设置优先级为工作量（SJF会选择小值优先）
            lab6_setpriority(work_units[i]);
            
            cpu_bound_work(work_units[i]);
            
            cprintf("Job %d completed\n", i+1);
            exit(0);
        } else {
            pids[i] = pid;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
    }
    
    cprintf("\nTest 2 completed.\n");
}

// 测试场景3：优先级测试
void test_priority_scenario(void) {
    cprintf("\n========================================\n");
    cprintf("Test 3: Priority Scheduling Test\n");
    cprintf("========================================\n");
    cprintf("Creating 3 processes with priorities: Low(1), High(5), Medium(3)\n\n");
    
    int pids[3];
    int priorities[] = {1, 5, 3};
    char *names[] = {"Low", "High", "Medium"};
    
    for (int i = 0; i < 3; i++) {
        int pid = fork();
        if (pid == 0) {
            cprintf("%s priority process (pri=%d) started\n", names[i], priorities[i]);
            
            lab6_setpriority(priorities[i]);
            
            // 相同工作量
            cpu_bound_work(2);
            
            cprintf("%s priority process completed\n", names[i]);
            exit(0);
        } else {
            pids[i] = pid;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
    }
    
    cprintf("\nTest 3 completed.\n");
}

// 测试场景4：MLFQ行为测试
void test_mlfq_scenario(void) {
    cprintf("\n========================================\n");
    cprintf("Test 4: MLFQ Behavior Test\n");
    cprintf("========================================\n");
    cprintf("Creating processes with varying behavior\n\n");
    
    int pids[3];
    
    // 进程1：短任务（应保持在高优先级）
    int pid = fork();
    if (pid == 0) {
        cprintf("Short task started\n");
        cpu_bound_work(1);
        cprintf("Short task completed\n");
        exit(0);
    }
    pids[0] = pid;
    
    // 进程2：长CPU密集型任务（应降级到低优先级）
    pid = fork();
    if (pid == 0) {
        cprintf("Long CPU-bound task started\n");
        cpu_bound_work(6);
        cprintf("Long CPU-bound task completed\n");
        exit(0);
    }
    pids[1] = pid;
    
    // 进程3：中等任务
    pid = fork();
    if (pid == 0) {
        cprintf("Medium task started\n");
        cpu_bound_work(3);
        cprintf("Medium task completed\n");
        exit(0);
    }
    pids[2] = pid;
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
    }
    
    cprintf("\nTest 4 completed.\n");
}

// 测试场景5：公平性测试（用于RR和Stride比较）
void test_fairness(void) {
    cprintf("\n========================================\n");
    cprintf("Test 5: Fairness Test\n");
    cprintf("========================================\n");
    cprintf("Creating 3 equal-priority processes\n\n");
    
    int pids[3];
    
    for (int i = 0; i < 3; i++) {
        int pid = fork();
        if (pid == 0) {
            cprintf("Process %d started\n", i+1);
            
            lab6_setpriority(1);  // 相同优先级
            
            volatile int count = 0;
            for (int j = 0; j < 5000000; j++) {
                count++;
                if (count % 1000000 == 0) {
                    cprintf("P%d: %d iterations\n", i+1, count);
                }
            }
            
            cprintf("Process %d completed, total iterations: %d\n", i+1, count);
            exit(0);
        } else {
            pids[i] = pid;
        }
    }
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
    }
    
    cprintf("\nTest 5 completed.\n");
}

int main(void) {
    cprintf("\n");
    cprintf("###############################################\n");
    cprintf("#    Scheduling Algorithm Comparison Test     #\n");
    cprintf("###############################################\n");
    cprintf("\nCurrent scheduler will be used for all tests.\n");
    cprintf("Run this test with different schedulers to compare.\n");
    
    // 运行所有测试
    test_cpu_bound_mix();
    test_sjf_scenario();
    test_priority_scenario();
    test_mlfq_scenario();
    test_fairness();
    
    cprintf("\n###############################################\n");
    cprintf("#           All Tests Completed               #\n");
    cprintf("###############################################\n");
    
    return 0;
}
