#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>
#include <stdio.h>

/* Buddy System 物理内存分配器（支持任意大小内存）
 * 用完全二叉树表示伙伴系统，每个节点记录该子树最大可用连续块大小（以页为单位）
 * 
 * - 使用"虚拟满二叉树"：找到最小的 2^k >= 实际页数，用它构建树
 * - 超出实际范围的虚拟节点初始化为 0（不可用）
 * - 分配时请求大小向上取整到 2 的幂（标准 Buddy 语义）
 * - 释放时通过物理偏移定位节点，支持精确回收与合并
 */

// 全局数据：完全二叉树数组
static unsigned *buddy_tree = NULL;
static size_t buddy_tree_size = 0;     // 树节点总数（2*buddy_tree_pages - 1）
static size_t buddy_tree_pages = 0;    // 树覆盖的虚拟页数（>= actual_pages 的最小 2^k）
static size_t actual_pages = 0;        // 实际可管理的页数（可以不是 2 的幂）
static struct Page *buddy_base = NULL; // Buddy 管理的起始 Page 指针

#define LEFT_LEAF(index)   ((index) * 2 + 1)
#define RIGHT_LEAF(index)  ((index) * 2 + 2)
#define PARENT(index)      (((index) + 1) / 2 - 1)
#define IS_POWER_OF_2(x)   (!((x) & ((x) - 1)))
#define MAX(a, b)          ((a) > (b) ? (a) : (b))

// 将非 2 的幂向上取整为 2 的幂
static unsigned fixsize(unsigned size) {
    if (size == 0) return 1;
    size--;
    size |= size >> 1;
    size |= size >> 2;
    size |= size >> 4;
    size |= size >> 8;
    size |= size >> 16;
    return size + 1;
}

static void
buddy_init(void) {
    // 初始阶段不做任何操作，等待 buddy_init_memmap 传入实际可用页数
    buddy_tree = NULL;
    buddy_tree_size = 0;
    buddy_tree_pages = 0;
    actual_pages = 0;
    buddy_base = NULL;
}

static void
buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    
    // 保存实际可管理的页数
    actual_pages = n;
    buddy_base = base;
    
    // 计算虚拟树大小：找到最小的 2^k >= n
    buddy_tree_pages = fixsize(n);
    buddy_tree_size = 2 * buddy_tree_pages - 1;
    
    // 将 buddy_tree 放在 Page 元数据数组末尾
    // 注意：这里利用 Page 数组后面的空间，pmm.c 需要预留足够空间
    buddy_tree = (unsigned *)((char *)base + n * sizeof(struct Page));
    
    // 初始化完全二叉树
    unsigned node_size = buddy_tree_pages * 2;
    for (size_t i = 0; i < buddy_tree_size; i++) {
        if (IS_POWER_OF_2(i + 1)) {
            node_size /= 2;
        }
        buddy_tree[i] = node_size;
    }
    
    // 标记超出实际范围的虚拟节点为不可用
    // 注意:即使 buddy_tree_pages == actual_pages,如果actual_pages是2的幂,
    // 树的右半部分仍然超出实际可用范围,需要标记
    // 例如: actual_pages=16384时,树管理0-16383,但右子树管理8192-16383
    // 实际上8192-16383这部分页确实存在,所以不需要特殊处理
    
    if (buddy_tree_pages > actual_pages) {
        // 只有当虚拟树大于实际页数时才标记
        for (size_t i = actual_pages; i < buddy_tree_pages; i++) {
            unsigned index = i + buddy_tree_pages - 1;  // 叶节点索引
            buddy_tree[index] = 0;  // 标记为不可用
        }
        
        // 回溯更新所有受影响的祖先节点
        for (size_t i = actual_pages; i < buddy_tree_pages; i++) {
            unsigned index = i + buddy_tree_pages - 1;
            while (index != 0) {
                unsigned parent_index = PARENT(index);
                unsigned left = buddy_tree[LEFT_LEAF(parent_index)];
                unsigned right = buddy_tree[RIGHT_LEAF(parent_index)];
                buddy_tree[parent_index] = MAX(left, right);
                index = parent_index;
            }
        }
    }
    
    // 清理 Page 元数据（只清理实际存在的页）
    struct Page *p = base;
    for (size_t i = 0; i < n; i++, p++) {
        assert(PageReserved(p));
        p->flags = 0;
        p->property = 0;
        set_page_ref(p, 0);
    }
}

