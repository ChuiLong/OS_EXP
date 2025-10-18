# lab2

# 练习一：first-fit 连续物理内存分配算法

## 1.First-Fit算法基本思想

First-Fit（首次适配）算法的核心思想是：从空闲内存块链表的头部开始查找，选择第一个足够大的块进行分配。算法的具体实现方法如下：
1. 从空闲内存块链表的头部开始查找，选择第一个足够大的块进行分配。
2. 分割找到的块为已分配块和剩余块。已分配块的大小为请求的大小，剩余块的大小为原块大小减去已分配块的大小。
3. 将剩余块插入到空闲内存块链表中，保持链表的有序性。

**First-Fit** 算法在由 `default_pmm.c` 实现。该模块通过维护按物理地址排序的空闲块链表（free list）管理连续物理页面（struct Page）。关键函数包括：   `default_init`、`default_init_memmap`、`default_alloc_pages`、`default_free_pages`。下面，我们来分析 **First-Fit** 算法的实现过程、各函数职责、边界与异常情形，并提出可能的改进方向。

## 2. 环境与数据结构

- `struct Page`：表示物理页框（frame），含有字段 `flags`、`property`、`ref` 和 `page_link`（用于链表链接）。
- `free_area_t`：包含 `free_list`（循环双向链表哨兵）和 `nr_free`（空闲页总数）。
- 链表宏 ： `list_init`、`list_add`、`list_add_before`、`list_next`、`list_prev`、`list_empty`这些函数实现了链表的创建、插入、删除等链表结构的功能，`le2page` 等函数用于将通用链表项转换为 `Page` 并进行插入/删除操作。

以上数据结构与宏为实现 **First-Fit** 算法提供了基础功能框架。

## 3. 函数逐一分析

### 3.1 `default_init(void)`

  `default_init(void)`函数初始化内存管理器，为对空闲链表执行 `list_init(&free_list)` 建立一个空的链表哨兵节点（这个节点并不存储具体的空闲页，而是作为一个特殊节点，维护链表结构），并将 `nr_free = 0`初始化空闲页计数。

### 3.2 `default_init_memmap(struct Page *base, size_t n)`

- 作用：将一段连续的物理页面初始化为一个空闲块并插入 `free_list`，同时更新 `nr_free`，实现了将空闲页加入空闲链表（free_list）的功能。
- 主要步骤：
	1. 判断空闲页数是否大于0（`n > 0`）。
	2. 对该区间内每个 `Page` 执行初始化：清除 `flags` 和 `property`，将 `ref` 设为 0（`set_page_ref(p, 0)`）。
	3. 在区间首页 `base` 上设置 `base->property = n` 并调用 `SetPageProperty(base)` 标记为空闲块的首页。
	4. 更新总空闲块的页数 （`nr_free += n`）。
	5. 按物理地址从低到高把空闲页 `base` 插入到 `free_list`（遍历链表找到第一个 `page` 满足 `base < page` 的位置并 `list_add_before`，若链表为空或`base`的地址比当前链表中的节点地址都要大则直接添加至链表末尾）。

- 功能总结：函数将整段连续物理页面作为一个“可分配的块”插入到空闲链表中。链表按地址排序便于后续合并空闲链表的相邻块。

### 3.3 `default_alloc_pages(size_t n)`

- 作用：从空闲链表中 **First-fit** 策略分配 `n` 个连续页面，若找到第一个可分配的空闲块，则返回分配基地址（`struct Page *`），若失败返回 `NULL`。
- 主要步骤：
	1. 若 `n > nr_free` 则直接返回 `NULL`（全局可用页不足）。
	2. 遍历 `free_list`（从头开始），对每个空闲块 `p` 检查 `p->property >= n`。
	3. 找到第一个满足条件的块 `p`：
		 - 从链表中删除该块的链表项 `list_del(&(p->page_link))`（使其脱离空闲链表）。
		 - 若 `p->property == n`：将 `p` 直接返回（整块被分配）。
		 - 若 `p->property > n`：将块分割，令 `q = p + n`（指向剩余部分），设置 `q->property = p->property - n`、`SetPageProperty(q)`，并把 `q` 插回到链表（通过 `list_add(prev, &(q->page_link))` 将剩余部分接到原来 `p` 的前驱之后，以保持排序）；返回 `p` 前 `n` 页作为已分配页。
	4. 更新 `nr_free -= n` 并清除被分配块的 `PageProperty` 标志（`ClearPageProperty(p)`）。

