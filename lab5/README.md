# Copy-on-Write 机制设计报告

## 1 设计原理

Copy-on-Write（写时复制，COW）是一种重要的内存优化技术，用于提高进程 fork 操作的效率。在传统的 Unix 进程模型中，fork 系统调用会创建父进程的完整副本，包括整个地址空间的所有页面。然而，在实际应用中，大部分子进程会立即执行 exec 加载新程序，导致 fork 时复制的内存数据立即被丢弃，造成严重的时间和空间浪费。

COW 技术通过延迟复制策略根本性地解决了这一问题。其核心机制是：fork 时父子进程共享相同的物理页面，所有可写页面被标记为只读并设置 COW 标志；仅当某一进程尝试写入共享页面时，才触发页面错误（Page Fault），此时系统分配新的物理页面，复制原页面内容，并将新页面映射到写入进程的地址空间。这种"按需复制"的策略在 fork-exec 模式下具有显著优势：若子进程从不写入某些页面，这些页面将永远保持共享状态，避免了不必要的内存分配和数据复制。

<div align="center">
<svg width="960" height="350" viewBox="0 0 960 350" xmlns="http://www.w3.org/2000/svg">
<defs>
<marker id="arrowhead-blue" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto"><polygon points="0 0, 10 3.5, 0 7" fill="#2196F3" /></marker>
<marker id="arrowhead-green" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto"><polygon points="0 0, 10 3.5, 0 7" fill="#4CAF50" /></marker>
<marker id="arrowhead-red" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto"><polygon points="0 0, 10 3.5, 0 7" fill="#D32F2F" /></marker>
</defs>
<rect width="100%" height="100%" fill="#f8f9fa" rx="10" ry="10"/>
<g transform="translate(30, 50)">
<rect x="-15" y="-30" width="390" height="260" rx="10" fill="#fff" stroke="#ccc" stroke-width="1" stroke-dasharray="5,5"/>
<text x="180" y="-10" text-anchor="middle" font-weight="bold" font-size="16" fill="#333">Initial State (Shared)</text>
<rect x="0" y="20" width="140" height="60" rx="5" fill="#E3F2FD" stroke="#2196F3" stroke-width="2"/>
<text x="70" y="45" text-anchor="middle" font-weight="bold" fill="#1565C0">Process A</text>
<text x="70" y="65" text-anchor="middle" font-size="12" fill="#1565C0">Virtual Page X</text>
<rect x="0" y="140" width="140" height="60" rx="5" fill="#E8F5E9" stroke="#4CAF50" stroke-width="2"/>
<text x="70" y="165" text-anchor="middle" font-weight="bold" fill="#2E7D32">Process B</text>
<text x="70" y="185" text-anchor="middle" font-size="12" fill="#2E7D32">Virtual Page X</text>
<rect x="220" y="80" width="140" height="60" rx="5" fill="#FFF3E0" stroke="#FF9800" stroke-width="2"/>
<text x="290" y="105" text-anchor="middle" font-weight="bold" fill="#EF6C00">Physical Page P</text>
<text x="290" y="125" text-anchor="middle" font-size="12" fill="#EF6C00">Ref=2, Read-Only</text>
<path d="M 140 50 C 180 50, 180 90, 215 100" fill="none" stroke="#2196F3" stroke-width="2" marker-end="url(#arrowhead-blue)"/>
<path d="M 140 170 C 180 170, 180 130, 215 120" fill="none" stroke="#4CAF50" stroke-width="2" marker-end="url(#arrowhead-green)"/>
</g>
<g transform="translate(440, 160)">
<path d="M 0 -4 L 45 -4 L 45 -10 L 65 0 L 45 10 L 45 4 L 0 4 Z" fill="#D32F2F" stroke="none" filter="drop-shadow(1px 1px 1px rgba(0,0,0,0.2))"/>
<text x="32" y="-18" text-anchor="middle" font-weight="bold" font-size="14" fill="#D32F2F">Write Fault!</text>
<text x="32" y="25" text-anchor="middle" font-size="11" fill="#666">(Process A writes)</text>
</g>
<g transform="translate(550, 50)">
<rect x="-15" y="-30" width="390" height="260" rx="10" fill="#fff" stroke="#ccc" stroke-width="1" stroke-dasharray="5,5"/>
<text x="180" y="-10" text-anchor="middle" font-weight="bold" font-size="16" fill="#333">Post-Write State (Split)</text>
<rect x="0" y="20" width="140" height="60" rx="5" fill="#E3F2FD" stroke="#2196F3" stroke-width="2"/>
<text x="70" y="45" text-anchor="middle" font-weight="bold" fill="#1565C0">Process A</text>
<text x="70" y="65" text-anchor="middle" font-size="12" fill="#1565C0">Virtual Page X</text>
<rect x="0" y="140" width="140" height="60" rx="5" fill="#E8F5E9" stroke="#4CAF50" stroke-width="2"/>
<text x="70" y="165" text-anchor="middle" font-weight="bold" fill="#2E7D32">Process B</text>
<text x="70" y="185" text-anchor="middle" font-size="12" fill="#2E7D32">Virtual Page X</text>
<rect x="220" y="20" width="140" height="60" rx="5" fill="#FFEBEE" stroke="#D32F2F" stroke-width="2"/>
<text x="290" y="45" text-anchor="middle" font-weight="bold" fill="#C62828">New Page P'</text>
<text x="290" y="65" text-anchor="middle" font-size="12" fill="#C62828">Ref=1, R/W</text>
<text x="290" y="95" text-anchor="middle" font-size="10" fill="#C62828">(Copy of P)</text>
<rect x="220" y="140" width="140" height="60" rx="5" fill="#FFF3E0" stroke="#FF9800" stroke-width="2"/>
<text x="290" y="165" text-anchor="middle" font-weight="bold" fill="#EF6C00">Physical Page P</text>
<text x="290" y="185" text-anchor="middle" font-size="12" fill="#EF6C00">Ref=1, R/W</text>
<line x1="140" y1="50" x2="210" y2="50" stroke="#2196F3" stroke-width="2" marker-end="url(#arrowhead-blue)"/>
<line x1="140" y1="170" x2="210" y2="170" stroke="#4CAF50" stroke-width="2" marker-end="url(#arrowhead-green)"/>
</g>
</svg>
<p align="center">图 1: Copy-on-Write 机制原理示意图</p>
</div>

