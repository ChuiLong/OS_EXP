#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>

/* In the first fit algorithm, the allocator keeps a list of free blocks (known as the free list) and,
   on receiving a request for memory, scans along the list for the first block that is large enough to
   satisfy the request. If the chosen block is significantly larger than that requested, then it is
   usually split, and the remainder added to the list as another free block.
   Please see Page 196~198, Section 8.2 of Yan Wei Min's chinese book "Data Structure -- C programming language"
*/
// LAB2 EXERCISE 1: YOUR CODE
// you should rewrite functions: default_init,default_init_memmap,default_alloc_pages, default_free_pages.
/*
 * Details of FFMA
 * (1) Prepare: In order to implement the First-Fit Mem Alloc (FFMA), we should manage the free mem block use some list.
 *              The struct free_area_t is used for the management of free mem blocks. At first you should
 *              be familiar to the struct list in list.h. struct list is a simple doubly linked list implementation.
 *              You should know howto USE: list_init, list_add(list_add_after), list_add_before, list_del, list_next, list_prev
 *              Another tricky method is to transform a general list struct to a special struct (such as struct page):
 *              you can find some MACRO: le2page (in memlayout.h), (in future labs: le2vma (in vmm.h), le2proc (in proc.h),etc.)
 * (2) default_init: you can reuse the  demo default_init fun to init the free_list and set nr_free to 0.
 *              free_list is used to record the free mem blocks. nr_free is the total number for free mem blocks.
 * (3) default_init_memmap:  CALL GRAPH: kern_init --> pmm_init-->page_init-->init_memmap--> pmm_manager->init_memmap
 *              This fun is used to init a free block (with parameter: addr_base, page_number).
 *              First you should init each page (in memlayout.h) in this free block, include:
 *                  p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c),
 *                  the bit PG_reserved is setted in p->flags)
 *                  if this page  is free and is not the first page of free block, p->property should be set to 0.
 *                  if this page  is free and is the first page of free block, p->property should be set to total num of block.
 *                  p->ref should be 0, because now p is free and no reference.
 *                  We can use p->page_link to link this page to free_list, (such as: list_add_before(&free_list, &(p->page_link)); )
 *              Finally, we should sum the number of free mem block: nr_free+=n
 * (4) default_alloc_pages: search find a first free block (block size >=n) in free list and reszie the free block, return the addr
 *              of malloced block.
 *              (4.1) So you should search freelist like this:
 *                       list_entry_t le = &free_list;
 *                       while((le=list_next(le)) != &free_list) {
 *                       ....
 *                 (4.1.1) In while loop, get the struct page and check the p->property (record the num of free block) >=n?
 *                       struct Page *p = le2page(le, page_link);
 *                       if(p->property >= n){ ...
 *                 (4.1.2) If we find this p, then it' means we find a free block(block size >=n), and the first n pages can be malloced.
 *                     Some flag bits of this page should be setted: PG_reserved =1, PG_property =0
 *                     unlink the pages from free_list
 *                     (4.1.2.1) If (p->property >n), we should re-caluclate number of the the rest of this free block,
 *                           (such as: le2page(le,page_link))->property = p->property - n;)
 *                 (4.1.3)  re-caluclate nr_free (number of the the rest of all free block)
 *                 (4.1.4)  return p
 *               (4.2) If we can not find a free block (block size >=n), then return NULL
 * (5) default_free_pages: relink the pages into  free list, maybe merge small free blocks into big free blocks.
 *               (5.1) according the base addr of withdrawed blocks, search free list, find the correct position
 *                     (from low to high addr), and insert the pages. (may use list_next, le2page, list_add_before)
 *               (5.2) reset the fields of pages, such as p->ref, p->flags (PageProperty)
 *               (5.3) try to merge low addr or high addr blocks. Notice: should change some pages's p->property correctly.
 */