- 功能总结：首次适配策略选择第一个足以满足请求的空闲块，从而避免扫描全部链表，简单易实现。

### 3.4 `default_free_pages(struct Page *base, size_t n)`

- 作用：释放以 `base` 为起始、长度为 `n` 页的内存块，并在 `free_list` 中按地址顺序插入该空闲块，同时尝试与前后相邻空闲块合并以减少碎片。
- 主要步骤：
	1. 对要释放的每页：判断该页是否既未被保留也不已标记为 PageProperty；清除 `flags` 并 `set_page_ref(p,0)`。
	2. 在 `base` 处设置 `base->property = n`、`SetPageProperty(base)`，`nr_free += n`。
	3. 按地址序将 `base` 插入 `free_list`（若链表为空直接添加，否则遍历找到首个大于 `base` 的 `page` 并 `list_add_before`，否则加到末尾）。
	4. 尝试向前合并：取 `le = list_prev(&(base->page_link))`，若 `le != &free_list` 且前一块 `p` 满足 `p + p->property == base`（地址连续），则执行合并：`p->property += base->property`、`ClearPageProperty(base)`、`list_del(&(base->page_link))`、`base = p`（将 `base` 指向合并后的块，以便后续再尝试向后合并）。
	5. 尝试向后合并：取 `le = list_next(&(base->page_link))`，若存在后继块 `p` 且 `base + base->property == p` 则合并：`base->property += p->property`、`ClearPageProperty(p)`、`list_del(&(p->page_link))`。

- 功能总结：该函数保证空闲链表按物理地址排序并尽可能合并相邻空闲块，从而在释放时减少外部碎片。

## 4. 分配过程综述（运行时流程）

总体分配流程如下：

1. 系统启动时，`default_init` 初始化管理器数据结构；当可用物理内存区段被注册进系统时，`default_init_memmap` 将这些区段插入 `free_list` 并更新 `nr_free`。
2. 当需要分配 `n` 页时，调用 `default_alloc_pages(n)`：
	 - 从链表头开始线性扫描直至找到第一个 `property >= n` 的块；
	 - 若块等于请求大小，直接移除并返回；若块大于请求大小则分割，返回前半部分并将剩余部分重新链接回链表；
	 - 更新全局空闲页计数 `nr_free` 并清理已分配块的 `PageProperty` 标志。
3. 当释放时，`default_free_pages(base, n)` 将块信息（property、flags、ref）设置并按地址插入链表，然后尝试与前后相邻的块合并。

## 5. 复杂度与空间行为分析

- 分配复杂度（平均/最坏）：首次适配在最坏情况下需要遍历整个 `free_list`，时间复杂度为 O(m)，其中 m 是空闲块的数量。平均复杂度依赖于空闲块分布与请求模式，但通常优于在高度碎片化情况下的全链表扫描。分割与链表操作为 O(1)。
- 释放与合并复杂度：插入按照地址顺序需要线性扫描以找到插入点（O(m)），但合并本身为 O(1)（只检查邻居）。
- 空间效率：首次适配倾向于在低地址段产生更多小碎片（长期运行中可能降低可用性），但合并策略在释放时缓解了部分碎片问题。

## 6. 算法问题与改进方向

### 6.1 问题汇总

- 链表遍历成本：`alloc` 与 `free` 都需要在最坏情况下对空闲链表进行线性扫描，导致当空闲块数较大时性能下降。
- 碎片性：首次适配会导致低地址区域频繁分割产生小碎片，影响后续大块分配。
- 并发访问：该实现未考虑并发环境下对 `free_list` 的同步（在更复杂系统需加锁或采用 lock-free 结构）。

### 6.2 进一步的改进空间

1. 使用分级空闲列表（segregated free lists）或按大小分类的桶（bins）：将空闲块按大小范围放入不同链表，分配时只需查询合适桶，从而显著减少搜索成本。
2. 引入平衡树或二叉堆（如红黑树、size-ordered tree）：支持按块大小高效查询（best-fit、closest-fit），同时能在 O(log m) 时间内进行插入/删除。
3. 使用位图或 buddy allocator（伙伴系统）：对固定尺寸块的管理非常高效，分配与释放复杂度低且易于合并，对物理页管理（2^k 大小）比较适配。
4. 延迟合并或合并优化：目前每次释放都进行邻居检查并合并，可考虑按需合并或合并阈值以平衡释放成本。
5. 并发控制：在多核场景下，为避免全局链表争用，可采用 lock-free 结构，在分配页表和释放页表时加锁，避免并发分配页表与释放页表时出现冲突。

