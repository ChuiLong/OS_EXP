#ifndef __KERN_MM_VMM_H__
#define __KERN_MM_VMM_H__

#include <defs.h>
#include <list.h>
#include <memlayout.h>
#include <sync.h>

//pre define
struct mm_struct;

// the virtual continuous memory area(vma), [vm_start, vm_end), 
// addr belong to a vma means  vma.vm_start<= addr <vma.vm_end 
// vma_struct 表示“一个连续的虚拟内存区（VMA）”，对应用户地址空间中的一个区间 [vm_start, vm_end) 和它的访问权限/属性。每个进程的多个 VMA 由 mm_struct 管理。
struct vma_struct {
    struct mm_struct *vm_mm; // 指向拥有该 VMA 的 mm_struct
    uintptr_t vm_start;      // VMA 的起始虚拟地址    
    uintptr_t vm_end;        // VMA 的结束虚拟地址
    uint32_t vm_flags;       // VMA 的权限/属性位
    list_entry_t list_link;  // 链表节点，多个 VMA 组成链表
};

#define le2vma(le, member)                  \
    to_struct((le), struct vma_struct, member)

#define VM_READ                 0x00000001
#define VM_WRITE                0x00000002
#define VM_EXEC                 0x00000004

// struct mm_struct 是“进程/地址空间的内存管理描述符”，表示一组虚拟内存区（VMA）及其对应的页表（PDT）。每个用户进程或线程的地址空间由一个 mm_struct 管理
struct mm_struct {
    list_entry_t mmap_list;        // 按 vm_start 排序的 VMA 链表头，链上每个节点是 vma_struct::list_link。用于查找、遍历该地址空间的所有 VMA（如 mmap/munmap/查找 vma）
    struct vma_struct *mmap_cache; // current accessed vma, used for speed purpose
    pde_t *pgdir;                  // 指向该 mm 使用的页表（Page Directory/Table）的基址
    int map_count;                 // 当前 VMA 的数量（mmap_list 的长度）
    void *sm_priv;                 // 给交换/页面管理子系统保留的私有指针
};

struct vma_struct *find_vma(struct mm_struct *mm, uintptr_t addr);
struct vma_struct *vma_create(uintptr_t vm_start, uintptr_t vm_end, uint32_t vm_flags);
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma);

struct mm_struct *mm_create(void);
void mm_destroy(struct mm_struct *mm);

void vmm_init(void);

int do_pgfault(struct mm_struct *mm, uint32_t error_code, uintptr_t addr);

extern volatile unsigned int pgfault_num;
extern struct mm_struct *check_mm_struct;
#endif /* !__KERN_MM_VMM_H__ */

