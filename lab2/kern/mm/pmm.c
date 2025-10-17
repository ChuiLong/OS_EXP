#include <default_pmm.h>
#include <best_fit_pmm.h>
#include <slub_pmm.h>
#include <defs.h>
#include <error.h>
#include <memlayout.h>
#include <mmu.h>
#include <pmm.h>
#include <sbi.h>
#include <stdio.h>
#include <string.h>
#include <riscv.h>
#include <dtb.h>

/*
 * 全局变量声明
 */
// 物理页面数组的虚拟地址，用于管理所有的物理页面
struct Page *pages;

// 系统中物理内存页面的总数
size_t npage = 0;

// 内核映射的虚拟地址和物理地址之间的偏移量
// VA（虚拟地址）= KERNBASE，PA（物理地址）= info.base
uint64_t va_pa_offset;

// RISC-V 中内存起始地址为 0x80000000
// DRAM_BASE 在 riscv.h 中定义为 0x80000000
// nbase 表示内存起始地址对应的页面号
const size_t nbase = DRAM_BASE / PGSIZE;

// virtual address of boot-time page directory
uintptr_t *satp_virtual = NULL;
// physical address of boot-time page directory
uintptr_t satp_physical;

// physical memory management
const struct pmm_manager *pmm_manager;

static void check_alloc_page(void);

// init_pmm_manager - initialize a pmm_manager instance
/*
 * init_pmm_manager - 初始化物理内存管理器
 *
 * 功能：
 * 1. 选择并初始化物理内存管理器（这里使用 slub_pmm_manager）
 * 2. 打印当前使用的内存管理器名称
 * 3. 调用选定的内存管理器的初始化函数
 *
 * 调用时机：在系统启动时，在进行任何内存分配之前必须先调用此函数
 */
static void init_pmm_manager(void)
{
    pmm_manager = &best_fit_pmm_manager;                       // 设置内存管理器
    cprintf("memory management: %s\n", pmm_manager->name); // 打印管理器名称
    pmm_manager->init();                                   // 初始化内存管理器
}

// init_memmap - call pmm->init_memmap to build Page struct for free memory
/*
 * init_memmap - 初始化物理内存映射
 * @base: 需要初始化的空闲内存块的第一个页
 * @n: 要初始化的页面数量
 *
 * 功能：
 * 1. 调用当前内存管理器的 init_memmap 函数
 * 2. 将一段物理内存标记为可用
 * 3. 建立对应的 Page 结构体来管理这些页面
 *
 * 调用时机：在探测到可用物理内存后，需要将这些内存初始化为可用状态时调用
 */
static void init_memmap(struct Page *base, size_t n)
{
    pmm_manager->init_memmap(base, n); // 调用当前内存管理器的初始化函数
}

// alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE
// memory
/*
 * alloc_pages - 分配连续的物理页面
 * @n: 需要分配的页面数量
 *
 * 功能：
 * 1. 调用当前内存管理器的 alloc_pages 函数
 * 2. 分配 n 个连续的物理页面
 * 3. 返回分配到的第一个页面的 Page 结构体指针
 *
 * 返回值：
 * - 成功：返回分配的第一个页面的 Page 结构体指针
 * - 失败：返回 NULL
 *
 * 注意：这里可以实现自己的物理内存分配算法，
 * 可以参考 nr_free_pages() 函数了解内存管理器的工作原理
 */
struct Page *alloc_pages(size_t n)
{
    return pmm_manager->alloc_pages(n); // 调用当前内存管理器的页面分配函数
}

// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n)
{
    // 在这里编写你的物理内存释放算法。
    // 你可以参考nr_free_pages() 函数进行设计，
    // 了解物理内存管理器的工作原理，然后在这里实现自己的释放算法。
    // 实现算法后，调用 pmm_manager->free_pages(base, n) 来释放物理内存。
    pmm_manager->free_pages(base, n);
}

// nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE)
// of current free memory
size_t nr_free_pages(void)
{
    return pmm_manager->nr_free_pages();
}

/*
 * page_init - 初始化物理内存页面管理系统
 *
 * 功能：
 * 1. 设置虚拟地址和物理地址的偏移量
 * 2. 获取系统可用物理内存的起始地址和大小
 * 3. 初始化物理页面的管理结构
 * 4. 标记内核使用的内存页面为已保留
 * 5. 初始化可用的物理内存页面
 *
 * 初始化步骤：
 * 1. 设置 VA 和 PA 的偏移
 * 2. 获取内存信息
 * 3. 检查内存配置的有效性
 */
static void page_init(void)
{
    // 设置虚拟地址和物理地址的偏移量
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;

    // 获取物理内存的起始地址和大小
    uint64_t mem_begin = get_memory_base();
    uint64_t mem_size = get_memory_size();
    if (mem_size == 0)
    {
        panic("DTB memory info not available");
    }
    uint64_t mem_end = mem_begin + mem_size;

    cprintf("physcial memory map:\n");
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
            mem_end - 1);

    uint64_t maxpa = mem_end;

    if (maxpa > KERNTOP)
    {
        maxpa = KERNTOP;
    }

    extern char end[];

    npage = maxpa / PGSIZE;
    // kernel在end[]结束, pages是剩下的页的开始
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);

    for (size_t i = 0; i < npage - nbase; i++)
    {
        SetPageReserved(pages + i);
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));

    mem_begin = ROUNDUP(freemem, PGSIZE);
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
    if (freemem < mem_end)
    {
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
/*
 * pmm_init - 物理内存管理系统的总初始化函数
 *
 * 功能：
 * 1. 初始化物理内存管理器（颗粒度为4KB或其他大小）
 * 2. 探测和初始化物理内存空间
 * 3. 建立页表
 * 4. 验证内存分配/释放功能的正确性
 *
 * 初始化流程：
 * 1. 初始化物理内存管理器（支持first_fit/best_fit/worst_fit/buddy_system等算法）
 * 2. 探测物理内存空间，标记已使用内存
 * 3. 初始化空闲页面列表
 * 4. 进行内存分配功能的正确性检查
 */
void pmm_init(void)
{
    // 初始化物理内存管理器
    // 该框架定义在 pmm.h 中，支持多种内存分配算法
    // 当前支持 first_fit/best_fit/worst_fit/buddy_system
    init_pmm_manager();

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();

    // use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();

    extern char boot_page_table_sv39[];
    satp_virtual = (pte_t *)boot_page_table_sv39;
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

/*
 * check_alloc_page - 检查页面分配功能是否正常
 *
 * 功能：
 * 1. 调用当前内存管理器的检查函数
 * 2. 验证内存分配和释放操作的正确性
 * 3. 打印检查结果
 *
 * 注意：这是一个内部测试函数，用于确保内存管理系统正常工作
 */
static void check_alloc_page(void)
{
    pmm_manager->check();                       // 执行内存管理器的检查函数
    cprintf("check_alloc_page() succeeded!\n"); // 打印检查成功信息
}
