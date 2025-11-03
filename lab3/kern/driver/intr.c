#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt*/
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }

/* intr_disable - disable irq interrupt 清除 sstatus 的 SIE 位*/
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
