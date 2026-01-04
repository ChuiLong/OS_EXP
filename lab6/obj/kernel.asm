
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000c297          	auipc	t0,0xc
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020c000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000c297          	auipc	t0,0xc
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020c008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020b2b7          	lui	t0,0xc020b
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c020b137          	lui	sp,0xc020b

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000da517          	auipc	a0,0xda
ffffffffc020004e:	5e650513          	addi	a0,a0,1510 # ffffffffc02da630 <buf>
ffffffffc0200052:	000df617          	auipc	a2,0xdf
ffffffffc0200056:	abe60613          	addi	a2,a2,-1346 # ffffffffc02deb10 <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	015050ef          	jal	ra,ffffffffc0205876 <memset>
    cons_init(); // init the console
ffffffffc0200066:	520000ef          	jal	ra,ffffffffc0200586 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006a:	00006597          	auipc	a1,0x6
ffffffffc020006e:	83658593          	addi	a1,a1,-1994 # ffffffffc02058a0 <etext>
ffffffffc0200072:	00006517          	auipc	a0,0x6
ffffffffc0200076:	84e50513          	addi	a0,a0,-1970 # ffffffffc02058c0 <etext+0x20>
ffffffffc020007a:	11e000ef          	jal	ra,ffffffffc0200198 <cprintf>

    print_kerninfo();
ffffffffc020007e:	1a2000ef          	jal	ra,ffffffffc0200220 <print_kerninfo>

    // grade_backtrace();

    dtb_init(); // init dtb
ffffffffc0200082:	576000ef          	jal	ra,ffffffffc02005f8 <dtb_init>

    pmm_init(); // init physical memory management
ffffffffc0200086:	5b8020ef          	jal	ra,ffffffffc020263e <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	12b000ef          	jal	ra,ffffffffc02009b4 <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	129000ef          	jal	ra,ffffffffc02009b6 <idt_init>

    vmm_init(); // init virtual memory management
ffffffffc0200092:	085030ef          	jal	ra,ffffffffc0203916 <vmm_init>
    sched_init();
ffffffffc0200096:	74d040ef          	jal	ra,ffffffffc0204fe2 <sched_init>
    proc_init(); // init process table
ffffffffc020009a:	4cb040ef          	jal	ra,ffffffffc0204d64 <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009e:	4a0000ef          	jal	ra,ffffffffc020053e <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc02000a2:	107000ef          	jal	ra,ffffffffc02009a8 <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a6:	657040ef          	jal	ra,ffffffffc0204efc <cpu_idle>

ffffffffc02000aa <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000aa:	715d                	addi	sp,sp,-80
ffffffffc02000ac:	e486                	sd	ra,72(sp)
ffffffffc02000ae:	e0a6                	sd	s1,64(sp)
ffffffffc02000b0:	fc4a                	sd	s2,56(sp)
ffffffffc02000b2:	f84e                	sd	s3,48(sp)
ffffffffc02000b4:	f452                	sd	s4,40(sp)
ffffffffc02000b6:	f056                	sd	s5,32(sp)
ffffffffc02000b8:	ec5a                	sd	s6,24(sp)
ffffffffc02000ba:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000bc:	c901                	beqz	a0,ffffffffc02000cc <readline+0x22>
ffffffffc02000be:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000c0:	00006517          	auipc	a0,0x6
ffffffffc02000c4:	80850513          	addi	a0,a0,-2040 # ffffffffc02058c8 <etext+0x28>
ffffffffc02000c8:	0d0000ef          	jal	ra,ffffffffc0200198 <cprintf>
readline(const char *prompt) {
ffffffffc02000cc:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ce:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000d0:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000d2:	4aa9                	li	s5,10
ffffffffc02000d4:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d6:	000dab97          	auipc	s7,0xda
ffffffffc02000da:	55ab8b93          	addi	s7,s7,1370 # ffffffffc02da630 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000de:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000e2:	12e000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc02000e6:	00054a63          	bltz	a0,ffffffffc02000fa <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ea:	00a95a63          	bge	s2,a0,ffffffffc02000fe <readline+0x54>
ffffffffc02000ee:	029a5263          	bge	s4,s1,ffffffffc0200112 <readline+0x68>
        c = getchar();
ffffffffc02000f2:	11e000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc02000f6:	fe055ae3          	bgez	a0,ffffffffc02000ea <readline+0x40>
            return NULL;
ffffffffc02000fa:	4501                	li	a0,0
ffffffffc02000fc:	a091                	j	ffffffffc0200140 <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fe:	03351463          	bne	a0,s3,ffffffffc0200126 <readline+0x7c>
ffffffffc0200102:	e8a9                	bnez	s1,ffffffffc0200154 <readline+0xaa>
        c = getchar();
ffffffffc0200104:	10c000ef          	jal	ra,ffffffffc0200210 <getchar>
        if (c < 0) {
ffffffffc0200108:	fe0549e3          	bltz	a0,ffffffffc02000fa <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc020010c:	fea959e3          	bge	s2,a0,ffffffffc02000fe <readline+0x54>
ffffffffc0200110:	4481                	li	s1,0
            cputchar(c);
ffffffffc0200112:	e42a                	sd	a0,8(sp)
ffffffffc0200114:	0ba000ef          	jal	ra,ffffffffc02001ce <cputchar>
            buf[i ++] = c;
ffffffffc0200118:	6522                	ld	a0,8(sp)
ffffffffc020011a:	009b87b3          	add	a5,s7,s1
ffffffffc020011e:	2485                	addiw	s1,s1,1
ffffffffc0200120:	00a78023          	sb	a0,0(a5)
ffffffffc0200124:	bf7d                	j	ffffffffc02000e2 <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200126:	01550463          	beq	a0,s5,ffffffffc020012e <readline+0x84>
ffffffffc020012a:	fb651ce3          	bne	a0,s6,ffffffffc02000e2 <readline+0x38>
            cputchar(c);
ffffffffc020012e:	0a0000ef          	jal	ra,ffffffffc02001ce <cputchar>
            buf[i] = '\0';
ffffffffc0200132:	000da517          	auipc	a0,0xda
ffffffffc0200136:	4fe50513          	addi	a0,a0,1278 # ffffffffc02da630 <buf>
ffffffffc020013a:	94aa                	add	s1,s1,a0
ffffffffc020013c:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0200140:	60a6                	ld	ra,72(sp)
ffffffffc0200142:	6486                	ld	s1,64(sp)
ffffffffc0200144:	7962                	ld	s2,56(sp)
ffffffffc0200146:	79c2                	ld	s3,48(sp)
ffffffffc0200148:	7a22                	ld	s4,40(sp)
ffffffffc020014a:	7a82                	ld	s5,32(sp)
ffffffffc020014c:	6b62                	ld	s6,24(sp)
ffffffffc020014e:	6bc2                	ld	s7,16(sp)
ffffffffc0200150:	6161                	addi	sp,sp,80
ffffffffc0200152:	8082                	ret
            cputchar(c);
ffffffffc0200154:	4521                	li	a0,8
ffffffffc0200156:	078000ef          	jal	ra,ffffffffc02001ce <cputchar>
            i --;
ffffffffc020015a:	34fd                	addiw	s1,s1,-1
ffffffffc020015c:	b759                	j	ffffffffc02000e2 <readline+0x38>

ffffffffc020015e <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015e:	1141                	addi	sp,sp,-16
ffffffffc0200160:	e022                	sd	s0,0(sp)
ffffffffc0200162:	e406                	sd	ra,8(sp)
ffffffffc0200164:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200166:	422000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    (*cnt)++;
ffffffffc020016a:	401c                	lw	a5,0(s0)
}
ffffffffc020016c:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016e:	2785                	addiw	a5,a5,1
ffffffffc0200170:	c01c                	sw	a5,0(s0)
}
ffffffffc0200172:	6402                	ld	s0,0(sp)
ffffffffc0200174:	0141                	addi	sp,sp,16
ffffffffc0200176:	8082                	ret

ffffffffc0200178 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200178:	1101                	addi	sp,sp,-32
ffffffffc020017a:	862a                	mv	a2,a0
ffffffffc020017c:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017e:	00000517          	auipc	a0,0x0
ffffffffc0200182:	fe050513          	addi	a0,a0,-32 # ffffffffc020015e <cputch>
ffffffffc0200186:	006c                	addi	a1,sp,12
{
ffffffffc0200188:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc020018a:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020018c:	2c6050ef          	jal	ra,ffffffffc0205452 <vprintfmt>
    return cnt;
}
ffffffffc0200190:	60e2                	ld	ra,24(sp)
ffffffffc0200192:	4532                	lw	a0,12(sp)
ffffffffc0200194:	6105                	addi	sp,sp,32
ffffffffc0200196:	8082                	ret

ffffffffc0200198 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200198:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc020019a:	02810313          	addi	t1,sp,40 # ffffffffc020b028 <boot_page_table_sv39+0x28>
{
ffffffffc020019e:	8e2a                	mv	t3,a0
ffffffffc02001a0:	f42e                	sd	a1,40(sp)
ffffffffc02001a2:	f832                	sd	a2,48(sp)
ffffffffc02001a4:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a6:	00000517          	auipc	a0,0x0
ffffffffc02001aa:	fb850513          	addi	a0,a0,-72 # ffffffffc020015e <cputch>
ffffffffc02001ae:	004c                	addi	a1,sp,4
ffffffffc02001b0:	869a                	mv	a3,t1
ffffffffc02001b2:	8672                	mv	a2,t3
{
ffffffffc02001b4:	ec06                	sd	ra,24(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	e4be                	sd	a5,72(sp)
ffffffffc02001ba:	e8c2                	sd	a6,80(sp)
ffffffffc02001bc:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001be:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001c0:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001c2:	290050ef          	jal	ra,ffffffffc0205452 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c6:	60e2                	ld	ra,24(sp)
ffffffffc02001c8:	4512                	lw	a0,4(sp)
ffffffffc02001ca:	6125                	addi	sp,sp,96
ffffffffc02001cc:	8082                	ret

ffffffffc02001ce <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ce:	ae6d                	j	ffffffffc0200588 <cons_putc>

ffffffffc02001d0 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001d0:	1101                	addi	sp,sp,-32
ffffffffc02001d2:	e822                	sd	s0,16(sp)
ffffffffc02001d4:	ec06                	sd	ra,24(sp)
ffffffffc02001d6:	e426                	sd	s1,8(sp)
ffffffffc02001d8:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001da:	00054503          	lbu	a0,0(a0)
ffffffffc02001de:	c51d                	beqz	a0,ffffffffc020020c <cputs+0x3c>
ffffffffc02001e0:	0405                	addi	s0,s0,1
ffffffffc02001e2:	4485                	li	s1,1
ffffffffc02001e4:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e6:	3a2000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001ea:	00044503          	lbu	a0,0(s0)
ffffffffc02001ee:	008487bb          	addw	a5,s1,s0
ffffffffc02001f2:	0405                	addi	s0,s0,1
ffffffffc02001f4:	f96d                	bnez	a0,ffffffffc02001e6 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f6:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001fa:	4529                	li	a0,10
ffffffffc02001fc:	38c000ef          	jal	ra,ffffffffc0200588 <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc0200200:	60e2                	ld	ra,24(sp)
ffffffffc0200202:	8522                	mv	a0,s0
ffffffffc0200204:	6442                	ld	s0,16(sp)
ffffffffc0200206:	64a2                	ld	s1,8(sp)
ffffffffc0200208:	6105                	addi	sp,sp,32
ffffffffc020020a:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc020020c:	4405                	li	s0,1
ffffffffc020020e:	b7f5                	j	ffffffffc02001fa <cputs+0x2a>

ffffffffc0200210 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc0200210:	1141                	addi	sp,sp,-16
ffffffffc0200212:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200214:	3a8000ef          	jal	ra,ffffffffc02005bc <cons_getc>
ffffffffc0200218:	dd75                	beqz	a0,ffffffffc0200214 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc020021a:	60a2                	ld	ra,8(sp)
ffffffffc020021c:	0141                	addi	sp,sp,16
ffffffffc020021e:	8082                	ret

ffffffffc0200220 <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc0200220:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc0200222:	00005517          	auipc	a0,0x5
ffffffffc0200226:	6ae50513          	addi	a0,a0,1710 # ffffffffc02058d0 <etext+0x30>
void print_kerninfo(void) {
ffffffffc020022a:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc020022c:	f6dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc0200230:	00000597          	auipc	a1,0x0
ffffffffc0200234:	e1a58593          	addi	a1,a1,-486 # ffffffffc020004a <kern_init>
ffffffffc0200238:	00005517          	auipc	a0,0x5
ffffffffc020023c:	6b850513          	addi	a0,a0,1720 # ffffffffc02058f0 <etext+0x50>
ffffffffc0200240:	f59ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200244:	00005597          	auipc	a1,0x5
ffffffffc0200248:	65c58593          	addi	a1,a1,1628 # ffffffffc02058a0 <etext>
ffffffffc020024c:	00005517          	auipc	a0,0x5
ffffffffc0200250:	6c450513          	addi	a0,a0,1732 # ffffffffc0205910 <etext+0x70>
ffffffffc0200254:	f45ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200258:	000da597          	auipc	a1,0xda
ffffffffc020025c:	3d858593          	addi	a1,a1,984 # ffffffffc02da630 <buf>
ffffffffc0200260:	00005517          	auipc	a0,0x5
ffffffffc0200264:	6d050513          	addi	a0,a0,1744 # ffffffffc0205930 <etext+0x90>
ffffffffc0200268:	f31ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc020026c:	000df597          	auipc	a1,0xdf
ffffffffc0200270:	8a458593          	addi	a1,a1,-1884 # ffffffffc02deb10 <end>
ffffffffc0200274:	00005517          	auipc	a0,0x5
ffffffffc0200278:	6dc50513          	addi	a0,a0,1756 # ffffffffc0205950 <etext+0xb0>
ffffffffc020027c:	f1dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc0200280:	000df597          	auipc	a1,0xdf
ffffffffc0200284:	c8f58593          	addi	a1,a1,-881 # ffffffffc02def0f <end+0x3ff>
ffffffffc0200288:	00000797          	auipc	a5,0x0
ffffffffc020028c:	dc278793          	addi	a5,a5,-574 # ffffffffc020004a <kern_init>
ffffffffc0200290:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200294:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200298:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc020029a:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029e:	95be                	add	a1,a1,a5
ffffffffc02002a0:	85a9                	srai	a1,a1,0xa
ffffffffc02002a2:	00005517          	auipc	a0,0x5
ffffffffc02002a6:	6ce50513          	addi	a0,a0,1742 # ffffffffc0205970 <etext+0xd0>
}
ffffffffc02002aa:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002ac:	b5f5                	j	ffffffffc0200198 <cprintf>

ffffffffc02002ae <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc02002ae:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002b0:	00005617          	auipc	a2,0x5
ffffffffc02002b4:	6f060613          	addi	a2,a2,1776 # ffffffffc02059a0 <etext+0x100>
ffffffffc02002b8:	04d00593          	li	a1,77
ffffffffc02002bc:	00005517          	auipc	a0,0x5
ffffffffc02002c0:	6fc50513          	addi	a0,a0,1788 # ffffffffc02059b8 <etext+0x118>
void print_stackframe(void) {
ffffffffc02002c4:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c6:	1cc000ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02002ca <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002ca:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002cc:	00005617          	auipc	a2,0x5
ffffffffc02002d0:	70460613          	addi	a2,a2,1796 # ffffffffc02059d0 <etext+0x130>
ffffffffc02002d4:	00005597          	auipc	a1,0x5
ffffffffc02002d8:	71c58593          	addi	a1,a1,1820 # ffffffffc02059f0 <etext+0x150>
ffffffffc02002dc:	00005517          	auipc	a0,0x5
ffffffffc02002e0:	71c50513          	addi	a0,a0,1820 # ffffffffc02059f8 <etext+0x158>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002e4:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e6:	eb3ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc02002ea:	00005617          	auipc	a2,0x5
ffffffffc02002ee:	71e60613          	addi	a2,a2,1822 # ffffffffc0205a08 <etext+0x168>
ffffffffc02002f2:	00005597          	auipc	a1,0x5
ffffffffc02002f6:	73e58593          	addi	a1,a1,1854 # ffffffffc0205a30 <etext+0x190>
ffffffffc02002fa:	00005517          	auipc	a0,0x5
ffffffffc02002fe:	6fe50513          	addi	a0,a0,1790 # ffffffffc02059f8 <etext+0x158>
ffffffffc0200302:	e97ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0200306:	00005617          	auipc	a2,0x5
ffffffffc020030a:	73a60613          	addi	a2,a2,1850 # ffffffffc0205a40 <etext+0x1a0>
ffffffffc020030e:	00005597          	auipc	a1,0x5
ffffffffc0200312:	75258593          	addi	a1,a1,1874 # ffffffffc0205a60 <etext+0x1c0>
ffffffffc0200316:	00005517          	auipc	a0,0x5
ffffffffc020031a:	6e250513          	addi	a0,a0,1762 # ffffffffc02059f8 <etext+0x158>
ffffffffc020031e:	e7bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    }
    return 0;
}
ffffffffc0200322:	60a2                	ld	ra,8(sp)
ffffffffc0200324:	4501                	li	a0,0
ffffffffc0200326:	0141                	addi	sp,sp,16
ffffffffc0200328:	8082                	ret

ffffffffc020032a <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc020032a:	1141                	addi	sp,sp,-16
ffffffffc020032c:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032e:	ef3ff0ef          	jal	ra,ffffffffc0200220 <print_kerninfo>
    return 0;
}
ffffffffc0200332:	60a2                	ld	ra,8(sp)
ffffffffc0200334:	4501                	li	a0,0
ffffffffc0200336:	0141                	addi	sp,sp,16
ffffffffc0200338:	8082                	ret

ffffffffc020033a <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc020033a:	1141                	addi	sp,sp,-16
ffffffffc020033c:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033e:	f71ff0ef          	jal	ra,ffffffffc02002ae <print_stackframe>
    return 0;
}
ffffffffc0200342:	60a2                	ld	ra,8(sp)
ffffffffc0200344:	4501                	li	a0,0
ffffffffc0200346:	0141                	addi	sp,sp,16
ffffffffc0200348:	8082                	ret

ffffffffc020034a <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc020034a:	7115                	addi	sp,sp,-224
ffffffffc020034c:	ed5e                	sd	s7,152(sp)
ffffffffc020034e:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc0200350:	00005517          	auipc	a0,0x5
ffffffffc0200354:	72050513          	addi	a0,a0,1824 # ffffffffc0205a70 <etext+0x1d0>
kmonitor(struct trapframe *tf) {
ffffffffc0200358:	ed86                	sd	ra,216(sp)
ffffffffc020035a:	e9a2                	sd	s0,208(sp)
ffffffffc020035c:	e5a6                	sd	s1,200(sp)
ffffffffc020035e:	e1ca                	sd	s2,192(sp)
ffffffffc0200360:	fd4e                	sd	s3,184(sp)
ffffffffc0200362:	f952                	sd	s4,176(sp)
ffffffffc0200364:	f556                	sd	s5,168(sp)
ffffffffc0200366:	f15a                	sd	s6,160(sp)
ffffffffc0200368:	e962                	sd	s8,144(sp)
ffffffffc020036a:	e566                	sd	s9,136(sp)
ffffffffc020036c:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036e:	e2bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc0200372:	00005517          	auipc	a0,0x5
ffffffffc0200376:	72650513          	addi	a0,a0,1830 # ffffffffc0205a98 <etext+0x1f8>
ffffffffc020037a:	e1fff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    if (tf != NULL) {
ffffffffc020037e:	000b8563          	beqz	s7,ffffffffc0200388 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc0200382:	855e                	mv	a0,s7
ffffffffc0200384:	01b000ef          	jal	ra,ffffffffc0200b9e <print_trapframe>
ffffffffc0200388:	00005c17          	auipc	s8,0x5
ffffffffc020038c:	780c0c13          	addi	s8,s8,1920 # ffffffffc0205b08 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc0200390:	00005917          	auipc	s2,0x5
ffffffffc0200394:	73090913          	addi	s2,s2,1840 # ffffffffc0205ac0 <etext+0x220>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200398:	00005497          	auipc	s1,0x5
ffffffffc020039c:	73048493          	addi	s1,s1,1840 # ffffffffc0205ac8 <etext+0x228>
        if (argc == MAXARGS - 1) {
ffffffffc02003a0:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003a2:	00005b17          	auipc	s6,0x5
ffffffffc02003a6:	72eb0b13          	addi	s6,s6,1838 # ffffffffc0205ad0 <etext+0x230>
        argv[argc ++] = buf;
ffffffffc02003aa:	00005a17          	auipc	s4,0x5
ffffffffc02003ae:	646a0a13          	addi	s4,s4,1606 # ffffffffc02059f0 <etext+0x150>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003b2:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02003b4:	854a                	mv	a0,s2
ffffffffc02003b6:	cf5ff0ef          	jal	ra,ffffffffc02000aa <readline>
ffffffffc02003ba:	842a                	mv	s0,a0
ffffffffc02003bc:	dd65                	beqz	a0,ffffffffc02003b4 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003be:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003c2:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003c4:	e1bd                	bnez	a1,ffffffffc020042a <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc02003c6:	fe0c87e3          	beqz	s9,ffffffffc02003b4 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003ca:	6582                	ld	a1,0(sp)
ffffffffc02003cc:	00005d17          	auipc	s10,0x5
ffffffffc02003d0:	73cd0d13          	addi	s10,s10,1852 # ffffffffc0205b08 <commands>
        argv[argc ++] = buf;
ffffffffc02003d4:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003d6:	4401                	li	s0,0
ffffffffc02003d8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003da:	442050ef          	jal	ra,ffffffffc020581c <strcmp>
ffffffffc02003de:	c919                	beqz	a0,ffffffffc02003f4 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003e0:	2405                	addiw	s0,s0,1
ffffffffc02003e2:	0b540063          	beq	s0,s5,ffffffffc0200482 <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003e6:	000d3503          	ld	a0,0(s10)
ffffffffc02003ea:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc02003ec:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc02003ee:	42e050ef          	jal	ra,ffffffffc020581c <strcmp>
ffffffffc02003f2:	f57d                	bnez	a0,ffffffffc02003e0 <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f4:	00141793          	slli	a5,s0,0x1
ffffffffc02003f8:	97a2                	add	a5,a5,s0
ffffffffc02003fa:	078e                	slli	a5,a5,0x3
ffffffffc02003fc:	97e2                	add	a5,a5,s8
ffffffffc02003fe:	6b9c                	ld	a5,16(a5)
ffffffffc0200400:	865e                	mv	a2,s7
ffffffffc0200402:	002c                	addi	a1,sp,8
ffffffffc0200404:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200408:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc020040a:	fa0555e3          	bgez	a0,ffffffffc02003b4 <kmonitor+0x6a>
}
ffffffffc020040e:	60ee                	ld	ra,216(sp)
ffffffffc0200410:	644e                	ld	s0,208(sp)
ffffffffc0200412:	64ae                	ld	s1,200(sp)
ffffffffc0200414:	690e                	ld	s2,192(sp)
ffffffffc0200416:	79ea                	ld	s3,184(sp)
ffffffffc0200418:	7a4a                	ld	s4,176(sp)
ffffffffc020041a:	7aaa                	ld	s5,168(sp)
ffffffffc020041c:	7b0a                	ld	s6,160(sp)
ffffffffc020041e:	6bea                	ld	s7,152(sp)
ffffffffc0200420:	6c4a                	ld	s8,144(sp)
ffffffffc0200422:	6caa                	ld	s9,136(sp)
ffffffffc0200424:	6d0a                	ld	s10,128(sp)
ffffffffc0200426:	612d                	addi	sp,sp,224
ffffffffc0200428:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020042a:	8526                	mv	a0,s1
ffffffffc020042c:	434050ef          	jal	ra,ffffffffc0205860 <strchr>
ffffffffc0200430:	c901                	beqz	a0,ffffffffc0200440 <kmonitor+0xf6>
ffffffffc0200432:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc0200436:	00040023          	sb	zero,0(s0)
ffffffffc020043a:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020043c:	d5c9                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc020043e:	b7f5                	j	ffffffffc020042a <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc0200440:	00044783          	lbu	a5,0(s0)
ffffffffc0200444:	d3c9                	beqz	a5,ffffffffc02003c6 <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc0200446:	033c8963          	beq	s9,s3,ffffffffc0200478 <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc020044a:	003c9793          	slli	a5,s9,0x3
ffffffffc020044e:	0118                	addi	a4,sp,128
ffffffffc0200450:	97ba                	add	a5,a5,a4
ffffffffc0200452:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200456:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc020045a:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc020045c:	e591                	bnez	a1,ffffffffc0200468 <kmonitor+0x11e>
ffffffffc020045e:	b7b5                	j	ffffffffc02003ca <kmonitor+0x80>
ffffffffc0200460:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc0200464:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc0200466:	d1a5                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc0200468:	8526                	mv	a0,s1
ffffffffc020046a:	3f6050ef          	jal	ra,ffffffffc0205860 <strchr>
ffffffffc020046e:	d96d                	beqz	a0,ffffffffc0200460 <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200470:	00044583          	lbu	a1,0(s0)
ffffffffc0200474:	d9a9                	beqz	a1,ffffffffc02003c6 <kmonitor+0x7c>
ffffffffc0200476:	bf55                	j	ffffffffc020042a <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200478:	45c1                	li	a1,16
ffffffffc020047a:	855a                	mv	a0,s6
ffffffffc020047c:	d1dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0200480:	b7e9                	j	ffffffffc020044a <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc0200482:	6582                	ld	a1,0(sp)
ffffffffc0200484:	00005517          	auipc	a0,0x5
ffffffffc0200488:	66c50513          	addi	a0,a0,1644 # ffffffffc0205af0 <etext+0x250>
ffffffffc020048c:	d0dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return 0;
ffffffffc0200490:	b715                	j	ffffffffc02003b4 <kmonitor+0x6a>

ffffffffc0200492 <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc0200492:	000de317          	auipc	t1,0xde
ffffffffc0200496:	5f630313          	addi	t1,t1,1526 # ffffffffc02dea88 <is_panic>
ffffffffc020049a:	00033e03          	ld	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc020049e:	715d                	addi	sp,sp,-80
ffffffffc02004a0:	ec06                	sd	ra,24(sp)
ffffffffc02004a2:	e822                	sd	s0,16(sp)
ffffffffc02004a4:	f436                	sd	a3,40(sp)
ffffffffc02004a6:	f83a                	sd	a4,48(sp)
ffffffffc02004a8:	fc3e                	sd	a5,56(sp)
ffffffffc02004aa:	e0c2                	sd	a6,64(sp)
ffffffffc02004ac:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc02004ae:	020e1a63          	bnez	t3,ffffffffc02004e2 <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004b2:	4785                	li	a5,1
ffffffffc02004b4:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b8:	8432                	mv	s0,a2
ffffffffc02004ba:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004bc:	862e                	mv	a2,a1
ffffffffc02004be:	85aa                	mv	a1,a0
ffffffffc02004c0:	00005517          	auipc	a0,0x5
ffffffffc02004c4:	69050513          	addi	a0,a0,1680 # ffffffffc0205b50 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c8:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004ca:	ccfff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ce:	65a2                	ld	a1,8(sp)
ffffffffc02004d0:	8522                	mv	a0,s0
ffffffffc02004d2:	ca7ff0ef          	jal	ra,ffffffffc0200178 <vcprintf>
    cprintf("\n");
ffffffffc02004d6:	00006517          	auipc	a0,0x6
ffffffffc02004da:	78250513          	addi	a0,a0,1922 # ffffffffc0206c58 <default_pmm_manager+0x578>
ffffffffc02004de:	cbbff0ef          	jal	ra,ffffffffc0200198 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004e2:	4501                	li	a0,0
ffffffffc02004e4:	4581                	li	a1,0
ffffffffc02004e6:	4601                	li	a2,0
ffffffffc02004e8:	48a1                	li	a7,8
ffffffffc02004ea:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ee:	4c0000ef          	jal	ra,ffffffffc02009ae <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc02004f2:	4501                	li	a0,0
ffffffffc02004f4:	e57ff0ef          	jal	ra,ffffffffc020034a <kmonitor>
    while (1) {
ffffffffc02004f8:	bfed                	j	ffffffffc02004f2 <__panic+0x60>

ffffffffc02004fa <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc02004fa:	715d                	addi	sp,sp,-80
ffffffffc02004fc:	832e                	mv	t1,a1
ffffffffc02004fe:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200500:	85aa                	mv	a1,a0
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200502:	8432                	mv	s0,a2
ffffffffc0200504:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200508:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020050a:	00005517          	auipc	a0,0x5
ffffffffc020050e:	66650513          	addi	a0,a0,1638 # ffffffffc0205b70 <commands+0x68>
__warn(const char *file, int line, const char *fmt, ...) {
ffffffffc0200512:	ec06                	sd	ra,24(sp)
ffffffffc0200514:	f436                	sd	a3,40(sp)
ffffffffc0200516:	f83a                	sd	a4,48(sp)
ffffffffc0200518:	e0c2                	sd	a6,64(sp)
ffffffffc020051a:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc020051c:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051e:	c7bff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200522:	65a2                	ld	a1,8(sp)
ffffffffc0200524:	8522                	mv	a0,s0
ffffffffc0200526:	c53ff0ef          	jal	ra,ffffffffc0200178 <vcprintf>
    cprintf("\n");
ffffffffc020052a:	00006517          	auipc	a0,0x6
ffffffffc020052e:	72e50513          	addi	a0,a0,1838 # ffffffffc0206c58 <default_pmm_manager+0x578>
ffffffffc0200532:	c67ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    va_end(ap);
}
ffffffffc0200536:	60e2                	ld	ra,24(sp)
ffffffffc0200538:	6442                	ld	s0,16(sp)
ffffffffc020053a:	6161                	addi	sp,sp,80
ffffffffc020053c:	8082                	ret

ffffffffc020053e <clock_init>:
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void)
{
    set_csr(sie, MIP_STIP);
ffffffffc020053e:	02000793          	li	a5,32
ffffffffc0200542:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200546:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054a:	67e1                	lui	a5,0x18
ffffffffc020054c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_sched_test_out_size+0xb1c8>
ffffffffc0200550:	953e                	add	a0,a0,a5
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc0200552:	4581                	li	a1,0
ffffffffc0200554:	4601                	li	a2,0
ffffffffc0200556:	4881                	li	a7,0
ffffffffc0200558:	00000073          	ecall
    cprintf("++ setup timer interrupts\n");
ffffffffc020055c:	00005517          	auipc	a0,0x5
ffffffffc0200560:	63450513          	addi	a0,a0,1588 # ffffffffc0205b90 <commands+0x88>
    ticks = 0;
ffffffffc0200564:	000de797          	auipc	a5,0xde
ffffffffc0200568:	5207b623          	sd	zero,1324(a5) # ffffffffc02dea90 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc020056c:	b135                	j	ffffffffc0200198 <cprintf>

ffffffffc020056e <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020056e:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200572:	67e1                	lui	a5,0x18
ffffffffc0200574:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_sched_test_out_size+0xb1c8>
ffffffffc0200578:	953e                	add	a0,a0,a5
ffffffffc020057a:	4581                	li	a1,0
ffffffffc020057c:	4601                	li	a2,0
ffffffffc020057e:	4881                	li	a7,0
ffffffffc0200580:	00000073          	ecall
ffffffffc0200584:	8082                	ret

ffffffffc0200586 <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc0200586:	8082                	ret

ffffffffc0200588 <cons_putc>:
#include <assert.h>
#include <atomic.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0200588:	100027f3          	csrr	a5,sstatus
ffffffffc020058c:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc020058e:	0ff57513          	zext.b	a0,a0
ffffffffc0200592:	e799                	bnez	a5,ffffffffc02005a0 <cons_putc+0x18>
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4885                	li	a7,1
ffffffffc020059a:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc020059e:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005a6:	408000ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02005aa:	6522                	ld	a0,8(sp)
ffffffffc02005ac:	4581                	li	a1,0
ffffffffc02005ae:	4601                	li	a2,0
ffffffffc02005b0:	4885                	li	a7,1
ffffffffc02005b2:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005b6:	60e2                	ld	ra,24(sp)
ffffffffc02005b8:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005ba:	a6fd                	j	ffffffffc02009a8 <intr_enable>

ffffffffc02005bc <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005bc:	100027f3          	csrr	a5,sstatus
ffffffffc02005c0:	8b89                	andi	a5,a5,2
ffffffffc02005c2:	eb89                	bnez	a5,ffffffffc02005d4 <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005c4:	4501                	li	a0,0
ffffffffc02005c6:	4581                	li	a1,0
ffffffffc02005c8:	4601                	li	a2,0
ffffffffc02005ca:	4889                	li	a7,2
ffffffffc02005cc:	00000073          	ecall
ffffffffc02005d0:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d2:	8082                	ret
int cons_getc(void) {
ffffffffc02005d4:	1101                	addi	sp,sp,-32
ffffffffc02005d6:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005d8:	3d6000ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02005dc:	4501                	li	a0,0
ffffffffc02005de:	4581                	li	a1,0
ffffffffc02005e0:	4601                	li	a2,0
ffffffffc02005e2:	4889                	li	a7,2
ffffffffc02005e4:	00000073          	ecall
ffffffffc02005e8:	2501                	sext.w	a0,a0
ffffffffc02005ea:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005ec:	3bc000ef          	jal	ra,ffffffffc02009a8 <intr_enable>
}
ffffffffc02005f0:	60e2                	ld	ra,24(sp)
ffffffffc02005f2:	6522                	ld	a0,8(sp)
ffffffffc02005f4:	6105                	addi	sp,sp,32
ffffffffc02005f6:	8082                	ret

ffffffffc02005f8 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005f8:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc02005fa:	00005517          	auipc	a0,0x5
ffffffffc02005fe:	5b650513          	addi	a0,a0,1462 # ffffffffc0205bb0 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200602:	fc86                	sd	ra,120(sp)
ffffffffc0200604:	f8a2                	sd	s0,112(sp)
ffffffffc0200606:	e8d2                	sd	s4,80(sp)
ffffffffc0200608:	f4a6                	sd	s1,104(sp)
ffffffffc020060a:	f0ca                	sd	s2,96(sp)
ffffffffc020060c:	ecce                	sd	s3,88(sp)
ffffffffc020060e:	e4d6                	sd	s5,72(sp)
ffffffffc0200610:	e0da                	sd	s6,64(sp)
ffffffffc0200612:	fc5e                	sd	s7,56(sp)
ffffffffc0200614:	f862                	sd	s8,48(sp)
ffffffffc0200616:	f466                	sd	s9,40(sp)
ffffffffc0200618:	f06a                	sd	s10,32(sp)
ffffffffc020061a:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc020061c:	b7dff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200620:	0000c597          	auipc	a1,0xc
ffffffffc0200624:	9e05b583          	ld	a1,-1568(a1) # ffffffffc020c000 <boot_hartid>
ffffffffc0200628:	00005517          	auipc	a0,0x5
ffffffffc020062c:	59850513          	addi	a0,a0,1432 # ffffffffc0205bc0 <commands+0xb8>
ffffffffc0200630:	b69ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc0200634:	0000c417          	auipc	s0,0xc
ffffffffc0200638:	9d440413          	addi	s0,s0,-1580 # ffffffffc020c008 <boot_dtb>
ffffffffc020063c:	600c                	ld	a1,0(s0)
ffffffffc020063e:	00005517          	auipc	a0,0x5
ffffffffc0200642:	59250513          	addi	a0,a0,1426 # ffffffffc0205bd0 <commands+0xc8>
ffffffffc0200646:	b53ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc020064a:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc020064e:	00005517          	auipc	a0,0x5
ffffffffc0200652:	59a50513          	addi	a0,a0,1434 # ffffffffc0205be8 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc0200656:	120a0463          	beqz	s4,ffffffffc020077e <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc020065a:	57f5                	li	a5,-3
ffffffffc020065c:	07fa                	slli	a5,a5,0x1e
ffffffffc020065e:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200662:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200664:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200668:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020066e:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200672:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200676:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020067a:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067e:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	8ec9                	or	a3,a3,a0
ffffffffc0200682:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200686:	1b7d                	addi	s6,s6,-1
ffffffffc0200688:	0167f7b3          	and	a5,a5,s6
ffffffffc020068c:	8dd5                	or	a1,a1,a3
ffffffffc020068e:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200690:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200694:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe013dd>
ffffffffc020069a:	10f59163          	bne	a1,a5,ffffffffc020079c <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc020069e:	471c                	lw	a5,8(a4)
ffffffffc02006a0:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a2:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006a4:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006a8:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006ac:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b0:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006b4:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b8:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006bc:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c0:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c4:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c8:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006cc:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	01146433          	or	s0,s0,a7
ffffffffc02006d2:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006d6:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006da:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006dc:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e0:	8c49                	or	s0,s0,a0
ffffffffc02006e2:	0166f6b3          	and	a3,a3,s6
ffffffffc02006e6:	00ca6a33          	or	s4,s4,a2
ffffffffc02006ea:	0167f7b3          	and	a5,a5,s6
ffffffffc02006ee:	8c55                	or	s0,s0,a3
ffffffffc02006f0:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006f4:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006f6:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006f8:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fa:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200702:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc0200706:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200708:	00005917          	auipc	s2,0x5
ffffffffc020070c:	53090913          	addi	s2,s2,1328 # ffffffffc0205c38 <commands+0x130>
ffffffffc0200710:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200712:	4d91                	li	s11,4
ffffffffc0200714:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200716:	00005497          	auipc	s1,0x5
ffffffffc020071a:	51a48493          	addi	s1,s1,1306 # ffffffffc0205c30 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc020071e:	000a2703          	lw	a4,0(s4)
ffffffffc0200722:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200726:	0087569b          	srliw	a3,a4,0x8
ffffffffc020072a:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020072e:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200732:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200736:	0107571b          	srliw	a4,a4,0x10
ffffffffc020073a:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020073c:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200740:	0087171b          	slliw	a4,a4,0x8
ffffffffc0200744:	8fd5                	or	a5,a5,a3
ffffffffc0200746:	00eb7733          	and	a4,s6,a4
ffffffffc020074a:	8fd9                	or	a5,a5,a4
ffffffffc020074c:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc020074e:	09778c63          	beq	a5,s7,ffffffffc02007e6 <dtb_init+0x1ee>
ffffffffc0200752:	00fbea63          	bltu	s7,a5,ffffffffc0200766 <dtb_init+0x16e>
ffffffffc0200756:	07a78663          	beq	a5,s10,ffffffffc02007c2 <dtb_init+0x1ca>
ffffffffc020075a:	4709                	li	a4,2
ffffffffc020075c:	00e79763          	bne	a5,a4,ffffffffc020076a <dtb_init+0x172>
ffffffffc0200760:	4c81                	li	s9,0
ffffffffc0200762:	8a56                	mv	s4,s5
ffffffffc0200764:	bf6d                	j	ffffffffc020071e <dtb_init+0x126>
ffffffffc0200766:	ffb78ee3          	beq	a5,s11,ffffffffc0200762 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc020076a:	00005517          	auipc	a0,0x5
ffffffffc020076e:	54650513          	addi	a0,a0,1350 # ffffffffc0205cb0 <commands+0x1a8>
ffffffffc0200772:	a27ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200776:	00005517          	auipc	a0,0x5
ffffffffc020077a:	57250513          	addi	a0,a0,1394 # ffffffffc0205ce8 <commands+0x1e0>
}
ffffffffc020077e:	7446                	ld	s0,112(sp)
ffffffffc0200780:	70e6                	ld	ra,120(sp)
ffffffffc0200782:	74a6                	ld	s1,104(sp)
ffffffffc0200784:	7906                	ld	s2,96(sp)
ffffffffc0200786:	69e6                	ld	s3,88(sp)
ffffffffc0200788:	6a46                	ld	s4,80(sp)
ffffffffc020078a:	6aa6                	ld	s5,72(sp)
ffffffffc020078c:	6b06                	ld	s6,64(sp)
ffffffffc020078e:	7be2                	ld	s7,56(sp)
ffffffffc0200790:	7c42                	ld	s8,48(sp)
ffffffffc0200792:	7ca2                	ld	s9,40(sp)
ffffffffc0200794:	7d02                	ld	s10,32(sp)
ffffffffc0200796:	6de2                	ld	s11,24(sp)
ffffffffc0200798:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc020079a:	bafd                	j	ffffffffc0200198 <cprintf>
}
ffffffffc020079c:	7446                	ld	s0,112(sp)
ffffffffc020079e:	70e6                	ld	ra,120(sp)
ffffffffc02007a0:	74a6                	ld	s1,104(sp)
ffffffffc02007a2:	7906                	ld	s2,96(sp)
ffffffffc02007a4:	69e6                	ld	s3,88(sp)
ffffffffc02007a6:	6a46                	ld	s4,80(sp)
ffffffffc02007a8:	6aa6                	ld	s5,72(sp)
ffffffffc02007aa:	6b06                	ld	s6,64(sp)
ffffffffc02007ac:	7be2                	ld	s7,56(sp)
ffffffffc02007ae:	7c42                	ld	s8,48(sp)
ffffffffc02007b0:	7ca2                	ld	s9,40(sp)
ffffffffc02007b2:	7d02                	ld	s10,32(sp)
ffffffffc02007b4:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007b6:	00005517          	auipc	a0,0x5
ffffffffc02007ba:	45250513          	addi	a0,a0,1106 # ffffffffc0205c08 <commands+0x100>
}
ffffffffc02007be:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c0:	bae1                	j	ffffffffc0200198 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c2:	8556                	mv	a0,s5
ffffffffc02007c4:	010050ef          	jal	ra,ffffffffc02057d4 <strlen>
ffffffffc02007c8:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007ca:	4619                	li	a2,6
ffffffffc02007cc:	85a6                	mv	a1,s1
ffffffffc02007ce:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d0:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d2:	068050ef          	jal	ra,ffffffffc020583a <strncmp>
ffffffffc02007d6:	e111                	bnez	a0,ffffffffc02007da <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007d8:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007da:	0a91                	addi	s5,s5,4
ffffffffc02007dc:	9ad2                	add	s5,s5,s4
ffffffffc02007de:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e2:	8a56                	mv	s4,s5
ffffffffc02007e4:	bf2d                	j	ffffffffc020071e <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007e6:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ea:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007ee:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f2:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007f6:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007fa:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fe:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200802:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200806:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020080a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020080e:	00eaeab3          	or	s5,s5,a4
ffffffffc0200812:	00fb77b3          	and	a5,s6,a5
ffffffffc0200816:	00faeab3          	or	s5,s5,a5
ffffffffc020081a:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020081c:	000c9c63          	bnez	s9,ffffffffc0200834 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200820:	1a82                	slli	s5,s5,0x20
ffffffffc0200822:	00368793          	addi	a5,a3,3
ffffffffc0200826:	020ada93          	srli	s5,s5,0x20
ffffffffc020082a:	9abe                	add	s5,s5,a5
ffffffffc020082c:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200830:	8a56                	mv	s4,s5
ffffffffc0200832:	b5f5                	j	ffffffffc020071e <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200834:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200838:	85ca                	mv	a1,s2
ffffffffc020083a:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020083c:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200840:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200844:	0187971b          	slliw	a4,a5,0x18
ffffffffc0200848:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020084c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200850:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200852:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200856:	0087979b          	slliw	a5,a5,0x8
ffffffffc020085a:	8d59                	or	a0,a0,a4
ffffffffc020085c:	00fb77b3          	and	a5,s6,a5
ffffffffc0200860:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200862:	1502                	slli	a0,a0,0x20
ffffffffc0200864:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200866:	9522                	add	a0,a0,s0
ffffffffc0200868:	7b5040ef          	jal	ra,ffffffffc020581c <strcmp>
ffffffffc020086c:	66a2                	ld	a3,8(sp)
ffffffffc020086e:	f94d                	bnez	a0,ffffffffc0200820 <dtb_init+0x228>
ffffffffc0200870:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200820 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200874:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc0200878:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc020087c:	00005517          	auipc	a0,0x5
ffffffffc0200880:	3c450513          	addi	a0,a0,964 # ffffffffc0205c40 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc0200884:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200888:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc020088c:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200890:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200894:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200898:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020089c:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a0:	0187d693          	srli	a3,a5,0x18
ffffffffc02008a4:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008a8:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008ac:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b0:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008b4:	010f6f33          	or	t5,t5,a6
ffffffffc02008b8:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008bc:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c0:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008c4:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c8:	0186f6b3          	and	a3,a3,s8
ffffffffc02008cc:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d0:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008d4:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008d8:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008dc:	8361                	srli	a4,a4,0x18
ffffffffc02008de:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e2:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008e6:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008ea:	00cb7633          	and	a2,s6,a2
ffffffffc02008ee:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f2:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008f6:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008fa:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008fe:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200902:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200906:	0088989b          	slliw	a7,a7,0x8
ffffffffc020090a:	011b78b3          	and	a7,s6,a7
ffffffffc020090e:	005eeeb3          	or	t4,t4,t0
ffffffffc0200912:	00c6e733          	or	a4,a3,a2
ffffffffc0200916:	006c6c33          	or	s8,s8,t1
ffffffffc020091a:	010b76b3          	and	a3,s6,a6
ffffffffc020091e:	00bb7b33          	and	s6,s6,a1
ffffffffc0200922:	01d7e7b3          	or	a5,a5,t4
ffffffffc0200926:	016c6b33          	or	s6,s8,s6
ffffffffc020092a:	01146433          	or	s0,s0,a7
ffffffffc020092e:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200930:	1702                	slli	a4,a4,0x20
ffffffffc0200932:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200934:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200938:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093a:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	0167eb33          	or	s6,a5,s6
ffffffffc0200942:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200944:	855ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc0200948:	85a2                	mv	a1,s0
ffffffffc020094a:	00005517          	auipc	a0,0x5
ffffffffc020094e:	31650513          	addi	a0,a0,790 # ffffffffc0205c60 <commands+0x158>
ffffffffc0200952:	847ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc0200956:	014b5613          	srli	a2,s6,0x14
ffffffffc020095a:	85da                	mv	a1,s6
ffffffffc020095c:	00005517          	auipc	a0,0x5
ffffffffc0200960:	31c50513          	addi	a0,a0,796 # ffffffffc0205c78 <commands+0x170>
ffffffffc0200964:	835ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200968:	008b05b3          	add	a1,s6,s0
ffffffffc020096c:	15fd                	addi	a1,a1,-1
ffffffffc020096e:	00005517          	auipc	a0,0x5
ffffffffc0200972:	32a50513          	addi	a0,a0,810 # ffffffffc0205c98 <commands+0x190>
ffffffffc0200976:	823ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc020097a:	00005517          	auipc	a0,0x5
ffffffffc020097e:	36e50513          	addi	a0,a0,878 # ffffffffc0205ce8 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200982:	000de797          	auipc	a5,0xde
ffffffffc0200986:	1087bb23          	sd	s0,278(a5) # ffffffffc02dea98 <memory_base>
        memory_size = mem_size;
ffffffffc020098a:	000de797          	auipc	a5,0xde
ffffffffc020098e:	1167bb23          	sd	s6,278(a5) # ffffffffc02deaa0 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200992:	b3f5                	j	ffffffffc020077e <dtb_init+0x186>

ffffffffc0200994 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200994:	000de517          	auipc	a0,0xde
ffffffffc0200998:	10453503          	ld	a0,260(a0) # ffffffffc02dea98 <memory_base>
ffffffffc020099c:	8082                	ret

ffffffffc020099e <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc020099e:	000de517          	auipc	a0,0xde
ffffffffc02009a2:	10253503          	ld	a0,258(a0) # ffffffffc02deaa0 <memory_size>
ffffffffc02009a6:	8082                	ret

ffffffffc02009a8 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009a8:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009b4:	8082                	ret

ffffffffc02009b6 <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009b6:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009ba:	00000797          	auipc	a5,0x0
ffffffffc02009be:	45a78793          	addi	a5,a5,1114 # ffffffffc0200e14 <__alltraps>
ffffffffc02009c2:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009c6:	000407b7          	lui	a5,0x40
ffffffffc02009ca:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009ce:	8082                	ret

ffffffffc02009d0 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d0:	610c                	ld	a1,0(a0)
{
ffffffffc02009d2:	1141                	addi	sp,sp,-16
ffffffffc02009d4:	e022                	sd	s0,0(sp)
ffffffffc02009d6:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d8:	00005517          	auipc	a0,0x5
ffffffffc02009dc:	32850513          	addi	a0,a0,808 # ffffffffc0205d00 <commands+0x1f8>
{
ffffffffc02009e0:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e2:	fb6ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009e6:	640c                	ld	a1,8(s0)
ffffffffc02009e8:	00005517          	auipc	a0,0x5
ffffffffc02009ec:	33050513          	addi	a0,a0,816 # ffffffffc0205d18 <commands+0x210>
ffffffffc02009f0:	fa8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009f4:	680c                	ld	a1,16(s0)
ffffffffc02009f6:	00005517          	auipc	a0,0x5
ffffffffc02009fa:	33a50513          	addi	a0,a0,826 # ffffffffc0205d30 <commands+0x228>
ffffffffc02009fe:	f9aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a02:	6c0c                	ld	a1,24(s0)
ffffffffc0200a04:	00005517          	auipc	a0,0x5
ffffffffc0200a08:	34450513          	addi	a0,a0,836 # ffffffffc0205d48 <commands+0x240>
ffffffffc0200a0c:	f8cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a10:	700c                	ld	a1,32(s0)
ffffffffc0200a12:	00005517          	auipc	a0,0x5
ffffffffc0200a16:	34e50513          	addi	a0,a0,846 # ffffffffc0205d60 <commands+0x258>
ffffffffc0200a1a:	f7eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a1e:	740c                	ld	a1,40(s0)
ffffffffc0200a20:	00005517          	auipc	a0,0x5
ffffffffc0200a24:	35850513          	addi	a0,a0,856 # ffffffffc0205d78 <commands+0x270>
ffffffffc0200a28:	f70ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a2c:	780c                	ld	a1,48(s0)
ffffffffc0200a2e:	00005517          	auipc	a0,0x5
ffffffffc0200a32:	36250513          	addi	a0,a0,866 # ffffffffc0205d90 <commands+0x288>
ffffffffc0200a36:	f62ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a3a:	7c0c                	ld	a1,56(s0)
ffffffffc0200a3c:	00005517          	auipc	a0,0x5
ffffffffc0200a40:	36c50513          	addi	a0,a0,876 # ffffffffc0205da8 <commands+0x2a0>
ffffffffc0200a44:	f54ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a48:	602c                	ld	a1,64(s0)
ffffffffc0200a4a:	00005517          	auipc	a0,0x5
ffffffffc0200a4e:	37650513          	addi	a0,a0,886 # ffffffffc0205dc0 <commands+0x2b8>
ffffffffc0200a52:	f46ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a56:	642c                	ld	a1,72(s0)
ffffffffc0200a58:	00005517          	auipc	a0,0x5
ffffffffc0200a5c:	38050513          	addi	a0,a0,896 # ffffffffc0205dd8 <commands+0x2d0>
ffffffffc0200a60:	f38ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a64:	682c                	ld	a1,80(s0)
ffffffffc0200a66:	00005517          	auipc	a0,0x5
ffffffffc0200a6a:	38a50513          	addi	a0,a0,906 # ffffffffc0205df0 <commands+0x2e8>
ffffffffc0200a6e:	f2aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a72:	6c2c                	ld	a1,88(s0)
ffffffffc0200a74:	00005517          	auipc	a0,0x5
ffffffffc0200a78:	39450513          	addi	a0,a0,916 # ffffffffc0205e08 <commands+0x300>
ffffffffc0200a7c:	f1cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a80:	702c                	ld	a1,96(s0)
ffffffffc0200a82:	00005517          	auipc	a0,0x5
ffffffffc0200a86:	39e50513          	addi	a0,a0,926 # ffffffffc0205e20 <commands+0x318>
ffffffffc0200a8a:	f0eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a8e:	742c                	ld	a1,104(s0)
ffffffffc0200a90:	00005517          	auipc	a0,0x5
ffffffffc0200a94:	3a850513          	addi	a0,a0,936 # ffffffffc0205e38 <commands+0x330>
ffffffffc0200a98:	f00ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200a9c:	782c                	ld	a1,112(s0)
ffffffffc0200a9e:	00005517          	auipc	a0,0x5
ffffffffc0200aa2:	3b250513          	addi	a0,a0,946 # ffffffffc0205e50 <commands+0x348>
ffffffffc0200aa6:	ef2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200aaa:	7c2c                	ld	a1,120(s0)
ffffffffc0200aac:	00005517          	auipc	a0,0x5
ffffffffc0200ab0:	3bc50513          	addi	a0,a0,956 # ffffffffc0205e68 <commands+0x360>
ffffffffc0200ab4:	ee4ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200ab8:	604c                	ld	a1,128(s0)
ffffffffc0200aba:	00005517          	auipc	a0,0x5
ffffffffc0200abe:	3c650513          	addi	a0,a0,966 # ffffffffc0205e80 <commands+0x378>
ffffffffc0200ac2:	ed6ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200ac6:	644c                	ld	a1,136(s0)
ffffffffc0200ac8:	00005517          	auipc	a0,0x5
ffffffffc0200acc:	3d050513          	addi	a0,a0,976 # ffffffffc0205e98 <commands+0x390>
ffffffffc0200ad0:	ec8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ad4:	684c                	ld	a1,144(s0)
ffffffffc0200ad6:	00005517          	auipc	a0,0x5
ffffffffc0200ada:	3da50513          	addi	a0,a0,986 # ffffffffc0205eb0 <commands+0x3a8>
ffffffffc0200ade:	ebaff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae2:	6c4c                	ld	a1,152(s0)
ffffffffc0200ae4:	00005517          	auipc	a0,0x5
ffffffffc0200ae8:	3e450513          	addi	a0,a0,996 # ffffffffc0205ec8 <commands+0x3c0>
ffffffffc0200aec:	eacff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af0:	704c                	ld	a1,160(s0)
ffffffffc0200af2:	00005517          	auipc	a0,0x5
ffffffffc0200af6:	3ee50513          	addi	a0,a0,1006 # ffffffffc0205ee0 <commands+0x3d8>
ffffffffc0200afa:	e9eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200afe:	744c                	ld	a1,168(s0)
ffffffffc0200b00:	00005517          	auipc	a0,0x5
ffffffffc0200b04:	3f850513          	addi	a0,a0,1016 # ffffffffc0205ef8 <commands+0x3f0>
ffffffffc0200b08:	e90ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b0c:	784c                	ld	a1,176(s0)
ffffffffc0200b0e:	00005517          	auipc	a0,0x5
ffffffffc0200b12:	40250513          	addi	a0,a0,1026 # ffffffffc0205f10 <commands+0x408>
ffffffffc0200b16:	e82ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b1a:	7c4c                	ld	a1,184(s0)
ffffffffc0200b1c:	00005517          	auipc	a0,0x5
ffffffffc0200b20:	40c50513          	addi	a0,a0,1036 # ffffffffc0205f28 <commands+0x420>
ffffffffc0200b24:	e74ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b28:	606c                	ld	a1,192(s0)
ffffffffc0200b2a:	00005517          	auipc	a0,0x5
ffffffffc0200b2e:	41650513          	addi	a0,a0,1046 # ffffffffc0205f40 <commands+0x438>
ffffffffc0200b32:	e66ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b36:	646c                	ld	a1,200(s0)
ffffffffc0200b38:	00005517          	auipc	a0,0x5
ffffffffc0200b3c:	42050513          	addi	a0,a0,1056 # ffffffffc0205f58 <commands+0x450>
ffffffffc0200b40:	e58ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b44:	686c                	ld	a1,208(s0)
ffffffffc0200b46:	00005517          	auipc	a0,0x5
ffffffffc0200b4a:	42a50513          	addi	a0,a0,1066 # ffffffffc0205f70 <commands+0x468>
ffffffffc0200b4e:	e4aff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b52:	6c6c                	ld	a1,216(s0)
ffffffffc0200b54:	00005517          	auipc	a0,0x5
ffffffffc0200b58:	43450513          	addi	a0,a0,1076 # ffffffffc0205f88 <commands+0x480>
ffffffffc0200b5c:	e3cff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b60:	706c                	ld	a1,224(s0)
ffffffffc0200b62:	00005517          	auipc	a0,0x5
ffffffffc0200b66:	43e50513          	addi	a0,a0,1086 # ffffffffc0205fa0 <commands+0x498>
ffffffffc0200b6a:	e2eff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b6e:	746c                	ld	a1,232(s0)
ffffffffc0200b70:	00005517          	auipc	a0,0x5
ffffffffc0200b74:	44850513          	addi	a0,a0,1096 # ffffffffc0205fb8 <commands+0x4b0>
ffffffffc0200b78:	e20ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b7c:	786c                	ld	a1,240(s0)
ffffffffc0200b7e:	00005517          	auipc	a0,0x5
ffffffffc0200b82:	45250513          	addi	a0,a0,1106 # ffffffffc0205fd0 <commands+0x4c8>
ffffffffc0200b86:	e12ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b8a:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b8c:	6402                	ld	s0,0(sp)
ffffffffc0200b8e:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	00005517          	auipc	a0,0x5
ffffffffc0200b94:	45850513          	addi	a0,a0,1112 # ffffffffc0205fe8 <commands+0x4e0>
}
ffffffffc0200b98:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b9a:	dfeff06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0200b9e <print_trapframe>:
{
ffffffffc0200b9e:	1141                	addi	sp,sp,-16
ffffffffc0200ba0:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba2:	85aa                	mv	a1,a0
{
ffffffffc0200ba4:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba6:	00005517          	auipc	a0,0x5
ffffffffc0200baa:	45a50513          	addi	a0,a0,1114 # ffffffffc0206000 <commands+0x4f8>
{
ffffffffc0200bae:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb0:	de8ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bb4:	8522                	mv	a0,s0
ffffffffc0200bb6:	e1bff0ef          	jal	ra,ffffffffc02009d0 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bba:	10043583          	ld	a1,256(s0)
ffffffffc0200bbe:	00005517          	auipc	a0,0x5
ffffffffc0200bc2:	45a50513          	addi	a0,a0,1114 # ffffffffc0206018 <commands+0x510>
ffffffffc0200bc6:	dd2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bca:	10843583          	ld	a1,264(s0)
ffffffffc0200bce:	00005517          	auipc	a0,0x5
ffffffffc0200bd2:	46250513          	addi	a0,a0,1122 # ffffffffc0206030 <commands+0x528>
ffffffffc0200bd6:	dc2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200bda:	11043583          	ld	a1,272(s0)
ffffffffc0200bde:	00005517          	auipc	a0,0x5
ffffffffc0200be2:	46a50513          	addi	a0,a0,1130 # ffffffffc0206048 <commands+0x540>
ffffffffc0200be6:	db2ff0ef          	jal	ra,ffffffffc0200198 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bea:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bee:	6402                	ld	s0,0(sp)
ffffffffc0200bf0:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf2:	00005517          	auipc	a0,0x5
ffffffffc0200bf6:	46650513          	addi	a0,a0,1126 # ffffffffc0206058 <commands+0x550>
}
ffffffffc0200bfa:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bfc:	d9cff06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0200c00 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c00:	11853783          	ld	a5,280(a0)
ffffffffc0200c04:	472d                	li	a4,11
ffffffffc0200c06:	0786                	slli	a5,a5,0x1
ffffffffc0200c08:	8385                	srli	a5,a5,0x1
ffffffffc0200c0a:	08f76263          	bltu	a4,a5,ffffffffc0200c8e <interrupt_handler+0x8e>
ffffffffc0200c0e:	00005717          	auipc	a4,0x5
ffffffffc0200c12:	51270713          	addi	a4,a4,1298 # ffffffffc0206120 <commands+0x618>
ffffffffc0200c16:	078a                	slli	a5,a5,0x2
ffffffffc0200c18:	97ba                	add	a5,a5,a4
ffffffffc0200c1a:	439c                	lw	a5,0(a5)
ffffffffc0200c1c:	97ba                	add	a5,a5,a4
ffffffffc0200c1e:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c20:	00005517          	auipc	a0,0x5
ffffffffc0200c24:	4b050513          	addi	a0,a0,1200 # ffffffffc02060d0 <commands+0x5c8>
ffffffffc0200c28:	d70ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c2c:	00005517          	auipc	a0,0x5
ffffffffc0200c30:	48450513          	addi	a0,a0,1156 # ffffffffc02060b0 <commands+0x5a8>
ffffffffc0200c34:	d64ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c38:	00005517          	auipc	a0,0x5
ffffffffc0200c3c:	43850513          	addi	a0,a0,1080 # ffffffffc0206070 <commands+0x568>
ffffffffc0200c40:	d58ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c44:	00005517          	auipc	a0,0x5
ffffffffc0200c48:	44c50513          	addi	a0,a0,1100 # ffffffffc0206090 <commands+0x588>
ffffffffc0200c4c:	d4cff06f          	j	ffffffffc0200198 <cprintf>
{
ffffffffc0200c50:	1141                	addi	sp,sp,-16
ffffffffc0200c52:	e406                	sd	ra,8(sp)
        // In fact, Call sbi_set_timer will clear STIP, or you can clear it
        // directly.
        // clear_csr(sip, SIP_STIP);

        /* LAB3 :填写你在lab3中实现的代码 */
        clock_set_next_event();                            // (1) 设置下次时钟中断
ffffffffc0200c54:	91bff0ef          	jal	ra,ffffffffc020056e <clock_set_next_event>
        ticks++;                                           // (2) 计数器加一
ffffffffc0200c58:	000de797          	auipc	a5,0xde
ffffffffc0200c5c:	e3878793          	addi	a5,a5,-456 # ffffffffc02dea90 <ticks>
ffffffffc0200c60:	6398                	ld	a4,0(a5)
ffffffffc0200c62:	0705                	addi	a4,a4,1
ffffffffc0200c64:	e398                	sd	a4,0(a5)
        if (ticks % TICK_NUM == 0) {                       // (3) 每100次时钟中断
ffffffffc0200c66:	639c                	ld	a5,0(a5)
ffffffffc0200c68:	06400713          	li	a4,100
ffffffffc0200c6c:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200c70:	c385                	beqz	a5,ffffffffc0200c90 <interrupt_handler+0x90>
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c72:	60a2                	ld	ra,8(sp)
        sched_class_proc_tick(current);
ffffffffc0200c74:	000de517          	auipc	a0,0xde
ffffffffc0200c78:	e6c53503          	ld	a0,-404(a0) # ffffffffc02deae0 <current>
}
ffffffffc0200c7c:	0141                	addi	sp,sp,16
        sched_class_proc_tick(current);
ffffffffc0200c7e:	33c0406f          	j	ffffffffc0204fba <sched_class_proc_tick>
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c82:	00005517          	auipc	a0,0x5
ffffffffc0200c86:	47e50513          	addi	a0,a0,1150 # ffffffffc0206100 <commands+0x5f8>
ffffffffc0200c8a:	d0eff06f          	j	ffffffffc0200198 <cprintf>
        print_trapframe(tf);
ffffffffc0200c8e:	bf01                	j	ffffffffc0200b9e <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200c90:	06400593          	li	a1,100
ffffffffc0200c94:	00005517          	auipc	a0,0x5
ffffffffc0200c98:	45c50513          	addi	a0,a0,1116 # ffffffffc02060f0 <commands+0x5e8>
ffffffffc0200c9c:	cfcff0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0200ca0:	bfc9                	j	ffffffffc0200c72 <interrupt_handler+0x72>

ffffffffc0200ca2 <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200ca2:	11853783          	ld	a5,280(a0)
{
ffffffffc0200ca6:	1141                	addi	sp,sp,-16
ffffffffc0200ca8:	e022                	sd	s0,0(sp)
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	473d                	li	a4,15
ffffffffc0200cae:	842a                	mv	s0,a0
ffffffffc0200cb0:	0af76b63          	bltu	a4,a5,ffffffffc0200d66 <exception_handler+0xc4>
ffffffffc0200cb4:	00005717          	auipc	a4,0x5
ffffffffc0200cb8:	62c70713          	addi	a4,a4,1580 # ffffffffc02062e0 <commands+0x7d8>
ffffffffc0200cbc:	078a                	slli	a5,a5,0x2
ffffffffc0200cbe:	97ba                	add	a5,a5,a4
ffffffffc0200cc0:	439c                	lw	a5,0(a5)
ffffffffc0200cc2:	97ba                	add	a5,a5,a4
ffffffffc0200cc4:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200cc6:	00005517          	auipc	a0,0x5
ffffffffc0200cca:	57250513          	addi	a0,a0,1394 # ffffffffc0206238 <commands+0x730>
ffffffffc0200cce:	ccaff0ef          	jal	ra,ffffffffc0200198 <cprintf>
        tf->epc += 4;
ffffffffc0200cd2:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200cd6:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200cd8:	0791                	addi	a5,a5,4
ffffffffc0200cda:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200cde:	6402                	ld	s0,0(sp)
ffffffffc0200ce0:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200ce2:	66c0406f          	j	ffffffffc020534e <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200ce6:	00005517          	auipc	a0,0x5
ffffffffc0200cea:	57250513          	addi	a0,a0,1394 # ffffffffc0206258 <commands+0x750>
}
ffffffffc0200cee:	6402                	ld	s0,0(sp)
ffffffffc0200cf0:	60a2                	ld	ra,8(sp)
ffffffffc0200cf2:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200cf4:	ca4ff06f          	j	ffffffffc0200198 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200cf8:	00005517          	auipc	a0,0x5
ffffffffc0200cfc:	58050513          	addi	a0,a0,1408 # ffffffffc0206278 <commands+0x770>
ffffffffc0200d00:	b7fd                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200d02:	00005517          	auipc	a0,0x5
ffffffffc0200d06:	59650513          	addi	a0,a0,1430 # ffffffffc0206298 <commands+0x790>
ffffffffc0200d0a:	b7d5                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d0c:	00005517          	auipc	a0,0x5
ffffffffc0200d10:	5a450513          	addi	a0,a0,1444 # ffffffffc02062b0 <commands+0x7a8>
ffffffffc0200d14:	bfe9                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d16:	00005517          	auipc	a0,0x5
ffffffffc0200d1a:	5b250513          	addi	a0,a0,1458 # ffffffffc02062c8 <commands+0x7c0>
ffffffffc0200d1e:	bfc1                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d20:	00005517          	auipc	a0,0x5
ffffffffc0200d24:	43050513          	addi	a0,a0,1072 # ffffffffc0206150 <commands+0x648>
ffffffffc0200d28:	b7d9                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d2a:	00005517          	auipc	a0,0x5
ffffffffc0200d2e:	44650513          	addi	a0,a0,1094 # ffffffffc0206170 <commands+0x668>
ffffffffc0200d32:	bf75                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d34:	00005517          	auipc	a0,0x5
ffffffffc0200d38:	45c50513          	addi	a0,a0,1116 # ffffffffc0206190 <commands+0x688>
ffffffffc0200d3c:	bf4d                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d3e:	00005517          	auipc	a0,0x5
ffffffffc0200d42:	46a50513          	addi	a0,a0,1130 # ffffffffc02061a8 <commands+0x6a0>
ffffffffc0200d46:	b765                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Load address misaligned\n");
ffffffffc0200d48:	00005517          	auipc	a0,0x5
ffffffffc0200d4c:	47050513          	addi	a0,a0,1136 # ffffffffc02061b8 <commands+0x6b0>
ffffffffc0200d50:	bf79                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d52:	00005517          	auipc	a0,0x5
ffffffffc0200d56:	48650513          	addi	a0,a0,1158 # ffffffffc02061d8 <commands+0x6d0>
ffffffffc0200d5a:	bf51                	j	ffffffffc0200cee <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200d5c:	00005517          	auipc	a0,0x5
ffffffffc0200d60:	4c450513          	addi	a0,a0,1220 # ffffffffc0206220 <commands+0x718>
ffffffffc0200d64:	b769                	j	ffffffffc0200cee <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200d66:	8522                	mv	a0,s0
}
ffffffffc0200d68:	6402                	ld	s0,0(sp)
ffffffffc0200d6a:	60a2                	ld	ra,8(sp)
ffffffffc0200d6c:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200d6e:	bd05                	j	ffffffffc0200b9e <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200d70:	00005617          	auipc	a2,0x5
ffffffffc0200d74:	48060613          	addi	a2,a2,1152 # ffffffffc02061f0 <commands+0x6e8>
ffffffffc0200d78:	0bd00593          	li	a1,189
ffffffffc0200d7c:	00005517          	auipc	a0,0x5
ffffffffc0200d80:	48c50513          	addi	a0,a0,1164 # ffffffffc0206208 <commands+0x700>
ffffffffc0200d84:	f0eff0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0200d88 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200d88:	1101                	addi	sp,sp,-32
ffffffffc0200d8a:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200d8c:	000de417          	auipc	s0,0xde
ffffffffc0200d90:	d5440413          	addi	s0,s0,-684 # ffffffffc02deae0 <current>
ffffffffc0200d94:	6018                	ld	a4,0(s0)
{
ffffffffc0200d96:	ec06                	sd	ra,24(sp)
ffffffffc0200d98:	e426                	sd	s1,8(sp)
ffffffffc0200d9a:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200d9c:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200da0:	cf1d                	beqz	a4,ffffffffc0200dde <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200da2:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200da6:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200daa:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200dac:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200db0:	0206c463          	bltz	a3,ffffffffc0200dd8 <trap+0x50>
        exception_handler(tf);
ffffffffc0200db4:	eefff0ef          	jal	ra,ffffffffc0200ca2 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200db8:	601c                	ld	a5,0(s0)
ffffffffc0200dba:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200dbe:	e499                	bnez	s1,ffffffffc0200dcc <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200dc0:	0b07a703          	lw	a4,176(a5)
ffffffffc0200dc4:	8b05                	andi	a4,a4,1
ffffffffc0200dc6:	e329                	bnez	a4,ffffffffc0200e08 <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200dc8:	6f9c                	ld	a5,24(a5)
ffffffffc0200dca:	eb85                	bnez	a5,ffffffffc0200dfa <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200dcc:	60e2                	ld	ra,24(sp)
ffffffffc0200dce:	6442                	ld	s0,16(sp)
ffffffffc0200dd0:	64a2                	ld	s1,8(sp)
ffffffffc0200dd2:	6902                	ld	s2,0(sp)
ffffffffc0200dd4:	6105                	addi	sp,sp,32
ffffffffc0200dd6:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200dd8:	e29ff0ef          	jal	ra,ffffffffc0200c00 <interrupt_handler>
ffffffffc0200ddc:	bff1                	j	ffffffffc0200db8 <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200dde:	0006c863          	bltz	a3,ffffffffc0200dee <trap+0x66>
}
ffffffffc0200de2:	6442                	ld	s0,16(sp)
ffffffffc0200de4:	60e2                	ld	ra,24(sp)
ffffffffc0200de6:	64a2                	ld	s1,8(sp)
ffffffffc0200de8:	6902                	ld	s2,0(sp)
ffffffffc0200dea:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200dec:	bd5d                	j	ffffffffc0200ca2 <exception_handler>
}
ffffffffc0200dee:	6442                	ld	s0,16(sp)
ffffffffc0200df0:	60e2                	ld	ra,24(sp)
ffffffffc0200df2:	64a2                	ld	s1,8(sp)
ffffffffc0200df4:	6902                	ld	s2,0(sp)
ffffffffc0200df6:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200df8:	b521                	j	ffffffffc0200c00 <interrupt_handler>
}
ffffffffc0200dfa:	6442                	ld	s0,16(sp)
ffffffffc0200dfc:	60e2                	ld	ra,24(sp)
ffffffffc0200dfe:	64a2                	ld	s1,8(sp)
ffffffffc0200e00:	6902                	ld	s2,0(sp)
ffffffffc0200e02:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e04:	2e20406f          	j	ffffffffc02050e6 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e08:	555d                	li	a0,-9
ffffffffc0200e0a:	4a6030ef          	jal	ra,ffffffffc02042b0 <do_exit>
            if (current->need_resched)
ffffffffc0200e0e:	601c                	ld	a5,0(s0)
ffffffffc0200e10:	bf65                	j	ffffffffc0200dc8 <trap+0x40>
	...

ffffffffc0200e14 <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e14:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e18:	00011463          	bnez	sp,ffffffffc0200e20 <__alltraps+0xc>
ffffffffc0200e1c:	14002173          	csrr	sp,sscratch
ffffffffc0200e20:	712d                	addi	sp,sp,-288
ffffffffc0200e22:	e002                	sd	zero,0(sp)
ffffffffc0200e24:	e406                	sd	ra,8(sp)
ffffffffc0200e26:	ec0e                	sd	gp,24(sp)
ffffffffc0200e28:	f012                	sd	tp,32(sp)
ffffffffc0200e2a:	f416                	sd	t0,40(sp)
ffffffffc0200e2c:	f81a                	sd	t1,48(sp)
ffffffffc0200e2e:	fc1e                	sd	t2,56(sp)
ffffffffc0200e30:	e0a2                	sd	s0,64(sp)
ffffffffc0200e32:	e4a6                	sd	s1,72(sp)
ffffffffc0200e34:	e8aa                	sd	a0,80(sp)
ffffffffc0200e36:	ecae                	sd	a1,88(sp)
ffffffffc0200e38:	f0b2                	sd	a2,96(sp)
ffffffffc0200e3a:	f4b6                	sd	a3,104(sp)
ffffffffc0200e3c:	f8ba                	sd	a4,112(sp)
ffffffffc0200e3e:	fcbe                	sd	a5,120(sp)
ffffffffc0200e40:	e142                	sd	a6,128(sp)
ffffffffc0200e42:	e546                	sd	a7,136(sp)
ffffffffc0200e44:	e94a                	sd	s2,144(sp)
ffffffffc0200e46:	ed4e                	sd	s3,152(sp)
ffffffffc0200e48:	f152                	sd	s4,160(sp)
ffffffffc0200e4a:	f556                	sd	s5,168(sp)
ffffffffc0200e4c:	f95a                	sd	s6,176(sp)
ffffffffc0200e4e:	fd5e                	sd	s7,184(sp)
ffffffffc0200e50:	e1e2                	sd	s8,192(sp)
ffffffffc0200e52:	e5e6                	sd	s9,200(sp)
ffffffffc0200e54:	e9ea                	sd	s10,208(sp)
ffffffffc0200e56:	edee                	sd	s11,216(sp)
ffffffffc0200e58:	f1f2                	sd	t3,224(sp)
ffffffffc0200e5a:	f5f6                	sd	t4,232(sp)
ffffffffc0200e5c:	f9fa                	sd	t5,240(sp)
ffffffffc0200e5e:	fdfe                	sd	t6,248(sp)
ffffffffc0200e60:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200e64:	100024f3          	csrr	s1,sstatus
ffffffffc0200e68:	14102973          	csrr	s2,sepc
ffffffffc0200e6c:	143029f3          	csrr	s3,stval
ffffffffc0200e70:	14202a73          	csrr	s4,scause
ffffffffc0200e74:	e822                	sd	s0,16(sp)
ffffffffc0200e76:	e226                	sd	s1,256(sp)
ffffffffc0200e78:	e64a                	sd	s2,264(sp)
ffffffffc0200e7a:	ea4e                	sd	s3,272(sp)
ffffffffc0200e7c:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200e7e:	850a                	mv	a0,sp
    jal trap
ffffffffc0200e80:	f09ff0ef          	jal	ra,ffffffffc0200d88 <trap>

ffffffffc0200e84 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200e84:	6492                	ld	s1,256(sp)
ffffffffc0200e86:	6932                	ld	s2,264(sp)
ffffffffc0200e88:	1004f413          	andi	s0,s1,256
ffffffffc0200e8c:	e401                	bnez	s0,ffffffffc0200e94 <__trapret+0x10>
ffffffffc0200e8e:	1200                	addi	s0,sp,288
ffffffffc0200e90:	14041073          	csrw	sscratch,s0
ffffffffc0200e94:	10049073          	csrw	sstatus,s1
ffffffffc0200e98:	14191073          	csrw	sepc,s2
ffffffffc0200e9c:	60a2                	ld	ra,8(sp)
ffffffffc0200e9e:	61e2                	ld	gp,24(sp)
ffffffffc0200ea0:	7202                	ld	tp,32(sp)
ffffffffc0200ea2:	72a2                	ld	t0,40(sp)
ffffffffc0200ea4:	7342                	ld	t1,48(sp)
ffffffffc0200ea6:	73e2                	ld	t2,56(sp)
ffffffffc0200ea8:	6406                	ld	s0,64(sp)
ffffffffc0200eaa:	64a6                	ld	s1,72(sp)
ffffffffc0200eac:	6546                	ld	a0,80(sp)
ffffffffc0200eae:	65e6                	ld	a1,88(sp)
ffffffffc0200eb0:	7606                	ld	a2,96(sp)
ffffffffc0200eb2:	76a6                	ld	a3,104(sp)
ffffffffc0200eb4:	7746                	ld	a4,112(sp)
ffffffffc0200eb6:	77e6                	ld	a5,120(sp)
ffffffffc0200eb8:	680a                	ld	a6,128(sp)
ffffffffc0200eba:	68aa                	ld	a7,136(sp)
ffffffffc0200ebc:	694a                	ld	s2,144(sp)
ffffffffc0200ebe:	69ea                	ld	s3,152(sp)
ffffffffc0200ec0:	7a0a                	ld	s4,160(sp)
ffffffffc0200ec2:	7aaa                	ld	s5,168(sp)
ffffffffc0200ec4:	7b4a                	ld	s6,176(sp)
ffffffffc0200ec6:	7bea                	ld	s7,184(sp)
ffffffffc0200ec8:	6c0e                	ld	s8,192(sp)
ffffffffc0200eca:	6cae                	ld	s9,200(sp)
ffffffffc0200ecc:	6d4e                	ld	s10,208(sp)
ffffffffc0200ece:	6dee                	ld	s11,216(sp)
ffffffffc0200ed0:	7e0e                	ld	t3,224(sp)
ffffffffc0200ed2:	7eae                	ld	t4,232(sp)
ffffffffc0200ed4:	7f4e                	ld	t5,240(sp)
ffffffffc0200ed6:	7fee                	ld	t6,248(sp)
ffffffffc0200ed8:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200eda:	10200073          	sret

ffffffffc0200ede <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200ede:	812a                	mv	sp,a0
ffffffffc0200ee0:	b755                	j	ffffffffc0200e84 <__trapret>

ffffffffc0200ee2 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200ee2:	000da797          	auipc	a5,0xda
ffffffffc0200ee6:	b4e78793          	addi	a5,a5,-1202 # ffffffffc02daa30 <free_area>
ffffffffc0200eea:	e79c                	sd	a5,8(a5)
ffffffffc0200eec:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200eee:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200ef2:	8082                	ret

ffffffffc0200ef4 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0200ef4:	000da517          	auipc	a0,0xda
ffffffffc0200ef8:	b4c56503          	lwu	a0,-1204(a0) # ffffffffc02daa40 <free_area+0x10>
ffffffffc0200efc:	8082                	ret

ffffffffc0200efe <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc0200efe:	715d                	addi	sp,sp,-80
ffffffffc0200f00:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200f02:	000da417          	auipc	s0,0xda
ffffffffc0200f06:	b2e40413          	addi	s0,s0,-1234 # ffffffffc02daa30 <free_area>
ffffffffc0200f0a:	641c                	ld	a5,8(s0)
ffffffffc0200f0c:	e486                	sd	ra,72(sp)
ffffffffc0200f0e:	fc26                	sd	s1,56(sp)
ffffffffc0200f10:	f84a                	sd	s2,48(sp)
ffffffffc0200f12:	f44e                	sd	s3,40(sp)
ffffffffc0200f14:	f052                	sd	s4,32(sp)
ffffffffc0200f16:	ec56                	sd	s5,24(sp)
ffffffffc0200f18:	e85a                	sd	s6,16(sp)
ffffffffc0200f1a:	e45e                	sd	s7,8(sp)
ffffffffc0200f1c:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc0200f1e:	2a878d63          	beq	a5,s0,ffffffffc02011d8 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0200f22:	4481                	li	s1,0
ffffffffc0200f24:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200f26:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200f2a:	8b09                	andi	a4,a4,2
ffffffffc0200f2c:	2a070a63          	beqz	a4,ffffffffc02011e0 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0200f30:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200f34:	679c                	ld	a5,8(a5)
ffffffffc0200f36:	2905                	addiw	s2,s2,1
ffffffffc0200f38:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc0200f3a:	fe8796e3          	bne	a5,s0,ffffffffc0200f26 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200f3e:	89a6                	mv	s3,s1
ffffffffc0200f40:	6df000ef          	jal	ra,ffffffffc0201e1e <nr_free_pages>
ffffffffc0200f44:	6f351e63          	bne	a0,s3,ffffffffc0201640 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200f48:	4505                	li	a0,1
ffffffffc0200f4a:	657000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0200f4e:	8aaa                	mv	s5,a0
ffffffffc0200f50:	42050863          	beqz	a0,ffffffffc0201380 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200f54:	4505                	li	a0,1
ffffffffc0200f56:	64b000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0200f5a:	89aa                	mv	s3,a0
ffffffffc0200f5c:	70050263          	beqz	a0,ffffffffc0201660 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200f60:	4505                	li	a0,1
ffffffffc0200f62:	63f000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0200f66:	8a2a                	mv	s4,a0
ffffffffc0200f68:	48050c63          	beqz	a0,ffffffffc0201400 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200f6c:	293a8a63          	beq	s5,s3,ffffffffc0201200 <default_check+0x302>
ffffffffc0200f70:	28aa8863          	beq	s5,a0,ffffffffc0201200 <default_check+0x302>
ffffffffc0200f74:	28a98663          	beq	s3,a0,ffffffffc0201200 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200f78:	000aa783          	lw	a5,0(s5)
ffffffffc0200f7c:	2a079263          	bnez	a5,ffffffffc0201220 <default_check+0x322>
ffffffffc0200f80:	0009a783          	lw	a5,0(s3)
ffffffffc0200f84:	28079e63          	bnez	a5,ffffffffc0201220 <default_check+0x322>
ffffffffc0200f88:	411c                	lw	a5,0(a0)
ffffffffc0200f8a:	28079b63          	bnez	a5,ffffffffc0201220 <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc0200f8e:	000de797          	auipc	a5,0xde
ffffffffc0200f92:	b3a7b783          	ld	a5,-1222(a5) # ffffffffc02deac8 <pages>
ffffffffc0200f96:	40fa8733          	sub	a4,s5,a5
ffffffffc0200f9a:	00007617          	auipc	a2,0x7
ffffffffc0200f9e:	21663603          	ld	a2,534(a2) # ffffffffc02081b0 <nbase>
ffffffffc0200fa2:	8719                	srai	a4,a4,0x6
ffffffffc0200fa4:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200fa6:	000de697          	auipc	a3,0xde
ffffffffc0200faa:	b1a6b683          	ld	a3,-1254(a3) # ffffffffc02deac0 <npage>
ffffffffc0200fae:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fb0:	0732                	slli	a4,a4,0xc
ffffffffc0200fb2:	28d77763          	bgeu	a4,a3,ffffffffc0201240 <default_check+0x342>
    return page - pages + nbase;
ffffffffc0200fb6:	40f98733          	sub	a4,s3,a5
ffffffffc0200fba:	8719                	srai	a4,a4,0x6
ffffffffc0200fbc:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fbe:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200fc0:	4cd77063          	bgeu	a4,a3,ffffffffc0201480 <default_check+0x582>
    return page - pages + nbase;
ffffffffc0200fc4:	40f507b3          	sub	a5,a0,a5
ffffffffc0200fc8:	8799                	srai	a5,a5,0x6
ffffffffc0200fca:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200fcc:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200fce:	30d7f963          	bgeu	a5,a3,ffffffffc02012e0 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc0200fd2:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200fd4:	00043c03          	ld	s8,0(s0)
ffffffffc0200fd8:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200fdc:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200fe0:	e400                	sd	s0,8(s0)
ffffffffc0200fe2:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200fe4:	000da797          	auipc	a5,0xda
ffffffffc0200fe8:	a407ae23          	sw	zero,-1444(a5) # ffffffffc02daa40 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200fec:	5b5000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0200ff0:	2c051863          	bnez	a0,ffffffffc02012c0 <default_check+0x3c2>
    free_page(p0);
ffffffffc0200ff4:	4585                	li	a1,1
ffffffffc0200ff6:	8556                	mv	a0,s5
ffffffffc0200ff8:	5e7000ef          	jal	ra,ffffffffc0201dde <free_pages>
    free_page(p1);
ffffffffc0200ffc:	4585                	li	a1,1
ffffffffc0200ffe:	854e                	mv	a0,s3
ffffffffc0201000:	5df000ef          	jal	ra,ffffffffc0201dde <free_pages>
    free_page(p2);
ffffffffc0201004:	4585                	li	a1,1
ffffffffc0201006:	8552                	mv	a0,s4
ffffffffc0201008:	5d7000ef          	jal	ra,ffffffffc0201dde <free_pages>
    assert(nr_free == 3);
ffffffffc020100c:	4818                	lw	a4,16(s0)
ffffffffc020100e:	478d                	li	a5,3
ffffffffc0201010:	28f71863          	bne	a4,a5,ffffffffc02012a0 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201014:	4505                	li	a0,1
ffffffffc0201016:	58b000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc020101a:	89aa                	mv	s3,a0
ffffffffc020101c:	26050263          	beqz	a0,ffffffffc0201280 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201020:	4505                	li	a0,1
ffffffffc0201022:	57f000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201026:	8aaa                	mv	s5,a0
ffffffffc0201028:	3a050c63          	beqz	a0,ffffffffc02013e0 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020102c:	4505                	li	a0,1
ffffffffc020102e:	573000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201032:	8a2a                	mv	s4,a0
ffffffffc0201034:	38050663          	beqz	a0,ffffffffc02013c0 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201038:	4505                	li	a0,1
ffffffffc020103a:	567000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc020103e:	36051163          	bnez	a0,ffffffffc02013a0 <default_check+0x4a2>
    free_page(p0);
ffffffffc0201042:	4585                	li	a1,1
ffffffffc0201044:	854e                	mv	a0,s3
ffffffffc0201046:	599000ef          	jal	ra,ffffffffc0201dde <free_pages>
    assert(!list_empty(&free_list));
ffffffffc020104a:	641c                	ld	a5,8(s0)
ffffffffc020104c:	20878a63          	beq	a5,s0,ffffffffc0201260 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201050:	4505                	li	a0,1
ffffffffc0201052:	54f000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201056:	30a99563          	bne	s3,a0,ffffffffc0201360 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc020105a:	4505                	li	a0,1
ffffffffc020105c:	545000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201060:	2e051063          	bnez	a0,ffffffffc0201340 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201064:	481c                	lw	a5,16(s0)
ffffffffc0201066:	2a079d63          	bnez	a5,ffffffffc0201320 <default_check+0x422>
    free_page(p);
ffffffffc020106a:	854e                	mv	a0,s3
ffffffffc020106c:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc020106e:	01843023          	sd	s8,0(s0)
ffffffffc0201072:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201076:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc020107a:	565000ef          	jal	ra,ffffffffc0201dde <free_pages>
    free_page(p1);
ffffffffc020107e:	4585                	li	a1,1
ffffffffc0201080:	8556                	mv	a0,s5
ffffffffc0201082:	55d000ef          	jal	ra,ffffffffc0201dde <free_pages>
    free_page(p2);
ffffffffc0201086:	4585                	li	a1,1
ffffffffc0201088:	8552                	mv	a0,s4
ffffffffc020108a:	555000ef          	jal	ra,ffffffffc0201dde <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc020108e:	4515                	li	a0,5
ffffffffc0201090:	511000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201094:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0201096:	26050563          	beqz	a0,ffffffffc0201300 <default_check+0x402>
ffffffffc020109a:	651c                	ld	a5,8(a0)
ffffffffc020109c:	8385                	srli	a5,a5,0x1
ffffffffc020109e:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc02010a0:	54079063          	bnez	a5,ffffffffc02015e0 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc02010a4:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02010a6:	00043b03          	ld	s6,0(s0)
ffffffffc02010aa:	00843a83          	ld	s5,8(s0)
ffffffffc02010ae:	e000                	sd	s0,0(s0)
ffffffffc02010b0:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02010b2:	4ef000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc02010b6:	50051563          	bnez	a0,ffffffffc02015c0 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02010ba:	08098a13          	addi	s4,s3,128
ffffffffc02010be:	8552                	mv	a0,s4
ffffffffc02010c0:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02010c2:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02010c6:	000da797          	auipc	a5,0xda
ffffffffc02010ca:	9607ad23          	sw	zero,-1670(a5) # ffffffffc02daa40 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02010ce:	511000ef          	jal	ra,ffffffffc0201dde <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02010d2:	4511                	li	a0,4
ffffffffc02010d4:	4cd000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc02010d8:	4c051463          	bnez	a0,ffffffffc02015a0 <default_check+0x6a2>
ffffffffc02010dc:	0889b783          	ld	a5,136(s3)
ffffffffc02010e0:	8385                	srli	a5,a5,0x1
ffffffffc02010e2:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02010e4:	48078e63          	beqz	a5,ffffffffc0201580 <default_check+0x682>
ffffffffc02010e8:	0909a703          	lw	a4,144(s3)
ffffffffc02010ec:	478d                	li	a5,3
ffffffffc02010ee:	48f71963          	bne	a4,a5,ffffffffc0201580 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc02010f2:	450d                	li	a0,3
ffffffffc02010f4:	4ad000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc02010f8:	8c2a                	mv	s8,a0
ffffffffc02010fa:	46050363          	beqz	a0,ffffffffc0201560 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc02010fe:	4505                	li	a0,1
ffffffffc0201100:	4a1000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201104:	42051e63          	bnez	a0,ffffffffc0201540 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201108:	418a1c63          	bne	s4,s8,ffffffffc0201520 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc020110c:	4585                	li	a1,1
ffffffffc020110e:	854e                	mv	a0,s3
ffffffffc0201110:	4cf000ef          	jal	ra,ffffffffc0201dde <free_pages>
    free_pages(p1, 3);
ffffffffc0201114:	458d                	li	a1,3
ffffffffc0201116:	8552                	mv	a0,s4
ffffffffc0201118:	4c7000ef          	jal	ra,ffffffffc0201dde <free_pages>
ffffffffc020111c:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201120:	04098c13          	addi	s8,s3,64
ffffffffc0201124:	8385                	srli	a5,a5,0x1
ffffffffc0201126:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201128:	3c078c63          	beqz	a5,ffffffffc0201500 <default_check+0x602>
ffffffffc020112c:	0109a703          	lw	a4,16(s3)
ffffffffc0201130:	4785                	li	a5,1
ffffffffc0201132:	3cf71763          	bne	a4,a5,ffffffffc0201500 <default_check+0x602>
ffffffffc0201136:	008a3783          	ld	a5,8(s4)
ffffffffc020113a:	8385                	srli	a5,a5,0x1
ffffffffc020113c:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc020113e:	3a078163          	beqz	a5,ffffffffc02014e0 <default_check+0x5e2>
ffffffffc0201142:	010a2703          	lw	a4,16(s4)
ffffffffc0201146:	478d                	li	a5,3
ffffffffc0201148:	38f71c63          	bne	a4,a5,ffffffffc02014e0 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc020114c:	4505                	li	a0,1
ffffffffc020114e:	453000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201152:	36a99763          	bne	s3,a0,ffffffffc02014c0 <default_check+0x5c2>
    free_page(p0);
ffffffffc0201156:	4585                	li	a1,1
ffffffffc0201158:	487000ef          	jal	ra,ffffffffc0201dde <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc020115c:	4509                	li	a0,2
ffffffffc020115e:	443000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201162:	32aa1f63          	bne	s4,a0,ffffffffc02014a0 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201166:	4589                	li	a1,2
ffffffffc0201168:	477000ef          	jal	ra,ffffffffc0201dde <free_pages>
    free_page(p2);
ffffffffc020116c:	4585                	li	a1,1
ffffffffc020116e:	8562                	mv	a0,s8
ffffffffc0201170:	46f000ef          	jal	ra,ffffffffc0201dde <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201174:	4515                	li	a0,5
ffffffffc0201176:	42b000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc020117a:	89aa                	mv	s3,a0
ffffffffc020117c:	48050263          	beqz	a0,ffffffffc0201600 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201180:	4505                	li	a0,1
ffffffffc0201182:	41f000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc0201186:	2c051d63          	bnez	a0,ffffffffc0201460 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc020118a:	481c                	lw	a5,16(s0)
ffffffffc020118c:	2a079a63          	bnez	a5,ffffffffc0201440 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0201190:	4595                	li	a1,5
ffffffffc0201192:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0201194:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0201198:	01643023          	sd	s6,0(s0)
ffffffffc020119c:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc02011a0:	43f000ef          	jal	ra,ffffffffc0201dde <free_pages>
    return listelm->next;
ffffffffc02011a4:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc02011a6:	00878963          	beq	a5,s0,ffffffffc02011b8 <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc02011aa:	ff87a703          	lw	a4,-8(a5)
ffffffffc02011ae:	679c                	ld	a5,8(a5)
ffffffffc02011b0:	397d                	addiw	s2,s2,-1
ffffffffc02011b2:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc02011b4:	fe879be3          	bne	a5,s0,ffffffffc02011aa <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02011b8:	26091463          	bnez	s2,ffffffffc0201420 <default_check+0x522>
    assert(total == 0);
ffffffffc02011bc:	46049263          	bnez	s1,ffffffffc0201620 <default_check+0x722>
}
ffffffffc02011c0:	60a6                	ld	ra,72(sp)
ffffffffc02011c2:	6406                	ld	s0,64(sp)
ffffffffc02011c4:	74e2                	ld	s1,56(sp)
ffffffffc02011c6:	7942                	ld	s2,48(sp)
ffffffffc02011c8:	79a2                	ld	s3,40(sp)
ffffffffc02011ca:	7a02                	ld	s4,32(sp)
ffffffffc02011cc:	6ae2                	ld	s5,24(sp)
ffffffffc02011ce:	6b42                	ld	s6,16(sp)
ffffffffc02011d0:	6ba2                	ld	s7,8(sp)
ffffffffc02011d2:	6c02                	ld	s8,0(sp)
ffffffffc02011d4:	6161                	addi	sp,sp,80
ffffffffc02011d6:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc02011d8:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02011da:	4481                	li	s1,0
ffffffffc02011dc:	4901                	li	s2,0
ffffffffc02011de:	b38d                	j	ffffffffc0200f40 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02011e0:	00005697          	auipc	a3,0x5
ffffffffc02011e4:	14068693          	addi	a3,a3,320 # ffffffffc0206320 <commands+0x818>
ffffffffc02011e8:	00005617          	auipc	a2,0x5
ffffffffc02011ec:	14860613          	addi	a2,a2,328 # ffffffffc0206330 <commands+0x828>
ffffffffc02011f0:	11000593          	li	a1,272
ffffffffc02011f4:	00005517          	auipc	a0,0x5
ffffffffc02011f8:	15450513          	addi	a0,a0,340 # ffffffffc0206348 <commands+0x840>
ffffffffc02011fc:	a96ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201200:	00005697          	auipc	a3,0x5
ffffffffc0201204:	1e068693          	addi	a3,a3,480 # ffffffffc02063e0 <commands+0x8d8>
ffffffffc0201208:	00005617          	auipc	a2,0x5
ffffffffc020120c:	12860613          	addi	a2,a2,296 # ffffffffc0206330 <commands+0x828>
ffffffffc0201210:	0db00593          	li	a1,219
ffffffffc0201214:	00005517          	auipc	a0,0x5
ffffffffc0201218:	13450513          	addi	a0,a0,308 # ffffffffc0206348 <commands+0x840>
ffffffffc020121c:	a76ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201220:	00005697          	auipc	a3,0x5
ffffffffc0201224:	1e868693          	addi	a3,a3,488 # ffffffffc0206408 <commands+0x900>
ffffffffc0201228:	00005617          	auipc	a2,0x5
ffffffffc020122c:	10860613          	addi	a2,a2,264 # ffffffffc0206330 <commands+0x828>
ffffffffc0201230:	0dc00593          	li	a1,220
ffffffffc0201234:	00005517          	auipc	a0,0x5
ffffffffc0201238:	11450513          	addi	a0,a0,276 # ffffffffc0206348 <commands+0x840>
ffffffffc020123c:	a56ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201240:	00005697          	auipc	a3,0x5
ffffffffc0201244:	20868693          	addi	a3,a3,520 # ffffffffc0206448 <commands+0x940>
ffffffffc0201248:	00005617          	auipc	a2,0x5
ffffffffc020124c:	0e860613          	addi	a2,a2,232 # ffffffffc0206330 <commands+0x828>
ffffffffc0201250:	0de00593          	li	a1,222
ffffffffc0201254:	00005517          	auipc	a0,0x5
ffffffffc0201258:	0f450513          	addi	a0,a0,244 # ffffffffc0206348 <commands+0x840>
ffffffffc020125c:	a36ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201260:	00005697          	auipc	a3,0x5
ffffffffc0201264:	27068693          	addi	a3,a3,624 # ffffffffc02064d0 <commands+0x9c8>
ffffffffc0201268:	00005617          	auipc	a2,0x5
ffffffffc020126c:	0c860613          	addi	a2,a2,200 # ffffffffc0206330 <commands+0x828>
ffffffffc0201270:	0f700593          	li	a1,247
ffffffffc0201274:	00005517          	auipc	a0,0x5
ffffffffc0201278:	0d450513          	addi	a0,a0,212 # ffffffffc0206348 <commands+0x840>
ffffffffc020127c:	a16ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201280:	00005697          	auipc	a3,0x5
ffffffffc0201284:	10068693          	addi	a3,a3,256 # ffffffffc0206380 <commands+0x878>
ffffffffc0201288:	00005617          	auipc	a2,0x5
ffffffffc020128c:	0a860613          	addi	a2,a2,168 # ffffffffc0206330 <commands+0x828>
ffffffffc0201290:	0f000593          	li	a1,240
ffffffffc0201294:	00005517          	auipc	a0,0x5
ffffffffc0201298:	0b450513          	addi	a0,a0,180 # ffffffffc0206348 <commands+0x840>
ffffffffc020129c:	9f6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 3);
ffffffffc02012a0:	00005697          	auipc	a3,0x5
ffffffffc02012a4:	22068693          	addi	a3,a3,544 # ffffffffc02064c0 <commands+0x9b8>
ffffffffc02012a8:	00005617          	auipc	a2,0x5
ffffffffc02012ac:	08860613          	addi	a2,a2,136 # ffffffffc0206330 <commands+0x828>
ffffffffc02012b0:	0ee00593          	li	a1,238
ffffffffc02012b4:	00005517          	auipc	a0,0x5
ffffffffc02012b8:	09450513          	addi	a0,a0,148 # ffffffffc0206348 <commands+0x840>
ffffffffc02012bc:	9d6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02012c0:	00005697          	auipc	a3,0x5
ffffffffc02012c4:	1e868693          	addi	a3,a3,488 # ffffffffc02064a8 <commands+0x9a0>
ffffffffc02012c8:	00005617          	auipc	a2,0x5
ffffffffc02012cc:	06860613          	addi	a2,a2,104 # ffffffffc0206330 <commands+0x828>
ffffffffc02012d0:	0e900593          	li	a1,233
ffffffffc02012d4:	00005517          	auipc	a0,0x5
ffffffffc02012d8:	07450513          	addi	a0,a0,116 # ffffffffc0206348 <commands+0x840>
ffffffffc02012dc:	9b6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02012e0:	00005697          	auipc	a3,0x5
ffffffffc02012e4:	1a868693          	addi	a3,a3,424 # ffffffffc0206488 <commands+0x980>
ffffffffc02012e8:	00005617          	auipc	a2,0x5
ffffffffc02012ec:	04860613          	addi	a2,a2,72 # ffffffffc0206330 <commands+0x828>
ffffffffc02012f0:	0e000593          	li	a1,224
ffffffffc02012f4:	00005517          	auipc	a0,0x5
ffffffffc02012f8:	05450513          	addi	a0,a0,84 # ffffffffc0206348 <commands+0x840>
ffffffffc02012fc:	996ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 != NULL);
ffffffffc0201300:	00005697          	auipc	a3,0x5
ffffffffc0201304:	21868693          	addi	a3,a3,536 # ffffffffc0206518 <commands+0xa10>
ffffffffc0201308:	00005617          	auipc	a2,0x5
ffffffffc020130c:	02860613          	addi	a2,a2,40 # ffffffffc0206330 <commands+0x828>
ffffffffc0201310:	11800593          	li	a1,280
ffffffffc0201314:	00005517          	auipc	a0,0x5
ffffffffc0201318:	03450513          	addi	a0,a0,52 # ffffffffc0206348 <commands+0x840>
ffffffffc020131c:	976ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 0);
ffffffffc0201320:	00005697          	auipc	a3,0x5
ffffffffc0201324:	1e868693          	addi	a3,a3,488 # ffffffffc0206508 <commands+0xa00>
ffffffffc0201328:	00005617          	auipc	a2,0x5
ffffffffc020132c:	00860613          	addi	a2,a2,8 # ffffffffc0206330 <commands+0x828>
ffffffffc0201330:	0fd00593          	li	a1,253
ffffffffc0201334:	00005517          	auipc	a0,0x5
ffffffffc0201338:	01450513          	addi	a0,a0,20 # ffffffffc0206348 <commands+0x840>
ffffffffc020133c:	956ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201340:	00005697          	auipc	a3,0x5
ffffffffc0201344:	16868693          	addi	a3,a3,360 # ffffffffc02064a8 <commands+0x9a0>
ffffffffc0201348:	00005617          	auipc	a2,0x5
ffffffffc020134c:	fe860613          	addi	a2,a2,-24 # ffffffffc0206330 <commands+0x828>
ffffffffc0201350:	0fb00593          	li	a1,251
ffffffffc0201354:	00005517          	auipc	a0,0x5
ffffffffc0201358:	ff450513          	addi	a0,a0,-12 # ffffffffc0206348 <commands+0x840>
ffffffffc020135c:	936ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201360:	00005697          	auipc	a3,0x5
ffffffffc0201364:	18868693          	addi	a3,a3,392 # ffffffffc02064e8 <commands+0x9e0>
ffffffffc0201368:	00005617          	auipc	a2,0x5
ffffffffc020136c:	fc860613          	addi	a2,a2,-56 # ffffffffc0206330 <commands+0x828>
ffffffffc0201370:	0fa00593          	li	a1,250
ffffffffc0201374:	00005517          	auipc	a0,0x5
ffffffffc0201378:	fd450513          	addi	a0,a0,-44 # ffffffffc0206348 <commands+0x840>
ffffffffc020137c:	916ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201380:	00005697          	auipc	a3,0x5
ffffffffc0201384:	00068693          	mv	a3,a3
ffffffffc0201388:	00005617          	auipc	a2,0x5
ffffffffc020138c:	fa860613          	addi	a2,a2,-88 # ffffffffc0206330 <commands+0x828>
ffffffffc0201390:	0d700593          	li	a1,215
ffffffffc0201394:	00005517          	auipc	a0,0x5
ffffffffc0201398:	fb450513          	addi	a0,a0,-76 # ffffffffc0206348 <commands+0x840>
ffffffffc020139c:	8f6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013a0:	00005697          	auipc	a3,0x5
ffffffffc02013a4:	10868693          	addi	a3,a3,264 # ffffffffc02064a8 <commands+0x9a0>
ffffffffc02013a8:	00005617          	auipc	a2,0x5
ffffffffc02013ac:	f8860613          	addi	a2,a2,-120 # ffffffffc0206330 <commands+0x828>
ffffffffc02013b0:	0f400593          	li	a1,244
ffffffffc02013b4:	00005517          	auipc	a0,0x5
ffffffffc02013b8:	f9450513          	addi	a0,a0,-108 # ffffffffc0206348 <commands+0x840>
ffffffffc02013bc:	8d6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02013c0:	00005697          	auipc	a3,0x5
ffffffffc02013c4:	00068693          	mv	a3,a3
ffffffffc02013c8:	00005617          	auipc	a2,0x5
ffffffffc02013cc:	f6860613          	addi	a2,a2,-152 # ffffffffc0206330 <commands+0x828>
ffffffffc02013d0:	0f200593          	li	a1,242
ffffffffc02013d4:	00005517          	auipc	a0,0x5
ffffffffc02013d8:	f7450513          	addi	a0,a0,-140 # ffffffffc0206348 <commands+0x840>
ffffffffc02013dc:	8b6ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02013e0:	00005697          	auipc	a3,0x5
ffffffffc02013e4:	fc068693          	addi	a3,a3,-64 # ffffffffc02063a0 <commands+0x898>
ffffffffc02013e8:	00005617          	auipc	a2,0x5
ffffffffc02013ec:	f4860613          	addi	a2,a2,-184 # ffffffffc0206330 <commands+0x828>
ffffffffc02013f0:	0f100593          	li	a1,241
ffffffffc02013f4:	00005517          	auipc	a0,0x5
ffffffffc02013f8:	f5450513          	addi	a0,a0,-172 # ffffffffc0206348 <commands+0x840>
ffffffffc02013fc:	896ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201400:	00005697          	auipc	a3,0x5
ffffffffc0201404:	fc068693          	addi	a3,a3,-64 # ffffffffc02063c0 <commands+0x8b8>
ffffffffc0201408:	00005617          	auipc	a2,0x5
ffffffffc020140c:	f2860613          	addi	a2,a2,-216 # ffffffffc0206330 <commands+0x828>
ffffffffc0201410:	0d900593          	li	a1,217
ffffffffc0201414:	00005517          	auipc	a0,0x5
ffffffffc0201418:	f3450513          	addi	a0,a0,-204 # ffffffffc0206348 <commands+0x840>
ffffffffc020141c:	876ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(count == 0);
ffffffffc0201420:	00005697          	auipc	a3,0x5
ffffffffc0201424:	24868693          	addi	a3,a3,584 # ffffffffc0206668 <commands+0xb60>
ffffffffc0201428:	00005617          	auipc	a2,0x5
ffffffffc020142c:	f0860613          	addi	a2,a2,-248 # ffffffffc0206330 <commands+0x828>
ffffffffc0201430:	14600593          	li	a1,326
ffffffffc0201434:	00005517          	auipc	a0,0x5
ffffffffc0201438:	f1450513          	addi	a0,a0,-236 # ffffffffc0206348 <commands+0x840>
ffffffffc020143c:	856ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free == 0);
ffffffffc0201440:	00005697          	auipc	a3,0x5
ffffffffc0201444:	0c868693          	addi	a3,a3,200 # ffffffffc0206508 <commands+0xa00>
ffffffffc0201448:	00005617          	auipc	a2,0x5
ffffffffc020144c:	ee860613          	addi	a2,a2,-280 # ffffffffc0206330 <commands+0x828>
ffffffffc0201450:	13a00593          	li	a1,314
ffffffffc0201454:	00005517          	auipc	a0,0x5
ffffffffc0201458:	ef450513          	addi	a0,a0,-268 # ffffffffc0206348 <commands+0x840>
ffffffffc020145c:	836ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201460:	00005697          	auipc	a3,0x5
ffffffffc0201464:	04868693          	addi	a3,a3,72 # ffffffffc02064a8 <commands+0x9a0>
ffffffffc0201468:	00005617          	auipc	a2,0x5
ffffffffc020146c:	ec860613          	addi	a2,a2,-312 # ffffffffc0206330 <commands+0x828>
ffffffffc0201470:	13800593          	li	a1,312
ffffffffc0201474:	00005517          	auipc	a0,0x5
ffffffffc0201478:	ed450513          	addi	a0,a0,-300 # ffffffffc0206348 <commands+0x840>
ffffffffc020147c:	816ff0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201480:	00005697          	auipc	a3,0x5
ffffffffc0201484:	fe868693          	addi	a3,a3,-24 # ffffffffc0206468 <commands+0x960>
ffffffffc0201488:	00005617          	auipc	a2,0x5
ffffffffc020148c:	ea860613          	addi	a2,a2,-344 # ffffffffc0206330 <commands+0x828>
ffffffffc0201490:	0df00593          	li	a1,223
ffffffffc0201494:	00005517          	auipc	a0,0x5
ffffffffc0201498:	eb450513          	addi	a0,a0,-332 # ffffffffc0206348 <commands+0x840>
ffffffffc020149c:	ff7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02014a0:	00005697          	auipc	a3,0x5
ffffffffc02014a4:	18868693          	addi	a3,a3,392 # ffffffffc0206628 <commands+0xb20>
ffffffffc02014a8:	00005617          	auipc	a2,0x5
ffffffffc02014ac:	e8860613          	addi	a2,a2,-376 # ffffffffc0206330 <commands+0x828>
ffffffffc02014b0:	13200593          	li	a1,306
ffffffffc02014b4:	00005517          	auipc	a0,0x5
ffffffffc02014b8:	e9450513          	addi	a0,a0,-364 # ffffffffc0206348 <commands+0x840>
ffffffffc02014bc:	fd7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02014c0:	00005697          	auipc	a3,0x5
ffffffffc02014c4:	14868693          	addi	a3,a3,328 # ffffffffc0206608 <commands+0xb00>
ffffffffc02014c8:	00005617          	auipc	a2,0x5
ffffffffc02014cc:	e6860613          	addi	a2,a2,-408 # ffffffffc0206330 <commands+0x828>
ffffffffc02014d0:	13000593          	li	a1,304
ffffffffc02014d4:	00005517          	auipc	a0,0x5
ffffffffc02014d8:	e7450513          	addi	a0,a0,-396 # ffffffffc0206348 <commands+0x840>
ffffffffc02014dc:	fb7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02014e0:	00005697          	auipc	a3,0x5
ffffffffc02014e4:	10068693          	addi	a3,a3,256 # ffffffffc02065e0 <commands+0xad8>
ffffffffc02014e8:	00005617          	auipc	a2,0x5
ffffffffc02014ec:	e4860613          	addi	a2,a2,-440 # ffffffffc0206330 <commands+0x828>
ffffffffc02014f0:	12e00593          	li	a1,302
ffffffffc02014f4:	00005517          	auipc	a0,0x5
ffffffffc02014f8:	e5450513          	addi	a0,a0,-428 # ffffffffc0206348 <commands+0x840>
ffffffffc02014fc:	f97fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201500:	00005697          	auipc	a3,0x5
ffffffffc0201504:	0b868693          	addi	a3,a3,184 # ffffffffc02065b8 <commands+0xab0>
ffffffffc0201508:	00005617          	auipc	a2,0x5
ffffffffc020150c:	e2860613          	addi	a2,a2,-472 # ffffffffc0206330 <commands+0x828>
ffffffffc0201510:	12d00593          	li	a1,301
ffffffffc0201514:	00005517          	auipc	a0,0x5
ffffffffc0201518:	e3450513          	addi	a0,a0,-460 # ffffffffc0206348 <commands+0x840>
ffffffffc020151c:	f77fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201520:	00005697          	auipc	a3,0x5
ffffffffc0201524:	08868693          	addi	a3,a3,136 # ffffffffc02065a8 <commands+0xaa0>
ffffffffc0201528:	00005617          	auipc	a2,0x5
ffffffffc020152c:	e0860613          	addi	a2,a2,-504 # ffffffffc0206330 <commands+0x828>
ffffffffc0201530:	12800593          	li	a1,296
ffffffffc0201534:	00005517          	auipc	a0,0x5
ffffffffc0201538:	e1450513          	addi	a0,a0,-492 # ffffffffc0206348 <commands+0x840>
ffffffffc020153c:	f57fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201540:	00005697          	auipc	a3,0x5
ffffffffc0201544:	f6868693          	addi	a3,a3,-152 # ffffffffc02064a8 <commands+0x9a0>
ffffffffc0201548:	00005617          	auipc	a2,0x5
ffffffffc020154c:	de860613          	addi	a2,a2,-536 # ffffffffc0206330 <commands+0x828>
ffffffffc0201550:	12700593          	li	a1,295
ffffffffc0201554:	00005517          	auipc	a0,0x5
ffffffffc0201558:	df450513          	addi	a0,a0,-524 # ffffffffc0206348 <commands+0x840>
ffffffffc020155c:	f37fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201560:	00005697          	auipc	a3,0x5
ffffffffc0201564:	02868693          	addi	a3,a3,40 # ffffffffc0206588 <commands+0xa80>
ffffffffc0201568:	00005617          	auipc	a2,0x5
ffffffffc020156c:	dc860613          	addi	a2,a2,-568 # ffffffffc0206330 <commands+0x828>
ffffffffc0201570:	12600593          	li	a1,294
ffffffffc0201574:	00005517          	auipc	a0,0x5
ffffffffc0201578:	dd450513          	addi	a0,a0,-556 # ffffffffc0206348 <commands+0x840>
ffffffffc020157c:	f17fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201580:	00005697          	auipc	a3,0x5
ffffffffc0201584:	fd868693          	addi	a3,a3,-40 # ffffffffc0206558 <commands+0xa50>
ffffffffc0201588:	00005617          	auipc	a2,0x5
ffffffffc020158c:	da860613          	addi	a2,a2,-600 # ffffffffc0206330 <commands+0x828>
ffffffffc0201590:	12500593          	li	a1,293
ffffffffc0201594:	00005517          	auipc	a0,0x5
ffffffffc0201598:	db450513          	addi	a0,a0,-588 # ffffffffc0206348 <commands+0x840>
ffffffffc020159c:	ef7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02015a0:	00005697          	auipc	a3,0x5
ffffffffc02015a4:	fa068693          	addi	a3,a3,-96 # ffffffffc0206540 <commands+0xa38>
ffffffffc02015a8:	00005617          	auipc	a2,0x5
ffffffffc02015ac:	d8860613          	addi	a2,a2,-632 # ffffffffc0206330 <commands+0x828>
ffffffffc02015b0:	12400593          	li	a1,292
ffffffffc02015b4:	00005517          	auipc	a0,0x5
ffffffffc02015b8:	d9450513          	addi	a0,a0,-620 # ffffffffc0206348 <commands+0x840>
ffffffffc02015bc:	ed7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(alloc_page() == NULL);
ffffffffc02015c0:	00005697          	auipc	a3,0x5
ffffffffc02015c4:	ee868693          	addi	a3,a3,-280 # ffffffffc02064a8 <commands+0x9a0>
ffffffffc02015c8:	00005617          	auipc	a2,0x5
ffffffffc02015cc:	d6860613          	addi	a2,a2,-664 # ffffffffc0206330 <commands+0x828>
ffffffffc02015d0:	11e00593          	li	a1,286
ffffffffc02015d4:	00005517          	auipc	a0,0x5
ffffffffc02015d8:	d7450513          	addi	a0,a0,-652 # ffffffffc0206348 <commands+0x840>
ffffffffc02015dc:	eb7fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(!PageProperty(p0));
ffffffffc02015e0:	00005697          	auipc	a3,0x5
ffffffffc02015e4:	f4868693          	addi	a3,a3,-184 # ffffffffc0206528 <commands+0xa20>
ffffffffc02015e8:	00005617          	auipc	a2,0x5
ffffffffc02015ec:	d4860613          	addi	a2,a2,-696 # ffffffffc0206330 <commands+0x828>
ffffffffc02015f0:	11900593          	li	a1,281
ffffffffc02015f4:	00005517          	auipc	a0,0x5
ffffffffc02015f8:	d5450513          	addi	a0,a0,-684 # ffffffffc0206348 <commands+0x840>
ffffffffc02015fc:	e97fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201600:	00005697          	auipc	a3,0x5
ffffffffc0201604:	04868693          	addi	a3,a3,72 # ffffffffc0206648 <commands+0xb40>
ffffffffc0201608:	00005617          	auipc	a2,0x5
ffffffffc020160c:	d2860613          	addi	a2,a2,-728 # ffffffffc0206330 <commands+0x828>
ffffffffc0201610:	13700593          	li	a1,311
ffffffffc0201614:	00005517          	auipc	a0,0x5
ffffffffc0201618:	d3450513          	addi	a0,a0,-716 # ffffffffc0206348 <commands+0x840>
ffffffffc020161c:	e77fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(total == 0);
ffffffffc0201620:	00005697          	auipc	a3,0x5
ffffffffc0201624:	05868693          	addi	a3,a3,88 # ffffffffc0206678 <commands+0xb70>
ffffffffc0201628:	00005617          	auipc	a2,0x5
ffffffffc020162c:	d0860613          	addi	a2,a2,-760 # ffffffffc0206330 <commands+0x828>
ffffffffc0201630:	14700593          	li	a1,327
ffffffffc0201634:	00005517          	auipc	a0,0x5
ffffffffc0201638:	d1450513          	addi	a0,a0,-748 # ffffffffc0206348 <commands+0x840>
ffffffffc020163c:	e57fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(total == nr_free_pages());
ffffffffc0201640:	00005697          	auipc	a3,0x5
ffffffffc0201644:	d2068693          	addi	a3,a3,-736 # ffffffffc0206360 <commands+0x858>
ffffffffc0201648:	00005617          	auipc	a2,0x5
ffffffffc020164c:	ce860613          	addi	a2,a2,-792 # ffffffffc0206330 <commands+0x828>
ffffffffc0201650:	11300593          	li	a1,275
ffffffffc0201654:	00005517          	auipc	a0,0x5
ffffffffc0201658:	cf450513          	addi	a0,a0,-780 # ffffffffc0206348 <commands+0x840>
ffffffffc020165c:	e37fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201660:	00005697          	auipc	a3,0x5
ffffffffc0201664:	d4068693          	addi	a3,a3,-704 # ffffffffc02063a0 <commands+0x898>
ffffffffc0201668:	00005617          	auipc	a2,0x5
ffffffffc020166c:	cc860613          	addi	a2,a2,-824 # ffffffffc0206330 <commands+0x828>
ffffffffc0201670:	0d800593          	li	a1,216
ffffffffc0201674:	00005517          	auipc	a0,0x5
ffffffffc0201678:	cd450513          	addi	a0,a0,-812 # ffffffffc0206348 <commands+0x840>
ffffffffc020167c:	e17fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201680 <default_free_pages>:
{
ffffffffc0201680:	1141                	addi	sp,sp,-16
ffffffffc0201682:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201684:	14058463          	beqz	a1,ffffffffc02017cc <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc0201688:	00659693          	slli	a3,a1,0x6
ffffffffc020168c:	96aa                	add	a3,a3,a0
ffffffffc020168e:	87aa                	mv	a5,a0
ffffffffc0201690:	02d50263          	beq	a0,a3,ffffffffc02016b4 <default_free_pages+0x34>
ffffffffc0201694:	6798                	ld	a4,8(a5)
ffffffffc0201696:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc0201698:	10071a63          	bnez	a4,ffffffffc02017ac <default_free_pages+0x12c>
ffffffffc020169c:	6798                	ld	a4,8(a5)
ffffffffc020169e:	8b09                	andi	a4,a4,2
ffffffffc02016a0:	10071663          	bnez	a4,ffffffffc02017ac <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc02016a4:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc02016a8:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02016ac:	04078793          	addi	a5,a5,64
ffffffffc02016b0:	fed792e3          	bne	a5,a3,ffffffffc0201694 <default_free_pages+0x14>
    base->property = n;
ffffffffc02016b4:	2581                	sext.w	a1,a1
ffffffffc02016b6:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02016b8:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02016bc:	4789                	li	a5,2
ffffffffc02016be:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02016c2:	000d9697          	auipc	a3,0xd9
ffffffffc02016c6:	36e68693          	addi	a3,a3,878 # ffffffffc02daa30 <free_area>
ffffffffc02016ca:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02016cc:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02016ce:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02016d2:	9db9                	addw	a1,a1,a4
ffffffffc02016d4:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02016d6:	0ad78463          	beq	a5,a3,ffffffffc020177e <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02016da:	fe878713          	addi	a4,a5,-24
ffffffffc02016de:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02016e2:	4581                	li	a1,0
            if (base < page)
ffffffffc02016e4:	00e56a63          	bltu	a0,a4,ffffffffc02016f8 <default_free_pages+0x78>
    return listelm->next;
ffffffffc02016e8:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02016ea:	04d70c63          	beq	a4,a3,ffffffffc0201742 <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc02016ee:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc02016f0:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc02016f4:	fee57ae3          	bgeu	a0,a4,ffffffffc02016e8 <default_free_pages+0x68>
ffffffffc02016f8:	c199                	beqz	a1,ffffffffc02016fe <default_free_pages+0x7e>
ffffffffc02016fa:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc02016fe:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc0201700:	e390                	sd	a2,0(a5)
ffffffffc0201702:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201704:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201706:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc0201708:	00d70d63          	beq	a4,a3,ffffffffc0201722 <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc020170c:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0201710:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc0201714:	02059813          	slli	a6,a1,0x20
ffffffffc0201718:	01a85793          	srli	a5,a6,0x1a
ffffffffc020171c:	97b2                	add	a5,a5,a2
ffffffffc020171e:	02f50c63          	beq	a0,a5,ffffffffc0201756 <default_free_pages+0xd6>
    return listelm->next;
ffffffffc0201722:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc0201724:	00d78c63          	beq	a5,a3,ffffffffc020173c <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc0201728:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc020172a:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc020172e:	02061593          	slli	a1,a2,0x20
ffffffffc0201732:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201736:	972a                	add	a4,a4,a0
ffffffffc0201738:	04e68a63          	beq	a3,a4,ffffffffc020178c <default_free_pages+0x10c>
}
ffffffffc020173c:	60a2                	ld	ra,8(sp)
ffffffffc020173e:	0141                	addi	sp,sp,16
ffffffffc0201740:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201742:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201744:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201746:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201748:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020174a:	02d70763          	beq	a4,a3,ffffffffc0201778 <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc020174e:	8832                	mv	a6,a2
ffffffffc0201750:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201752:	87ba                	mv	a5,a4
ffffffffc0201754:	bf71                	j	ffffffffc02016f0 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0201756:	491c                	lw	a5,16(a0)
ffffffffc0201758:	9dbd                	addw	a1,a1,a5
ffffffffc020175a:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020175e:	57f5                	li	a5,-3
ffffffffc0201760:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201764:	01853803          	ld	a6,24(a0)
ffffffffc0201768:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc020176a:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc020176c:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0201770:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc0201772:	0105b023          	sd	a6,0(a1)
ffffffffc0201776:	b77d                	j	ffffffffc0201724 <default_free_pages+0xa4>
ffffffffc0201778:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc020177a:	873e                	mv	a4,a5
ffffffffc020177c:	bf41                	j	ffffffffc020170c <default_free_pages+0x8c>
}
ffffffffc020177e:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201780:	e390                	sd	a2,0(a5)
ffffffffc0201782:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201784:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201786:	ed1c                	sd	a5,24(a0)
ffffffffc0201788:	0141                	addi	sp,sp,16
ffffffffc020178a:	8082                	ret
            base->property += p->property;
ffffffffc020178c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201790:	ff078693          	addi	a3,a5,-16
ffffffffc0201794:	9e39                	addw	a2,a2,a4
ffffffffc0201796:	c910                	sw	a2,16(a0)
ffffffffc0201798:	5775                	li	a4,-3
ffffffffc020179a:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc020179e:	6398                	ld	a4,0(a5)
ffffffffc02017a0:	679c                	ld	a5,8(a5)
}
ffffffffc02017a2:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02017a4:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02017a6:	e398                	sd	a4,0(a5)
ffffffffc02017a8:	0141                	addi	sp,sp,16
ffffffffc02017aa:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02017ac:	00005697          	auipc	a3,0x5
ffffffffc02017b0:	ee468693          	addi	a3,a3,-284 # ffffffffc0206690 <commands+0xb88>
ffffffffc02017b4:	00005617          	auipc	a2,0x5
ffffffffc02017b8:	b7c60613          	addi	a2,a2,-1156 # ffffffffc0206330 <commands+0x828>
ffffffffc02017bc:	09400593          	li	a1,148
ffffffffc02017c0:	00005517          	auipc	a0,0x5
ffffffffc02017c4:	b8850513          	addi	a0,a0,-1144 # ffffffffc0206348 <commands+0x840>
ffffffffc02017c8:	ccbfe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(n > 0);
ffffffffc02017cc:	00005697          	auipc	a3,0x5
ffffffffc02017d0:	ebc68693          	addi	a3,a3,-324 # ffffffffc0206688 <commands+0xb80>
ffffffffc02017d4:	00005617          	auipc	a2,0x5
ffffffffc02017d8:	b5c60613          	addi	a2,a2,-1188 # ffffffffc0206330 <commands+0x828>
ffffffffc02017dc:	09000593          	li	a1,144
ffffffffc02017e0:	00005517          	auipc	a0,0x5
ffffffffc02017e4:	b6850513          	addi	a0,a0,-1176 # ffffffffc0206348 <commands+0x840>
ffffffffc02017e8:	cabfe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02017ec <default_alloc_pages>:
    assert(n > 0);
ffffffffc02017ec:	c941                	beqz	a0,ffffffffc020187c <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc02017ee:	000d9597          	auipc	a1,0xd9
ffffffffc02017f2:	24258593          	addi	a1,a1,578 # ffffffffc02daa30 <free_area>
ffffffffc02017f6:	0105a803          	lw	a6,16(a1)
ffffffffc02017fa:	872a                	mv	a4,a0
ffffffffc02017fc:	02081793          	slli	a5,a6,0x20
ffffffffc0201800:	9381                	srli	a5,a5,0x20
ffffffffc0201802:	00a7ee63          	bltu	a5,a0,ffffffffc020181e <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0201806:	87ae                	mv	a5,a1
ffffffffc0201808:	a801                	j	ffffffffc0201818 <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc020180a:	ff87a683          	lw	a3,-8(a5)
ffffffffc020180e:	02069613          	slli	a2,a3,0x20
ffffffffc0201812:	9201                	srli	a2,a2,0x20
ffffffffc0201814:	00e67763          	bgeu	a2,a4,ffffffffc0201822 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0201818:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc020181a:	feb798e3          	bne	a5,a1,ffffffffc020180a <default_alloc_pages+0x1e>
        return NULL;
ffffffffc020181e:	4501                	li	a0,0
}
ffffffffc0201820:	8082                	ret
    return listelm->prev;
ffffffffc0201822:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201826:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020182a:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc020182e:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc0201832:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0201836:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc020183a:	02c77863          	bgeu	a4,a2,ffffffffc020186a <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc020183e:	071a                	slli	a4,a4,0x6
ffffffffc0201840:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0201842:	41c686bb          	subw	a3,a3,t3
ffffffffc0201846:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201848:	00870613          	addi	a2,a4,8
ffffffffc020184c:	4689                	li	a3,2
ffffffffc020184e:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201852:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201856:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc020185a:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc020185e:	e290                	sd	a2,0(a3)
ffffffffc0201860:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201864:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0201866:	01173c23          	sd	a7,24(a4)
ffffffffc020186a:	41c8083b          	subw	a6,a6,t3
ffffffffc020186e:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201872:	5775                	li	a4,-3
ffffffffc0201874:	17c1                	addi	a5,a5,-16
ffffffffc0201876:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020187a:	8082                	ret
{
ffffffffc020187c:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc020187e:	00005697          	auipc	a3,0x5
ffffffffc0201882:	e0a68693          	addi	a3,a3,-502 # ffffffffc0206688 <commands+0xb80>
ffffffffc0201886:	00005617          	auipc	a2,0x5
ffffffffc020188a:	aaa60613          	addi	a2,a2,-1366 # ffffffffc0206330 <commands+0x828>
ffffffffc020188e:	06c00593          	li	a1,108
ffffffffc0201892:	00005517          	auipc	a0,0x5
ffffffffc0201896:	ab650513          	addi	a0,a0,-1354 # ffffffffc0206348 <commands+0x840>
{
ffffffffc020189a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020189c:	bf7fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02018a0 <default_init_memmap>:
{
ffffffffc02018a0:	1141                	addi	sp,sp,-16
ffffffffc02018a2:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02018a4:	c5f1                	beqz	a1,ffffffffc0201970 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc02018a6:	00659693          	slli	a3,a1,0x6
ffffffffc02018aa:	96aa                	add	a3,a3,a0
ffffffffc02018ac:	87aa                	mv	a5,a0
ffffffffc02018ae:	00d50f63          	beq	a0,a3,ffffffffc02018cc <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02018b2:	6798                	ld	a4,8(a5)
ffffffffc02018b4:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02018b6:	cf49                	beqz	a4,ffffffffc0201950 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02018b8:	0007a823          	sw	zero,16(a5)
ffffffffc02018bc:	0007b423          	sd	zero,8(a5)
ffffffffc02018c0:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02018c4:	04078793          	addi	a5,a5,64
ffffffffc02018c8:	fed795e3          	bne	a5,a3,ffffffffc02018b2 <default_init_memmap+0x12>
    base->property = n;
ffffffffc02018cc:	2581                	sext.w	a1,a1
ffffffffc02018ce:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02018d0:	4789                	li	a5,2
ffffffffc02018d2:	00850713          	addi	a4,a0,8
ffffffffc02018d6:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02018da:	000d9697          	auipc	a3,0xd9
ffffffffc02018de:	15668693          	addi	a3,a3,342 # ffffffffc02daa30 <free_area>
ffffffffc02018e2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02018e4:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02018e6:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02018ea:	9db9                	addw	a1,a1,a4
ffffffffc02018ec:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02018ee:	04d78a63          	beq	a5,a3,ffffffffc0201942 <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc02018f2:	fe878713          	addi	a4,a5,-24
ffffffffc02018f6:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02018fa:	4581                	li	a1,0
            if (base < page)
ffffffffc02018fc:	00e56a63          	bltu	a0,a4,ffffffffc0201910 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0201900:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc0201902:	02d70263          	beq	a4,a3,ffffffffc0201926 <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc0201906:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0201908:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc020190c:	fee57ae3          	bgeu	a0,a4,ffffffffc0201900 <default_init_memmap+0x60>
ffffffffc0201910:	c199                	beqz	a1,ffffffffc0201916 <default_init_memmap+0x76>
ffffffffc0201912:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201916:	6398                	ld	a4,0(a5)
}
ffffffffc0201918:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc020191a:	e390                	sd	a2,0(a5)
ffffffffc020191c:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc020191e:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201920:	ed18                	sd	a4,24(a0)
ffffffffc0201922:	0141                	addi	sp,sp,16
ffffffffc0201924:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201926:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201928:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020192a:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020192c:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020192e:	00d70663          	beq	a4,a3,ffffffffc020193a <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0201932:	8832                	mv	a6,a2
ffffffffc0201934:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201936:	87ba                	mv	a5,a4
ffffffffc0201938:	bfc1                	j	ffffffffc0201908 <default_init_memmap+0x68>
}
ffffffffc020193a:	60a2                	ld	ra,8(sp)
ffffffffc020193c:	e290                	sd	a2,0(a3)
ffffffffc020193e:	0141                	addi	sp,sp,16
ffffffffc0201940:	8082                	ret
ffffffffc0201942:	60a2                	ld	ra,8(sp)
ffffffffc0201944:	e390                	sd	a2,0(a5)
ffffffffc0201946:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201948:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020194a:	ed1c                	sd	a5,24(a0)
ffffffffc020194c:	0141                	addi	sp,sp,16
ffffffffc020194e:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201950:	00005697          	auipc	a3,0x5
ffffffffc0201954:	d6868693          	addi	a3,a3,-664 # ffffffffc02066b8 <commands+0xbb0>
ffffffffc0201958:	00005617          	auipc	a2,0x5
ffffffffc020195c:	9d860613          	addi	a2,a2,-1576 # ffffffffc0206330 <commands+0x828>
ffffffffc0201960:	04b00593          	li	a1,75
ffffffffc0201964:	00005517          	auipc	a0,0x5
ffffffffc0201968:	9e450513          	addi	a0,a0,-1564 # ffffffffc0206348 <commands+0x840>
ffffffffc020196c:	b27fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(n > 0);
ffffffffc0201970:	00005697          	auipc	a3,0x5
ffffffffc0201974:	d1868693          	addi	a3,a3,-744 # ffffffffc0206688 <commands+0xb80>
ffffffffc0201978:	00005617          	auipc	a2,0x5
ffffffffc020197c:	9b860613          	addi	a2,a2,-1608 # ffffffffc0206330 <commands+0x828>
ffffffffc0201980:	04700593          	li	a1,71
ffffffffc0201984:	00005517          	auipc	a0,0x5
ffffffffc0201988:	9c450513          	addi	a0,a0,-1596 # ffffffffc0206348 <commands+0x840>
ffffffffc020198c:	b07fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201990 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201990:	c94d                	beqz	a0,ffffffffc0201a42 <slob_free+0xb2>
{
ffffffffc0201992:	1141                	addi	sp,sp,-16
ffffffffc0201994:	e022                	sd	s0,0(sp)
ffffffffc0201996:	e406                	sd	ra,8(sp)
ffffffffc0201998:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc020199a:	e9c1                	bnez	a1,ffffffffc0201a2a <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020199c:	100027f3          	csrr	a5,sstatus
ffffffffc02019a0:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02019a2:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02019a4:	ebd9                	bnez	a5,ffffffffc0201a3a <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc02019a6:	000d9617          	auipc	a2,0xd9
ffffffffc02019aa:	c7a60613          	addi	a2,a2,-902 # ffffffffc02da620 <slobfree>
ffffffffc02019ae:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc02019b0:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc02019b2:	679c                	ld	a5,8(a5)
ffffffffc02019b4:	02877a63          	bgeu	a4,s0,ffffffffc02019e8 <slob_free+0x58>
ffffffffc02019b8:	00f46463          	bltu	s0,a5,ffffffffc02019c0 <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc02019bc:	fef76ae3          	bltu	a4,a5,ffffffffc02019b0 <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc02019c0:	400c                	lw	a1,0(s0)
ffffffffc02019c2:	00459693          	slli	a3,a1,0x4
ffffffffc02019c6:	96a2                	add	a3,a3,s0
ffffffffc02019c8:	02d78a63          	beq	a5,a3,ffffffffc02019fc <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc02019cc:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc02019ce:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc02019d0:	00469793          	slli	a5,a3,0x4
ffffffffc02019d4:	97ba                	add	a5,a5,a4
ffffffffc02019d6:	02f40e63          	beq	s0,a5,ffffffffc0201a12 <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc02019da:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc02019dc:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc02019de:	e129                	bnez	a0,ffffffffc0201a20 <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc02019e0:	60a2                	ld	ra,8(sp)
ffffffffc02019e2:	6402                	ld	s0,0(sp)
ffffffffc02019e4:	0141                	addi	sp,sp,16
ffffffffc02019e6:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc02019e8:	fcf764e3          	bltu	a4,a5,ffffffffc02019b0 <slob_free+0x20>
ffffffffc02019ec:	fcf472e3          	bgeu	s0,a5,ffffffffc02019b0 <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc02019f0:	400c                	lw	a1,0(s0)
ffffffffc02019f2:	00459693          	slli	a3,a1,0x4
ffffffffc02019f6:	96a2                	add	a3,a3,s0
ffffffffc02019f8:	fcd79ae3          	bne	a5,a3,ffffffffc02019cc <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc02019fc:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc02019fe:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc0201a00:	9db5                	addw	a1,a1,a3
ffffffffc0201a02:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc0201a04:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201a06:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201a08:	00469793          	slli	a5,a3,0x4
ffffffffc0201a0c:	97ba                	add	a5,a5,a4
ffffffffc0201a0e:	fcf416e3          	bne	s0,a5,ffffffffc02019da <slob_free+0x4a>
		cur->units += b->units;
ffffffffc0201a12:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc0201a14:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc0201a16:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc0201a18:	9ebd                	addw	a3,a3,a5
ffffffffc0201a1a:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc0201a1c:	e70c                	sd	a1,8(a4)
ffffffffc0201a1e:	d169                	beqz	a0,ffffffffc02019e0 <slob_free+0x50>
}
ffffffffc0201a20:	6402                	ld	s0,0(sp)
ffffffffc0201a22:	60a2                	ld	ra,8(sp)
ffffffffc0201a24:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201a26:	f83fe06f          	j	ffffffffc02009a8 <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201a2a:	25bd                	addiw	a1,a1,15
ffffffffc0201a2c:	8191                	srli	a1,a1,0x4
ffffffffc0201a2e:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a30:	100027f3          	csrr	a5,sstatus
ffffffffc0201a34:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201a36:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201a38:	d7bd                	beqz	a5,ffffffffc02019a6 <slob_free+0x16>
        intr_disable();
ffffffffc0201a3a:	f75fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0201a3e:	4505                	li	a0,1
ffffffffc0201a40:	b79d                	j	ffffffffc02019a6 <slob_free+0x16>
ffffffffc0201a42:	8082                	ret

ffffffffc0201a44 <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a44:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201a46:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a48:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201a4c:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201a4e:	352000ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
	if (!page)
ffffffffc0201a52:	c91d                	beqz	a0,ffffffffc0201a88 <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201a54:	000dd697          	auipc	a3,0xdd
ffffffffc0201a58:	0746b683          	ld	a3,116(a3) # ffffffffc02deac8 <pages>
ffffffffc0201a5c:	8d15                	sub	a0,a0,a3
ffffffffc0201a5e:	8519                	srai	a0,a0,0x6
ffffffffc0201a60:	00006697          	auipc	a3,0x6
ffffffffc0201a64:	7506b683          	ld	a3,1872(a3) # ffffffffc02081b0 <nbase>
ffffffffc0201a68:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201a6a:	00c51793          	slli	a5,a0,0xc
ffffffffc0201a6e:	83b1                	srli	a5,a5,0xc
ffffffffc0201a70:	000dd717          	auipc	a4,0xdd
ffffffffc0201a74:	05073703          	ld	a4,80(a4) # ffffffffc02deac0 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201a78:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201a7a:	00e7fa63          	bgeu	a5,a4,ffffffffc0201a8e <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201a7e:	000dd697          	auipc	a3,0xdd
ffffffffc0201a82:	05a6b683          	ld	a3,90(a3) # ffffffffc02dead8 <va_pa_offset>
ffffffffc0201a86:	9536                	add	a0,a0,a3
}
ffffffffc0201a88:	60a2                	ld	ra,8(sp)
ffffffffc0201a8a:	0141                	addi	sp,sp,16
ffffffffc0201a8c:	8082                	ret
ffffffffc0201a8e:	86aa                	mv	a3,a0
ffffffffc0201a90:	00005617          	auipc	a2,0x5
ffffffffc0201a94:	c8860613          	addi	a2,a2,-888 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0201a98:	07100593          	li	a1,113
ffffffffc0201a9c:	00005517          	auipc	a0,0x5
ffffffffc0201aa0:	ca450513          	addi	a0,a0,-860 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0201aa4:	9effe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201aa8 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201aa8:	1101                	addi	sp,sp,-32
ffffffffc0201aaa:	ec06                	sd	ra,24(sp)
ffffffffc0201aac:	e822                	sd	s0,16(sp)
ffffffffc0201aae:	e426                	sd	s1,8(sp)
ffffffffc0201ab0:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201ab2:	01050713          	addi	a4,a0,16
ffffffffc0201ab6:	6785                	lui	a5,0x1
ffffffffc0201ab8:	0cf77363          	bgeu	a4,a5,ffffffffc0201b7e <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201abc:	00f50493          	addi	s1,a0,15
ffffffffc0201ac0:	8091                	srli	s1,s1,0x4
ffffffffc0201ac2:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201ac4:	10002673          	csrr	a2,sstatus
ffffffffc0201ac8:	8a09                	andi	a2,a2,2
ffffffffc0201aca:	e25d                	bnez	a2,ffffffffc0201b70 <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201acc:	000d9917          	auipc	s2,0xd9
ffffffffc0201ad0:	b5490913          	addi	s2,s2,-1196 # ffffffffc02da620 <slobfree>
ffffffffc0201ad4:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201ad8:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201ada:	4398                	lw	a4,0(a5)
ffffffffc0201adc:	08975e63          	bge	a4,s1,ffffffffc0201b78 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201ae0:	00f68b63          	beq	a3,a5,ffffffffc0201af6 <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201ae4:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201ae6:	4018                	lw	a4,0(s0)
ffffffffc0201ae8:	02975a63          	bge	a4,s1,ffffffffc0201b1c <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201aec:	00093683          	ld	a3,0(s2)
ffffffffc0201af0:	87a2                	mv	a5,s0
ffffffffc0201af2:	fef699e3          	bne	a3,a5,ffffffffc0201ae4 <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201af6:	ee31                	bnez	a2,ffffffffc0201b52 <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201af8:	4501                	li	a0,0
ffffffffc0201afa:	f4bff0ef          	jal	ra,ffffffffc0201a44 <__slob_get_free_pages.constprop.0>
ffffffffc0201afe:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201b00:	cd05                	beqz	a0,ffffffffc0201b38 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201b02:	6585                	lui	a1,0x1
ffffffffc0201b04:	e8dff0ef          	jal	ra,ffffffffc0201990 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b08:	10002673          	csrr	a2,sstatus
ffffffffc0201b0c:	8a09                	andi	a2,a2,2
ffffffffc0201b0e:	ee05                	bnez	a2,ffffffffc0201b46 <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201b10:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201b14:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201b16:	4018                	lw	a4,0(s0)
ffffffffc0201b18:	fc974ae3          	blt	a4,s1,ffffffffc0201aec <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201b1c:	04e48763          	beq	s1,a4,ffffffffc0201b6a <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201b20:	00449693          	slli	a3,s1,0x4
ffffffffc0201b24:	96a2                	add	a3,a3,s0
ffffffffc0201b26:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201b28:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201b2a:	9f05                	subw	a4,a4,s1
ffffffffc0201b2c:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201b2e:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201b30:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201b32:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201b36:	e20d                	bnez	a2,ffffffffc0201b58 <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201b38:	60e2                	ld	ra,24(sp)
ffffffffc0201b3a:	8522                	mv	a0,s0
ffffffffc0201b3c:	6442                	ld	s0,16(sp)
ffffffffc0201b3e:	64a2                	ld	s1,8(sp)
ffffffffc0201b40:	6902                	ld	s2,0(sp)
ffffffffc0201b42:	6105                	addi	sp,sp,32
ffffffffc0201b44:	8082                	ret
        intr_disable();
ffffffffc0201b46:	e69fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
			cur = slobfree;
ffffffffc0201b4a:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201b4e:	4605                	li	a2,1
ffffffffc0201b50:	b7d1                	j	ffffffffc0201b14 <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201b52:	e57fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201b56:	b74d                	j	ffffffffc0201af8 <slob_alloc.constprop.0+0x50>
ffffffffc0201b58:	e51fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
}
ffffffffc0201b5c:	60e2                	ld	ra,24(sp)
ffffffffc0201b5e:	8522                	mv	a0,s0
ffffffffc0201b60:	6442                	ld	s0,16(sp)
ffffffffc0201b62:	64a2                	ld	s1,8(sp)
ffffffffc0201b64:	6902                	ld	s2,0(sp)
ffffffffc0201b66:	6105                	addi	sp,sp,32
ffffffffc0201b68:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201b6a:	6418                	ld	a4,8(s0)
ffffffffc0201b6c:	e798                	sd	a4,8(a5)
ffffffffc0201b6e:	b7d1                	j	ffffffffc0201b32 <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201b70:	e3ffe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0201b74:	4605                	li	a2,1
ffffffffc0201b76:	bf99                	j	ffffffffc0201acc <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201b78:	843e                	mv	s0,a5
ffffffffc0201b7a:	87b6                	mv	a5,a3
ffffffffc0201b7c:	b745                	j	ffffffffc0201b1c <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201b7e:	00005697          	auipc	a3,0x5
ffffffffc0201b82:	bd268693          	addi	a3,a3,-1070 # ffffffffc0206750 <default_pmm_manager+0x70>
ffffffffc0201b86:	00004617          	auipc	a2,0x4
ffffffffc0201b8a:	7aa60613          	addi	a2,a2,1962 # ffffffffc0206330 <commands+0x828>
ffffffffc0201b8e:	06300593          	li	a1,99
ffffffffc0201b92:	00005517          	auipc	a0,0x5
ffffffffc0201b96:	bde50513          	addi	a0,a0,-1058 # ffffffffc0206770 <default_pmm_manager+0x90>
ffffffffc0201b9a:	8f9fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201b9e <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201b9e:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201ba0:	00005517          	auipc	a0,0x5
ffffffffc0201ba4:	be850513          	addi	a0,a0,-1048 # ffffffffc0206788 <default_pmm_manager+0xa8>
{
ffffffffc0201ba8:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201baa:	deefe0ef          	jal	ra,ffffffffc0200198 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201bae:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201bb0:	00005517          	auipc	a0,0x5
ffffffffc0201bb4:	bf050513          	addi	a0,a0,-1040 # ffffffffc02067a0 <default_pmm_manager+0xc0>
}
ffffffffc0201bb8:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201bba:	ddefe06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0201bbe <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201bbe:	4501                	li	a0,0
ffffffffc0201bc0:	8082                	ret

ffffffffc0201bc2 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201bc2:	1101                	addi	sp,sp,-32
ffffffffc0201bc4:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bc6:	6905                	lui	s2,0x1
{
ffffffffc0201bc8:	e822                	sd	s0,16(sp)
ffffffffc0201bca:	ec06                	sd	ra,24(sp)
ffffffffc0201bcc:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bce:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8f49>
{
ffffffffc0201bd2:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201bd4:	04a7f963          	bgeu	a5,a0,ffffffffc0201c26 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201bd8:	4561                	li	a0,24
ffffffffc0201bda:	ecfff0ef          	jal	ra,ffffffffc0201aa8 <slob_alloc.constprop.0>
ffffffffc0201bde:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201be0:	c929                	beqz	a0,ffffffffc0201c32 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201be2:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201be6:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201be8:	00f95763          	bge	s2,a5,ffffffffc0201bf6 <kmalloc+0x34>
ffffffffc0201bec:	6705                	lui	a4,0x1
ffffffffc0201bee:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201bf0:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201bf2:	fef74ee3          	blt	a4,a5,ffffffffc0201bee <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201bf6:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201bf8:	e4dff0ef          	jal	ra,ffffffffc0201a44 <__slob_get_free_pages.constprop.0>
ffffffffc0201bfc:	e488                	sd	a0,8(s1)
ffffffffc0201bfe:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201c00:	c525                	beqz	a0,ffffffffc0201c68 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201c02:	100027f3          	csrr	a5,sstatus
ffffffffc0201c06:	8b89                	andi	a5,a5,2
ffffffffc0201c08:	ef8d                	bnez	a5,ffffffffc0201c42 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201c0a:	000dd797          	auipc	a5,0xdd
ffffffffc0201c0e:	e9e78793          	addi	a5,a5,-354 # ffffffffc02deaa8 <bigblocks>
ffffffffc0201c12:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201c14:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201c16:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201c18:	60e2                	ld	ra,24(sp)
ffffffffc0201c1a:	8522                	mv	a0,s0
ffffffffc0201c1c:	6442                	ld	s0,16(sp)
ffffffffc0201c1e:	64a2                	ld	s1,8(sp)
ffffffffc0201c20:	6902                	ld	s2,0(sp)
ffffffffc0201c22:	6105                	addi	sp,sp,32
ffffffffc0201c24:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201c26:	0541                	addi	a0,a0,16
ffffffffc0201c28:	e81ff0ef          	jal	ra,ffffffffc0201aa8 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201c2c:	01050413          	addi	s0,a0,16
ffffffffc0201c30:	f565                	bnez	a0,ffffffffc0201c18 <kmalloc+0x56>
ffffffffc0201c32:	4401                	li	s0,0
}
ffffffffc0201c34:	60e2                	ld	ra,24(sp)
ffffffffc0201c36:	8522                	mv	a0,s0
ffffffffc0201c38:	6442                	ld	s0,16(sp)
ffffffffc0201c3a:	64a2                	ld	s1,8(sp)
ffffffffc0201c3c:	6902                	ld	s2,0(sp)
ffffffffc0201c3e:	6105                	addi	sp,sp,32
ffffffffc0201c40:	8082                	ret
        intr_disable();
ffffffffc0201c42:	d6dfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
		bb->next = bigblocks;
ffffffffc0201c46:	000dd797          	auipc	a5,0xdd
ffffffffc0201c4a:	e6278793          	addi	a5,a5,-414 # ffffffffc02deaa8 <bigblocks>
ffffffffc0201c4e:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201c50:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201c52:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201c54:	d55fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
		return bb->pages;
ffffffffc0201c58:	6480                	ld	s0,8(s1)
}
ffffffffc0201c5a:	60e2                	ld	ra,24(sp)
ffffffffc0201c5c:	64a2                	ld	s1,8(sp)
ffffffffc0201c5e:	8522                	mv	a0,s0
ffffffffc0201c60:	6442                	ld	s0,16(sp)
ffffffffc0201c62:	6902                	ld	s2,0(sp)
ffffffffc0201c64:	6105                	addi	sp,sp,32
ffffffffc0201c66:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201c68:	45e1                	li	a1,24
ffffffffc0201c6a:	8526                	mv	a0,s1
ffffffffc0201c6c:	d25ff0ef          	jal	ra,ffffffffc0201990 <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201c70:	b765                	j	ffffffffc0201c18 <kmalloc+0x56>

ffffffffc0201c72 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201c72:	c169                	beqz	a0,ffffffffc0201d34 <kfree+0xc2>
{
ffffffffc0201c74:	1101                	addi	sp,sp,-32
ffffffffc0201c76:	e822                	sd	s0,16(sp)
ffffffffc0201c78:	ec06                	sd	ra,24(sp)
ffffffffc0201c7a:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201c7c:	03451793          	slli	a5,a0,0x34
ffffffffc0201c80:	842a                	mv	s0,a0
ffffffffc0201c82:	e3d9                	bnez	a5,ffffffffc0201d08 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201c84:	100027f3          	csrr	a5,sstatus
ffffffffc0201c88:	8b89                	andi	a5,a5,2
ffffffffc0201c8a:	e7d9                	bnez	a5,ffffffffc0201d18 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201c8c:	000dd797          	auipc	a5,0xdd
ffffffffc0201c90:	e1c7b783          	ld	a5,-484(a5) # ffffffffc02deaa8 <bigblocks>
    return 0;
ffffffffc0201c94:	4601                	li	a2,0
ffffffffc0201c96:	cbad                	beqz	a5,ffffffffc0201d08 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201c98:	000dd697          	auipc	a3,0xdd
ffffffffc0201c9c:	e1068693          	addi	a3,a3,-496 # ffffffffc02deaa8 <bigblocks>
ffffffffc0201ca0:	a021                	j	ffffffffc0201ca8 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201ca2:	01048693          	addi	a3,s1,16
ffffffffc0201ca6:	c3a5                	beqz	a5,ffffffffc0201d06 <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201ca8:	6798                	ld	a4,8(a5)
ffffffffc0201caa:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201cac:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201cae:	fe871ae3          	bne	a4,s0,ffffffffc0201ca2 <kfree+0x30>
				*last = bb->next;
ffffffffc0201cb2:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201cb4:	ee2d                	bnez	a2,ffffffffc0201d2e <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201cb6:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201cba:	4098                	lw	a4,0(s1)
ffffffffc0201cbc:	08f46963          	bltu	s0,a5,ffffffffc0201d4e <kfree+0xdc>
ffffffffc0201cc0:	000dd697          	auipc	a3,0xdd
ffffffffc0201cc4:	e186b683          	ld	a3,-488(a3) # ffffffffc02dead8 <va_pa_offset>
ffffffffc0201cc8:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201cca:	8031                	srli	s0,s0,0xc
ffffffffc0201ccc:	000dd797          	auipc	a5,0xdd
ffffffffc0201cd0:	df47b783          	ld	a5,-524(a5) # ffffffffc02deac0 <npage>
ffffffffc0201cd4:	06f47163          	bgeu	s0,a5,ffffffffc0201d36 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201cd8:	00006517          	auipc	a0,0x6
ffffffffc0201cdc:	4d853503          	ld	a0,1240(a0) # ffffffffc02081b0 <nbase>
ffffffffc0201ce0:	8c09                	sub	s0,s0,a0
ffffffffc0201ce2:	041a                	slli	s0,s0,0x6
	free_pages(kva2page(kva), 1 << order);
ffffffffc0201ce4:	000dd517          	auipc	a0,0xdd
ffffffffc0201ce8:	de453503          	ld	a0,-540(a0) # ffffffffc02deac8 <pages>
ffffffffc0201cec:	4585                	li	a1,1
ffffffffc0201cee:	9522                	add	a0,a0,s0
ffffffffc0201cf0:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201cf4:	0ea000ef          	jal	ra,ffffffffc0201dde <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201cf8:	6442                	ld	s0,16(sp)
ffffffffc0201cfa:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201cfc:	8526                	mv	a0,s1
}
ffffffffc0201cfe:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d00:	45e1                	li	a1,24
}
ffffffffc0201d02:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201d04:	b171                	j	ffffffffc0201990 <slob_free>
ffffffffc0201d06:	e20d                	bnez	a2,ffffffffc0201d28 <kfree+0xb6>
ffffffffc0201d08:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201d0c:	6442                	ld	s0,16(sp)
ffffffffc0201d0e:	60e2                	ld	ra,24(sp)
ffffffffc0201d10:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201d12:	4581                	li	a1,0
}
ffffffffc0201d14:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201d16:	b9ad                	j	ffffffffc0201990 <slob_free>
        intr_disable();
ffffffffc0201d18:	c97fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d1c:	000dd797          	auipc	a5,0xdd
ffffffffc0201d20:	d8c7b783          	ld	a5,-628(a5) # ffffffffc02deaa8 <bigblocks>
        return 1;
ffffffffc0201d24:	4605                	li	a2,1
ffffffffc0201d26:	fbad                	bnez	a5,ffffffffc0201c98 <kfree+0x26>
        intr_enable();
ffffffffc0201d28:	c81fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201d2c:	bff1                	j	ffffffffc0201d08 <kfree+0x96>
ffffffffc0201d2e:	c7bfe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0201d32:	b751                	j	ffffffffc0201cb6 <kfree+0x44>
ffffffffc0201d34:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201d36:	00005617          	auipc	a2,0x5
ffffffffc0201d3a:	ab260613          	addi	a2,a2,-1358 # ffffffffc02067e8 <default_pmm_manager+0x108>
ffffffffc0201d3e:	06900593          	li	a1,105
ffffffffc0201d42:	00005517          	auipc	a0,0x5
ffffffffc0201d46:	9fe50513          	addi	a0,a0,-1538 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0201d4a:	f48fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201d4e:	86a2                	mv	a3,s0
ffffffffc0201d50:	00005617          	auipc	a2,0x5
ffffffffc0201d54:	a7060613          	addi	a2,a2,-1424 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc0201d58:	07700593          	li	a1,119
ffffffffc0201d5c:	00005517          	auipc	a0,0x5
ffffffffc0201d60:	9e450513          	addi	a0,a0,-1564 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0201d64:	f2efe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201d68 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201d68:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201d6a:	00005617          	auipc	a2,0x5
ffffffffc0201d6e:	a7e60613          	addi	a2,a2,-1410 # ffffffffc02067e8 <default_pmm_manager+0x108>
ffffffffc0201d72:	06900593          	li	a1,105
ffffffffc0201d76:	00005517          	auipc	a0,0x5
ffffffffc0201d7a:	9ca50513          	addi	a0,a0,-1590 # ffffffffc0206740 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201d7e:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201d80:	f12fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201d84 <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201d84:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201d86:	00005617          	auipc	a2,0x5
ffffffffc0201d8a:	a8260613          	addi	a2,a2,-1406 # ffffffffc0206808 <default_pmm_manager+0x128>
ffffffffc0201d8e:	07f00593          	li	a1,127
ffffffffc0201d92:	00005517          	auipc	a0,0x5
ffffffffc0201d96:	9ae50513          	addi	a0,a0,-1618 # ffffffffc0206740 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201d9a:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201d9c:	ef6fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0201da0 <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201da0:	100027f3          	csrr	a5,sstatus
ffffffffc0201da4:	8b89                	andi	a5,a5,2
ffffffffc0201da6:	e799                	bnez	a5,ffffffffc0201db4 <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201da8:	000dd797          	auipc	a5,0xdd
ffffffffc0201dac:	d287b783          	ld	a5,-728(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201db0:	6f9c                	ld	a5,24(a5)
ffffffffc0201db2:	8782                	jr	a5
{
ffffffffc0201db4:	1141                	addi	sp,sp,-16
ffffffffc0201db6:	e406                	sd	ra,8(sp)
ffffffffc0201db8:	e022                	sd	s0,0(sp)
ffffffffc0201dba:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201dbc:	bf3fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201dc0:	000dd797          	auipc	a5,0xdd
ffffffffc0201dc4:	d107b783          	ld	a5,-752(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201dc8:	6f9c                	ld	a5,24(a5)
ffffffffc0201dca:	8522                	mv	a0,s0
ffffffffc0201dcc:	9782                	jalr	a5
ffffffffc0201dce:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201dd0:	bd9fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201dd4:	60a2                	ld	ra,8(sp)
ffffffffc0201dd6:	8522                	mv	a0,s0
ffffffffc0201dd8:	6402                	ld	s0,0(sp)
ffffffffc0201dda:	0141                	addi	sp,sp,16
ffffffffc0201ddc:	8082                	ret

ffffffffc0201dde <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201dde:	100027f3          	csrr	a5,sstatus
ffffffffc0201de2:	8b89                	andi	a5,a5,2
ffffffffc0201de4:	e799                	bnez	a5,ffffffffc0201df2 <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201de6:	000dd797          	auipc	a5,0xdd
ffffffffc0201dea:	cea7b783          	ld	a5,-790(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201dee:	739c                	ld	a5,32(a5)
ffffffffc0201df0:	8782                	jr	a5
{
ffffffffc0201df2:	1101                	addi	sp,sp,-32
ffffffffc0201df4:	ec06                	sd	ra,24(sp)
ffffffffc0201df6:	e822                	sd	s0,16(sp)
ffffffffc0201df8:	e426                	sd	s1,8(sp)
ffffffffc0201dfa:	842a                	mv	s0,a0
ffffffffc0201dfc:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201dfe:	bb1fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201e02:	000dd797          	auipc	a5,0xdd
ffffffffc0201e06:	cce7b783          	ld	a5,-818(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201e0a:	739c                	ld	a5,32(a5)
ffffffffc0201e0c:	85a6                	mv	a1,s1
ffffffffc0201e0e:	8522                	mv	a0,s0
ffffffffc0201e10:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201e12:	6442                	ld	s0,16(sp)
ffffffffc0201e14:	60e2                	ld	ra,24(sp)
ffffffffc0201e16:	64a2                	ld	s1,8(sp)
ffffffffc0201e18:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201e1a:	b8ffe06f          	j	ffffffffc02009a8 <intr_enable>

ffffffffc0201e1e <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e1e:	100027f3          	csrr	a5,sstatus
ffffffffc0201e22:	8b89                	andi	a5,a5,2
ffffffffc0201e24:	e799                	bnez	a5,ffffffffc0201e32 <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201e26:	000dd797          	auipc	a5,0xdd
ffffffffc0201e2a:	caa7b783          	ld	a5,-854(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201e2e:	779c                	ld	a5,40(a5)
ffffffffc0201e30:	8782                	jr	a5
{
ffffffffc0201e32:	1141                	addi	sp,sp,-16
ffffffffc0201e34:	e406                	sd	ra,8(sp)
ffffffffc0201e36:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201e38:	b77fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201e3c:	000dd797          	auipc	a5,0xdd
ffffffffc0201e40:	c947b783          	ld	a5,-876(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201e44:	779c                	ld	a5,40(a5)
ffffffffc0201e46:	9782                	jalr	a5
ffffffffc0201e48:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201e4a:	b5ffe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201e4e:	60a2                	ld	ra,8(sp)
ffffffffc0201e50:	8522                	mv	a0,s0
ffffffffc0201e52:	6402                	ld	s0,0(sp)
ffffffffc0201e54:	0141                	addi	sp,sp,16
ffffffffc0201e56:	8082                	ret

ffffffffc0201e58 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e58:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201e5c:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201e60:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e62:	078e                	slli	a5,a5,0x3
{
ffffffffc0201e64:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201e66:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201e6a:	6094                	ld	a3,0(s1)
{
ffffffffc0201e6c:	f04a                	sd	s2,32(sp)
ffffffffc0201e6e:	ec4e                	sd	s3,24(sp)
ffffffffc0201e70:	e852                	sd	s4,16(sp)
ffffffffc0201e72:	fc06                	sd	ra,56(sp)
ffffffffc0201e74:	f822                	sd	s0,48(sp)
ffffffffc0201e76:	e456                	sd	s5,8(sp)
ffffffffc0201e78:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201e7a:	0016f793          	andi	a5,a3,1
{
ffffffffc0201e7e:	892e                	mv	s2,a1
ffffffffc0201e80:	8a32                	mv	s4,a2
ffffffffc0201e82:	000dd997          	auipc	s3,0xdd
ffffffffc0201e86:	c3e98993          	addi	s3,s3,-962 # ffffffffc02deac0 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201e8a:	efbd                	bnez	a5,ffffffffc0201f08 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201e8c:	14060c63          	beqz	a2,ffffffffc0201fe4 <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201e90:	100027f3          	csrr	a5,sstatus
ffffffffc0201e94:	8b89                	andi	a5,a5,2
ffffffffc0201e96:	14079963          	bnez	a5,ffffffffc0201fe8 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201e9a:	000dd797          	auipc	a5,0xdd
ffffffffc0201e9e:	c367b783          	ld	a5,-970(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201ea2:	6f9c                	ld	a5,24(a5)
ffffffffc0201ea4:	4505                	li	a0,1
ffffffffc0201ea6:	9782                	jalr	a5
ffffffffc0201ea8:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201eaa:	12040d63          	beqz	s0,ffffffffc0201fe4 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201eae:	000ddb17          	auipc	s6,0xdd
ffffffffc0201eb2:	c1ab0b13          	addi	s6,s6,-998 # ffffffffc02deac8 <pages>
ffffffffc0201eb6:	000b3503          	ld	a0,0(s6)
ffffffffc0201eba:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201ebe:	000dd997          	auipc	s3,0xdd
ffffffffc0201ec2:	c0298993          	addi	s3,s3,-1022 # ffffffffc02deac0 <npage>
ffffffffc0201ec6:	40a40533          	sub	a0,s0,a0
ffffffffc0201eca:	8519                	srai	a0,a0,0x6
ffffffffc0201ecc:	9556                	add	a0,a0,s5
ffffffffc0201ece:	0009b703          	ld	a4,0(s3)
ffffffffc0201ed2:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201ed6:	4685                	li	a3,1
ffffffffc0201ed8:	c014                	sw	a3,0(s0)
ffffffffc0201eda:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201edc:	0532                	slli	a0,a0,0xc
ffffffffc0201ede:	16e7f763          	bgeu	a5,a4,ffffffffc020204c <get_pte+0x1f4>
ffffffffc0201ee2:	000dd797          	auipc	a5,0xdd
ffffffffc0201ee6:	bf67b783          	ld	a5,-1034(a5) # ffffffffc02dead8 <va_pa_offset>
ffffffffc0201eea:	6605                	lui	a2,0x1
ffffffffc0201eec:	4581                	li	a1,0
ffffffffc0201eee:	953e                	add	a0,a0,a5
ffffffffc0201ef0:	187030ef          	jal	ra,ffffffffc0205876 <memset>
    return page - pages + nbase;
ffffffffc0201ef4:	000b3683          	ld	a3,0(s6)
ffffffffc0201ef8:	40d406b3          	sub	a3,s0,a3
ffffffffc0201efc:	8699                	srai	a3,a3,0x6
ffffffffc0201efe:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201f00:	06aa                	slli	a3,a3,0xa
ffffffffc0201f02:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201f06:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0201f08:	77fd                	lui	a5,0xfffff
ffffffffc0201f0a:	068a                	slli	a3,a3,0x2
ffffffffc0201f0c:	0009b703          	ld	a4,0(s3)
ffffffffc0201f10:	8efd                	and	a3,a3,a5
ffffffffc0201f12:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201f16:	10e7ff63          	bgeu	a5,a4,ffffffffc0202034 <get_pte+0x1dc>
ffffffffc0201f1a:	000dda97          	auipc	s5,0xdd
ffffffffc0201f1e:	bbea8a93          	addi	s5,s5,-1090 # ffffffffc02dead8 <va_pa_offset>
ffffffffc0201f22:	000ab403          	ld	s0,0(s5)
ffffffffc0201f26:	01595793          	srli	a5,s2,0x15
ffffffffc0201f2a:	1ff7f793          	andi	a5,a5,511
ffffffffc0201f2e:	96a2                	add	a3,a3,s0
ffffffffc0201f30:	00379413          	slli	s0,a5,0x3
ffffffffc0201f34:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc0201f36:	6014                	ld	a3,0(s0)
ffffffffc0201f38:	0016f793          	andi	a5,a3,1
ffffffffc0201f3c:	ebad                	bnez	a5,ffffffffc0201fae <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f3e:	0a0a0363          	beqz	s4,ffffffffc0201fe4 <get_pte+0x18c>
ffffffffc0201f42:	100027f3          	csrr	a5,sstatus
ffffffffc0201f46:	8b89                	andi	a5,a5,2
ffffffffc0201f48:	efcd                	bnez	a5,ffffffffc0202002 <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201f4a:	000dd797          	auipc	a5,0xdd
ffffffffc0201f4e:	b867b783          	ld	a5,-1146(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201f52:	6f9c                	ld	a5,24(a5)
ffffffffc0201f54:	4505                	li	a0,1
ffffffffc0201f56:	9782                	jalr	a5
ffffffffc0201f58:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f5a:	c4c9                	beqz	s1,ffffffffc0201fe4 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201f5c:	000ddb17          	auipc	s6,0xdd
ffffffffc0201f60:	b6cb0b13          	addi	s6,s6,-1172 # ffffffffc02deac8 <pages>
ffffffffc0201f64:	000b3503          	ld	a0,0(s6)
ffffffffc0201f68:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201f6c:	0009b703          	ld	a4,0(s3)
ffffffffc0201f70:	40a48533          	sub	a0,s1,a0
ffffffffc0201f74:	8519                	srai	a0,a0,0x6
ffffffffc0201f76:	9552                	add	a0,a0,s4
ffffffffc0201f78:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201f7c:	4685                	li	a3,1
ffffffffc0201f7e:	c094                	sw	a3,0(s1)
ffffffffc0201f80:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201f82:	0532                	slli	a0,a0,0xc
ffffffffc0201f84:	0ee7f163          	bgeu	a5,a4,ffffffffc0202066 <get_pte+0x20e>
ffffffffc0201f88:	000ab783          	ld	a5,0(s5)
ffffffffc0201f8c:	6605                	lui	a2,0x1
ffffffffc0201f8e:	4581                	li	a1,0
ffffffffc0201f90:	953e                	add	a0,a0,a5
ffffffffc0201f92:	0e5030ef          	jal	ra,ffffffffc0205876 <memset>
    return page - pages + nbase;
ffffffffc0201f96:	000b3683          	ld	a3,0(s6)
ffffffffc0201f9a:	40d486b3          	sub	a3,s1,a3
ffffffffc0201f9e:	8699                	srai	a3,a3,0x6
ffffffffc0201fa0:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0201fa2:	06aa                	slli	a3,a3,0xa
ffffffffc0201fa4:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0201fa8:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc0201faa:	0009b703          	ld	a4,0(s3)
ffffffffc0201fae:	068a                	slli	a3,a3,0x2
ffffffffc0201fb0:	757d                	lui	a0,0xfffff
ffffffffc0201fb2:	8ee9                	and	a3,a3,a0
ffffffffc0201fb4:	00c6d793          	srli	a5,a3,0xc
ffffffffc0201fb8:	06e7f263          	bgeu	a5,a4,ffffffffc020201c <get_pte+0x1c4>
ffffffffc0201fbc:	000ab503          	ld	a0,0(s5)
ffffffffc0201fc0:	00c95913          	srli	s2,s2,0xc
ffffffffc0201fc4:	1ff97913          	andi	s2,s2,511
ffffffffc0201fc8:	96aa                	add	a3,a3,a0
ffffffffc0201fca:	00391513          	slli	a0,s2,0x3
ffffffffc0201fce:	9536                	add	a0,a0,a3
}
ffffffffc0201fd0:	70e2                	ld	ra,56(sp)
ffffffffc0201fd2:	7442                	ld	s0,48(sp)
ffffffffc0201fd4:	74a2                	ld	s1,40(sp)
ffffffffc0201fd6:	7902                	ld	s2,32(sp)
ffffffffc0201fd8:	69e2                	ld	s3,24(sp)
ffffffffc0201fda:	6a42                	ld	s4,16(sp)
ffffffffc0201fdc:	6aa2                	ld	s5,8(sp)
ffffffffc0201fde:	6b02                	ld	s6,0(sp)
ffffffffc0201fe0:	6121                	addi	sp,sp,64
ffffffffc0201fe2:	8082                	ret
            return NULL;
ffffffffc0201fe4:	4501                	li	a0,0
ffffffffc0201fe6:	b7ed                	j	ffffffffc0201fd0 <get_pte+0x178>
        intr_disable();
ffffffffc0201fe8:	9c7fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201fec:	000dd797          	auipc	a5,0xdd
ffffffffc0201ff0:	ae47b783          	ld	a5,-1308(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0201ff4:	6f9c                	ld	a5,24(a5)
ffffffffc0201ff6:	4505                	li	a0,1
ffffffffc0201ff8:	9782                	jalr	a5
ffffffffc0201ffa:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201ffc:	9adfe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202000:	b56d                	j	ffffffffc0201eaa <get_pte+0x52>
        intr_disable();
ffffffffc0202002:	9adfe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202006:	000dd797          	auipc	a5,0xdd
ffffffffc020200a:	aca7b783          	ld	a5,-1334(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc020200e:	6f9c                	ld	a5,24(a5)
ffffffffc0202010:	4505                	li	a0,1
ffffffffc0202012:	9782                	jalr	a5
ffffffffc0202014:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc0202016:	993fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020201a:	b781                	j	ffffffffc0201f5a <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc020201c:	00004617          	auipc	a2,0x4
ffffffffc0202020:	6fc60613          	addi	a2,a2,1788 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0202024:	0fa00593          	li	a1,250
ffffffffc0202028:	00005517          	auipc	a0,0x5
ffffffffc020202c:	80850513          	addi	a0,a0,-2040 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202030:	c62fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202034:	00004617          	auipc	a2,0x4
ffffffffc0202038:	6e460613          	addi	a2,a2,1764 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc020203c:	0ed00593          	li	a1,237
ffffffffc0202040:	00004517          	auipc	a0,0x4
ffffffffc0202044:	7f050513          	addi	a0,a0,2032 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202048:	c4afe0ef          	jal	ra,ffffffffc0200492 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020204c:	86aa                	mv	a3,a0
ffffffffc020204e:	00004617          	auipc	a2,0x4
ffffffffc0202052:	6ca60613          	addi	a2,a2,1738 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0202056:	0e900593          	li	a1,233
ffffffffc020205a:	00004517          	auipc	a0,0x4
ffffffffc020205e:	7d650513          	addi	a0,a0,2006 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202062:	c30fe0ef          	jal	ra,ffffffffc0200492 <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202066:	86aa                	mv	a3,a0
ffffffffc0202068:	00004617          	auipc	a2,0x4
ffffffffc020206c:	6b060613          	addi	a2,a2,1712 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0202070:	0f700593          	li	a1,247
ffffffffc0202074:	00004517          	auipc	a0,0x4
ffffffffc0202078:	7bc50513          	addi	a0,a0,1980 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020207c:	c16fe0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0202080 <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc0202080:	1141                	addi	sp,sp,-16
ffffffffc0202082:	e022                	sd	s0,0(sp)
ffffffffc0202084:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202086:	4601                	li	a2,0
{
ffffffffc0202088:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020208a:	dcfff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
    if (ptep_store != NULL)
ffffffffc020208e:	c011                	beqz	s0,ffffffffc0202092 <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc0202090:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc0202092:	c511                	beqz	a0,ffffffffc020209e <get_page+0x1e>
ffffffffc0202094:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc0202096:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc0202098:	0017f713          	andi	a4,a5,1
ffffffffc020209c:	e709                	bnez	a4,ffffffffc02020a6 <get_page+0x26>
}
ffffffffc020209e:	60a2                	ld	ra,8(sp)
ffffffffc02020a0:	6402                	ld	s0,0(sp)
ffffffffc02020a2:	0141                	addi	sp,sp,16
ffffffffc02020a4:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02020a6:	078a                	slli	a5,a5,0x2
ffffffffc02020a8:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02020aa:	000dd717          	auipc	a4,0xdd
ffffffffc02020ae:	a1673703          	ld	a4,-1514(a4) # ffffffffc02deac0 <npage>
ffffffffc02020b2:	00e7ff63          	bgeu	a5,a4,ffffffffc02020d0 <get_page+0x50>
ffffffffc02020b6:	60a2                	ld	ra,8(sp)
ffffffffc02020b8:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc02020ba:	fff80537          	lui	a0,0xfff80
ffffffffc02020be:	97aa                	add	a5,a5,a0
ffffffffc02020c0:	079a                	slli	a5,a5,0x6
ffffffffc02020c2:	000dd517          	auipc	a0,0xdd
ffffffffc02020c6:	a0653503          	ld	a0,-1530(a0) # ffffffffc02deac8 <pages>
ffffffffc02020ca:	953e                	add	a0,a0,a5
ffffffffc02020cc:	0141                	addi	sp,sp,16
ffffffffc02020ce:	8082                	ret
ffffffffc02020d0:	c99ff0ef          	jal	ra,ffffffffc0201d68 <pa2page.part.0>

ffffffffc02020d4 <unmap_range>:
        tlb_invalidate(pgdir, la); //(6) flush tlb
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02020d4:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02020d6:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02020da:	f486                	sd	ra,104(sp)
ffffffffc02020dc:	f0a2                	sd	s0,96(sp)
ffffffffc02020de:	eca6                	sd	s1,88(sp)
ffffffffc02020e0:	e8ca                	sd	s2,80(sp)
ffffffffc02020e2:	e4ce                	sd	s3,72(sp)
ffffffffc02020e4:	e0d2                	sd	s4,64(sp)
ffffffffc02020e6:	fc56                	sd	s5,56(sp)
ffffffffc02020e8:	f85a                	sd	s6,48(sp)
ffffffffc02020ea:	f45e                	sd	s7,40(sp)
ffffffffc02020ec:	f062                	sd	s8,32(sp)
ffffffffc02020ee:	ec66                	sd	s9,24(sp)
ffffffffc02020f0:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02020f2:	17d2                	slli	a5,a5,0x34
ffffffffc02020f4:	e3ed                	bnez	a5,ffffffffc02021d6 <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc02020f6:	002007b7          	lui	a5,0x200
ffffffffc02020fa:	842e                	mv	s0,a1
ffffffffc02020fc:	0ef5ed63          	bltu	a1,a5,ffffffffc02021f6 <unmap_range+0x122>
ffffffffc0202100:	8932                	mv	s2,a2
ffffffffc0202102:	0ec5fa63          	bgeu	a1,a2,ffffffffc02021f6 <unmap_range+0x122>
ffffffffc0202106:	4785                	li	a5,1
ffffffffc0202108:	07fe                	slli	a5,a5,0x1f
ffffffffc020210a:	0ec7e663          	bltu	a5,a2,ffffffffc02021f6 <unmap_range+0x122>
ffffffffc020210e:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0202110:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc0202112:	000ddc97          	auipc	s9,0xdd
ffffffffc0202116:	9aec8c93          	addi	s9,s9,-1618 # ffffffffc02deac0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc020211a:	000ddc17          	auipc	s8,0xdd
ffffffffc020211e:	9aec0c13          	addi	s8,s8,-1618 # ffffffffc02deac8 <pages>
ffffffffc0202122:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc0202126:	000ddd17          	auipc	s10,0xdd
ffffffffc020212a:	9aad0d13          	addi	s10,s10,-1622 # ffffffffc02dead0 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc020212e:	00200b37          	lui	s6,0x200
ffffffffc0202132:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202136:	4601                	li	a2,0
ffffffffc0202138:	85a2                	mv	a1,s0
ffffffffc020213a:	854e                	mv	a0,s3
ffffffffc020213c:	d1dff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc0202140:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc0202142:	cd29                	beqz	a0,ffffffffc020219c <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc0202144:	611c                	ld	a5,0(a0)
ffffffffc0202146:	e395                	bnez	a5,ffffffffc020216a <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202148:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020214a:	ff2466e3          	bltu	s0,s2,ffffffffc0202136 <unmap_range+0x62>
}
ffffffffc020214e:	70a6                	ld	ra,104(sp)
ffffffffc0202150:	7406                	ld	s0,96(sp)
ffffffffc0202152:	64e6                	ld	s1,88(sp)
ffffffffc0202154:	6946                	ld	s2,80(sp)
ffffffffc0202156:	69a6                	ld	s3,72(sp)
ffffffffc0202158:	6a06                	ld	s4,64(sp)
ffffffffc020215a:	7ae2                	ld	s5,56(sp)
ffffffffc020215c:	7b42                	ld	s6,48(sp)
ffffffffc020215e:	7ba2                	ld	s7,40(sp)
ffffffffc0202160:	7c02                	ld	s8,32(sp)
ffffffffc0202162:	6ce2                	ld	s9,24(sp)
ffffffffc0202164:	6d42                	ld	s10,16(sp)
ffffffffc0202166:	6165                	addi	sp,sp,112
ffffffffc0202168:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc020216a:	0017f713          	andi	a4,a5,1
ffffffffc020216e:	df69                	beqz	a4,ffffffffc0202148 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc0202170:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202174:	078a                	slli	a5,a5,0x2
ffffffffc0202176:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202178:	08e7ff63          	bgeu	a5,a4,ffffffffc0202216 <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc020217c:	000c3503          	ld	a0,0(s8)
ffffffffc0202180:	97de                	add	a5,a5,s7
ffffffffc0202182:	079a                	slli	a5,a5,0x6
ffffffffc0202184:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202186:	411c                	lw	a5,0(a0)
ffffffffc0202188:	fff7871b          	addiw	a4,a5,-1
ffffffffc020218c:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc020218e:	cf11                	beqz	a4,ffffffffc02021aa <unmap_range+0xd6>
        *ptep = 0;                 //(5) clear second page table entry
ffffffffc0202190:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202194:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc0202198:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020219a:	bf45                	j	ffffffffc020214a <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc020219c:	945a                	add	s0,s0,s6
ffffffffc020219e:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc02021a2:	d455                	beqz	s0,ffffffffc020214e <unmap_range+0x7a>
ffffffffc02021a4:	f92469e3          	bltu	s0,s2,ffffffffc0202136 <unmap_range+0x62>
ffffffffc02021a8:	b75d                	j	ffffffffc020214e <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc02021b2:	000d3783          	ld	a5,0(s10)
ffffffffc02021b6:	4585                	li	a1,1
ffffffffc02021b8:	739c                	ld	a5,32(a5)
ffffffffc02021ba:	9782                	jalr	a5
    if (flag)
ffffffffc02021bc:	bfd1                	j	ffffffffc0202190 <unmap_range+0xbc>
ffffffffc02021be:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02021c0:	feefe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc02021c4:	000d3783          	ld	a5,0(s10)
ffffffffc02021c8:	6522                	ld	a0,8(sp)
ffffffffc02021ca:	4585                	li	a1,1
ffffffffc02021cc:	739c                	ld	a5,32(a5)
ffffffffc02021ce:	9782                	jalr	a5
        intr_enable();
ffffffffc02021d0:	fd8fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02021d4:	bf75                	j	ffffffffc0202190 <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021d6:	00004697          	auipc	a3,0x4
ffffffffc02021da:	66a68693          	addi	a3,a3,1642 # ffffffffc0206840 <default_pmm_manager+0x160>
ffffffffc02021de:	00004617          	auipc	a2,0x4
ffffffffc02021e2:	15260613          	addi	a2,a2,338 # ffffffffc0206330 <commands+0x828>
ffffffffc02021e6:	12200593          	li	a1,290
ffffffffc02021ea:	00004517          	auipc	a0,0x4
ffffffffc02021ee:	64650513          	addi	a0,a0,1606 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02021f2:	aa0fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc02021f6:	00004697          	auipc	a3,0x4
ffffffffc02021fa:	67a68693          	addi	a3,a3,1658 # ffffffffc0206870 <default_pmm_manager+0x190>
ffffffffc02021fe:	00004617          	auipc	a2,0x4
ffffffffc0202202:	13260613          	addi	a2,a2,306 # ffffffffc0206330 <commands+0x828>
ffffffffc0202206:	12300593          	li	a1,291
ffffffffc020220a:	00004517          	auipc	a0,0x4
ffffffffc020220e:	62650513          	addi	a0,a0,1574 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202212:	a80fe0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0202216:	b53ff0ef          	jal	ra,ffffffffc0201d68 <pa2page.part.0>

ffffffffc020221a <exit_range>:
{
ffffffffc020221a:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020221c:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202220:	fc86                	sd	ra,120(sp)
ffffffffc0202222:	f8a2                	sd	s0,112(sp)
ffffffffc0202224:	f4a6                	sd	s1,104(sp)
ffffffffc0202226:	f0ca                	sd	s2,96(sp)
ffffffffc0202228:	ecce                	sd	s3,88(sp)
ffffffffc020222a:	e8d2                	sd	s4,80(sp)
ffffffffc020222c:	e4d6                	sd	s5,72(sp)
ffffffffc020222e:	e0da                	sd	s6,64(sp)
ffffffffc0202230:	fc5e                	sd	s7,56(sp)
ffffffffc0202232:	f862                	sd	s8,48(sp)
ffffffffc0202234:	f466                	sd	s9,40(sp)
ffffffffc0202236:	f06a                	sd	s10,32(sp)
ffffffffc0202238:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020223a:	17d2                	slli	a5,a5,0x34
ffffffffc020223c:	20079a63          	bnez	a5,ffffffffc0202450 <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202240:	002007b7          	lui	a5,0x200
ffffffffc0202244:	24f5e463          	bltu	a1,a5,ffffffffc020248c <exit_range+0x272>
ffffffffc0202248:	8ab2                	mv	s5,a2
ffffffffc020224a:	24c5f163          	bgeu	a1,a2,ffffffffc020248c <exit_range+0x272>
ffffffffc020224e:	4785                	li	a5,1
ffffffffc0202250:	07fe                	slli	a5,a5,0x1f
ffffffffc0202252:	22c7ed63          	bltu	a5,a2,ffffffffc020248c <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc0202256:	c00009b7          	lui	s3,0xc0000
ffffffffc020225a:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc020225e:	ffe00937          	lui	s2,0xffe00
ffffffffc0202262:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc0202266:	5cfd                	li	s9,-1
ffffffffc0202268:	8c2a                	mv	s8,a0
ffffffffc020226a:	0125f933          	and	s2,a1,s2
ffffffffc020226e:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202270:	000ddd17          	auipc	s10,0xdd
ffffffffc0202274:	850d0d13          	addi	s10,s10,-1968 # ffffffffc02deac0 <npage>
    return KADDR(page2pa(page));
ffffffffc0202278:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc020227c:	000dd717          	auipc	a4,0xdd
ffffffffc0202280:	84c70713          	addi	a4,a4,-1972 # ffffffffc02deac8 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc0202284:	000ddd97          	auipc	s11,0xdd
ffffffffc0202288:	84cd8d93          	addi	s11,s11,-1972 # ffffffffc02dead0 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc020228c:	c0000437          	lui	s0,0xc0000
ffffffffc0202290:	944e                	add	s0,s0,s3
ffffffffc0202292:	8079                	srli	s0,s0,0x1e
ffffffffc0202294:	1ff47413          	andi	s0,s0,511
ffffffffc0202298:	040e                	slli	s0,s0,0x3
ffffffffc020229a:	9462                	add	s0,s0,s8
ffffffffc020229c:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_sched_test_out_size+0xffffffffbfff2b28>
        if (pde1 & PTE_V)
ffffffffc02022a0:	001a7793          	andi	a5,s4,1
ffffffffc02022a4:	eb99                	bnez	a5,ffffffffc02022ba <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc02022a6:	12098463          	beqz	s3,ffffffffc02023ce <exit_range+0x1b4>
ffffffffc02022aa:	400007b7          	lui	a5,0x40000
ffffffffc02022ae:	97ce                	add	a5,a5,s3
ffffffffc02022b0:	894e                	mv	s2,s3
ffffffffc02022b2:	1159fe63          	bgeu	s3,s5,ffffffffc02023ce <exit_range+0x1b4>
ffffffffc02022b6:	89be                	mv	s3,a5
ffffffffc02022b8:	bfd1                	j	ffffffffc020228c <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc02022ba:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc02022be:	0a0a                	slli	s4,s4,0x2
ffffffffc02022c0:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc02022c4:	1cfa7263          	bgeu	s4,a5,ffffffffc0202488 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02022c8:	fff80637          	lui	a2,0xfff80
ffffffffc02022cc:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02022ce:	000806b7          	lui	a3,0x80
ffffffffc02022d2:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02022d4:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc02022d8:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc02022da:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02022dc:	18f5fa63          	bgeu	a1,a5,ffffffffc0202470 <exit_range+0x256>
ffffffffc02022e0:	000dc817          	auipc	a6,0xdc
ffffffffc02022e4:	7f880813          	addi	a6,a6,2040 # ffffffffc02dead8 <va_pa_offset>
ffffffffc02022e8:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc02022ec:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc02022ee:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc02022f2:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc02022f4:	00080337          	lui	t1,0x80
ffffffffc02022f8:	6885                	lui	a7,0x1
ffffffffc02022fa:	a819                	j	ffffffffc0202310 <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc02022fc:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc02022fe:	002007b7          	lui	a5,0x200
ffffffffc0202302:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202304:	08090c63          	beqz	s2,ffffffffc020239c <exit_range+0x182>
ffffffffc0202308:	09397a63          	bgeu	s2,s3,ffffffffc020239c <exit_range+0x182>
ffffffffc020230c:	0f597063          	bgeu	s2,s5,ffffffffc02023ec <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc0202310:	01595493          	srli	s1,s2,0x15
ffffffffc0202314:	1ff4f493          	andi	s1,s1,511
ffffffffc0202318:	048e                	slli	s1,s1,0x3
ffffffffc020231a:	94da                	add	s1,s1,s6
ffffffffc020231c:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc020231e:	0017f693          	andi	a3,a5,1
ffffffffc0202322:	dee9                	beqz	a3,ffffffffc02022fc <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc0202324:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202328:	078a                	slli	a5,a5,0x2
ffffffffc020232a:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020232c:	14b7fe63          	bgeu	a5,a1,ffffffffc0202488 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202330:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc0202332:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc0202336:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc020233a:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc020233e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202340:	12bef863          	bgeu	t4,a1,ffffffffc0202470 <exit_range+0x256>
ffffffffc0202344:	00083783          	ld	a5,0(a6)
ffffffffc0202348:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc020234a:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc020234e:	629c                	ld	a5,0(a3)
ffffffffc0202350:	8b85                	andi	a5,a5,1
ffffffffc0202352:	f7d5                	bnez	a5,ffffffffc02022fe <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202354:	06a1                	addi	a3,a3,8
ffffffffc0202356:	fed59ce3          	bne	a1,a3,ffffffffc020234e <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc020235a:	631c                	ld	a5,0(a4)
ffffffffc020235c:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020235e:	100027f3          	csrr	a5,sstatus
ffffffffc0202362:	8b89                	andi	a5,a5,2
ffffffffc0202364:	e7d9                	bnez	a5,ffffffffc02023f2 <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc0202366:	000db783          	ld	a5,0(s11)
ffffffffc020236a:	4585                	li	a1,1
ffffffffc020236c:	e032                	sd	a2,0(sp)
ffffffffc020236e:	739c                	ld	a5,32(a5)
ffffffffc0202370:	9782                	jalr	a5
    if (flag)
ffffffffc0202372:	6602                	ld	a2,0(sp)
ffffffffc0202374:	000dc817          	auipc	a6,0xdc
ffffffffc0202378:	76480813          	addi	a6,a6,1892 # ffffffffc02dead8 <va_pa_offset>
ffffffffc020237c:	fff80e37          	lui	t3,0xfff80
ffffffffc0202380:	00080337          	lui	t1,0x80
ffffffffc0202384:	6885                	lui	a7,0x1
ffffffffc0202386:	000dc717          	auipc	a4,0xdc
ffffffffc020238a:	74270713          	addi	a4,a4,1858 # ffffffffc02deac8 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc020238e:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc0202392:	002007b7          	lui	a5,0x200
ffffffffc0202396:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202398:	f60918e3          	bnez	s2,ffffffffc0202308 <exit_range+0xee>
            if (free_pd0)
ffffffffc020239c:	f00b85e3          	beqz	s7,ffffffffc02022a6 <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc02023a0:	000d3783          	ld	a5,0(s10)
ffffffffc02023a4:	0efa7263          	bgeu	s4,a5,ffffffffc0202488 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02023a8:	6308                	ld	a0,0(a4)
ffffffffc02023aa:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02023ac:	100027f3          	csrr	a5,sstatus
ffffffffc02023b0:	8b89                	andi	a5,a5,2
ffffffffc02023b2:	efad                	bnez	a5,ffffffffc020242c <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc02023b4:	000db783          	ld	a5,0(s11)
ffffffffc02023b8:	4585                	li	a1,1
ffffffffc02023ba:	739c                	ld	a5,32(a5)
ffffffffc02023bc:	9782                	jalr	a5
ffffffffc02023be:	000dc717          	auipc	a4,0xdc
ffffffffc02023c2:	70a70713          	addi	a4,a4,1802 # ffffffffc02deac8 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc02023c6:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02023ca:	ee0990e3          	bnez	s3,ffffffffc02022aa <exit_range+0x90>
}
ffffffffc02023ce:	70e6                	ld	ra,120(sp)
ffffffffc02023d0:	7446                	ld	s0,112(sp)
ffffffffc02023d2:	74a6                	ld	s1,104(sp)
ffffffffc02023d4:	7906                	ld	s2,96(sp)
ffffffffc02023d6:	69e6                	ld	s3,88(sp)
ffffffffc02023d8:	6a46                	ld	s4,80(sp)
ffffffffc02023da:	6aa6                	ld	s5,72(sp)
ffffffffc02023dc:	6b06                	ld	s6,64(sp)
ffffffffc02023de:	7be2                	ld	s7,56(sp)
ffffffffc02023e0:	7c42                	ld	s8,48(sp)
ffffffffc02023e2:	7ca2                	ld	s9,40(sp)
ffffffffc02023e4:	7d02                	ld	s10,32(sp)
ffffffffc02023e6:	6de2                	ld	s11,24(sp)
ffffffffc02023e8:	6109                	addi	sp,sp,128
ffffffffc02023ea:	8082                	ret
            if (free_pd0)
ffffffffc02023ec:	ea0b8fe3          	beqz	s7,ffffffffc02022aa <exit_range+0x90>
ffffffffc02023f0:	bf45                	j	ffffffffc02023a0 <exit_range+0x186>
ffffffffc02023f2:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc02023f4:	e42a                	sd	a0,8(sp)
ffffffffc02023f6:	db8fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc02023fa:	000db783          	ld	a5,0(s11)
ffffffffc02023fe:	6522                	ld	a0,8(sp)
ffffffffc0202400:	4585                	li	a1,1
ffffffffc0202402:	739c                	ld	a5,32(a5)
ffffffffc0202404:	9782                	jalr	a5
        intr_enable();
ffffffffc0202406:	da2fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020240a:	6602                	ld	a2,0(sp)
ffffffffc020240c:	000dc717          	auipc	a4,0xdc
ffffffffc0202410:	6bc70713          	addi	a4,a4,1724 # ffffffffc02deac8 <pages>
ffffffffc0202414:	6885                	lui	a7,0x1
ffffffffc0202416:	00080337          	lui	t1,0x80
ffffffffc020241a:	fff80e37          	lui	t3,0xfff80
ffffffffc020241e:	000dc817          	auipc	a6,0xdc
ffffffffc0202422:	6ba80813          	addi	a6,a6,1722 # ffffffffc02dead8 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202426:	0004b023          	sd	zero,0(s1)
ffffffffc020242a:	b7a5                	j	ffffffffc0202392 <exit_range+0x178>
ffffffffc020242c:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc020242e:	d80fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202432:	000db783          	ld	a5,0(s11)
ffffffffc0202436:	6502                	ld	a0,0(sp)
ffffffffc0202438:	4585                	li	a1,1
ffffffffc020243a:	739c                	ld	a5,32(a5)
ffffffffc020243c:	9782                	jalr	a5
        intr_enable();
ffffffffc020243e:	d6afe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202442:	000dc717          	auipc	a4,0xdc
ffffffffc0202446:	68670713          	addi	a4,a4,1670 # ffffffffc02deac8 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc020244a:	00043023          	sd	zero,0(s0)
ffffffffc020244e:	bfb5                	j	ffffffffc02023ca <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202450:	00004697          	auipc	a3,0x4
ffffffffc0202454:	3f068693          	addi	a3,a3,1008 # ffffffffc0206840 <default_pmm_manager+0x160>
ffffffffc0202458:	00004617          	auipc	a2,0x4
ffffffffc020245c:	ed860613          	addi	a2,a2,-296 # ffffffffc0206330 <commands+0x828>
ffffffffc0202460:	13700593          	li	a1,311
ffffffffc0202464:	00004517          	auipc	a0,0x4
ffffffffc0202468:	3cc50513          	addi	a0,a0,972 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020246c:	826fe0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0202470:	00004617          	auipc	a2,0x4
ffffffffc0202474:	2a860613          	addi	a2,a2,680 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0202478:	07100593          	li	a1,113
ffffffffc020247c:	00004517          	auipc	a0,0x4
ffffffffc0202480:	2c450513          	addi	a0,a0,708 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0202484:	80efe0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0202488:	8e1ff0ef          	jal	ra,ffffffffc0201d68 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc020248c:	00004697          	auipc	a3,0x4
ffffffffc0202490:	3e468693          	addi	a3,a3,996 # ffffffffc0206870 <default_pmm_manager+0x190>
ffffffffc0202494:	00004617          	auipc	a2,0x4
ffffffffc0202498:	e9c60613          	addi	a2,a2,-356 # ffffffffc0206330 <commands+0x828>
ffffffffc020249c:	13800593          	li	a1,312
ffffffffc02024a0:	00004517          	auipc	a0,0x4
ffffffffc02024a4:	39050513          	addi	a0,a0,912 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02024a8:	febfd0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02024ac <page_remove>:
{
ffffffffc02024ac:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02024ae:	4601                	li	a2,0
{
ffffffffc02024b0:	ec26                	sd	s1,24(sp)
ffffffffc02024b2:	f406                	sd	ra,40(sp)
ffffffffc02024b4:	f022                	sd	s0,32(sp)
ffffffffc02024b6:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02024b8:	9a1ff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
    if (ptep != NULL)
ffffffffc02024bc:	c511                	beqz	a0,ffffffffc02024c8 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc02024be:	611c                	ld	a5,0(a0)
ffffffffc02024c0:	842a                	mv	s0,a0
ffffffffc02024c2:	0017f713          	andi	a4,a5,1
ffffffffc02024c6:	e711                	bnez	a4,ffffffffc02024d2 <page_remove+0x26>
}
ffffffffc02024c8:	70a2                	ld	ra,40(sp)
ffffffffc02024ca:	7402                	ld	s0,32(sp)
ffffffffc02024cc:	64e2                	ld	s1,24(sp)
ffffffffc02024ce:	6145                	addi	sp,sp,48
ffffffffc02024d0:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02024d2:	078a                	slli	a5,a5,0x2
ffffffffc02024d4:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02024d6:	000dc717          	auipc	a4,0xdc
ffffffffc02024da:	5ea73703          	ld	a4,1514(a4) # ffffffffc02deac0 <npage>
ffffffffc02024de:	06e7f363          	bgeu	a5,a4,ffffffffc0202544 <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc02024e2:	fff80537          	lui	a0,0xfff80
ffffffffc02024e6:	97aa                	add	a5,a5,a0
ffffffffc02024e8:	079a                	slli	a5,a5,0x6
ffffffffc02024ea:	000dc517          	auipc	a0,0xdc
ffffffffc02024ee:	5de53503          	ld	a0,1502(a0) # ffffffffc02deac8 <pages>
ffffffffc02024f2:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc02024f4:	411c                	lw	a5,0(a0)
ffffffffc02024f6:	fff7871b          	addiw	a4,a5,-1
ffffffffc02024fa:	c118                	sw	a4,0(a0)
        if (page_ref(page) ==
ffffffffc02024fc:	cb11                	beqz	a4,ffffffffc0202510 <page_remove+0x64>
        *ptep = 0;                 //(5) clear second page table entry
ffffffffc02024fe:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202502:	12048073          	sfence.vma	s1
}
ffffffffc0202506:	70a2                	ld	ra,40(sp)
ffffffffc0202508:	7402                	ld	s0,32(sp)
ffffffffc020250a:	64e2                	ld	s1,24(sp)
ffffffffc020250c:	6145                	addi	sp,sp,48
ffffffffc020250e:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202510:	100027f3          	csrr	a5,sstatus
ffffffffc0202514:	8b89                	andi	a5,a5,2
ffffffffc0202516:	eb89                	bnez	a5,ffffffffc0202528 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc0202518:	000dc797          	auipc	a5,0xdc
ffffffffc020251c:	5b87b783          	ld	a5,1464(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0202520:	739c                	ld	a5,32(a5)
ffffffffc0202522:	4585                	li	a1,1
ffffffffc0202524:	9782                	jalr	a5
    if (flag)
ffffffffc0202526:	bfe1                	j	ffffffffc02024fe <page_remove+0x52>
        intr_disable();
ffffffffc0202528:	e42a                	sd	a0,8(sp)
ffffffffc020252a:	c84fe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc020252e:	000dc797          	auipc	a5,0xdc
ffffffffc0202532:	5a27b783          	ld	a5,1442(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0202536:	739c                	ld	a5,32(a5)
ffffffffc0202538:	6522                	ld	a0,8(sp)
ffffffffc020253a:	4585                	li	a1,1
ffffffffc020253c:	9782                	jalr	a5
        intr_enable();
ffffffffc020253e:	c6afe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202542:	bf75                	j	ffffffffc02024fe <page_remove+0x52>
ffffffffc0202544:	825ff0ef          	jal	ra,ffffffffc0201d68 <pa2page.part.0>

ffffffffc0202548 <page_insert>:
{
ffffffffc0202548:	7139                	addi	sp,sp,-64
ffffffffc020254a:	e852                	sd	s4,16(sp)
ffffffffc020254c:	8a32                	mv	s4,a2
ffffffffc020254e:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202550:	4605                	li	a2,1
{
ffffffffc0202552:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202554:	85d2                	mv	a1,s4
{
ffffffffc0202556:	f426                	sd	s1,40(sp)
ffffffffc0202558:	fc06                	sd	ra,56(sp)
ffffffffc020255a:	f04a                	sd	s2,32(sp)
ffffffffc020255c:	ec4e                	sd	s3,24(sp)
ffffffffc020255e:	e456                	sd	s5,8(sp)
ffffffffc0202560:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202562:	8f7ff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
    if (ptep == NULL)
ffffffffc0202566:	c961                	beqz	a0,ffffffffc0202636 <page_insert+0xee>
    page->ref += 1;
ffffffffc0202568:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc020256a:	611c                	ld	a5,0(a0)
ffffffffc020256c:	89aa                	mv	s3,a0
ffffffffc020256e:	0016871b          	addiw	a4,a3,1
ffffffffc0202572:	c018                	sw	a4,0(s0)
ffffffffc0202574:	0017f713          	andi	a4,a5,1
ffffffffc0202578:	ef05                	bnez	a4,ffffffffc02025b0 <page_insert+0x68>
    return page - pages + nbase;
ffffffffc020257a:	000dc717          	auipc	a4,0xdc
ffffffffc020257e:	54e73703          	ld	a4,1358(a4) # ffffffffc02deac8 <pages>
ffffffffc0202582:	8c19                	sub	s0,s0,a4
ffffffffc0202584:	000807b7          	lui	a5,0x80
ffffffffc0202588:	8419                	srai	s0,s0,0x6
ffffffffc020258a:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020258c:	042a                	slli	s0,s0,0xa
ffffffffc020258e:	8cc1                	or	s1,s1,s0
ffffffffc0202590:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc0202594:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_sched_test_out_size+0xffffffffbfff2b28>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202598:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc020259c:	4501                	li	a0,0
}
ffffffffc020259e:	70e2                	ld	ra,56(sp)
ffffffffc02025a0:	7442                	ld	s0,48(sp)
ffffffffc02025a2:	74a2                	ld	s1,40(sp)
ffffffffc02025a4:	7902                	ld	s2,32(sp)
ffffffffc02025a6:	69e2                	ld	s3,24(sp)
ffffffffc02025a8:	6a42                	ld	s4,16(sp)
ffffffffc02025aa:	6aa2                	ld	s5,8(sp)
ffffffffc02025ac:	6121                	addi	sp,sp,64
ffffffffc02025ae:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02025b0:	078a                	slli	a5,a5,0x2
ffffffffc02025b2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02025b4:	000dc717          	auipc	a4,0xdc
ffffffffc02025b8:	50c73703          	ld	a4,1292(a4) # ffffffffc02deac0 <npage>
ffffffffc02025bc:	06e7ff63          	bgeu	a5,a4,ffffffffc020263a <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc02025c0:	000dca97          	auipc	s5,0xdc
ffffffffc02025c4:	508a8a93          	addi	s5,s5,1288 # ffffffffc02deac8 <pages>
ffffffffc02025c8:	000ab703          	ld	a4,0(s5)
ffffffffc02025cc:	fff80937          	lui	s2,0xfff80
ffffffffc02025d0:	993e                	add	s2,s2,a5
ffffffffc02025d2:	091a                	slli	s2,s2,0x6
ffffffffc02025d4:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02025d6:	01240c63          	beq	s0,s2,ffffffffc02025ee <page_insert+0xa6>
    page->ref -= 1;
ffffffffc02025da:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fca14f0>
ffffffffc02025de:	fff7869b          	addiw	a3,a5,-1
ffffffffc02025e2:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) ==
ffffffffc02025e6:	c691                	beqz	a3,ffffffffc02025f2 <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02025e8:	120a0073          	sfence.vma	s4
}
ffffffffc02025ec:	bf59                	j	ffffffffc0202582 <page_insert+0x3a>
ffffffffc02025ee:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc02025f0:	bf49                	j	ffffffffc0202582 <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02025f2:	100027f3          	csrr	a5,sstatus
ffffffffc02025f6:	8b89                	andi	a5,a5,2
ffffffffc02025f8:	ef91                	bnez	a5,ffffffffc0202614 <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc02025fa:	000dc797          	auipc	a5,0xdc
ffffffffc02025fe:	4d67b783          	ld	a5,1238(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0202602:	739c                	ld	a5,32(a5)
ffffffffc0202604:	4585                	li	a1,1
ffffffffc0202606:	854a                	mv	a0,s2
ffffffffc0202608:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc020260a:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020260e:	120a0073          	sfence.vma	s4
ffffffffc0202612:	bf85                	j	ffffffffc0202582 <page_insert+0x3a>
        intr_disable();
ffffffffc0202614:	b9afe0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202618:	000dc797          	auipc	a5,0xdc
ffffffffc020261c:	4b87b783          	ld	a5,1208(a5) # ffffffffc02dead0 <pmm_manager>
ffffffffc0202620:	739c                	ld	a5,32(a5)
ffffffffc0202622:	4585                	li	a1,1
ffffffffc0202624:	854a                	mv	a0,s2
ffffffffc0202626:	9782                	jalr	a5
        intr_enable();
ffffffffc0202628:	b80fe0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020262c:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202630:	120a0073          	sfence.vma	s4
ffffffffc0202634:	b7b9                	j	ffffffffc0202582 <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc0202636:	5571                	li	a0,-4
ffffffffc0202638:	b79d                	j	ffffffffc020259e <page_insert+0x56>
ffffffffc020263a:	f2eff0ef          	jal	ra,ffffffffc0201d68 <pa2page.part.0>

ffffffffc020263e <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc020263e:	00004797          	auipc	a5,0x4
ffffffffc0202642:	0a278793          	addi	a5,a5,162 # ffffffffc02066e0 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202646:	638c                	ld	a1,0(a5)
{
ffffffffc0202648:	7159                	addi	sp,sp,-112
ffffffffc020264a:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020264c:	00004517          	auipc	a0,0x4
ffffffffc0202650:	23c50513          	addi	a0,a0,572 # ffffffffc0206888 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc0202654:	000dcb17          	auipc	s6,0xdc
ffffffffc0202658:	47cb0b13          	addi	s6,s6,1148 # ffffffffc02dead0 <pmm_manager>
{
ffffffffc020265c:	f486                	sd	ra,104(sp)
ffffffffc020265e:	e8ca                	sd	s2,80(sp)
ffffffffc0202660:	e4ce                	sd	s3,72(sp)
ffffffffc0202662:	f0a2                	sd	s0,96(sp)
ffffffffc0202664:	eca6                	sd	s1,88(sp)
ffffffffc0202666:	e0d2                	sd	s4,64(sp)
ffffffffc0202668:	fc56                	sd	s5,56(sp)
ffffffffc020266a:	f45e                	sd	s7,40(sp)
ffffffffc020266c:	f062                	sd	s8,32(sp)
ffffffffc020266e:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202670:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202674:	b25fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    pmm_manager->init();
ffffffffc0202678:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020267c:	000dc997          	auipc	s3,0xdc
ffffffffc0202680:	45c98993          	addi	s3,s3,1116 # ffffffffc02dead8 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202684:	679c                	ld	a5,8(a5)
ffffffffc0202686:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202688:	57f5                	li	a5,-3
ffffffffc020268a:	07fa                	slli	a5,a5,0x1e
ffffffffc020268c:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc0202690:	b04fe0ef          	jal	ra,ffffffffc0200994 <get_memory_base>
ffffffffc0202694:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc0202696:	b08fe0ef          	jal	ra,ffffffffc020099e <get_memory_size>
    if (mem_size == 0)
ffffffffc020269a:	200505e3          	beqz	a0,ffffffffc02030a4 <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc020269e:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc02026a0:	00004517          	auipc	a0,0x4
ffffffffc02026a4:	22050513          	addi	a0,a0,544 # ffffffffc02068c0 <default_pmm_manager+0x1e0>
ffffffffc02026a8:	af1fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02026ac:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc02026b0:	fff40693          	addi	a3,s0,-1
ffffffffc02026b4:	864a                	mv	a2,s2
ffffffffc02026b6:	85a6                	mv	a1,s1
ffffffffc02026b8:	00004517          	auipc	a0,0x4
ffffffffc02026bc:	22050513          	addi	a0,a0,544 # ffffffffc02068d8 <default_pmm_manager+0x1f8>
ffffffffc02026c0:	ad9fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02026c4:	c8000737          	lui	a4,0xc8000
ffffffffc02026c8:	87a2                	mv	a5,s0
ffffffffc02026ca:	54876163          	bltu	a4,s0,ffffffffc0202c0c <pmm_init+0x5ce>
ffffffffc02026ce:	757d                	lui	a0,0xfffff
ffffffffc02026d0:	000dd617          	auipc	a2,0xdd
ffffffffc02026d4:	43f60613          	addi	a2,a2,1087 # ffffffffc02dfb0f <end+0xfff>
ffffffffc02026d8:	8e69                	and	a2,a2,a0
ffffffffc02026da:	000dc497          	auipc	s1,0xdc
ffffffffc02026de:	3e648493          	addi	s1,s1,998 # ffffffffc02deac0 <npage>
ffffffffc02026e2:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02026e6:	000dcb97          	auipc	s7,0xdc
ffffffffc02026ea:	3e2b8b93          	addi	s7,s7,994 # ffffffffc02deac8 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02026ee:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02026f0:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02026f4:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02026f8:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc02026fa:	02f50863          	beq	a0,a5,ffffffffc020272a <pmm_init+0xec>
ffffffffc02026fe:	4781                	li	a5,0
ffffffffc0202700:	4585                	li	a1,1
ffffffffc0202702:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc0202706:	00679513          	slli	a0,a5,0x6
ffffffffc020270a:	9532                	add	a0,a0,a2
ffffffffc020270c:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd204f8>
ffffffffc0202710:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202714:	6088                	ld	a0,0(s1)
ffffffffc0202716:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc0202718:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc020271c:	00d50733          	add	a4,a0,a3
ffffffffc0202720:	fee7e3e3          	bltu	a5,a4,ffffffffc0202706 <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202724:	071a                	slli	a4,a4,0x6
ffffffffc0202726:	00e606b3          	add	a3,a2,a4
ffffffffc020272a:	c02007b7          	lui	a5,0xc0200
ffffffffc020272e:	2ef6ece3          	bltu	a3,a5,ffffffffc0203226 <pmm_init+0xbe8>
ffffffffc0202732:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0202736:	77fd                	lui	a5,0xfffff
ffffffffc0202738:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020273a:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc020273c:	5086eb63          	bltu	a3,s0,ffffffffc0202c52 <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202740:	00004517          	auipc	a0,0x4
ffffffffc0202744:	1c050513          	addi	a0,a0,448 # ffffffffc0206900 <default_pmm_manager+0x220>
ffffffffc0202748:	a51fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc020274c:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202750:	000dc917          	auipc	s2,0xdc
ffffffffc0202754:	36890913          	addi	s2,s2,872 # ffffffffc02deab8 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202758:	7b9c                	ld	a5,48(a5)
ffffffffc020275a:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc020275c:	00004517          	auipc	a0,0x4
ffffffffc0202760:	1bc50513          	addi	a0,a0,444 # ffffffffc0206918 <default_pmm_manager+0x238>
ffffffffc0202764:	a35fd0ef          	jal	ra,ffffffffc0200198 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202768:	00009697          	auipc	a3,0x9
ffffffffc020276c:	89868693          	addi	a3,a3,-1896 # ffffffffc020b000 <boot_page_table_sv39>
ffffffffc0202770:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0202774:	c02007b7          	lui	a5,0xc0200
ffffffffc0202778:	28f6ebe3          	bltu	a3,a5,ffffffffc020320e <pmm_init+0xbd0>
ffffffffc020277c:	0009b783          	ld	a5,0(s3)
ffffffffc0202780:	8e9d                	sub	a3,a3,a5
ffffffffc0202782:	000dc797          	auipc	a5,0xdc
ffffffffc0202786:	32d7b723          	sd	a3,814(a5) # ffffffffc02deab0 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020278a:	100027f3          	csrr	a5,sstatus
ffffffffc020278e:	8b89                	andi	a5,a5,2
ffffffffc0202790:	4a079763          	bnez	a5,ffffffffc0202c3e <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202794:	000b3783          	ld	a5,0(s6)
ffffffffc0202798:	779c                	ld	a5,40(a5)
ffffffffc020279a:	9782                	jalr	a5
ffffffffc020279c:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc020279e:	6098                	ld	a4,0(s1)
ffffffffc02027a0:	c80007b7          	lui	a5,0xc8000
ffffffffc02027a4:	83b1                	srli	a5,a5,0xc
ffffffffc02027a6:	66e7e363          	bltu	a5,a4,ffffffffc0202e0c <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc02027aa:	00093503          	ld	a0,0(s2)
ffffffffc02027ae:	62050f63          	beqz	a0,ffffffffc0202dec <pmm_init+0x7ae>
ffffffffc02027b2:	03451793          	slli	a5,a0,0x34
ffffffffc02027b6:	62079b63          	bnez	a5,ffffffffc0202dec <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc02027ba:	4601                	li	a2,0
ffffffffc02027bc:	4581                	li	a1,0
ffffffffc02027be:	8c3ff0ef          	jal	ra,ffffffffc0202080 <get_page>
ffffffffc02027c2:	60051563          	bnez	a0,ffffffffc0202dcc <pmm_init+0x78e>
ffffffffc02027c6:	100027f3          	csrr	a5,sstatus
ffffffffc02027ca:	8b89                	andi	a5,a5,2
ffffffffc02027cc:	44079e63          	bnez	a5,ffffffffc0202c28 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02027d0:	000b3783          	ld	a5,0(s6)
ffffffffc02027d4:	4505                	li	a0,1
ffffffffc02027d6:	6f9c                	ld	a5,24(a5)
ffffffffc02027d8:	9782                	jalr	a5
ffffffffc02027da:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc02027dc:	00093503          	ld	a0,0(s2)
ffffffffc02027e0:	4681                	li	a3,0
ffffffffc02027e2:	4601                	li	a2,0
ffffffffc02027e4:	85d2                	mv	a1,s4
ffffffffc02027e6:	d63ff0ef          	jal	ra,ffffffffc0202548 <page_insert>
ffffffffc02027ea:	26051ae3          	bnez	a0,ffffffffc020325e <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc02027ee:	00093503          	ld	a0,0(s2)
ffffffffc02027f2:	4601                	li	a2,0
ffffffffc02027f4:	4581                	li	a1,0
ffffffffc02027f6:	e62ff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc02027fa:	240502e3          	beqz	a0,ffffffffc020323e <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc02027fe:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc0202800:	0017f713          	andi	a4,a5,1
ffffffffc0202804:	5a070263          	beqz	a4,ffffffffc0202da8 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202808:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc020280a:	078a                	slli	a5,a5,0x2
ffffffffc020280c:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020280e:	58e7fb63          	bgeu	a5,a4,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202812:	000bb683          	ld	a3,0(s7)
ffffffffc0202816:	fff80637          	lui	a2,0xfff80
ffffffffc020281a:	97b2                	add	a5,a5,a2
ffffffffc020281c:	079a                	slli	a5,a5,0x6
ffffffffc020281e:	97b6                	add	a5,a5,a3
ffffffffc0202820:	14fa17e3          	bne	s4,a5,ffffffffc020316e <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc0202824:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>
ffffffffc0202828:	4785                	li	a5,1
ffffffffc020282a:	12f692e3          	bne	a3,a5,ffffffffc020314e <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020282e:	00093503          	ld	a0,0(s2)
ffffffffc0202832:	77fd                	lui	a5,0xfffff
ffffffffc0202834:	6114                	ld	a3,0(a0)
ffffffffc0202836:	068a                	slli	a3,a3,0x2
ffffffffc0202838:	8efd                	and	a3,a3,a5
ffffffffc020283a:	00c6d613          	srli	a2,a3,0xc
ffffffffc020283e:	0ee67ce3          	bgeu	a2,a4,ffffffffc0203136 <pmm_init+0xaf8>
ffffffffc0202842:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202846:	96e2                	add	a3,a3,s8
ffffffffc0202848:	0006ba83          	ld	s5,0(a3)
ffffffffc020284c:	0a8a                	slli	s5,s5,0x2
ffffffffc020284e:	00fafab3          	and	s5,s5,a5
ffffffffc0202852:	00cad793          	srli	a5,s5,0xc
ffffffffc0202856:	0ce7f3e3          	bgeu	a5,a4,ffffffffc020311c <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020285a:	4601                	li	a2,0
ffffffffc020285c:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020285e:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202860:	df8ff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202864:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202866:	55551363          	bne	a0,s5,ffffffffc0202dac <pmm_init+0x76e>
ffffffffc020286a:	100027f3          	csrr	a5,sstatus
ffffffffc020286e:	8b89                	andi	a5,a5,2
ffffffffc0202870:	3a079163          	bnez	a5,ffffffffc0202c12 <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202874:	000b3783          	ld	a5,0(s6)
ffffffffc0202878:	4505                	li	a0,1
ffffffffc020287a:	6f9c                	ld	a5,24(a5)
ffffffffc020287c:	9782                	jalr	a5
ffffffffc020287e:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0202880:	00093503          	ld	a0,0(s2)
ffffffffc0202884:	46d1                	li	a3,20
ffffffffc0202886:	6605                	lui	a2,0x1
ffffffffc0202888:	85e2                	mv	a1,s8
ffffffffc020288a:	cbfff0ef          	jal	ra,ffffffffc0202548 <page_insert>
ffffffffc020288e:	060517e3          	bnez	a0,ffffffffc02030fc <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202892:	00093503          	ld	a0,0(s2)
ffffffffc0202896:	4601                	li	a2,0
ffffffffc0202898:	6585                	lui	a1,0x1
ffffffffc020289a:	dbeff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc020289e:	02050fe3          	beqz	a0,ffffffffc02030dc <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc02028a2:	611c                	ld	a5,0(a0)
ffffffffc02028a4:	0107f713          	andi	a4,a5,16
ffffffffc02028a8:	7c070e63          	beqz	a4,ffffffffc0203084 <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc02028ac:	8b91                	andi	a5,a5,4
ffffffffc02028ae:	7a078b63          	beqz	a5,ffffffffc0203064 <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc02028b2:	00093503          	ld	a0,0(s2)
ffffffffc02028b6:	611c                	ld	a5,0(a0)
ffffffffc02028b8:	8bc1                	andi	a5,a5,16
ffffffffc02028ba:	78078563          	beqz	a5,ffffffffc0203044 <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc02028be:	000c2703          	lw	a4,0(s8)
ffffffffc02028c2:	4785                	li	a5,1
ffffffffc02028c4:	76f71063          	bne	a4,a5,ffffffffc0203024 <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02028c8:	4681                	li	a3,0
ffffffffc02028ca:	6605                	lui	a2,0x1
ffffffffc02028cc:	85d2                	mv	a1,s4
ffffffffc02028ce:	c7bff0ef          	jal	ra,ffffffffc0202548 <page_insert>
ffffffffc02028d2:	72051963          	bnez	a0,ffffffffc0203004 <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02028d6:	000a2703          	lw	a4,0(s4)
ffffffffc02028da:	4789                	li	a5,2
ffffffffc02028dc:	70f71463          	bne	a4,a5,ffffffffc0202fe4 <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc02028e0:	000c2783          	lw	a5,0(s8)
ffffffffc02028e4:	6e079063          	bnez	a5,ffffffffc0202fc4 <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02028e8:	00093503          	ld	a0,0(s2)
ffffffffc02028ec:	4601                	li	a2,0
ffffffffc02028ee:	6585                	lui	a1,0x1
ffffffffc02028f0:	d68ff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc02028f4:	6a050863          	beqz	a0,ffffffffc0202fa4 <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc02028f8:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc02028fa:	00177793          	andi	a5,a4,1
ffffffffc02028fe:	4a078563          	beqz	a5,ffffffffc0202da8 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202902:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202904:	00271793          	slli	a5,a4,0x2
ffffffffc0202908:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020290a:	48d7fd63          	bgeu	a5,a3,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc020290e:	000bb683          	ld	a3,0(s7)
ffffffffc0202912:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202916:	97d6                	add	a5,a5,s5
ffffffffc0202918:	079a                	slli	a5,a5,0x6
ffffffffc020291a:	97b6                	add	a5,a5,a3
ffffffffc020291c:	66fa1463          	bne	s4,a5,ffffffffc0202f84 <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202920:	8b41                	andi	a4,a4,16
ffffffffc0202922:	64071163          	bnez	a4,ffffffffc0202f64 <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc0202926:	00093503          	ld	a0,0(s2)
ffffffffc020292a:	4581                	li	a1,0
ffffffffc020292c:	b81ff0ef          	jal	ra,ffffffffc02024ac <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202930:	000a2c83          	lw	s9,0(s4)
ffffffffc0202934:	4785                	li	a5,1
ffffffffc0202936:	60fc9763          	bne	s9,a5,ffffffffc0202f44 <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc020293a:	000c2783          	lw	a5,0(s8)
ffffffffc020293e:	5e079363          	bnez	a5,ffffffffc0202f24 <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc0202942:	00093503          	ld	a0,0(s2)
ffffffffc0202946:	6585                	lui	a1,0x1
ffffffffc0202948:	b65ff0ef          	jal	ra,ffffffffc02024ac <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc020294c:	000a2783          	lw	a5,0(s4)
ffffffffc0202950:	52079a63          	bnez	a5,ffffffffc0202e84 <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc0202954:	000c2783          	lw	a5,0(s8)
ffffffffc0202958:	50079663          	bnez	a5,ffffffffc0202e64 <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc020295c:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202960:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202962:	000a3683          	ld	a3,0(s4)
ffffffffc0202966:	068a                	slli	a3,a3,0x2
ffffffffc0202968:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc020296a:	42b6fd63          	bgeu	a3,a1,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc020296e:	000bb503          	ld	a0,0(s7)
ffffffffc0202972:	96d6                	add	a3,a3,s5
ffffffffc0202974:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc0202976:	00d507b3          	add	a5,a0,a3
ffffffffc020297a:	439c                	lw	a5,0(a5)
ffffffffc020297c:	4d979463          	bne	a5,s9,ffffffffc0202e44 <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc0202980:	8699                	srai	a3,a3,0x6
ffffffffc0202982:	00080637          	lui	a2,0x80
ffffffffc0202986:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202988:	00c69713          	slli	a4,a3,0xc
ffffffffc020298c:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc020298e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202990:	48b77e63          	bgeu	a4,a1,ffffffffc0202e2c <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc0202994:	0009b703          	ld	a4,0(s3)
ffffffffc0202998:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc020299a:	629c                	ld	a5,0(a3)
ffffffffc020299c:	078a                	slli	a5,a5,0x2
ffffffffc020299e:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029a0:	40b7f263          	bgeu	a5,a1,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02029a4:	8f91                	sub	a5,a5,a2
ffffffffc02029a6:	079a                	slli	a5,a5,0x6
ffffffffc02029a8:	953e                	add	a0,a0,a5
ffffffffc02029aa:	100027f3          	csrr	a5,sstatus
ffffffffc02029ae:	8b89                	andi	a5,a5,2
ffffffffc02029b0:	30079963          	bnez	a5,ffffffffc0202cc2 <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc02029b4:	000b3783          	ld	a5,0(s6)
ffffffffc02029b8:	4585                	li	a1,1
ffffffffc02029ba:	739c                	ld	a5,32(a5)
ffffffffc02029bc:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc02029be:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc02029c2:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc02029c4:	078a                	slli	a5,a5,0x2
ffffffffc02029c6:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02029c8:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc02029cc:	000bb503          	ld	a0,0(s7)
ffffffffc02029d0:	fff80737          	lui	a4,0xfff80
ffffffffc02029d4:	97ba                	add	a5,a5,a4
ffffffffc02029d6:	079a                	slli	a5,a5,0x6
ffffffffc02029d8:	953e                	add	a0,a0,a5
ffffffffc02029da:	100027f3          	csrr	a5,sstatus
ffffffffc02029de:	8b89                	andi	a5,a5,2
ffffffffc02029e0:	2c079563          	bnez	a5,ffffffffc0202caa <pmm_init+0x66c>
ffffffffc02029e4:	000b3783          	ld	a5,0(s6)
ffffffffc02029e8:	4585                	li	a1,1
ffffffffc02029ea:	739c                	ld	a5,32(a5)
ffffffffc02029ec:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc02029ee:	00093783          	ld	a5,0(s2)
ffffffffc02029f2:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd204f0>
    asm volatile("sfence.vma");
ffffffffc02029f6:	12000073          	sfence.vma
ffffffffc02029fa:	100027f3          	csrr	a5,sstatus
ffffffffc02029fe:	8b89                	andi	a5,a5,2
ffffffffc0202a00:	28079b63          	bnez	a5,ffffffffc0202c96 <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202a04:	000b3783          	ld	a5,0(s6)
ffffffffc0202a08:	779c                	ld	a5,40(a5)
ffffffffc0202a0a:	9782                	jalr	a5
ffffffffc0202a0c:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202a0e:	4b441b63          	bne	s0,s4,ffffffffc0202ec4 <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc0202a12:	00004517          	auipc	a0,0x4
ffffffffc0202a16:	22e50513          	addi	a0,a0,558 # ffffffffc0206c40 <default_pmm_manager+0x560>
ffffffffc0202a1a:	f7efd0ef          	jal	ra,ffffffffc0200198 <cprintf>
ffffffffc0202a1e:	100027f3          	csrr	a5,sstatus
ffffffffc0202a22:	8b89                	andi	a5,a5,2
ffffffffc0202a24:	24079f63          	bnez	a5,ffffffffc0202c82 <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202a28:	000b3783          	ld	a5,0(s6)
ffffffffc0202a2c:	779c                	ld	a5,40(a5)
ffffffffc0202a2e:	9782                	jalr	a5
ffffffffc0202a30:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a32:	6098                	ld	a4,0(s1)
ffffffffc0202a34:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202a38:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a3a:	00c71793          	slli	a5,a4,0xc
ffffffffc0202a3e:	6a05                	lui	s4,0x1
ffffffffc0202a40:	02f47c63          	bgeu	s0,a5,ffffffffc0202a78 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202a44:	00c45793          	srli	a5,s0,0xc
ffffffffc0202a48:	00093503          	ld	a0,0(s2)
ffffffffc0202a4c:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202d4a <pmm_init+0x70c>
ffffffffc0202a50:	0009b583          	ld	a1,0(s3)
ffffffffc0202a54:	4601                	li	a2,0
ffffffffc0202a56:	95a2                	add	a1,a1,s0
ffffffffc0202a58:	c00ff0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc0202a5c:	32050463          	beqz	a0,ffffffffc0202d84 <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202a60:	611c                	ld	a5,0(a0)
ffffffffc0202a62:	078a                	slli	a5,a5,0x2
ffffffffc0202a64:	0157f7b3          	and	a5,a5,s5
ffffffffc0202a68:	2e879e63          	bne	a5,s0,ffffffffc0202d64 <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202a6c:	6098                	ld	a4,0(s1)
ffffffffc0202a6e:	9452                	add	s0,s0,s4
ffffffffc0202a70:	00c71793          	slli	a5,a4,0xc
ffffffffc0202a74:	fcf468e3          	bltu	s0,a5,ffffffffc0202a44 <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202a78:	00093783          	ld	a5,0(s2)
ffffffffc0202a7c:	639c                	ld	a5,0(a5)
ffffffffc0202a7e:	42079363          	bnez	a5,ffffffffc0202ea4 <pmm_init+0x866>
ffffffffc0202a82:	100027f3          	csrr	a5,sstatus
ffffffffc0202a86:	8b89                	andi	a5,a5,2
ffffffffc0202a88:	24079963          	bnez	a5,ffffffffc0202cda <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202a8c:	000b3783          	ld	a5,0(s6)
ffffffffc0202a90:	4505                	li	a0,1
ffffffffc0202a92:	6f9c                	ld	a5,24(a5)
ffffffffc0202a94:	9782                	jalr	a5
ffffffffc0202a96:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202a98:	00093503          	ld	a0,0(s2)
ffffffffc0202a9c:	4699                	li	a3,6
ffffffffc0202a9e:	10000613          	li	a2,256
ffffffffc0202aa2:	85d2                	mv	a1,s4
ffffffffc0202aa4:	aa5ff0ef          	jal	ra,ffffffffc0202548 <page_insert>
ffffffffc0202aa8:	44051e63          	bnez	a0,ffffffffc0202f04 <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202aac:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>
ffffffffc0202ab0:	4785                	li	a5,1
ffffffffc0202ab2:	42f71963          	bne	a4,a5,ffffffffc0202ee4 <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202ab6:	00093503          	ld	a0,0(s2)
ffffffffc0202aba:	6405                	lui	s0,0x1
ffffffffc0202abc:	4699                	li	a3,6
ffffffffc0202abe:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8e38>
ffffffffc0202ac2:	85d2                	mv	a1,s4
ffffffffc0202ac4:	a85ff0ef          	jal	ra,ffffffffc0202548 <page_insert>
ffffffffc0202ac8:	72051363          	bnez	a0,ffffffffc02031ee <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202acc:	000a2703          	lw	a4,0(s4)
ffffffffc0202ad0:	4789                	li	a5,2
ffffffffc0202ad2:	6ef71e63          	bne	a4,a5,ffffffffc02031ce <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202ad6:	00004597          	auipc	a1,0x4
ffffffffc0202ada:	2b258593          	addi	a1,a1,690 # ffffffffc0206d88 <default_pmm_manager+0x6a8>
ffffffffc0202ade:	10000513          	li	a0,256
ffffffffc0202ae2:	529020ef          	jal	ra,ffffffffc020580a <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202ae6:	10040593          	addi	a1,s0,256
ffffffffc0202aea:	10000513          	li	a0,256
ffffffffc0202aee:	52f020ef          	jal	ra,ffffffffc020581c <strcmp>
ffffffffc0202af2:	6a051e63          	bnez	a0,ffffffffc02031ae <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202af6:	000bb683          	ld	a3,0(s7)
ffffffffc0202afa:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202afe:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202b00:	40da06b3          	sub	a3,s4,a3
ffffffffc0202b04:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202b06:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202b08:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202b0a:	8031                	srli	s0,s0,0xc
ffffffffc0202b0c:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b10:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b12:	30f77d63          	bgeu	a4,a5,ffffffffc0202e2c <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202b16:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202b1a:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202b1e:	96be                	add	a3,a3,a5
ffffffffc0202b20:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202b24:	4b1020ef          	jal	ra,ffffffffc02057d4 <strlen>
ffffffffc0202b28:	66051363          	bnez	a0,ffffffffc020318e <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202b2c:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202b30:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b32:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd204f0>
ffffffffc0202b36:	068a                	slli	a3,a3,0x2
ffffffffc0202b38:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b3a:	26f6f563          	bgeu	a3,a5,ffffffffc0202da4 <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202b3e:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202b40:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202b42:	2ef47563          	bgeu	s0,a5,ffffffffc0202e2c <pmm_init+0x7ee>
ffffffffc0202b46:	0009b403          	ld	s0,0(s3)
ffffffffc0202b4a:	9436                	add	s0,s0,a3
ffffffffc0202b4c:	100027f3          	csrr	a5,sstatus
ffffffffc0202b50:	8b89                	andi	a5,a5,2
ffffffffc0202b52:	1e079163          	bnez	a5,ffffffffc0202d34 <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202b56:	000b3783          	ld	a5,0(s6)
ffffffffc0202b5a:	4585                	li	a1,1
ffffffffc0202b5c:	8552                	mv	a0,s4
ffffffffc0202b5e:	739c                	ld	a5,32(a5)
ffffffffc0202b60:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b62:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202b64:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b66:	078a                	slli	a5,a5,0x2
ffffffffc0202b68:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b6a:	22e7fd63          	bgeu	a5,a4,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b6e:	000bb503          	ld	a0,0(s7)
ffffffffc0202b72:	fff80737          	lui	a4,0xfff80
ffffffffc0202b76:	97ba                	add	a5,a5,a4
ffffffffc0202b78:	079a                	slli	a5,a5,0x6
ffffffffc0202b7a:	953e                	add	a0,a0,a5
ffffffffc0202b7c:	100027f3          	csrr	a5,sstatus
ffffffffc0202b80:	8b89                	andi	a5,a5,2
ffffffffc0202b82:	18079d63          	bnez	a5,ffffffffc0202d1c <pmm_init+0x6de>
ffffffffc0202b86:	000b3783          	ld	a5,0(s6)
ffffffffc0202b8a:	4585                	li	a1,1
ffffffffc0202b8c:	739c                	ld	a5,32(a5)
ffffffffc0202b8e:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b90:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202b94:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202b96:	078a                	slli	a5,a5,0x2
ffffffffc0202b98:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202b9a:	20e7f563          	bgeu	a5,a4,ffffffffc0202da4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202b9e:	000bb503          	ld	a0,0(s7)
ffffffffc0202ba2:	fff80737          	lui	a4,0xfff80
ffffffffc0202ba6:	97ba                	add	a5,a5,a4
ffffffffc0202ba8:	079a                	slli	a5,a5,0x6
ffffffffc0202baa:	953e                	add	a0,a0,a5
ffffffffc0202bac:	100027f3          	csrr	a5,sstatus
ffffffffc0202bb0:	8b89                	andi	a5,a5,2
ffffffffc0202bb2:	14079963          	bnez	a5,ffffffffc0202d04 <pmm_init+0x6c6>
ffffffffc0202bb6:	000b3783          	ld	a5,0(s6)
ffffffffc0202bba:	4585                	li	a1,1
ffffffffc0202bbc:	739c                	ld	a5,32(a5)
ffffffffc0202bbe:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202bc0:	00093783          	ld	a5,0(s2)
ffffffffc0202bc4:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202bc8:	12000073          	sfence.vma
ffffffffc0202bcc:	100027f3          	csrr	a5,sstatus
ffffffffc0202bd0:	8b89                	andi	a5,a5,2
ffffffffc0202bd2:	10079f63          	bnez	a5,ffffffffc0202cf0 <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202bd6:	000b3783          	ld	a5,0(s6)
ffffffffc0202bda:	779c                	ld	a5,40(a5)
ffffffffc0202bdc:	9782                	jalr	a5
ffffffffc0202bde:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202be0:	4c8c1e63          	bne	s8,s0,ffffffffc02030bc <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202be4:	00004517          	auipc	a0,0x4
ffffffffc0202be8:	21c50513          	addi	a0,a0,540 # ffffffffc0206e00 <default_pmm_manager+0x720>
ffffffffc0202bec:	dacfd0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0202bf0:	7406                	ld	s0,96(sp)
ffffffffc0202bf2:	70a6                	ld	ra,104(sp)
ffffffffc0202bf4:	64e6                	ld	s1,88(sp)
ffffffffc0202bf6:	6946                	ld	s2,80(sp)
ffffffffc0202bf8:	69a6                	ld	s3,72(sp)
ffffffffc0202bfa:	6a06                	ld	s4,64(sp)
ffffffffc0202bfc:	7ae2                	ld	s5,56(sp)
ffffffffc0202bfe:	7b42                	ld	s6,48(sp)
ffffffffc0202c00:	7ba2                	ld	s7,40(sp)
ffffffffc0202c02:	7c02                	ld	s8,32(sp)
ffffffffc0202c04:	6ce2                	ld	s9,24(sp)
ffffffffc0202c06:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202c08:	f97fe06f          	j	ffffffffc0201b9e <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202c0c:	c80007b7          	lui	a5,0xc8000
ffffffffc0202c10:	bc7d                	j	ffffffffc02026ce <pmm_init+0x90>
        intr_disable();
ffffffffc0202c12:	d9dfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202c16:	000b3783          	ld	a5,0(s6)
ffffffffc0202c1a:	4505                	li	a0,1
ffffffffc0202c1c:	6f9c                	ld	a5,24(a5)
ffffffffc0202c1e:	9782                	jalr	a5
ffffffffc0202c20:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202c22:	d87fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c26:	b9a9                	j	ffffffffc0202880 <pmm_init+0x242>
        intr_disable();
ffffffffc0202c28:	d87fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202c2c:	000b3783          	ld	a5,0(s6)
ffffffffc0202c30:	4505                	li	a0,1
ffffffffc0202c32:	6f9c                	ld	a5,24(a5)
ffffffffc0202c34:	9782                	jalr	a5
ffffffffc0202c36:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202c38:	d71fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c3c:	b645                	j	ffffffffc02027dc <pmm_init+0x19e>
        intr_disable();
ffffffffc0202c3e:	d71fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202c42:	000b3783          	ld	a5,0(s6)
ffffffffc0202c46:	779c                	ld	a5,40(a5)
ffffffffc0202c48:	9782                	jalr	a5
ffffffffc0202c4a:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202c4c:	d5dfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c50:	b6b9                	j	ffffffffc020279e <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202c52:	6705                	lui	a4,0x1
ffffffffc0202c54:	177d                	addi	a4,a4,-1
ffffffffc0202c56:	96ba                	add	a3,a3,a4
ffffffffc0202c58:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202c5a:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202c5e:	14a77363          	bgeu	a4,a0,ffffffffc0202da4 <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202c62:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202c66:	fff80537          	lui	a0,0xfff80
ffffffffc0202c6a:	972a                	add	a4,a4,a0
ffffffffc0202c6c:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202c6e:	8c1d                	sub	s0,s0,a5
ffffffffc0202c70:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202c74:	00c45593          	srli	a1,s0,0xc
ffffffffc0202c78:	9532                	add	a0,a0,a2
ffffffffc0202c7a:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202c7c:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202c80:	b4c1                	j	ffffffffc0202740 <pmm_init+0x102>
        intr_disable();
ffffffffc0202c82:	d2dfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202c86:	000b3783          	ld	a5,0(s6)
ffffffffc0202c8a:	779c                	ld	a5,40(a5)
ffffffffc0202c8c:	9782                	jalr	a5
ffffffffc0202c8e:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202c90:	d19fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202c94:	bb79                	j	ffffffffc0202a32 <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202c96:	d19fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202c9a:	000b3783          	ld	a5,0(s6)
ffffffffc0202c9e:	779c                	ld	a5,40(a5)
ffffffffc0202ca0:	9782                	jalr	a5
ffffffffc0202ca2:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202ca4:	d05fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202ca8:	b39d                	j	ffffffffc0202a0e <pmm_init+0x3d0>
ffffffffc0202caa:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202cac:	d03fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202cb0:	000b3783          	ld	a5,0(s6)
ffffffffc0202cb4:	6522                	ld	a0,8(sp)
ffffffffc0202cb6:	4585                	li	a1,1
ffffffffc0202cb8:	739c                	ld	a5,32(a5)
ffffffffc0202cba:	9782                	jalr	a5
        intr_enable();
ffffffffc0202cbc:	cedfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cc0:	b33d                	j	ffffffffc02029ee <pmm_init+0x3b0>
ffffffffc0202cc2:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202cc4:	cebfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202cc8:	000b3783          	ld	a5,0(s6)
ffffffffc0202ccc:	6522                	ld	a0,8(sp)
ffffffffc0202cce:	4585                	li	a1,1
ffffffffc0202cd0:	739c                	ld	a5,32(a5)
ffffffffc0202cd2:	9782                	jalr	a5
        intr_enable();
ffffffffc0202cd4:	cd5fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cd8:	b1dd                	j	ffffffffc02029be <pmm_init+0x380>
        intr_disable();
ffffffffc0202cda:	cd5fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202cde:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce2:	4505                	li	a0,1
ffffffffc0202ce4:	6f9c                	ld	a5,24(a5)
ffffffffc0202ce6:	9782                	jalr	a5
ffffffffc0202ce8:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202cea:	cbffd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202cee:	b36d                	j	ffffffffc0202a98 <pmm_init+0x45a>
        intr_disable();
ffffffffc0202cf0:	cbffd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202cf4:	000b3783          	ld	a5,0(s6)
ffffffffc0202cf8:	779c                	ld	a5,40(a5)
ffffffffc0202cfa:	9782                	jalr	a5
ffffffffc0202cfc:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202cfe:	cabfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d02:	bdf9                	j	ffffffffc0202be0 <pmm_init+0x5a2>
ffffffffc0202d04:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202d06:	ca9fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202d0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202d0e:	6522                	ld	a0,8(sp)
ffffffffc0202d10:	4585                	li	a1,1
ffffffffc0202d12:	739c                	ld	a5,32(a5)
ffffffffc0202d14:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d16:	c93fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d1a:	b55d                	j	ffffffffc0202bc0 <pmm_init+0x582>
ffffffffc0202d1c:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202d1e:	c91fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202d22:	000b3783          	ld	a5,0(s6)
ffffffffc0202d26:	6522                	ld	a0,8(sp)
ffffffffc0202d28:	4585                	li	a1,1
ffffffffc0202d2a:	739c                	ld	a5,32(a5)
ffffffffc0202d2c:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d2e:	c7bfd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d32:	bdb9                	j	ffffffffc0202b90 <pmm_init+0x552>
        intr_disable();
ffffffffc0202d34:	c7bfd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc0202d38:	000b3783          	ld	a5,0(s6)
ffffffffc0202d3c:	4585                	li	a1,1
ffffffffc0202d3e:	8552                	mv	a0,s4
ffffffffc0202d40:	739c                	ld	a5,32(a5)
ffffffffc0202d42:	9782                	jalr	a5
        intr_enable();
ffffffffc0202d44:	c65fd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc0202d48:	bd29                	j	ffffffffc0202b62 <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202d4a:	86a2                	mv	a3,s0
ffffffffc0202d4c:	00004617          	auipc	a2,0x4
ffffffffc0202d50:	9cc60613          	addi	a2,a2,-1588 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0202d54:	24700593          	li	a1,583
ffffffffc0202d58:	00004517          	auipc	a0,0x4
ffffffffc0202d5c:	ad850513          	addi	a0,a0,-1320 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202d60:	f32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202d64:	00004697          	auipc	a3,0x4
ffffffffc0202d68:	f3c68693          	addi	a3,a3,-196 # ffffffffc0206ca0 <default_pmm_manager+0x5c0>
ffffffffc0202d6c:	00003617          	auipc	a2,0x3
ffffffffc0202d70:	5c460613          	addi	a2,a2,1476 # ffffffffc0206330 <commands+0x828>
ffffffffc0202d74:	24800593          	li	a1,584
ffffffffc0202d78:	00004517          	auipc	a0,0x4
ffffffffc0202d7c:	ab850513          	addi	a0,a0,-1352 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202d80:	f12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202d84:	00004697          	auipc	a3,0x4
ffffffffc0202d88:	edc68693          	addi	a3,a3,-292 # ffffffffc0206c60 <default_pmm_manager+0x580>
ffffffffc0202d8c:	00003617          	auipc	a2,0x3
ffffffffc0202d90:	5a460613          	addi	a2,a2,1444 # ffffffffc0206330 <commands+0x828>
ffffffffc0202d94:	24700593          	li	a1,583
ffffffffc0202d98:	00004517          	auipc	a0,0x4
ffffffffc0202d9c:	a9850513          	addi	a0,a0,-1384 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202da0:	ef2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0202da4:	fc5fe0ef          	jal	ra,ffffffffc0201d68 <pa2page.part.0>
ffffffffc0202da8:	fddfe0ef          	jal	ra,ffffffffc0201d84 <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202dac:	00004697          	auipc	a3,0x4
ffffffffc0202db0:	cac68693          	addi	a3,a3,-852 # ffffffffc0206a58 <default_pmm_manager+0x378>
ffffffffc0202db4:	00003617          	auipc	a2,0x3
ffffffffc0202db8:	57c60613          	addi	a2,a2,1404 # ffffffffc0206330 <commands+0x828>
ffffffffc0202dbc:	21700593          	li	a1,535
ffffffffc0202dc0:	00004517          	auipc	a0,0x4
ffffffffc0202dc4:	a7050513          	addi	a0,a0,-1424 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202dc8:	ecafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202dcc:	00004697          	auipc	a3,0x4
ffffffffc0202dd0:	bcc68693          	addi	a3,a3,-1076 # ffffffffc0206998 <default_pmm_manager+0x2b8>
ffffffffc0202dd4:	00003617          	auipc	a2,0x3
ffffffffc0202dd8:	55c60613          	addi	a2,a2,1372 # ffffffffc0206330 <commands+0x828>
ffffffffc0202ddc:	20a00593          	li	a1,522
ffffffffc0202de0:	00004517          	auipc	a0,0x4
ffffffffc0202de4:	a5050513          	addi	a0,a0,-1456 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202de8:	eaafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202dec:	00004697          	auipc	a3,0x4
ffffffffc0202df0:	b6c68693          	addi	a3,a3,-1172 # ffffffffc0206958 <default_pmm_manager+0x278>
ffffffffc0202df4:	00003617          	auipc	a2,0x3
ffffffffc0202df8:	53c60613          	addi	a2,a2,1340 # ffffffffc0206330 <commands+0x828>
ffffffffc0202dfc:	20900593          	li	a1,521
ffffffffc0202e00:	00004517          	auipc	a0,0x4
ffffffffc0202e04:	a3050513          	addi	a0,a0,-1488 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202e08:	e8afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202e0c:	00004697          	auipc	a3,0x4
ffffffffc0202e10:	b2c68693          	addi	a3,a3,-1236 # ffffffffc0206938 <default_pmm_manager+0x258>
ffffffffc0202e14:	00003617          	auipc	a2,0x3
ffffffffc0202e18:	51c60613          	addi	a2,a2,1308 # ffffffffc0206330 <commands+0x828>
ffffffffc0202e1c:	20800593          	li	a1,520
ffffffffc0202e20:	00004517          	auipc	a0,0x4
ffffffffc0202e24:	a1050513          	addi	a0,a0,-1520 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202e28:	e6afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc0202e2c:	00004617          	auipc	a2,0x4
ffffffffc0202e30:	8ec60613          	addi	a2,a2,-1812 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0202e34:	07100593          	li	a1,113
ffffffffc0202e38:	00004517          	auipc	a0,0x4
ffffffffc0202e3c:	90850513          	addi	a0,a0,-1784 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0202e40:	e52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202e44:	00004697          	auipc	a3,0x4
ffffffffc0202e48:	da468693          	addi	a3,a3,-604 # ffffffffc0206be8 <default_pmm_manager+0x508>
ffffffffc0202e4c:	00003617          	auipc	a2,0x3
ffffffffc0202e50:	4e460613          	addi	a2,a2,1252 # ffffffffc0206330 <commands+0x828>
ffffffffc0202e54:	23000593          	li	a1,560
ffffffffc0202e58:	00004517          	auipc	a0,0x4
ffffffffc0202e5c:	9d850513          	addi	a0,a0,-1576 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202e60:	e32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202e64:	00004697          	auipc	a3,0x4
ffffffffc0202e68:	d3c68693          	addi	a3,a3,-708 # ffffffffc0206ba0 <default_pmm_manager+0x4c0>
ffffffffc0202e6c:	00003617          	auipc	a2,0x3
ffffffffc0202e70:	4c460613          	addi	a2,a2,1220 # ffffffffc0206330 <commands+0x828>
ffffffffc0202e74:	22e00593          	li	a1,558
ffffffffc0202e78:	00004517          	auipc	a0,0x4
ffffffffc0202e7c:	9b850513          	addi	a0,a0,-1608 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202e80:	e12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202e84:	00004697          	auipc	a3,0x4
ffffffffc0202e88:	d4c68693          	addi	a3,a3,-692 # ffffffffc0206bd0 <default_pmm_manager+0x4f0>
ffffffffc0202e8c:	00003617          	auipc	a2,0x3
ffffffffc0202e90:	4a460613          	addi	a2,a2,1188 # ffffffffc0206330 <commands+0x828>
ffffffffc0202e94:	22d00593          	li	a1,557
ffffffffc0202e98:	00004517          	auipc	a0,0x4
ffffffffc0202e9c:	99850513          	addi	a0,a0,-1640 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202ea0:	df2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202ea4:	00004697          	auipc	a3,0x4
ffffffffc0202ea8:	e1468693          	addi	a3,a3,-492 # ffffffffc0206cb8 <default_pmm_manager+0x5d8>
ffffffffc0202eac:	00003617          	auipc	a2,0x3
ffffffffc0202eb0:	48460613          	addi	a2,a2,1156 # ffffffffc0206330 <commands+0x828>
ffffffffc0202eb4:	24b00593          	li	a1,587
ffffffffc0202eb8:	00004517          	auipc	a0,0x4
ffffffffc0202ebc:	97850513          	addi	a0,a0,-1672 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202ec0:	dd2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202ec4:	00004697          	auipc	a3,0x4
ffffffffc0202ec8:	d5468693          	addi	a3,a3,-684 # ffffffffc0206c18 <default_pmm_manager+0x538>
ffffffffc0202ecc:	00003617          	auipc	a2,0x3
ffffffffc0202ed0:	46460613          	addi	a2,a2,1124 # ffffffffc0206330 <commands+0x828>
ffffffffc0202ed4:	23800593          	li	a1,568
ffffffffc0202ed8:	00004517          	auipc	a0,0x4
ffffffffc0202edc:	95850513          	addi	a0,a0,-1704 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202ee0:	db2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202ee4:	00004697          	auipc	a3,0x4
ffffffffc0202ee8:	e2c68693          	addi	a3,a3,-468 # ffffffffc0206d10 <default_pmm_manager+0x630>
ffffffffc0202eec:	00003617          	auipc	a2,0x3
ffffffffc0202ef0:	44460613          	addi	a2,a2,1092 # ffffffffc0206330 <commands+0x828>
ffffffffc0202ef4:	25000593          	li	a1,592
ffffffffc0202ef8:	00004517          	auipc	a0,0x4
ffffffffc0202efc:	93850513          	addi	a0,a0,-1736 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202f00:	d92fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202f04:	00004697          	auipc	a3,0x4
ffffffffc0202f08:	dcc68693          	addi	a3,a3,-564 # ffffffffc0206cd0 <default_pmm_manager+0x5f0>
ffffffffc0202f0c:	00003617          	auipc	a2,0x3
ffffffffc0202f10:	42460613          	addi	a2,a2,1060 # ffffffffc0206330 <commands+0x828>
ffffffffc0202f14:	24f00593          	li	a1,591
ffffffffc0202f18:	00004517          	auipc	a0,0x4
ffffffffc0202f1c:	91850513          	addi	a0,a0,-1768 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202f20:	d72fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f24:	00004697          	auipc	a3,0x4
ffffffffc0202f28:	c7c68693          	addi	a3,a3,-900 # ffffffffc0206ba0 <default_pmm_manager+0x4c0>
ffffffffc0202f2c:	00003617          	auipc	a2,0x3
ffffffffc0202f30:	40460613          	addi	a2,a2,1028 # ffffffffc0206330 <commands+0x828>
ffffffffc0202f34:	22a00593          	li	a1,554
ffffffffc0202f38:	00004517          	auipc	a0,0x4
ffffffffc0202f3c:	8f850513          	addi	a0,a0,-1800 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202f40:	d52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0202f44:	00004697          	auipc	a3,0x4
ffffffffc0202f48:	afc68693          	addi	a3,a3,-1284 # ffffffffc0206a40 <default_pmm_manager+0x360>
ffffffffc0202f4c:	00003617          	auipc	a2,0x3
ffffffffc0202f50:	3e460613          	addi	a2,a2,996 # ffffffffc0206330 <commands+0x828>
ffffffffc0202f54:	22900593          	li	a1,553
ffffffffc0202f58:	00004517          	auipc	a0,0x4
ffffffffc0202f5c:	8d850513          	addi	a0,a0,-1832 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202f60:	d32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202f64:	00004697          	auipc	a3,0x4
ffffffffc0202f68:	c5468693          	addi	a3,a3,-940 # ffffffffc0206bb8 <default_pmm_manager+0x4d8>
ffffffffc0202f6c:	00003617          	auipc	a2,0x3
ffffffffc0202f70:	3c460613          	addi	a2,a2,964 # ffffffffc0206330 <commands+0x828>
ffffffffc0202f74:	22600593          	li	a1,550
ffffffffc0202f78:	00004517          	auipc	a0,0x4
ffffffffc0202f7c:	8b850513          	addi	a0,a0,-1864 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202f80:	d12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0202f84:	00004697          	auipc	a3,0x4
ffffffffc0202f88:	aa468693          	addi	a3,a3,-1372 # ffffffffc0206a28 <default_pmm_manager+0x348>
ffffffffc0202f8c:	00003617          	auipc	a2,0x3
ffffffffc0202f90:	3a460613          	addi	a2,a2,932 # ffffffffc0206330 <commands+0x828>
ffffffffc0202f94:	22500593          	li	a1,549
ffffffffc0202f98:	00004517          	auipc	a0,0x4
ffffffffc0202f9c:	89850513          	addi	a0,a0,-1896 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202fa0:	cf2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc0202fa4:	00004697          	auipc	a3,0x4
ffffffffc0202fa8:	b2468693          	addi	a3,a3,-1244 # ffffffffc0206ac8 <default_pmm_manager+0x3e8>
ffffffffc0202fac:	00003617          	auipc	a2,0x3
ffffffffc0202fb0:	38460613          	addi	a2,a2,900 # ffffffffc0206330 <commands+0x828>
ffffffffc0202fb4:	22400593          	li	a1,548
ffffffffc0202fb8:	00004517          	auipc	a0,0x4
ffffffffc0202fbc:	87850513          	addi	a0,a0,-1928 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202fc0:	cd2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202fc4:	00004697          	auipc	a3,0x4
ffffffffc0202fc8:	bdc68693          	addi	a3,a3,-1060 # ffffffffc0206ba0 <default_pmm_manager+0x4c0>
ffffffffc0202fcc:	00003617          	auipc	a2,0x3
ffffffffc0202fd0:	36460613          	addi	a2,a2,868 # ffffffffc0206330 <commands+0x828>
ffffffffc0202fd4:	22300593          	li	a1,547
ffffffffc0202fd8:	00004517          	auipc	a0,0x4
ffffffffc0202fdc:	85850513          	addi	a0,a0,-1960 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0202fe0:	cb2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 2);
ffffffffc0202fe4:	00004697          	auipc	a3,0x4
ffffffffc0202fe8:	ba468693          	addi	a3,a3,-1116 # ffffffffc0206b88 <default_pmm_manager+0x4a8>
ffffffffc0202fec:	00003617          	auipc	a2,0x3
ffffffffc0202ff0:	34460613          	addi	a2,a2,836 # ffffffffc0206330 <commands+0x828>
ffffffffc0202ff4:	22200593          	li	a1,546
ffffffffc0202ff8:	00004517          	auipc	a0,0x4
ffffffffc0202ffc:	83850513          	addi	a0,a0,-1992 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203000:	c92fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc0203004:	00004697          	auipc	a3,0x4
ffffffffc0203008:	b5468693          	addi	a3,a3,-1196 # ffffffffc0206b58 <default_pmm_manager+0x478>
ffffffffc020300c:	00003617          	auipc	a2,0x3
ffffffffc0203010:	32460613          	addi	a2,a2,804 # ffffffffc0206330 <commands+0x828>
ffffffffc0203014:	22100593          	li	a1,545
ffffffffc0203018:	00004517          	auipc	a0,0x4
ffffffffc020301c:	81850513          	addi	a0,a0,-2024 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203020:	c72fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p2) == 1);
ffffffffc0203024:	00004697          	auipc	a3,0x4
ffffffffc0203028:	b1c68693          	addi	a3,a3,-1252 # ffffffffc0206b40 <default_pmm_manager+0x460>
ffffffffc020302c:	00003617          	auipc	a2,0x3
ffffffffc0203030:	30460613          	addi	a2,a2,772 # ffffffffc0206330 <commands+0x828>
ffffffffc0203034:	21f00593          	li	a1,543
ffffffffc0203038:	00003517          	auipc	a0,0x3
ffffffffc020303c:	7f850513          	addi	a0,a0,2040 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203040:	c52fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc0203044:	00004697          	auipc	a3,0x4
ffffffffc0203048:	adc68693          	addi	a3,a3,-1316 # ffffffffc0206b20 <default_pmm_manager+0x440>
ffffffffc020304c:	00003617          	auipc	a2,0x3
ffffffffc0203050:	2e460613          	addi	a2,a2,740 # ffffffffc0206330 <commands+0x828>
ffffffffc0203054:	21e00593          	li	a1,542
ffffffffc0203058:	00003517          	auipc	a0,0x3
ffffffffc020305c:	7d850513          	addi	a0,a0,2008 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203060:	c32fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(*ptep & PTE_W);
ffffffffc0203064:	00004697          	auipc	a3,0x4
ffffffffc0203068:	aac68693          	addi	a3,a3,-1364 # ffffffffc0206b10 <default_pmm_manager+0x430>
ffffffffc020306c:	00003617          	auipc	a2,0x3
ffffffffc0203070:	2c460613          	addi	a2,a2,708 # ffffffffc0206330 <commands+0x828>
ffffffffc0203074:	21d00593          	li	a1,541
ffffffffc0203078:	00003517          	auipc	a0,0x3
ffffffffc020307c:	7b850513          	addi	a0,a0,1976 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203080:	c12fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(*ptep & PTE_U);
ffffffffc0203084:	00004697          	auipc	a3,0x4
ffffffffc0203088:	a7c68693          	addi	a3,a3,-1412 # ffffffffc0206b00 <default_pmm_manager+0x420>
ffffffffc020308c:	00003617          	auipc	a2,0x3
ffffffffc0203090:	2a460613          	addi	a2,a2,676 # ffffffffc0206330 <commands+0x828>
ffffffffc0203094:	21c00593          	li	a1,540
ffffffffc0203098:	00003517          	auipc	a0,0x3
ffffffffc020309c:	79850513          	addi	a0,a0,1944 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02030a0:	bf2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("DTB memory info not available");
ffffffffc02030a4:	00003617          	auipc	a2,0x3
ffffffffc02030a8:	7fc60613          	addi	a2,a2,2044 # ffffffffc02068a0 <default_pmm_manager+0x1c0>
ffffffffc02030ac:	06500593          	li	a1,101
ffffffffc02030b0:	00003517          	auipc	a0,0x3
ffffffffc02030b4:	78050513          	addi	a0,a0,1920 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02030b8:	bdafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc02030bc:	00004697          	auipc	a3,0x4
ffffffffc02030c0:	b5c68693          	addi	a3,a3,-1188 # ffffffffc0206c18 <default_pmm_manager+0x538>
ffffffffc02030c4:	00003617          	auipc	a2,0x3
ffffffffc02030c8:	26c60613          	addi	a2,a2,620 # ffffffffc0206330 <commands+0x828>
ffffffffc02030cc:	26200593          	li	a1,610
ffffffffc02030d0:	00003517          	auipc	a0,0x3
ffffffffc02030d4:	76050513          	addi	a0,a0,1888 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02030d8:	bbafd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02030dc:	00004697          	auipc	a3,0x4
ffffffffc02030e0:	9ec68693          	addi	a3,a3,-1556 # ffffffffc0206ac8 <default_pmm_manager+0x3e8>
ffffffffc02030e4:	00003617          	auipc	a2,0x3
ffffffffc02030e8:	24c60613          	addi	a2,a2,588 # ffffffffc0206330 <commands+0x828>
ffffffffc02030ec:	21b00593          	li	a1,539
ffffffffc02030f0:	00003517          	auipc	a0,0x3
ffffffffc02030f4:	74050513          	addi	a0,a0,1856 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02030f8:	b9afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc02030fc:	00004697          	auipc	a3,0x4
ffffffffc0203100:	98c68693          	addi	a3,a3,-1652 # ffffffffc0206a88 <default_pmm_manager+0x3a8>
ffffffffc0203104:	00003617          	auipc	a2,0x3
ffffffffc0203108:	22c60613          	addi	a2,a2,556 # ffffffffc0206330 <commands+0x828>
ffffffffc020310c:	21a00593          	li	a1,538
ffffffffc0203110:	00003517          	auipc	a0,0x3
ffffffffc0203114:	72050513          	addi	a0,a0,1824 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203118:	b7afd0ef          	jal	ra,ffffffffc0200492 <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020311c:	86d6                	mv	a3,s5
ffffffffc020311e:	00003617          	auipc	a2,0x3
ffffffffc0203122:	5fa60613          	addi	a2,a2,1530 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0203126:	21600593          	li	a1,534
ffffffffc020312a:	00003517          	auipc	a0,0x3
ffffffffc020312e:	70650513          	addi	a0,a0,1798 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203132:	b60fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0203136:	00003617          	auipc	a2,0x3
ffffffffc020313a:	5e260613          	addi	a2,a2,1506 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc020313e:	21500593          	li	a1,533
ffffffffc0203142:	00003517          	auipc	a0,0x3
ffffffffc0203146:	6ee50513          	addi	a0,a0,1774 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020314a:	b48fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p1) == 1);
ffffffffc020314e:	00004697          	auipc	a3,0x4
ffffffffc0203152:	8f268693          	addi	a3,a3,-1806 # ffffffffc0206a40 <default_pmm_manager+0x360>
ffffffffc0203156:	00003617          	auipc	a2,0x3
ffffffffc020315a:	1da60613          	addi	a2,a2,474 # ffffffffc0206330 <commands+0x828>
ffffffffc020315e:	21300593          	li	a1,531
ffffffffc0203162:	00003517          	auipc	a0,0x3
ffffffffc0203166:	6ce50513          	addi	a0,a0,1742 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020316a:	b28fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc020316e:	00004697          	auipc	a3,0x4
ffffffffc0203172:	8ba68693          	addi	a3,a3,-1862 # ffffffffc0206a28 <default_pmm_manager+0x348>
ffffffffc0203176:	00003617          	auipc	a2,0x3
ffffffffc020317a:	1ba60613          	addi	a2,a2,442 # ffffffffc0206330 <commands+0x828>
ffffffffc020317e:	21200593          	li	a1,530
ffffffffc0203182:	00003517          	auipc	a0,0x3
ffffffffc0203186:	6ae50513          	addi	a0,a0,1710 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020318a:	b08fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc020318e:	00004697          	auipc	a3,0x4
ffffffffc0203192:	c4a68693          	addi	a3,a3,-950 # ffffffffc0206dd8 <default_pmm_manager+0x6f8>
ffffffffc0203196:	00003617          	auipc	a2,0x3
ffffffffc020319a:	19a60613          	addi	a2,a2,410 # ffffffffc0206330 <commands+0x828>
ffffffffc020319e:	25900593          	li	a1,601
ffffffffc02031a2:	00003517          	auipc	a0,0x3
ffffffffc02031a6:	68e50513          	addi	a0,a0,1678 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02031aa:	ae8fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc02031ae:	00004697          	auipc	a3,0x4
ffffffffc02031b2:	bf268693          	addi	a3,a3,-1038 # ffffffffc0206da0 <default_pmm_manager+0x6c0>
ffffffffc02031b6:	00003617          	auipc	a2,0x3
ffffffffc02031ba:	17a60613          	addi	a2,a2,378 # ffffffffc0206330 <commands+0x828>
ffffffffc02031be:	25600593          	li	a1,598
ffffffffc02031c2:	00003517          	auipc	a0,0x3
ffffffffc02031c6:	66e50513          	addi	a0,a0,1646 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02031ca:	ac8fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_ref(p) == 2);
ffffffffc02031ce:	00004697          	auipc	a3,0x4
ffffffffc02031d2:	ba268693          	addi	a3,a3,-1118 # ffffffffc0206d70 <default_pmm_manager+0x690>
ffffffffc02031d6:	00003617          	auipc	a2,0x3
ffffffffc02031da:	15a60613          	addi	a2,a2,346 # ffffffffc0206330 <commands+0x828>
ffffffffc02031de:	25200593          	li	a1,594
ffffffffc02031e2:	00003517          	auipc	a0,0x3
ffffffffc02031e6:	64e50513          	addi	a0,a0,1614 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02031ea:	aa8fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc02031ee:	00004697          	auipc	a3,0x4
ffffffffc02031f2:	b3a68693          	addi	a3,a3,-1222 # ffffffffc0206d28 <default_pmm_manager+0x648>
ffffffffc02031f6:	00003617          	auipc	a2,0x3
ffffffffc02031fa:	13a60613          	addi	a2,a2,314 # ffffffffc0206330 <commands+0x828>
ffffffffc02031fe:	25100593          	li	a1,593
ffffffffc0203202:	00003517          	auipc	a0,0x3
ffffffffc0203206:	62e50513          	addi	a0,a0,1582 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020320a:	a88fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc020320e:	00003617          	auipc	a2,0x3
ffffffffc0203212:	5b260613          	addi	a2,a2,1458 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc0203216:	0c900593          	li	a1,201
ffffffffc020321a:	00003517          	auipc	a0,0x3
ffffffffc020321e:	61650513          	addi	a0,a0,1558 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc0203222:	a70fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0203226:	00003617          	auipc	a2,0x3
ffffffffc020322a:	59a60613          	addi	a2,a2,1434 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc020322e:	08100593          	li	a1,129
ffffffffc0203232:	00003517          	auipc	a0,0x3
ffffffffc0203236:	5fe50513          	addi	a0,a0,1534 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020323a:	a58fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc020323e:	00003697          	auipc	a3,0x3
ffffffffc0203242:	7ba68693          	addi	a3,a3,1978 # ffffffffc02069f8 <default_pmm_manager+0x318>
ffffffffc0203246:	00003617          	auipc	a2,0x3
ffffffffc020324a:	0ea60613          	addi	a2,a2,234 # ffffffffc0206330 <commands+0x828>
ffffffffc020324e:	21100593          	li	a1,529
ffffffffc0203252:	00003517          	auipc	a0,0x3
ffffffffc0203256:	5de50513          	addi	a0,a0,1502 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020325a:	a38fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc020325e:	00003697          	auipc	a3,0x3
ffffffffc0203262:	76a68693          	addi	a3,a3,1898 # ffffffffc02069c8 <default_pmm_manager+0x2e8>
ffffffffc0203266:	00003617          	auipc	a2,0x3
ffffffffc020326a:	0ca60613          	addi	a2,a2,202 # ffffffffc0206330 <commands+0x828>
ffffffffc020326e:	20e00593          	li	a1,526
ffffffffc0203272:	00003517          	auipc	a0,0x3
ffffffffc0203276:	5be50513          	addi	a0,a0,1470 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020327a:	a18fd0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020327e <copy_range>:
{
ffffffffc020327e:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203280:	00d667b3          	or	a5,a2,a3
{
ffffffffc0203284:	f486                	sd	ra,104(sp)
ffffffffc0203286:	f0a2                	sd	s0,96(sp)
ffffffffc0203288:	eca6                	sd	s1,88(sp)
ffffffffc020328a:	e8ca                	sd	s2,80(sp)
ffffffffc020328c:	e4ce                	sd	s3,72(sp)
ffffffffc020328e:	e0d2                	sd	s4,64(sp)
ffffffffc0203290:	fc56                	sd	s5,56(sp)
ffffffffc0203292:	f85a                	sd	s6,48(sp)
ffffffffc0203294:	f45e                	sd	s7,40(sp)
ffffffffc0203296:	f062                	sd	s8,32(sp)
ffffffffc0203298:	ec66                	sd	s9,24(sp)
ffffffffc020329a:	e86a                	sd	s10,16(sp)
ffffffffc020329c:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020329e:	17d2                	slli	a5,a5,0x34
ffffffffc02032a0:	20079f63          	bnez	a5,ffffffffc02034be <copy_range+0x240>
    assert(USER_ACCESS(start, end));
ffffffffc02032a4:	002007b7          	lui	a5,0x200
ffffffffc02032a8:	8432                	mv	s0,a2
ffffffffc02032aa:	1af66263          	bltu	a2,a5,ffffffffc020344e <copy_range+0x1d0>
ffffffffc02032ae:	8936                	mv	s2,a3
ffffffffc02032b0:	18d67f63          	bgeu	a2,a3,ffffffffc020344e <copy_range+0x1d0>
ffffffffc02032b4:	4785                	li	a5,1
ffffffffc02032b6:	07fe                	slli	a5,a5,0x1f
ffffffffc02032b8:	18d7eb63          	bltu	a5,a3,ffffffffc020344e <copy_range+0x1d0>
ffffffffc02032bc:	5b7d                	li	s6,-1
ffffffffc02032be:	8aaa                	mv	s5,a0
ffffffffc02032c0:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc02032c2:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc02032c4:	000dbc17          	auipc	s8,0xdb
ffffffffc02032c8:	7fcc0c13          	addi	s8,s8,2044 # ffffffffc02deac0 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02032cc:	000dbb97          	auipc	s7,0xdb
ffffffffc02032d0:	7fcb8b93          	addi	s7,s7,2044 # ffffffffc02deac8 <pages>
    return KADDR(page2pa(page));
ffffffffc02032d4:	00cb5b13          	srli	s6,s6,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc02032d8:	000dbc97          	auipc	s9,0xdb
ffffffffc02032dc:	7f8c8c93          	addi	s9,s9,2040 # ffffffffc02dead0 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02032e0:	4601                	li	a2,0
ffffffffc02032e2:	85a2                	mv	a1,s0
ffffffffc02032e4:	854e                	mv	a0,s3
ffffffffc02032e6:	b73fe0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc02032ea:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc02032ec:	0e050c63          	beqz	a0,ffffffffc02033e4 <copy_range+0x166>
        if (*ptep & PTE_V)
ffffffffc02032f0:	611c                	ld	a5,0(a0)
ffffffffc02032f2:	8b85                	andi	a5,a5,1
ffffffffc02032f4:	e785                	bnez	a5,ffffffffc020331c <copy_range+0x9e>
        start += PGSIZE;
ffffffffc02032f6:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02032f8:	ff2464e3          	bltu	s0,s2,ffffffffc02032e0 <copy_range+0x62>
    return 0;
ffffffffc02032fc:	4501                	li	a0,0
}
ffffffffc02032fe:	70a6                	ld	ra,104(sp)
ffffffffc0203300:	7406                	ld	s0,96(sp)
ffffffffc0203302:	64e6                	ld	s1,88(sp)
ffffffffc0203304:	6946                	ld	s2,80(sp)
ffffffffc0203306:	69a6                	ld	s3,72(sp)
ffffffffc0203308:	6a06                	ld	s4,64(sp)
ffffffffc020330a:	7ae2                	ld	s5,56(sp)
ffffffffc020330c:	7b42                	ld	s6,48(sp)
ffffffffc020330e:	7ba2                	ld	s7,40(sp)
ffffffffc0203310:	7c02                	ld	s8,32(sp)
ffffffffc0203312:	6ce2                	ld	s9,24(sp)
ffffffffc0203314:	6d42                	ld	s10,16(sp)
ffffffffc0203316:	6da2                	ld	s11,8(sp)
ffffffffc0203318:	6165                	addi	sp,sp,112
ffffffffc020331a:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc020331c:	4605                	li	a2,1
ffffffffc020331e:	85a2                	mv	a1,s0
ffffffffc0203320:	8556                	mv	a0,s5
ffffffffc0203322:	b37fe0ef          	jal	ra,ffffffffc0201e58 <get_pte>
ffffffffc0203326:	c56d                	beqz	a0,ffffffffc0203410 <copy_range+0x192>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203328:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V))
ffffffffc020332a:	0017f713          	andi	a4,a5,1
ffffffffc020332e:	01f7f493          	andi	s1,a5,31
ffffffffc0203332:	16070a63          	beqz	a4,ffffffffc02034a6 <copy_range+0x228>
    if (PPN(pa) >= npage)
ffffffffc0203336:	000c3683          	ld	a3,0(s8)
    return pa2page(PTE_ADDR(pte));
ffffffffc020333a:	078a                	slli	a5,a5,0x2
ffffffffc020333c:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203340:	14d77763          	bgeu	a4,a3,ffffffffc020348e <copy_range+0x210>
    return &pages[PPN(pa) - nbase];
ffffffffc0203344:	000bb783          	ld	a5,0(s7)
ffffffffc0203348:	fff806b7          	lui	a3,0xfff80
ffffffffc020334c:	9736                	add	a4,a4,a3
ffffffffc020334e:	071a                	slli	a4,a4,0x6
ffffffffc0203350:	00e78db3          	add	s11,a5,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203354:	10002773          	csrr	a4,sstatus
ffffffffc0203358:	8b09                	andi	a4,a4,2
ffffffffc020335a:	e345                	bnez	a4,ffffffffc02033fa <copy_range+0x17c>
        page = pmm_manager->alloc_pages(n);
ffffffffc020335c:	000cb703          	ld	a4,0(s9)
ffffffffc0203360:	4505                	li	a0,1
ffffffffc0203362:	6f18                	ld	a4,24(a4)
ffffffffc0203364:	9702                	jalr	a4
ffffffffc0203366:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0203368:	0c0d8363          	beqz	s11,ffffffffc020342e <copy_range+0x1b0>
            assert(npage != NULL);
ffffffffc020336c:	100d0163          	beqz	s10,ffffffffc020346e <copy_range+0x1f0>
    return page - pages + nbase;
ffffffffc0203370:	000bb703          	ld	a4,0(s7)
ffffffffc0203374:	000805b7          	lui	a1,0x80
    return KADDR(page2pa(page));
ffffffffc0203378:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc020337c:	40ed86b3          	sub	a3,s11,a4
ffffffffc0203380:	8699                	srai	a3,a3,0x6
ffffffffc0203382:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc0203384:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0203388:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020338a:	08c7f663          	bgeu	a5,a2,ffffffffc0203416 <copy_range+0x198>
    return page - pages + nbase;
ffffffffc020338e:	40ed07b3          	sub	a5,s10,a4
    return KADDR(page2pa(page));
ffffffffc0203392:	000db717          	auipc	a4,0xdb
ffffffffc0203396:	74670713          	addi	a4,a4,1862 # ffffffffc02dead8 <va_pa_offset>
ffffffffc020339a:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc020339c:	8799                	srai	a5,a5,0x6
ffffffffc020339e:	97ae                	add	a5,a5,a1
    return KADDR(page2pa(page));
ffffffffc02033a0:	0167f733          	and	a4,a5,s6
ffffffffc02033a4:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc02033a8:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc02033aa:	06c77563          	bgeu	a4,a2,ffffffffc0203414 <copy_range+0x196>
            memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
ffffffffc02033ae:	6605                	lui	a2,0x1
ffffffffc02033b0:	953e                	add	a0,a0,a5
ffffffffc02033b2:	4d6020ef          	jal	ra,ffffffffc0205888 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc02033b6:	86a6                	mv	a3,s1
ffffffffc02033b8:	8622                	mv	a2,s0
ffffffffc02033ba:	85ea                	mv	a1,s10
ffffffffc02033bc:	8556                	mv	a0,s5
ffffffffc02033be:	98aff0ef          	jal	ra,ffffffffc0202548 <page_insert>
            assert(ret == 0);
ffffffffc02033c2:	d915                	beqz	a0,ffffffffc02032f6 <copy_range+0x78>
ffffffffc02033c4:	00004697          	auipc	a3,0x4
ffffffffc02033c8:	a7c68693          	addi	a3,a3,-1412 # ffffffffc0206e40 <default_pmm_manager+0x760>
ffffffffc02033cc:	00003617          	auipc	a2,0x3
ffffffffc02033d0:	f6460613          	addi	a2,a2,-156 # ffffffffc0206330 <commands+0x828>
ffffffffc02033d4:	1a600593          	li	a1,422
ffffffffc02033d8:	00003517          	auipc	a0,0x3
ffffffffc02033dc:	45850513          	addi	a0,a0,1112 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02033e0:	8b2fd0ef          	jal	ra,ffffffffc0200492 <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02033e4:	00200637          	lui	a2,0x200
ffffffffc02033e8:	9432                	add	s0,s0,a2
ffffffffc02033ea:	ffe00637          	lui	a2,0xffe00
ffffffffc02033ee:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc02033f0:	f00406e3          	beqz	s0,ffffffffc02032fc <copy_range+0x7e>
ffffffffc02033f4:	ef2466e3          	bltu	s0,s2,ffffffffc02032e0 <copy_range+0x62>
ffffffffc02033f8:	b711                	j	ffffffffc02032fc <copy_range+0x7e>
        intr_disable();
ffffffffc02033fa:	db4fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02033fe:	000cb703          	ld	a4,0(s9)
ffffffffc0203402:	4505                	li	a0,1
ffffffffc0203404:	6f18                	ld	a4,24(a4)
ffffffffc0203406:	9702                	jalr	a4
ffffffffc0203408:	8d2a                	mv	s10,a0
        intr_enable();
ffffffffc020340a:	d9efd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020340e:	bfa9                	j	ffffffffc0203368 <copy_range+0xea>
                return -E_NO_MEM;
ffffffffc0203410:	5571                	li	a0,-4
ffffffffc0203412:	b5f5                	j	ffffffffc02032fe <copy_range+0x80>
ffffffffc0203414:	86be                	mv	a3,a5
ffffffffc0203416:	00003617          	auipc	a2,0x3
ffffffffc020341a:	30260613          	addi	a2,a2,770 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc020341e:	07100593          	li	a1,113
ffffffffc0203422:	00003517          	auipc	a0,0x3
ffffffffc0203426:	31e50513          	addi	a0,a0,798 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc020342a:	868fd0ef          	jal	ra,ffffffffc0200492 <__panic>
            assert(page != NULL);
ffffffffc020342e:	00004697          	auipc	a3,0x4
ffffffffc0203432:	9f268693          	addi	a3,a3,-1550 # ffffffffc0206e20 <default_pmm_manager+0x740>
ffffffffc0203436:	00003617          	auipc	a2,0x3
ffffffffc020343a:	efa60613          	addi	a2,a2,-262 # ffffffffc0206330 <commands+0x828>
ffffffffc020343e:	19600593          	li	a1,406
ffffffffc0203442:	00003517          	auipc	a0,0x3
ffffffffc0203446:	3ee50513          	addi	a0,a0,1006 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020344a:	848fd0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc020344e:	00003697          	auipc	a3,0x3
ffffffffc0203452:	42268693          	addi	a3,a3,1058 # ffffffffc0206870 <default_pmm_manager+0x190>
ffffffffc0203456:	00003617          	auipc	a2,0x3
ffffffffc020345a:	eda60613          	addi	a2,a2,-294 # ffffffffc0206330 <commands+0x828>
ffffffffc020345e:	17e00593          	li	a1,382
ffffffffc0203462:	00003517          	auipc	a0,0x3
ffffffffc0203466:	3ce50513          	addi	a0,a0,974 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020346a:	828fd0ef          	jal	ra,ffffffffc0200492 <__panic>
            assert(npage != NULL);
ffffffffc020346e:	00004697          	auipc	a3,0x4
ffffffffc0203472:	9c268693          	addi	a3,a3,-1598 # ffffffffc0206e30 <default_pmm_manager+0x750>
ffffffffc0203476:	00003617          	auipc	a2,0x3
ffffffffc020347a:	eba60613          	addi	a2,a2,-326 # ffffffffc0206330 <commands+0x828>
ffffffffc020347e:	19700593          	li	a1,407
ffffffffc0203482:	00003517          	auipc	a0,0x3
ffffffffc0203486:	3ae50513          	addi	a0,a0,942 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020348a:	808fd0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020348e:	00003617          	auipc	a2,0x3
ffffffffc0203492:	35a60613          	addi	a2,a2,858 # ffffffffc02067e8 <default_pmm_manager+0x108>
ffffffffc0203496:	06900593          	li	a1,105
ffffffffc020349a:	00003517          	auipc	a0,0x3
ffffffffc020349e:	2a650513          	addi	a0,a0,678 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc02034a2:	ff1fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pte2page called with invalid pte");
ffffffffc02034a6:	00003617          	auipc	a2,0x3
ffffffffc02034aa:	36260613          	addi	a2,a2,866 # ffffffffc0206808 <default_pmm_manager+0x128>
ffffffffc02034ae:	07f00593          	li	a1,127
ffffffffc02034b2:	00003517          	auipc	a0,0x3
ffffffffc02034b6:	28e50513          	addi	a0,a0,654 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc02034ba:	fd9fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02034be:	00003697          	auipc	a3,0x3
ffffffffc02034c2:	38268693          	addi	a3,a3,898 # ffffffffc0206840 <default_pmm_manager+0x160>
ffffffffc02034c6:	00003617          	auipc	a2,0x3
ffffffffc02034ca:	e6a60613          	addi	a2,a2,-406 # ffffffffc0206330 <commands+0x828>
ffffffffc02034ce:	17d00593          	li	a1,381
ffffffffc02034d2:	00003517          	auipc	a0,0x3
ffffffffc02034d6:	35e50513          	addi	a0,a0,862 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc02034da:	fb9fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02034de <pgdir_alloc_page>:
{
ffffffffc02034de:	7179                	addi	sp,sp,-48
ffffffffc02034e0:	ec26                	sd	s1,24(sp)
ffffffffc02034e2:	e84a                	sd	s2,16(sp)
ffffffffc02034e4:	e052                	sd	s4,0(sp)
ffffffffc02034e6:	f406                	sd	ra,40(sp)
ffffffffc02034e8:	f022                	sd	s0,32(sp)
ffffffffc02034ea:	e44e                	sd	s3,8(sp)
ffffffffc02034ec:	8a2a                	mv	s4,a0
ffffffffc02034ee:	84ae                	mv	s1,a1
ffffffffc02034f0:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02034f2:	100027f3          	csrr	a5,sstatus
ffffffffc02034f6:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc02034f8:	000db997          	auipc	s3,0xdb
ffffffffc02034fc:	5d898993          	addi	s3,s3,1496 # ffffffffc02dead0 <pmm_manager>
ffffffffc0203500:	ef8d                	bnez	a5,ffffffffc020353a <pgdir_alloc_page+0x5c>
ffffffffc0203502:	0009b783          	ld	a5,0(s3)
ffffffffc0203506:	4505                	li	a0,1
ffffffffc0203508:	6f9c                	ld	a5,24(a5)
ffffffffc020350a:	9782                	jalr	a5
ffffffffc020350c:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc020350e:	cc09                	beqz	s0,ffffffffc0203528 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc0203510:	86ca                	mv	a3,s2
ffffffffc0203512:	8626                	mv	a2,s1
ffffffffc0203514:	85a2                	mv	a1,s0
ffffffffc0203516:	8552                	mv	a0,s4
ffffffffc0203518:	830ff0ef          	jal	ra,ffffffffc0202548 <page_insert>
ffffffffc020351c:	e915                	bnez	a0,ffffffffc0203550 <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc020351e:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc0203520:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc0203522:	4785                	li	a5,1
ffffffffc0203524:	04f71e63          	bne	a4,a5,ffffffffc0203580 <pgdir_alloc_page+0xa2>
}
ffffffffc0203528:	70a2                	ld	ra,40(sp)
ffffffffc020352a:	8522                	mv	a0,s0
ffffffffc020352c:	7402                	ld	s0,32(sp)
ffffffffc020352e:	64e2                	ld	s1,24(sp)
ffffffffc0203530:	6942                	ld	s2,16(sp)
ffffffffc0203532:	69a2                	ld	s3,8(sp)
ffffffffc0203534:	6a02                	ld	s4,0(sp)
ffffffffc0203536:	6145                	addi	sp,sp,48
ffffffffc0203538:	8082                	ret
        intr_disable();
ffffffffc020353a:	c74fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc020353e:	0009b783          	ld	a5,0(s3)
ffffffffc0203542:	4505                	li	a0,1
ffffffffc0203544:	6f9c                	ld	a5,24(a5)
ffffffffc0203546:	9782                	jalr	a5
ffffffffc0203548:	842a                	mv	s0,a0
        intr_enable();
ffffffffc020354a:	c5efd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020354e:	b7c1                	j	ffffffffc020350e <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203550:	100027f3          	csrr	a5,sstatus
ffffffffc0203554:	8b89                	andi	a5,a5,2
ffffffffc0203556:	eb89                	bnez	a5,ffffffffc0203568 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc0203558:	0009b783          	ld	a5,0(s3)
ffffffffc020355c:	8522                	mv	a0,s0
ffffffffc020355e:	4585                	li	a1,1
ffffffffc0203560:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203562:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203564:	9782                	jalr	a5
    if (flag)
ffffffffc0203566:	b7c9                	j	ffffffffc0203528 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc0203568:	c46fd0ef          	jal	ra,ffffffffc02009ae <intr_disable>
ffffffffc020356c:	0009b783          	ld	a5,0(s3)
ffffffffc0203570:	8522                	mv	a0,s0
ffffffffc0203572:	4585                	li	a1,1
ffffffffc0203574:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203576:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203578:	9782                	jalr	a5
        intr_enable();
ffffffffc020357a:	c2efd0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020357e:	b76d                	j	ffffffffc0203528 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc0203580:	00004697          	auipc	a3,0x4
ffffffffc0203584:	8d068693          	addi	a3,a3,-1840 # ffffffffc0206e50 <default_pmm_manager+0x770>
ffffffffc0203588:	00003617          	auipc	a2,0x3
ffffffffc020358c:	da860613          	addi	a2,a2,-600 # ffffffffc0206330 <commands+0x828>
ffffffffc0203590:	1ef00593          	li	a1,495
ffffffffc0203594:	00003517          	auipc	a0,0x3
ffffffffc0203598:	29c50513          	addi	a0,a0,668 # ffffffffc0206830 <default_pmm_manager+0x150>
ffffffffc020359c:	ef7fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02035a0 <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02035a0:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc02035a2:	00004697          	auipc	a3,0x4
ffffffffc02035a6:	8c668693          	addi	a3,a3,-1850 # ffffffffc0206e68 <default_pmm_manager+0x788>
ffffffffc02035aa:	00003617          	auipc	a2,0x3
ffffffffc02035ae:	d8660613          	addi	a2,a2,-634 # ffffffffc0206330 <commands+0x828>
ffffffffc02035b2:	07400593          	li	a1,116
ffffffffc02035b6:	00004517          	auipc	a0,0x4
ffffffffc02035ba:	8d250513          	addi	a0,a0,-1838 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02035be:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc02035c0:	ed3fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02035c4 <mm_create>:
{
ffffffffc02035c4:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02035c6:	04000513          	li	a0,64
{
ffffffffc02035ca:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02035cc:	df6fe0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
    if (mm != NULL)
ffffffffc02035d0:	cd19                	beqz	a0,ffffffffc02035ee <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc02035d2:	e508                	sd	a0,8(a0)
ffffffffc02035d4:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc02035d6:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc02035da:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc02035de:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02035e2:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc02035e6:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc02035ea:	02053c23          	sd	zero,56(a0)
}
ffffffffc02035ee:	60a2                	ld	ra,8(sp)
ffffffffc02035f0:	0141                	addi	sp,sp,16
ffffffffc02035f2:	8082                	ret

ffffffffc02035f4 <find_vma>:
{
ffffffffc02035f4:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc02035f6:	c505                	beqz	a0,ffffffffc020361e <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc02035f8:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc02035fa:	c501                	beqz	a0,ffffffffc0203602 <find_vma+0xe>
ffffffffc02035fc:	651c                	ld	a5,8(a0)
ffffffffc02035fe:	02f5f263          	bgeu	a1,a5,ffffffffc0203622 <find_vma+0x2e>
    return listelm->next;
ffffffffc0203602:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc0203604:	00f68d63          	beq	a3,a5,ffffffffc020361e <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0203608:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_obj___user_sched_test_out_size+0x1f2b10>
ffffffffc020360c:	00e5e663          	bltu	a1,a4,ffffffffc0203618 <find_vma+0x24>
ffffffffc0203610:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203614:	00e5ec63          	bltu	a1,a4,ffffffffc020362c <find_vma+0x38>
ffffffffc0203618:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc020361a:	fef697e3          	bne	a3,a5,ffffffffc0203608 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc020361e:	4501                	li	a0,0
}
ffffffffc0203620:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0203622:	691c                	ld	a5,16(a0)
ffffffffc0203624:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203602 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0203628:	ea88                	sd	a0,16(a3)
ffffffffc020362a:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc020362c:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0203630:	ea88                	sd	a0,16(a3)
ffffffffc0203632:	8082                	ret

ffffffffc0203634 <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203634:	6590                	ld	a2,8(a1)
ffffffffc0203636:	0105b803          	ld	a6,16(a1) # 80010 <_binary_obj___user_sched_test_out_size+0x72b38>
{
ffffffffc020363a:	1141                	addi	sp,sp,-16
ffffffffc020363c:	e406                	sd	ra,8(sp)
ffffffffc020363e:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203640:	01066763          	bltu	a2,a6,ffffffffc020364e <insert_vma_struct+0x1a>
ffffffffc0203644:	a085                	j	ffffffffc02036a4 <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc0203646:	fe87b703          	ld	a4,-24(a5)
ffffffffc020364a:	04e66863          	bltu	a2,a4,ffffffffc020369a <insert_vma_struct+0x66>
ffffffffc020364e:	86be                	mv	a3,a5
ffffffffc0203650:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc0203652:	fef51ae3          	bne	a0,a5,ffffffffc0203646 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc0203656:	02a68463          	beq	a3,a0,ffffffffc020367e <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc020365a:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc020365e:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203662:	08e8f163          	bgeu	a7,a4,ffffffffc02036e4 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203666:	04e66f63          	bltu	a2,a4,ffffffffc02036c4 <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc020366a:	00f50a63          	beq	a0,a5,ffffffffc020367e <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc020366e:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203672:	05076963          	bltu	a4,a6,ffffffffc02036c4 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0203676:	ff07b603          	ld	a2,-16(a5)
ffffffffc020367a:	02c77363          	bgeu	a4,a2,ffffffffc02036a0 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc020367e:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0203680:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0203682:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0203686:	e390                	sd	a2,0(a5)
ffffffffc0203688:	e690                	sd	a2,8(a3)
}
ffffffffc020368a:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc020368c:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc020368e:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc0203690:	0017079b          	addiw	a5,a4,1
ffffffffc0203694:	d11c                	sw	a5,32(a0)
}
ffffffffc0203696:	0141                	addi	sp,sp,16
ffffffffc0203698:	8082                	ret
    if (le_prev != list)
ffffffffc020369a:	fca690e3          	bne	a3,a0,ffffffffc020365a <insert_vma_struct+0x26>
ffffffffc020369e:	bfd1                	j	ffffffffc0203672 <insert_vma_struct+0x3e>
ffffffffc02036a0:	f01ff0ef          	jal	ra,ffffffffc02035a0 <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc02036a4:	00003697          	auipc	a3,0x3
ffffffffc02036a8:	7f468693          	addi	a3,a3,2036 # ffffffffc0206e98 <default_pmm_manager+0x7b8>
ffffffffc02036ac:	00003617          	auipc	a2,0x3
ffffffffc02036b0:	c8460613          	addi	a2,a2,-892 # ffffffffc0206330 <commands+0x828>
ffffffffc02036b4:	07a00593          	li	a1,122
ffffffffc02036b8:	00003517          	auipc	a0,0x3
ffffffffc02036bc:	7d050513          	addi	a0,a0,2000 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc02036c0:	dd3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02036c4:	00004697          	auipc	a3,0x4
ffffffffc02036c8:	81468693          	addi	a3,a3,-2028 # ffffffffc0206ed8 <default_pmm_manager+0x7f8>
ffffffffc02036cc:	00003617          	auipc	a2,0x3
ffffffffc02036d0:	c6460613          	addi	a2,a2,-924 # ffffffffc0206330 <commands+0x828>
ffffffffc02036d4:	07300593          	li	a1,115
ffffffffc02036d8:	00003517          	auipc	a0,0x3
ffffffffc02036dc:	7b050513          	addi	a0,a0,1968 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc02036e0:	db3fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc02036e4:	00003697          	auipc	a3,0x3
ffffffffc02036e8:	7d468693          	addi	a3,a3,2004 # ffffffffc0206eb8 <default_pmm_manager+0x7d8>
ffffffffc02036ec:	00003617          	auipc	a2,0x3
ffffffffc02036f0:	c4460613          	addi	a2,a2,-956 # ffffffffc0206330 <commands+0x828>
ffffffffc02036f4:	07200593          	li	a1,114
ffffffffc02036f8:	00003517          	auipc	a0,0x3
ffffffffc02036fc:	79050513          	addi	a0,a0,1936 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203700:	d93fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203704 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc0203704:	591c                	lw	a5,48(a0)
{
ffffffffc0203706:	1141                	addi	sp,sp,-16
ffffffffc0203708:	e406                	sd	ra,8(sp)
ffffffffc020370a:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc020370c:	e78d                	bnez	a5,ffffffffc0203736 <mm_destroy+0x32>
ffffffffc020370e:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0203710:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc0203712:	00a40c63          	beq	s0,a0,ffffffffc020372a <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203716:	6118                	ld	a4,0(a0)
ffffffffc0203718:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc020371a:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc020371c:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc020371e:	e398                	sd	a4,0(a5)
ffffffffc0203720:	d52fe0ef          	jal	ra,ffffffffc0201c72 <kfree>
    return listelm->next;
ffffffffc0203724:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc0203726:	fea418e3          	bne	s0,a0,ffffffffc0203716 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc020372a:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc020372c:	6402                	ld	s0,0(sp)
ffffffffc020372e:	60a2                	ld	ra,8(sp)
ffffffffc0203730:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc0203732:	d40fe06f          	j	ffffffffc0201c72 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0203736:	00003697          	auipc	a3,0x3
ffffffffc020373a:	7c268693          	addi	a3,a3,1986 # ffffffffc0206ef8 <default_pmm_manager+0x818>
ffffffffc020373e:	00003617          	auipc	a2,0x3
ffffffffc0203742:	bf260613          	addi	a2,a2,-1038 # ffffffffc0206330 <commands+0x828>
ffffffffc0203746:	09e00593          	li	a1,158
ffffffffc020374a:	00003517          	auipc	a0,0x3
ffffffffc020374e:	73e50513          	addi	a0,a0,1854 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203752:	d41fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203756 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc0203756:	7139                	addi	sp,sp,-64
ffffffffc0203758:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc020375a:	6405                	lui	s0,0x1
ffffffffc020375c:	147d                	addi	s0,s0,-1
ffffffffc020375e:	77fd                	lui	a5,0xfffff
ffffffffc0203760:	9622                	add	a2,a2,s0
ffffffffc0203762:	962e                	add	a2,a2,a1
{
ffffffffc0203764:	f426                	sd	s1,40(sp)
ffffffffc0203766:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0203768:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc020376c:	f04a                	sd	s2,32(sp)
ffffffffc020376e:	ec4e                	sd	s3,24(sp)
ffffffffc0203770:	e852                	sd	s4,16(sp)
ffffffffc0203772:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc0203774:	002005b7          	lui	a1,0x200
ffffffffc0203778:	00f67433          	and	s0,a2,a5
ffffffffc020377c:	06b4e363          	bltu	s1,a1,ffffffffc02037e2 <mm_map+0x8c>
ffffffffc0203780:	0684f163          	bgeu	s1,s0,ffffffffc02037e2 <mm_map+0x8c>
ffffffffc0203784:	4785                	li	a5,1
ffffffffc0203786:	07fe                	slli	a5,a5,0x1f
ffffffffc0203788:	0487ed63          	bltu	a5,s0,ffffffffc02037e2 <mm_map+0x8c>
ffffffffc020378c:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc020378e:	cd21                	beqz	a0,ffffffffc02037e6 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc0203790:	85a6                	mv	a1,s1
ffffffffc0203792:	8ab6                	mv	s5,a3
ffffffffc0203794:	8a3a                	mv	s4,a4
ffffffffc0203796:	e5fff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
ffffffffc020379a:	c501                	beqz	a0,ffffffffc02037a2 <mm_map+0x4c>
ffffffffc020379c:	651c                	ld	a5,8(a0)
ffffffffc020379e:	0487e263          	bltu	a5,s0,ffffffffc02037e2 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02037a2:	03000513          	li	a0,48
ffffffffc02037a6:	c1cfe0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
ffffffffc02037aa:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc02037ac:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc02037ae:	02090163          	beqz	s2,ffffffffc02037d0 <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc02037b2:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc02037b4:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc02037b8:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc02037bc:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc02037c0:	85ca                	mv	a1,s2
ffffffffc02037c2:	e73ff0ef          	jal	ra,ffffffffc0203634 <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc02037c6:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc02037c8:	000a0463          	beqz	s4,ffffffffc02037d0 <mm_map+0x7a>
        *vma_store = vma;
ffffffffc02037cc:	012a3023          	sd	s2,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>

out:
    return ret;
}
ffffffffc02037d0:	70e2                	ld	ra,56(sp)
ffffffffc02037d2:	7442                	ld	s0,48(sp)
ffffffffc02037d4:	74a2                	ld	s1,40(sp)
ffffffffc02037d6:	7902                	ld	s2,32(sp)
ffffffffc02037d8:	69e2                	ld	s3,24(sp)
ffffffffc02037da:	6a42                	ld	s4,16(sp)
ffffffffc02037dc:	6aa2                	ld	s5,8(sp)
ffffffffc02037de:	6121                	addi	sp,sp,64
ffffffffc02037e0:	8082                	ret
        return -E_INVAL;
ffffffffc02037e2:	5575                	li	a0,-3
ffffffffc02037e4:	b7f5                	j	ffffffffc02037d0 <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc02037e6:	00003697          	auipc	a3,0x3
ffffffffc02037ea:	72a68693          	addi	a3,a3,1834 # ffffffffc0206f10 <default_pmm_manager+0x830>
ffffffffc02037ee:	00003617          	auipc	a2,0x3
ffffffffc02037f2:	b4260613          	addi	a2,a2,-1214 # ffffffffc0206330 <commands+0x828>
ffffffffc02037f6:	0b300593          	li	a1,179
ffffffffc02037fa:	00003517          	auipc	a0,0x3
ffffffffc02037fe:	68e50513          	addi	a0,a0,1678 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203802:	c91fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203806 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc0203806:	7139                	addi	sp,sp,-64
ffffffffc0203808:	fc06                	sd	ra,56(sp)
ffffffffc020380a:	f822                	sd	s0,48(sp)
ffffffffc020380c:	f426                	sd	s1,40(sp)
ffffffffc020380e:	f04a                	sd	s2,32(sp)
ffffffffc0203810:	ec4e                	sd	s3,24(sp)
ffffffffc0203812:	e852                	sd	s4,16(sp)
ffffffffc0203814:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0203816:	c52d                	beqz	a0,ffffffffc0203880 <dup_mmap+0x7a>
ffffffffc0203818:	892a                	mv	s2,a0
ffffffffc020381a:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc020381c:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc020381e:	e595                	bnez	a1,ffffffffc020384a <dup_mmap+0x44>
ffffffffc0203820:	a085                	j	ffffffffc0203880 <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0203822:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0203824:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_sched_test_out_size+0x1f2b30>
        vma->vm_end = vm_end;
ffffffffc0203828:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc020382c:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0203830:	e05ff0ef          	jal	ra,ffffffffc0203634 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc0203834:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8f48>
ffffffffc0203838:	fe843603          	ld	a2,-24(s0)
ffffffffc020383c:	6c8c                	ld	a1,24(s1)
ffffffffc020383e:	01893503          	ld	a0,24(s2)
ffffffffc0203842:	4701                	li	a4,0
ffffffffc0203844:	a3bff0ef          	jal	ra,ffffffffc020327e <copy_range>
ffffffffc0203848:	e105                	bnez	a0,ffffffffc0203868 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc020384a:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc020384c:	02848863          	beq	s1,s0,ffffffffc020387c <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203850:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0203854:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203858:	ff043a03          	ld	s4,-16(s0)
ffffffffc020385c:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203860:	b62fe0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
ffffffffc0203864:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc0203866:	fd55                	bnez	a0,ffffffffc0203822 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0203868:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc020386a:	70e2                	ld	ra,56(sp)
ffffffffc020386c:	7442                	ld	s0,48(sp)
ffffffffc020386e:	74a2                	ld	s1,40(sp)
ffffffffc0203870:	7902                	ld	s2,32(sp)
ffffffffc0203872:	69e2                	ld	s3,24(sp)
ffffffffc0203874:	6a42                	ld	s4,16(sp)
ffffffffc0203876:	6aa2                	ld	s5,8(sp)
ffffffffc0203878:	6121                	addi	sp,sp,64
ffffffffc020387a:	8082                	ret
    return 0;
ffffffffc020387c:	4501                	li	a0,0
ffffffffc020387e:	b7f5                	j	ffffffffc020386a <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0203880:	00003697          	auipc	a3,0x3
ffffffffc0203884:	6a068693          	addi	a3,a3,1696 # ffffffffc0206f20 <default_pmm_manager+0x840>
ffffffffc0203888:	00003617          	auipc	a2,0x3
ffffffffc020388c:	aa860613          	addi	a2,a2,-1368 # ffffffffc0206330 <commands+0x828>
ffffffffc0203890:	0cf00593          	li	a1,207
ffffffffc0203894:	00003517          	auipc	a0,0x3
ffffffffc0203898:	5f450513          	addi	a0,a0,1524 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc020389c:	bf7fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02038a0 <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc02038a0:	1101                	addi	sp,sp,-32
ffffffffc02038a2:	ec06                	sd	ra,24(sp)
ffffffffc02038a4:	e822                	sd	s0,16(sp)
ffffffffc02038a6:	e426                	sd	s1,8(sp)
ffffffffc02038a8:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02038aa:	c531                	beqz	a0,ffffffffc02038f6 <exit_mmap+0x56>
ffffffffc02038ac:	591c                	lw	a5,48(a0)
ffffffffc02038ae:	84aa                	mv	s1,a0
ffffffffc02038b0:	e3b9                	bnez	a5,ffffffffc02038f6 <exit_mmap+0x56>
    return listelm->next;
ffffffffc02038b2:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc02038b4:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc02038b8:	02850663          	beq	a0,s0,ffffffffc02038e4 <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02038bc:	ff043603          	ld	a2,-16(s0)
ffffffffc02038c0:	fe843583          	ld	a1,-24(s0)
ffffffffc02038c4:	854a                	mv	a0,s2
ffffffffc02038c6:	80ffe0ef          	jal	ra,ffffffffc02020d4 <unmap_range>
ffffffffc02038ca:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02038cc:	fe8498e3          	bne	s1,s0,ffffffffc02038bc <exit_mmap+0x1c>
ffffffffc02038d0:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc02038d2:	00848c63          	beq	s1,s0,ffffffffc02038ea <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02038d6:	ff043603          	ld	a2,-16(s0)
ffffffffc02038da:	fe843583          	ld	a1,-24(s0)
ffffffffc02038de:	854a                	mv	a0,s2
ffffffffc02038e0:	93bfe0ef          	jal	ra,ffffffffc020221a <exit_range>
ffffffffc02038e4:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02038e6:	fe8498e3          	bne	s1,s0,ffffffffc02038d6 <exit_mmap+0x36>
    }
}
ffffffffc02038ea:	60e2                	ld	ra,24(sp)
ffffffffc02038ec:	6442                	ld	s0,16(sp)
ffffffffc02038ee:	64a2                	ld	s1,8(sp)
ffffffffc02038f0:	6902                	ld	s2,0(sp)
ffffffffc02038f2:	6105                	addi	sp,sp,32
ffffffffc02038f4:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02038f6:	00003697          	auipc	a3,0x3
ffffffffc02038fa:	64a68693          	addi	a3,a3,1610 # ffffffffc0206f40 <default_pmm_manager+0x860>
ffffffffc02038fe:	00003617          	auipc	a2,0x3
ffffffffc0203902:	a3260613          	addi	a2,a2,-1486 # ffffffffc0206330 <commands+0x828>
ffffffffc0203906:	0e800593          	li	a1,232
ffffffffc020390a:	00003517          	auipc	a0,0x3
ffffffffc020390e:	57e50513          	addi	a0,a0,1406 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203912:	b81fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203916 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0203916:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203918:	04000513          	li	a0,64
{
ffffffffc020391c:	fc06                	sd	ra,56(sp)
ffffffffc020391e:	f822                	sd	s0,48(sp)
ffffffffc0203920:	f426                	sd	s1,40(sp)
ffffffffc0203922:	f04a                	sd	s2,32(sp)
ffffffffc0203924:	ec4e                	sd	s3,24(sp)
ffffffffc0203926:	e852                	sd	s4,16(sp)
ffffffffc0203928:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc020392a:	a98fe0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
    if (mm != NULL)
ffffffffc020392e:	2e050663          	beqz	a0,ffffffffc0203c1a <vmm_init+0x304>
ffffffffc0203932:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc0203934:	e508                	sd	a0,8(a0)
ffffffffc0203936:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203938:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc020393c:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203940:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc0203944:	02053423          	sd	zero,40(a0)
ffffffffc0203948:	02052823          	sw	zero,48(a0)
ffffffffc020394c:	02053c23          	sd	zero,56(a0)
ffffffffc0203950:	03200413          	li	s0,50
ffffffffc0203954:	a811                	j	ffffffffc0203968 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc0203956:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203958:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc020395a:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc020395e:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203960:	8526                	mv	a0,s1
ffffffffc0203962:	cd3ff0ef          	jal	ra,ffffffffc0203634 <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc0203966:	c80d                	beqz	s0,ffffffffc0203998 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203968:	03000513          	li	a0,48
ffffffffc020396c:	a56fe0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
ffffffffc0203970:	85aa                	mv	a1,a0
ffffffffc0203972:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203976:	f165                	bnez	a0,ffffffffc0203956 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc0203978:	00003697          	auipc	a3,0x3
ffffffffc020397c:	76068693          	addi	a3,a3,1888 # ffffffffc02070d8 <default_pmm_manager+0x9f8>
ffffffffc0203980:	00003617          	auipc	a2,0x3
ffffffffc0203984:	9b060613          	addi	a2,a2,-1616 # ffffffffc0206330 <commands+0x828>
ffffffffc0203988:	12c00593          	li	a1,300
ffffffffc020398c:	00003517          	auipc	a0,0x3
ffffffffc0203990:	4fc50513          	addi	a0,a0,1276 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203994:	afffc0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0203998:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc020399c:	1f900913          	li	s2,505
ffffffffc02039a0:	a819                	j	ffffffffc02039b6 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc02039a2:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc02039a4:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc02039a6:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc02039aa:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc02039ac:	8526                	mv	a0,s1
ffffffffc02039ae:	c87ff0ef          	jal	ra,ffffffffc0203634 <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc02039b2:	03240a63          	beq	s0,s2,ffffffffc02039e6 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02039b6:	03000513          	li	a0,48
ffffffffc02039ba:	a08fe0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
ffffffffc02039be:	85aa                	mv	a1,a0
ffffffffc02039c0:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc02039c4:	fd79                	bnez	a0,ffffffffc02039a2 <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc02039c6:	00003697          	auipc	a3,0x3
ffffffffc02039ca:	71268693          	addi	a3,a3,1810 # ffffffffc02070d8 <default_pmm_manager+0x9f8>
ffffffffc02039ce:	00003617          	auipc	a2,0x3
ffffffffc02039d2:	96260613          	addi	a2,a2,-1694 # ffffffffc0206330 <commands+0x828>
ffffffffc02039d6:	13300593          	li	a1,307
ffffffffc02039da:	00003517          	auipc	a0,0x3
ffffffffc02039de:	4ae50513          	addi	a0,a0,1198 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc02039e2:	ab1fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return listelm->next;
ffffffffc02039e6:	649c                	ld	a5,8(s1)
ffffffffc02039e8:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc02039ea:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc02039ee:	16f48663          	beq	s1,a5,ffffffffc0203b5a <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc02039f2:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd204d8>
ffffffffc02039f6:	ffe70693          	addi	a3,a4,-2
ffffffffc02039fa:	10d61063          	bne	a2,a3,ffffffffc0203afa <vmm_init+0x1e4>
ffffffffc02039fe:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203a02:	0ed71c63          	bne	a4,a3,ffffffffc0203afa <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203a06:	0715                	addi	a4,a4,5
ffffffffc0203a08:	679c                	ld	a5,8(a5)
ffffffffc0203a0a:	feb712e3          	bne	a4,a1,ffffffffc02039ee <vmm_init+0xd8>
ffffffffc0203a0e:	4a1d                	li	s4,7
ffffffffc0203a10:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203a12:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203a16:	85a2                	mv	a1,s0
ffffffffc0203a18:	8526                	mv	a0,s1
ffffffffc0203a1a:	bdbff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
ffffffffc0203a1e:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203a20:	16050d63          	beqz	a0,ffffffffc0203b9a <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203a24:	00140593          	addi	a1,s0,1
ffffffffc0203a28:	8526                	mv	a0,s1
ffffffffc0203a2a:	bcbff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
ffffffffc0203a2e:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203a30:	14050563          	beqz	a0,ffffffffc0203b7a <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203a34:	85d2                	mv	a1,s4
ffffffffc0203a36:	8526                	mv	a0,s1
ffffffffc0203a38:	bbdff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
        assert(vma3 == NULL);
ffffffffc0203a3c:	16051f63          	bnez	a0,ffffffffc0203bba <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203a40:	00340593          	addi	a1,s0,3
ffffffffc0203a44:	8526                	mv	a0,s1
ffffffffc0203a46:	bafff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
        assert(vma4 == NULL);
ffffffffc0203a4a:	1a051863          	bnez	a0,ffffffffc0203bfa <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203a4e:	00440593          	addi	a1,s0,4
ffffffffc0203a52:	8526                	mv	a0,s1
ffffffffc0203a54:	ba1ff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
        assert(vma5 == NULL);
ffffffffc0203a58:	18051163          	bnez	a0,ffffffffc0203bda <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203a5c:	00893783          	ld	a5,8(s2)
ffffffffc0203a60:	0a879d63          	bne	a5,s0,ffffffffc0203b1a <vmm_init+0x204>
ffffffffc0203a64:	01093783          	ld	a5,16(s2)
ffffffffc0203a68:	0b479963          	bne	a5,s4,ffffffffc0203b1a <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203a6c:	0089b783          	ld	a5,8(s3)
ffffffffc0203a70:	0c879563          	bne	a5,s0,ffffffffc0203b3a <vmm_init+0x224>
ffffffffc0203a74:	0109b783          	ld	a5,16(s3)
ffffffffc0203a78:	0d479163          	bne	a5,s4,ffffffffc0203b3a <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203a7c:	0415                	addi	s0,s0,5
ffffffffc0203a7e:	0a15                	addi	s4,s4,5
ffffffffc0203a80:	f9541be3          	bne	s0,s5,ffffffffc0203a16 <vmm_init+0x100>
ffffffffc0203a84:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203a86:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203a88:	85a2                	mv	a1,s0
ffffffffc0203a8a:	8526                	mv	a0,s1
ffffffffc0203a8c:	b69ff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
ffffffffc0203a90:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203a94:	c90d                	beqz	a0,ffffffffc0203ac6 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203a96:	6914                	ld	a3,16(a0)
ffffffffc0203a98:	6510                	ld	a2,8(a0)
ffffffffc0203a9a:	00003517          	auipc	a0,0x3
ffffffffc0203a9e:	5c650513          	addi	a0,a0,1478 # ffffffffc0207060 <default_pmm_manager+0x980>
ffffffffc0203aa2:	ef6fc0ef          	jal	ra,ffffffffc0200198 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203aa6:	00003697          	auipc	a3,0x3
ffffffffc0203aaa:	5e268693          	addi	a3,a3,1506 # ffffffffc0207088 <default_pmm_manager+0x9a8>
ffffffffc0203aae:	00003617          	auipc	a2,0x3
ffffffffc0203ab2:	88260613          	addi	a2,a2,-1918 # ffffffffc0206330 <commands+0x828>
ffffffffc0203ab6:	15900593          	li	a1,345
ffffffffc0203aba:	00003517          	auipc	a0,0x3
ffffffffc0203abe:	3ce50513          	addi	a0,a0,974 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203ac2:	9d1fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203ac6:	147d                	addi	s0,s0,-1
ffffffffc0203ac8:	fd2410e3          	bne	s0,s2,ffffffffc0203a88 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203acc:	8526                	mv	a0,s1
ffffffffc0203ace:	c37ff0ef          	jal	ra,ffffffffc0203704 <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203ad2:	00003517          	auipc	a0,0x3
ffffffffc0203ad6:	5ce50513          	addi	a0,a0,1486 # ffffffffc02070a0 <default_pmm_manager+0x9c0>
ffffffffc0203ada:	ebefc0ef          	jal	ra,ffffffffc0200198 <cprintf>
}
ffffffffc0203ade:	7442                	ld	s0,48(sp)
ffffffffc0203ae0:	70e2                	ld	ra,56(sp)
ffffffffc0203ae2:	74a2                	ld	s1,40(sp)
ffffffffc0203ae4:	7902                	ld	s2,32(sp)
ffffffffc0203ae6:	69e2                	ld	s3,24(sp)
ffffffffc0203ae8:	6a42                	ld	s4,16(sp)
ffffffffc0203aea:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203aec:	00003517          	auipc	a0,0x3
ffffffffc0203af0:	5d450513          	addi	a0,a0,1492 # ffffffffc02070c0 <default_pmm_manager+0x9e0>
}
ffffffffc0203af4:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203af6:	ea2fc06f          	j	ffffffffc0200198 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203afa:	00003697          	auipc	a3,0x3
ffffffffc0203afe:	47e68693          	addi	a3,a3,1150 # ffffffffc0206f78 <default_pmm_manager+0x898>
ffffffffc0203b02:	00003617          	auipc	a2,0x3
ffffffffc0203b06:	82e60613          	addi	a2,a2,-2002 # ffffffffc0206330 <commands+0x828>
ffffffffc0203b0a:	13d00593          	li	a1,317
ffffffffc0203b0e:	00003517          	auipc	a0,0x3
ffffffffc0203b12:	37a50513          	addi	a0,a0,890 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203b16:	97dfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b1a:	00003697          	auipc	a3,0x3
ffffffffc0203b1e:	4e668693          	addi	a3,a3,1254 # ffffffffc0207000 <default_pmm_manager+0x920>
ffffffffc0203b22:	00003617          	auipc	a2,0x3
ffffffffc0203b26:	80e60613          	addi	a2,a2,-2034 # ffffffffc0206330 <commands+0x828>
ffffffffc0203b2a:	14e00593          	li	a1,334
ffffffffc0203b2e:	00003517          	auipc	a0,0x3
ffffffffc0203b32:	35a50513          	addi	a0,a0,858 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203b36:	95dfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203b3a:	00003697          	auipc	a3,0x3
ffffffffc0203b3e:	4f668693          	addi	a3,a3,1270 # ffffffffc0207030 <default_pmm_manager+0x950>
ffffffffc0203b42:	00002617          	auipc	a2,0x2
ffffffffc0203b46:	7ee60613          	addi	a2,a2,2030 # ffffffffc0206330 <commands+0x828>
ffffffffc0203b4a:	14f00593          	li	a1,335
ffffffffc0203b4e:	00003517          	auipc	a0,0x3
ffffffffc0203b52:	33a50513          	addi	a0,a0,826 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203b56:	93dfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203b5a:	00003697          	auipc	a3,0x3
ffffffffc0203b5e:	40668693          	addi	a3,a3,1030 # ffffffffc0206f60 <default_pmm_manager+0x880>
ffffffffc0203b62:	00002617          	auipc	a2,0x2
ffffffffc0203b66:	7ce60613          	addi	a2,a2,1998 # ffffffffc0206330 <commands+0x828>
ffffffffc0203b6a:	13b00593          	li	a1,315
ffffffffc0203b6e:	00003517          	auipc	a0,0x3
ffffffffc0203b72:	31a50513          	addi	a0,a0,794 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203b76:	91dfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma2 != NULL);
ffffffffc0203b7a:	00003697          	auipc	a3,0x3
ffffffffc0203b7e:	44668693          	addi	a3,a3,1094 # ffffffffc0206fc0 <default_pmm_manager+0x8e0>
ffffffffc0203b82:	00002617          	auipc	a2,0x2
ffffffffc0203b86:	7ae60613          	addi	a2,a2,1966 # ffffffffc0206330 <commands+0x828>
ffffffffc0203b8a:	14600593          	li	a1,326
ffffffffc0203b8e:	00003517          	auipc	a0,0x3
ffffffffc0203b92:	2fa50513          	addi	a0,a0,762 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203b96:	8fdfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma1 != NULL);
ffffffffc0203b9a:	00003697          	auipc	a3,0x3
ffffffffc0203b9e:	41668693          	addi	a3,a3,1046 # ffffffffc0206fb0 <default_pmm_manager+0x8d0>
ffffffffc0203ba2:	00002617          	auipc	a2,0x2
ffffffffc0203ba6:	78e60613          	addi	a2,a2,1934 # ffffffffc0206330 <commands+0x828>
ffffffffc0203baa:	14400593          	li	a1,324
ffffffffc0203bae:	00003517          	auipc	a0,0x3
ffffffffc0203bb2:	2da50513          	addi	a0,a0,730 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203bb6:	8ddfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma3 == NULL);
ffffffffc0203bba:	00003697          	auipc	a3,0x3
ffffffffc0203bbe:	41668693          	addi	a3,a3,1046 # ffffffffc0206fd0 <default_pmm_manager+0x8f0>
ffffffffc0203bc2:	00002617          	auipc	a2,0x2
ffffffffc0203bc6:	76e60613          	addi	a2,a2,1902 # ffffffffc0206330 <commands+0x828>
ffffffffc0203bca:	14800593          	li	a1,328
ffffffffc0203bce:	00003517          	auipc	a0,0x3
ffffffffc0203bd2:	2ba50513          	addi	a0,a0,698 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203bd6:	8bdfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma5 == NULL);
ffffffffc0203bda:	00003697          	auipc	a3,0x3
ffffffffc0203bde:	41668693          	addi	a3,a3,1046 # ffffffffc0206ff0 <default_pmm_manager+0x910>
ffffffffc0203be2:	00002617          	auipc	a2,0x2
ffffffffc0203be6:	74e60613          	addi	a2,a2,1870 # ffffffffc0206330 <commands+0x828>
ffffffffc0203bea:	14c00593          	li	a1,332
ffffffffc0203bee:	00003517          	auipc	a0,0x3
ffffffffc0203bf2:	29a50513          	addi	a0,a0,666 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203bf6:	89dfc0ef          	jal	ra,ffffffffc0200492 <__panic>
        assert(vma4 == NULL);
ffffffffc0203bfa:	00003697          	auipc	a3,0x3
ffffffffc0203bfe:	3e668693          	addi	a3,a3,998 # ffffffffc0206fe0 <default_pmm_manager+0x900>
ffffffffc0203c02:	00002617          	auipc	a2,0x2
ffffffffc0203c06:	72e60613          	addi	a2,a2,1838 # ffffffffc0206330 <commands+0x828>
ffffffffc0203c0a:	14a00593          	li	a1,330
ffffffffc0203c0e:	00003517          	auipc	a0,0x3
ffffffffc0203c12:	27a50513          	addi	a0,a0,634 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203c16:	87dfc0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(mm != NULL);
ffffffffc0203c1a:	00003697          	auipc	a3,0x3
ffffffffc0203c1e:	2f668693          	addi	a3,a3,758 # ffffffffc0206f10 <default_pmm_manager+0x830>
ffffffffc0203c22:	00002617          	auipc	a2,0x2
ffffffffc0203c26:	70e60613          	addi	a2,a2,1806 # ffffffffc0206330 <commands+0x828>
ffffffffc0203c2a:	12400593          	li	a1,292
ffffffffc0203c2e:	00003517          	auipc	a0,0x3
ffffffffc0203c32:	25a50513          	addi	a0,a0,602 # ffffffffc0206e88 <default_pmm_manager+0x7a8>
ffffffffc0203c36:	85dfc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203c3a <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203c3a:	7179                	addi	sp,sp,-48
ffffffffc0203c3c:	f022                	sd	s0,32(sp)
ffffffffc0203c3e:	f406                	sd	ra,40(sp)
ffffffffc0203c40:	ec26                	sd	s1,24(sp)
ffffffffc0203c42:	e84a                	sd	s2,16(sp)
ffffffffc0203c44:	e44e                	sd	s3,8(sp)
ffffffffc0203c46:	e052                	sd	s4,0(sp)
ffffffffc0203c48:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203c4a:	c135                	beqz	a0,ffffffffc0203cae <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203c4c:	002007b7          	lui	a5,0x200
ffffffffc0203c50:	04f5e663          	bltu	a1,a5,ffffffffc0203c9c <user_mem_check+0x62>
ffffffffc0203c54:	00c584b3          	add	s1,a1,a2
ffffffffc0203c58:	0495f263          	bgeu	a1,s1,ffffffffc0203c9c <user_mem_check+0x62>
ffffffffc0203c5c:	4785                	li	a5,1
ffffffffc0203c5e:	07fe                	slli	a5,a5,0x1f
ffffffffc0203c60:	0297ee63          	bltu	a5,s1,ffffffffc0203c9c <user_mem_check+0x62>
ffffffffc0203c64:	892a                	mv	s2,a0
ffffffffc0203c66:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203c68:	6a05                	lui	s4,0x1
ffffffffc0203c6a:	a821                	j	ffffffffc0203c82 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203c6c:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203c70:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203c72:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203c74:	c685                	beqz	a3,ffffffffc0203c9c <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203c76:	c399                	beqz	a5,ffffffffc0203c7c <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203c78:	02e46263          	bltu	s0,a4,ffffffffc0203c9c <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203c7c:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203c7e:	04947663          	bgeu	s0,s1,ffffffffc0203cca <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203c82:	85a2                	mv	a1,s0
ffffffffc0203c84:	854a                	mv	a0,s2
ffffffffc0203c86:	96fff0ef          	jal	ra,ffffffffc02035f4 <find_vma>
ffffffffc0203c8a:	c909                	beqz	a0,ffffffffc0203c9c <user_mem_check+0x62>
ffffffffc0203c8c:	6518                	ld	a4,8(a0)
ffffffffc0203c8e:	00e46763          	bltu	s0,a4,ffffffffc0203c9c <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203c92:	4d1c                	lw	a5,24(a0)
ffffffffc0203c94:	fc099ce3          	bnez	s3,ffffffffc0203c6c <user_mem_check+0x32>
ffffffffc0203c98:	8b85                	andi	a5,a5,1
ffffffffc0203c9a:	f3ed                	bnez	a5,ffffffffc0203c7c <user_mem_check+0x42>
            return 0;
ffffffffc0203c9c:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
}
ffffffffc0203c9e:	70a2                	ld	ra,40(sp)
ffffffffc0203ca0:	7402                	ld	s0,32(sp)
ffffffffc0203ca2:	64e2                	ld	s1,24(sp)
ffffffffc0203ca4:	6942                	ld	s2,16(sp)
ffffffffc0203ca6:	69a2                	ld	s3,8(sp)
ffffffffc0203ca8:	6a02                	ld	s4,0(sp)
ffffffffc0203caa:	6145                	addi	sp,sp,48
ffffffffc0203cac:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203cae:	c02007b7          	lui	a5,0xc0200
ffffffffc0203cb2:	4501                	li	a0,0
ffffffffc0203cb4:	fef5e5e3          	bltu	a1,a5,ffffffffc0203c9e <user_mem_check+0x64>
ffffffffc0203cb8:	962e                	add	a2,a2,a1
ffffffffc0203cba:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203c9e <user_mem_check+0x64>
ffffffffc0203cbe:	c8000537          	lui	a0,0xc8000
ffffffffc0203cc2:	0505                	addi	a0,a0,1
ffffffffc0203cc4:	00a63533          	sltu	a0,a2,a0
ffffffffc0203cc8:	bfd9                	j	ffffffffc0203c9e <user_mem_check+0x64>
        return 1;
ffffffffc0203cca:	4505                	li	a0,1
ffffffffc0203ccc:	bfc9                	j	ffffffffc0203c9e <user_mem_check+0x64>

ffffffffc0203cce <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203cce:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203cd0:	9402                	jalr	s0

	jal do_exit
ffffffffc0203cd2:	5de000ef          	jal	ra,ffffffffc02042b0 <do_exit>

ffffffffc0203cd6 <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203cd6:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203cd8:	14800513          	li	a0,328
{
ffffffffc0203cdc:	e022                	sd	s0,0(sp)
ffffffffc0203cde:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203ce0:	ee3fd0ef          	jal	ra,ffffffffc0201bc2 <kmalloc>
ffffffffc0203ce4:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203ce6:	cd35                	beqz	a0,ffffffffc0203d62 <alloc_proc+0x8c>
    {
        // LAB4:填写你在lab4中实现的代码
        proc->state = PROC_UNINIT;                         // 设置进程为未初始化状态
ffffffffc0203ce8:	57fd                	li	a5,-1
ffffffffc0203cea:	1782                	slli	a5,a5,0x20
ffffffffc0203cec:	e11c                	sd	a5,0(a0)
        proc->runs = 0;                                    // 初始化运行时间为0
        proc->kstack = 0;                                  // 内核栈地址初始化为0
        proc->need_resched = 0;                            // 不需要调度
        proc->parent = NULL;                               // 父进程为空
        proc->mm = NULL;                                   // 虚拟内存管理为空
        memset(&(proc->context), 0, sizeof(struct context)); // 初始化上下文
ffffffffc0203cee:	07000613          	li	a2,112
ffffffffc0203cf2:	4581                	li	a1,0
        proc->runs = 0;                                    // 初始化运行时间为0
ffffffffc0203cf4:	00052423          	sw	zero,8(a0) # ffffffffc8000008 <end+0x7d214f8>
        proc->kstack = 0;                                  // 内核栈地址初始化为0
ffffffffc0203cf8:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;                            // 不需要调度
ffffffffc0203cfc:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;                               // 父进程为空
ffffffffc0203d00:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;                                   // 虚拟内存管理为空
ffffffffc0203d04:	02053423          	sd	zero,40(a0)
        memset(&(proc->context), 0, sizeof(struct context)); // 初始化上下文
ffffffffc0203d08:	03050513          	addi	a0,a0,48
ffffffffc0203d0c:	36b010ef          	jal	ra,ffffffffc0205876 <memset>
        proc->tf = NULL;                                   // 中断帧指针为空
        proc->pgdir = boot_pgdir_pa;                       // 页目录为内核页目录表的基址
ffffffffc0203d10:	000db797          	auipc	a5,0xdb
ffffffffc0203d14:	da07b783          	ld	a5,-608(a5) # ffffffffc02deab0 <boot_pgdir_pa>
ffffffffc0203d18:	f45c                	sd	a5,168(s0)
        proc->tf = NULL;                                   // 中断帧指针为空
ffffffffc0203d1a:	0a043023          	sd	zero,160(s0)
        proc->flags = 0;                                   // 标志位为0
ffffffffc0203d1e:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN + 1);          // 进程名初始化为0
ffffffffc0203d22:	4641                	li	a2,16
ffffffffc0203d24:	4581                	li	a1,0
ffffffffc0203d26:	0b440513          	addi	a0,s0,180
ffffffffc0203d2a:	34d010ef          	jal	ra,ffffffffc0205876 <memset>
        proc->optr = NULL;                                 // older sibling 指针为空
        proc->yptr = NULL;                                 // younger sibling 指针为空

        // LAB6:YOUR CODE (update LAB5 steps)
        proc->rq = NULL;                                   // 运行队列为空
        list_init(&(proc->run_link));                      // 初始化运行队列链表项
ffffffffc0203d2e:	11040793          	addi	a5,s0,272
        proc->wait_state = 0;                              // 初始化进程等待状态
ffffffffc0203d32:	0e042623          	sw	zero,236(s0)
        proc->cptr = NULL;                                 // 子进程指针为空
ffffffffc0203d36:	0e043823          	sd	zero,240(s0)
        proc->optr = NULL;                                 // older sibling 指针为空
ffffffffc0203d3a:	10043023          	sd	zero,256(s0)
        proc->yptr = NULL;                                 // younger sibling 指针为空
ffffffffc0203d3e:	0e043c23          	sd	zero,248(s0)
        proc->rq = NULL;                                   // 运行队列为空
ffffffffc0203d42:	10043423          	sd	zero,264(s0)
    elm->prev = elm->next = elm;
ffffffffc0203d46:	10f43c23          	sd	a5,280(s0)
ffffffffc0203d4a:	10f43823          	sd	a5,272(s0)
        proc->time_slice = 0;                              // 时间片初始化为0
ffffffffc0203d4e:	12042023          	sw	zero,288(s0)
        proc->lab6_run_pool.left = proc->lab6_run_pool.right = proc->lab6_run_pool.parent = NULL;  // 初始化斜堆节点
ffffffffc0203d52:	12043423          	sd	zero,296(s0)
ffffffffc0203d56:	12043823          	sd	zero,304(s0)
ffffffffc0203d5a:	12043c23          	sd	zero,312(s0)
        proc->lab6_stride = 0;                             // stride初始化为0
ffffffffc0203d5e:	14043023          	sd	zero,320(s0)
        proc->lab6_priority = 0;                           // 优先级初始化为0
    }
    return proc;
}
ffffffffc0203d62:	60a2                	ld	ra,8(sp)
ffffffffc0203d64:	8522                	mv	a0,s0
ffffffffc0203d66:	6402                	ld	s0,0(sp)
ffffffffc0203d68:	0141                	addi	sp,sp,16
ffffffffc0203d6a:	8082                	ret

ffffffffc0203d6c <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203d6c:	000db797          	auipc	a5,0xdb
ffffffffc0203d70:	d747b783          	ld	a5,-652(a5) # ffffffffc02deae0 <current>
ffffffffc0203d74:	73c8                	ld	a0,160(a5)
ffffffffc0203d76:	968fd06f          	j	ffffffffc0200ede <forkrets>

ffffffffc0203d7a <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203d7a:	6d14                	ld	a3,24(a0)
}

// put_pgdir - free the memory space of PDT
static void
put_pgdir(struct mm_struct *mm)
{
ffffffffc0203d7c:	1141                	addi	sp,sp,-16
ffffffffc0203d7e:	e406                	sd	ra,8(sp)
ffffffffc0203d80:	c02007b7          	lui	a5,0xc0200
ffffffffc0203d84:	02f6ee63          	bltu	a3,a5,ffffffffc0203dc0 <put_pgdir+0x46>
ffffffffc0203d88:	000db517          	auipc	a0,0xdb
ffffffffc0203d8c:	d5053503          	ld	a0,-688(a0) # ffffffffc02dead8 <va_pa_offset>
ffffffffc0203d90:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203d92:	82b1                	srli	a3,a3,0xc
ffffffffc0203d94:	000db797          	auipc	a5,0xdb
ffffffffc0203d98:	d2c7b783          	ld	a5,-724(a5) # ffffffffc02deac0 <npage>
ffffffffc0203d9c:	02f6fe63          	bgeu	a3,a5,ffffffffc0203dd8 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203da0:	00004517          	auipc	a0,0x4
ffffffffc0203da4:	41053503          	ld	a0,1040(a0) # ffffffffc02081b0 <nbase>
    free_page(kva2page(mm->pgdir));
}
ffffffffc0203da8:	60a2                	ld	ra,8(sp)
ffffffffc0203daa:	8e89                	sub	a3,a3,a0
ffffffffc0203dac:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203dae:	000db517          	auipc	a0,0xdb
ffffffffc0203db2:	d1a53503          	ld	a0,-742(a0) # ffffffffc02deac8 <pages>
ffffffffc0203db6:	4585                	li	a1,1
ffffffffc0203db8:	9536                	add	a0,a0,a3
}
ffffffffc0203dba:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203dbc:	822fe06f          	j	ffffffffc0201dde <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203dc0:	00003617          	auipc	a2,0x3
ffffffffc0203dc4:	a0060613          	addi	a2,a2,-1536 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc0203dc8:	07700593          	li	a1,119
ffffffffc0203dcc:	00003517          	auipc	a0,0x3
ffffffffc0203dd0:	97450513          	addi	a0,a0,-1676 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0203dd4:	ebefc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203dd8:	00003617          	auipc	a2,0x3
ffffffffc0203ddc:	a1060613          	addi	a2,a2,-1520 # ffffffffc02067e8 <default_pmm_manager+0x108>
ffffffffc0203de0:	06900593          	li	a1,105
ffffffffc0203de4:	00003517          	auipc	a0,0x3
ffffffffc0203de8:	95c50513          	addi	a0,a0,-1700 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0203dec:	ea6fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0203df0 <proc_run>:
{
ffffffffc0203df0:	7179                	addi	sp,sp,-48
ffffffffc0203df2:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203df4:	000db917          	auipc	s2,0xdb
ffffffffc0203df8:	cec90913          	addi	s2,s2,-788 # ffffffffc02deae0 <current>
{
ffffffffc0203dfc:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203dfe:	00093483          	ld	s1,0(s2)
{
ffffffffc0203e02:	f406                	sd	ra,40(sp)
ffffffffc0203e04:	e84e                	sd	s3,16(sp)
    if (proc != current)
ffffffffc0203e06:	02a48863          	beq	s1,a0,ffffffffc0203e36 <proc_run+0x46>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203e0a:	100027f3          	csrr	a5,sstatus
ffffffffc0203e0e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203e10:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203e12:	ef9d                	bnez	a5,ffffffffc0203e50 <proc_run+0x60>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203e14:	755c                	ld	a5,168(a0)
ffffffffc0203e16:	577d                	li	a4,-1
ffffffffc0203e18:	177e                	slli	a4,a4,0x3f
ffffffffc0203e1a:	83b1                	srli	a5,a5,0xc
            current = proc;                            // 切换当前进程为要运行的进程
ffffffffc0203e1c:	00a93023          	sd	a0,0(s2)
ffffffffc0203e20:	8fd9                	or	a5,a5,a4
ffffffffc0203e22:	18079073          	csrw	satp,a5
            switch_to(&(prev->context), &(next->context)); // 实现上下文切换
ffffffffc0203e26:	03050593          	addi	a1,a0,48
ffffffffc0203e2a:	03048513          	addi	a0,s1,48
ffffffffc0203e2e:	122010ef          	jal	ra,ffffffffc0204f50 <switch_to>
    if (flag)
ffffffffc0203e32:	00099863          	bnez	s3,ffffffffc0203e42 <proc_run+0x52>
}
ffffffffc0203e36:	70a2                	ld	ra,40(sp)
ffffffffc0203e38:	7482                	ld	s1,32(sp)
ffffffffc0203e3a:	6962                	ld	s2,24(sp)
ffffffffc0203e3c:	69c2                	ld	s3,16(sp)
ffffffffc0203e3e:	6145                	addi	sp,sp,48
ffffffffc0203e40:	8082                	ret
ffffffffc0203e42:	70a2                	ld	ra,40(sp)
ffffffffc0203e44:	7482                	ld	s1,32(sp)
ffffffffc0203e46:	6962                	ld	s2,24(sp)
ffffffffc0203e48:	69c2                	ld	s3,16(sp)
ffffffffc0203e4a:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203e4c:	b5dfc06f          	j	ffffffffc02009a8 <intr_enable>
ffffffffc0203e50:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203e52:	b5dfc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc0203e56:	6522                	ld	a0,8(sp)
ffffffffc0203e58:	4985                	li	s3,1
ffffffffc0203e5a:	bf6d                	j	ffffffffc0203e14 <proc_run+0x24>

ffffffffc0203e5c <do_fork>:
 * @clone_flags: used to guide how to clone the child process
 * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.
 * @tf:          the trapframe info, which will be copied to child process's proc->tf
 */
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
ffffffffc0203e5c:	7119                	addi	sp,sp,-128
ffffffffc0203e5e:	f0ca                	sd	s2,96(sp)
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
ffffffffc0203e60:	000db917          	auipc	s2,0xdb
ffffffffc0203e64:	c9890913          	addi	s2,s2,-872 # ffffffffc02deaf8 <nr_process>
ffffffffc0203e68:	00092703          	lw	a4,0(s2)
{
ffffffffc0203e6c:	fc86                	sd	ra,120(sp)
ffffffffc0203e6e:	f8a2                	sd	s0,112(sp)
ffffffffc0203e70:	f4a6                	sd	s1,104(sp)
ffffffffc0203e72:	ecce                	sd	s3,88(sp)
ffffffffc0203e74:	e8d2                	sd	s4,80(sp)
ffffffffc0203e76:	e4d6                	sd	s5,72(sp)
ffffffffc0203e78:	e0da                	sd	s6,64(sp)
ffffffffc0203e7a:	fc5e                	sd	s7,56(sp)
ffffffffc0203e7c:	f862                	sd	s8,48(sp)
ffffffffc0203e7e:	f466                	sd	s9,40(sp)
ffffffffc0203e80:	f06a                	sd	s10,32(sp)
ffffffffc0203e82:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS)
ffffffffc0203e84:	6785                	lui	a5,0x1
ffffffffc0203e86:	32f75b63          	bge	a4,a5,ffffffffc02041bc <do_fork+0x360>
ffffffffc0203e8a:	8a2a                	mv	s4,a0
ffffffffc0203e8c:	89ae                	mv	s3,a1
ffffffffc0203e8e:	8432                	mv	s0,a2
    // LAB4:填写你在lab4中实现的代码

    // LAB5:填写你在lab5中实现的代码 (update LAB4 steps)

    //    1. call alloc_proc to allocate a proc_struct
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203e90:	e47ff0ef          	jal	ra,ffffffffc0203cd6 <alloc_proc>
ffffffffc0203e94:	84aa                	mv	s1,a0
ffffffffc0203e96:	30050463          	beqz	a0,ffffffffc020419e <do_fork+0x342>
        goto fork_out;
    }
    proc->parent = current;                            // 设置子进程的父进程为当前进程
ffffffffc0203e9a:	000dbc17          	auipc	s8,0xdb
ffffffffc0203e9e:	c46c0c13          	addi	s8,s8,-954 # ffffffffc02deae0 <current>
ffffffffc0203ea2:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0);                  // 确保当前进程没有在等待
ffffffffc0203ea6:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_faultread_out_size-0x8e4c>
    proc->parent = current;                            // 设置子进程的父进程为当前进程
ffffffffc0203eaa:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0);                  // 确保当前进程没有在等待
ffffffffc0203eac:	30071d63          	bnez	a4,ffffffffc02041c6 <do_fork+0x36a>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0203eb0:	4509                	li	a0,2
ffffffffc0203eb2:	eeffd0ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
    if (page != NULL)
ffffffffc0203eb6:	2e050163          	beqz	a0,ffffffffc0204198 <do_fork+0x33c>
    return page - pages + nbase;
ffffffffc0203eba:	000dba97          	auipc	s5,0xdb
ffffffffc0203ebe:	c0ea8a93          	addi	s5,s5,-1010 # ffffffffc02deac8 <pages>
ffffffffc0203ec2:	000ab683          	ld	a3,0(s5)
ffffffffc0203ec6:	00004b17          	auipc	s6,0x4
ffffffffc0203eca:	2eab0b13          	addi	s6,s6,746 # ffffffffc02081b0 <nbase>
ffffffffc0203ece:	000b3783          	ld	a5,0(s6)
ffffffffc0203ed2:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc0203ed6:	000dbb97          	auipc	s7,0xdb
ffffffffc0203eda:	beab8b93          	addi	s7,s7,-1046 # ffffffffc02deac0 <npage>
    return page - pages + nbase;
ffffffffc0203ede:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0203ee0:	5dfd                	li	s11,-1
ffffffffc0203ee2:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc0203ee6:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0203ee8:	00cddd93          	srli	s11,s11,0xc
ffffffffc0203eec:	01b6f633          	and	a2,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0203ef0:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0203ef2:	2ee67a63          	bgeu	a2,a4,ffffffffc02041e6 <do_fork+0x38a>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc0203ef6:	000c3603          	ld	a2,0(s8)
ffffffffc0203efa:	000dbc17          	auipc	s8,0xdb
ffffffffc0203efe:	bdec0c13          	addi	s8,s8,-1058 # ffffffffc02dead8 <va_pa_offset>
ffffffffc0203f02:	000c3703          	ld	a4,0(s8)
ffffffffc0203f06:	02863d03          	ld	s10,40(a2)
ffffffffc0203f0a:	e43e                	sd	a5,8(sp)
ffffffffc0203f0c:	96ba                	add	a3,a3,a4
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0203f0e:	e894                	sd	a3,16(s1)
    if (oldmm == NULL)
ffffffffc0203f10:	020d0863          	beqz	s10,ffffffffc0203f40 <do_fork+0xe4>
    if (clone_flags & CLONE_VM)
ffffffffc0203f14:	100a7a13          	andi	s4,s4,256
ffffffffc0203f18:	1c0a0163          	beqz	s4,ffffffffc02040da <do_fork+0x27e>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0203f1c:	030d2703          	lw	a4,48(s10)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203f20:	018d3783          	ld	a5,24(s10)
ffffffffc0203f24:	c02006b7          	lui	a3,0xc0200
ffffffffc0203f28:	2705                	addiw	a4,a4,1
ffffffffc0203f2a:	02ed2823          	sw	a4,48(s10)
    proc->mm = mm;
ffffffffc0203f2e:	03a4b423          	sd	s10,40(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203f32:	2ed7e263          	bltu	a5,a3,ffffffffc0204216 <do_fork+0x3ba>
ffffffffc0203f36:	000c3703          	ld	a4,0(s8)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203f3a:	6894                	ld	a3,16(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0203f3c:	8f99                	sub	a5,a5,a4
ffffffffc0203f3e:	f4dc                	sd	a5,168(s1)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203f40:	6789                	lui	a5,0x2
ffffffffc0203f42:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x8058>
ffffffffc0203f46:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc0203f48:	8622                	mv	a2,s0
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc0203f4a:	f0d4                	sd	a3,160(s1)
    *(proc->tf) = *tf;
ffffffffc0203f4c:	87b6                	mv	a5,a3
ffffffffc0203f4e:	12040893          	addi	a7,s0,288
ffffffffc0203f52:	00063803          	ld	a6,0(a2)
ffffffffc0203f56:	6608                	ld	a0,8(a2)
ffffffffc0203f58:	6a0c                	ld	a1,16(a2)
ffffffffc0203f5a:	6e18                	ld	a4,24(a2)
ffffffffc0203f5c:	0107b023          	sd	a6,0(a5)
ffffffffc0203f60:	e788                	sd	a0,8(a5)
ffffffffc0203f62:	eb8c                	sd	a1,16(a5)
ffffffffc0203f64:	ef98                	sd	a4,24(a5)
ffffffffc0203f66:	02060613          	addi	a2,a2,32
ffffffffc0203f6a:	02078793          	addi	a5,a5,32
ffffffffc0203f6e:	ff1612e3          	bne	a2,a7,ffffffffc0203f52 <do_fork+0xf6>
    proc->tf->gpr.a0 = 0;
ffffffffc0203f72:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0203f76:	12098f63          	beqz	s3,ffffffffc02040b4 <do_fork+0x258>
ffffffffc0203f7a:	0136b823          	sd	s3,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc0203f7e:	00000797          	auipc	a5,0x0
ffffffffc0203f82:	dee78793          	addi	a5,a5,-530 # ffffffffc0203d6c <forkret>
ffffffffc0203f86:	f89c                	sd	a5,48(s1)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc0203f88:	fc94                	sd	a3,56(s1)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f8a:	100027f3          	csrr	a5,sstatus
ffffffffc0203f8e:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203f90:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f92:	14079063          	bnez	a5,ffffffffc02040d2 <do_fork+0x276>
    if (++last_pid >= MAX_PID)
ffffffffc0203f96:	000d6817          	auipc	a6,0xd6
ffffffffc0203f9a:	69280813          	addi	a6,a6,1682 # ffffffffc02da628 <last_pid.1>
ffffffffc0203f9e:	00082783          	lw	a5,0(a6)
ffffffffc0203fa2:	6709                	lui	a4,0x2
ffffffffc0203fa4:	0017851b          	addiw	a0,a5,1
ffffffffc0203fa8:	00a82023          	sw	a0,0(a6)
ffffffffc0203fac:	08e55d63          	bge	a0,a4,ffffffffc0204046 <do_fork+0x1ea>
    if (last_pid >= next_safe)
ffffffffc0203fb0:	000d6317          	auipc	t1,0xd6
ffffffffc0203fb4:	67c30313          	addi	t1,t1,1660 # ffffffffc02da62c <next_safe.0>
ffffffffc0203fb8:	00032783          	lw	a5,0(t1)
ffffffffc0203fbc:	000db417          	auipc	s0,0xdb
ffffffffc0203fc0:	a8c40413          	addi	s0,s0,-1396 # ffffffffc02dea48 <proc_list>
ffffffffc0203fc4:	08f55963          	bge	a0,a5,ffffffffc0204056 <do_fork+0x1fa>
    
    //    5. insert proc_struct into hash_list && proc_list, set the relation links of process
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        proc->pid = get_pid();
ffffffffc0203fc8:	c0c8                	sw	a0,4(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0203fca:	45a9                	li	a1,10
ffffffffc0203fcc:	2501                	sext.w	a0,a0
ffffffffc0203fce:	402010ef          	jal	ra,ffffffffc02053d0 <hash32>
ffffffffc0203fd2:	02051793          	slli	a5,a0,0x20
ffffffffc0203fd6:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0203fda:	000d7797          	auipc	a5,0xd7
ffffffffc0203fde:	a6e78793          	addi	a5,a5,-1426 # ffffffffc02daa48 <hash_list>
ffffffffc0203fe2:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc0203fe4:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0203fe6:	7094                	ld	a3,32(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0203fe8:	0d848793          	addi	a5,s1,216
    prev->next = next->prev = elm;
ffffffffc0203fec:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc0203fee:	6410                	ld	a2,8(s0)
    prev->next = next->prev = elm;
ffffffffc0203ff0:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0203ff2:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc0203ff4:	0c848793          	addi	a5,s1,200
    elm->next = next;
ffffffffc0203ff8:	f0ec                	sd	a1,224(s1)
    elm->prev = prev;
ffffffffc0203ffa:	ece8                	sd	a0,216(s1)
    prev->next = next->prev = elm;
ffffffffc0203ffc:	e21c                	sd	a5,0(a2)
ffffffffc0203ffe:	e41c                	sd	a5,8(s0)
    elm->next = next;
ffffffffc0204000:	e8f0                	sd	a2,208(s1)
    elm->prev = prev;
ffffffffc0204002:	e4e0                	sd	s0,200(s1)
    proc->yptr = NULL;
ffffffffc0204004:	0e04bc23          	sd	zero,248(s1)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204008:	10e4b023          	sd	a4,256(s1)
ffffffffc020400c:	c311                	beqz	a4,ffffffffc0204010 <do_fork+0x1b4>
        proc->optr->yptr = proc;
ffffffffc020400e:	ff64                	sd	s1,248(a4)
    nr_process++;
ffffffffc0204010:	00092783          	lw	a5,0(s2)
    proc->parent->cptr = proc;
ffffffffc0204014:	fae4                	sd	s1,240(a3)
    nr_process++;
ffffffffc0204016:	2785                	addiw	a5,a5,1
ffffffffc0204018:	00f92023          	sw	a5,0(s2)
    if (flag)
ffffffffc020401c:	18099363          	bnez	s3,ffffffffc02041a2 <do_fork+0x346>
        set_links(proc);                               // 使用 set_links 建立进程间的关系
    }
    local_intr_restore(intr_flag);
    
    //    6. call wakeup_proc to make the new child process RUNNABLE
    wakeup_proc(proc);
ffffffffc0204020:	8526                	mv	a0,s1
ffffffffc0204022:	012010ef          	jal	ra,ffffffffc0205034 <wakeup_proc>
    
    //    7. set ret vaule using child proc's pid
    ret = proc->pid;
ffffffffc0204026:	40c8                	lw	a0,4(s1)
bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
ffffffffc0204028:	70e6                	ld	ra,120(sp)
ffffffffc020402a:	7446                	ld	s0,112(sp)
ffffffffc020402c:	74a6                	ld	s1,104(sp)
ffffffffc020402e:	7906                	ld	s2,96(sp)
ffffffffc0204030:	69e6                	ld	s3,88(sp)
ffffffffc0204032:	6a46                	ld	s4,80(sp)
ffffffffc0204034:	6aa6                	ld	s5,72(sp)
ffffffffc0204036:	6b06                	ld	s6,64(sp)
ffffffffc0204038:	7be2                	ld	s7,56(sp)
ffffffffc020403a:	7c42                	ld	s8,48(sp)
ffffffffc020403c:	7ca2                	ld	s9,40(sp)
ffffffffc020403e:	7d02                	ld	s10,32(sp)
ffffffffc0204040:	6de2                	ld	s11,24(sp)
ffffffffc0204042:	6109                	addi	sp,sp,128
ffffffffc0204044:	8082                	ret
        last_pid = 1;
ffffffffc0204046:	4785                	li	a5,1
ffffffffc0204048:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc020404c:	4505                	li	a0,1
ffffffffc020404e:	000d6317          	auipc	t1,0xd6
ffffffffc0204052:	5de30313          	addi	t1,t1,1502 # ffffffffc02da62c <next_safe.0>
    return listelm->next;
ffffffffc0204056:	000db417          	auipc	s0,0xdb
ffffffffc020405a:	9f240413          	addi	s0,s0,-1550 # ffffffffc02dea48 <proc_list>
ffffffffc020405e:	00843e03          	ld	t3,8(s0)
        next_safe = MAX_PID;
ffffffffc0204062:	6789                	lui	a5,0x2
ffffffffc0204064:	00f32023          	sw	a5,0(t1)
ffffffffc0204068:	86aa                	mv	a3,a0
ffffffffc020406a:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc020406c:	6e89                	lui	t4,0x2
ffffffffc020406e:	148e0263          	beq	t3,s0,ffffffffc02041b2 <do_fork+0x356>
ffffffffc0204072:	88ae                	mv	a7,a1
ffffffffc0204074:	87f2                	mv	a5,t3
ffffffffc0204076:	6609                	lui	a2,0x2
ffffffffc0204078:	a811                	j	ffffffffc020408c <do_fork+0x230>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc020407a:	00e6d663          	bge	a3,a4,ffffffffc0204086 <do_fork+0x22a>
ffffffffc020407e:	00c75463          	bge	a4,a2,ffffffffc0204086 <do_fork+0x22a>
ffffffffc0204082:	863a                	mv	a2,a4
ffffffffc0204084:	4885                	li	a7,1
ffffffffc0204086:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204088:	00878d63          	beq	a5,s0,ffffffffc02040a2 <do_fork+0x246>
            if (proc->pid == last_pid)
ffffffffc020408c:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7ffc>
ffffffffc0204090:	fed715e3          	bne	a4,a3,ffffffffc020407a <do_fork+0x21e>
                if (++last_pid >= next_safe)
ffffffffc0204094:	2685                	addiw	a3,a3,1
ffffffffc0204096:	10c6d963          	bge	a3,a2,ffffffffc02041a8 <do_fork+0x34c>
ffffffffc020409a:	679c                	ld	a5,8(a5)
ffffffffc020409c:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc020409e:	fe8797e3          	bne	a5,s0,ffffffffc020408c <do_fork+0x230>
ffffffffc02040a2:	c581                	beqz	a1,ffffffffc02040aa <do_fork+0x24e>
ffffffffc02040a4:	00d82023          	sw	a3,0(a6)
ffffffffc02040a8:	8536                	mv	a0,a3
ffffffffc02040aa:	f0088fe3          	beqz	a7,ffffffffc0203fc8 <do_fork+0x16c>
ffffffffc02040ae:	00c32023          	sw	a2,0(t1)
ffffffffc02040b2:	bf19                	j	ffffffffc0203fc8 <do_fork+0x16c>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040b4:	89b6                	mv	s3,a3
ffffffffc02040b6:	0136b823          	sd	s3,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02040ba:	00000797          	auipc	a5,0x0
ffffffffc02040be:	cb278793          	addi	a5,a5,-846 # ffffffffc0203d6c <forkret>
ffffffffc02040c2:	f89c                	sd	a5,48(s1)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02040c4:	fc94                	sd	a3,56(s1)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02040c6:	100027f3          	csrr	a5,sstatus
ffffffffc02040ca:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02040cc:	4981                	li	s3,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02040ce:	ec0784e3          	beqz	a5,ffffffffc0203f96 <do_fork+0x13a>
        intr_disable();
ffffffffc02040d2:	8ddfc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc02040d6:	4985                	li	s3,1
ffffffffc02040d8:	bd7d                	j	ffffffffc0203f96 <do_fork+0x13a>
    if ((mm = mm_create()) == NULL)
ffffffffc02040da:	ceaff0ef          	jal	ra,ffffffffc02035c4 <mm_create>
ffffffffc02040de:	8caa                	mv	s9,a0
ffffffffc02040e0:	c541                	beqz	a0,ffffffffc0204168 <do_fork+0x30c>
    if ((page = alloc_page()) == NULL)
ffffffffc02040e2:	4505                	li	a0,1
ffffffffc02040e4:	cbdfd0ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc02040e8:	cd2d                	beqz	a0,ffffffffc0204162 <do_fork+0x306>
    return page - pages + nbase;
ffffffffc02040ea:	000ab683          	ld	a3,0(s5)
ffffffffc02040ee:	67a2                	ld	a5,8(sp)
    return KADDR(page2pa(page));
ffffffffc02040f0:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc02040f4:	40d506b3          	sub	a3,a0,a3
ffffffffc02040f8:	8699                	srai	a3,a3,0x6
ffffffffc02040fa:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02040fc:	01b6fdb3          	and	s11,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0204100:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204102:	0eedf263          	bgeu	s11,a4,ffffffffc02041e6 <do_fork+0x38a>
ffffffffc0204106:	000c3a03          	ld	s4,0(s8)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc020410a:	6605                	lui	a2,0x1
ffffffffc020410c:	000db597          	auipc	a1,0xdb
ffffffffc0204110:	9ac5b583          	ld	a1,-1620(a1) # ffffffffc02deab8 <boot_pgdir_va>
ffffffffc0204114:	9a36                	add	s4,s4,a3
ffffffffc0204116:	8552                	mv	a0,s4
ffffffffc0204118:	770010ef          	jal	ra,ffffffffc0205888 <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc020411c:	038d0d93          	addi	s11,s10,56
    mm->pgdir = pgdir;
ffffffffc0204120:	014cbc23          	sd	s4,24(s9)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0204124:	4785                	li	a5,1
ffffffffc0204126:	40fdb7af          	amoor.d	a5,a5,(s11)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc020412a:	8b85                	andi	a5,a5,1
ffffffffc020412c:	4a05                	li	s4,1
ffffffffc020412e:	c799                	beqz	a5,ffffffffc020413c <do_fork+0x2e0>
    {
        schedule();
ffffffffc0204130:	7b7000ef          	jal	ra,ffffffffc02050e6 <schedule>
ffffffffc0204134:	414db7af          	amoor.d	a5,s4,(s11)
    while (!try_lock(lock))
ffffffffc0204138:	8b85                	andi	a5,a5,1
ffffffffc020413a:	fbfd                	bnez	a5,ffffffffc0204130 <do_fork+0x2d4>
        ret = dup_mmap(mm, oldmm);
ffffffffc020413c:	85ea                	mv	a1,s10
ffffffffc020413e:	8566                	mv	a0,s9
ffffffffc0204140:	ec6ff0ef          	jal	ra,ffffffffc0203806 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0204144:	57f9                	li	a5,-2
ffffffffc0204146:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc020414a:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc020414c:	0e078e63          	beqz	a5,ffffffffc0204248 <do_fork+0x3ec>
good_mm:
ffffffffc0204150:	8d66                	mv	s10,s9
    if (ret != 0)
ffffffffc0204152:	dc0505e3          	beqz	a0,ffffffffc0203f1c <do_fork+0xc0>
    exit_mmap(mm);
ffffffffc0204156:	8566                	mv	a0,s9
ffffffffc0204158:	f48ff0ef          	jal	ra,ffffffffc02038a0 <exit_mmap>
    put_pgdir(mm);
ffffffffc020415c:	8566                	mv	a0,s9
ffffffffc020415e:	c1dff0ef          	jal	ra,ffffffffc0203d7a <put_pgdir>
    mm_destroy(mm);
ffffffffc0204162:	8566                	mv	a0,s9
ffffffffc0204164:	da0ff0ef          	jal	ra,ffffffffc0203704 <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0204168:	6894                	ld	a3,16(s1)
    return pa2page(PADDR(kva));
ffffffffc020416a:	c02007b7          	lui	a5,0xc0200
ffffffffc020416e:	0cf6e163          	bltu	a3,a5,ffffffffc0204230 <do_fork+0x3d4>
ffffffffc0204172:	000c3783          	ld	a5,0(s8)
    if (PPN(pa) >= npage)
ffffffffc0204176:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc020417a:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage)
ffffffffc020417e:	83b1                	srli	a5,a5,0xc
ffffffffc0204180:	06e7ff63          	bgeu	a5,a4,ffffffffc02041fe <do_fork+0x3a2>
    return &pages[PPN(pa) - nbase];
ffffffffc0204184:	000b3703          	ld	a4,0(s6)
ffffffffc0204188:	000ab503          	ld	a0,0(s5)
ffffffffc020418c:	4589                	li	a1,2
ffffffffc020418e:	8f99                	sub	a5,a5,a4
ffffffffc0204190:	079a                	slli	a5,a5,0x6
ffffffffc0204192:	953e                	add	a0,a0,a5
ffffffffc0204194:	c4bfd0ef          	jal	ra,ffffffffc0201dde <free_pages>
    kfree(proc);
ffffffffc0204198:	8526                	mv	a0,s1
ffffffffc020419a:	ad9fd0ef          	jal	ra,ffffffffc0201c72 <kfree>
    ret = -E_NO_MEM;
ffffffffc020419e:	5571                	li	a0,-4
    return ret;
ffffffffc02041a0:	b561                	j	ffffffffc0204028 <do_fork+0x1cc>
        intr_enable();
ffffffffc02041a2:	807fc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02041a6:	bdad                	j	ffffffffc0204020 <do_fork+0x1c4>
                    if (last_pid >= MAX_PID)
ffffffffc02041a8:	01d6c363          	blt	a3,t4,ffffffffc02041ae <do_fork+0x352>
                        last_pid = 1;
ffffffffc02041ac:	4685                	li	a3,1
                    goto repeat;
ffffffffc02041ae:	4585                	li	a1,1
ffffffffc02041b0:	bd7d                	j	ffffffffc020406e <do_fork+0x212>
ffffffffc02041b2:	c599                	beqz	a1,ffffffffc02041c0 <do_fork+0x364>
ffffffffc02041b4:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc02041b8:	8536                	mv	a0,a3
ffffffffc02041ba:	b539                	j	ffffffffc0203fc8 <do_fork+0x16c>
    int ret = -E_NO_FREE_PROC;
ffffffffc02041bc:	556d                	li	a0,-5
ffffffffc02041be:	b5ad                	j	ffffffffc0204028 <do_fork+0x1cc>
    return last_pid;
ffffffffc02041c0:	00082503          	lw	a0,0(a6)
ffffffffc02041c4:	b511                	j	ffffffffc0203fc8 <do_fork+0x16c>
    assert(current->wait_state == 0);                  // 确保当前进程没有在等待
ffffffffc02041c6:	00003697          	auipc	a3,0x3
ffffffffc02041ca:	f2268693          	addi	a3,a3,-222 # ffffffffc02070e8 <default_pmm_manager+0xa08>
ffffffffc02041ce:	00002617          	auipc	a2,0x2
ffffffffc02041d2:	16260613          	addi	a2,a2,354 # ffffffffc0206330 <commands+0x828>
ffffffffc02041d6:	1a900593          	li	a1,425
ffffffffc02041da:	00003517          	auipc	a0,0x3
ffffffffc02041de:	f2e50513          	addi	a0,a0,-210 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02041e2:	ab0fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return KADDR(page2pa(page));
ffffffffc02041e6:	00002617          	auipc	a2,0x2
ffffffffc02041ea:	53260613          	addi	a2,a2,1330 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc02041ee:	07100593          	li	a1,113
ffffffffc02041f2:	00002517          	auipc	a0,0x2
ffffffffc02041f6:	54e50513          	addi	a0,a0,1358 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc02041fa:	a98fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02041fe:	00002617          	auipc	a2,0x2
ffffffffc0204202:	5ea60613          	addi	a2,a2,1514 # ffffffffc02067e8 <default_pmm_manager+0x108>
ffffffffc0204206:	06900593          	li	a1,105
ffffffffc020420a:	00002517          	auipc	a0,0x2
ffffffffc020420e:	53650513          	addi	a0,a0,1334 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0204212:	a80fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204216:	86be                	mv	a3,a5
ffffffffc0204218:	00002617          	auipc	a2,0x2
ffffffffc020421c:	5a860613          	addi	a2,a2,1448 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc0204220:	17700593          	li	a1,375
ffffffffc0204224:	00003517          	auipc	a0,0x3
ffffffffc0204228:	ee450513          	addi	a0,a0,-284 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc020422c:	a66fc0ef          	jal	ra,ffffffffc0200492 <__panic>
    return pa2page(PADDR(kva));
ffffffffc0204230:	00002617          	auipc	a2,0x2
ffffffffc0204234:	59060613          	addi	a2,a2,1424 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc0204238:	07700593          	li	a1,119
ffffffffc020423c:	00002517          	auipc	a0,0x2
ffffffffc0204240:	50450513          	addi	a0,a0,1284 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0204244:	a4efc0ef          	jal	ra,ffffffffc0200492 <__panic>
    {
        panic("Unlock failed.\n");
ffffffffc0204248:	00003617          	auipc	a2,0x3
ffffffffc020424c:	ed860613          	addi	a2,a2,-296 # ffffffffc0207120 <default_pmm_manager+0xa40>
ffffffffc0204250:	04000593          	li	a1,64
ffffffffc0204254:	00003517          	auipc	a0,0x3
ffffffffc0204258:	edc50513          	addi	a0,a0,-292 # ffffffffc0207130 <default_pmm_manager+0xa50>
ffffffffc020425c:	a36fc0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204260 <kernel_thread>:
{
ffffffffc0204260:	7129                	addi	sp,sp,-320
ffffffffc0204262:	fa22                	sd	s0,304(sp)
ffffffffc0204264:	f626                	sd	s1,296(sp)
ffffffffc0204266:	f24a                	sd	s2,288(sp)
ffffffffc0204268:	84ae                	mv	s1,a1
ffffffffc020426a:	892a                	mv	s2,a0
ffffffffc020426c:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc020426e:	4581                	li	a1,0
ffffffffc0204270:	12000613          	li	a2,288
ffffffffc0204274:	850a                	mv	a0,sp
{
ffffffffc0204276:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204278:	5fe010ef          	jal	ra,ffffffffc0205876 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc020427c:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc020427e:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc0204280:	100027f3          	csrr	a5,sstatus
ffffffffc0204284:	edd7f793          	andi	a5,a5,-291
ffffffffc0204288:	1207e793          	ori	a5,a5,288
ffffffffc020428c:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020428e:	860a                	mv	a2,sp
ffffffffc0204290:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc0204294:	00000797          	auipc	a5,0x0
ffffffffc0204298:	a3a78793          	addi	a5,a5,-1478 # ffffffffc0203cce <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc020429c:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc020429e:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02042a0:	bbdff0ef          	jal	ra,ffffffffc0203e5c <do_fork>
}
ffffffffc02042a4:	70f2                	ld	ra,312(sp)
ffffffffc02042a6:	7452                	ld	s0,304(sp)
ffffffffc02042a8:	74b2                	ld	s1,296(sp)
ffffffffc02042aa:	7912                	ld	s2,288(sp)
ffffffffc02042ac:	6131                	addi	sp,sp,320
ffffffffc02042ae:	8082                	ret

ffffffffc02042b0 <do_exit>:
// do_exit - called by sys_exit
//   1. call exit_mmap & put_pgdir & mm_destroy to free the almost all memory space of process
//   2. set process' state as PROC_ZOMBIE, then call wakeup_proc(parent) to ask parent reclaim itself.
//   3. call scheduler to switch to other process
int do_exit(int error_code)
{
ffffffffc02042b0:	7179                	addi	sp,sp,-48
ffffffffc02042b2:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc02042b4:	000db417          	auipc	s0,0xdb
ffffffffc02042b8:	82c40413          	addi	s0,s0,-2004 # ffffffffc02deae0 <current>
ffffffffc02042bc:	601c                	ld	a5,0(s0)
{
ffffffffc02042be:	f406                	sd	ra,40(sp)
ffffffffc02042c0:	ec26                	sd	s1,24(sp)
ffffffffc02042c2:	e84a                	sd	s2,16(sp)
ffffffffc02042c4:	e44e                	sd	s3,8(sp)
ffffffffc02042c6:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc02042c8:	000db717          	auipc	a4,0xdb
ffffffffc02042cc:	82073703          	ld	a4,-2016(a4) # ffffffffc02deae8 <idleproc>
ffffffffc02042d0:	0ce78c63          	beq	a5,a4,ffffffffc02043a8 <do_exit+0xf8>
    {
        panic("idleproc exit.\n");
    }
    if (current == initproc)
ffffffffc02042d4:	000db497          	auipc	s1,0xdb
ffffffffc02042d8:	81c48493          	addi	s1,s1,-2020 # ffffffffc02deaf0 <initproc>
ffffffffc02042dc:	6098                	ld	a4,0(s1)
ffffffffc02042de:	0ee78b63          	beq	a5,a4,ffffffffc02043d4 <do_exit+0x124>
    {
        panic("initproc exit.\n");
    }
    struct mm_struct *mm = current->mm;
ffffffffc02042e2:	0287b983          	ld	s3,40(a5)
ffffffffc02042e6:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc02042e8:	02098663          	beqz	s3,ffffffffc0204314 <do_exit+0x64>
ffffffffc02042ec:	000da797          	auipc	a5,0xda
ffffffffc02042f0:	7c47b783          	ld	a5,1988(a5) # ffffffffc02deab0 <boot_pgdir_pa>
ffffffffc02042f4:	577d                	li	a4,-1
ffffffffc02042f6:	177e                	slli	a4,a4,0x3f
ffffffffc02042f8:	83b1                	srli	a5,a5,0xc
ffffffffc02042fa:	8fd9                	or	a5,a5,a4
ffffffffc02042fc:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0204300:	0309a783          	lw	a5,48(s3)
ffffffffc0204304:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204308:	02e9a823          	sw	a4,48(s3)
    {
        lsatp(boot_pgdir_pa);
        if (mm_count_dec(mm) == 0)
ffffffffc020430c:	cb55                	beqz	a4,ffffffffc02043c0 <do_exit+0x110>
        {
            exit_mmap(mm);
            put_pgdir(mm);
            mm_destroy(mm);
        }
        current->mm = NULL;
ffffffffc020430e:	601c                	ld	a5,0(s0)
ffffffffc0204310:	0207b423          	sd	zero,40(a5)
    }
    current->state = PROC_ZOMBIE;
ffffffffc0204314:	601c                	ld	a5,0(s0)
ffffffffc0204316:	470d                	li	a4,3
ffffffffc0204318:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc020431a:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020431e:	100027f3          	csrr	a5,sstatus
ffffffffc0204322:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204324:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204326:	e3f9                	bnez	a5,ffffffffc02043ec <do_exit+0x13c>
    bool intr_flag;
    struct proc_struct *proc;
    local_intr_save(intr_flag);
    {
        proc = current->parent;
ffffffffc0204328:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc020432a:	800007b7          	lui	a5,0x80000
ffffffffc020432e:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc0204330:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204332:	0ec52703          	lw	a4,236(a0)
ffffffffc0204336:	0af70f63          	beq	a4,a5,ffffffffc02043f4 <do_exit+0x144>
        {
            wakeup_proc(proc);
        }
        while (current->cptr != NULL)
ffffffffc020433a:	6018                	ld	a4,0(s0)
ffffffffc020433c:	7b7c                	ld	a5,240(a4)
ffffffffc020433e:	c3a1                	beqz	a5,ffffffffc020437e <do_exit+0xce>
            }
            proc->parent = initproc;
            initproc->cptr = proc;
            if (proc->state == PROC_ZOMBIE)
            {
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204340:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204344:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204346:	0985                	addi	s3,s3,1
ffffffffc0204348:	a021                	j	ffffffffc0204350 <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc020434a:	6018                	ld	a4,0(s0)
ffffffffc020434c:	7b7c                	ld	a5,240(a4)
ffffffffc020434e:	cb85                	beqz	a5,ffffffffc020437e <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc0204350:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_sched_test_out_size+0xffffffff7fff2c28>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204354:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc0204356:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204358:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc020435a:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc020435e:	10e7b023          	sd	a4,256(a5)
ffffffffc0204362:	c311                	beqz	a4,ffffffffc0204366 <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc0204364:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204366:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0204368:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc020436a:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc020436c:	fd271fe3          	bne	a4,s2,ffffffffc020434a <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204370:	0ec52783          	lw	a5,236(a0)
ffffffffc0204374:	fd379be3          	bne	a5,s3,ffffffffc020434a <do_exit+0x9a>
                {
                    wakeup_proc(initproc);
ffffffffc0204378:	4bd000ef          	jal	ra,ffffffffc0205034 <wakeup_proc>
ffffffffc020437c:	b7f9                	j	ffffffffc020434a <do_exit+0x9a>
    if (flag)
ffffffffc020437e:	020a1263          	bnez	s4,ffffffffc02043a2 <do_exit+0xf2>
                }
            }
        }
    }
    local_intr_restore(intr_flag);
    schedule();
ffffffffc0204382:	565000ef          	jal	ra,ffffffffc02050e6 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc0204386:	601c                	ld	a5,0(s0)
ffffffffc0204388:	00003617          	auipc	a2,0x3
ffffffffc020438c:	de060613          	addi	a2,a2,-544 # ffffffffc0207168 <default_pmm_manager+0xa88>
ffffffffc0204390:	20e00593          	li	a1,526
ffffffffc0204394:	43d4                	lw	a3,4(a5)
ffffffffc0204396:	00003517          	auipc	a0,0x3
ffffffffc020439a:	d7250513          	addi	a0,a0,-654 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc020439e:	8f4fc0ef          	jal	ra,ffffffffc0200492 <__panic>
        intr_enable();
ffffffffc02043a2:	e06fc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc02043a6:	bff1                	j	ffffffffc0204382 <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc02043a8:	00003617          	auipc	a2,0x3
ffffffffc02043ac:	da060613          	addi	a2,a2,-608 # ffffffffc0207148 <default_pmm_manager+0xa68>
ffffffffc02043b0:	1da00593          	li	a1,474
ffffffffc02043b4:	00003517          	auipc	a0,0x3
ffffffffc02043b8:	d5450513          	addi	a0,a0,-684 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02043bc:	8d6fc0ef          	jal	ra,ffffffffc0200492 <__panic>
            exit_mmap(mm);
ffffffffc02043c0:	854e                	mv	a0,s3
ffffffffc02043c2:	cdeff0ef          	jal	ra,ffffffffc02038a0 <exit_mmap>
            put_pgdir(mm);
ffffffffc02043c6:	854e                	mv	a0,s3
ffffffffc02043c8:	9b3ff0ef          	jal	ra,ffffffffc0203d7a <put_pgdir>
            mm_destroy(mm);
ffffffffc02043cc:	854e                	mv	a0,s3
ffffffffc02043ce:	b36ff0ef          	jal	ra,ffffffffc0203704 <mm_destroy>
ffffffffc02043d2:	bf35                	j	ffffffffc020430e <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc02043d4:	00003617          	auipc	a2,0x3
ffffffffc02043d8:	d8460613          	addi	a2,a2,-636 # ffffffffc0207158 <default_pmm_manager+0xa78>
ffffffffc02043dc:	1de00593          	li	a1,478
ffffffffc02043e0:	00003517          	auipc	a0,0x3
ffffffffc02043e4:	d2850513          	addi	a0,a0,-728 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02043e8:	8aafc0ef          	jal	ra,ffffffffc0200492 <__panic>
        intr_disable();
ffffffffc02043ec:	dc2fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc02043f0:	4a05                	li	s4,1
ffffffffc02043f2:	bf1d                	j	ffffffffc0204328 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc02043f4:	441000ef          	jal	ra,ffffffffc0205034 <wakeup_proc>
ffffffffc02043f8:	b789                	j	ffffffffc020433a <do_exit+0x8a>

ffffffffc02043fa <do_wait.part.0>:
}

// do_wait - wait one OR any children with PROC_ZOMBIE state, and free memory space of kernel stack
//         - proc struct of this child.
// NOTE: only after do_wait function, all resources of the child proces are free.
int do_wait(int pid, int *code_store)
ffffffffc02043fa:	715d                	addi	sp,sp,-80
ffffffffc02043fc:	f84a                	sd	s2,48(sp)
ffffffffc02043fe:	f44e                	sd	s3,40(sp)
        }
    }
    if (haskid)
    {
        current->state = PROC_SLEEPING;
        current->wait_state = WT_CHILD;
ffffffffc0204400:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc0204404:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc0204406:	fc26                	sd	s1,56(sp)
ffffffffc0204408:	f052                	sd	s4,32(sp)
ffffffffc020440a:	ec56                	sd	s5,24(sp)
ffffffffc020440c:	e85a                	sd	s6,16(sp)
ffffffffc020440e:	e45e                	sd	s7,8(sp)
ffffffffc0204410:	e486                	sd	ra,72(sp)
ffffffffc0204412:	e0a2                	sd	s0,64(sp)
ffffffffc0204414:	84aa                	mv	s1,a0
ffffffffc0204416:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc0204418:	000dab97          	auipc	s7,0xda
ffffffffc020441c:	6c8b8b93          	addi	s7,s7,1736 # ffffffffc02deae0 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204420:	00050b1b          	sext.w	s6,a0
ffffffffc0204424:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0204428:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc020442a:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc020442c:	ccbd                	beqz	s1,ffffffffc02044aa <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc020442e:	0359e863          	bltu	s3,s5,ffffffffc020445e <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204432:	45a9                	li	a1,10
ffffffffc0204434:	855a                	mv	a0,s6
ffffffffc0204436:	79b000ef          	jal	ra,ffffffffc02053d0 <hash32>
ffffffffc020443a:	02051793          	slli	a5,a0,0x20
ffffffffc020443e:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204442:	000d6797          	auipc	a5,0xd6
ffffffffc0204446:	60678793          	addi	a5,a5,1542 # ffffffffc02daa48 <hash_list>
ffffffffc020444a:	953e                	add	a0,a0,a5
ffffffffc020444c:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc020444e:	a029                	j	ffffffffc0204458 <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc0204450:	f2c42783          	lw	a5,-212(s0)
ffffffffc0204454:	02978163          	beq	a5,s1,ffffffffc0204476 <do_wait.part.0+0x7c>
ffffffffc0204458:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc020445a:	fe851be3          	bne	a0,s0,ffffffffc0204450 <do_wait.part.0+0x56>
        {
            do_exit(-E_KILLED);
        }
        goto repeat;
    }
    return -E_BAD_PROC;
ffffffffc020445e:	5579                	li	a0,-2
    }
    local_intr_restore(intr_flag);
    put_kstack(proc);
    kfree(proc);
    return 0;
}
ffffffffc0204460:	60a6                	ld	ra,72(sp)
ffffffffc0204462:	6406                	ld	s0,64(sp)
ffffffffc0204464:	74e2                	ld	s1,56(sp)
ffffffffc0204466:	7942                	ld	s2,48(sp)
ffffffffc0204468:	79a2                	ld	s3,40(sp)
ffffffffc020446a:	7a02                	ld	s4,32(sp)
ffffffffc020446c:	6ae2                	ld	s5,24(sp)
ffffffffc020446e:	6b42                	ld	s6,16(sp)
ffffffffc0204470:	6ba2                	ld	s7,8(sp)
ffffffffc0204472:	6161                	addi	sp,sp,80
ffffffffc0204474:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc0204476:	000bb683          	ld	a3,0(s7)
ffffffffc020447a:	f4843783          	ld	a5,-184(s0)
ffffffffc020447e:	fed790e3          	bne	a5,a3,ffffffffc020445e <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204482:	f2842703          	lw	a4,-216(s0)
ffffffffc0204486:	478d                	li	a5,3
ffffffffc0204488:	0ef70b63          	beq	a4,a5,ffffffffc020457e <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc020448c:	4785                	li	a5,1
ffffffffc020448e:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc0204490:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc0204494:	453000ef          	jal	ra,ffffffffc02050e6 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc0204498:	000bb783          	ld	a5,0(s7)
ffffffffc020449c:	0b07a783          	lw	a5,176(a5)
ffffffffc02044a0:	8b85                	andi	a5,a5,1
ffffffffc02044a2:	d7c9                	beqz	a5,ffffffffc020442c <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc02044a4:	555d                	li	a0,-9
ffffffffc02044a6:	e0bff0ef          	jal	ra,ffffffffc02042b0 <do_exit>
        proc = current->cptr;
ffffffffc02044aa:	000bb683          	ld	a3,0(s7)
ffffffffc02044ae:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc02044b0:	d45d                	beqz	s0,ffffffffc020445e <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044b2:	470d                	li	a4,3
ffffffffc02044b4:	a021                	j	ffffffffc02044bc <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc02044b6:	10043403          	ld	s0,256(s0)
ffffffffc02044ba:	d869                	beqz	s0,ffffffffc020448c <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02044bc:	401c                	lw	a5,0(s0)
ffffffffc02044be:	fee79ce3          	bne	a5,a4,ffffffffc02044b6 <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc02044c2:	000da797          	auipc	a5,0xda
ffffffffc02044c6:	6267b783          	ld	a5,1574(a5) # ffffffffc02deae8 <idleproc>
ffffffffc02044ca:	0c878963          	beq	a5,s0,ffffffffc020459c <do_wait.part.0+0x1a2>
ffffffffc02044ce:	000da797          	auipc	a5,0xda
ffffffffc02044d2:	6227b783          	ld	a5,1570(a5) # ffffffffc02deaf0 <initproc>
ffffffffc02044d6:	0cf40363          	beq	s0,a5,ffffffffc020459c <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc02044da:	000a0663          	beqz	s4,ffffffffc02044e6 <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc02044de:	0e842783          	lw	a5,232(s0)
ffffffffc02044e2:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8f38>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02044e6:	100027f3          	csrr	a5,sstatus
ffffffffc02044ea:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc02044ec:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02044ee:	e7c1                	bnez	a5,ffffffffc0204576 <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc02044f0:	6c70                	ld	a2,216(s0)
ffffffffc02044f2:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc02044f4:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc02044f8:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc02044fa:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc02044fc:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02044fe:	6470                	ld	a2,200(s0)
ffffffffc0204500:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc0204502:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204504:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc0204506:	c319                	beqz	a4,ffffffffc020450c <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc0204508:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc020450a:	7c7c                	ld	a5,248(s0)
ffffffffc020450c:	c3b5                	beqz	a5,ffffffffc0204570 <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc020450e:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc0204512:	000da717          	auipc	a4,0xda
ffffffffc0204516:	5e670713          	addi	a4,a4,1510 # ffffffffc02deaf8 <nr_process>
ffffffffc020451a:	431c                	lw	a5,0(a4)
ffffffffc020451c:	37fd                	addiw	a5,a5,-1
ffffffffc020451e:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc0204520:	e5a9                	bnez	a1,ffffffffc020456a <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0204522:	6814                	ld	a3,16(s0)
ffffffffc0204524:	c02007b7          	lui	a5,0xc0200
ffffffffc0204528:	04f6ee63          	bltu	a3,a5,ffffffffc0204584 <do_wait.part.0+0x18a>
ffffffffc020452c:	000da797          	auipc	a5,0xda
ffffffffc0204530:	5ac7b783          	ld	a5,1452(a5) # ffffffffc02dead8 <va_pa_offset>
ffffffffc0204534:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc0204536:	82b1                	srli	a3,a3,0xc
ffffffffc0204538:	000da797          	auipc	a5,0xda
ffffffffc020453c:	5887b783          	ld	a5,1416(a5) # ffffffffc02deac0 <npage>
ffffffffc0204540:	06f6fa63          	bgeu	a3,a5,ffffffffc02045b4 <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc0204544:	00004517          	auipc	a0,0x4
ffffffffc0204548:	c6c53503          	ld	a0,-916(a0) # ffffffffc02081b0 <nbase>
ffffffffc020454c:	8e89                	sub	a3,a3,a0
ffffffffc020454e:	069a                	slli	a3,a3,0x6
ffffffffc0204550:	000da517          	auipc	a0,0xda
ffffffffc0204554:	57853503          	ld	a0,1400(a0) # ffffffffc02deac8 <pages>
ffffffffc0204558:	9536                	add	a0,a0,a3
ffffffffc020455a:	4589                	li	a1,2
ffffffffc020455c:	883fd0ef          	jal	ra,ffffffffc0201dde <free_pages>
    kfree(proc);
ffffffffc0204560:	8522                	mv	a0,s0
ffffffffc0204562:	f10fd0ef          	jal	ra,ffffffffc0201c72 <kfree>
    return 0;
ffffffffc0204566:	4501                	li	a0,0
ffffffffc0204568:	bde5                	j	ffffffffc0204460 <do_wait.part.0+0x66>
        intr_enable();
ffffffffc020456a:	c3efc0ef          	jal	ra,ffffffffc02009a8 <intr_enable>
ffffffffc020456e:	bf55                	j	ffffffffc0204522 <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc0204570:	701c                	ld	a5,32(s0)
ffffffffc0204572:	fbf8                	sd	a4,240(a5)
ffffffffc0204574:	bf79                	j	ffffffffc0204512 <do_wait.part.0+0x118>
        intr_disable();
ffffffffc0204576:	c38fc0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc020457a:	4585                	li	a1,1
ffffffffc020457c:	bf95                	j	ffffffffc02044f0 <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc020457e:	f2840413          	addi	s0,s0,-216
ffffffffc0204582:	b781                	j	ffffffffc02044c2 <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc0204584:	00002617          	auipc	a2,0x2
ffffffffc0204588:	23c60613          	addi	a2,a2,572 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc020458c:	07700593          	li	a1,119
ffffffffc0204590:	00002517          	auipc	a0,0x2
ffffffffc0204594:	1b050513          	addi	a0,a0,432 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0204598:	efbfb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc020459c:	00003617          	auipc	a2,0x3
ffffffffc02045a0:	bec60613          	addi	a2,a2,-1044 # ffffffffc0207188 <default_pmm_manager+0xaa8>
ffffffffc02045a4:	33200593          	li	a1,818
ffffffffc02045a8:	00003517          	auipc	a0,0x3
ffffffffc02045ac:	b6050513          	addi	a0,a0,-1184 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02045b0:	ee3fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02045b4:	00002617          	auipc	a2,0x2
ffffffffc02045b8:	23460613          	addi	a2,a2,564 # ffffffffc02067e8 <default_pmm_manager+0x108>
ffffffffc02045bc:	06900593          	li	a1,105
ffffffffc02045c0:	00002517          	auipc	a0,0x2
ffffffffc02045c4:	18050513          	addi	a0,a0,384 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc02045c8:	ecbfb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02045cc <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc02045cc:	1141                	addi	sp,sp,-16
ffffffffc02045ce:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc02045d0:	84ffd0ef          	jal	ra,ffffffffc0201e1e <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc02045d4:	deafd0ef          	jal	ra,ffffffffc0201bbe <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc02045d8:	4601                	li	a2,0
ffffffffc02045da:	4581                	li	a1,0
ffffffffc02045dc:	00000517          	auipc	a0,0x0
ffffffffc02045e0:	62850513          	addi	a0,a0,1576 # ffffffffc0204c04 <user_main>
ffffffffc02045e4:	c7dff0ef          	jal	ra,ffffffffc0204260 <kernel_thread>
    if (pid <= 0)
ffffffffc02045e8:	00a04563          	bgtz	a0,ffffffffc02045f2 <init_main+0x26>
ffffffffc02045ec:	a071                	j	ffffffffc0204678 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc02045ee:	2f9000ef          	jal	ra,ffffffffc02050e6 <schedule>
    if (code_store != NULL)
ffffffffc02045f2:	4581                	li	a1,0
ffffffffc02045f4:	4501                	li	a0,0
ffffffffc02045f6:	e05ff0ef          	jal	ra,ffffffffc02043fa <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc02045fa:	d975                	beqz	a0,ffffffffc02045ee <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc02045fc:	00003517          	auipc	a0,0x3
ffffffffc0204600:	bcc50513          	addi	a0,a0,-1076 # ffffffffc02071c8 <default_pmm_manager+0xae8>
ffffffffc0204604:	b95fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204608:	000da797          	auipc	a5,0xda
ffffffffc020460c:	4e87b783          	ld	a5,1256(a5) # ffffffffc02deaf0 <initproc>
ffffffffc0204610:	7bf8                	ld	a4,240(a5)
ffffffffc0204612:	e339                	bnez	a4,ffffffffc0204658 <init_main+0x8c>
ffffffffc0204614:	7ff8                	ld	a4,248(a5)
ffffffffc0204616:	e329                	bnez	a4,ffffffffc0204658 <init_main+0x8c>
ffffffffc0204618:	1007b703          	ld	a4,256(a5)
ffffffffc020461c:	ef15                	bnez	a4,ffffffffc0204658 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc020461e:	000da697          	auipc	a3,0xda
ffffffffc0204622:	4da6a683          	lw	a3,1242(a3) # ffffffffc02deaf8 <nr_process>
ffffffffc0204626:	4709                	li	a4,2
ffffffffc0204628:	0ae69463          	bne	a3,a4,ffffffffc02046d0 <init_main+0x104>
    return listelm->next;
ffffffffc020462c:	000da697          	auipc	a3,0xda
ffffffffc0204630:	41c68693          	addi	a3,a3,1052 # ffffffffc02dea48 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc0204634:	6698                	ld	a4,8(a3)
ffffffffc0204636:	0c878793          	addi	a5,a5,200
ffffffffc020463a:	06f71b63          	bne	a4,a5,ffffffffc02046b0 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc020463e:	629c                	ld	a5,0(a3)
ffffffffc0204640:	04f71863          	bne	a4,a5,ffffffffc0204690 <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc0204644:	00003517          	auipc	a0,0x3
ffffffffc0204648:	c6c50513          	addi	a0,a0,-916 # ffffffffc02072b0 <default_pmm_manager+0xbd0>
ffffffffc020464c:	b4dfb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    return 0;
}
ffffffffc0204650:	60a2                	ld	ra,8(sp)
ffffffffc0204652:	4501                	li	a0,0
ffffffffc0204654:	0141                	addi	sp,sp,16
ffffffffc0204656:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204658:	00003697          	auipc	a3,0x3
ffffffffc020465c:	b9868693          	addi	a3,a3,-1128 # ffffffffc02071f0 <default_pmm_manager+0xb10>
ffffffffc0204660:	00002617          	auipc	a2,0x2
ffffffffc0204664:	cd060613          	addi	a2,a2,-816 # ffffffffc0206330 <commands+0x828>
ffffffffc0204668:	39e00593          	li	a1,926
ffffffffc020466c:	00003517          	auipc	a0,0x3
ffffffffc0204670:	a9c50513          	addi	a0,a0,-1380 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204674:	e1ffb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("create user_main failed.\n");
ffffffffc0204678:	00003617          	auipc	a2,0x3
ffffffffc020467c:	b3060613          	addi	a2,a2,-1232 # ffffffffc02071a8 <default_pmm_manager+0xac8>
ffffffffc0204680:	39500593          	li	a1,917
ffffffffc0204684:	00003517          	auipc	a0,0x3
ffffffffc0204688:	a8450513          	addi	a0,a0,-1404 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc020468c:	e07fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204690:	00003697          	auipc	a3,0x3
ffffffffc0204694:	bf068693          	addi	a3,a3,-1040 # ffffffffc0207280 <default_pmm_manager+0xba0>
ffffffffc0204698:	00002617          	auipc	a2,0x2
ffffffffc020469c:	c9860613          	addi	a2,a2,-872 # ffffffffc0206330 <commands+0x828>
ffffffffc02046a0:	3a100593          	li	a1,929
ffffffffc02046a4:	00003517          	auipc	a0,0x3
ffffffffc02046a8:	a6450513          	addi	a0,a0,-1436 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02046ac:	de7fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc02046b0:	00003697          	auipc	a3,0x3
ffffffffc02046b4:	ba068693          	addi	a3,a3,-1120 # ffffffffc0207250 <default_pmm_manager+0xb70>
ffffffffc02046b8:	00002617          	auipc	a2,0x2
ffffffffc02046bc:	c7860613          	addi	a2,a2,-904 # ffffffffc0206330 <commands+0x828>
ffffffffc02046c0:	3a000593          	li	a1,928
ffffffffc02046c4:	00003517          	auipc	a0,0x3
ffffffffc02046c8:	a4450513          	addi	a0,a0,-1468 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02046cc:	dc7fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(nr_process == 2);
ffffffffc02046d0:	00003697          	auipc	a3,0x3
ffffffffc02046d4:	b7068693          	addi	a3,a3,-1168 # ffffffffc0207240 <default_pmm_manager+0xb60>
ffffffffc02046d8:	00002617          	auipc	a2,0x2
ffffffffc02046dc:	c5860613          	addi	a2,a2,-936 # ffffffffc0206330 <commands+0x828>
ffffffffc02046e0:	39f00593          	li	a1,927
ffffffffc02046e4:	00003517          	auipc	a0,0x3
ffffffffc02046e8:	a2450513          	addi	a0,a0,-1500 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc02046ec:	da7fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02046f0 <do_execve>:
{
ffffffffc02046f0:	7171                	addi	sp,sp,-176
ffffffffc02046f2:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc02046f4:	000dad97          	auipc	s11,0xda
ffffffffc02046f8:	3ecd8d93          	addi	s11,s11,1004 # ffffffffc02deae0 <current>
ffffffffc02046fc:	000db783          	ld	a5,0(s11)
{
ffffffffc0204700:	e54e                	sd	s3,136(sp)
ffffffffc0204702:	ed26                	sd	s1,152(sp)
    struct mm_struct *mm = current->mm;
ffffffffc0204704:	0287b983          	ld	s3,40(a5)
{
ffffffffc0204708:	e94a                	sd	s2,144(sp)
ffffffffc020470a:	f4de                	sd	s7,104(sp)
ffffffffc020470c:	892a                	mv	s2,a0
ffffffffc020470e:	8bb2                	mv	s7,a2
ffffffffc0204710:	84ae                	mv	s1,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc0204712:	862e                	mv	a2,a1
ffffffffc0204714:	4681                	li	a3,0
ffffffffc0204716:	85aa                	mv	a1,a0
ffffffffc0204718:	854e                	mv	a0,s3
{
ffffffffc020471a:	f506                	sd	ra,168(sp)
ffffffffc020471c:	f122                	sd	s0,160(sp)
ffffffffc020471e:	e152                	sd	s4,128(sp)
ffffffffc0204720:	fcd6                	sd	s5,120(sp)
ffffffffc0204722:	f8da                	sd	s6,112(sp)
ffffffffc0204724:	f0e2                	sd	s8,96(sp)
ffffffffc0204726:	ece6                	sd	s9,88(sp)
ffffffffc0204728:	e8ea                	sd	s10,80(sp)
ffffffffc020472a:	f05e                	sd	s7,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc020472c:	d0eff0ef          	jal	ra,ffffffffc0203c3a <user_mem_check>
ffffffffc0204730:	40050a63          	beqz	a0,ffffffffc0204b44 <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc0204734:	4641                	li	a2,16
ffffffffc0204736:	4581                	li	a1,0
ffffffffc0204738:	1808                	addi	a0,sp,48
ffffffffc020473a:	13c010ef          	jal	ra,ffffffffc0205876 <memset>
    memcpy(local_name, name, len);
ffffffffc020473e:	47bd                	li	a5,15
ffffffffc0204740:	8626                	mv	a2,s1
ffffffffc0204742:	1e97e263          	bltu	a5,s1,ffffffffc0204926 <do_execve+0x236>
ffffffffc0204746:	85ca                	mv	a1,s2
ffffffffc0204748:	1808                	addi	a0,sp,48
ffffffffc020474a:	13e010ef          	jal	ra,ffffffffc0205888 <memcpy>
    if (mm != NULL)
ffffffffc020474e:	1e098363          	beqz	s3,ffffffffc0204934 <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc0204752:	00002517          	auipc	a0,0x2
ffffffffc0204756:	7be50513          	addi	a0,a0,1982 # ffffffffc0206f10 <default_pmm_manager+0x830>
ffffffffc020475a:	a77fb0ef          	jal	ra,ffffffffc02001d0 <cputs>
ffffffffc020475e:	000da797          	auipc	a5,0xda
ffffffffc0204762:	3527b783          	ld	a5,850(a5) # ffffffffc02deab0 <boot_pgdir_pa>
ffffffffc0204766:	577d                	li	a4,-1
ffffffffc0204768:	177e                	slli	a4,a4,0x3f
ffffffffc020476a:	83b1                	srli	a5,a5,0xc
ffffffffc020476c:	8fd9                	or	a5,a5,a4
ffffffffc020476e:	18079073          	csrw	satp,a5
ffffffffc0204772:	0309a783          	lw	a5,48(s3) # 2030 <_binary_obj___user_faultread_out_size-0x7f08>
ffffffffc0204776:	fff7871b          	addiw	a4,a5,-1
ffffffffc020477a:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc020477e:	2c070463          	beqz	a4,ffffffffc0204a46 <do_execve+0x356>
        current->mm = NULL;
ffffffffc0204782:	000db783          	ld	a5,0(s11)
ffffffffc0204786:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc020478a:	e3bfe0ef          	jal	ra,ffffffffc02035c4 <mm_create>
ffffffffc020478e:	84aa                	mv	s1,a0
ffffffffc0204790:	1c050d63          	beqz	a0,ffffffffc020496a <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc0204794:	4505                	li	a0,1
ffffffffc0204796:	e0afd0ef          	jal	ra,ffffffffc0201da0 <alloc_pages>
ffffffffc020479a:	3a050963          	beqz	a0,ffffffffc0204b4c <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc020479e:	000dac97          	auipc	s9,0xda
ffffffffc02047a2:	32ac8c93          	addi	s9,s9,810 # ffffffffc02deac8 <pages>
ffffffffc02047a6:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc02047aa:	000dac17          	auipc	s8,0xda
ffffffffc02047ae:	316c0c13          	addi	s8,s8,790 # ffffffffc02deac0 <npage>
    return page - pages + nbase;
ffffffffc02047b2:	00004717          	auipc	a4,0x4
ffffffffc02047b6:	9fe73703          	ld	a4,-1538(a4) # ffffffffc02081b0 <nbase>
ffffffffc02047ba:	40d506b3          	sub	a3,a0,a3
ffffffffc02047be:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02047c0:	5afd                	li	s5,-1
ffffffffc02047c2:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc02047c6:	96ba                	add	a3,a3,a4
ffffffffc02047c8:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc02047ca:	00cad713          	srli	a4,s5,0xc
ffffffffc02047ce:	ec3a                	sd	a4,24(sp)
ffffffffc02047d0:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc02047d2:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02047d4:	38f77063          	bgeu	a4,a5,ffffffffc0204b54 <do_execve+0x464>
ffffffffc02047d8:	000dab17          	auipc	s6,0xda
ffffffffc02047dc:	300b0b13          	addi	s6,s6,768 # ffffffffc02dead8 <va_pa_offset>
ffffffffc02047e0:	000b3903          	ld	s2,0(s6)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc02047e4:	6605                	lui	a2,0x1
ffffffffc02047e6:	000da597          	auipc	a1,0xda
ffffffffc02047ea:	2d25b583          	ld	a1,722(a1) # ffffffffc02deab8 <boot_pgdir_va>
ffffffffc02047ee:	9936                	add	s2,s2,a3
ffffffffc02047f0:	854a                	mv	a0,s2
ffffffffc02047f2:	096010ef          	jal	ra,ffffffffc0205888 <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc02047f6:	7782                	ld	a5,32(sp)
ffffffffc02047f8:	4398                	lw	a4,0(a5)
ffffffffc02047fa:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc02047fe:	0124bc23          	sd	s2,24(s1)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc0204802:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_sched_test_out_size+0x464b70a7>
ffffffffc0204806:	14f71863          	bne	a4,a5,ffffffffc0204956 <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020480a:	7682                	ld	a3,32(sp)
ffffffffc020480c:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204810:	0206b983          	ld	s3,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204814:	00371793          	slli	a5,a4,0x3
ffffffffc0204818:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc020481a:	99b6                	add	s3,s3,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020481c:	078e                	slli	a5,a5,0x3
ffffffffc020481e:	97ce                	add	a5,a5,s3
ffffffffc0204820:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc0204822:	00f9fc63          	bgeu	s3,a5,ffffffffc020483a <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc0204826:	0009a783          	lw	a5,0(s3)
ffffffffc020482a:	4705                	li	a4,1
ffffffffc020482c:	14e78163          	beq	a5,a4,ffffffffc020496e <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc0204830:	77a2                	ld	a5,40(sp)
ffffffffc0204832:	03898993          	addi	s3,s3,56
ffffffffc0204836:	fef9e8e3          	bltu	s3,a5,ffffffffc0204826 <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc020483a:	4701                	li	a4,0
ffffffffc020483c:	46ad                	li	a3,11
ffffffffc020483e:	00100637          	lui	a2,0x100
ffffffffc0204842:	7ff005b7          	lui	a1,0x7ff00
ffffffffc0204846:	8526                	mv	a0,s1
ffffffffc0204848:	f0ffe0ef          	jal	ra,ffffffffc0203756 <mm_map>
ffffffffc020484c:	8a2a                	mv	s4,a0
ffffffffc020484e:	1e051263          	bnez	a0,ffffffffc0204a32 <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204852:	6c88                	ld	a0,24(s1)
ffffffffc0204854:	467d                	li	a2,31
ffffffffc0204856:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc020485a:	c85fe0ef          	jal	ra,ffffffffc02034de <pgdir_alloc_page>
ffffffffc020485e:	38050363          	beqz	a0,ffffffffc0204be4 <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204862:	6c88                	ld	a0,24(s1)
ffffffffc0204864:	467d                	li	a2,31
ffffffffc0204866:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc020486a:	c75fe0ef          	jal	ra,ffffffffc02034de <pgdir_alloc_page>
ffffffffc020486e:	34050b63          	beqz	a0,ffffffffc0204bc4 <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204872:	6c88                	ld	a0,24(s1)
ffffffffc0204874:	467d                	li	a2,31
ffffffffc0204876:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc020487a:	c65fe0ef          	jal	ra,ffffffffc02034de <pgdir_alloc_page>
ffffffffc020487e:	32050363          	beqz	a0,ffffffffc0204ba4 <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204882:	6c88                	ld	a0,24(s1)
ffffffffc0204884:	467d                	li	a2,31
ffffffffc0204886:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc020488a:	c55fe0ef          	jal	ra,ffffffffc02034de <pgdir_alloc_page>
ffffffffc020488e:	2e050b63          	beqz	a0,ffffffffc0204b84 <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc0204892:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc0204894:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204898:	6c94                	ld	a3,24(s1)
ffffffffc020489a:	2785                	addiw	a5,a5,1
ffffffffc020489c:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc020489e:	f604                	sd	s1,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc02048a0:	c02007b7          	lui	a5,0xc0200
ffffffffc02048a4:	2cf6e463          	bltu	a3,a5,ffffffffc0204b6c <do_execve+0x47c>
ffffffffc02048a8:	000b3783          	ld	a5,0(s6)
ffffffffc02048ac:	577d                	li	a4,-1
ffffffffc02048ae:	177e                	slli	a4,a4,0x3f
ffffffffc02048b0:	8e9d                	sub	a3,a3,a5
ffffffffc02048b2:	00c6d793          	srli	a5,a3,0xc
ffffffffc02048b6:	f654                	sd	a3,168(a2)
ffffffffc02048b8:	8fd9                	or	a5,a5,a4
ffffffffc02048ba:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc02048be:	7240                	ld	s0,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02048c0:	4581                	li	a1,0
ffffffffc02048c2:	12000613          	li	a2,288
ffffffffc02048c6:	8522                	mv	a0,s0
    uintptr_t sstatus = tf->status;
ffffffffc02048c8:	10043483          	ld	s1,256(s0)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02048cc:	7ab000ef          	jal	ra,ffffffffc0205876 <memset>
    tf->epc = elf->e_entry;                           // 设置程序入口点
ffffffffc02048d0:	7782                	ld	a5,32(sp)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048d2:	000db903          	ld	s2,0(s11)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02048d6:	edf4f493          	andi	s1,s1,-289
    tf->epc = elf->e_entry;                           // 设置程序入口点
ffffffffc02048da:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;                           // 设置用户栈栈顶
ffffffffc02048dc:	4785                	li	a5,1
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048de:	0b490913          	addi	s2,s2,180 # ffffffff800000b4 <_binary_obj___user_sched_test_out_size+0xffffffff7fff2bdc>
    tf->gpr.sp = USTACKTOP;                           // 设置用户栈栈顶
ffffffffc02048e2:	07fe                	slli	a5,a5,0x1f
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02048e4:	0204e493          	ori	s1,s1,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048e8:	4641                	li	a2,16
ffffffffc02048ea:	4581                	li	a1,0
    tf->gpr.sp = USTACKTOP;                           // 设置用户栈栈顶
ffffffffc02048ec:	e81c                	sd	a5,16(s0)
    tf->epc = elf->e_entry;                           // 设置程序入口点
ffffffffc02048ee:	10e43423          	sd	a4,264(s0)
    tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc02048f2:	10943023          	sd	s1,256(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc02048f6:	854a                	mv	a0,s2
ffffffffc02048f8:	77f000ef          	jal	ra,ffffffffc0205876 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc02048fc:	463d                	li	a2,15
ffffffffc02048fe:	180c                	addi	a1,sp,48
ffffffffc0204900:	854a                	mv	a0,s2
ffffffffc0204902:	787000ef          	jal	ra,ffffffffc0205888 <memcpy>
}
ffffffffc0204906:	70aa                	ld	ra,168(sp)
ffffffffc0204908:	740a                	ld	s0,160(sp)
ffffffffc020490a:	64ea                	ld	s1,152(sp)
ffffffffc020490c:	694a                	ld	s2,144(sp)
ffffffffc020490e:	69aa                	ld	s3,136(sp)
ffffffffc0204910:	7ae6                	ld	s5,120(sp)
ffffffffc0204912:	7b46                	ld	s6,112(sp)
ffffffffc0204914:	7ba6                	ld	s7,104(sp)
ffffffffc0204916:	7c06                	ld	s8,96(sp)
ffffffffc0204918:	6ce6                	ld	s9,88(sp)
ffffffffc020491a:	6d46                	ld	s10,80(sp)
ffffffffc020491c:	6da6                	ld	s11,72(sp)
ffffffffc020491e:	8552                	mv	a0,s4
ffffffffc0204920:	6a0a                	ld	s4,128(sp)
ffffffffc0204922:	614d                	addi	sp,sp,176
ffffffffc0204924:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204926:	463d                	li	a2,15
ffffffffc0204928:	85ca                	mv	a1,s2
ffffffffc020492a:	1808                	addi	a0,sp,48
ffffffffc020492c:	75d000ef          	jal	ra,ffffffffc0205888 <memcpy>
    if (mm != NULL)
ffffffffc0204930:	e20991e3          	bnez	s3,ffffffffc0204752 <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204934:	000db783          	ld	a5,0(s11)
ffffffffc0204938:	779c                	ld	a5,40(a5)
ffffffffc020493a:	e40788e3          	beqz	a5,ffffffffc020478a <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc020493e:	00003617          	auipc	a2,0x3
ffffffffc0204942:	99260613          	addi	a2,a2,-1646 # ffffffffc02072d0 <default_pmm_manager+0xbf0>
ffffffffc0204946:	21a00593          	li	a1,538
ffffffffc020494a:	00002517          	auipc	a0,0x2
ffffffffc020494e:	7be50513          	addi	a0,a0,1982 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204952:	b41fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    put_pgdir(mm);
ffffffffc0204956:	8526                	mv	a0,s1
ffffffffc0204958:	c22ff0ef          	jal	ra,ffffffffc0203d7a <put_pgdir>
    mm_destroy(mm);
ffffffffc020495c:	8526                	mv	a0,s1
ffffffffc020495e:	da7fe0ef          	jal	ra,ffffffffc0203704 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204962:	5a61                	li	s4,-8
    do_exit(ret);
ffffffffc0204964:	8552                	mv	a0,s4
ffffffffc0204966:	94bff0ef          	jal	ra,ffffffffc02042b0 <do_exit>
    int ret = -E_NO_MEM;
ffffffffc020496a:	5a71                	li	s4,-4
ffffffffc020496c:	bfe5                	j	ffffffffc0204964 <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc020496e:	0289b603          	ld	a2,40(s3)
ffffffffc0204972:	0209b783          	ld	a5,32(s3)
ffffffffc0204976:	1cf66d63          	bltu	a2,a5,ffffffffc0204b50 <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc020497a:	0049a783          	lw	a5,4(s3)
ffffffffc020497e:	0017f693          	andi	a3,a5,1
ffffffffc0204982:	c291                	beqz	a3,ffffffffc0204986 <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204984:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204986:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc020498a:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc020498c:	e779                	bnez	a4,ffffffffc0204a5a <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc020498e:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204990:	c781                	beqz	a5,ffffffffc0204998 <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204992:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204996:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204998:	0026f793          	andi	a5,a3,2
ffffffffc020499c:	e3f1                	bnez	a5,ffffffffc0204a60 <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc020499e:	0046f793          	andi	a5,a3,4
ffffffffc02049a2:	c399                	beqz	a5,ffffffffc02049a8 <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc02049a4:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc02049a8:	0109b583          	ld	a1,16(s3)
ffffffffc02049ac:	4701                	li	a4,0
ffffffffc02049ae:	8526                	mv	a0,s1
ffffffffc02049b0:	da7fe0ef          	jal	ra,ffffffffc0203756 <mm_map>
ffffffffc02049b4:	8a2a                	mv	s4,a0
ffffffffc02049b6:	ed35                	bnez	a0,ffffffffc0204a32 <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc02049b8:	0109bb83          	ld	s7,16(s3)
ffffffffc02049bc:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc02049be:	0209ba03          	ld	s4,32(s3)
        unsigned char *from = binary + ph->p_offset;
ffffffffc02049c2:	0089b903          	ld	s2,8(s3)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc02049c6:	00fbfab3          	and	s5,s7,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc02049ca:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc02049cc:	9a5e                	add	s4,s4,s7
        unsigned char *from = binary + ph->p_offset;
ffffffffc02049ce:	993e                	add	s2,s2,a5
        while (start < end)
ffffffffc02049d0:	054be963          	bltu	s7,s4,ffffffffc0204a22 <do_execve+0x332>
ffffffffc02049d4:	aa95                	j	ffffffffc0204b48 <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc02049d6:	6785                	lui	a5,0x1
ffffffffc02049d8:	415b8533          	sub	a0,s7,s5
ffffffffc02049dc:	9abe                	add	s5,s5,a5
ffffffffc02049de:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc02049e2:	015a7463          	bgeu	s4,s5,ffffffffc02049ea <do_execve+0x2fa>
                size -= la - end;
ffffffffc02049e6:	417a0633          	sub	a2,s4,s7
    return page - pages + nbase;
ffffffffc02049ea:	000cb683          	ld	a3,0(s9)
ffffffffc02049ee:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc02049f0:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc02049f4:	40d406b3          	sub	a3,s0,a3
ffffffffc02049f8:	8699                	srai	a3,a3,0x6
ffffffffc02049fa:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc02049fc:	67e2                	ld	a5,24(sp)
ffffffffc02049fe:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204a02:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204a04:	14b87863          	bgeu	a6,a1,ffffffffc0204b54 <do_execve+0x464>
ffffffffc0204a08:	000b3803          	ld	a6,0(s6)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204a0c:	85ca                	mv	a1,s2
            start += size, from += size;
ffffffffc0204a0e:	9bb2                	add	s7,s7,a2
ffffffffc0204a10:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204a12:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204a14:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204a16:	673000ef          	jal	ra,ffffffffc0205888 <memcpy>
            start += size, from += size;
ffffffffc0204a1a:	6622                	ld	a2,8(sp)
ffffffffc0204a1c:	9932                	add	s2,s2,a2
        while (start < end)
ffffffffc0204a1e:	054bf363          	bgeu	s7,s4,ffffffffc0204a64 <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204a22:	6c88                	ld	a0,24(s1)
ffffffffc0204a24:	866a                	mv	a2,s10
ffffffffc0204a26:	85d6                	mv	a1,s5
ffffffffc0204a28:	ab7fe0ef          	jal	ra,ffffffffc02034de <pgdir_alloc_page>
ffffffffc0204a2c:	842a                	mv	s0,a0
ffffffffc0204a2e:	f545                	bnez	a0,ffffffffc02049d6 <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204a30:	5a71                	li	s4,-4
    exit_mmap(mm);
ffffffffc0204a32:	8526                	mv	a0,s1
ffffffffc0204a34:	e6dfe0ef          	jal	ra,ffffffffc02038a0 <exit_mmap>
    put_pgdir(mm);
ffffffffc0204a38:	8526                	mv	a0,s1
ffffffffc0204a3a:	b40ff0ef          	jal	ra,ffffffffc0203d7a <put_pgdir>
    mm_destroy(mm);
ffffffffc0204a3e:	8526                	mv	a0,s1
ffffffffc0204a40:	cc5fe0ef          	jal	ra,ffffffffc0203704 <mm_destroy>
    return ret;
ffffffffc0204a44:	b705                	j	ffffffffc0204964 <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204a46:	854e                	mv	a0,s3
ffffffffc0204a48:	e59fe0ef          	jal	ra,ffffffffc02038a0 <exit_mmap>
            put_pgdir(mm);
ffffffffc0204a4c:	854e                	mv	a0,s3
ffffffffc0204a4e:	b2cff0ef          	jal	ra,ffffffffc0203d7a <put_pgdir>
            mm_destroy(mm);
ffffffffc0204a52:	854e                	mv	a0,s3
ffffffffc0204a54:	cb1fe0ef          	jal	ra,ffffffffc0203704 <mm_destroy>
ffffffffc0204a58:	b32d                	j	ffffffffc0204782 <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204a5a:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204a5e:	fb95                	bnez	a5,ffffffffc0204992 <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204a60:	4d5d                	li	s10,23
ffffffffc0204a62:	bf35                	j	ffffffffc020499e <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204a64:	0109b683          	ld	a3,16(s3)
ffffffffc0204a68:	0289b903          	ld	s2,40(s3)
ffffffffc0204a6c:	9936                	add	s2,s2,a3
        if (start < la)
ffffffffc0204a6e:	075bfd63          	bgeu	s7,s5,ffffffffc0204ae8 <do_execve+0x3f8>
            if (start == end)
ffffffffc0204a72:	db790fe3          	beq	s2,s7,ffffffffc0204830 <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204a76:	6785                	lui	a5,0x1
ffffffffc0204a78:	00fb8533          	add	a0,s7,a5
ffffffffc0204a7c:	41550533          	sub	a0,a0,s5
                size -= la - end;
ffffffffc0204a80:	41790a33          	sub	s4,s2,s7
            if (end < la)
ffffffffc0204a84:	0b597d63          	bgeu	s2,s5,ffffffffc0204b3e <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204a88:	000cb683          	ld	a3,0(s9)
ffffffffc0204a8c:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204a8e:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204a92:	40d406b3          	sub	a3,s0,a3
ffffffffc0204a96:	8699                	srai	a3,a3,0x6
ffffffffc0204a98:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204a9a:	67e2                	ld	a5,24(sp)
ffffffffc0204a9c:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204aa0:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204aa2:	0ac5f963          	bgeu	a1,a2,ffffffffc0204b54 <do_execve+0x464>
ffffffffc0204aa6:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204aaa:	8652                	mv	a2,s4
ffffffffc0204aac:	4581                	li	a1,0
ffffffffc0204aae:	96c2                	add	a3,a3,a6
ffffffffc0204ab0:	9536                	add	a0,a0,a3
ffffffffc0204ab2:	5c5000ef          	jal	ra,ffffffffc0205876 <memset>
            start += size;
ffffffffc0204ab6:	017a0733          	add	a4,s4,s7
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204aba:	03597463          	bgeu	s2,s5,ffffffffc0204ae2 <do_execve+0x3f2>
ffffffffc0204abe:	d6e909e3          	beq	s2,a4,ffffffffc0204830 <do_execve+0x140>
ffffffffc0204ac2:	00003697          	auipc	a3,0x3
ffffffffc0204ac6:	83668693          	addi	a3,a3,-1994 # ffffffffc02072f8 <default_pmm_manager+0xc18>
ffffffffc0204aca:	00002617          	auipc	a2,0x2
ffffffffc0204ace:	86660613          	addi	a2,a2,-1946 # ffffffffc0206330 <commands+0x828>
ffffffffc0204ad2:	28300593          	li	a1,643
ffffffffc0204ad6:	00002517          	auipc	a0,0x2
ffffffffc0204ada:	63250513          	addi	a0,a0,1586 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204ade:	9b5fb0ef          	jal	ra,ffffffffc0200492 <__panic>
ffffffffc0204ae2:	ff5710e3          	bne	a4,s5,ffffffffc0204ac2 <do_execve+0x3d2>
ffffffffc0204ae6:	8bd6                	mv	s7,s5
        while (start < end)
ffffffffc0204ae8:	d52bf4e3          	bgeu	s7,s2,ffffffffc0204830 <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204aec:	6c88                	ld	a0,24(s1)
ffffffffc0204aee:	866a                	mv	a2,s10
ffffffffc0204af0:	85d6                	mv	a1,s5
ffffffffc0204af2:	9edfe0ef          	jal	ra,ffffffffc02034de <pgdir_alloc_page>
ffffffffc0204af6:	842a                	mv	s0,a0
ffffffffc0204af8:	dd05                	beqz	a0,ffffffffc0204a30 <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204afa:	6785                	lui	a5,0x1
ffffffffc0204afc:	415b8533          	sub	a0,s7,s5
ffffffffc0204b00:	9abe                	add	s5,s5,a5
ffffffffc0204b02:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204b06:	01597463          	bgeu	s2,s5,ffffffffc0204b0e <do_execve+0x41e>
                size -= la - end;
ffffffffc0204b0a:	41790633          	sub	a2,s2,s7
    return page - pages + nbase;
ffffffffc0204b0e:	000cb683          	ld	a3,0(s9)
ffffffffc0204b12:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b14:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204b18:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b1c:	8699                	srai	a3,a3,0x6
ffffffffc0204b1e:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b20:	67e2                	ld	a5,24(sp)
ffffffffc0204b22:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b26:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b28:	02b87663          	bgeu	a6,a1,ffffffffc0204b54 <do_execve+0x464>
ffffffffc0204b2c:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204b30:	4581                	li	a1,0
            start += size;
ffffffffc0204b32:	9bb2                	add	s7,s7,a2
ffffffffc0204b34:	96c2                	add	a3,a3,a6
            memset(page2kva(page) + off, 0, size);
ffffffffc0204b36:	9536                	add	a0,a0,a3
ffffffffc0204b38:	53f000ef          	jal	ra,ffffffffc0205876 <memset>
ffffffffc0204b3c:	b775                	j	ffffffffc0204ae8 <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204b3e:	417a8a33          	sub	s4,s5,s7
ffffffffc0204b42:	b799                	j	ffffffffc0204a88 <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204b44:	5a75                	li	s4,-3
ffffffffc0204b46:	b3c1                	j	ffffffffc0204906 <do_execve+0x216>
        while (start < end)
ffffffffc0204b48:	86de                	mv	a3,s7
ffffffffc0204b4a:	bf39                	j	ffffffffc0204a68 <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204b4c:	5a71                	li	s4,-4
ffffffffc0204b4e:	bdc5                	j	ffffffffc0204a3e <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204b50:	5a61                	li	s4,-8
ffffffffc0204b52:	b5c5                	j	ffffffffc0204a32 <do_execve+0x342>
ffffffffc0204b54:	00002617          	auipc	a2,0x2
ffffffffc0204b58:	bc460613          	addi	a2,a2,-1084 # ffffffffc0206718 <default_pmm_manager+0x38>
ffffffffc0204b5c:	07100593          	li	a1,113
ffffffffc0204b60:	00002517          	auipc	a0,0x2
ffffffffc0204b64:	be050513          	addi	a0,a0,-1056 # ffffffffc0206740 <default_pmm_manager+0x60>
ffffffffc0204b68:	92bfb0ef          	jal	ra,ffffffffc0200492 <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204b6c:	00002617          	auipc	a2,0x2
ffffffffc0204b70:	c5460613          	addi	a2,a2,-940 # ffffffffc02067c0 <default_pmm_manager+0xe0>
ffffffffc0204b74:	2a200593          	li	a1,674
ffffffffc0204b78:	00002517          	auipc	a0,0x2
ffffffffc0204b7c:	59050513          	addi	a0,a0,1424 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204b80:	913fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204b84:	00003697          	auipc	a3,0x3
ffffffffc0204b88:	88c68693          	addi	a3,a3,-1908 # ffffffffc0207410 <default_pmm_manager+0xd30>
ffffffffc0204b8c:	00001617          	auipc	a2,0x1
ffffffffc0204b90:	7a460613          	addi	a2,a2,1956 # ffffffffc0206330 <commands+0x828>
ffffffffc0204b94:	29d00593          	li	a1,669
ffffffffc0204b98:	00002517          	auipc	a0,0x2
ffffffffc0204b9c:	57050513          	addi	a0,a0,1392 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204ba0:	8f3fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204ba4:	00003697          	auipc	a3,0x3
ffffffffc0204ba8:	82468693          	addi	a3,a3,-2012 # ffffffffc02073c8 <default_pmm_manager+0xce8>
ffffffffc0204bac:	00001617          	auipc	a2,0x1
ffffffffc0204bb0:	78460613          	addi	a2,a2,1924 # ffffffffc0206330 <commands+0x828>
ffffffffc0204bb4:	29c00593          	li	a1,668
ffffffffc0204bb8:	00002517          	auipc	a0,0x2
ffffffffc0204bbc:	55050513          	addi	a0,a0,1360 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204bc0:	8d3fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204bc4:	00002697          	auipc	a3,0x2
ffffffffc0204bc8:	7bc68693          	addi	a3,a3,1980 # ffffffffc0207380 <default_pmm_manager+0xca0>
ffffffffc0204bcc:	00001617          	auipc	a2,0x1
ffffffffc0204bd0:	76460613          	addi	a2,a2,1892 # ffffffffc0206330 <commands+0x828>
ffffffffc0204bd4:	29b00593          	li	a1,667
ffffffffc0204bd8:	00002517          	auipc	a0,0x2
ffffffffc0204bdc:	53050513          	addi	a0,a0,1328 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204be0:	8b3fb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204be4:	00002697          	auipc	a3,0x2
ffffffffc0204be8:	75468693          	addi	a3,a3,1876 # ffffffffc0207338 <default_pmm_manager+0xc58>
ffffffffc0204bec:	00001617          	auipc	a2,0x1
ffffffffc0204bf0:	74460613          	addi	a2,a2,1860 # ffffffffc0206330 <commands+0x828>
ffffffffc0204bf4:	29a00593          	li	a1,666
ffffffffc0204bf8:	00002517          	auipc	a0,0x2
ffffffffc0204bfc:	51050513          	addi	a0,a0,1296 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204c00:	893fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204c04 <user_main>:
{
ffffffffc0204c04:	1101                	addi	sp,sp,-32
ffffffffc0204c06:	e04a                	sd	s2,0(sp)
    KERNEL_EXECVE(priority);  // 测试调度算法
ffffffffc0204c08:	000da917          	auipc	s2,0xda
ffffffffc0204c0c:	ed890913          	addi	s2,s2,-296 # ffffffffc02deae0 <current>
ffffffffc0204c10:	00093783          	ld	a5,0(s2)
ffffffffc0204c14:	00003617          	auipc	a2,0x3
ffffffffc0204c18:	84460613          	addi	a2,a2,-1980 # ffffffffc0207458 <default_pmm_manager+0xd78>
ffffffffc0204c1c:	00003517          	auipc	a0,0x3
ffffffffc0204c20:	84c50513          	addi	a0,a0,-1972 # ffffffffc0207468 <default_pmm_manager+0xd88>
ffffffffc0204c24:	43cc                	lw	a1,4(a5)
{
ffffffffc0204c26:	ec06                	sd	ra,24(sp)
ffffffffc0204c28:	e822                	sd	s0,16(sp)
ffffffffc0204c2a:	e426                	sd	s1,8(sp)
    KERNEL_EXECVE(priority);  // 测试调度算法
ffffffffc0204c2c:	d6cfb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    size_t len = strlen(name);
ffffffffc0204c30:	00003517          	auipc	a0,0x3
ffffffffc0204c34:	82850513          	addi	a0,a0,-2008 # ffffffffc0207458 <default_pmm_manager+0xd78>
ffffffffc0204c38:	39d000ef          	jal	ra,ffffffffc02057d4 <strlen>
    struct trapframe *old_tf = current->tf;
ffffffffc0204c3c:	00093783          	ld	a5,0(s2)
    size_t len = strlen(name);
ffffffffc0204c40:	84aa                	mv	s1,a0
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204c42:	12000613          	li	a2,288
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
ffffffffc0204c46:	6b80                	ld	s0,16(a5)
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204c48:	73cc                	ld	a1,160(a5)
    struct trapframe *new_tf = (struct trapframe *)(current->kstack + KSTACKSIZE - sizeof(struct trapframe));
ffffffffc0204c4a:	6789                	lui	a5,0x2
ffffffffc0204c4c:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x8058>
ffffffffc0204c50:	943e                	add	s0,s0,a5
    memcpy(new_tf, old_tf, sizeof(struct trapframe));
ffffffffc0204c52:	8522                	mv	a0,s0
ffffffffc0204c54:	435000ef          	jal	ra,ffffffffc0205888 <memcpy>
    current->tf = new_tf;
ffffffffc0204c58:	00093783          	ld	a5,0(s2)
    ret = do_execve(name, len, binary, size);
ffffffffc0204c5c:	3fe07697          	auipc	a3,0x3fe07
ffffffffc0204c60:	adc68693          	addi	a3,a3,-1316 # b738 <_binary_obj___user_priority_out_size>
ffffffffc0204c64:	0007d617          	auipc	a2,0x7d
ffffffffc0204c68:	08460613          	addi	a2,a2,132 # ffffffffc0281ce8 <_binary_obj___user_priority_out_start>
    current->tf = new_tf;
ffffffffc0204c6c:	f3c0                	sd	s0,160(a5)
    ret = do_execve(name, len, binary, size);
ffffffffc0204c6e:	85a6                	mv	a1,s1
ffffffffc0204c70:	00002517          	auipc	a0,0x2
ffffffffc0204c74:	7e850513          	addi	a0,a0,2024 # ffffffffc0207458 <default_pmm_manager+0xd78>
ffffffffc0204c78:	a79ff0ef          	jal	ra,ffffffffc02046f0 <do_execve>
    asm volatile(
ffffffffc0204c7c:	8122                	mv	sp,s0
ffffffffc0204c7e:	a06fc06f          	j	ffffffffc0200e84 <__trapret>
    panic("user_main execve failed.\n");
ffffffffc0204c82:	00003617          	auipc	a2,0x3
ffffffffc0204c86:	80e60613          	addi	a2,a2,-2034 # ffffffffc0207490 <default_pmm_manager+0xdb0>
ffffffffc0204c8a:	38800593          	li	a1,904
ffffffffc0204c8e:	00002517          	auipc	a0,0x2
ffffffffc0204c92:	47a50513          	addi	a0,a0,1146 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204c96:	ffcfb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204c9a <do_yield>:
    current->need_resched = 1;
ffffffffc0204c9a:	000da797          	auipc	a5,0xda
ffffffffc0204c9e:	e467b783          	ld	a5,-442(a5) # ffffffffc02deae0 <current>
ffffffffc0204ca2:	4705                	li	a4,1
ffffffffc0204ca4:	ef98                	sd	a4,24(a5)
}
ffffffffc0204ca6:	4501                	li	a0,0
ffffffffc0204ca8:	8082                	ret

ffffffffc0204caa <do_wait>:
{
ffffffffc0204caa:	1101                	addi	sp,sp,-32
ffffffffc0204cac:	e822                	sd	s0,16(sp)
ffffffffc0204cae:	e426                	sd	s1,8(sp)
ffffffffc0204cb0:	ec06                	sd	ra,24(sp)
ffffffffc0204cb2:	842e                	mv	s0,a1
ffffffffc0204cb4:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204cb6:	c999                	beqz	a1,ffffffffc0204ccc <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204cb8:	000da797          	auipc	a5,0xda
ffffffffc0204cbc:	e287b783          	ld	a5,-472(a5) # ffffffffc02deae0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204cc0:	7788                	ld	a0,40(a5)
ffffffffc0204cc2:	4685                	li	a3,1
ffffffffc0204cc4:	4611                	li	a2,4
ffffffffc0204cc6:	f75fe0ef          	jal	ra,ffffffffc0203c3a <user_mem_check>
ffffffffc0204cca:	c909                	beqz	a0,ffffffffc0204cdc <do_wait+0x32>
ffffffffc0204ccc:	85a2                	mv	a1,s0
}
ffffffffc0204cce:	6442                	ld	s0,16(sp)
ffffffffc0204cd0:	60e2                	ld	ra,24(sp)
ffffffffc0204cd2:	8526                	mv	a0,s1
ffffffffc0204cd4:	64a2                	ld	s1,8(sp)
ffffffffc0204cd6:	6105                	addi	sp,sp,32
ffffffffc0204cd8:	f22ff06f          	j	ffffffffc02043fa <do_wait.part.0>
ffffffffc0204cdc:	60e2                	ld	ra,24(sp)
ffffffffc0204cde:	6442                	ld	s0,16(sp)
ffffffffc0204ce0:	64a2                	ld	s1,8(sp)
ffffffffc0204ce2:	5575                	li	a0,-3
ffffffffc0204ce4:	6105                	addi	sp,sp,32
ffffffffc0204ce6:	8082                	ret

ffffffffc0204ce8 <do_kill>:
{
ffffffffc0204ce8:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204cea:	6789                	lui	a5,0x2
{
ffffffffc0204cec:	e406                	sd	ra,8(sp)
ffffffffc0204cee:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204cf0:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204cf4:	17f9                	addi	a5,a5,-2
ffffffffc0204cf6:	02e7e963          	bltu	a5,a4,ffffffffc0204d28 <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204cfa:	842a                	mv	s0,a0
ffffffffc0204cfc:	45a9                	li	a1,10
ffffffffc0204cfe:	2501                	sext.w	a0,a0
ffffffffc0204d00:	6d0000ef          	jal	ra,ffffffffc02053d0 <hash32>
ffffffffc0204d04:	02051793          	slli	a5,a0,0x20
ffffffffc0204d08:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204d0c:	000d6797          	auipc	a5,0xd6
ffffffffc0204d10:	d3c78793          	addi	a5,a5,-708 # ffffffffc02daa48 <hash_list>
ffffffffc0204d14:	953e                	add	a0,a0,a5
ffffffffc0204d16:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204d18:	a029                	j	ffffffffc0204d22 <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204d1a:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204d1e:	00870b63          	beq	a4,s0,ffffffffc0204d34 <do_kill+0x4c>
ffffffffc0204d22:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204d24:	fef51be3          	bne	a0,a5,ffffffffc0204d1a <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204d28:	5475                	li	s0,-3
}
ffffffffc0204d2a:	60a2                	ld	ra,8(sp)
ffffffffc0204d2c:	8522                	mv	a0,s0
ffffffffc0204d2e:	6402                	ld	s0,0(sp)
ffffffffc0204d30:	0141                	addi	sp,sp,16
ffffffffc0204d32:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204d34:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204d38:	00177693          	andi	a3,a4,1
ffffffffc0204d3c:	e295                	bnez	a3,ffffffffc0204d60 <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204d3e:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204d40:	00176713          	ori	a4,a4,1
ffffffffc0204d44:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204d48:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204d4a:	fe06d0e3          	bgez	a3,ffffffffc0204d2a <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204d4e:	f2878513          	addi	a0,a5,-216
ffffffffc0204d52:	2e2000ef          	jal	ra,ffffffffc0205034 <wakeup_proc>
}
ffffffffc0204d56:	60a2                	ld	ra,8(sp)
ffffffffc0204d58:	8522                	mv	a0,s0
ffffffffc0204d5a:	6402                	ld	s0,0(sp)
ffffffffc0204d5c:	0141                	addi	sp,sp,16
ffffffffc0204d5e:	8082                	ret
        return -E_KILLED;
ffffffffc0204d60:	545d                	li	s0,-9
ffffffffc0204d62:	b7e1                	j	ffffffffc0204d2a <do_kill+0x42>

ffffffffc0204d64 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204d64:	1101                	addi	sp,sp,-32
ffffffffc0204d66:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204d68:	000da797          	auipc	a5,0xda
ffffffffc0204d6c:	ce078793          	addi	a5,a5,-800 # ffffffffc02dea48 <proc_list>
ffffffffc0204d70:	ec06                	sd	ra,24(sp)
ffffffffc0204d72:	e822                	sd	s0,16(sp)
ffffffffc0204d74:	e04a                	sd	s2,0(sp)
ffffffffc0204d76:	000d6497          	auipc	s1,0xd6
ffffffffc0204d7a:	cd248493          	addi	s1,s1,-814 # ffffffffc02daa48 <hash_list>
ffffffffc0204d7e:	e79c                	sd	a5,8(a5)
ffffffffc0204d80:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204d82:	000da717          	auipc	a4,0xda
ffffffffc0204d86:	cc670713          	addi	a4,a4,-826 # ffffffffc02dea48 <proc_list>
ffffffffc0204d8a:	87a6                	mv	a5,s1
ffffffffc0204d8c:	e79c                	sd	a5,8(a5)
ffffffffc0204d8e:	e39c                	sd	a5,0(a5)
ffffffffc0204d90:	07c1                	addi	a5,a5,16
ffffffffc0204d92:	fef71de3          	bne	a4,a5,ffffffffc0204d8c <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204d96:	f41fe0ef          	jal	ra,ffffffffc0203cd6 <alloc_proc>
ffffffffc0204d9a:	000da917          	auipc	s2,0xda
ffffffffc0204d9e:	d4e90913          	addi	s2,s2,-690 # ffffffffc02deae8 <idleproc>
ffffffffc0204da2:	00a93023          	sd	a0,0(s2)
ffffffffc0204da6:	0e050f63          	beqz	a0,ffffffffc0204ea4 <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204daa:	4789                	li	a5,2
ffffffffc0204dac:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204dae:	00004797          	auipc	a5,0x4
ffffffffc0204db2:	25278793          	addi	a5,a5,594 # ffffffffc0209000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204db6:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204dba:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204dbc:	4785                	li	a5,1
ffffffffc0204dbe:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204dc0:	4641                	li	a2,16
ffffffffc0204dc2:	4581                	li	a1,0
ffffffffc0204dc4:	8522                	mv	a0,s0
ffffffffc0204dc6:	2b1000ef          	jal	ra,ffffffffc0205876 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204dca:	463d                	li	a2,15
ffffffffc0204dcc:	00002597          	auipc	a1,0x2
ffffffffc0204dd0:	6fc58593          	addi	a1,a1,1788 # ffffffffc02074c8 <default_pmm_manager+0xde8>
ffffffffc0204dd4:	8522                	mv	a0,s0
ffffffffc0204dd6:	2b3000ef          	jal	ra,ffffffffc0205888 <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204dda:	000da717          	auipc	a4,0xda
ffffffffc0204dde:	d1e70713          	addi	a4,a4,-738 # ffffffffc02deaf8 <nr_process>
ffffffffc0204de2:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204de4:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204de8:	4601                	li	a2,0
    nr_process++;
ffffffffc0204dea:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204dec:	4581                	li	a1,0
ffffffffc0204dee:	fffff517          	auipc	a0,0xfffff
ffffffffc0204df2:	7de50513          	addi	a0,a0,2014 # ffffffffc02045cc <init_main>
    nr_process++;
ffffffffc0204df6:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204df8:	000da797          	auipc	a5,0xda
ffffffffc0204dfc:	ced7b423          	sd	a3,-792(a5) # ffffffffc02deae0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e00:	c60ff0ef          	jal	ra,ffffffffc0204260 <kernel_thread>
ffffffffc0204e04:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204e06:	08a05363          	blez	a0,ffffffffc0204e8c <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204e0a:	6789                	lui	a5,0x2
ffffffffc0204e0c:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204e10:	17f9                	addi	a5,a5,-2
ffffffffc0204e12:	2501                	sext.w	a0,a0
ffffffffc0204e14:	02e7e363          	bltu	a5,a4,ffffffffc0204e3a <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204e18:	45a9                	li	a1,10
ffffffffc0204e1a:	5b6000ef          	jal	ra,ffffffffc02053d0 <hash32>
ffffffffc0204e1e:	02051793          	slli	a5,a0,0x20
ffffffffc0204e22:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204e26:	96a6                	add	a3,a3,s1
ffffffffc0204e28:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204e2a:	a029                	j	ffffffffc0204e34 <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204e2c:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x800c>
ffffffffc0204e30:	04870b63          	beq	a4,s0,ffffffffc0204e86 <proc_init+0x122>
    return listelm->next;
ffffffffc0204e34:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204e36:	fef69be3          	bne	a3,a5,ffffffffc0204e2c <proc_init+0xc8>
    return NULL;
ffffffffc0204e3a:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e3c:	0b478493          	addi	s1,a5,180
ffffffffc0204e40:	4641                	li	a2,16
ffffffffc0204e42:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204e44:	000da417          	auipc	s0,0xda
ffffffffc0204e48:	cac40413          	addi	s0,s0,-852 # ffffffffc02deaf0 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e4c:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204e4e:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e50:	227000ef          	jal	ra,ffffffffc0205876 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204e54:	463d                	li	a2,15
ffffffffc0204e56:	00002597          	auipc	a1,0x2
ffffffffc0204e5a:	69a58593          	addi	a1,a1,1690 # ffffffffc02074f0 <default_pmm_manager+0xe10>
ffffffffc0204e5e:	8526                	mv	a0,s1
ffffffffc0204e60:	229000ef          	jal	ra,ffffffffc0205888 <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204e64:	00093783          	ld	a5,0(s2)
ffffffffc0204e68:	cbb5                	beqz	a5,ffffffffc0204edc <proc_init+0x178>
ffffffffc0204e6a:	43dc                	lw	a5,4(a5)
ffffffffc0204e6c:	eba5                	bnez	a5,ffffffffc0204edc <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204e6e:	601c                	ld	a5,0(s0)
ffffffffc0204e70:	c7b1                	beqz	a5,ffffffffc0204ebc <proc_init+0x158>
ffffffffc0204e72:	43d8                	lw	a4,4(a5)
ffffffffc0204e74:	4785                	li	a5,1
ffffffffc0204e76:	04f71363          	bne	a4,a5,ffffffffc0204ebc <proc_init+0x158>
}
ffffffffc0204e7a:	60e2                	ld	ra,24(sp)
ffffffffc0204e7c:	6442                	ld	s0,16(sp)
ffffffffc0204e7e:	64a2                	ld	s1,8(sp)
ffffffffc0204e80:	6902                	ld	s2,0(sp)
ffffffffc0204e82:	6105                	addi	sp,sp,32
ffffffffc0204e84:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204e86:	f2878793          	addi	a5,a5,-216
ffffffffc0204e8a:	bf4d                	j	ffffffffc0204e3c <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204e8c:	00002617          	auipc	a2,0x2
ffffffffc0204e90:	64460613          	addi	a2,a2,1604 # ffffffffc02074d0 <default_pmm_manager+0xdf0>
ffffffffc0204e94:	3c400593          	li	a1,964
ffffffffc0204e98:	00002517          	auipc	a0,0x2
ffffffffc0204e9c:	27050513          	addi	a0,a0,624 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204ea0:	df2fb0ef          	jal	ra,ffffffffc0200492 <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204ea4:	00002617          	auipc	a2,0x2
ffffffffc0204ea8:	60c60613          	addi	a2,a2,1548 # ffffffffc02074b0 <default_pmm_manager+0xdd0>
ffffffffc0204eac:	3b500593          	li	a1,949
ffffffffc0204eb0:	00002517          	auipc	a0,0x2
ffffffffc0204eb4:	25850513          	addi	a0,a0,600 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204eb8:	ddafb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204ebc:	00002697          	auipc	a3,0x2
ffffffffc0204ec0:	66468693          	addi	a3,a3,1636 # ffffffffc0207520 <default_pmm_manager+0xe40>
ffffffffc0204ec4:	00001617          	auipc	a2,0x1
ffffffffc0204ec8:	46c60613          	addi	a2,a2,1132 # ffffffffc0206330 <commands+0x828>
ffffffffc0204ecc:	3cb00593          	li	a1,971
ffffffffc0204ed0:	00002517          	auipc	a0,0x2
ffffffffc0204ed4:	23850513          	addi	a0,a0,568 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204ed8:	dbafb0ef          	jal	ra,ffffffffc0200492 <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204edc:	00002697          	auipc	a3,0x2
ffffffffc0204ee0:	61c68693          	addi	a3,a3,1564 # ffffffffc02074f8 <default_pmm_manager+0xe18>
ffffffffc0204ee4:	00001617          	auipc	a2,0x1
ffffffffc0204ee8:	44c60613          	addi	a2,a2,1100 # ffffffffc0206330 <commands+0x828>
ffffffffc0204eec:	3ca00593          	li	a1,970
ffffffffc0204ef0:	00002517          	auipc	a0,0x2
ffffffffc0204ef4:	21850513          	addi	a0,a0,536 # ffffffffc0207108 <default_pmm_manager+0xa28>
ffffffffc0204ef8:	d9afb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc0204efc <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204efc:	1141                	addi	sp,sp,-16
ffffffffc0204efe:	e022                	sd	s0,0(sp)
ffffffffc0204f00:	e406                	sd	ra,8(sp)
ffffffffc0204f02:	000da417          	auipc	s0,0xda
ffffffffc0204f06:	bde40413          	addi	s0,s0,-1058 # ffffffffc02deae0 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204f0a:	6018                	ld	a4,0(s0)
ffffffffc0204f0c:	6f1c                	ld	a5,24(a4)
ffffffffc0204f0e:	dffd                	beqz	a5,ffffffffc0204f0c <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204f10:	1d6000ef          	jal	ra,ffffffffc02050e6 <schedule>
ffffffffc0204f14:	bfdd                	j	ffffffffc0204f0a <cpu_idle+0xe>

ffffffffc0204f16 <lab6_set_priority>:
        }
    }
}
// FOR LAB6, set the process's priority (bigger value will get more CPU time)
void lab6_set_priority(uint32_t priority)
{
ffffffffc0204f16:	1141                	addi	sp,sp,-16
ffffffffc0204f18:	e022                	sd	s0,0(sp)
    cprintf("set priority to %d\n", priority);
ffffffffc0204f1a:	85aa                	mv	a1,a0
{
ffffffffc0204f1c:	842a                	mv	s0,a0
    cprintf("set priority to %d\n", priority);
ffffffffc0204f1e:	00002517          	auipc	a0,0x2
ffffffffc0204f22:	62a50513          	addi	a0,a0,1578 # ffffffffc0207548 <default_pmm_manager+0xe68>
{
ffffffffc0204f26:	e406                	sd	ra,8(sp)
    cprintf("set priority to %d\n", priority);
ffffffffc0204f28:	a70fb0ef          	jal	ra,ffffffffc0200198 <cprintf>
    if (priority == 0)
        current->lab6_priority = 1;
ffffffffc0204f2c:	000da797          	auipc	a5,0xda
ffffffffc0204f30:	bb47b783          	ld	a5,-1100(a5) # ffffffffc02deae0 <current>
    if (priority == 0)
ffffffffc0204f34:	e801                	bnez	s0,ffffffffc0204f44 <lab6_set_priority+0x2e>
    else
        current->lab6_priority = priority;
}
ffffffffc0204f36:	60a2                	ld	ra,8(sp)
ffffffffc0204f38:	6402                	ld	s0,0(sp)
        current->lab6_priority = 1;
ffffffffc0204f3a:	4705                	li	a4,1
ffffffffc0204f3c:	14e7a223          	sw	a4,324(a5)
}
ffffffffc0204f40:	0141                	addi	sp,sp,16
ffffffffc0204f42:	8082                	ret
ffffffffc0204f44:	60a2                	ld	ra,8(sp)
        current->lab6_priority = priority;
ffffffffc0204f46:	1487a223          	sw	s0,324(a5)
}
ffffffffc0204f4a:	6402                	ld	s0,0(sp)
ffffffffc0204f4c:	0141                	addi	sp,sp,16
ffffffffc0204f4e:	8082                	ret

ffffffffc0204f50 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0204f50:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0204f54:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0204f58:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0204f5a:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0204f5c:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0204f60:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0204f64:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0204f68:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0204f6c:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0204f70:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0204f74:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0204f78:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0204f7c:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0204f80:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0204f84:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0204f88:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0204f8c:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0204f8e:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0204f90:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0204f94:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0204f98:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0204f9c:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0204fa0:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0204fa4:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0204fa8:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0204fac:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0204fb0:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc0204fb4:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0204fb8:	8082                	ret

ffffffffc0204fba <sched_class_proc_tick>:
    return sched_class->pick_next(rq);
}

void sched_class_proc_tick(struct proc_struct *proc)
{
    if (proc != idleproc)
ffffffffc0204fba:	000da797          	auipc	a5,0xda
ffffffffc0204fbe:	b2e7b783          	ld	a5,-1234(a5) # ffffffffc02deae8 <idleproc>
{
ffffffffc0204fc2:	85aa                	mv	a1,a0
    if (proc != idleproc)
ffffffffc0204fc4:	00a78c63          	beq	a5,a0,ffffffffc0204fdc <sched_class_proc_tick+0x22>
    {
        sched_class->proc_tick(rq, proc);
ffffffffc0204fc8:	000da797          	auipc	a5,0xda
ffffffffc0204fcc:	b407b783          	ld	a5,-1216(a5) # ffffffffc02deb08 <sched_class>
ffffffffc0204fd0:	779c                	ld	a5,40(a5)
ffffffffc0204fd2:	000da517          	auipc	a0,0xda
ffffffffc0204fd6:	b2e53503          	ld	a0,-1234(a0) # ffffffffc02deb00 <rq>
ffffffffc0204fda:	8782                	jr	a5
    }
    else
    {
        proc->need_resched = 1;
ffffffffc0204fdc:	4705                	li	a4,1
ffffffffc0204fde:	ef98                	sd	a4,24(a5)
    }
}
ffffffffc0204fe0:	8082                	ret

ffffffffc0204fe2 <sched_init>:

static struct run_queue __rq;

void sched_init(void)
{
ffffffffc0204fe2:	1141                	addi	sp,sp,-16
#elif CURRENT_SCHED == SCHED_SJF
    sched_class = &SJF_sched_class;
#elif CURRENT_SCHED == SCHED_PRIORITY
    sched_class = &Priority_sched_class;
#elif CURRENT_SCHED == SCHED_MLFQ
    sched_class = &MLFQ_sched_class;
ffffffffc0204fe4:	000d5717          	auipc	a4,0xd5
ffffffffc0204fe8:	60c70713          	addi	a4,a4,1548 # ffffffffc02da5f0 <MLFQ_sched_class>
{
ffffffffc0204fec:	e022                	sd	s0,0(sp)
ffffffffc0204fee:	e406                	sd	ra,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204ff0:	000da797          	auipc	a5,0xda
ffffffffc0204ff4:	a8878793          	addi	a5,a5,-1400 # ffffffffc02dea78 <timer_list>
    sched_class = &default_sched_class;
#endif

    rq = &__rq;
    rq->max_time_slice = MAX_TIME_SLICE;
    sched_class->init(rq);
ffffffffc0204ff8:	6714                	ld	a3,8(a4)
    rq = &__rq;
ffffffffc0204ffa:	000da517          	auipc	a0,0xda
ffffffffc0204ffe:	a5e50513          	addi	a0,a0,-1442 # ffffffffc02dea58 <__rq>
ffffffffc0205002:	e79c                	sd	a5,8(a5)
ffffffffc0205004:	e39c                	sd	a5,0(a5)
    rq->max_time_slice = MAX_TIME_SLICE;
ffffffffc0205006:	4795                	li	a5,5
ffffffffc0205008:	c95c                	sw	a5,20(a0)
    sched_class = &MLFQ_sched_class;
ffffffffc020500a:	000da417          	auipc	s0,0xda
ffffffffc020500e:	afe40413          	addi	s0,s0,-1282 # ffffffffc02deb08 <sched_class>
    rq = &__rq;
ffffffffc0205012:	000da797          	auipc	a5,0xda
ffffffffc0205016:	aea7b723          	sd	a0,-1298(a5) # ffffffffc02deb00 <rq>
    sched_class = &MLFQ_sched_class;
ffffffffc020501a:	e018                	sd	a4,0(s0)
    sched_class->init(rq);
ffffffffc020501c:	9682                	jalr	a3

    cprintf("sched class: %s\n", sched_class->name);
ffffffffc020501e:	601c                	ld	a5,0(s0)
}
ffffffffc0205020:	6402                	ld	s0,0(sp)
ffffffffc0205022:	60a2                	ld	ra,8(sp)
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0205024:	638c                	ld	a1,0(a5)
ffffffffc0205026:	00002517          	auipc	a0,0x2
ffffffffc020502a:	53a50513          	addi	a0,a0,1338 # ffffffffc0207560 <default_pmm_manager+0xe80>
}
ffffffffc020502e:	0141                	addi	sp,sp,16
    cprintf("sched class: %s\n", sched_class->name);
ffffffffc0205030:	968fb06f          	j	ffffffffc0200198 <cprintf>

ffffffffc0205034 <wakeup_proc>:

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205034:	4118                	lw	a4,0(a0)
{
ffffffffc0205036:	1101                	addi	sp,sp,-32
ffffffffc0205038:	ec06                	sd	ra,24(sp)
ffffffffc020503a:	e822                	sd	s0,16(sp)
ffffffffc020503c:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020503e:	478d                	li	a5,3
ffffffffc0205040:	08f70363          	beq	a4,a5,ffffffffc02050c6 <wakeup_proc+0x92>
ffffffffc0205044:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205046:	100027f3          	csrr	a5,sstatus
ffffffffc020504a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020504c:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020504e:	e7bd                	bnez	a5,ffffffffc02050bc <wakeup_proc+0x88>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc0205050:	4789                	li	a5,2
ffffffffc0205052:	04f70863          	beq	a4,a5,ffffffffc02050a2 <wakeup_proc+0x6e>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc0205056:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc0205058:	0e042623          	sw	zero,236(s0)
            if (proc != current)
ffffffffc020505c:	000da797          	auipc	a5,0xda
ffffffffc0205060:	a847b783          	ld	a5,-1404(a5) # ffffffffc02deae0 <current>
ffffffffc0205064:	02878363          	beq	a5,s0,ffffffffc020508a <wakeup_proc+0x56>
    if (proc != idleproc)
ffffffffc0205068:	000da797          	auipc	a5,0xda
ffffffffc020506c:	a807b783          	ld	a5,-1408(a5) # ffffffffc02deae8 <idleproc>
ffffffffc0205070:	00f40d63          	beq	s0,a5,ffffffffc020508a <wakeup_proc+0x56>
        sched_class->enqueue(rq, proc);
ffffffffc0205074:	000da797          	auipc	a5,0xda
ffffffffc0205078:	a947b783          	ld	a5,-1388(a5) # ffffffffc02deb08 <sched_class>
ffffffffc020507c:	6b9c                	ld	a5,16(a5)
ffffffffc020507e:	85a2                	mv	a1,s0
ffffffffc0205080:	000da517          	auipc	a0,0xda
ffffffffc0205084:	a8053503          	ld	a0,-1408(a0) # ffffffffc02deb00 <rq>
ffffffffc0205088:	9782                	jalr	a5
    if (flag)
ffffffffc020508a:	e491                	bnez	s1,ffffffffc0205096 <wakeup_proc+0x62>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020508c:	60e2                	ld	ra,24(sp)
ffffffffc020508e:	6442                	ld	s0,16(sp)
ffffffffc0205090:	64a2                	ld	s1,8(sp)
ffffffffc0205092:	6105                	addi	sp,sp,32
ffffffffc0205094:	8082                	ret
ffffffffc0205096:	6442                	ld	s0,16(sp)
ffffffffc0205098:	60e2                	ld	ra,24(sp)
ffffffffc020509a:	64a2                	ld	s1,8(sp)
ffffffffc020509c:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc020509e:	90bfb06f          	j	ffffffffc02009a8 <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc02050a2:	00002617          	auipc	a2,0x2
ffffffffc02050a6:	50e60613          	addi	a2,a2,1294 # ffffffffc02075b0 <default_pmm_manager+0xed0>
ffffffffc02050aa:	06100593          	li	a1,97
ffffffffc02050ae:	00002517          	auipc	a0,0x2
ffffffffc02050b2:	4ea50513          	addi	a0,a0,1258 # ffffffffc0207598 <default_pmm_manager+0xeb8>
ffffffffc02050b6:	c44fb0ef          	jal	ra,ffffffffc02004fa <__warn>
ffffffffc02050ba:	bfc1                	j	ffffffffc020508a <wakeup_proc+0x56>
        intr_disable();
ffffffffc02050bc:	8f3fb0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc02050c0:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc02050c2:	4485                	li	s1,1
ffffffffc02050c4:	b771                	j	ffffffffc0205050 <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc02050c6:	00002697          	auipc	a3,0x2
ffffffffc02050ca:	4b268693          	addi	a3,a3,1202 # ffffffffc0207578 <default_pmm_manager+0xe98>
ffffffffc02050ce:	00001617          	auipc	a2,0x1
ffffffffc02050d2:	26260613          	addi	a2,a2,610 # ffffffffc0206330 <commands+0x828>
ffffffffc02050d6:	05200593          	li	a1,82
ffffffffc02050da:	00002517          	auipc	a0,0x2
ffffffffc02050de:	4be50513          	addi	a0,a0,1214 # ffffffffc0207598 <default_pmm_manager+0xeb8>
ffffffffc02050e2:	bb0fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02050e6 <schedule>:

void schedule(void)
{
ffffffffc02050e6:	7179                	addi	sp,sp,-48
ffffffffc02050e8:	f406                	sd	ra,40(sp)
ffffffffc02050ea:	f022                	sd	s0,32(sp)
ffffffffc02050ec:	ec26                	sd	s1,24(sp)
ffffffffc02050ee:	e84a                	sd	s2,16(sp)
ffffffffc02050f0:	e44e                	sd	s3,8(sp)
ffffffffc02050f2:	e052                	sd	s4,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02050f4:	100027f3          	csrr	a5,sstatus
ffffffffc02050f8:	8b89                	andi	a5,a5,2
ffffffffc02050fa:	4a01                	li	s4,0
ffffffffc02050fc:	e3cd                	bnez	a5,ffffffffc020519e <schedule+0xb8>
    bool intr_flag;
    struct proc_struct *next;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc02050fe:	000da497          	auipc	s1,0xda
ffffffffc0205102:	9e248493          	addi	s1,s1,-1566 # ffffffffc02deae0 <current>
ffffffffc0205106:	608c                	ld	a1,0(s1)
        sched_class->enqueue(rq, proc);
ffffffffc0205108:	000da997          	auipc	s3,0xda
ffffffffc020510c:	a0098993          	addi	s3,s3,-1536 # ffffffffc02deb08 <sched_class>
ffffffffc0205110:	000da917          	auipc	s2,0xda
ffffffffc0205114:	9f090913          	addi	s2,s2,-1552 # ffffffffc02deb00 <rq>
        if (current->state == PROC_RUNNABLE)
ffffffffc0205118:	4194                	lw	a3,0(a1)
        current->need_resched = 0;
ffffffffc020511a:	0005bc23          	sd	zero,24(a1)
        if (current->state == PROC_RUNNABLE)
ffffffffc020511e:	4709                	li	a4,2
        sched_class->enqueue(rq, proc);
ffffffffc0205120:	0009b783          	ld	a5,0(s3)
ffffffffc0205124:	00093503          	ld	a0,0(s2)
        if (current->state == PROC_RUNNABLE)
ffffffffc0205128:	04e68e63          	beq	a3,a4,ffffffffc0205184 <schedule+0x9e>
    return sched_class->pick_next(rq);
ffffffffc020512c:	739c                	ld	a5,32(a5)
ffffffffc020512e:	9782                	jalr	a5
ffffffffc0205130:	842a                	mv	s0,a0
        {
            sched_class_enqueue(current);
        }
        if ((next = sched_class_pick_next()) != NULL)
ffffffffc0205132:	c521                	beqz	a0,ffffffffc020517a <schedule+0x94>
    sched_class->dequeue(rq, proc);
ffffffffc0205134:	0009b783          	ld	a5,0(s3)
ffffffffc0205138:	00093503          	ld	a0,0(s2)
ffffffffc020513c:	85a2                	mv	a1,s0
ffffffffc020513e:	6f9c                	ld	a5,24(a5)
ffffffffc0205140:	9782                	jalr	a5
        }
        if (next == NULL)
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc0205142:	441c                	lw	a5,8(s0)
        if (next != current)
ffffffffc0205144:	6098                	ld	a4,0(s1)
        next->runs++;
ffffffffc0205146:	2785                	addiw	a5,a5,1
ffffffffc0205148:	c41c                	sw	a5,8(s0)
        if (next != current)
ffffffffc020514a:	00870563          	beq	a4,s0,ffffffffc0205154 <schedule+0x6e>
        {
            proc_run(next);
ffffffffc020514e:	8522                	mv	a0,s0
ffffffffc0205150:	ca1fe0ef          	jal	ra,ffffffffc0203df0 <proc_run>
    if (flag)
ffffffffc0205154:	000a1a63          	bnez	s4,ffffffffc0205168 <schedule+0x82>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc0205158:	70a2                	ld	ra,40(sp)
ffffffffc020515a:	7402                	ld	s0,32(sp)
ffffffffc020515c:	64e2                	ld	s1,24(sp)
ffffffffc020515e:	6942                	ld	s2,16(sp)
ffffffffc0205160:	69a2                	ld	s3,8(sp)
ffffffffc0205162:	6a02                	ld	s4,0(sp)
ffffffffc0205164:	6145                	addi	sp,sp,48
ffffffffc0205166:	8082                	ret
ffffffffc0205168:	7402                	ld	s0,32(sp)
ffffffffc020516a:	70a2                	ld	ra,40(sp)
ffffffffc020516c:	64e2                	ld	s1,24(sp)
ffffffffc020516e:	6942                	ld	s2,16(sp)
ffffffffc0205170:	69a2                	ld	s3,8(sp)
ffffffffc0205172:	6a02                	ld	s4,0(sp)
ffffffffc0205174:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0205176:	833fb06f          	j	ffffffffc02009a8 <intr_enable>
            next = idleproc;
ffffffffc020517a:	000da417          	auipc	s0,0xda
ffffffffc020517e:	96e43403          	ld	s0,-1682(s0) # ffffffffc02deae8 <idleproc>
ffffffffc0205182:	b7c1                	j	ffffffffc0205142 <schedule+0x5c>
    if (proc != idleproc)
ffffffffc0205184:	000da717          	auipc	a4,0xda
ffffffffc0205188:	96473703          	ld	a4,-1692(a4) # ffffffffc02deae8 <idleproc>
ffffffffc020518c:	fae580e3          	beq	a1,a4,ffffffffc020512c <schedule+0x46>
        sched_class->enqueue(rq, proc);
ffffffffc0205190:	6b9c                	ld	a5,16(a5)
ffffffffc0205192:	9782                	jalr	a5
    return sched_class->pick_next(rq);
ffffffffc0205194:	0009b783          	ld	a5,0(s3)
ffffffffc0205198:	00093503          	ld	a0,0(s2)
ffffffffc020519c:	bf41                	j	ffffffffc020512c <schedule+0x46>
        intr_disable();
ffffffffc020519e:	811fb0ef          	jal	ra,ffffffffc02009ae <intr_disable>
        return 1;
ffffffffc02051a2:	4a05                	li	s4,1
ffffffffc02051a4:	bfa9                	j	ffffffffc02050fe <schedule+0x18>

ffffffffc02051a6 <MLFQ_init>:
ffffffffc02051a6:	e508                	sd	a0,8(a0)
ffffffffc02051a8:	e108                	sd	a0,0(a0)
 */
static void
MLFQ_init(struct run_queue *rq)
{
    list_init(&(rq->run_list));
    rq->proc_num = 0;
ffffffffc02051aa:	00052823          	sw	zero,16(a0)
}
ffffffffc02051ae:	8082                	ret

ffffffffc02051b0 <MLFQ_pick_next>:
    return listelm->next;
ffffffffc02051b0:	651c                	ld	a5,8(a0)
 */
static struct proc_struct *
MLFQ_pick_next(struct run_queue *rq)
{
    list_entry_t *le = list_next(&(rq->run_list));
    if (le != &(rq->run_list)) {
ffffffffc02051b2:	00f50563          	beq	a0,a5,ffffffffc02051bc <MLFQ_pick_next+0xc>
        return le2proc(le, run_link);
ffffffffc02051b6:	ef078513          	addi	a0,a5,-272
ffffffffc02051ba:	8082                	ret
    }
    return NULL;
ffffffffc02051bc:	4501                	li	a0,0
}
ffffffffc02051be:	8082                	ret

ffffffffc02051c0 <MLFQ_enqueue>:
    assert(list_empty(&(proc->run_link)));
ffffffffc02051c0:	1185b783          	ld	a5,280(a1)
ffffffffc02051c4:	11058813          	addi	a6,a1,272
ffffffffc02051c8:	06f81163          	bne	a6,a5,ffffffffc020522a <MLFQ_enqueue+0x6a>
    if (proc->lab6_stride >= MLFQ_LEVELS) {
ffffffffc02051cc:	1405a703          	lw	a4,320(a1)
ffffffffc02051d0:	478d                	li	a5,3
ffffffffc02051d2:	00e7f463          	bgeu	a5,a4,ffffffffc02051da <MLFQ_enqueue+0x1a>
        proc->lab6_stride = 0;
ffffffffc02051d6:	1405a023          	sw	zero,320(a1)
    if (proc->time_slice == 0) {
ffffffffc02051da:	1205a783          	lw	a5,288(a1)
ffffffffc02051de:	cf95                	beqz	a5,ffffffffc020521a <MLFQ_enqueue+0x5a>
ffffffffc02051e0:	651c                	ld	a5,8(a0)
    while (le != &(rq->run_list)) {
ffffffffc02051e2:	862a                	mv	a2,a0
ffffffffc02051e4:	00a78c63          	beq	a5,a0,ffffffffc02051fc <MLFQ_enqueue+0x3c>
        if (p->lab6_stride > proc->lab6_stride) {
ffffffffc02051e8:	1405a683          	lw	a3,320(a1)
ffffffffc02051ec:	a021                	j	ffffffffc02051f4 <MLFQ_enqueue+0x34>
ffffffffc02051ee:	679c                	ld	a5,8(a5)
    while (le != &(rq->run_list)) {
ffffffffc02051f0:	00a78663          	beq	a5,a0,ffffffffc02051fc <MLFQ_enqueue+0x3c>
        if (p->lab6_stride > proc->lab6_stride) {
ffffffffc02051f4:	5b98                	lw	a4,48(a5)
ffffffffc02051f6:	fee6fce3          	bgeu	a3,a4,ffffffffc02051ee <MLFQ_enqueue+0x2e>
ffffffffc02051fa:	863e                	mv	a2,a5
    __list_add(elm, listelm->prev, listelm);
ffffffffc02051fc:	6218                	ld	a4,0(a2)
    rq->proc_num++;
ffffffffc02051fe:	491c                	lw	a5,16(a0)
    prev->next = next->prev = elm;
ffffffffc0205200:	01063023          	sd	a6,0(a2)
ffffffffc0205204:	01073423          	sd	a6,8(a4)
    elm->next = next;
ffffffffc0205208:	10c5bc23          	sd	a2,280(a1)
    elm->prev = prev;
ffffffffc020520c:	10e5b823          	sd	a4,272(a1)
    proc->rq = rq;
ffffffffc0205210:	10a5b423          	sd	a0,264(a1)
    rq->proc_num++;
ffffffffc0205214:	2785                	addiw	a5,a5,1
ffffffffc0205216:	c91c                	sw	a5,16(a0)
ffffffffc0205218:	8082                	ret
    return MLFQ_BASE_SLICE << level;
ffffffffc020521a:	1405a703          	lw	a4,320(a1)
ffffffffc020521e:	4789                	li	a5,2
ffffffffc0205220:	00e797bb          	sllw	a5,a5,a4
        proc->time_slice = get_level_time_slice(proc->lab6_stride);
ffffffffc0205224:	12f5a023          	sw	a5,288(a1)
ffffffffc0205228:	bf65                	j	ffffffffc02051e0 <MLFQ_enqueue+0x20>
{
ffffffffc020522a:	1141                	addi	sp,sp,-16
    assert(list_empty(&(proc->run_link)));
ffffffffc020522c:	00002697          	auipc	a3,0x2
ffffffffc0205230:	3a468693          	addi	a3,a3,932 # ffffffffc02075d0 <default_pmm_manager+0xef0>
ffffffffc0205234:	00001617          	auipc	a2,0x1
ffffffffc0205238:	0fc60613          	addi	a2,a2,252 # ffffffffc0206330 <commands+0x828>
ffffffffc020523c:	03400593          	li	a1,52
ffffffffc0205240:	00002517          	auipc	a0,0x2
ffffffffc0205244:	3b050513          	addi	a0,a0,944 # ffffffffc02075f0 <default_pmm_manager+0xf10>
{
ffffffffc0205248:	e406                	sd	ra,8(sp)
    assert(list_empty(&(proc->run_link)));
ffffffffc020524a:	a48fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc020524e <MLFQ_proc_tick>:
 * 时间片用完后降级
 */
static void
MLFQ_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (proc->time_slice > 0) {
ffffffffc020524e:	1205a783          	lw	a5,288(a1)
ffffffffc0205252:	00f05563          	blez	a5,ffffffffc020525c <MLFQ_proc_tick+0xe>
        proc->time_slice--;
ffffffffc0205256:	37fd                	addiw	a5,a5,-1
ffffffffc0205258:	12f5a023          	sw	a5,288(a1)
    }
    if (proc->time_slice == 0) {
ffffffffc020525c:	e385                	bnez	a5,ffffffffc020527c <MLFQ_proc_tick+0x2e>
        // 时间片用完，降级到下一级队列
        if (proc->lab6_stride < MLFQ_LEVELS - 1) {
ffffffffc020525e:	1405a703          	lw	a4,320(a1)
ffffffffc0205262:	4789                	li	a5,2
ffffffffc0205264:	00e7e563          	bltu	a5,a4,ffffffffc020526e <MLFQ_proc_tick+0x20>
            proc->lab6_stride++;
ffffffffc0205268:	2705                	addiw	a4,a4,1
ffffffffc020526a:	14e5a023          	sw	a4,320(a1)
    return MLFQ_BASE_SLICE << level;
ffffffffc020526e:	4789                	li	a5,2
ffffffffc0205270:	00e797bb          	sllw	a5,a5,a4
        }
        // 设置新级别的时间片
        proc->time_slice = get_level_time_slice(proc->lab6_stride);
ffffffffc0205274:	12f5a023          	sw	a5,288(a1)
        proc->need_resched = 1;
ffffffffc0205278:	4785                	li	a5,1
ffffffffc020527a:	ed9c                	sd	a5,24(a1)
    }
}
ffffffffc020527c:	8082                	ret

ffffffffc020527e <MLFQ_dequeue>:
    return list->next == list;
ffffffffc020527e:	1185b703          	ld	a4,280(a1)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc0205282:	11058793          	addi	a5,a1,272
ffffffffc0205286:	02e78363          	beq	a5,a4,ffffffffc02052ac <MLFQ_dequeue+0x2e>
ffffffffc020528a:	1085b683          	ld	a3,264(a1)
ffffffffc020528e:	00a69f63          	bne	a3,a0,ffffffffc02052ac <MLFQ_dequeue+0x2e>
    __list_del(listelm->prev, listelm->next);
ffffffffc0205292:	1105b503          	ld	a0,272(a1)
    rq->proc_num--;
ffffffffc0205296:	4a90                	lw	a2,16(a3)
    prev->next = next;
ffffffffc0205298:	e518                	sd	a4,8(a0)
    next->prev = prev;
ffffffffc020529a:	e308                	sd	a0,0(a4)
    elm->prev = elm->next = elm;
ffffffffc020529c:	10f5bc23          	sd	a5,280(a1)
ffffffffc02052a0:	10f5b823          	sd	a5,272(a1)
ffffffffc02052a4:	fff6079b          	addiw	a5,a2,-1
ffffffffc02052a8:	ca9c                	sw	a5,16(a3)
ffffffffc02052aa:	8082                	ret
{
ffffffffc02052ac:	1141                	addi	sp,sp,-16
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02052ae:	00002697          	auipc	a3,0x2
ffffffffc02052b2:	36268693          	addi	a3,a3,866 # ffffffffc0207610 <default_pmm_manager+0xf30>
ffffffffc02052b6:	00001617          	auipc	a2,0x1
ffffffffc02052ba:	07a60613          	addi	a2,a2,122 # ffffffffc0206330 <commands+0x828>
ffffffffc02052be:	05600593          	li	a1,86
ffffffffc02052c2:	00002517          	auipc	a0,0x2
ffffffffc02052c6:	32e50513          	addi	a0,a0,814 # ffffffffc02075f0 <default_pmm_manager+0xf10>
{
ffffffffc02052ca:	e406                	sd	ra,8(sp)
    assert(!list_empty(&(proc->run_link)) && proc->rq == rq);
ffffffffc02052cc:	9c6fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02052d0 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc02052d0:	000da797          	auipc	a5,0xda
ffffffffc02052d4:	8107b783          	ld	a5,-2032(a5) # ffffffffc02deae0 <current>
}
ffffffffc02052d8:	43c8                	lw	a0,4(a5)
ffffffffc02052da:	8082                	ret

ffffffffc02052dc <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc02052dc:	4501                	li	a0,0
ffffffffc02052de:	8082                	ret

ffffffffc02052e0 <sys_gettime>:
static int sys_gettime(uint64_t arg[]){
    return (int)ticks*10;
ffffffffc02052e0:	000d9797          	auipc	a5,0xd9
ffffffffc02052e4:	7b07b783          	ld	a5,1968(a5) # ffffffffc02dea90 <ticks>
ffffffffc02052e8:	0027951b          	slliw	a0,a5,0x2
ffffffffc02052ec:	9d3d                	addw	a0,a0,a5
}
ffffffffc02052ee:	0015151b          	slliw	a0,a0,0x1
ffffffffc02052f2:	8082                	ret

ffffffffc02052f4 <sys_lab6_set_priority>:
static int sys_lab6_set_priority(uint64_t arg[]){
    uint64_t priority = (uint64_t)arg[0];
    lab6_set_priority(priority);
ffffffffc02052f4:	4108                	lw	a0,0(a0)
static int sys_lab6_set_priority(uint64_t arg[]){
ffffffffc02052f6:	1141                	addi	sp,sp,-16
ffffffffc02052f8:	e406                	sd	ra,8(sp)
    lab6_set_priority(priority);
ffffffffc02052fa:	c1dff0ef          	jal	ra,ffffffffc0204f16 <lab6_set_priority>
    return 0;
}
ffffffffc02052fe:	60a2                	ld	ra,8(sp)
ffffffffc0205300:	4501                	li	a0,0
ffffffffc0205302:	0141                	addi	sp,sp,16
ffffffffc0205304:	8082                	ret

ffffffffc0205306 <sys_putc>:
    cputchar(c);
ffffffffc0205306:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0205308:	1141                	addi	sp,sp,-16
ffffffffc020530a:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc020530c:	ec3fa0ef          	jal	ra,ffffffffc02001ce <cputchar>
}
ffffffffc0205310:	60a2                	ld	ra,8(sp)
ffffffffc0205312:	4501                	li	a0,0
ffffffffc0205314:	0141                	addi	sp,sp,16
ffffffffc0205316:	8082                	ret

ffffffffc0205318 <sys_kill>:
    return do_kill(pid);
ffffffffc0205318:	4108                	lw	a0,0(a0)
ffffffffc020531a:	9cfff06f          	j	ffffffffc0204ce8 <do_kill>

ffffffffc020531e <sys_yield>:
    return do_yield();
ffffffffc020531e:	97dff06f          	j	ffffffffc0204c9a <do_yield>

ffffffffc0205322 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0205322:	6d14                	ld	a3,24(a0)
ffffffffc0205324:	6910                	ld	a2,16(a0)
ffffffffc0205326:	650c                	ld	a1,8(a0)
ffffffffc0205328:	6108                	ld	a0,0(a0)
ffffffffc020532a:	bc6ff06f          	j	ffffffffc02046f0 <do_execve>

ffffffffc020532e <sys_wait>:
    return do_wait(pid, store);
ffffffffc020532e:	650c                	ld	a1,8(a0)
ffffffffc0205330:	4108                	lw	a0,0(a0)
ffffffffc0205332:	979ff06f          	j	ffffffffc0204caa <do_wait>

ffffffffc0205336 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0205336:	000d9797          	auipc	a5,0xd9
ffffffffc020533a:	7aa7b783          	ld	a5,1962(a5) # ffffffffc02deae0 <current>
ffffffffc020533e:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0205340:	4501                	li	a0,0
ffffffffc0205342:	6a0c                	ld	a1,16(a2)
ffffffffc0205344:	b19fe06f          	j	ffffffffc0203e5c <do_fork>

ffffffffc0205348 <sys_exit>:
    return do_exit(error_code);
ffffffffc0205348:	4108                	lw	a0,0(a0)
ffffffffc020534a:	f67fe06f          	j	ffffffffc02042b0 <do_exit>

ffffffffc020534e <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc020534e:	715d                	addi	sp,sp,-80
ffffffffc0205350:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205352:	000d9497          	auipc	s1,0xd9
ffffffffc0205356:	78e48493          	addi	s1,s1,1934 # ffffffffc02deae0 <current>
ffffffffc020535a:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc020535c:	e0a2                	sd	s0,64(sp)
ffffffffc020535e:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205360:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0205362:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205364:	0ff00793          	li	a5,255
    int num = tf->gpr.a0;
ffffffffc0205368:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020536c:	0327ee63          	bltu	a5,s2,ffffffffc02053a8 <syscall+0x5a>
        if (syscalls[num] != NULL) {
ffffffffc0205370:	00391713          	slli	a4,s2,0x3
ffffffffc0205374:	00002797          	auipc	a5,0x2
ffffffffc0205378:	32c78793          	addi	a5,a5,812 # ffffffffc02076a0 <syscalls>
ffffffffc020537c:	97ba                	add	a5,a5,a4
ffffffffc020537e:	639c                	ld	a5,0(a5)
ffffffffc0205380:	c785                	beqz	a5,ffffffffc02053a8 <syscall+0x5a>
            arg[0] = tf->gpr.a1;
ffffffffc0205382:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc0205384:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc0205386:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc0205388:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc020538a:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc020538c:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc020538e:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc0205390:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc0205392:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc0205394:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc0205396:	0028                	addi	a0,sp,8
ffffffffc0205398:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc020539a:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc020539c:	e828                	sd	a0,80(s0)
}
ffffffffc020539e:	6406                	ld	s0,64(sp)
ffffffffc02053a0:	74e2                	ld	s1,56(sp)
ffffffffc02053a2:	7942                	ld	s2,48(sp)
ffffffffc02053a4:	6161                	addi	sp,sp,80
ffffffffc02053a6:	8082                	ret
    print_trapframe(tf);
ffffffffc02053a8:	8522                	mv	a0,s0
ffffffffc02053aa:	ff4fb0ef          	jal	ra,ffffffffc0200b9e <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02053ae:	609c                	ld	a5,0(s1)
ffffffffc02053b0:	86ca                	mv	a3,s2
ffffffffc02053b2:	00002617          	auipc	a2,0x2
ffffffffc02053b6:	2a660613          	addi	a2,a2,678 # ffffffffc0207658 <default_pmm_manager+0xf78>
ffffffffc02053ba:	43d8                	lw	a4,4(a5)
ffffffffc02053bc:	06c00593          	li	a1,108
ffffffffc02053c0:	0b478793          	addi	a5,a5,180
ffffffffc02053c4:	00002517          	auipc	a0,0x2
ffffffffc02053c8:	2c450513          	addi	a0,a0,708 # ffffffffc0207688 <default_pmm_manager+0xfa8>
ffffffffc02053cc:	8c6fb0ef          	jal	ra,ffffffffc0200492 <__panic>

ffffffffc02053d0 <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc02053d0:	9e3707b7          	lui	a5,0x9e370
ffffffffc02053d4:	2785                	addiw	a5,a5,1
ffffffffc02053d6:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc02053da:	02000793          	li	a5,32
ffffffffc02053de:	9f8d                	subw	a5,a5,a1
}
ffffffffc02053e0:	00f5553b          	srlw	a0,a0,a5
ffffffffc02053e4:	8082                	ret

ffffffffc02053e6 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc02053e6:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02053ea:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc02053ec:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02053f0:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc02053f2:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc02053f6:	f022                	sd	s0,32(sp)
ffffffffc02053f8:	ec26                	sd	s1,24(sp)
ffffffffc02053fa:	e84a                	sd	s2,16(sp)
ffffffffc02053fc:	f406                	sd	ra,40(sp)
ffffffffc02053fe:	e44e                	sd	s3,8(sp)
ffffffffc0205400:	84aa                	mv	s1,a0
ffffffffc0205402:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0205404:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0205408:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc020540a:	03067e63          	bgeu	a2,a6,ffffffffc0205446 <printnum+0x60>
ffffffffc020540e:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0205410:	00805763          	blez	s0,ffffffffc020541e <printnum+0x38>
ffffffffc0205414:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0205416:	85ca                	mv	a1,s2
ffffffffc0205418:	854e                	mv	a0,s3
ffffffffc020541a:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020541c:	fc65                	bnez	s0,ffffffffc0205414 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020541e:	1a02                	slli	s4,s4,0x20
ffffffffc0205420:	00003797          	auipc	a5,0x3
ffffffffc0205424:	a8078793          	addi	a5,a5,-1408 # ffffffffc0207ea0 <syscalls+0x800>
ffffffffc0205428:	020a5a13          	srli	s4,s4,0x20
ffffffffc020542c:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc020542e:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205430:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0205434:	70a2                	ld	ra,40(sp)
ffffffffc0205436:	69a2                	ld	s3,8(sp)
ffffffffc0205438:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020543a:	85ca                	mv	a1,s2
ffffffffc020543c:	87a6                	mv	a5,s1
}
ffffffffc020543e:	6942                	ld	s2,16(sp)
ffffffffc0205440:	64e2                	ld	s1,24(sp)
ffffffffc0205442:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205444:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0205446:	03065633          	divu	a2,a2,a6
ffffffffc020544a:	8722                	mv	a4,s0
ffffffffc020544c:	f9bff0ef          	jal	ra,ffffffffc02053e6 <printnum>
ffffffffc0205450:	b7f9                	j	ffffffffc020541e <printnum+0x38>

ffffffffc0205452 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0205452:	7119                	addi	sp,sp,-128
ffffffffc0205454:	f4a6                	sd	s1,104(sp)
ffffffffc0205456:	f0ca                	sd	s2,96(sp)
ffffffffc0205458:	ecce                	sd	s3,88(sp)
ffffffffc020545a:	e8d2                	sd	s4,80(sp)
ffffffffc020545c:	e4d6                	sd	s5,72(sp)
ffffffffc020545e:	e0da                	sd	s6,64(sp)
ffffffffc0205460:	fc5e                	sd	s7,56(sp)
ffffffffc0205462:	f06a                	sd	s10,32(sp)
ffffffffc0205464:	fc86                	sd	ra,120(sp)
ffffffffc0205466:	f8a2                	sd	s0,112(sp)
ffffffffc0205468:	f862                	sd	s8,48(sp)
ffffffffc020546a:	f466                	sd	s9,40(sp)
ffffffffc020546c:	ec6e                	sd	s11,24(sp)
ffffffffc020546e:	892a                	mv	s2,a0
ffffffffc0205470:	84ae                	mv	s1,a1
ffffffffc0205472:	8d32                	mv	s10,a2
ffffffffc0205474:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0205476:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc020547a:	5b7d                	li	s6,-1
ffffffffc020547c:	00003a97          	auipc	s5,0x3
ffffffffc0205480:	a50a8a93          	addi	s5,s5,-1456 # ffffffffc0207ecc <syscalls+0x82c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0205484:	00003b97          	auipc	s7,0x3
ffffffffc0205488:	c64b8b93          	addi	s7,s7,-924 # ffffffffc02080e8 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020548c:	000d4503          	lbu	a0,0(s10)
ffffffffc0205490:	001d0413          	addi	s0,s10,1
ffffffffc0205494:	01350a63          	beq	a0,s3,ffffffffc02054a8 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0205498:	c121                	beqz	a0,ffffffffc02054d8 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc020549a:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc020549c:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc020549e:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02054a0:	fff44503          	lbu	a0,-1(s0)
ffffffffc02054a4:	ff351ae3          	bne	a0,s3,ffffffffc0205498 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054a8:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02054ac:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02054b0:	4c81                	li	s9,0
ffffffffc02054b2:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02054b4:	5c7d                	li	s8,-1
ffffffffc02054b6:	5dfd                	li	s11,-1
ffffffffc02054b8:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02054bc:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054be:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02054c2:	0ff5f593          	zext.b	a1,a1
ffffffffc02054c6:	00140d13          	addi	s10,s0,1
ffffffffc02054ca:	04b56263          	bltu	a0,a1,ffffffffc020550e <vprintfmt+0xbc>
ffffffffc02054ce:	058a                	slli	a1,a1,0x2
ffffffffc02054d0:	95d6                	add	a1,a1,s5
ffffffffc02054d2:	4194                	lw	a3,0(a1)
ffffffffc02054d4:	96d6                	add	a3,a3,s5
ffffffffc02054d6:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc02054d8:	70e6                	ld	ra,120(sp)
ffffffffc02054da:	7446                	ld	s0,112(sp)
ffffffffc02054dc:	74a6                	ld	s1,104(sp)
ffffffffc02054de:	7906                	ld	s2,96(sp)
ffffffffc02054e0:	69e6                	ld	s3,88(sp)
ffffffffc02054e2:	6a46                	ld	s4,80(sp)
ffffffffc02054e4:	6aa6                	ld	s5,72(sp)
ffffffffc02054e6:	6b06                	ld	s6,64(sp)
ffffffffc02054e8:	7be2                	ld	s7,56(sp)
ffffffffc02054ea:	7c42                	ld	s8,48(sp)
ffffffffc02054ec:	7ca2                	ld	s9,40(sp)
ffffffffc02054ee:	7d02                	ld	s10,32(sp)
ffffffffc02054f0:	6de2                	ld	s11,24(sp)
ffffffffc02054f2:	6109                	addi	sp,sp,128
ffffffffc02054f4:	8082                	ret
            padc = '0';
ffffffffc02054f6:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc02054f8:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02054fc:	846a                	mv	s0,s10
ffffffffc02054fe:	00140d13          	addi	s10,s0,1
ffffffffc0205502:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0205506:	0ff5f593          	zext.b	a1,a1
ffffffffc020550a:	fcb572e3          	bgeu	a0,a1,ffffffffc02054ce <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc020550e:	85a6                	mv	a1,s1
ffffffffc0205510:	02500513          	li	a0,37
ffffffffc0205514:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0205516:	fff44783          	lbu	a5,-1(s0)
ffffffffc020551a:	8d22                	mv	s10,s0
ffffffffc020551c:	f73788e3          	beq	a5,s3,ffffffffc020548c <vprintfmt+0x3a>
ffffffffc0205520:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0205524:	1d7d                	addi	s10,s10,-1
ffffffffc0205526:	ff379de3          	bne	a5,s3,ffffffffc0205520 <vprintfmt+0xce>
ffffffffc020552a:	b78d                	j	ffffffffc020548c <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc020552c:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0205530:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205534:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0205536:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc020553a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc020553e:	02d86463          	bltu	a6,a3,ffffffffc0205566 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0205542:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0205546:	002c169b          	slliw	a3,s8,0x2
ffffffffc020554a:	0186873b          	addw	a4,a3,s8
ffffffffc020554e:	0017171b          	slliw	a4,a4,0x1
ffffffffc0205552:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0205554:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0205558:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc020555a:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc020555e:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205562:	fed870e3          	bgeu	a6,a3,ffffffffc0205542 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0205566:	f40ddce3          	bgez	s11,ffffffffc02054be <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc020556a:	8de2                	mv	s11,s8
ffffffffc020556c:	5c7d                	li	s8,-1
ffffffffc020556e:	bf81                	j	ffffffffc02054be <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0205570:	fffdc693          	not	a3,s11
ffffffffc0205574:	96fd                	srai	a3,a3,0x3f
ffffffffc0205576:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020557a:	00144603          	lbu	a2,1(s0)
ffffffffc020557e:	2d81                	sext.w	s11,s11
ffffffffc0205580:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205582:	bf35                	j	ffffffffc02054be <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0205584:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205588:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc020558c:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020558e:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0205590:	bfd9                	j	ffffffffc0205566 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0205592:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205594:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0205598:	01174463          	blt	a4,a7,ffffffffc02055a0 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc020559c:	1a088e63          	beqz	a7,ffffffffc0205758 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc02055a0:	000a3603          	ld	a2,0(s4)
ffffffffc02055a4:	46c1                	li	a3,16
ffffffffc02055a6:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02055a8:	2781                	sext.w	a5,a5
ffffffffc02055aa:	876e                	mv	a4,s11
ffffffffc02055ac:	85a6                	mv	a1,s1
ffffffffc02055ae:	854a                	mv	a0,s2
ffffffffc02055b0:	e37ff0ef          	jal	ra,ffffffffc02053e6 <printnum>
            break;
ffffffffc02055b4:	bde1                	j	ffffffffc020548c <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc02055b6:	000a2503          	lw	a0,0(s4)
ffffffffc02055ba:	85a6                	mv	a1,s1
ffffffffc02055bc:	0a21                	addi	s4,s4,8
ffffffffc02055be:	9902                	jalr	s2
            break;
ffffffffc02055c0:	b5f1                	j	ffffffffc020548c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02055c2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02055c4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02055c8:	01174463          	blt	a4,a7,ffffffffc02055d0 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02055cc:	18088163          	beqz	a7,ffffffffc020574e <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02055d0:	000a3603          	ld	a2,0(s4)
ffffffffc02055d4:	46a9                	li	a3,10
ffffffffc02055d6:	8a2e                	mv	s4,a1
ffffffffc02055d8:	bfc1                	j	ffffffffc02055a8 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02055da:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc02055de:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02055e0:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02055e2:	bdf1                	j	ffffffffc02054be <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc02055e4:	85a6                	mv	a1,s1
ffffffffc02055e6:	02500513          	li	a0,37
ffffffffc02055ea:	9902                	jalr	s2
            break;
ffffffffc02055ec:	b545                	j	ffffffffc020548c <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02055ee:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc02055f2:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02055f4:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02055f6:	b5e1                	j	ffffffffc02054be <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc02055f8:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02055fa:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02055fe:	01174463          	blt	a4,a7,ffffffffc0205606 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0205602:	14088163          	beqz	a7,ffffffffc0205744 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0205606:	000a3603          	ld	a2,0(s4)
ffffffffc020560a:	46a1                	li	a3,8
ffffffffc020560c:	8a2e                	mv	s4,a1
ffffffffc020560e:	bf69                	j	ffffffffc02055a8 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0205610:	03000513          	li	a0,48
ffffffffc0205614:	85a6                	mv	a1,s1
ffffffffc0205616:	e03e                	sd	a5,0(sp)
ffffffffc0205618:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc020561a:	85a6                	mv	a1,s1
ffffffffc020561c:	07800513          	li	a0,120
ffffffffc0205620:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205622:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0205624:	6782                	ld	a5,0(sp)
ffffffffc0205626:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205628:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc020562c:	bfb5                	j	ffffffffc02055a8 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020562e:	000a3403          	ld	s0,0(s4)
ffffffffc0205632:	008a0713          	addi	a4,s4,8
ffffffffc0205636:	e03a                	sd	a4,0(sp)
ffffffffc0205638:	14040263          	beqz	s0,ffffffffc020577c <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc020563c:	0fb05763          	blez	s11,ffffffffc020572a <vprintfmt+0x2d8>
ffffffffc0205640:	02d00693          	li	a3,45
ffffffffc0205644:	0cd79163          	bne	a5,a3,ffffffffc0205706 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205648:	00044783          	lbu	a5,0(s0)
ffffffffc020564c:	0007851b          	sext.w	a0,a5
ffffffffc0205650:	cf85                	beqz	a5,ffffffffc0205688 <vprintfmt+0x236>
ffffffffc0205652:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205656:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020565a:	000c4563          	bltz	s8,ffffffffc0205664 <vprintfmt+0x212>
ffffffffc020565e:	3c7d                	addiw	s8,s8,-1
ffffffffc0205660:	036c0263          	beq	s8,s6,ffffffffc0205684 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0205664:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205666:	0e0c8e63          	beqz	s9,ffffffffc0205762 <vprintfmt+0x310>
ffffffffc020566a:	3781                	addiw	a5,a5,-32
ffffffffc020566c:	0ef47b63          	bgeu	s0,a5,ffffffffc0205762 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0205670:	03f00513          	li	a0,63
ffffffffc0205674:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205676:	000a4783          	lbu	a5,0(s4)
ffffffffc020567a:	3dfd                	addiw	s11,s11,-1
ffffffffc020567c:	0a05                	addi	s4,s4,1
ffffffffc020567e:	0007851b          	sext.w	a0,a5
ffffffffc0205682:	ffe1                	bnez	a5,ffffffffc020565a <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0205684:	01b05963          	blez	s11,ffffffffc0205696 <vprintfmt+0x244>
ffffffffc0205688:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc020568a:	85a6                	mv	a1,s1
ffffffffc020568c:	02000513          	li	a0,32
ffffffffc0205690:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0205692:	fe0d9be3          	bnez	s11,ffffffffc0205688 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0205696:	6a02                	ld	s4,0(sp)
ffffffffc0205698:	bbd5                	j	ffffffffc020548c <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc020569a:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc020569c:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc02056a0:	01174463          	blt	a4,a7,ffffffffc02056a8 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc02056a4:	08088d63          	beqz	a7,ffffffffc020573e <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc02056a8:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc02056ac:	0a044d63          	bltz	s0,ffffffffc0205766 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc02056b0:	8622                	mv	a2,s0
ffffffffc02056b2:	8a66                	mv	s4,s9
ffffffffc02056b4:	46a9                	li	a3,10
ffffffffc02056b6:	bdcd                	j	ffffffffc02055a8 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc02056b8:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02056bc:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc02056be:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02056c0:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02056c4:	8fb5                	xor	a5,a5,a3
ffffffffc02056c6:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02056ca:	02d74163          	blt	a4,a3,ffffffffc02056ec <vprintfmt+0x29a>
ffffffffc02056ce:	00369793          	slli	a5,a3,0x3
ffffffffc02056d2:	97de                	add	a5,a5,s7
ffffffffc02056d4:	639c                	ld	a5,0(a5)
ffffffffc02056d6:	cb99                	beqz	a5,ffffffffc02056ec <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc02056d8:	86be                	mv	a3,a5
ffffffffc02056da:	00000617          	auipc	a2,0x0
ffffffffc02056de:	1ee60613          	addi	a2,a2,494 # ffffffffc02058c8 <etext+0x28>
ffffffffc02056e2:	85a6                	mv	a1,s1
ffffffffc02056e4:	854a                	mv	a0,s2
ffffffffc02056e6:	0ce000ef          	jal	ra,ffffffffc02057b4 <printfmt>
ffffffffc02056ea:	b34d                	j	ffffffffc020548c <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc02056ec:	00002617          	auipc	a2,0x2
ffffffffc02056f0:	7d460613          	addi	a2,a2,2004 # ffffffffc0207ec0 <syscalls+0x820>
ffffffffc02056f4:	85a6                	mv	a1,s1
ffffffffc02056f6:	854a                	mv	a0,s2
ffffffffc02056f8:	0bc000ef          	jal	ra,ffffffffc02057b4 <printfmt>
ffffffffc02056fc:	bb41                	j	ffffffffc020548c <vprintfmt+0x3a>
                p = "(null)";
ffffffffc02056fe:	00002417          	auipc	s0,0x2
ffffffffc0205702:	7ba40413          	addi	s0,s0,1978 # ffffffffc0207eb8 <syscalls+0x818>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205706:	85e2                	mv	a1,s8
ffffffffc0205708:	8522                	mv	a0,s0
ffffffffc020570a:	e43e                	sd	a5,8(sp)
ffffffffc020570c:	0e2000ef          	jal	ra,ffffffffc02057ee <strnlen>
ffffffffc0205710:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0205714:	01b05b63          	blez	s11,ffffffffc020572a <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0205718:	67a2                	ld	a5,8(sp)
ffffffffc020571a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020571e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0205720:	85a6                	mv	a1,s1
ffffffffc0205722:	8552                	mv	a0,s4
ffffffffc0205724:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205726:	fe0d9ce3          	bnez	s11,ffffffffc020571e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc020572a:	00044783          	lbu	a5,0(s0)
ffffffffc020572e:	00140a13          	addi	s4,s0,1
ffffffffc0205732:	0007851b          	sext.w	a0,a5
ffffffffc0205736:	d3a5                	beqz	a5,ffffffffc0205696 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205738:	05e00413          	li	s0,94
ffffffffc020573c:	bf39                	j	ffffffffc020565a <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc020573e:	000a2403          	lw	s0,0(s4)
ffffffffc0205742:	b7ad                	j	ffffffffc02056ac <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0205744:	000a6603          	lwu	a2,0(s4)
ffffffffc0205748:	46a1                	li	a3,8
ffffffffc020574a:	8a2e                	mv	s4,a1
ffffffffc020574c:	bdb1                	j	ffffffffc02055a8 <vprintfmt+0x156>
ffffffffc020574e:	000a6603          	lwu	a2,0(s4)
ffffffffc0205752:	46a9                	li	a3,10
ffffffffc0205754:	8a2e                	mv	s4,a1
ffffffffc0205756:	bd89                	j	ffffffffc02055a8 <vprintfmt+0x156>
ffffffffc0205758:	000a6603          	lwu	a2,0(s4)
ffffffffc020575c:	46c1                	li	a3,16
ffffffffc020575e:	8a2e                	mv	s4,a1
ffffffffc0205760:	b5a1                	j	ffffffffc02055a8 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0205762:	9902                	jalr	s2
ffffffffc0205764:	bf09                	j	ffffffffc0205676 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0205766:	85a6                	mv	a1,s1
ffffffffc0205768:	02d00513          	li	a0,45
ffffffffc020576c:	e03e                	sd	a5,0(sp)
ffffffffc020576e:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0205770:	6782                	ld	a5,0(sp)
ffffffffc0205772:	8a66                	mv	s4,s9
ffffffffc0205774:	40800633          	neg	a2,s0
ffffffffc0205778:	46a9                	li	a3,10
ffffffffc020577a:	b53d                	j	ffffffffc02055a8 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc020577c:	03b05163          	blez	s11,ffffffffc020579e <vprintfmt+0x34c>
ffffffffc0205780:	02d00693          	li	a3,45
ffffffffc0205784:	f6d79de3          	bne	a5,a3,ffffffffc02056fe <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0205788:	00002417          	auipc	s0,0x2
ffffffffc020578c:	73040413          	addi	s0,s0,1840 # ffffffffc0207eb8 <syscalls+0x818>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205790:	02800793          	li	a5,40
ffffffffc0205794:	02800513          	li	a0,40
ffffffffc0205798:	00140a13          	addi	s4,s0,1
ffffffffc020579c:	bd6d                	j	ffffffffc0205656 <vprintfmt+0x204>
ffffffffc020579e:	00002a17          	auipc	s4,0x2
ffffffffc02057a2:	71ba0a13          	addi	s4,s4,1819 # ffffffffc0207eb9 <syscalls+0x819>
ffffffffc02057a6:	02800513          	li	a0,40
ffffffffc02057aa:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02057ae:	05e00413          	li	s0,94
ffffffffc02057b2:	b565                	j	ffffffffc020565a <vprintfmt+0x208>

ffffffffc02057b4 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02057b4:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02057b6:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02057ba:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02057bc:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02057be:	ec06                	sd	ra,24(sp)
ffffffffc02057c0:	f83a                	sd	a4,48(sp)
ffffffffc02057c2:	fc3e                	sd	a5,56(sp)
ffffffffc02057c4:	e0c2                	sd	a6,64(sp)
ffffffffc02057c6:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02057c8:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02057ca:	c89ff0ef          	jal	ra,ffffffffc0205452 <vprintfmt>
}
ffffffffc02057ce:	60e2                	ld	ra,24(sp)
ffffffffc02057d0:	6161                	addi	sp,sp,80
ffffffffc02057d2:	8082                	ret

ffffffffc02057d4 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc02057d4:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc02057d8:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc02057da:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc02057dc:	cb81                	beqz	a5,ffffffffc02057ec <strlen+0x18>
        cnt ++;
ffffffffc02057de:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc02057e0:	00a707b3          	add	a5,a4,a0
ffffffffc02057e4:	0007c783          	lbu	a5,0(a5)
ffffffffc02057e8:	fbfd                	bnez	a5,ffffffffc02057de <strlen+0xa>
ffffffffc02057ea:	8082                	ret
    }
    return cnt;
}
ffffffffc02057ec:	8082                	ret

ffffffffc02057ee <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc02057ee:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc02057f0:	e589                	bnez	a1,ffffffffc02057fa <strnlen+0xc>
ffffffffc02057f2:	a811                	j	ffffffffc0205806 <strnlen+0x18>
        cnt ++;
ffffffffc02057f4:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc02057f6:	00f58863          	beq	a1,a5,ffffffffc0205806 <strnlen+0x18>
ffffffffc02057fa:	00f50733          	add	a4,a0,a5
ffffffffc02057fe:	00074703          	lbu	a4,0(a4)
ffffffffc0205802:	fb6d                	bnez	a4,ffffffffc02057f4 <strnlen+0x6>
ffffffffc0205804:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0205806:	852e                	mv	a0,a1
ffffffffc0205808:	8082                	ret

ffffffffc020580a <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc020580a:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc020580c:	0005c703          	lbu	a4,0(a1)
ffffffffc0205810:	0785                	addi	a5,a5,1
ffffffffc0205812:	0585                	addi	a1,a1,1
ffffffffc0205814:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0205818:	fb75                	bnez	a4,ffffffffc020580c <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc020581a:	8082                	ret

ffffffffc020581c <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020581c:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205820:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205824:	cb89                	beqz	a5,ffffffffc0205836 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0205826:	0505                	addi	a0,a0,1
ffffffffc0205828:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020582a:	fee789e3          	beq	a5,a4,ffffffffc020581c <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020582e:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0205832:	9d19                	subw	a0,a0,a4
ffffffffc0205834:	8082                	ret
ffffffffc0205836:	4501                	li	a0,0
ffffffffc0205838:	bfed                	j	ffffffffc0205832 <strcmp+0x16>

ffffffffc020583a <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020583a:	c20d                	beqz	a2,ffffffffc020585c <strncmp+0x22>
ffffffffc020583c:	962e                	add	a2,a2,a1
ffffffffc020583e:	a031                	j	ffffffffc020584a <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0205840:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205842:	00e79a63          	bne	a5,a4,ffffffffc0205856 <strncmp+0x1c>
ffffffffc0205846:	00b60b63          	beq	a2,a1,ffffffffc020585c <strncmp+0x22>
ffffffffc020584a:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc020584e:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205850:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0205854:	f7f5                	bnez	a5,ffffffffc0205840 <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205856:	40e7853b          	subw	a0,a5,a4
}
ffffffffc020585a:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020585c:	4501                	li	a0,0
ffffffffc020585e:	8082                	ret

ffffffffc0205860 <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0205860:	00054783          	lbu	a5,0(a0)
ffffffffc0205864:	c799                	beqz	a5,ffffffffc0205872 <strchr+0x12>
        if (*s == c) {
ffffffffc0205866:	00f58763          	beq	a1,a5,ffffffffc0205874 <strchr+0x14>
    while (*s != '\0') {
ffffffffc020586a:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020586e:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0205870:	fbfd                	bnez	a5,ffffffffc0205866 <strchr+0x6>
    }
    return NULL;
ffffffffc0205872:	4501                	li	a0,0
}
ffffffffc0205874:	8082                	ret

ffffffffc0205876 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0205876:	ca01                	beqz	a2,ffffffffc0205886 <memset+0x10>
ffffffffc0205878:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc020587a:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc020587c:	0785                	addi	a5,a5,1
ffffffffc020587e:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0205882:	fec79de3          	bne	a5,a2,ffffffffc020587c <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0205886:	8082                	ret

ffffffffc0205888 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc0205888:	ca19                	beqz	a2,ffffffffc020589e <memcpy+0x16>
ffffffffc020588a:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc020588c:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc020588e:	0005c703          	lbu	a4,0(a1)
ffffffffc0205892:	0585                	addi	a1,a1,1
ffffffffc0205894:	0785                	addi	a5,a5,1
ffffffffc0205896:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc020589a:	fec59ae3          	bne	a1,a2,ffffffffc020588e <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc020589e:	8082                	ret
