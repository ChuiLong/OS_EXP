
obj/__user_sched_test.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800020:	0d4000ef          	jal	ra,8000f4 <umain>
1:  j 1b
  800024:	a001                	j	800024 <_start+0x4>

0000000000800026 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800026:	1141                	addi	sp,sp,-16
  800028:	e022                	sd	s0,0(sp)
  80002a:	e406                	sd	ra,8(sp)
  80002c:	842e                	mv	s0,a1
    sys_putc(c);
  80002e:	096000ef          	jal	ra,8000c4 <sys_putc>
    (*cnt) ++;
  800032:	401c                	lw	a5,0(s0)
}
  800034:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800036:	2785                	addiw	a5,a5,1
  800038:	c01c                	sw	a5,0(s0)
}
  80003a:	6402                	ld	s0,0(sp)
  80003c:	0141                	addi	sp,sp,16
  80003e:	8082                	ret

0000000000800040 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800040:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800042:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800046:	8e2a                	mv	t3,a0
  800048:	f42e                	sd	a1,40(sp)
  80004a:	f832                	sd	a2,48(sp)
  80004c:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80004e:	00000517          	auipc	a0,0x0
  800052:	fd850513          	addi	a0,a0,-40 # 800026 <cputch>
  800056:	004c                	addi	a1,sp,4
  800058:	869a                	mv	a3,t1
  80005a:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80005c:	ec06                	sd	ra,24(sp)
  80005e:	e0ba                	sd	a4,64(sp)
  800060:	e4be                	sd	a5,72(sp)
  800062:	e8c2                	sd	a6,80(sp)
  800064:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800066:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800068:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80006a:	102000ef          	jal	ra,80016c <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  80006e:	60e2                	ld	ra,24(sp)
  800070:	4512                	lw	a0,4(sp)
  800072:	6125                	addi	sp,sp,96
  800074:	8082                	ret

0000000000800076 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800076:	7175                	addi	sp,sp,-144
  800078:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  80007a:	e0ba                	sd	a4,64(sp)
  80007c:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80007e:	e42a                	sd	a0,8(sp)
  800080:	ecae                	sd	a1,88(sp)
  800082:	f0b2                	sd	a2,96(sp)
  800084:	f4b6                	sd	a3,104(sp)
  800086:	fcbe                	sd	a5,120(sp)
  800088:	e142                	sd	a6,128(sp)
  80008a:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  80008c:	f42e                	sd	a1,40(sp)
  80008e:	f832                	sd	a2,48(sp)
  800090:	fc36                	sd	a3,56(sp)
  800092:	f03a                	sd	a4,32(sp)
  800094:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800096:	4522                	lw	a0,8(sp)
  800098:	55a2                	lw	a1,40(sp)
  80009a:	5642                	lw	a2,48(sp)
  80009c:	56e2                	lw	a3,56(sp)
  80009e:	4706                	lw	a4,64(sp)
  8000a0:	47a6                	lw	a5,72(sp)
  8000a2:	00000073          	ecall
  8000a6:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  8000a8:	4572                	lw	a0,28(sp)
  8000aa:	6149                	addi	sp,sp,144
  8000ac:	8082                	ret

00000000008000ae <sys_exit>:

int
sys_exit(int64_t error_code) {
  8000ae:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  8000b0:	4505                	li	a0,1
  8000b2:	b7d1                	j	800076 <syscall>

00000000008000b4 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000b4:	4509                	li	a0,2
  8000b6:	b7c1                	j	800076 <syscall>

00000000008000b8 <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  8000b8:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  8000ba:	85aa                	mv	a1,a0
  8000bc:	450d                	li	a0,3
  8000be:	bf65                	j	800076 <syscall>

00000000008000c0 <sys_getpid>:
    return syscall(SYS_kill, pid);
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
  8000c0:	4549                	li	a0,18
  8000c2:	bf55                	j	800076 <syscall>

00000000008000c4 <sys_putc>:
}

int
sys_putc(int64_t c) {
  8000c4:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000c6:	4579                	li	a0,30
  8000c8:	b77d                	j	800076 <syscall>

00000000008000ca <sys_lab6_set_priority>:
    return syscall(SYS_gettime);
}

void
sys_lab6_set_priority(uint64_t priority)
{
  8000ca:	85aa                	mv	a1,a0
    syscall(SYS_lab6_set_priority, priority);
  8000cc:	0ff00513          	li	a0,255
  8000d0:	b75d                	j	800076 <syscall>

00000000008000d2 <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000d2:	1141                	addi	sp,sp,-16
  8000d4:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  8000d6:	fd9ff0ef          	jal	ra,8000ae <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000da:	00001517          	auipc	a0,0x1
  8000de:	9be50513          	addi	a0,a0,-1602 # 800a98 <main+0x92>
  8000e2:	f5fff0ef          	jal	ra,800040 <cprintf>
    while (1);
  8000e6:	a001                	j	8000e6 <exit+0x14>

00000000008000e8 <fork>:
}

int
fork(void) {
    return sys_fork();
  8000e8:	b7f1                	j	8000b4 <sys_fork>

00000000008000ea <waitpid>:
    return sys_wait(0, NULL);
}

int
waitpid(int pid, int *store) {
    return sys_wait(pid, store);
  8000ea:	b7f9                	j	8000b8 <sys_wait>

00000000008000ec <getpid>:
    return sys_kill(pid);
}

int
getpid(void) {
    return sys_getpid();
  8000ec:	bfd1                	j	8000c0 <sys_getpid>

00000000008000ee <lab6_setpriority>:
}

void
lab6_setpriority(uint32_t priority)
{
    sys_lab6_set_priority(priority);
  8000ee:	1502                	slli	a0,a0,0x20
  8000f0:	9101                	srli	a0,a0,0x20
  8000f2:	bfe1                	j	8000ca <sys_lab6_set_priority>

00000000008000f4 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  8000f4:	1141                	addi	sp,sp,-16
  8000f6:	e406                	sd	ra,8(sp)
    int ret = main();
  8000f8:	10f000ef          	jal	ra,800a06 <main>
    exit(ret);
  8000fc:	fd7ff0ef          	jal	ra,8000d2 <exit>

0000000000800100 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  800100:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800104:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800106:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  80010a:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  80010c:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  800110:	f022                	sd	s0,32(sp)
  800112:	ec26                	sd	s1,24(sp)
  800114:	e84a                	sd	s2,16(sp)
  800116:	f406                	sd	ra,40(sp)
  800118:	e44e                	sd	s3,8(sp)
  80011a:	84aa                	mv	s1,a0
  80011c:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  80011e:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  800122:	2a01                	sext.w	s4,s4
    if (num >= base) {
  800124:	03067e63          	bgeu	a2,a6,800160 <printnum+0x60>
  800128:	89be                	mv	s3,a5
        while (-- width > 0)
  80012a:	00805763          	blez	s0,800138 <printnum+0x38>
  80012e:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  800130:	85ca                	mv	a1,s2
  800132:	854e                	mv	a0,s3
  800134:	9482                	jalr	s1
        while (-- width > 0)
  800136:	fc65                	bnez	s0,80012e <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  800138:	1a02                	slli	s4,s4,0x20
  80013a:	00001797          	auipc	a5,0x1
  80013e:	97678793          	addi	a5,a5,-1674 # 800ab0 <main+0xaa>
  800142:	020a5a13          	srli	s4,s4,0x20
  800146:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  800148:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  80014a:	000a4503          	lbu	a0,0(s4)
}
  80014e:	70a2                	ld	ra,40(sp)
  800150:	69a2                	ld	s3,8(sp)
  800152:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  800154:	85ca                	mv	a1,s2
  800156:	87a6                	mv	a5,s1
}
  800158:	6942                	ld	s2,16(sp)
  80015a:	64e2                	ld	s1,24(sp)
  80015c:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  80015e:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  800160:	03065633          	divu	a2,a2,a6
  800164:	8722                	mv	a4,s0
  800166:	f9bff0ef          	jal	ra,800100 <printnum>
  80016a:	b7f9                	j	800138 <printnum+0x38>