/* 在首次适应（First Fit）算法中，分配器维护一个空闲块列表（称为空闲链表）。
   当收到内存请求时，它会扫描这个链表，寻找第一个足以满足请求的块。
   如果找到的块比请求的要大得多，那么它通常会被分割，
   剩余的部分作为一个新的空闲块被添加回链表中。
   详情请参阅严蔚敏《数据结构 -- C语言版》一书的第196~198页，8.2节。
*/
// 实验二 练习一：你的代码
// 你需要重写以下函数：default_init, default_init_memmap, default_alloc_pages, default_free_pages。
/*
 * FFMA (首次适应内存分配算法) 的实现细节
 * (1) 准备工作：为了实现首次适应内存分配算法（FFMA），我们需要用一个列表来管理空闲的内存块。
 * 结构体 free_area_t 就是用来管理空闲内存块的。首先，你应该
 * 熟悉 list.h 中的 list 结构体。struct list 是一个简单的双向链表实现。
 * 你应该知道如何使用：list_init, list_add(list_add_after), list_add_before, list_del, list_next, list_prev。
 * 另一个技巧是将一个通用的 list 结构体指针转换成一个特定结构体的指针（比如 struct page）：
 * 你可以找到一些宏定义来完成这个转换：le2page (在 memlayout.h 中)，(在未来的实验中还会有：le2vma (在 vmm.h 中), le2proc (在 proc.h 中) 等。)
 *
 * (2) default_init: 你可以复用示例中的 default_init 函数来初始化 free_list 并将 nr_free 设置为 0。
 * free_list 用于记录空闲的内存块。nr_free 是所有空闲内存块的总数。
 *
 * (3) default_init_memmap: 调用流程：kern_init --> pmm_init --> page_init --> init_memmap --> pmm_manager->init_memmap
 * 这个函数用于初始化一个空闲块（参数为：基地址 addr_base, 页数 page_number）。
 * 首先，你应该初始化这个空闲块中的每一页（struct Page，在 memlayout.h 中定义），包括：
 * - p->flags 应该设置 PG_property 位（表示此页是有效的。在 pmm_init 函数 (pmm.c) 中，
 * p->flags 的 PG_reserved 位已经被设置了）。
 * - 如果这一页是空闲的，并且它不是这个空闲块的第一页，那么 p->property 应该被设置为 0。
 * - 如果这一页是空闲的，并且它是这个空闲块的第一页，那么 p->property 应该被设置为这个块的总页数。
 * - p->ref 应该为 0，因为现在这一页是空闲的，没有被引用。
 * - 我们可以用 p->page_link 将这一页链接到 free_list 中（例如：list_add_before(&free_list, &(p->page_link));）。
 * 最后，我们应该对空闲块的数量进行累加：nr_free += n。
 *
 * (4) default_alloc_pages: 在空闲链表中搜索并找到第一个大小不小于 n 的空闲块，然后调整这个空闲块的大小，
 * 并返回分配好的内存块的地址。
 * (4.1) 你应该像这样搜索空闲链表：
 * list_entry_t le = &free_list;
 * while((le=list_next(le)) != &free_list) {
 * ....
 * }
 * (4.1.1) 在 while 循环中，获取 Page 结构体并检查 p->property (记录了空闲块的页数) 是否 >= n？
 * struct Page *p = le2page(le, page_link);
 * if(p->property >= n){ ...
 * (4.1.2) 如果我们找到了这个 p，就意味着我们找到了一个大小足够的空闲块，这个块的前 n 页可以被分配出去。
 * 这些被分配页的一些标志位需要被设置：PG_reserved = 1, PG_property = 0。
 * 并将这些页从空闲链表 free_list 中移除。
 * (4.1.2.1) 如果 (p->property > n)，我们应该重新计算这个空闲块剩余部分的大小，
 * （例如：(le2page(le,page_link))->property = p->property - n;）
 * 并将其作为一个新的空闲块放回链表中。
 * (4.1.3) 重新计算 nr_free (所有空闲页的总数)。
 * (4.1.4) 返回 p。
 * (4.2) 如果找不到大小足够 (>=n) 的空闲块，则返回 NULL。
 *
 * (5) default_free_pages: 将被释放的页重新链接回 free_list，并可能将小的空闲块合并成大的空闲块。
 * (5.1) 根据被回收块的基地址，搜索空闲链表，找到正确的位置
 * （按地址从低到高排序），然后插入这些页。（可能会用到 list_next, le2page, list_add_before）。
 * (5.2) 重置这些页的字段，比如 p->ref, p->flags (清除 PG_reserved 位)。
 * (5.3) 尝试与地址相邻的低地址或高地址的空闲块进行合并。注意：需要正确地修改某些页的 p->property 字段。
 */

static free_area_t free_area;

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

