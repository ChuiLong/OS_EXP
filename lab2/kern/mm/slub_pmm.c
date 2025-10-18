#include <pmm.h>
#include <list.h>
#include <string.h>
#include <slub_pmm.h>
#include <stdio.h>
#include <mmu.h>

/* SLUB (Unqueued SLab allocator) 内存分配器
 * 
 * create by: 王为（2311605）
 * 核心设计思想：
 * 
 * 1. 【两层架构】
 *    - 第一层：页级分配（通过伙伴系统/pmm_manager分配整页）
 *    - 第二层：对象级分配（在页上划分固定大小对象）
 *
 * 2. 【三级缓存】
 *    - CPU freelist：正在使用的slab，快速路径，O(1)分配
 *    - CPU partial：本地CPU的partial slab链表，无锁访问
 *    - Node partial：所有CPU共享的partial slab链表，需要加锁
 *
 * 3. 【指针内置】
 *    - 在空闲对象内部存储下一个对象的地址
 *    - 形成单链表，无需额外存储空间
 *    - freelist指向第一个空闲对象
 *
 * 4. 【状态转换】
 *    - Empty slab（完全空闲）
 *    - Partial slab（部分使用）
 *    - Full slab（完全使用，无链表管理）
 */

// ==================== 全局变量 ====================

// 全局SLUB管理器实例
static struct slub_manager slub_mgr;

// 预定义的对象大小（字节）：16, 32, 64, 128, 256, 512, 1024, 2048
static const size_t slub_sizes[SLUB_CACHE_NUM] = {
    16, 32, 64, 128, 256, 512, 1024, 2048
};

// ==================== 第一层：页级分配接口 ====================

/**
 * slub_init - 初始化SLUB管理器
 * 
 * Linux风格初始化：
 * 1. 初始化底层pmm_manager
 * 2. 创建多个kmem_cache（类似kmalloc-16, kmalloc-32...）
 * 3. 初始化per-cpu和per-node结构
 */
void slub_init(void) {
    cprintf("========== SLUB Init (Linux Style) ==========\n");
    cprintf("Initializing SLUB allocator...\n");
    
    // 设置底层页分配器
    extern const struct pmm_manager default_pmm_manager;
    slub_mgr.base_pmm = &default_pmm_manager;
    
    // 调用底层初始化
    if (slub_mgr.base_pmm->init) {
        slub_mgr.base_pmm->init();
    }
    
    // 初始化所有cache（类似Linux的kmalloc_caches[]）
    for (int i = 0; i < SLUB_CACHE_NUM; i++) {
        struct kmem_cache *s = &slub_mgr.caches[i];
        
        // 基本属性
        s->object_size = slub_sizes[i];
        s->size = SLUB_ALIGN_SIZE(slub_sizes[i]);
        
        // 计算每页对象数
        // 注意：不需要额外的slub_page结构，直接使用struct Page
        s->objects = PGSIZE / s->size;
        
        // freelist指针存储在对象开头（指针内置）
        s->offset = 0;
        
        // CPU partial配置
        s->cpu_partial = SLUB_CPU_PARTIAL;
        s->min_partial = 5;
        
        // 初始化per-cpu缓存
        s->cpu_slab.freelist = NULL;
        s->cpu_slab.page = NULL;
        s->cpu_slab.partial = NULL;
        
        // 初始化per-node缓存
        s->node.nr_partial = 0;
        list_init(&s->node.partial);
        
        // 设置名称
        static char cache_names[SLUB_CACHE_NUM][32];
        snprintf(cache_names[i], 32, "kmem_cache_%d", (int)slub_sizes[i]);
        s->name = cache_names[i];
        
        cprintf("  [%d] %s: object_size=%d, objects_per_page=%d\n", 
                i, s->name, (int)s->object_size, s->objects);
    }
    
    cprintf("SLUB initialization complete!\n");
    cprintf("=============================================\n");
}

/**
 * slub_init_memmap - 初始化内存映射
 */
void slub_init_memmap(struct Page *base, size_t n) {
    cprintf("slub_init_memmap: base=%p, n=%d pages\n", base, (int)n);
    assert(slub_mgr.base_pmm != NULL);
    slub_mgr.base_pmm->init_memmap(base, n);
}

/**
 * slub_alloc_pages - 第一层：页级分配
 */