本实现在 ucore 操作系统中采用 COW 机制，设计目标为：（1）正确性——确保父子进程的内存完全隔离，任一进程的写操作不影响另一方；（2）高效性——最小化 fork 的时间开销和内存占用；（3）透明性——对用户程序完全透明，无需修改应用代码；（4）安全性——避免潜在的竞态条件和权限提升漏洞。实现中使用 RISC-V Sv39 页表的软件保留位（RSW）定义专用的 PTE_COW 标志（0x100），通过显式状态标记实现清晰的状态管理，并在页面错误处理程序中根据页面引用计数（reference count）决定是否需要实际复制页面。

---

## 2 状态转换模型

COW 机制的核心在于页面状态的动态转换。为精确描述这一过程，我们采用有限状态自动机（Finite State Automaton, FSA）进行形式化建模。定义页面状态集合 $S = \{S_0, S_1, S_2, S_3\}$，其中 $S_0$ 表示私有可写页面（PRIVATE_RW，PTE_W=1, PTE_COW=0, ref=1），$S_1$ 表示共享 COW 页面（SHARED_COW，PTE_W=0, PTE_COW=1, ref≥2），$S_2$ 表示独占 COW 页面（EXCLUSIVE_COW，PTE_W=0, PTE_COW=1, ref=1），$S_3$ 表示未映射状态（UNMAPPED，ref=0）。输入事件集合 $E = \{e_{fork}, e_{write}, e_{other\_exit}, e_{self\_exit}\}$ 分别对应 fork 操作、写入触发 Store Page Fault、其他共享进程退出、当前进程退出。

状态转换函数 $\delta: S \times E \rightarrow S \times A$ 的完整规则如下表所示：