/*
 * default_init - 初始化物理内存管理器
 * @详细说明：
 * 1. 初始化空闲页面链表 free_list，使用 list_init 将其设置为空
 * 2. 将系统中的空闲页面数量 nr_free 初始化为 0
 * free_list 用于记录空闲的内存块。nr_free 是所有空闲内存块的总数。
 * @注意：这是物理内存管理器最基础的初始化步骤，在系统启动时最先被调用
 */
static void
default_init(void)
{
    list_init(&free_list); // 初始化空闲链表
    nr_free = 0;           // 初始化空闲页面数为0
}

/*
 * default_init_memmap - 始化一段新的空闲物理内存块
 * @参数：
 *   - base: 需要初始化的空闲内存块的第一个页
 *   - n: 本内存块中页的数量
 * @详细说明：
 * 这个函数会被用来初始化一段新发现的可用物理内存。它需要：
 * 1. 确保传入的页面数量大于0
 * 2. 对块中的每个页面进行初始化
 * 3. 设置块中第一个页面的属性值
 * 4. 将初始化好的页面加入到空闲列表中
 * 
 * default_init_memmap: 调用流程：kern_init --> pmm_init --> page_init --> init_memmap --> pmm_manager->init_memmap
 * 这个函数用于初始化一个空闲块（参数为：基地址 addr_base, 页数 page_number）。
 * 首先，你应该初始化这个空闲块中的每一页（struct Page，在 memlayout.h 中定义），包括：
 * - p->flags 应该设置 PG_property 位（表示此页是有效的。在 pmm_init 函数 (pmm.c) 中，
 * p->flags 的 PG_reserved 位已经被设置了）。
 * - 如果这一页是空闲的，并且它不是这个空闲块的第一页，那么 p->property 应该被设置为 0。
 * - 如果这一页是空闲的，并且它是这个空闲块的第一页，那么 p->property 应该被设置为这个块的总页数。
 * - p->ref 应该为 0，因为现在这一页是空闲的，没有被引用。
 * - 我们可以用 p->page_link 将这一页链接到 free_list 中（例如：list_add_before(&free_list, &(p->page_link));）。
 * 最后，我们应该对空闲块的数量进行累加：nr_free += n。
 */
static void
default_init_memmap(struct Page *base, size_t n)
{
    assert(n > 0); // 确保页面数量大于0
    struct Page *p = base;
    for (; p != base + n; p++)
    {
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);
    nr_free += n;
    if (list_empty(&free_list))
    {
        // 按地址顺序插入空闲链表
        list_add(&free_list, &(base->page_link));
    }
    else
    {
        list_entry_t *le = &free_list;
        while ((le = list_next(le)) != &free_list)
        {
            struct Page *page = le2page(le, page_link);
            if (base < page)
            {
                list_add_before(le, &(base->page_link));
                break;
            }
            else if (list_next(le) == &free_list)
            {
                // 按地址顺序插入空闲链表
                list_add(le, &(base->page_link));
            }
        }
    }
}

/*
 * default_alloc_pages - 分配n个连续的物理页面
 * @参数：
 *   - n: 需要分配的页面数量
 * @返回值：
 *   - 成功: 返回分配的第一个页面的指针
 *   - 失败: 返回 NULL
 * @实现要求：
 * 1. 在空闲链表中查找第一个大小不小于n的空闲块
 * 2. 如果找到了这样的空闲块：
 *    - 如果空闲块大小刚好等于n，直接分配整个块
 *    - 如果空闲块大小大于n，需要分割：分配前n页，剩余部分作为新的空闲块
 * 3. 更新分配块的标志位和空闲页面数量
 * @注意：这是首次适应算法的核心实现
 */
static struct Page *
default_alloc_pages(size_t n)
{
    assert(n > 0);
    if (n > nr_free)
    {
        return NULL;
    }
    struct Page *page = NULL;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
    {
        struct Page *p = le2page(le, page_link);
        // 找到第一个足够大的块
        if (p->property >= n)
        {
            page = p;
            break;
        }
    }
    if (page != NULL)
    {
        list_entry_t *prev = list_prev(&(page->page_link));
        list_del(&(page->page_link));
        if (page->property > n)
        // 分割空闲块
        {
            struct Page *p = page + n;
            p->property = page->property - n;
            SetPageProperty(p);
            list_add(prev, &(p->page_link));
        }
        nr_free -= n;
        ClearPageProperty(page);
    }
    return page;
}