struct Page *slub_alloc_pages(size_t n) {
    assert(slub_mgr.base_pmm != NULL);
    struct Page *page = slub_mgr.base_pmm->alloc_pages(n);
    if (page) {
        cprintf("slub_alloc_pages: %d pages at %p\n", (int)n, page);
    }
    return page;
}

/**
 * slub_free_pages - 第一层：页级释放
 */
void slub_free_pages(struct Page *base, size_t n) {
    cprintf("slub_free_pages: %d pages at %p\n", (int)n, base);
    assert(slub_mgr.base_pmm != NULL);
    slub_mgr.base_pmm->free_pages(base, n);
}

/**
 * slub_nr_free_pages - 返回空闲页数
 */
size_t slub_nr_free_pages(void) {
    assert(slub_mgr.base_pmm != NULL);
    return slub_mgr.base_pmm->nr_free_pages();
}

// ==================== 第二层：对象级分配（Linux SLUB核心）====================

/**
 * get_freepointer - 获取对象中存储的下一个对象指针
 * 
 * Linux SLUB核心技巧：指针内置
 * 在空闲对象的开头（offset位置）存储下一个空闲对象的地址
 */
void *get_freepointer(struct kmem_cache *s, void *object) {
    return *(void **)(object + s->offset);
}

/**
 * set_freepointer - 设置对象中的下一个对象指针
 */
void set_freepointer(struct kmem_cache *s, void *object, void *fp) {
    *(void **)(object + s->offset) = fp;
}

/**
 * get_kmem_cache - 根据大小选择合适的cache
 * 类似Linux的kmalloc_index()
 */
struct kmem_cache *get_kmem_cache(size_t size) {
    size = SLUB_ALIGN_SIZE(size);
    
    if (size < SLUB_MIN_SIZE || size > SLUB_MAX_SIZE) {
        return NULL;
    }
    
    // 找到第一个大于等于size的cache
    for (int i = 0; i < SLUB_CACHE_NUM; i++) {
        if (slub_mgr.caches[i].object_size >= size) {
            return &slub_mgr.caches[i];
        }
    }
    
    return NULL;
}

/**
 * init_slab_page - 初始化一个新的slab页
 * 
 * 将页划分为多个对象，并建立freelist链表
 * 使用指针内置方式：在每个对象开头存储下一个对象的地址
 */
static void init_slab_page(struct kmem_cache *s, struct Page *page) {
    extern uint64_t va_pa_offset;
    uintptr_t page_addr = page2pa(page) + va_pa_offset;
    
    void *start = (void *)page_addr;
    void *p = start;
    void *end = start + s->objects * s->size;
    
    // 建立freelist链表（指针内置）
    for (p = start; p + s->size < end; p += s->size) {
        set_freepointer(s, p, p + s->size);
    }
    set_freepointer(s, p, NULL);  // 最后一个对象指向NULL
    
    // 设置page的freelist
    page_set_freelist(page, start);
    page_set_cache(page, s);
    
    // 使用ref字段存储inuse（已使用对象数）
    page->ref = 0;
    
    cprintf("init_slab_page: cache=%s, page=%p, freelist=%p\n", 
            s->name, page, start);
}

/**
 * new_slab - 从伙伴系统分配新slab
 * 
 * Linux SLUB流程：
 * 1. 从伙伴系统分配页
 * 2. 初始化slab（建立freelist）
 * 3. 返回page结构
 */
static struct Page *new_slab(struct kmem_cache *s) {
    struct Page *page = slub_alloc_pages(1);
    if (!page) {
        return NULL;
    }
    
    init_slab_page(s, page);
    cprintf("new_slab: allocated for cache %s\n", s->name);
    
    return page;
}

/**
 * __slab_alloc - 慢速路径分配
 * 
 * 当CPU freelist为空时的分配路径：
 * 1. 尝试从CPU partial获取
 * 2. 尝试从Node partial获取
 * 3. 分配新slab
 */
