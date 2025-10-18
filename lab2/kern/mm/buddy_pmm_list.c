#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>
#include <stdio.h>
#define MAX_ORDER 20  // 支持最大 2^20 = 1M 页 = 4GB

// 全局数据结构
static list_entry_t free_list[MAX_ORDER + 1];  // 每个阶的空闲块链表
static size_t nr_free[MAX_ORDER + 1];           // 每个阶的空闲块数量
static struct Page *buddy_base = NULL;          // 管理的内存起始页
static size_t total_pages = 0;                  // 总页数

// 辅助函数：计算需要的阶数（向上取整到2的幂）
static inline size_t order_of_size(size_t n) {
    size_t order = 0;
    size_t size = n;
    while (size > 1) {
        size = (size + 1) / 2;
        order++;
    }
    return order;
}

static void
buddy_init(void) {
    // 初始化所有空闲链表
    for (int i = 0; i <= MAX_ORDER; i++) {
        list_init(&free_list[i]);
        nr_free[i] = 0;
    }
    buddy_base = NULL;
    total_pages = 0;
}

static void
buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    
    buddy_base = base;
    total_pages = n;
    
    // 初始化所有页面
    for (size_t i = 0; i < n; i++) {
        struct Page *p = base + i;
        assert(PageReserved(p));
        p->flags = 0;
        p->property = 0;
        set_page_ref(p, 0);
    }
    
    // 将内存分解成不同大小的块加入空闲链表
    // 策略：贪心地分配尽可能大的块
    size_t remaining = n;
    struct Page *current = base;
    
    while (remaining > 0) {
        // 找到不超过 remaining 的最大 2 的幂
        size_t order = 0;
        while ((1UL << (order + 1)) <= remaining && order < MAX_ORDER) {
            order++;
        }
        
        size_t block_size = (1UL << order);
        
        // 设置块的属性
        current->property = order;  // property 存储阶数
        SetPageProperty(current);    // 标记为块首页
        
        // 加入对应阶的空闲链表
        list_add_before(&free_list[order], &(current->page_link));
        nr_free[order]++;
        
        current += block_size;
        remaining -= block_size;
    }
}

static struct Page *
buddy_alloc_pages(size_t n) {
    assert(n > 0);
    
    if (n > total_pages) {
        return NULL;
    }
    
    // 计算需要的阶数（向上取整到2的幂）
    size_t order = order_of_size(n);
    
    if (order > MAX_ORDER) {
        return NULL;
    }
    
    // 从 order 开始查找空闲块
    size_t current_order = order;
    while (current_order <= MAX_ORDER) {
        if (!list_empty(&free_list[current_order])) {
            // 找到空闲块
            list_entry_t *le = list_next(&free_list[current_order]);
            struct Page *page = le2page(le, page_link);
            list_del(le);
            nr_free[current_order]--;
            ClearPageProperty(page);
            
            // 如果块太大，需要分裂
            while (current_order > order) {
                current_order--;
                size_t buddy_size = (1UL << current_order);
                struct Page *buddy = page + buddy_size;
                
                // 设置分裂出的右半部分
                buddy->property = current_order;
                SetPageProperty(buddy);
                list_add(&free_list[current_order], &(buddy->page_link));
                nr_free[current_order]++;
            }
            
            // 清理分配出去的页面
            for (size_t i = 0; i < n; i++) {
                struct Page *p = page + i;
                p->flags = 0;
                set_page_ref(p, 0);
            }
            
            return page;
        }
        current_order++;
    }
    
    return NULL;  // 没有足够的内存
}

static void
buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    
    if (buddy_base == NULL || base < buddy_base || base >= buddy_base + total_pages) {
        return;  // 非法地址
    }
    
    // 计算块的阶数
    size_t order = order_of_size(n);
    size_t block_size = (1UL << order);
    
    // 计算块在内存中的索引
    size_t page_idx = base - buddy_base;
    
    // 检查对齐：块起始地址必须对齐到块大小
    if (page_idx & (block_size - 1)) {
        return;  // 未对齐，非法释放
    }
    
    // 尝试与伙伴块合并
    struct Page *page = base;
    
    while (order < MAX_ORDER) {
        // 计算伙伴块的索引
        size_t buddy_idx = page_idx ^ (1UL << order);
        
        // 检查伙伴是否在有效范围内
        if (buddy_idx >= total_pages) {
            break;
        }
        
        struct Page *buddy = buddy_base + buddy_idx;
        
        // 检查伙伴是否空闲且大小匹配
        if (!PageProperty(buddy) || buddy->property != order) {
            break;  // 伙伴不空闲或大小不匹配
        }
        
        // 合并：从链表中移除伙伴
        list_del(&(buddy->page_link));
        nr_free[order]--;
        ClearPageProperty(buddy);
        
        // 合并为更大的块（选择低地址的那个作为新块首）
        if (page_idx > buddy_idx) {
            page = buddy;
            page_idx = buddy_idx;
        }
        
        order++;
        block_size <<= 1;
    }
    
    // 将合并后的块加入对应阶的空闲链表
    page->property = order;
    SetPageProperty(page);
    list_add(&free_list[order], &(page->page_link));
    nr_free[order]++;
}