/*
 * default_free_pages - 释放n个连续的物理页面
 * @参数：
 *   - base: 需要释放的空闲块的第一个页面
 *   - n: 要释放的页面数量
 * @详细说明：
 * 该函数需要完成以下工作：
 * 1. 将被释放的页面标记为可用状态
 * 2. 将这些页面按地址顺序插入到空闲链表中
 * 3. 尝试与相邻的空闲块进行合并，具体包括：
 *    - 如果释放块的后面有空闲块，尝试向后合并
 *    - 如果释放块的前面有空闲块，尝试向前合并
 * 4. 正确更新合并后块的大小信息
 * 5. 更新系统中的空闲页面总数
 * @注意：合并过程需要特别注意地址的连续性和页面属性的正确设置
 */
static void
default_free_pages(struct Page *base, size_t n)
{
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p++)
    {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    base->property = n;
    SetPageProperty(base);
    nr_free += n;

    if (list_empty(&free_list))
    {
        list_add(&free_list, &(base->page_link));
    }
    else
    {
        list_entry_t *le = &free_list;
        while ((le = list_next(le)) != &free_list)
        {
            struct Page *page = le2page(le, page_link);
            if (base < page)
            {
                list_add_before(le, &(base->page_link));
                break;
            }
            else if (list_next(le) == &free_list)
            {
                list_add(le, &(base->page_link));
            }
        }
    }

    list_entry_t *le = list_prev(&(base->page_link));
    if (le != &free_list)
    {
        p = le2page(le, page_link);
        if (p + p->property == base)
        {
            p->property += base->property;
            ClearPageProperty(base);
            list_del(&(base->page_link));
            base = p;
        }
    }

    le = list_next(&(base->page_link));
    if (le != &free_list)
    {
        p = le2page(le, page_link);
        if (base + base->property == p)
        {
            base->property += p->property;
            ClearPageProperty(p);
            list_del(&(p->page_link));
        }
    }
}

/*
 * default_nr_free_pages - 获取当前系统中空闲页面的总数
 * @返回值：当前系统中空闲的物理页面数量
 * @详细说明：
 * 1. 这个函数直接返回全局变量nr_free的值
 * 2. nr_free在分配和释放页面时会同步更新
 * 3. 这个函数常用于内存使用情况的统计和监控
 */
static size_t
default_nr_free_pages(void)
{
    return nr_free;
}

static void
basic_check(void)
{
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(p0 != p1 && p0 != p2 && p1 != p2);
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);

    assert(page2pa(p0) < npage * PGSIZE);
    assert(page2pa(p1) < npage * PGSIZE);
    assert(page2pa(p2) < npage * PGSIZE);

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    assert(alloc_page() == NULL);

    free_page(p0);
    free_page(p1);
    free_page(p2);
    assert(nr_free == 3);

    assert((p0 = alloc_page()) != NULL);
    assert((p1 = alloc_page()) != NULL);
    assert((p2 = alloc_page()) != NULL);

    assert(alloc_page() == NULL);

    free_page(p0);
    assert(!list_empty(&free_list));

    struct Page *p;
    assert((p = alloc_page()) == p0);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    free_list = free_list_store;
    nr_free = nr_free_store;

    free_page(p);
    free_page(p1);
    free_page(p2);
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
        count++, total += p->property;
    }
    assert(total == nr_free_pages());

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
    assert(p0 != NULL);
    assert(!PageProperty(p0));

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
    assert(alloc_pages(4) == NULL);
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
    assert((p1 = alloc_pages(3)) != NULL);
    assert(alloc_page() == NULL);
    assert(p0 + 2 == p1);

    p2 = p0 + 1;
    free_page(p0);
    free_pages(p1, 3);
    assert(PageProperty(p0) && p0->property == 1);
    assert(PageProperty(p1) && p1->property == 3);

    assert((p0 = alloc_page()) == p2 - 1);
    free_page(p0);
    assert((p0 = alloc_pages(2)) == p2 + 1);

    free_pages(p0, 2);
    free_page(p2);

    assert((p0 = alloc_pages(5)) != NULL);
    assert(alloc_page() == NULL);

    assert(nr_free == 0);
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
    }
    assert(count == 0);
    assert(total == 0);
}

const struct pmm_manager default_pmm_manager = {
    .name = "default_pmm_manager",
    .init = default_init,
    .init_memmap = default_init_memmap,
    .alloc_pages = default_alloc_pages,
    .free_pages = default_free_pages,
    .nr_free_pages = default_nr_free_pages,
    .check = default_check,
};