static void *__slab_alloc(struct kmem_cache *s) {
    struct Page *page;
    void *freelist;
    
    cprintf("__slab_alloc: slow path for %s\n", s->name);
    
    // 1. 尝试从CPU partial获取
    page = s->cpu_slab.partial;
    if (page) {
        cprintf("  -> from CPU partial\n");
        s->cpu_slab.partial = (struct Page *)page->page_link.next;
        s->cpu_slab.page = page;
        s->cpu_slab.freelist = (void **)page_freelist(page);
        return s->cpu_slab.freelist;
    }
    
    // 2. 尝试从Node partial获取
    if (!list_empty(&s->node.partial)) {
        cprintf("  -> from Node partial\n");
        list_entry_t *le = list_next(&s->node.partial);
        page = le2page(le, page_link);
        list_del(le);
        s->node.nr_partial--;
        
        s->cpu_slab.page = page;
        s->cpu_slab.freelist = (void **)page_freelist(page);
        return s->cpu_slab.freelist;
    }
    
    // 3. 分配新slab
    cprintf("  -> allocate new slab\n");
    page = new_slab(s);
    if (!page) {
        return NULL;
    }
    
    s->cpu_slab.page = page;
    s->cpu_slab.freelist = (void **)page_freelist(page);
    
    return s->cpu_slab.freelist;
}

/**
 * kmem_cache_alloc - 从cache分配对象
 * 
 * Linux SLUB分配流程（快速路径优先）：
 * 1. 【快速路径】从CPU freelist直接分配
 * 2. 【慢速路径】CPU freelist为空，调用__slab_alloc
 */
void *kmem_cache_alloc(struct kmem_cache *s) {
    void **freelist = s->cpu_slab.freelist;
    void *object;
    
    // 快速路径：从CPU freelist直接分配
    if (freelist) {
        object = (void *)freelist;
        s->cpu_slab.freelist = (void **)get_freepointer(s, object);
        
        // 更新inuse
        if (s->cpu_slab.page) {
            s->cpu_slab.page->ref++;
        }
        
        cprintf("kmem_cache_alloc: fast path, object=%p from %s\n", 
                object, s->name);
        return object;
    }
    
    // 慢速路径：freelist为空
    freelist = (void **)__slab_alloc(s);
    if (!freelist) {
        return NULL;
    }
    
    object = (void *)freelist;
    s->cpu_slab.freelist = (void **)get_freepointer(s, object);
    
    if (s->cpu_slab.page) {
        s->cpu_slab.page->ref++;
    }
    
    cprintf("kmem_cache_alloc: slow path, object=%p from %s\n", 
            object, s->name);
    return object;
}

/**
 * kmem_cache_free - 释放对象到cache
 * 
 * Linux SLUB释放流程：
 * 1. 判断是否属于当前CPU的slab
 * 2. 如果是，直接加入freelist（快速路径）
 * 3. 如果不是，需要处理不同情况（慢速路径）
 */
void kmem_cache_free(struct kmem_cache *s, void *object) {
    struct Page *page;
    
    cprintf("kmem_cache_free: object=%p to %s\n", object, s->name);
    
    // 找到对象所属的页
    extern uint64_t va_pa_offset;
    uintptr_t obj_addr = (uintptr_t)object;
    uintptr_t page_addr = ROUNDDOWN(obj_addr, PGSIZE);
    uintptr_t page_pa = page_addr - va_pa_offset;
    page = pa2page(page_pa);
    
    // 简化实现：直接加入当前CPU的freelist
    // 真实Linux会判断是否属于当前CPU的slab
    set_freepointer(s, object, s->cpu_slab.freelist);
    s->cpu_slab.freelist = (void **)object;
    
    if (page) {
        page->ref--;
        
        // 如果页完全空闲，考虑移到partial或释放
        if (page->ref == 0) {
            cprintf("  -> page becomes empty\n");
            // 简化：直接加入node partial
            if (s->node.nr_partial < s->min_partial) {
                list_add(&s->node.partial, &page->page_link);
                s->node.nr_partial++;
                cprintf("  -> moved to node partial\n");
            } else {
                // 释放回伙伴系统
                cprintf("  -> free page to buddy system\n");
                slub_free_pages(page, 1);
            }
        }
    }
}

// ==================== 第二层：便捷接口（类似kmalloc）====================

/**
 * slub_alloc - 按大小分配对象（类似kmalloc）
 */
void *slub_alloc(size_t size) {
    struct kmem_cache *s = get_kmem_cache(size);
    if (!s) {
        cprintf("slub_alloc: size %d out of range\n", (int)size);
        return NULL;
    }
    return kmem_cache_alloc(s);
}

/**
 * slub_free - 释放对象（类似kfree）
 * 
 * 注意：真实Linux会从对象地址找到所属cache
 * 这里简化为需要知道cache
 */
