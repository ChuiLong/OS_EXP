#ifndef __KERN_SYNC_SYNC_H__
#define __KERN_SYNC_SYNC_H__

#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
        // 把 sstatus.SIE 清 0，表示禁止中断
        intr_disable();
        return 1;
    }
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        // 把 sstatus.SIE 位置 1，表示允许中断
        intr_enable();
    }
}

//思考：这里宏定义的 do{}while(0)起什么作用?
/*把“多条语句的宏”包装成“像一条语句”的东西，
方便安全地在任何地方使用（尤其是 if/else），
并且末尾可以自然地写分号；运行时不会真的循环。*/
#define local_intr_save(x) \
    do {                   \
        x = __intr_save(); \
    } while (0)
#define local_intr_restore(x) __intr_restore(x);

#endif /* !__KERN_SYNC_SYNC_H__ */