## 7. 结论

`default_pmm` 模块通过维持按物理地址排序的空闲块链表，实现了一个语义清晰且容易验证的首次适配分配器。其优点在于实现简单、合并操作便捷；缺点为在大规模/碎片化场景下存在搜索开销和潜在的内存碎片问题。

# 练习二：Best-Fit物理内存分配算法

## 1. 算法概述

**Best-Fit** 算法是一种物理内存分配策略，其核心思想是：在所有足够大的空闲块中选择最小的一个进行分配。这种方法试图最小化内部碎片，提高内存利用率。

在 **Best-Fit** 算法的实现中，我们可以参考 `default_pmm` 模块中的 **First-Fit** 算法实现，主要区别在于在`alloc_pages` 中选择空闲块时，需要遍历整个空闲链表，找到最小的块进行分配，而其他函数实现方式保持不变。

那下面我们就对`best_fit_alloc_pages`进行详细分析。

## 2.页面分配实现
`best_fit_alloc_pages`相比于`default_alloc_pages`的修改代码如下：
```c
// 遍历空闲链表寻找最小的足够大的块
while ((le = list_next(le)) != &free_list) {
    struct Page *p = le2page(le, page_link);
    if (p->property >= n) {
        if (page == NULL || p->property < page->property) {
                page = p;
        }
    }
}
```
**实现思路**：我们首先遍历空闲链表，找到第一个足够大的块，并保存在变量`page`中。然后，我们继续循环遍历链表，将新找到的块与当前的`page`的property进行比较，并将`page`更新为较小的空闲块，最终我们找到最小的块，并保存在`page`中。

## 4. Best-Fit与First-Fit的关键区别

1. 选择策略：
   - First-Fit：选择第一个足够大的块
   - Best-Fit：选择最小的足够大的块

2. 时间效率：
   - First-Fit：因为找到第一个符合条件的块就停止，所以其平均情况下搜索时间较短
   - Best-Fit：总是需要扫描整个空闲链表以找到最优块，时间开销较大

3. 空间效率：
   - First-Fit：容易在前端产生小碎片，但分配速度快
   - Best-Fit：产生的碎片大小最小，但可能会产生更多难以利用的小碎片

4. 实现复杂度：
   - First-Fit：实现简单，维护成本低
   - Best-Fit：需要完整遍历，实现略复杂

## 5. 算法改进分析

### 5.1 核心问题

当前Best-Fit实现面临两个主要挑战：性能开销和内存碎片。
* **性能代销**：每次分配都需要完整遍历链表（O(n)复杂度）来找到最适合的块，这在空闲块数量较大时会造成显著延迟。
* **内存碎片**：虽然算法选择最适合的块，但这可能导致产生大量难以利用的小碎片，同时现有的合并策略也存在优化空间。

### 5.2 改进方案

1. 数据结构优化
```c
// 分级空闲列表：按大小范围分类管理
struct SizeClass {
    size_t min_size;        // 该类别最小大小
    size_t max_size;        // 该类别最大大小
    struct AVLTree* blocks; // 使用平衡树存储该大小范围的块
};

// 平衡树节点：支持快速查找最佳匹配块
struct AVLNode {
    size_t size;           // 块大小
    struct Page* page;     // 对应的页面
    uint32_t height;       // 树高度
    struct AVLNode *left, *right;
};
```

这种结构将空闲块按大小范围分类，并在每个类别内使用平衡树存储，可以将查找时间从O(n)优化到O(log n)。当需要分配内存时，先确定大小类别（O(1)），然后在对应的平衡树中查找最小的足够大的块。

2. 内存碎片管理
```c
struct PageAllocator {
    SizeClass classes[N_CLASSES];    // 分级空闲列表
    struct {
        size_t split_threshold;      // 分割阈值
        size_t merge_threshold;      // 合并阈值
        struct Page* hot_cache;      // 热点大小缓存
    } policy;
};
```