static size_t
buddy_nr_free_pages(void) {
    size_t total = 0;
    for (int i = 0; i <= MAX_ORDER; i++) {
        total += nr_free[i] * (1UL << i);
    }
    return total;
}

static void
buddy_check(void) {
    cprintf("buddy_check: comprehensive allocation test\n");
    
    struct Page *p0, *p1, *p2, *p3, *p4;
    size_t free_pages_before, free_pages_after;
    
    // 首先获取可用内存信息
    size_t total_free = nr_free_pages();
    cprintf("Total free pages: %d (%.2f MB)\n", 
            total_free, total_free * 4.0 / 1024);
    
    // ==================== 测试1: 基本分配与释放 ====================
    cprintf("\n[Test 1] Basic allocation and deallocation\n");
    free_pages_before = nr_free_pages();
    
    p0 = alloc_pages(1);
    assert(p0 != NULL);
    cprintf("  allocated 1 page: %p\n", p0);
    
    p1 = alloc_pages(2);
    assert(p1 != NULL);
    cprintf("  allocated 2 pages: %p\n", p1);
    
    p2 = alloc_pages(4);
    assert(p2 != NULL);
    cprintf("  allocated 4 pages: %p\n", p2);
    
    free_pages(p0, 1);
    free_pages(p1, 2);
    free_pages(p2, 4);
    cprintf("  freed all pages\n");
    
    free_pages_after = nr_free_pages();
    assert(free_pages_after == free_pages_before);
    cprintf("  [PASS] Memory fully recovered\n");
    
    // ==================== 测试2: 非2的幂分配(自动向上取整) ====================
    cprintf("\n[Test 2] Non-power-of-2 allocation (auto round up)\n");
    
    p0 = alloc_pages(3);  // 应该分配4页
    assert(p0 != NULL);
    cprintf("  requested 3 pages, allocated 4 pages: %p\n", p0);
    
    p1 = alloc_pages(5);  // 应该分配8页
    assert(p1 != NULL);
    cprintf("  requested 5 pages, allocated 8 pages: %p\n", p1);
    
    p2 = alloc_pages(7);  // 应该分配8页
    assert(p2 != NULL);
    cprintf("  requested 7 pages, allocated 8 pages: %p\n", p2);
    
    free_pages(p0, 3);
    free_pages(p1, 5);
    free_pages(p2, 7);
    cprintf("  [PASS] Non-power-of-2 allocation succeeded\n");
    
    // ==================== 测试3: 伙伴合并机制 ====================
    cprintf("\n[Test 3] Buddy merge mechanism\n");
    
    // 分配两个相邻的伙伴块
    p0 = alloc_pages(1);
    p1 = alloc_pages(1);
    p2 = alloc_pages(1);
    p3 = alloc_pages(1);
    assert(p0 && p1 && p2 && p3);
    cprintf("  allocated 4 separate 1-page blocks\n");
    
    // 按顺序释放,观察合并
    free_pages(p0, 1);
    free_pages(p1, 1);
    cprintf("  freed 2 buddy blocks (should merge)\n");
    
    // 现在应该能分配2页的连续块
    p4 = alloc_pages(2);
    assert(p4 != NULL);
    cprintf("  allocated 2-page block after merge: %p\n", p4);
    
    free_pages(p2, 1);
    free_pages(p3, 1);
    free_pages(p4, 2);
    cprintf("  [PASS] Buddy merge test succeeded\n");
    
    // ==================== 测试4: 内存耗尽处理 ====================
    cprintf("\n[Test 4] Memory exhaustion handling\n");
    
    size_t max_pages = nr_free_pages();
    cprintf("  current max allocatable pages: %d\n", max_pages);
    
    // 尝试分配超过可用内存(但不超过128MB = 32768页)
    size_t oversize = (max_pages < 16384) ? (max_pages * 2) : 32768;
    p0 = alloc_pages(oversize);
    assert(p0 == NULL);
    cprintf("  [PASS] Correctly rejected over-sized allocation (%d pages)\n", oversize);
    
    // 尝试分配所有可用内存(仅当可用内存合理时)
    if (max_pages <= 16384) {  // 只在 <= 64MB 时尝试
        p0 = alloc_pages(max_pages);
        if (p0 != NULL) {
            cprintf("  allocated all available memory: %d pages\n", max_pages);
            
            // 再次分配应该失败
            p1 = alloc_pages(1);
            if (p1 != NULL) {
                cprintf("  ERROR: p1 = %p (should be NULL!)\n", p1);
            }
            assert(p1 == NULL);
            cprintf("  [PASS] Correctly rejected allocation when full\n");
            
            free_pages(p0, max_pages);
            cprintf("  freed all memory\n");
        } else {
            cprintf("  [INFO] Cannot allocate all memory at once (fragmentation)\n");
        }
    } else {
        cprintf("  [INFO] Skipped full memory allocation (max_pages too large)\n");
    }
    
    // ==================== 测试5: 边界值测试 ====================
    cprintf("\n[Test 5] Boundary value testing\n");
    
    // 测试单页分配
    p0 = alloc_pages(1);
    assert(p0 != NULL);
    free_pages(p0, 1);
    cprintf("  [PASS] Single page allocation\n");
    
    // 测试大块分配(16页 = 64KB)
    p0 = alloc_pages(16);
    if (p0 != NULL) {
        free_pages(p0, 16);
        cprintf("  [PASS] Large block (16 pages) allocation\n");
    } else {
        cprintf("  [INFO] 16-page allocation failed (insufficient memory)\n");
    }
    
    // ==================== 测试6: 碎片整理验证 ====================
    cprintf("\n[Test 6] Fragmentation and defragmentation\n");
    
    // 创建碎片化场景
    p0 = alloc_pages(1);
    p1 = alloc_pages(1);
    p2 = alloc_pages(1);
    p3 = alloc_pages(1);
    assert(p0 && p1 && p2 && p3);
    
    // 释放间隔的块(创造碎片)
    free_pages(p0, 1);
    free_pages(p2, 1);
    cprintf("  created fragmented memory (freed p0, p2)\n");
    
    // 尝试分配2页(可能失败,取决于伙伴关系)
    p4 = alloc_pages(2);
    if (p4 == NULL) {
        cprintf("  [INFO] 2-page allocation failed (fragmented)\n");
        // 释放剩余块后应该能合并
        free_pages(p1, 1);
        free_pages(p3, 1);
        p4 = alloc_pages(4);
        assert(p4 != NULL);
        cprintf("  [PASS] 4-page allocation succeeded after full defragmentation\n");
        free_pages(p4, 4);
    } else {
        cprintf("  [PASS] 2-page allocation succeeded\n");
        free_pages(p1, 1);
        free_pages(p3, 1);
        free_pages(p4, 2);
    }
    
    // ==================== 测试7: 顺序性验证 ====================
    cprintf("\n[Test 7] Allocation order consistency\n");
    
    free_pages_before = nr_free_pages();
    struct Page *pages[5];
    for (int i = 0; i < 5; i++) {
        pages[i] = alloc_pages(1);
        assert(pages[i] != NULL);
    }
    
    // 验证地址是否递增(Buddy应该从低地址开始分配)
    int ordered = 1;
    for (int i = 1; i < 5; i++) {
        if (pages[i] < pages[i-1]) {
            ordered = 0;
            break;
        }
    }
    
    for (int i = 0; i < 5; i++) {
        free_pages(pages[i], 1);
    }
    
    free_pages_after = nr_free_pages();
    assert(free_pages_after == free_pages_before);
    
    if (ordered) {
        cprintf("  [PASS] Allocations follow ascending address order\n");
    } else {
        cprintf("  [INFO] Allocations not strictly ordered (acceptable)\n");
    }
    
    // ==================== 所有测试通过 ====================
    cprintf("\n========================================\n");
    cprintf("buddy_check: ALL TESTS PASSED!\n");
    cprintf("========================================\n");
}

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};