000000000080016c <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  80016c:	7119                	addi	sp,sp,-128
  80016e:	f4a6                	sd	s1,104(sp)
  800170:	f0ca                	sd	s2,96(sp)
  800172:	ecce                	sd	s3,88(sp)
  800174:	e8d2                	sd	s4,80(sp)
  800176:	e4d6                	sd	s5,72(sp)
  800178:	e0da                	sd	s6,64(sp)
  80017a:	fc5e                	sd	s7,56(sp)
  80017c:	f06a                	sd	s10,32(sp)
  80017e:	fc86                	sd	ra,120(sp)
  800180:	f8a2                	sd	s0,112(sp)
  800182:	f862                	sd	s8,48(sp)
  800184:	f466                	sd	s9,40(sp)
  800186:	ec6e                	sd	s11,24(sp)
  800188:	892a                	mv	s2,a0
  80018a:	84ae                	mv	s1,a1
  80018c:	8d32                	mv	s10,a2
  80018e:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800190:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800194:	5b7d                	li	s6,-1
  800196:	00001a97          	auipc	s5,0x1
  80019a:	94ea8a93          	addi	s5,s5,-1714 # 800ae4 <main+0xde>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80019e:	00001b97          	auipc	s7,0x1
  8001a2:	b62b8b93          	addi	s7,s7,-1182 # 800d00 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001a6:	000d4503          	lbu	a0,0(s10)
  8001aa:	001d0413          	addi	s0,s10,1
  8001ae:	01350a63          	beq	a0,s3,8001c2 <vprintfmt+0x56>
            if (ch == '\0') {
  8001b2:	c121                	beqz	a0,8001f2 <vprintfmt+0x86>
            putch(ch, putdat);
  8001b4:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001b6:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001b8:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001ba:	fff44503          	lbu	a0,-1(s0)
  8001be:	ff351ae3          	bne	a0,s3,8001b2 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  8001c2:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001c6:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001ca:	4c81                	li	s9,0
  8001cc:	4881                	li	a7,0
        width = precision = -1;
  8001ce:	5c7d                	li	s8,-1
  8001d0:	5dfd                	li	s11,-1
  8001d2:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001d6:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001d8:	fdd6059b          	addiw	a1,a2,-35
  8001dc:	0ff5f593          	zext.b	a1,a1
  8001e0:	00140d13          	addi	s10,s0,1
  8001e4:	04b56263          	bltu	a0,a1,800228 <vprintfmt+0xbc>
  8001e8:	058a                	slli	a1,a1,0x2
  8001ea:	95d6                	add	a1,a1,s5
  8001ec:	4194                	lw	a3,0(a1)
  8001ee:	96d6                	add	a3,a3,s5
  8001f0:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8001f2:	70e6                	ld	ra,120(sp)
  8001f4:	7446                	ld	s0,112(sp)
  8001f6:	74a6                	ld	s1,104(sp)
  8001f8:	7906                	ld	s2,96(sp)
  8001fa:	69e6                	ld	s3,88(sp)
  8001fc:	6a46                	ld	s4,80(sp)
  8001fe:	6aa6                	ld	s5,72(sp)
  800200:	6b06                	ld	s6,64(sp)
  800202:	7be2                	ld	s7,56(sp)
  800204:	7c42                	ld	s8,48(sp)
  800206:	7ca2                	ld	s9,40(sp)
  800208:	7d02                	ld	s10,32(sp)
  80020a:	6de2                	ld	s11,24(sp)
  80020c:	6109                	addi	sp,sp,128
  80020e:	8082                	ret
            padc = '0';
  800210:	87b2                	mv	a5,a2
            goto reswitch;
  800212:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800216:	846a                	mv	s0,s10
  800218:	00140d13          	addi	s10,s0,1
  80021c:	fdd6059b          	addiw	a1,a2,-35
  800220:	0ff5f593          	zext.b	a1,a1
  800224:	fcb572e3          	bgeu	a0,a1,8001e8 <vprintfmt+0x7c>
            putch('%', putdat);
  800228:	85a6                	mv	a1,s1
  80022a:	02500513          	li	a0,37
  80022e:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  800230:	fff44783          	lbu	a5,-1(s0)
  800234:	8d22                	mv	s10,s0
  800236:	f73788e3          	beq	a5,s3,8001a6 <vprintfmt+0x3a>
  80023a:	ffed4783          	lbu	a5,-2(s10)
  80023e:	1d7d                	addi	s10,s10,-1
  800240:	ff379de3          	bne	a5,s3,80023a <vprintfmt+0xce>
  800244:	b78d                	j	8001a6 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  800246:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  80024a:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80024e:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  800250:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800254:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800258:	02d86463          	bltu	a6,a3,800280 <vprintfmt+0x114>
                ch = *fmt;
  80025c:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  800260:	002c169b          	slliw	a3,s8,0x2
  800264:	0186873b          	addw	a4,a3,s8
  800268:	0017171b          	slliw	a4,a4,0x1
  80026c:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  80026e:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  800272:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800274:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800278:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  80027c:	fed870e3          	bgeu	a6,a3,80025c <vprintfmt+0xf0>
            if (width < 0)
  800280:	f40ddce3          	bgez	s11,8001d8 <vprintfmt+0x6c>
                width = precision, precision = -1;
  800284:	8de2                	mv	s11,s8
  800286:	5c7d                	li	s8,-1
  800288:	bf81                	j	8001d8 <vprintfmt+0x6c>
            if (width < 0)
  80028a:	fffdc693          	not	a3,s11
  80028e:	96fd                	srai	a3,a3,0x3f
  800290:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  800294:	00144603          	lbu	a2,1(s0)
  800298:	2d81                	sext.w	s11,s11
  80029a:	846a                	mv	s0,s10
            goto reswitch;
  80029c:	bf35                	j	8001d8 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  80029e:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  8002a2:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  8002a6:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  8002a8:	846a                	mv	s0,s10
            goto process_precision;
  8002aa:	bfd9                	j	800280 <vprintfmt+0x114>
    if (lflag >= 2) {
  8002ac:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002ae:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002b2:	01174463          	blt	a4,a7,8002ba <vprintfmt+0x14e>
    else if (lflag) {
  8002b6:	1a088e63          	beqz	a7,800472 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002ba:	000a3603          	ld	a2,0(s4)
  8002be:	46c1                	li	a3,16
  8002c0:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002c2:	2781                	sext.w	a5,a5
  8002c4:	876e                	mv	a4,s11
  8002c6:	85a6                	mv	a1,s1
  8002c8:	854a                	mv	a0,s2
  8002ca:	e37ff0ef          	jal	ra,800100 <printnum>
            break;
  8002ce:	bde1                	j	8001a6 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002d0:	000a2503          	lw	a0,0(s4)
  8002d4:	85a6                	mv	a1,s1
  8002d6:	0a21                	addi	s4,s4,8
  8002d8:	9902                	jalr	s2
            break;
  8002da:	b5f1                	j	8001a6 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002dc:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002de:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002e2:	01174463          	blt	a4,a7,8002ea <vprintfmt+0x17e>
    else if (lflag) {
  8002e6:	18088163          	beqz	a7,800468 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8002ea:	000a3603          	ld	a2,0(s4)
  8002ee:	46a9                	li	a3,10
  8002f0:	8a2e                	mv	s4,a1
  8002f2:	bfc1                	j	8002c2 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  8002f4:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8002f8:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8002fa:	846a                	mv	s0,s10
            goto reswitch;
  8002fc:	bdf1                	j	8001d8 <vprintfmt+0x6c>
            putch(ch, putdat);
  8002fe:	85a6                	mv	a1,s1
  800300:	02500513          	li	a0,37
  800304:	9902                	jalr	s2
            break;
  800306:	b545                	j	8001a6 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  800308:	00144603          	lbu	a2,1(s0)
            lflag ++;
  80030c:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  80030e:	846a                	mv	s0,s10
            goto reswitch;
  800310:	b5e1                	j	8001d8 <vprintfmt+0x6c>
    if (lflag >= 2) {
  800312:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800314:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  800318:	01174463          	blt	a4,a7,800320 <vprintfmt+0x1b4>
    else if (lflag) {
  80031c:	14088163          	beqz	a7,80045e <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  800320:	000a3603          	ld	a2,0(s4)
  800324:	46a1                	li	a3,8
  800326:	8a2e                	mv	s4,a1
  800328:	bf69                	j	8002c2 <vprintfmt+0x156>
            putch('0', putdat);
  80032a:	03000513          	li	a0,48
  80032e:	85a6                	mv	a1,s1
  800330:	e03e                	sd	a5,0(sp)
  800332:	9902                	jalr	s2
            putch('x', putdat);
  800334:	85a6                	mv	a1,s1
  800336:	07800513          	li	a0,120
  80033a:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  80033c:	0a21                	addi	s4,s4,8
            goto number;
  80033e:	6782                	ld	a5,0(sp)
  800340:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800342:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  800346:	bfb5                	j	8002c2 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  800348:	000a3403          	ld	s0,0(s4)
  80034c:	008a0713          	addi	a4,s4,8
  800350:	e03a                	sd	a4,0(sp)
  800352:	14040263          	beqz	s0,800496 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  800356:	0fb05763          	blez	s11,800444 <vprintfmt+0x2d8>
  80035a:	02d00693          	li	a3,45
  80035e:	0cd79163          	bne	a5,a3,800420 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800362:	00044783          	lbu	a5,0(s0)
  800366:	0007851b          	sext.w	a0,a5
  80036a:	cf85                	beqz	a5,8003a2 <vprintfmt+0x236>
  80036c:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  800370:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800374:	000c4563          	bltz	s8,80037e <vprintfmt+0x212>
  800378:	3c7d                	addiw	s8,s8,-1
  80037a:	036c0263          	beq	s8,s6,80039e <vprintfmt+0x232>
                    putch('?', putdat);
  80037e:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  800380:	0e0c8e63          	beqz	s9,80047c <vprintfmt+0x310>
  800384:	3781                	addiw	a5,a5,-32
  800386:	0ef47b63          	bgeu	s0,a5,80047c <vprintfmt+0x310>
                    putch('?', putdat);
  80038a:	03f00513          	li	a0,63
  80038e:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800390:	000a4783          	lbu	a5,0(s4)
  800394:	3dfd                	addiw	s11,s11,-1
  800396:	0a05                	addi	s4,s4,1
  800398:	0007851b          	sext.w	a0,a5
  80039c:	ffe1                	bnez	a5,800374 <vprintfmt+0x208>
            for (; width > 0; width --) {
  80039e:	01b05963          	blez	s11,8003b0 <vprintfmt+0x244>
  8003a2:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  8003a4:	85a6                	mv	a1,s1
  8003a6:	02000513          	li	a0,32
  8003aa:	9902                	jalr	s2
            for (; width > 0; width --) {
  8003ac:	fe0d9be3          	bnez	s11,8003a2 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003b0:	6a02                	ld	s4,0(sp)
  8003b2:	bbd5                	j	8001a6 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003b4:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8003b6:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  8003ba:	01174463          	blt	a4,a7,8003c2 <vprintfmt+0x256>
    else if (lflag) {
  8003be:	08088d63          	beqz	a7,800458 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003c2:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003c6:	0a044d63          	bltz	s0,800480 <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003ca:	8622                	mv	a2,s0
  8003cc:	8a66                	mv	s4,s9
  8003ce:	46a9                	li	a3,10
  8003d0:	bdcd                	j	8002c2 <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003d2:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003d6:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003d8:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003da:	41f7d69b          	sraiw	a3,a5,0x1f
  8003de:	8fb5                	xor	a5,a5,a3
  8003e0:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003e4:	02d74163          	blt	a4,a3,800406 <vprintfmt+0x29a>
  8003e8:	00369793          	slli	a5,a3,0x3
  8003ec:	97de                	add	a5,a5,s7
  8003ee:	639c                	ld	a5,0(a5)
  8003f0:	cb99                	beqz	a5,800406 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8003f2:	86be                	mv	a3,a5
  8003f4:	00000617          	auipc	a2,0x0
  8003f8:	6ec60613          	addi	a2,a2,1772 # 800ae0 <main+0xda>
  8003fc:	85a6                	mv	a1,s1
  8003fe:	854a                	mv	a0,s2
  800400:	0ce000ef          	jal	ra,8004ce <printfmt>
  800404:	b34d                	j	8001a6 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  800406:	00000617          	auipc	a2,0x0
  80040a:	6ca60613          	addi	a2,a2,1738 # 800ad0 <main+0xca>
  80040e:	85a6                	mv	a1,s1
  800410:	854a                	mv	a0,s2
  800412:	0bc000ef          	jal	ra,8004ce <printfmt>
  800416:	bb41                	j	8001a6 <vprintfmt+0x3a>
                p = "(null)";
  800418:	00000417          	auipc	s0,0x0
  80041c:	6b040413          	addi	s0,s0,1712 # 800ac8 <main+0xc2>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800420:	85e2                	mv	a1,s8
  800422:	8522                	mv	a0,s0
  800424:	e43e                	sd	a5,8(sp)
  800426:	0c8000ef          	jal	ra,8004ee <strnlen>
  80042a:	40ad8dbb          	subw	s11,s11,a0
  80042e:	01b05b63          	blez	s11,800444 <vprintfmt+0x2d8>
                    putch(padc, putdat);
  800432:	67a2                	ld	a5,8(sp)
  800434:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  800438:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  80043a:	85a6                	mv	a1,s1
  80043c:	8552                	mv	a0,s4
  80043e:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  800440:	fe0d9ce3          	bnez	s11,800438 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800444:	00044783          	lbu	a5,0(s0)
  800448:	00140a13          	addi	s4,s0,1
  80044c:	0007851b          	sext.w	a0,a5
  800450:	d3a5                	beqz	a5,8003b0 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  800452:	05e00413          	li	s0,94
  800456:	bf39                	j	800374 <vprintfmt+0x208>
        return va_arg(*ap, int);
  800458:	000a2403          	lw	s0,0(s4)
  80045c:	b7ad                	j	8003c6 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  80045e:	000a6603          	lwu	a2,0(s4)
  800462:	46a1                	li	a3,8
  800464:	8a2e                	mv	s4,a1
  800466:	bdb1                	j	8002c2 <vprintfmt+0x156>
  800468:	000a6603          	lwu	a2,0(s4)
  80046c:	46a9                	li	a3,10
  80046e:	8a2e                	mv	s4,a1
  800470:	bd89                	j	8002c2 <vprintfmt+0x156>
  800472:	000a6603          	lwu	a2,0(s4)
  800476:	46c1                	li	a3,16
  800478:	8a2e                	mv	s4,a1
  80047a:	b5a1                	j	8002c2 <vprintfmt+0x156>
                    putch(ch, putdat);
  80047c:	9902                	jalr	s2
  80047e:	bf09                	j	800390 <vprintfmt+0x224>
                putch('-', putdat);
  800480:	85a6                	mv	a1,s1
  800482:	02d00513          	li	a0,45
  800486:	e03e                	sd	a5,0(sp)
  800488:	9902                	jalr	s2
                num = -(long long)num;
  80048a:	6782                	ld	a5,0(sp)
  80048c:	8a66                	mv	s4,s9
  80048e:	40800633          	neg	a2,s0
  800492:	46a9                	li	a3,10
  800494:	b53d                	j	8002c2 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800496:	03b05163          	blez	s11,8004b8 <vprintfmt+0x34c>
  80049a:	02d00693          	li	a3,45
  80049e:	f6d79de3          	bne	a5,a3,800418 <vprintfmt+0x2ac>
                p = "(null)";
  8004a2:	00000417          	auipc	s0,0x0
  8004a6:	62640413          	addi	s0,s0,1574 # 800ac8 <main+0xc2>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004aa:	02800793          	li	a5,40
  8004ae:	02800513          	li	a0,40
  8004b2:	00140a13          	addi	s4,s0,1
  8004b6:	bd6d                	j	800370 <vprintfmt+0x204>
  8004b8:	00000a17          	auipc	s4,0x0
  8004bc:	611a0a13          	addi	s4,s4,1553 # 800ac9 <main+0xc3>
  8004c0:	02800513          	li	a0,40
  8004c4:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004c8:	05e00413          	li	s0,94
  8004cc:	b565                	j	800374 <vprintfmt+0x208>

00000000008004ce <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004ce:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004d0:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004d4:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004d6:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004d8:	ec06                	sd	ra,24(sp)
  8004da:	f83a                	sd	a4,48(sp)
  8004dc:	fc3e                	sd	a5,56(sp)
  8004de:	e0c2                	sd	a6,64(sp)
  8004e0:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  8004e2:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004e4:	c89ff0ef          	jal	ra,80016c <vprintfmt>
}
  8004e8:	60e2                	ld	ra,24(sp)
  8004ea:	6161                	addi	sp,sp,80
  8004ec:	8082                	ret

00000000008004ee <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  8004ee:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  8004f0:	e589                	bnez	a1,8004fa <strnlen+0xc>
  8004f2:	a811                	j	800506 <strnlen+0x18>
        cnt ++;
  8004f4:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  8004f6:	00f58863          	beq	a1,a5,800506 <strnlen+0x18>
  8004fa:	00f50733          	add	a4,a0,a5
  8004fe:	00074703          	lbu	a4,0(a4)
  800502:	fb6d                	bnez	a4,8004f4 <strnlen+0x6>
  800504:	85be                	mv	a1,a5
    }
    return cnt;
}
  800506:	852e                	mv	a0,a1
  800508:	8082                	ret

000000000080050a <test_cpu_bound_mix>:
    int burst_time;     // 预计执行时间（用于SJF）
    int work_units;     // 实际工作量
};

// 测试场景1：CPU密集型任务混合
void test_cpu_bound_mix(void) {
  80050a:	7119                	addi	sp,sp,-128
    cprintf("\n========================================\n");
  80050c:	00001517          	auipc	a0,0x1
  800510:	8bc50513          	addi	a0,a0,-1860 # 800dc8 <error_string+0xc8>
void test_cpu_bound_mix(void) {
  800514:	fc86                	sd	ra,120(sp)
  800516:	f4a6                	sd	s1,104(sp)
  800518:	f0ca                	sd	s2,96(sp)
  80051a:	ecce                	sd	s3,88(sp)
  80051c:	e8d2                	sd	s4,80(sp)
  80051e:	f8a2                	sd	s0,112(sp)
  800520:	e4d6                	sd	s5,72(sp)
    cprintf("\n========================================\n");
  800522:	b1fff0ef          	jal	ra,800040 <cprintf>
    cprintf("Test 1: CPU-Bound Tasks Mix\n");
  800526:	00001517          	auipc	a0,0x1
  80052a:	8d250513          	addi	a0,a0,-1838 # 800df8 <error_string+0xf8>
  80052e:	b13ff0ef          	jal	ra,800040 <cprintf>
    cprintf("========================================\n");
  800532:	00001517          	auipc	a0,0x1
  800536:	8e650513          	addi	a0,a0,-1818 # 800e18 <error_string+0x118>
  80053a:	b07ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Creating 4 processes with different workloads\n");
  80053e:	00001517          	auipc	a0,0x1
  800542:	90a50513          	addi	a0,a0,-1782 # 800e48 <error_string+0x148>
  800546:	afbff0ef          	jal	ra,800040 <cprintf>
    cprintf("P1: 3 units, P2: 1 unit, P3: 2 units, P4: 4 units\n\n");
  80054a:	00001517          	auipc	a0,0x1
  80054e:	92e50513          	addi	a0,a0,-1746 # 800e78 <error_string+0x178>
  800552:	aefff0ef          	jal	ra,800040 <cprintf>
    
    int pids[4];
    int start_time = 0;  // 简化：用计数器模拟时间
    
    // 创建进程，设置不同的工作量
    int work_units[] = {3, 1, 2, 4};
  800556:	4785                	li	a5,1
  800558:	02079713          	slli	a4,a5,0x20
  80055c:	178a                	slli	a5,a5,0x22
  80055e:	070d                	addi	a4,a4,3
  800560:	0789                	addi	a5,a5,2
  800562:	0804                	addi	s1,sp,16
  800564:	f03a                	sd	a4,32(sp)
  800566:	f43e                	sd	a5,40(sp)
    int priorities[] = {3, 1, 2, 4};  // 对应优先级
  800568:	f83a                	sd	a4,48(sp)
  80056a:	fc3e                	sd	a5,56(sp)
  80056c:	89a6                	mv	s3,s1
    
    for (int i = 0; i < 4; i++) {
  80056e:	4901                	li	s2,0
  800570:	4a11                	li	s4,4
        int pid = fork();
  800572:	b77ff0ef          	jal	ra,8000e8 <fork>
  800576:	8aca                	mv	s5,s2
  800578:	842a                	mv	s0,a0
        if (pid == 0) {
            // 子进程
            cprintf("Process %d (pid=%d) started, work_units=%d\n", 
  80057a:	2905                	addiw	s2,s2,1
        if (pid == 0) {
  80057c:	cd05                	beqz	a0,8005b4 <test_cpu_bound_mix+0xaa>
            cpu_bound_work(work_units[i]);
            
            cprintf("Process %d (pid=%d) completed\n", i+1, getpid());
            exit(0);
        } else {
            pids[i] = pid;
  80057e:	00a9a023          	sw	a0,0(s3)
    for (int i = 0; i < 4; i++) {
  800582:	0991                	addi	s3,s3,4
  800584:	ff4917e3          	bne	s2,s4,800572 <test_cpu_bound_mix+0x68>
  800588:	01048413          	addi	s0,s1,16
        }
    }
    
    // 等待所有子进程
    for (int i = 0; i < 4; i++) {
        waitpid(pids[i], NULL);
  80058c:	4088                	lw	a0,0(s1)
  80058e:	4581                	li	a1,0
    for (int i = 0; i < 4; i++) {
  800590:	0491                	addi	s1,s1,4
        waitpid(pids[i], NULL);
  800592:	b59ff0ef          	jal	ra,8000ea <waitpid>
    for (int i = 0; i < 4; i++) {
  800596:	fe941be3          	bne	s0,s1,80058c <test_cpu_bound_mix+0x82>
    }
    
    cprintf("\nTest 1 completed.\n");
}
  80059a:	7446                	ld	s0,112(sp)
  80059c:	70e6                	ld	ra,120(sp)
  80059e:	74a6                	ld	s1,104(sp)
  8005a0:	7906                	ld	s2,96(sp)
  8005a2:	69e6                	ld	s3,88(sp)
  8005a4:	6a46                	ld	s4,80(sp)
  8005a6:	6aa6                	ld	s5,72(sp)
    cprintf("\nTest 1 completed.\n");
  8005a8:	00001517          	auipc	a0,0x1
  8005ac:	95850513          	addi	a0,a0,-1704 # 800f00 <error_string+0x200>
}
  8005b0:	6109                	addi	sp,sp,128
    cprintf("\nTest 1 completed.\n");
  8005b2:	b479                	j	800040 <cprintf>
            cprintf("Process %d (pid=%d) started, work_units=%d\n", 
  8005b4:	b39ff0ef          	jal	ra,8000ec <getpid>
  8005b8:	009c                	addi	a5,sp,64
  8005ba:	002a9493          	slli	s1,s5,0x2
  8005be:	94be                	add	s1,s1,a5
  8005c0:	fe04a983          	lw	s3,-32(s1)
  8005c4:	862a                	mv	a2,a0
  8005c6:	85ca                	mv	a1,s2
  8005c8:	86ce                	mv	a3,s3
  8005ca:	00001517          	auipc	a0,0x1
  8005ce:	8e650513          	addi	a0,a0,-1818 # 800eb0 <error_string+0x1b0>
  8005d2:	a6fff0ef          	jal	ra,800040 <cprintf>
            lab6_setpriority(priorities[i]);
  8005d6:	ff04a503          	lw	a0,-16(s1)
  8005da:	b15ff0ef          	jal	ra,8000ee <lab6_setpriority>
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8005de:	67e1                	lui	a5,0x18
  8005e0:	6a07879b          	addiw	a5,a5,1696
  8005e4:	033787bb          	mulw	a5,a5,s3
    volatile int sum = 0;
  8005e8:	c602                	sw	zero,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8005ea:	00f05863          	blez	a5,8005fa <test_cpu_bound_mix+0xf0>
        sum += i;
  8005ee:	4732                	lw	a4,12(sp)
  8005f0:	9f21                	addw	a4,a4,s0
  8005f2:	c63a                	sw	a4,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8005f4:	2405                	addiw	s0,s0,1
  8005f6:	fef41ce3          	bne	s0,a5,8005ee <test_cpu_bound_mix+0xe4>
            cprintf("Process %d (pid=%d) completed\n", i+1, getpid());
  8005fa:	af3ff0ef          	jal	ra,8000ec <getpid>
  8005fe:	862a                	mv	a2,a0
  800600:	85ca                	mv	a1,s2
  800602:	00001517          	auipc	a0,0x1
  800606:	8de50513          	addi	a0,a0,-1826 # 800ee0 <error_string+0x1e0>
  80060a:	a37ff0ef          	jal	ra,800040 <cprintf>
            exit(0);
  80060e:	4501                	li	a0,0
  800610:	ac3ff0ef          	jal	ra,8000d2 <exit>

0000000000800614 <test_sjf_scenario>:

// 测试场景2：短作业与长作业混合
void test_sjf_scenario(void) {
  800614:	711d                	addi	sp,sp,-96
    cprintf("\n========================================\n");
  800616:	00000517          	auipc	a0,0x0
  80061a:	7b250513          	addi	a0,a0,1970 # 800dc8 <error_string+0xc8>
void test_sjf_scenario(void) {
  80061e:	ec86                	sd	ra,88(sp)
  800620:	e4a6                	sd	s1,72(sp)
  800622:	e0ca                	sd	s2,64(sp)
  800624:	fc4e                	sd	s3,56(sp)
  800626:	e8a2                	sd	s0,80(sp)
    cprintf("\n========================================\n");
  800628:	a19ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Test 2: Short Job vs Long Job\n");
  80062c:	00001517          	auipc	a0,0x1
  800630:	8ec50513          	addi	a0,a0,-1812 # 800f18 <error_string+0x218>
  800634:	a0dff0ef          	jal	ra,800040 <cprintf>
    cprintf("========================================\n");
  800638:	00000517          	auipc	a0,0x0
  80063c:	7e050513          	addi	a0,a0,2016 # 800e18 <error_string+0x118>
  800640:	a01ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Creating jobs: Short(1), Long(5), Medium(2)\n\n");
  800644:	00001517          	auipc	a0,0x1
  800648:	8f450513          	addi	a0,a0,-1804 # 800f38 <error_string+0x238>
  80064c:	9f5ff0ef          	jal	ra,800040 <cprintf>
    
    int pids[3];
    int work_units[] = {1, 5, 2};
  800650:	4795                	li	a5,5
  800652:	1782                	slli	a5,a5,0x20
  800654:	0785                	addi	a5,a5,1
  800656:	f03e                	sd	a5,32(sp)
  800658:	4789                	li	a5,2
  80065a:	d43e                	sw	a5,40(sp)
    
    for (int i = 0; i < 3; i++) {
  80065c:	01010913          	addi	s2,sp,16
  800660:	4481                	li	s1,0
  800662:	498d                	li	s3,3
        int pid = fork();
  800664:	a85ff0ef          	jal	ra,8000e8 <fork>
  800668:	87a6                	mv	a5,s1
  80066a:	842a                	mv	s0,a0
        if (pid == 0) {
            cprintf("Job %d started (work=%d units)\n", i+1, work_units[i]);
  80066c:	2485                	addiw	s1,s1,1
        if (pid == 0) {
  80066e:	cd0d                	beqz	a0,8006a8 <test_sjf_scenario+0x94>
            cpu_bound_work(work_units[i]);
            
            cprintf("Job %d completed\n", i+1);
            exit(0);
        } else {
            pids[i] = pid;
  800670:	00a92023          	sw	a0,0(s2)
    for (int i = 0; i < 3; i++) {
  800674:	0911                	addi	s2,s2,4
  800676:	ff3497e3          	bne	s1,s3,800664 <test_sjf_scenario+0x50>
        }
    }
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
  80067a:	4542                	lw	a0,16(sp)
  80067c:	4581                	li	a1,0
  80067e:	a6dff0ef          	jal	ra,8000ea <waitpid>
  800682:	4552                	lw	a0,20(sp)
  800684:	4581                	li	a1,0
  800686:	a65ff0ef          	jal	ra,8000ea <waitpid>
  80068a:	4562                	lw	a0,24(sp)
  80068c:	4581                	li	a1,0
  80068e:	a5dff0ef          	jal	ra,8000ea <waitpid>
    }
    
    cprintf("\nTest 2 completed.\n");
}
  800692:	6446                	ld	s0,80(sp)
  800694:	60e6                	ld	ra,88(sp)
  800696:	64a6                	ld	s1,72(sp)
  800698:	6906                	ld	s2,64(sp)
  80069a:	79e2                	ld	s3,56(sp)
    cprintf("\nTest 2 completed.\n");
  80069c:	00001517          	auipc	a0,0x1
  8006a0:	90450513          	addi	a0,a0,-1788 # 800fa0 <error_string+0x2a0>
}
  8006a4:	6125                	addi	sp,sp,96
    cprintf("\nTest 2 completed.\n");
  8006a6:	ba69                	j	800040 <cprintf>
            cprintf("Job %d started (work=%d units)\n", i+1, work_units[i]);
  8006a8:	1818                	addi	a4,sp,48
  8006aa:	078a                	slli	a5,a5,0x2
  8006ac:	97ba                	add	a5,a5,a4
  8006ae:	ff07a903          	lw	s2,-16(a5) # 17ff0 <_start-0x7e8030>
  8006b2:	85a6                	mv	a1,s1
  8006b4:	00001517          	auipc	a0,0x1
  8006b8:	8b450513          	addi	a0,a0,-1868 # 800f68 <error_string+0x268>
  8006bc:	864a                	mv	a2,s2
  8006be:	983ff0ef          	jal	ra,800040 <cprintf>
            lab6_setpriority(work_units[i]);
  8006c2:	854a                	mv	a0,s2
  8006c4:	a2bff0ef          	jal	ra,8000ee <lab6_setpriority>
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8006c8:	67e1                	lui	a5,0x18
  8006ca:	6a07879b          	addiw	a5,a5,1696
  8006ce:	032787bb          	mulw	a5,a5,s2
    volatile int sum = 0;
  8006d2:	c602                	sw	zero,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8006d4:	00f05863          	blez	a5,8006e4 <test_sjf_scenario+0xd0>
        sum += i;
  8006d8:	4732                	lw	a4,12(sp)
  8006da:	9f21                	addw	a4,a4,s0
  8006dc:	c63a                	sw	a4,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8006de:	2405                	addiw	s0,s0,1
  8006e0:	fef41ce3          	bne	s0,a5,8006d8 <test_sjf_scenario+0xc4>
            cprintf("Job %d completed\n", i+1);
  8006e4:	85a6                	mv	a1,s1
  8006e6:	00001517          	auipc	a0,0x1
  8006ea:	8a250513          	addi	a0,a0,-1886 # 800f88 <error_string+0x288>
  8006ee:	953ff0ef          	jal	ra,800040 <cprintf>
            exit(0);
  8006f2:	4501                	li	a0,0
  8006f4:	9dfff0ef          	jal	ra,8000d2 <exit>

00000000008006f8 <test_priority_scenario>:

// 测试场景3：优先级测试
void test_priority_scenario(void) {
  8006f8:	7159                	addi	sp,sp,-112
    cprintf("\n========================================\n");
  8006fa:	00000517          	auipc	a0,0x0
  8006fe:	6ce50513          	addi	a0,a0,1742 # 800dc8 <error_string+0xc8>
void test_priority_scenario(void) {
  800702:	f486                	sd	ra,104(sp)
  800704:	eca6                	sd	s1,88(sp)
  800706:	e8ca                	sd	s2,80(sp)
  800708:	e4ce                	sd	s3,72(sp)
  80070a:	f0a2                	sd	s0,96(sp)
    cprintf("\n========================================\n");
  80070c:	935ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Test 3: Priority Scheduling Test\n");
  800710:	00001517          	auipc	a0,0x1
  800714:	8a850513          	addi	a0,a0,-1880 # 800fb8 <error_string+0x2b8>
  800718:	929ff0ef          	jal	ra,800040 <cprintf>
    cprintf("========================================\n");
  80071c:	00000517          	auipc	a0,0x0
  800720:	6fc50513          	addi	a0,a0,1788 # 800e18 <error_string+0x118>
  800724:	91dff0ef          	jal	ra,800040 <cprintf>
    cprintf("Creating 3 processes with priorities: Low(1), High(5), Medium(3)\n\n");
  800728:	00001517          	auipc	a0,0x1
  80072c:	8b850513          	addi	a0,a0,-1864 # 800fe0 <error_string+0x2e0>
  800730:	911ff0ef          	jal	ra,800040 <cprintf>
    
    int pids[3];
    int priorities[] = {1, 5, 3};
  800734:	4795                	li	a5,5
  800736:	1782                	slli	a5,a5,0x20
  800738:	0785                	addi	a5,a5,1
  80073a:	ec3e                	sd	a5,24(sp)
  80073c:	478d                	li	a5,3
  80073e:	d03e                	sw	a5,32(sp)
    char *names[] = {"Low", "High", "Medium"};
  800740:	00001797          	auipc	a5,0x1
  800744:	8e878793          	addi	a5,a5,-1816 # 801028 <error_string+0x328>
  800748:	f43e                	sd	a5,40(sp)
  80074a:	00001797          	auipc	a5,0x1
  80074e:	8e678793          	addi	a5,a5,-1818 # 801030 <error_string+0x330>
  800752:	f83e                	sd	a5,48(sp)
  800754:	00001797          	auipc	a5,0x1
  800758:	8e478793          	addi	a5,a5,-1820 # 801038 <error_string+0x338>
  80075c:	fc3e                	sd	a5,56(sp)
    
    for (int i = 0; i < 3; i++) {
  80075e:	00810913          	addi	s2,sp,8
  800762:	4481                	li	s1,0
  800764:	498d                	li	s3,3
        int pid = fork();
  800766:	983ff0ef          	jal	ra,8000e8 <fork>
  80076a:	842a                	mv	s0,a0
        if (pid == 0) {
  80076c:	cd1d                	beqz	a0,8007aa <test_priority_scenario+0xb2>
            cpu_bound_work(2);
            
            cprintf("%s priority process completed\n", names[i]);
            exit(0);
        } else {
            pids[i] = pid;
  80076e:	00a92023          	sw	a0,0(s2)
    for (int i = 0; i < 3; i++) {
  800772:	2485                	addiw	s1,s1,1
  800774:	0911                	addi	s2,s2,4
  800776:	ff3498e3          	bne	s1,s3,800766 <test_priority_scenario+0x6e>
        }
    }
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
  80077a:	4522                	lw	a0,8(sp)
  80077c:	4581                	li	a1,0
  80077e:	96dff0ef          	jal	ra,8000ea <waitpid>
  800782:	4532                	lw	a0,12(sp)
  800784:	4581                	li	a1,0
  800786:	965ff0ef          	jal	ra,8000ea <waitpid>
  80078a:	4542                	lw	a0,16(sp)
  80078c:	4581                	li	a1,0
  80078e:	95dff0ef          	jal	ra,8000ea <waitpid>
    }
    
    cprintf("\nTest 3 completed.\n");
}
  800792:	7406                	ld	s0,96(sp)
  800794:	70a6                	ld	ra,104(sp)
  800796:	64e6                	ld	s1,88(sp)
  800798:	6946                	ld	s2,80(sp)
  80079a:	69a6                	ld	s3,72(sp)
    cprintf("\nTest 3 completed.\n");
  80079c:	00001517          	auipc	a0,0x1
  8007a0:	8ec50513          	addi	a0,a0,-1812 # 801088 <error_string+0x388>
}
  8007a4:	6165                	addi	sp,sp,112
    cprintf("\nTest 3 completed.\n");
  8007a6:	89bff06f          	j	800040 <cprintf>
            cprintf("%s priority process (pri=%d) started\n", names[i], priorities[i]);
  8007aa:	0094                	addi	a3,sp,64
  8007ac:	00349713          	slli	a4,s1,0x3
  8007b0:	00249793          	slli	a5,s1,0x2
  8007b4:	9736                	add	a4,a4,a3
  8007b6:	97b6                	add	a5,a5,a3
  8007b8:	fe873483          	ld	s1,-24(a4)
  8007bc:	fd87a903          	lw	s2,-40(a5)
  8007c0:	00001517          	auipc	a0,0x1
  8007c4:	88050513          	addi	a0,a0,-1920 # 801040 <error_string+0x340>
  8007c8:	85a6                	mv	a1,s1
  8007ca:	864a                	mv	a2,s2
  8007cc:	875ff0ef          	jal	ra,800040 <cprintf>
            lab6_setpriority(priorities[i]);
  8007d0:	854a                	mv	a0,s2
  8007d2:	91dff0ef          	jal	ra,8000ee <lab6_setpriority>
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8007d6:	00031737          	lui	a4,0x31
    volatile int sum = 0;
  8007da:	c202                	sw	zero,4(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8007dc:	d4070713          	addi	a4,a4,-704 # 30d40 <_start-0x7cf2e0>
        sum += i;
  8007e0:	4792                	lw	a5,4(sp)
  8007e2:	9fa1                	addw	a5,a5,s0
  8007e4:	c23e                	sw	a5,4(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8007e6:	2405                	addiw	s0,s0,1
  8007e8:	fee41ce3          	bne	s0,a4,8007e0 <test_priority_scenario+0xe8>
            cprintf("%s priority process completed\n", names[i]);
  8007ec:	85a6                	mv	a1,s1
  8007ee:	00001517          	auipc	a0,0x1
  8007f2:	87a50513          	addi	a0,a0,-1926 # 801068 <error_string+0x368>
  8007f6:	84bff0ef          	jal	ra,800040 <cprintf>
            exit(0);
  8007fa:	4501                	li	a0,0
  8007fc:	8d7ff0ef          	jal	ra,8000d2 <exit>

0000000000800800 <test_mlfq_scenario>:

// 测试场景4：MLFQ行为测试
void test_mlfq_scenario(void) {
  800800:	7179                	addi	sp,sp,-48
    cprintf("\n========================================\n");
  800802:	00000517          	auipc	a0,0x0
  800806:	5c650513          	addi	a0,a0,1478 # 800dc8 <error_string+0xc8>
void test_mlfq_scenario(void) {
  80080a:	f406                	sd	ra,40(sp)
  80080c:	e84a                	sd	s2,16(sp)
  80080e:	f022                	sd	s0,32(sp)
  800810:	ec26                	sd	s1,24(sp)
    cprintf("\n========================================\n");
  800812:	82fff0ef          	jal	ra,800040 <cprintf>
    cprintf("Test 4: MLFQ Behavior Test\n");
  800816:	00001517          	auipc	a0,0x1
  80081a:	88a50513          	addi	a0,a0,-1910 # 8010a0 <error_string+0x3a0>
  80081e:	823ff0ef          	jal	ra,800040 <cprintf>
    cprintf("========================================\n");
  800822:	00000517          	auipc	a0,0x0
  800826:	5f650513          	addi	a0,a0,1526 # 800e18 <error_string+0x118>
  80082a:	817ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Creating processes with varying behavior\n\n");
  80082e:	00001517          	auipc	a0,0x1
  800832:	89250513          	addi	a0,a0,-1902 # 8010c0 <error_string+0x3c0>
  800836:	80bff0ef          	jal	ra,800040 <cprintf>
    
    int pids[3];
    
    // 进程1：短任务（应保持在高优先级）
    int pid = fork();
  80083a:	8afff0ef          	jal	ra,8000e8 <fork>
  80083e:	892a                	mv	s2,a0
    if (pid == 0) {
  800840:	c121                	beqz	a0,800880 <test_mlfq_scenario+0x80>
        exit(0);
    }
    pids[0] = pid;
    
    // 进程2：长CPU密集型任务（应降级到低优先级）
    pid = fork();
  800842:	8a7ff0ef          	jal	ra,8000e8 <fork>
  800846:	84aa                	mv	s1,a0
    if (pid == 0) {
  800848:	c145                	beqz	a0,8008e8 <test_mlfq_scenario+0xe8>
        exit(0);
    }
    pids[1] = pid;
    
    // 进程3：中等任务
    pid = fork();
  80084a:	89fff0ef          	jal	ra,8000e8 <fork>
  80084e:	842a                	mv	s0,a0
    if (pid == 0) {
  800850:	c135                	beqz	a0,8008b4 <test_mlfq_scenario+0xb4>
        exit(0);
    }
    pids[2] = pid;
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
  800852:	4581                	li	a1,0
  800854:	854a                	mv	a0,s2
  800856:	895ff0ef          	jal	ra,8000ea <waitpid>
  80085a:	4581                	li	a1,0
  80085c:	8526                	mv	a0,s1
  80085e:	88dff0ef          	jal	ra,8000ea <waitpid>
  800862:	8522                	mv	a0,s0
  800864:	4581                	li	a1,0
  800866:	885ff0ef          	jal	ra,8000ea <waitpid>
    }
    
    cprintf("\nTest 4 completed.\n");
}
  80086a:	7402                	ld	s0,32(sp)
  80086c:	70a2                	ld	ra,40(sp)
  80086e:	64e2                	ld	s1,24(sp)
  800870:	6942                	ld	s2,16(sp)
    cprintf("\nTest 4 completed.\n");
  800872:	00001517          	auipc	a0,0x1
  800876:	91e50513          	addi	a0,a0,-1762 # 801190 <error_string+0x490>
}
  80087a:	6145                	addi	sp,sp,48
    cprintf("\nTest 4 completed.\n");
  80087c:	fc4ff06f          	j	800040 <cprintf>
        cprintf("Short task started\n");
  800880:	00001517          	auipc	a0,0x1
  800884:	87050513          	addi	a0,a0,-1936 # 8010f0 <error_string+0x3f0>
  800888:	fb8ff0ef          	jal	ra,800040 <cprintf>
    for (int i = 0; i < units * WORK_UNIT; i++) {
  80088c:	67e1                	lui	a5,0x18
    volatile int sum = 0;
  80088e:	c602                	sw	zero,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  800890:	6a078793          	addi	a5,a5,1696 # 186a0 <_start-0x7e7980>
        sum += i;
  800894:	4732                	lw	a4,12(sp)
  800896:	0127073b          	addw	a4,a4,s2
  80089a:	c63a                	sw	a4,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  80089c:	2905                	addiw	s2,s2,1
  80089e:	fef91be3          	bne	s2,a5,800894 <test_mlfq_scenario+0x94>
        cprintf("Short task completed\n");
  8008a2:	00001517          	auipc	a0,0x1
  8008a6:	86650513          	addi	a0,a0,-1946 # 801108 <error_string+0x408>
  8008aa:	f96ff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  8008ae:	4501                	li	a0,0
  8008b0:	823ff0ef          	jal	ra,8000d2 <exit>
        cprintf("Medium task started\n");
  8008b4:	00001517          	auipc	a0,0x1
  8008b8:	8ac50513          	addi	a0,a0,-1876 # 801160 <error_string+0x460>
  8008bc:	f84ff0ef          	jal	ra,800040 <cprintf>
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8008c0:	000497b7          	lui	a5,0x49
    volatile int sum = 0;
  8008c4:	c602                	sw	zero,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8008c6:	3e078793          	addi	a5,a5,992 # 493e0 <_start-0x7b6c40>
        sum += i;
  8008ca:	4732                	lw	a4,12(sp)
  8008cc:	9f21                	addw	a4,a4,s0
  8008ce:	c63a                	sw	a4,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8008d0:	2405                	addiw	s0,s0,1
  8008d2:	fef41ce3          	bne	s0,a5,8008ca <test_mlfq_scenario+0xca>
        cprintf("Medium task completed\n");
  8008d6:	00001517          	auipc	a0,0x1
  8008da:	8a250513          	addi	a0,a0,-1886 # 801178 <error_string+0x478>
  8008de:	f62ff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  8008e2:	4501                	li	a0,0
  8008e4:	feeff0ef          	jal	ra,8000d2 <exit>
        cprintf("Long CPU-bound task started\n");
  8008e8:	00001517          	auipc	a0,0x1
  8008ec:	83850513          	addi	a0,a0,-1992 # 801120 <error_string+0x420>
  8008f0:	f50ff0ef          	jal	ra,800040 <cprintf>
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8008f4:	000927b7          	lui	a5,0x92
    volatile int sum = 0;
  8008f8:	c602                	sw	zero,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  8008fa:	7c078793          	addi	a5,a5,1984 # 927c0 <_start-0x76d860>
        sum += i;
  8008fe:	4732                	lw	a4,12(sp)
  800900:	9f25                	addw	a4,a4,s1
  800902:	c63a                	sw	a4,12(sp)
    for (int i = 0; i < units * WORK_UNIT; i++) {
  800904:	2485                	addiw	s1,s1,1
  800906:	fef49ce3          	bne	s1,a5,8008fe <test_mlfq_scenario+0xfe>
        cprintf("Long CPU-bound task completed\n");
  80090a:	00001517          	auipc	a0,0x1
  80090e:	83650513          	addi	a0,a0,-1994 # 801140 <error_string+0x440>
  800912:	f2eff0ef          	jal	ra,800040 <cprintf>
        exit(0);
  800916:	4501                	li	a0,0
  800918:	fbaff0ef          	jal	ra,8000d2 <exit>

000000000080091c <test_fairness>:

// 测试场景5：公平性测试（用于RR和Stride比较）
void test_fairness(void) {
  80091c:	715d                	addi	sp,sp,-80
    cprintf("\n========================================\n");
  80091e:	00000517          	auipc	a0,0x0
  800922:	4aa50513          	addi	a0,a0,1194 # 800dc8 <error_string+0xc8>
void test_fairness(void) {
  800926:	e486                	sd	ra,72(sp)
  800928:	e0a2                	sd	s0,64(sp)
  80092a:	fc26                	sd	s1,56(sp)
  80092c:	f84a                	sd	s2,48(sp)
  80092e:	f44e                	sd	s3,40(sp)
    cprintf("\n========================================\n");
  800930:	f10ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Test 5: Fairness Test\n");
  800934:	00001517          	auipc	a0,0x1
  800938:	87450513          	addi	a0,a0,-1932 # 8011a8 <error_string+0x4a8>
  80093c:	f04ff0ef          	jal	ra,800040 <cprintf>
    cprintf("========================================\n");
  800940:	00000517          	auipc	a0,0x0
  800944:	4d850513          	addi	a0,a0,1240 # 800e18 <error_string+0x118>
  800948:	ef8ff0ef          	jal	ra,800040 <cprintf>
    cprintf("Creating 3 equal-priority processes\n\n");
  80094c:	00001517          	auipc	a0,0x1
  800950:	87450513          	addi	a0,a0,-1932 # 8011c0 <error_string+0x4c0>
  800954:	eecff0ef          	jal	ra,800040 <cprintf>
    
    int pids[3];
    
    for (int i = 0; i < 3; i++) {
  800958:	0804                	addi	s1,sp,16
  80095a:	4401                	li	s0,0
  80095c:	490d                	li	s2,3
        int pid = fork();
  80095e:	f8aff0ef          	jal	ra,8000e8 <fork>
        if (pid == 0) {
            cprintf("Process %d started\n", i+1);
  800962:	2405                	addiw	s0,s0,1
        if (pid == 0) {
  800964:	cd0d                	beqz	a0,80099e <test_fairness+0x82>
            }
            
            cprintf("Process %d completed, total iterations: %d\n", i+1, count);
            exit(0);
        } else {
            pids[i] = pid;
  800966:	c088                	sw	a0,0(s1)
    for (int i = 0; i < 3; i++) {
  800968:	0491                	addi	s1,s1,4
  80096a:	ff241ae3          	bne	s0,s2,80095e <test_fairness+0x42>
        }
    }
    
    for (int i = 0; i < 3; i++) {
        waitpid(pids[i], NULL);
  80096e:	4542                	lw	a0,16(sp)
  800970:	4581                	li	a1,0
  800972:	f78ff0ef          	jal	ra,8000ea <waitpid>
  800976:	4552                	lw	a0,20(sp)
  800978:	4581                	li	a1,0
  80097a:	f70ff0ef          	jal	ra,8000ea <waitpid>
  80097e:	4562                	lw	a0,24(sp)
  800980:	4581                	li	a1,0
  800982:	f68ff0ef          	jal	ra,8000ea <waitpid>
    }
    
    cprintf("\nTest 5 completed.\n");
}
  800986:	6406                	ld	s0,64(sp)
  800988:	60a6                	ld	ra,72(sp)
  80098a:	74e2                	ld	s1,56(sp)
  80098c:	7942                	ld	s2,48(sp)
  80098e:	79a2                	ld	s3,40(sp)
    cprintf("\nTest 5 completed.\n");
  800990:	00001517          	auipc	a0,0x1
  800994:	8b850513          	addi	a0,a0,-1864 # 801248 <error_string+0x548>
}
  800998:	6161                	addi	sp,sp,80
    cprintf("\nTest 5 completed.\n");
  80099a:	ea6ff06f          	j	800040 <cprintf>
            cprintf("Process %d started\n", i+1);
  80099e:	85a2                	mv	a1,s0
  8009a0:	00001517          	auipc	a0,0x1
  8009a4:	84850513          	addi	a0,a0,-1976 # 8011e8 <error_string+0x4e8>
  8009a8:	e98ff0ef          	jal	ra,800040 <cprintf>
            lab6_setpriority(1);  // 相同优先级
  8009ac:	4505                	li	a0,1
            volatile int count = 0;
  8009ae:	004c54b7          	lui	s1,0x4c5
                if (count % 1000000 == 0) {
  8009b2:	000f4937          	lui	s2,0xf4
            lab6_setpriority(1);  // 相同优先级
  8009b6:	f38ff0ef          	jal	ra,8000ee <lab6_setpriority>
            volatile int count = 0;
  8009ba:	b4048493          	addi	s1,s1,-1216 # 4c4b40 <_start-0x33b4e0>
  8009be:	c602                	sw	zero,12(sp)
                if (count % 1000000 == 0) {
  8009c0:	2409091b          	addiw	s2,s2,576
                    cprintf("P%d: %d iterations\n", i+1, count);
  8009c4:	00001997          	auipc	s3,0x1
  8009c8:	83c98993          	addi	s3,s3,-1988 # 801200 <error_string+0x500>
  8009cc:	a019                	j	8009d2 <test_fairness+0xb6>
            for (int j = 0; j < 5000000; j++) {
  8009ce:	34fd                	addiw	s1,s1,-1
  8009d0:	cc99                	beqz	s1,8009ee <test_fairness+0xd2>
                count++;
  8009d2:	47b2                	lw	a5,12(sp)
  8009d4:	2785                	addiw	a5,a5,1
  8009d6:	c63e                	sw	a5,12(sp)
                if (count % 1000000 == 0) {
  8009d8:	47b2                	lw	a5,12(sp)
  8009da:	0327e7bb          	remw	a5,a5,s2
  8009de:	fbe5                	bnez	a5,8009ce <test_fairness+0xb2>
                    cprintf("P%d: %d iterations\n", i+1, count);
  8009e0:	4632                	lw	a2,12(sp)
  8009e2:	85a2                	mv	a1,s0
  8009e4:	854e                	mv	a0,s3
  8009e6:	2601                	sext.w	a2,a2
  8009e8:	e58ff0ef          	jal	ra,800040 <cprintf>
  8009ec:	b7cd                	j	8009ce <test_fairness+0xb2>
            cprintf("Process %d completed, total iterations: %d\n", i+1, count);
  8009ee:	4632                	lw	a2,12(sp)
  8009f0:	85a2                	mv	a1,s0
  8009f2:	00001517          	auipc	a0,0x1
  8009f6:	82650513          	addi	a0,a0,-2010 # 801218 <error_string+0x518>
  8009fa:	2601                	sext.w	a2,a2
  8009fc:	e44ff0ef          	jal	ra,800040 <cprintf>
            exit(0);
  800a00:	4501                	li	a0,0
  800a02:	ed0ff0ef          	jal	ra,8000d2 <exit>

0000000000800a06 <main>:

int main(void) {
  800a06:	1141                	addi	sp,sp,-16
    cprintf("\n");
  800a08:	00001517          	auipc	a0,0x1
  800a0c:	96050513          	addi	a0,a0,-1696 # 801368 <error_string+0x668>
int main(void) {
  800a10:	e406                	sd	ra,8(sp)
    cprintf("\n");
  800a12:	e2eff0ef          	jal	ra,800040 <cprintf>
    cprintf("###############################################\n");
  800a16:	00001517          	auipc	a0,0x1
  800a1a:	84a50513          	addi	a0,a0,-1974 # 801260 <error_string+0x560>
  800a1e:	e22ff0ef          	jal	ra,800040 <cprintf>
    cprintf("#    Scheduling Algorithm Comparison Test     #\n");
  800a22:	00001517          	auipc	a0,0x1
  800a26:	87650513          	addi	a0,a0,-1930 # 801298 <error_string+0x598>
  800a2a:	e16ff0ef          	jal	ra,800040 <cprintf>
    cprintf("###############################################\n");
  800a2e:	00001517          	auipc	a0,0x1
  800a32:	83250513          	addi	a0,a0,-1998 # 801260 <error_string+0x560>
  800a36:	e0aff0ef          	jal	ra,800040 <cprintf>
    cprintf("\nCurrent scheduler will be used for all tests.\n");
  800a3a:	00001517          	auipc	a0,0x1
  800a3e:	89650513          	addi	a0,a0,-1898 # 8012d0 <error_string+0x5d0>
  800a42:	dfeff0ef          	jal	ra,800040 <cprintf>
    cprintf("Run this test with different schedulers to compare.\n");
  800a46:	00001517          	auipc	a0,0x1
  800a4a:	8ba50513          	addi	a0,a0,-1862 # 801300 <error_string+0x600>
  800a4e:	df2ff0ef          	jal	ra,800040 <cprintf>
    
    // 运行所有测试
    test_cpu_bound_mix();
  800a52:	ab9ff0ef          	jal	ra,80050a <test_cpu_bound_mix>
    test_sjf_scenario();
  800a56:	bbfff0ef          	jal	ra,800614 <test_sjf_scenario>
    test_priority_scenario();
  800a5a:	c9fff0ef          	jal	ra,8006f8 <test_priority_scenario>
    test_mlfq_scenario();
  800a5e:	da3ff0ef          	jal	ra,800800 <test_mlfq_scenario>
    test_fairness();
  800a62:	ebbff0ef          	jal	ra,80091c <test_fairness>
    
    cprintf("\n###############################################\n");
  800a66:	00001517          	auipc	a0,0x1
  800a6a:	8d250513          	addi	a0,a0,-1838 # 801338 <error_string+0x638>
  800a6e:	dd2ff0ef          	jal	ra,800040 <cprintf>
    cprintf("#           All Tests Completed               #\n");
  800a72:	00001517          	auipc	a0,0x1
  800a76:	8fe50513          	addi	a0,a0,-1794 # 801370 <error_string+0x670>
  800a7a:	dc6ff0ef          	jal	ra,800040 <cprintf>
    cprintf("###############################################\n");
  800a7e:	00000517          	auipc	a0,0x0
  800a82:	7e250513          	addi	a0,a0,2018 # 801260 <error_string+0x560>
  800a86:	dbaff0ef          	jal	ra,800040 <cprintf>
    
    return 0;
}
  800a8a:	60a2                	ld	ra,8(sp)
  800a8c:	4501                	li	a0,0
  800a8e:	0141                	addi	sp,sp,16
  800a90:	8082                	ret