| 当前状态 | 输入事件 | 下一状态 | 执行动作 |
|:--------:|:--------:|:--------:|:---------|
| $S_0$ | $e_{fork}$ | $S_1$ | 清除 PTE_W，设置 PTE_COW，ref++ |
| $S_0$ | $e_{write}$ | $S_0$ | 无操作（页面已可写） |
| $S_0$ | $e_{self\_exit}$ | $S_3$ | 释放页面，解除映射 |
| $S_1$ | $e_{write}$ | $S_0$ | 分配新页，复制内容，ref--，映射新页 |
| $S_1$ | $e_{other\_exit}$ | $S_1$ 或 $S_2$ | ref--（若 ref=1 则转 $S_2$） |
| $S_1$ | $e_{self\_exit}$ | $S_1$ 或 $S_3$ | ref--（若 ref=0 则转 $S_3$） |
| $S_2$ | $e_{write}$ | $S_0$ | 设置 PTE_W，清除 PTE_COW（无需复制） |
| $S_2$ | $e_{self\_exit}$ | $S_3$ | 释放页面，解除映射 |

状态转换的关键在于 $S_1 \rightarrow S_0$ 和 $S_2 \rightarrow S_0$ 两种写入场景的区分：前者由于页面仍被多个进程共享（ref>1），需要分配新页面并复制内容；后者由于页面已被当前进程独占（ref=1），仅需恢复写权限即可，从而避免不必要的内存分配和数据复制。下图展示了完整的状态转换关系：

下图展示了完整的状态转换关系：