通过引入分配策略控制：
- 设置分割阈值：当剩余碎片小于阈值时不进行分割，避免产生过小碎片
- 延迟合并：不是每次释放都立即合并，而是当碎片达到一定程度时才触发合并
- 维护热点缓存：对常用大小的块进行预分配和缓存

这些机制协同工作，可以显著减少碎片，提高内存利用率。

在多核环境下，该结构还可以扩展为每CPU一个分配器：
```c
struct PerCPUAllocator {
    struct PageAllocator local;     // 本地分配器
    struct SharedPool* shared;      // 共享池
    char pad[CACHELINE_SIZE];      // 避免false sharing
};
```

这种设计不仅提高了性能，还通过本地缓存和共享池的分层结构降低了并发冲突。当本地分配器资源不足时，才需要与其他CPU竞争共享资源。

## 6. 结论

Best-Fit算法通过选择最适合的空闲块来优化空间利用率，但存在时间效率的问题。通过引入索引结构、优化数据结构和改进并发处理，可以在保持其空间效率优势的同时提高时间效率。

# 扩展练习Challenge：任意大小的内存单元SLUB分配算法

## 1. SLUB分配算法理论基础

SLUB（Single Level Unqueued Blocks）分配器是一种高效的内存管理机制，其理论基础建立在对象缓存和内存池管理的基础之上。该算法通过实现分层次的内存管理结构，在保证内存分配效率的同时，有效降低了内存碎片化程度。

### 1.1 核心理论模型

SLUB分配器的理论模型基于以下两个关键概念：

1. **对象缓存层次结构**：将内存空间按照对象大小进行分层管理，每层维护固定大小的内存块集合。这种层次化设计能够显著降低内存分配的搜索开销，并提供近似O(1)的分配时间复杂度。

2. **批量内存管理策略**：采用页面级别的内存块（slab）作为基本管理单元，每个slab包含多个相同大小的对象。这种策略通过减少内存管理操作的频率，有效降低了系统开销，同时提高了缓存利用率。

## 2. 内存管理架构设计

SLUB分配器的架构设计采用了分层式的内存管理结构，通过精心设计的数据结构实现了高效的内存分配和回收机制。

### 2.1 核心数据结构分析

在SLUB分配器中，内存管理的核心围绕两个关键数据结构展开：

```c
struct slub_cache {
    list_entry_t slub_list;     /* slab可用队列 */
    list_entry_t full_list;     /* slab完全分配队列 */
    struct Page* partial;       /* 部分分配slab指针 */
    uint32_t objsize;          /* 对象大小 */
    uint32_t num;              /* 每个slab的对象数量 */
    uint32_t offset;           /* 对象偏移量 */
    uint32_t free_objects;     /* 空闲对象计数 */
    uint32_t total_objects;    /* 总对象计数 */
};
```

这个结构实现了对象缓存的核心管理功能，采用分离式链表管理策略，有效区分了不同状态的内存块，从而优化了内存分配的查找过程。其中，`objsize`和`num`的设计体现了SLUB分配器对内存对齐和空间效率的权衡考虑。

```c
struct slub_page {
    void* freelist;           /* 空闲对象链表 */
    uint32_t units;          /* 已分配对象计数 */
    struct Page page;        /* 基础页面结构 */
};
```

此结构通过扩展基础页面管理，实现了高效的对象级内存管理。其中，`freelist`字段指向空闲对象链表，`units`字段记录已分配对象数量，从而支持高效的内存分配和释放操作。

## 3. 核心算法实现分析

SLUB分配器的实现围绕内存的初始化、分配和释放三个核心操作展开，我们将逐一分析这些操作的实现细节。

### 3.1 初始化机制

SLUB分配器的初始化过程实现了缓存系统的基础构建，其核心算法如下：

```c
static void slub_init(void) {
    list_init(&cache_chain);
    
    for (int i = 0; i < SIZED_CACHE_NUM; i++) {
        sized_caches[i].objsize = sized_cache_sizes[i];
        slub_cache_init(&sized_caches[i]);
    }
    
    nr_free = 0;
    slub_cache = &sized_caches[0];
}
```

此初始化过程采用分层初始化策略，建立了一个多层次的缓存结构，为后续的内存分配操作提供了高效的基础架构。

### 3.2 内存分配算法