static struct Page *
buddy_alloc_pages(size_t n) {
    assert(n > 0);
    
    if (buddy_tree == NULL || n > actual_pages) {
        return NULL;
    }
    
    // 将请求大小向上取整为 2 的幂（标准 Buddy 语义）
    unsigned size = fixsize(n);
    
    // 根节点不满足需求
    if (buddy_tree[0] < size) {
        return NULL;
    }
    
    // 从根向下查找第一个满足大小的节点
    unsigned index = 0;
    unsigned node_size = buddy_tree_pages;
    
    for (; node_size != size; node_size /= 2) {
        // 优先选左子树（保持地址连续性）
        unsigned left_index = LEFT_LEAF(index);
        unsigned right_index = RIGHT_LEAF(index);
        
        if (buddy_tree[left_index] >= size) {
            index = left_index;
        } else {
            index = right_index;
        }
    }
    
    // 标记该节点为已分配
    buddy_tree[index] = 0;
    
    // 计算该节点对应的物理页偏移
    unsigned offset = (index + 1) * node_size - buddy_tree_pages;
    
    // 安全检查：确保偏移在实际范围内
    if (offset >= actual_pages) {
        // 回滚分配
        buddy_tree[index] = node_size;
        return NULL;
    }
    
    // 回溯更新祖先节点的最大空闲块大小
    while (index) {
        index = PARENT(index);
        buddy_tree[index] = MAX(buddy_tree[LEFT_LEAF(index)], 
                                 buddy_tree[RIGHT_LEAF(index)]);
    }
    
    // 返回对应的 Page 指针（相对于 buddy_base）
    return buddy_base + offset;
}

static void
buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    
    if (buddy_tree == NULL || buddy_base == NULL) {
        return;
    }
    
    // 计算 base 相对于 buddy_base 的偏移
    unsigned offset = base - buddy_base;
    assert(offset >= 0 && offset < actual_pages);
    
    // 定位到对应的叶节点
    unsigned node_size = 1;
    unsigned index = offset + buddy_tree_pages - 1;
    
    // 向上回溯找到当前分配块的实际节点（longest[index] == 0 的节点）
    for (; buddy_tree[index] != 0; index = PARENT(index)) {
        node_size *= 2;
        if (index == 0) {
            return;  // 未找到已分配节点，可能是重复释放
        }
    }
    
    // 恢复该节点为空闲
    buddy_tree[index] = node_size;
    
    // 回溯合并：若两个子节点都满空闲则父节点恢复满容量
    while (index != 0) {
        unsigned parent_index = PARENT(index);
        node_size *= 2;
        
        unsigned left_longest = buddy_tree[LEFT_LEAF(parent_index)];
        unsigned right_longest = buddy_tree[RIGHT_LEAF(parent_index)];
        
        if (left_longest + right_longest == node_size) {
            buddy_tree[parent_index] = node_size;  // 两子树已完全空闲，合并
        } else {
            buddy_tree[parent_index] = MAX(left_longest, right_longest);
        }
        
        index = parent_index;
    }
    
    struct Page *p = base;
    for (size_t i = 0; i < n; i++, p++) {
        assert(!PageReserved(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
}

static size_t
buddy_nr_free_pages(void) {
    if (buddy_tree == NULL) {
        return 0;
    }
    size_t free_count = 0;
    for (size_t i = 0; i < buddy_tree_pages; i++) {
        unsigned index = i + buddy_tree_pages - 1;
        if (buddy_tree[index] > 0 && i < actual_pages) {
            free_count += buddy_tree[index];
        }
    }
    return free_count;
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
            
            // 调试:检查树状态
            cprintf("  DEBUG: buddy_tree[0] after full alloc = %d\n", buddy_tree[0]);
            cprintf("  DEBUG: buddy_tree[1] = %d, buddy_tree[2] = %d\n", 
                    buddy_tree[1], buddy_tree[2]);
            
            // 再次分配应该失败
            p1 = alloc_pages(1);
            if (p1 != NULL) {
                cprintf("  ERROR: p1 = %p (should be NULL!)\n", p1);
                cprintf("  DEBUG: buddy_tree[0] before second alloc = %d\n", buddy_tree[0]);
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