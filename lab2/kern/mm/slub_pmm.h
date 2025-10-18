#ifndef __KERN_MM_SLUB_PMM_H__
#define __KERN_MM_SLUB_PMM_H__

#include <pmm.h>
#include <list.h>
#include <defs.h>
#include <memlayout.h>

/* SLUB算法实现
 * create by: 王为（2311605）
 * 两层架构：
 * 【第一层】页级分配：通过底层pmm_manager分配整页内存（4KB为单位）
 * 【第二层】对象级分配：在页上划分成多个固定大小的对象
 * 
 * 三级缓存结构：
 * 1. CPU freelist - 正在使用的slab，快速路径
 * 2. CPU partial - 本地CPU的部分使用slab链表
 * 3. Node partial - 所有CPU共享的部分使用slab链表
 */

//配置参数
#define SLUB_MIN_SIZE       16      // 最小对象大小（字节）
#define SLUB_MAX_SIZE       2048    // 最大对象大小（字节）
#define SLUB_ALIGN          8       // 对齐大小
#define SLUB_CACHE_NUM      8       // cache数量（支持不同大小的对象）
#define SLUB_CPU_PARTIAL    10      // CPU partial最大空闲对象数

// 计算对齐后的大小
#define SLUB_ALIGN_SIZE(size) (((size) + SLUB_ALIGN - 1) & ~(SLUB_ALIGN - 1))

/* kmem_cache_cpu - Per-CPU本地缓存池（Linux SLUB核心结构）
 * 每个CPU独占，无需加锁，保证分配速度
 */
struct kmem_cache_cpu {
    void **freelist;                // 指向下一个可用对象（快速路径）
    struct Page *page;              // 当前正在使用的slab
    struct Page *partial;           // CPU本地partial链表头
};

/* kmem_cache_node - NUMA节点缓存池（简化为单节点）
 * 所有CPU共享，需要加锁保护
 */
struct kmem_cache_node {
    unsigned long nr_partial;       // partial链表中slab数量
    list_entry_t partial;           // 部分使用的slab链表
};

/* kmem_cache - SLUB缓存池描述符（核心数据结构）
 * 描述如何管理特定大小的对象
 */
struct kmem_cache {
    struct kmem_cache_cpu cpu_slab; // Per-CPU本地缓存
    
    // 对象属性
    size_t size;                    // 对象大小（对齐后）
    size_t object_size;             // 实际对象大小
    size_t offset;                  // freelist指针在对象中的偏移
    
    // Slab属性
    unsigned int objects;           // 每个slab的对象数
    unsigned int cpu_partial;       // CPU partial最大对象数
    
    // 统计信息
    unsigned long min_partial;      // Node partial最小slab数
    
    // 节点管理
    struct kmem_cache_node node;    // NUMA节点（简化为单节点）
    
    const char *name;               // Cache名称
};

/* SLUB管理器 - 管理所有cache */
struct slub_manager {
    struct kmem_cache caches[SLUB_CACHE_NUM];  // 预定义大小的cache数组
    const struct pmm_manager *base_pmm;         // 底层页分配器
};

// 使用struct Page的字段来存储SLUB信息
// Linux中的做法：复用struct page的字段
// 
// 注意：在64位系统中，指针是64位，property是32位不够用
// 我们巧妙地使用page_link的prev和next来存储SLUB信息
// 当page作为slab使用时，不在链表中，所以可以复用这些字段
#define page_freelist(page)         ((void *)((page)->page_link.prev))
#define page_set_freelist(page, fp) ((page)->page_link.prev = (list_entry_t *)(fp))
#define page_cache(page)            ((struct kmem_cache *)((page)->page_link.next))
#define page_set_cache(page, c)     ((page)->page_link.next = (list_entry_t *)(c))

// 外部接口函数
extern const struct pmm_manager slub_pmm_manager;

// 第一层：页级分配接口
void slub_init(void);
void slub_init_memmap(struct Page *base, size_t n);
struct Page *slub_alloc_pages(size_t n);
void slub_free_pages(struct Page *base, size_t n);
size_t slub_nr_free_pages(void);
void slub_check(void);

// 第二层：对象级别的分配接口（Linux SLUB风格）
void *kmem_cache_alloc(struct kmem_cache *cachep);
void kmem_cache_free(struct kmem_cache *cachep, void *objp);

// 辅助函数（在slub_pmm.c中实现）
void *get_freepointer(struct kmem_cache *s, void *object);
void set_freepointer(struct kmem_cache *s, void *object, void *fp);
struct kmem_cache *get_kmem_cache(size_t size);


void *slub_alloc(size_t size);
void slub_free_simple(void *objp, size_t size);

// 调试和统计函数
void slub_print_stats(void);

#endif /* ! __KERN_MM_SLUB_PMM_H__ */