内存分配算法是SLUB分配器的核心，其实现体现了高效性和可扩展性的平衡：

```c
static struct Page* slub_alloc_pages(size_t n) {
    if (n > nr_free) return NULL;
    
    struct slub_cache *cache = slub_cache;
    struct Page *page = NULL;
    
    if (cache->partial != NULL) {
        page = cache->partial;
        void *object = page->freelist;
        page->freelist = *(void **)object;
        page->units++;
        
        if (page->units == cache->num) {
            cache->partial = NULL;
            list_add(&cache->full_list, &(page->page_link));
        }
    } else {
        page = alloc_page();
        if (page != NULL) {
            cache->total_objects += cache->num;
            setup_slub_page(cache, page);
        }
    }
    
    if (page != NULL) {
        nr_free -= n;
        ClearPageProperty(page);
    }
    return page;
}
```

该算法实现了基于状态的内存分配策略，其核心机制是通过维护slab的三种状态（部分分配、完全分配和空闲）来优化内存分配过程。具体而言，当系统接收到内存分配请求时，算法遵循以下分配原则：

首先，算法会优先从部分分配（partial）的slab中分配内存，这种策略有效利用了已经激活的内存页面，不仅减少了内存碎片，还提高了缓存的命中率。当partial slab中的对象被完全分配后，该slab会自动转换为完全分配（full）状态，并被移至full_list中管理。

如果没有可用的partial slab，系统则会创建新的slab页面，此过程涉及物理页面的分配和初始化，包括设置对象布局、构建空闲对象链表等操作。这种动态创建机制确保了系统能够根据实际需求扩展内存池，同时保持了较高的内存使用效率。

### 3.3 内存释放与回收算法

SLUB分配器的内存释放过程的核心在于如何高效地管理对象的生命周期、维护slab的状态一致性。

```c
static void slub_free_pages(struct Page *base, size_t n) {
    struct slub_cache *cache = slub_cache;
    
    // 重置页面基本属性
    base->flags = 0;
    set_page_ref(base, 0);
    
    // 计算对象地址并获取slub控制结构
    void *object = page2kva(base) + cache->offset;
    struct slub_page *slub = (struct slub_page *)page2kva(base);
    
    // 将释放的对象添加到空闲链表
    *(void **)object = slub->freelist;
    slub->freelist = object;
    slub->units--;
    
    // 根据使用情况更新slab状态
    if (slub->units == 0) {
        // slab完全空闲，从链表中移除
        list_del(&(base->page_link));
        cache->free_objects += cache->num;
    } else if (slub->units == cache->num - 1) {
        // slab变为部分使用状态
        list_del(&(base->page_link));
        cache->partial = base;
    }
    
    nr_free += n;
}
```
该释放算法通过以下几个关键步骤实现了高效的内存回收：

首先，通过重置页面的基本属性（`flags = 0`和引用计数清零），确保页面能够安全地进入可重分配状态。释放算法采用LIFO（后进先出）策略来管理空闲对象链表，这种方式不仅通过简单的指针操作（`*(void **)object = slub->freelist`）实现了O(1)时间复杂度的对象插入，还有效地维护了内存访问的空间局部性。

在内存释放代码的算法中最关键的是其动态的状态管理机制：当一个slab的已用对象数（`units`）降为0时，该slab被完全回收；当`units`达到`cache->num - 1`时，slab则转移到partial状态，这种基于使用率的精确状态转换确保了内存的高效利用，同时最小化了内存碎片。

上述内存释放算法通过巧妙的状态转换设计和高效的链表操作，实现了快速的内存释放和对象重用，并保持了系统的内存使用效率。

## 4. 理论分析与性能评估

### 4.1 算法复杂度分析

SLUB分配器的性能特征可从以下几个维度进行理论分析：

1. **时间复杂度**
   - 内存分配：平均情况下接近O(1)
   - 内存释放：严格O(1)
   - 缓存初始化：O(n)，其中n为预定义的缓存类别数量

2. **空间复杂度**
   - 元数据开销：每个slab额外需要O(1)的管理结构
   - 内存利用率：理论上可达到(1-ε)，其中ε为对齐开销

### 4.2 关键性能特征

SLUB分配器的核心优势体现在以下方面：

1. **局部性优化**
   通过对象池化管理，显著提高了缓存命中率，具体表现为：
   - 相同大小对象的连续存储
   - 最小化的元数据访问
   - 优化的内存对齐策略