void slub_free_simple(void *objp, size_t size) {
    if (!objp) return;
    
    struct kmem_cache *s = get_kmem_cache(size);
    if (s) {
        kmem_cache_free(s, objp);
    }
}

// ==================== 测试 ====================

/**
 * slub_check - SLUB测试函数
 */
void slub_check(void) {
    cprintf("\n========== SLUB Check (Linux Style) ==========\n");
    
    // 先测试底层PMM
    if (slub_mgr.base_pmm->check) {
        cprintf("Running base PMM check...\n");
        slub_mgr.base_pmm->check();
    }
    
    cprintf("\n========== Testing SLUB Two-Layer Allocation ==========\n");
    
    // 测试第一层：页级分配
    cprintf("\n[Test 1] Page-level allocation:\n");
    struct Page *p0 = slub_alloc_pages(1);
    struct Page *p1 = slub_alloc_pages(2);
    assert(p0 && p1);
    cprintf("  ✓ Page allocation success\n");
    
    slub_free_pages(p0, 1);
    slub_free_pages(p1, 2);
    cprintf("  ✓ Page free success\n");
    
    // 测试第二层：对象级分配
    cprintf("\n[Test 2] Object-level allocation:\n");
    void *obj1 = slub_alloc(16);
    void *obj2 = slub_alloc(64);
    void *obj3 = slub_alloc(256);
    assert(obj1 && obj2 && obj3);
    cprintf("  ✓ Object allocation: 16B=%p, 64B=%p, 256B=%p\n", 
            obj1, obj2, obj3);
    
    slub_free_simple(obj1, 16);
    slub_free_simple(obj2, 64);
    slub_free_simple(obj3, 256);
    cprintf("  ✓ Object free success\n");
    
    // 测试批量分配
    cprintf("\n[Test 3] Batch allocation:\n");
    void *objs[10];
    for (int i = 0; i < 10; i++) {
        objs[i] = slub_alloc(32);
        assert(objs[i]);
    }
    cprintf("  ✓ Allocated 10 x 32B objects\n");
    
    for (int i = 0; i < 10; i++) {
        slub_free_simple(objs[i], 32);
    }
    cprintf("  ✓ Freed all objects\n");
    
    // 测试边界
    cprintf("\n[Test 4] Boundary test:\n");
    void *small = slub_alloc(SLUB_MIN_SIZE);
    void *large = slub_alloc(SLUB_MAX_SIZE);
    assert(small && large);
    cprintf("  ✓ Min/Max allocation success\n");
    
    slub_free_simple(small, SLUB_MIN_SIZE);
    slub_free_simple(large, SLUB_MAX_SIZE);
    cprintf("  ✓ Min/Max free success\n");
    
    slub_print_stats();
    
    cprintf("\n========== SLUB Check Passed! ==========\n");
}

/**
 * slub_print_stats - 打印统计信息
 */
void slub_print_stats(void) {
    cprintf("\n========== SLUB Statistics ==========\n");
    cprintf("Total caches: %d\n", SLUB_CACHE_NUM);
    
    for (int i = 0; i < SLUB_CACHE_NUM; i++) {
        struct kmem_cache *s = &slub_mgr.caches[i];
        cprintf("\nCache[%d] %s:\n", i, s->name);
        cprintf("  Object size: %d bytes (actual: %d)\n", 
                (int)s->size, (int)s->object_size);
        cprintf("  Objects per page: %d\n", s->objects);
        cprintf("  CPU freelist: %s\n", 
                s->cpu_slab.freelist ? "has objects" : "empty");
        cprintf("  CPU partial: %s\n", 
                s->cpu_slab.partial ? "has slabs" : "empty");
        cprintf("  Node partial slabs: %lu\n", s->node.nr_partial);
    }
    
    cprintf("\nBase PMM free pages: %d\n", (int)slub_nr_free_pages());
    cprintf("=====================================\n");
}



// ==================== PMM Manager接口 ====================

const struct pmm_manager slub_pmm_manager = {
    .name = "slub_pmm_manager (Linux Style)",
    .init = slub_init,
    .init_memmap = slub_init_memmap,
    .alloc_pages = slub_alloc_pages,
    .free_pages = slub_free_pages,
    .nr_free_pages = slub_nr_free_pages,
    .check = slub_check,
};