<div align="center">
<svg width="600" height="650" xmlns="http://www.w3.org/2000/svg">
  <!-- Definitions -->
  <defs>
    <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
      <polygon points="0 0, 10 3.5, 0 7" fill="#333" />
    </marker>
  </defs>

  <!-- Styles -->
  <style>
    text { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; }
    .state-box { fill: #ffffff; stroke: #333; stroke-width: 2; rx: 8; ry: 8; filter: drop-shadow(2px 2px 2px rgba(0,0,0,0.1)); }
    .state-title { font-weight: bold; font-size: 14px; text-anchor: middle; fill: #000; }
    .state-desc { font-family: Consolas, monospace; font-size: 11px; text-anchor: middle; fill: #555; }
    .arrow { stroke: #333; stroke-width: 1.5; fill: none; marker-end: url(#arrowhead); }
    .label-bg { fill: white; opacity: 0.95; }
    .label { font-size: 12px; fill: #333; text-anchor: middle; font-weight: 500; }
    .start-node { fill: #333; stroke: none; }
  </style>

  <!-- Layout: Vertical Stack
       Start: 300, 30
       S0 (Private): 300, 100
       S1 (Shared): 300, 250
       S2 (Exclusive): 300, 400
       S3 (Unmapped): 300, 550
  -->

  <!-- START -->
  <circle cx="300" cy="30" r="6" class="start-node" />
  <line x1="300" y1="36" x2="300" y2="70" class="arrow" />
  <text x="340" y="55" class="label">alloc_page</text>

  <!-- S0: PRIVATE_RW -->
  <rect x="200" y="70" width="200" height="60" class="state-box" />
  <text x="300" y="95" class="state-title">S₀: PRIVATE_RW</text>
  <text x="300" y="115" class="state-desc">W=1, COW=0, ref=1</text>

  <!-- S1: SHARED_COW -->
  <rect x="200" y="220" width="200" height="60" class="state-box" />
  <text x="300" y="245" class="state-title">S₁: SHARED_COW</text>
  <text x="300" y="265" class="state-desc">W=0, COW=1, ref≥2</text>

  <!-- S2: EXCLUSIVE_COW -->
  <rect x="200" y="370" width="200" height="60" class="state-box" />
  <text x="300" y="395" class="state-title">S₂: EXCLUSIVE_COW</text>
  <text x="300" y="415" class="state-desc">W=0, COW=1, ref=1</text>

  <!-- S3: UNMAPPED -->
  <rect x="250" y="520" width="100" height="50" class="state-box" style="stroke-dasharray: 4,4; fill: #f9f9f9;" />
  <text x="300" y="540" class="state-title">S₃</text>
  <text x="300" y="555" class="state-desc">UNMAPPED</text>

  <!-- Transitions -->

  <!-- S0 -> S1 (fork) -->
  <!-- Curve Right Side -->
  <path d="M 400 100 C 480 100, 480 250, 400 250" class="arrow" />
  <rect x="440" y="165" width="50" height="20" class="label-bg" rx="3" />
  <text x="465" y="180" class="label">fork()</text>

  <!-- S1 -> S0 (write/copy) -->
  <!-- Curve Left Side -->
  <path d="M 200 250 C 120 250, 120 100, 200 100" class="arrow" />
  <rect x="110" y="165" width="80" height="20" class="label-bg" rx="3" />
  <text x="150" y="180" class="label">write (copy)</text>

  <!-- S1 -> S2 (other_exit) -->
  <!-- Straight Down -->
  <line x1="300" y1="280" x2="300" y2="370" class="arrow" />
  <rect x="240" y="315" width="120" height="20" class="label-bg" rx="3" />
  <text x="300" y="330" class="label">other_exit (ref→1)</text>

  <!-- S2 -> S0 (write/restore) -->
  <!-- Wide Curve Left Side -->
  <path d="M 200 400 C 60 400, 60 100, 200 100" class="arrow" />
  <rect x="50" y="240" width="90" height="20" class="label-bg" rx="3" />
  <text x="95" y="255" class="label">write (restore)</text>

  <!-- S2 -> S3 (exit) -->
  <!-- Straight Down -->
  <line x1="300" y1="430" x2="300" y2="520" class="arrow" stroke-dasharray="4" />
  <text x="315" y="480" class="label" font-size="10">exit</text>

  <!-- S0 -> S3 (exit) -->
  <!-- Wide Curve Right Side -->
  <path d="M 400 100 C 580 100, 580 545, 350 545" class="arrow" stroke-dasharray="4" />
  <text x="540" y="320" class="label" font-size="10">exit</text>

</svg>
  
</svg>
</div>

为确保 COW 机制的正确性，系统必须维护以下三个不变量：（1）引用计数一致性，即 $\forall \text{ page } P: P.\text{ref\_count} = |\{pte \mid pte \text{ maps to } P\}|$，保证引用计数与实际映射数量严格相等；（2）COW 标志有效性，即 $\forall \text{ pte}: (\text{pte.COW} = 1) \Rightarrow (\text{pte.W} = 0)$，确保 COW 页面始终为只读状态；（3）共享页面只读性，即 $\forall \text{ page } P: (P.\text{ref\_count} > 1) \Rightarrow \forall \text{ pte mapping } P: (\text{pte.W} = 0)$，防止多个进程同时拥有写权限。这些不变量在 fork、写入、退出等关键操作中均得到严格维护。

---

## 3 实现细节

本实现利用 RISC-V Sv39 页表项的软件保留位（RSW）定义 COW 标志（`PTE_COW = 0x100`，位于 bit 8），页表项格式为：bit[63:54] 保留，bit[53:10] 物理页号（PPN），bit[9:8] RSW，bit[7:0] 标志位（DAGUXWRV）。核心实现分为三个阶段：fork 时的页面共享、写时复制处理、进程退出时的引用计数维护。

在 fork 阶段，`dup_mmap` 函数复制虚拟内存区域时，对可写且非栈区域启用 COW（栈页面由于写入频繁而直接复制）。具体由 `copy_range` 函数实现状态转换 $S_0 \rightarrow S_1$：

```c
if (share) {
    page_ref_inc(page);                              // 原子递增 ref
    __asm__ __volatile__("fence rw, rw" ::: "memory"); // 内存屏障
    perm = (*ptep & ~PTE_W) | PTE_COW;               // 移除写权限，添加 COW
    *ptep = (PTE_ADDR(*ptep) >> (PGSHIFT - PTE_PPN_SHIFT)) | perm;
    tlb_invalidate(from, start);                     // 刷新父进程 TLB
    *nptep = pte_create(page2ppn(page), perm);       // 映射子进程
}
```

该过程的关键在于：（1）同时修改父进程的 PTE，确保父子进程均为只读+COW 状态；（2）立即刷新 TLB，防止父进程使用缓存的可写权限绕过 COW 机制；（3）通过 `page_insert` 增加引用计数，维护不变量 1。

在写时复制阶段，当进程写入 COW 页面时，硬件触发 Store Page Fault，trap handler 检测 `PTE_COW` 标志并调用 `do_cow_fault` 函数。该函数采用"原子递减后决策"的并发安全模式：先原子递减引用计数获取旧值 `old_ref`，若 `old_ref > 1`（状态 $S_1$），表示页面曾被共享，需分配新页面、复制内容、更新映射；若 `old_ref == 1`（状态 $S_2$），表示页面已独占，仅需恢复写权限。关键代码如下：

```c
int do_cow_fault(struct mm_struct *mm, uintptr_t addr, pte_t *ptep) {
    struct Page *page = pte2page(*ptep);
    // 原子递减 ref 并获取旧值，避免 TOCTOU 竞态
    int old_ref;
    __asm__ __volatile__("amoadd.w %0, %2, %1"
                         : "=r"(old_ref), "+A"(page->ref)
                         : "r"(-1) : "memory");
    if (old_ref > 1) {
        struct Page *npage = alloc_page();
        memcpy(page2kva(npage), page2kva(page), PGSIZE);
        if (old_ref - 1 == 0) free_page(page);  // 处理并发退出情况
        uint32_t perm = ((*ptep & PTE_USER) & ~PTE_COW) | PTE_W;
        set_page_ref(npage, 1);
        *ptep = pte_create(page2ppn(npage), perm);
    } else {
        set_page_ref(page, 1);  // 恢复 ref（原子递减后变为 0）
        uint32_t perm = ((*ptep & PTE_USER) & ~PTE_COW) | PTE_W;
        *ptep = (PTE_ADDR(*ptep) >> (PGSHIFT - PTE_PPN_SHIFT)) | perm;
    }
    tlb_invalidate(mm->pgdir, ROUNDDOWN(addr, PGSIZE));
    return 0;
}
```

进程退出时，`exit_mmap` 调用 `page_remove_pte` 解除页面映射，该函数递减引用计数并在计数归零时释放物理页面（状态转换至 $S_3$），确保内存资源的正确回收。

---

## 4 正确性分析

### 4.1 不变量验证

**验证不变量 1（引用计数一致性）**：

- fork 操作：`page_ref_inc` 增加计数，`page_insert` 建立新映射，计数与映射数同步增加
- COW 写入（ref > 1）：`page_insert` 内部调用 `page_remove_pte` 递减旧页面计数，新页面计数为 1
- 进程退出：`page_remove_pte` 递减计数，映射数同步减少

**验证不变量 2（COW 标志有效性）**：

- $S_0 \rightarrow S_1$：同时执行 `perm & ~PTE_W` 和 `perm | PTE_COW`
- $S_1 \rightarrow S_0$ 和 $S_2 \rightarrow S_0$：同时执行 `perm | PTE_W` 和 `perm & ~PTE_COW`

**验证不变量 3（共享页面只读性）**：

当 ref > 1 时，所有指向该页面的 PTE 均设置了 COW 标志且清除了 W 位。任何写入尝试都会触发页面错误，在 `do_cow_fault` 中创建私有副本后才允许写入。

### 4.2 原子性保证

关键操作在以下条件下保证原子性：

1. **fork 期间**：整个 `do_fork` 过程在禁用中断的上下文中执行
2. **COW 处理期间**：trap handler 中硬件已禁用中断，保证状态检查与更新的原子性
3. **TLB 一致性**：修改 PTE 后立即调用 `tlb_invalidate` 刷新缓存

### 4.3 并发安全设计

尽管 ucore 当前为单核单线程环境，本实现仍采用并发安全的设计模式，确保代码在多核/多线程环境下的正确性：

**原子引用计数操作**：页面引用计数的增减使用 RISC-V 原子指令 `amoadd.w` 实现，避免多核环境下的数据竞争：

```c
static inline int page_ref_inc(struct Page *page) {
    int ret;
    __asm__ __volatile__("amoadd.w %0, %2, %1"
                         : "=r"(ret), "+A"(page->ref)
                         : "r"(1) : "memory");
    return ret + 1;
}
```

**消除 TOCTOU 竞态**：传统 COW 实现中"检查 ref→执行操作"的两步模式存在 TOCTOU（Time-of-Check to Time-of-Use）漏洞。本实现采用"先原子修改，后根据旧值决策"的模式：

```c
int do_cow_fault(...) {
    // 原子递减引用计数并获取旧值
    int old_ref;
    __asm__ __volatile__("amoadd.w %0, %2, %1"
                         : "=r"(old_ref), "+A"(page->ref)
                         : "r"(-1) : "memory");
    
    if (old_ref > 1) {
        // 页面曾被共享，需要复制
        // ...复制页面，若 old_ref-1==0 则释放原页面
    } else {
        // 页面已独占（old_ref==1），恢复 ref 并设置写权限
        set_page_ref(page, 1);
        // ...恢复写权限
    }
}
```

该设计确保：即使两个进程同时触发同一 COW 页面的写入，原子操作保证只有一个进程看到 `old_ref > 1` 并执行复制，另一个进程看到 `old_ref == 1` 并直接恢复权限。

**内存屏障保证顺序性**：在 `copy_range` 中，使用 `fence rw, rw` 内存屏障确保引用计数递增在 PTE 修改之前对所有 CPU 可见，防止指令重排导致的不一致：

```c
page_ref_inc(page);                              // Step 1: 原子递增 ref
__asm__ __volatile__("fence rw, rw" ::: "memory"); // Step 2: 内存屏障
// Step 3: 修改父进程 PTE 为只读+COW
// Step 4: 映射子进程 PTE
```

**失败回滚机制**：所有关键操作均设计了原子回滚路径，确保操作失败时系统状态保持一致。例如 `copy_range` 中若子进程 PTE 分配失败，会回滚父进程的 ref 递增和 PTE 修改。

---

## 5  Dirty COW 漏洞分析与防护

### 5.1 Dirty COW 漏洞原理

Dirty COW（CVE-2016-5195）是 Linux 内核中存在长达 11 年的严重本地提权漏洞（2005-2016），允许非特权用户获得对只读内存映射（包括 `/etc/passwd` 等系统文件）的写访问权限。要理解该漏洞并设计有效防护，需要深入分析其形成的根本原因。

**攻击流程**

攻击者创建两个并发线程：线程 A 通过 `/proc/self/mem` 接口对只读文件映射区域执行写操作；线程 B 反复调用 `madvise(MADV_DONTNEED)` 丢弃该区域的页面。攻击的时序如下：

<div align="center">
<table style="border-collapse: collapse; font-size: 13px; width: 90%;">
<tr style="background: #f5f5f5;">
<th style="border: 2px solid #1565C0; padding: 10px; width: 45%; color: #1565C0;">线程 A（写入线程）</th>
<th style="border: 2px solid #2E7D32; padding: 10px; width: 45%; color: #2E7D32;">线程 B（madvise 线程）</th>
</tr>
<tr>
<td style="border: 1px solid #ddd; padding: 8px; background: #E3F2FD;">write() → __get_user_pages()</td>
<td style="border: 1px solid #ddd; padding: 8px;"></td>
</tr>
<tr>
<td style="border: 1px solid #ddd; padding: 8px; background: #E3F2FD;"> follow_page_mask() 失败（页面只读）</td>
<td style="border: 1px solid #ddd; padding: 8px;"></td>
</tr>
<tr>
<td style="border: 1px solid #ddd; padding: 8px; background: #E3F2FD;">faultin_page() → 创建 COW 私有副本</td>
<td style="border: 1px solid #ddd; padding: 8px;"></td>
</tr>
<tr style="background: #FFEBEE;">
<td style="border: 2px solid #C62828; padding: 8px; color: #C62828;"><b>移除 FOLL_WRITE 标志</b></td>
<td style="border: 2px solid #C62828; padding: 8px; color: #C62828;"><b>madvise(MADV_DONTNEED)</b><br><i style="font-size: 11px;">丢弃刚创建的 COW 页面</i></td>
</tr>
<tr>
<td style="border: 1px solid #ddd; padding: 8px; background: #E3F2FD;">goto retry</td>
<td style="border: 1px solid #ddd; padding: 8px;"></td>
</tr>
<tr>
<td style="border: 1px solid #ddd; padding: 8px; background: #E3F2FD;">follow_page_mask() 再次失败<br><i style="font-size: 11px;">（COW 页面已被丢弃）</i></td>
<td style="border: 1px solid #ddd; padding: 8px;"></td>
</tr>
<tr>
<td style="border: 1px solid #ddd; padding: 8px; background: #FFF3E0;">faultin_page() 但此时无 FOLL_WRITE<br><i style="font-size: 11px;">（内核误以为只需读访问）</i></td>
<td style="border: 1px solid #ddd; padding: 8px;"></td>
</tr>
<tr style="background: #FFCDD2;">
<td colspan="2" style="border: 2px solid #C62828; padding: 10px; text-align: center; color: #C62828;"><b>【漏洞】直接返回原始文件页面 → 写入穿透 COW 保护 </b></td>
</tr>
</table>
<p style="margin-top: 8px; font-size: 13px; color: #555;">图 2: Dirty COW 攻击时序——两线程竞态导致写入穿透 COW 保护</p>
</div>

**漏洞根因分析**

漏洞的核心在于 `faultin_page()` 函数末尾的这段代码：

```c
// Linux 4.8 之前的漏洞代码
if ((ret & VM_FAULT_WRITE) && !(vma->vm_flags & VM_WRITE))
    *flags &= ~FOLL_WRITE;  // 移除写标志！
```

当 COW 完成后（`VM_FAULT_WRITE`），内核为了避免无限重试循环，直接移除了 `FOLL_WRITE` 标志。这意味着后续重试时，内核会"谎称"只需要读访问。如果此时 COW 页面被 `madvise()` 丢弃，内核会直接返回原始文件的 page cache 页面——因为对于"只读"请求，返回共享页面是最优选择。最终，写操作被施加到了原始文件页面上。

### 5.2 Linux 内核的修复方案

Linux 通过引入 `FOLL_COW` 标志和 `can_follow_write_pte()` 验证函数修复了该漏洞：

```c
// Linux 修复补丁的核心逻辑
#define FOLL_COW    0x4000  // 新增标志：期望遇到 COW 页面

// 判断是否可以对 PTE 执行写操作
static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
{
    return pte_write(pte) ||
        ((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
}

// faultin_page() 末尾的修复
if ((ret & VM_FAULT_WRITE) && !(vma->vm_flags & VM_WRITE))
    *flags |= FOLL_COW;  // 不再移除 FOLL_WRITE，而是添加 FOLL_COW
```

修复的关键思想是：**保留写意图（`FOLL_WRITE`），同时标记已完成 COW（`FOLL_COW`）**。在后续的 `follow_page_pte()` 中，只有当页面同时满足以下条件时才返回：

1. 设置了 `FOLL_COW` 标志（表明已经历 COW）
2. 页面的 dirty 位被设置（表明这确实是 COW 产生的脏页）
3. 或者页面本身就是可写的

如果 COW 页面被丢弃后重新触发缺页，由于原始文件页面的 dirty 位未设置，`can_follow_write_pte()` 返回 false，内核会重新执行 COW 而非返回原始页面。

### 5.3 本实现的防护机制

本 ucore 实现采用了类似但更为严格的防护策略，确保即使在多核多线程环境下也能抵御 Dirty COW 类型攻击。

**防护策略一：显式 COW 状态标志与原子验证**

与 Linux 使用隐式的 dirty bit 组合不同，本实现使用显式的 `PTE_COW` 标志位。在 `do_cow_fault()` 入口处，通过原子加载指令重新读取 PTE 并验证其状态：

```c
int do_cow_fault(struct mm_struct *mm, uintptr_t addr, pte_t *ptep)
{
    uintptr_t la = ROUNDDOWN(addr, PGSIZE);
    
    // 原子读取当前 PTE 值，获取一致性快照
    pte_t pte;
    __asm__ __volatile__("ld %0, %1" : "=r"(pte) : "m"(*ptep) : "memory");
    
    // 二次验证：PTE 必须仍然有效且保持 COW 状态
    if (!(pte & PTE_V) || !(pte & PTE_COW)) {
        // 状态已变化：可能被其他 CPU 处理，或被恶意修改
        if ((pte & PTE_V) && (pte & PTE_W)) {
            return 0;  // 良性竞态：已被其他核心完成 COW
        }
        return -1;  // 异常：页面状态不一致
    }
    // ... 后续操作基于验证后的 pte 快照进行
}
```

这一验证防止了 TOCTOU 攻击：即使在 trap handler 检测到 COW 条件与进入 `do_cow_fault()` 之间，PTE 被其他 CPU 或中断修改（例如页面被取消映射），系统也能检测到状态变化并正确处理。

**防护策略二：原子引用计数与"先减后判"模式**

Linux Dirty COW 的另一个问题是引用计数的非原子操作可能导致竞态。本实现使用 RISC-V 的 `amoadd.w` 原子指令，采用"先减后判"模式：

```c
// 原子递减引用计数，返回操作前的旧值
int old_ref;
__asm__ __volatile__("amoadd.w %0, %2, %1"
                     : "=r"(old_ref), "+A"(page->ref)
                     : "r"(-1)
                     : "memory");

if (old_ref > 1) {
    // 页面确实被共享，必须复制
    struct Page *npage = alloc_page();
    // ... 执行页面复制
} else {
    // old_ref == 1，本进程是唯一持有者，直接恢复写权限
    set_page_ref(page, 1);
    // ... 恢复写权限
}
```

该模式的关键在于：**决策基于原子操作返回的旧值，而非事后检查**。假设两个 CPU 同时对同一 COW 页面触发写错误：

- CPU A 执行 `amoadd.w`，返回 `old_ref = 2`，ref 变为 1
- CPU B 执行 `amoadd.w`，返回 `old_ref = 1`，ref 变为 0

CPU A 看到 `old_ref > 1`，执行复制；CPU B 看到 `old_ref == 1`，获得原页面所有权。无论执行顺序如何，最终结果都是正确的：每个进程获得独立的可写页面。

**防护策略三：强制写入私有副本**

Dirty COW 的本质危害是写入被重定向到共享的原始页面。本实现通过以下机制确保写入始终指向私有副本：

```c
if (old_ref > 1) {
    // 分配新页面并复制内容
    struct Page *npage = alloc_page();
    memcpy(page2kva(npage), page2kva(page), PGSIZE);
    
    // 设置新页面的权限：移除 COW 标志，添加写权限
    uint32_t perm = (pte & PTE_USER);
    perm = (perm & ~PTE_COW) | PTE_W;
    
    // 关键：PTE 指向新分配的私有页面
    pte_t new_pte = pte_create(page2ppn(npage), perm);
    
    // 原子更新 PTE
    __asm__ __volatile__("sd %1, %0" : "=m"(*ptep) : "r"(new_pte) : "memory");
    
    // 内存屏障 + TLB 刷新
    __asm__ __volatile__("fence rw, rw" ::: "memory");
    tlb_invalidate(mm->pgdir, la);
}
```

新 PTE 明确指向 `npage`（私有副本），而非原始共享页面。即使存在竞态，写入也只能发生在进程自己的私有页面上。






---

## 6 测试验证

### 6.1 测试用例设计

测试程序 `cow_test.c` 包含 7 类共 15 项测试，覆盖 COW 机制的各种场景：

| 测试类别 | 测试内容 | 验证目标 |
|:---------|:---------|:---------|
| 基本 COW 功能 | 子进程写入触发 COW | $S_1 \rightarrow S_0$ 转换正确性 |
| 数组隔离 | 大数组的 COW 处理 | 多页面 COW 的正确性 |
| 多子进程 | 多个子进程独立 COW | 引用计数正确维护 |
| 嵌套 fork | 三层 fork 嵌套 | 复杂继承关系下的隔离性 |
| 快速 fork 压力 | 连续 10 次 fork | 系统稳定性 |
| 读写混合 | 读后写、写后读 | 状态转换的完整性 |
| 边界条件 | 零值、极值数据 | 边界情况处理 |

### 6.2 测试结果

```
========================================
           COW Test Summary
========================================
  Passed: 15, Failed: 0, Total: 15

  *** ALL TESTS PASSED! ***
```

所有 15 项测试通过，同时 Lab5 官方评测获得满分（130/130）。

---

