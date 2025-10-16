#ifndef __KERN_MM_PMM_H__
#define __KERN_MM_PMM_H__

#include <assert.h>
#include <defs.h>
#include <memlayout.h>
#include <mmu.h>
#include <riscv.h>

/*
 * pmm_manager 是物理内存管理器的抽象类
 * 通过实现这个结构体中定义的方法，可以实现不同的物理内存管理算法
 * 例如 first-fit、best-fit、worst-fit、buddy system 等
 */
struct pmm_manager
{
    const char *name; // 物理内存管理器的名称

    /*
     * init - 初始化内存管理器
     * 功能：初始化内部描述和管理数据结构（如空闲块链表、空闲块数量等）
     */
    void (*init)(void);

    /*
     * init_memmap - 根据可用物理内存空间建立初始的数据结构
     * @参数：
     *   - base: 可用空闲物理内存的起始页
     *   - n: 可用物理内存页数
     */
    void (*init_memmap)(
        struct Page *base,
        size_t n);
    /*
     * alloc_pages - 分配连续的物理页面
     * @参数：
     *   - n: 需要分配的页面数
     * @返回值：分配的第一个页面的Page结构体指针
     * 具体分配策略由实现的算法决定（如first-fit、best-fit等）
     */
    struct Page *(*alloc_pages)(size_t n);

    /*
     * free_pages - 释放连续的物理页面
     * @参数：
     *   - base: 要释放的起始页面
     *   - n: 要释放的页面数
     */
    void (*free_pages)(struct Page *base, size_t n);

    /*
     * nr_free_pages - 获取当前空闲页面数
     * @返回值：系统中当前可用的空闲页面总数
     */
    size_t (*nr_free_pages)(void);

    /*
     * check - 检查内存管理器的正确性
     * 用于验证内存管理算法的实现是否正确
     */
    void (*check)(void);
};

extern const struct pmm_manager *pmm_manager;

void pmm_init(void);

struct Page *alloc_pages(size_t n);
void free_pages(struct Page *base, size_t n);
size_t nr_free_pages(void); // number of free pages

#define alloc_page() alloc_pages(1)
#define free_page(page) free_pages(page, 1)

/* *
 * PADDR - takes a kernel virtual address (an address that points above
 * KERNBASE),
 * where the machine's maximum 256MB of physical memory is mapped and returns
 * the
 * corresponding physical address.  It panics if you pass it a non-kernel
 * virtual address.
 * */
/*
 * PADDR - 将内核虚拟地址转换为物理地址
 * @参数：
 *   - kva: 内核虚拟地址（必须大于KERNBASE）
 * @返回值：对应的物理地址
 * @说明：
 *   - 只能用于内核空间地址（高于KERNBASE的地址）
 *   - 如果传入非内核空间地址会触发panic
 */
#define PADDR(kva)                                                 \
    ({                                                             \
        uintptr_t __m_kva = (uintptr_t)(kva);                      \
        if (__m_kva < KERNBASE)                                    \
        {                                                          \
            panic("PADDR called with invalid kva %08lx", __m_kva); \
        }                                                          \
        __m_kva - va_pa_offset;                                    \
    })

/* *
 * KADDR - takes a physical address and returns the corresponding kernel virtual
 * address. It panics if you pass an invalid physical address.
 * */
/*
#define KADDR(pa)                                                \
    ({                                                           \
        uintptr_t __m_pa = (pa);                                 \
        size_t __m_ppn = PPN(__m_pa);                            \
        if (__m_ppn >= npage) {                                  \
            panic("KADDR called with invalid pa %08lx", __m_pa); \
        }                                                        \
        (void *)(__m_pa + va_pa_offset);                         \
    })
*/
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

/*
 * 页面操作相关的内联函数
 */

/*
 * page2ppn - 将Page结构体指针转换为物理页号
 * @参数：Page结构体指针
 * @返回值：对应的物理页号
 */
static inline ppn_t page2ppn(struct Page *page)
{
    return page - pages + nbase;
}

/*
 * page2pa - 将Page结构体指针转换为物理地址
 * @参数：Page结构体指针
 * @返回值：对应的物理地址
 */
static inline uintptr_t page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
}

/*
 * 页面引用计数操作函数
 */

/*
 * page_ref - 获取页面的引用计数
 * @参数：Page结构体指针
 * @返回值：页面当前的引用计数
 */
static inline int page_ref(struct Page *page)
{
    return page->ref;
}

/*
 * set_page_ref - 设置页面的引用计数
 * @参数：
 *   - page：Page结构体指针
 *   - val：要设置的引用计数值
 */
static inline void set_page_ref(struct Page *page, int val)
{
    page->ref = val;
}

/*
 * page_ref_inc - 增加页面的引用计数
 * @参数：Page结构体指针
 * @返回值：增加后的引用计数
 */
static inline int page_ref_inc(struct Page *page)
{
    page->ref += 1;
    return page->ref;
}

/*
 * page_ref_dec - 减少页面的引用计数
 * @参数：Page结构体指针
 * @返回值：减少后的引用计数
 */
static inline int page_ref_dec(struct Page *page)
{
    page->ref -= 1;
    return page->ref;
}
/*
 * pa2page - 将物理地址转换为对应的Page结构体指针
 * @参数：物理地址
 * @返回值：对应的Page结构体指针
 * @说明：如果物理地址无效会触发panic
 */
static inline struct Page *pa2page(uintptr_t pa)
{
    if (PPN(pa) >= npage)
    {
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
}

/*
 * flush_tlb - 刷新TLB（Translation Lookaside Buffer）
 * @说明：通过执行RISC-V的sfence.vm指令刷新TLB
 */
static inline void flush_tlb()
{
    asm volatile("sfence.vm");
}

/*
 * bootstack, bootstacktop - 启动栈的起始和结束地址
 * 这些符号在entry.S中定义
 */
extern char bootstack[], bootstacktop[];

#endif /* !__KERN_MM_PMM_H__ */