2. **伸缩性设计**
   采用分层式管理结构，实现了良好的系统扩展性：
   - 动态slab创建机制
   - 自适应的内存池管理
   - 高效的空间复用策略

## 5. 优化方向与改进建议

基于对SLUB分配器的深入分析，提出以下关键优化方向：

### 5.1 并发优化设计

```c
struct slub_cache_node {
    spinlock_t lock;           /* 并发访问控制 */
    struct list_head partial;  /* 部分分配slab链表 */
    atomic_t nr_partial;      /* 部分分配slab计数 */
    struct array_cache *shared;/* 共享缓存 */
};
```

此设计通过引入细粒度锁机制和共享缓存，显著提升了多处理器环境下的性能。

### 5.2 内存回收机制

提出一种基于阈值的智能回收策略：

```c
struct slub_reclaim_policy {
    unsigned int reclaim_threshold;  /* 回收阈值 */
    unsigned int min_objects;        /* 最小保留对象数 */
    unsigned int batch_reclaim;      /* 批量回收大小 */
};
```

## 6. 结论

SLUB分配器通过其独特的分层次内存管理机制，在保证高性能的同时实现了良好的可扩展性。其核心优势在于：

1. 高效的内存分配策略
2. 优化的缓存局部性
3. 可扩展的架构设计

通过这些优化，SLUB分配器将能更好地适应现代计算系统的需求。

在操作系统无法从设备树或固件获取物理内存信息时，需要通过主动探测的方式确定可用的物理内存范围。本文将详细介绍一种基于位模式测试的高效内存探测方法。

# 扩展练习Challenge：硬件的可用物理内存范围的获取方法

如果操作系统（OS）或其引导加载程序（Bootloader）在启动初期无法通过BIOS/UEFI等固件接口提前获取物理内存的布局信息，它必须主动进行 **内存探测（Memory Probing）** 来确定可用物理内存的起始地址和结束地址。这个过程的核心思想，是通过向内存地址写入特定的位模式并回读校验，从而判断该地址是否对应着真实、可用的物理内存。

这套探测机制可以归纳为一个连续的“ 写入-回读-验证 ”的循环过程。OS会从一个已知的、肯定存在的低地址（例如物理地址0）开始，逐步向高地址进行探测。在每一个探测的地址上，它会执行一系列操作来确认内存的有效性和可靠性。

为什么“ 写入-回读-验证 ”的整个过程就能够说明这段内存地址是可用的？因为从一个无效地址（浮动总线）上恰好读回我们试图写入的一段内容的概率非常低。因此，当我们写入一段内容并能稳定地读回一段内容时，就建立了一个强有力的证据：这个地址背后有一个能可靠存储并返回数据的物理设备，也就是内存。

为了确保探测的准确性，仅仅使用单一的数据模式（如全0或全1）是不够的，因为它可能无法检测出所有类型的硬件故障，例如数据线之间的短路或某些位“卡死”在0或1的状态。因此，我们需要采用更严谨的测试模式，其中最经典的就是互补位模式测试：OS会对一个内存单元执行以下操作：

1. 写入第一个模式：向该内存地址写入 0xAA（二进制为 10101010）。这个模式的特点是相邻位完全相反。

2. 验证第一个模式：立即从该地址读出数据，检查是否仍然是 0xAA。如果不是，说明此内存地址无效或存在故障。

3. 写入互补模式：如果上一步通过，再向同一地址写入 0x55（二进制为 01010101）。0x55 正好是 0xAA 的二进制反码。

4. 验证互补模式：再次立即读出数据，检查是否为 0x55。

通过这一对互补模式的测试，可以有效地检测出大部分常见的内存硬件问题。如果一个内存地址成功通过了这一系列的读写校验，OS就将其标记为“可用”。



OS会不断重复这个探测过程，依次递增内存地址（通常以页或更大的块为单位以提高效率）。当探测到一个写入和回读结果不一致的地址时，通常就意味着遇到了物理内存的边界，或者是一个无效的内存空洞、以及映射给硬件设备（MMIO）的地址空间。通过记录下最后一个成功的地址，OS就能确定这段连续物理内存的上限，从而构建出整个系统的物理内存映射图（Memory Map），为后续的内存管理初始化工作打下基础。
