#ifndef __LIBS_SKEW_HEAP_H__
#define __LIBS_SKEW_HEAP_H__

struct skew_heap_entry {
     struct skew_heap_entry *parent, *left, *right;
};

typedef struct skew_heap_entry skew_heap_entry_t;

typedef int(*compare_f)(void *a, void *b);

static inline void skew_heap_init(skew_heap_entry_t *a) __attribute__((always_inline));
static inline skew_heap_entry_t *skew_heap_merge(
     skew_heap_entry_t *a, skew_heap_entry_t *b,
     compare_f comp);
static inline skew_heap_entry_t *skew_heap_insert(
     skew_heap_entry_t *a, skew_heap_entry_t *b,
     compare_f comp) __attribute__((always_inline));
static inline skew_heap_entry_t *skew_heap_remove(
     skew_heap_entry_t *a, skew_heap_entry_t *b,
     compare_f comp) __attribute__((always_inline));

static inline void
skew_heap_init(skew_heap_entry_t *a)
{
     a->left = a->right = a->parent = NULL;
}

/**
 * 合并两个斜堆
 * 
 * @param a 第一个斜堆的根节点指针，可以为NULL
 * @param b 第二个斜堆的根节点指针，可以为NULL  
 * @param comp 比较函数，用于比较两个节点的大小关系
 *             返回-1表示第一个节点小于第二个节点，其他值表示大于等于
 * @return 合并后的新斜堆的根节点指针
 */
static inline skew_heap_entry_t *
skew_heap_merge(skew_heap_entry_t *a, skew_heap_entry_t *b,
                compare_f comp)
{
     if (a == NULL) return b;
     else if (b == NULL) return a;
     
     skew_heap_entry_t *l, *r;
     // 比较两个根节点，选择较小的作为新根
     if (comp(a, b) == -1)
     {
          r = a->left;
          l = skew_heap_merge(a->right, b, comp);
          
          a->left = l;
          a->right = r;
          if (l) l->parent = a;

          return a;
     }
     else
     {
          r = b->left;
          l = skew_heap_merge(a, b->right, comp);
          
          b->left = l;
          b->right = r;
          if (l) l->parent = b;

          return b;
     }
}

/**
 * 向偏斜堆中插入一个节点
 * 
 * 该函数将节点b插入到以a为根的偏斜堆中，返回合并后的新堆的根节点。
 * 插入操作通过将待插入节点初始化，然后与原堆进行合并来实现。
 * 
 * @param a 指向偏斜堆根节点的指针，可以为NULL表示空堆
 * @param b 指向待插入节点的指针，该节点将被插入到堆中
 * @param comp 比较函数指针，用于确定堆中元素的优先级关系
 *             函数原型应为: int compare_f(const void *a, const void *b)
 *             返回值: <0表示a优先级高于b, 0表示相等, >0表示a优先级低于b
 * 
 * @return 返回合并后的新堆的根节点指针
 *         如果a和b都为NULL，则返回NULL
 *         如果其中一个为NULL，则返回另一个节点
 */
static inline skew_heap_entry_t *
skew_heap_insert(skew_heap_entry_t *a, skew_heap_entry_t *b,
                 compare_f comp)
{
     // 初始化待插入节点，确保其左右子树指针被正确设置
     skew_heap_init(b);
     // 通过合并操作完成插入，将初始化后的节点b与原堆a合并
     return skew_heap_merge(a, b, comp);
}

static inline skew_heap_entry_t *
skew_heap_remove(skew_heap_entry_t *a, skew_heap_entry_t *b,
                 compare_f comp)
{
     skew_heap_entry_t *p   = b->parent;
     skew_heap_entry_t *rep = skew_heap_merge(b->left, b->right, comp);
     if (rep) rep->parent = p;
     
     if (p)
     {
          if (p->left == b)
               p->left = rep;
          else p->right = rep;
          return a;
     }
     else return rep;
}

#endif    /* !__LIBS_SKEW_HEAP_H__ */
