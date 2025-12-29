
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00013297          	auipc	t0,0x13
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0213000 <boot_hartid>
ffffffffc020000c:	00013297          	auipc	t0,0x13
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0213008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02122b7          	lui	t0,0xc0212
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0212137          	lui	sp,0xc0212
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00090517          	auipc	a0,0x90
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0290060 <buf>
ffffffffc0200052:	00096617          	auipc	a2,0x96
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0295910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	26d0a0ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	ace58593          	addi	a1,a1,-1330 # ffffffffc020ab38 <etext>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	ae650513          	addi	a0,a0,-1306 # ffffffffc020ab58 <etext+0x20>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	24b020ef          	jal	ra,ffffffffc0202ad0 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	565030ef          	jal	ra,ffffffffc0203df6 <vmm_init>
ffffffffc0200096:	205060ef          	jal	ra,ffffffffc0206a9a <sched_init>
ffffffffc020009a:	60a060ef          	jal	ra,ffffffffc02066a4 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	797040ef          	jal	ra,ffffffffc0205038 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	7c2060ef          	jal	ra,ffffffffc0206870 <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	a9850513          	addi	a0,a0,-1384 # ffffffffc020ab60 <etext+0x28>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00090b97          	auipc	s7,0x90
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0290060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00090517          	auipc	a0,0x90
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0290060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd611c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	4a60a0ef          	jal	ra,ffffffffc020a640 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0212028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd611c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	46a0a0ef          	jal	ra,ffffffffc020a640 <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	02d0a0ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	10b0a0ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	93a50513          	addi	a0,a0,-1734 # ffffffffc020ab68 <etext+0x30>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	94450513          	addi	a0,a0,-1724 # ffffffffc020ab88 <etext+0x50>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	8e858593          	addi	a1,a1,-1816 # ffffffffc020ab38 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	95050513          	addi	a0,a0,-1712 # ffffffffc020aba8 <etext+0x70>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00090597          	auipc	a1,0x90
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0290060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	95c50513          	addi	a0,a0,-1700 # ffffffffc020abc8 <etext+0x90>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00095597          	auipc	a1,0x95
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0295910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	96850513          	addi	a0,a0,-1688 # ffffffffc020abe8 <etext+0xb0>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00096597          	auipc	a1,0x96
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0295d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	95a50513          	addi	a0,a0,-1702 # ffffffffc020ac08 <etext+0xd0>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	97c60613          	addi	a2,a2,-1668 # ffffffffc020ac38 <etext+0x100>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	98850513          	addi	a0,a0,-1656 # ffffffffc020ac50 <etext+0x118>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	99060613          	addi	a2,a2,-1648 # ffffffffc020ac68 <etext+0x130>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	9a858593          	addi	a1,a1,-1624 # ffffffffc020ac88 <etext+0x150>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	9a850513          	addi	a0,a0,-1624 # ffffffffc020ac90 <etext+0x158>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	9aa60613          	addi	a2,a2,-1622 # ffffffffc020aca0 <etext+0x168>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	9ca58593          	addi	a1,a1,-1590 # ffffffffc020acc8 <etext+0x190>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	98a50513          	addi	a0,a0,-1654 # ffffffffc020ac90 <etext+0x158>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	9c660613          	addi	a2,a2,-1594 # ffffffffc020acd8 <etext+0x1a0>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	9de58593          	addi	a1,a1,-1570 # ffffffffc020acf8 <etext+0x1c0>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	96e50513          	addi	a0,a0,-1682 # ffffffffc020ac90 <etext+0x158>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	9ac50513          	addi	a0,a0,-1620 # ffffffffc020ad08 <etext+0x1d0>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	9b250513          	addi	a0,a0,-1614 # ffffffffc020ad30 <etext+0x1f8>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	a0cc0c13          	addi	s8,s8,-1524 # ffffffffc020ada0 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	9bc90913          	addi	s2,s2,-1604 # ffffffffc020ad58 <etext+0x220>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	9bc48493          	addi	s1,s1,-1604 # ffffffffc020ad60 <etext+0x228>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	9bab0b13          	addi	s6,s6,-1606 # ffffffffc020ad68 <etext+0x230>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	8d2a0a13          	addi	s4,s4,-1838 # ffffffffc020ac88 <etext+0x150>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	9c8d0d13          	addi	s10,s10,-1592 # ffffffffc020ada0 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	68e0a0ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	67a0a0ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	6800a0ef          	jal	ra,ffffffffc020aab8 <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	6420a0ef          	jal	ra,ffffffffc020aab8 <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	8f850513          	addi	a0,a0,-1800 # ffffffffc020ad88 <etext+0x250>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00095317          	auipc	t1,0x95
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0295868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	91c50513          	addi	a0,a0,-1764 # ffffffffc020ade8 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	bc650513          	addi	a0,a0,-1082 # ffffffffc020c0a8 <default_pmm_manager+0x610>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	8f250513          	addi	a0,a0,-1806 # ffffffffc020ae08 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000c517          	auipc	a0,0xc
ffffffffc020053a:	b7250513          	addi	a0,a0,-1166 # ffffffffc020c0a8 <default_pmm_manager+0x610>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	8c050513          	addi	a0,a0,-1856 # ffffffffc020ae28 <commands+0x88>
ffffffffc0200570:	00095797          	auipc	a5,0x95
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0295870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00090697          	auipc	a3,0x90
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0290460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00090797          	auipc	a5,0x90
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0290664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00090797          	auipc	a5,0x90
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0290660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000a517          	auipc	a0,0xa
ffffffffc02006b2:	79a50513          	addi	a0,a0,1946 # ffffffffc020ae48 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00013597          	auipc	a1,0x13
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0213000 <boot_hartid>
ffffffffc02006dc:	0000a517          	auipc	a0,0xa
ffffffffc02006e0:	77c50513          	addi	a0,a0,1916 # ffffffffc020ae58 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00013417          	auipc	s0,0x13
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0213008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000a517          	auipc	a0,0xa
ffffffffc02006f6:	77650513          	addi	a0,a0,1910 # ffffffffc020ae68 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000a517          	auipc	a0,0xa
ffffffffc0200706:	77e50513          	addi	a0,a0,1918 # ffffffffc020ae80 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe4a5dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000a917          	auipc	s2,0xa
ffffffffc02007c0:	71490913          	addi	s2,s2,1812 # ffffffffc020aed0 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000a497          	auipc	s1,0xa
ffffffffc02007ce:	6fe48493          	addi	s1,s1,1790 # ffffffffc020aec8 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000a517          	auipc	a0,0xa
ffffffffc0200822:	72a50513          	addi	a0,a0,1834 # ffffffffc020af48 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000a517          	auipc	a0,0xa
ffffffffc020082e:	75650513          	addi	a0,a0,1878 # ffffffffc020af80 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000a517          	auipc	a0,0xa
ffffffffc020086e:	63650513          	addi	a0,a0,1590 # ffffffffc020aea0 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	1b40a0ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	20c0a0ef          	jal	ra,ffffffffc020aa92 <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	1580a0ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000a517          	auipc	a0,0xa
ffffffffc0200934:	5a850513          	addi	a0,a0,1448 # ffffffffc020aed8 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000a517          	auipc	a0,0xa
ffffffffc0200a02:	4fa50513          	addi	a0,a0,1274 # ffffffffc020aef8 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000a517          	auipc	a0,0xa
ffffffffc0200a14:	50050513          	addi	a0,a0,1280 # ffffffffc020af10 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000a517          	auipc	a0,0xa
ffffffffc0200a26:	50e50513          	addi	a0,a0,1294 # ffffffffc020af30 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000a517          	auipc	a0,0xa
ffffffffc0200a32:	55250513          	addi	a0,a0,1362 # ffffffffc020af80 <commands+0x1e0>
ffffffffc0200a36:	00095797          	auipc	a5,0x95
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0295878 <memory_base>
ffffffffc0200a3e:	00095797          	auipc	a5,0x95
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0295880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00095517          	auipc	a0,0x95
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0295878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00095517          	auipc	a0,0x95
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0295880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00090597          	auipc	a1,0x90
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02906b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00090797          	auipc	a5,0x90
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0290668 <ide_devices>
ffffffffc0200a72:	00090797          	auipc	a5,0x90
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02906b8 <ide_devices+0x50>
ffffffffc0200a7a:	00090797          	auipc	a5,0x90
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0290708 <ide_devices+0xa0>
ffffffffc0200a82:	00090797          	auipc	a5,0x90
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0290758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00090417          	auipc	s0,0x90
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0290668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00090597          	auipc	a1,0x90
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0290708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000a697          	auipc	a3,0xa
ffffffffc0200abc:	4e068693          	addi	a3,a3,1248 # ffffffffc020af98 <commands+0x1f8>
ffffffffc0200ac0:	0000a617          	auipc	a2,0xa
ffffffffc0200ac4:	4f060613          	addi	a2,a2,1264 # ffffffffc020afb0 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000a517          	auipc	a0,0xa
ffffffffc0200ace:	4fe50513          	addi	a0,a0,1278 # ffffffffc020afc8 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000a697          	auipc	a3,0xa
ffffffffc0200ada:	50a68693          	addi	a3,a3,1290 # ffffffffc020afe0 <commands+0x240>
ffffffffc0200ade:	0000a617          	auipc	a2,0xa
ffffffffc0200ae2:	4d260613          	addi	a2,a2,1234 # ffffffffc020afb0 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000a517          	auipc	a0,0xa
ffffffffc0200aec:	4e050513          	addi	a0,a0,1248 # ffffffffc020afc8 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00090797          	auipc	a5,0x90
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0290668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00090797          	auipc	a5,0x90
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0290668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00090817          	auipc	a6,0x90
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0290668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000a697          	auipc	a3,0xa
ffffffffc0200b9a:	46268693          	addi	a3,a3,1122 # ffffffffc020aff8 <commands+0x258>
ffffffffc0200b9e:	0000a617          	auipc	a2,0xa
ffffffffc0200ba2:	41260613          	addi	a2,a2,1042 # ffffffffc020afb0 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000a517          	auipc	a0,0xa
ffffffffc0200bae:	41e50513          	addi	a0,a0,1054 # ffffffffc020afc8 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000a697          	auipc	a3,0xa
ffffffffc0200bba:	46a68693          	addi	a3,a3,1130 # ffffffffc020b020 <commands+0x280>
ffffffffc0200bbe:	0000a617          	auipc	a2,0xa
ffffffffc0200bc2:	3f260613          	addi	a2,a2,1010 # ffffffffc020afb0 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000a517          	auipc	a0,0xa
ffffffffc0200bce:	3fe50513          	addi	a0,a0,1022 # ffffffffc020afc8 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00090817          	auipc	a6,0x90
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0290668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000a697          	auipc	a3,0xa
ffffffffc0200c30:	3cc68693          	addi	a3,a3,972 # ffffffffc020aff8 <commands+0x258>
ffffffffc0200c34:	0000a617          	auipc	a2,0xa
ffffffffc0200c38:	37c60613          	addi	a2,a2,892 # ffffffffc020afb0 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000a517          	auipc	a0,0xa
ffffffffc0200c44:	38850513          	addi	a0,a0,904 # ffffffffc020afc8 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000a697          	auipc	a3,0xa
ffffffffc0200c50:	3d468693          	addi	a3,a3,980 # ffffffffc020b020 <commands+0x280>
ffffffffc0200c54:	0000a617          	auipc	a2,0xa
ffffffffc0200c58:	35c60613          	addi	a2,a2,860 # ffffffffc020afb0 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000a517          	auipc	a0,0xa
ffffffffc0200c64:	36850513          	addi	a0,a0,872 # ffffffffc020afc8 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	689090ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	65f090ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	5eb090ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	0008f617          	auipc	a2,0x8f
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0290010 <arena>
ffffffffc0200cf8:	0001a917          	auipc	s2,0x1a
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021ad10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000a517          	auipc	a0,0xa
ffffffffc0200d16:	36650513          	addi	a0,a0,870 # ffffffffc020b078 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000a597          	auipc	a1,0xa
ffffffffc0200d38:	39c58593          	addi	a1,a1,924 # ffffffffc020b0d0 <commands+0x330>
ffffffffc0200d3c:	527090ef          	jal	ra,ffffffffc020aa62 <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001a617          	auipc	a2,0x1a
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021ad10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00012917          	auipc	s2,0x12
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0213010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000a517          	auipc	a0,0xa
ffffffffc0200d80:	2e450513          	addi	a0,a0,740 # ffffffffc020b060 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000a617          	auipc	a2,0xa
ffffffffc0200d8e:	31660613          	addi	a2,a2,790 # ffffffffc020b0a0 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000a517          	auipc	a0,0xa
ffffffffc0200d9a:	32250513          	addi	a0,a0,802 # ffffffffc020b0b8 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000a517          	auipc	a0,0xa
ffffffffc0200dc8:	31c50513          	addi	a0,a0,796 # ffffffffc020b0e0 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000a517          	auipc	a0,0xa
ffffffffc0200dd8:	32450513          	addi	a0,a0,804 # ffffffffc020b0f8 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000a517          	auipc	a0,0xa
ffffffffc0200de6:	32e50513          	addi	a0,a0,814 # ffffffffc020b110 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000a517          	auipc	a0,0xa
ffffffffc0200df4:	33850513          	addi	a0,a0,824 # ffffffffc020b128 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000a517          	auipc	a0,0xa
ffffffffc0200e02:	34250513          	addi	a0,a0,834 # ffffffffc020b140 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000a517          	auipc	a0,0xa
ffffffffc0200e10:	34c50513          	addi	a0,a0,844 # ffffffffc020b158 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000a517          	auipc	a0,0xa
ffffffffc0200e1e:	35650513          	addi	a0,a0,854 # ffffffffc020b170 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000a517          	auipc	a0,0xa
ffffffffc0200e2c:	36050513          	addi	a0,a0,864 # ffffffffc020b188 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000a517          	auipc	a0,0xa
ffffffffc0200e3a:	36a50513          	addi	a0,a0,874 # ffffffffc020b1a0 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000a517          	auipc	a0,0xa
ffffffffc0200e48:	37450513          	addi	a0,a0,884 # ffffffffc020b1b8 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000a517          	auipc	a0,0xa
ffffffffc0200e56:	37e50513          	addi	a0,a0,894 # ffffffffc020b1d0 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000a517          	auipc	a0,0xa
ffffffffc0200e64:	38850513          	addi	a0,a0,904 # ffffffffc020b1e8 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000a517          	auipc	a0,0xa
ffffffffc0200e72:	39250513          	addi	a0,a0,914 # ffffffffc020b200 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000a517          	auipc	a0,0xa
ffffffffc0200e80:	39c50513          	addi	a0,a0,924 # ffffffffc020b218 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000a517          	auipc	a0,0xa
ffffffffc0200e8e:	3a650513          	addi	a0,a0,934 # ffffffffc020b230 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000a517          	auipc	a0,0xa
ffffffffc0200e9c:	3b050513          	addi	a0,a0,944 # ffffffffc020b248 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000a517          	auipc	a0,0xa
ffffffffc0200eaa:	3ba50513          	addi	a0,a0,954 # ffffffffc020b260 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000a517          	auipc	a0,0xa
ffffffffc0200eb8:	3c450513          	addi	a0,a0,964 # ffffffffc020b278 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000a517          	auipc	a0,0xa
ffffffffc0200ec6:	3ce50513          	addi	a0,a0,974 # ffffffffc020b290 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000a517          	auipc	a0,0xa
ffffffffc0200ed4:	3d850513          	addi	a0,a0,984 # ffffffffc020b2a8 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000a517          	auipc	a0,0xa
ffffffffc0200ee2:	3e250513          	addi	a0,a0,994 # ffffffffc020b2c0 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000a517          	auipc	a0,0xa
ffffffffc0200ef0:	3ec50513          	addi	a0,a0,1004 # ffffffffc020b2d8 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000a517          	auipc	a0,0xa
ffffffffc0200efe:	3f650513          	addi	a0,a0,1014 # ffffffffc020b2f0 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000a517          	auipc	a0,0xa
ffffffffc0200f0c:	40050513          	addi	a0,a0,1024 # ffffffffc020b308 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000a517          	auipc	a0,0xa
ffffffffc0200f1a:	40a50513          	addi	a0,a0,1034 # ffffffffc020b320 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000a517          	auipc	a0,0xa
ffffffffc0200f28:	41450513          	addi	a0,a0,1044 # ffffffffc020b338 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000a517          	auipc	a0,0xa
ffffffffc0200f36:	41e50513          	addi	a0,a0,1054 # ffffffffc020b350 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000a517          	auipc	a0,0xa
ffffffffc0200f44:	42850513          	addi	a0,a0,1064 # ffffffffc020b368 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000a517          	auipc	a0,0xa
ffffffffc0200f52:	43250513          	addi	a0,a0,1074 # ffffffffc020b380 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000a517          	auipc	a0,0xa
ffffffffc0200f60:	43c50513          	addi	a0,a0,1084 # ffffffffc020b398 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000a517          	auipc	a0,0xa
ffffffffc0200f6e:	44650513          	addi	a0,a0,1094 # ffffffffc020b3b0 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000a517          	auipc	a0,0xa
ffffffffc0200f80:	44c50513          	addi	a0,a0,1100 # ffffffffc020b3c8 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000a517          	auipc	a0,0xa
ffffffffc0200f96:	44e50513          	addi	a0,a0,1102 # ffffffffc020b3e0 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000a517          	auipc	a0,0xa
ffffffffc0200fae:	44e50513          	addi	a0,a0,1102 # ffffffffc020b3f8 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000a517          	auipc	a0,0xa
ffffffffc0200fbe:	45650513          	addi	a0,a0,1110 # ffffffffc020b410 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000a517          	auipc	a0,0xa
ffffffffc0200fce:	45e50513          	addi	a0,a0,1118 # ffffffffc020b428 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000a517          	auipc	a0,0xa
ffffffffc0200fe2:	45a50513          	addi	a0,a0,1114 # ffffffffc020b438 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000a717          	auipc	a4,0xa
ffffffffc0200ffe:	4f670713          	addi	a4,a4,1270 # ffffffffc020b4f0 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000a517          	auipc	a0,0xa
ffffffffc0201010:	4a450513          	addi	a0,a0,1188 # ffffffffc020b4b0 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000a517          	auipc	a0,0xa
ffffffffc020101c:	47850513          	addi	a0,a0,1144 # ffffffffc020b490 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000a517          	auipc	a0,0xa
ffffffffc0201028:	42c50513          	addi	a0,a0,1068 # ffffffffc020b450 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000a517          	auipc	a0,0xa
ffffffffc0201034:	44050513          	addi	a0,a0,1088 # ffffffffc020b470 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00095717          	auipc	a4,0x95
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0295870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	559050ef          	jal	ra,ffffffffc0206daa <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	41c0706f          	j	ffffffffc020847a <dev_stdin_write>
ffffffffc0201062:	0000a517          	auipc	a0,0xa
ffffffffc0201066:	46e50513          	addi	a0,a0,1134 # ffffffffc020b4d0 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000a717          	auipc	a4,0xa
ffffffffc0201086:	62e70713          	addi	a4,a4,1582 # ffffffffc020b6b0 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000a517          	auipc	a0,0xa
ffffffffc0201098:	57450513          	addi	a0,a0,1396 # ffffffffc020b608 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	7110506f          	j	ffffffffc0206fc0 <syscall>
ffffffffc02010b4:	0000a517          	auipc	a0,0xa
ffffffffc02010b8:	57450513          	addi	a0,a0,1396 # ffffffffc020b628 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000a517          	auipc	a0,0xa
ffffffffc02010ca:	58250513          	addi	a0,a0,1410 # ffffffffc020b648 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000a517          	auipc	a0,0xa
ffffffffc02010d4:	59850513          	addi	a0,a0,1432 # ffffffffc020b668 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000a517          	auipc	a0,0xa
ffffffffc02010de:	5a650513          	addi	a0,a0,1446 # ffffffffc020b680 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000a517          	auipc	a0,0xa
ffffffffc02010e8:	5b450513          	addi	a0,a0,1460 # ffffffffc020b698 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000a517          	auipc	a0,0xa
ffffffffc02010f2:	43250513          	addi	a0,a0,1074 # ffffffffc020b520 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000a517          	auipc	a0,0xa
ffffffffc02010fc:	44850513          	addi	a0,a0,1096 # ffffffffc020b540 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000a517          	auipc	a0,0xa
ffffffffc0201106:	45e50513          	addi	a0,a0,1118 # ffffffffc020b560 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000a517          	auipc	a0,0xa
ffffffffc0201110:	46c50513          	addi	a0,a0,1132 # ffffffffc020b578 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000a517          	auipc	a0,0xa
ffffffffc020111a:	47250513          	addi	a0,a0,1138 # ffffffffc020b588 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000a517          	auipc	a0,0xa
ffffffffc0201124:	48850513          	addi	a0,a0,1160 # ffffffffc020b5a8 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000a517          	auipc	a0,0xa
ffffffffc020112e:	4c650513          	addi	a0,a0,1222 # ffffffffc020b5f0 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000a617          	auipc	a2,0xa
ffffffffc0201142:	48260613          	addi	a2,a2,1154 # ffffffffc020b5c0 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000a517          	auipc	a0,0xa
ffffffffc020114e:	48e50513          	addi	a0,a0,1166 # ffffffffc020b5d8 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00094417          	auipc	s0,0x94
ffffffffc020115e:	76640413          	addi	s0,s0,1894 # ffffffffc02958c0 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	1cd0506f          	j	ffffffffc0206b9e <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	495040ef          	jal	ra,ffffffffc0205e6c <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	0008f797          	auipc	a5,0x8f
ffffffffc02012b2:	4fa78793          	addi	a5,a5,1274 # ffffffffc02907a8 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	0008f517          	auipc	a0,0x8f
ffffffffc02012c4:	4f856503          	lwu	a0,1272(a0) # ffffffffc02907b8 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	0008f417          	auipc	s0,0x8f
ffffffffc02012d2:	4da40413          	addi	s0,s0,1242 # ffffffffc02907a8 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00094797          	auipc	a5,0x94
ffffffffc020135e:	54e7b783          	ld	a5,1358(a5) # ffffffffc02958a8 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000e617          	auipc	a2,0xe
ffffffffc020136a:	91a63603          	ld	a2,-1766(a2) # ffffffffc020ec80 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00094697          	auipc	a3,0x94
ffffffffc0201376:	52e6b683          	ld	a3,1326(a3) # ffffffffc02958a0 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	0008f797          	auipc	a5,0x8f
ffffffffc02013b4:	4007a423          	sw	zero,1032(a5) # ffffffffc02907b8 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	0008f797          	auipc	a5,0x8f
ffffffffc0201496:	3207a323          	sw	zero,806(a5) # ffffffffc02907b8 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000a697          	auipc	a3,0xa
ffffffffc02015b0:	14468693          	addi	a3,a3,324 # ffffffffc020b6f0 <commands+0x950>
ffffffffc02015b4:	0000a617          	auipc	a2,0xa
ffffffffc02015b8:	9fc60613          	addi	a2,a2,-1540 # ffffffffc020afb0 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000a517          	auipc	a0,0xa
ffffffffc02015c4:	14050513          	addi	a0,a0,320 # ffffffffc020b700 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000a697          	auipc	a3,0xa
ffffffffc02015d0:	1cc68693          	addi	a3,a3,460 # ffffffffc020b798 <commands+0x9f8>
ffffffffc02015d4:	0000a617          	auipc	a2,0xa
ffffffffc02015d8:	9dc60613          	addi	a2,a2,-1572 # ffffffffc020afb0 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000a517          	auipc	a0,0xa
ffffffffc02015e4:	12050513          	addi	a0,a0,288 # ffffffffc020b700 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000a697          	auipc	a3,0xa
ffffffffc02015f0:	1d468693          	addi	a3,a3,468 # ffffffffc020b7c0 <commands+0xa20>
ffffffffc02015f4:	0000a617          	auipc	a2,0xa
ffffffffc02015f8:	9bc60613          	addi	a2,a2,-1604 # ffffffffc020afb0 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000a517          	auipc	a0,0xa
ffffffffc0201604:	10050513          	addi	a0,a0,256 # ffffffffc020b700 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000a697          	auipc	a3,0xa
ffffffffc0201610:	1f468693          	addi	a3,a3,500 # ffffffffc020b800 <commands+0xa60>
ffffffffc0201614:	0000a617          	auipc	a2,0xa
ffffffffc0201618:	99c60613          	addi	a2,a2,-1636 # ffffffffc020afb0 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000a517          	auipc	a0,0xa
ffffffffc0201624:	0e050513          	addi	a0,a0,224 # ffffffffc020b700 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000a697          	auipc	a3,0xa
ffffffffc0201630:	25c68693          	addi	a3,a3,604 # ffffffffc020b888 <commands+0xae8>
ffffffffc0201634:	0000a617          	auipc	a2,0xa
ffffffffc0201638:	97c60613          	addi	a2,a2,-1668 # ffffffffc020afb0 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000a517          	auipc	a0,0xa
ffffffffc0201644:	0c050513          	addi	a0,a0,192 # ffffffffc020b700 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000a697          	auipc	a3,0xa
ffffffffc0201650:	0ec68693          	addi	a3,a3,236 # ffffffffc020b738 <commands+0x998>
ffffffffc0201654:	0000a617          	auipc	a2,0xa
ffffffffc0201658:	95c60613          	addi	a2,a2,-1700 # ffffffffc020afb0 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000a517          	auipc	a0,0xa
ffffffffc0201664:	0a050513          	addi	a0,a0,160 # ffffffffc020b700 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000a697          	auipc	a3,0xa
ffffffffc0201670:	20c68693          	addi	a3,a3,524 # ffffffffc020b878 <commands+0xad8>
ffffffffc0201674:	0000a617          	auipc	a2,0xa
ffffffffc0201678:	93c60613          	addi	a2,a2,-1732 # ffffffffc020afb0 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000a517          	auipc	a0,0xa
ffffffffc0201684:	08050513          	addi	a0,a0,128 # ffffffffc020b700 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000a697          	auipc	a3,0xa
ffffffffc0201690:	1d468693          	addi	a3,a3,468 # ffffffffc020b860 <commands+0xac0>
ffffffffc0201694:	0000a617          	auipc	a2,0xa
ffffffffc0201698:	91c60613          	addi	a2,a2,-1764 # ffffffffc020afb0 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000a517          	auipc	a0,0xa
ffffffffc02016a4:	06050513          	addi	a0,a0,96 # ffffffffc020b700 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000a697          	auipc	a3,0xa
ffffffffc02016b0:	19468693          	addi	a3,a3,404 # ffffffffc020b840 <commands+0xaa0>
ffffffffc02016b4:	0000a617          	auipc	a2,0xa
ffffffffc02016b8:	8fc60613          	addi	a2,a2,-1796 # ffffffffc020afb0 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000a517          	auipc	a0,0xa
ffffffffc02016c4:	04050513          	addi	a0,a0,64 # ffffffffc020b700 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000a697          	auipc	a3,0xa
ffffffffc02016d0:	20468693          	addi	a3,a3,516 # ffffffffc020b8d0 <commands+0xb30>
ffffffffc02016d4:	0000a617          	auipc	a2,0xa
ffffffffc02016d8:	8dc60613          	addi	a2,a2,-1828 # ffffffffc020afb0 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000a517          	auipc	a0,0xa
ffffffffc02016e4:	02050513          	addi	a0,a0,32 # ffffffffc020b700 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000a697          	auipc	a3,0xa
ffffffffc02016f0:	1d468693          	addi	a3,a3,468 # ffffffffc020b8c0 <commands+0xb20>
ffffffffc02016f4:	0000a617          	auipc	a2,0xa
ffffffffc02016f8:	8bc60613          	addi	a2,a2,-1860 # ffffffffc020afb0 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000a517          	auipc	a0,0xa
ffffffffc0201704:	00050513          	mv	a0,a0
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000a697          	auipc	a3,0xa
ffffffffc0201710:	15468693          	addi	a3,a3,340 # ffffffffc020b860 <commands+0xac0>
ffffffffc0201714:	0000a617          	auipc	a2,0xa
ffffffffc0201718:	89c60613          	addi	a2,a2,-1892 # ffffffffc020afb0 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000a517          	auipc	a0,0xa
ffffffffc0201724:	fe050513          	addi	a0,a0,-32 # ffffffffc020b700 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000a697          	auipc	a3,0xa
ffffffffc0201730:	17468693          	addi	a3,a3,372 # ffffffffc020b8a0 <commands+0xb00>
ffffffffc0201734:	0000a617          	auipc	a2,0xa
ffffffffc0201738:	87c60613          	addi	a2,a2,-1924 # ffffffffc020afb0 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000a517          	auipc	a0,0xa
ffffffffc0201744:	fc050513          	addi	a0,a0,-64 # ffffffffc020b700 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000a697          	auipc	a3,0xa
ffffffffc0201750:	fec68693          	addi	a3,a3,-20 # ffffffffc020b738 <commands+0x998>
ffffffffc0201754:	0000a617          	auipc	a2,0xa
ffffffffc0201758:	85c60613          	addi	a2,a2,-1956 # ffffffffc020afb0 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000a517          	auipc	a0,0xa
ffffffffc0201764:	fa050513          	addi	a0,a0,-96 # ffffffffc020b700 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000a697          	auipc	a3,0xa
ffffffffc0201770:	0f468693          	addi	a3,a3,244 # ffffffffc020b860 <commands+0xac0>
ffffffffc0201774:	0000a617          	auipc	a2,0xa
ffffffffc0201778:	83c60613          	addi	a2,a2,-1988 # ffffffffc020afb0 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000a517          	auipc	a0,0xa
ffffffffc0201784:	f8050513          	addi	a0,a0,-128 # ffffffffc020b700 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000a697          	auipc	a3,0xa
ffffffffc0201790:	fec68693          	addi	a3,a3,-20 # ffffffffc020b778 <commands+0x9d8>
ffffffffc0201794:	0000a617          	auipc	a2,0xa
ffffffffc0201798:	81c60613          	addi	a2,a2,-2020 # ffffffffc020afb0 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000a517          	auipc	a0,0xa
ffffffffc02017a4:	f6050513          	addi	a0,a0,-160 # ffffffffc020b700 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000a697          	auipc	a3,0xa
ffffffffc02017b0:	fac68693          	addi	a3,a3,-84 # ffffffffc020b758 <commands+0x9b8>
ffffffffc02017b4:	00009617          	auipc	a2,0x9
ffffffffc02017b8:	7fc60613          	addi	a2,a2,2044 # ffffffffc020afb0 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	0000a517          	auipc	a0,0xa
ffffffffc02017c4:	f4050513          	addi	a0,a0,-192 # ffffffffc020b700 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000a697          	auipc	a3,0xa
ffffffffc02017d0:	fac68693          	addi	a3,a3,-84 # ffffffffc020b778 <commands+0x9d8>
ffffffffc02017d4:	00009617          	auipc	a2,0x9
ffffffffc02017d8:	7dc60613          	addi	a2,a2,2012 # ffffffffc020afb0 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	0000a517          	auipc	a0,0xa
ffffffffc02017e4:	f2050513          	addi	a0,a0,-224 # ffffffffc020b700 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000a697          	auipc	a3,0xa
ffffffffc02017f0:	23468693          	addi	a3,a3,564 # ffffffffc020ba20 <commands+0xc80>
ffffffffc02017f4:	00009617          	auipc	a2,0x9
ffffffffc02017f8:	7bc60613          	addi	a2,a2,1980 # ffffffffc020afb0 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	0000a517          	auipc	a0,0xa
ffffffffc0201804:	f0050513          	addi	a0,a0,-256 # ffffffffc020b700 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000a697          	auipc	a3,0xa
ffffffffc0201810:	0b468693          	addi	a3,a3,180 # ffffffffc020b8c0 <commands+0xb20>
ffffffffc0201814:	00009617          	auipc	a2,0x9
ffffffffc0201818:	79c60613          	addi	a2,a2,1948 # ffffffffc020afb0 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	0000a517          	auipc	a0,0xa
ffffffffc0201824:	ee050513          	addi	a0,a0,-288 # ffffffffc020b700 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000a697          	auipc	a3,0xa
ffffffffc0201830:	03468693          	addi	a3,a3,52 # ffffffffc020b860 <commands+0xac0>
ffffffffc0201834:	00009617          	auipc	a2,0x9
ffffffffc0201838:	77c60613          	addi	a2,a2,1916 # ffffffffc020afb0 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	0000a517          	auipc	a0,0xa
ffffffffc0201844:	ec050513          	addi	a0,a0,-320 # ffffffffc020b700 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000a697          	auipc	a3,0xa
ffffffffc0201850:	fd468693          	addi	a3,a3,-44 # ffffffffc020b820 <commands+0xa80>
ffffffffc0201854:	00009617          	auipc	a2,0x9
ffffffffc0201858:	75c60613          	addi	a2,a2,1884 # ffffffffc020afb0 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	0000a517          	auipc	a0,0xa
ffffffffc0201864:	ea050513          	addi	a0,a0,-352 # ffffffffc020b700 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000a697          	auipc	a3,0xa
ffffffffc0201870:	17468693          	addi	a3,a3,372 # ffffffffc020b9e0 <commands+0xc40>
ffffffffc0201874:	00009617          	auipc	a2,0x9
ffffffffc0201878:	73c60613          	addi	a2,a2,1852 # ffffffffc020afb0 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	0000a517          	auipc	a0,0xa
ffffffffc0201884:	e8050513          	addi	a0,a0,-384 # ffffffffc020b700 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000a697          	auipc	a3,0xa
ffffffffc0201890:	13468693          	addi	a3,a3,308 # ffffffffc020b9c0 <commands+0xc20>
ffffffffc0201894:	00009617          	auipc	a2,0x9
ffffffffc0201898:	71c60613          	addi	a2,a2,1820 # ffffffffc020afb0 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	0000a517          	auipc	a0,0xa
ffffffffc02018a4:	e6050513          	addi	a0,a0,-416 # ffffffffc020b700 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000a697          	auipc	a3,0xa
ffffffffc02018b0:	0ec68693          	addi	a3,a3,236 # ffffffffc020b998 <commands+0xbf8>
ffffffffc02018b4:	00009617          	auipc	a2,0x9
ffffffffc02018b8:	6fc60613          	addi	a2,a2,1788 # ffffffffc020afb0 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	0000a517          	auipc	a0,0xa
ffffffffc02018c4:	e4050513          	addi	a0,a0,-448 # ffffffffc020b700 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000a697          	auipc	a3,0xa
ffffffffc02018d0:	0a468693          	addi	a3,a3,164 # ffffffffc020b970 <commands+0xbd0>
ffffffffc02018d4:	00009617          	auipc	a2,0x9
ffffffffc02018d8:	6dc60613          	addi	a2,a2,1756 # ffffffffc020afb0 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	0000a517          	auipc	a0,0xa
ffffffffc02018e4:	e2050513          	addi	a0,a0,-480 # ffffffffc020b700 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000a697          	auipc	a3,0xa
ffffffffc02018f0:	07468693          	addi	a3,a3,116 # ffffffffc020b960 <commands+0xbc0>
ffffffffc02018f4:	00009617          	auipc	a2,0x9
ffffffffc02018f8:	6bc60613          	addi	a2,a2,1724 # ffffffffc020afb0 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	0000a517          	auipc	a0,0xa
ffffffffc0201904:	e0050513          	addi	a0,a0,-512 # ffffffffc020b700 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	0000a697          	auipc	a3,0xa
ffffffffc0201910:	f5468693          	addi	a3,a3,-172 # ffffffffc020b860 <commands+0xac0>
ffffffffc0201914:	00009617          	auipc	a2,0x9
ffffffffc0201918:	69c60613          	addi	a2,a2,1692 # ffffffffc020afb0 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	0000a517          	auipc	a0,0xa
ffffffffc0201924:	de050513          	addi	a0,a0,-544 # ffffffffc020b700 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000a697          	auipc	a3,0xa
ffffffffc0201930:	01468693          	addi	a3,a3,20 # ffffffffc020b940 <commands+0xba0>
ffffffffc0201934:	00009617          	auipc	a2,0x9
ffffffffc0201938:	67c60613          	addi	a2,a2,1660 # ffffffffc020afb0 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	0000a517          	auipc	a0,0xa
ffffffffc0201944:	dc050513          	addi	a0,a0,-576 # ffffffffc020b700 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000a697          	auipc	a3,0xa
ffffffffc0201950:	fc468693          	addi	a3,a3,-60 # ffffffffc020b910 <commands+0xb70>
ffffffffc0201954:	00009617          	auipc	a2,0x9
ffffffffc0201958:	65c60613          	addi	a2,a2,1628 # ffffffffc020afb0 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	0000a517          	auipc	a0,0xa
ffffffffc0201964:	da050513          	addi	a0,a0,-608 # ffffffffc020b700 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000a697          	auipc	a3,0xa
ffffffffc0201970:	f8c68693          	addi	a3,a3,-116 # ffffffffc020b8f8 <commands+0xb58>
ffffffffc0201974:	00009617          	auipc	a2,0x9
ffffffffc0201978:	63c60613          	addi	a2,a2,1596 # ffffffffc020afb0 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	0000a517          	auipc	a0,0xa
ffffffffc0201984:	d8050513          	addi	a0,a0,-640 # ffffffffc020b700 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	0000a697          	auipc	a3,0xa
ffffffffc0201990:	ed468693          	addi	a3,a3,-300 # ffffffffc020b860 <commands+0xac0>
ffffffffc0201994:	00009617          	auipc	a2,0x9
ffffffffc0201998:	61c60613          	addi	a2,a2,1564 # ffffffffc020afb0 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	0000a517          	auipc	a0,0xa
ffffffffc02019a4:	d6050513          	addi	a0,a0,-672 # ffffffffc020b700 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	0000a697          	auipc	a3,0xa
ffffffffc02019b0:	f3468693          	addi	a3,a3,-204 # ffffffffc020b8e0 <commands+0xb40>
ffffffffc02019b4:	00009617          	auipc	a2,0x9
ffffffffc02019b8:	5fc60613          	addi	a2,a2,1532 # ffffffffc020afb0 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	0000a517          	auipc	a0,0xa
ffffffffc02019c4:	d4050513          	addi	a0,a0,-704 # ffffffffc020b700 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000a697          	auipc	a3,0xa
ffffffffc02019d0:	03468693          	addi	a3,a3,52 # ffffffffc020ba00 <commands+0xc60>
ffffffffc02019d4:	00009617          	auipc	a2,0x9
ffffffffc02019d8:	5dc60613          	addi	a2,a2,1500 # ffffffffc020afb0 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	0000a517          	auipc	a0,0xa
ffffffffc02019e4:	d2050513          	addi	a0,a0,-736 # ffffffffc020b700 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000a697          	auipc	a3,0xa
ffffffffc02019f0:	04468693          	addi	a3,a3,68 # ffffffffc020ba30 <commands+0xc90>
ffffffffc02019f4:	00009617          	auipc	a2,0x9
ffffffffc02019f8:	5bc60613          	addi	a2,a2,1468 # ffffffffc020afb0 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	0000a517          	auipc	a0,0xa
ffffffffc0201a04:	d0050513          	addi	a0,a0,-768 # ffffffffc020b700 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	0000a697          	auipc	a3,0xa
ffffffffc0201a10:	d0c68693          	addi	a3,a3,-756 # ffffffffc020b718 <commands+0x978>
ffffffffc0201a14:	00009617          	auipc	a2,0x9
ffffffffc0201a18:	59c60613          	addi	a2,a2,1436 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	0000a517          	auipc	a0,0xa
ffffffffc0201a24:	ce050513          	addi	a0,a0,-800 # ffffffffc020b700 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	0000a697          	auipc	a3,0xa
ffffffffc0201a30:	d2c68693          	addi	a3,a3,-724 # ffffffffc020b758 <commands+0x9b8>
ffffffffc0201a34:	00009617          	auipc	a2,0x9
ffffffffc0201a38:	57c60613          	addi	a2,a2,1404 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	0000a517          	auipc	a0,0xa
ffffffffc0201a44:	cc050513          	addi	a0,a0,-832 # ffffffffc020b700 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	0008f697          	auipc	a3,0x8f
ffffffffc0201a92:	d1a68693          	addi	a3,a3,-742 # ffffffffc02907a8 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	0000a697          	auipc	a3,0xa
ffffffffc0201b7c:	ed068693          	addi	a3,a3,-304 # ffffffffc020ba48 <commands+0xca8>
ffffffffc0201b80:	00009617          	auipc	a2,0x9
ffffffffc0201b84:	43060613          	addi	a2,a2,1072 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	0000a517          	auipc	a0,0xa
ffffffffc0201b90:	b7450513          	addi	a0,a0,-1164 # ffffffffc020b700 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	0000a697          	auipc	a3,0xa
ffffffffc0201b9c:	ea868693          	addi	a3,a3,-344 # ffffffffc020ba40 <commands+0xca0>
ffffffffc0201ba0:	00009617          	auipc	a2,0x9
ffffffffc0201ba4:	41060613          	addi	a2,a2,1040 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	0000a517          	auipc	a0,0xa
ffffffffc0201bb0:	b5450513          	addi	a0,a0,-1196 # ffffffffc020b700 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	0008f597          	auipc	a1,0x8f
ffffffffc0201bbe:	bee58593          	addi	a1,a1,-1042 # ffffffffc02907a8 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	0000a697          	auipc	a3,0xa
ffffffffc0201c4e:	df668693          	addi	a3,a3,-522 # ffffffffc020ba40 <commands+0xca0>
ffffffffc0201c52:	00009617          	auipc	a2,0x9
ffffffffc0201c56:	35e60613          	addi	a2,a2,862 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	0000a517          	auipc	a0,0xa
ffffffffc0201c62:	aa250513          	addi	a0,a0,-1374 # ffffffffc020b700 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	0008f697          	auipc	a3,0x8f
ffffffffc0201caa:	b0268693          	addi	a3,a3,-1278 # ffffffffc02907a8 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	0000a697          	auipc	a3,0xa
ffffffffc0201d20:	d5468693          	addi	a3,a3,-684 # ffffffffc020ba70 <commands+0xcd0>
ffffffffc0201d24:	00009617          	auipc	a2,0x9
ffffffffc0201d28:	28c60613          	addi	a2,a2,652 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	0000a517          	auipc	a0,0xa
ffffffffc0201d34:	9d050513          	addi	a0,a0,-1584 # ffffffffc020b700 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	0000a697          	auipc	a3,0xa
ffffffffc0201d40:	d0468693          	addi	a3,a3,-764 # ffffffffc020ba40 <commands+0xca0>
ffffffffc0201d44:	00009617          	auipc	a2,0x9
ffffffffc0201d48:	26c60613          	addi	a2,a2,620 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	0000a517          	auipc	a0,0xa
ffffffffc0201d54:	9b050513          	addi	a0,a0,-1616 # ffffffffc020b700 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008e617          	auipc	a2,0x8e
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0290050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00094697          	auipc	a3,0x94
ffffffffc0201e24:	a886b683          	ld	a3,-1400(a3) # ffffffffc02958a8 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000d697          	auipc	a3,0xd
ffffffffc0201e30:	e546b683          	ld	a3,-428(a3) # ffffffffc020ec80 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00094717          	auipc	a4,0x94
ffffffffc0201e40:	a6473703          	ld	a4,-1436(a4) # ffffffffc02958a0 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00094697          	auipc	a3,0x94
ffffffffc0201e4e:	a6e6b683          	ld	a3,-1426(a3) # ffffffffc02958b8 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	0000a617          	auipc	a2,0xa
ffffffffc0201e60:	c7460613          	addi	a2,a2,-908 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	0000a517          	auipc	a0,0xa
ffffffffc0201e6c:	c9050513          	addi	a0,a0,-880 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008e917          	auipc	s2,0x8e
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0290050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	0000a697          	auipc	a3,0xa
ffffffffc0201f4e:	bbe68693          	addi	a3,a3,-1090 # ffffffffc020bb08 <default_pmm_manager+0x70>
ffffffffc0201f52:	00009617          	auipc	a2,0x9
ffffffffc0201f56:	05e60613          	addi	a2,a2,94 # ffffffffc020afb0 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	0000a517          	auipc	a0,0xa
ffffffffc0201f62:	bca50513          	addi	a0,a0,-1078 # ffffffffc020bb28 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	0000a517          	auipc	a0,0xa
ffffffffc0201f70:	bd450513          	addi	a0,a0,-1068 # ffffffffc020bb40 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	0000a517          	auipc	a0,0xa
ffffffffc0201f80:	bdc50513          	addi	a0,a0,-1060 # ffffffffc020bb58 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00094797          	auipc	a5,0x94
ffffffffc0201fda:	8b278793          	addi	a5,a5,-1870 # ffffffffc0295888 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00094797          	auipc	a5,0x94
ffffffffc0202016:	87678793          	addi	a5,a5,-1930 # ffffffffc0295888 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00094797          	auipc	a5,0x94
ffffffffc020205c:	8307b783          	ld	a5,-2000(a5) # ffffffffc0295888 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00094697          	auipc	a3,0x94
ffffffffc0202068:	82468693          	addi	a3,a3,-2012 # ffffffffc0295888 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00094697          	auipc	a3,0x94
ffffffffc0202090:	82c6b683          	ld	a3,-2004(a3) # ffffffffc02958b8 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00094797          	auipc	a5,0x94
ffffffffc020209c:	8087b783          	ld	a5,-2040(a5) # ffffffffc02958a0 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000d517          	auipc	a0,0xd
ffffffffc02020a8:	bdc53503          	ld	a0,-1060(a0) # ffffffffc020ec80 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00093517          	auipc	a0,0x93
ffffffffc02020b4:	7f853503          	ld	a0,2040(a0) # ffffffffc02958a8 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00093797          	auipc	a5,0x93
ffffffffc02020ec:	7a07b783          	ld	a5,1952(a5) # ffffffffc0295888 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	0000a617          	auipc	a2,0xa
ffffffffc0202106:	a9e60613          	addi	a2,a2,-1378 # ffffffffc020bba0 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	0000a517          	auipc	a0,0xa
ffffffffc0202112:	9ea50513          	addi	a0,a0,-1558 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	0000a617          	auipc	a2,0xa
ffffffffc0202120:	a5c60613          	addi	a2,a2,-1444 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	0000a517          	auipc	a0,0xa
ffffffffc020212c:	9d050513          	addi	a0,a0,-1584 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	0000a617          	auipc	a2,0xa
ffffffffc020213a:	a6a60613          	addi	a2,a2,-1430 # ffffffffc020bba0 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	0000a517          	auipc	a0,0xa
ffffffffc0202146:	9b650513          	addi	a0,a0,-1610 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	a6e60613          	addi	a2,a2,-1426 # ffffffffc020bbc0 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	99a50513          	addi	a0,a0,-1638 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00093797          	auipc	a5,0x93
ffffffffc0202178:	73c7b783          	ld	a5,1852(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00093797          	auipc	a5,0x93
ffffffffc0202190:	7247b783          	ld	a5,1828(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00093797          	auipc	a5,0x93
ffffffffc02021b6:	6fe7b783          	ld	a5,1790(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00093797          	auipc	a5,0x93
ffffffffc02021d2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00093797          	auipc	a5,0x93
ffffffffc02021f6:	6be7b783          	ld	a5,1726(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00093797          	auipc	a5,0x93
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00093997          	auipc	s3,0x93
ffffffffc0202252:	65298993          	addi	s3,s3,1618 # ffffffffc02958a0 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00093797          	auipc	a5,0x93
ffffffffc020226a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00093b17          	auipc	s6,0x93
ffffffffc020227e:	62eb0b13          	addi	s6,s6,1582 # ffffffffc02958a8 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00093997          	auipc	s3,0x93
ffffffffc020228e:	61698993          	addi	s3,s3,1558 # ffffffffc02958a0 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00093797          	auipc	a5,0x93
ffffffffc02022b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02958b8 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	013080ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00093a97          	auipc	s5,0x93
ffffffffc02022ea:	5d2a8a93          	addi	s5,s5,1490 # ffffffffc02958b8 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00093797          	auipc	a5,0x93
ffffffffc020231a:	59a7b783          	ld	a5,1434(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00093b17          	auipc	s6,0x93
ffffffffc020232c:	580b0b13          	addi	s6,s6,1408 # ffffffffc02958a8 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	770080ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00093797          	auipc	a5,0x93
ffffffffc02023bc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00093797          	auipc	a5,0x93
ffffffffc02023d6:	4de7b783          	ld	a5,1246(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	00009617          	auipc	a2,0x9
ffffffffc02023ec:	6e860613          	addi	a2,a2,1768 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	00009517          	auipc	a0,0x9
ffffffffc02023f8:	7f450513          	addi	a0,a0,2036 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	00009617          	auipc	a2,0x9
ffffffffc0202404:	6d060613          	addi	a2,a2,1744 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	00009517          	auipc	a0,0x9
ffffffffc0202410:	7dc50513          	addi	a0,a0,2012 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	00009617          	auipc	a2,0x9
ffffffffc020241e:	6b660613          	addi	a2,a2,1718 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	00009517          	auipc	a0,0x9
ffffffffc020242a:	7c250513          	addi	a0,a0,1986 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	00009617          	auipc	a2,0x9
ffffffffc0202438:	69c60613          	addi	a2,a2,1692 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	00009517          	auipc	a0,0x9
ffffffffc0202444:	7a850513          	addi	a0,a0,1960 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	00009697          	auipc	a3,0x9
ffffffffc02024d6:	73e68693          	addi	a3,a3,1854 # ffffffffc020bc10 <default_pmm_manager+0x178>
ffffffffc02024da:	00009617          	auipc	a2,0x9
ffffffffc02024de:	ad660613          	addi	a2,a2,-1322 # ffffffffc020afb0 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	00009517          	auipc	a0,0x9
ffffffffc02024ea:	70250513          	addi	a0,a0,1794 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	00009697          	auipc	a3,0x9
ffffffffc02024f6:	70668693          	addi	a3,a3,1798 # ffffffffc020bbf8 <default_pmm_manager+0x160>
ffffffffc02024fa:	00009617          	auipc	a2,0x9
ffffffffc02024fe:	ab660613          	addi	a2,a2,-1354 # ffffffffc020afb0 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	00009517          	auipc	a0,0x9
ffffffffc020250a:	6e250513          	addi	a0,a0,1762 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00093717          	auipc	a4,0x93
ffffffffc0202540:	36473703          	ld	a4,868(a4) # ffffffffc02958a0 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00093517          	auipc	a0,0x93
ffffffffc0202558:	35453503          	ld	a0,852(a0) # ffffffffc02958a8 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00093c97          	auipc	s9,0x93
ffffffffc02025a8:	2fcc8c93          	addi	s9,s9,764 # ffffffffc02958a0 <npage>
ffffffffc02025ac:	00093c17          	auipc	s8,0x93
ffffffffc02025b0:	2fcc0c13          	addi	s8,s8,764 # ffffffffc02958a8 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00093d17          	auipc	s10,0x93
ffffffffc02025bc:	2f8d0d13          	addi	s10,s10,760 # ffffffffc02958b0 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	00009697          	auipc	a3,0x9
ffffffffc020266c:	5b868693          	addi	a3,a3,1464 # ffffffffc020bc20 <default_pmm_manager+0x188>
ffffffffc0202670:	00009617          	auipc	a2,0x9
ffffffffc0202674:	94060613          	addi	a2,a2,-1728 # ffffffffc020afb0 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	00009517          	auipc	a0,0x9
ffffffffc0202680:	56c50513          	addi	a0,a0,1388 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	00009697          	auipc	a3,0x9
ffffffffc020268c:	5c868693          	addi	a3,a3,1480 # ffffffffc020bc50 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00009617          	auipc	a2,0x9
ffffffffc0202694:	92060613          	addi	a2,a2,-1760 # ffffffffc020afb0 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	00009517          	auipc	a0,0x9
ffffffffc02026a0:	54c50513          	addi	a0,a0,1356 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00093d17          	auipc	s10,0x93
ffffffffc0202706:	19ed0d13          	addi	s10,s10,414 # ffffffffc02958a0 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00093717          	auipc	a4,0x93
ffffffffc0202712:	19a70713          	addi	a4,a4,410 # ffffffffc02958a8 <pages>
ffffffffc0202716:	00093d97          	auipc	s11,0x93
ffffffffc020271a:	19ad8d93          	addi	s11,s11,410 # ffffffffc02958b0 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00093817          	auipc	a6,0x93
ffffffffc0202776:	14680813          	addi	a6,a6,326 # ffffffffc02958b8 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00093817          	auipc	a6,0x93
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02958b8 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00093717          	auipc	a4,0x93
ffffffffc020281c:	09070713          	addi	a4,a4,144 # ffffffffc02958a8 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00093717          	auipc	a4,0x93
ffffffffc0202854:	05870713          	addi	a4,a4,88 # ffffffffc02958a8 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00093717          	auipc	a4,0x93
ffffffffc02028a2:	00a70713          	addi	a4,a4,10 # ffffffffc02958a8 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00093817          	auipc	a6,0x93
ffffffffc02028b4:	00880813          	addi	a6,a6,8 # ffffffffc02958b8 <va_pa_offset>
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00093717          	auipc	a4,0x93
ffffffffc02028d8:	fd470713          	addi	a4,a4,-44 # ffffffffc02958a8 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	00009697          	auipc	a3,0x9
ffffffffc02028e6:	33e68693          	addi	a3,a3,830 # ffffffffc020bc20 <default_pmm_manager+0x188>
ffffffffc02028ea:	00008617          	auipc	a2,0x8
ffffffffc02028ee:	6c660613          	addi	a2,a2,1734 # ffffffffc020afb0 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	00009517          	auipc	a0,0x9
ffffffffc02028fa:	2f250513          	addi	a0,a0,754 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	00009617          	auipc	a2,0x9
ffffffffc0202906:	1ce60613          	addi	a2,a2,462 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	00009517          	auipc	a0,0x9
ffffffffc0202912:	1ea50513          	addi	a0,a0,490 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	00009697          	auipc	a3,0x9
ffffffffc0202922:	33268693          	addi	a3,a3,818 # ffffffffc020bc50 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00008617          	auipc	a2,0x8
ffffffffc020292a:	68a60613          	addi	a2,a2,1674 # ffffffffc020afb0 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	00009517          	auipc	a0,0x9
ffffffffc0202936:	2b650513          	addi	a0,a0,694 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <page_remove>:
ffffffffc020293e:	7179                	addi	sp,sp,-48
ffffffffc0202940:	4601                	li	a2,0
ffffffffc0202942:	ec26                	sd	s1,24(sp)
ffffffffc0202944:	f406                	sd	ra,40(sp)
ffffffffc0202946:	f022                	sd	s0,32(sp)
ffffffffc0202948:	84ae                	mv	s1,a1
ffffffffc020294a:	8dbff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020294e:	c511                	beqz	a0,ffffffffc020295a <page_remove+0x1c>
ffffffffc0202950:	611c                	ld	a5,0(a0)
ffffffffc0202952:	842a                	mv	s0,a0
ffffffffc0202954:	0017f713          	andi	a4,a5,1
ffffffffc0202958:	e711                	bnez	a4,ffffffffc0202964 <page_remove+0x26>
ffffffffc020295a:	70a2                	ld	ra,40(sp)
ffffffffc020295c:	7402                	ld	s0,32(sp)
ffffffffc020295e:	64e2                	ld	s1,24(sp)
ffffffffc0202960:	6145                	addi	sp,sp,48
ffffffffc0202962:	8082                	ret
ffffffffc0202964:	078a                	slli	a5,a5,0x2
ffffffffc0202966:	83b1                	srli	a5,a5,0xc
ffffffffc0202968:	00093717          	auipc	a4,0x93
ffffffffc020296c:	f3873703          	ld	a4,-200(a4) # ffffffffc02958a0 <npage>
ffffffffc0202970:	06e7f363          	bgeu	a5,a4,ffffffffc02029d6 <page_remove+0x98>
ffffffffc0202974:	fff80537          	lui	a0,0xfff80
ffffffffc0202978:	97aa                	add	a5,a5,a0
ffffffffc020297a:	079a                	slli	a5,a5,0x6
ffffffffc020297c:	00093517          	auipc	a0,0x93
ffffffffc0202980:	f2c53503          	ld	a0,-212(a0) # ffffffffc02958a8 <pages>
ffffffffc0202984:	953e                	add	a0,a0,a5
ffffffffc0202986:	411c                	lw	a5,0(a0)
ffffffffc0202988:	fff7871b          	addiw	a4,a5,-1
ffffffffc020298c:	c118                	sw	a4,0(a0)
ffffffffc020298e:	cb11                	beqz	a4,ffffffffc02029a2 <page_remove+0x64>
ffffffffc0202990:	00043023          	sd	zero,0(s0)
ffffffffc0202994:	12048073          	sfence.vma	s1
ffffffffc0202998:	70a2                	ld	ra,40(sp)
ffffffffc020299a:	7402                	ld	s0,32(sp)
ffffffffc020299c:	64e2                	ld	s1,24(sp)
ffffffffc020299e:	6145                	addi	sp,sp,48
ffffffffc02029a0:	8082                	ret
ffffffffc02029a2:	100027f3          	csrr	a5,sstatus
ffffffffc02029a6:	8b89                	andi	a5,a5,2
ffffffffc02029a8:	eb89                	bnez	a5,ffffffffc02029ba <page_remove+0x7c>
ffffffffc02029aa:	00093797          	auipc	a5,0x93
ffffffffc02029ae:	f067b783          	ld	a5,-250(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02029b2:	739c                	ld	a5,32(a5)
ffffffffc02029b4:	4585                	li	a1,1
ffffffffc02029b6:	9782                	jalr	a5
ffffffffc02029b8:	bfe1                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029ba:	e42a                	sd	a0,8(sp)
ffffffffc02029bc:	ab6fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02029c0:	00093797          	auipc	a5,0x93
ffffffffc02029c4:	ef07b783          	ld	a5,-272(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc02029c8:	739c                	ld	a5,32(a5)
ffffffffc02029ca:	6522                	ld	a0,8(sp)
ffffffffc02029cc:	4585                	li	a1,1
ffffffffc02029ce:	9782                	jalr	a5
ffffffffc02029d0:	a9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02029d4:	bf75                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029d6:	f5eff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02029da <page_insert>:
ffffffffc02029da:	7139                	addi	sp,sp,-64
ffffffffc02029dc:	e852                	sd	s4,16(sp)
ffffffffc02029de:	8a32                	mv	s4,a2
ffffffffc02029e0:	f822                	sd	s0,48(sp)
ffffffffc02029e2:	4605                	li	a2,1
ffffffffc02029e4:	842e                	mv	s0,a1
ffffffffc02029e6:	85d2                	mv	a1,s4
ffffffffc02029e8:	f426                	sd	s1,40(sp)
ffffffffc02029ea:	fc06                	sd	ra,56(sp)
ffffffffc02029ec:	f04a                	sd	s2,32(sp)
ffffffffc02029ee:	ec4e                	sd	s3,24(sp)
ffffffffc02029f0:	e456                	sd	s5,8(sp)
ffffffffc02029f2:	84b6                	mv	s1,a3
ffffffffc02029f4:	831ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029f8:	c961                	beqz	a0,ffffffffc0202ac8 <page_insert+0xee>
ffffffffc02029fa:	4014                	lw	a3,0(s0)
ffffffffc02029fc:	611c                	ld	a5,0(a0)
ffffffffc02029fe:	89aa                	mv	s3,a0
ffffffffc0202a00:	0016871b          	addiw	a4,a3,1
ffffffffc0202a04:	c018                	sw	a4,0(s0)
ffffffffc0202a06:	0017f713          	andi	a4,a5,1
ffffffffc0202a0a:	ef05                	bnez	a4,ffffffffc0202a42 <page_insert+0x68>
ffffffffc0202a0c:	00093717          	auipc	a4,0x93
ffffffffc0202a10:	e9c73703          	ld	a4,-356(a4) # ffffffffc02958a8 <pages>
ffffffffc0202a14:	8c19                	sub	s0,s0,a4
ffffffffc0202a16:	000807b7          	lui	a5,0x80
ffffffffc0202a1a:	8419                	srai	s0,s0,0x6
ffffffffc0202a1c:	943e                	add	s0,s0,a5
ffffffffc0202a1e:	042a                	slli	s0,s0,0xa
ffffffffc0202a20:	8cc1                	or	s1,s1,s0
ffffffffc0202a22:	0014e493          	ori	s1,s1,1
ffffffffc0202a26:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a2a:	120a0073          	sfence.vma	s4
ffffffffc0202a2e:	4501                	li	a0,0
ffffffffc0202a30:	70e2                	ld	ra,56(sp)
ffffffffc0202a32:	7442                	ld	s0,48(sp)
ffffffffc0202a34:	74a2                	ld	s1,40(sp)
ffffffffc0202a36:	7902                	ld	s2,32(sp)
ffffffffc0202a38:	69e2                	ld	s3,24(sp)
ffffffffc0202a3a:	6a42                	ld	s4,16(sp)
ffffffffc0202a3c:	6aa2                	ld	s5,8(sp)
ffffffffc0202a3e:	6121                	addi	sp,sp,64
ffffffffc0202a40:	8082                	ret
ffffffffc0202a42:	078a                	slli	a5,a5,0x2
ffffffffc0202a44:	83b1                	srli	a5,a5,0xc
ffffffffc0202a46:	00093717          	auipc	a4,0x93
ffffffffc0202a4a:	e5a73703          	ld	a4,-422(a4) # ffffffffc02958a0 <npage>
ffffffffc0202a4e:	06e7ff63          	bgeu	a5,a4,ffffffffc0202acc <page_insert+0xf2>
ffffffffc0202a52:	00093a97          	auipc	s5,0x93
ffffffffc0202a56:	e56a8a93          	addi	s5,s5,-426 # ffffffffc02958a8 <pages>
ffffffffc0202a5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202a5e:	fff80937          	lui	s2,0xfff80
ffffffffc0202a62:	993e                	add	s2,s2,a5
ffffffffc0202a64:	091a                	slli	s2,s2,0x6
ffffffffc0202a66:	993a                	add	s2,s2,a4
ffffffffc0202a68:	01240c63          	beq	s0,s2,ffffffffc0202a80 <page_insert+0xa6>
ffffffffc0202a6c:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcea6f0>
ffffffffc0202a70:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202a74:	00d92023          	sw	a3,0(s2)
ffffffffc0202a78:	c691                	beqz	a3,ffffffffc0202a84 <page_insert+0xaa>
ffffffffc0202a7a:	120a0073          	sfence.vma	s4
ffffffffc0202a7e:	bf59                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a80:	c014                	sw	a3,0(s0)
ffffffffc0202a82:	bf49                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a84:	100027f3          	csrr	a5,sstatus
ffffffffc0202a88:	8b89                	andi	a5,a5,2
ffffffffc0202a8a:	ef91                	bnez	a5,ffffffffc0202aa6 <page_insert+0xcc>
ffffffffc0202a8c:	00093797          	auipc	a5,0x93
ffffffffc0202a90:	e247b783          	ld	a5,-476(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc0202a94:	739c                	ld	a5,32(a5)
ffffffffc0202a96:	4585                	li	a1,1
ffffffffc0202a98:	854a                	mv	a0,s2
ffffffffc0202a9a:	9782                	jalr	a5
ffffffffc0202a9c:	000ab703          	ld	a4,0(s5)
ffffffffc0202aa0:	120a0073          	sfence.vma	s4
ffffffffc0202aa4:	bf85                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202aa6:	9ccfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202aaa:	00093797          	auipc	a5,0x93
ffffffffc0202aae:	e067b783          	ld	a5,-506(a5) # ffffffffc02958b0 <pmm_manager>
ffffffffc0202ab2:	739c                	ld	a5,32(a5)
ffffffffc0202ab4:	4585                	li	a1,1
ffffffffc0202ab6:	854a                	mv	a0,s2
ffffffffc0202ab8:	9782                	jalr	a5
ffffffffc0202aba:	9b2fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202abe:	000ab703          	ld	a4,0(s5)
ffffffffc0202ac2:	120a0073          	sfence.vma	s4
ffffffffc0202ac6:	b7b9                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202ac8:	5571                	li	a0,-4
ffffffffc0202aca:	b79d                	j	ffffffffc0202a30 <page_insert+0x56>
ffffffffc0202acc:	e68ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202ad0 <pmm_init>:
ffffffffc0202ad0:	00009797          	auipc	a5,0x9
ffffffffc0202ad4:	fc878793          	addi	a5,a5,-56 # ffffffffc020ba98 <default_pmm_manager>
ffffffffc0202ad8:	638c                	ld	a1,0(a5)
ffffffffc0202ada:	7159                	addi	sp,sp,-112
ffffffffc0202adc:	f85a                	sd	s6,48(sp)
ffffffffc0202ade:	00009517          	auipc	a0,0x9
ffffffffc0202ae2:	18a50513          	addi	a0,a0,394 # ffffffffc020bc68 <default_pmm_manager+0x1d0>
ffffffffc0202ae6:	00093b17          	auipc	s6,0x93
ffffffffc0202aea:	dcab0b13          	addi	s6,s6,-566 # ffffffffc02958b0 <pmm_manager>
ffffffffc0202aee:	f486                	sd	ra,104(sp)
ffffffffc0202af0:	e8ca                	sd	s2,80(sp)
ffffffffc0202af2:	e4ce                	sd	s3,72(sp)
ffffffffc0202af4:	f0a2                	sd	s0,96(sp)
ffffffffc0202af6:	eca6                	sd	s1,88(sp)
ffffffffc0202af8:	e0d2                	sd	s4,64(sp)
ffffffffc0202afa:	fc56                	sd	s5,56(sp)
ffffffffc0202afc:	f45e                	sd	s7,40(sp)
ffffffffc0202afe:	f062                	sd	s8,32(sp)
ffffffffc0202b00:	ec66                	sd	s9,24(sp)
ffffffffc0202b02:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b06:	ea0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202b0e:	00093997          	auipc	s3,0x93
ffffffffc0202b12:	daa98993          	addi	s3,s3,-598 # ffffffffc02958b8 <va_pa_offset>
ffffffffc0202b16:	679c                	ld	a5,8(a5)
ffffffffc0202b18:	9782                	jalr	a5
ffffffffc0202b1a:	57f5                	li	a5,-3
ffffffffc0202b1c:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b1e:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b22:	f27fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b26:	892a                	mv	s2,a0
ffffffffc0202b28:	f2bfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b2c:	280502e3          	beqz	a0,ffffffffc02035b0 <pmm_init+0xae0>
ffffffffc0202b30:	84aa                	mv	s1,a0
ffffffffc0202b32:	00009517          	auipc	a0,0x9
ffffffffc0202b36:	16e50513          	addi	a0,a0,366 # ffffffffc020bca0 <default_pmm_manager+0x208>
ffffffffc0202b3a:	e6cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b3e:	00990433          	add	s0,s2,s1
ffffffffc0202b42:	fff40693          	addi	a3,s0,-1
ffffffffc0202b46:	864a                	mv	a2,s2
ffffffffc0202b48:	85a6                	mv	a1,s1
ffffffffc0202b4a:	00009517          	auipc	a0,0x9
ffffffffc0202b4e:	16e50513          	addi	a0,a0,366 # ffffffffc020bcb8 <default_pmm_manager+0x220>
ffffffffc0202b52:	e54fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b56:	c8000737          	lui	a4,0xc8000
ffffffffc0202b5a:	87a2                	mv	a5,s0
ffffffffc0202b5c:	5e876e63          	bltu	a4,s0,ffffffffc0203158 <pmm_init+0x688>
ffffffffc0202b60:	757d                	lui	a0,0xfffff
ffffffffc0202b62:	00094617          	auipc	a2,0x94
ffffffffc0202b66:	dad60613          	addi	a2,a2,-595 # ffffffffc029690f <end+0xfff>
ffffffffc0202b6a:	8e69                	and	a2,a2,a0
ffffffffc0202b6c:	00093497          	auipc	s1,0x93
ffffffffc0202b70:	d3448493          	addi	s1,s1,-716 # ffffffffc02958a0 <npage>
ffffffffc0202b74:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202b78:	00093b97          	auipc	s7,0x93
ffffffffc0202b7c:	d30b8b93          	addi	s7,s7,-720 # ffffffffc02958a8 <pages>
ffffffffc0202b80:	e088                	sd	a0,0(s1)
ffffffffc0202b82:	00cbb023          	sd	a2,0(s7)
ffffffffc0202b86:	000807b7          	lui	a5,0x80
ffffffffc0202b8a:	86b2                	mv	a3,a2
ffffffffc0202b8c:	02f50863          	beq	a0,a5,ffffffffc0202bbc <pmm_init+0xec>
ffffffffc0202b90:	4781                	li	a5,0
ffffffffc0202b92:	4585                	li	a1,1
ffffffffc0202b94:	fff806b7          	lui	a3,0xfff80
ffffffffc0202b98:	00679513          	slli	a0,a5,0x6
ffffffffc0202b9c:	9532                	add	a0,a0,a2
ffffffffc0202b9e:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd696f8>
ffffffffc0202ba2:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202ba6:	6088                	ld	a0,0(s1)
ffffffffc0202ba8:	0785                	addi	a5,a5,1
ffffffffc0202baa:	000bb603          	ld	a2,0(s7)
ffffffffc0202bae:	00d50733          	add	a4,a0,a3
ffffffffc0202bb2:	fee7e3e3          	bltu	a5,a4,ffffffffc0202b98 <pmm_init+0xc8>
ffffffffc0202bb6:	071a                	slli	a4,a4,0x6
ffffffffc0202bb8:	00e606b3          	add	a3,a2,a4
ffffffffc0202bbc:	c02007b7          	lui	a5,0xc0200
ffffffffc0202bc0:	3af6eae3          	bltu	a3,a5,ffffffffc0203774 <pmm_init+0xca4>
ffffffffc0202bc4:	0009b583          	ld	a1,0(s3)
ffffffffc0202bc8:	77fd                	lui	a5,0xfffff
ffffffffc0202bca:	8c7d                	and	s0,s0,a5
ffffffffc0202bcc:	8e8d                	sub	a3,a3,a1
ffffffffc0202bce:	5e86e363          	bltu	a3,s0,ffffffffc02031b4 <pmm_init+0x6e4>
ffffffffc0202bd2:	00009517          	auipc	a0,0x9
ffffffffc0202bd6:	10e50513          	addi	a0,a0,270 # ffffffffc020bce0 <default_pmm_manager+0x248>
ffffffffc0202bda:	dccfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bde:	000b3783          	ld	a5,0(s6)
ffffffffc0202be2:	7b9c                	ld	a5,48(a5)
ffffffffc0202be4:	9782                	jalr	a5
ffffffffc0202be6:	00009517          	auipc	a0,0x9
ffffffffc0202bea:	11250513          	addi	a0,a0,274 # ffffffffc020bcf8 <default_pmm_manager+0x260>
ffffffffc0202bee:	db8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bf2:	100027f3          	csrr	a5,sstatus
ffffffffc0202bf6:	8b89                	andi	a5,a5,2
ffffffffc0202bf8:	5a079363          	bnez	a5,ffffffffc020319e <pmm_init+0x6ce>
ffffffffc0202bfc:	000b3783          	ld	a5,0(s6)
ffffffffc0202c00:	4505                	li	a0,1
ffffffffc0202c02:	6f9c                	ld	a5,24(a5)
ffffffffc0202c04:	9782                	jalr	a5
ffffffffc0202c06:	842a                	mv	s0,a0
ffffffffc0202c08:	180408e3          	beqz	s0,ffffffffc0203598 <pmm_init+0xac8>
ffffffffc0202c0c:	000bb683          	ld	a3,0(s7)
ffffffffc0202c10:	5a7d                	li	s4,-1
ffffffffc0202c12:	6098                	ld	a4,0(s1)
ffffffffc0202c14:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c18:	8699                	srai	a3,a3,0x6
ffffffffc0202c1a:	00080437          	lui	s0,0x80
ffffffffc0202c1e:	96a2                	add	a3,a3,s0
ffffffffc0202c20:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c24:	8ff5                	and	a5,a5,a3
ffffffffc0202c26:	06b2                	slli	a3,a3,0xc
ffffffffc0202c28:	30e7fde3          	bgeu	a5,a4,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202c2c:	0009b403          	ld	s0,0(s3)
ffffffffc0202c30:	6605                	lui	a2,0x1
ffffffffc0202c32:	4581                	li	a1,0
ffffffffc0202c34:	9436                	add	s0,s0,a3
ffffffffc0202c36:	8522                	mv	a0,s0
ffffffffc0202c38:	697070ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0202c3c:	0009b683          	ld	a3,0(s3)
ffffffffc0202c40:	77fd                	lui	a5,0xfffff
ffffffffc0202c42:	00009917          	auipc	s2,0x9
ffffffffc0202c46:	ef590913          	addi	s2,s2,-267 # ffffffffc020bb37 <default_pmm_manager+0x9f>
ffffffffc0202c4a:	00f97933          	and	s2,s2,a5
ffffffffc0202c4e:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202c52:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202c56:	964a                	add	a2,a2,s2
ffffffffc0202c58:	4729                	li	a4,10
ffffffffc0202c5a:	40da86b3          	sub	a3,s5,a3
ffffffffc0202c5e:	c02005b7          	lui	a1,0xc0200
ffffffffc0202c62:	8522                	mv	a0,s0
ffffffffc0202c64:	fe8ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c68:	c8000637          	lui	a2,0xc8000
ffffffffc0202c6c:	41260633          	sub	a2,a2,s2
ffffffffc0202c70:	3f596ce3          	bltu	s2,s5,ffffffffc0203868 <pmm_init+0xd98>
ffffffffc0202c74:	0009b683          	ld	a3,0(s3)
ffffffffc0202c78:	85ca                	mv	a1,s2
ffffffffc0202c7a:	4719                	li	a4,6
ffffffffc0202c7c:	40d906b3          	sub	a3,s2,a3
ffffffffc0202c80:	8522                	mv	a0,s0
ffffffffc0202c82:	00093917          	auipc	s2,0x93
ffffffffc0202c86:	c1690913          	addi	s2,s2,-1002 # ffffffffc0295898 <boot_pgdir_va>
ffffffffc0202c8a:	fc2ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c8e:	00893023          	sd	s0,0(s2)
ffffffffc0202c92:	2d5464e3          	bltu	s0,s5,ffffffffc020375a <pmm_init+0xc8a>
ffffffffc0202c96:	0009b783          	ld	a5,0(s3)
ffffffffc0202c9a:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202c9c:	8c1d                	sub	s0,s0,a5
ffffffffc0202c9e:	00c45793          	srli	a5,s0,0xc
ffffffffc0202ca2:	00093717          	auipc	a4,0x93
ffffffffc0202ca6:	be873723          	sd	s0,-1042(a4) # ffffffffc0295890 <boot_pgdir_pa>
ffffffffc0202caa:	0147ea33          	or	s4,a5,s4
ffffffffc0202cae:	180a1073          	csrw	satp,s4
ffffffffc0202cb2:	12000073          	sfence.vma
ffffffffc0202cb6:	00009517          	auipc	a0,0x9
ffffffffc0202cba:	08250513          	addi	a0,a0,130 # ffffffffc020bd38 <default_pmm_manager+0x2a0>
ffffffffc0202cbe:	ce8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc2:	0000d717          	auipc	a4,0xd
ffffffffc0202cc6:	33e70713          	addi	a4,a4,830 # ffffffffc0210000 <bootstack>
ffffffffc0202cca:	0000d797          	auipc	a5,0xd
ffffffffc0202cce:	33678793          	addi	a5,a5,822 # ffffffffc0210000 <bootstack>
ffffffffc0202cd2:	5cf70d63          	beq	a4,a5,ffffffffc02032ac <pmm_init+0x7dc>
ffffffffc0202cd6:	100027f3          	csrr	a5,sstatus
ffffffffc0202cda:	8b89                	andi	a5,a5,2
ffffffffc0202cdc:	4a079763          	bnez	a5,ffffffffc020318a <pmm_init+0x6ba>
ffffffffc0202ce0:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce4:	779c                	ld	a5,40(a5)
ffffffffc0202ce6:	9782                	jalr	a5
ffffffffc0202ce8:	842a                	mv	s0,a0
ffffffffc0202cea:	6098                	ld	a4,0(s1)
ffffffffc0202cec:	c80007b7          	lui	a5,0xc8000
ffffffffc0202cf0:	83b1                	srli	a5,a5,0xc
ffffffffc0202cf2:	08e7e3e3          	bltu	a5,a4,ffffffffc0203578 <pmm_init+0xaa8>
ffffffffc0202cf6:	00093503          	ld	a0,0(s2)
ffffffffc0202cfa:	04050fe3          	beqz	a0,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202cfe:	03451793          	slli	a5,a0,0x34
ffffffffc0202d02:	04079be3          	bnez	a5,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202d06:	4601                	li	a2,0
ffffffffc0202d08:	4581                	li	a1,0
ffffffffc0202d0a:	809ff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202d0e:	2e0511e3          	bnez	a0,ffffffffc02037f0 <pmm_init+0xd20>
ffffffffc0202d12:	100027f3          	csrr	a5,sstatus
ffffffffc0202d16:	8b89                	andi	a5,a5,2
ffffffffc0202d18:	44079e63          	bnez	a5,ffffffffc0203174 <pmm_init+0x6a4>
ffffffffc0202d1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d20:	4505                	li	a0,1
ffffffffc0202d22:	6f9c                	ld	a5,24(a5)
ffffffffc0202d24:	9782                	jalr	a5
ffffffffc0202d26:	8a2a                	mv	s4,a0
ffffffffc0202d28:	00093503          	ld	a0,0(s2)
ffffffffc0202d2c:	4681                	li	a3,0
ffffffffc0202d2e:	4601                	li	a2,0
ffffffffc0202d30:	85d2                	mv	a1,s4
ffffffffc0202d32:	ca9ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202d36:	26051be3          	bnez	a0,ffffffffc02037ac <pmm_init+0xcdc>
ffffffffc0202d3a:	00093503          	ld	a0,0(s2)
ffffffffc0202d3e:	4601                	li	a2,0
ffffffffc0202d40:	4581                	li	a1,0
ffffffffc0202d42:	ce2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202d46:	280505e3          	beqz	a0,ffffffffc02037d0 <pmm_init+0xd00>
ffffffffc0202d4a:	611c                	ld	a5,0(a0)
ffffffffc0202d4c:	0017f713          	andi	a4,a5,1
ffffffffc0202d50:	26070ee3          	beqz	a4,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202d54:	6098                	ld	a4,0(s1)
ffffffffc0202d56:	078a                	slli	a5,a5,0x2
ffffffffc0202d58:	83b1                	srli	a5,a5,0xc
ffffffffc0202d5a:	62e7f363          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202d5e:	000bb683          	ld	a3,0(s7)
ffffffffc0202d62:	fff80637          	lui	a2,0xfff80
ffffffffc0202d66:	97b2                	add	a5,a5,a2
ffffffffc0202d68:	079a                	slli	a5,a5,0x6
ffffffffc0202d6a:	97b6                	add	a5,a5,a3
ffffffffc0202d6c:	2afa12e3          	bne	s4,a5,ffffffffc0203810 <pmm_init+0xd40>
ffffffffc0202d70:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202d74:	4785                	li	a5,1
ffffffffc0202d76:	2cf699e3          	bne	a3,a5,ffffffffc0203848 <pmm_init+0xd78>
ffffffffc0202d7a:	00093503          	ld	a0,0(s2)
ffffffffc0202d7e:	77fd                	lui	a5,0xfffff
ffffffffc0202d80:	6114                	ld	a3,0(a0)
ffffffffc0202d82:	068a                	slli	a3,a3,0x2
ffffffffc0202d84:	8efd                	and	a3,a3,a5
ffffffffc0202d86:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202d8a:	2ae673e3          	bgeu	a2,a4,ffffffffc0203830 <pmm_init+0xd60>
ffffffffc0202d8e:	0009bc03          	ld	s8,0(s3)
ffffffffc0202d92:	96e2                	add	a3,a3,s8
ffffffffc0202d94:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fcea6f0>
ffffffffc0202d98:	0a8a                	slli	s5,s5,0x2
ffffffffc0202d9a:	00fafab3          	and	s5,s5,a5
ffffffffc0202d9e:	00cad793          	srli	a5,s5,0xc
ffffffffc0202da2:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203608 <pmm_init+0xb38>
ffffffffc0202da6:	4601                	li	a2,0
ffffffffc0202da8:	6585                	lui	a1,0x1
ffffffffc0202daa:	9ae2                	add	s5,s5,s8
ffffffffc0202dac:	c78ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202db0:	0aa1                	addi	s5,s5,8
ffffffffc0202db2:	03551be3          	bne	a0,s5,ffffffffc02035e8 <pmm_init+0xb18>
ffffffffc0202db6:	100027f3          	csrr	a5,sstatus
ffffffffc0202dba:	8b89                	andi	a5,a5,2
ffffffffc0202dbc:	3a079163          	bnez	a5,ffffffffc020315e <pmm_init+0x68e>
ffffffffc0202dc0:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc4:	4505                	li	a0,1
ffffffffc0202dc6:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc8:	9782                	jalr	a5
ffffffffc0202dca:	8c2a                	mv	s8,a0
ffffffffc0202dcc:	00093503          	ld	a0,0(s2)
ffffffffc0202dd0:	46d1                	li	a3,20
ffffffffc0202dd2:	6605                	lui	a2,0x1
ffffffffc0202dd4:	85e2                	mv	a1,s8
ffffffffc0202dd6:	c05ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202dda:	1a0519e3          	bnez	a0,ffffffffc020378c <pmm_init+0xcbc>
ffffffffc0202dde:	00093503          	ld	a0,0(s2)
ffffffffc0202de2:	4601                	li	a2,0
ffffffffc0202de4:	6585                	lui	a1,0x1
ffffffffc0202de6:	c3eff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202dea:	10050ce3          	beqz	a0,ffffffffc0203702 <pmm_init+0xc32>
ffffffffc0202dee:	611c                	ld	a5,0(a0)
ffffffffc0202df0:	0107f713          	andi	a4,a5,16
ffffffffc0202df4:	0e0707e3          	beqz	a4,ffffffffc02036e2 <pmm_init+0xc12>
ffffffffc0202df8:	8b91                	andi	a5,a5,4
ffffffffc0202dfa:	0c0784e3          	beqz	a5,ffffffffc02036c2 <pmm_init+0xbf2>
ffffffffc0202dfe:	00093503          	ld	a0,0(s2)
ffffffffc0202e02:	611c                	ld	a5,0(a0)
ffffffffc0202e04:	8bc1                	andi	a5,a5,16
ffffffffc0202e06:	08078ee3          	beqz	a5,ffffffffc02036a2 <pmm_init+0xbd2>
ffffffffc0202e0a:	000c2703          	lw	a4,0(s8)
ffffffffc0202e0e:	4785                	li	a5,1
ffffffffc0202e10:	06f719e3          	bne	a4,a5,ffffffffc0203682 <pmm_init+0xbb2>
ffffffffc0202e14:	4681                	li	a3,0
ffffffffc0202e16:	6605                	lui	a2,0x1
ffffffffc0202e18:	85d2                	mv	a1,s4
ffffffffc0202e1a:	bc1ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202e1e:	040512e3          	bnez	a0,ffffffffc0203662 <pmm_init+0xb92>
ffffffffc0202e22:	000a2703          	lw	a4,0(s4)
ffffffffc0202e26:	4789                	li	a5,2
ffffffffc0202e28:	00f71de3          	bne	a4,a5,ffffffffc0203642 <pmm_init+0xb72>
ffffffffc0202e2c:	000c2783          	lw	a5,0(s8)
ffffffffc0202e30:	7e079963          	bnez	a5,ffffffffc0203622 <pmm_init+0xb52>
ffffffffc0202e34:	00093503          	ld	a0,0(s2)
ffffffffc0202e38:	4601                	li	a2,0
ffffffffc0202e3a:	6585                	lui	a1,0x1
ffffffffc0202e3c:	be8ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202e40:	54050263          	beqz	a0,ffffffffc0203384 <pmm_init+0x8b4>
ffffffffc0202e44:	6118                	ld	a4,0(a0)
ffffffffc0202e46:	00177793          	andi	a5,a4,1
ffffffffc0202e4a:	180781e3          	beqz	a5,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202e4e:	6094                	ld	a3,0(s1)
ffffffffc0202e50:	00271793          	slli	a5,a4,0x2
ffffffffc0202e54:	83b1                	srli	a5,a5,0xc
ffffffffc0202e56:	52d7f563          	bgeu	a5,a3,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202e5a:	000bb683          	ld	a3,0(s7)
ffffffffc0202e5e:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202e62:	97d6                	add	a5,a5,s5
ffffffffc0202e64:	079a                	slli	a5,a5,0x6
ffffffffc0202e66:	97b6                	add	a5,a5,a3
ffffffffc0202e68:	58fa1e63          	bne	s4,a5,ffffffffc0203404 <pmm_init+0x934>
ffffffffc0202e6c:	8b41                	andi	a4,a4,16
ffffffffc0202e6e:	56071b63          	bnez	a4,ffffffffc02033e4 <pmm_init+0x914>
ffffffffc0202e72:	00093503          	ld	a0,0(s2)
ffffffffc0202e76:	4581                	li	a1,0
ffffffffc0202e78:	ac7ff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e7c:	000a2c83          	lw	s9,0(s4)
ffffffffc0202e80:	4785                	li	a5,1
ffffffffc0202e82:	5cfc9163          	bne	s9,a5,ffffffffc0203444 <pmm_init+0x974>
ffffffffc0202e86:	000c2783          	lw	a5,0(s8)
ffffffffc0202e8a:	58079d63          	bnez	a5,ffffffffc0203424 <pmm_init+0x954>
ffffffffc0202e8e:	00093503          	ld	a0,0(s2)
ffffffffc0202e92:	6585                	lui	a1,0x1
ffffffffc0202e94:	aabff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e98:	000a2783          	lw	a5,0(s4)
ffffffffc0202e9c:	200793e3          	bnez	a5,ffffffffc02038a2 <pmm_init+0xdd2>
ffffffffc0202ea0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ea4:	1c079fe3          	bnez	a5,ffffffffc0203882 <pmm_init+0xdb2>
ffffffffc0202ea8:	00093a03          	ld	s4,0(s2)
ffffffffc0202eac:	608c                	ld	a1,0(s1)
ffffffffc0202eae:	000a3683          	ld	a3,0(s4)
ffffffffc0202eb2:	068a                	slli	a3,a3,0x2
ffffffffc0202eb4:	82b1                	srli	a3,a3,0xc
ffffffffc0202eb6:	4cb6f563          	bgeu	a3,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202eba:	000bb503          	ld	a0,0(s7)
ffffffffc0202ebe:	96d6                	add	a3,a3,s5
ffffffffc0202ec0:	069a                	slli	a3,a3,0x6
ffffffffc0202ec2:	00d507b3          	add	a5,a0,a3
ffffffffc0202ec6:	439c                	lw	a5,0(a5)
ffffffffc0202ec8:	4f979e63          	bne	a5,s9,ffffffffc02033c4 <pmm_init+0x8f4>
ffffffffc0202ecc:	8699                	srai	a3,a3,0x6
ffffffffc0202ece:	00080637          	lui	a2,0x80
ffffffffc0202ed2:	96b2                	add	a3,a3,a2
ffffffffc0202ed4:	00c69713          	slli	a4,a3,0xc
ffffffffc0202ed8:	8331                	srli	a4,a4,0xc
ffffffffc0202eda:	06b2                	slli	a3,a3,0xc
ffffffffc0202edc:	06b773e3          	bgeu	a4,a1,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202ee0:	0009b703          	ld	a4,0(s3)
ffffffffc0202ee4:	96ba                	add	a3,a3,a4
ffffffffc0202ee6:	629c                	ld	a5,0(a3)
ffffffffc0202ee8:	078a                	slli	a5,a5,0x2
ffffffffc0202eea:	83b1                	srli	a5,a5,0xc
ffffffffc0202eec:	48b7fa63          	bgeu	a5,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202ef0:	8f91                	sub	a5,a5,a2
ffffffffc0202ef2:	079a                	slli	a5,a5,0x6
ffffffffc0202ef4:	953e                	add	a0,a0,a5
ffffffffc0202ef6:	100027f3          	csrr	a5,sstatus
ffffffffc0202efa:	8b89                	andi	a5,a5,2
ffffffffc0202efc:	32079463          	bnez	a5,ffffffffc0203224 <pmm_init+0x754>
ffffffffc0202f00:	000b3783          	ld	a5,0(s6)
ffffffffc0202f04:	4585                	li	a1,1
ffffffffc0202f06:	739c                	ld	a5,32(a5)
ffffffffc0202f08:	9782                	jalr	a5
ffffffffc0202f0a:	000a3783          	ld	a5,0(s4)
ffffffffc0202f0e:	6098                	ld	a4,0(s1)
ffffffffc0202f10:	078a                	slli	a5,a5,0x2
ffffffffc0202f12:	83b1                	srli	a5,a5,0xc
ffffffffc0202f14:	46e7f663          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202f18:	000bb503          	ld	a0,0(s7)
ffffffffc0202f1c:	fff80737          	lui	a4,0xfff80
ffffffffc0202f20:	97ba                	add	a5,a5,a4
ffffffffc0202f22:	079a                	slli	a5,a5,0x6
ffffffffc0202f24:	953e                	add	a0,a0,a5
ffffffffc0202f26:	100027f3          	csrr	a5,sstatus
ffffffffc0202f2a:	8b89                	andi	a5,a5,2
ffffffffc0202f2c:	2e079063          	bnez	a5,ffffffffc020320c <pmm_init+0x73c>
ffffffffc0202f30:	000b3783          	ld	a5,0(s6)
ffffffffc0202f34:	4585                	li	a1,1
ffffffffc0202f36:	739c                	ld	a5,32(a5)
ffffffffc0202f38:	9782                	jalr	a5
ffffffffc0202f3a:	00093783          	ld	a5,0(s2)
ffffffffc0202f3e:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd696f0>
ffffffffc0202f42:	12000073          	sfence.vma
ffffffffc0202f46:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4a:	8b89                	andi	a5,a5,2
ffffffffc0202f4c:	2a079663          	bnez	a5,ffffffffc02031f8 <pmm_init+0x728>
ffffffffc0202f50:	000b3783          	ld	a5,0(s6)
ffffffffc0202f54:	779c                	ld	a5,40(a5)
ffffffffc0202f56:	9782                	jalr	a5
ffffffffc0202f58:	8a2a                	mv	s4,a0
ffffffffc0202f5a:	7d441463          	bne	s0,s4,ffffffffc0203722 <pmm_init+0xc52>
ffffffffc0202f5e:	00009517          	auipc	a0,0x9
ffffffffc0202f62:	13250513          	addi	a0,a0,306 # ffffffffc020c090 <default_pmm_manager+0x5f8>
ffffffffc0202f66:	a40fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202f6a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f6e:	8b89                	andi	a5,a5,2
ffffffffc0202f70:	26079a63          	bnez	a5,ffffffffc02031e4 <pmm_init+0x714>
ffffffffc0202f74:	000b3783          	ld	a5,0(s6)
ffffffffc0202f78:	779c                	ld	a5,40(a5)
ffffffffc0202f7a:	9782                	jalr	a5
ffffffffc0202f7c:	8c2a                	mv	s8,a0
ffffffffc0202f7e:	6098                	ld	a4,0(s1)
ffffffffc0202f80:	c0200437          	lui	s0,0xc0200
ffffffffc0202f84:	7afd                	lui	s5,0xfffff
ffffffffc0202f86:	00c71793          	slli	a5,a4,0xc
ffffffffc0202f8a:	6a05                	lui	s4,0x1
ffffffffc0202f8c:	02f47c63          	bgeu	s0,a5,ffffffffc0202fc4 <pmm_init+0x4f4>
ffffffffc0202f90:	00c45793          	srli	a5,s0,0xc
ffffffffc0202f94:	00093503          	ld	a0,0(s2)
ffffffffc0202f98:	3ae7f763          	bgeu	a5,a4,ffffffffc0203346 <pmm_init+0x876>
ffffffffc0202f9c:	0009b583          	ld	a1,0(s3)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	95a2                	add	a1,a1,s0
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	36050f63          	beqz	a0,ffffffffc0203326 <pmm_init+0x856>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	078a                	slli	a5,a5,0x2
ffffffffc0202fb0:	0157f7b3          	and	a5,a5,s5
ffffffffc0202fb4:	3a879663          	bne	a5,s0,ffffffffc0203360 <pmm_init+0x890>
ffffffffc0202fb8:	6098                	ld	a4,0(s1)
ffffffffc0202fba:	9452                	add	s0,s0,s4
ffffffffc0202fbc:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fc0:	fcf468e3          	bltu	s0,a5,ffffffffc0202f90 <pmm_init+0x4c0>
ffffffffc0202fc4:	00093783          	ld	a5,0(s2)
ffffffffc0202fc8:	639c                	ld	a5,0(a5)
ffffffffc0202fca:	48079d63          	bnez	a5,ffffffffc0203464 <pmm_init+0x994>
ffffffffc0202fce:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd2:	8b89                	andi	a5,a5,2
ffffffffc0202fd4:	26079463          	bnez	a5,ffffffffc020323c <pmm_init+0x76c>
ffffffffc0202fd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202fdc:	4505                	li	a0,1
ffffffffc0202fde:	6f9c                	ld	a5,24(a5)
ffffffffc0202fe0:	9782                	jalr	a5
ffffffffc0202fe2:	8a2a                	mv	s4,a0
ffffffffc0202fe4:	00093503          	ld	a0,0(s2)
ffffffffc0202fe8:	4699                	li	a3,6
ffffffffc0202fea:	10000613          	li	a2,256
ffffffffc0202fee:	85d2                	mv	a1,s4
ffffffffc0202ff0:	9ebff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202ff4:	4a051863          	bnez	a0,ffffffffc02034a4 <pmm_init+0x9d4>
ffffffffc0202ff8:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202ffc:	4785                	li	a5,1
ffffffffc0202ffe:	48f71363          	bne	a4,a5,ffffffffc0203484 <pmm_init+0x9b4>
ffffffffc0203002:	00093503          	ld	a0,0(s2)
ffffffffc0203006:	6405                	lui	s0,0x1
ffffffffc0203008:	4699                	li	a3,6
ffffffffc020300a:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc020300e:	85d2                	mv	a1,s4
ffffffffc0203010:	9cbff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203014:	38051863          	bnez	a0,ffffffffc02033a4 <pmm_init+0x8d4>
ffffffffc0203018:	000a2703          	lw	a4,0(s4)
ffffffffc020301c:	4789                	li	a5,2
ffffffffc020301e:	4ef71363          	bne	a4,a5,ffffffffc0203504 <pmm_init+0xa34>
ffffffffc0203022:	00009597          	auipc	a1,0x9
ffffffffc0203026:	1b658593          	addi	a1,a1,438 # ffffffffc020c1d8 <default_pmm_manager+0x740>
ffffffffc020302a:	10000513          	li	a0,256
ffffffffc020302e:	235070ef          	jal	ra,ffffffffc020aa62 <strcpy>
ffffffffc0203032:	10040593          	addi	a1,s0,256
ffffffffc0203036:	10000513          	li	a0,256
ffffffffc020303a:	23b070ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc020303e:	4a051363          	bnez	a0,ffffffffc02034e4 <pmm_init+0xa14>
ffffffffc0203042:	000bb683          	ld	a3,0(s7)
ffffffffc0203046:	00080737          	lui	a4,0x80
ffffffffc020304a:	547d                	li	s0,-1
ffffffffc020304c:	40da06b3          	sub	a3,s4,a3
ffffffffc0203050:	8699                	srai	a3,a3,0x6
ffffffffc0203052:	609c                	ld	a5,0(s1)
ffffffffc0203054:	96ba                	add	a3,a3,a4
ffffffffc0203056:	8031                	srli	s0,s0,0xc
ffffffffc0203058:	0086f733          	and	a4,a3,s0
ffffffffc020305c:	06b2                	slli	a3,a3,0xc
ffffffffc020305e:	6ef77263          	bgeu	a4,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203062:	0009b783          	ld	a5,0(s3)
ffffffffc0203066:	10000513          	li	a0,256
ffffffffc020306a:	96be                	add	a3,a3,a5
ffffffffc020306c:	10068023          	sb	zero,256(a3)
ffffffffc0203070:	1bd070ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc0203074:	44051863          	bnez	a0,ffffffffc02034c4 <pmm_init+0x9f4>
ffffffffc0203078:	00093a83          	ld	s5,0(s2)
ffffffffc020307c:	609c                	ld	a5,0(s1)
ffffffffc020307e:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd696f0>
ffffffffc0203082:	068a                	slli	a3,a3,0x2
ffffffffc0203084:	82b1                	srli	a3,a3,0xc
ffffffffc0203086:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc020308a:	8c75                	and	s0,s0,a3
ffffffffc020308c:	06b2                	slli	a3,a3,0xc
ffffffffc020308e:	6af47a63          	bgeu	s0,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203092:	0009b403          	ld	s0,0(s3)
ffffffffc0203096:	9436                	add	s0,s0,a3
ffffffffc0203098:	100027f3          	csrr	a5,sstatus
ffffffffc020309c:	8b89                	andi	a5,a5,2
ffffffffc020309e:	1e079c63          	bnez	a5,ffffffffc0203296 <pmm_init+0x7c6>
ffffffffc02030a2:	000b3783          	ld	a5,0(s6)
ffffffffc02030a6:	4585                	li	a1,1
ffffffffc02030a8:	8552                	mv	a0,s4
ffffffffc02030aa:	739c                	ld	a5,32(a5)
ffffffffc02030ac:	9782                	jalr	a5
ffffffffc02030ae:	601c                	ld	a5,0(s0)
ffffffffc02030b0:	6098                	ld	a4,0(s1)
ffffffffc02030b2:	078a                	slli	a5,a5,0x2
ffffffffc02030b4:	83b1                	srli	a5,a5,0xc
ffffffffc02030b6:	2ce7f563          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ba:	000bb503          	ld	a0,0(s7)
ffffffffc02030be:	fff80737          	lui	a4,0xfff80
ffffffffc02030c2:	97ba                	add	a5,a5,a4
ffffffffc02030c4:	079a                	slli	a5,a5,0x6
ffffffffc02030c6:	953e                	add	a0,a0,a5
ffffffffc02030c8:	100027f3          	csrr	a5,sstatus
ffffffffc02030cc:	8b89                	andi	a5,a5,2
ffffffffc02030ce:	1a079863          	bnez	a5,ffffffffc020327e <pmm_init+0x7ae>
ffffffffc02030d2:	000b3783          	ld	a5,0(s6)
ffffffffc02030d6:	4585                	li	a1,1
ffffffffc02030d8:	739c                	ld	a5,32(a5)
ffffffffc02030da:	9782                	jalr	a5
ffffffffc02030dc:	000ab783          	ld	a5,0(s5)
ffffffffc02030e0:	6098                	ld	a4,0(s1)
ffffffffc02030e2:	078a                	slli	a5,a5,0x2
ffffffffc02030e4:	83b1                	srli	a5,a5,0xc
ffffffffc02030e6:	28e7fd63          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ea:	000bb503          	ld	a0,0(s7)
ffffffffc02030ee:	fff80737          	lui	a4,0xfff80
ffffffffc02030f2:	97ba                	add	a5,a5,a4
ffffffffc02030f4:	079a                	slli	a5,a5,0x6
ffffffffc02030f6:	953e                	add	a0,a0,a5
ffffffffc02030f8:	100027f3          	csrr	a5,sstatus
ffffffffc02030fc:	8b89                	andi	a5,a5,2
ffffffffc02030fe:	16079463          	bnez	a5,ffffffffc0203266 <pmm_init+0x796>
ffffffffc0203102:	000b3783          	ld	a5,0(s6)
ffffffffc0203106:	4585                	li	a1,1
ffffffffc0203108:	739c                	ld	a5,32(a5)
ffffffffc020310a:	9782                	jalr	a5
ffffffffc020310c:	00093783          	ld	a5,0(s2)
ffffffffc0203110:	0007b023          	sd	zero,0(a5)
ffffffffc0203114:	12000073          	sfence.vma
ffffffffc0203118:	100027f3          	csrr	a5,sstatus
ffffffffc020311c:	8b89                	andi	a5,a5,2
ffffffffc020311e:	12079a63          	bnez	a5,ffffffffc0203252 <pmm_init+0x782>
ffffffffc0203122:	000b3783          	ld	a5,0(s6)
ffffffffc0203126:	779c                	ld	a5,40(a5)
ffffffffc0203128:	9782                	jalr	a5
ffffffffc020312a:	842a                	mv	s0,a0
ffffffffc020312c:	488c1e63          	bne	s8,s0,ffffffffc02035c8 <pmm_init+0xaf8>
ffffffffc0203130:	00009517          	auipc	a0,0x9
ffffffffc0203134:	12050513          	addi	a0,a0,288 # ffffffffc020c250 <default_pmm_manager+0x7b8>
ffffffffc0203138:	86efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020313c:	7406                	ld	s0,96(sp)
ffffffffc020313e:	70a6                	ld	ra,104(sp)
ffffffffc0203140:	64e6                	ld	s1,88(sp)
ffffffffc0203142:	6946                	ld	s2,80(sp)
ffffffffc0203144:	69a6                	ld	s3,72(sp)
ffffffffc0203146:	6a06                	ld	s4,64(sp)
ffffffffc0203148:	7ae2                	ld	s5,56(sp)
ffffffffc020314a:	7b42                	ld	s6,48(sp)
ffffffffc020314c:	7ba2                	ld	s7,40(sp)
ffffffffc020314e:	7c02                	ld	s8,32(sp)
ffffffffc0203150:	6ce2                	ld	s9,24(sp)
ffffffffc0203152:	6165                	addi	sp,sp,112
ffffffffc0203154:	e17fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203158:	c80007b7          	lui	a5,0xc8000
ffffffffc020315c:	b411                	j	ffffffffc0202b60 <pmm_init+0x90>
ffffffffc020315e:	b15fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203162:	000b3783          	ld	a5,0(s6)
ffffffffc0203166:	4505                	li	a0,1
ffffffffc0203168:	6f9c                	ld	a5,24(a5)
ffffffffc020316a:	9782                	jalr	a5
ffffffffc020316c:	8c2a                	mv	s8,a0
ffffffffc020316e:	afffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203172:	b9a9                	j	ffffffffc0202dcc <pmm_init+0x2fc>
ffffffffc0203174:	afffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203178:	000b3783          	ld	a5,0(s6)
ffffffffc020317c:	4505                	li	a0,1
ffffffffc020317e:	6f9c                	ld	a5,24(a5)
ffffffffc0203180:	9782                	jalr	a5
ffffffffc0203182:	8a2a                	mv	s4,a0
ffffffffc0203184:	ae9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203188:	b645                	j	ffffffffc0202d28 <pmm_init+0x258>
ffffffffc020318a:	ae9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020318e:	000b3783          	ld	a5,0(s6)
ffffffffc0203192:	779c                	ld	a5,40(a5)
ffffffffc0203194:	9782                	jalr	a5
ffffffffc0203196:	842a                	mv	s0,a0
ffffffffc0203198:	ad5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020319c:	b6b9                	j	ffffffffc0202cea <pmm_init+0x21a>
ffffffffc020319e:	ad5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031a2:	000b3783          	ld	a5,0(s6)
ffffffffc02031a6:	4505                	li	a0,1
ffffffffc02031a8:	6f9c                	ld	a5,24(a5)
ffffffffc02031aa:	9782                	jalr	a5
ffffffffc02031ac:	842a                	mv	s0,a0
ffffffffc02031ae:	abffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031b2:	bc99                	j	ffffffffc0202c08 <pmm_init+0x138>
ffffffffc02031b4:	6705                	lui	a4,0x1
ffffffffc02031b6:	177d                	addi	a4,a4,-1
ffffffffc02031b8:	96ba                	add	a3,a3,a4
ffffffffc02031ba:	8ff5                	and	a5,a5,a3
ffffffffc02031bc:	00c7d713          	srli	a4,a5,0xc
ffffffffc02031c0:	1ca77063          	bgeu	a4,a0,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02031c4:	000b3683          	ld	a3,0(s6)
ffffffffc02031c8:	fff80537          	lui	a0,0xfff80
ffffffffc02031cc:	972a                	add	a4,a4,a0
ffffffffc02031ce:	6a94                	ld	a3,16(a3)
ffffffffc02031d0:	8c1d                	sub	s0,s0,a5
ffffffffc02031d2:	00671513          	slli	a0,a4,0x6
ffffffffc02031d6:	00c45593          	srli	a1,s0,0xc
ffffffffc02031da:	9532                	add	a0,a0,a2
ffffffffc02031dc:	9682                	jalr	a3
ffffffffc02031de:	0009b583          	ld	a1,0(s3)
ffffffffc02031e2:	bac5                	j	ffffffffc0202bd2 <pmm_init+0x102>
ffffffffc02031e4:	a8ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031e8:	000b3783          	ld	a5,0(s6)
ffffffffc02031ec:	779c                	ld	a5,40(a5)
ffffffffc02031ee:	9782                	jalr	a5
ffffffffc02031f0:	8c2a                	mv	s8,a0
ffffffffc02031f2:	a7bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031f6:	b361                	j	ffffffffc0202f7e <pmm_init+0x4ae>
ffffffffc02031f8:	a7bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031fc:	000b3783          	ld	a5,0(s6)
ffffffffc0203200:	779c                	ld	a5,40(a5)
ffffffffc0203202:	9782                	jalr	a5
ffffffffc0203204:	8a2a                	mv	s4,a0
ffffffffc0203206:	a67fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020320a:	bb81                	j	ffffffffc0202f5a <pmm_init+0x48a>
ffffffffc020320c:	e42a                	sd	a0,8(sp)
ffffffffc020320e:	a65fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203212:	000b3783          	ld	a5,0(s6)
ffffffffc0203216:	6522                	ld	a0,8(sp)
ffffffffc0203218:	4585                	li	a1,1
ffffffffc020321a:	739c                	ld	a5,32(a5)
ffffffffc020321c:	9782                	jalr	a5
ffffffffc020321e:	a4ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203222:	bb21                	j	ffffffffc0202f3a <pmm_init+0x46a>
ffffffffc0203224:	e42a                	sd	a0,8(sp)
ffffffffc0203226:	a4dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020322a:	000b3783          	ld	a5,0(s6)
ffffffffc020322e:	6522                	ld	a0,8(sp)
ffffffffc0203230:	4585                	li	a1,1
ffffffffc0203232:	739c                	ld	a5,32(a5)
ffffffffc0203234:	9782                	jalr	a5
ffffffffc0203236:	a37fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020323a:	b9c1                	j	ffffffffc0202f0a <pmm_init+0x43a>
ffffffffc020323c:	a37fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203240:	000b3783          	ld	a5,0(s6)
ffffffffc0203244:	4505                	li	a0,1
ffffffffc0203246:	6f9c                	ld	a5,24(a5)
ffffffffc0203248:	9782                	jalr	a5
ffffffffc020324a:	8a2a                	mv	s4,a0
ffffffffc020324c:	a21fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203250:	bb51                	j	ffffffffc0202fe4 <pmm_init+0x514>
ffffffffc0203252:	a21fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203256:	000b3783          	ld	a5,0(s6)
ffffffffc020325a:	779c                	ld	a5,40(a5)
ffffffffc020325c:	9782                	jalr	a5
ffffffffc020325e:	842a                	mv	s0,a0
ffffffffc0203260:	a0dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203264:	b5e1                	j	ffffffffc020312c <pmm_init+0x65c>
ffffffffc0203266:	e42a                	sd	a0,8(sp)
ffffffffc0203268:	a0bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020326c:	000b3783          	ld	a5,0(s6)
ffffffffc0203270:	6522                	ld	a0,8(sp)
ffffffffc0203272:	4585                	li	a1,1
ffffffffc0203274:	739c                	ld	a5,32(a5)
ffffffffc0203276:	9782                	jalr	a5
ffffffffc0203278:	9f5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020327c:	bd41                	j	ffffffffc020310c <pmm_init+0x63c>
ffffffffc020327e:	e42a                	sd	a0,8(sp)
ffffffffc0203280:	9f3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203284:	000b3783          	ld	a5,0(s6)
ffffffffc0203288:	6522                	ld	a0,8(sp)
ffffffffc020328a:	4585                	li	a1,1
ffffffffc020328c:	739c                	ld	a5,32(a5)
ffffffffc020328e:	9782                	jalr	a5
ffffffffc0203290:	9ddfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203294:	b5a1                	j	ffffffffc02030dc <pmm_init+0x60c>
ffffffffc0203296:	9ddfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020329a:	000b3783          	ld	a5,0(s6)
ffffffffc020329e:	4585                	li	a1,1
ffffffffc02032a0:	8552                	mv	a0,s4
ffffffffc02032a2:	739c                	ld	a5,32(a5)
ffffffffc02032a4:	9782                	jalr	a5
ffffffffc02032a6:	9c7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032aa:	b511                	j	ffffffffc02030ae <pmm_init+0x5de>
ffffffffc02032ac:	0000f417          	auipc	s0,0xf
ffffffffc02032b0:	d5440413          	addi	s0,s0,-684 # ffffffffc0212000 <boot_page_table_sv39>
ffffffffc02032b4:	0000f797          	auipc	a5,0xf
ffffffffc02032b8:	d4c78793          	addi	a5,a5,-692 # ffffffffc0212000 <boot_page_table_sv39>
ffffffffc02032bc:	a0f41de3          	bne	s0,a5,ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc02032c0:	4581                	li	a1,0
ffffffffc02032c2:	6605                	lui	a2,0x1
ffffffffc02032c4:	8522                	mv	a0,s0
ffffffffc02032c6:	009070ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc02032ca:	0000c597          	auipc	a1,0xc
ffffffffc02032ce:	d3658593          	addi	a1,a1,-714 # ffffffffc020f000 <bootstackguard>
ffffffffc02032d2:	0000d797          	auipc	a5,0xd
ffffffffc02032d6:	d20786a3          	sb	zero,-723(a5) # ffffffffc020ffff <bootstackguard+0xfff>
ffffffffc02032da:	0000c797          	auipc	a5,0xc
ffffffffc02032de:	d2078323          	sb	zero,-730(a5) # ffffffffc020f000 <bootstackguard>
ffffffffc02032e2:	00093503          	ld	a0,0(s2)
ffffffffc02032e6:	2555ec63          	bltu	a1,s5,ffffffffc020353e <pmm_init+0xa6e>
ffffffffc02032ea:	0009b683          	ld	a3,0(s3)
ffffffffc02032ee:	4701                	li	a4,0
ffffffffc02032f0:	6605                	lui	a2,0x1
ffffffffc02032f2:	40d586b3          	sub	a3,a1,a3
ffffffffc02032f6:	956ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02032fa:	00093503          	ld	a0,0(s2)
ffffffffc02032fe:	23546363          	bltu	s0,s5,ffffffffc0203524 <pmm_init+0xa54>
ffffffffc0203302:	0009b683          	ld	a3,0(s3)
ffffffffc0203306:	4701                	li	a4,0
ffffffffc0203308:	6605                	lui	a2,0x1
ffffffffc020330a:	40d406b3          	sub	a3,s0,a3
ffffffffc020330e:	85a2                	mv	a1,s0
ffffffffc0203310:	93cff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0203314:	12000073          	sfence.vma
ffffffffc0203318:	00009517          	auipc	a0,0x9
ffffffffc020331c:	a4850513          	addi	a0,a0,-1464 # ffffffffc020bd60 <default_pmm_manager+0x2c8>
ffffffffc0203320:	e87fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203324:	ba4d                	j	ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc0203326:	00009697          	auipc	a3,0x9
ffffffffc020332a:	d8a68693          	addi	a3,a3,-630 # ffffffffc020c0b0 <default_pmm_manager+0x618>
ffffffffc020332e:	00008617          	auipc	a2,0x8
ffffffffc0203332:	c8260613          	addi	a2,a2,-894 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203336:	28d00593          	li	a1,653
ffffffffc020333a:	00009517          	auipc	a0,0x9
ffffffffc020333e:	8ae50513          	addi	a0,a0,-1874 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203342:	95cfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203346:	86a2                	mv	a3,s0
ffffffffc0203348:	00008617          	auipc	a2,0x8
ffffffffc020334c:	78860613          	addi	a2,a2,1928 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0203350:	28d00593          	li	a1,653
ffffffffc0203354:	00009517          	auipc	a0,0x9
ffffffffc0203358:	89450513          	addi	a0,a0,-1900 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020335c:	942fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203360:	00009697          	auipc	a3,0x9
ffffffffc0203364:	d9068693          	addi	a3,a3,-624 # ffffffffc020c0f0 <default_pmm_manager+0x658>
ffffffffc0203368:	00008617          	auipc	a2,0x8
ffffffffc020336c:	c4860613          	addi	a2,a2,-952 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203370:	28e00593          	li	a1,654
ffffffffc0203374:	00009517          	auipc	a0,0x9
ffffffffc0203378:	87450513          	addi	a0,a0,-1932 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020337c:	922fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203380:	db5fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203384:	00009697          	auipc	a3,0x9
ffffffffc0203388:	b9468693          	addi	a3,a3,-1132 # ffffffffc020bf18 <default_pmm_manager+0x480>
ffffffffc020338c:	00008617          	auipc	a2,0x8
ffffffffc0203390:	c2460613          	addi	a2,a2,-988 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203394:	26a00593          	li	a1,618
ffffffffc0203398:	00009517          	auipc	a0,0x9
ffffffffc020339c:	85050513          	addi	a0,a0,-1968 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02033a0:	8fefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033a4:	00009697          	auipc	a3,0x9
ffffffffc02033a8:	dd468693          	addi	a3,a3,-556 # ffffffffc020c178 <default_pmm_manager+0x6e0>
ffffffffc02033ac:	00008617          	auipc	a2,0x8
ffffffffc02033b0:	c0460613          	addi	a2,a2,-1020 # ffffffffc020afb0 <commands+0x210>
ffffffffc02033b4:	29700593          	li	a1,663
ffffffffc02033b8:	00009517          	auipc	a0,0x9
ffffffffc02033bc:	83050513          	addi	a0,a0,-2000 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02033c0:	8defd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033c4:	00009697          	auipc	a3,0x9
ffffffffc02033c8:	c7468693          	addi	a3,a3,-908 # ffffffffc020c038 <default_pmm_manager+0x5a0>
ffffffffc02033cc:	00008617          	auipc	a2,0x8
ffffffffc02033d0:	be460613          	addi	a2,a2,-1052 # ffffffffc020afb0 <commands+0x210>
ffffffffc02033d4:	27600593          	li	a1,630
ffffffffc02033d8:	00009517          	auipc	a0,0x9
ffffffffc02033dc:	81050513          	addi	a0,a0,-2032 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02033e0:	8befd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033e4:	00009697          	auipc	a3,0x9
ffffffffc02033e8:	c2468693          	addi	a3,a3,-988 # ffffffffc020c008 <default_pmm_manager+0x570>
ffffffffc02033ec:	00008617          	auipc	a2,0x8
ffffffffc02033f0:	bc460613          	addi	a2,a2,-1084 # ffffffffc020afb0 <commands+0x210>
ffffffffc02033f4:	26c00593          	li	a1,620
ffffffffc02033f8:	00008517          	auipc	a0,0x8
ffffffffc02033fc:	7f050513          	addi	a0,a0,2032 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203400:	89efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203404:	00009697          	auipc	a3,0x9
ffffffffc0203408:	a7468693          	addi	a3,a3,-1420 # ffffffffc020be78 <default_pmm_manager+0x3e0>
ffffffffc020340c:	00008617          	auipc	a2,0x8
ffffffffc0203410:	ba460613          	addi	a2,a2,-1116 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203414:	26b00593          	li	a1,619
ffffffffc0203418:	00008517          	auipc	a0,0x8
ffffffffc020341c:	7d050513          	addi	a0,a0,2000 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203420:	87efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203424:	00009697          	auipc	a3,0x9
ffffffffc0203428:	bcc68693          	addi	a3,a3,-1076 # ffffffffc020bff0 <default_pmm_manager+0x558>
ffffffffc020342c:	00008617          	auipc	a2,0x8
ffffffffc0203430:	b8460613          	addi	a2,a2,-1148 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203434:	27000593          	li	a1,624
ffffffffc0203438:	00008517          	auipc	a0,0x8
ffffffffc020343c:	7b050513          	addi	a0,a0,1968 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203440:	85efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203444:	00009697          	auipc	a3,0x9
ffffffffc0203448:	a4c68693          	addi	a3,a3,-1460 # ffffffffc020be90 <default_pmm_manager+0x3f8>
ffffffffc020344c:	00008617          	auipc	a2,0x8
ffffffffc0203450:	b6460613          	addi	a2,a2,-1180 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203454:	26f00593          	li	a1,623
ffffffffc0203458:	00008517          	auipc	a0,0x8
ffffffffc020345c:	79050513          	addi	a0,a0,1936 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203460:	83efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203464:	00009697          	auipc	a3,0x9
ffffffffc0203468:	ca468693          	addi	a3,a3,-860 # ffffffffc020c108 <default_pmm_manager+0x670>
ffffffffc020346c:	00008617          	auipc	a2,0x8
ffffffffc0203470:	b4460613          	addi	a2,a2,-1212 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203474:	29100593          	li	a1,657
ffffffffc0203478:	00008517          	auipc	a0,0x8
ffffffffc020347c:	77050513          	addi	a0,a0,1904 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203480:	81efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203484:	00009697          	auipc	a3,0x9
ffffffffc0203488:	cdc68693          	addi	a3,a3,-804 # ffffffffc020c160 <default_pmm_manager+0x6c8>
ffffffffc020348c:	00008617          	auipc	a2,0x8
ffffffffc0203490:	b2460613          	addi	a2,a2,-1244 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203494:	29600593          	li	a1,662
ffffffffc0203498:	00008517          	auipc	a0,0x8
ffffffffc020349c:	75050513          	addi	a0,a0,1872 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02034a0:	ffffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034a4:	00009697          	auipc	a3,0x9
ffffffffc02034a8:	c7c68693          	addi	a3,a3,-900 # ffffffffc020c120 <default_pmm_manager+0x688>
ffffffffc02034ac:	00008617          	auipc	a2,0x8
ffffffffc02034b0:	b0460613          	addi	a2,a2,-1276 # ffffffffc020afb0 <commands+0x210>
ffffffffc02034b4:	29500593          	li	a1,661
ffffffffc02034b8:	00008517          	auipc	a0,0x8
ffffffffc02034bc:	73050513          	addi	a0,a0,1840 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02034c0:	fdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034c4:	00009697          	auipc	a3,0x9
ffffffffc02034c8:	d6468693          	addi	a3,a3,-668 # ffffffffc020c228 <default_pmm_manager+0x790>
ffffffffc02034cc:	00008617          	auipc	a2,0x8
ffffffffc02034d0:	ae460613          	addi	a2,a2,-1308 # ffffffffc020afb0 <commands+0x210>
ffffffffc02034d4:	29f00593          	li	a1,671
ffffffffc02034d8:	00008517          	auipc	a0,0x8
ffffffffc02034dc:	71050513          	addi	a0,a0,1808 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02034e0:	fbffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034e4:	00009697          	auipc	a3,0x9
ffffffffc02034e8:	d0c68693          	addi	a3,a3,-756 # ffffffffc020c1f0 <default_pmm_manager+0x758>
ffffffffc02034ec:	00008617          	auipc	a2,0x8
ffffffffc02034f0:	ac460613          	addi	a2,a2,-1340 # ffffffffc020afb0 <commands+0x210>
ffffffffc02034f4:	29c00593          	li	a1,668
ffffffffc02034f8:	00008517          	auipc	a0,0x8
ffffffffc02034fc:	6f050513          	addi	a0,a0,1776 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	00009697          	auipc	a3,0x9
ffffffffc0203508:	cbc68693          	addi	a3,a3,-836 # ffffffffc020c1c0 <default_pmm_manager+0x728>
ffffffffc020350c:	00008617          	auipc	a2,0x8
ffffffffc0203510:	aa460613          	addi	a2,a2,-1372 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203514:	29800593          	li	a1,664
ffffffffc0203518:	00008517          	auipc	a0,0x8
ffffffffc020351c:	6d050513          	addi	a0,a0,1744 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203520:	f7ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203524:	86a2                	mv	a3,s0
ffffffffc0203526:	00008617          	auipc	a2,0x8
ffffffffc020352a:	65260613          	addi	a2,a2,1618 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc020352e:	0dc00593          	li	a1,220
ffffffffc0203532:	00008517          	auipc	a0,0x8
ffffffffc0203536:	6b650513          	addi	a0,a0,1718 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	86ae                	mv	a3,a1
ffffffffc0203540:	00008617          	auipc	a2,0x8
ffffffffc0203544:	63860613          	addi	a2,a2,1592 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0203548:	0db00593          	li	a1,219
ffffffffc020354c:	00008517          	auipc	a0,0x8
ffffffffc0203550:	69c50513          	addi	a0,a0,1692 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	00009697          	auipc	a3,0x9
ffffffffc020355c:	85068693          	addi	a3,a3,-1968 # ffffffffc020bda8 <default_pmm_manager+0x310>
ffffffffc0203560:	00008617          	auipc	a2,0x8
ffffffffc0203564:	a5060613          	addi	a2,a2,-1456 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203568:	24f00593          	li	a1,591
ffffffffc020356c:	00008517          	auipc	a0,0x8
ffffffffc0203570:	67c50513          	addi	a0,a0,1660 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	00009697          	auipc	a3,0x9
ffffffffc020357c:	81068693          	addi	a3,a3,-2032 # ffffffffc020bd88 <default_pmm_manager+0x2f0>
ffffffffc0203580:	00008617          	auipc	a2,0x8
ffffffffc0203584:	a3060613          	addi	a2,a2,-1488 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203588:	24e00593          	li	a1,590
ffffffffc020358c:	00008517          	auipc	a0,0x8
ffffffffc0203590:	65c50513          	addi	a0,a0,1628 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	00008617          	auipc	a2,0x8
ffffffffc020359c:	78060613          	addi	a2,a2,1920 # ffffffffc020bd18 <default_pmm_manager+0x280>
ffffffffc02035a0:	0aa00593          	li	a1,170
ffffffffc02035a4:	00008517          	auipc	a0,0x8
ffffffffc02035a8:	64450513          	addi	a0,a0,1604 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02035ac:	ef3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b0:	00008617          	auipc	a2,0x8
ffffffffc02035b4:	6d060613          	addi	a2,a2,1744 # ffffffffc020bc80 <default_pmm_manager+0x1e8>
ffffffffc02035b8:	06500593          	li	a1,101
ffffffffc02035bc:	00008517          	auipc	a0,0x8
ffffffffc02035c0:	62c50513          	addi	a0,a0,1580 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02035c4:	edbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c8:	00009697          	auipc	a3,0x9
ffffffffc02035cc:	aa068693          	addi	a3,a3,-1376 # ffffffffc020c068 <default_pmm_manager+0x5d0>
ffffffffc02035d0:	00008617          	auipc	a2,0x8
ffffffffc02035d4:	9e060613          	addi	a2,a2,-1568 # ffffffffc020afb0 <commands+0x210>
ffffffffc02035d8:	2a800593          	li	a1,680
ffffffffc02035dc:	00008517          	auipc	a0,0x8
ffffffffc02035e0:	60c50513          	addi	a0,a0,1548 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02035e4:	ebbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e8:	00009697          	auipc	a3,0x9
ffffffffc02035ec:	8c068693          	addi	a3,a3,-1856 # ffffffffc020bea8 <default_pmm_manager+0x410>
ffffffffc02035f0:	00008617          	auipc	a2,0x8
ffffffffc02035f4:	9c060613          	addi	a2,a2,-1600 # ffffffffc020afb0 <commands+0x210>
ffffffffc02035f8:	25d00593          	li	a1,605
ffffffffc02035fc:	00008517          	auipc	a0,0x8
ffffffffc0203600:	5ec50513          	addi	a0,a0,1516 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203604:	e9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203608:	86d6                	mv	a3,s5
ffffffffc020360a:	00008617          	auipc	a2,0x8
ffffffffc020360e:	4c660613          	addi	a2,a2,1222 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0203612:	25c00593          	li	a1,604
ffffffffc0203616:	00008517          	auipc	a0,0x8
ffffffffc020361a:	5d250513          	addi	a0,a0,1490 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00009697          	auipc	a3,0x9
ffffffffc0203626:	9ce68693          	addi	a3,a3,-1586 # ffffffffc020bff0 <default_pmm_manager+0x558>
ffffffffc020362a:	00008617          	auipc	a2,0x8
ffffffffc020362e:	98660613          	addi	a2,a2,-1658 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203632:	26900593          	li	a1,617
ffffffffc0203636:	00008517          	auipc	a0,0x8
ffffffffc020363a:	5b250513          	addi	a0,a0,1458 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00009697          	auipc	a3,0x9
ffffffffc0203646:	99668693          	addi	a3,a3,-1642 # ffffffffc020bfd8 <default_pmm_manager+0x540>
ffffffffc020364a:	00008617          	auipc	a2,0x8
ffffffffc020364e:	96660613          	addi	a2,a2,-1690 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203652:	26800593          	li	a1,616
ffffffffc0203656:	00008517          	auipc	a0,0x8
ffffffffc020365a:	59250513          	addi	a0,a0,1426 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00009697          	auipc	a3,0x9
ffffffffc0203666:	94668693          	addi	a3,a3,-1722 # ffffffffc020bfa8 <default_pmm_manager+0x510>
ffffffffc020366a:	00008617          	auipc	a2,0x8
ffffffffc020366e:	94660613          	addi	a2,a2,-1722 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203672:	26700593          	li	a1,615
ffffffffc0203676:	00008517          	auipc	a0,0x8
ffffffffc020367a:	57250513          	addi	a0,a0,1394 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00009697          	auipc	a3,0x9
ffffffffc0203686:	90e68693          	addi	a3,a3,-1778 # ffffffffc020bf90 <default_pmm_manager+0x4f8>
ffffffffc020368a:	00008617          	auipc	a2,0x8
ffffffffc020368e:	92660613          	addi	a2,a2,-1754 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203692:	26500593          	li	a1,613
ffffffffc0203696:	00008517          	auipc	a0,0x8
ffffffffc020369a:	55250513          	addi	a0,a0,1362 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00009697          	auipc	a3,0x9
ffffffffc02036a6:	8ce68693          	addi	a3,a3,-1842 # ffffffffc020bf70 <default_pmm_manager+0x4d8>
ffffffffc02036aa:	00008617          	auipc	a2,0x8
ffffffffc02036ae:	90660613          	addi	a2,a2,-1786 # ffffffffc020afb0 <commands+0x210>
ffffffffc02036b2:	26400593          	li	a1,612
ffffffffc02036b6:	00008517          	auipc	a0,0x8
ffffffffc02036ba:	53250513          	addi	a0,a0,1330 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00009697          	auipc	a3,0x9
ffffffffc02036c6:	89e68693          	addi	a3,a3,-1890 # ffffffffc020bf60 <default_pmm_manager+0x4c8>
ffffffffc02036ca:	00008617          	auipc	a2,0x8
ffffffffc02036ce:	8e660613          	addi	a2,a2,-1818 # ffffffffc020afb0 <commands+0x210>
ffffffffc02036d2:	26300593          	li	a1,611
ffffffffc02036d6:	00008517          	auipc	a0,0x8
ffffffffc02036da:	51250513          	addi	a0,a0,1298 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	00009697          	auipc	a3,0x9
ffffffffc02036e6:	86e68693          	addi	a3,a3,-1938 # ffffffffc020bf50 <default_pmm_manager+0x4b8>
ffffffffc02036ea:	00008617          	auipc	a2,0x8
ffffffffc02036ee:	8c660613          	addi	a2,a2,-1850 # ffffffffc020afb0 <commands+0x210>
ffffffffc02036f2:	26200593          	li	a1,610
ffffffffc02036f6:	00008517          	auipc	a0,0x8
ffffffffc02036fa:	4f250513          	addi	a0,a0,1266 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02036fe:	da1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203702:	00009697          	auipc	a3,0x9
ffffffffc0203706:	81668693          	addi	a3,a3,-2026 # ffffffffc020bf18 <default_pmm_manager+0x480>
ffffffffc020370a:	00008617          	auipc	a2,0x8
ffffffffc020370e:	8a660613          	addi	a2,a2,-1882 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203712:	26100593          	li	a1,609
ffffffffc0203716:	00008517          	auipc	a0,0x8
ffffffffc020371a:	4d250513          	addi	a0,a0,1234 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020371e:	d81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203722:	00009697          	auipc	a3,0x9
ffffffffc0203726:	94668693          	addi	a3,a3,-1722 # ffffffffc020c068 <default_pmm_manager+0x5d0>
ffffffffc020372a:	00008617          	auipc	a2,0x8
ffffffffc020372e:	88660613          	addi	a2,a2,-1914 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203732:	27e00593          	li	a1,638
ffffffffc0203736:	00008517          	auipc	a0,0x8
ffffffffc020373a:	4b250513          	addi	a0,a0,1202 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020373e:	d61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203742:	00008617          	auipc	a2,0x8
ffffffffc0203746:	38e60613          	addi	a2,a2,910 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc020374a:	07100593          	li	a1,113
ffffffffc020374e:	00008517          	auipc	a0,0x8
ffffffffc0203752:	3aa50513          	addi	a0,a0,938 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0203756:	d49fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020375a:	86a2                	mv	a3,s0
ffffffffc020375c:	00008617          	auipc	a2,0x8
ffffffffc0203760:	41c60613          	addi	a2,a2,1052 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0203764:	0ca00593          	li	a1,202
ffffffffc0203768:	00008517          	auipc	a0,0x8
ffffffffc020376c:	48050513          	addi	a0,a0,1152 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203770:	d2ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203774:	00008617          	auipc	a2,0x8
ffffffffc0203778:	40460613          	addi	a2,a2,1028 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc020377c:	08100593          	li	a1,129
ffffffffc0203780:	00008517          	auipc	a0,0x8
ffffffffc0203784:	46850513          	addi	a0,a0,1128 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203788:	d17fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020378c:	00008697          	auipc	a3,0x8
ffffffffc0203790:	74c68693          	addi	a3,a3,1868 # ffffffffc020bed8 <default_pmm_manager+0x440>
ffffffffc0203794:	00008617          	auipc	a2,0x8
ffffffffc0203798:	81c60613          	addi	a2,a2,-2020 # ffffffffc020afb0 <commands+0x210>
ffffffffc020379c:	26000593          	li	a1,608
ffffffffc02037a0:	00008517          	auipc	a0,0x8
ffffffffc02037a4:	44850513          	addi	a0,a0,1096 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02037a8:	cf7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ac:	00008697          	auipc	a3,0x8
ffffffffc02037b0:	66c68693          	addi	a3,a3,1644 # ffffffffc020be18 <default_pmm_manager+0x380>
ffffffffc02037b4:	00007617          	auipc	a2,0x7
ffffffffc02037b8:	7fc60613          	addi	a2,a2,2044 # ffffffffc020afb0 <commands+0x210>
ffffffffc02037bc:	25400593          	li	a1,596
ffffffffc02037c0:	00008517          	auipc	a0,0x8
ffffffffc02037c4:	42850513          	addi	a0,a0,1064 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02037c8:	cd7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037cc:	985fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc02037d0:	00008697          	auipc	a3,0x8
ffffffffc02037d4:	67868693          	addi	a3,a3,1656 # ffffffffc020be48 <default_pmm_manager+0x3b0>
ffffffffc02037d8:	00007617          	auipc	a2,0x7
ffffffffc02037dc:	7d860613          	addi	a2,a2,2008 # ffffffffc020afb0 <commands+0x210>
ffffffffc02037e0:	25700593          	li	a1,599
ffffffffc02037e4:	00008517          	auipc	a0,0x8
ffffffffc02037e8:	40450513          	addi	a0,a0,1028 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02037ec:	cb3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037f0:	00008697          	auipc	a3,0x8
ffffffffc02037f4:	5f868693          	addi	a3,a3,1528 # ffffffffc020bde8 <default_pmm_manager+0x350>
ffffffffc02037f8:	00007617          	auipc	a2,0x7
ffffffffc02037fc:	7b860613          	addi	a2,a2,1976 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203800:	25000593          	li	a1,592
ffffffffc0203804:	00008517          	auipc	a0,0x8
ffffffffc0203808:	3e450513          	addi	a0,a0,996 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020380c:	c93fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203810:	00008697          	auipc	a3,0x8
ffffffffc0203814:	66868693          	addi	a3,a3,1640 # ffffffffc020be78 <default_pmm_manager+0x3e0>
ffffffffc0203818:	00007617          	auipc	a2,0x7
ffffffffc020381c:	79860613          	addi	a2,a2,1944 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203820:	25800593          	li	a1,600
ffffffffc0203824:	00008517          	auipc	a0,0x8
ffffffffc0203828:	3c450513          	addi	a0,a0,964 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020382c:	c73fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203830:	00008617          	auipc	a2,0x8
ffffffffc0203834:	2a060613          	addi	a2,a2,672 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0203838:	25b00593          	li	a1,603
ffffffffc020383c:	00008517          	auipc	a0,0x8
ffffffffc0203840:	3ac50513          	addi	a0,a0,940 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203844:	c5bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203848:	00008697          	auipc	a3,0x8
ffffffffc020384c:	64868693          	addi	a3,a3,1608 # ffffffffc020be90 <default_pmm_manager+0x3f8>
ffffffffc0203850:	00007617          	auipc	a2,0x7
ffffffffc0203854:	76060613          	addi	a2,a2,1888 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203858:	25900593          	li	a1,601
ffffffffc020385c:	00008517          	auipc	a0,0x8
ffffffffc0203860:	38c50513          	addi	a0,a0,908 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203864:	c3bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203868:	86ca                	mv	a3,s2
ffffffffc020386a:	00008617          	auipc	a2,0x8
ffffffffc020386e:	30e60613          	addi	a2,a2,782 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0203872:	0c600593          	li	a1,198
ffffffffc0203876:	00008517          	auipc	a0,0x8
ffffffffc020387a:	37250513          	addi	a0,a0,882 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020387e:	c21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203882:	00008697          	auipc	a3,0x8
ffffffffc0203886:	76e68693          	addi	a3,a3,1902 # ffffffffc020bff0 <default_pmm_manager+0x558>
ffffffffc020388a:	00007617          	auipc	a2,0x7
ffffffffc020388e:	72660613          	addi	a2,a2,1830 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203892:	27400593          	li	a1,628
ffffffffc0203896:	00008517          	auipc	a0,0x8
ffffffffc020389a:	35250513          	addi	a0,a0,850 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc020389e:	c01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a2:	00008697          	auipc	a3,0x8
ffffffffc02038a6:	77e68693          	addi	a3,a3,1918 # ffffffffc020c020 <default_pmm_manager+0x588>
ffffffffc02038aa:	00007617          	auipc	a2,0x7
ffffffffc02038ae:	70660613          	addi	a2,a2,1798 # ffffffffc020afb0 <commands+0x210>
ffffffffc02038b2:	27300593          	li	a1,627
ffffffffc02038b6:	00008517          	auipc	a0,0x8
ffffffffc02038ba:	33250513          	addi	a0,a0,818 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc02038be:	be1fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038c2 <copy_range>:
ffffffffc02038c2:	7159                	addi	sp,sp,-112
ffffffffc02038c4:	00d667b3          	or	a5,a2,a3
ffffffffc02038c8:	f486                	sd	ra,104(sp)
ffffffffc02038ca:	f0a2                	sd	s0,96(sp)
ffffffffc02038cc:	eca6                	sd	s1,88(sp)
ffffffffc02038ce:	e8ca                	sd	s2,80(sp)
ffffffffc02038d0:	e4ce                	sd	s3,72(sp)
ffffffffc02038d2:	e0d2                	sd	s4,64(sp)
ffffffffc02038d4:	fc56                	sd	s5,56(sp)
ffffffffc02038d6:	f85a                	sd	s6,48(sp)
ffffffffc02038d8:	f45e                	sd	s7,40(sp)
ffffffffc02038da:	f062                	sd	s8,32(sp)
ffffffffc02038dc:	ec66                	sd	s9,24(sp)
ffffffffc02038de:	e86a                	sd	s10,16(sp)
ffffffffc02038e0:	e46e                	sd	s11,8(sp)
ffffffffc02038e2:	17d2                	slli	a5,a5,0x34
ffffffffc02038e4:	20079f63          	bnez	a5,ffffffffc0203b02 <copy_range+0x240>
ffffffffc02038e8:	002007b7          	lui	a5,0x200
ffffffffc02038ec:	8432                	mv	s0,a2
ffffffffc02038ee:	1af66263          	bltu	a2,a5,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc02038f2:	8936                	mv	s2,a3
ffffffffc02038f4:	18d67f63          	bgeu	a2,a3,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc02038f8:	4785                	li	a5,1
ffffffffc02038fa:	07fe                	slli	a5,a5,0x1f
ffffffffc02038fc:	18d7eb63          	bltu	a5,a3,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc0203900:	5b7d                	li	s6,-1
ffffffffc0203902:	8aaa                	mv	s5,a0
ffffffffc0203904:	89ae                	mv	s3,a1
ffffffffc0203906:	6a05                	lui	s4,0x1
ffffffffc0203908:	00092c17          	auipc	s8,0x92
ffffffffc020390c:	f98c0c13          	addi	s8,s8,-104 # ffffffffc02958a0 <npage>
ffffffffc0203910:	00092b97          	auipc	s7,0x92
ffffffffc0203914:	f98b8b93          	addi	s7,s7,-104 # ffffffffc02958a8 <pages>
ffffffffc0203918:	00cb5b13          	srli	s6,s6,0xc
ffffffffc020391c:	00092c97          	auipc	s9,0x92
ffffffffc0203920:	f94c8c93          	addi	s9,s9,-108 # ffffffffc02958b0 <pmm_manager>
ffffffffc0203924:	4601                	li	a2,0
ffffffffc0203926:	85a2                	mv	a1,s0
ffffffffc0203928:	854e                	mv	a0,s3
ffffffffc020392a:	8fbfe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020392e:	84aa                	mv	s1,a0
ffffffffc0203930:	0e050c63          	beqz	a0,ffffffffc0203a28 <copy_range+0x166>
ffffffffc0203934:	611c                	ld	a5,0(a0)
ffffffffc0203936:	8b85                	andi	a5,a5,1
ffffffffc0203938:	e785                	bnez	a5,ffffffffc0203960 <copy_range+0x9e>
ffffffffc020393a:	9452                	add	s0,s0,s4
ffffffffc020393c:	ff2464e3          	bltu	s0,s2,ffffffffc0203924 <copy_range+0x62>
ffffffffc0203940:	4501                	li	a0,0
ffffffffc0203942:	70a6                	ld	ra,104(sp)
ffffffffc0203944:	7406                	ld	s0,96(sp)
ffffffffc0203946:	64e6                	ld	s1,88(sp)
ffffffffc0203948:	6946                	ld	s2,80(sp)
ffffffffc020394a:	69a6                	ld	s3,72(sp)
ffffffffc020394c:	6a06                	ld	s4,64(sp)
ffffffffc020394e:	7ae2                	ld	s5,56(sp)
ffffffffc0203950:	7b42                	ld	s6,48(sp)
ffffffffc0203952:	7ba2                	ld	s7,40(sp)
ffffffffc0203954:	7c02                	ld	s8,32(sp)
ffffffffc0203956:	6ce2                	ld	s9,24(sp)
ffffffffc0203958:	6d42                	ld	s10,16(sp)
ffffffffc020395a:	6da2                	ld	s11,8(sp)
ffffffffc020395c:	6165                	addi	sp,sp,112
ffffffffc020395e:	8082                	ret
ffffffffc0203960:	4605                	li	a2,1
ffffffffc0203962:	85a2                	mv	a1,s0
ffffffffc0203964:	8556                	mv	a0,s5
ffffffffc0203966:	8bffe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020396a:	c56d                	beqz	a0,ffffffffc0203a54 <copy_range+0x192>
ffffffffc020396c:	609c                	ld	a5,0(s1)
ffffffffc020396e:	0017f713          	andi	a4,a5,1
ffffffffc0203972:	01f7f493          	andi	s1,a5,31
ffffffffc0203976:	16070a63          	beqz	a4,ffffffffc0203aea <copy_range+0x228>
ffffffffc020397a:	000c3683          	ld	a3,0(s8)
ffffffffc020397e:	078a                	slli	a5,a5,0x2
ffffffffc0203980:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203984:	14d77763          	bgeu	a4,a3,ffffffffc0203ad2 <copy_range+0x210>
ffffffffc0203988:	000bb783          	ld	a5,0(s7)
ffffffffc020398c:	fff806b7          	lui	a3,0xfff80
ffffffffc0203990:	9736                	add	a4,a4,a3
ffffffffc0203992:	071a                	slli	a4,a4,0x6
ffffffffc0203994:	00e78db3          	add	s11,a5,a4
ffffffffc0203998:	10002773          	csrr	a4,sstatus
ffffffffc020399c:	8b09                	andi	a4,a4,2
ffffffffc020399e:	e345                	bnez	a4,ffffffffc0203a3e <copy_range+0x17c>
ffffffffc02039a0:	000cb703          	ld	a4,0(s9)
ffffffffc02039a4:	4505                	li	a0,1
ffffffffc02039a6:	6f18                	ld	a4,24(a4)
ffffffffc02039a8:	9702                	jalr	a4
ffffffffc02039aa:	8d2a                	mv	s10,a0
ffffffffc02039ac:	0c0d8363          	beqz	s11,ffffffffc0203a72 <copy_range+0x1b0>
ffffffffc02039b0:	100d0163          	beqz	s10,ffffffffc0203ab2 <copy_range+0x1f0>
ffffffffc02039b4:	000bb703          	ld	a4,0(s7)
ffffffffc02039b8:	000805b7          	lui	a1,0x80
ffffffffc02039bc:	000c3603          	ld	a2,0(s8)
ffffffffc02039c0:	40ed86b3          	sub	a3,s11,a4
ffffffffc02039c4:	8699                	srai	a3,a3,0x6
ffffffffc02039c6:	96ae                	add	a3,a3,a1
ffffffffc02039c8:	0166f7b3          	and	a5,a3,s6
ffffffffc02039cc:	06b2                	slli	a3,a3,0xc
ffffffffc02039ce:	08c7f663          	bgeu	a5,a2,ffffffffc0203a5a <copy_range+0x198>
ffffffffc02039d2:	40ed07b3          	sub	a5,s10,a4
ffffffffc02039d6:	00092717          	auipc	a4,0x92
ffffffffc02039da:	ee270713          	addi	a4,a4,-286 # ffffffffc02958b8 <va_pa_offset>
ffffffffc02039de:	6308                	ld	a0,0(a4)
ffffffffc02039e0:	8799                	srai	a5,a5,0x6
ffffffffc02039e2:	97ae                	add	a5,a5,a1
ffffffffc02039e4:	0167f733          	and	a4,a5,s6
ffffffffc02039e8:	00a685b3          	add	a1,a3,a0
ffffffffc02039ec:	07b2                	slli	a5,a5,0xc
ffffffffc02039ee:	06c77563          	bgeu	a4,a2,ffffffffc0203a58 <copy_range+0x196>
ffffffffc02039f2:	6605                	lui	a2,0x1
ffffffffc02039f4:	953e                	add	a0,a0,a5
ffffffffc02039f6:	12a070ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc02039fa:	86a6                	mv	a3,s1
ffffffffc02039fc:	8622                	mv	a2,s0
ffffffffc02039fe:	85ea                	mv	a1,s10
ffffffffc0203a00:	8556                	mv	a0,s5
ffffffffc0203a02:	fd9fe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203a06:	d915                	beqz	a0,ffffffffc020393a <copy_range+0x78>
ffffffffc0203a08:	00009697          	auipc	a3,0x9
ffffffffc0203a0c:	88868693          	addi	a3,a3,-1912 # ffffffffc020c290 <default_pmm_manager+0x7f8>
ffffffffc0203a10:	00007617          	auipc	a2,0x7
ffffffffc0203a14:	5a060613          	addi	a2,a2,1440 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203a18:	1ec00593          	li	a1,492
ffffffffc0203a1c:	00008517          	auipc	a0,0x8
ffffffffc0203a20:	1cc50513          	addi	a0,a0,460 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203a24:	a7bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a28:	00200637          	lui	a2,0x200
ffffffffc0203a2c:	9432                	add	s0,s0,a2
ffffffffc0203a2e:	ffe00637          	lui	a2,0xffe00
ffffffffc0203a32:	8c71                	and	s0,s0,a2
ffffffffc0203a34:	f00406e3          	beqz	s0,ffffffffc0203940 <copy_range+0x7e>
ffffffffc0203a38:	ef2466e3          	bltu	s0,s2,ffffffffc0203924 <copy_range+0x62>
ffffffffc0203a3c:	b711                	j	ffffffffc0203940 <copy_range+0x7e>
ffffffffc0203a3e:	a34fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203a42:	000cb703          	ld	a4,0(s9)
ffffffffc0203a46:	4505                	li	a0,1
ffffffffc0203a48:	6f18                	ld	a4,24(a4)
ffffffffc0203a4a:	9702                	jalr	a4
ffffffffc0203a4c:	8d2a                	mv	s10,a0
ffffffffc0203a4e:	a1efd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203a52:	bfa9                	j	ffffffffc02039ac <copy_range+0xea>
ffffffffc0203a54:	5571                	li	a0,-4
ffffffffc0203a56:	b5f5                	j	ffffffffc0203942 <copy_range+0x80>
ffffffffc0203a58:	86be                	mv	a3,a5
ffffffffc0203a5a:	00008617          	auipc	a2,0x8
ffffffffc0203a5e:	07660613          	addi	a2,a2,118 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0203a62:	07100593          	li	a1,113
ffffffffc0203a66:	00008517          	auipc	a0,0x8
ffffffffc0203a6a:	09250513          	addi	a0,a0,146 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0203a6e:	a31fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a72:	00008697          	auipc	a3,0x8
ffffffffc0203a76:	7fe68693          	addi	a3,a3,2046 # ffffffffc020c270 <default_pmm_manager+0x7d8>
ffffffffc0203a7a:	00007617          	auipc	a2,0x7
ffffffffc0203a7e:	53660613          	addi	a2,a2,1334 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203a82:	1ce00593          	li	a1,462
ffffffffc0203a86:	00008517          	auipc	a0,0x8
ffffffffc0203a8a:	16250513          	addi	a0,a0,354 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203a8e:	a11fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a92:	00008697          	auipc	a3,0x8
ffffffffc0203a96:	1be68693          	addi	a3,a3,446 # ffffffffc020bc50 <default_pmm_manager+0x1b8>
ffffffffc0203a9a:	00007617          	auipc	a2,0x7
ffffffffc0203a9e:	51660613          	addi	a2,a2,1302 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203aa2:	1b600593          	li	a1,438
ffffffffc0203aa6:	00008517          	auipc	a0,0x8
ffffffffc0203aaa:	14250513          	addi	a0,a0,322 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203aae:	9f1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ab2:	00008697          	auipc	a3,0x8
ffffffffc0203ab6:	7ce68693          	addi	a3,a3,1998 # ffffffffc020c280 <default_pmm_manager+0x7e8>
ffffffffc0203aba:	00007617          	auipc	a2,0x7
ffffffffc0203abe:	4f660613          	addi	a2,a2,1270 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203ac2:	1cf00593          	li	a1,463
ffffffffc0203ac6:	00008517          	auipc	a0,0x8
ffffffffc0203aca:	12250513          	addi	a0,a0,290 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203ace:	9d1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ad2:	00008617          	auipc	a2,0x8
ffffffffc0203ad6:	0ce60613          	addi	a2,a2,206 # ffffffffc020bba0 <default_pmm_manager+0x108>
ffffffffc0203ada:	06900593          	li	a1,105
ffffffffc0203ade:	00008517          	auipc	a0,0x8
ffffffffc0203ae2:	01a50513          	addi	a0,a0,26 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0203ae6:	9b9fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203aea:	00008617          	auipc	a2,0x8
ffffffffc0203aee:	0d660613          	addi	a2,a2,214 # ffffffffc020bbc0 <default_pmm_manager+0x128>
ffffffffc0203af2:	07f00593          	li	a1,127
ffffffffc0203af6:	00008517          	auipc	a0,0x8
ffffffffc0203afa:	00250513          	addi	a0,a0,2 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0203afe:	9a1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b02:	00008697          	auipc	a3,0x8
ffffffffc0203b06:	11e68693          	addi	a3,a3,286 # ffffffffc020bc20 <default_pmm_manager+0x188>
ffffffffc0203b0a:	00007617          	auipc	a2,0x7
ffffffffc0203b0e:	4a660613          	addi	a2,a2,1190 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203b12:	1b500593          	li	a1,437
ffffffffc0203b16:	00008517          	auipc	a0,0x8
ffffffffc0203b1a:	0d250513          	addi	a0,a0,210 # ffffffffc020bbe8 <default_pmm_manager+0x150>
ffffffffc0203b1e:	981fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b22 <check_vma_overlap.part.0>:
ffffffffc0203b22:	1141                	addi	sp,sp,-16
ffffffffc0203b24:	00008697          	auipc	a3,0x8
ffffffffc0203b28:	77c68693          	addi	a3,a3,1916 # ffffffffc020c2a0 <default_pmm_manager+0x808>
ffffffffc0203b2c:	00007617          	auipc	a2,0x7
ffffffffc0203b30:	48460613          	addi	a2,a2,1156 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203b34:	07400593          	li	a1,116
ffffffffc0203b38:	00008517          	auipc	a0,0x8
ffffffffc0203b3c:	78850513          	addi	a0,a0,1928 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203b40:	e406                	sd	ra,8(sp)
ffffffffc0203b42:	95dfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b46 <mm_create>:
ffffffffc0203b46:	1141                	addi	sp,sp,-16
ffffffffc0203b48:	05800513          	li	a0,88
ffffffffc0203b4c:	e022                	sd	s0,0(sp)
ffffffffc0203b4e:	e406                	sd	ra,8(sp)
ffffffffc0203b50:	c3efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203b54:	842a                	mv	s0,a0
ffffffffc0203b56:	c115                	beqz	a0,ffffffffc0203b7a <mm_create+0x34>
ffffffffc0203b58:	e408                	sd	a0,8(s0)
ffffffffc0203b5a:	e008                	sd	a0,0(s0)
ffffffffc0203b5c:	00053823          	sd	zero,16(a0)
ffffffffc0203b60:	00053c23          	sd	zero,24(a0)
ffffffffc0203b64:	02052023          	sw	zero,32(a0)
ffffffffc0203b68:	02053423          	sd	zero,40(a0)
ffffffffc0203b6c:	02052823          	sw	zero,48(a0)
ffffffffc0203b70:	4585                	li	a1,1
ffffffffc0203b72:	03850513          	addi	a0,a0,56
ffffffffc0203b76:	073000ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0203b7a:	60a2                	ld	ra,8(sp)
ffffffffc0203b7c:	8522                	mv	a0,s0
ffffffffc0203b7e:	6402                	ld	s0,0(sp)
ffffffffc0203b80:	0141                	addi	sp,sp,16
ffffffffc0203b82:	8082                	ret

ffffffffc0203b84 <find_vma>:
ffffffffc0203b84:	86aa                	mv	a3,a0
ffffffffc0203b86:	c505                	beqz	a0,ffffffffc0203bae <find_vma+0x2a>
ffffffffc0203b88:	6908                	ld	a0,16(a0)
ffffffffc0203b8a:	c501                	beqz	a0,ffffffffc0203b92 <find_vma+0xe>
ffffffffc0203b8c:	651c                	ld	a5,8(a0)
ffffffffc0203b8e:	02f5f263          	bgeu	a1,a5,ffffffffc0203bb2 <find_vma+0x2e>
ffffffffc0203b92:	669c                	ld	a5,8(a3)
ffffffffc0203b94:	00f68d63          	beq	a3,a5,ffffffffc0203bae <find_vma+0x2a>
ffffffffc0203b98:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0203b9c:	00e5e663          	bltu	a1,a4,ffffffffc0203ba8 <find_vma+0x24>
ffffffffc0203ba0:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203ba4:	00e5ec63          	bltu	a1,a4,ffffffffc0203bbc <find_vma+0x38>
ffffffffc0203ba8:	679c                	ld	a5,8(a5)
ffffffffc0203baa:	fef697e3          	bne	a3,a5,ffffffffc0203b98 <find_vma+0x14>
ffffffffc0203bae:	4501                	li	a0,0
ffffffffc0203bb0:	8082                	ret
ffffffffc0203bb2:	691c                	ld	a5,16(a0)
ffffffffc0203bb4:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203b92 <find_vma+0xe>
ffffffffc0203bb8:	ea88                	sd	a0,16(a3)
ffffffffc0203bba:	8082                	ret
ffffffffc0203bbc:	fe078513          	addi	a0,a5,-32
ffffffffc0203bc0:	ea88                	sd	a0,16(a3)
ffffffffc0203bc2:	8082                	ret

ffffffffc0203bc4 <insert_vma_struct>:
ffffffffc0203bc4:	6590                	ld	a2,8(a1)
ffffffffc0203bc6:	0105b803          	ld	a6,16(a1) # 80010 <_binary_bin_sfs_img_size+0xad10>
ffffffffc0203bca:	1141                	addi	sp,sp,-16
ffffffffc0203bcc:	e406                	sd	ra,8(sp)
ffffffffc0203bce:	87aa                	mv	a5,a0
ffffffffc0203bd0:	01066763          	bltu	a2,a6,ffffffffc0203bde <insert_vma_struct+0x1a>
ffffffffc0203bd4:	a085                	j	ffffffffc0203c34 <insert_vma_struct+0x70>
ffffffffc0203bd6:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203bda:	04e66863          	bltu	a2,a4,ffffffffc0203c2a <insert_vma_struct+0x66>
ffffffffc0203bde:	86be                	mv	a3,a5
ffffffffc0203be0:	679c                	ld	a5,8(a5)
ffffffffc0203be2:	fef51ae3          	bne	a0,a5,ffffffffc0203bd6 <insert_vma_struct+0x12>
ffffffffc0203be6:	02a68463          	beq	a3,a0,ffffffffc0203c0e <insert_vma_struct+0x4a>
ffffffffc0203bea:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203bee:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203bf2:	08e8f163          	bgeu	a7,a4,ffffffffc0203c74 <insert_vma_struct+0xb0>
ffffffffc0203bf6:	04e66f63          	bltu	a2,a4,ffffffffc0203c54 <insert_vma_struct+0x90>
ffffffffc0203bfa:	00f50a63          	beq	a0,a5,ffffffffc0203c0e <insert_vma_struct+0x4a>
ffffffffc0203bfe:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203c02:	05076963          	bltu	a4,a6,ffffffffc0203c54 <insert_vma_struct+0x90>
ffffffffc0203c06:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203c0a:	02c77363          	bgeu	a4,a2,ffffffffc0203c30 <insert_vma_struct+0x6c>
ffffffffc0203c0e:	5118                	lw	a4,32(a0)
ffffffffc0203c10:	e188                	sd	a0,0(a1)
ffffffffc0203c12:	02058613          	addi	a2,a1,32
ffffffffc0203c16:	e390                	sd	a2,0(a5)
ffffffffc0203c18:	e690                	sd	a2,8(a3)
ffffffffc0203c1a:	60a2                	ld	ra,8(sp)
ffffffffc0203c1c:	f59c                	sd	a5,40(a1)
ffffffffc0203c1e:	f194                	sd	a3,32(a1)
ffffffffc0203c20:	0017079b          	addiw	a5,a4,1
ffffffffc0203c24:	d11c                	sw	a5,32(a0)
ffffffffc0203c26:	0141                	addi	sp,sp,16
ffffffffc0203c28:	8082                	ret
ffffffffc0203c2a:	fca690e3          	bne	a3,a0,ffffffffc0203bea <insert_vma_struct+0x26>
ffffffffc0203c2e:	bfd1                	j	ffffffffc0203c02 <insert_vma_struct+0x3e>
ffffffffc0203c30:	ef3ff0ef          	jal	ra,ffffffffc0203b22 <check_vma_overlap.part.0>
ffffffffc0203c34:	00008697          	auipc	a3,0x8
ffffffffc0203c38:	69c68693          	addi	a3,a3,1692 # ffffffffc020c2d0 <default_pmm_manager+0x838>
ffffffffc0203c3c:	00007617          	auipc	a2,0x7
ffffffffc0203c40:	37460613          	addi	a2,a2,884 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203c44:	07a00593          	li	a1,122
ffffffffc0203c48:	00008517          	auipc	a0,0x8
ffffffffc0203c4c:	67850513          	addi	a0,a0,1656 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203c50:	84ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c54:	00008697          	auipc	a3,0x8
ffffffffc0203c58:	6bc68693          	addi	a3,a3,1724 # ffffffffc020c310 <default_pmm_manager+0x878>
ffffffffc0203c5c:	00007617          	auipc	a2,0x7
ffffffffc0203c60:	35460613          	addi	a2,a2,852 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203c64:	07300593          	li	a1,115
ffffffffc0203c68:	00008517          	auipc	a0,0x8
ffffffffc0203c6c:	65850513          	addi	a0,a0,1624 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203c70:	82ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c74:	00008697          	auipc	a3,0x8
ffffffffc0203c78:	67c68693          	addi	a3,a3,1660 # ffffffffc020c2f0 <default_pmm_manager+0x858>
ffffffffc0203c7c:	00007617          	auipc	a2,0x7
ffffffffc0203c80:	33460613          	addi	a2,a2,820 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203c84:	07200593          	li	a1,114
ffffffffc0203c88:	00008517          	auipc	a0,0x8
ffffffffc0203c8c:	63850513          	addi	a0,a0,1592 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203c90:	80ffc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c94 <mm_destroy>:
ffffffffc0203c94:	591c                	lw	a5,48(a0)
ffffffffc0203c96:	1141                	addi	sp,sp,-16
ffffffffc0203c98:	e406                	sd	ra,8(sp)
ffffffffc0203c9a:	e022                	sd	s0,0(sp)
ffffffffc0203c9c:	e78d                	bnez	a5,ffffffffc0203cc6 <mm_destroy+0x32>
ffffffffc0203c9e:	842a                	mv	s0,a0
ffffffffc0203ca0:	6508                	ld	a0,8(a0)
ffffffffc0203ca2:	00a40c63          	beq	s0,a0,ffffffffc0203cba <mm_destroy+0x26>
ffffffffc0203ca6:	6118                	ld	a4,0(a0)
ffffffffc0203ca8:	651c                	ld	a5,8(a0)
ffffffffc0203caa:	1501                	addi	a0,a0,-32
ffffffffc0203cac:	e71c                	sd	a5,8(a4)
ffffffffc0203cae:	e398                	sd	a4,0(a5)
ffffffffc0203cb0:	b8efe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203cb4:	6408                	ld	a0,8(s0)
ffffffffc0203cb6:	fea418e3          	bne	s0,a0,ffffffffc0203ca6 <mm_destroy+0x12>
ffffffffc0203cba:	8522                	mv	a0,s0
ffffffffc0203cbc:	6402                	ld	s0,0(sp)
ffffffffc0203cbe:	60a2                	ld	ra,8(sp)
ffffffffc0203cc0:	0141                	addi	sp,sp,16
ffffffffc0203cc2:	b7cfe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203cc6:	00008697          	auipc	a3,0x8
ffffffffc0203cca:	66a68693          	addi	a3,a3,1642 # ffffffffc020c330 <default_pmm_manager+0x898>
ffffffffc0203cce:	00007617          	auipc	a2,0x7
ffffffffc0203cd2:	2e260613          	addi	a2,a2,738 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203cd6:	09e00593          	li	a1,158
ffffffffc0203cda:	00008517          	auipc	a0,0x8
ffffffffc0203cde:	5e650513          	addi	a0,a0,1510 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203ce2:	fbcfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ce6 <dup_mmap>:
ffffffffc0203ce6:	7139                	addi	sp,sp,-64
ffffffffc0203ce8:	fc06                	sd	ra,56(sp)
ffffffffc0203cea:	f822                	sd	s0,48(sp)
ffffffffc0203cec:	f426                	sd	s1,40(sp)
ffffffffc0203cee:	f04a                	sd	s2,32(sp)
ffffffffc0203cf0:	ec4e                	sd	s3,24(sp)
ffffffffc0203cf2:	e852                	sd	s4,16(sp)
ffffffffc0203cf4:	e456                	sd	s5,8(sp)
ffffffffc0203cf6:	c52d                	beqz	a0,ffffffffc0203d60 <dup_mmap+0x7a>
ffffffffc0203cf8:	892a                	mv	s2,a0
ffffffffc0203cfa:	84ae                	mv	s1,a1
ffffffffc0203cfc:	842e                	mv	s0,a1
ffffffffc0203cfe:	e595                	bnez	a1,ffffffffc0203d2a <dup_mmap+0x44>
ffffffffc0203d00:	a085                	j	ffffffffc0203d60 <dup_mmap+0x7a>
ffffffffc0203d02:	854a                	mv	a0,s2
ffffffffc0203d04:	0155b423          	sd	s5,8(a1)
ffffffffc0203d08:	0145b823          	sd	s4,16(a1)
ffffffffc0203d0c:	0135ac23          	sw	s3,24(a1)
ffffffffc0203d10:	eb5ff0ef          	jal	ra,ffffffffc0203bc4 <insert_vma_struct>
ffffffffc0203d14:	ff043683          	ld	a3,-16(s0)
ffffffffc0203d18:	fe843603          	ld	a2,-24(s0)
ffffffffc0203d1c:	6c8c                	ld	a1,24(s1)
ffffffffc0203d1e:	01893503          	ld	a0,24(s2)
ffffffffc0203d22:	4701                	li	a4,0
ffffffffc0203d24:	b9fff0ef          	jal	ra,ffffffffc02038c2 <copy_range>
ffffffffc0203d28:	e105                	bnez	a0,ffffffffc0203d48 <dup_mmap+0x62>
ffffffffc0203d2a:	6000                	ld	s0,0(s0)
ffffffffc0203d2c:	02848863          	beq	s1,s0,ffffffffc0203d5c <dup_mmap+0x76>
ffffffffc0203d30:	03000513          	li	a0,48
ffffffffc0203d34:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203d38:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203d3c:	ff842983          	lw	s3,-8(s0)
ffffffffc0203d40:	a4efe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203d44:	85aa                	mv	a1,a0
ffffffffc0203d46:	fd55                	bnez	a0,ffffffffc0203d02 <dup_mmap+0x1c>
ffffffffc0203d48:	5571                	li	a0,-4
ffffffffc0203d4a:	70e2                	ld	ra,56(sp)
ffffffffc0203d4c:	7442                	ld	s0,48(sp)
ffffffffc0203d4e:	74a2                	ld	s1,40(sp)
ffffffffc0203d50:	7902                	ld	s2,32(sp)
ffffffffc0203d52:	69e2                	ld	s3,24(sp)
ffffffffc0203d54:	6a42                	ld	s4,16(sp)
ffffffffc0203d56:	6aa2                	ld	s5,8(sp)
ffffffffc0203d58:	6121                	addi	sp,sp,64
ffffffffc0203d5a:	8082                	ret
ffffffffc0203d5c:	4501                	li	a0,0
ffffffffc0203d5e:	b7f5                	j	ffffffffc0203d4a <dup_mmap+0x64>
ffffffffc0203d60:	00008697          	auipc	a3,0x8
ffffffffc0203d64:	5f868693          	addi	a3,a3,1528 # ffffffffc020c358 <default_pmm_manager+0x8c0>
ffffffffc0203d68:	00007617          	auipc	a2,0x7
ffffffffc0203d6c:	24860613          	addi	a2,a2,584 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203d70:	0cf00593          	li	a1,207
ffffffffc0203d74:	00008517          	auipc	a0,0x8
ffffffffc0203d78:	54c50513          	addi	a0,a0,1356 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203d7c:	f22fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d80 <exit_mmap>:
ffffffffc0203d80:	1101                	addi	sp,sp,-32
ffffffffc0203d82:	ec06                	sd	ra,24(sp)
ffffffffc0203d84:	e822                	sd	s0,16(sp)
ffffffffc0203d86:	e426                	sd	s1,8(sp)
ffffffffc0203d88:	e04a                	sd	s2,0(sp)
ffffffffc0203d8a:	c531                	beqz	a0,ffffffffc0203dd6 <exit_mmap+0x56>
ffffffffc0203d8c:	591c                	lw	a5,48(a0)
ffffffffc0203d8e:	84aa                	mv	s1,a0
ffffffffc0203d90:	e3b9                	bnez	a5,ffffffffc0203dd6 <exit_mmap+0x56>
ffffffffc0203d92:	6500                	ld	s0,8(a0)
ffffffffc0203d94:	01853903          	ld	s2,24(a0)
ffffffffc0203d98:	02850663          	beq	a0,s0,ffffffffc0203dc4 <exit_mmap+0x44>
ffffffffc0203d9c:	ff043603          	ld	a2,-16(s0)
ffffffffc0203da0:	fe843583          	ld	a1,-24(s0)
ffffffffc0203da4:	854a                	mv	a0,s2
ffffffffc0203da6:	fc0fe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203daa:	6400                	ld	s0,8(s0)
ffffffffc0203dac:	fe8498e3          	bne	s1,s0,ffffffffc0203d9c <exit_mmap+0x1c>
ffffffffc0203db0:	6400                	ld	s0,8(s0)
ffffffffc0203db2:	00848c63          	beq	s1,s0,ffffffffc0203dca <exit_mmap+0x4a>
ffffffffc0203db6:	ff043603          	ld	a2,-16(s0)
ffffffffc0203dba:	fe843583          	ld	a1,-24(s0)
ffffffffc0203dbe:	854a                	mv	a0,s2
ffffffffc0203dc0:	8edfe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203dc4:	6400                	ld	s0,8(s0)
ffffffffc0203dc6:	fe8498e3          	bne	s1,s0,ffffffffc0203db6 <exit_mmap+0x36>
ffffffffc0203dca:	60e2                	ld	ra,24(sp)
ffffffffc0203dcc:	6442                	ld	s0,16(sp)
ffffffffc0203dce:	64a2                	ld	s1,8(sp)
ffffffffc0203dd0:	6902                	ld	s2,0(sp)
ffffffffc0203dd2:	6105                	addi	sp,sp,32
ffffffffc0203dd4:	8082                	ret
ffffffffc0203dd6:	00008697          	auipc	a3,0x8
ffffffffc0203dda:	5a268693          	addi	a3,a3,1442 # ffffffffc020c378 <default_pmm_manager+0x8e0>
ffffffffc0203dde:	00007617          	auipc	a2,0x7
ffffffffc0203de2:	1d260613          	addi	a2,a2,466 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203de6:	0e800593          	li	a1,232
ffffffffc0203dea:	00008517          	auipc	a0,0x8
ffffffffc0203dee:	4d650513          	addi	a0,a0,1238 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203df2:	eacfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203df6 <vmm_init>:
ffffffffc0203df6:	7139                	addi	sp,sp,-64
ffffffffc0203df8:	05800513          	li	a0,88
ffffffffc0203dfc:	fc06                	sd	ra,56(sp)
ffffffffc0203dfe:	f822                	sd	s0,48(sp)
ffffffffc0203e00:	f426                	sd	s1,40(sp)
ffffffffc0203e02:	f04a                	sd	s2,32(sp)
ffffffffc0203e04:	ec4e                	sd	s3,24(sp)
ffffffffc0203e06:	e852                	sd	s4,16(sp)
ffffffffc0203e08:	e456                	sd	s5,8(sp)
ffffffffc0203e0a:	984fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203e0e:	2e050963          	beqz	a0,ffffffffc0204100 <vmm_init+0x30a>
ffffffffc0203e12:	e508                	sd	a0,8(a0)
ffffffffc0203e14:	e108                	sd	a0,0(a0)
ffffffffc0203e16:	00053823          	sd	zero,16(a0)
ffffffffc0203e1a:	00053c23          	sd	zero,24(a0)
ffffffffc0203e1e:	02052023          	sw	zero,32(a0)
ffffffffc0203e22:	02053423          	sd	zero,40(a0)
ffffffffc0203e26:	02052823          	sw	zero,48(a0)
ffffffffc0203e2a:	84aa                	mv	s1,a0
ffffffffc0203e2c:	4585                	li	a1,1
ffffffffc0203e2e:	03850513          	addi	a0,a0,56
ffffffffc0203e32:	5b6000ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0203e36:	03200413          	li	s0,50
ffffffffc0203e3a:	a811                	j	ffffffffc0203e4e <vmm_init+0x58>
ffffffffc0203e3c:	e500                	sd	s0,8(a0)
ffffffffc0203e3e:	e91c                	sd	a5,16(a0)
ffffffffc0203e40:	00052c23          	sw	zero,24(a0)
ffffffffc0203e44:	146d                	addi	s0,s0,-5
ffffffffc0203e46:	8526                	mv	a0,s1
ffffffffc0203e48:	d7dff0ef          	jal	ra,ffffffffc0203bc4 <insert_vma_struct>
ffffffffc0203e4c:	c80d                	beqz	s0,ffffffffc0203e7e <vmm_init+0x88>
ffffffffc0203e4e:	03000513          	li	a0,48
ffffffffc0203e52:	93cfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203e56:	85aa                	mv	a1,a0
ffffffffc0203e58:	00240793          	addi	a5,s0,2
ffffffffc0203e5c:	f165                	bnez	a0,ffffffffc0203e3c <vmm_init+0x46>
ffffffffc0203e5e:	00008697          	auipc	a3,0x8
ffffffffc0203e62:	6b268693          	addi	a3,a3,1714 # ffffffffc020c510 <default_pmm_manager+0xa78>
ffffffffc0203e66:	00007617          	auipc	a2,0x7
ffffffffc0203e6a:	14a60613          	addi	a2,a2,330 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203e6e:	12c00593          	li	a1,300
ffffffffc0203e72:	00008517          	auipc	a0,0x8
ffffffffc0203e76:	44e50513          	addi	a0,a0,1102 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203e7a:	e24fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203e7e:	03700413          	li	s0,55
ffffffffc0203e82:	1f900913          	li	s2,505
ffffffffc0203e86:	a819                	j	ffffffffc0203e9c <vmm_init+0xa6>
ffffffffc0203e88:	e500                	sd	s0,8(a0)
ffffffffc0203e8a:	e91c                	sd	a5,16(a0)
ffffffffc0203e8c:	00052c23          	sw	zero,24(a0)
ffffffffc0203e90:	0415                	addi	s0,s0,5
ffffffffc0203e92:	8526                	mv	a0,s1
ffffffffc0203e94:	d31ff0ef          	jal	ra,ffffffffc0203bc4 <insert_vma_struct>
ffffffffc0203e98:	03240a63          	beq	s0,s2,ffffffffc0203ecc <vmm_init+0xd6>
ffffffffc0203e9c:	03000513          	li	a0,48
ffffffffc0203ea0:	8eefe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203ea4:	85aa                	mv	a1,a0
ffffffffc0203ea6:	00240793          	addi	a5,s0,2
ffffffffc0203eaa:	fd79                	bnez	a0,ffffffffc0203e88 <vmm_init+0x92>
ffffffffc0203eac:	00008697          	auipc	a3,0x8
ffffffffc0203eb0:	66468693          	addi	a3,a3,1636 # ffffffffc020c510 <default_pmm_manager+0xa78>
ffffffffc0203eb4:	00007617          	auipc	a2,0x7
ffffffffc0203eb8:	0fc60613          	addi	a2,a2,252 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203ebc:	13300593          	li	a1,307
ffffffffc0203ec0:	00008517          	auipc	a0,0x8
ffffffffc0203ec4:	40050513          	addi	a0,a0,1024 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203ec8:	dd6fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ecc:	649c                	ld	a5,8(s1)
ffffffffc0203ece:	471d                	li	a4,7
ffffffffc0203ed0:	1fb00593          	li	a1,507
ffffffffc0203ed4:	16f48663          	beq	s1,a5,ffffffffc0204040 <vmm_init+0x24a>
ffffffffc0203ed8:	fe87b603          	ld	a2,-24(a5)
ffffffffc0203edc:	ffe70693          	addi	a3,a4,-2
ffffffffc0203ee0:	10d61063          	bne	a2,a3,ffffffffc0203fe0 <vmm_init+0x1ea>
ffffffffc0203ee4:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203ee8:	0ed71c63          	bne	a4,a3,ffffffffc0203fe0 <vmm_init+0x1ea>
ffffffffc0203eec:	0715                	addi	a4,a4,5
ffffffffc0203eee:	679c                	ld	a5,8(a5)
ffffffffc0203ef0:	feb712e3          	bne	a4,a1,ffffffffc0203ed4 <vmm_init+0xde>
ffffffffc0203ef4:	4a1d                	li	s4,7
ffffffffc0203ef6:	4415                	li	s0,5
ffffffffc0203ef8:	1f900a93          	li	s5,505
ffffffffc0203efc:	85a2                	mv	a1,s0
ffffffffc0203efe:	8526                	mv	a0,s1
ffffffffc0203f00:	c85ff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0203f04:	892a                	mv	s2,a0
ffffffffc0203f06:	16050d63          	beqz	a0,ffffffffc0204080 <vmm_init+0x28a>
ffffffffc0203f0a:	00140593          	addi	a1,s0,1
ffffffffc0203f0e:	8526                	mv	a0,s1
ffffffffc0203f10:	c75ff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0203f14:	89aa                	mv	s3,a0
ffffffffc0203f16:	14050563          	beqz	a0,ffffffffc0204060 <vmm_init+0x26a>
ffffffffc0203f1a:	85d2                	mv	a1,s4
ffffffffc0203f1c:	8526                	mv	a0,s1
ffffffffc0203f1e:	c67ff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0203f22:	16051f63          	bnez	a0,ffffffffc02040a0 <vmm_init+0x2aa>
ffffffffc0203f26:	00340593          	addi	a1,s0,3
ffffffffc0203f2a:	8526                	mv	a0,s1
ffffffffc0203f2c:	c59ff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0203f30:	1a051863          	bnez	a0,ffffffffc02040e0 <vmm_init+0x2ea>
ffffffffc0203f34:	00440593          	addi	a1,s0,4
ffffffffc0203f38:	8526                	mv	a0,s1
ffffffffc0203f3a:	c4bff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0203f3e:	18051163          	bnez	a0,ffffffffc02040c0 <vmm_init+0x2ca>
ffffffffc0203f42:	00893783          	ld	a5,8(s2)
ffffffffc0203f46:	0a879d63          	bne	a5,s0,ffffffffc0204000 <vmm_init+0x20a>
ffffffffc0203f4a:	01093783          	ld	a5,16(s2)
ffffffffc0203f4e:	0b479963          	bne	a5,s4,ffffffffc0204000 <vmm_init+0x20a>
ffffffffc0203f52:	0089b783          	ld	a5,8(s3)
ffffffffc0203f56:	0c879563          	bne	a5,s0,ffffffffc0204020 <vmm_init+0x22a>
ffffffffc0203f5a:	0109b783          	ld	a5,16(s3)
ffffffffc0203f5e:	0d479163          	bne	a5,s4,ffffffffc0204020 <vmm_init+0x22a>
ffffffffc0203f62:	0415                	addi	s0,s0,5
ffffffffc0203f64:	0a15                	addi	s4,s4,5
ffffffffc0203f66:	f9541be3          	bne	s0,s5,ffffffffc0203efc <vmm_init+0x106>
ffffffffc0203f6a:	4411                	li	s0,4
ffffffffc0203f6c:	597d                	li	s2,-1
ffffffffc0203f6e:	85a2                	mv	a1,s0
ffffffffc0203f70:	8526                	mv	a0,s1
ffffffffc0203f72:	c13ff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0203f76:	0004059b          	sext.w	a1,s0
ffffffffc0203f7a:	c90d                	beqz	a0,ffffffffc0203fac <vmm_init+0x1b6>
ffffffffc0203f7c:	6914                	ld	a3,16(a0)
ffffffffc0203f7e:	6510                	ld	a2,8(a0)
ffffffffc0203f80:	00008517          	auipc	a0,0x8
ffffffffc0203f84:	51850513          	addi	a0,a0,1304 # ffffffffc020c498 <default_pmm_manager+0xa00>
ffffffffc0203f88:	a1efc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203f8c:	00008697          	auipc	a3,0x8
ffffffffc0203f90:	53468693          	addi	a3,a3,1332 # ffffffffc020c4c0 <default_pmm_manager+0xa28>
ffffffffc0203f94:	00007617          	auipc	a2,0x7
ffffffffc0203f98:	01c60613          	addi	a2,a2,28 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203f9c:	15900593          	li	a1,345
ffffffffc0203fa0:	00008517          	auipc	a0,0x8
ffffffffc0203fa4:	32050513          	addi	a0,a0,800 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203fa8:	cf6fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203fac:	147d                	addi	s0,s0,-1
ffffffffc0203fae:	fd2410e3          	bne	s0,s2,ffffffffc0203f6e <vmm_init+0x178>
ffffffffc0203fb2:	8526                	mv	a0,s1
ffffffffc0203fb4:	ce1ff0ef          	jal	ra,ffffffffc0203c94 <mm_destroy>
ffffffffc0203fb8:	00008517          	auipc	a0,0x8
ffffffffc0203fbc:	52050513          	addi	a0,a0,1312 # ffffffffc020c4d8 <default_pmm_manager+0xa40>
ffffffffc0203fc0:	9e6fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203fc4:	7442                	ld	s0,48(sp)
ffffffffc0203fc6:	70e2                	ld	ra,56(sp)
ffffffffc0203fc8:	74a2                	ld	s1,40(sp)
ffffffffc0203fca:	7902                	ld	s2,32(sp)
ffffffffc0203fcc:	69e2                	ld	s3,24(sp)
ffffffffc0203fce:	6a42                	ld	s4,16(sp)
ffffffffc0203fd0:	6aa2                	ld	s5,8(sp)
ffffffffc0203fd2:	00008517          	auipc	a0,0x8
ffffffffc0203fd6:	52650513          	addi	a0,a0,1318 # ffffffffc020c4f8 <default_pmm_manager+0xa60>
ffffffffc0203fda:	6121                	addi	sp,sp,64
ffffffffc0203fdc:	9cafc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0203fe0:	00008697          	auipc	a3,0x8
ffffffffc0203fe4:	3d068693          	addi	a3,a3,976 # ffffffffc020c3b0 <default_pmm_manager+0x918>
ffffffffc0203fe8:	00007617          	auipc	a2,0x7
ffffffffc0203fec:	fc860613          	addi	a2,a2,-56 # ffffffffc020afb0 <commands+0x210>
ffffffffc0203ff0:	13d00593          	li	a1,317
ffffffffc0203ff4:	00008517          	auipc	a0,0x8
ffffffffc0203ff8:	2cc50513          	addi	a0,a0,716 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc0203ffc:	ca2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204000:	00008697          	auipc	a3,0x8
ffffffffc0204004:	43868693          	addi	a3,a3,1080 # ffffffffc020c438 <default_pmm_manager+0x9a0>
ffffffffc0204008:	00007617          	auipc	a2,0x7
ffffffffc020400c:	fa860613          	addi	a2,a2,-88 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204010:	14e00593          	li	a1,334
ffffffffc0204014:	00008517          	auipc	a0,0x8
ffffffffc0204018:	2ac50513          	addi	a0,a0,684 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc020401c:	c82fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204020:	00008697          	auipc	a3,0x8
ffffffffc0204024:	44868693          	addi	a3,a3,1096 # ffffffffc020c468 <default_pmm_manager+0x9d0>
ffffffffc0204028:	00007617          	auipc	a2,0x7
ffffffffc020402c:	f8860613          	addi	a2,a2,-120 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204030:	14f00593          	li	a1,335
ffffffffc0204034:	00008517          	auipc	a0,0x8
ffffffffc0204038:	28c50513          	addi	a0,a0,652 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc020403c:	c62fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204040:	00008697          	auipc	a3,0x8
ffffffffc0204044:	35868693          	addi	a3,a3,856 # ffffffffc020c398 <default_pmm_manager+0x900>
ffffffffc0204048:	00007617          	auipc	a2,0x7
ffffffffc020404c:	f6860613          	addi	a2,a2,-152 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204050:	13b00593          	li	a1,315
ffffffffc0204054:	00008517          	auipc	a0,0x8
ffffffffc0204058:	26c50513          	addi	a0,a0,620 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc020405c:	c42fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204060:	00008697          	auipc	a3,0x8
ffffffffc0204064:	39868693          	addi	a3,a3,920 # ffffffffc020c3f8 <default_pmm_manager+0x960>
ffffffffc0204068:	00007617          	auipc	a2,0x7
ffffffffc020406c:	f4860613          	addi	a2,a2,-184 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204070:	14600593          	li	a1,326
ffffffffc0204074:	00008517          	auipc	a0,0x8
ffffffffc0204078:	24c50513          	addi	a0,a0,588 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc020407c:	c22fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204080:	00008697          	auipc	a3,0x8
ffffffffc0204084:	36868693          	addi	a3,a3,872 # ffffffffc020c3e8 <default_pmm_manager+0x950>
ffffffffc0204088:	00007617          	auipc	a2,0x7
ffffffffc020408c:	f2860613          	addi	a2,a2,-216 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204090:	14400593          	li	a1,324
ffffffffc0204094:	00008517          	auipc	a0,0x8
ffffffffc0204098:	22c50513          	addi	a0,a0,556 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc020409c:	c02fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040a0:	00008697          	auipc	a3,0x8
ffffffffc02040a4:	36868693          	addi	a3,a3,872 # ffffffffc020c408 <default_pmm_manager+0x970>
ffffffffc02040a8:	00007617          	auipc	a2,0x7
ffffffffc02040ac:	f0860613          	addi	a2,a2,-248 # ffffffffc020afb0 <commands+0x210>
ffffffffc02040b0:	14800593          	li	a1,328
ffffffffc02040b4:	00008517          	auipc	a0,0x8
ffffffffc02040b8:	20c50513          	addi	a0,a0,524 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc02040bc:	be2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040c0:	00008697          	auipc	a3,0x8
ffffffffc02040c4:	36868693          	addi	a3,a3,872 # ffffffffc020c428 <default_pmm_manager+0x990>
ffffffffc02040c8:	00007617          	auipc	a2,0x7
ffffffffc02040cc:	ee860613          	addi	a2,a2,-280 # ffffffffc020afb0 <commands+0x210>
ffffffffc02040d0:	14c00593          	li	a1,332
ffffffffc02040d4:	00008517          	auipc	a0,0x8
ffffffffc02040d8:	1ec50513          	addi	a0,a0,492 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc02040dc:	bc2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02040e0:	00008697          	auipc	a3,0x8
ffffffffc02040e4:	33868693          	addi	a3,a3,824 # ffffffffc020c418 <default_pmm_manager+0x980>
ffffffffc02040e8:	00007617          	auipc	a2,0x7
ffffffffc02040ec:	ec860613          	addi	a2,a2,-312 # ffffffffc020afb0 <commands+0x210>
ffffffffc02040f0:	14a00593          	li	a1,330
ffffffffc02040f4:	00008517          	auipc	a0,0x8
ffffffffc02040f8:	1cc50513          	addi	a0,a0,460 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc02040fc:	ba2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204100:	00008697          	auipc	a3,0x8
ffffffffc0204104:	24868693          	addi	a3,a3,584 # ffffffffc020c348 <default_pmm_manager+0x8b0>
ffffffffc0204108:	00007617          	auipc	a2,0x7
ffffffffc020410c:	ea860613          	addi	a2,a2,-344 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204110:	12400593          	li	a1,292
ffffffffc0204114:	00008517          	auipc	a0,0x8
ffffffffc0204118:	1ac50513          	addi	a0,a0,428 # ffffffffc020c2c0 <default_pmm_manager+0x828>
ffffffffc020411c:	b82fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204120 <user_mem_check>:
ffffffffc0204120:	7179                	addi	sp,sp,-48
ffffffffc0204122:	f022                	sd	s0,32(sp)
ffffffffc0204124:	f406                	sd	ra,40(sp)
ffffffffc0204126:	ec26                	sd	s1,24(sp)
ffffffffc0204128:	e84a                	sd	s2,16(sp)
ffffffffc020412a:	e44e                	sd	s3,8(sp)
ffffffffc020412c:	e052                	sd	s4,0(sp)
ffffffffc020412e:	842e                	mv	s0,a1
ffffffffc0204130:	c135                	beqz	a0,ffffffffc0204194 <user_mem_check+0x74>
ffffffffc0204132:	002007b7          	lui	a5,0x200
ffffffffc0204136:	04f5e663          	bltu	a1,a5,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc020413a:	00c584b3          	add	s1,a1,a2
ffffffffc020413e:	0495f263          	bgeu	a1,s1,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc0204142:	4785                	li	a5,1
ffffffffc0204144:	07fe                	slli	a5,a5,0x1f
ffffffffc0204146:	0297ee63          	bltu	a5,s1,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc020414a:	892a                	mv	s2,a0
ffffffffc020414c:	89b6                	mv	s3,a3
ffffffffc020414e:	6a05                	lui	s4,0x1
ffffffffc0204150:	a821                	j	ffffffffc0204168 <user_mem_check+0x48>
ffffffffc0204152:	0027f693          	andi	a3,a5,2
ffffffffc0204156:	9752                	add	a4,a4,s4
ffffffffc0204158:	8ba1                	andi	a5,a5,8
ffffffffc020415a:	c685                	beqz	a3,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc020415c:	c399                	beqz	a5,ffffffffc0204162 <user_mem_check+0x42>
ffffffffc020415e:	02e46263          	bltu	s0,a4,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc0204162:	6900                	ld	s0,16(a0)
ffffffffc0204164:	04947663          	bgeu	s0,s1,ffffffffc02041b0 <user_mem_check+0x90>
ffffffffc0204168:	85a2                	mv	a1,s0
ffffffffc020416a:	854a                	mv	a0,s2
ffffffffc020416c:	a19ff0ef          	jal	ra,ffffffffc0203b84 <find_vma>
ffffffffc0204170:	c909                	beqz	a0,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc0204172:	6518                	ld	a4,8(a0)
ffffffffc0204174:	00e46763          	bltu	s0,a4,ffffffffc0204182 <user_mem_check+0x62>
ffffffffc0204178:	4d1c                	lw	a5,24(a0)
ffffffffc020417a:	fc099ce3          	bnez	s3,ffffffffc0204152 <user_mem_check+0x32>
ffffffffc020417e:	8b85                	andi	a5,a5,1
ffffffffc0204180:	f3ed                	bnez	a5,ffffffffc0204162 <user_mem_check+0x42>
ffffffffc0204182:	4501                	li	a0,0
ffffffffc0204184:	70a2                	ld	ra,40(sp)
ffffffffc0204186:	7402                	ld	s0,32(sp)
ffffffffc0204188:	64e2                	ld	s1,24(sp)
ffffffffc020418a:	6942                	ld	s2,16(sp)
ffffffffc020418c:	69a2                	ld	s3,8(sp)
ffffffffc020418e:	6a02                	ld	s4,0(sp)
ffffffffc0204190:	6145                	addi	sp,sp,48
ffffffffc0204192:	8082                	ret
ffffffffc0204194:	c02007b7          	lui	a5,0xc0200
ffffffffc0204198:	4501                	li	a0,0
ffffffffc020419a:	fef5e5e3          	bltu	a1,a5,ffffffffc0204184 <user_mem_check+0x64>
ffffffffc020419e:	962e                	add	a2,a2,a1
ffffffffc02041a0:	fec5f2e3          	bgeu	a1,a2,ffffffffc0204184 <user_mem_check+0x64>
ffffffffc02041a4:	c8000537          	lui	a0,0xc8000
ffffffffc02041a8:	0505                	addi	a0,a0,1
ffffffffc02041aa:	00a63533          	sltu	a0,a2,a0
ffffffffc02041ae:	bfd9                	j	ffffffffc0204184 <user_mem_check+0x64>
ffffffffc02041b0:	4505                	li	a0,1
ffffffffc02041b2:	bfc9                	j	ffffffffc0204184 <user_mem_check+0x64>

ffffffffc02041b4 <copy_from_user>:
ffffffffc02041b4:	1101                	addi	sp,sp,-32
ffffffffc02041b6:	e822                	sd	s0,16(sp)
ffffffffc02041b8:	e426                	sd	s1,8(sp)
ffffffffc02041ba:	8432                	mv	s0,a2
ffffffffc02041bc:	84b6                	mv	s1,a3
ffffffffc02041be:	e04a                	sd	s2,0(sp)
ffffffffc02041c0:	86ba                	mv	a3,a4
ffffffffc02041c2:	892e                	mv	s2,a1
ffffffffc02041c4:	8626                	mv	a2,s1
ffffffffc02041c6:	85a2                	mv	a1,s0
ffffffffc02041c8:	ec06                	sd	ra,24(sp)
ffffffffc02041ca:	f57ff0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc02041ce:	c519                	beqz	a0,ffffffffc02041dc <copy_from_user+0x28>
ffffffffc02041d0:	8626                	mv	a2,s1
ffffffffc02041d2:	85a2                	mv	a1,s0
ffffffffc02041d4:	854a                	mv	a0,s2
ffffffffc02041d6:	14b060ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc02041da:	4505                	li	a0,1
ffffffffc02041dc:	60e2                	ld	ra,24(sp)
ffffffffc02041de:	6442                	ld	s0,16(sp)
ffffffffc02041e0:	64a2                	ld	s1,8(sp)
ffffffffc02041e2:	6902                	ld	s2,0(sp)
ffffffffc02041e4:	6105                	addi	sp,sp,32
ffffffffc02041e6:	8082                	ret

ffffffffc02041e8 <copy_to_user>:
ffffffffc02041e8:	1101                	addi	sp,sp,-32
ffffffffc02041ea:	e822                	sd	s0,16(sp)
ffffffffc02041ec:	8436                	mv	s0,a3
ffffffffc02041ee:	e04a                	sd	s2,0(sp)
ffffffffc02041f0:	4685                	li	a3,1
ffffffffc02041f2:	8932                	mv	s2,a2
ffffffffc02041f4:	8622                	mv	a2,s0
ffffffffc02041f6:	e426                	sd	s1,8(sp)
ffffffffc02041f8:	ec06                	sd	ra,24(sp)
ffffffffc02041fa:	84ae                	mv	s1,a1
ffffffffc02041fc:	f25ff0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc0204200:	c519                	beqz	a0,ffffffffc020420e <copy_to_user+0x26>
ffffffffc0204202:	8622                	mv	a2,s0
ffffffffc0204204:	85ca                	mv	a1,s2
ffffffffc0204206:	8526                	mv	a0,s1
ffffffffc0204208:	119060ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020420c:	4505                	li	a0,1
ffffffffc020420e:	60e2                	ld	ra,24(sp)
ffffffffc0204210:	6442                	ld	s0,16(sp)
ffffffffc0204212:	64a2                	ld	s1,8(sp)
ffffffffc0204214:	6902                	ld	s2,0(sp)
ffffffffc0204216:	6105                	addi	sp,sp,32
ffffffffc0204218:	8082                	ret

ffffffffc020421a <copy_string>:
ffffffffc020421a:	7139                	addi	sp,sp,-64
ffffffffc020421c:	ec4e                	sd	s3,24(sp)
ffffffffc020421e:	6985                	lui	s3,0x1
ffffffffc0204220:	99b2                	add	s3,s3,a2
ffffffffc0204222:	77fd                	lui	a5,0xfffff
ffffffffc0204224:	00f9f9b3          	and	s3,s3,a5
ffffffffc0204228:	f426                	sd	s1,40(sp)
ffffffffc020422a:	f04a                	sd	s2,32(sp)
ffffffffc020422c:	e852                	sd	s4,16(sp)
ffffffffc020422e:	e456                	sd	s5,8(sp)
ffffffffc0204230:	fc06                	sd	ra,56(sp)
ffffffffc0204232:	f822                	sd	s0,48(sp)
ffffffffc0204234:	84b2                	mv	s1,a2
ffffffffc0204236:	8aaa                	mv	s5,a0
ffffffffc0204238:	8a2e                	mv	s4,a1
ffffffffc020423a:	8936                	mv	s2,a3
ffffffffc020423c:	40c989b3          	sub	s3,s3,a2
ffffffffc0204240:	a015                	j	ffffffffc0204264 <copy_string+0x4a>
ffffffffc0204242:	005060ef          	jal	ra,ffffffffc020aa46 <strnlen>
ffffffffc0204246:	87aa                	mv	a5,a0
ffffffffc0204248:	85a6                	mv	a1,s1
ffffffffc020424a:	8552                	mv	a0,s4
ffffffffc020424c:	8622                	mv	a2,s0
ffffffffc020424e:	0487e363          	bltu	a5,s0,ffffffffc0204294 <copy_string+0x7a>
ffffffffc0204252:	0329f763          	bgeu	s3,s2,ffffffffc0204280 <copy_string+0x66>
ffffffffc0204256:	0cb060ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020425a:	9a22                	add	s4,s4,s0
ffffffffc020425c:	94a2                	add	s1,s1,s0
ffffffffc020425e:	40890933          	sub	s2,s2,s0
ffffffffc0204262:	6985                	lui	s3,0x1
ffffffffc0204264:	4681                	li	a3,0
ffffffffc0204266:	85a6                	mv	a1,s1
ffffffffc0204268:	8556                	mv	a0,s5
ffffffffc020426a:	844a                	mv	s0,s2
ffffffffc020426c:	0129f363          	bgeu	s3,s2,ffffffffc0204272 <copy_string+0x58>
ffffffffc0204270:	844e                	mv	s0,s3
ffffffffc0204272:	8622                	mv	a2,s0
ffffffffc0204274:	eadff0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc0204278:	87aa                	mv	a5,a0
ffffffffc020427a:	85a2                	mv	a1,s0
ffffffffc020427c:	8526                	mv	a0,s1
ffffffffc020427e:	f3f1                	bnez	a5,ffffffffc0204242 <copy_string+0x28>
ffffffffc0204280:	4501                	li	a0,0
ffffffffc0204282:	70e2                	ld	ra,56(sp)
ffffffffc0204284:	7442                	ld	s0,48(sp)
ffffffffc0204286:	74a2                	ld	s1,40(sp)
ffffffffc0204288:	7902                	ld	s2,32(sp)
ffffffffc020428a:	69e2                	ld	s3,24(sp)
ffffffffc020428c:	6a42                	ld	s4,16(sp)
ffffffffc020428e:	6aa2                	ld	s5,8(sp)
ffffffffc0204290:	6121                	addi	sp,sp,64
ffffffffc0204292:	8082                	ret
ffffffffc0204294:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd696f1>
ffffffffc0204298:	089060ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020429c:	4505                	li	a0,1
ffffffffc020429e:	b7d5                	j	ffffffffc0204282 <copy_string+0x68>

ffffffffc02042a0 <__down.constprop.0>:
ffffffffc02042a0:	715d                	addi	sp,sp,-80
ffffffffc02042a2:	e0a2                	sd	s0,64(sp)
ffffffffc02042a4:	e486                	sd	ra,72(sp)
ffffffffc02042a6:	fc26                	sd	s1,56(sp)
ffffffffc02042a8:	842a                	mv	s0,a0
ffffffffc02042aa:	100027f3          	csrr	a5,sstatus
ffffffffc02042ae:	8b89                	andi	a5,a5,2
ffffffffc02042b0:	ebb1                	bnez	a5,ffffffffc0204304 <__down.constprop.0+0x64>
ffffffffc02042b2:	411c                	lw	a5,0(a0)
ffffffffc02042b4:	00f05a63          	blez	a5,ffffffffc02042c8 <__down.constprop.0+0x28>
ffffffffc02042b8:	37fd                	addiw	a5,a5,-1
ffffffffc02042ba:	c11c                	sw	a5,0(a0)
ffffffffc02042bc:	4501                	li	a0,0
ffffffffc02042be:	60a6                	ld	ra,72(sp)
ffffffffc02042c0:	6406                	ld	s0,64(sp)
ffffffffc02042c2:	74e2                	ld	s1,56(sp)
ffffffffc02042c4:	6161                	addi	sp,sp,80
ffffffffc02042c6:	8082                	ret
ffffffffc02042c8:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d6a6f8>
ffffffffc02042cc:	0024                	addi	s1,sp,8
ffffffffc02042ce:	10000613          	li	a2,256
ffffffffc02042d2:	85a6                	mv	a1,s1
ffffffffc02042d4:	8522                	mv	a0,s0
ffffffffc02042d6:	2d8000ef          	jal	ra,ffffffffc02045ae <wait_current_set>
ffffffffc02042da:	0c5020ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc02042de:	100027f3          	csrr	a5,sstatus
ffffffffc02042e2:	8b89                	andi	a5,a5,2
ffffffffc02042e4:	efb9                	bnez	a5,ffffffffc0204342 <__down.constprop.0+0xa2>
ffffffffc02042e6:	8526                	mv	a0,s1
ffffffffc02042e8:	19c000ef          	jal	ra,ffffffffc0204484 <wait_in_queue>
ffffffffc02042ec:	e531                	bnez	a0,ffffffffc0204338 <__down.constprop.0+0x98>
ffffffffc02042ee:	4542                	lw	a0,16(sp)
ffffffffc02042f0:	10000793          	li	a5,256
ffffffffc02042f4:	fcf515e3          	bne	a0,a5,ffffffffc02042be <__down.constprop.0+0x1e>
ffffffffc02042f8:	60a6                	ld	ra,72(sp)
ffffffffc02042fa:	6406                	ld	s0,64(sp)
ffffffffc02042fc:	74e2                	ld	s1,56(sp)
ffffffffc02042fe:	4501                	li	a0,0
ffffffffc0204300:	6161                	addi	sp,sp,80
ffffffffc0204302:	8082                	ret
ffffffffc0204304:	96ffc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204308:	401c                	lw	a5,0(s0)
ffffffffc020430a:	00f05c63          	blez	a5,ffffffffc0204322 <__down.constprop.0+0x82>
ffffffffc020430e:	37fd                	addiw	a5,a5,-1
ffffffffc0204310:	c01c                	sw	a5,0(s0)
ffffffffc0204312:	95bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204316:	60a6                	ld	ra,72(sp)
ffffffffc0204318:	6406                	ld	s0,64(sp)
ffffffffc020431a:	74e2                	ld	s1,56(sp)
ffffffffc020431c:	4501                	li	a0,0
ffffffffc020431e:	6161                	addi	sp,sp,80
ffffffffc0204320:	8082                	ret
ffffffffc0204322:	0421                	addi	s0,s0,8
ffffffffc0204324:	0024                	addi	s1,sp,8
ffffffffc0204326:	10000613          	li	a2,256
ffffffffc020432a:	85a6                	mv	a1,s1
ffffffffc020432c:	8522                	mv	a0,s0
ffffffffc020432e:	280000ef          	jal	ra,ffffffffc02045ae <wait_current_set>
ffffffffc0204332:	93bfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204336:	b755                	j	ffffffffc02042da <__down.constprop.0+0x3a>
ffffffffc0204338:	85a6                	mv	a1,s1
ffffffffc020433a:	8522                	mv	a0,s0
ffffffffc020433c:	0ee000ef          	jal	ra,ffffffffc020442a <wait_queue_del>
ffffffffc0204340:	b77d                	j	ffffffffc02042ee <__down.constprop.0+0x4e>
ffffffffc0204342:	931fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204346:	8526                	mv	a0,s1
ffffffffc0204348:	13c000ef          	jal	ra,ffffffffc0204484 <wait_in_queue>
ffffffffc020434c:	e501                	bnez	a0,ffffffffc0204354 <__down.constprop.0+0xb4>
ffffffffc020434e:	91ffc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204352:	bf71                	j	ffffffffc02042ee <__down.constprop.0+0x4e>
ffffffffc0204354:	85a6                	mv	a1,s1
ffffffffc0204356:	8522                	mv	a0,s0
ffffffffc0204358:	0d2000ef          	jal	ra,ffffffffc020442a <wait_queue_del>
ffffffffc020435c:	bfcd                	j	ffffffffc020434e <__down.constprop.0+0xae>

ffffffffc020435e <__up.constprop.0>:
ffffffffc020435e:	1101                	addi	sp,sp,-32
ffffffffc0204360:	e822                	sd	s0,16(sp)
ffffffffc0204362:	ec06                	sd	ra,24(sp)
ffffffffc0204364:	e426                	sd	s1,8(sp)
ffffffffc0204366:	e04a                	sd	s2,0(sp)
ffffffffc0204368:	842a                	mv	s0,a0
ffffffffc020436a:	100027f3          	csrr	a5,sstatus
ffffffffc020436e:	8b89                	andi	a5,a5,2
ffffffffc0204370:	4901                	li	s2,0
ffffffffc0204372:	eba1                	bnez	a5,ffffffffc02043c2 <__up.constprop.0+0x64>
ffffffffc0204374:	00840493          	addi	s1,s0,8
ffffffffc0204378:	8526                	mv	a0,s1
ffffffffc020437a:	0ee000ef          	jal	ra,ffffffffc0204468 <wait_queue_first>
ffffffffc020437e:	85aa                	mv	a1,a0
ffffffffc0204380:	cd0d                	beqz	a0,ffffffffc02043ba <__up.constprop.0+0x5c>
ffffffffc0204382:	6118                	ld	a4,0(a0)
ffffffffc0204384:	10000793          	li	a5,256
ffffffffc0204388:	0ec72703          	lw	a4,236(a4)
ffffffffc020438c:	02f71f63          	bne	a4,a5,ffffffffc02043ca <__up.constprop.0+0x6c>
ffffffffc0204390:	4685                	li	a3,1
ffffffffc0204392:	10000613          	li	a2,256
ffffffffc0204396:	8526                	mv	a0,s1
ffffffffc0204398:	0fa000ef          	jal	ra,ffffffffc0204492 <wakeup_wait>
ffffffffc020439c:	00091863          	bnez	s2,ffffffffc02043ac <__up.constprop.0+0x4e>
ffffffffc02043a0:	60e2                	ld	ra,24(sp)
ffffffffc02043a2:	6442                	ld	s0,16(sp)
ffffffffc02043a4:	64a2                	ld	s1,8(sp)
ffffffffc02043a6:	6902                	ld	s2,0(sp)
ffffffffc02043a8:	6105                	addi	sp,sp,32
ffffffffc02043aa:	8082                	ret
ffffffffc02043ac:	6442                	ld	s0,16(sp)
ffffffffc02043ae:	60e2                	ld	ra,24(sp)
ffffffffc02043b0:	64a2                	ld	s1,8(sp)
ffffffffc02043b2:	6902                	ld	s2,0(sp)
ffffffffc02043b4:	6105                	addi	sp,sp,32
ffffffffc02043b6:	8b7fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02043ba:	401c                	lw	a5,0(s0)
ffffffffc02043bc:	2785                	addiw	a5,a5,1
ffffffffc02043be:	c01c                	sw	a5,0(s0)
ffffffffc02043c0:	bff1                	j	ffffffffc020439c <__up.constprop.0+0x3e>
ffffffffc02043c2:	8b1fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02043c6:	4905                	li	s2,1
ffffffffc02043c8:	b775                	j	ffffffffc0204374 <__up.constprop.0+0x16>
ffffffffc02043ca:	00008697          	auipc	a3,0x8
ffffffffc02043ce:	15668693          	addi	a3,a3,342 # ffffffffc020c520 <default_pmm_manager+0xa88>
ffffffffc02043d2:	00007617          	auipc	a2,0x7
ffffffffc02043d6:	bde60613          	addi	a2,a2,-1058 # ffffffffc020afb0 <commands+0x210>
ffffffffc02043da:	45e5                	li	a1,25
ffffffffc02043dc:	00008517          	auipc	a0,0x8
ffffffffc02043e0:	16c50513          	addi	a0,a0,364 # ffffffffc020c548 <default_pmm_manager+0xab0>
ffffffffc02043e4:	8bafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02043e8 <sem_init>:
ffffffffc02043e8:	c10c                	sw	a1,0(a0)
ffffffffc02043ea:	0521                	addi	a0,a0,8
ffffffffc02043ec:	a825                	j	ffffffffc0204424 <wait_queue_init>

ffffffffc02043ee <up>:
ffffffffc02043ee:	f71ff06f          	j	ffffffffc020435e <__up.constprop.0>

ffffffffc02043f2 <down>:
ffffffffc02043f2:	1141                	addi	sp,sp,-16
ffffffffc02043f4:	e406                	sd	ra,8(sp)
ffffffffc02043f6:	eabff0ef          	jal	ra,ffffffffc02042a0 <__down.constprop.0>
ffffffffc02043fa:	2501                	sext.w	a0,a0
ffffffffc02043fc:	e501                	bnez	a0,ffffffffc0204404 <down+0x12>
ffffffffc02043fe:	60a2                	ld	ra,8(sp)
ffffffffc0204400:	0141                	addi	sp,sp,16
ffffffffc0204402:	8082                	ret
ffffffffc0204404:	00008697          	auipc	a3,0x8
ffffffffc0204408:	15468693          	addi	a3,a3,340 # ffffffffc020c558 <default_pmm_manager+0xac0>
ffffffffc020440c:	00007617          	auipc	a2,0x7
ffffffffc0204410:	ba460613          	addi	a2,a2,-1116 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204414:	04000593          	li	a1,64
ffffffffc0204418:	00008517          	auipc	a0,0x8
ffffffffc020441c:	13050513          	addi	a0,a0,304 # ffffffffc020c548 <default_pmm_manager+0xab0>
ffffffffc0204420:	87efc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204424 <wait_queue_init>:
ffffffffc0204424:	e508                	sd	a0,8(a0)
ffffffffc0204426:	e108                	sd	a0,0(a0)
ffffffffc0204428:	8082                	ret

ffffffffc020442a <wait_queue_del>:
ffffffffc020442a:	7198                	ld	a4,32(a1)
ffffffffc020442c:	01858793          	addi	a5,a1,24
ffffffffc0204430:	00e78b63          	beq	a5,a4,ffffffffc0204446 <wait_queue_del+0x1c>
ffffffffc0204434:	6994                	ld	a3,16(a1)
ffffffffc0204436:	00a69863          	bne	a3,a0,ffffffffc0204446 <wait_queue_del+0x1c>
ffffffffc020443a:	6d94                	ld	a3,24(a1)
ffffffffc020443c:	e698                	sd	a4,8(a3)
ffffffffc020443e:	e314                	sd	a3,0(a4)
ffffffffc0204440:	f19c                	sd	a5,32(a1)
ffffffffc0204442:	ed9c                	sd	a5,24(a1)
ffffffffc0204444:	8082                	ret
ffffffffc0204446:	1141                	addi	sp,sp,-16
ffffffffc0204448:	00008697          	auipc	a3,0x8
ffffffffc020444c:	17068693          	addi	a3,a3,368 # ffffffffc020c5b8 <default_pmm_manager+0xb20>
ffffffffc0204450:	00007617          	auipc	a2,0x7
ffffffffc0204454:	b6060613          	addi	a2,a2,-1184 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204458:	45f1                	li	a1,28
ffffffffc020445a:	00008517          	auipc	a0,0x8
ffffffffc020445e:	14650513          	addi	a0,a0,326 # ffffffffc020c5a0 <default_pmm_manager+0xb08>
ffffffffc0204462:	e406                	sd	ra,8(sp)
ffffffffc0204464:	83afc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204468 <wait_queue_first>:
ffffffffc0204468:	651c                	ld	a5,8(a0)
ffffffffc020446a:	00f50563          	beq	a0,a5,ffffffffc0204474 <wait_queue_first+0xc>
ffffffffc020446e:	fe878513          	addi	a0,a5,-24
ffffffffc0204472:	8082                	ret
ffffffffc0204474:	4501                	li	a0,0
ffffffffc0204476:	8082                	ret

ffffffffc0204478 <wait_queue_empty>:
ffffffffc0204478:	651c                	ld	a5,8(a0)
ffffffffc020447a:	40a78533          	sub	a0,a5,a0
ffffffffc020447e:	00153513          	seqz	a0,a0
ffffffffc0204482:	8082                	ret

ffffffffc0204484 <wait_in_queue>:
ffffffffc0204484:	711c                	ld	a5,32(a0)
ffffffffc0204486:	0561                	addi	a0,a0,24
ffffffffc0204488:	40a78533          	sub	a0,a5,a0
ffffffffc020448c:	00a03533          	snez	a0,a0
ffffffffc0204490:	8082                	ret

ffffffffc0204492 <wakeup_wait>:
ffffffffc0204492:	e689                	bnez	a3,ffffffffc020449c <wakeup_wait+0xa>
ffffffffc0204494:	6188                	ld	a0,0(a1)
ffffffffc0204496:	c590                	sw	a2,8(a1)
ffffffffc0204498:	6540206f          	j	ffffffffc0206aec <wakeup_proc>
ffffffffc020449c:	7198                	ld	a4,32(a1)
ffffffffc020449e:	01858793          	addi	a5,a1,24
ffffffffc02044a2:	00e78e63          	beq	a5,a4,ffffffffc02044be <wakeup_wait+0x2c>
ffffffffc02044a6:	6994                	ld	a3,16(a1)
ffffffffc02044a8:	00d51b63          	bne	a0,a3,ffffffffc02044be <wakeup_wait+0x2c>
ffffffffc02044ac:	6d94                	ld	a3,24(a1)
ffffffffc02044ae:	6188                	ld	a0,0(a1)
ffffffffc02044b0:	e698                	sd	a4,8(a3)
ffffffffc02044b2:	e314                	sd	a3,0(a4)
ffffffffc02044b4:	f19c                	sd	a5,32(a1)
ffffffffc02044b6:	ed9c                	sd	a5,24(a1)
ffffffffc02044b8:	c590                	sw	a2,8(a1)
ffffffffc02044ba:	6320206f          	j	ffffffffc0206aec <wakeup_proc>
ffffffffc02044be:	1141                	addi	sp,sp,-16
ffffffffc02044c0:	00008697          	auipc	a3,0x8
ffffffffc02044c4:	0f868693          	addi	a3,a3,248 # ffffffffc020c5b8 <default_pmm_manager+0xb20>
ffffffffc02044c8:	00007617          	auipc	a2,0x7
ffffffffc02044cc:	ae860613          	addi	a2,a2,-1304 # ffffffffc020afb0 <commands+0x210>
ffffffffc02044d0:	45f1                	li	a1,28
ffffffffc02044d2:	00008517          	auipc	a0,0x8
ffffffffc02044d6:	0ce50513          	addi	a0,a0,206 # ffffffffc020c5a0 <default_pmm_manager+0xb08>
ffffffffc02044da:	e406                	sd	ra,8(sp)
ffffffffc02044dc:	fc3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02044e0 <wakeup_queue>:
ffffffffc02044e0:	651c                	ld	a5,8(a0)
ffffffffc02044e2:	0ca78563          	beq	a5,a0,ffffffffc02045ac <wakeup_queue+0xcc>
ffffffffc02044e6:	1101                	addi	sp,sp,-32
ffffffffc02044e8:	e822                	sd	s0,16(sp)
ffffffffc02044ea:	e426                	sd	s1,8(sp)
ffffffffc02044ec:	e04a                	sd	s2,0(sp)
ffffffffc02044ee:	ec06                	sd	ra,24(sp)
ffffffffc02044f0:	84aa                	mv	s1,a0
ffffffffc02044f2:	892e                	mv	s2,a1
ffffffffc02044f4:	fe878413          	addi	s0,a5,-24
ffffffffc02044f8:	e23d                	bnez	a2,ffffffffc020455e <wakeup_queue+0x7e>
ffffffffc02044fa:	6008                	ld	a0,0(s0)
ffffffffc02044fc:	01242423          	sw	s2,8(s0)
ffffffffc0204500:	5ec020ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0204504:	701c                	ld	a5,32(s0)
ffffffffc0204506:	01840713          	addi	a4,s0,24
ffffffffc020450a:	02e78463          	beq	a5,a4,ffffffffc0204532 <wakeup_queue+0x52>
ffffffffc020450e:	6818                	ld	a4,16(s0)
ffffffffc0204510:	02e49163          	bne	s1,a4,ffffffffc0204532 <wakeup_queue+0x52>
ffffffffc0204514:	02f48f63          	beq	s1,a5,ffffffffc0204552 <wakeup_queue+0x72>
ffffffffc0204518:	fe87b503          	ld	a0,-24(a5)
ffffffffc020451c:	ff27a823          	sw	s2,-16(a5)
ffffffffc0204520:	fe878413          	addi	s0,a5,-24
ffffffffc0204524:	5c8020ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0204528:	701c                	ld	a5,32(s0)
ffffffffc020452a:	01840713          	addi	a4,s0,24
ffffffffc020452e:	fee790e3          	bne	a5,a4,ffffffffc020450e <wakeup_queue+0x2e>
ffffffffc0204532:	00008697          	auipc	a3,0x8
ffffffffc0204536:	08668693          	addi	a3,a3,134 # ffffffffc020c5b8 <default_pmm_manager+0xb20>
ffffffffc020453a:	00007617          	auipc	a2,0x7
ffffffffc020453e:	a7660613          	addi	a2,a2,-1418 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204542:	02200593          	li	a1,34
ffffffffc0204546:	00008517          	auipc	a0,0x8
ffffffffc020454a:	05a50513          	addi	a0,a0,90 # ffffffffc020c5a0 <default_pmm_manager+0xb08>
ffffffffc020454e:	f51fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204552:	60e2                	ld	ra,24(sp)
ffffffffc0204554:	6442                	ld	s0,16(sp)
ffffffffc0204556:	64a2                	ld	s1,8(sp)
ffffffffc0204558:	6902                	ld	s2,0(sp)
ffffffffc020455a:	6105                	addi	sp,sp,32
ffffffffc020455c:	8082                	ret
ffffffffc020455e:	6798                	ld	a4,8(a5)
ffffffffc0204560:	02f70763          	beq	a4,a5,ffffffffc020458e <wakeup_queue+0xae>
ffffffffc0204564:	6814                	ld	a3,16(s0)
ffffffffc0204566:	02d49463          	bne	s1,a3,ffffffffc020458e <wakeup_queue+0xae>
ffffffffc020456a:	6c14                	ld	a3,24(s0)
ffffffffc020456c:	6008                	ld	a0,0(s0)
ffffffffc020456e:	e698                	sd	a4,8(a3)
ffffffffc0204570:	e314                	sd	a3,0(a4)
ffffffffc0204572:	f01c                	sd	a5,32(s0)
ffffffffc0204574:	ec1c                	sd	a5,24(s0)
ffffffffc0204576:	01242423          	sw	s2,8(s0)
ffffffffc020457a:	572020ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc020457e:	6480                	ld	s0,8(s1)
ffffffffc0204580:	fc8489e3          	beq	s1,s0,ffffffffc0204552 <wakeup_queue+0x72>
ffffffffc0204584:	6418                	ld	a4,8(s0)
ffffffffc0204586:	87a2                	mv	a5,s0
ffffffffc0204588:	1421                	addi	s0,s0,-24
ffffffffc020458a:	fce79de3          	bne	a5,a4,ffffffffc0204564 <wakeup_queue+0x84>
ffffffffc020458e:	00008697          	auipc	a3,0x8
ffffffffc0204592:	02a68693          	addi	a3,a3,42 # ffffffffc020c5b8 <default_pmm_manager+0xb20>
ffffffffc0204596:	00007617          	auipc	a2,0x7
ffffffffc020459a:	a1a60613          	addi	a2,a2,-1510 # ffffffffc020afb0 <commands+0x210>
ffffffffc020459e:	45f1                	li	a1,28
ffffffffc02045a0:	00008517          	auipc	a0,0x8
ffffffffc02045a4:	00050513          	mv	a0,a0
ffffffffc02045a8:	ef7fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02045ac:	8082                	ret

ffffffffc02045ae <wait_current_set>:
ffffffffc02045ae:	00091797          	auipc	a5,0x91
ffffffffc02045b2:	3127b783          	ld	a5,786(a5) # ffffffffc02958c0 <current>
ffffffffc02045b6:	c39d                	beqz	a5,ffffffffc02045dc <wait_current_set+0x2e>
ffffffffc02045b8:	01858713          	addi	a4,a1,24
ffffffffc02045bc:	800006b7          	lui	a3,0x80000
ffffffffc02045c0:	ed98                	sd	a4,24(a1)
ffffffffc02045c2:	e19c                	sd	a5,0(a1)
ffffffffc02045c4:	c594                	sw	a3,8(a1)
ffffffffc02045c6:	4685                	li	a3,1
ffffffffc02045c8:	c394                	sw	a3,0(a5)
ffffffffc02045ca:	0ec7a623          	sw	a2,236(a5)
ffffffffc02045ce:	611c                	ld	a5,0(a0)
ffffffffc02045d0:	e988                	sd	a0,16(a1)
ffffffffc02045d2:	e118                	sd	a4,0(a0)
ffffffffc02045d4:	e798                	sd	a4,8(a5)
ffffffffc02045d6:	f188                	sd	a0,32(a1)
ffffffffc02045d8:	ed9c                	sd	a5,24(a1)
ffffffffc02045da:	8082                	ret
ffffffffc02045dc:	1141                	addi	sp,sp,-16
ffffffffc02045de:	00008697          	auipc	a3,0x8
ffffffffc02045e2:	01a68693          	addi	a3,a3,26 # ffffffffc020c5f8 <default_pmm_manager+0xb60>
ffffffffc02045e6:	00007617          	auipc	a2,0x7
ffffffffc02045ea:	9ca60613          	addi	a2,a2,-1590 # ffffffffc020afb0 <commands+0x210>
ffffffffc02045ee:	07400593          	li	a1,116
ffffffffc02045f2:	00008517          	auipc	a0,0x8
ffffffffc02045f6:	fae50513          	addi	a0,a0,-82 # ffffffffc020c5a0 <default_pmm_manager+0xb08>
ffffffffc02045fa:	e406                	sd	ra,8(sp)
ffffffffc02045fc:	ea3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204600 <get_fd_array.part.0>:
ffffffffc0204600:	1141                	addi	sp,sp,-16
ffffffffc0204602:	00008697          	auipc	a3,0x8
ffffffffc0204606:	00668693          	addi	a3,a3,6 # ffffffffc020c608 <default_pmm_manager+0xb70>
ffffffffc020460a:	00007617          	auipc	a2,0x7
ffffffffc020460e:	9a660613          	addi	a2,a2,-1626 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204612:	45d1                	li	a1,20
ffffffffc0204614:	00008517          	auipc	a0,0x8
ffffffffc0204618:	02450513          	addi	a0,a0,36 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc020461c:	e406                	sd	ra,8(sp)
ffffffffc020461e:	e81fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204622 <fd_array_alloc>:
ffffffffc0204622:	00091797          	auipc	a5,0x91
ffffffffc0204626:	29e7b783          	ld	a5,670(a5) # ffffffffc02958c0 <current>
ffffffffc020462a:	1487b783          	ld	a5,328(a5)
ffffffffc020462e:	1141                	addi	sp,sp,-16
ffffffffc0204630:	e406                	sd	ra,8(sp)
ffffffffc0204632:	c3a5                	beqz	a5,ffffffffc0204692 <fd_array_alloc+0x70>
ffffffffc0204634:	4b98                	lw	a4,16(a5)
ffffffffc0204636:	04e05e63          	blez	a4,ffffffffc0204692 <fd_array_alloc+0x70>
ffffffffc020463a:	775d                	lui	a4,0xffff7
ffffffffc020463c:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd611c9>
ffffffffc0204640:	679c                	ld	a5,8(a5)
ffffffffc0204642:	02e50863          	beq	a0,a4,ffffffffc0204672 <fd_array_alloc+0x50>
ffffffffc0204646:	04700713          	li	a4,71
ffffffffc020464a:	04a76263          	bltu	a4,a0,ffffffffc020468e <fd_array_alloc+0x6c>
ffffffffc020464e:	00351713          	slli	a4,a0,0x3
ffffffffc0204652:	40a70533          	sub	a0,a4,a0
ffffffffc0204656:	050e                	slli	a0,a0,0x3
ffffffffc0204658:	97aa                	add	a5,a5,a0
ffffffffc020465a:	4398                	lw	a4,0(a5)
ffffffffc020465c:	e71d                	bnez	a4,ffffffffc020468a <fd_array_alloc+0x68>
ffffffffc020465e:	5b88                	lw	a0,48(a5)
ffffffffc0204660:	e91d                	bnez	a0,ffffffffc0204696 <fd_array_alloc+0x74>
ffffffffc0204662:	4705                	li	a4,1
ffffffffc0204664:	c398                	sw	a4,0(a5)
ffffffffc0204666:	0207b423          	sd	zero,40(a5)
ffffffffc020466a:	e19c                	sd	a5,0(a1)
ffffffffc020466c:	60a2                	ld	ra,8(sp)
ffffffffc020466e:	0141                	addi	sp,sp,16
ffffffffc0204670:	8082                	ret
ffffffffc0204672:	6685                	lui	a3,0x1
ffffffffc0204674:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204678:	96be                	add	a3,a3,a5
ffffffffc020467a:	4398                	lw	a4,0(a5)
ffffffffc020467c:	d36d                	beqz	a4,ffffffffc020465e <fd_array_alloc+0x3c>
ffffffffc020467e:	03878793          	addi	a5,a5,56
ffffffffc0204682:	fef69ce3          	bne	a3,a5,ffffffffc020467a <fd_array_alloc+0x58>
ffffffffc0204686:	5529                	li	a0,-22
ffffffffc0204688:	b7d5                	j	ffffffffc020466c <fd_array_alloc+0x4a>
ffffffffc020468a:	5545                	li	a0,-15
ffffffffc020468c:	b7c5                	j	ffffffffc020466c <fd_array_alloc+0x4a>
ffffffffc020468e:	5575                	li	a0,-3
ffffffffc0204690:	bff1                	j	ffffffffc020466c <fd_array_alloc+0x4a>
ffffffffc0204692:	f6fff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>
ffffffffc0204696:	00008697          	auipc	a3,0x8
ffffffffc020469a:	fb268693          	addi	a3,a3,-78 # ffffffffc020c648 <default_pmm_manager+0xbb0>
ffffffffc020469e:	00007617          	auipc	a2,0x7
ffffffffc02046a2:	91260613          	addi	a2,a2,-1774 # ffffffffc020afb0 <commands+0x210>
ffffffffc02046a6:	03b00593          	li	a1,59
ffffffffc02046aa:	00008517          	auipc	a0,0x8
ffffffffc02046ae:	f8e50513          	addi	a0,a0,-114 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc02046b2:	dedfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046b6 <fd_array_free>:
ffffffffc02046b6:	411c                	lw	a5,0(a0)
ffffffffc02046b8:	1141                	addi	sp,sp,-16
ffffffffc02046ba:	e022                	sd	s0,0(sp)
ffffffffc02046bc:	e406                	sd	ra,8(sp)
ffffffffc02046be:	4705                	li	a4,1
ffffffffc02046c0:	842a                	mv	s0,a0
ffffffffc02046c2:	04e78063          	beq	a5,a4,ffffffffc0204702 <fd_array_free+0x4c>
ffffffffc02046c6:	470d                	li	a4,3
ffffffffc02046c8:	04e79563          	bne	a5,a4,ffffffffc0204712 <fd_array_free+0x5c>
ffffffffc02046cc:	591c                	lw	a5,48(a0)
ffffffffc02046ce:	c38d                	beqz	a5,ffffffffc02046f0 <fd_array_free+0x3a>
ffffffffc02046d0:	00008697          	auipc	a3,0x8
ffffffffc02046d4:	f7868693          	addi	a3,a3,-136 # ffffffffc020c648 <default_pmm_manager+0xbb0>
ffffffffc02046d8:	00007617          	auipc	a2,0x7
ffffffffc02046dc:	8d860613          	addi	a2,a2,-1832 # ffffffffc020afb0 <commands+0x210>
ffffffffc02046e0:	04500593          	li	a1,69
ffffffffc02046e4:	00008517          	auipc	a0,0x8
ffffffffc02046e8:	f5450513          	addi	a0,a0,-172 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc02046ec:	db3fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02046f0:	7408                	ld	a0,40(s0)
ffffffffc02046f2:	270030ef          	jal	ra,ffffffffc0207962 <vfs_close>
ffffffffc02046f6:	60a2                	ld	ra,8(sp)
ffffffffc02046f8:	00042023          	sw	zero,0(s0)
ffffffffc02046fc:	6402                	ld	s0,0(sp)
ffffffffc02046fe:	0141                	addi	sp,sp,16
ffffffffc0204700:	8082                	ret
ffffffffc0204702:	591c                	lw	a5,48(a0)
ffffffffc0204704:	f7f1                	bnez	a5,ffffffffc02046d0 <fd_array_free+0x1a>
ffffffffc0204706:	60a2                	ld	ra,8(sp)
ffffffffc0204708:	00042023          	sw	zero,0(s0)
ffffffffc020470c:	6402                	ld	s0,0(sp)
ffffffffc020470e:	0141                	addi	sp,sp,16
ffffffffc0204710:	8082                	ret
ffffffffc0204712:	00008697          	auipc	a3,0x8
ffffffffc0204716:	f6e68693          	addi	a3,a3,-146 # ffffffffc020c680 <default_pmm_manager+0xbe8>
ffffffffc020471a:	00007617          	auipc	a2,0x7
ffffffffc020471e:	89660613          	addi	a2,a2,-1898 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204722:	04400593          	li	a1,68
ffffffffc0204726:	00008517          	auipc	a0,0x8
ffffffffc020472a:	f1250513          	addi	a0,a0,-238 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc020472e:	d71fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204732 <fd_array_release>:
ffffffffc0204732:	4118                	lw	a4,0(a0)
ffffffffc0204734:	1141                	addi	sp,sp,-16
ffffffffc0204736:	e406                	sd	ra,8(sp)
ffffffffc0204738:	4685                	li	a3,1
ffffffffc020473a:	3779                	addiw	a4,a4,-2
ffffffffc020473c:	04e6e063          	bltu	a3,a4,ffffffffc020477c <fd_array_release+0x4a>
ffffffffc0204740:	5918                	lw	a4,48(a0)
ffffffffc0204742:	00e05d63          	blez	a4,ffffffffc020475c <fd_array_release+0x2a>
ffffffffc0204746:	fff7069b          	addiw	a3,a4,-1
ffffffffc020474a:	d914                	sw	a3,48(a0)
ffffffffc020474c:	c681                	beqz	a3,ffffffffc0204754 <fd_array_release+0x22>
ffffffffc020474e:	60a2                	ld	ra,8(sp)
ffffffffc0204750:	0141                	addi	sp,sp,16
ffffffffc0204752:	8082                	ret
ffffffffc0204754:	60a2                	ld	ra,8(sp)
ffffffffc0204756:	0141                	addi	sp,sp,16
ffffffffc0204758:	f5fff06f          	j	ffffffffc02046b6 <fd_array_free>
ffffffffc020475c:	00008697          	auipc	a3,0x8
ffffffffc0204760:	f9468693          	addi	a3,a3,-108 # ffffffffc020c6f0 <default_pmm_manager+0xc58>
ffffffffc0204764:	00007617          	auipc	a2,0x7
ffffffffc0204768:	84c60613          	addi	a2,a2,-1972 # ffffffffc020afb0 <commands+0x210>
ffffffffc020476c:	05600593          	li	a1,86
ffffffffc0204770:	00008517          	auipc	a0,0x8
ffffffffc0204774:	ec850513          	addi	a0,a0,-312 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204778:	d27fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020477c:	00008697          	auipc	a3,0x8
ffffffffc0204780:	f3c68693          	addi	a3,a3,-196 # ffffffffc020c6b8 <default_pmm_manager+0xc20>
ffffffffc0204784:	00007617          	auipc	a2,0x7
ffffffffc0204788:	82c60613          	addi	a2,a2,-2004 # ffffffffc020afb0 <commands+0x210>
ffffffffc020478c:	05500593          	li	a1,85
ffffffffc0204790:	00008517          	auipc	a0,0x8
ffffffffc0204794:	ea850513          	addi	a0,a0,-344 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204798:	d07fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020479c <fd_array_open.part.0>:
ffffffffc020479c:	1141                	addi	sp,sp,-16
ffffffffc020479e:	00008697          	auipc	a3,0x8
ffffffffc02047a2:	f6a68693          	addi	a3,a3,-150 # ffffffffc020c708 <default_pmm_manager+0xc70>
ffffffffc02047a6:	00007617          	auipc	a2,0x7
ffffffffc02047aa:	80a60613          	addi	a2,a2,-2038 # ffffffffc020afb0 <commands+0x210>
ffffffffc02047ae:	05f00593          	li	a1,95
ffffffffc02047b2:	00008517          	auipc	a0,0x8
ffffffffc02047b6:	e8650513          	addi	a0,a0,-378 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc02047ba:	e406                	sd	ra,8(sp)
ffffffffc02047bc:	ce3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02047c0 <fd_array_init>:
ffffffffc02047c0:	4781                	li	a5,0
ffffffffc02047c2:	04800713          	li	a4,72
ffffffffc02047c6:	cd1c                	sw	a5,24(a0)
ffffffffc02047c8:	02052823          	sw	zero,48(a0)
ffffffffc02047cc:	00052023          	sw	zero,0(a0)
ffffffffc02047d0:	2785                	addiw	a5,a5,1
ffffffffc02047d2:	03850513          	addi	a0,a0,56
ffffffffc02047d6:	fee798e3          	bne	a5,a4,ffffffffc02047c6 <fd_array_init+0x6>
ffffffffc02047da:	8082                	ret

ffffffffc02047dc <fd_array_close>:
ffffffffc02047dc:	4118                	lw	a4,0(a0)
ffffffffc02047de:	1141                	addi	sp,sp,-16
ffffffffc02047e0:	e406                	sd	ra,8(sp)
ffffffffc02047e2:	e022                	sd	s0,0(sp)
ffffffffc02047e4:	4789                	li	a5,2
ffffffffc02047e6:	04f71a63          	bne	a4,a5,ffffffffc020483a <fd_array_close+0x5e>
ffffffffc02047ea:	591c                	lw	a5,48(a0)
ffffffffc02047ec:	842a                	mv	s0,a0
ffffffffc02047ee:	02f05663          	blez	a5,ffffffffc020481a <fd_array_close+0x3e>
ffffffffc02047f2:	37fd                	addiw	a5,a5,-1
ffffffffc02047f4:	470d                	li	a4,3
ffffffffc02047f6:	c118                	sw	a4,0(a0)
ffffffffc02047f8:	d91c                	sw	a5,48(a0)
ffffffffc02047fa:	0007871b          	sext.w	a4,a5
ffffffffc02047fe:	c709                	beqz	a4,ffffffffc0204808 <fd_array_close+0x2c>
ffffffffc0204800:	60a2                	ld	ra,8(sp)
ffffffffc0204802:	6402                	ld	s0,0(sp)
ffffffffc0204804:	0141                	addi	sp,sp,16
ffffffffc0204806:	8082                	ret
ffffffffc0204808:	7508                	ld	a0,40(a0)
ffffffffc020480a:	158030ef          	jal	ra,ffffffffc0207962 <vfs_close>
ffffffffc020480e:	60a2                	ld	ra,8(sp)
ffffffffc0204810:	00042023          	sw	zero,0(s0)
ffffffffc0204814:	6402                	ld	s0,0(sp)
ffffffffc0204816:	0141                	addi	sp,sp,16
ffffffffc0204818:	8082                	ret
ffffffffc020481a:	00008697          	auipc	a3,0x8
ffffffffc020481e:	ed668693          	addi	a3,a3,-298 # ffffffffc020c6f0 <default_pmm_manager+0xc58>
ffffffffc0204822:	00006617          	auipc	a2,0x6
ffffffffc0204826:	78e60613          	addi	a2,a2,1934 # ffffffffc020afb0 <commands+0x210>
ffffffffc020482a:	06800593          	li	a1,104
ffffffffc020482e:	00008517          	auipc	a0,0x8
ffffffffc0204832:	e0a50513          	addi	a0,a0,-502 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204836:	c69fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020483a:	00008697          	auipc	a3,0x8
ffffffffc020483e:	e2668693          	addi	a3,a3,-474 # ffffffffc020c660 <default_pmm_manager+0xbc8>
ffffffffc0204842:	00006617          	auipc	a2,0x6
ffffffffc0204846:	76e60613          	addi	a2,a2,1902 # ffffffffc020afb0 <commands+0x210>
ffffffffc020484a:	06700593          	li	a1,103
ffffffffc020484e:	00008517          	auipc	a0,0x8
ffffffffc0204852:	dea50513          	addi	a0,a0,-534 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204856:	c49fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020485a <fd_array_dup>:
ffffffffc020485a:	7179                	addi	sp,sp,-48
ffffffffc020485c:	e84a                	sd	s2,16(sp)
ffffffffc020485e:	00052903          	lw	s2,0(a0)
ffffffffc0204862:	f406                	sd	ra,40(sp)
ffffffffc0204864:	f022                	sd	s0,32(sp)
ffffffffc0204866:	ec26                	sd	s1,24(sp)
ffffffffc0204868:	e44e                	sd	s3,8(sp)
ffffffffc020486a:	4785                	li	a5,1
ffffffffc020486c:	04f91663          	bne	s2,a5,ffffffffc02048b8 <fd_array_dup+0x5e>
ffffffffc0204870:	0005a983          	lw	s3,0(a1)
ffffffffc0204874:	4789                	li	a5,2
ffffffffc0204876:	04f99163          	bne	s3,a5,ffffffffc02048b8 <fd_array_dup+0x5e>
ffffffffc020487a:	7584                	ld	s1,40(a1)
ffffffffc020487c:	699c                	ld	a5,16(a1)
ffffffffc020487e:	7194                	ld	a3,32(a1)
ffffffffc0204880:	6598                	ld	a4,8(a1)
ffffffffc0204882:	842a                	mv	s0,a0
ffffffffc0204884:	e91c                	sd	a5,16(a0)
ffffffffc0204886:	f114                	sd	a3,32(a0)
ffffffffc0204888:	e518                	sd	a4,8(a0)
ffffffffc020488a:	8526                	mv	a0,s1
ffffffffc020488c:	035020ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0204890:	8526                	mv	a0,s1
ffffffffc0204892:	03b020ef          	jal	ra,ffffffffc02070cc <inode_open_inc>
ffffffffc0204896:	401c                	lw	a5,0(s0)
ffffffffc0204898:	f404                	sd	s1,40(s0)
ffffffffc020489a:	03279f63          	bne	a5,s2,ffffffffc02048d8 <fd_array_dup+0x7e>
ffffffffc020489e:	cc8d                	beqz	s1,ffffffffc02048d8 <fd_array_dup+0x7e>
ffffffffc02048a0:	581c                	lw	a5,48(s0)
ffffffffc02048a2:	01342023          	sw	s3,0(s0)
ffffffffc02048a6:	70a2                	ld	ra,40(sp)
ffffffffc02048a8:	2785                	addiw	a5,a5,1
ffffffffc02048aa:	d81c                	sw	a5,48(s0)
ffffffffc02048ac:	7402                	ld	s0,32(sp)
ffffffffc02048ae:	64e2                	ld	s1,24(sp)
ffffffffc02048b0:	6942                	ld	s2,16(sp)
ffffffffc02048b2:	69a2                	ld	s3,8(sp)
ffffffffc02048b4:	6145                	addi	sp,sp,48
ffffffffc02048b6:	8082                	ret
ffffffffc02048b8:	00008697          	auipc	a3,0x8
ffffffffc02048bc:	e8068693          	addi	a3,a3,-384 # ffffffffc020c738 <default_pmm_manager+0xca0>
ffffffffc02048c0:	00006617          	auipc	a2,0x6
ffffffffc02048c4:	6f060613          	addi	a2,a2,1776 # ffffffffc020afb0 <commands+0x210>
ffffffffc02048c8:	07300593          	li	a1,115
ffffffffc02048cc:	00008517          	auipc	a0,0x8
ffffffffc02048d0:	d6c50513          	addi	a0,a0,-660 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc02048d4:	bcbfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048d8:	ec5ff0ef          	jal	ra,ffffffffc020479c <fd_array_open.part.0>

ffffffffc02048dc <file_testfd>:
ffffffffc02048dc:	04700793          	li	a5,71
ffffffffc02048e0:	04a7e263          	bltu	a5,a0,ffffffffc0204924 <file_testfd+0x48>
ffffffffc02048e4:	00091797          	auipc	a5,0x91
ffffffffc02048e8:	fdc7b783          	ld	a5,-36(a5) # ffffffffc02958c0 <current>
ffffffffc02048ec:	1487b783          	ld	a5,328(a5)
ffffffffc02048f0:	cf85                	beqz	a5,ffffffffc0204928 <file_testfd+0x4c>
ffffffffc02048f2:	4b98                	lw	a4,16(a5)
ffffffffc02048f4:	02e05a63          	blez	a4,ffffffffc0204928 <file_testfd+0x4c>
ffffffffc02048f8:	6798                	ld	a4,8(a5)
ffffffffc02048fa:	00351793          	slli	a5,a0,0x3
ffffffffc02048fe:	8f89                	sub	a5,a5,a0
ffffffffc0204900:	078e                	slli	a5,a5,0x3
ffffffffc0204902:	97ba                	add	a5,a5,a4
ffffffffc0204904:	4394                	lw	a3,0(a5)
ffffffffc0204906:	4709                	li	a4,2
ffffffffc0204908:	00e69e63          	bne	a3,a4,ffffffffc0204924 <file_testfd+0x48>
ffffffffc020490c:	4f98                	lw	a4,24(a5)
ffffffffc020490e:	00a71b63          	bne	a4,a0,ffffffffc0204924 <file_testfd+0x48>
ffffffffc0204912:	c199                	beqz	a1,ffffffffc0204918 <file_testfd+0x3c>
ffffffffc0204914:	6788                	ld	a0,8(a5)
ffffffffc0204916:	c901                	beqz	a0,ffffffffc0204926 <file_testfd+0x4a>
ffffffffc0204918:	4505                	li	a0,1
ffffffffc020491a:	c611                	beqz	a2,ffffffffc0204926 <file_testfd+0x4a>
ffffffffc020491c:	6b88                	ld	a0,16(a5)
ffffffffc020491e:	00a03533          	snez	a0,a0
ffffffffc0204922:	8082                	ret
ffffffffc0204924:	4501                	li	a0,0
ffffffffc0204926:	8082                	ret
ffffffffc0204928:	1141                	addi	sp,sp,-16
ffffffffc020492a:	e406                	sd	ra,8(sp)
ffffffffc020492c:	cd5ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>

ffffffffc0204930 <file_open>:
ffffffffc0204930:	711d                	addi	sp,sp,-96
ffffffffc0204932:	ec86                	sd	ra,88(sp)
ffffffffc0204934:	e8a2                	sd	s0,80(sp)
ffffffffc0204936:	e4a6                	sd	s1,72(sp)
ffffffffc0204938:	e0ca                	sd	s2,64(sp)
ffffffffc020493a:	fc4e                	sd	s3,56(sp)
ffffffffc020493c:	f852                	sd	s4,48(sp)
ffffffffc020493e:	0035f793          	andi	a5,a1,3
ffffffffc0204942:	470d                	li	a4,3
ffffffffc0204944:	0ce78163          	beq	a5,a4,ffffffffc0204a06 <file_open+0xd6>
ffffffffc0204948:	078e                	slli	a5,a5,0x3
ffffffffc020494a:	00008717          	auipc	a4,0x8
ffffffffc020494e:	05e70713          	addi	a4,a4,94 # ffffffffc020c9a8 <CSWTCH.79>
ffffffffc0204952:	892a                	mv	s2,a0
ffffffffc0204954:	00008697          	auipc	a3,0x8
ffffffffc0204958:	03c68693          	addi	a3,a3,60 # ffffffffc020c990 <CSWTCH.78>
ffffffffc020495c:	755d                	lui	a0,0xffff7
ffffffffc020495e:	96be                	add	a3,a3,a5
ffffffffc0204960:	84ae                	mv	s1,a1
ffffffffc0204962:	97ba                	add	a5,a5,a4
ffffffffc0204964:	858a                	mv	a1,sp
ffffffffc0204966:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd611c9>
ffffffffc020496a:	0006ba03          	ld	s4,0(a3)
ffffffffc020496e:	0007b983          	ld	s3,0(a5)
ffffffffc0204972:	cb1ff0ef          	jal	ra,ffffffffc0204622 <fd_array_alloc>
ffffffffc0204976:	842a                	mv	s0,a0
ffffffffc0204978:	c911                	beqz	a0,ffffffffc020498c <file_open+0x5c>
ffffffffc020497a:	60e6                	ld	ra,88(sp)
ffffffffc020497c:	8522                	mv	a0,s0
ffffffffc020497e:	6446                	ld	s0,80(sp)
ffffffffc0204980:	64a6                	ld	s1,72(sp)
ffffffffc0204982:	6906                	ld	s2,64(sp)
ffffffffc0204984:	79e2                	ld	s3,56(sp)
ffffffffc0204986:	7a42                	ld	s4,48(sp)
ffffffffc0204988:	6125                	addi	sp,sp,96
ffffffffc020498a:	8082                	ret
ffffffffc020498c:	0030                	addi	a2,sp,8
ffffffffc020498e:	85a6                	mv	a1,s1
ffffffffc0204990:	854a                	mv	a0,s2
ffffffffc0204992:	62b020ef          	jal	ra,ffffffffc02077bc <vfs_open>
ffffffffc0204996:	842a                	mv	s0,a0
ffffffffc0204998:	e13d                	bnez	a0,ffffffffc02049fe <file_open+0xce>
ffffffffc020499a:	6782                	ld	a5,0(sp)
ffffffffc020499c:	0204f493          	andi	s1,s1,32
ffffffffc02049a0:	6422                	ld	s0,8(sp)
ffffffffc02049a2:	0207b023          	sd	zero,32(a5)
ffffffffc02049a6:	c885                	beqz	s1,ffffffffc02049d6 <file_open+0xa6>
ffffffffc02049a8:	c03d                	beqz	s0,ffffffffc0204a0e <file_open+0xde>
ffffffffc02049aa:	783c                	ld	a5,112(s0)
ffffffffc02049ac:	c3ad                	beqz	a5,ffffffffc0204a0e <file_open+0xde>
ffffffffc02049ae:	779c                	ld	a5,40(a5)
ffffffffc02049b0:	cfb9                	beqz	a5,ffffffffc0204a0e <file_open+0xde>
ffffffffc02049b2:	8522                	mv	a0,s0
ffffffffc02049b4:	00008597          	auipc	a1,0x8
ffffffffc02049b8:	e0c58593          	addi	a1,a1,-500 # ffffffffc020c7c0 <default_pmm_manager+0xd28>
ffffffffc02049bc:	71c020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc02049c0:	783c                	ld	a5,112(s0)
ffffffffc02049c2:	6522                	ld	a0,8(sp)
ffffffffc02049c4:	080c                	addi	a1,sp,16
ffffffffc02049c6:	779c                	ld	a5,40(a5)
ffffffffc02049c8:	9782                	jalr	a5
ffffffffc02049ca:	842a                	mv	s0,a0
ffffffffc02049cc:	e515                	bnez	a0,ffffffffc02049f8 <file_open+0xc8>
ffffffffc02049ce:	6782                	ld	a5,0(sp)
ffffffffc02049d0:	7722                	ld	a4,40(sp)
ffffffffc02049d2:	6422                	ld	s0,8(sp)
ffffffffc02049d4:	f398                	sd	a4,32(a5)
ffffffffc02049d6:	4394                	lw	a3,0(a5)
ffffffffc02049d8:	f780                	sd	s0,40(a5)
ffffffffc02049da:	0147b423          	sd	s4,8(a5)
ffffffffc02049de:	0137b823          	sd	s3,16(a5)
ffffffffc02049e2:	4705                	li	a4,1
ffffffffc02049e4:	02e69363          	bne	a3,a4,ffffffffc0204a0a <file_open+0xda>
ffffffffc02049e8:	c00d                	beqz	s0,ffffffffc0204a0a <file_open+0xda>
ffffffffc02049ea:	5b98                	lw	a4,48(a5)
ffffffffc02049ec:	4689                	li	a3,2
ffffffffc02049ee:	4f80                	lw	s0,24(a5)
ffffffffc02049f0:	2705                	addiw	a4,a4,1
ffffffffc02049f2:	c394                	sw	a3,0(a5)
ffffffffc02049f4:	db98                	sw	a4,48(a5)
ffffffffc02049f6:	b751                	j	ffffffffc020497a <file_open+0x4a>
ffffffffc02049f8:	6522                	ld	a0,8(sp)
ffffffffc02049fa:	769020ef          	jal	ra,ffffffffc0207962 <vfs_close>
ffffffffc02049fe:	6502                	ld	a0,0(sp)
ffffffffc0204a00:	cb7ff0ef          	jal	ra,ffffffffc02046b6 <fd_array_free>
ffffffffc0204a04:	bf9d                	j	ffffffffc020497a <file_open+0x4a>
ffffffffc0204a06:	5475                	li	s0,-3
ffffffffc0204a08:	bf8d                	j	ffffffffc020497a <file_open+0x4a>
ffffffffc0204a0a:	d93ff0ef          	jal	ra,ffffffffc020479c <fd_array_open.part.0>
ffffffffc0204a0e:	00008697          	auipc	a3,0x8
ffffffffc0204a12:	d6268693          	addi	a3,a3,-670 # ffffffffc020c770 <default_pmm_manager+0xcd8>
ffffffffc0204a16:	00006617          	auipc	a2,0x6
ffffffffc0204a1a:	59a60613          	addi	a2,a2,1434 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204a1e:	0b500593          	li	a1,181
ffffffffc0204a22:	00008517          	auipc	a0,0x8
ffffffffc0204a26:	c1650513          	addi	a0,a0,-1002 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204a2a:	a75fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204a2e <file_close>:
ffffffffc0204a2e:	04700713          	li	a4,71
ffffffffc0204a32:	04a76563          	bltu	a4,a0,ffffffffc0204a7c <file_close+0x4e>
ffffffffc0204a36:	00091717          	auipc	a4,0x91
ffffffffc0204a3a:	e8a73703          	ld	a4,-374(a4) # ffffffffc02958c0 <current>
ffffffffc0204a3e:	14873703          	ld	a4,328(a4)
ffffffffc0204a42:	1141                	addi	sp,sp,-16
ffffffffc0204a44:	e406                	sd	ra,8(sp)
ffffffffc0204a46:	cf0d                	beqz	a4,ffffffffc0204a80 <file_close+0x52>
ffffffffc0204a48:	4b14                	lw	a3,16(a4)
ffffffffc0204a4a:	02d05b63          	blez	a3,ffffffffc0204a80 <file_close+0x52>
ffffffffc0204a4e:	6718                	ld	a4,8(a4)
ffffffffc0204a50:	87aa                	mv	a5,a0
ffffffffc0204a52:	050e                	slli	a0,a0,0x3
ffffffffc0204a54:	8d1d                	sub	a0,a0,a5
ffffffffc0204a56:	050e                	slli	a0,a0,0x3
ffffffffc0204a58:	953a                	add	a0,a0,a4
ffffffffc0204a5a:	4114                	lw	a3,0(a0)
ffffffffc0204a5c:	4709                	li	a4,2
ffffffffc0204a5e:	00e69b63          	bne	a3,a4,ffffffffc0204a74 <file_close+0x46>
ffffffffc0204a62:	4d18                	lw	a4,24(a0)
ffffffffc0204a64:	00f71863          	bne	a4,a5,ffffffffc0204a74 <file_close+0x46>
ffffffffc0204a68:	d75ff0ef          	jal	ra,ffffffffc02047dc <fd_array_close>
ffffffffc0204a6c:	60a2                	ld	ra,8(sp)
ffffffffc0204a6e:	4501                	li	a0,0
ffffffffc0204a70:	0141                	addi	sp,sp,16
ffffffffc0204a72:	8082                	ret
ffffffffc0204a74:	60a2                	ld	ra,8(sp)
ffffffffc0204a76:	5575                	li	a0,-3
ffffffffc0204a78:	0141                	addi	sp,sp,16
ffffffffc0204a7a:	8082                	ret
ffffffffc0204a7c:	5575                	li	a0,-3
ffffffffc0204a7e:	8082                	ret
ffffffffc0204a80:	b81ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>

ffffffffc0204a84 <file_read>:
ffffffffc0204a84:	715d                	addi	sp,sp,-80
ffffffffc0204a86:	e486                	sd	ra,72(sp)
ffffffffc0204a88:	e0a2                	sd	s0,64(sp)
ffffffffc0204a8a:	fc26                	sd	s1,56(sp)
ffffffffc0204a8c:	f84a                	sd	s2,48(sp)
ffffffffc0204a8e:	f44e                	sd	s3,40(sp)
ffffffffc0204a90:	f052                	sd	s4,32(sp)
ffffffffc0204a92:	0006b023          	sd	zero,0(a3)
ffffffffc0204a96:	04700793          	li	a5,71
ffffffffc0204a9a:	0aa7e463          	bltu	a5,a0,ffffffffc0204b42 <file_read+0xbe>
ffffffffc0204a9e:	00091797          	auipc	a5,0x91
ffffffffc0204aa2:	e227b783          	ld	a5,-478(a5) # ffffffffc02958c0 <current>
ffffffffc0204aa6:	1487b783          	ld	a5,328(a5)
ffffffffc0204aaa:	cfd1                	beqz	a5,ffffffffc0204b46 <file_read+0xc2>
ffffffffc0204aac:	4b98                	lw	a4,16(a5)
ffffffffc0204aae:	08e05c63          	blez	a4,ffffffffc0204b46 <file_read+0xc2>
ffffffffc0204ab2:	6780                	ld	s0,8(a5)
ffffffffc0204ab4:	00351793          	slli	a5,a0,0x3
ffffffffc0204ab8:	8f89                	sub	a5,a5,a0
ffffffffc0204aba:	078e                	slli	a5,a5,0x3
ffffffffc0204abc:	943e                	add	s0,s0,a5
ffffffffc0204abe:	00042983          	lw	s3,0(s0)
ffffffffc0204ac2:	4789                	li	a5,2
ffffffffc0204ac4:	06f99f63          	bne	s3,a5,ffffffffc0204b42 <file_read+0xbe>
ffffffffc0204ac8:	4c1c                	lw	a5,24(s0)
ffffffffc0204aca:	06a79c63          	bne	a5,a0,ffffffffc0204b42 <file_read+0xbe>
ffffffffc0204ace:	641c                	ld	a5,8(s0)
ffffffffc0204ad0:	cbad                	beqz	a5,ffffffffc0204b42 <file_read+0xbe>
ffffffffc0204ad2:	581c                	lw	a5,48(s0)
ffffffffc0204ad4:	8a36                	mv	s4,a3
ffffffffc0204ad6:	7014                	ld	a3,32(s0)
ffffffffc0204ad8:	2785                	addiw	a5,a5,1
ffffffffc0204ada:	850a                	mv	a0,sp
ffffffffc0204adc:	d81c                	sw	a5,48(s0)
ffffffffc0204ade:	792000ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc0204ae2:	02843903          	ld	s2,40(s0)
ffffffffc0204ae6:	84aa                	mv	s1,a0
ffffffffc0204ae8:	06090163          	beqz	s2,ffffffffc0204b4a <file_read+0xc6>
ffffffffc0204aec:	07093783          	ld	a5,112(s2)
ffffffffc0204af0:	cfa9                	beqz	a5,ffffffffc0204b4a <file_read+0xc6>
ffffffffc0204af2:	6f9c                	ld	a5,24(a5)
ffffffffc0204af4:	cbb9                	beqz	a5,ffffffffc0204b4a <file_read+0xc6>
ffffffffc0204af6:	00008597          	auipc	a1,0x8
ffffffffc0204afa:	d2258593          	addi	a1,a1,-734 # ffffffffc020c818 <default_pmm_manager+0xd80>
ffffffffc0204afe:	854a                	mv	a0,s2
ffffffffc0204b00:	5d8020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204b04:	07093783          	ld	a5,112(s2)
ffffffffc0204b08:	7408                	ld	a0,40(s0)
ffffffffc0204b0a:	85a6                	mv	a1,s1
ffffffffc0204b0c:	6f9c                	ld	a5,24(a5)
ffffffffc0204b0e:	9782                	jalr	a5
ffffffffc0204b10:	689c                	ld	a5,16(s1)
ffffffffc0204b12:	6c94                	ld	a3,24(s1)
ffffffffc0204b14:	4018                	lw	a4,0(s0)
ffffffffc0204b16:	84aa                	mv	s1,a0
ffffffffc0204b18:	8f95                	sub	a5,a5,a3
ffffffffc0204b1a:	03370063          	beq	a4,s3,ffffffffc0204b3a <file_read+0xb6>
ffffffffc0204b1e:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204b22:	8522                	mv	a0,s0
ffffffffc0204b24:	c0fff0ef          	jal	ra,ffffffffc0204732 <fd_array_release>
ffffffffc0204b28:	60a6                	ld	ra,72(sp)
ffffffffc0204b2a:	6406                	ld	s0,64(sp)
ffffffffc0204b2c:	7942                	ld	s2,48(sp)
ffffffffc0204b2e:	79a2                	ld	s3,40(sp)
ffffffffc0204b30:	7a02                	ld	s4,32(sp)
ffffffffc0204b32:	8526                	mv	a0,s1
ffffffffc0204b34:	74e2                	ld	s1,56(sp)
ffffffffc0204b36:	6161                	addi	sp,sp,80
ffffffffc0204b38:	8082                	ret
ffffffffc0204b3a:	7018                	ld	a4,32(s0)
ffffffffc0204b3c:	973e                	add	a4,a4,a5
ffffffffc0204b3e:	f018                	sd	a4,32(s0)
ffffffffc0204b40:	bff9                	j	ffffffffc0204b1e <file_read+0x9a>
ffffffffc0204b42:	54f5                	li	s1,-3
ffffffffc0204b44:	b7d5                	j	ffffffffc0204b28 <file_read+0xa4>
ffffffffc0204b46:	abbff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>
ffffffffc0204b4a:	00008697          	auipc	a3,0x8
ffffffffc0204b4e:	c7e68693          	addi	a3,a3,-898 # ffffffffc020c7c8 <default_pmm_manager+0xd30>
ffffffffc0204b52:	00006617          	auipc	a2,0x6
ffffffffc0204b56:	45e60613          	addi	a2,a2,1118 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204b5a:	0de00593          	li	a1,222
ffffffffc0204b5e:	00008517          	auipc	a0,0x8
ffffffffc0204b62:	ada50513          	addi	a0,a0,-1318 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204b66:	939fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204b6a <file_write>:
ffffffffc0204b6a:	715d                	addi	sp,sp,-80
ffffffffc0204b6c:	e486                	sd	ra,72(sp)
ffffffffc0204b6e:	e0a2                	sd	s0,64(sp)
ffffffffc0204b70:	fc26                	sd	s1,56(sp)
ffffffffc0204b72:	f84a                	sd	s2,48(sp)
ffffffffc0204b74:	f44e                	sd	s3,40(sp)
ffffffffc0204b76:	f052                	sd	s4,32(sp)
ffffffffc0204b78:	0006b023          	sd	zero,0(a3)
ffffffffc0204b7c:	04700793          	li	a5,71
ffffffffc0204b80:	0aa7e463          	bltu	a5,a0,ffffffffc0204c28 <file_write+0xbe>
ffffffffc0204b84:	00091797          	auipc	a5,0x91
ffffffffc0204b88:	d3c7b783          	ld	a5,-708(a5) # ffffffffc02958c0 <current>
ffffffffc0204b8c:	1487b783          	ld	a5,328(a5)
ffffffffc0204b90:	cfd1                	beqz	a5,ffffffffc0204c2c <file_write+0xc2>
ffffffffc0204b92:	4b98                	lw	a4,16(a5)
ffffffffc0204b94:	08e05c63          	blez	a4,ffffffffc0204c2c <file_write+0xc2>
ffffffffc0204b98:	6780                	ld	s0,8(a5)
ffffffffc0204b9a:	00351793          	slli	a5,a0,0x3
ffffffffc0204b9e:	8f89                	sub	a5,a5,a0
ffffffffc0204ba0:	078e                	slli	a5,a5,0x3
ffffffffc0204ba2:	943e                	add	s0,s0,a5
ffffffffc0204ba4:	00042983          	lw	s3,0(s0)
ffffffffc0204ba8:	4789                	li	a5,2
ffffffffc0204baa:	06f99f63          	bne	s3,a5,ffffffffc0204c28 <file_write+0xbe>
ffffffffc0204bae:	4c1c                	lw	a5,24(s0)
ffffffffc0204bb0:	06a79c63          	bne	a5,a0,ffffffffc0204c28 <file_write+0xbe>
ffffffffc0204bb4:	681c                	ld	a5,16(s0)
ffffffffc0204bb6:	cbad                	beqz	a5,ffffffffc0204c28 <file_write+0xbe>
ffffffffc0204bb8:	581c                	lw	a5,48(s0)
ffffffffc0204bba:	8a36                	mv	s4,a3
ffffffffc0204bbc:	7014                	ld	a3,32(s0)
ffffffffc0204bbe:	2785                	addiw	a5,a5,1
ffffffffc0204bc0:	850a                	mv	a0,sp
ffffffffc0204bc2:	d81c                	sw	a5,48(s0)
ffffffffc0204bc4:	6ac000ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc0204bc8:	02843903          	ld	s2,40(s0)
ffffffffc0204bcc:	84aa                	mv	s1,a0
ffffffffc0204bce:	06090163          	beqz	s2,ffffffffc0204c30 <file_write+0xc6>
ffffffffc0204bd2:	07093783          	ld	a5,112(s2)
ffffffffc0204bd6:	cfa9                	beqz	a5,ffffffffc0204c30 <file_write+0xc6>
ffffffffc0204bd8:	739c                	ld	a5,32(a5)
ffffffffc0204bda:	cbb9                	beqz	a5,ffffffffc0204c30 <file_write+0xc6>
ffffffffc0204bdc:	00008597          	auipc	a1,0x8
ffffffffc0204be0:	c9458593          	addi	a1,a1,-876 # ffffffffc020c870 <default_pmm_manager+0xdd8>
ffffffffc0204be4:	854a                	mv	a0,s2
ffffffffc0204be6:	4f2020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204bea:	07093783          	ld	a5,112(s2)
ffffffffc0204bee:	7408                	ld	a0,40(s0)
ffffffffc0204bf0:	85a6                	mv	a1,s1
ffffffffc0204bf2:	739c                	ld	a5,32(a5)
ffffffffc0204bf4:	9782                	jalr	a5
ffffffffc0204bf6:	689c                	ld	a5,16(s1)
ffffffffc0204bf8:	6c94                	ld	a3,24(s1)
ffffffffc0204bfa:	4018                	lw	a4,0(s0)
ffffffffc0204bfc:	84aa                	mv	s1,a0
ffffffffc0204bfe:	8f95                	sub	a5,a5,a3
ffffffffc0204c00:	03370063          	beq	a4,s3,ffffffffc0204c20 <file_write+0xb6>
ffffffffc0204c04:	00fa3023          	sd	a5,0(s4)
ffffffffc0204c08:	8522                	mv	a0,s0
ffffffffc0204c0a:	b29ff0ef          	jal	ra,ffffffffc0204732 <fd_array_release>
ffffffffc0204c0e:	60a6                	ld	ra,72(sp)
ffffffffc0204c10:	6406                	ld	s0,64(sp)
ffffffffc0204c12:	7942                	ld	s2,48(sp)
ffffffffc0204c14:	79a2                	ld	s3,40(sp)
ffffffffc0204c16:	7a02                	ld	s4,32(sp)
ffffffffc0204c18:	8526                	mv	a0,s1
ffffffffc0204c1a:	74e2                	ld	s1,56(sp)
ffffffffc0204c1c:	6161                	addi	sp,sp,80
ffffffffc0204c1e:	8082                	ret
ffffffffc0204c20:	7018                	ld	a4,32(s0)
ffffffffc0204c22:	973e                	add	a4,a4,a5
ffffffffc0204c24:	f018                	sd	a4,32(s0)
ffffffffc0204c26:	bff9                	j	ffffffffc0204c04 <file_write+0x9a>
ffffffffc0204c28:	54f5                	li	s1,-3
ffffffffc0204c2a:	b7d5                	j	ffffffffc0204c0e <file_write+0xa4>
ffffffffc0204c2c:	9d5ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>
ffffffffc0204c30:	00008697          	auipc	a3,0x8
ffffffffc0204c34:	bf068693          	addi	a3,a3,-1040 # ffffffffc020c820 <default_pmm_manager+0xd88>
ffffffffc0204c38:	00006617          	auipc	a2,0x6
ffffffffc0204c3c:	37860613          	addi	a2,a2,888 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204c40:	0f800593          	li	a1,248
ffffffffc0204c44:	00008517          	auipc	a0,0x8
ffffffffc0204c48:	9f450513          	addi	a0,a0,-1548 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204c4c:	853fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204c50 <file_seek>:
ffffffffc0204c50:	7139                	addi	sp,sp,-64
ffffffffc0204c52:	fc06                	sd	ra,56(sp)
ffffffffc0204c54:	f822                	sd	s0,48(sp)
ffffffffc0204c56:	f426                	sd	s1,40(sp)
ffffffffc0204c58:	f04a                	sd	s2,32(sp)
ffffffffc0204c5a:	04700793          	li	a5,71
ffffffffc0204c5e:	08a7e863          	bltu	a5,a0,ffffffffc0204cee <file_seek+0x9e>
ffffffffc0204c62:	00091797          	auipc	a5,0x91
ffffffffc0204c66:	c5e7b783          	ld	a5,-930(a5) # ffffffffc02958c0 <current>
ffffffffc0204c6a:	1487b783          	ld	a5,328(a5)
ffffffffc0204c6e:	cfdd                	beqz	a5,ffffffffc0204d2c <file_seek+0xdc>
ffffffffc0204c70:	4b98                	lw	a4,16(a5)
ffffffffc0204c72:	0ae05d63          	blez	a4,ffffffffc0204d2c <file_seek+0xdc>
ffffffffc0204c76:	6780                	ld	s0,8(a5)
ffffffffc0204c78:	00351793          	slli	a5,a0,0x3
ffffffffc0204c7c:	8f89                	sub	a5,a5,a0
ffffffffc0204c7e:	078e                	slli	a5,a5,0x3
ffffffffc0204c80:	943e                	add	s0,s0,a5
ffffffffc0204c82:	4018                	lw	a4,0(s0)
ffffffffc0204c84:	4789                	li	a5,2
ffffffffc0204c86:	06f71463          	bne	a4,a5,ffffffffc0204cee <file_seek+0x9e>
ffffffffc0204c8a:	4c1c                	lw	a5,24(s0)
ffffffffc0204c8c:	06a79163          	bne	a5,a0,ffffffffc0204cee <file_seek+0x9e>
ffffffffc0204c90:	581c                	lw	a5,48(s0)
ffffffffc0204c92:	4685                	li	a3,1
ffffffffc0204c94:	892e                	mv	s2,a1
ffffffffc0204c96:	2785                	addiw	a5,a5,1
ffffffffc0204c98:	d81c                	sw	a5,48(s0)
ffffffffc0204c9a:	02d60063          	beq	a2,a3,ffffffffc0204cba <file_seek+0x6a>
ffffffffc0204c9e:	06e60063          	beq	a2,a4,ffffffffc0204cfe <file_seek+0xae>
ffffffffc0204ca2:	54f5                	li	s1,-3
ffffffffc0204ca4:	ce11                	beqz	a2,ffffffffc0204cc0 <file_seek+0x70>
ffffffffc0204ca6:	8522                	mv	a0,s0
ffffffffc0204ca8:	a8bff0ef          	jal	ra,ffffffffc0204732 <fd_array_release>
ffffffffc0204cac:	70e2                	ld	ra,56(sp)
ffffffffc0204cae:	7442                	ld	s0,48(sp)
ffffffffc0204cb0:	7902                	ld	s2,32(sp)
ffffffffc0204cb2:	8526                	mv	a0,s1
ffffffffc0204cb4:	74a2                	ld	s1,40(sp)
ffffffffc0204cb6:	6121                	addi	sp,sp,64
ffffffffc0204cb8:	8082                	ret
ffffffffc0204cba:	701c                	ld	a5,32(s0)
ffffffffc0204cbc:	00f58933          	add	s2,a1,a5
ffffffffc0204cc0:	7404                	ld	s1,40(s0)
ffffffffc0204cc2:	c4bd                	beqz	s1,ffffffffc0204d30 <file_seek+0xe0>
ffffffffc0204cc4:	78bc                	ld	a5,112(s1)
ffffffffc0204cc6:	c7ad                	beqz	a5,ffffffffc0204d30 <file_seek+0xe0>
ffffffffc0204cc8:	6fbc                	ld	a5,88(a5)
ffffffffc0204cca:	c3bd                	beqz	a5,ffffffffc0204d30 <file_seek+0xe0>
ffffffffc0204ccc:	8526                	mv	a0,s1
ffffffffc0204cce:	00008597          	auipc	a1,0x8
ffffffffc0204cd2:	bfa58593          	addi	a1,a1,-1030 # ffffffffc020c8c8 <default_pmm_manager+0xe30>
ffffffffc0204cd6:	402020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204cda:	78bc                	ld	a5,112(s1)
ffffffffc0204cdc:	7408                	ld	a0,40(s0)
ffffffffc0204cde:	85ca                	mv	a1,s2
ffffffffc0204ce0:	6fbc                	ld	a5,88(a5)
ffffffffc0204ce2:	9782                	jalr	a5
ffffffffc0204ce4:	84aa                	mv	s1,a0
ffffffffc0204ce6:	f161                	bnez	a0,ffffffffc0204ca6 <file_seek+0x56>
ffffffffc0204ce8:	03243023          	sd	s2,32(s0)
ffffffffc0204cec:	bf6d                	j	ffffffffc0204ca6 <file_seek+0x56>
ffffffffc0204cee:	70e2                	ld	ra,56(sp)
ffffffffc0204cf0:	7442                	ld	s0,48(sp)
ffffffffc0204cf2:	54f5                	li	s1,-3
ffffffffc0204cf4:	7902                	ld	s2,32(sp)
ffffffffc0204cf6:	8526                	mv	a0,s1
ffffffffc0204cf8:	74a2                	ld	s1,40(sp)
ffffffffc0204cfa:	6121                	addi	sp,sp,64
ffffffffc0204cfc:	8082                	ret
ffffffffc0204cfe:	7404                	ld	s1,40(s0)
ffffffffc0204d00:	c8a1                	beqz	s1,ffffffffc0204d50 <file_seek+0x100>
ffffffffc0204d02:	78bc                	ld	a5,112(s1)
ffffffffc0204d04:	c7b1                	beqz	a5,ffffffffc0204d50 <file_seek+0x100>
ffffffffc0204d06:	779c                	ld	a5,40(a5)
ffffffffc0204d08:	c7a1                	beqz	a5,ffffffffc0204d50 <file_seek+0x100>
ffffffffc0204d0a:	8526                	mv	a0,s1
ffffffffc0204d0c:	00008597          	auipc	a1,0x8
ffffffffc0204d10:	ab458593          	addi	a1,a1,-1356 # ffffffffc020c7c0 <default_pmm_manager+0xd28>
ffffffffc0204d14:	3c4020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204d18:	78bc                	ld	a5,112(s1)
ffffffffc0204d1a:	7408                	ld	a0,40(s0)
ffffffffc0204d1c:	858a                	mv	a1,sp
ffffffffc0204d1e:	779c                	ld	a5,40(a5)
ffffffffc0204d20:	9782                	jalr	a5
ffffffffc0204d22:	84aa                	mv	s1,a0
ffffffffc0204d24:	f149                	bnez	a0,ffffffffc0204ca6 <file_seek+0x56>
ffffffffc0204d26:	67e2                	ld	a5,24(sp)
ffffffffc0204d28:	993e                	add	s2,s2,a5
ffffffffc0204d2a:	bf59                	j	ffffffffc0204cc0 <file_seek+0x70>
ffffffffc0204d2c:	8d5ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>
ffffffffc0204d30:	00008697          	auipc	a3,0x8
ffffffffc0204d34:	b4868693          	addi	a3,a3,-1208 # ffffffffc020c878 <default_pmm_manager+0xde0>
ffffffffc0204d38:	00006617          	auipc	a2,0x6
ffffffffc0204d3c:	27860613          	addi	a2,a2,632 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204d40:	11a00593          	li	a1,282
ffffffffc0204d44:	00008517          	auipc	a0,0x8
ffffffffc0204d48:	8f450513          	addi	a0,a0,-1804 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204d4c:	f52fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204d50:	00008697          	auipc	a3,0x8
ffffffffc0204d54:	a2068693          	addi	a3,a3,-1504 # ffffffffc020c770 <default_pmm_manager+0xcd8>
ffffffffc0204d58:	00006617          	auipc	a2,0x6
ffffffffc0204d5c:	25860613          	addi	a2,a2,600 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204d60:	11200593          	li	a1,274
ffffffffc0204d64:	00008517          	auipc	a0,0x8
ffffffffc0204d68:	8d450513          	addi	a0,a0,-1836 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204d6c:	f32fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204d70 <file_fstat>:
ffffffffc0204d70:	1101                	addi	sp,sp,-32
ffffffffc0204d72:	ec06                	sd	ra,24(sp)
ffffffffc0204d74:	e822                	sd	s0,16(sp)
ffffffffc0204d76:	e426                	sd	s1,8(sp)
ffffffffc0204d78:	e04a                	sd	s2,0(sp)
ffffffffc0204d7a:	04700793          	li	a5,71
ffffffffc0204d7e:	06a7ef63          	bltu	a5,a0,ffffffffc0204dfc <file_fstat+0x8c>
ffffffffc0204d82:	00091797          	auipc	a5,0x91
ffffffffc0204d86:	b3e7b783          	ld	a5,-1218(a5) # ffffffffc02958c0 <current>
ffffffffc0204d8a:	1487b783          	ld	a5,328(a5)
ffffffffc0204d8e:	cfd9                	beqz	a5,ffffffffc0204e2c <file_fstat+0xbc>
ffffffffc0204d90:	4b98                	lw	a4,16(a5)
ffffffffc0204d92:	08e05d63          	blez	a4,ffffffffc0204e2c <file_fstat+0xbc>
ffffffffc0204d96:	6780                	ld	s0,8(a5)
ffffffffc0204d98:	00351793          	slli	a5,a0,0x3
ffffffffc0204d9c:	8f89                	sub	a5,a5,a0
ffffffffc0204d9e:	078e                	slli	a5,a5,0x3
ffffffffc0204da0:	943e                	add	s0,s0,a5
ffffffffc0204da2:	4018                	lw	a4,0(s0)
ffffffffc0204da4:	4789                	li	a5,2
ffffffffc0204da6:	04f71b63          	bne	a4,a5,ffffffffc0204dfc <file_fstat+0x8c>
ffffffffc0204daa:	4c1c                	lw	a5,24(s0)
ffffffffc0204dac:	04a79863          	bne	a5,a0,ffffffffc0204dfc <file_fstat+0x8c>
ffffffffc0204db0:	581c                	lw	a5,48(s0)
ffffffffc0204db2:	02843903          	ld	s2,40(s0)
ffffffffc0204db6:	2785                	addiw	a5,a5,1
ffffffffc0204db8:	d81c                	sw	a5,48(s0)
ffffffffc0204dba:	04090963          	beqz	s2,ffffffffc0204e0c <file_fstat+0x9c>
ffffffffc0204dbe:	07093783          	ld	a5,112(s2)
ffffffffc0204dc2:	c7a9                	beqz	a5,ffffffffc0204e0c <file_fstat+0x9c>
ffffffffc0204dc4:	779c                	ld	a5,40(a5)
ffffffffc0204dc6:	c3b9                	beqz	a5,ffffffffc0204e0c <file_fstat+0x9c>
ffffffffc0204dc8:	84ae                	mv	s1,a1
ffffffffc0204dca:	854a                	mv	a0,s2
ffffffffc0204dcc:	00008597          	auipc	a1,0x8
ffffffffc0204dd0:	9f458593          	addi	a1,a1,-1548 # ffffffffc020c7c0 <default_pmm_manager+0xd28>
ffffffffc0204dd4:	304020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204dd8:	07093783          	ld	a5,112(s2)
ffffffffc0204ddc:	7408                	ld	a0,40(s0)
ffffffffc0204dde:	85a6                	mv	a1,s1
ffffffffc0204de0:	779c                	ld	a5,40(a5)
ffffffffc0204de2:	9782                	jalr	a5
ffffffffc0204de4:	87aa                	mv	a5,a0
ffffffffc0204de6:	8522                	mv	a0,s0
ffffffffc0204de8:	843e                	mv	s0,a5
ffffffffc0204dea:	949ff0ef          	jal	ra,ffffffffc0204732 <fd_array_release>
ffffffffc0204dee:	60e2                	ld	ra,24(sp)
ffffffffc0204df0:	8522                	mv	a0,s0
ffffffffc0204df2:	6442                	ld	s0,16(sp)
ffffffffc0204df4:	64a2                	ld	s1,8(sp)
ffffffffc0204df6:	6902                	ld	s2,0(sp)
ffffffffc0204df8:	6105                	addi	sp,sp,32
ffffffffc0204dfa:	8082                	ret
ffffffffc0204dfc:	5475                	li	s0,-3
ffffffffc0204dfe:	60e2                	ld	ra,24(sp)
ffffffffc0204e00:	8522                	mv	a0,s0
ffffffffc0204e02:	6442                	ld	s0,16(sp)
ffffffffc0204e04:	64a2                	ld	s1,8(sp)
ffffffffc0204e06:	6902                	ld	s2,0(sp)
ffffffffc0204e08:	6105                	addi	sp,sp,32
ffffffffc0204e0a:	8082                	ret
ffffffffc0204e0c:	00008697          	auipc	a3,0x8
ffffffffc0204e10:	96468693          	addi	a3,a3,-1692 # ffffffffc020c770 <default_pmm_manager+0xcd8>
ffffffffc0204e14:	00006617          	auipc	a2,0x6
ffffffffc0204e18:	19c60613          	addi	a2,a2,412 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204e1c:	12c00593          	li	a1,300
ffffffffc0204e20:	00008517          	auipc	a0,0x8
ffffffffc0204e24:	81850513          	addi	a0,a0,-2024 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204e28:	e76fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204e2c:	fd4ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>

ffffffffc0204e30 <file_fsync>:
ffffffffc0204e30:	1101                	addi	sp,sp,-32
ffffffffc0204e32:	ec06                	sd	ra,24(sp)
ffffffffc0204e34:	e822                	sd	s0,16(sp)
ffffffffc0204e36:	e426                	sd	s1,8(sp)
ffffffffc0204e38:	04700793          	li	a5,71
ffffffffc0204e3c:	06a7e863          	bltu	a5,a0,ffffffffc0204eac <file_fsync+0x7c>
ffffffffc0204e40:	00091797          	auipc	a5,0x91
ffffffffc0204e44:	a807b783          	ld	a5,-1408(a5) # ffffffffc02958c0 <current>
ffffffffc0204e48:	1487b783          	ld	a5,328(a5)
ffffffffc0204e4c:	c7d9                	beqz	a5,ffffffffc0204eda <file_fsync+0xaa>
ffffffffc0204e4e:	4b98                	lw	a4,16(a5)
ffffffffc0204e50:	08e05563          	blez	a4,ffffffffc0204eda <file_fsync+0xaa>
ffffffffc0204e54:	6780                	ld	s0,8(a5)
ffffffffc0204e56:	00351793          	slli	a5,a0,0x3
ffffffffc0204e5a:	8f89                	sub	a5,a5,a0
ffffffffc0204e5c:	078e                	slli	a5,a5,0x3
ffffffffc0204e5e:	943e                	add	s0,s0,a5
ffffffffc0204e60:	4018                	lw	a4,0(s0)
ffffffffc0204e62:	4789                	li	a5,2
ffffffffc0204e64:	04f71463          	bne	a4,a5,ffffffffc0204eac <file_fsync+0x7c>
ffffffffc0204e68:	4c1c                	lw	a5,24(s0)
ffffffffc0204e6a:	04a79163          	bne	a5,a0,ffffffffc0204eac <file_fsync+0x7c>
ffffffffc0204e6e:	581c                	lw	a5,48(s0)
ffffffffc0204e70:	7404                	ld	s1,40(s0)
ffffffffc0204e72:	2785                	addiw	a5,a5,1
ffffffffc0204e74:	d81c                	sw	a5,48(s0)
ffffffffc0204e76:	c0b1                	beqz	s1,ffffffffc0204eba <file_fsync+0x8a>
ffffffffc0204e78:	78bc                	ld	a5,112(s1)
ffffffffc0204e7a:	c3a1                	beqz	a5,ffffffffc0204eba <file_fsync+0x8a>
ffffffffc0204e7c:	7b9c                	ld	a5,48(a5)
ffffffffc0204e7e:	cf95                	beqz	a5,ffffffffc0204eba <file_fsync+0x8a>
ffffffffc0204e80:	00008597          	auipc	a1,0x8
ffffffffc0204e84:	aa058593          	addi	a1,a1,-1376 # ffffffffc020c920 <default_pmm_manager+0xe88>
ffffffffc0204e88:	8526                	mv	a0,s1
ffffffffc0204e8a:	24e020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204e8e:	78bc                	ld	a5,112(s1)
ffffffffc0204e90:	7408                	ld	a0,40(s0)
ffffffffc0204e92:	7b9c                	ld	a5,48(a5)
ffffffffc0204e94:	9782                	jalr	a5
ffffffffc0204e96:	87aa                	mv	a5,a0
ffffffffc0204e98:	8522                	mv	a0,s0
ffffffffc0204e9a:	843e                	mv	s0,a5
ffffffffc0204e9c:	897ff0ef          	jal	ra,ffffffffc0204732 <fd_array_release>
ffffffffc0204ea0:	60e2                	ld	ra,24(sp)
ffffffffc0204ea2:	8522                	mv	a0,s0
ffffffffc0204ea4:	6442                	ld	s0,16(sp)
ffffffffc0204ea6:	64a2                	ld	s1,8(sp)
ffffffffc0204ea8:	6105                	addi	sp,sp,32
ffffffffc0204eaa:	8082                	ret
ffffffffc0204eac:	5475                	li	s0,-3
ffffffffc0204eae:	60e2                	ld	ra,24(sp)
ffffffffc0204eb0:	8522                	mv	a0,s0
ffffffffc0204eb2:	6442                	ld	s0,16(sp)
ffffffffc0204eb4:	64a2                	ld	s1,8(sp)
ffffffffc0204eb6:	6105                	addi	sp,sp,32
ffffffffc0204eb8:	8082                	ret
ffffffffc0204eba:	00008697          	auipc	a3,0x8
ffffffffc0204ebe:	a1668693          	addi	a3,a3,-1514 # ffffffffc020c8d0 <default_pmm_manager+0xe38>
ffffffffc0204ec2:	00006617          	auipc	a2,0x6
ffffffffc0204ec6:	0ee60613          	addi	a2,a2,238 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204eca:	13a00593          	li	a1,314
ffffffffc0204ece:	00007517          	auipc	a0,0x7
ffffffffc0204ed2:	76a50513          	addi	a0,a0,1898 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204ed6:	dc8fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204eda:	f26ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>

ffffffffc0204ede <file_getdirentry>:
ffffffffc0204ede:	715d                	addi	sp,sp,-80
ffffffffc0204ee0:	e486                	sd	ra,72(sp)
ffffffffc0204ee2:	e0a2                	sd	s0,64(sp)
ffffffffc0204ee4:	fc26                	sd	s1,56(sp)
ffffffffc0204ee6:	f84a                	sd	s2,48(sp)
ffffffffc0204ee8:	f44e                	sd	s3,40(sp)
ffffffffc0204eea:	04700793          	li	a5,71
ffffffffc0204eee:	0aa7e063          	bltu	a5,a0,ffffffffc0204f8e <file_getdirentry+0xb0>
ffffffffc0204ef2:	00091797          	auipc	a5,0x91
ffffffffc0204ef6:	9ce7b783          	ld	a5,-1586(a5) # ffffffffc02958c0 <current>
ffffffffc0204efa:	1487b783          	ld	a5,328(a5)
ffffffffc0204efe:	c3e9                	beqz	a5,ffffffffc0204fc0 <file_getdirentry+0xe2>
ffffffffc0204f00:	4b98                	lw	a4,16(a5)
ffffffffc0204f02:	0ae05f63          	blez	a4,ffffffffc0204fc0 <file_getdirentry+0xe2>
ffffffffc0204f06:	6780                	ld	s0,8(a5)
ffffffffc0204f08:	00351793          	slli	a5,a0,0x3
ffffffffc0204f0c:	8f89                	sub	a5,a5,a0
ffffffffc0204f0e:	078e                	slli	a5,a5,0x3
ffffffffc0204f10:	943e                	add	s0,s0,a5
ffffffffc0204f12:	4018                	lw	a4,0(s0)
ffffffffc0204f14:	4789                	li	a5,2
ffffffffc0204f16:	06f71c63          	bne	a4,a5,ffffffffc0204f8e <file_getdirentry+0xb0>
ffffffffc0204f1a:	4c1c                	lw	a5,24(s0)
ffffffffc0204f1c:	06a79963          	bne	a5,a0,ffffffffc0204f8e <file_getdirentry+0xb0>
ffffffffc0204f20:	581c                	lw	a5,48(s0)
ffffffffc0204f22:	6194                	ld	a3,0(a1)
ffffffffc0204f24:	84ae                	mv	s1,a1
ffffffffc0204f26:	2785                	addiw	a5,a5,1
ffffffffc0204f28:	10000613          	li	a2,256
ffffffffc0204f2c:	d81c                	sw	a5,48(s0)
ffffffffc0204f2e:	05a1                	addi	a1,a1,8
ffffffffc0204f30:	850a                	mv	a0,sp
ffffffffc0204f32:	33e000ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc0204f36:	02843983          	ld	s3,40(s0)
ffffffffc0204f3a:	892a                	mv	s2,a0
ffffffffc0204f3c:	06098263          	beqz	s3,ffffffffc0204fa0 <file_getdirentry+0xc2>
ffffffffc0204f40:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc0204f44:	cfb1                	beqz	a5,ffffffffc0204fa0 <file_getdirentry+0xc2>
ffffffffc0204f46:	63bc                	ld	a5,64(a5)
ffffffffc0204f48:	cfa1                	beqz	a5,ffffffffc0204fa0 <file_getdirentry+0xc2>
ffffffffc0204f4a:	854e                	mv	a0,s3
ffffffffc0204f4c:	00008597          	auipc	a1,0x8
ffffffffc0204f50:	a3458593          	addi	a1,a1,-1484 # ffffffffc020c980 <default_pmm_manager+0xee8>
ffffffffc0204f54:	184020ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0204f58:	0709b783          	ld	a5,112(s3)
ffffffffc0204f5c:	7408                	ld	a0,40(s0)
ffffffffc0204f5e:	85ca                	mv	a1,s2
ffffffffc0204f60:	63bc                	ld	a5,64(a5)
ffffffffc0204f62:	9782                	jalr	a5
ffffffffc0204f64:	89aa                	mv	s3,a0
ffffffffc0204f66:	e909                	bnez	a0,ffffffffc0204f78 <file_getdirentry+0x9a>
ffffffffc0204f68:	609c                	ld	a5,0(s1)
ffffffffc0204f6a:	01093683          	ld	a3,16(s2)
ffffffffc0204f6e:	01893703          	ld	a4,24(s2)
ffffffffc0204f72:	97b6                	add	a5,a5,a3
ffffffffc0204f74:	8f99                	sub	a5,a5,a4
ffffffffc0204f76:	e09c                	sd	a5,0(s1)
ffffffffc0204f78:	8522                	mv	a0,s0
ffffffffc0204f7a:	fb8ff0ef          	jal	ra,ffffffffc0204732 <fd_array_release>
ffffffffc0204f7e:	60a6                	ld	ra,72(sp)
ffffffffc0204f80:	6406                	ld	s0,64(sp)
ffffffffc0204f82:	74e2                	ld	s1,56(sp)
ffffffffc0204f84:	7942                	ld	s2,48(sp)
ffffffffc0204f86:	854e                	mv	a0,s3
ffffffffc0204f88:	79a2                	ld	s3,40(sp)
ffffffffc0204f8a:	6161                	addi	sp,sp,80
ffffffffc0204f8c:	8082                	ret
ffffffffc0204f8e:	60a6                	ld	ra,72(sp)
ffffffffc0204f90:	6406                	ld	s0,64(sp)
ffffffffc0204f92:	59f5                	li	s3,-3
ffffffffc0204f94:	74e2                	ld	s1,56(sp)
ffffffffc0204f96:	7942                	ld	s2,48(sp)
ffffffffc0204f98:	854e                	mv	a0,s3
ffffffffc0204f9a:	79a2                	ld	s3,40(sp)
ffffffffc0204f9c:	6161                	addi	sp,sp,80
ffffffffc0204f9e:	8082                	ret
ffffffffc0204fa0:	00008697          	auipc	a3,0x8
ffffffffc0204fa4:	98868693          	addi	a3,a3,-1656 # ffffffffc020c928 <default_pmm_manager+0xe90>
ffffffffc0204fa8:	00006617          	auipc	a2,0x6
ffffffffc0204fac:	00860613          	addi	a2,a2,8 # ffffffffc020afb0 <commands+0x210>
ffffffffc0204fb0:	14a00593          	li	a1,330
ffffffffc0204fb4:	00007517          	auipc	a0,0x7
ffffffffc0204fb8:	68450513          	addi	a0,a0,1668 # ffffffffc020c638 <default_pmm_manager+0xba0>
ffffffffc0204fbc:	ce2fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204fc0:	e40ff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>

ffffffffc0204fc4 <file_dup>:
ffffffffc0204fc4:	04700713          	li	a4,71
ffffffffc0204fc8:	06a76463          	bltu	a4,a0,ffffffffc0205030 <file_dup+0x6c>
ffffffffc0204fcc:	00091717          	auipc	a4,0x91
ffffffffc0204fd0:	8f473703          	ld	a4,-1804(a4) # ffffffffc02958c0 <current>
ffffffffc0204fd4:	14873703          	ld	a4,328(a4)
ffffffffc0204fd8:	1101                	addi	sp,sp,-32
ffffffffc0204fda:	ec06                	sd	ra,24(sp)
ffffffffc0204fdc:	e822                	sd	s0,16(sp)
ffffffffc0204fde:	cb39                	beqz	a4,ffffffffc0205034 <file_dup+0x70>
ffffffffc0204fe0:	4b14                	lw	a3,16(a4)
ffffffffc0204fe2:	04d05963          	blez	a3,ffffffffc0205034 <file_dup+0x70>
ffffffffc0204fe6:	6700                	ld	s0,8(a4)
ffffffffc0204fe8:	00351713          	slli	a4,a0,0x3
ffffffffc0204fec:	8f09                	sub	a4,a4,a0
ffffffffc0204fee:	070e                	slli	a4,a4,0x3
ffffffffc0204ff0:	943a                	add	s0,s0,a4
ffffffffc0204ff2:	4014                	lw	a3,0(s0)
ffffffffc0204ff4:	4709                	li	a4,2
ffffffffc0204ff6:	02e69863          	bne	a3,a4,ffffffffc0205026 <file_dup+0x62>
ffffffffc0204ffa:	4c18                	lw	a4,24(s0)
ffffffffc0204ffc:	02a71563          	bne	a4,a0,ffffffffc0205026 <file_dup+0x62>
ffffffffc0205000:	852e                	mv	a0,a1
ffffffffc0205002:	002c                	addi	a1,sp,8
ffffffffc0205004:	e1eff0ef          	jal	ra,ffffffffc0204622 <fd_array_alloc>
ffffffffc0205008:	c509                	beqz	a0,ffffffffc0205012 <file_dup+0x4e>
ffffffffc020500a:	60e2                	ld	ra,24(sp)
ffffffffc020500c:	6442                	ld	s0,16(sp)
ffffffffc020500e:	6105                	addi	sp,sp,32
ffffffffc0205010:	8082                	ret
ffffffffc0205012:	6522                	ld	a0,8(sp)
ffffffffc0205014:	85a2                	mv	a1,s0
ffffffffc0205016:	845ff0ef          	jal	ra,ffffffffc020485a <fd_array_dup>
ffffffffc020501a:	67a2                	ld	a5,8(sp)
ffffffffc020501c:	60e2                	ld	ra,24(sp)
ffffffffc020501e:	6442                	ld	s0,16(sp)
ffffffffc0205020:	4f88                	lw	a0,24(a5)
ffffffffc0205022:	6105                	addi	sp,sp,32
ffffffffc0205024:	8082                	ret
ffffffffc0205026:	60e2                	ld	ra,24(sp)
ffffffffc0205028:	6442                	ld	s0,16(sp)
ffffffffc020502a:	5575                	li	a0,-3
ffffffffc020502c:	6105                	addi	sp,sp,32
ffffffffc020502e:	8082                	ret
ffffffffc0205030:	5575                	li	a0,-3
ffffffffc0205032:	8082                	ret
ffffffffc0205034:	dccff0ef          	jal	ra,ffffffffc0204600 <get_fd_array.part.0>

ffffffffc0205038 <fs_init>:
ffffffffc0205038:	1141                	addi	sp,sp,-16
ffffffffc020503a:	e406                	sd	ra,8(sp)
ffffffffc020503c:	2ba020ef          	jal	ra,ffffffffc02072f6 <vfs_init>
ffffffffc0205040:	793020ef          	jal	ra,ffffffffc0207fd2 <dev_init>
ffffffffc0205044:	60a2                	ld	ra,8(sp)
ffffffffc0205046:	0141                	addi	sp,sp,16
ffffffffc0205048:	0e30306f          	j	ffffffffc020892a <sfs_init>

ffffffffc020504c <fs_cleanup>:
ffffffffc020504c:	4fc0206f          	j	ffffffffc0207548 <vfs_cleanup>

ffffffffc0205050 <lock_files>:
ffffffffc0205050:	0561                	addi	a0,a0,24
ffffffffc0205052:	ba0ff06f          	j	ffffffffc02043f2 <down>

ffffffffc0205056 <unlock_files>:
ffffffffc0205056:	0561                	addi	a0,a0,24
ffffffffc0205058:	b96ff06f          	j	ffffffffc02043ee <up>

ffffffffc020505c <files_create>:
ffffffffc020505c:	1141                	addi	sp,sp,-16
ffffffffc020505e:	6505                	lui	a0,0x1
ffffffffc0205060:	e022                	sd	s0,0(sp)
ffffffffc0205062:	e406                	sd	ra,8(sp)
ffffffffc0205064:	f2bfc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205068:	842a                	mv	s0,a0
ffffffffc020506a:	cd19                	beqz	a0,ffffffffc0205088 <files_create+0x2c>
ffffffffc020506c:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0205070:	00043023          	sd	zero,0(s0)
ffffffffc0205074:	0561                	addi	a0,a0,24
ffffffffc0205076:	e41c                	sd	a5,8(s0)
ffffffffc0205078:	00042823          	sw	zero,16(s0)
ffffffffc020507c:	4585                	li	a1,1
ffffffffc020507e:	b6aff0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0205082:	6408                	ld	a0,8(s0)
ffffffffc0205084:	f3cff0ef          	jal	ra,ffffffffc02047c0 <fd_array_init>
ffffffffc0205088:	60a2                	ld	ra,8(sp)
ffffffffc020508a:	8522                	mv	a0,s0
ffffffffc020508c:	6402                	ld	s0,0(sp)
ffffffffc020508e:	0141                	addi	sp,sp,16
ffffffffc0205090:	8082                	ret

ffffffffc0205092 <files_destroy>:
ffffffffc0205092:	7179                	addi	sp,sp,-48
ffffffffc0205094:	f406                	sd	ra,40(sp)
ffffffffc0205096:	f022                	sd	s0,32(sp)
ffffffffc0205098:	ec26                	sd	s1,24(sp)
ffffffffc020509a:	e84a                	sd	s2,16(sp)
ffffffffc020509c:	e44e                	sd	s3,8(sp)
ffffffffc020509e:	c52d                	beqz	a0,ffffffffc0205108 <files_destroy+0x76>
ffffffffc02050a0:	491c                	lw	a5,16(a0)
ffffffffc02050a2:	89aa                	mv	s3,a0
ffffffffc02050a4:	e3b5                	bnez	a5,ffffffffc0205108 <files_destroy+0x76>
ffffffffc02050a6:	6108                	ld	a0,0(a0)
ffffffffc02050a8:	c119                	beqz	a0,ffffffffc02050ae <files_destroy+0x1c>
ffffffffc02050aa:	0e4020ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc02050ae:	0089b403          	ld	s0,8(s3)
ffffffffc02050b2:	6485                	lui	s1,0x1
ffffffffc02050b4:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02050b8:	94a2                	add	s1,s1,s0
ffffffffc02050ba:	4909                	li	s2,2
ffffffffc02050bc:	401c                	lw	a5,0(s0)
ffffffffc02050be:	03278063          	beq	a5,s2,ffffffffc02050de <files_destroy+0x4c>
ffffffffc02050c2:	e39d                	bnez	a5,ffffffffc02050e8 <files_destroy+0x56>
ffffffffc02050c4:	03840413          	addi	s0,s0,56
ffffffffc02050c8:	fe849ae3          	bne	s1,s0,ffffffffc02050bc <files_destroy+0x2a>
ffffffffc02050cc:	7402                	ld	s0,32(sp)
ffffffffc02050ce:	70a2                	ld	ra,40(sp)
ffffffffc02050d0:	64e2                	ld	s1,24(sp)
ffffffffc02050d2:	6942                	ld	s2,16(sp)
ffffffffc02050d4:	854e                	mv	a0,s3
ffffffffc02050d6:	69a2                	ld	s3,8(sp)
ffffffffc02050d8:	6145                	addi	sp,sp,48
ffffffffc02050da:	f65fc06f          	j	ffffffffc020203e <kfree>
ffffffffc02050de:	8522                	mv	a0,s0
ffffffffc02050e0:	efcff0ef          	jal	ra,ffffffffc02047dc <fd_array_close>
ffffffffc02050e4:	401c                	lw	a5,0(s0)
ffffffffc02050e6:	bff1                	j	ffffffffc02050c2 <files_destroy+0x30>
ffffffffc02050e8:	00008697          	auipc	a3,0x8
ffffffffc02050ec:	91868693          	addi	a3,a3,-1768 # ffffffffc020ca00 <CSWTCH.79+0x58>
ffffffffc02050f0:	00006617          	auipc	a2,0x6
ffffffffc02050f4:	ec060613          	addi	a2,a2,-320 # ffffffffc020afb0 <commands+0x210>
ffffffffc02050f8:	03d00593          	li	a1,61
ffffffffc02050fc:	00008517          	auipc	a0,0x8
ffffffffc0205100:	8f450513          	addi	a0,a0,-1804 # ffffffffc020c9f0 <CSWTCH.79+0x48>
ffffffffc0205104:	b9afb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205108:	00008697          	auipc	a3,0x8
ffffffffc020510c:	8b868693          	addi	a3,a3,-1864 # ffffffffc020c9c0 <CSWTCH.79+0x18>
ffffffffc0205110:	00006617          	auipc	a2,0x6
ffffffffc0205114:	ea060613          	addi	a2,a2,-352 # ffffffffc020afb0 <commands+0x210>
ffffffffc0205118:	03300593          	li	a1,51
ffffffffc020511c:	00008517          	auipc	a0,0x8
ffffffffc0205120:	8d450513          	addi	a0,a0,-1836 # ffffffffc020c9f0 <CSWTCH.79+0x48>
ffffffffc0205124:	b7afb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205128 <files_closeall>:
ffffffffc0205128:	1101                	addi	sp,sp,-32
ffffffffc020512a:	ec06                	sd	ra,24(sp)
ffffffffc020512c:	e822                	sd	s0,16(sp)
ffffffffc020512e:	e426                	sd	s1,8(sp)
ffffffffc0205130:	e04a                	sd	s2,0(sp)
ffffffffc0205132:	c129                	beqz	a0,ffffffffc0205174 <files_closeall+0x4c>
ffffffffc0205134:	491c                	lw	a5,16(a0)
ffffffffc0205136:	02f05f63          	blez	a5,ffffffffc0205174 <files_closeall+0x4c>
ffffffffc020513a:	6504                	ld	s1,8(a0)
ffffffffc020513c:	6785                	lui	a5,0x1
ffffffffc020513e:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205142:	07048413          	addi	s0,s1,112
ffffffffc0205146:	4909                	li	s2,2
ffffffffc0205148:	94be                	add	s1,s1,a5
ffffffffc020514a:	a029                	j	ffffffffc0205154 <files_closeall+0x2c>
ffffffffc020514c:	03840413          	addi	s0,s0,56
ffffffffc0205150:	00848c63          	beq	s1,s0,ffffffffc0205168 <files_closeall+0x40>
ffffffffc0205154:	401c                	lw	a5,0(s0)
ffffffffc0205156:	ff279be3          	bne	a5,s2,ffffffffc020514c <files_closeall+0x24>
ffffffffc020515a:	8522                	mv	a0,s0
ffffffffc020515c:	03840413          	addi	s0,s0,56
ffffffffc0205160:	e7cff0ef          	jal	ra,ffffffffc02047dc <fd_array_close>
ffffffffc0205164:	fe8498e3          	bne	s1,s0,ffffffffc0205154 <files_closeall+0x2c>
ffffffffc0205168:	60e2                	ld	ra,24(sp)
ffffffffc020516a:	6442                	ld	s0,16(sp)
ffffffffc020516c:	64a2                	ld	s1,8(sp)
ffffffffc020516e:	6902                	ld	s2,0(sp)
ffffffffc0205170:	6105                	addi	sp,sp,32
ffffffffc0205172:	8082                	ret
ffffffffc0205174:	00007697          	auipc	a3,0x7
ffffffffc0205178:	49468693          	addi	a3,a3,1172 # ffffffffc020c608 <default_pmm_manager+0xb70>
ffffffffc020517c:	00006617          	auipc	a2,0x6
ffffffffc0205180:	e3460613          	addi	a2,a2,-460 # ffffffffc020afb0 <commands+0x210>
ffffffffc0205184:	04500593          	li	a1,69
ffffffffc0205188:	00008517          	auipc	a0,0x8
ffffffffc020518c:	86850513          	addi	a0,a0,-1944 # ffffffffc020c9f0 <CSWTCH.79+0x48>
ffffffffc0205190:	b0efb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205194 <dup_files>:
ffffffffc0205194:	7179                	addi	sp,sp,-48
ffffffffc0205196:	f406                	sd	ra,40(sp)
ffffffffc0205198:	f022                	sd	s0,32(sp)
ffffffffc020519a:	ec26                	sd	s1,24(sp)
ffffffffc020519c:	e84a                	sd	s2,16(sp)
ffffffffc020519e:	e44e                	sd	s3,8(sp)
ffffffffc02051a0:	e052                	sd	s4,0(sp)
ffffffffc02051a2:	c52d                	beqz	a0,ffffffffc020520c <dup_files+0x78>
ffffffffc02051a4:	842e                	mv	s0,a1
ffffffffc02051a6:	c1bd                	beqz	a1,ffffffffc020520c <dup_files+0x78>
ffffffffc02051a8:	491c                	lw	a5,16(a0)
ffffffffc02051aa:	84aa                	mv	s1,a0
ffffffffc02051ac:	e3c1                	bnez	a5,ffffffffc020522c <dup_files+0x98>
ffffffffc02051ae:	499c                	lw	a5,16(a1)
ffffffffc02051b0:	06f05e63          	blez	a5,ffffffffc020522c <dup_files+0x98>
ffffffffc02051b4:	6188                	ld	a0,0(a1)
ffffffffc02051b6:	e088                	sd	a0,0(s1)
ffffffffc02051b8:	c119                	beqz	a0,ffffffffc02051be <dup_files+0x2a>
ffffffffc02051ba:	707010ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc02051be:	6400                	ld	s0,8(s0)
ffffffffc02051c0:	6905                	lui	s2,0x1
ffffffffc02051c2:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02051c6:	6484                	ld	s1,8(s1)
ffffffffc02051c8:	9922                	add	s2,s2,s0
ffffffffc02051ca:	4989                	li	s3,2
ffffffffc02051cc:	4a05                	li	s4,1
ffffffffc02051ce:	a039                	j	ffffffffc02051dc <dup_files+0x48>
ffffffffc02051d0:	03840413          	addi	s0,s0,56
ffffffffc02051d4:	03848493          	addi	s1,s1,56
ffffffffc02051d8:	02890163          	beq	s2,s0,ffffffffc02051fa <dup_files+0x66>
ffffffffc02051dc:	401c                	lw	a5,0(s0)
ffffffffc02051de:	ff3799e3          	bne	a5,s3,ffffffffc02051d0 <dup_files+0x3c>
ffffffffc02051e2:	0144a023          	sw	s4,0(s1)
ffffffffc02051e6:	85a2                	mv	a1,s0
ffffffffc02051e8:	8526                	mv	a0,s1
ffffffffc02051ea:	03840413          	addi	s0,s0,56
ffffffffc02051ee:	e6cff0ef          	jal	ra,ffffffffc020485a <fd_array_dup>
ffffffffc02051f2:	03848493          	addi	s1,s1,56
ffffffffc02051f6:	fe8913e3          	bne	s2,s0,ffffffffc02051dc <dup_files+0x48>
ffffffffc02051fa:	70a2                	ld	ra,40(sp)
ffffffffc02051fc:	7402                	ld	s0,32(sp)
ffffffffc02051fe:	64e2                	ld	s1,24(sp)
ffffffffc0205200:	6942                	ld	s2,16(sp)
ffffffffc0205202:	69a2                	ld	s3,8(sp)
ffffffffc0205204:	6a02                	ld	s4,0(sp)
ffffffffc0205206:	4501                	li	a0,0
ffffffffc0205208:	6145                	addi	sp,sp,48
ffffffffc020520a:	8082                	ret
ffffffffc020520c:	00007697          	auipc	a3,0x7
ffffffffc0205210:	14c68693          	addi	a3,a3,332 # ffffffffc020c358 <default_pmm_manager+0x8c0>
ffffffffc0205214:	00006617          	auipc	a2,0x6
ffffffffc0205218:	d9c60613          	addi	a2,a2,-612 # ffffffffc020afb0 <commands+0x210>
ffffffffc020521c:	05300593          	li	a1,83
ffffffffc0205220:	00007517          	auipc	a0,0x7
ffffffffc0205224:	7d050513          	addi	a0,a0,2000 # ffffffffc020c9f0 <CSWTCH.79+0x48>
ffffffffc0205228:	a76fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020522c:	00007697          	auipc	a3,0x7
ffffffffc0205230:	7ec68693          	addi	a3,a3,2028 # ffffffffc020ca18 <CSWTCH.79+0x70>
ffffffffc0205234:	00006617          	auipc	a2,0x6
ffffffffc0205238:	d7c60613          	addi	a2,a2,-644 # ffffffffc020afb0 <commands+0x210>
ffffffffc020523c:	05400593          	li	a1,84
ffffffffc0205240:	00007517          	auipc	a0,0x7
ffffffffc0205244:	7b050513          	addi	a0,a0,1968 # ffffffffc020c9f0 <CSWTCH.79+0x48>
ffffffffc0205248:	a56fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020524c <iobuf_skip.part.0>:
ffffffffc020524c:	1141                	addi	sp,sp,-16
ffffffffc020524e:	00007697          	auipc	a3,0x7
ffffffffc0205252:	7fa68693          	addi	a3,a3,2042 # ffffffffc020ca48 <CSWTCH.79+0xa0>
ffffffffc0205256:	00006617          	auipc	a2,0x6
ffffffffc020525a:	d5a60613          	addi	a2,a2,-678 # ffffffffc020afb0 <commands+0x210>
ffffffffc020525e:	04a00593          	li	a1,74
ffffffffc0205262:	00007517          	auipc	a0,0x7
ffffffffc0205266:	7fe50513          	addi	a0,a0,2046 # ffffffffc020ca60 <CSWTCH.79+0xb8>
ffffffffc020526a:	e406                	sd	ra,8(sp)
ffffffffc020526c:	a32fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205270 <iobuf_init>:
ffffffffc0205270:	e10c                	sd	a1,0(a0)
ffffffffc0205272:	e514                	sd	a3,8(a0)
ffffffffc0205274:	ed10                	sd	a2,24(a0)
ffffffffc0205276:	e910                	sd	a2,16(a0)
ffffffffc0205278:	8082                	ret

ffffffffc020527a <iobuf_move>:
ffffffffc020527a:	7179                	addi	sp,sp,-48
ffffffffc020527c:	ec26                	sd	s1,24(sp)
ffffffffc020527e:	6d04                	ld	s1,24(a0)
ffffffffc0205280:	f022                	sd	s0,32(sp)
ffffffffc0205282:	e84a                	sd	s2,16(sp)
ffffffffc0205284:	e44e                	sd	s3,8(sp)
ffffffffc0205286:	f406                	sd	ra,40(sp)
ffffffffc0205288:	842a                	mv	s0,a0
ffffffffc020528a:	8932                	mv	s2,a2
ffffffffc020528c:	852e                	mv	a0,a1
ffffffffc020528e:	89ba                	mv	s3,a4
ffffffffc0205290:	00967363          	bgeu	a2,s1,ffffffffc0205296 <iobuf_move+0x1c>
ffffffffc0205294:	84b2                	mv	s1,a2
ffffffffc0205296:	c495                	beqz	s1,ffffffffc02052c2 <iobuf_move+0x48>
ffffffffc0205298:	600c                	ld	a1,0(s0)
ffffffffc020529a:	c681                	beqz	a3,ffffffffc02052a2 <iobuf_move+0x28>
ffffffffc020529c:	87ae                	mv	a5,a1
ffffffffc020529e:	85aa                	mv	a1,a0
ffffffffc02052a0:	853e                	mv	a0,a5
ffffffffc02052a2:	8626                	mv	a2,s1
ffffffffc02052a4:	03d050ef          	jal	ra,ffffffffc020aae0 <memmove>
ffffffffc02052a8:	6c1c                	ld	a5,24(s0)
ffffffffc02052aa:	0297ea63          	bltu	a5,s1,ffffffffc02052de <iobuf_move+0x64>
ffffffffc02052ae:	6014                	ld	a3,0(s0)
ffffffffc02052b0:	6418                	ld	a4,8(s0)
ffffffffc02052b2:	8f85                	sub	a5,a5,s1
ffffffffc02052b4:	96a6                	add	a3,a3,s1
ffffffffc02052b6:	9726                	add	a4,a4,s1
ffffffffc02052b8:	e014                	sd	a3,0(s0)
ffffffffc02052ba:	e418                	sd	a4,8(s0)
ffffffffc02052bc:	ec1c                	sd	a5,24(s0)
ffffffffc02052be:	40990933          	sub	s2,s2,s1
ffffffffc02052c2:	00098463          	beqz	s3,ffffffffc02052ca <iobuf_move+0x50>
ffffffffc02052c6:	0099b023          	sd	s1,0(s3)
ffffffffc02052ca:	4501                	li	a0,0
ffffffffc02052cc:	00091b63          	bnez	s2,ffffffffc02052e2 <iobuf_move+0x68>
ffffffffc02052d0:	70a2                	ld	ra,40(sp)
ffffffffc02052d2:	7402                	ld	s0,32(sp)
ffffffffc02052d4:	64e2                	ld	s1,24(sp)
ffffffffc02052d6:	6942                	ld	s2,16(sp)
ffffffffc02052d8:	69a2                	ld	s3,8(sp)
ffffffffc02052da:	6145                	addi	sp,sp,48
ffffffffc02052dc:	8082                	ret
ffffffffc02052de:	f6fff0ef          	jal	ra,ffffffffc020524c <iobuf_skip.part.0>
ffffffffc02052e2:	5571                	li	a0,-4
ffffffffc02052e4:	b7f5                	j	ffffffffc02052d0 <iobuf_move+0x56>

ffffffffc02052e6 <iobuf_skip>:
ffffffffc02052e6:	6d1c                	ld	a5,24(a0)
ffffffffc02052e8:	00b7eb63          	bltu	a5,a1,ffffffffc02052fe <iobuf_skip+0x18>
ffffffffc02052ec:	6114                	ld	a3,0(a0)
ffffffffc02052ee:	6518                	ld	a4,8(a0)
ffffffffc02052f0:	8f8d                	sub	a5,a5,a1
ffffffffc02052f2:	96ae                	add	a3,a3,a1
ffffffffc02052f4:	95ba                	add	a1,a1,a4
ffffffffc02052f6:	e114                	sd	a3,0(a0)
ffffffffc02052f8:	e50c                	sd	a1,8(a0)
ffffffffc02052fa:	ed1c                	sd	a5,24(a0)
ffffffffc02052fc:	8082                	ret
ffffffffc02052fe:	1141                	addi	sp,sp,-16
ffffffffc0205300:	e406                	sd	ra,8(sp)
ffffffffc0205302:	f4bff0ef          	jal	ra,ffffffffc020524c <iobuf_skip.part.0>

ffffffffc0205306 <copy_path>:
ffffffffc0205306:	7139                	addi	sp,sp,-64
ffffffffc0205308:	f04a                	sd	s2,32(sp)
ffffffffc020530a:	00090917          	auipc	s2,0x90
ffffffffc020530e:	5b690913          	addi	s2,s2,1462 # ffffffffc02958c0 <current>
ffffffffc0205312:	00093703          	ld	a4,0(s2)
ffffffffc0205316:	ec4e                	sd	s3,24(sp)
ffffffffc0205318:	89aa                	mv	s3,a0
ffffffffc020531a:	6505                	lui	a0,0x1
ffffffffc020531c:	f426                	sd	s1,40(sp)
ffffffffc020531e:	e852                	sd	s4,16(sp)
ffffffffc0205320:	fc06                	sd	ra,56(sp)
ffffffffc0205322:	f822                	sd	s0,48(sp)
ffffffffc0205324:	e456                	sd	s5,8(sp)
ffffffffc0205326:	02873a03          	ld	s4,40(a4)
ffffffffc020532a:	84ae                	mv	s1,a1
ffffffffc020532c:	c63fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205330:	c141                	beqz	a0,ffffffffc02053b0 <copy_path+0xaa>
ffffffffc0205332:	842a                	mv	s0,a0
ffffffffc0205334:	040a0563          	beqz	s4,ffffffffc020537e <copy_path+0x78>
ffffffffc0205338:	038a0a93          	addi	s5,s4,56
ffffffffc020533c:	8556                	mv	a0,s5
ffffffffc020533e:	8b4ff0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0205342:	00093783          	ld	a5,0(s2)
ffffffffc0205346:	cba1                	beqz	a5,ffffffffc0205396 <copy_path+0x90>
ffffffffc0205348:	43dc                	lw	a5,4(a5)
ffffffffc020534a:	6685                	lui	a3,0x1
ffffffffc020534c:	8626                	mv	a2,s1
ffffffffc020534e:	04fa2823          	sw	a5,80(s4)
ffffffffc0205352:	85a2                	mv	a1,s0
ffffffffc0205354:	8552                	mv	a0,s4
ffffffffc0205356:	ec5fe0ef          	jal	ra,ffffffffc020421a <copy_string>
ffffffffc020535a:	c529                	beqz	a0,ffffffffc02053a4 <copy_path+0x9e>
ffffffffc020535c:	8556                	mv	a0,s5
ffffffffc020535e:	890ff0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0205362:	040a2823          	sw	zero,80(s4)
ffffffffc0205366:	0089b023          	sd	s0,0(s3)
ffffffffc020536a:	4501                	li	a0,0
ffffffffc020536c:	70e2                	ld	ra,56(sp)
ffffffffc020536e:	7442                	ld	s0,48(sp)
ffffffffc0205370:	74a2                	ld	s1,40(sp)
ffffffffc0205372:	7902                	ld	s2,32(sp)
ffffffffc0205374:	69e2                	ld	s3,24(sp)
ffffffffc0205376:	6a42                	ld	s4,16(sp)
ffffffffc0205378:	6aa2                	ld	s5,8(sp)
ffffffffc020537a:	6121                	addi	sp,sp,64
ffffffffc020537c:	8082                	ret
ffffffffc020537e:	85aa                	mv	a1,a0
ffffffffc0205380:	6685                	lui	a3,0x1
ffffffffc0205382:	8626                	mv	a2,s1
ffffffffc0205384:	4501                	li	a0,0
ffffffffc0205386:	e95fe0ef          	jal	ra,ffffffffc020421a <copy_string>
ffffffffc020538a:	fd71                	bnez	a0,ffffffffc0205366 <copy_path+0x60>
ffffffffc020538c:	8522                	mv	a0,s0
ffffffffc020538e:	cb1fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205392:	5575                	li	a0,-3
ffffffffc0205394:	bfe1                	j	ffffffffc020536c <copy_path+0x66>
ffffffffc0205396:	6685                	lui	a3,0x1
ffffffffc0205398:	8626                	mv	a2,s1
ffffffffc020539a:	85a2                	mv	a1,s0
ffffffffc020539c:	8552                	mv	a0,s4
ffffffffc020539e:	e7dfe0ef          	jal	ra,ffffffffc020421a <copy_string>
ffffffffc02053a2:	fd4d                	bnez	a0,ffffffffc020535c <copy_path+0x56>
ffffffffc02053a4:	8556                	mv	a0,s5
ffffffffc02053a6:	848ff0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02053aa:	040a2823          	sw	zero,80(s4)
ffffffffc02053ae:	bff9                	j	ffffffffc020538c <copy_path+0x86>
ffffffffc02053b0:	5571                	li	a0,-4
ffffffffc02053b2:	bf6d                	j	ffffffffc020536c <copy_path+0x66>

ffffffffc02053b4 <sysfile_open>:
ffffffffc02053b4:	7179                	addi	sp,sp,-48
ffffffffc02053b6:	872a                	mv	a4,a0
ffffffffc02053b8:	ec26                	sd	s1,24(sp)
ffffffffc02053ba:	0028                	addi	a0,sp,8
ffffffffc02053bc:	84ae                	mv	s1,a1
ffffffffc02053be:	85ba                	mv	a1,a4
ffffffffc02053c0:	f022                	sd	s0,32(sp)
ffffffffc02053c2:	f406                	sd	ra,40(sp)
ffffffffc02053c4:	f43ff0ef          	jal	ra,ffffffffc0205306 <copy_path>
ffffffffc02053c8:	842a                	mv	s0,a0
ffffffffc02053ca:	e909                	bnez	a0,ffffffffc02053dc <sysfile_open+0x28>
ffffffffc02053cc:	6522                	ld	a0,8(sp)
ffffffffc02053ce:	85a6                	mv	a1,s1
ffffffffc02053d0:	d60ff0ef          	jal	ra,ffffffffc0204930 <file_open>
ffffffffc02053d4:	842a                	mv	s0,a0
ffffffffc02053d6:	6522                	ld	a0,8(sp)
ffffffffc02053d8:	c67fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02053dc:	70a2                	ld	ra,40(sp)
ffffffffc02053de:	8522                	mv	a0,s0
ffffffffc02053e0:	7402                	ld	s0,32(sp)
ffffffffc02053e2:	64e2                	ld	s1,24(sp)
ffffffffc02053e4:	6145                	addi	sp,sp,48
ffffffffc02053e6:	8082                	ret

ffffffffc02053e8 <sysfile_close>:
ffffffffc02053e8:	e46ff06f          	j	ffffffffc0204a2e <file_close>

ffffffffc02053ec <sysfile_read>:
ffffffffc02053ec:	7159                	addi	sp,sp,-112
ffffffffc02053ee:	f0a2                	sd	s0,96(sp)
ffffffffc02053f0:	f486                	sd	ra,104(sp)
ffffffffc02053f2:	eca6                	sd	s1,88(sp)
ffffffffc02053f4:	e8ca                	sd	s2,80(sp)
ffffffffc02053f6:	e4ce                	sd	s3,72(sp)
ffffffffc02053f8:	e0d2                	sd	s4,64(sp)
ffffffffc02053fa:	fc56                	sd	s5,56(sp)
ffffffffc02053fc:	f85a                	sd	s6,48(sp)
ffffffffc02053fe:	f45e                	sd	s7,40(sp)
ffffffffc0205400:	f062                	sd	s8,32(sp)
ffffffffc0205402:	ec66                	sd	s9,24(sp)
ffffffffc0205404:	4401                	li	s0,0
ffffffffc0205406:	ee19                	bnez	a2,ffffffffc0205424 <sysfile_read+0x38>
ffffffffc0205408:	70a6                	ld	ra,104(sp)
ffffffffc020540a:	8522                	mv	a0,s0
ffffffffc020540c:	7406                	ld	s0,96(sp)
ffffffffc020540e:	64e6                	ld	s1,88(sp)
ffffffffc0205410:	6946                	ld	s2,80(sp)
ffffffffc0205412:	69a6                	ld	s3,72(sp)
ffffffffc0205414:	6a06                	ld	s4,64(sp)
ffffffffc0205416:	7ae2                	ld	s5,56(sp)
ffffffffc0205418:	7b42                	ld	s6,48(sp)
ffffffffc020541a:	7ba2                	ld	s7,40(sp)
ffffffffc020541c:	7c02                	ld	s8,32(sp)
ffffffffc020541e:	6ce2                	ld	s9,24(sp)
ffffffffc0205420:	6165                	addi	sp,sp,112
ffffffffc0205422:	8082                	ret
ffffffffc0205424:	00090c97          	auipc	s9,0x90
ffffffffc0205428:	49cc8c93          	addi	s9,s9,1180 # ffffffffc02958c0 <current>
ffffffffc020542c:	000cb783          	ld	a5,0(s9)
ffffffffc0205430:	84b2                	mv	s1,a2
ffffffffc0205432:	8b2e                	mv	s6,a1
ffffffffc0205434:	4601                	li	a2,0
ffffffffc0205436:	4585                	li	a1,1
ffffffffc0205438:	0287b903          	ld	s2,40(a5)
ffffffffc020543c:	8aaa                	mv	s5,a0
ffffffffc020543e:	c9eff0ef          	jal	ra,ffffffffc02048dc <file_testfd>
ffffffffc0205442:	c959                	beqz	a0,ffffffffc02054d8 <sysfile_read+0xec>
ffffffffc0205444:	6505                	lui	a0,0x1
ffffffffc0205446:	b49fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020544a:	89aa                	mv	s3,a0
ffffffffc020544c:	c941                	beqz	a0,ffffffffc02054dc <sysfile_read+0xf0>
ffffffffc020544e:	4b81                	li	s7,0
ffffffffc0205450:	6a05                	lui	s4,0x1
ffffffffc0205452:	03890c13          	addi	s8,s2,56
ffffffffc0205456:	0744ec63          	bltu	s1,s4,ffffffffc02054ce <sysfile_read+0xe2>
ffffffffc020545a:	e452                	sd	s4,8(sp)
ffffffffc020545c:	6605                	lui	a2,0x1
ffffffffc020545e:	0034                	addi	a3,sp,8
ffffffffc0205460:	85ce                	mv	a1,s3
ffffffffc0205462:	8556                	mv	a0,s5
ffffffffc0205464:	e20ff0ef          	jal	ra,ffffffffc0204a84 <file_read>
ffffffffc0205468:	66a2                	ld	a3,8(sp)
ffffffffc020546a:	842a                	mv	s0,a0
ffffffffc020546c:	ca9d                	beqz	a3,ffffffffc02054a2 <sysfile_read+0xb6>
ffffffffc020546e:	00090c63          	beqz	s2,ffffffffc0205486 <sysfile_read+0x9a>
ffffffffc0205472:	8562                	mv	a0,s8
ffffffffc0205474:	f7ffe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0205478:	000cb783          	ld	a5,0(s9)
ffffffffc020547c:	cfa1                	beqz	a5,ffffffffc02054d4 <sysfile_read+0xe8>
ffffffffc020547e:	43dc                	lw	a5,4(a5)
ffffffffc0205480:	66a2                	ld	a3,8(sp)
ffffffffc0205482:	04f92823          	sw	a5,80(s2)
ffffffffc0205486:	864e                	mv	a2,s3
ffffffffc0205488:	85da                	mv	a1,s6
ffffffffc020548a:	854a                	mv	a0,s2
ffffffffc020548c:	d5dfe0ef          	jal	ra,ffffffffc02041e8 <copy_to_user>
ffffffffc0205490:	c50d                	beqz	a0,ffffffffc02054ba <sysfile_read+0xce>
ffffffffc0205492:	67a2                	ld	a5,8(sp)
ffffffffc0205494:	04f4e663          	bltu	s1,a5,ffffffffc02054e0 <sysfile_read+0xf4>
ffffffffc0205498:	9b3e                	add	s6,s6,a5
ffffffffc020549a:	8c9d                	sub	s1,s1,a5
ffffffffc020549c:	9bbe                	add	s7,s7,a5
ffffffffc020549e:	02091263          	bnez	s2,ffffffffc02054c2 <sysfile_read+0xd6>
ffffffffc02054a2:	e401                	bnez	s0,ffffffffc02054aa <sysfile_read+0xbe>
ffffffffc02054a4:	67a2                	ld	a5,8(sp)
ffffffffc02054a6:	c391                	beqz	a5,ffffffffc02054aa <sysfile_read+0xbe>
ffffffffc02054a8:	f4dd                	bnez	s1,ffffffffc0205456 <sysfile_read+0x6a>
ffffffffc02054aa:	854e                	mv	a0,s3
ffffffffc02054ac:	b93fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02054b0:	f40b8ce3          	beqz	s7,ffffffffc0205408 <sysfile_read+0x1c>
ffffffffc02054b4:	000b841b          	sext.w	s0,s7
ffffffffc02054b8:	bf81                	j	ffffffffc0205408 <sysfile_read+0x1c>
ffffffffc02054ba:	e011                	bnez	s0,ffffffffc02054be <sysfile_read+0xd2>
ffffffffc02054bc:	5475                	li	s0,-3
ffffffffc02054be:	fe0906e3          	beqz	s2,ffffffffc02054aa <sysfile_read+0xbe>
ffffffffc02054c2:	8562                	mv	a0,s8
ffffffffc02054c4:	f2bfe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02054c8:	04092823          	sw	zero,80(s2)
ffffffffc02054cc:	bfd9                	j	ffffffffc02054a2 <sysfile_read+0xb6>
ffffffffc02054ce:	e426                	sd	s1,8(sp)
ffffffffc02054d0:	8626                	mv	a2,s1
ffffffffc02054d2:	b771                	j	ffffffffc020545e <sysfile_read+0x72>
ffffffffc02054d4:	66a2                	ld	a3,8(sp)
ffffffffc02054d6:	bf45                	j	ffffffffc0205486 <sysfile_read+0x9a>
ffffffffc02054d8:	5475                	li	s0,-3
ffffffffc02054da:	b73d                	j	ffffffffc0205408 <sysfile_read+0x1c>
ffffffffc02054dc:	5471                	li	s0,-4
ffffffffc02054de:	b72d                	j	ffffffffc0205408 <sysfile_read+0x1c>
ffffffffc02054e0:	00007697          	auipc	a3,0x7
ffffffffc02054e4:	59068693          	addi	a3,a3,1424 # ffffffffc020ca70 <CSWTCH.79+0xc8>
ffffffffc02054e8:	00006617          	auipc	a2,0x6
ffffffffc02054ec:	ac860613          	addi	a2,a2,-1336 # ffffffffc020afb0 <commands+0x210>
ffffffffc02054f0:	05500593          	li	a1,85
ffffffffc02054f4:	00007517          	auipc	a0,0x7
ffffffffc02054f8:	58c50513          	addi	a0,a0,1420 # ffffffffc020ca80 <CSWTCH.79+0xd8>
ffffffffc02054fc:	fa3fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205500 <sysfile_write>:
ffffffffc0205500:	7159                	addi	sp,sp,-112
ffffffffc0205502:	e8ca                	sd	s2,80(sp)
ffffffffc0205504:	f486                	sd	ra,104(sp)
ffffffffc0205506:	f0a2                	sd	s0,96(sp)
ffffffffc0205508:	eca6                	sd	s1,88(sp)
ffffffffc020550a:	e4ce                	sd	s3,72(sp)
ffffffffc020550c:	e0d2                	sd	s4,64(sp)
ffffffffc020550e:	fc56                	sd	s5,56(sp)
ffffffffc0205510:	f85a                	sd	s6,48(sp)
ffffffffc0205512:	f45e                	sd	s7,40(sp)
ffffffffc0205514:	f062                	sd	s8,32(sp)
ffffffffc0205516:	ec66                	sd	s9,24(sp)
ffffffffc0205518:	4901                	li	s2,0
ffffffffc020551a:	ee19                	bnez	a2,ffffffffc0205538 <sysfile_write+0x38>
ffffffffc020551c:	70a6                	ld	ra,104(sp)
ffffffffc020551e:	7406                	ld	s0,96(sp)
ffffffffc0205520:	64e6                	ld	s1,88(sp)
ffffffffc0205522:	69a6                	ld	s3,72(sp)
ffffffffc0205524:	6a06                	ld	s4,64(sp)
ffffffffc0205526:	7ae2                	ld	s5,56(sp)
ffffffffc0205528:	7b42                	ld	s6,48(sp)
ffffffffc020552a:	7ba2                	ld	s7,40(sp)
ffffffffc020552c:	7c02                	ld	s8,32(sp)
ffffffffc020552e:	6ce2                	ld	s9,24(sp)
ffffffffc0205530:	854a                	mv	a0,s2
ffffffffc0205532:	6946                	ld	s2,80(sp)
ffffffffc0205534:	6165                	addi	sp,sp,112
ffffffffc0205536:	8082                	ret
ffffffffc0205538:	00090c17          	auipc	s8,0x90
ffffffffc020553c:	388c0c13          	addi	s8,s8,904 # ffffffffc02958c0 <current>
ffffffffc0205540:	000c3783          	ld	a5,0(s8)
ffffffffc0205544:	8432                	mv	s0,a2
ffffffffc0205546:	89ae                	mv	s3,a1
ffffffffc0205548:	4605                	li	a2,1
ffffffffc020554a:	4581                	li	a1,0
ffffffffc020554c:	7784                	ld	s1,40(a5)
ffffffffc020554e:	8baa                	mv	s7,a0
ffffffffc0205550:	b8cff0ef          	jal	ra,ffffffffc02048dc <file_testfd>
ffffffffc0205554:	cd59                	beqz	a0,ffffffffc02055f2 <sysfile_write+0xf2>
ffffffffc0205556:	6505                	lui	a0,0x1
ffffffffc0205558:	a37fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020555c:	8a2a                	mv	s4,a0
ffffffffc020555e:	cd41                	beqz	a0,ffffffffc02055f6 <sysfile_write+0xf6>
ffffffffc0205560:	4c81                	li	s9,0
ffffffffc0205562:	6a85                	lui	s5,0x1
ffffffffc0205564:	03848b13          	addi	s6,s1,56
ffffffffc0205568:	05546a63          	bltu	s0,s5,ffffffffc02055bc <sysfile_write+0xbc>
ffffffffc020556c:	e456                	sd	s5,8(sp)
ffffffffc020556e:	c8a9                	beqz	s1,ffffffffc02055c0 <sysfile_write+0xc0>
ffffffffc0205570:	855a                	mv	a0,s6
ffffffffc0205572:	e81fe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0205576:	000c3783          	ld	a5,0(s8)
ffffffffc020557a:	c399                	beqz	a5,ffffffffc0205580 <sysfile_write+0x80>
ffffffffc020557c:	43dc                	lw	a5,4(a5)
ffffffffc020557e:	c8bc                	sw	a5,80(s1)
ffffffffc0205580:	66a2                	ld	a3,8(sp)
ffffffffc0205582:	4701                	li	a4,0
ffffffffc0205584:	864e                	mv	a2,s3
ffffffffc0205586:	85d2                	mv	a1,s4
ffffffffc0205588:	8526                	mv	a0,s1
ffffffffc020558a:	c2bfe0ef          	jal	ra,ffffffffc02041b4 <copy_from_user>
ffffffffc020558e:	c139                	beqz	a0,ffffffffc02055d4 <sysfile_write+0xd4>
ffffffffc0205590:	855a                	mv	a0,s6
ffffffffc0205592:	e5dfe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0205596:	0404a823          	sw	zero,80(s1)
ffffffffc020559a:	6622                	ld	a2,8(sp)
ffffffffc020559c:	0034                	addi	a3,sp,8
ffffffffc020559e:	85d2                	mv	a1,s4
ffffffffc02055a0:	855e                	mv	a0,s7
ffffffffc02055a2:	dc8ff0ef          	jal	ra,ffffffffc0204b6a <file_write>
ffffffffc02055a6:	67a2                	ld	a5,8(sp)
ffffffffc02055a8:	892a                	mv	s2,a0
ffffffffc02055aa:	ef85                	bnez	a5,ffffffffc02055e2 <sysfile_write+0xe2>
ffffffffc02055ac:	8552                	mv	a0,s4
ffffffffc02055ae:	a91fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02055b2:	f60c85e3          	beqz	s9,ffffffffc020551c <sysfile_write+0x1c>
ffffffffc02055b6:	000c891b          	sext.w	s2,s9
ffffffffc02055ba:	b78d                	j	ffffffffc020551c <sysfile_write+0x1c>
ffffffffc02055bc:	e422                	sd	s0,8(sp)
ffffffffc02055be:	f8cd                	bnez	s1,ffffffffc0205570 <sysfile_write+0x70>
ffffffffc02055c0:	66a2                	ld	a3,8(sp)
ffffffffc02055c2:	4701                	li	a4,0
ffffffffc02055c4:	864e                	mv	a2,s3
ffffffffc02055c6:	85d2                	mv	a1,s4
ffffffffc02055c8:	4501                	li	a0,0
ffffffffc02055ca:	bebfe0ef          	jal	ra,ffffffffc02041b4 <copy_from_user>
ffffffffc02055ce:	f571                	bnez	a0,ffffffffc020559a <sysfile_write+0x9a>
ffffffffc02055d0:	5975                	li	s2,-3
ffffffffc02055d2:	bfe9                	j	ffffffffc02055ac <sysfile_write+0xac>
ffffffffc02055d4:	855a                	mv	a0,s6
ffffffffc02055d6:	e19fe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02055da:	5975                	li	s2,-3
ffffffffc02055dc:	0404a823          	sw	zero,80(s1)
ffffffffc02055e0:	b7f1                	j	ffffffffc02055ac <sysfile_write+0xac>
ffffffffc02055e2:	00f46c63          	bltu	s0,a5,ffffffffc02055fa <sysfile_write+0xfa>
ffffffffc02055e6:	99be                	add	s3,s3,a5
ffffffffc02055e8:	8c1d                	sub	s0,s0,a5
ffffffffc02055ea:	9cbe                	add	s9,s9,a5
ffffffffc02055ec:	f161                	bnez	a0,ffffffffc02055ac <sysfile_write+0xac>
ffffffffc02055ee:	fc2d                	bnez	s0,ffffffffc0205568 <sysfile_write+0x68>
ffffffffc02055f0:	bf75                	j	ffffffffc02055ac <sysfile_write+0xac>
ffffffffc02055f2:	5975                	li	s2,-3
ffffffffc02055f4:	b725                	j	ffffffffc020551c <sysfile_write+0x1c>
ffffffffc02055f6:	5971                	li	s2,-4
ffffffffc02055f8:	b715                	j	ffffffffc020551c <sysfile_write+0x1c>
ffffffffc02055fa:	00007697          	auipc	a3,0x7
ffffffffc02055fe:	47668693          	addi	a3,a3,1142 # ffffffffc020ca70 <CSWTCH.79+0xc8>
ffffffffc0205602:	00006617          	auipc	a2,0x6
ffffffffc0205606:	9ae60613          	addi	a2,a2,-1618 # ffffffffc020afb0 <commands+0x210>
ffffffffc020560a:	08a00593          	li	a1,138
ffffffffc020560e:	00007517          	auipc	a0,0x7
ffffffffc0205612:	47250513          	addi	a0,a0,1138 # ffffffffc020ca80 <CSWTCH.79+0xd8>
ffffffffc0205616:	e89fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020561a <sysfile_seek>:
ffffffffc020561a:	e36ff06f          	j	ffffffffc0204c50 <file_seek>

ffffffffc020561e <sysfile_fstat>:
ffffffffc020561e:	715d                	addi	sp,sp,-80
ffffffffc0205620:	f44e                	sd	s3,40(sp)
ffffffffc0205622:	00090997          	auipc	s3,0x90
ffffffffc0205626:	29e98993          	addi	s3,s3,670 # ffffffffc02958c0 <current>
ffffffffc020562a:	0009b703          	ld	a4,0(s3)
ffffffffc020562e:	fc26                	sd	s1,56(sp)
ffffffffc0205630:	84ae                	mv	s1,a1
ffffffffc0205632:	858a                	mv	a1,sp
ffffffffc0205634:	e0a2                	sd	s0,64(sp)
ffffffffc0205636:	f84a                	sd	s2,48(sp)
ffffffffc0205638:	e486                	sd	ra,72(sp)
ffffffffc020563a:	02873903          	ld	s2,40(a4)
ffffffffc020563e:	f052                	sd	s4,32(sp)
ffffffffc0205640:	f30ff0ef          	jal	ra,ffffffffc0204d70 <file_fstat>
ffffffffc0205644:	842a                	mv	s0,a0
ffffffffc0205646:	e91d                	bnez	a0,ffffffffc020567c <sysfile_fstat+0x5e>
ffffffffc0205648:	04090363          	beqz	s2,ffffffffc020568e <sysfile_fstat+0x70>
ffffffffc020564c:	03890a13          	addi	s4,s2,56
ffffffffc0205650:	8552                	mv	a0,s4
ffffffffc0205652:	da1fe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0205656:	0009b783          	ld	a5,0(s3)
ffffffffc020565a:	c3b9                	beqz	a5,ffffffffc02056a0 <sysfile_fstat+0x82>
ffffffffc020565c:	43dc                	lw	a5,4(a5)
ffffffffc020565e:	02000693          	li	a3,32
ffffffffc0205662:	860a                	mv	a2,sp
ffffffffc0205664:	04f92823          	sw	a5,80(s2)
ffffffffc0205668:	85a6                	mv	a1,s1
ffffffffc020566a:	854a                	mv	a0,s2
ffffffffc020566c:	b7dfe0ef          	jal	ra,ffffffffc02041e8 <copy_to_user>
ffffffffc0205670:	c121                	beqz	a0,ffffffffc02056b0 <sysfile_fstat+0x92>
ffffffffc0205672:	8552                	mv	a0,s4
ffffffffc0205674:	d7bfe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0205678:	04092823          	sw	zero,80(s2)
ffffffffc020567c:	60a6                	ld	ra,72(sp)
ffffffffc020567e:	8522                	mv	a0,s0
ffffffffc0205680:	6406                	ld	s0,64(sp)
ffffffffc0205682:	74e2                	ld	s1,56(sp)
ffffffffc0205684:	7942                	ld	s2,48(sp)
ffffffffc0205686:	79a2                	ld	s3,40(sp)
ffffffffc0205688:	7a02                	ld	s4,32(sp)
ffffffffc020568a:	6161                	addi	sp,sp,80
ffffffffc020568c:	8082                	ret
ffffffffc020568e:	02000693          	li	a3,32
ffffffffc0205692:	860a                	mv	a2,sp
ffffffffc0205694:	85a6                	mv	a1,s1
ffffffffc0205696:	b53fe0ef          	jal	ra,ffffffffc02041e8 <copy_to_user>
ffffffffc020569a:	f16d                	bnez	a0,ffffffffc020567c <sysfile_fstat+0x5e>
ffffffffc020569c:	5475                	li	s0,-3
ffffffffc020569e:	bff9                	j	ffffffffc020567c <sysfile_fstat+0x5e>
ffffffffc02056a0:	02000693          	li	a3,32
ffffffffc02056a4:	860a                	mv	a2,sp
ffffffffc02056a6:	85a6                	mv	a1,s1
ffffffffc02056a8:	854a                	mv	a0,s2
ffffffffc02056aa:	b3ffe0ef          	jal	ra,ffffffffc02041e8 <copy_to_user>
ffffffffc02056ae:	f171                	bnez	a0,ffffffffc0205672 <sysfile_fstat+0x54>
ffffffffc02056b0:	8552                	mv	a0,s4
ffffffffc02056b2:	d3dfe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02056b6:	5475                	li	s0,-3
ffffffffc02056b8:	04092823          	sw	zero,80(s2)
ffffffffc02056bc:	b7c1                	j	ffffffffc020567c <sysfile_fstat+0x5e>

ffffffffc02056be <sysfile_fsync>:
ffffffffc02056be:	f72ff06f          	j	ffffffffc0204e30 <file_fsync>

ffffffffc02056c2 <sysfile_getcwd>:
ffffffffc02056c2:	715d                	addi	sp,sp,-80
ffffffffc02056c4:	f44e                	sd	s3,40(sp)
ffffffffc02056c6:	00090997          	auipc	s3,0x90
ffffffffc02056ca:	1fa98993          	addi	s3,s3,506 # ffffffffc02958c0 <current>
ffffffffc02056ce:	0009b783          	ld	a5,0(s3)
ffffffffc02056d2:	f84a                	sd	s2,48(sp)
ffffffffc02056d4:	e486                	sd	ra,72(sp)
ffffffffc02056d6:	e0a2                	sd	s0,64(sp)
ffffffffc02056d8:	fc26                	sd	s1,56(sp)
ffffffffc02056da:	f052                	sd	s4,32(sp)
ffffffffc02056dc:	0287b903          	ld	s2,40(a5)
ffffffffc02056e0:	cda9                	beqz	a1,ffffffffc020573a <sysfile_getcwd+0x78>
ffffffffc02056e2:	842e                	mv	s0,a1
ffffffffc02056e4:	84aa                	mv	s1,a0
ffffffffc02056e6:	04090363          	beqz	s2,ffffffffc020572c <sysfile_getcwd+0x6a>
ffffffffc02056ea:	03890a13          	addi	s4,s2,56
ffffffffc02056ee:	8552                	mv	a0,s4
ffffffffc02056f0:	d03fe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02056f4:	0009b783          	ld	a5,0(s3)
ffffffffc02056f8:	c781                	beqz	a5,ffffffffc0205700 <sysfile_getcwd+0x3e>
ffffffffc02056fa:	43dc                	lw	a5,4(a5)
ffffffffc02056fc:	04f92823          	sw	a5,80(s2)
ffffffffc0205700:	4685                	li	a3,1
ffffffffc0205702:	8622                	mv	a2,s0
ffffffffc0205704:	85a6                	mv	a1,s1
ffffffffc0205706:	854a                	mv	a0,s2
ffffffffc0205708:	a19fe0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc020570c:	e90d                	bnez	a0,ffffffffc020573e <sysfile_getcwd+0x7c>
ffffffffc020570e:	5475                	li	s0,-3
ffffffffc0205710:	8552                	mv	a0,s4
ffffffffc0205712:	cddfe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0205716:	04092823          	sw	zero,80(s2)
ffffffffc020571a:	60a6                	ld	ra,72(sp)
ffffffffc020571c:	8522                	mv	a0,s0
ffffffffc020571e:	6406                	ld	s0,64(sp)
ffffffffc0205720:	74e2                	ld	s1,56(sp)
ffffffffc0205722:	7942                	ld	s2,48(sp)
ffffffffc0205724:	79a2                	ld	s3,40(sp)
ffffffffc0205726:	7a02                	ld	s4,32(sp)
ffffffffc0205728:	6161                	addi	sp,sp,80
ffffffffc020572a:	8082                	ret
ffffffffc020572c:	862e                	mv	a2,a1
ffffffffc020572e:	4685                	li	a3,1
ffffffffc0205730:	85aa                	mv	a1,a0
ffffffffc0205732:	4501                	li	a0,0
ffffffffc0205734:	9edfe0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc0205738:	ed09                	bnez	a0,ffffffffc0205752 <sysfile_getcwd+0x90>
ffffffffc020573a:	5475                	li	s0,-3
ffffffffc020573c:	bff9                	j	ffffffffc020571a <sysfile_getcwd+0x58>
ffffffffc020573e:	8622                	mv	a2,s0
ffffffffc0205740:	4681                	li	a3,0
ffffffffc0205742:	85a6                	mv	a1,s1
ffffffffc0205744:	850a                	mv	a0,sp
ffffffffc0205746:	b2bff0ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc020574a:	534020ef          	jal	ra,ffffffffc0207c7e <vfs_getcwd>
ffffffffc020574e:	842a                	mv	s0,a0
ffffffffc0205750:	b7c1                	j	ffffffffc0205710 <sysfile_getcwd+0x4e>
ffffffffc0205752:	8622                	mv	a2,s0
ffffffffc0205754:	4681                	li	a3,0
ffffffffc0205756:	85a6                	mv	a1,s1
ffffffffc0205758:	850a                	mv	a0,sp
ffffffffc020575a:	b17ff0ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc020575e:	520020ef          	jal	ra,ffffffffc0207c7e <vfs_getcwd>
ffffffffc0205762:	842a                	mv	s0,a0
ffffffffc0205764:	bf5d                	j	ffffffffc020571a <sysfile_getcwd+0x58>

ffffffffc0205766 <sysfile_getdirentry>:
ffffffffc0205766:	7139                	addi	sp,sp,-64
ffffffffc0205768:	e852                	sd	s4,16(sp)
ffffffffc020576a:	00090a17          	auipc	s4,0x90
ffffffffc020576e:	156a0a13          	addi	s4,s4,342 # ffffffffc02958c0 <current>
ffffffffc0205772:	000a3703          	ld	a4,0(s4)
ffffffffc0205776:	ec4e                	sd	s3,24(sp)
ffffffffc0205778:	89aa                	mv	s3,a0
ffffffffc020577a:	10800513          	li	a0,264
ffffffffc020577e:	f426                	sd	s1,40(sp)
ffffffffc0205780:	f04a                	sd	s2,32(sp)
ffffffffc0205782:	fc06                	sd	ra,56(sp)
ffffffffc0205784:	f822                	sd	s0,48(sp)
ffffffffc0205786:	e456                	sd	s5,8(sp)
ffffffffc0205788:	7704                	ld	s1,40(a4)
ffffffffc020578a:	892e                	mv	s2,a1
ffffffffc020578c:	803fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205790:	c169                	beqz	a0,ffffffffc0205852 <sysfile_getdirentry+0xec>
ffffffffc0205792:	842a                	mv	s0,a0
ffffffffc0205794:	c8c1                	beqz	s1,ffffffffc0205824 <sysfile_getdirentry+0xbe>
ffffffffc0205796:	03848a93          	addi	s5,s1,56
ffffffffc020579a:	8556                	mv	a0,s5
ffffffffc020579c:	c57fe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02057a0:	000a3783          	ld	a5,0(s4)
ffffffffc02057a4:	c399                	beqz	a5,ffffffffc02057aa <sysfile_getdirentry+0x44>
ffffffffc02057a6:	43dc                	lw	a5,4(a5)
ffffffffc02057a8:	c8bc                	sw	a5,80(s1)
ffffffffc02057aa:	4705                	li	a4,1
ffffffffc02057ac:	46a1                	li	a3,8
ffffffffc02057ae:	864a                	mv	a2,s2
ffffffffc02057b0:	85a2                	mv	a1,s0
ffffffffc02057b2:	8526                	mv	a0,s1
ffffffffc02057b4:	a01fe0ef          	jal	ra,ffffffffc02041b4 <copy_from_user>
ffffffffc02057b8:	e505                	bnez	a0,ffffffffc02057e0 <sysfile_getdirentry+0x7a>
ffffffffc02057ba:	8556                	mv	a0,s5
ffffffffc02057bc:	c33fe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02057c0:	59f5                	li	s3,-3
ffffffffc02057c2:	0404a823          	sw	zero,80(s1)
ffffffffc02057c6:	8522                	mv	a0,s0
ffffffffc02057c8:	877fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02057cc:	70e2                	ld	ra,56(sp)
ffffffffc02057ce:	7442                	ld	s0,48(sp)
ffffffffc02057d0:	74a2                	ld	s1,40(sp)
ffffffffc02057d2:	7902                	ld	s2,32(sp)
ffffffffc02057d4:	6a42                	ld	s4,16(sp)
ffffffffc02057d6:	6aa2                	ld	s5,8(sp)
ffffffffc02057d8:	854e                	mv	a0,s3
ffffffffc02057da:	69e2                	ld	s3,24(sp)
ffffffffc02057dc:	6121                	addi	sp,sp,64
ffffffffc02057de:	8082                	ret
ffffffffc02057e0:	8556                	mv	a0,s5
ffffffffc02057e2:	c0dfe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02057e6:	854e                	mv	a0,s3
ffffffffc02057e8:	85a2                	mv	a1,s0
ffffffffc02057ea:	0404a823          	sw	zero,80(s1)
ffffffffc02057ee:	ef0ff0ef          	jal	ra,ffffffffc0204ede <file_getdirentry>
ffffffffc02057f2:	89aa                	mv	s3,a0
ffffffffc02057f4:	f969                	bnez	a0,ffffffffc02057c6 <sysfile_getdirentry+0x60>
ffffffffc02057f6:	8556                	mv	a0,s5
ffffffffc02057f8:	bfbfe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02057fc:	000a3783          	ld	a5,0(s4)
ffffffffc0205800:	c399                	beqz	a5,ffffffffc0205806 <sysfile_getdirentry+0xa0>
ffffffffc0205802:	43dc                	lw	a5,4(a5)
ffffffffc0205804:	c8bc                	sw	a5,80(s1)
ffffffffc0205806:	10800693          	li	a3,264
ffffffffc020580a:	8622                	mv	a2,s0
ffffffffc020580c:	85ca                	mv	a1,s2
ffffffffc020580e:	8526                	mv	a0,s1
ffffffffc0205810:	9d9fe0ef          	jal	ra,ffffffffc02041e8 <copy_to_user>
ffffffffc0205814:	e111                	bnez	a0,ffffffffc0205818 <sysfile_getdirentry+0xb2>
ffffffffc0205816:	59f5                	li	s3,-3
ffffffffc0205818:	8556                	mv	a0,s5
ffffffffc020581a:	bd5fe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020581e:	0404a823          	sw	zero,80(s1)
ffffffffc0205822:	b755                	j	ffffffffc02057c6 <sysfile_getdirentry+0x60>
ffffffffc0205824:	85aa                	mv	a1,a0
ffffffffc0205826:	4705                	li	a4,1
ffffffffc0205828:	46a1                	li	a3,8
ffffffffc020582a:	864a                	mv	a2,s2
ffffffffc020582c:	4501                	li	a0,0
ffffffffc020582e:	987fe0ef          	jal	ra,ffffffffc02041b4 <copy_from_user>
ffffffffc0205832:	cd11                	beqz	a0,ffffffffc020584e <sysfile_getdirentry+0xe8>
ffffffffc0205834:	854e                	mv	a0,s3
ffffffffc0205836:	85a2                	mv	a1,s0
ffffffffc0205838:	ea6ff0ef          	jal	ra,ffffffffc0204ede <file_getdirentry>
ffffffffc020583c:	89aa                	mv	s3,a0
ffffffffc020583e:	f541                	bnez	a0,ffffffffc02057c6 <sysfile_getdirentry+0x60>
ffffffffc0205840:	10800693          	li	a3,264
ffffffffc0205844:	8622                	mv	a2,s0
ffffffffc0205846:	85ca                	mv	a1,s2
ffffffffc0205848:	9a1fe0ef          	jal	ra,ffffffffc02041e8 <copy_to_user>
ffffffffc020584c:	fd2d                	bnez	a0,ffffffffc02057c6 <sysfile_getdirentry+0x60>
ffffffffc020584e:	59f5                	li	s3,-3
ffffffffc0205850:	bf9d                	j	ffffffffc02057c6 <sysfile_getdirentry+0x60>
ffffffffc0205852:	59f1                	li	s3,-4
ffffffffc0205854:	bfa5                	j	ffffffffc02057cc <sysfile_getdirentry+0x66>

ffffffffc0205856 <sysfile_dup>:
ffffffffc0205856:	f6eff06f          	j	ffffffffc0204fc4 <file_dup>

ffffffffc020585a <kernel_thread_entry>:
ffffffffc020585a:	8526                	mv	a0,s1
ffffffffc020585c:	9402                	jalr	s0
ffffffffc020585e:	60e000ef          	jal	ra,ffffffffc0205e6c <do_exit>

ffffffffc0205862 <alloc_proc>:
ffffffffc0205862:	1141                	addi	sp,sp,-16
ffffffffc0205864:	15000513          	li	a0,336
ffffffffc0205868:	e022                	sd	s0,0(sp)
ffffffffc020586a:	e406                	sd	ra,8(sp)
ffffffffc020586c:	f22fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205870:	842a                	mv	s0,a0
ffffffffc0205872:	c141                	beqz	a0,ffffffffc02058f2 <alloc_proc+0x90>
ffffffffc0205874:	57fd                	li	a5,-1
ffffffffc0205876:	1782                	slli	a5,a5,0x20
ffffffffc0205878:	e11c                	sd	a5,0(a0)
ffffffffc020587a:	07000613          	li	a2,112
ffffffffc020587e:	4581                	li	a1,0
ffffffffc0205880:	14053423          	sd	zero,328(a0)
ffffffffc0205884:	00052423          	sw	zero,8(a0)
ffffffffc0205888:	00053823          	sd	zero,16(a0)
ffffffffc020588c:	00053c23          	sd	zero,24(a0)
ffffffffc0205890:	02053023          	sd	zero,32(a0)
ffffffffc0205894:	02053423          	sd	zero,40(a0)
ffffffffc0205898:	03050513          	addi	a0,a0,48
ffffffffc020589c:	232050ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc02058a0:	00090797          	auipc	a5,0x90
ffffffffc02058a4:	ff07b783          	ld	a5,-16(a5) # ffffffffc0295890 <boot_pgdir_pa>
ffffffffc02058a8:	f45c                	sd	a5,168(s0)
ffffffffc02058aa:	0a043023          	sd	zero,160(s0)
ffffffffc02058ae:	0a042823          	sw	zero,176(s0)
ffffffffc02058b2:	463d                	li	a2,15
ffffffffc02058b4:	4581                	li	a1,0
ffffffffc02058b6:	0b440513          	addi	a0,s0,180
ffffffffc02058ba:	214050ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc02058be:	11040793          	addi	a5,s0,272
ffffffffc02058c2:	0e042623          	sw	zero,236(s0)
ffffffffc02058c6:	0e043c23          	sd	zero,248(s0)
ffffffffc02058ca:	10043023          	sd	zero,256(s0)
ffffffffc02058ce:	0e043823          	sd	zero,240(s0)
ffffffffc02058d2:	10043423          	sd	zero,264(s0)
ffffffffc02058d6:	10f43c23          	sd	a5,280(s0)
ffffffffc02058da:	10f43823          	sd	a5,272(s0)
ffffffffc02058de:	12042023          	sw	zero,288(s0)
ffffffffc02058e2:	12043423          	sd	zero,296(s0)
ffffffffc02058e6:	12043823          	sd	zero,304(s0)
ffffffffc02058ea:	12043c23          	sd	zero,312(s0)
ffffffffc02058ee:	14043023          	sd	zero,320(s0)
ffffffffc02058f2:	60a2                	ld	ra,8(sp)
ffffffffc02058f4:	8522                	mv	a0,s0
ffffffffc02058f6:	6402                	ld	s0,0(sp)
ffffffffc02058f8:	0141                	addi	sp,sp,16
ffffffffc02058fa:	8082                	ret

ffffffffc02058fc <forkret>:
ffffffffc02058fc:	00090797          	auipc	a5,0x90
ffffffffc0205900:	fc47b783          	ld	a5,-60(a5) # ffffffffc02958c0 <current>
ffffffffc0205904:	73c8                	ld	a0,160(a5)
ffffffffc0205906:	9a5fb06f          	j	ffffffffc02012aa <forkrets>

ffffffffc020590a <put_pgdir.isra.0>:
ffffffffc020590a:	1141                	addi	sp,sp,-16
ffffffffc020590c:	e406                	sd	ra,8(sp)
ffffffffc020590e:	c02007b7          	lui	a5,0xc0200
ffffffffc0205912:	02f56e63          	bltu	a0,a5,ffffffffc020594e <put_pgdir.isra.0+0x44>
ffffffffc0205916:	00090697          	auipc	a3,0x90
ffffffffc020591a:	fa26b683          	ld	a3,-94(a3) # ffffffffc02958b8 <va_pa_offset>
ffffffffc020591e:	8d15                	sub	a0,a0,a3
ffffffffc0205920:	8131                	srli	a0,a0,0xc
ffffffffc0205922:	00090797          	auipc	a5,0x90
ffffffffc0205926:	f7e7b783          	ld	a5,-130(a5) # ffffffffc02958a0 <npage>
ffffffffc020592a:	02f57f63          	bgeu	a0,a5,ffffffffc0205968 <put_pgdir.isra.0+0x5e>
ffffffffc020592e:	00009697          	auipc	a3,0x9
ffffffffc0205932:	3526b683          	ld	a3,850(a3) # ffffffffc020ec80 <nbase>
ffffffffc0205936:	60a2                	ld	ra,8(sp)
ffffffffc0205938:	8d15                	sub	a0,a0,a3
ffffffffc020593a:	00090797          	auipc	a5,0x90
ffffffffc020593e:	f6e7b783          	ld	a5,-146(a5) # ffffffffc02958a8 <pages>
ffffffffc0205942:	051a                	slli	a0,a0,0x6
ffffffffc0205944:	4585                	li	a1,1
ffffffffc0205946:	953e                	add	a0,a0,a5
ffffffffc0205948:	0141                	addi	sp,sp,16
ffffffffc020594a:	861fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc020594e:	86aa                	mv	a3,a0
ffffffffc0205950:	00006617          	auipc	a2,0x6
ffffffffc0205954:	22860613          	addi	a2,a2,552 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0205958:	07700593          	li	a1,119
ffffffffc020595c:	00006517          	auipc	a0,0x6
ffffffffc0205960:	19c50513          	addi	a0,a0,412 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0205964:	b3bfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205968:	00006617          	auipc	a2,0x6
ffffffffc020596c:	23860613          	addi	a2,a2,568 # ffffffffc020bba0 <default_pmm_manager+0x108>
ffffffffc0205970:	06900593          	li	a1,105
ffffffffc0205974:	00006517          	auipc	a0,0x6
ffffffffc0205978:	18450513          	addi	a0,a0,388 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc020597c:	b23fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205980 <proc_run>:
ffffffffc0205980:	7179                	addi	sp,sp,-48
ffffffffc0205982:	ec4a                	sd	s2,24(sp)
ffffffffc0205984:	00090917          	auipc	s2,0x90
ffffffffc0205988:	f3c90913          	addi	s2,s2,-196 # ffffffffc02958c0 <current>
ffffffffc020598c:	f026                	sd	s1,32(sp)
ffffffffc020598e:	00093483          	ld	s1,0(s2)
ffffffffc0205992:	f406                	sd	ra,40(sp)
ffffffffc0205994:	e84e                	sd	s3,16(sp)
ffffffffc0205996:	02a48863          	beq	s1,a0,ffffffffc02059c6 <proc_run+0x46>
ffffffffc020599a:	100027f3          	csrr	a5,sstatus
ffffffffc020599e:	8b89                	andi	a5,a5,2
ffffffffc02059a0:	4981                	li	s3,0
ffffffffc02059a2:	ef9d                	bnez	a5,ffffffffc02059e0 <proc_run+0x60>
ffffffffc02059a4:	755c                	ld	a5,168(a0)
ffffffffc02059a6:	577d                	li	a4,-1
ffffffffc02059a8:	177e                	slli	a4,a4,0x3f
ffffffffc02059aa:	83b1                	srli	a5,a5,0xc
ffffffffc02059ac:	00a93023          	sd	a0,0(s2)
ffffffffc02059b0:	8fd9                	or	a5,a5,a4
ffffffffc02059b2:	18079073          	csrw	satp,a5
ffffffffc02059b6:	03050593          	addi	a1,a0,48
ffffffffc02059ba:	03048513          	addi	a0,s1,48
ffffffffc02059be:	78b000ef          	jal	ra,ffffffffc0206948 <switch_to>
ffffffffc02059c2:	00099863          	bnez	s3,ffffffffc02059d2 <proc_run+0x52>
ffffffffc02059c6:	70a2                	ld	ra,40(sp)
ffffffffc02059c8:	7482                	ld	s1,32(sp)
ffffffffc02059ca:	6962                	ld	s2,24(sp)
ffffffffc02059cc:	69c2                	ld	s3,16(sp)
ffffffffc02059ce:	6145                	addi	sp,sp,48
ffffffffc02059d0:	8082                	ret
ffffffffc02059d2:	70a2                	ld	ra,40(sp)
ffffffffc02059d4:	7482                	ld	s1,32(sp)
ffffffffc02059d6:	6962                	ld	s2,24(sp)
ffffffffc02059d8:	69c2                	ld	s3,16(sp)
ffffffffc02059da:	6145                	addi	sp,sp,48
ffffffffc02059dc:	a90fb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02059e0:	e42a                	sd	a0,8(sp)
ffffffffc02059e2:	a90fb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02059e6:	6522                	ld	a0,8(sp)
ffffffffc02059e8:	4985                	li	s3,1
ffffffffc02059ea:	bf6d                	j	ffffffffc02059a4 <proc_run+0x24>

ffffffffc02059ec <do_fork>:
ffffffffc02059ec:	7119                	addi	sp,sp,-128
ffffffffc02059ee:	ecce                	sd	s3,88(sp)
ffffffffc02059f0:	00090997          	auipc	s3,0x90
ffffffffc02059f4:	ee898993          	addi	s3,s3,-280 # ffffffffc02958d8 <nr_process>
ffffffffc02059f8:	0009a703          	lw	a4,0(s3)
ffffffffc02059fc:	fc86                	sd	ra,120(sp)
ffffffffc02059fe:	f8a2                	sd	s0,112(sp)
ffffffffc0205a00:	f4a6                	sd	s1,104(sp)
ffffffffc0205a02:	f0ca                	sd	s2,96(sp)
ffffffffc0205a04:	e8d2                	sd	s4,80(sp)
ffffffffc0205a06:	e4d6                	sd	s5,72(sp)
ffffffffc0205a08:	e0da                	sd	s6,64(sp)
ffffffffc0205a0a:	fc5e                	sd	s7,56(sp)
ffffffffc0205a0c:	f862                	sd	s8,48(sp)
ffffffffc0205a0e:	f466                	sd	s9,40(sp)
ffffffffc0205a10:	f06a                	sd	s10,32(sp)
ffffffffc0205a12:	ec6e                	sd	s11,24(sp)
ffffffffc0205a14:	6785                	lui	a5,0x1
ffffffffc0205a16:	34f75263          	bge	a4,a5,ffffffffc0205d5a <do_fork+0x36e>
ffffffffc0205a1a:	892a                	mv	s2,a0
ffffffffc0205a1c:	8a2e                	mv	s4,a1
ffffffffc0205a1e:	8432                	mv	s0,a2
ffffffffc0205a20:	e43ff0ef          	jal	ra,ffffffffc0205862 <alloc_proc>
ffffffffc0205a24:	84aa                	mv	s1,a0
ffffffffc0205a26:	28050363          	beqz	a0,ffffffffc0205cac <do_fork+0x2c0>
ffffffffc0205a2a:	00090d97          	auipc	s11,0x90
ffffffffc0205a2e:	e96d8d93          	addi	s11,s11,-362 # ffffffffc02958c0 <current>
ffffffffc0205a32:	000db783          	ld	a5,0(s11)
ffffffffc0205a36:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_bin_swap_img_size-0x6c14>
ffffffffc0205a3a:	f11c                	sd	a5,32(a0)
ffffffffc0205a3c:	3c071063          	bnez	a4,ffffffffc0205dfc <do_fork+0x410>
ffffffffc0205a40:	4509                	li	a0,2
ffffffffc0205a42:	f2afc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205a46:	26050063          	beqz	a0,ffffffffc0205ca6 <do_fork+0x2ba>
ffffffffc0205a4a:	00090b17          	auipc	s6,0x90
ffffffffc0205a4e:	e5eb0b13          	addi	s6,s6,-418 # ffffffffc02958a8 <pages>
ffffffffc0205a52:	000b3683          	ld	a3,0(s6)
ffffffffc0205a56:	00090b97          	auipc	s7,0x90
ffffffffc0205a5a:	e4ab8b93          	addi	s7,s7,-438 # ffffffffc02958a0 <npage>
ffffffffc0205a5e:	00009a97          	auipc	s5,0x9
ffffffffc0205a62:	222aba83          	ld	s5,546(s5) # ffffffffc020ec80 <nbase>
ffffffffc0205a66:	40d506b3          	sub	a3,a0,a3
ffffffffc0205a6a:	8699                	srai	a3,a3,0x6
ffffffffc0205a6c:	5cfd                	li	s9,-1
ffffffffc0205a6e:	000bb783          	ld	a5,0(s7)
ffffffffc0205a72:	96d6                	add	a3,a3,s5
ffffffffc0205a74:	00ccdc93          	srli	s9,s9,0xc
ffffffffc0205a78:	0196f733          	and	a4,a3,s9
ffffffffc0205a7c:	06b2                	slli	a3,a3,0xc
ffffffffc0205a7e:	32f77663          	bgeu	a4,a5,ffffffffc0205daa <do_fork+0x3be>
ffffffffc0205a82:	000db883          	ld	a7,0(s11)
ffffffffc0205a86:	00090c17          	auipc	s8,0x90
ffffffffc0205a8a:	e32c0c13          	addi	s8,s8,-462 # ffffffffc02958b8 <va_pa_offset>
ffffffffc0205a8e:	000c3703          	ld	a4,0(s8)
ffffffffc0205a92:	0288bd03          	ld	s10,40(a7) # 1028 <_binary_bin_swap_img_size-0x6cd8>
ffffffffc0205a96:	96ba                	add	a3,a3,a4
ffffffffc0205a98:	e894                	sd	a3,16(s1)
ffffffffc0205a9a:	020d0a63          	beqz	s10,ffffffffc0205ace <do_fork+0xe2>
ffffffffc0205a9e:	10097713          	andi	a4,s2,256
ffffffffc0205aa2:	20070763          	beqz	a4,ffffffffc0205cb0 <do_fork+0x2c4>
ffffffffc0205aa6:	030d2683          	lw	a3,48(s10)
ffffffffc0205aaa:	018d3703          	ld	a4,24(s10)
ffffffffc0205aae:	c0200637          	lui	a2,0xc0200
ffffffffc0205ab2:	2685                	addiw	a3,a3,1
ffffffffc0205ab4:	02dd2823          	sw	a3,48(s10)
ffffffffc0205ab8:	03a4b423          	sd	s10,40(s1)
ffffffffc0205abc:	30c76363          	bltu	a4,a2,ffffffffc0205dc2 <do_fork+0x3d6>
ffffffffc0205ac0:	000c3783          	ld	a5,0(s8)
ffffffffc0205ac4:	000db883          	ld	a7,0(s11)
ffffffffc0205ac8:	6894                	ld	a3,16(s1)
ffffffffc0205aca:	8f1d                	sub	a4,a4,a5
ffffffffc0205acc:	f4d8                	sd	a4,168(s1)
ffffffffc0205ace:	6789                	lui	a5,0x2
ffffffffc0205ad0:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205ad4:	96be                	add	a3,a3,a5
ffffffffc0205ad6:	f0d4                	sd	a3,160(s1)
ffffffffc0205ad8:	87b6                	mv	a5,a3
ffffffffc0205ada:	12040813          	addi	a6,s0,288
ffffffffc0205ade:	6008                	ld	a0,0(s0)
ffffffffc0205ae0:	640c                	ld	a1,8(s0)
ffffffffc0205ae2:	6810                	ld	a2,16(s0)
ffffffffc0205ae4:	6c18                	ld	a4,24(s0)
ffffffffc0205ae6:	e388                	sd	a0,0(a5)
ffffffffc0205ae8:	e78c                	sd	a1,8(a5)
ffffffffc0205aea:	eb90                	sd	a2,16(a5)
ffffffffc0205aec:	ef98                	sd	a4,24(a5)
ffffffffc0205aee:	02040413          	addi	s0,s0,32
ffffffffc0205af2:	02078793          	addi	a5,a5,32
ffffffffc0205af6:	ff0414e3          	bne	s0,a6,ffffffffc0205ade <do_fork+0xf2>
ffffffffc0205afa:	0406b823          	sd	zero,80(a3)
ffffffffc0205afe:	140a0e63          	beqz	s4,ffffffffc0205c5a <do_fork+0x26e>
ffffffffc0205b02:	1488b403          	ld	s0,328(a7)
ffffffffc0205b06:	00000797          	auipc	a5,0x0
ffffffffc0205b0a:	df678793          	addi	a5,a5,-522 # ffffffffc02058fc <forkret>
ffffffffc0205b0e:	0146b823          	sd	s4,16(a3)
ffffffffc0205b12:	f89c                	sd	a5,48(s1)
ffffffffc0205b14:	fc94                	sd	a3,56(s1)
ffffffffc0205b16:	2c040363          	beqz	s0,ffffffffc0205ddc <do_fork+0x3f0>
ffffffffc0205b1a:	00b95913          	srli	s2,s2,0xb
ffffffffc0205b1e:	00197913          	andi	s2,s2,1
ffffffffc0205b22:	12090e63          	beqz	s2,ffffffffc0205c5e <do_fork+0x272>
ffffffffc0205b26:	481c                	lw	a5,16(s0)
ffffffffc0205b28:	2785                	addiw	a5,a5,1
ffffffffc0205b2a:	c81c                	sw	a5,16(s0)
ffffffffc0205b2c:	1484b423          	sd	s0,328(s1)
ffffffffc0205b30:	100027f3          	csrr	a5,sstatus
ffffffffc0205b34:	8b89                	andi	a5,a5,2
ffffffffc0205b36:	4901                	li	s2,0
ffffffffc0205b38:	20079863          	bnez	a5,ffffffffc0205d48 <do_fork+0x35c>
ffffffffc0205b3c:	0008a817          	auipc	a6,0x8a
ffffffffc0205b40:	51c80813          	addi	a6,a6,1308 # ffffffffc0290058 <last_pid.1>
ffffffffc0205b44:	00082783          	lw	a5,0(a6)
ffffffffc0205b48:	6709                	lui	a4,0x2
ffffffffc0205b4a:	0017851b          	addiw	a0,a5,1
ffffffffc0205b4e:	00a82023          	sw	a0,0(a6)
ffffffffc0205b52:	08e55d63          	bge	a0,a4,ffffffffc0205bec <do_fork+0x200>
ffffffffc0205b56:	0008a317          	auipc	t1,0x8a
ffffffffc0205b5a:	50630313          	addi	t1,t1,1286 # ffffffffc029005c <next_safe.0>
ffffffffc0205b5e:	00032783          	lw	a5,0(t1)
ffffffffc0205b62:	0008f417          	auipc	s0,0x8f
ffffffffc0205b66:	c5e40413          	addi	s0,s0,-930 # ffffffffc02947c0 <proc_list>
ffffffffc0205b6a:	08f55963          	bge	a0,a5,ffffffffc0205bfc <do_fork+0x210>
ffffffffc0205b6e:	c0c8                	sw	a0,4(s1)
ffffffffc0205b70:	45a9                	li	a1,10
ffffffffc0205b72:	2501                	sext.w	a0,a0
ffffffffc0205b74:	227040ef          	jal	ra,ffffffffc020a59a <hash32>
ffffffffc0205b78:	02051793          	slli	a5,a0,0x20
ffffffffc0205b7c:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205b80:	0008b797          	auipc	a5,0x8b
ffffffffc0205b84:	c4078793          	addi	a5,a5,-960 # ffffffffc02907c0 <hash_list>
ffffffffc0205b88:	953e                	add	a0,a0,a5
ffffffffc0205b8a:	650c                	ld	a1,8(a0)
ffffffffc0205b8c:	7094                	ld	a3,32(s1)
ffffffffc0205b8e:	0d848793          	addi	a5,s1,216
ffffffffc0205b92:	e19c                	sd	a5,0(a1)
ffffffffc0205b94:	6410                	ld	a2,8(s0)
ffffffffc0205b96:	e51c                	sd	a5,8(a0)
ffffffffc0205b98:	7af8                	ld	a4,240(a3)
ffffffffc0205b9a:	0c848793          	addi	a5,s1,200
ffffffffc0205b9e:	f0ec                	sd	a1,224(s1)
ffffffffc0205ba0:	ece8                	sd	a0,216(s1)
ffffffffc0205ba2:	e21c                	sd	a5,0(a2)
ffffffffc0205ba4:	e41c                	sd	a5,8(s0)
ffffffffc0205ba6:	e8f0                	sd	a2,208(s1)
ffffffffc0205ba8:	e4e0                	sd	s0,200(s1)
ffffffffc0205baa:	0e04bc23          	sd	zero,248(s1)
ffffffffc0205bae:	10e4b023          	sd	a4,256(s1)
ffffffffc0205bb2:	c311                	beqz	a4,ffffffffc0205bb6 <do_fork+0x1ca>
ffffffffc0205bb4:	ff64                	sd	s1,248(a4)
ffffffffc0205bb6:	0009a783          	lw	a5,0(s3)
ffffffffc0205bba:	fae4                	sd	s1,240(a3)
ffffffffc0205bbc:	2785                	addiw	a5,a5,1
ffffffffc0205bbe:	00f9a023          	sw	a5,0(s3)
ffffffffc0205bc2:	16091763          	bnez	s2,ffffffffc0205d30 <do_fork+0x344>
ffffffffc0205bc6:	8526                	mv	a0,s1
ffffffffc0205bc8:	725000ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0205bcc:	40c8                	lw	a0,4(s1)
ffffffffc0205bce:	70e6                	ld	ra,120(sp)
ffffffffc0205bd0:	7446                	ld	s0,112(sp)
ffffffffc0205bd2:	74a6                	ld	s1,104(sp)
ffffffffc0205bd4:	7906                	ld	s2,96(sp)
ffffffffc0205bd6:	69e6                	ld	s3,88(sp)
ffffffffc0205bd8:	6a46                	ld	s4,80(sp)
ffffffffc0205bda:	6aa6                	ld	s5,72(sp)
ffffffffc0205bdc:	6b06                	ld	s6,64(sp)
ffffffffc0205bde:	7be2                	ld	s7,56(sp)
ffffffffc0205be0:	7c42                	ld	s8,48(sp)
ffffffffc0205be2:	7ca2                	ld	s9,40(sp)
ffffffffc0205be4:	7d02                	ld	s10,32(sp)
ffffffffc0205be6:	6de2                	ld	s11,24(sp)
ffffffffc0205be8:	6109                	addi	sp,sp,128
ffffffffc0205bea:	8082                	ret
ffffffffc0205bec:	4785                	li	a5,1
ffffffffc0205bee:	00f82023          	sw	a5,0(a6)
ffffffffc0205bf2:	4505                	li	a0,1
ffffffffc0205bf4:	0008a317          	auipc	t1,0x8a
ffffffffc0205bf8:	46830313          	addi	t1,t1,1128 # ffffffffc029005c <next_safe.0>
ffffffffc0205bfc:	0008f417          	auipc	s0,0x8f
ffffffffc0205c00:	bc440413          	addi	s0,s0,-1084 # ffffffffc02947c0 <proc_list>
ffffffffc0205c04:	00843e03          	ld	t3,8(s0)
ffffffffc0205c08:	6789                	lui	a5,0x2
ffffffffc0205c0a:	00f32023          	sw	a5,0(t1)
ffffffffc0205c0e:	86aa                	mv	a3,a0
ffffffffc0205c10:	4581                	li	a1,0
ffffffffc0205c12:	6e89                	lui	t4,0x2
ffffffffc0205c14:	128e0e63          	beq	t3,s0,ffffffffc0205d50 <do_fork+0x364>
ffffffffc0205c18:	88ae                	mv	a7,a1
ffffffffc0205c1a:	87f2                	mv	a5,t3
ffffffffc0205c1c:	6609                	lui	a2,0x2
ffffffffc0205c1e:	a811                	j	ffffffffc0205c32 <do_fork+0x246>
ffffffffc0205c20:	00e6d663          	bge	a3,a4,ffffffffc0205c2c <do_fork+0x240>
ffffffffc0205c24:	00c75463          	bge	a4,a2,ffffffffc0205c2c <do_fork+0x240>
ffffffffc0205c28:	863a                	mv	a2,a4
ffffffffc0205c2a:	4885                	li	a7,1
ffffffffc0205c2c:	679c                	ld	a5,8(a5)
ffffffffc0205c2e:	00878d63          	beq	a5,s0,ffffffffc0205c48 <do_fork+0x25c>
ffffffffc0205c32:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205c36:	fed715e3          	bne	a4,a3,ffffffffc0205c20 <do_fork+0x234>
ffffffffc0205c3a:	2685                	addiw	a3,a3,1
ffffffffc0205c3c:	0ec6dd63          	bge	a3,a2,ffffffffc0205d36 <do_fork+0x34a>
ffffffffc0205c40:	679c                	ld	a5,8(a5)
ffffffffc0205c42:	4585                	li	a1,1
ffffffffc0205c44:	fe8797e3          	bne	a5,s0,ffffffffc0205c32 <do_fork+0x246>
ffffffffc0205c48:	c581                	beqz	a1,ffffffffc0205c50 <do_fork+0x264>
ffffffffc0205c4a:	00d82023          	sw	a3,0(a6)
ffffffffc0205c4e:	8536                	mv	a0,a3
ffffffffc0205c50:	f0088fe3          	beqz	a7,ffffffffc0205b6e <do_fork+0x182>
ffffffffc0205c54:	00c32023          	sw	a2,0(t1)
ffffffffc0205c58:	bf19                	j	ffffffffc0205b6e <do_fork+0x182>
ffffffffc0205c5a:	8a36                	mv	s4,a3
ffffffffc0205c5c:	b55d                	j	ffffffffc0205b02 <do_fork+0x116>
ffffffffc0205c5e:	bfeff0ef          	jal	ra,ffffffffc020505c <files_create>
ffffffffc0205c62:	892a                	mv	s2,a0
ffffffffc0205c64:	c911                	beqz	a0,ffffffffc0205c78 <do_fork+0x28c>
ffffffffc0205c66:	85a2                	mv	a1,s0
ffffffffc0205c68:	d2cff0ef          	jal	ra,ffffffffc0205194 <dup_files>
ffffffffc0205c6c:	844a                	mv	s0,s2
ffffffffc0205c6e:	ea050ce3          	beqz	a0,ffffffffc0205b26 <do_fork+0x13a>
ffffffffc0205c72:	854a                	mv	a0,s2
ffffffffc0205c74:	c1eff0ef          	jal	ra,ffffffffc0205092 <files_destroy>
ffffffffc0205c78:	6894                	ld	a3,16(s1)
ffffffffc0205c7a:	c02007b7          	lui	a5,0xc0200
ffffffffc0205c7e:	0ef6ee63          	bltu	a3,a5,ffffffffc0205d7a <do_fork+0x38e>
ffffffffc0205c82:	000c3783          	ld	a5,0(s8)
ffffffffc0205c86:	000bb703          	ld	a4,0(s7)
ffffffffc0205c8a:	40f687b3          	sub	a5,a3,a5
ffffffffc0205c8e:	83b1                	srli	a5,a5,0xc
ffffffffc0205c90:	10e7f163          	bgeu	a5,a4,ffffffffc0205d92 <do_fork+0x3a6>
ffffffffc0205c94:	000b3503          	ld	a0,0(s6)
ffffffffc0205c98:	415787b3          	sub	a5,a5,s5
ffffffffc0205c9c:	079a                	slli	a5,a5,0x6
ffffffffc0205c9e:	4589                	li	a1,2
ffffffffc0205ca0:	953e                	add	a0,a0,a5
ffffffffc0205ca2:	d08fc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205ca6:	8526                	mv	a0,s1
ffffffffc0205ca8:	b96fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205cac:	5571                	li	a0,-4
ffffffffc0205cae:	b705                	j	ffffffffc0205bce <do_fork+0x1e2>
ffffffffc0205cb0:	e97fd0ef          	jal	ra,ffffffffc0203b46 <mm_create>
ffffffffc0205cb4:	e02a                	sd	a0,0(sp)
ffffffffc0205cb6:	d169                	beqz	a0,ffffffffc0205c78 <do_fork+0x28c>
ffffffffc0205cb8:	4505                	li	a0,1
ffffffffc0205cba:	cb2fc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205cbe:	c149                	beqz	a0,ffffffffc0205d40 <do_fork+0x354>
ffffffffc0205cc0:	000b3683          	ld	a3,0(s6)
ffffffffc0205cc4:	000bb703          	ld	a4,0(s7)
ffffffffc0205cc8:	40d506b3          	sub	a3,a0,a3
ffffffffc0205ccc:	8699                	srai	a3,a3,0x6
ffffffffc0205cce:	96d6                	add	a3,a3,s5
ffffffffc0205cd0:	0196fcb3          	and	s9,a3,s9
ffffffffc0205cd4:	06b2                	slli	a3,a3,0xc
ffffffffc0205cd6:	0cecfa63          	bgeu	s9,a4,ffffffffc0205daa <do_fork+0x3be>
ffffffffc0205cda:	000c3c83          	ld	s9,0(s8)
ffffffffc0205cde:	6605                	lui	a2,0x1
ffffffffc0205ce0:	00090597          	auipc	a1,0x90
ffffffffc0205ce4:	bb85b583          	ld	a1,-1096(a1) # ffffffffc0295898 <boot_pgdir_va>
ffffffffc0205ce8:	9cb6                	add	s9,s9,a3
ffffffffc0205cea:	8566                	mv	a0,s9
ffffffffc0205cec:	635040ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc0205cf0:	6782                	ld	a5,0(sp)
ffffffffc0205cf2:	038d0713          	addi	a4,s10,56
ffffffffc0205cf6:	853a                	mv	a0,a4
ffffffffc0205cf8:	0197bc23          	sd	s9,24(a5) # ffffffffc0200018 <kern_entry+0x18>
ffffffffc0205cfc:	e43a                	sd	a4,8(sp)
ffffffffc0205cfe:	ef4fe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0205d02:	000db683          	ld	a3,0(s11)
ffffffffc0205d06:	6722                	ld	a4,8(sp)
ffffffffc0205d08:	c681                	beqz	a3,ffffffffc0205d10 <do_fork+0x324>
ffffffffc0205d0a:	42d4                	lw	a3,4(a3)
ffffffffc0205d0c:	04dd2823          	sw	a3,80(s10)
ffffffffc0205d10:	6502                	ld	a0,0(sp)
ffffffffc0205d12:	85ea                	mv	a1,s10
ffffffffc0205d14:	e43a                	sd	a4,8(sp)
ffffffffc0205d16:	fd1fd0ef          	jal	ra,ffffffffc0203ce6 <dup_mmap>
ffffffffc0205d1a:	6722                	ld	a4,8(sp)
ffffffffc0205d1c:	8caa                	mv	s9,a0
ffffffffc0205d1e:	853a                	mv	a0,a4
ffffffffc0205d20:	ecefe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0205d24:	040d2823          	sw	zero,80(s10)
ffffffffc0205d28:	020c9e63          	bnez	s9,ffffffffc0205d64 <do_fork+0x378>
ffffffffc0205d2c:	6d02                	ld	s10,0(sp)
ffffffffc0205d2e:	bba5                	j	ffffffffc0205aa6 <do_fork+0xba>
ffffffffc0205d30:	f3dfa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205d34:	bd49                	j	ffffffffc0205bc6 <do_fork+0x1da>
ffffffffc0205d36:	01d6c363          	blt	a3,t4,ffffffffc0205d3c <do_fork+0x350>
ffffffffc0205d3a:	4685                	li	a3,1
ffffffffc0205d3c:	4585                	li	a1,1
ffffffffc0205d3e:	bdd9                	j	ffffffffc0205c14 <do_fork+0x228>
ffffffffc0205d40:	6502                	ld	a0,0(sp)
ffffffffc0205d42:	f53fd0ef          	jal	ra,ffffffffc0203c94 <mm_destroy>
ffffffffc0205d46:	bf0d                	j	ffffffffc0205c78 <do_fork+0x28c>
ffffffffc0205d48:	f2bfa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205d4c:	4905                	li	s2,1
ffffffffc0205d4e:	b3fd                	j	ffffffffc0205b3c <do_fork+0x150>
ffffffffc0205d50:	c599                	beqz	a1,ffffffffc0205d5e <do_fork+0x372>
ffffffffc0205d52:	00d82023          	sw	a3,0(a6)
ffffffffc0205d56:	8536                	mv	a0,a3
ffffffffc0205d58:	bd19                	j	ffffffffc0205b6e <do_fork+0x182>
ffffffffc0205d5a:	556d                	li	a0,-5
ffffffffc0205d5c:	bd8d                	j	ffffffffc0205bce <do_fork+0x1e2>
ffffffffc0205d5e:	00082503          	lw	a0,0(a6)
ffffffffc0205d62:	b531                	j	ffffffffc0205b6e <do_fork+0x182>
ffffffffc0205d64:	6402                	ld	s0,0(sp)
ffffffffc0205d66:	8522                	mv	a0,s0
ffffffffc0205d68:	818fe0ef          	jal	ra,ffffffffc0203d80 <exit_mmap>
ffffffffc0205d6c:	6c08                	ld	a0,24(s0)
ffffffffc0205d6e:	b9dff0ef          	jal	ra,ffffffffc020590a <put_pgdir.isra.0>
ffffffffc0205d72:	8522                	mv	a0,s0
ffffffffc0205d74:	f21fd0ef          	jal	ra,ffffffffc0203c94 <mm_destroy>
ffffffffc0205d78:	b701                	j	ffffffffc0205c78 <do_fork+0x28c>
ffffffffc0205d7a:	00006617          	auipc	a2,0x6
ffffffffc0205d7e:	dfe60613          	addi	a2,a2,-514 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0205d82:	07700593          	li	a1,119
ffffffffc0205d86:	00006517          	auipc	a0,0x6
ffffffffc0205d8a:	d7250513          	addi	a0,a0,-654 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0205d8e:	f10fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205d92:	00006617          	auipc	a2,0x6
ffffffffc0205d96:	e0e60613          	addi	a2,a2,-498 # ffffffffc020bba0 <default_pmm_manager+0x108>
ffffffffc0205d9a:	06900593          	li	a1,105
ffffffffc0205d9e:	00006517          	auipc	a0,0x6
ffffffffc0205da2:	d5a50513          	addi	a0,a0,-678 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0205da6:	ef8fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205daa:	00006617          	auipc	a2,0x6
ffffffffc0205dae:	d2660613          	addi	a2,a2,-730 # ffffffffc020bad0 <default_pmm_manager+0x38>
ffffffffc0205db2:	07100593          	li	a1,113
ffffffffc0205db6:	00006517          	auipc	a0,0x6
ffffffffc0205dba:	d4250513          	addi	a0,a0,-702 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc0205dbe:	ee0fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205dc2:	86ba                	mv	a3,a4
ffffffffc0205dc4:	00006617          	auipc	a2,0x6
ffffffffc0205dc8:	db460613          	addi	a2,a2,-588 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0205dcc:	19e00593          	li	a1,414
ffffffffc0205dd0:	00007517          	auipc	a0,0x7
ffffffffc0205dd4:	ce850513          	addi	a0,a0,-792 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0205dd8:	ec6fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205ddc:	00007697          	auipc	a3,0x7
ffffffffc0205de0:	cf468693          	addi	a3,a3,-780 # ffffffffc020cad0 <CSWTCH.79+0x128>
ffffffffc0205de4:	00005617          	auipc	a2,0x5
ffffffffc0205de8:	1cc60613          	addi	a2,a2,460 # ffffffffc020afb0 <commands+0x210>
ffffffffc0205dec:	1be00593          	li	a1,446
ffffffffc0205df0:	00007517          	auipc	a0,0x7
ffffffffc0205df4:	cc850513          	addi	a0,a0,-824 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0205df8:	ea6fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205dfc:	00007697          	auipc	a3,0x7
ffffffffc0205e00:	c9c68693          	addi	a3,a3,-868 # ffffffffc020ca98 <CSWTCH.79+0xf0>
ffffffffc0205e04:	00005617          	auipc	a2,0x5
ffffffffc0205e08:	1ac60613          	addi	a2,a2,428 # ffffffffc020afb0 <commands+0x210>
ffffffffc0205e0c:	22000593          	li	a1,544
ffffffffc0205e10:	00007517          	auipc	a0,0x7
ffffffffc0205e14:	ca850513          	addi	a0,a0,-856 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0205e18:	e86fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205e1c <kernel_thread>:
ffffffffc0205e1c:	7129                	addi	sp,sp,-320
ffffffffc0205e1e:	fa22                	sd	s0,304(sp)
ffffffffc0205e20:	f626                	sd	s1,296(sp)
ffffffffc0205e22:	f24a                	sd	s2,288(sp)
ffffffffc0205e24:	84ae                	mv	s1,a1
ffffffffc0205e26:	892a                	mv	s2,a0
ffffffffc0205e28:	8432                	mv	s0,a2
ffffffffc0205e2a:	4581                	li	a1,0
ffffffffc0205e2c:	12000613          	li	a2,288
ffffffffc0205e30:	850a                	mv	a0,sp
ffffffffc0205e32:	fe06                	sd	ra,312(sp)
ffffffffc0205e34:	49b040ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0205e38:	e0ca                	sd	s2,64(sp)
ffffffffc0205e3a:	e4a6                	sd	s1,72(sp)
ffffffffc0205e3c:	100027f3          	csrr	a5,sstatus
ffffffffc0205e40:	edd7f793          	andi	a5,a5,-291
ffffffffc0205e44:	1207e793          	ori	a5,a5,288
ffffffffc0205e48:	e23e                	sd	a5,256(sp)
ffffffffc0205e4a:	860a                	mv	a2,sp
ffffffffc0205e4c:	10046513          	ori	a0,s0,256
ffffffffc0205e50:	00000797          	auipc	a5,0x0
ffffffffc0205e54:	a0a78793          	addi	a5,a5,-1526 # ffffffffc020585a <kernel_thread_entry>
ffffffffc0205e58:	4581                	li	a1,0
ffffffffc0205e5a:	e63e                	sd	a5,264(sp)
ffffffffc0205e5c:	b91ff0ef          	jal	ra,ffffffffc02059ec <do_fork>
ffffffffc0205e60:	70f2                	ld	ra,312(sp)
ffffffffc0205e62:	7452                	ld	s0,304(sp)
ffffffffc0205e64:	74b2                	ld	s1,296(sp)
ffffffffc0205e66:	7912                	ld	s2,288(sp)
ffffffffc0205e68:	6131                	addi	sp,sp,320
ffffffffc0205e6a:	8082                	ret

ffffffffc0205e6c <do_exit>:
ffffffffc0205e6c:	7179                	addi	sp,sp,-48
ffffffffc0205e6e:	f022                	sd	s0,32(sp)
ffffffffc0205e70:	00090417          	auipc	s0,0x90
ffffffffc0205e74:	a5040413          	addi	s0,s0,-1456 # ffffffffc02958c0 <current>
ffffffffc0205e78:	601c                	ld	a5,0(s0)
ffffffffc0205e7a:	f406                	sd	ra,40(sp)
ffffffffc0205e7c:	ec26                	sd	s1,24(sp)
ffffffffc0205e7e:	e84a                	sd	s2,16(sp)
ffffffffc0205e80:	e44e                	sd	s3,8(sp)
ffffffffc0205e82:	e052                	sd	s4,0(sp)
ffffffffc0205e84:	00090717          	auipc	a4,0x90
ffffffffc0205e88:	a4473703          	ld	a4,-1468(a4) # ffffffffc02958c8 <idleproc>
ffffffffc0205e8c:	0ee78763          	beq	a5,a4,ffffffffc0205f7a <do_exit+0x10e>
ffffffffc0205e90:	00090497          	auipc	s1,0x90
ffffffffc0205e94:	a4048493          	addi	s1,s1,-1472 # ffffffffc02958d0 <initproc>
ffffffffc0205e98:	6098                	ld	a4,0(s1)
ffffffffc0205e9a:	10e78763          	beq	a5,a4,ffffffffc0205fa8 <do_exit+0x13c>
ffffffffc0205e9e:	0287b983          	ld	s3,40(a5)
ffffffffc0205ea2:	892a                	mv	s2,a0
ffffffffc0205ea4:	02098e63          	beqz	s3,ffffffffc0205ee0 <do_exit+0x74>
ffffffffc0205ea8:	00090797          	auipc	a5,0x90
ffffffffc0205eac:	9e87b783          	ld	a5,-1560(a5) # ffffffffc0295890 <boot_pgdir_pa>
ffffffffc0205eb0:	577d                	li	a4,-1
ffffffffc0205eb2:	177e                	slli	a4,a4,0x3f
ffffffffc0205eb4:	83b1                	srli	a5,a5,0xc
ffffffffc0205eb6:	8fd9                	or	a5,a5,a4
ffffffffc0205eb8:	18079073          	csrw	satp,a5
ffffffffc0205ebc:	0309a783          	lw	a5,48(s3)
ffffffffc0205ec0:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205ec4:	02e9a823          	sw	a4,48(s3)
ffffffffc0205ec8:	c769                	beqz	a4,ffffffffc0205f92 <do_exit+0x126>
ffffffffc0205eca:	601c                	ld	a5,0(s0)
ffffffffc0205ecc:	1487b503          	ld	a0,328(a5)
ffffffffc0205ed0:	0207b423          	sd	zero,40(a5)
ffffffffc0205ed4:	c511                	beqz	a0,ffffffffc0205ee0 <do_exit+0x74>
ffffffffc0205ed6:	491c                	lw	a5,16(a0)
ffffffffc0205ed8:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205edc:	c918                	sw	a4,16(a0)
ffffffffc0205ede:	cb59                	beqz	a4,ffffffffc0205f74 <do_exit+0x108>
ffffffffc0205ee0:	601c                	ld	a5,0(s0)
ffffffffc0205ee2:	470d                	li	a4,3
ffffffffc0205ee4:	c398                	sw	a4,0(a5)
ffffffffc0205ee6:	0f27a423          	sw	s2,232(a5)
ffffffffc0205eea:	100027f3          	csrr	a5,sstatus
ffffffffc0205eee:	8b89                	andi	a5,a5,2
ffffffffc0205ef0:	4a01                	li	s4,0
ffffffffc0205ef2:	e7f9                	bnez	a5,ffffffffc0205fc0 <do_exit+0x154>
ffffffffc0205ef4:	6018                	ld	a4,0(s0)
ffffffffc0205ef6:	800007b7          	lui	a5,0x80000
ffffffffc0205efa:	0785                	addi	a5,a5,1
ffffffffc0205efc:	7308                	ld	a0,32(a4)
ffffffffc0205efe:	0ec52703          	lw	a4,236(a0)
ffffffffc0205f02:	0cf70363          	beq	a4,a5,ffffffffc0205fc8 <do_exit+0x15c>
ffffffffc0205f06:	6018                	ld	a4,0(s0)
ffffffffc0205f08:	7b7c                	ld	a5,240(a4)
ffffffffc0205f0a:	c3a1                	beqz	a5,ffffffffc0205f4a <do_exit+0xde>
ffffffffc0205f0c:	800009b7          	lui	s3,0x80000
ffffffffc0205f10:	490d                	li	s2,3
ffffffffc0205f12:	0985                	addi	s3,s3,1
ffffffffc0205f14:	a021                	j	ffffffffc0205f1c <do_exit+0xb0>
ffffffffc0205f16:	6018                	ld	a4,0(s0)
ffffffffc0205f18:	7b7c                	ld	a5,240(a4)
ffffffffc0205f1a:	cb85                	beqz	a5,ffffffffc0205f4a <do_exit+0xde>
ffffffffc0205f1c:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc0205f20:	6088                	ld	a0,0(s1)
ffffffffc0205f22:	fb74                	sd	a3,240(a4)
ffffffffc0205f24:	7978                	ld	a4,240(a0)
ffffffffc0205f26:	0e07bc23          	sd	zero,248(a5)
ffffffffc0205f2a:	10e7b023          	sd	a4,256(a5)
ffffffffc0205f2e:	c311                	beqz	a4,ffffffffc0205f32 <do_exit+0xc6>
ffffffffc0205f30:	ff7c                	sd	a5,248(a4)
ffffffffc0205f32:	4398                	lw	a4,0(a5)
ffffffffc0205f34:	f388                	sd	a0,32(a5)
ffffffffc0205f36:	f97c                	sd	a5,240(a0)
ffffffffc0205f38:	fd271fe3          	bne	a4,s2,ffffffffc0205f16 <do_exit+0xaa>
ffffffffc0205f3c:	0ec52783          	lw	a5,236(a0)
ffffffffc0205f40:	fd379be3          	bne	a5,s3,ffffffffc0205f16 <do_exit+0xaa>
ffffffffc0205f44:	3a9000ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0205f48:	b7f9                	j	ffffffffc0205f16 <do_exit+0xaa>
ffffffffc0205f4a:	020a1263          	bnez	s4,ffffffffc0205f6e <do_exit+0x102>
ffffffffc0205f4e:	451000ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc0205f52:	601c                	ld	a5,0(s0)
ffffffffc0205f54:	00007617          	auipc	a2,0x7
ffffffffc0205f58:	bb460613          	addi	a2,a2,-1100 # ffffffffc020cb08 <CSWTCH.79+0x160>
ffffffffc0205f5c:	28e00593          	li	a1,654
ffffffffc0205f60:	43d4                	lw	a3,4(a5)
ffffffffc0205f62:	00007517          	auipc	a0,0x7
ffffffffc0205f66:	b5650513          	addi	a0,a0,-1194 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0205f6a:	d34fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f6e:	cfffa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205f72:	bff1                	j	ffffffffc0205f4e <do_exit+0xe2>
ffffffffc0205f74:	91eff0ef          	jal	ra,ffffffffc0205092 <files_destroy>
ffffffffc0205f78:	b7a5                	j	ffffffffc0205ee0 <do_exit+0x74>
ffffffffc0205f7a:	00007617          	auipc	a2,0x7
ffffffffc0205f7e:	b6e60613          	addi	a2,a2,-1170 # ffffffffc020cae8 <CSWTCH.79+0x140>
ffffffffc0205f82:	25900593          	li	a1,601
ffffffffc0205f86:	00007517          	auipc	a0,0x7
ffffffffc0205f8a:	b3250513          	addi	a0,a0,-1230 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0205f8e:	d10fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f92:	854e                	mv	a0,s3
ffffffffc0205f94:	dedfd0ef          	jal	ra,ffffffffc0203d80 <exit_mmap>
ffffffffc0205f98:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc0205f9c:	96fff0ef          	jal	ra,ffffffffc020590a <put_pgdir.isra.0>
ffffffffc0205fa0:	854e                	mv	a0,s3
ffffffffc0205fa2:	cf3fd0ef          	jal	ra,ffffffffc0203c94 <mm_destroy>
ffffffffc0205fa6:	b715                	j	ffffffffc0205eca <do_exit+0x5e>
ffffffffc0205fa8:	00007617          	auipc	a2,0x7
ffffffffc0205fac:	b5060613          	addi	a2,a2,-1200 # ffffffffc020caf8 <CSWTCH.79+0x150>
ffffffffc0205fb0:	25d00593          	li	a1,605
ffffffffc0205fb4:	00007517          	auipc	a0,0x7
ffffffffc0205fb8:	b0450513          	addi	a0,a0,-1276 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0205fbc:	ce2fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fc0:	cb3fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205fc4:	4a05                	li	s4,1
ffffffffc0205fc6:	b73d                	j	ffffffffc0205ef4 <do_exit+0x88>
ffffffffc0205fc8:	325000ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0205fcc:	bf2d                	j	ffffffffc0205f06 <do_exit+0x9a>

ffffffffc0205fce <do_wait.part.0>:
ffffffffc0205fce:	715d                	addi	sp,sp,-80
ffffffffc0205fd0:	f84a                	sd	s2,48(sp)
ffffffffc0205fd2:	f44e                	sd	s3,40(sp)
ffffffffc0205fd4:	80000937          	lui	s2,0x80000
ffffffffc0205fd8:	6989                	lui	s3,0x2
ffffffffc0205fda:	fc26                	sd	s1,56(sp)
ffffffffc0205fdc:	f052                	sd	s4,32(sp)
ffffffffc0205fde:	ec56                	sd	s5,24(sp)
ffffffffc0205fe0:	e85a                	sd	s6,16(sp)
ffffffffc0205fe2:	e45e                	sd	s7,8(sp)
ffffffffc0205fe4:	e486                	sd	ra,72(sp)
ffffffffc0205fe6:	e0a2                	sd	s0,64(sp)
ffffffffc0205fe8:	84aa                	mv	s1,a0
ffffffffc0205fea:	8a2e                	mv	s4,a1
ffffffffc0205fec:	00090b97          	auipc	s7,0x90
ffffffffc0205ff0:	8d4b8b93          	addi	s7,s7,-1836 # ffffffffc02958c0 <current>
ffffffffc0205ff4:	00050b1b          	sext.w	s6,a0
ffffffffc0205ff8:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0205ffc:	19f9                	addi	s3,s3,-2
ffffffffc0205ffe:	0905                	addi	s2,s2,1
ffffffffc0206000:	ccbd                	beqz	s1,ffffffffc020607e <do_wait.part.0+0xb0>
ffffffffc0206002:	0359e863          	bltu	s3,s5,ffffffffc0206032 <do_wait.part.0+0x64>
ffffffffc0206006:	45a9                	li	a1,10
ffffffffc0206008:	855a                	mv	a0,s6
ffffffffc020600a:	590040ef          	jal	ra,ffffffffc020a59a <hash32>
ffffffffc020600e:	02051793          	slli	a5,a0,0x20
ffffffffc0206012:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206016:	0008a797          	auipc	a5,0x8a
ffffffffc020601a:	7aa78793          	addi	a5,a5,1962 # ffffffffc02907c0 <hash_list>
ffffffffc020601e:	953e                	add	a0,a0,a5
ffffffffc0206020:	842a                	mv	s0,a0
ffffffffc0206022:	a029                	j	ffffffffc020602c <do_wait.part.0+0x5e>
ffffffffc0206024:	f2c42783          	lw	a5,-212(s0)
ffffffffc0206028:	02978163          	beq	a5,s1,ffffffffc020604a <do_wait.part.0+0x7c>
ffffffffc020602c:	6400                	ld	s0,8(s0)
ffffffffc020602e:	fe851be3          	bne	a0,s0,ffffffffc0206024 <do_wait.part.0+0x56>
ffffffffc0206032:	5579                	li	a0,-2
ffffffffc0206034:	60a6                	ld	ra,72(sp)
ffffffffc0206036:	6406                	ld	s0,64(sp)
ffffffffc0206038:	74e2                	ld	s1,56(sp)
ffffffffc020603a:	7942                	ld	s2,48(sp)
ffffffffc020603c:	79a2                	ld	s3,40(sp)
ffffffffc020603e:	7a02                	ld	s4,32(sp)
ffffffffc0206040:	6ae2                	ld	s5,24(sp)
ffffffffc0206042:	6b42                	ld	s6,16(sp)
ffffffffc0206044:	6ba2                	ld	s7,8(sp)
ffffffffc0206046:	6161                	addi	sp,sp,80
ffffffffc0206048:	8082                	ret
ffffffffc020604a:	000bb683          	ld	a3,0(s7)
ffffffffc020604e:	f4843783          	ld	a5,-184(s0)
ffffffffc0206052:	fed790e3          	bne	a5,a3,ffffffffc0206032 <do_wait.part.0+0x64>
ffffffffc0206056:	f2842703          	lw	a4,-216(s0)
ffffffffc020605a:	478d                	li	a5,3
ffffffffc020605c:	0ef70b63          	beq	a4,a5,ffffffffc0206152 <do_wait.part.0+0x184>
ffffffffc0206060:	4785                	li	a5,1
ffffffffc0206062:	c29c                	sw	a5,0(a3)
ffffffffc0206064:	0f26a623          	sw	s2,236(a3)
ffffffffc0206068:	337000ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc020606c:	000bb783          	ld	a5,0(s7)
ffffffffc0206070:	0b07a783          	lw	a5,176(a5)
ffffffffc0206074:	8b85                	andi	a5,a5,1
ffffffffc0206076:	d7c9                	beqz	a5,ffffffffc0206000 <do_wait.part.0+0x32>
ffffffffc0206078:	555d                	li	a0,-9
ffffffffc020607a:	df3ff0ef          	jal	ra,ffffffffc0205e6c <do_exit>
ffffffffc020607e:	000bb683          	ld	a3,0(s7)
ffffffffc0206082:	7ae0                	ld	s0,240(a3)
ffffffffc0206084:	d45d                	beqz	s0,ffffffffc0206032 <do_wait.part.0+0x64>
ffffffffc0206086:	470d                	li	a4,3
ffffffffc0206088:	a021                	j	ffffffffc0206090 <do_wait.part.0+0xc2>
ffffffffc020608a:	10043403          	ld	s0,256(s0)
ffffffffc020608e:	d869                	beqz	s0,ffffffffc0206060 <do_wait.part.0+0x92>
ffffffffc0206090:	401c                	lw	a5,0(s0)
ffffffffc0206092:	fee79ce3          	bne	a5,a4,ffffffffc020608a <do_wait.part.0+0xbc>
ffffffffc0206096:	00090797          	auipc	a5,0x90
ffffffffc020609a:	8327b783          	ld	a5,-1998(a5) # ffffffffc02958c8 <idleproc>
ffffffffc020609e:	0c878963          	beq	a5,s0,ffffffffc0206170 <do_wait.part.0+0x1a2>
ffffffffc02060a2:	00090797          	auipc	a5,0x90
ffffffffc02060a6:	82e7b783          	ld	a5,-2002(a5) # ffffffffc02958d0 <initproc>
ffffffffc02060aa:	0cf40363          	beq	s0,a5,ffffffffc0206170 <do_wait.part.0+0x1a2>
ffffffffc02060ae:	000a0663          	beqz	s4,ffffffffc02060ba <do_wait.part.0+0xec>
ffffffffc02060b2:	0e842783          	lw	a5,232(s0)
ffffffffc02060b6:	00fa2023          	sw	a5,0(s4)
ffffffffc02060ba:	100027f3          	csrr	a5,sstatus
ffffffffc02060be:	8b89                	andi	a5,a5,2
ffffffffc02060c0:	4581                	li	a1,0
ffffffffc02060c2:	e7c1                	bnez	a5,ffffffffc020614a <do_wait.part.0+0x17c>
ffffffffc02060c4:	6c70                	ld	a2,216(s0)
ffffffffc02060c6:	7074                	ld	a3,224(s0)
ffffffffc02060c8:	10043703          	ld	a4,256(s0)
ffffffffc02060cc:	7c7c                	ld	a5,248(s0)
ffffffffc02060ce:	e614                	sd	a3,8(a2)
ffffffffc02060d0:	e290                	sd	a2,0(a3)
ffffffffc02060d2:	6470                	ld	a2,200(s0)
ffffffffc02060d4:	6874                	ld	a3,208(s0)
ffffffffc02060d6:	e614                	sd	a3,8(a2)
ffffffffc02060d8:	e290                	sd	a2,0(a3)
ffffffffc02060da:	c319                	beqz	a4,ffffffffc02060e0 <do_wait.part.0+0x112>
ffffffffc02060dc:	ff7c                	sd	a5,248(a4)
ffffffffc02060de:	7c7c                	ld	a5,248(s0)
ffffffffc02060e0:	c3b5                	beqz	a5,ffffffffc0206144 <do_wait.part.0+0x176>
ffffffffc02060e2:	10e7b023          	sd	a4,256(a5)
ffffffffc02060e6:	0008f717          	auipc	a4,0x8f
ffffffffc02060ea:	7f270713          	addi	a4,a4,2034 # ffffffffc02958d8 <nr_process>
ffffffffc02060ee:	431c                	lw	a5,0(a4)
ffffffffc02060f0:	37fd                	addiw	a5,a5,-1
ffffffffc02060f2:	c31c                	sw	a5,0(a4)
ffffffffc02060f4:	e5a9                	bnez	a1,ffffffffc020613e <do_wait.part.0+0x170>
ffffffffc02060f6:	6814                	ld	a3,16(s0)
ffffffffc02060f8:	c02007b7          	lui	a5,0xc0200
ffffffffc02060fc:	04f6ee63          	bltu	a3,a5,ffffffffc0206158 <do_wait.part.0+0x18a>
ffffffffc0206100:	0008f797          	auipc	a5,0x8f
ffffffffc0206104:	7b87b783          	ld	a5,1976(a5) # ffffffffc02958b8 <va_pa_offset>
ffffffffc0206108:	8e9d                	sub	a3,a3,a5
ffffffffc020610a:	82b1                	srli	a3,a3,0xc
ffffffffc020610c:	0008f797          	auipc	a5,0x8f
ffffffffc0206110:	7947b783          	ld	a5,1940(a5) # ffffffffc02958a0 <npage>
ffffffffc0206114:	06f6fa63          	bgeu	a3,a5,ffffffffc0206188 <do_wait.part.0+0x1ba>
ffffffffc0206118:	00009517          	auipc	a0,0x9
ffffffffc020611c:	b6853503          	ld	a0,-1176(a0) # ffffffffc020ec80 <nbase>
ffffffffc0206120:	8e89                	sub	a3,a3,a0
ffffffffc0206122:	069a                	slli	a3,a3,0x6
ffffffffc0206124:	0008f517          	auipc	a0,0x8f
ffffffffc0206128:	78453503          	ld	a0,1924(a0) # ffffffffc02958a8 <pages>
ffffffffc020612c:	9536                	add	a0,a0,a3
ffffffffc020612e:	4589                	li	a1,2
ffffffffc0206130:	87afc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0206134:	8522                	mv	a0,s0
ffffffffc0206136:	f09fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020613a:	4501                	li	a0,0
ffffffffc020613c:	bde5                	j	ffffffffc0206034 <do_wait.part.0+0x66>
ffffffffc020613e:	b2ffa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206142:	bf55                	j	ffffffffc02060f6 <do_wait.part.0+0x128>
ffffffffc0206144:	701c                	ld	a5,32(s0)
ffffffffc0206146:	fbf8                	sd	a4,240(a5)
ffffffffc0206148:	bf79                	j	ffffffffc02060e6 <do_wait.part.0+0x118>
ffffffffc020614a:	b29fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020614e:	4585                	li	a1,1
ffffffffc0206150:	bf95                	j	ffffffffc02060c4 <do_wait.part.0+0xf6>
ffffffffc0206152:	f2840413          	addi	s0,s0,-216
ffffffffc0206156:	b781                	j	ffffffffc0206096 <do_wait.part.0+0xc8>
ffffffffc0206158:	00006617          	auipc	a2,0x6
ffffffffc020615c:	a2060613          	addi	a2,a2,-1504 # ffffffffc020bb78 <default_pmm_manager+0xe0>
ffffffffc0206160:	07700593          	li	a1,119
ffffffffc0206164:	00006517          	auipc	a0,0x6
ffffffffc0206168:	99450513          	addi	a0,a0,-1644 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc020616c:	b32fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206170:	00007617          	auipc	a2,0x7
ffffffffc0206174:	9b860613          	addi	a2,a2,-1608 # ffffffffc020cb28 <CSWTCH.79+0x180>
ffffffffc0206178:	37600593          	li	a1,886
ffffffffc020617c:	00007517          	auipc	a0,0x7
ffffffffc0206180:	93c50513          	addi	a0,a0,-1732 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0206184:	b1afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206188:	00006617          	auipc	a2,0x6
ffffffffc020618c:	a1860613          	addi	a2,a2,-1512 # ffffffffc020bba0 <default_pmm_manager+0x108>
ffffffffc0206190:	06900593          	li	a1,105
ffffffffc0206194:	00006517          	auipc	a0,0x6
ffffffffc0206198:	96450513          	addi	a0,a0,-1692 # ffffffffc020baf8 <default_pmm_manager+0x60>
ffffffffc020619c:	b02fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02061a0 <init_main>:
ffffffffc02061a0:	1141                	addi	sp,sp,-16
ffffffffc02061a2:	00007517          	auipc	a0,0x7
ffffffffc02061a6:	9a650513          	addi	a0,a0,-1626 # ffffffffc020cb48 <CSWTCH.79+0x1a0>
ffffffffc02061aa:	e406                	sd	ra,8(sp)
ffffffffc02061ac:	162010ef          	jal	ra,ffffffffc020730e <vfs_set_bootfs>
ffffffffc02061b0:	e179                	bnez	a0,ffffffffc0206276 <init_main+0xd6>
ffffffffc02061b2:	838fc0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc02061b6:	dd5fb0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc02061ba:	4601                	li	a2,0
ffffffffc02061bc:	4581                	li	a1,0
ffffffffc02061be:	00000517          	auipc	a0,0x0
ffffffffc02061c2:	38850513          	addi	a0,a0,904 # ffffffffc0206546 <user_main>
ffffffffc02061c6:	c57ff0ef          	jal	ra,ffffffffc0205e1c <kernel_thread>
ffffffffc02061ca:	00a04563          	bgtz	a0,ffffffffc02061d4 <init_main+0x34>
ffffffffc02061ce:	a841                	j	ffffffffc020625e <init_main+0xbe>
ffffffffc02061d0:	1cf000ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc02061d4:	4581                	li	a1,0
ffffffffc02061d6:	4501                	li	a0,0
ffffffffc02061d8:	df7ff0ef          	jal	ra,ffffffffc0205fce <do_wait.part.0>
ffffffffc02061dc:	d975                	beqz	a0,ffffffffc02061d0 <init_main+0x30>
ffffffffc02061de:	e6ffe0ef          	jal	ra,ffffffffc020504c <fs_cleanup>
ffffffffc02061e2:	00007517          	auipc	a0,0x7
ffffffffc02061e6:	9ae50513          	addi	a0,a0,-1618 # ffffffffc020cb90 <CSWTCH.79+0x1e8>
ffffffffc02061ea:	fbdf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02061ee:	0008f797          	auipc	a5,0x8f
ffffffffc02061f2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02958d0 <initproc>
ffffffffc02061f6:	7bf8                	ld	a4,240(a5)
ffffffffc02061f8:	e339                	bnez	a4,ffffffffc020623e <init_main+0x9e>
ffffffffc02061fa:	7ff8                	ld	a4,248(a5)
ffffffffc02061fc:	e329                	bnez	a4,ffffffffc020623e <init_main+0x9e>
ffffffffc02061fe:	1007b703          	ld	a4,256(a5)
ffffffffc0206202:	ef15                	bnez	a4,ffffffffc020623e <init_main+0x9e>
ffffffffc0206204:	0008f697          	auipc	a3,0x8f
ffffffffc0206208:	6d46a683          	lw	a3,1748(a3) # ffffffffc02958d8 <nr_process>
ffffffffc020620c:	4709                	li	a4,2
ffffffffc020620e:	0ce69163          	bne	a3,a4,ffffffffc02062d0 <init_main+0x130>
ffffffffc0206212:	0008e717          	auipc	a4,0x8e
ffffffffc0206216:	5ae70713          	addi	a4,a4,1454 # ffffffffc02947c0 <proc_list>
ffffffffc020621a:	6714                	ld	a3,8(a4)
ffffffffc020621c:	0c878793          	addi	a5,a5,200
ffffffffc0206220:	08d79863          	bne	a5,a3,ffffffffc02062b0 <init_main+0x110>
ffffffffc0206224:	6318                	ld	a4,0(a4)
ffffffffc0206226:	06e79563          	bne	a5,a4,ffffffffc0206290 <init_main+0xf0>
ffffffffc020622a:	00007517          	auipc	a0,0x7
ffffffffc020622e:	a4e50513          	addi	a0,a0,-1458 # ffffffffc020cc78 <CSWTCH.79+0x2d0>
ffffffffc0206232:	f75f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206236:	60a2                	ld	ra,8(sp)
ffffffffc0206238:	4501                	li	a0,0
ffffffffc020623a:	0141                	addi	sp,sp,16
ffffffffc020623c:	8082                	ret
ffffffffc020623e:	00007697          	auipc	a3,0x7
ffffffffc0206242:	97a68693          	addi	a3,a3,-1670 # ffffffffc020cbb8 <CSWTCH.79+0x210>
ffffffffc0206246:	00005617          	auipc	a2,0x5
ffffffffc020624a:	d6a60613          	addi	a2,a2,-662 # ffffffffc020afb0 <commands+0x210>
ffffffffc020624e:	3ec00593          	li	a1,1004
ffffffffc0206252:	00007517          	auipc	a0,0x7
ffffffffc0206256:	86650513          	addi	a0,a0,-1946 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc020625a:	a44fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020625e:	00007617          	auipc	a2,0x7
ffffffffc0206262:	91260613          	addi	a2,a2,-1774 # ffffffffc020cb70 <CSWTCH.79+0x1c8>
ffffffffc0206266:	3df00593          	li	a1,991
ffffffffc020626a:	00007517          	auipc	a0,0x7
ffffffffc020626e:	84e50513          	addi	a0,a0,-1970 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0206272:	a2cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206276:	86aa                	mv	a3,a0
ffffffffc0206278:	00007617          	auipc	a2,0x7
ffffffffc020627c:	8d860613          	addi	a2,a2,-1832 # ffffffffc020cb50 <CSWTCH.79+0x1a8>
ffffffffc0206280:	3d700593          	li	a1,983
ffffffffc0206284:	00007517          	auipc	a0,0x7
ffffffffc0206288:	83450513          	addi	a0,a0,-1996 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc020628c:	a12fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206290:	00007697          	auipc	a3,0x7
ffffffffc0206294:	9b868693          	addi	a3,a3,-1608 # ffffffffc020cc48 <CSWTCH.79+0x2a0>
ffffffffc0206298:	00005617          	auipc	a2,0x5
ffffffffc020629c:	d1860613          	addi	a2,a2,-744 # ffffffffc020afb0 <commands+0x210>
ffffffffc02062a0:	3ef00593          	li	a1,1007
ffffffffc02062a4:	00007517          	auipc	a0,0x7
ffffffffc02062a8:	81450513          	addi	a0,a0,-2028 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc02062ac:	9f2fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02062b0:	00007697          	auipc	a3,0x7
ffffffffc02062b4:	96868693          	addi	a3,a3,-1688 # ffffffffc020cc18 <CSWTCH.79+0x270>
ffffffffc02062b8:	00005617          	auipc	a2,0x5
ffffffffc02062bc:	cf860613          	addi	a2,a2,-776 # ffffffffc020afb0 <commands+0x210>
ffffffffc02062c0:	3ee00593          	li	a1,1006
ffffffffc02062c4:	00006517          	auipc	a0,0x6
ffffffffc02062c8:	7f450513          	addi	a0,a0,2036 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc02062cc:	9d2fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02062d0:	00007697          	auipc	a3,0x7
ffffffffc02062d4:	93868693          	addi	a3,a3,-1736 # ffffffffc020cc08 <CSWTCH.79+0x260>
ffffffffc02062d8:	00005617          	auipc	a2,0x5
ffffffffc02062dc:	cd860613          	addi	a2,a2,-808 # ffffffffc020afb0 <commands+0x210>
ffffffffc02062e0:	3ed00593          	li	a1,1005
ffffffffc02062e4:	00006517          	auipc	a0,0x6
ffffffffc02062e8:	7d450513          	addi	a0,a0,2004 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc02062ec:	9b2fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02062f0 <do_execve>:
ffffffffc02062f0:	7149                	addi	sp,sp,-368
ffffffffc02062f2:	fa5a                	sd	s6,304(sp)
ffffffffc02062f4:	0008fb17          	auipc	s6,0x8f
ffffffffc02062f8:	5ccb0b13          	addi	s6,s6,1484 # ffffffffc02958c0 <current>
ffffffffc02062fc:	000b3683          	ld	a3,0(s6)
ffffffffc0206300:	f65e                	sd	s7,296(sp)
ffffffffc0206302:	fff58b9b          	addiw	s7,a1,-1
ffffffffc0206306:	fe56                	sd	s5,312(sp)
ffffffffc0206308:	f686                	sd	ra,360(sp)
ffffffffc020630a:	f2a2                	sd	s0,352(sp)
ffffffffc020630c:	eea6                	sd	s1,344(sp)
ffffffffc020630e:	eaca                	sd	s2,336(sp)
ffffffffc0206310:	e6ce                	sd	s3,328(sp)
ffffffffc0206312:	e2d2                	sd	s4,320(sp)
ffffffffc0206314:	f262                	sd	s8,288(sp)
ffffffffc0206316:	ee66                	sd	s9,280(sp)
ffffffffc0206318:	000b871b          	sext.w	a4,s7
ffffffffc020631c:	47fd                	li	a5,31
ffffffffc020631e:	0286ba83          	ld	s5,40(a3)
ffffffffc0206322:	20e7e263          	bltu	a5,a4,ffffffffc0206526 <do_execve+0x236>
ffffffffc0206326:	89ae                	mv	s3,a1
ffffffffc0206328:	842a                	mv	s0,a0
ffffffffc020632a:	8cb2                	mv	s9,a2
ffffffffc020632c:	4581                	li	a1,0
ffffffffc020632e:	4641                	li	a2,16
ffffffffc0206330:	850a                	mv	a0,sp
ffffffffc0206332:	79c040ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0206336:	000a8c63          	beqz	s5,ffffffffc020634e <do_execve+0x5e>
ffffffffc020633a:	038a8513          	addi	a0,s5,56
ffffffffc020633e:	8b4fe0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0206342:	000b3783          	ld	a5,0(s6)
ffffffffc0206346:	c781                	beqz	a5,ffffffffc020634e <do_execve+0x5e>
ffffffffc0206348:	43dc                	lw	a5,4(a5)
ffffffffc020634a:	04faa823          	sw	a5,80(s5)
ffffffffc020634e:	1a040563          	beqz	s0,ffffffffc02064f8 <do_execve+0x208>
ffffffffc0206352:	46c1                	li	a3,16
ffffffffc0206354:	8622                	mv	a2,s0
ffffffffc0206356:	858a                	mv	a1,sp
ffffffffc0206358:	8556                	mv	a0,s5
ffffffffc020635a:	ec1fd0ef          	jal	ra,ffffffffc020421a <copy_string>
ffffffffc020635e:	1c050a63          	beqz	a0,ffffffffc0206532 <do_execve+0x242>
ffffffffc0206362:	00399c13          	slli	s8,s3,0x3
ffffffffc0206366:	4681                	li	a3,0
ffffffffc0206368:	8662                	mv	a2,s8
ffffffffc020636a:	85e6                	mv	a1,s9
ffffffffc020636c:	8556                	mv	a0,s5
ffffffffc020636e:	db3fd0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc0206372:	84e6                	mv	s1,s9
ffffffffc0206374:	1a050b63          	beqz	a0,ffffffffc020652a <do_execve+0x23a>
ffffffffc0206378:	01010913          	addi	s2,sp,16
ffffffffc020637c:	4a01                	li	s4,0
ffffffffc020637e:	6505                	lui	a0,0x1
ffffffffc0206380:	c0ffb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206384:	842a                	mv	s0,a0
ffffffffc0206386:	12050163          	beqz	a0,ffffffffc02064a8 <do_execve+0x1b8>
ffffffffc020638a:	6090                	ld	a2,0(s1)
ffffffffc020638c:	85aa                	mv	a1,a0
ffffffffc020638e:	6685                	lui	a3,0x1
ffffffffc0206390:	8556                	mv	a0,s5
ffffffffc0206392:	e89fd0ef          	jal	ra,ffffffffc020421a <copy_string>
ffffffffc0206396:	14050c63          	beqz	a0,ffffffffc02064ee <do_execve+0x1fe>
ffffffffc020639a:	00893023          	sd	s0,0(s2) # ffffffff80000000 <_binary_bin_sfs_img_size+0xffffffff7ff8ad00>
ffffffffc020639e:	2a05                	addiw	s4,s4,1
ffffffffc02063a0:	0921                	addi	s2,s2,8
ffffffffc02063a2:	04a1                	addi	s1,s1,8
ffffffffc02063a4:	fd499de3          	bne	s3,s4,ffffffffc020637e <do_execve+0x8e>
ffffffffc02063a8:	000cb403          	ld	s0,0(s9)
ffffffffc02063ac:	0a0a8b63          	beqz	s5,ffffffffc0206462 <do_execve+0x172>
ffffffffc02063b0:	038a8513          	addi	a0,s5,56
ffffffffc02063b4:	83afe0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02063b8:	000b3783          	ld	a5,0(s6)
ffffffffc02063bc:	040aa823          	sw	zero,80(s5)
ffffffffc02063c0:	1487b503          	ld	a0,328(a5)
ffffffffc02063c4:	d65fe0ef          	jal	ra,ffffffffc0205128 <files_closeall>
ffffffffc02063c8:	4581                	li	a1,0
ffffffffc02063ca:	8522                	mv	a0,s0
ffffffffc02063cc:	fe9fe0ef          	jal	ra,ffffffffc02053b4 <sysfile_open>
ffffffffc02063d0:	84aa                	mv	s1,a0
ffffffffc02063d2:	0a054563          	bltz	a0,ffffffffc020647c <do_execve+0x18c>
ffffffffc02063d6:	0008f797          	auipc	a5,0x8f
ffffffffc02063da:	4ba7b783          	ld	a5,1210(a5) # ffffffffc0295890 <boot_pgdir_pa>
ffffffffc02063de:	577d                	li	a4,-1
ffffffffc02063e0:	177e                	slli	a4,a4,0x3f
ffffffffc02063e2:	83b1                	srli	a5,a5,0xc
ffffffffc02063e4:	8fd9                	or	a5,a5,a4
ffffffffc02063e6:	18079073          	csrw	satp,a5
ffffffffc02063ea:	030aa783          	lw	a5,48(s5)
ffffffffc02063ee:	fff7871b          	addiw	a4,a5,-1
ffffffffc02063f2:	02eaa823          	sw	a4,48(s5)
ffffffffc02063f6:	10070d63          	beqz	a4,ffffffffc0206510 <do_execve+0x220>
ffffffffc02063fa:	000b3783          	ld	a5,0(s6)
ffffffffc02063fe:	0207b423          	sd	zero,40(a5)
ffffffffc0206402:	ecad                	bnez	s1,ffffffffc020647c <do_execve+0x18c>
ffffffffc0206404:	878a                	mv	a5,sp
ffffffffc0206406:	9c3e                	add	s8,s8,a5
ffffffffc0206408:	fff98413          	addi	s0,s3,-1 # 1fff <_binary_bin_swap_img_size-0x5d01>
ffffffffc020640c:	020b9793          	slli	a5,s7,0x20
ffffffffc0206410:	01d7db93          	srli	s7,a5,0x1d
ffffffffc0206414:	040e                	slli	s0,s0,0x3
ffffffffc0206416:	081c                	addi	a5,sp,16
ffffffffc0206418:	943e                	add	s0,s0,a5
ffffffffc020641a:	417c0bb3          	sub	s7,s8,s7
ffffffffc020641e:	6008                	ld	a0,0(s0)
ffffffffc0206420:	1461                	addi	s0,s0,-8
ffffffffc0206422:	c1dfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206426:	ff741ce3          	bne	s0,s7,ffffffffc020641e <do_execve+0x12e>
ffffffffc020642a:	000b3403          	ld	s0,0(s6)
ffffffffc020642e:	4641                	li	a2,16
ffffffffc0206430:	4581                	li	a1,0
ffffffffc0206432:	0b440413          	addi	s0,s0,180
ffffffffc0206436:	8522                	mv	a0,s0
ffffffffc0206438:	696040ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc020643c:	463d                	li	a2,15
ffffffffc020643e:	858a                	mv	a1,sp
ffffffffc0206440:	8522                	mv	a0,s0
ffffffffc0206442:	6de040ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc0206446:	70b6                	ld	ra,360(sp)
ffffffffc0206448:	7416                	ld	s0,352(sp)
ffffffffc020644a:	6956                	ld	s2,336(sp)
ffffffffc020644c:	69b6                	ld	s3,328(sp)
ffffffffc020644e:	6a16                	ld	s4,320(sp)
ffffffffc0206450:	7af2                	ld	s5,312(sp)
ffffffffc0206452:	7b52                	ld	s6,304(sp)
ffffffffc0206454:	7bb2                	ld	s7,296(sp)
ffffffffc0206456:	7c12                	ld	s8,288(sp)
ffffffffc0206458:	6cf2                	ld	s9,280(sp)
ffffffffc020645a:	8526                	mv	a0,s1
ffffffffc020645c:	64f6                	ld	s1,344(sp)
ffffffffc020645e:	6175                	addi	sp,sp,368
ffffffffc0206460:	8082                	ret
ffffffffc0206462:	000b3783          	ld	a5,0(s6)
ffffffffc0206466:	1487b503          	ld	a0,328(a5)
ffffffffc020646a:	cbffe0ef          	jal	ra,ffffffffc0205128 <files_closeall>
ffffffffc020646e:	4581                	li	a1,0
ffffffffc0206470:	8522                	mv	a0,s0
ffffffffc0206472:	f43fe0ef          	jal	ra,ffffffffc02053b4 <sysfile_open>
ffffffffc0206476:	84aa                	mv	s1,a0
ffffffffc0206478:	f80555e3          	bgez	a0,ffffffffc0206402 <do_execve+0x112>
ffffffffc020647c:	020b9793          	slli	a5,s7,0x20
ffffffffc0206480:	fff98413          	addi	s0,s3,-1
ffffffffc0206484:	890a                	mv	s2,sp
ffffffffc0206486:	01d7db93          	srli	s7,a5,0x1d
ffffffffc020648a:	040e                	slli	s0,s0,0x3
ffffffffc020648c:	9962                	add	s2,s2,s8
ffffffffc020648e:	081c                	addi	a5,sp,16
ffffffffc0206490:	943e                	add	s0,s0,a5
ffffffffc0206492:	41790933          	sub	s2,s2,s7
ffffffffc0206496:	6008                	ld	a0,0(s0)
ffffffffc0206498:	1461                	addi	s0,s0,-8
ffffffffc020649a:	ba5fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020649e:	fe891ce3          	bne	s2,s0,ffffffffc0206496 <do_execve+0x1a6>
ffffffffc02064a2:	8526                	mv	a0,s1
ffffffffc02064a4:	9c9ff0ef          	jal	ra,ffffffffc0205e6c <do_exit>
ffffffffc02064a8:	54f1                	li	s1,-4
ffffffffc02064aa:	020a0963          	beqz	s4,ffffffffc02064dc <do_execve+0x1ec>
ffffffffc02064ae:	003a1713          	slli	a4,s4,0x3
ffffffffc02064b2:	fffa079b          	addiw	a5,s4,-1
ffffffffc02064b6:	890a                	mv	s2,sp
ffffffffc02064b8:	993a                	add	s2,s2,a4
ffffffffc02064ba:	fffa0413          	addi	s0,s4,-1
ffffffffc02064be:	02079713          	slli	a4,a5,0x20
ffffffffc02064c2:	01d75793          	srli	a5,a4,0x1d
ffffffffc02064c6:	040e                	slli	s0,s0,0x3
ffffffffc02064c8:	0818                	addi	a4,sp,16
ffffffffc02064ca:	943a                	add	s0,s0,a4
ffffffffc02064cc:	40f90933          	sub	s2,s2,a5
ffffffffc02064d0:	6008                	ld	a0,0(s0)
ffffffffc02064d2:	1461                	addi	s0,s0,-8
ffffffffc02064d4:	b6bfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02064d8:	fe891ce3          	bne	s2,s0,ffffffffc02064d0 <do_execve+0x1e0>
ffffffffc02064dc:	f60a85e3          	beqz	s5,ffffffffc0206446 <do_execve+0x156>
ffffffffc02064e0:	038a8513          	addi	a0,s5,56
ffffffffc02064e4:	f0bfd0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02064e8:	040aa823          	sw	zero,80(s5)
ffffffffc02064ec:	bfa9                	j	ffffffffc0206446 <do_execve+0x156>
ffffffffc02064ee:	8522                	mv	a0,s0
ffffffffc02064f0:	b4ffb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02064f4:	54f5                	li	s1,-3
ffffffffc02064f6:	bf55                	j	ffffffffc02064aa <do_execve+0x1ba>
ffffffffc02064f8:	000b3783          	ld	a5,0(s6)
ffffffffc02064fc:	00006617          	auipc	a2,0x6
ffffffffc0206500:	79c60613          	addi	a2,a2,1948 # ffffffffc020cc98 <CSWTCH.79+0x2f0>
ffffffffc0206504:	45c1                	li	a1,16
ffffffffc0206506:	43d4                	lw	a3,4(a5)
ffffffffc0206508:	850a                	mv	a0,sp
ffffffffc020650a:	4d4040ef          	jal	ra,ffffffffc020a9de <snprintf>
ffffffffc020650e:	bd91                	j	ffffffffc0206362 <do_execve+0x72>
ffffffffc0206510:	8556                	mv	a0,s5
ffffffffc0206512:	86ffd0ef          	jal	ra,ffffffffc0203d80 <exit_mmap>
ffffffffc0206516:	018ab503          	ld	a0,24(s5)
ffffffffc020651a:	bf0ff0ef          	jal	ra,ffffffffc020590a <put_pgdir.isra.0>
ffffffffc020651e:	8556                	mv	a0,s5
ffffffffc0206520:	f74fd0ef          	jal	ra,ffffffffc0203c94 <mm_destroy>
ffffffffc0206524:	bdd9                	j	ffffffffc02063fa <do_execve+0x10a>
ffffffffc0206526:	54f5                	li	s1,-3
ffffffffc0206528:	bf39                	j	ffffffffc0206446 <do_execve+0x156>
ffffffffc020652a:	54f5                	li	s1,-3
ffffffffc020652c:	fa0a9ae3          	bnez	s5,ffffffffc02064e0 <do_execve+0x1f0>
ffffffffc0206530:	bf19                	j	ffffffffc0206446 <do_execve+0x156>
ffffffffc0206532:	fe0a8ae3          	beqz	s5,ffffffffc0206526 <do_execve+0x236>
ffffffffc0206536:	038a8513          	addi	a0,s5,56
ffffffffc020653a:	eb5fd0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020653e:	54f5                	li	s1,-3
ffffffffc0206540:	040aa823          	sw	zero,80(s5)
ffffffffc0206544:	b709                	j	ffffffffc0206446 <do_execve+0x156>

ffffffffc0206546 <user_main>:
ffffffffc0206546:	7179                	addi	sp,sp,-48
ffffffffc0206548:	e84a                	sd	s2,16(sp)
ffffffffc020654a:	0008f917          	auipc	s2,0x8f
ffffffffc020654e:	37690913          	addi	s2,s2,886 # ffffffffc02958c0 <current>
ffffffffc0206552:	00093783          	ld	a5,0(s2)
ffffffffc0206556:	00006617          	auipc	a2,0x6
ffffffffc020655a:	75260613          	addi	a2,a2,1874 # ffffffffc020cca8 <CSWTCH.79+0x300>
ffffffffc020655e:	00006517          	auipc	a0,0x6
ffffffffc0206562:	75250513          	addi	a0,a0,1874 # ffffffffc020ccb0 <CSWTCH.79+0x308>
ffffffffc0206566:	43cc                	lw	a1,4(a5)
ffffffffc0206568:	f406                	sd	ra,40(sp)
ffffffffc020656a:	f022                	sd	s0,32(sp)
ffffffffc020656c:	ec26                	sd	s1,24(sp)
ffffffffc020656e:	e032                	sd	a2,0(sp)
ffffffffc0206570:	e402                	sd	zero,8(sp)
ffffffffc0206572:	c35f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206576:	6782                	ld	a5,0(sp)
ffffffffc0206578:	cfb9                	beqz	a5,ffffffffc02065d6 <user_main+0x90>
ffffffffc020657a:	003c                	addi	a5,sp,8
ffffffffc020657c:	4401                	li	s0,0
ffffffffc020657e:	6398                	ld	a4,0(a5)
ffffffffc0206580:	0405                	addi	s0,s0,1
ffffffffc0206582:	07a1                	addi	a5,a5,8
ffffffffc0206584:	ff6d                	bnez	a4,ffffffffc020657e <user_main+0x38>
ffffffffc0206586:	00093783          	ld	a5,0(s2)
ffffffffc020658a:	12000613          	li	a2,288
ffffffffc020658e:	6b84                	ld	s1,16(a5)
ffffffffc0206590:	73cc                	ld	a1,160(a5)
ffffffffc0206592:	6789                	lui	a5,0x2
ffffffffc0206594:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206598:	94be                	add	s1,s1,a5
ffffffffc020659a:	8526                	mv	a0,s1
ffffffffc020659c:	584040ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc02065a0:	00093783          	ld	a5,0(s2)
ffffffffc02065a4:	860a                	mv	a2,sp
ffffffffc02065a6:	0004059b          	sext.w	a1,s0
ffffffffc02065aa:	f3c4                	sd	s1,160(a5)
ffffffffc02065ac:	00006517          	auipc	a0,0x6
ffffffffc02065b0:	6fc50513          	addi	a0,a0,1788 # ffffffffc020cca8 <CSWTCH.79+0x300>
ffffffffc02065b4:	d3dff0ef          	jal	ra,ffffffffc02062f0 <do_execve>
ffffffffc02065b8:	8126                	mv	sp,s1
ffffffffc02065ba:	c97fa06f          	j	ffffffffc0201250 <__trapret>
ffffffffc02065be:	00006617          	auipc	a2,0x6
ffffffffc02065c2:	71a60613          	addi	a2,a2,1818 # ffffffffc020ccd8 <CSWTCH.79+0x330>
ffffffffc02065c6:	3cd00593          	li	a1,973
ffffffffc02065ca:	00006517          	auipc	a0,0x6
ffffffffc02065ce:	4ee50513          	addi	a0,a0,1262 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc02065d2:	ecdf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02065d6:	4401                	li	s0,0
ffffffffc02065d8:	b77d                	j	ffffffffc0206586 <user_main+0x40>

ffffffffc02065da <do_yield>:
ffffffffc02065da:	0008f797          	auipc	a5,0x8f
ffffffffc02065de:	2e67b783          	ld	a5,742(a5) # ffffffffc02958c0 <current>
ffffffffc02065e2:	4705                	li	a4,1
ffffffffc02065e4:	ef98                	sd	a4,24(a5)
ffffffffc02065e6:	4501                	li	a0,0
ffffffffc02065e8:	8082                	ret

ffffffffc02065ea <do_wait>:
ffffffffc02065ea:	1101                	addi	sp,sp,-32
ffffffffc02065ec:	e822                	sd	s0,16(sp)
ffffffffc02065ee:	e426                	sd	s1,8(sp)
ffffffffc02065f0:	ec06                	sd	ra,24(sp)
ffffffffc02065f2:	842e                	mv	s0,a1
ffffffffc02065f4:	84aa                	mv	s1,a0
ffffffffc02065f6:	c999                	beqz	a1,ffffffffc020660c <do_wait+0x22>
ffffffffc02065f8:	0008f797          	auipc	a5,0x8f
ffffffffc02065fc:	2c87b783          	ld	a5,712(a5) # ffffffffc02958c0 <current>
ffffffffc0206600:	7788                	ld	a0,40(a5)
ffffffffc0206602:	4685                	li	a3,1
ffffffffc0206604:	4611                	li	a2,4
ffffffffc0206606:	b1bfd0ef          	jal	ra,ffffffffc0204120 <user_mem_check>
ffffffffc020660a:	c909                	beqz	a0,ffffffffc020661c <do_wait+0x32>
ffffffffc020660c:	85a2                	mv	a1,s0
ffffffffc020660e:	6442                	ld	s0,16(sp)
ffffffffc0206610:	60e2                	ld	ra,24(sp)
ffffffffc0206612:	8526                	mv	a0,s1
ffffffffc0206614:	64a2                	ld	s1,8(sp)
ffffffffc0206616:	6105                	addi	sp,sp,32
ffffffffc0206618:	9b7ff06f          	j	ffffffffc0205fce <do_wait.part.0>
ffffffffc020661c:	60e2                	ld	ra,24(sp)
ffffffffc020661e:	6442                	ld	s0,16(sp)
ffffffffc0206620:	64a2                	ld	s1,8(sp)
ffffffffc0206622:	5575                	li	a0,-3
ffffffffc0206624:	6105                	addi	sp,sp,32
ffffffffc0206626:	8082                	ret

ffffffffc0206628 <do_kill>:
ffffffffc0206628:	1141                	addi	sp,sp,-16
ffffffffc020662a:	6789                	lui	a5,0x2
ffffffffc020662c:	e406                	sd	ra,8(sp)
ffffffffc020662e:	e022                	sd	s0,0(sp)
ffffffffc0206630:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206634:	17f9                	addi	a5,a5,-2
ffffffffc0206636:	02e7e963          	bltu	a5,a4,ffffffffc0206668 <do_kill+0x40>
ffffffffc020663a:	842a                	mv	s0,a0
ffffffffc020663c:	45a9                	li	a1,10
ffffffffc020663e:	2501                	sext.w	a0,a0
ffffffffc0206640:	75b030ef          	jal	ra,ffffffffc020a59a <hash32>
ffffffffc0206644:	02051793          	slli	a5,a0,0x20
ffffffffc0206648:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020664c:	0008a797          	auipc	a5,0x8a
ffffffffc0206650:	17478793          	addi	a5,a5,372 # ffffffffc02907c0 <hash_list>
ffffffffc0206654:	953e                	add	a0,a0,a5
ffffffffc0206656:	87aa                	mv	a5,a0
ffffffffc0206658:	a029                	j	ffffffffc0206662 <do_kill+0x3a>
ffffffffc020665a:	f2c7a703          	lw	a4,-212(a5)
ffffffffc020665e:	00870b63          	beq	a4,s0,ffffffffc0206674 <do_kill+0x4c>
ffffffffc0206662:	679c                	ld	a5,8(a5)
ffffffffc0206664:	fef51be3          	bne	a0,a5,ffffffffc020665a <do_kill+0x32>
ffffffffc0206668:	5475                	li	s0,-3
ffffffffc020666a:	60a2                	ld	ra,8(sp)
ffffffffc020666c:	8522                	mv	a0,s0
ffffffffc020666e:	6402                	ld	s0,0(sp)
ffffffffc0206670:	0141                	addi	sp,sp,16
ffffffffc0206672:	8082                	ret
ffffffffc0206674:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206678:	00177693          	andi	a3,a4,1
ffffffffc020667c:	e295                	bnez	a3,ffffffffc02066a0 <do_kill+0x78>
ffffffffc020667e:	4bd4                	lw	a3,20(a5)
ffffffffc0206680:	00176713          	ori	a4,a4,1
ffffffffc0206684:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206688:	4401                	li	s0,0
ffffffffc020668a:	fe06d0e3          	bgez	a3,ffffffffc020666a <do_kill+0x42>
ffffffffc020668e:	f2878513          	addi	a0,a5,-216
ffffffffc0206692:	45a000ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0206696:	60a2                	ld	ra,8(sp)
ffffffffc0206698:	8522                	mv	a0,s0
ffffffffc020669a:	6402                	ld	s0,0(sp)
ffffffffc020669c:	0141                	addi	sp,sp,16
ffffffffc020669e:	8082                	ret
ffffffffc02066a0:	545d                	li	s0,-9
ffffffffc02066a2:	b7e1                	j	ffffffffc020666a <do_kill+0x42>

ffffffffc02066a4 <proc_init>:
ffffffffc02066a4:	1101                	addi	sp,sp,-32
ffffffffc02066a6:	e426                	sd	s1,8(sp)
ffffffffc02066a8:	0008e797          	auipc	a5,0x8e
ffffffffc02066ac:	11878793          	addi	a5,a5,280 # ffffffffc02947c0 <proc_list>
ffffffffc02066b0:	ec06                	sd	ra,24(sp)
ffffffffc02066b2:	e822                	sd	s0,16(sp)
ffffffffc02066b4:	e04a                	sd	s2,0(sp)
ffffffffc02066b6:	0008a497          	auipc	s1,0x8a
ffffffffc02066ba:	10a48493          	addi	s1,s1,266 # ffffffffc02907c0 <hash_list>
ffffffffc02066be:	e79c                	sd	a5,8(a5)
ffffffffc02066c0:	e39c                	sd	a5,0(a5)
ffffffffc02066c2:	0008e717          	auipc	a4,0x8e
ffffffffc02066c6:	0fe70713          	addi	a4,a4,254 # ffffffffc02947c0 <proc_list>
ffffffffc02066ca:	87a6                	mv	a5,s1
ffffffffc02066cc:	e79c                	sd	a5,8(a5)
ffffffffc02066ce:	e39c                	sd	a5,0(a5)
ffffffffc02066d0:	07c1                	addi	a5,a5,16
ffffffffc02066d2:	fef71de3          	bne	a4,a5,ffffffffc02066cc <proc_init+0x28>
ffffffffc02066d6:	98cff0ef          	jal	ra,ffffffffc0205862 <alloc_proc>
ffffffffc02066da:	0008f917          	auipc	s2,0x8f
ffffffffc02066de:	1ee90913          	addi	s2,s2,494 # ffffffffc02958c8 <idleproc>
ffffffffc02066e2:	00a93023          	sd	a0,0(s2)
ffffffffc02066e6:	842a                	mv	s0,a0
ffffffffc02066e8:	12050863          	beqz	a0,ffffffffc0206818 <proc_init+0x174>
ffffffffc02066ec:	4789                	li	a5,2
ffffffffc02066ee:	e11c                	sd	a5,0(a0)
ffffffffc02066f0:	0000a797          	auipc	a5,0xa
ffffffffc02066f4:	91078793          	addi	a5,a5,-1776 # ffffffffc0210000 <bootstack>
ffffffffc02066f8:	e91c                	sd	a5,16(a0)
ffffffffc02066fa:	4785                	li	a5,1
ffffffffc02066fc:	ed1c                	sd	a5,24(a0)
ffffffffc02066fe:	95ffe0ef          	jal	ra,ffffffffc020505c <files_create>
ffffffffc0206702:	14a43423          	sd	a0,328(s0)
ffffffffc0206706:	0e050d63          	beqz	a0,ffffffffc0206800 <proc_init+0x15c>
ffffffffc020670a:	00093403          	ld	s0,0(s2)
ffffffffc020670e:	4641                	li	a2,16
ffffffffc0206710:	4581                	li	a1,0
ffffffffc0206712:	14843703          	ld	a4,328(s0)
ffffffffc0206716:	0b440413          	addi	s0,s0,180
ffffffffc020671a:	8522                	mv	a0,s0
ffffffffc020671c:	4b1c                	lw	a5,16(a4)
ffffffffc020671e:	2785                	addiw	a5,a5,1
ffffffffc0206720:	cb1c                	sw	a5,16(a4)
ffffffffc0206722:	3ac040ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0206726:	463d                	li	a2,15
ffffffffc0206728:	00006597          	auipc	a1,0x6
ffffffffc020672c:	61058593          	addi	a1,a1,1552 # ffffffffc020cd38 <CSWTCH.79+0x390>
ffffffffc0206730:	8522                	mv	a0,s0
ffffffffc0206732:	3ee040ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc0206736:	0008f717          	auipc	a4,0x8f
ffffffffc020673a:	1a270713          	addi	a4,a4,418 # ffffffffc02958d8 <nr_process>
ffffffffc020673e:	431c                	lw	a5,0(a4)
ffffffffc0206740:	00093683          	ld	a3,0(s2)
ffffffffc0206744:	4601                	li	a2,0
ffffffffc0206746:	2785                	addiw	a5,a5,1
ffffffffc0206748:	4581                	li	a1,0
ffffffffc020674a:	00000517          	auipc	a0,0x0
ffffffffc020674e:	a5650513          	addi	a0,a0,-1450 # ffffffffc02061a0 <init_main>
ffffffffc0206752:	c31c                	sw	a5,0(a4)
ffffffffc0206754:	0008f797          	auipc	a5,0x8f
ffffffffc0206758:	16d7b623          	sd	a3,364(a5) # ffffffffc02958c0 <current>
ffffffffc020675c:	ec0ff0ef          	jal	ra,ffffffffc0205e1c <kernel_thread>
ffffffffc0206760:	842a                	mv	s0,a0
ffffffffc0206762:	08a05363          	blez	a0,ffffffffc02067e8 <proc_init+0x144>
ffffffffc0206766:	6789                	lui	a5,0x2
ffffffffc0206768:	fff5071b          	addiw	a4,a0,-1
ffffffffc020676c:	17f9                	addi	a5,a5,-2
ffffffffc020676e:	2501                	sext.w	a0,a0
ffffffffc0206770:	02e7e363          	bltu	a5,a4,ffffffffc0206796 <proc_init+0xf2>
ffffffffc0206774:	45a9                	li	a1,10
ffffffffc0206776:	625030ef          	jal	ra,ffffffffc020a59a <hash32>
ffffffffc020677a:	02051793          	slli	a5,a0,0x20
ffffffffc020677e:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206782:	96a6                	add	a3,a3,s1
ffffffffc0206784:	87b6                	mv	a5,a3
ffffffffc0206786:	a029                	j	ffffffffc0206790 <proc_init+0xec>
ffffffffc0206788:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc020678c:	04870b63          	beq	a4,s0,ffffffffc02067e2 <proc_init+0x13e>
ffffffffc0206790:	679c                	ld	a5,8(a5)
ffffffffc0206792:	fef69be3          	bne	a3,a5,ffffffffc0206788 <proc_init+0xe4>
ffffffffc0206796:	4781                	li	a5,0
ffffffffc0206798:	0b478493          	addi	s1,a5,180
ffffffffc020679c:	4641                	li	a2,16
ffffffffc020679e:	4581                	li	a1,0
ffffffffc02067a0:	0008f417          	auipc	s0,0x8f
ffffffffc02067a4:	13040413          	addi	s0,s0,304 # ffffffffc02958d0 <initproc>
ffffffffc02067a8:	8526                	mv	a0,s1
ffffffffc02067aa:	e01c                	sd	a5,0(s0)
ffffffffc02067ac:	322040ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc02067b0:	463d                	li	a2,15
ffffffffc02067b2:	00006597          	auipc	a1,0x6
ffffffffc02067b6:	5ae58593          	addi	a1,a1,1454 # ffffffffc020cd60 <CSWTCH.79+0x3b8>
ffffffffc02067ba:	8526                	mv	a0,s1
ffffffffc02067bc:	364040ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc02067c0:	00093783          	ld	a5,0(s2)
ffffffffc02067c4:	c7d1                	beqz	a5,ffffffffc0206850 <proc_init+0x1ac>
ffffffffc02067c6:	43dc                	lw	a5,4(a5)
ffffffffc02067c8:	e7c1                	bnez	a5,ffffffffc0206850 <proc_init+0x1ac>
ffffffffc02067ca:	601c                	ld	a5,0(s0)
ffffffffc02067cc:	c3b5                	beqz	a5,ffffffffc0206830 <proc_init+0x18c>
ffffffffc02067ce:	43d8                	lw	a4,4(a5)
ffffffffc02067d0:	4785                	li	a5,1
ffffffffc02067d2:	04f71f63          	bne	a4,a5,ffffffffc0206830 <proc_init+0x18c>
ffffffffc02067d6:	60e2                	ld	ra,24(sp)
ffffffffc02067d8:	6442                	ld	s0,16(sp)
ffffffffc02067da:	64a2                	ld	s1,8(sp)
ffffffffc02067dc:	6902                	ld	s2,0(sp)
ffffffffc02067de:	6105                	addi	sp,sp,32
ffffffffc02067e0:	8082                	ret
ffffffffc02067e2:	f2878793          	addi	a5,a5,-216
ffffffffc02067e6:	bf4d                	j	ffffffffc0206798 <proc_init+0xf4>
ffffffffc02067e8:	00006617          	auipc	a2,0x6
ffffffffc02067ec:	55860613          	addi	a2,a2,1368 # ffffffffc020cd40 <CSWTCH.79+0x398>
ffffffffc02067f0:	41900593          	li	a1,1049
ffffffffc02067f4:	00006517          	auipc	a0,0x6
ffffffffc02067f8:	2c450513          	addi	a0,a0,708 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc02067fc:	ca3f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206800:	00006617          	auipc	a2,0x6
ffffffffc0206804:	51060613          	addi	a2,a2,1296 # ffffffffc020cd10 <CSWTCH.79+0x368>
ffffffffc0206808:	40d00593          	li	a1,1037
ffffffffc020680c:	00006517          	auipc	a0,0x6
ffffffffc0206810:	2ac50513          	addi	a0,a0,684 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc0206814:	c8bf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206818:	00006617          	auipc	a2,0x6
ffffffffc020681c:	4e060613          	addi	a2,a2,1248 # ffffffffc020ccf8 <CSWTCH.79+0x350>
ffffffffc0206820:	40300593          	li	a1,1027
ffffffffc0206824:	00006517          	auipc	a0,0x6
ffffffffc0206828:	29450513          	addi	a0,a0,660 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc020682c:	c73f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206830:	00006697          	auipc	a3,0x6
ffffffffc0206834:	56068693          	addi	a3,a3,1376 # ffffffffc020cd90 <CSWTCH.79+0x3e8>
ffffffffc0206838:	00004617          	auipc	a2,0x4
ffffffffc020683c:	77860613          	addi	a2,a2,1912 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206840:	42000593          	li	a1,1056
ffffffffc0206844:	00006517          	auipc	a0,0x6
ffffffffc0206848:	27450513          	addi	a0,a0,628 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc020684c:	c53f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206850:	00006697          	auipc	a3,0x6
ffffffffc0206854:	51868693          	addi	a3,a3,1304 # ffffffffc020cd68 <CSWTCH.79+0x3c0>
ffffffffc0206858:	00004617          	auipc	a2,0x4
ffffffffc020685c:	75860613          	addi	a2,a2,1880 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206860:	41f00593          	li	a1,1055
ffffffffc0206864:	00006517          	auipc	a0,0x6
ffffffffc0206868:	25450513          	addi	a0,a0,596 # ffffffffc020cab8 <CSWTCH.79+0x110>
ffffffffc020686c:	c33f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206870 <cpu_idle>:
ffffffffc0206870:	1141                	addi	sp,sp,-16
ffffffffc0206872:	e022                	sd	s0,0(sp)
ffffffffc0206874:	e406                	sd	ra,8(sp)
ffffffffc0206876:	0008f417          	auipc	s0,0x8f
ffffffffc020687a:	04a40413          	addi	s0,s0,74 # ffffffffc02958c0 <current>
ffffffffc020687e:	6018                	ld	a4,0(s0)
ffffffffc0206880:	6f1c                	ld	a5,24(a4)
ffffffffc0206882:	dffd                	beqz	a5,ffffffffc0206880 <cpu_idle+0x10>
ffffffffc0206884:	31a000ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc0206888:	bfdd                	j	ffffffffc020687e <cpu_idle+0xe>

ffffffffc020688a <lab6_set_priority>:
ffffffffc020688a:	1141                	addi	sp,sp,-16
ffffffffc020688c:	e022                	sd	s0,0(sp)
ffffffffc020688e:	85aa                	mv	a1,a0
ffffffffc0206890:	842a                	mv	s0,a0
ffffffffc0206892:	00006517          	auipc	a0,0x6
ffffffffc0206896:	52650513          	addi	a0,a0,1318 # ffffffffc020cdb8 <CSWTCH.79+0x410>
ffffffffc020689a:	e406                	sd	ra,8(sp)
ffffffffc020689c:	90bf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02068a0:	0008f797          	auipc	a5,0x8f
ffffffffc02068a4:	0207b783          	ld	a5,32(a5) # ffffffffc02958c0 <current>
ffffffffc02068a8:	e801                	bnez	s0,ffffffffc02068b8 <lab6_set_priority+0x2e>
ffffffffc02068aa:	60a2                	ld	ra,8(sp)
ffffffffc02068ac:	6402                	ld	s0,0(sp)
ffffffffc02068ae:	4705                	li	a4,1
ffffffffc02068b0:	14e7a223          	sw	a4,324(a5)
ffffffffc02068b4:	0141                	addi	sp,sp,16
ffffffffc02068b6:	8082                	ret
ffffffffc02068b8:	60a2                	ld	ra,8(sp)
ffffffffc02068ba:	1487a223          	sw	s0,324(a5)
ffffffffc02068be:	6402                	ld	s0,0(sp)
ffffffffc02068c0:	0141                	addi	sp,sp,16
ffffffffc02068c2:	8082                	ret

ffffffffc02068c4 <do_sleep>:
ffffffffc02068c4:	c539                	beqz	a0,ffffffffc0206912 <do_sleep+0x4e>
ffffffffc02068c6:	7179                	addi	sp,sp,-48
ffffffffc02068c8:	f022                	sd	s0,32(sp)
ffffffffc02068ca:	f406                	sd	ra,40(sp)
ffffffffc02068cc:	842a                	mv	s0,a0
ffffffffc02068ce:	100027f3          	csrr	a5,sstatus
ffffffffc02068d2:	8b89                	andi	a5,a5,2
ffffffffc02068d4:	e3a9                	bnez	a5,ffffffffc0206916 <do_sleep+0x52>
ffffffffc02068d6:	0008f797          	auipc	a5,0x8f
ffffffffc02068da:	fea7b783          	ld	a5,-22(a5) # ffffffffc02958c0 <current>
ffffffffc02068de:	0818                	addi	a4,sp,16
ffffffffc02068e0:	c02a                	sw	a0,0(sp)
ffffffffc02068e2:	ec3a                	sd	a4,24(sp)
ffffffffc02068e4:	e83a                	sd	a4,16(sp)
ffffffffc02068e6:	e43e                	sd	a5,8(sp)
ffffffffc02068e8:	4705                	li	a4,1
ffffffffc02068ea:	c398                	sw	a4,0(a5)
ffffffffc02068ec:	80000737          	lui	a4,0x80000
ffffffffc02068f0:	840a                	mv	s0,sp
ffffffffc02068f2:	0709                	addi	a4,a4,2
ffffffffc02068f4:	0ee7a623          	sw	a4,236(a5)
ffffffffc02068f8:	8522                	mv	a0,s0
ffffffffc02068fa:	364000ef          	jal	ra,ffffffffc0206c5e <add_timer>
ffffffffc02068fe:	2a0000ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc0206902:	8522                	mv	a0,s0
ffffffffc0206904:	422000ef          	jal	ra,ffffffffc0206d26 <del_timer>
ffffffffc0206908:	70a2                	ld	ra,40(sp)
ffffffffc020690a:	7402                	ld	s0,32(sp)
ffffffffc020690c:	4501                	li	a0,0
ffffffffc020690e:	6145                	addi	sp,sp,48
ffffffffc0206910:	8082                	ret
ffffffffc0206912:	4501                	li	a0,0
ffffffffc0206914:	8082                	ret
ffffffffc0206916:	b5cfa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020691a:	0008f797          	auipc	a5,0x8f
ffffffffc020691e:	fa67b783          	ld	a5,-90(a5) # ffffffffc02958c0 <current>
ffffffffc0206922:	0818                	addi	a4,sp,16
ffffffffc0206924:	c022                	sw	s0,0(sp)
ffffffffc0206926:	e43e                	sd	a5,8(sp)
ffffffffc0206928:	ec3a                	sd	a4,24(sp)
ffffffffc020692a:	e83a                	sd	a4,16(sp)
ffffffffc020692c:	4705                	li	a4,1
ffffffffc020692e:	c398                	sw	a4,0(a5)
ffffffffc0206930:	80000737          	lui	a4,0x80000
ffffffffc0206934:	0709                	addi	a4,a4,2
ffffffffc0206936:	840a                	mv	s0,sp
ffffffffc0206938:	8522                	mv	a0,s0
ffffffffc020693a:	0ee7a623          	sw	a4,236(a5)
ffffffffc020693e:	320000ef          	jal	ra,ffffffffc0206c5e <add_timer>
ffffffffc0206942:	b2afa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206946:	bf65                	j	ffffffffc02068fe <do_sleep+0x3a>

ffffffffc0206948 <switch_to>:
ffffffffc0206948:	00153023          	sd	ra,0(a0)
ffffffffc020694c:	00253423          	sd	sp,8(a0)
ffffffffc0206950:	e900                	sd	s0,16(a0)
ffffffffc0206952:	ed04                	sd	s1,24(a0)
ffffffffc0206954:	03253023          	sd	s2,32(a0)
ffffffffc0206958:	03353423          	sd	s3,40(a0)
ffffffffc020695c:	03453823          	sd	s4,48(a0)
ffffffffc0206960:	03553c23          	sd	s5,56(a0)
ffffffffc0206964:	05653023          	sd	s6,64(a0)
ffffffffc0206968:	05753423          	sd	s7,72(a0)
ffffffffc020696c:	05853823          	sd	s8,80(a0)
ffffffffc0206970:	05953c23          	sd	s9,88(a0)
ffffffffc0206974:	07a53023          	sd	s10,96(a0)
ffffffffc0206978:	07b53423          	sd	s11,104(a0)
ffffffffc020697c:	0005b083          	ld	ra,0(a1)
ffffffffc0206980:	0085b103          	ld	sp,8(a1)
ffffffffc0206984:	6980                	ld	s0,16(a1)
ffffffffc0206986:	6d84                	ld	s1,24(a1)
ffffffffc0206988:	0205b903          	ld	s2,32(a1)
ffffffffc020698c:	0285b983          	ld	s3,40(a1)
ffffffffc0206990:	0305ba03          	ld	s4,48(a1)
ffffffffc0206994:	0385ba83          	ld	s5,56(a1)
ffffffffc0206998:	0405bb03          	ld	s6,64(a1)
ffffffffc020699c:	0485bb83          	ld	s7,72(a1)
ffffffffc02069a0:	0505bc03          	ld	s8,80(a1)
ffffffffc02069a4:	0585bc83          	ld	s9,88(a1)
ffffffffc02069a8:	0605bd03          	ld	s10,96(a1)
ffffffffc02069ac:	0685bd83          	ld	s11,104(a1)
ffffffffc02069b0:	8082                	ret

ffffffffc02069b2 <RR_init>:
ffffffffc02069b2:	e508                	sd	a0,8(a0)
ffffffffc02069b4:	e108                	sd	a0,0(a0)
ffffffffc02069b6:	00052823          	sw	zero,16(a0)
ffffffffc02069ba:	8082                	ret

ffffffffc02069bc <RR_pick_next>:
ffffffffc02069bc:	651c                	ld	a5,8(a0)
ffffffffc02069be:	00f50563          	beq	a0,a5,ffffffffc02069c8 <RR_pick_next+0xc>
ffffffffc02069c2:	ef078513          	addi	a0,a5,-272
ffffffffc02069c6:	8082                	ret
ffffffffc02069c8:	4501                	li	a0,0
ffffffffc02069ca:	8082                	ret

ffffffffc02069cc <RR_proc_tick>:
ffffffffc02069cc:	1205a783          	lw	a5,288(a1)
ffffffffc02069d0:	00f05563          	blez	a5,ffffffffc02069da <RR_proc_tick+0xe>
ffffffffc02069d4:	37fd                	addiw	a5,a5,-1
ffffffffc02069d6:	12f5a023          	sw	a5,288(a1)
ffffffffc02069da:	e399                	bnez	a5,ffffffffc02069e0 <RR_proc_tick+0x14>
ffffffffc02069dc:	4785                	li	a5,1
ffffffffc02069de:	ed9c                	sd	a5,24(a1)
ffffffffc02069e0:	8082                	ret

ffffffffc02069e2 <RR_dequeue>:
ffffffffc02069e2:	1185b703          	ld	a4,280(a1)
ffffffffc02069e6:	11058793          	addi	a5,a1,272
ffffffffc02069ea:	02e78363          	beq	a5,a4,ffffffffc0206a10 <RR_dequeue+0x2e>
ffffffffc02069ee:	1085b683          	ld	a3,264(a1)
ffffffffc02069f2:	00a69f63          	bne	a3,a0,ffffffffc0206a10 <RR_dequeue+0x2e>
ffffffffc02069f6:	1105b503          	ld	a0,272(a1)
ffffffffc02069fa:	4a90                	lw	a2,16(a3)
ffffffffc02069fc:	e518                	sd	a4,8(a0)
ffffffffc02069fe:	e308                	sd	a0,0(a4)
ffffffffc0206a00:	10f5bc23          	sd	a5,280(a1)
ffffffffc0206a04:	10f5b823          	sd	a5,272(a1)
ffffffffc0206a08:	fff6079b          	addiw	a5,a2,-1
ffffffffc0206a0c:	ca9c                	sw	a5,16(a3)
ffffffffc0206a0e:	8082                	ret
ffffffffc0206a10:	1141                	addi	sp,sp,-16
ffffffffc0206a12:	00006697          	auipc	a3,0x6
ffffffffc0206a16:	3be68693          	addi	a3,a3,958 # ffffffffc020cdd0 <CSWTCH.79+0x428>
ffffffffc0206a1a:	00004617          	auipc	a2,0x4
ffffffffc0206a1e:	59660613          	addi	a2,a2,1430 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206a22:	03c00593          	li	a1,60
ffffffffc0206a26:	00006517          	auipc	a0,0x6
ffffffffc0206a2a:	3e250513          	addi	a0,a0,994 # ffffffffc020ce08 <CSWTCH.79+0x460>
ffffffffc0206a2e:	e406                	sd	ra,8(sp)
ffffffffc0206a30:	a6ff90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206a34 <RR_enqueue>:
ffffffffc0206a34:	1185b703          	ld	a4,280(a1)
ffffffffc0206a38:	11058793          	addi	a5,a1,272
ffffffffc0206a3c:	02e79d63          	bne	a5,a4,ffffffffc0206a76 <RR_enqueue+0x42>
ffffffffc0206a40:	6118                	ld	a4,0(a0)
ffffffffc0206a42:	1205a683          	lw	a3,288(a1)
ffffffffc0206a46:	e11c                	sd	a5,0(a0)
ffffffffc0206a48:	e71c                	sd	a5,8(a4)
ffffffffc0206a4a:	10a5bc23          	sd	a0,280(a1)
ffffffffc0206a4e:	10e5b823          	sd	a4,272(a1)
ffffffffc0206a52:	495c                	lw	a5,20(a0)
ffffffffc0206a54:	ea89                	bnez	a3,ffffffffc0206a66 <RR_enqueue+0x32>
ffffffffc0206a56:	12f5a023          	sw	a5,288(a1)
ffffffffc0206a5a:	491c                	lw	a5,16(a0)
ffffffffc0206a5c:	10a5b423          	sd	a0,264(a1)
ffffffffc0206a60:	2785                	addiw	a5,a5,1
ffffffffc0206a62:	c91c                	sw	a5,16(a0)
ffffffffc0206a64:	8082                	ret
ffffffffc0206a66:	fed7c8e3          	blt	a5,a3,ffffffffc0206a56 <RR_enqueue+0x22>
ffffffffc0206a6a:	491c                	lw	a5,16(a0)
ffffffffc0206a6c:	10a5b423          	sd	a0,264(a1)
ffffffffc0206a70:	2785                	addiw	a5,a5,1
ffffffffc0206a72:	c91c                	sw	a5,16(a0)
ffffffffc0206a74:	8082                	ret
ffffffffc0206a76:	1141                	addi	sp,sp,-16
ffffffffc0206a78:	00006697          	auipc	a3,0x6
ffffffffc0206a7c:	3b068693          	addi	a3,a3,944 # ffffffffc020ce28 <CSWTCH.79+0x480>
ffffffffc0206a80:	00004617          	auipc	a2,0x4
ffffffffc0206a84:	53060613          	addi	a2,a2,1328 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206a88:	02800593          	li	a1,40
ffffffffc0206a8c:	00006517          	auipc	a0,0x6
ffffffffc0206a90:	37c50513          	addi	a0,a0,892 # ffffffffc020ce08 <CSWTCH.79+0x460>
ffffffffc0206a94:	e406                	sd	ra,8(sp)
ffffffffc0206a96:	a09f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206a9a <sched_init>:
ffffffffc0206a9a:	1141                	addi	sp,sp,-16
ffffffffc0206a9c:	00089717          	auipc	a4,0x89
ffffffffc0206aa0:	58470713          	addi	a4,a4,1412 # ffffffffc0290020 <default_sched_class>
ffffffffc0206aa4:	e022                	sd	s0,0(sp)
ffffffffc0206aa6:	e406                	sd	ra,8(sp)
ffffffffc0206aa8:	0008e797          	auipc	a5,0x8e
ffffffffc0206aac:	d4878793          	addi	a5,a5,-696 # ffffffffc02947f0 <timer_list>
ffffffffc0206ab0:	6714                	ld	a3,8(a4)
ffffffffc0206ab2:	0008e517          	auipc	a0,0x8e
ffffffffc0206ab6:	d1e50513          	addi	a0,a0,-738 # ffffffffc02947d0 <__rq>
ffffffffc0206aba:	e79c                	sd	a5,8(a5)
ffffffffc0206abc:	e39c                	sd	a5,0(a5)
ffffffffc0206abe:	4795                	li	a5,5
ffffffffc0206ac0:	c95c                	sw	a5,20(a0)
ffffffffc0206ac2:	0008f417          	auipc	s0,0x8f
ffffffffc0206ac6:	e2640413          	addi	s0,s0,-474 # ffffffffc02958e8 <sched_class>
ffffffffc0206aca:	0008f797          	auipc	a5,0x8f
ffffffffc0206ace:	e0a7bb23          	sd	a0,-490(a5) # ffffffffc02958e0 <rq>
ffffffffc0206ad2:	e018                	sd	a4,0(s0)
ffffffffc0206ad4:	9682                	jalr	a3
ffffffffc0206ad6:	601c                	ld	a5,0(s0)
ffffffffc0206ad8:	6402                	ld	s0,0(sp)
ffffffffc0206ada:	60a2                	ld	ra,8(sp)
ffffffffc0206adc:	638c                	ld	a1,0(a5)
ffffffffc0206ade:	00006517          	auipc	a0,0x6
ffffffffc0206ae2:	37a50513          	addi	a0,a0,890 # ffffffffc020ce58 <CSWTCH.79+0x4b0>
ffffffffc0206ae6:	0141                	addi	sp,sp,16
ffffffffc0206ae8:	ebef906f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0206aec <wakeup_proc>:
ffffffffc0206aec:	4118                	lw	a4,0(a0)
ffffffffc0206aee:	1101                	addi	sp,sp,-32
ffffffffc0206af0:	ec06                	sd	ra,24(sp)
ffffffffc0206af2:	e822                	sd	s0,16(sp)
ffffffffc0206af4:	e426                	sd	s1,8(sp)
ffffffffc0206af6:	478d                	li	a5,3
ffffffffc0206af8:	08f70363          	beq	a4,a5,ffffffffc0206b7e <wakeup_proc+0x92>
ffffffffc0206afc:	842a                	mv	s0,a0
ffffffffc0206afe:	100027f3          	csrr	a5,sstatus
ffffffffc0206b02:	8b89                	andi	a5,a5,2
ffffffffc0206b04:	4481                	li	s1,0
ffffffffc0206b06:	e7bd                	bnez	a5,ffffffffc0206b74 <wakeup_proc+0x88>
ffffffffc0206b08:	4789                	li	a5,2
ffffffffc0206b0a:	04f70863          	beq	a4,a5,ffffffffc0206b5a <wakeup_proc+0x6e>
ffffffffc0206b0e:	c01c                	sw	a5,0(s0)
ffffffffc0206b10:	0e042623          	sw	zero,236(s0)
ffffffffc0206b14:	0008f797          	auipc	a5,0x8f
ffffffffc0206b18:	dac7b783          	ld	a5,-596(a5) # ffffffffc02958c0 <current>
ffffffffc0206b1c:	02878363          	beq	a5,s0,ffffffffc0206b42 <wakeup_proc+0x56>
ffffffffc0206b20:	0008f797          	auipc	a5,0x8f
ffffffffc0206b24:	da87b783          	ld	a5,-600(a5) # ffffffffc02958c8 <idleproc>
ffffffffc0206b28:	00f40d63          	beq	s0,a5,ffffffffc0206b42 <wakeup_proc+0x56>
ffffffffc0206b2c:	0008f797          	auipc	a5,0x8f
ffffffffc0206b30:	dbc7b783          	ld	a5,-580(a5) # ffffffffc02958e8 <sched_class>
ffffffffc0206b34:	6b9c                	ld	a5,16(a5)
ffffffffc0206b36:	85a2                	mv	a1,s0
ffffffffc0206b38:	0008f517          	auipc	a0,0x8f
ffffffffc0206b3c:	da853503          	ld	a0,-600(a0) # ffffffffc02958e0 <rq>
ffffffffc0206b40:	9782                	jalr	a5
ffffffffc0206b42:	e491                	bnez	s1,ffffffffc0206b4e <wakeup_proc+0x62>
ffffffffc0206b44:	60e2                	ld	ra,24(sp)
ffffffffc0206b46:	6442                	ld	s0,16(sp)
ffffffffc0206b48:	64a2                	ld	s1,8(sp)
ffffffffc0206b4a:	6105                	addi	sp,sp,32
ffffffffc0206b4c:	8082                	ret
ffffffffc0206b4e:	6442                	ld	s0,16(sp)
ffffffffc0206b50:	60e2                	ld	ra,24(sp)
ffffffffc0206b52:	64a2                	ld	s1,8(sp)
ffffffffc0206b54:	6105                	addi	sp,sp,32
ffffffffc0206b56:	916fa06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0206b5a:	00006617          	auipc	a2,0x6
ffffffffc0206b5e:	34e60613          	addi	a2,a2,846 # ffffffffc020cea8 <CSWTCH.79+0x500>
ffffffffc0206b62:	05200593          	li	a1,82
ffffffffc0206b66:	00006517          	auipc	a0,0x6
ffffffffc0206b6a:	32a50513          	addi	a0,a0,810 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206b6e:	999f90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc0206b72:	bfc1                	j	ffffffffc0206b42 <wakeup_proc+0x56>
ffffffffc0206b74:	8fefa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206b78:	4018                	lw	a4,0(s0)
ffffffffc0206b7a:	4485                	li	s1,1
ffffffffc0206b7c:	b771                	j	ffffffffc0206b08 <wakeup_proc+0x1c>
ffffffffc0206b7e:	00006697          	auipc	a3,0x6
ffffffffc0206b82:	2f268693          	addi	a3,a3,754 # ffffffffc020ce70 <CSWTCH.79+0x4c8>
ffffffffc0206b86:	00004617          	auipc	a2,0x4
ffffffffc0206b8a:	42a60613          	addi	a2,a2,1066 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206b8e:	04300593          	li	a1,67
ffffffffc0206b92:	00006517          	auipc	a0,0x6
ffffffffc0206b96:	2fe50513          	addi	a0,a0,766 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206b9a:	905f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206b9e <schedule>:
ffffffffc0206b9e:	7179                	addi	sp,sp,-48
ffffffffc0206ba0:	f406                	sd	ra,40(sp)
ffffffffc0206ba2:	f022                	sd	s0,32(sp)
ffffffffc0206ba4:	ec26                	sd	s1,24(sp)
ffffffffc0206ba6:	e84a                	sd	s2,16(sp)
ffffffffc0206ba8:	e44e                	sd	s3,8(sp)
ffffffffc0206baa:	e052                	sd	s4,0(sp)
ffffffffc0206bac:	100027f3          	csrr	a5,sstatus
ffffffffc0206bb0:	8b89                	andi	a5,a5,2
ffffffffc0206bb2:	4a01                	li	s4,0
ffffffffc0206bb4:	e3cd                	bnez	a5,ffffffffc0206c56 <schedule+0xb8>
ffffffffc0206bb6:	0008f497          	auipc	s1,0x8f
ffffffffc0206bba:	d0a48493          	addi	s1,s1,-758 # ffffffffc02958c0 <current>
ffffffffc0206bbe:	608c                	ld	a1,0(s1)
ffffffffc0206bc0:	0008f997          	auipc	s3,0x8f
ffffffffc0206bc4:	d2898993          	addi	s3,s3,-728 # ffffffffc02958e8 <sched_class>
ffffffffc0206bc8:	0008f917          	auipc	s2,0x8f
ffffffffc0206bcc:	d1890913          	addi	s2,s2,-744 # ffffffffc02958e0 <rq>
ffffffffc0206bd0:	4194                	lw	a3,0(a1)
ffffffffc0206bd2:	0005bc23          	sd	zero,24(a1)
ffffffffc0206bd6:	4709                	li	a4,2
ffffffffc0206bd8:	0009b783          	ld	a5,0(s3)
ffffffffc0206bdc:	00093503          	ld	a0,0(s2)
ffffffffc0206be0:	04e68e63          	beq	a3,a4,ffffffffc0206c3c <schedule+0x9e>
ffffffffc0206be4:	739c                	ld	a5,32(a5)
ffffffffc0206be6:	9782                	jalr	a5
ffffffffc0206be8:	842a                	mv	s0,a0
ffffffffc0206bea:	c521                	beqz	a0,ffffffffc0206c32 <schedule+0x94>
ffffffffc0206bec:	0009b783          	ld	a5,0(s3)
ffffffffc0206bf0:	00093503          	ld	a0,0(s2)
ffffffffc0206bf4:	85a2                	mv	a1,s0
ffffffffc0206bf6:	6f9c                	ld	a5,24(a5)
ffffffffc0206bf8:	9782                	jalr	a5
ffffffffc0206bfa:	441c                	lw	a5,8(s0)
ffffffffc0206bfc:	6098                	ld	a4,0(s1)
ffffffffc0206bfe:	2785                	addiw	a5,a5,1
ffffffffc0206c00:	c41c                	sw	a5,8(s0)
ffffffffc0206c02:	00870563          	beq	a4,s0,ffffffffc0206c0c <schedule+0x6e>
ffffffffc0206c06:	8522                	mv	a0,s0
ffffffffc0206c08:	d79fe0ef          	jal	ra,ffffffffc0205980 <proc_run>
ffffffffc0206c0c:	000a1a63          	bnez	s4,ffffffffc0206c20 <schedule+0x82>
ffffffffc0206c10:	70a2                	ld	ra,40(sp)
ffffffffc0206c12:	7402                	ld	s0,32(sp)
ffffffffc0206c14:	64e2                	ld	s1,24(sp)
ffffffffc0206c16:	6942                	ld	s2,16(sp)
ffffffffc0206c18:	69a2                	ld	s3,8(sp)
ffffffffc0206c1a:	6a02                	ld	s4,0(sp)
ffffffffc0206c1c:	6145                	addi	sp,sp,48
ffffffffc0206c1e:	8082                	ret
ffffffffc0206c20:	7402                	ld	s0,32(sp)
ffffffffc0206c22:	70a2                	ld	ra,40(sp)
ffffffffc0206c24:	64e2                	ld	s1,24(sp)
ffffffffc0206c26:	6942                	ld	s2,16(sp)
ffffffffc0206c28:	69a2                	ld	s3,8(sp)
ffffffffc0206c2a:	6a02                	ld	s4,0(sp)
ffffffffc0206c2c:	6145                	addi	sp,sp,48
ffffffffc0206c2e:	83efa06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0206c32:	0008f417          	auipc	s0,0x8f
ffffffffc0206c36:	c9643403          	ld	s0,-874(s0) # ffffffffc02958c8 <idleproc>
ffffffffc0206c3a:	b7c1                	j	ffffffffc0206bfa <schedule+0x5c>
ffffffffc0206c3c:	0008f717          	auipc	a4,0x8f
ffffffffc0206c40:	c8c73703          	ld	a4,-884(a4) # ffffffffc02958c8 <idleproc>
ffffffffc0206c44:	fae580e3          	beq	a1,a4,ffffffffc0206be4 <schedule+0x46>
ffffffffc0206c48:	6b9c                	ld	a5,16(a5)
ffffffffc0206c4a:	9782                	jalr	a5
ffffffffc0206c4c:	0009b783          	ld	a5,0(s3)
ffffffffc0206c50:	00093503          	ld	a0,0(s2)
ffffffffc0206c54:	bf41                	j	ffffffffc0206be4 <schedule+0x46>
ffffffffc0206c56:	81cfa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206c5a:	4a05                	li	s4,1
ffffffffc0206c5c:	bfa9                	j	ffffffffc0206bb6 <schedule+0x18>

ffffffffc0206c5e <add_timer>:
ffffffffc0206c5e:	1141                	addi	sp,sp,-16
ffffffffc0206c60:	e022                	sd	s0,0(sp)
ffffffffc0206c62:	e406                	sd	ra,8(sp)
ffffffffc0206c64:	842a                	mv	s0,a0
ffffffffc0206c66:	100027f3          	csrr	a5,sstatus
ffffffffc0206c6a:	8b89                	andi	a5,a5,2
ffffffffc0206c6c:	4501                	li	a0,0
ffffffffc0206c6e:	eba5                	bnez	a5,ffffffffc0206cde <add_timer+0x80>
ffffffffc0206c70:	401c                	lw	a5,0(s0)
ffffffffc0206c72:	cbb5                	beqz	a5,ffffffffc0206ce6 <add_timer+0x88>
ffffffffc0206c74:	6418                	ld	a4,8(s0)
ffffffffc0206c76:	cb25                	beqz	a4,ffffffffc0206ce6 <add_timer+0x88>
ffffffffc0206c78:	6c18                	ld	a4,24(s0)
ffffffffc0206c7a:	01040593          	addi	a1,s0,16
ffffffffc0206c7e:	08e59463          	bne	a1,a4,ffffffffc0206d06 <add_timer+0xa8>
ffffffffc0206c82:	0008e617          	auipc	a2,0x8e
ffffffffc0206c86:	b6e60613          	addi	a2,a2,-1170 # ffffffffc02947f0 <timer_list>
ffffffffc0206c8a:	6618                	ld	a4,8(a2)
ffffffffc0206c8c:	00c71863          	bne	a4,a2,ffffffffc0206c9c <add_timer+0x3e>
ffffffffc0206c90:	a80d                	j	ffffffffc0206cc2 <add_timer+0x64>
ffffffffc0206c92:	6718                	ld	a4,8(a4)
ffffffffc0206c94:	9f95                	subw	a5,a5,a3
ffffffffc0206c96:	c01c                	sw	a5,0(s0)
ffffffffc0206c98:	02c70563          	beq	a4,a2,ffffffffc0206cc2 <add_timer+0x64>
ffffffffc0206c9c:	ff072683          	lw	a3,-16(a4)
ffffffffc0206ca0:	fed7f9e3          	bgeu	a5,a3,ffffffffc0206c92 <add_timer+0x34>
ffffffffc0206ca4:	40f687bb          	subw	a5,a3,a5
ffffffffc0206ca8:	fef72823          	sw	a5,-16(a4)
ffffffffc0206cac:	631c                	ld	a5,0(a4)
ffffffffc0206cae:	e30c                	sd	a1,0(a4)
ffffffffc0206cb0:	e78c                	sd	a1,8(a5)
ffffffffc0206cb2:	ec18                	sd	a4,24(s0)
ffffffffc0206cb4:	e81c                	sd	a5,16(s0)
ffffffffc0206cb6:	c105                	beqz	a0,ffffffffc0206cd6 <add_timer+0x78>
ffffffffc0206cb8:	6402                	ld	s0,0(sp)
ffffffffc0206cba:	60a2                	ld	ra,8(sp)
ffffffffc0206cbc:	0141                	addi	sp,sp,16
ffffffffc0206cbe:	faff906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0206cc2:	0008e717          	auipc	a4,0x8e
ffffffffc0206cc6:	b2e70713          	addi	a4,a4,-1234 # ffffffffc02947f0 <timer_list>
ffffffffc0206cca:	631c                	ld	a5,0(a4)
ffffffffc0206ccc:	e30c                	sd	a1,0(a4)
ffffffffc0206cce:	e78c                	sd	a1,8(a5)
ffffffffc0206cd0:	ec18                	sd	a4,24(s0)
ffffffffc0206cd2:	e81c                	sd	a5,16(s0)
ffffffffc0206cd4:	f175                	bnez	a0,ffffffffc0206cb8 <add_timer+0x5a>
ffffffffc0206cd6:	60a2                	ld	ra,8(sp)
ffffffffc0206cd8:	6402                	ld	s0,0(sp)
ffffffffc0206cda:	0141                	addi	sp,sp,16
ffffffffc0206cdc:	8082                	ret
ffffffffc0206cde:	f95f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206ce2:	4505                	li	a0,1
ffffffffc0206ce4:	b771                	j	ffffffffc0206c70 <add_timer+0x12>
ffffffffc0206ce6:	00006697          	auipc	a3,0x6
ffffffffc0206cea:	1e268693          	addi	a3,a3,482 # ffffffffc020cec8 <CSWTCH.79+0x520>
ffffffffc0206cee:	00004617          	auipc	a2,0x4
ffffffffc0206cf2:	2c260613          	addi	a2,a2,706 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206cf6:	07a00593          	li	a1,122
ffffffffc0206cfa:	00006517          	auipc	a0,0x6
ffffffffc0206cfe:	19650513          	addi	a0,a0,406 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206d02:	f9cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d06:	00006697          	auipc	a3,0x6
ffffffffc0206d0a:	1f268693          	addi	a3,a3,498 # ffffffffc020cef8 <CSWTCH.79+0x550>
ffffffffc0206d0e:	00004617          	auipc	a2,0x4
ffffffffc0206d12:	2a260613          	addi	a2,a2,674 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206d16:	07b00593          	li	a1,123
ffffffffc0206d1a:	00006517          	auipc	a0,0x6
ffffffffc0206d1e:	17650513          	addi	a0,a0,374 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206d22:	f7cf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206d26 <del_timer>:
ffffffffc0206d26:	1101                	addi	sp,sp,-32
ffffffffc0206d28:	e822                	sd	s0,16(sp)
ffffffffc0206d2a:	ec06                	sd	ra,24(sp)
ffffffffc0206d2c:	e426                	sd	s1,8(sp)
ffffffffc0206d2e:	842a                	mv	s0,a0
ffffffffc0206d30:	100027f3          	csrr	a5,sstatus
ffffffffc0206d34:	8b89                	andi	a5,a5,2
ffffffffc0206d36:	01050493          	addi	s1,a0,16
ffffffffc0206d3a:	eb9d                	bnez	a5,ffffffffc0206d70 <del_timer+0x4a>
ffffffffc0206d3c:	6d1c                	ld	a5,24(a0)
ffffffffc0206d3e:	02978463          	beq	a5,s1,ffffffffc0206d66 <del_timer+0x40>
ffffffffc0206d42:	4114                	lw	a3,0(a0)
ffffffffc0206d44:	6918                	ld	a4,16(a0)
ffffffffc0206d46:	ce81                	beqz	a3,ffffffffc0206d5e <del_timer+0x38>
ffffffffc0206d48:	0008e617          	auipc	a2,0x8e
ffffffffc0206d4c:	aa860613          	addi	a2,a2,-1368 # ffffffffc02947f0 <timer_list>
ffffffffc0206d50:	00c78763          	beq	a5,a2,ffffffffc0206d5e <del_timer+0x38>
ffffffffc0206d54:	ff07a603          	lw	a2,-16(a5)
ffffffffc0206d58:	9eb1                	addw	a3,a3,a2
ffffffffc0206d5a:	fed7a823          	sw	a3,-16(a5)
ffffffffc0206d5e:	e71c                	sd	a5,8(a4)
ffffffffc0206d60:	e398                	sd	a4,0(a5)
ffffffffc0206d62:	ec04                	sd	s1,24(s0)
ffffffffc0206d64:	e804                	sd	s1,16(s0)
ffffffffc0206d66:	60e2                	ld	ra,24(sp)
ffffffffc0206d68:	6442                	ld	s0,16(sp)
ffffffffc0206d6a:	64a2                	ld	s1,8(sp)
ffffffffc0206d6c:	6105                	addi	sp,sp,32
ffffffffc0206d6e:	8082                	ret
ffffffffc0206d70:	f03f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206d74:	6c1c                	ld	a5,24(s0)
ffffffffc0206d76:	02978463          	beq	a5,s1,ffffffffc0206d9e <del_timer+0x78>
ffffffffc0206d7a:	4014                	lw	a3,0(s0)
ffffffffc0206d7c:	6818                	ld	a4,16(s0)
ffffffffc0206d7e:	ce81                	beqz	a3,ffffffffc0206d96 <del_timer+0x70>
ffffffffc0206d80:	0008e617          	auipc	a2,0x8e
ffffffffc0206d84:	a7060613          	addi	a2,a2,-1424 # ffffffffc02947f0 <timer_list>
ffffffffc0206d88:	00c78763          	beq	a5,a2,ffffffffc0206d96 <del_timer+0x70>
ffffffffc0206d8c:	ff07a603          	lw	a2,-16(a5)
ffffffffc0206d90:	9eb1                	addw	a3,a3,a2
ffffffffc0206d92:	fed7a823          	sw	a3,-16(a5)
ffffffffc0206d96:	e71c                	sd	a5,8(a4)
ffffffffc0206d98:	e398                	sd	a4,0(a5)
ffffffffc0206d9a:	ec04                	sd	s1,24(s0)
ffffffffc0206d9c:	e804                	sd	s1,16(s0)
ffffffffc0206d9e:	6442                	ld	s0,16(sp)
ffffffffc0206da0:	60e2                	ld	ra,24(sp)
ffffffffc0206da2:	64a2                	ld	s1,8(sp)
ffffffffc0206da4:	6105                	addi	sp,sp,32
ffffffffc0206da6:	ec7f906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc0206daa <run_timer_list>:
ffffffffc0206daa:	7139                	addi	sp,sp,-64
ffffffffc0206dac:	fc06                	sd	ra,56(sp)
ffffffffc0206dae:	f822                	sd	s0,48(sp)
ffffffffc0206db0:	f426                	sd	s1,40(sp)
ffffffffc0206db2:	f04a                	sd	s2,32(sp)
ffffffffc0206db4:	ec4e                	sd	s3,24(sp)
ffffffffc0206db6:	e852                	sd	s4,16(sp)
ffffffffc0206db8:	e456                	sd	s5,8(sp)
ffffffffc0206dba:	e05a                	sd	s6,0(sp)
ffffffffc0206dbc:	100027f3          	csrr	a5,sstatus
ffffffffc0206dc0:	8b89                	andi	a5,a5,2
ffffffffc0206dc2:	4b01                	li	s6,0
ffffffffc0206dc4:	efe9                	bnez	a5,ffffffffc0206e9e <run_timer_list+0xf4>
ffffffffc0206dc6:	0008e997          	auipc	s3,0x8e
ffffffffc0206dca:	a2a98993          	addi	s3,s3,-1494 # ffffffffc02947f0 <timer_list>
ffffffffc0206dce:	0089b403          	ld	s0,8(s3)
ffffffffc0206dd2:	07340a63          	beq	s0,s3,ffffffffc0206e46 <run_timer_list+0x9c>
ffffffffc0206dd6:	ff042783          	lw	a5,-16(s0)
ffffffffc0206dda:	ff040913          	addi	s2,s0,-16
ffffffffc0206dde:	0e078763          	beqz	a5,ffffffffc0206ecc <run_timer_list+0x122>
ffffffffc0206de2:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206de6:	fee42823          	sw	a4,-16(s0)
ffffffffc0206dea:	ef31                	bnez	a4,ffffffffc0206e46 <run_timer_list+0x9c>
ffffffffc0206dec:	00006a97          	auipc	s5,0x6
ffffffffc0206df0:	174a8a93          	addi	s5,s5,372 # ffffffffc020cf60 <CSWTCH.79+0x5b8>
ffffffffc0206df4:	00006a17          	auipc	s4,0x6
ffffffffc0206df8:	09ca0a13          	addi	s4,s4,156 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206dfc:	a005                	j	ffffffffc0206e1c <run_timer_list+0x72>
ffffffffc0206dfe:	0a07d763          	bgez	a5,ffffffffc0206eac <run_timer_list+0x102>
ffffffffc0206e02:	8526                	mv	a0,s1
ffffffffc0206e04:	ce9ff0ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0206e08:	854a                	mv	a0,s2
ffffffffc0206e0a:	f1dff0ef          	jal	ra,ffffffffc0206d26 <del_timer>
ffffffffc0206e0e:	03340c63          	beq	s0,s3,ffffffffc0206e46 <run_timer_list+0x9c>
ffffffffc0206e12:	ff042783          	lw	a5,-16(s0)
ffffffffc0206e16:	ff040913          	addi	s2,s0,-16
ffffffffc0206e1a:	e795                	bnez	a5,ffffffffc0206e46 <run_timer_list+0x9c>
ffffffffc0206e1c:	00893483          	ld	s1,8(s2)
ffffffffc0206e20:	6400                	ld	s0,8(s0)
ffffffffc0206e22:	0ec4a783          	lw	a5,236(s1)
ffffffffc0206e26:	ffe1                	bnez	a5,ffffffffc0206dfe <run_timer_list+0x54>
ffffffffc0206e28:	40d4                	lw	a3,4(s1)
ffffffffc0206e2a:	8656                	mv	a2,s5
ffffffffc0206e2c:	0ba00593          	li	a1,186
ffffffffc0206e30:	8552                	mv	a0,s4
ffffffffc0206e32:	ed4f90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc0206e36:	8526                	mv	a0,s1
ffffffffc0206e38:	cb5ff0ef          	jal	ra,ffffffffc0206aec <wakeup_proc>
ffffffffc0206e3c:	854a                	mv	a0,s2
ffffffffc0206e3e:	ee9ff0ef          	jal	ra,ffffffffc0206d26 <del_timer>
ffffffffc0206e42:	fd3418e3          	bne	s0,s3,ffffffffc0206e12 <run_timer_list+0x68>
ffffffffc0206e46:	0008f597          	auipc	a1,0x8f
ffffffffc0206e4a:	a7a5b583          	ld	a1,-1414(a1) # ffffffffc02958c0 <current>
ffffffffc0206e4e:	c18d                	beqz	a1,ffffffffc0206e70 <run_timer_list+0xc6>
ffffffffc0206e50:	0008f797          	auipc	a5,0x8f
ffffffffc0206e54:	a787b783          	ld	a5,-1416(a5) # ffffffffc02958c8 <idleproc>
ffffffffc0206e58:	04f58763          	beq	a1,a5,ffffffffc0206ea6 <run_timer_list+0xfc>
ffffffffc0206e5c:	0008f797          	auipc	a5,0x8f
ffffffffc0206e60:	a8c7b783          	ld	a5,-1396(a5) # ffffffffc02958e8 <sched_class>
ffffffffc0206e64:	779c                	ld	a5,40(a5)
ffffffffc0206e66:	0008f517          	auipc	a0,0x8f
ffffffffc0206e6a:	a7a53503          	ld	a0,-1414(a0) # ffffffffc02958e0 <rq>
ffffffffc0206e6e:	9782                	jalr	a5
ffffffffc0206e70:	000b1c63          	bnez	s6,ffffffffc0206e88 <run_timer_list+0xde>
ffffffffc0206e74:	70e2                	ld	ra,56(sp)
ffffffffc0206e76:	7442                	ld	s0,48(sp)
ffffffffc0206e78:	74a2                	ld	s1,40(sp)
ffffffffc0206e7a:	7902                	ld	s2,32(sp)
ffffffffc0206e7c:	69e2                	ld	s3,24(sp)
ffffffffc0206e7e:	6a42                	ld	s4,16(sp)
ffffffffc0206e80:	6aa2                	ld	s5,8(sp)
ffffffffc0206e82:	6b02                	ld	s6,0(sp)
ffffffffc0206e84:	6121                	addi	sp,sp,64
ffffffffc0206e86:	8082                	ret
ffffffffc0206e88:	7442                	ld	s0,48(sp)
ffffffffc0206e8a:	70e2                	ld	ra,56(sp)
ffffffffc0206e8c:	74a2                	ld	s1,40(sp)
ffffffffc0206e8e:	7902                	ld	s2,32(sp)
ffffffffc0206e90:	69e2                	ld	s3,24(sp)
ffffffffc0206e92:	6a42                	ld	s4,16(sp)
ffffffffc0206e94:	6aa2                	ld	s5,8(sp)
ffffffffc0206e96:	6b02                	ld	s6,0(sp)
ffffffffc0206e98:	6121                	addi	sp,sp,64
ffffffffc0206e9a:	dd3f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0206e9e:	dd5f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206ea2:	4b05                	li	s6,1
ffffffffc0206ea4:	b70d                	j	ffffffffc0206dc6 <run_timer_list+0x1c>
ffffffffc0206ea6:	4785                	li	a5,1
ffffffffc0206ea8:	ed9c                	sd	a5,24(a1)
ffffffffc0206eaa:	b7d9                	j	ffffffffc0206e70 <run_timer_list+0xc6>
ffffffffc0206eac:	00006697          	auipc	a3,0x6
ffffffffc0206eb0:	08c68693          	addi	a3,a3,140 # ffffffffc020cf38 <CSWTCH.79+0x590>
ffffffffc0206eb4:	00004617          	auipc	a2,0x4
ffffffffc0206eb8:	0fc60613          	addi	a2,a2,252 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206ebc:	0b600593          	li	a1,182
ffffffffc0206ec0:	00006517          	auipc	a0,0x6
ffffffffc0206ec4:	fd050513          	addi	a0,a0,-48 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206ec8:	dd6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ecc:	00006697          	auipc	a3,0x6
ffffffffc0206ed0:	05468693          	addi	a3,a3,84 # ffffffffc020cf20 <CSWTCH.79+0x578>
ffffffffc0206ed4:	00004617          	auipc	a2,0x4
ffffffffc0206ed8:	0dc60613          	addi	a2,a2,220 # ffffffffc020afb0 <commands+0x210>
ffffffffc0206edc:	0ae00593          	li	a1,174
ffffffffc0206ee0:	00006517          	auipc	a0,0x6
ffffffffc0206ee4:	fb050513          	addi	a0,a0,-80 # ffffffffc020ce90 <CSWTCH.79+0x4e8>
ffffffffc0206ee8:	db6f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206eec <sys_getpid>:
ffffffffc0206eec:	0008f797          	auipc	a5,0x8f
ffffffffc0206ef0:	9d47b783          	ld	a5,-1580(a5) # ffffffffc02958c0 <current>
ffffffffc0206ef4:	43c8                	lw	a0,4(a5)
ffffffffc0206ef6:	8082                	ret

ffffffffc0206ef8 <sys_pgdir>:
ffffffffc0206ef8:	4501                	li	a0,0
ffffffffc0206efa:	8082                	ret

ffffffffc0206efc <sys_gettime>:
ffffffffc0206efc:	0008f797          	auipc	a5,0x8f
ffffffffc0206f00:	9747b783          	ld	a5,-1676(a5) # ffffffffc0295870 <ticks>
ffffffffc0206f04:	0027951b          	slliw	a0,a5,0x2
ffffffffc0206f08:	9d3d                	addw	a0,a0,a5
ffffffffc0206f0a:	0015151b          	slliw	a0,a0,0x1
ffffffffc0206f0e:	8082                	ret

ffffffffc0206f10 <sys_lab6_set_priority>:
ffffffffc0206f10:	4108                	lw	a0,0(a0)
ffffffffc0206f12:	1141                	addi	sp,sp,-16
ffffffffc0206f14:	e406                	sd	ra,8(sp)
ffffffffc0206f16:	975ff0ef          	jal	ra,ffffffffc020688a <lab6_set_priority>
ffffffffc0206f1a:	60a2                	ld	ra,8(sp)
ffffffffc0206f1c:	4501                	li	a0,0
ffffffffc0206f1e:	0141                	addi	sp,sp,16
ffffffffc0206f20:	8082                	ret

ffffffffc0206f22 <sys_dup>:
ffffffffc0206f22:	450c                	lw	a1,8(a0)
ffffffffc0206f24:	4108                	lw	a0,0(a0)
ffffffffc0206f26:	931fe06f          	j	ffffffffc0205856 <sysfile_dup>

ffffffffc0206f2a <sys_getdirentry>:
ffffffffc0206f2a:	650c                	ld	a1,8(a0)
ffffffffc0206f2c:	4108                	lw	a0,0(a0)
ffffffffc0206f2e:	839fe06f          	j	ffffffffc0205766 <sysfile_getdirentry>

ffffffffc0206f32 <sys_getcwd>:
ffffffffc0206f32:	650c                	ld	a1,8(a0)
ffffffffc0206f34:	6108                	ld	a0,0(a0)
ffffffffc0206f36:	f8cfe06f          	j	ffffffffc02056c2 <sysfile_getcwd>

ffffffffc0206f3a <sys_fsync>:
ffffffffc0206f3a:	4108                	lw	a0,0(a0)
ffffffffc0206f3c:	f82fe06f          	j	ffffffffc02056be <sysfile_fsync>

ffffffffc0206f40 <sys_fstat>:
ffffffffc0206f40:	650c                	ld	a1,8(a0)
ffffffffc0206f42:	4108                	lw	a0,0(a0)
ffffffffc0206f44:	edafe06f          	j	ffffffffc020561e <sysfile_fstat>

ffffffffc0206f48 <sys_seek>:
ffffffffc0206f48:	4910                	lw	a2,16(a0)
ffffffffc0206f4a:	650c                	ld	a1,8(a0)
ffffffffc0206f4c:	4108                	lw	a0,0(a0)
ffffffffc0206f4e:	eccfe06f          	j	ffffffffc020561a <sysfile_seek>

ffffffffc0206f52 <sys_write>:
ffffffffc0206f52:	6910                	ld	a2,16(a0)
ffffffffc0206f54:	650c                	ld	a1,8(a0)
ffffffffc0206f56:	4108                	lw	a0,0(a0)
ffffffffc0206f58:	da8fe06f          	j	ffffffffc0205500 <sysfile_write>

ffffffffc0206f5c <sys_read>:
ffffffffc0206f5c:	6910                	ld	a2,16(a0)
ffffffffc0206f5e:	650c                	ld	a1,8(a0)
ffffffffc0206f60:	4108                	lw	a0,0(a0)
ffffffffc0206f62:	c8afe06f          	j	ffffffffc02053ec <sysfile_read>

ffffffffc0206f66 <sys_close>:
ffffffffc0206f66:	4108                	lw	a0,0(a0)
ffffffffc0206f68:	c80fe06f          	j	ffffffffc02053e8 <sysfile_close>

ffffffffc0206f6c <sys_open>:
ffffffffc0206f6c:	450c                	lw	a1,8(a0)
ffffffffc0206f6e:	6108                	ld	a0,0(a0)
ffffffffc0206f70:	c44fe06f          	j	ffffffffc02053b4 <sysfile_open>

ffffffffc0206f74 <sys_putc>:
ffffffffc0206f74:	4108                	lw	a0,0(a0)
ffffffffc0206f76:	1141                	addi	sp,sp,-16
ffffffffc0206f78:	e406                	sd	ra,8(sp)
ffffffffc0206f7a:	a68f90ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0206f7e:	60a2                	ld	ra,8(sp)
ffffffffc0206f80:	4501                	li	a0,0
ffffffffc0206f82:	0141                	addi	sp,sp,16
ffffffffc0206f84:	8082                	ret

ffffffffc0206f86 <sys_kill>:
ffffffffc0206f86:	4108                	lw	a0,0(a0)
ffffffffc0206f88:	ea0ff06f          	j	ffffffffc0206628 <do_kill>

ffffffffc0206f8c <sys_sleep>:
ffffffffc0206f8c:	4108                	lw	a0,0(a0)
ffffffffc0206f8e:	937ff06f          	j	ffffffffc02068c4 <do_sleep>

ffffffffc0206f92 <sys_yield>:
ffffffffc0206f92:	e48ff06f          	j	ffffffffc02065da <do_yield>

ffffffffc0206f96 <sys_exec>:
ffffffffc0206f96:	6910                	ld	a2,16(a0)
ffffffffc0206f98:	450c                	lw	a1,8(a0)
ffffffffc0206f9a:	6108                	ld	a0,0(a0)
ffffffffc0206f9c:	b54ff06f          	j	ffffffffc02062f0 <do_execve>

ffffffffc0206fa0 <sys_wait>:
ffffffffc0206fa0:	650c                	ld	a1,8(a0)
ffffffffc0206fa2:	4108                	lw	a0,0(a0)
ffffffffc0206fa4:	e46ff06f          	j	ffffffffc02065ea <do_wait>

ffffffffc0206fa8 <sys_fork>:
ffffffffc0206fa8:	0008f797          	auipc	a5,0x8f
ffffffffc0206fac:	9187b783          	ld	a5,-1768(a5) # ffffffffc02958c0 <current>
ffffffffc0206fb0:	73d0                	ld	a2,160(a5)
ffffffffc0206fb2:	4501                	li	a0,0
ffffffffc0206fb4:	6a0c                	ld	a1,16(a2)
ffffffffc0206fb6:	a37fe06f          	j	ffffffffc02059ec <do_fork>

ffffffffc0206fba <sys_exit>:
ffffffffc0206fba:	4108                	lw	a0,0(a0)
ffffffffc0206fbc:	eb1fe06f          	j	ffffffffc0205e6c <do_exit>

ffffffffc0206fc0 <syscall>:
ffffffffc0206fc0:	715d                	addi	sp,sp,-80
ffffffffc0206fc2:	fc26                	sd	s1,56(sp)
ffffffffc0206fc4:	0008f497          	auipc	s1,0x8f
ffffffffc0206fc8:	8fc48493          	addi	s1,s1,-1796 # ffffffffc02958c0 <current>
ffffffffc0206fcc:	6098                	ld	a4,0(s1)
ffffffffc0206fce:	e0a2                	sd	s0,64(sp)
ffffffffc0206fd0:	f84a                	sd	s2,48(sp)
ffffffffc0206fd2:	7340                	ld	s0,160(a4)
ffffffffc0206fd4:	e486                	sd	ra,72(sp)
ffffffffc0206fd6:	0ff00793          	li	a5,255
ffffffffc0206fda:	05042903          	lw	s2,80(s0)
ffffffffc0206fde:	0327ee63          	bltu	a5,s2,ffffffffc020701a <syscall+0x5a>
ffffffffc0206fe2:	00391713          	slli	a4,s2,0x3
ffffffffc0206fe6:	00006797          	auipc	a5,0x6
ffffffffc0206fea:	fe278793          	addi	a5,a5,-30 # ffffffffc020cfc8 <syscalls>
ffffffffc0206fee:	97ba                	add	a5,a5,a4
ffffffffc0206ff0:	639c                	ld	a5,0(a5)
ffffffffc0206ff2:	c785                	beqz	a5,ffffffffc020701a <syscall+0x5a>
ffffffffc0206ff4:	6c28                	ld	a0,88(s0)
ffffffffc0206ff6:	702c                	ld	a1,96(s0)
ffffffffc0206ff8:	7430                	ld	a2,104(s0)
ffffffffc0206ffa:	7834                	ld	a3,112(s0)
ffffffffc0206ffc:	7c38                	ld	a4,120(s0)
ffffffffc0206ffe:	e42a                	sd	a0,8(sp)
ffffffffc0207000:	e82e                	sd	a1,16(sp)
ffffffffc0207002:	ec32                	sd	a2,24(sp)
ffffffffc0207004:	f036                	sd	a3,32(sp)
ffffffffc0207006:	f43a                	sd	a4,40(sp)
ffffffffc0207008:	0028                	addi	a0,sp,8
ffffffffc020700a:	9782                	jalr	a5
ffffffffc020700c:	60a6                	ld	ra,72(sp)
ffffffffc020700e:	e828                	sd	a0,80(s0)
ffffffffc0207010:	6406                	ld	s0,64(sp)
ffffffffc0207012:	74e2                	ld	s1,56(sp)
ffffffffc0207014:	7942                	ld	s2,48(sp)
ffffffffc0207016:	6161                	addi	sp,sp,80
ffffffffc0207018:	8082                	ret
ffffffffc020701a:	8522                	mv	a0,s0
ffffffffc020701c:	f6ff90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0207020:	609c                	ld	a5,0(s1)
ffffffffc0207022:	86ca                	mv	a3,s2
ffffffffc0207024:	00006617          	auipc	a2,0x6
ffffffffc0207028:	f5c60613          	addi	a2,a2,-164 # ffffffffc020cf80 <CSWTCH.79+0x5d8>
ffffffffc020702c:	43d8                	lw	a4,4(a5)
ffffffffc020702e:	0d800593          	li	a1,216
ffffffffc0207032:	0b478793          	addi	a5,a5,180
ffffffffc0207036:	00006517          	auipc	a0,0x6
ffffffffc020703a:	f7a50513          	addi	a0,a0,-134 # ffffffffc020cfb0 <CSWTCH.79+0x608>
ffffffffc020703e:	c60f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207042 <__alloc_inode>:
ffffffffc0207042:	1141                	addi	sp,sp,-16
ffffffffc0207044:	e022                	sd	s0,0(sp)
ffffffffc0207046:	842a                	mv	s0,a0
ffffffffc0207048:	07800513          	li	a0,120
ffffffffc020704c:	e406                	sd	ra,8(sp)
ffffffffc020704e:	f41fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207052:	c111                	beqz	a0,ffffffffc0207056 <__alloc_inode+0x14>
ffffffffc0207054:	cd20                	sw	s0,88(a0)
ffffffffc0207056:	60a2                	ld	ra,8(sp)
ffffffffc0207058:	6402                	ld	s0,0(sp)
ffffffffc020705a:	0141                	addi	sp,sp,16
ffffffffc020705c:	8082                	ret

ffffffffc020705e <inode_init>:
ffffffffc020705e:	4785                	li	a5,1
ffffffffc0207060:	06052023          	sw	zero,96(a0)
ffffffffc0207064:	f92c                	sd	a1,112(a0)
ffffffffc0207066:	f530                	sd	a2,104(a0)
ffffffffc0207068:	cd7c                	sw	a5,92(a0)
ffffffffc020706a:	8082                	ret

ffffffffc020706c <inode_kill>:
ffffffffc020706c:	4d78                	lw	a4,92(a0)
ffffffffc020706e:	1141                	addi	sp,sp,-16
ffffffffc0207070:	e406                	sd	ra,8(sp)
ffffffffc0207072:	e719                	bnez	a4,ffffffffc0207080 <inode_kill+0x14>
ffffffffc0207074:	513c                	lw	a5,96(a0)
ffffffffc0207076:	e78d                	bnez	a5,ffffffffc02070a0 <inode_kill+0x34>
ffffffffc0207078:	60a2                	ld	ra,8(sp)
ffffffffc020707a:	0141                	addi	sp,sp,16
ffffffffc020707c:	fc3fa06f          	j	ffffffffc020203e <kfree>
ffffffffc0207080:	00006697          	auipc	a3,0x6
ffffffffc0207084:	74868693          	addi	a3,a3,1864 # ffffffffc020d7c8 <syscalls+0x800>
ffffffffc0207088:	00004617          	auipc	a2,0x4
ffffffffc020708c:	f2860613          	addi	a2,a2,-216 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207090:	02900593          	li	a1,41
ffffffffc0207094:	00006517          	auipc	a0,0x6
ffffffffc0207098:	75450513          	addi	a0,a0,1876 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc020709c:	c02f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02070a0:	00006697          	auipc	a3,0x6
ffffffffc02070a4:	76068693          	addi	a3,a3,1888 # ffffffffc020d800 <syscalls+0x838>
ffffffffc02070a8:	00004617          	auipc	a2,0x4
ffffffffc02070ac:	f0860613          	addi	a2,a2,-248 # ffffffffc020afb0 <commands+0x210>
ffffffffc02070b0:	02a00593          	li	a1,42
ffffffffc02070b4:	00006517          	auipc	a0,0x6
ffffffffc02070b8:	73450513          	addi	a0,a0,1844 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc02070bc:	be2f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02070c0 <inode_ref_inc>:
ffffffffc02070c0:	4d7c                	lw	a5,92(a0)
ffffffffc02070c2:	2785                	addiw	a5,a5,1
ffffffffc02070c4:	cd7c                	sw	a5,92(a0)
ffffffffc02070c6:	0007851b          	sext.w	a0,a5
ffffffffc02070ca:	8082                	ret

ffffffffc02070cc <inode_open_inc>:
ffffffffc02070cc:	513c                	lw	a5,96(a0)
ffffffffc02070ce:	2785                	addiw	a5,a5,1
ffffffffc02070d0:	d13c                	sw	a5,96(a0)
ffffffffc02070d2:	0007851b          	sext.w	a0,a5
ffffffffc02070d6:	8082                	ret

ffffffffc02070d8 <inode_check>:
ffffffffc02070d8:	1141                	addi	sp,sp,-16
ffffffffc02070da:	e406                	sd	ra,8(sp)
ffffffffc02070dc:	c90d                	beqz	a0,ffffffffc020710e <inode_check+0x36>
ffffffffc02070de:	793c                	ld	a5,112(a0)
ffffffffc02070e0:	c79d                	beqz	a5,ffffffffc020710e <inode_check+0x36>
ffffffffc02070e2:	6398                	ld	a4,0(a5)
ffffffffc02070e4:	4625d7b7          	lui	a5,0x4625d
ffffffffc02070e8:	0786                	slli	a5,a5,0x1
ffffffffc02070ea:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc02070ee:	08f71063          	bne	a4,a5,ffffffffc020716e <inode_check+0x96>
ffffffffc02070f2:	4d78                	lw	a4,92(a0)
ffffffffc02070f4:	513c                	lw	a5,96(a0)
ffffffffc02070f6:	04f74c63          	blt	a4,a5,ffffffffc020714e <inode_check+0x76>
ffffffffc02070fa:	0407ca63          	bltz	a5,ffffffffc020714e <inode_check+0x76>
ffffffffc02070fe:	66c1                	lui	a3,0x10
ffffffffc0207100:	02d75763          	bge	a4,a3,ffffffffc020712e <inode_check+0x56>
ffffffffc0207104:	02d7d563          	bge	a5,a3,ffffffffc020712e <inode_check+0x56>
ffffffffc0207108:	60a2                	ld	ra,8(sp)
ffffffffc020710a:	0141                	addi	sp,sp,16
ffffffffc020710c:	8082                	ret
ffffffffc020710e:	00006697          	auipc	a3,0x6
ffffffffc0207112:	71268693          	addi	a3,a3,1810 # ffffffffc020d820 <syscalls+0x858>
ffffffffc0207116:	00004617          	auipc	a2,0x4
ffffffffc020711a:	e9a60613          	addi	a2,a2,-358 # ffffffffc020afb0 <commands+0x210>
ffffffffc020711e:	06e00593          	li	a1,110
ffffffffc0207122:	00006517          	auipc	a0,0x6
ffffffffc0207126:	6c650513          	addi	a0,a0,1734 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc020712a:	b74f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020712e:	00006697          	auipc	a3,0x6
ffffffffc0207132:	77268693          	addi	a3,a3,1906 # ffffffffc020d8a0 <syscalls+0x8d8>
ffffffffc0207136:	00004617          	auipc	a2,0x4
ffffffffc020713a:	e7a60613          	addi	a2,a2,-390 # ffffffffc020afb0 <commands+0x210>
ffffffffc020713e:	07200593          	li	a1,114
ffffffffc0207142:	00006517          	auipc	a0,0x6
ffffffffc0207146:	6a650513          	addi	a0,a0,1702 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc020714a:	b54f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020714e:	00006697          	auipc	a3,0x6
ffffffffc0207152:	72268693          	addi	a3,a3,1826 # ffffffffc020d870 <syscalls+0x8a8>
ffffffffc0207156:	00004617          	auipc	a2,0x4
ffffffffc020715a:	e5a60613          	addi	a2,a2,-422 # ffffffffc020afb0 <commands+0x210>
ffffffffc020715e:	07100593          	li	a1,113
ffffffffc0207162:	00006517          	auipc	a0,0x6
ffffffffc0207166:	68650513          	addi	a0,a0,1670 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc020716a:	b34f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020716e:	00006697          	auipc	a3,0x6
ffffffffc0207172:	6da68693          	addi	a3,a3,1754 # ffffffffc020d848 <syscalls+0x880>
ffffffffc0207176:	00004617          	auipc	a2,0x4
ffffffffc020717a:	e3a60613          	addi	a2,a2,-454 # ffffffffc020afb0 <commands+0x210>
ffffffffc020717e:	06f00593          	li	a1,111
ffffffffc0207182:	00006517          	auipc	a0,0x6
ffffffffc0207186:	66650513          	addi	a0,a0,1638 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc020718a:	b14f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020718e <inode_ref_dec>:
ffffffffc020718e:	4d7c                	lw	a5,92(a0)
ffffffffc0207190:	1101                	addi	sp,sp,-32
ffffffffc0207192:	ec06                	sd	ra,24(sp)
ffffffffc0207194:	e822                	sd	s0,16(sp)
ffffffffc0207196:	e426                	sd	s1,8(sp)
ffffffffc0207198:	e04a                	sd	s2,0(sp)
ffffffffc020719a:	06f05e63          	blez	a5,ffffffffc0207216 <inode_ref_dec+0x88>
ffffffffc020719e:	fff7849b          	addiw	s1,a5,-1
ffffffffc02071a2:	cd64                	sw	s1,92(a0)
ffffffffc02071a4:	842a                	mv	s0,a0
ffffffffc02071a6:	e09d                	bnez	s1,ffffffffc02071cc <inode_ref_dec+0x3e>
ffffffffc02071a8:	793c                	ld	a5,112(a0)
ffffffffc02071aa:	c7b1                	beqz	a5,ffffffffc02071f6 <inode_ref_dec+0x68>
ffffffffc02071ac:	0487b903          	ld	s2,72(a5)
ffffffffc02071b0:	04090363          	beqz	s2,ffffffffc02071f6 <inode_ref_dec+0x68>
ffffffffc02071b4:	00006597          	auipc	a1,0x6
ffffffffc02071b8:	79c58593          	addi	a1,a1,1948 # ffffffffc020d950 <syscalls+0x988>
ffffffffc02071bc:	f1dff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc02071c0:	8522                	mv	a0,s0
ffffffffc02071c2:	9902                	jalr	s2
ffffffffc02071c4:	c501                	beqz	a0,ffffffffc02071cc <inode_ref_dec+0x3e>
ffffffffc02071c6:	57c5                	li	a5,-15
ffffffffc02071c8:	00f51963          	bne	a0,a5,ffffffffc02071da <inode_ref_dec+0x4c>
ffffffffc02071cc:	60e2                	ld	ra,24(sp)
ffffffffc02071ce:	6442                	ld	s0,16(sp)
ffffffffc02071d0:	6902                	ld	s2,0(sp)
ffffffffc02071d2:	8526                	mv	a0,s1
ffffffffc02071d4:	64a2                	ld	s1,8(sp)
ffffffffc02071d6:	6105                	addi	sp,sp,32
ffffffffc02071d8:	8082                	ret
ffffffffc02071da:	85aa                	mv	a1,a0
ffffffffc02071dc:	00006517          	auipc	a0,0x6
ffffffffc02071e0:	77c50513          	addi	a0,a0,1916 # ffffffffc020d958 <syscalls+0x990>
ffffffffc02071e4:	fc3f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02071e8:	60e2                	ld	ra,24(sp)
ffffffffc02071ea:	6442                	ld	s0,16(sp)
ffffffffc02071ec:	6902                	ld	s2,0(sp)
ffffffffc02071ee:	8526                	mv	a0,s1
ffffffffc02071f0:	64a2                	ld	s1,8(sp)
ffffffffc02071f2:	6105                	addi	sp,sp,32
ffffffffc02071f4:	8082                	ret
ffffffffc02071f6:	00006697          	auipc	a3,0x6
ffffffffc02071fa:	70a68693          	addi	a3,a3,1802 # ffffffffc020d900 <syscalls+0x938>
ffffffffc02071fe:	00004617          	auipc	a2,0x4
ffffffffc0207202:	db260613          	addi	a2,a2,-590 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207206:	04400593          	li	a1,68
ffffffffc020720a:	00006517          	auipc	a0,0x6
ffffffffc020720e:	5de50513          	addi	a0,a0,1502 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc0207212:	a8cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207216:	00006697          	auipc	a3,0x6
ffffffffc020721a:	6ca68693          	addi	a3,a3,1738 # ffffffffc020d8e0 <syscalls+0x918>
ffffffffc020721e:	00004617          	auipc	a2,0x4
ffffffffc0207222:	d9260613          	addi	a2,a2,-622 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207226:	03f00593          	li	a1,63
ffffffffc020722a:	00006517          	auipc	a0,0x6
ffffffffc020722e:	5be50513          	addi	a0,a0,1470 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc0207232:	a6cf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207236 <inode_open_dec>:
ffffffffc0207236:	513c                	lw	a5,96(a0)
ffffffffc0207238:	1101                	addi	sp,sp,-32
ffffffffc020723a:	ec06                	sd	ra,24(sp)
ffffffffc020723c:	e822                	sd	s0,16(sp)
ffffffffc020723e:	e426                	sd	s1,8(sp)
ffffffffc0207240:	e04a                	sd	s2,0(sp)
ffffffffc0207242:	06f05b63          	blez	a5,ffffffffc02072b8 <inode_open_dec+0x82>
ffffffffc0207246:	fff7849b          	addiw	s1,a5,-1
ffffffffc020724a:	d124                	sw	s1,96(a0)
ffffffffc020724c:	842a                	mv	s0,a0
ffffffffc020724e:	e085                	bnez	s1,ffffffffc020726e <inode_open_dec+0x38>
ffffffffc0207250:	793c                	ld	a5,112(a0)
ffffffffc0207252:	c3b9                	beqz	a5,ffffffffc0207298 <inode_open_dec+0x62>
ffffffffc0207254:	0107b903          	ld	s2,16(a5)
ffffffffc0207258:	04090063          	beqz	s2,ffffffffc0207298 <inode_open_dec+0x62>
ffffffffc020725c:	00006597          	auipc	a1,0x6
ffffffffc0207260:	78c58593          	addi	a1,a1,1932 # ffffffffc020d9e8 <syscalls+0xa20>
ffffffffc0207264:	e75ff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0207268:	8522                	mv	a0,s0
ffffffffc020726a:	9902                	jalr	s2
ffffffffc020726c:	e901                	bnez	a0,ffffffffc020727c <inode_open_dec+0x46>
ffffffffc020726e:	60e2                	ld	ra,24(sp)
ffffffffc0207270:	6442                	ld	s0,16(sp)
ffffffffc0207272:	6902                	ld	s2,0(sp)
ffffffffc0207274:	8526                	mv	a0,s1
ffffffffc0207276:	64a2                	ld	s1,8(sp)
ffffffffc0207278:	6105                	addi	sp,sp,32
ffffffffc020727a:	8082                	ret
ffffffffc020727c:	85aa                	mv	a1,a0
ffffffffc020727e:	00006517          	auipc	a0,0x6
ffffffffc0207282:	77250513          	addi	a0,a0,1906 # ffffffffc020d9f0 <syscalls+0xa28>
ffffffffc0207286:	f21f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020728a:	60e2                	ld	ra,24(sp)
ffffffffc020728c:	6442                	ld	s0,16(sp)
ffffffffc020728e:	6902                	ld	s2,0(sp)
ffffffffc0207290:	8526                	mv	a0,s1
ffffffffc0207292:	64a2                	ld	s1,8(sp)
ffffffffc0207294:	6105                	addi	sp,sp,32
ffffffffc0207296:	8082                	ret
ffffffffc0207298:	00006697          	auipc	a3,0x6
ffffffffc020729c:	70068693          	addi	a3,a3,1792 # ffffffffc020d998 <syscalls+0x9d0>
ffffffffc02072a0:	00004617          	auipc	a2,0x4
ffffffffc02072a4:	d1060613          	addi	a2,a2,-752 # ffffffffc020afb0 <commands+0x210>
ffffffffc02072a8:	06100593          	li	a1,97
ffffffffc02072ac:	00006517          	auipc	a0,0x6
ffffffffc02072b0:	53c50513          	addi	a0,a0,1340 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc02072b4:	9eaf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02072b8:	00006697          	auipc	a3,0x6
ffffffffc02072bc:	6c068693          	addi	a3,a3,1728 # ffffffffc020d978 <syscalls+0x9b0>
ffffffffc02072c0:	00004617          	auipc	a2,0x4
ffffffffc02072c4:	cf060613          	addi	a2,a2,-784 # ffffffffc020afb0 <commands+0x210>
ffffffffc02072c8:	05c00593          	li	a1,92
ffffffffc02072cc:	00006517          	auipc	a0,0x6
ffffffffc02072d0:	51c50513          	addi	a0,a0,1308 # ffffffffc020d7e8 <syscalls+0x820>
ffffffffc02072d4:	9caf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02072d8 <__alloc_fs>:
ffffffffc02072d8:	1141                	addi	sp,sp,-16
ffffffffc02072da:	e022                	sd	s0,0(sp)
ffffffffc02072dc:	842a                	mv	s0,a0
ffffffffc02072de:	0d800513          	li	a0,216
ffffffffc02072e2:	e406                	sd	ra,8(sp)
ffffffffc02072e4:	cabfa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02072e8:	c119                	beqz	a0,ffffffffc02072ee <__alloc_fs+0x16>
ffffffffc02072ea:	0a852823          	sw	s0,176(a0)
ffffffffc02072ee:	60a2                	ld	ra,8(sp)
ffffffffc02072f0:	6402                	ld	s0,0(sp)
ffffffffc02072f2:	0141                	addi	sp,sp,16
ffffffffc02072f4:	8082                	ret

ffffffffc02072f6 <vfs_init>:
ffffffffc02072f6:	1141                	addi	sp,sp,-16
ffffffffc02072f8:	4585                	li	a1,1
ffffffffc02072fa:	0008d517          	auipc	a0,0x8d
ffffffffc02072fe:	50650513          	addi	a0,a0,1286 # ffffffffc0294800 <bootfs_sem>
ffffffffc0207302:	e406                	sd	ra,8(sp)
ffffffffc0207304:	8e4fd0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0207308:	60a2                	ld	ra,8(sp)
ffffffffc020730a:	0141                	addi	sp,sp,16
ffffffffc020730c:	a40d                	j	ffffffffc020752e <vfs_devlist_init>

ffffffffc020730e <vfs_set_bootfs>:
ffffffffc020730e:	7179                	addi	sp,sp,-48
ffffffffc0207310:	f022                	sd	s0,32(sp)
ffffffffc0207312:	f406                	sd	ra,40(sp)
ffffffffc0207314:	ec26                	sd	s1,24(sp)
ffffffffc0207316:	e402                	sd	zero,8(sp)
ffffffffc0207318:	842a                	mv	s0,a0
ffffffffc020731a:	c915                	beqz	a0,ffffffffc020734e <vfs_set_bootfs+0x40>
ffffffffc020731c:	03a00593          	li	a1,58
ffffffffc0207320:	798030ef          	jal	ra,ffffffffc020aab8 <strchr>
ffffffffc0207324:	c135                	beqz	a0,ffffffffc0207388 <vfs_set_bootfs+0x7a>
ffffffffc0207326:	00154783          	lbu	a5,1(a0)
ffffffffc020732a:	efb9                	bnez	a5,ffffffffc0207388 <vfs_set_bootfs+0x7a>
ffffffffc020732c:	8522                	mv	a0,s0
ffffffffc020732e:	11f000ef          	jal	ra,ffffffffc0207c4c <vfs_chdir>
ffffffffc0207332:	842a                	mv	s0,a0
ffffffffc0207334:	c519                	beqz	a0,ffffffffc0207342 <vfs_set_bootfs+0x34>
ffffffffc0207336:	70a2                	ld	ra,40(sp)
ffffffffc0207338:	8522                	mv	a0,s0
ffffffffc020733a:	7402                	ld	s0,32(sp)
ffffffffc020733c:	64e2                	ld	s1,24(sp)
ffffffffc020733e:	6145                	addi	sp,sp,48
ffffffffc0207340:	8082                	ret
ffffffffc0207342:	0028                	addi	a0,sp,8
ffffffffc0207344:	013000ef          	jal	ra,ffffffffc0207b56 <vfs_get_curdir>
ffffffffc0207348:	842a                	mv	s0,a0
ffffffffc020734a:	f575                	bnez	a0,ffffffffc0207336 <vfs_set_bootfs+0x28>
ffffffffc020734c:	6422                	ld	s0,8(sp)
ffffffffc020734e:	0008d517          	auipc	a0,0x8d
ffffffffc0207352:	4b250513          	addi	a0,a0,1202 # ffffffffc0294800 <bootfs_sem>
ffffffffc0207356:	89cfd0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc020735a:	0008e797          	auipc	a5,0x8e
ffffffffc020735e:	59678793          	addi	a5,a5,1430 # ffffffffc02958f0 <bootfs_node>
ffffffffc0207362:	6384                	ld	s1,0(a5)
ffffffffc0207364:	0008d517          	auipc	a0,0x8d
ffffffffc0207368:	49c50513          	addi	a0,a0,1180 # ffffffffc0294800 <bootfs_sem>
ffffffffc020736c:	e380                	sd	s0,0(a5)
ffffffffc020736e:	4401                	li	s0,0
ffffffffc0207370:	87efd0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0207374:	d0e9                	beqz	s1,ffffffffc0207336 <vfs_set_bootfs+0x28>
ffffffffc0207376:	8526                	mv	a0,s1
ffffffffc0207378:	e17ff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020737c:	70a2                	ld	ra,40(sp)
ffffffffc020737e:	8522                	mv	a0,s0
ffffffffc0207380:	7402                	ld	s0,32(sp)
ffffffffc0207382:	64e2                	ld	s1,24(sp)
ffffffffc0207384:	6145                	addi	sp,sp,48
ffffffffc0207386:	8082                	ret
ffffffffc0207388:	5475                	li	s0,-3
ffffffffc020738a:	b775                	j	ffffffffc0207336 <vfs_set_bootfs+0x28>

ffffffffc020738c <vfs_get_bootfs>:
ffffffffc020738c:	1101                	addi	sp,sp,-32
ffffffffc020738e:	e426                	sd	s1,8(sp)
ffffffffc0207390:	0008e497          	auipc	s1,0x8e
ffffffffc0207394:	56048493          	addi	s1,s1,1376 # ffffffffc02958f0 <bootfs_node>
ffffffffc0207398:	609c                	ld	a5,0(s1)
ffffffffc020739a:	ec06                	sd	ra,24(sp)
ffffffffc020739c:	e822                	sd	s0,16(sp)
ffffffffc020739e:	c3a1                	beqz	a5,ffffffffc02073de <vfs_get_bootfs+0x52>
ffffffffc02073a0:	842a                	mv	s0,a0
ffffffffc02073a2:	0008d517          	auipc	a0,0x8d
ffffffffc02073a6:	45e50513          	addi	a0,a0,1118 # ffffffffc0294800 <bootfs_sem>
ffffffffc02073aa:	848fd0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02073ae:	6084                	ld	s1,0(s1)
ffffffffc02073b0:	c08d                	beqz	s1,ffffffffc02073d2 <vfs_get_bootfs+0x46>
ffffffffc02073b2:	8526                	mv	a0,s1
ffffffffc02073b4:	d0dff0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc02073b8:	0008d517          	auipc	a0,0x8d
ffffffffc02073bc:	44850513          	addi	a0,a0,1096 # ffffffffc0294800 <bootfs_sem>
ffffffffc02073c0:	82efd0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02073c4:	4501                	li	a0,0
ffffffffc02073c6:	e004                	sd	s1,0(s0)
ffffffffc02073c8:	60e2                	ld	ra,24(sp)
ffffffffc02073ca:	6442                	ld	s0,16(sp)
ffffffffc02073cc:	64a2                	ld	s1,8(sp)
ffffffffc02073ce:	6105                	addi	sp,sp,32
ffffffffc02073d0:	8082                	ret
ffffffffc02073d2:	0008d517          	auipc	a0,0x8d
ffffffffc02073d6:	42e50513          	addi	a0,a0,1070 # ffffffffc0294800 <bootfs_sem>
ffffffffc02073da:	814fd0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02073de:	5541                	li	a0,-16
ffffffffc02073e0:	b7e5                	j	ffffffffc02073c8 <vfs_get_bootfs+0x3c>

ffffffffc02073e2 <vfs_do_add>:
ffffffffc02073e2:	7139                	addi	sp,sp,-64
ffffffffc02073e4:	fc06                	sd	ra,56(sp)
ffffffffc02073e6:	f822                	sd	s0,48(sp)
ffffffffc02073e8:	f426                	sd	s1,40(sp)
ffffffffc02073ea:	f04a                	sd	s2,32(sp)
ffffffffc02073ec:	ec4e                	sd	s3,24(sp)
ffffffffc02073ee:	e852                	sd	s4,16(sp)
ffffffffc02073f0:	e456                	sd	s5,8(sp)
ffffffffc02073f2:	e05a                	sd	s6,0(sp)
ffffffffc02073f4:	0e050b63          	beqz	a0,ffffffffc02074ea <vfs_do_add+0x108>
ffffffffc02073f8:	842a                	mv	s0,a0
ffffffffc02073fa:	8a2e                	mv	s4,a1
ffffffffc02073fc:	8b32                	mv	s6,a2
ffffffffc02073fe:	8ab6                	mv	s5,a3
ffffffffc0207400:	c5cd                	beqz	a1,ffffffffc02074aa <vfs_do_add+0xc8>
ffffffffc0207402:	4db8                	lw	a4,88(a1)
ffffffffc0207404:	6785                	lui	a5,0x1
ffffffffc0207406:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020740a:	0af71163          	bne	a4,a5,ffffffffc02074ac <vfs_do_add+0xca>
ffffffffc020740e:	8522                	mv	a0,s0
ffffffffc0207410:	61c030ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc0207414:	47fd                	li	a5,31
ffffffffc0207416:	0ca7e663          	bltu	a5,a0,ffffffffc02074e2 <vfs_do_add+0x100>
ffffffffc020741a:	8522                	mv	a0,s0
ffffffffc020741c:	dd9f80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207420:	84aa                	mv	s1,a0
ffffffffc0207422:	c171                	beqz	a0,ffffffffc02074e6 <vfs_do_add+0x104>
ffffffffc0207424:	03000513          	li	a0,48
ffffffffc0207428:	b67fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020742c:	89aa                	mv	s3,a0
ffffffffc020742e:	c92d                	beqz	a0,ffffffffc02074a0 <vfs_do_add+0xbe>
ffffffffc0207430:	0008d517          	auipc	a0,0x8d
ffffffffc0207434:	3f850513          	addi	a0,a0,1016 # ffffffffc0294828 <vdev_list_sem>
ffffffffc0207438:	0008d917          	auipc	s2,0x8d
ffffffffc020743c:	3e090913          	addi	s2,s2,992 # ffffffffc0294818 <vdev_list>
ffffffffc0207440:	fb3fc0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0207444:	844a                	mv	s0,s2
ffffffffc0207446:	a039                	j	ffffffffc0207454 <vfs_do_add+0x72>
ffffffffc0207448:	fe043503          	ld	a0,-32(s0)
ffffffffc020744c:	85a6                	mv	a1,s1
ffffffffc020744e:	626030ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc0207452:	cd2d                	beqz	a0,ffffffffc02074cc <vfs_do_add+0xea>
ffffffffc0207454:	6400                	ld	s0,8(s0)
ffffffffc0207456:	ff2419e3          	bne	s0,s2,ffffffffc0207448 <vfs_do_add+0x66>
ffffffffc020745a:	6418                	ld	a4,8(s0)
ffffffffc020745c:	02098793          	addi	a5,s3,32
ffffffffc0207460:	0099b023          	sd	s1,0(s3)
ffffffffc0207464:	0149b423          	sd	s4,8(s3)
ffffffffc0207468:	0159bc23          	sd	s5,24(s3)
ffffffffc020746c:	0169b823          	sd	s6,16(s3)
ffffffffc0207470:	e31c                	sd	a5,0(a4)
ffffffffc0207472:	0289b023          	sd	s0,32(s3)
ffffffffc0207476:	02e9b423          	sd	a4,40(s3)
ffffffffc020747a:	0008d517          	auipc	a0,0x8d
ffffffffc020747e:	3ae50513          	addi	a0,a0,942 # ffffffffc0294828 <vdev_list_sem>
ffffffffc0207482:	e41c                	sd	a5,8(s0)
ffffffffc0207484:	4401                	li	s0,0
ffffffffc0207486:	f69fc0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020748a:	70e2                	ld	ra,56(sp)
ffffffffc020748c:	8522                	mv	a0,s0
ffffffffc020748e:	7442                	ld	s0,48(sp)
ffffffffc0207490:	74a2                	ld	s1,40(sp)
ffffffffc0207492:	7902                	ld	s2,32(sp)
ffffffffc0207494:	69e2                	ld	s3,24(sp)
ffffffffc0207496:	6a42                	ld	s4,16(sp)
ffffffffc0207498:	6aa2                	ld	s5,8(sp)
ffffffffc020749a:	6b02                	ld	s6,0(sp)
ffffffffc020749c:	6121                	addi	sp,sp,64
ffffffffc020749e:	8082                	ret
ffffffffc02074a0:	5471                	li	s0,-4
ffffffffc02074a2:	8526                	mv	a0,s1
ffffffffc02074a4:	b9bfa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02074a8:	b7cd                	j	ffffffffc020748a <vfs_do_add+0xa8>
ffffffffc02074aa:	d2b5                	beqz	a3,ffffffffc020740e <vfs_do_add+0x2c>
ffffffffc02074ac:	00006697          	auipc	a3,0x6
ffffffffc02074b0:	58c68693          	addi	a3,a3,1420 # ffffffffc020da38 <syscalls+0xa70>
ffffffffc02074b4:	00004617          	auipc	a2,0x4
ffffffffc02074b8:	afc60613          	addi	a2,a2,-1284 # ffffffffc020afb0 <commands+0x210>
ffffffffc02074bc:	08f00593          	li	a1,143
ffffffffc02074c0:	00006517          	auipc	a0,0x6
ffffffffc02074c4:	56050513          	addi	a0,a0,1376 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc02074c8:	fd7f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02074cc:	0008d517          	auipc	a0,0x8d
ffffffffc02074d0:	35c50513          	addi	a0,a0,860 # ffffffffc0294828 <vdev_list_sem>
ffffffffc02074d4:	f1bfc0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02074d8:	854e                	mv	a0,s3
ffffffffc02074da:	b65fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02074de:	5425                	li	s0,-23
ffffffffc02074e0:	b7c9                	j	ffffffffc02074a2 <vfs_do_add+0xc0>
ffffffffc02074e2:	5451                	li	s0,-12
ffffffffc02074e4:	b75d                	j	ffffffffc020748a <vfs_do_add+0xa8>
ffffffffc02074e6:	5471                	li	s0,-4
ffffffffc02074e8:	b74d                	j	ffffffffc020748a <vfs_do_add+0xa8>
ffffffffc02074ea:	00006697          	auipc	a3,0x6
ffffffffc02074ee:	52668693          	addi	a3,a3,1318 # ffffffffc020da10 <syscalls+0xa48>
ffffffffc02074f2:	00004617          	auipc	a2,0x4
ffffffffc02074f6:	abe60613          	addi	a2,a2,-1346 # ffffffffc020afb0 <commands+0x210>
ffffffffc02074fa:	08e00593          	li	a1,142
ffffffffc02074fe:	00006517          	auipc	a0,0x6
ffffffffc0207502:	52250513          	addi	a0,a0,1314 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc0207506:	f99f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020750a <find_mount.part.0>:
ffffffffc020750a:	1141                	addi	sp,sp,-16
ffffffffc020750c:	00006697          	auipc	a3,0x6
ffffffffc0207510:	50468693          	addi	a3,a3,1284 # ffffffffc020da10 <syscalls+0xa48>
ffffffffc0207514:	00004617          	auipc	a2,0x4
ffffffffc0207518:	a9c60613          	addi	a2,a2,-1380 # ffffffffc020afb0 <commands+0x210>
ffffffffc020751c:	0cd00593          	li	a1,205
ffffffffc0207520:	00006517          	auipc	a0,0x6
ffffffffc0207524:	50050513          	addi	a0,a0,1280 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc0207528:	e406                	sd	ra,8(sp)
ffffffffc020752a:	f75f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020752e <vfs_devlist_init>:
ffffffffc020752e:	0008d797          	auipc	a5,0x8d
ffffffffc0207532:	2ea78793          	addi	a5,a5,746 # ffffffffc0294818 <vdev_list>
ffffffffc0207536:	4585                	li	a1,1
ffffffffc0207538:	0008d517          	auipc	a0,0x8d
ffffffffc020753c:	2f050513          	addi	a0,a0,752 # ffffffffc0294828 <vdev_list_sem>
ffffffffc0207540:	e79c                	sd	a5,8(a5)
ffffffffc0207542:	e39c                	sd	a5,0(a5)
ffffffffc0207544:	ea5fc06f          	j	ffffffffc02043e8 <sem_init>

ffffffffc0207548 <vfs_cleanup>:
ffffffffc0207548:	1101                	addi	sp,sp,-32
ffffffffc020754a:	e426                	sd	s1,8(sp)
ffffffffc020754c:	0008d497          	auipc	s1,0x8d
ffffffffc0207550:	2cc48493          	addi	s1,s1,716 # ffffffffc0294818 <vdev_list>
ffffffffc0207554:	649c                	ld	a5,8(s1)
ffffffffc0207556:	ec06                	sd	ra,24(sp)
ffffffffc0207558:	e822                	sd	s0,16(sp)
ffffffffc020755a:	02978e63          	beq	a5,s1,ffffffffc0207596 <vfs_cleanup+0x4e>
ffffffffc020755e:	0008d517          	auipc	a0,0x8d
ffffffffc0207562:	2ca50513          	addi	a0,a0,714 # ffffffffc0294828 <vdev_list_sem>
ffffffffc0207566:	e8dfc0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc020756a:	6480                	ld	s0,8(s1)
ffffffffc020756c:	00940b63          	beq	s0,s1,ffffffffc0207582 <vfs_cleanup+0x3a>
ffffffffc0207570:	ff043783          	ld	a5,-16(s0)
ffffffffc0207574:	853e                	mv	a0,a5
ffffffffc0207576:	c399                	beqz	a5,ffffffffc020757c <vfs_cleanup+0x34>
ffffffffc0207578:	6bfc                	ld	a5,208(a5)
ffffffffc020757a:	9782                	jalr	a5
ffffffffc020757c:	6400                	ld	s0,8(s0)
ffffffffc020757e:	fe9419e3          	bne	s0,s1,ffffffffc0207570 <vfs_cleanup+0x28>
ffffffffc0207582:	6442                	ld	s0,16(sp)
ffffffffc0207584:	60e2                	ld	ra,24(sp)
ffffffffc0207586:	64a2                	ld	s1,8(sp)
ffffffffc0207588:	0008d517          	auipc	a0,0x8d
ffffffffc020758c:	2a050513          	addi	a0,a0,672 # ffffffffc0294828 <vdev_list_sem>
ffffffffc0207590:	6105                	addi	sp,sp,32
ffffffffc0207592:	e5dfc06f          	j	ffffffffc02043ee <up>
ffffffffc0207596:	60e2                	ld	ra,24(sp)
ffffffffc0207598:	6442                	ld	s0,16(sp)
ffffffffc020759a:	64a2                	ld	s1,8(sp)
ffffffffc020759c:	6105                	addi	sp,sp,32
ffffffffc020759e:	8082                	ret

ffffffffc02075a0 <vfs_get_root>:
ffffffffc02075a0:	7179                	addi	sp,sp,-48
ffffffffc02075a2:	f406                	sd	ra,40(sp)
ffffffffc02075a4:	f022                	sd	s0,32(sp)
ffffffffc02075a6:	ec26                	sd	s1,24(sp)
ffffffffc02075a8:	e84a                	sd	s2,16(sp)
ffffffffc02075aa:	e44e                	sd	s3,8(sp)
ffffffffc02075ac:	e052                	sd	s4,0(sp)
ffffffffc02075ae:	c541                	beqz	a0,ffffffffc0207636 <vfs_get_root+0x96>
ffffffffc02075b0:	0008d917          	auipc	s2,0x8d
ffffffffc02075b4:	26890913          	addi	s2,s2,616 # ffffffffc0294818 <vdev_list>
ffffffffc02075b8:	00893783          	ld	a5,8(s2)
ffffffffc02075bc:	07278b63          	beq	a5,s2,ffffffffc0207632 <vfs_get_root+0x92>
ffffffffc02075c0:	89aa                	mv	s3,a0
ffffffffc02075c2:	0008d517          	auipc	a0,0x8d
ffffffffc02075c6:	26650513          	addi	a0,a0,614 # ffffffffc0294828 <vdev_list_sem>
ffffffffc02075ca:	8a2e                	mv	s4,a1
ffffffffc02075cc:	844a                	mv	s0,s2
ffffffffc02075ce:	e25fc0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02075d2:	a801                	j	ffffffffc02075e2 <vfs_get_root+0x42>
ffffffffc02075d4:	fe043583          	ld	a1,-32(s0)
ffffffffc02075d8:	854e                	mv	a0,s3
ffffffffc02075da:	49a030ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc02075de:	84aa                	mv	s1,a0
ffffffffc02075e0:	c505                	beqz	a0,ffffffffc0207608 <vfs_get_root+0x68>
ffffffffc02075e2:	6400                	ld	s0,8(s0)
ffffffffc02075e4:	ff2418e3          	bne	s0,s2,ffffffffc02075d4 <vfs_get_root+0x34>
ffffffffc02075e8:	54cd                	li	s1,-13
ffffffffc02075ea:	0008d517          	auipc	a0,0x8d
ffffffffc02075ee:	23e50513          	addi	a0,a0,574 # ffffffffc0294828 <vdev_list_sem>
ffffffffc02075f2:	dfdfc0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02075f6:	70a2                	ld	ra,40(sp)
ffffffffc02075f8:	7402                	ld	s0,32(sp)
ffffffffc02075fa:	6942                	ld	s2,16(sp)
ffffffffc02075fc:	69a2                	ld	s3,8(sp)
ffffffffc02075fe:	6a02                	ld	s4,0(sp)
ffffffffc0207600:	8526                	mv	a0,s1
ffffffffc0207602:	64e2                	ld	s1,24(sp)
ffffffffc0207604:	6145                	addi	sp,sp,48
ffffffffc0207606:	8082                	ret
ffffffffc0207608:	ff043503          	ld	a0,-16(s0)
ffffffffc020760c:	c519                	beqz	a0,ffffffffc020761a <vfs_get_root+0x7a>
ffffffffc020760e:	617c                	ld	a5,192(a0)
ffffffffc0207610:	9782                	jalr	a5
ffffffffc0207612:	c519                	beqz	a0,ffffffffc0207620 <vfs_get_root+0x80>
ffffffffc0207614:	00aa3023          	sd	a0,0(s4)
ffffffffc0207618:	bfc9                	j	ffffffffc02075ea <vfs_get_root+0x4a>
ffffffffc020761a:	ff843783          	ld	a5,-8(s0)
ffffffffc020761e:	c399                	beqz	a5,ffffffffc0207624 <vfs_get_root+0x84>
ffffffffc0207620:	54c9                	li	s1,-14
ffffffffc0207622:	b7e1                	j	ffffffffc02075ea <vfs_get_root+0x4a>
ffffffffc0207624:	fe843503          	ld	a0,-24(s0)
ffffffffc0207628:	a99ff0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc020762c:	fe843503          	ld	a0,-24(s0)
ffffffffc0207630:	b7cd                	j	ffffffffc0207612 <vfs_get_root+0x72>
ffffffffc0207632:	54cd                	li	s1,-13
ffffffffc0207634:	b7c9                	j	ffffffffc02075f6 <vfs_get_root+0x56>
ffffffffc0207636:	00006697          	auipc	a3,0x6
ffffffffc020763a:	3da68693          	addi	a3,a3,986 # ffffffffc020da10 <syscalls+0xa48>
ffffffffc020763e:	00004617          	auipc	a2,0x4
ffffffffc0207642:	97260613          	addi	a2,a2,-1678 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207646:	04500593          	li	a1,69
ffffffffc020764a:	00006517          	auipc	a0,0x6
ffffffffc020764e:	3d650513          	addi	a0,a0,982 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc0207652:	e4df80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207656 <vfs_get_devname>:
ffffffffc0207656:	0008d697          	auipc	a3,0x8d
ffffffffc020765a:	1c268693          	addi	a3,a3,450 # ffffffffc0294818 <vdev_list>
ffffffffc020765e:	87b6                	mv	a5,a3
ffffffffc0207660:	e511                	bnez	a0,ffffffffc020766c <vfs_get_devname+0x16>
ffffffffc0207662:	a829                	j	ffffffffc020767c <vfs_get_devname+0x26>
ffffffffc0207664:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207668:	00a70763          	beq	a4,a0,ffffffffc0207676 <vfs_get_devname+0x20>
ffffffffc020766c:	679c                	ld	a5,8(a5)
ffffffffc020766e:	fed79be3          	bne	a5,a3,ffffffffc0207664 <vfs_get_devname+0xe>
ffffffffc0207672:	4501                	li	a0,0
ffffffffc0207674:	8082                	ret
ffffffffc0207676:	fe07b503          	ld	a0,-32(a5)
ffffffffc020767a:	8082                	ret
ffffffffc020767c:	1141                	addi	sp,sp,-16
ffffffffc020767e:	00006697          	auipc	a3,0x6
ffffffffc0207682:	41a68693          	addi	a3,a3,1050 # ffffffffc020da98 <syscalls+0xad0>
ffffffffc0207686:	00004617          	auipc	a2,0x4
ffffffffc020768a:	92a60613          	addi	a2,a2,-1750 # ffffffffc020afb0 <commands+0x210>
ffffffffc020768e:	06a00593          	li	a1,106
ffffffffc0207692:	00006517          	auipc	a0,0x6
ffffffffc0207696:	38e50513          	addi	a0,a0,910 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc020769a:	e406                	sd	ra,8(sp)
ffffffffc020769c:	e03f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076a0 <vfs_add_dev>:
ffffffffc02076a0:	86b2                	mv	a3,a2
ffffffffc02076a2:	4601                	li	a2,0
ffffffffc02076a4:	d3fff06f          	j	ffffffffc02073e2 <vfs_do_add>

ffffffffc02076a8 <vfs_mount>:
ffffffffc02076a8:	7179                	addi	sp,sp,-48
ffffffffc02076aa:	e84a                	sd	s2,16(sp)
ffffffffc02076ac:	892a                	mv	s2,a0
ffffffffc02076ae:	0008d517          	auipc	a0,0x8d
ffffffffc02076b2:	17a50513          	addi	a0,a0,378 # ffffffffc0294828 <vdev_list_sem>
ffffffffc02076b6:	e44e                	sd	s3,8(sp)
ffffffffc02076b8:	f406                	sd	ra,40(sp)
ffffffffc02076ba:	f022                	sd	s0,32(sp)
ffffffffc02076bc:	ec26                	sd	s1,24(sp)
ffffffffc02076be:	89ae                	mv	s3,a1
ffffffffc02076c0:	d33fc0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02076c4:	08090a63          	beqz	s2,ffffffffc0207758 <vfs_mount+0xb0>
ffffffffc02076c8:	0008d497          	auipc	s1,0x8d
ffffffffc02076cc:	15048493          	addi	s1,s1,336 # ffffffffc0294818 <vdev_list>
ffffffffc02076d0:	6480                	ld	s0,8(s1)
ffffffffc02076d2:	00941663          	bne	s0,s1,ffffffffc02076de <vfs_mount+0x36>
ffffffffc02076d6:	a8ad                	j	ffffffffc0207750 <vfs_mount+0xa8>
ffffffffc02076d8:	6400                	ld	s0,8(s0)
ffffffffc02076da:	06940b63          	beq	s0,s1,ffffffffc0207750 <vfs_mount+0xa8>
ffffffffc02076de:	ff843783          	ld	a5,-8(s0)
ffffffffc02076e2:	dbfd                	beqz	a5,ffffffffc02076d8 <vfs_mount+0x30>
ffffffffc02076e4:	fe043503          	ld	a0,-32(s0)
ffffffffc02076e8:	85ca                	mv	a1,s2
ffffffffc02076ea:	38a030ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc02076ee:	f56d                	bnez	a0,ffffffffc02076d8 <vfs_mount+0x30>
ffffffffc02076f0:	ff043783          	ld	a5,-16(s0)
ffffffffc02076f4:	e3a5                	bnez	a5,ffffffffc0207754 <vfs_mount+0xac>
ffffffffc02076f6:	fe043783          	ld	a5,-32(s0)
ffffffffc02076fa:	c3c9                	beqz	a5,ffffffffc020777c <vfs_mount+0xd4>
ffffffffc02076fc:	ff843783          	ld	a5,-8(s0)
ffffffffc0207700:	cfb5                	beqz	a5,ffffffffc020777c <vfs_mount+0xd4>
ffffffffc0207702:	fe843503          	ld	a0,-24(s0)
ffffffffc0207706:	c939                	beqz	a0,ffffffffc020775c <vfs_mount+0xb4>
ffffffffc0207708:	4d38                	lw	a4,88(a0)
ffffffffc020770a:	6785                	lui	a5,0x1
ffffffffc020770c:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207710:	04f71663          	bne	a4,a5,ffffffffc020775c <vfs_mount+0xb4>
ffffffffc0207714:	ff040593          	addi	a1,s0,-16
ffffffffc0207718:	9982                	jalr	s3
ffffffffc020771a:	84aa                	mv	s1,a0
ffffffffc020771c:	ed01                	bnez	a0,ffffffffc0207734 <vfs_mount+0x8c>
ffffffffc020771e:	ff043783          	ld	a5,-16(s0)
ffffffffc0207722:	cfad                	beqz	a5,ffffffffc020779c <vfs_mount+0xf4>
ffffffffc0207724:	fe043583          	ld	a1,-32(s0)
ffffffffc0207728:	00006517          	auipc	a0,0x6
ffffffffc020772c:	40050513          	addi	a0,a0,1024 # ffffffffc020db28 <syscalls+0xb60>
ffffffffc0207730:	a77f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207734:	0008d517          	auipc	a0,0x8d
ffffffffc0207738:	0f450513          	addi	a0,a0,244 # ffffffffc0294828 <vdev_list_sem>
ffffffffc020773c:	cb3fc0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0207740:	70a2                	ld	ra,40(sp)
ffffffffc0207742:	7402                	ld	s0,32(sp)
ffffffffc0207744:	6942                	ld	s2,16(sp)
ffffffffc0207746:	69a2                	ld	s3,8(sp)
ffffffffc0207748:	8526                	mv	a0,s1
ffffffffc020774a:	64e2                	ld	s1,24(sp)
ffffffffc020774c:	6145                	addi	sp,sp,48
ffffffffc020774e:	8082                	ret
ffffffffc0207750:	54cd                	li	s1,-13
ffffffffc0207752:	b7cd                	j	ffffffffc0207734 <vfs_mount+0x8c>
ffffffffc0207754:	54c5                	li	s1,-15
ffffffffc0207756:	bff9                	j	ffffffffc0207734 <vfs_mount+0x8c>
ffffffffc0207758:	db3ff0ef          	jal	ra,ffffffffc020750a <find_mount.part.0>
ffffffffc020775c:	00006697          	auipc	a3,0x6
ffffffffc0207760:	37c68693          	addi	a3,a3,892 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207764:	00004617          	auipc	a2,0x4
ffffffffc0207768:	84c60613          	addi	a2,a2,-1972 # ffffffffc020afb0 <commands+0x210>
ffffffffc020776c:	0ed00593          	li	a1,237
ffffffffc0207770:	00006517          	auipc	a0,0x6
ffffffffc0207774:	2b050513          	addi	a0,a0,688 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc0207778:	d27f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020777c:	00006697          	auipc	a3,0x6
ffffffffc0207780:	32c68693          	addi	a3,a3,812 # ffffffffc020daa8 <syscalls+0xae0>
ffffffffc0207784:	00004617          	auipc	a2,0x4
ffffffffc0207788:	82c60613          	addi	a2,a2,-2004 # ffffffffc020afb0 <commands+0x210>
ffffffffc020778c:	0eb00593          	li	a1,235
ffffffffc0207790:	00006517          	auipc	a0,0x6
ffffffffc0207794:	29050513          	addi	a0,a0,656 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc0207798:	d07f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020779c:	00006697          	auipc	a3,0x6
ffffffffc02077a0:	37468693          	addi	a3,a3,884 # ffffffffc020db10 <syscalls+0xb48>
ffffffffc02077a4:	00004617          	auipc	a2,0x4
ffffffffc02077a8:	80c60613          	addi	a2,a2,-2036 # ffffffffc020afb0 <commands+0x210>
ffffffffc02077ac:	0ef00593          	li	a1,239
ffffffffc02077b0:	00006517          	auipc	a0,0x6
ffffffffc02077b4:	27050513          	addi	a0,a0,624 # ffffffffc020da20 <syscalls+0xa58>
ffffffffc02077b8:	ce7f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02077bc <vfs_open>:
ffffffffc02077bc:	711d                	addi	sp,sp,-96
ffffffffc02077be:	e4a6                	sd	s1,72(sp)
ffffffffc02077c0:	e0ca                	sd	s2,64(sp)
ffffffffc02077c2:	fc4e                	sd	s3,56(sp)
ffffffffc02077c4:	ec86                	sd	ra,88(sp)
ffffffffc02077c6:	e8a2                	sd	s0,80(sp)
ffffffffc02077c8:	f852                	sd	s4,48(sp)
ffffffffc02077ca:	f456                	sd	s5,40(sp)
ffffffffc02077cc:	0035f793          	andi	a5,a1,3
ffffffffc02077d0:	84ae                	mv	s1,a1
ffffffffc02077d2:	892a                	mv	s2,a0
ffffffffc02077d4:	89b2                	mv	s3,a2
ffffffffc02077d6:	0e078663          	beqz	a5,ffffffffc02078c2 <vfs_open+0x106>
ffffffffc02077da:	470d                	li	a4,3
ffffffffc02077dc:	0105fa93          	andi	s5,a1,16
ffffffffc02077e0:	0ce78f63          	beq	a5,a4,ffffffffc02078be <vfs_open+0x102>
ffffffffc02077e4:	002c                	addi	a1,sp,8
ffffffffc02077e6:	854a                	mv	a0,s2
ffffffffc02077e8:	2ae000ef          	jal	ra,ffffffffc0207a96 <vfs_lookup>
ffffffffc02077ec:	842a                	mv	s0,a0
ffffffffc02077ee:	0044fa13          	andi	s4,s1,4
ffffffffc02077f2:	e159                	bnez	a0,ffffffffc0207878 <vfs_open+0xbc>
ffffffffc02077f4:	00c4f793          	andi	a5,s1,12
ffffffffc02077f8:	4731                	li	a4,12
ffffffffc02077fa:	0ee78263          	beq	a5,a4,ffffffffc02078de <vfs_open+0x122>
ffffffffc02077fe:	6422                	ld	s0,8(sp)
ffffffffc0207800:	12040163          	beqz	s0,ffffffffc0207922 <vfs_open+0x166>
ffffffffc0207804:	783c                	ld	a5,112(s0)
ffffffffc0207806:	cff1                	beqz	a5,ffffffffc02078e2 <vfs_open+0x126>
ffffffffc0207808:	679c                	ld	a5,8(a5)
ffffffffc020780a:	cfe1                	beqz	a5,ffffffffc02078e2 <vfs_open+0x126>
ffffffffc020780c:	8522                	mv	a0,s0
ffffffffc020780e:	00006597          	auipc	a1,0x6
ffffffffc0207812:	3fa58593          	addi	a1,a1,1018 # ffffffffc020dc08 <syscalls+0xc40>
ffffffffc0207816:	8c3ff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc020781a:	783c                	ld	a5,112(s0)
ffffffffc020781c:	6522                	ld	a0,8(sp)
ffffffffc020781e:	85a6                	mv	a1,s1
ffffffffc0207820:	679c                	ld	a5,8(a5)
ffffffffc0207822:	9782                	jalr	a5
ffffffffc0207824:	842a                	mv	s0,a0
ffffffffc0207826:	6522                	ld	a0,8(sp)
ffffffffc0207828:	e845                	bnez	s0,ffffffffc02078d8 <vfs_open+0x11c>
ffffffffc020782a:	015a6a33          	or	s4,s4,s5
ffffffffc020782e:	89fff0ef          	jal	ra,ffffffffc02070cc <inode_open_inc>
ffffffffc0207832:	020a0663          	beqz	s4,ffffffffc020785e <vfs_open+0xa2>
ffffffffc0207836:	64a2                	ld	s1,8(sp)
ffffffffc0207838:	c4e9                	beqz	s1,ffffffffc0207902 <vfs_open+0x146>
ffffffffc020783a:	78bc                	ld	a5,112(s1)
ffffffffc020783c:	c3f9                	beqz	a5,ffffffffc0207902 <vfs_open+0x146>
ffffffffc020783e:	73bc                	ld	a5,96(a5)
ffffffffc0207840:	c3e9                	beqz	a5,ffffffffc0207902 <vfs_open+0x146>
ffffffffc0207842:	00006597          	auipc	a1,0x6
ffffffffc0207846:	42658593          	addi	a1,a1,1062 # ffffffffc020dc68 <syscalls+0xca0>
ffffffffc020784a:	8526                	mv	a0,s1
ffffffffc020784c:	88dff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0207850:	78bc                	ld	a5,112(s1)
ffffffffc0207852:	6522                	ld	a0,8(sp)
ffffffffc0207854:	4581                	li	a1,0
ffffffffc0207856:	73bc                	ld	a5,96(a5)
ffffffffc0207858:	9782                	jalr	a5
ffffffffc020785a:	87aa                	mv	a5,a0
ffffffffc020785c:	e92d                	bnez	a0,ffffffffc02078ce <vfs_open+0x112>
ffffffffc020785e:	67a2                	ld	a5,8(sp)
ffffffffc0207860:	00f9b023          	sd	a5,0(s3)
ffffffffc0207864:	60e6                	ld	ra,88(sp)
ffffffffc0207866:	8522                	mv	a0,s0
ffffffffc0207868:	6446                	ld	s0,80(sp)
ffffffffc020786a:	64a6                	ld	s1,72(sp)
ffffffffc020786c:	6906                	ld	s2,64(sp)
ffffffffc020786e:	79e2                	ld	s3,56(sp)
ffffffffc0207870:	7a42                	ld	s4,48(sp)
ffffffffc0207872:	7aa2                	ld	s5,40(sp)
ffffffffc0207874:	6125                	addi	sp,sp,96
ffffffffc0207876:	8082                	ret
ffffffffc0207878:	57c1                	li	a5,-16
ffffffffc020787a:	fef515e3          	bne	a0,a5,ffffffffc0207864 <vfs_open+0xa8>
ffffffffc020787e:	fe0a03e3          	beqz	s4,ffffffffc0207864 <vfs_open+0xa8>
ffffffffc0207882:	0810                	addi	a2,sp,16
ffffffffc0207884:	082c                	addi	a1,sp,24
ffffffffc0207886:	854a                	mv	a0,s2
ffffffffc0207888:	2a4000ef          	jal	ra,ffffffffc0207b2c <vfs_lookup_parent>
ffffffffc020788c:	842a                	mv	s0,a0
ffffffffc020788e:	f979                	bnez	a0,ffffffffc0207864 <vfs_open+0xa8>
ffffffffc0207890:	6462                	ld	s0,24(sp)
ffffffffc0207892:	c845                	beqz	s0,ffffffffc0207942 <vfs_open+0x186>
ffffffffc0207894:	783c                	ld	a5,112(s0)
ffffffffc0207896:	c7d5                	beqz	a5,ffffffffc0207942 <vfs_open+0x186>
ffffffffc0207898:	77bc                	ld	a5,104(a5)
ffffffffc020789a:	c7c5                	beqz	a5,ffffffffc0207942 <vfs_open+0x186>
ffffffffc020789c:	8522                	mv	a0,s0
ffffffffc020789e:	00006597          	auipc	a1,0x6
ffffffffc02078a2:	30258593          	addi	a1,a1,770 # ffffffffc020dba0 <syscalls+0xbd8>
ffffffffc02078a6:	833ff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc02078aa:	783c                	ld	a5,112(s0)
ffffffffc02078ac:	65c2                	ld	a1,16(sp)
ffffffffc02078ae:	6562                	ld	a0,24(sp)
ffffffffc02078b0:	77bc                	ld	a5,104(a5)
ffffffffc02078b2:	4034d613          	srai	a2,s1,0x3
ffffffffc02078b6:	0034                	addi	a3,sp,8
ffffffffc02078b8:	8a05                	andi	a2,a2,1
ffffffffc02078ba:	9782                	jalr	a5
ffffffffc02078bc:	b789                	j	ffffffffc02077fe <vfs_open+0x42>
ffffffffc02078be:	5475                	li	s0,-3
ffffffffc02078c0:	b755                	j	ffffffffc0207864 <vfs_open+0xa8>
ffffffffc02078c2:	0105fa93          	andi	s5,a1,16
ffffffffc02078c6:	5475                	li	s0,-3
ffffffffc02078c8:	f80a9ee3          	bnez	s5,ffffffffc0207864 <vfs_open+0xa8>
ffffffffc02078cc:	bf21                	j	ffffffffc02077e4 <vfs_open+0x28>
ffffffffc02078ce:	6522                	ld	a0,8(sp)
ffffffffc02078d0:	843e                	mv	s0,a5
ffffffffc02078d2:	965ff0ef          	jal	ra,ffffffffc0207236 <inode_open_dec>
ffffffffc02078d6:	6522                	ld	a0,8(sp)
ffffffffc02078d8:	8b7ff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc02078dc:	b761                	j	ffffffffc0207864 <vfs_open+0xa8>
ffffffffc02078de:	5425                	li	s0,-23
ffffffffc02078e0:	b751                	j	ffffffffc0207864 <vfs_open+0xa8>
ffffffffc02078e2:	00006697          	auipc	a3,0x6
ffffffffc02078e6:	2d668693          	addi	a3,a3,726 # ffffffffc020dbb8 <syscalls+0xbf0>
ffffffffc02078ea:	00003617          	auipc	a2,0x3
ffffffffc02078ee:	6c660613          	addi	a2,a2,1734 # ffffffffc020afb0 <commands+0x210>
ffffffffc02078f2:	03300593          	li	a1,51
ffffffffc02078f6:	00006517          	auipc	a0,0x6
ffffffffc02078fa:	29250513          	addi	a0,a0,658 # ffffffffc020db88 <syscalls+0xbc0>
ffffffffc02078fe:	ba1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207902:	00006697          	auipc	a3,0x6
ffffffffc0207906:	30e68693          	addi	a3,a3,782 # ffffffffc020dc10 <syscalls+0xc48>
ffffffffc020790a:	00003617          	auipc	a2,0x3
ffffffffc020790e:	6a660613          	addi	a2,a2,1702 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207912:	03a00593          	li	a1,58
ffffffffc0207916:	00006517          	auipc	a0,0x6
ffffffffc020791a:	27250513          	addi	a0,a0,626 # ffffffffc020db88 <syscalls+0xbc0>
ffffffffc020791e:	b81f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207922:	00006697          	auipc	a3,0x6
ffffffffc0207926:	28668693          	addi	a3,a3,646 # ffffffffc020dba8 <syscalls+0xbe0>
ffffffffc020792a:	00003617          	auipc	a2,0x3
ffffffffc020792e:	68660613          	addi	a2,a2,1670 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207932:	03100593          	li	a1,49
ffffffffc0207936:	00006517          	auipc	a0,0x6
ffffffffc020793a:	25250513          	addi	a0,a0,594 # ffffffffc020db88 <syscalls+0xbc0>
ffffffffc020793e:	b61f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207942:	00006697          	auipc	a3,0x6
ffffffffc0207946:	1f668693          	addi	a3,a3,502 # ffffffffc020db38 <syscalls+0xb70>
ffffffffc020794a:	00003617          	auipc	a2,0x3
ffffffffc020794e:	66660613          	addi	a2,a2,1638 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207952:	02c00593          	li	a1,44
ffffffffc0207956:	00006517          	auipc	a0,0x6
ffffffffc020795a:	23250513          	addi	a0,a0,562 # ffffffffc020db88 <syscalls+0xbc0>
ffffffffc020795e:	b41f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207962 <vfs_close>:
ffffffffc0207962:	1141                	addi	sp,sp,-16
ffffffffc0207964:	e406                	sd	ra,8(sp)
ffffffffc0207966:	e022                	sd	s0,0(sp)
ffffffffc0207968:	842a                	mv	s0,a0
ffffffffc020796a:	8cdff0ef          	jal	ra,ffffffffc0207236 <inode_open_dec>
ffffffffc020796e:	8522                	mv	a0,s0
ffffffffc0207970:	81fff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc0207974:	60a2                	ld	ra,8(sp)
ffffffffc0207976:	6402                	ld	s0,0(sp)
ffffffffc0207978:	4501                	li	a0,0
ffffffffc020797a:	0141                	addi	sp,sp,16
ffffffffc020797c:	8082                	ret

ffffffffc020797e <get_device>:
ffffffffc020797e:	7179                	addi	sp,sp,-48
ffffffffc0207980:	ec26                	sd	s1,24(sp)
ffffffffc0207982:	e84a                	sd	s2,16(sp)
ffffffffc0207984:	f406                	sd	ra,40(sp)
ffffffffc0207986:	f022                	sd	s0,32(sp)
ffffffffc0207988:	00054303          	lbu	t1,0(a0)
ffffffffc020798c:	892e                	mv	s2,a1
ffffffffc020798e:	84b2                	mv	s1,a2
ffffffffc0207990:	02030463          	beqz	t1,ffffffffc02079b8 <get_device+0x3a>
ffffffffc0207994:	00150413          	addi	s0,a0,1
ffffffffc0207998:	86a2                	mv	a3,s0
ffffffffc020799a:	879a                	mv	a5,t1
ffffffffc020799c:	4701                	li	a4,0
ffffffffc020799e:	03a00813          	li	a6,58
ffffffffc02079a2:	02f00893          	li	a7,47
ffffffffc02079a6:	03078263          	beq	a5,a6,ffffffffc02079ca <get_device+0x4c>
ffffffffc02079aa:	05178963          	beq	a5,a7,ffffffffc02079fc <get_device+0x7e>
ffffffffc02079ae:	0006c783          	lbu	a5,0(a3)
ffffffffc02079b2:	2705                	addiw	a4,a4,1
ffffffffc02079b4:	0685                	addi	a3,a3,1
ffffffffc02079b6:	fbe5                	bnez	a5,ffffffffc02079a6 <get_device+0x28>
ffffffffc02079b8:	7402                	ld	s0,32(sp)
ffffffffc02079ba:	00a93023          	sd	a0,0(s2)
ffffffffc02079be:	70a2                	ld	ra,40(sp)
ffffffffc02079c0:	6942                	ld	s2,16(sp)
ffffffffc02079c2:	8526                	mv	a0,s1
ffffffffc02079c4:	64e2                	ld	s1,24(sp)
ffffffffc02079c6:	6145                	addi	sp,sp,48
ffffffffc02079c8:	a279                	j	ffffffffc0207b56 <vfs_get_curdir>
ffffffffc02079ca:	cb15                	beqz	a4,ffffffffc02079fe <get_device+0x80>
ffffffffc02079cc:	00e507b3          	add	a5,a0,a4
ffffffffc02079d0:	0705                	addi	a4,a4,1
ffffffffc02079d2:	00078023          	sb	zero,0(a5)
ffffffffc02079d6:	972a                	add	a4,a4,a0
ffffffffc02079d8:	02f00613          	li	a2,47
ffffffffc02079dc:	00074783          	lbu	a5,0(a4)
ffffffffc02079e0:	86ba                	mv	a3,a4
ffffffffc02079e2:	0705                	addi	a4,a4,1
ffffffffc02079e4:	fec78ce3          	beq	a5,a2,ffffffffc02079dc <get_device+0x5e>
ffffffffc02079e8:	7402                	ld	s0,32(sp)
ffffffffc02079ea:	70a2                	ld	ra,40(sp)
ffffffffc02079ec:	00d93023          	sd	a3,0(s2)
ffffffffc02079f0:	85a6                	mv	a1,s1
ffffffffc02079f2:	6942                	ld	s2,16(sp)
ffffffffc02079f4:	64e2                	ld	s1,24(sp)
ffffffffc02079f6:	6145                	addi	sp,sp,48
ffffffffc02079f8:	ba9ff06f          	j	ffffffffc02075a0 <vfs_get_root>
ffffffffc02079fc:	ff55                	bnez	a4,ffffffffc02079b8 <get_device+0x3a>
ffffffffc02079fe:	02f00793          	li	a5,47
ffffffffc0207a02:	04f30563          	beq	t1,a5,ffffffffc0207a4c <get_device+0xce>
ffffffffc0207a06:	03a00793          	li	a5,58
ffffffffc0207a0a:	06f31663          	bne	t1,a5,ffffffffc0207a76 <get_device+0xf8>
ffffffffc0207a0e:	0028                	addi	a0,sp,8
ffffffffc0207a10:	146000ef          	jal	ra,ffffffffc0207b56 <vfs_get_curdir>
ffffffffc0207a14:	e515                	bnez	a0,ffffffffc0207a40 <get_device+0xc2>
ffffffffc0207a16:	67a2                	ld	a5,8(sp)
ffffffffc0207a18:	77a8                	ld	a0,104(a5)
ffffffffc0207a1a:	cd15                	beqz	a0,ffffffffc0207a56 <get_device+0xd8>
ffffffffc0207a1c:	617c                	ld	a5,192(a0)
ffffffffc0207a1e:	9782                	jalr	a5
ffffffffc0207a20:	87aa                	mv	a5,a0
ffffffffc0207a22:	6522                	ld	a0,8(sp)
ffffffffc0207a24:	e09c                	sd	a5,0(s1)
ffffffffc0207a26:	f68ff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc0207a2a:	02f00713          	li	a4,47
ffffffffc0207a2e:	a011                	j	ffffffffc0207a32 <get_device+0xb4>
ffffffffc0207a30:	0405                	addi	s0,s0,1
ffffffffc0207a32:	00044783          	lbu	a5,0(s0)
ffffffffc0207a36:	fee78de3          	beq	a5,a4,ffffffffc0207a30 <get_device+0xb2>
ffffffffc0207a3a:	00893023          	sd	s0,0(s2)
ffffffffc0207a3e:	4501                	li	a0,0
ffffffffc0207a40:	70a2                	ld	ra,40(sp)
ffffffffc0207a42:	7402                	ld	s0,32(sp)
ffffffffc0207a44:	64e2                	ld	s1,24(sp)
ffffffffc0207a46:	6942                	ld	s2,16(sp)
ffffffffc0207a48:	6145                	addi	sp,sp,48
ffffffffc0207a4a:	8082                	ret
ffffffffc0207a4c:	8526                	mv	a0,s1
ffffffffc0207a4e:	93fff0ef          	jal	ra,ffffffffc020738c <vfs_get_bootfs>
ffffffffc0207a52:	dd61                	beqz	a0,ffffffffc0207a2a <get_device+0xac>
ffffffffc0207a54:	b7f5                	j	ffffffffc0207a40 <get_device+0xc2>
ffffffffc0207a56:	00006697          	auipc	a3,0x6
ffffffffc0207a5a:	24a68693          	addi	a3,a3,586 # ffffffffc020dca0 <syscalls+0xcd8>
ffffffffc0207a5e:	00003617          	auipc	a2,0x3
ffffffffc0207a62:	55260613          	addi	a2,a2,1362 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207a66:	03900593          	li	a1,57
ffffffffc0207a6a:	00006517          	auipc	a0,0x6
ffffffffc0207a6e:	21e50513          	addi	a0,a0,542 # ffffffffc020dc88 <syscalls+0xcc0>
ffffffffc0207a72:	a2df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a76:	00006697          	auipc	a3,0x6
ffffffffc0207a7a:	20268693          	addi	a3,a3,514 # ffffffffc020dc78 <syscalls+0xcb0>
ffffffffc0207a7e:	00003617          	auipc	a2,0x3
ffffffffc0207a82:	53260613          	addi	a2,a2,1330 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207a86:	03300593          	li	a1,51
ffffffffc0207a8a:	00006517          	auipc	a0,0x6
ffffffffc0207a8e:	1fe50513          	addi	a0,a0,510 # ffffffffc020dc88 <syscalls+0xcc0>
ffffffffc0207a92:	a0df80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a96 <vfs_lookup>:
ffffffffc0207a96:	7139                	addi	sp,sp,-64
ffffffffc0207a98:	f426                	sd	s1,40(sp)
ffffffffc0207a9a:	0830                	addi	a2,sp,24
ffffffffc0207a9c:	84ae                	mv	s1,a1
ffffffffc0207a9e:	002c                	addi	a1,sp,8
ffffffffc0207aa0:	f822                	sd	s0,48(sp)
ffffffffc0207aa2:	fc06                	sd	ra,56(sp)
ffffffffc0207aa4:	f04a                	sd	s2,32(sp)
ffffffffc0207aa6:	e42a                	sd	a0,8(sp)
ffffffffc0207aa8:	ed7ff0ef          	jal	ra,ffffffffc020797e <get_device>
ffffffffc0207aac:	842a                	mv	s0,a0
ffffffffc0207aae:	ed1d                	bnez	a0,ffffffffc0207aec <vfs_lookup+0x56>
ffffffffc0207ab0:	67a2                	ld	a5,8(sp)
ffffffffc0207ab2:	6962                	ld	s2,24(sp)
ffffffffc0207ab4:	0007c783          	lbu	a5,0(a5)
ffffffffc0207ab8:	c3a9                	beqz	a5,ffffffffc0207afa <vfs_lookup+0x64>
ffffffffc0207aba:	04090963          	beqz	s2,ffffffffc0207b0c <vfs_lookup+0x76>
ffffffffc0207abe:	07093783          	ld	a5,112(s2)
ffffffffc0207ac2:	c7a9                	beqz	a5,ffffffffc0207b0c <vfs_lookup+0x76>
ffffffffc0207ac4:	7bbc                	ld	a5,112(a5)
ffffffffc0207ac6:	c3b9                	beqz	a5,ffffffffc0207b0c <vfs_lookup+0x76>
ffffffffc0207ac8:	854a                	mv	a0,s2
ffffffffc0207aca:	00006597          	auipc	a1,0x6
ffffffffc0207ace:	23e58593          	addi	a1,a1,574 # ffffffffc020dd08 <syscalls+0xd40>
ffffffffc0207ad2:	e06ff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0207ad6:	07093783          	ld	a5,112(s2)
ffffffffc0207ada:	65a2                	ld	a1,8(sp)
ffffffffc0207adc:	6562                	ld	a0,24(sp)
ffffffffc0207ade:	7bbc                	ld	a5,112(a5)
ffffffffc0207ae0:	8626                	mv	a2,s1
ffffffffc0207ae2:	9782                	jalr	a5
ffffffffc0207ae4:	842a                	mv	s0,a0
ffffffffc0207ae6:	6562                	ld	a0,24(sp)
ffffffffc0207ae8:	ea6ff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc0207aec:	70e2                	ld	ra,56(sp)
ffffffffc0207aee:	8522                	mv	a0,s0
ffffffffc0207af0:	7442                	ld	s0,48(sp)
ffffffffc0207af2:	74a2                	ld	s1,40(sp)
ffffffffc0207af4:	7902                	ld	s2,32(sp)
ffffffffc0207af6:	6121                	addi	sp,sp,64
ffffffffc0207af8:	8082                	ret
ffffffffc0207afa:	70e2                	ld	ra,56(sp)
ffffffffc0207afc:	8522                	mv	a0,s0
ffffffffc0207afe:	7442                	ld	s0,48(sp)
ffffffffc0207b00:	0124b023          	sd	s2,0(s1)
ffffffffc0207b04:	74a2                	ld	s1,40(sp)
ffffffffc0207b06:	7902                	ld	s2,32(sp)
ffffffffc0207b08:	6121                	addi	sp,sp,64
ffffffffc0207b0a:	8082                	ret
ffffffffc0207b0c:	00006697          	auipc	a3,0x6
ffffffffc0207b10:	1ac68693          	addi	a3,a3,428 # ffffffffc020dcb8 <syscalls+0xcf0>
ffffffffc0207b14:	00003617          	auipc	a2,0x3
ffffffffc0207b18:	49c60613          	addi	a2,a2,1180 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207b1c:	04f00593          	li	a1,79
ffffffffc0207b20:	00006517          	auipc	a0,0x6
ffffffffc0207b24:	16850513          	addi	a0,a0,360 # ffffffffc020dc88 <syscalls+0xcc0>
ffffffffc0207b28:	977f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207b2c <vfs_lookup_parent>:
ffffffffc0207b2c:	7139                	addi	sp,sp,-64
ffffffffc0207b2e:	f822                	sd	s0,48(sp)
ffffffffc0207b30:	f426                	sd	s1,40(sp)
ffffffffc0207b32:	842e                	mv	s0,a1
ffffffffc0207b34:	84b2                	mv	s1,a2
ffffffffc0207b36:	002c                	addi	a1,sp,8
ffffffffc0207b38:	0830                	addi	a2,sp,24
ffffffffc0207b3a:	fc06                	sd	ra,56(sp)
ffffffffc0207b3c:	e42a                	sd	a0,8(sp)
ffffffffc0207b3e:	e41ff0ef          	jal	ra,ffffffffc020797e <get_device>
ffffffffc0207b42:	e509                	bnez	a0,ffffffffc0207b4c <vfs_lookup_parent+0x20>
ffffffffc0207b44:	67a2                	ld	a5,8(sp)
ffffffffc0207b46:	e09c                	sd	a5,0(s1)
ffffffffc0207b48:	67e2                	ld	a5,24(sp)
ffffffffc0207b4a:	e01c                	sd	a5,0(s0)
ffffffffc0207b4c:	70e2                	ld	ra,56(sp)
ffffffffc0207b4e:	7442                	ld	s0,48(sp)
ffffffffc0207b50:	74a2                	ld	s1,40(sp)
ffffffffc0207b52:	6121                	addi	sp,sp,64
ffffffffc0207b54:	8082                	ret

ffffffffc0207b56 <vfs_get_curdir>:
ffffffffc0207b56:	0008e797          	auipc	a5,0x8e
ffffffffc0207b5a:	d6a7b783          	ld	a5,-662(a5) # ffffffffc02958c0 <current>
ffffffffc0207b5e:	1487b783          	ld	a5,328(a5)
ffffffffc0207b62:	1101                	addi	sp,sp,-32
ffffffffc0207b64:	e426                	sd	s1,8(sp)
ffffffffc0207b66:	6384                	ld	s1,0(a5)
ffffffffc0207b68:	ec06                	sd	ra,24(sp)
ffffffffc0207b6a:	e822                	sd	s0,16(sp)
ffffffffc0207b6c:	cc81                	beqz	s1,ffffffffc0207b84 <vfs_get_curdir+0x2e>
ffffffffc0207b6e:	842a                	mv	s0,a0
ffffffffc0207b70:	8526                	mv	a0,s1
ffffffffc0207b72:	d4eff0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0207b76:	4501                	li	a0,0
ffffffffc0207b78:	e004                	sd	s1,0(s0)
ffffffffc0207b7a:	60e2                	ld	ra,24(sp)
ffffffffc0207b7c:	6442                	ld	s0,16(sp)
ffffffffc0207b7e:	64a2                	ld	s1,8(sp)
ffffffffc0207b80:	6105                	addi	sp,sp,32
ffffffffc0207b82:	8082                	ret
ffffffffc0207b84:	5541                	li	a0,-16
ffffffffc0207b86:	bfd5                	j	ffffffffc0207b7a <vfs_get_curdir+0x24>

ffffffffc0207b88 <vfs_set_curdir>:
ffffffffc0207b88:	7139                	addi	sp,sp,-64
ffffffffc0207b8a:	f04a                	sd	s2,32(sp)
ffffffffc0207b8c:	0008e917          	auipc	s2,0x8e
ffffffffc0207b90:	d3490913          	addi	s2,s2,-716 # ffffffffc02958c0 <current>
ffffffffc0207b94:	00093783          	ld	a5,0(s2)
ffffffffc0207b98:	f822                	sd	s0,48(sp)
ffffffffc0207b9a:	842a                	mv	s0,a0
ffffffffc0207b9c:	1487b503          	ld	a0,328(a5)
ffffffffc0207ba0:	ec4e                	sd	s3,24(sp)
ffffffffc0207ba2:	fc06                	sd	ra,56(sp)
ffffffffc0207ba4:	f426                	sd	s1,40(sp)
ffffffffc0207ba6:	caafd0ef          	jal	ra,ffffffffc0205050 <lock_files>
ffffffffc0207baa:	00093783          	ld	a5,0(s2)
ffffffffc0207bae:	1487b503          	ld	a0,328(a5)
ffffffffc0207bb2:	00053983          	ld	s3,0(a0)
ffffffffc0207bb6:	07340963          	beq	s0,s3,ffffffffc0207c28 <vfs_set_curdir+0xa0>
ffffffffc0207bba:	cc39                	beqz	s0,ffffffffc0207c18 <vfs_set_curdir+0x90>
ffffffffc0207bbc:	783c                	ld	a5,112(s0)
ffffffffc0207bbe:	c7bd                	beqz	a5,ffffffffc0207c2c <vfs_set_curdir+0xa4>
ffffffffc0207bc0:	6bbc                	ld	a5,80(a5)
ffffffffc0207bc2:	c7ad                	beqz	a5,ffffffffc0207c2c <vfs_set_curdir+0xa4>
ffffffffc0207bc4:	00006597          	auipc	a1,0x6
ffffffffc0207bc8:	1b458593          	addi	a1,a1,436 # ffffffffc020dd78 <syscalls+0xdb0>
ffffffffc0207bcc:	8522                	mv	a0,s0
ffffffffc0207bce:	d0aff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0207bd2:	783c                	ld	a5,112(s0)
ffffffffc0207bd4:	006c                	addi	a1,sp,12
ffffffffc0207bd6:	8522                	mv	a0,s0
ffffffffc0207bd8:	6bbc                	ld	a5,80(a5)
ffffffffc0207bda:	9782                	jalr	a5
ffffffffc0207bdc:	84aa                	mv	s1,a0
ffffffffc0207bde:	e901                	bnez	a0,ffffffffc0207bee <vfs_set_curdir+0x66>
ffffffffc0207be0:	47b2                	lw	a5,12(sp)
ffffffffc0207be2:	669d                	lui	a3,0x7
ffffffffc0207be4:	6709                	lui	a4,0x2
ffffffffc0207be6:	8ff5                	and	a5,a5,a3
ffffffffc0207be8:	54b9                	li	s1,-18
ffffffffc0207bea:	02e78063          	beq	a5,a4,ffffffffc0207c0a <vfs_set_curdir+0x82>
ffffffffc0207bee:	00093783          	ld	a5,0(s2)
ffffffffc0207bf2:	1487b503          	ld	a0,328(a5)
ffffffffc0207bf6:	c60fd0ef          	jal	ra,ffffffffc0205056 <unlock_files>
ffffffffc0207bfa:	70e2                	ld	ra,56(sp)
ffffffffc0207bfc:	7442                	ld	s0,48(sp)
ffffffffc0207bfe:	7902                	ld	s2,32(sp)
ffffffffc0207c00:	69e2                	ld	s3,24(sp)
ffffffffc0207c02:	8526                	mv	a0,s1
ffffffffc0207c04:	74a2                	ld	s1,40(sp)
ffffffffc0207c06:	6121                	addi	sp,sp,64
ffffffffc0207c08:	8082                	ret
ffffffffc0207c0a:	8522                	mv	a0,s0
ffffffffc0207c0c:	cb4ff0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0207c10:	00093783          	ld	a5,0(s2)
ffffffffc0207c14:	1487b503          	ld	a0,328(a5)
ffffffffc0207c18:	e100                	sd	s0,0(a0)
ffffffffc0207c1a:	4481                	li	s1,0
ffffffffc0207c1c:	fc098de3          	beqz	s3,ffffffffc0207bf6 <vfs_set_curdir+0x6e>
ffffffffc0207c20:	854e                	mv	a0,s3
ffffffffc0207c22:	d6cff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc0207c26:	b7e1                	j	ffffffffc0207bee <vfs_set_curdir+0x66>
ffffffffc0207c28:	4481                	li	s1,0
ffffffffc0207c2a:	b7f1                	j	ffffffffc0207bf6 <vfs_set_curdir+0x6e>
ffffffffc0207c2c:	00006697          	auipc	a3,0x6
ffffffffc0207c30:	0e468693          	addi	a3,a3,228 # ffffffffc020dd10 <syscalls+0xd48>
ffffffffc0207c34:	00003617          	auipc	a2,0x3
ffffffffc0207c38:	37c60613          	addi	a2,a2,892 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207c3c:	04300593          	li	a1,67
ffffffffc0207c40:	00006517          	auipc	a0,0x6
ffffffffc0207c44:	12050513          	addi	a0,a0,288 # ffffffffc020dd60 <syscalls+0xd98>
ffffffffc0207c48:	857f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207c4c <vfs_chdir>:
ffffffffc0207c4c:	1101                	addi	sp,sp,-32
ffffffffc0207c4e:	002c                	addi	a1,sp,8
ffffffffc0207c50:	e822                	sd	s0,16(sp)
ffffffffc0207c52:	ec06                	sd	ra,24(sp)
ffffffffc0207c54:	e43ff0ef          	jal	ra,ffffffffc0207a96 <vfs_lookup>
ffffffffc0207c58:	842a                	mv	s0,a0
ffffffffc0207c5a:	c511                	beqz	a0,ffffffffc0207c66 <vfs_chdir+0x1a>
ffffffffc0207c5c:	60e2                	ld	ra,24(sp)
ffffffffc0207c5e:	8522                	mv	a0,s0
ffffffffc0207c60:	6442                	ld	s0,16(sp)
ffffffffc0207c62:	6105                	addi	sp,sp,32
ffffffffc0207c64:	8082                	ret
ffffffffc0207c66:	6522                	ld	a0,8(sp)
ffffffffc0207c68:	f21ff0ef          	jal	ra,ffffffffc0207b88 <vfs_set_curdir>
ffffffffc0207c6c:	842a                	mv	s0,a0
ffffffffc0207c6e:	6522                	ld	a0,8(sp)
ffffffffc0207c70:	d1eff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc0207c74:	60e2                	ld	ra,24(sp)
ffffffffc0207c76:	8522                	mv	a0,s0
ffffffffc0207c78:	6442                	ld	s0,16(sp)
ffffffffc0207c7a:	6105                	addi	sp,sp,32
ffffffffc0207c7c:	8082                	ret

ffffffffc0207c7e <vfs_getcwd>:
ffffffffc0207c7e:	0008e797          	auipc	a5,0x8e
ffffffffc0207c82:	c427b783          	ld	a5,-958(a5) # ffffffffc02958c0 <current>
ffffffffc0207c86:	1487b783          	ld	a5,328(a5)
ffffffffc0207c8a:	7179                	addi	sp,sp,-48
ffffffffc0207c8c:	ec26                	sd	s1,24(sp)
ffffffffc0207c8e:	6384                	ld	s1,0(a5)
ffffffffc0207c90:	f406                	sd	ra,40(sp)
ffffffffc0207c92:	f022                	sd	s0,32(sp)
ffffffffc0207c94:	e84a                	sd	s2,16(sp)
ffffffffc0207c96:	ccbd                	beqz	s1,ffffffffc0207d14 <vfs_getcwd+0x96>
ffffffffc0207c98:	892a                	mv	s2,a0
ffffffffc0207c9a:	8526                	mv	a0,s1
ffffffffc0207c9c:	c24ff0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0207ca0:	74a8                	ld	a0,104(s1)
ffffffffc0207ca2:	c93d                	beqz	a0,ffffffffc0207d18 <vfs_getcwd+0x9a>
ffffffffc0207ca4:	9b3ff0ef          	jal	ra,ffffffffc0207656 <vfs_get_devname>
ffffffffc0207ca8:	842a                	mv	s0,a0
ffffffffc0207caa:	583020ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc0207cae:	862a                	mv	a2,a0
ffffffffc0207cb0:	85a2                	mv	a1,s0
ffffffffc0207cb2:	4701                	li	a4,0
ffffffffc0207cb4:	4685                	li	a3,1
ffffffffc0207cb6:	854a                	mv	a0,s2
ffffffffc0207cb8:	dc2fd0ef          	jal	ra,ffffffffc020527a <iobuf_move>
ffffffffc0207cbc:	842a                	mv	s0,a0
ffffffffc0207cbe:	c919                	beqz	a0,ffffffffc0207cd4 <vfs_getcwd+0x56>
ffffffffc0207cc0:	8526                	mv	a0,s1
ffffffffc0207cc2:	cccff0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc0207cc6:	70a2                	ld	ra,40(sp)
ffffffffc0207cc8:	8522                	mv	a0,s0
ffffffffc0207cca:	7402                	ld	s0,32(sp)
ffffffffc0207ccc:	64e2                	ld	s1,24(sp)
ffffffffc0207cce:	6942                	ld	s2,16(sp)
ffffffffc0207cd0:	6145                	addi	sp,sp,48
ffffffffc0207cd2:	8082                	ret
ffffffffc0207cd4:	03a00793          	li	a5,58
ffffffffc0207cd8:	4701                	li	a4,0
ffffffffc0207cda:	4685                	li	a3,1
ffffffffc0207cdc:	4605                	li	a2,1
ffffffffc0207cde:	00f10593          	addi	a1,sp,15
ffffffffc0207ce2:	854a                	mv	a0,s2
ffffffffc0207ce4:	00f107a3          	sb	a5,15(sp)
ffffffffc0207ce8:	d92fd0ef          	jal	ra,ffffffffc020527a <iobuf_move>
ffffffffc0207cec:	842a                	mv	s0,a0
ffffffffc0207cee:	f969                	bnez	a0,ffffffffc0207cc0 <vfs_getcwd+0x42>
ffffffffc0207cf0:	78bc                	ld	a5,112(s1)
ffffffffc0207cf2:	c3b9                	beqz	a5,ffffffffc0207d38 <vfs_getcwd+0xba>
ffffffffc0207cf4:	7f9c                	ld	a5,56(a5)
ffffffffc0207cf6:	c3a9                	beqz	a5,ffffffffc0207d38 <vfs_getcwd+0xba>
ffffffffc0207cf8:	00006597          	auipc	a1,0x6
ffffffffc0207cfc:	0e058593          	addi	a1,a1,224 # ffffffffc020ddd8 <syscalls+0xe10>
ffffffffc0207d00:	8526                	mv	a0,s1
ffffffffc0207d02:	bd6ff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0207d06:	78bc                	ld	a5,112(s1)
ffffffffc0207d08:	85ca                	mv	a1,s2
ffffffffc0207d0a:	8526                	mv	a0,s1
ffffffffc0207d0c:	7f9c                	ld	a5,56(a5)
ffffffffc0207d0e:	9782                	jalr	a5
ffffffffc0207d10:	842a                	mv	s0,a0
ffffffffc0207d12:	b77d                	j	ffffffffc0207cc0 <vfs_getcwd+0x42>
ffffffffc0207d14:	5441                	li	s0,-16
ffffffffc0207d16:	bf45                	j	ffffffffc0207cc6 <vfs_getcwd+0x48>
ffffffffc0207d18:	00006697          	auipc	a3,0x6
ffffffffc0207d1c:	f8868693          	addi	a3,a3,-120 # ffffffffc020dca0 <syscalls+0xcd8>
ffffffffc0207d20:	00003617          	auipc	a2,0x3
ffffffffc0207d24:	29060613          	addi	a2,a2,656 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207d28:	06e00593          	li	a1,110
ffffffffc0207d2c:	00006517          	auipc	a0,0x6
ffffffffc0207d30:	03450513          	addi	a0,a0,52 # ffffffffc020dd60 <syscalls+0xd98>
ffffffffc0207d34:	f6af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d38:	00006697          	auipc	a3,0x6
ffffffffc0207d3c:	04868693          	addi	a3,a3,72 # ffffffffc020dd80 <syscalls+0xdb8>
ffffffffc0207d40:	00003617          	auipc	a2,0x3
ffffffffc0207d44:	27060613          	addi	a2,a2,624 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207d48:	07800593          	li	a1,120
ffffffffc0207d4c:	00006517          	auipc	a0,0x6
ffffffffc0207d50:	01450513          	addi	a0,a0,20 # ffffffffc020dd60 <syscalls+0xd98>
ffffffffc0207d54:	f4af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d58 <dev_lookup>:
ffffffffc0207d58:	0005c783          	lbu	a5,0(a1)
ffffffffc0207d5c:	e385                	bnez	a5,ffffffffc0207d7c <dev_lookup+0x24>
ffffffffc0207d5e:	1101                	addi	sp,sp,-32
ffffffffc0207d60:	e822                	sd	s0,16(sp)
ffffffffc0207d62:	e426                	sd	s1,8(sp)
ffffffffc0207d64:	ec06                	sd	ra,24(sp)
ffffffffc0207d66:	84aa                	mv	s1,a0
ffffffffc0207d68:	8432                	mv	s0,a2
ffffffffc0207d6a:	b56ff0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0207d6e:	60e2                	ld	ra,24(sp)
ffffffffc0207d70:	e004                	sd	s1,0(s0)
ffffffffc0207d72:	6442                	ld	s0,16(sp)
ffffffffc0207d74:	64a2                	ld	s1,8(sp)
ffffffffc0207d76:	4501                	li	a0,0
ffffffffc0207d78:	6105                	addi	sp,sp,32
ffffffffc0207d7a:	8082                	ret
ffffffffc0207d7c:	5541                	li	a0,-16
ffffffffc0207d7e:	8082                	ret

ffffffffc0207d80 <dev_fstat>:
ffffffffc0207d80:	1101                	addi	sp,sp,-32
ffffffffc0207d82:	e426                	sd	s1,8(sp)
ffffffffc0207d84:	84ae                	mv	s1,a1
ffffffffc0207d86:	e822                	sd	s0,16(sp)
ffffffffc0207d88:	02000613          	li	a2,32
ffffffffc0207d8c:	842a                	mv	s0,a0
ffffffffc0207d8e:	4581                	li	a1,0
ffffffffc0207d90:	8526                	mv	a0,s1
ffffffffc0207d92:	ec06                	sd	ra,24(sp)
ffffffffc0207d94:	53b020ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0207d98:	c429                	beqz	s0,ffffffffc0207de2 <dev_fstat+0x62>
ffffffffc0207d9a:	783c                	ld	a5,112(s0)
ffffffffc0207d9c:	c3b9                	beqz	a5,ffffffffc0207de2 <dev_fstat+0x62>
ffffffffc0207d9e:	6bbc                	ld	a5,80(a5)
ffffffffc0207da0:	c3a9                	beqz	a5,ffffffffc0207de2 <dev_fstat+0x62>
ffffffffc0207da2:	00006597          	auipc	a1,0x6
ffffffffc0207da6:	fd658593          	addi	a1,a1,-42 # ffffffffc020dd78 <syscalls+0xdb0>
ffffffffc0207daa:	8522                	mv	a0,s0
ffffffffc0207dac:	b2cff0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0207db0:	783c                	ld	a5,112(s0)
ffffffffc0207db2:	85a6                	mv	a1,s1
ffffffffc0207db4:	8522                	mv	a0,s0
ffffffffc0207db6:	6bbc                	ld	a5,80(a5)
ffffffffc0207db8:	9782                	jalr	a5
ffffffffc0207dba:	ed19                	bnez	a0,ffffffffc0207dd8 <dev_fstat+0x58>
ffffffffc0207dbc:	4c38                	lw	a4,88(s0)
ffffffffc0207dbe:	6785                	lui	a5,0x1
ffffffffc0207dc0:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207dc4:	02f71f63          	bne	a4,a5,ffffffffc0207e02 <dev_fstat+0x82>
ffffffffc0207dc8:	6018                	ld	a4,0(s0)
ffffffffc0207dca:	641c                	ld	a5,8(s0)
ffffffffc0207dcc:	4685                	li	a3,1
ffffffffc0207dce:	e494                	sd	a3,8(s1)
ffffffffc0207dd0:	02e787b3          	mul	a5,a5,a4
ffffffffc0207dd4:	e898                	sd	a4,16(s1)
ffffffffc0207dd6:	ec9c                	sd	a5,24(s1)
ffffffffc0207dd8:	60e2                	ld	ra,24(sp)
ffffffffc0207dda:	6442                	ld	s0,16(sp)
ffffffffc0207ddc:	64a2                	ld	s1,8(sp)
ffffffffc0207dde:	6105                	addi	sp,sp,32
ffffffffc0207de0:	8082                	ret
ffffffffc0207de2:	00006697          	auipc	a3,0x6
ffffffffc0207de6:	f2e68693          	addi	a3,a3,-210 # ffffffffc020dd10 <syscalls+0xd48>
ffffffffc0207dea:	00003617          	auipc	a2,0x3
ffffffffc0207dee:	1c660613          	addi	a2,a2,454 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207df2:	04200593          	li	a1,66
ffffffffc0207df6:	00006517          	auipc	a0,0x6
ffffffffc0207dfa:	ff250513          	addi	a0,a0,-14 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207dfe:	ea0f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e02:	00006697          	auipc	a3,0x6
ffffffffc0207e06:	cd668693          	addi	a3,a3,-810 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207e0a:	00003617          	auipc	a2,0x3
ffffffffc0207e0e:	1a660613          	addi	a2,a2,422 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207e12:	04500593          	li	a1,69
ffffffffc0207e16:	00006517          	auipc	a0,0x6
ffffffffc0207e1a:	fd250513          	addi	a0,a0,-46 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207e1e:	e80f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e22 <dev_ioctl>:
ffffffffc0207e22:	c909                	beqz	a0,ffffffffc0207e34 <dev_ioctl+0x12>
ffffffffc0207e24:	4d34                	lw	a3,88(a0)
ffffffffc0207e26:	6705                	lui	a4,0x1
ffffffffc0207e28:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207e2c:	00e69463          	bne	a3,a4,ffffffffc0207e34 <dev_ioctl+0x12>
ffffffffc0207e30:	751c                	ld	a5,40(a0)
ffffffffc0207e32:	8782                	jr	a5
ffffffffc0207e34:	1141                	addi	sp,sp,-16
ffffffffc0207e36:	00006697          	auipc	a3,0x6
ffffffffc0207e3a:	ca268693          	addi	a3,a3,-862 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207e3e:	00003617          	auipc	a2,0x3
ffffffffc0207e42:	17260613          	addi	a2,a2,370 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207e46:	03500593          	li	a1,53
ffffffffc0207e4a:	00006517          	auipc	a0,0x6
ffffffffc0207e4e:	f9e50513          	addi	a0,a0,-98 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207e52:	e406                	sd	ra,8(sp)
ffffffffc0207e54:	e4af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e58 <dev_tryseek>:
ffffffffc0207e58:	c51d                	beqz	a0,ffffffffc0207e86 <dev_tryseek+0x2e>
ffffffffc0207e5a:	4d38                	lw	a4,88(a0)
ffffffffc0207e5c:	6785                	lui	a5,0x1
ffffffffc0207e5e:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207e62:	02f71263          	bne	a4,a5,ffffffffc0207e86 <dev_tryseek+0x2e>
ffffffffc0207e66:	611c                	ld	a5,0(a0)
ffffffffc0207e68:	cf89                	beqz	a5,ffffffffc0207e82 <dev_tryseek+0x2a>
ffffffffc0207e6a:	6518                	ld	a4,8(a0)
ffffffffc0207e6c:	02e5f6b3          	remu	a3,a1,a4
ffffffffc0207e70:	ea89                	bnez	a3,ffffffffc0207e82 <dev_tryseek+0x2a>
ffffffffc0207e72:	0005c863          	bltz	a1,ffffffffc0207e82 <dev_tryseek+0x2a>
ffffffffc0207e76:	02e787b3          	mul	a5,a5,a4
ffffffffc0207e7a:	00f5f463          	bgeu	a1,a5,ffffffffc0207e82 <dev_tryseek+0x2a>
ffffffffc0207e7e:	4501                	li	a0,0
ffffffffc0207e80:	8082                	ret
ffffffffc0207e82:	5575                	li	a0,-3
ffffffffc0207e84:	8082                	ret
ffffffffc0207e86:	1141                	addi	sp,sp,-16
ffffffffc0207e88:	00006697          	auipc	a3,0x6
ffffffffc0207e8c:	c5068693          	addi	a3,a3,-944 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207e90:	00003617          	auipc	a2,0x3
ffffffffc0207e94:	12060613          	addi	a2,a2,288 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207e98:	05f00593          	li	a1,95
ffffffffc0207e9c:	00006517          	auipc	a0,0x6
ffffffffc0207ea0:	f4c50513          	addi	a0,a0,-180 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207ea4:	e406                	sd	ra,8(sp)
ffffffffc0207ea6:	df8f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207eaa <dev_gettype>:
ffffffffc0207eaa:	c10d                	beqz	a0,ffffffffc0207ecc <dev_gettype+0x22>
ffffffffc0207eac:	4d38                	lw	a4,88(a0)
ffffffffc0207eae:	6785                	lui	a5,0x1
ffffffffc0207eb0:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207eb4:	00f71c63          	bne	a4,a5,ffffffffc0207ecc <dev_gettype+0x22>
ffffffffc0207eb8:	6118                	ld	a4,0(a0)
ffffffffc0207eba:	6795                	lui	a5,0x5
ffffffffc0207ebc:	c701                	beqz	a4,ffffffffc0207ec4 <dev_gettype+0x1a>
ffffffffc0207ebe:	c19c                	sw	a5,0(a1)
ffffffffc0207ec0:	4501                	li	a0,0
ffffffffc0207ec2:	8082                	ret
ffffffffc0207ec4:	6791                	lui	a5,0x4
ffffffffc0207ec6:	c19c                	sw	a5,0(a1)
ffffffffc0207ec8:	4501                	li	a0,0
ffffffffc0207eca:	8082                	ret
ffffffffc0207ecc:	1141                	addi	sp,sp,-16
ffffffffc0207ece:	00006697          	auipc	a3,0x6
ffffffffc0207ed2:	c0a68693          	addi	a3,a3,-1014 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207ed6:	00003617          	auipc	a2,0x3
ffffffffc0207eda:	0da60613          	addi	a2,a2,218 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207ede:	05300593          	li	a1,83
ffffffffc0207ee2:	00006517          	auipc	a0,0x6
ffffffffc0207ee6:	f0650513          	addi	a0,a0,-250 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207eea:	e406                	sd	ra,8(sp)
ffffffffc0207eec:	db2f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ef0 <dev_write>:
ffffffffc0207ef0:	c911                	beqz	a0,ffffffffc0207f04 <dev_write+0x14>
ffffffffc0207ef2:	4d34                	lw	a3,88(a0)
ffffffffc0207ef4:	6705                	lui	a4,0x1
ffffffffc0207ef6:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207efa:	00e69563          	bne	a3,a4,ffffffffc0207f04 <dev_write+0x14>
ffffffffc0207efe:	711c                	ld	a5,32(a0)
ffffffffc0207f00:	4605                	li	a2,1
ffffffffc0207f02:	8782                	jr	a5
ffffffffc0207f04:	1141                	addi	sp,sp,-16
ffffffffc0207f06:	00006697          	auipc	a3,0x6
ffffffffc0207f0a:	bd268693          	addi	a3,a3,-1070 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207f0e:	00003617          	auipc	a2,0x3
ffffffffc0207f12:	0a260613          	addi	a2,a2,162 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207f16:	02c00593          	li	a1,44
ffffffffc0207f1a:	00006517          	auipc	a0,0x6
ffffffffc0207f1e:	ece50513          	addi	a0,a0,-306 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207f22:	e406                	sd	ra,8(sp)
ffffffffc0207f24:	d7af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207f28 <dev_read>:
ffffffffc0207f28:	c911                	beqz	a0,ffffffffc0207f3c <dev_read+0x14>
ffffffffc0207f2a:	4d34                	lw	a3,88(a0)
ffffffffc0207f2c:	6705                	lui	a4,0x1
ffffffffc0207f2e:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207f32:	00e69563          	bne	a3,a4,ffffffffc0207f3c <dev_read+0x14>
ffffffffc0207f36:	711c                	ld	a5,32(a0)
ffffffffc0207f38:	4601                	li	a2,0
ffffffffc0207f3a:	8782                	jr	a5
ffffffffc0207f3c:	1141                	addi	sp,sp,-16
ffffffffc0207f3e:	00006697          	auipc	a3,0x6
ffffffffc0207f42:	b9a68693          	addi	a3,a3,-1126 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207f46:	00003617          	auipc	a2,0x3
ffffffffc0207f4a:	06a60613          	addi	a2,a2,106 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207f4e:	02300593          	li	a1,35
ffffffffc0207f52:	00006517          	auipc	a0,0x6
ffffffffc0207f56:	e9650513          	addi	a0,a0,-362 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207f5a:	e406                	sd	ra,8(sp)
ffffffffc0207f5c:	d42f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207f60 <dev_close>:
ffffffffc0207f60:	c909                	beqz	a0,ffffffffc0207f72 <dev_close+0x12>
ffffffffc0207f62:	4d34                	lw	a3,88(a0)
ffffffffc0207f64:	6705                	lui	a4,0x1
ffffffffc0207f66:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207f6a:	00e69463          	bne	a3,a4,ffffffffc0207f72 <dev_close+0x12>
ffffffffc0207f6e:	6d1c                	ld	a5,24(a0)
ffffffffc0207f70:	8782                	jr	a5
ffffffffc0207f72:	1141                	addi	sp,sp,-16
ffffffffc0207f74:	00006697          	auipc	a3,0x6
ffffffffc0207f78:	b6468693          	addi	a3,a3,-1180 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207f7c:	00003617          	auipc	a2,0x3
ffffffffc0207f80:	03460613          	addi	a2,a2,52 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207f84:	45e9                	li	a1,26
ffffffffc0207f86:	00006517          	auipc	a0,0x6
ffffffffc0207f8a:	e6250513          	addi	a0,a0,-414 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207f8e:	e406                	sd	ra,8(sp)
ffffffffc0207f90:	d0ef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207f94 <dev_open>:
ffffffffc0207f94:	03c5f713          	andi	a4,a1,60
ffffffffc0207f98:	eb11                	bnez	a4,ffffffffc0207fac <dev_open+0x18>
ffffffffc0207f9a:	c919                	beqz	a0,ffffffffc0207fb0 <dev_open+0x1c>
ffffffffc0207f9c:	4d34                	lw	a3,88(a0)
ffffffffc0207f9e:	6705                	lui	a4,0x1
ffffffffc0207fa0:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207fa4:	00e69663          	bne	a3,a4,ffffffffc0207fb0 <dev_open+0x1c>
ffffffffc0207fa8:	691c                	ld	a5,16(a0)
ffffffffc0207faa:	8782                	jr	a5
ffffffffc0207fac:	5575                	li	a0,-3
ffffffffc0207fae:	8082                	ret
ffffffffc0207fb0:	1141                	addi	sp,sp,-16
ffffffffc0207fb2:	00006697          	auipc	a3,0x6
ffffffffc0207fb6:	b2668693          	addi	a3,a3,-1242 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc0207fba:	00003617          	auipc	a2,0x3
ffffffffc0207fbe:	ff660613          	addi	a2,a2,-10 # ffffffffc020afb0 <commands+0x210>
ffffffffc0207fc2:	45c5                	li	a1,17
ffffffffc0207fc4:	00006517          	auipc	a0,0x6
ffffffffc0207fc8:	e2450513          	addi	a0,a0,-476 # ffffffffc020dde8 <syscalls+0xe20>
ffffffffc0207fcc:	e406                	sd	ra,8(sp)
ffffffffc0207fce:	cd0f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207fd2 <dev_init>:
ffffffffc0207fd2:	1141                	addi	sp,sp,-16
ffffffffc0207fd4:	e406                	sd	ra,8(sp)
ffffffffc0207fd6:	542000ef          	jal	ra,ffffffffc0208518 <dev_init_stdin>
ffffffffc0207fda:	65a000ef          	jal	ra,ffffffffc0208634 <dev_init_stdout>
ffffffffc0207fde:	60a2                	ld	ra,8(sp)
ffffffffc0207fe0:	0141                	addi	sp,sp,16
ffffffffc0207fe2:	a439                	j	ffffffffc02081f0 <dev_init_disk0>

ffffffffc0207fe4 <dev_create_inode>:
ffffffffc0207fe4:	6505                	lui	a0,0x1
ffffffffc0207fe6:	1141                	addi	sp,sp,-16
ffffffffc0207fe8:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207fec:	e022                	sd	s0,0(sp)
ffffffffc0207fee:	e406                	sd	ra,8(sp)
ffffffffc0207ff0:	852ff0ef          	jal	ra,ffffffffc0207042 <__alloc_inode>
ffffffffc0207ff4:	842a                	mv	s0,a0
ffffffffc0207ff6:	c901                	beqz	a0,ffffffffc0208006 <dev_create_inode+0x22>
ffffffffc0207ff8:	4601                	li	a2,0
ffffffffc0207ffa:	00006597          	auipc	a1,0x6
ffffffffc0207ffe:	e0658593          	addi	a1,a1,-506 # ffffffffc020de00 <dev_node_ops>
ffffffffc0208002:	85cff0ef          	jal	ra,ffffffffc020705e <inode_init>
ffffffffc0208006:	60a2                	ld	ra,8(sp)
ffffffffc0208008:	8522                	mv	a0,s0
ffffffffc020800a:	6402                	ld	s0,0(sp)
ffffffffc020800c:	0141                	addi	sp,sp,16
ffffffffc020800e:	8082                	ret

ffffffffc0208010 <disk0_open>:
ffffffffc0208010:	4501                	li	a0,0
ffffffffc0208012:	8082                	ret

ffffffffc0208014 <disk0_close>:
ffffffffc0208014:	4501                	li	a0,0
ffffffffc0208016:	8082                	ret

ffffffffc0208018 <disk0_ioctl>:
ffffffffc0208018:	5531                	li	a0,-20
ffffffffc020801a:	8082                	ret

ffffffffc020801c <disk0_io>:
ffffffffc020801c:	659c                	ld	a5,8(a1)
ffffffffc020801e:	7159                	addi	sp,sp,-112
ffffffffc0208020:	eca6                	sd	s1,88(sp)
ffffffffc0208022:	f45e                	sd	s7,40(sp)
ffffffffc0208024:	6d84                	ld	s1,24(a1)
ffffffffc0208026:	6b85                	lui	s7,0x1
ffffffffc0208028:	1bfd                	addi	s7,s7,-1
ffffffffc020802a:	e4ce                	sd	s3,72(sp)
ffffffffc020802c:	43f7d993          	srai	s3,a5,0x3f
ffffffffc0208030:	0179f9b3          	and	s3,s3,s7
ffffffffc0208034:	99be                	add	s3,s3,a5
ffffffffc0208036:	8fc5                	or	a5,a5,s1
ffffffffc0208038:	f486                	sd	ra,104(sp)
ffffffffc020803a:	f0a2                	sd	s0,96(sp)
ffffffffc020803c:	e8ca                	sd	s2,80(sp)
ffffffffc020803e:	e0d2                	sd	s4,64(sp)
ffffffffc0208040:	fc56                	sd	s5,56(sp)
ffffffffc0208042:	f85a                	sd	s6,48(sp)
ffffffffc0208044:	f062                	sd	s8,32(sp)
ffffffffc0208046:	ec66                	sd	s9,24(sp)
ffffffffc0208048:	e86a                	sd	s10,16(sp)
ffffffffc020804a:	0177f7b3          	and	a5,a5,s7
ffffffffc020804e:	10079d63          	bnez	a5,ffffffffc0208168 <disk0_io+0x14c>
ffffffffc0208052:	40c9d993          	srai	s3,s3,0xc
ffffffffc0208056:	00c4d713          	srli	a4,s1,0xc
ffffffffc020805a:	2981                	sext.w	s3,s3
ffffffffc020805c:	2701                	sext.w	a4,a4
ffffffffc020805e:	00e987bb          	addw	a5,s3,a4
ffffffffc0208062:	6114                	ld	a3,0(a0)
ffffffffc0208064:	1782                	slli	a5,a5,0x20
ffffffffc0208066:	9381                	srli	a5,a5,0x20
ffffffffc0208068:	10f6e063          	bltu	a3,a5,ffffffffc0208168 <disk0_io+0x14c>
ffffffffc020806c:	4501                	li	a0,0
ffffffffc020806e:	ef19                	bnez	a4,ffffffffc020808c <disk0_io+0x70>
ffffffffc0208070:	70a6                	ld	ra,104(sp)
ffffffffc0208072:	7406                	ld	s0,96(sp)
ffffffffc0208074:	64e6                	ld	s1,88(sp)
ffffffffc0208076:	6946                	ld	s2,80(sp)
ffffffffc0208078:	69a6                	ld	s3,72(sp)
ffffffffc020807a:	6a06                	ld	s4,64(sp)
ffffffffc020807c:	7ae2                	ld	s5,56(sp)
ffffffffc020807e:	7b42                	ld	s6,48(sp)
ffffffffc0208080:	7ba2                	ld	s7,40(sp)
ffffffffc0208082:	7c02                	ld	s8,32(sp)
ffffffffc0208084:	6ce2                	ld	s9,24(sp)
ffffffffc0208086:	6d42                	ld	s10,16(sp)
ffffffffc0208088:	6165                	addi	sp,sp,112
ffffffffc020808a:	8082                	ret
ffffffffc020808c:	0008c517          	auipc	a0,0x8c
ffffffffc0208090:	7b450513          	addi	a0,a0,1972 # ffffffffc0294840 <disk0_sem>
ffffffffc0208094:	8b2e                	mv	s6,a1
ffffffffc0208096:	8c32                	mv	s8,a2
ffffffffc0208098:	0008ea97          	auipc	s5,0x8e
ffffffffc020809c:	860a8a93          	addi	s5,s5,-1952 # ffffffffc02958f8 <disk0_buffer>
ffffffffc02080a0:	b52fc0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02080a4:	6c91                	lui	s9,0x4
ffffffffc02080a6:	e4b9                	bnez	s1,ffffffffc02080f4 <disk0_io+0xd8>
ffffffffc02080a8:	a845                	j	ffffffffc0208158 <disk0_io+0x13c>
ffffffffc02080aa:	00c4d413          	srli	s0,s1,0xc
ffffffffc02080ae:	0034169b          	slliw	a3,s0,0x3
ffffffffc02080b2:	00068d1b          	sext.w	s10,a3
ffffffffc02080b6:	1682                	slli	a3,a3,0x20
ffffffffc02080b8:	2401                	sext.w	s0,s0
ffffffffc02080ba:	9281                	srli	a3,a3,0x20
ffffffffc02080bc:	8926                	mv	s2,s1
ffffffffc02080be:	00399a1b          	slliw	s4,s3,0x3
ffffffffc02080c2:	862e                	mv	a2,a1
ffffffffc02080c4:	4509                	li	a0,2
ffffffffc02080c6:	85d2                	mv	a1,s4
ffffffffc02080c8:	a79f80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc02080cc:	e165                	bnez	a0,ffffffffc02081ac <disk0_io+0x190>
ffffffffc02080ce:	000ab583          	ld	a1,0(s5)
ffffffffc02080d2:	0038                	addi	a4,sp,8
ffffffffc02080d4:	4685                	li	a3,1
ffffffffc02080d6:	864a                	mv	a2,s2
ffffffffc02080d8:	855a                	mv	a0,s6
ffffffffc02080da:	9a0fd0ef          	jal	ra,ffffffffc020527a <iobuf_move>
ffffffffc02080de:	67a2                	ld	a5,8(sp)
ffffffffc02080e0:	09279663          	bne	a5,s2,ffffffffc020816c <disk0_io+0x150>
ffffffffc02080e4:	017977b3          	and	a5,s2,s7
ffffffffc02080e8:	e3d1                	bnez	a5,ffffffffc020816c <disk0_io+0x150>
ffffffffc02080ea:	412484b3          	sub	s1,s1,s2
ffffffffc02080ee:	013409bb          	addw	s3,s0,s3
ffffffffc02080f2:	c0bd                	beqz	s1,ffffffffc0208158 <disk0_io+0x13c>
ffffffffc02080f4:	000ab583          	ld	a1,0(s5)
ffffffffc02080f8:	000c1b63          	bnez	s8,ffffffffc020810e <disk0_io+0xf2>
ffffffffc02080fc:	fb94e7e3          	bltu	s1,s9,ffffffffc02080aa <disk0_io+0x8e>
ffffffffc0208100:	02000693          	li	a3,32
ffffffffc0208104:	02000d13          	li	s10,32
ffffffffc0208108:	4411                	li	s0,4
ffffffffc020810a:	6911                	lui	s2,0x4
ffffffffc020810c:	bf4d                	j	ffffffffc02080be <disk0_io+0xa2>
ffffffffc020810e:	0038                	addi	a4,sp,8
ffffffffc0208110:	4681                	li	a3,0
ffffffffc0208112:	6611                	lui	a2,0x4
ffffffffc0208114:	855a                	mv	a0,s6
ffffffffc0208116:	964fd0ef          	jal	ra,ffffffffc020527a <iobuf_move>
ffffffffc020811a:	6422                	ld	s0,8(sp)
ffffffffc020811c:	c825                	beqz	s0,ffffffffc020818c <disk0_io+0x170>
ffffffffc020811e:	0684e763          	bltu	s1,s0,ffffffffc020818c <disk0_io+0x170>
ffffffffc0208122:	017477b3          	and	a5,s0,s7
ffffffffc0208126:	e3bd                	bnez	a5,ffffffffc020818c <disk0_io+0x170>
ffffffffc0208128:	8031                	srli	s0,s0,0xc
ffffffffc020812a:	0034179b          	slliw	a5,s0,0x3
ffffffffc020812e:	000ab603          	ld	a2,0(s5)
ffffffffc0208132:	0039991b          	slliw	s2,s3,0x3
ffffffffc0208136:	02079693          	slli	a3,a5,0x20
ffffffffc020813a:	9281                	srli	a3,a3,0x20
ffffffffc020813c:	85ca                	mv	a1,s2
ffffffffc020813e:	4509                	li	a0,2
ffffffffc0208140:	2401                	sext.w	s0,s0
ffffffffc0208142:	00078a1b          	sext.w	s4,a5
ffffffffc0208146:	a91f80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc020814a:	e151                	bnez	a0,ffffffffc02081ce <disk0_io+0x1b2>
ffffffffc020814c:	6922                	ld	s2,8(sp)
ffffffffc020814e:	013409bb          	addw	s3,s0,s3
ffffffffc0208152:	412484b3          	sub	s1,s1,s2
ffffffffc0208156:	fcd9                	bnez	s1,ffffffffc02080f4 <disk0_io+0xd8>
ffffffffc0208158:	0008c517          	auipc	a0,0x8c
ffffffffc020815c:	6e850513          	addi	a0,a0,1768 # ffffffffc0294840 <disk0_sem>
ffffffffc0208160:	a8efc0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0208164:	4501                	li	a0,0
ffffffffc0208166:	b729                	j	ffffffffc0208070 <disk0_io+0x54>
ffffffffc0208168:	5575                	li	a0,-3
ffffffffc020816a:	b719                	j	ffffffffc0208070 <disk0_io+0x54>
ffffffffc020816c:	00006697          	auipc	a3,0x6
ffffffffc0208170:	e0c68693          	addi	a3,a3,-500 # ffffffffc020df78 <dev_node_ops+0x178>
ffffffffc0208174:	00003617          	auipc	a2,0x3
ffffffffc0208178:	e3c60613          	addi	a2,a2,-452 # ffffffffc020afb0 <commands+0x210>
ffffffffc020817c:	06200593          	li	a1,98
ffffffffc0208180:	00006517          	auipc	a0,0x6
ffffffffc0208184:	d4050513          	addi	a0,a0,-704 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc0208188:	b16f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020818c:	00006697          	auipc	a3,0x6
ffffffffc0208190:	cf468693          	addi	a3,a3,-780 # ffffffffc020de80 <dev_node_ops+0x80>
ffffffffc0208194:	00003617          	auipc	a2,0x3
ffffffffc0208198:	e1c60613          	addi	a2,a2,-484 # ffffffffc020afb0 <commands+0x210>
ffffffffc020819c:	05700593          	li	a1,87
ffffffffc02081a0:	00006517          	auipc	a0,0x6
ffffffffc02081a4:	d2050513          	addi	a0,a0,-736 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc02081a8:	af6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02081ac:	88aa                	mv	a7,a0
ffffffffc02081ae:	886a                	mv	a6,s10
ffffffffc02081b0:	87a2                	mv	a5,s0
ffffffffc02081b2:	8752                	mv	a4,s4
ffffffffc02081b4:	86ce                	mv	a3,s3
ffffffffc02081b6:	00006617          	auipc	a2,0x6
ffffffffc02081ba:	d7a60613          	addi	a2,a2,-646 # ffffffffc020df30 <dev_node_ops+0x130>
ffffffffc02081be:	02d00593          	li	a1,45
ffffffffc02081c2:	00006517          	auipc	a0,0x6
ffffffffc02081c6:	cfe50513          	addi	a0,a0,-770 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc02081ca:	ad4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02081ce:	88aa                	mv	a7,a0
ffffffffc02081d0:	8852                	mv	a6,s4
ffffffffc02081d2:	87a2                	mv	a5,s0
ffffffffc02081d4:	874a                	mv	a4,s2
ffffffffc02081d6:	86ce                	mv	a3,s3
ffffffffc02081d8:	00006617          	auipc	a2,0x6
ffffffffc02081dc:	d0860613          	addi	a2,a2,-760 # ffffffffc020dee0 <dev_node_ops+0xe0>
ffffffffc02081e0:	03700593          	li	a1,55
ffffffffc02081e4:	00006517          	auipc	a0,0x6
ffffffffc02081e8:	cdc50513          	addi	a0,a0,-804 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc02081ec:	ab2f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02081f0 <dev_init_disk0>:
ffffffffc02081f0:	1101                	addi	sp,sp,-32
ffffffffc02081f2:	ec06                	sd	ra,24(sp)
ffffffffc02081f4:	e822                	sd	s0,16(sp)
ffffffffc02081f6:	e426                	sd	s1,8(sp)
ffffffffc02081f8:	dedff0ef          	jal	ra,ffffffffc0207fe4 <dev_create_inode>
ffffffffc02081fc:	c541                	beqz	a0,ffffffffc0208284 <dev_init_disk0+0x94>
ffffffffc02081fe:	4d38                	lw	a4,88(a0)
ffffffffc0208200:	6485                	lui	s1,0x1
ffffffffc0208202:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208206:	842a                	mv	s0,a0
ffffffffc0208208:	0cf71f63          	bne	a4,a5,ffffffffc02082e6 <dev_init_disk0+0xf6>
ffffffffc020820c:	4509                	li	a0,2
ffffffffc020820e:	8e7f80ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0208212:	cd55                	beqz	a0,ffffffffc02082ce <dev_init_disk0+0xde>
ffffffffc0208214:	4509                	li	a0,2
ffffffffc0208216:	903f80ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc020821a:	00355793          	srli	a5,a0,0x3
ffffffffc020821e:	e01c                	sd	a5,0(s0)
ffffffffc0208220:	00000797          	auipc	a5,0x0
ffffffffc0208224:	df078793          	addi	a5,a5,-528 # ffffffffc0208010 <disk0_open>
ffffffffc0208228:	e81c                	sd	a5,16(s0)
ffffffffc020822a:	00000797          	auipc	a5,0x0
ffffffffc020822e:	dea78793          	addi	a5,a5,-534 # ffffffffc0208014 <disk0_close>
ffffffffc0208232:	ec1c                	sd	a5,24(s0)
ffffffffc0208234:	00000797          	auipc	a5,0x0
ffffffffc0208238:	de878793          	addi	a5,a5,-536 # ffffffffc020801c <disk0_io>
ffffffffc020823c:	f01c                	sd	a5,32(s0)
ffffffffc020823e:	00000797          	auipc	a5,0x0
ffffffffc0208242:	dda78793          	addi	a5,a5,-550 # ffffffffc0208018 <disk0_ioctl>
ffffffffc0208246:	f41c                	sd	a5,40(s0)
ffffffffc0208248:	4585                	li	a1,1
ffffffffc020824a:	0008c517          	auipc	a0,0x8c
ffffffffc020824e:	5f650513          	addi	a0,a0,1526 # ffffffffc0294840 <disk0_sem>
ffffffffc0208252:	e404                	sd	s1,8(s0)
ffffffffc0208254:	994fc0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0208258:	6511                	lui	a0,0x4
ffffffffc020825a:	d35f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020825e:	0008d797          	auipc	a5,0x8d
ffffffffc0208262:	68a7bd23          	sd	a0,1690(a5) # ffffffffc02958f8 <disk0_buffer>
ffffffffc0208266:	c921                	beqz	a0,ffffffffc02082b6 <dev_init_disk0+0xc6>
ffffffffc0208268:	4605                	li	a2,1
ffffffffc020826a:	85a2                	mv	a1,s0
ffffffffc020826c:	00006517          	auipc	a0,0x6
ffffffffc0208270:	d9c50513          	addi	a0,a0,-612 # ffffffffc020e008 <dev_node_ops+0x208>
ffffffffc0208274:	c2cff0ef          	jal	ra,ffffffffc02076a0 <vfs_add_dev>
ffffffffc0208278:	e115                	bnez	a0,ffffffffc020829c <dev_init_disk0+0xac>
ffffffffc020827a:	60e2                	ld	ra,24(sp)
ffffffffc020827c:	6442                	ld	s0,16(sp)
ffffffffc020827e:	64a2                	ld	s1,8(sp)
ffffffffc0208280:	6105                	addi	sp,sp,32
ffffffffc0208282:	8082                	ret
ffffffffc0208284:	00006617          	auipc	a2,0x6
ffffffffc0208288:	d2460613          	addi	a2,a2,-732 # ffffffffc020dfa8 <dev_node_ops+0x1a8>
ffffffffc020828c:	08700593          	li	a1,135
ffffffffc0208290:	00006517          	auipc	a0,0x6
ffffffffc0208294:	c3050513          	addi	a0,a0,-976 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc0208298:	a06f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020829c:	86aa                	mv	a3,a0
ffffffffc020829e:	00006617          	auipc	a2,0x6
ffffffffc02082a2:	d7260613          	addi	a2,a2,-654 # ffffffffc020e010 <dev_node_ops+0x210>
ffffffffc02082a6:	08d00593          	li	a1,141
ffffffffc02082aa:	00006517          	auipc	a0,0x6
ffffffffc02082ae:	c1650513          	addi	a0,a0,-1002 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc02082b2:	9ecf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082b6:	00006617          	auipc	a2,0x6
ffffffffc02082ba:	d3260613          	addi	a2,a2,-718 # ffffffffc020dfe8 <dev_node_ops+0x1e8>
ffffffffc02082be:	07f00593          	li	a1,127
ffffffffc02082c2:	00006517          	auipc	a0,0x6
ffffffffc02082c6:	bfe50513          	addi	a0,a0,-1026 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc02082ca:	9d4f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082ce:	00006617          	auipc	a2,0x6
ffffffffc02082d2:	cfa60613          	addi	a2,a2,-774 # ffffffffc020dfc8 <dev_node_ops+0x1c8>
ffffffffc02082d6:	07300593          	li	a1,115
ffffffffc02082da:	00006517          	auipc	a0,0x6
ffffffffc02082de:	be650513          	addi	a0,a0,-1050 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc02082e2:	9bcf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082e6:	00005697          	auipc	a3,0x5
ffffffffc02082ea:	7f268693          	addi	a3,a3,2034 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc02082ee:	00003617          	auipc	a2,0x3
ffffffffc02082f2:	cc260613          	addi	a2,a2,-830 # ffffffffc020afb0 <commands+0x210>
ffffffffc02082f6:	08900593          	li	a1,137
ffffffffc02082fa:	00006517          	auipc	a0,0x6
ffffffffc02082fe:	bc650513          	addi	a0,a0,-1082 # ffffffffc020dec0 <dev_node_ops+0xc0>
ffffffffc0208302:	99cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208306 <stdin_open>:
ffffffffc0208306:	4501                	li	a0,0
ffffffffc0208308:	e191                	bnez	a1,ffffffffc020830c <stdin_open+0x6>
ffffffffc020830a:	8082                	ret
ffffffffc020830c:	5575                	li	a0,-3
ffffffffc020830e:	8082                	ret

ffffffffc0208310 <stdin_close>:
ffffffffc0208310:	4501                	li	a0,0
ffffffffc0208312:	8082                	ret

ffffffffc0208314 <stdin_ioctl>:
ffffffffc0208314:	5575                	li	a0,-3
ffffffffc0208316:	8082                	ret

ffffffffc0208318 <stdin_io>:
ffffffffc0208318:	7135                	addi	sp,sp,-160
ffffffffc020831a:	ed06                	sd	ra,152(sp)
ffffffffc020831c:	e922                	sd	s0,144(sp)
ffffffffc020831e:	e526                	sd	s1,136(sp)
ffffffffc0208320:	e14a                	sd	s2,128(sp)
ffffffffc0208322:	fcce                	sd	s3,120(sp)
ffffffffc0208324:	f8d2                	sd	s4,112(sp)
ffffffffc0208326:	f4d6                	sd	s5,104(sp)
ffffffffc0208328:	f0da                	sd	s6,96(sp)
ffffffffc020832a:	ecde                	sd	s7,88(sp)
ffffffffc020832c:	e8e2                	sd	s8,80(sp)
ffffffffc020832e:	e4e6                	sd	s9,72(sp)
ffffffffc0208330:	e0ea                	sd	s10,64(sp)
ffffffffc0208332:	fc6e                	sd	s11,56(sp)
ffffffffc0208334:	14061163          	bnez	a2,ffffffffc0208476 <stdin_io+0x15e>
ffffffffc0208338:	0005bd83          	ld	s11,0(a1)
ffffffffc020833c:	0185bd03          	ld	s10,24(a1)
ffffffffc0208340:	8b2e                	mv	s6,a1
ffffffffc0208342:	100027f3          	csrr	a5,sstatus
ffffffffc0208346:	8b89                	andi	a5,a5,2
ffffffffc0208348:	10079e63          	bnez	a5,ffffffffc0208464 <stdin_io+0x14c>
ffffffffc020834c:	4401                	li	s0,0
ffffffffc020834e:	100d0963          	beqz	s10,ffffffffc0208460 <stdin_io+0x148>
ffffffffc0208352:	0008d997          	auipc	s3,0x8d
ffffffffc0208356:	5ae98993          	addi	s3,s3,1454 # ffffffffc0295900 <p_rpos>
ffffffffc020835a:	0009b783          	ld	a5,0(s3)
ffffffffc020835e:	800004b7          	lui	s1,0x80000
ffffffffc0208362:	6c85                	lui	s9,0x1
ffffffffc0208364:	4a81                	li	s5,0
ffffffffc0208366:	0008da17          	auipc	s4,0x8d
ffffffffc020836a:	5a2a0a13          	addi	s4,s4,1442 # ffffffffc0295908 <p_wpos>
ffffffffc020836e:	0491                	addi	s1,s1,4
ffffffffc0208370:	0008c917          	auipc	s2,0x8c
ffffffffc0208374:	4e890913          	addi	s2,s2,1256 # ffffffffc0294858 <__wait_queue>
ffffffffc0208378:	1cfd                	addi	s9,s9,-1
ffffffffc020837a:	000a3703          	ld	a4,0(s4)
ffffffffc020837e:	000a8c1b          	sext.w	s8,s5
ffffffffc0208382:	8be2                	mv	s7,s8
ffffffffc0208384:	02e7d763          	bge	a5,a4,ffffffffc02083b2 <stdin_io+0x9a>
ffffffffc0208388:	a859                	j	ffffffffc020841e <stdin_io+0x106>
ffffffffc020838a:	815fe0ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc020838e:	100027f3          	csrr	a5,sstatus
ffffffffc0208392:	8b89                	andi	a5,a5,2
ffffffffc0208394:	4401                	li	s0,0
ffffffffc0208396:	ef8d                	bnez	a5,ffffffffc02083d0 <stdin_io+0xb8>
ffffffffc0208398:	0028                	addi	a0,sp,8
ffffffffc020839a:	8eafc0ef          	jal	ra,ffffffffc0204484 <wait_in_queue>
ffffffffc020839e:	e121                	bnez	a0,ffffffffc02083de <stdin_io+0xc6>
ffffffffc02083a0:	47c2                	lw	a5,16(sp)
ffffffffc02083a2:	04979563          	bne	a5,s1,ffffffffc02083ec <stdin_io+0xd4>
ffffffffc02083a6:	0009b783          	ld	a5,0(s3)
ffffffffc02083aa:	000a3703          	ld	a4,0(s4)
ffffffffc02083ae:	06e7c863          	blt	a5,a4,ffffffffc020841e <stdin_io+0x106>
ffffffffc02083b2:	8626                	mv	a2,s1
ffffffffc02083b4:	002c                	addi	a1,sp,8
ffffffffc02083b6:	854a                	mv	a0,s2
ffffffffc02083b8:	9f6fc0ef          	jal	ra,ffffffffc02045ae <wait_current_set>
ffffffffc02083bc:	d479                	beqz	s0,ffffffffc020838a <stdin_io+0x72>
ffffffffc02083be:	8aff80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02083c2:	fdcfe0ef          	jal	ra,ffffffffc0206b9e <schedule>
ffffffffc02083c6:	100027f3          	csrr	a5,sstatus
ffffffffc02083ca:	8b89                	andi	a5,a5,2
ffffffffc02083cc:	4401                	li	s0,0
ffffffffc02083ce:	d7e9                	beqz	a5,ffffffffc0208398 <stdin_io+0x80>
ffffffffc02083d0:	8a3f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02083d4:	0028                	addi	a0,sp,8
ffffffffc02083d6:	4405                	li	s0,1
ffffffffc02083d8:	8acfc0ef          	jal	ra,ffffffffc0204484 <wait_in_queue>
ffffffffc02083dc:	d171                	beqz	a0,ffffffffc02083a0 <stdin_io+0x88>
ffffffffc02083de:	002c                	addi	a1,sp,8
ffffffffc02083e0:	854a                	mv	a0,s2
ffffffffc02083e2:	848fc0ef          	jal	ra,ffffffffc020442a <wait_queue_del>
ffffffffc02083e6:	47c2                	lw	a5,16(sp)
ffffffffc02083e8:	fa978fe3          	beq	a5,s1,ffffffffc02083a6 <stdin_io+0x8e>
ffffffffc02083ec:	e435                	bnez	s0,ffffffffc0208458 <stdin_io+0x140>
ffffffffc02083ee:	060b8963          	beqz	s7,ffffffffc0208460 <stdin_io+0x148>
ffffffffc02083f2:	018b3783          	ld	a5,24(s6)
ffffffffc02083f6:	41578ab3          	sub	s5,a5,s5
ffffffffc02083fa:	015b3c23          	sd	s5,24(s6)
ffffffffc02083fe:	60ea                	ld	ra,152(sp)
ffffffffc0208400:	644a                	ld	s0,144(sp)
ffffffffc0208402:	64aa                	ld	s1,136(sp)
ffffffffc0208404:	690a                	ld	s2,128(sp)
ffffffffc0208406:	79e6                	ld	s3,120(sp)
ffffffffc0208408:	7a46                	ld	s4,112(sp)
ffffffffc020840a:	7aa6                	ld	s5,104(sp)
ffffffffc020840c:	7b06                	ld	s6,96(sp)
ffffffffc020840e:	6c46                	ld	s8,80(sp)
ffffffffc0208410:	6ca6                	ld	s9,72(sp)
ffffffffc0208412:	6d06                	ld	s10,64(sp)
ffffffffc0208414:	7de2                	ld	s11,56(sp)
ffffffffc0208416:	855e                	mv	a0,s7
ffffffffc0208418:	6be6                	ld	s7,88(sp)
ffffffffc020841a:	610d                	addi	sp,sp,160
ffffffffc020841c:	8082                	ret
ffffffffc020841e:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208422:	03475693          	srli	a3,a4,0x34
ffffffffc0208426:	00d78733          	add	a4,a5,a3
ffffffffc020842a:	01977733          	and	a4,a4,s9
ffffffffc020842e:	8f15                	sub	a4,a4,a3
ffffffffc0208430:	0008c697          	auipc	a3,0x8c
ffffffffc0208434:	43868693          	addi	a3,a3,1080 # ffffffffc0294868 <stdin_buffer>
ffffffffc0208438:	9736                	add	a4,a4,a3
ffffffffc020843a:	00074683          	lbu	a3,0(a4)
ffffffffc020843e:	0785                	addi	a5,a5,1
ffffffffc0208440:	015d8733          	add	a4,s11,s5
ffffffffc0208444:	00d70023          	sb	a3,0(a4)
ffffffffc0208448:	00f9b023          	sd	a5,0(s3)
ffffffffc020844c:	0a85                	addi	s5,s5,1
ffffffffc020844e:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208452:	f3aae4e3          	bltu	s5,s10,ffffffffc020837a <stdin_io+0x62>
ffffffffc0208456:	dc51                	beqz	s0,ffffffffc02083f2 <stdin_io+0xda>
ffffffffc0208458:	815f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020845c:	f80b9be3          	bnez	s7,ffffffffc02083f2 <stdin_io+0xda>
ffffffffc0208460:	4b81                	li	s7,0
ffffffffc0208462:	bf71                	j	ffffffffc02083fe <stdin_io+0xe6>
ffffffffc0208464:	80ff80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208468:	4405                	li	s0,1
ffffffffc020846a:	ee0d14e3          	bnez	s10,ffffffffc0208352 <stdin_io+0x3a>
ffffffffc020846e:	ffef80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208472:	4b81                	li	s7,0
ffffffffc0208474:	b769                	j	ffffffffc02083fe <stdin_io+0xe6>
ffffffffc0208476:	5bf5                	li	s7,-3
ffffffffc0208478:	b759                	j	ffffffffc02083fe <stdin_io+0xe6>

ffffffffc020847a <dev_stdin_write>:
ffffffffc020847a:	e111                	bnez	a0,ffffffffc020847e <dev_stdin_write+0x4>
ffffffffc020847c:	8082                	ret
ffffffffc020847e:	1101                	addi	sp,sp,-32
ffffffffc0208480:	e822                	sd	s0,16(sp)
ffffffffc0208482:	ec06                	sd	ra,24(sp)
ffffffffc0208484:	e426                	sd	s1,8(sp)
ffffffffc0208486:	842a                	mv	s0,a0
ffffffffc0208488:	100027f3          	csrr	a5,sstatus
ffffffffc020848c:	8b89                	andi	a5,a5,2
ffffffffc020848e:	4481                	li	s1,0
ffffffffc0208490:	e3c1                	bnez	a5,ffffffffc0208510 <dev_stdin_write+0x96>
ffffffffc0208492:	0008d597          	auipc	a1,0x8d
ffffffffc0208496:	47658593          	addi	a1,a1,1142 # ffffffffc0295908 <p_wpos>
ffffffffc020849a:	6198                	ld	a4,0(a1)
ffffffffc020849c:	6605                	lui	a2,0x1
ffffffffc020849e:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc02084a2:	43f75693          	srai	a3,a4,0x3f
ffffffffc02084a6:	92d1                	srli	a3,a3,0x34
ffffffffc02084a8:	00d707b3          	add	a5,a4,a3
ffffffffc02084ac:	8fe9                	and	a5,a5,a0
ffffffffc02084ae:	8f95                	sub	a5,a5,a3
ffffffffc02084b0:	0008c697          	auipc	a3,0x8c
ffffffffc02084b4:	3b868693          	addi	a3,a3,952 # ffffffffc0294868 <stdin_buffer>
ffffffffc02084b8:	97b6                	add	a5,a5,a3
ffffffffc02084ba:	00878023          	sb	s0,0(a5)
ffffffffc02084be:	0008d797          	auipc	a5,0x8d
ffffffffc02084c2:	4427b783          	ld	a5,1090(a5) # ffffffffc0295900 <p_rpos>
ffffffffc02084c6:	40f707b3          	sub	a5,a4,a5
ffffffffc02084ca:	00c7d463          	bge	a5,a2,ffffffffc02084d2 <dev_stdin_write+0x58>
ffffffffc02084ce:	0705                	addi	a4,a4,1
ffffffffc02084d0:	e198                	sd	a4,0(a1)
ffffffffc02084d2:	0008c517          	auipc	a0,0x8c
ffffffffc02084d6:	38650513          	addi	a0,a0,902 # ffffffffc0294858 <__wait_queue>
ffffffffc02084da:	f9ffb0ef          	jal	ra,ffffffffc0204478 <wait_queue_empty>
ffffffffc02084de:	cd09                	beqz	a0,ffffffffc02084f8 <dev_stdin_write+0x7e>
ffffffffc02084e0:	e491                	bnez	s1,ffffffffc02084ec <dev_stdin_write+0x72>
ffffffffc02084e2:	60e2                	ld	ra,24(sp)
ffffffffc02084e4:	6442                	ld	s0,16(sp)
ffffffffc02084e6:	64a2                	ld	s1,8(sp)
ffffffffc02084e8:	6105                	addi	sp,sp,32
ffffffffc02084ea:	8082                	ret
ffffffffc02084ec:	6442                	ld	s0,16(sp)
ffffffffc02084ee:	60e2                	ld	ra,24(sp)
ffffffffc02084f0:	64a2                	ld	s1,8(sp)
ffffffffc02084f2:	6105                	addi	sp,sp,32
ffffffffc02084f4:	f78f806f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02084f8:	800005b7          	lui	a1,0x80000
ffffffffc02084fc:	4605                	li	a2,1
ffffffffc02084fe:	0591                	addi	a1,a1,4
ffffffffc0208500:	0008c517          	auipc	a0,0x8c
ffffffffc0208504:	35850513          	addi	a0,a0,856 # ffffffffc0294858 <__wait_queue>
ffffffffc0208508:	fd9fb0ef          	jal	ra,ffffffffc02044e0 <wakeup_queue>
ffffffffc020850c:	d8f9                	beqz	s1,ffffffffc02084e2 <dev_stdin_write+0x68>
ffffffffc020850e:	bff9                	j	ffffffffc02084ec <dev_stdin_write+0x72>
ffffffffc0208510:	f62f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208514:	4485                	li	s1,1
ffffffffc0208516:	bfb5                	j	ffffffffc0208492 <dev_stdin_write+0x18>

ffffffffc0208518 <dev_init_stdin>:
ffffffffc0208518:	1141                	addi	sp,sp,-16
ffffffffc020851a:	e406                	sd	ra,8(sp)
ffffffffc020851c:	e022                	sd	s0,0(sp)
ffffffffc020851e:	ac7ff0ef          	jal	ra,ffffffffc0207fe4 <dev_create_inode>
ffffffffc0208522:	c93d                	beqz	a0,ffffffffc0208598 <dev_init_stdin+0x80>
ffffffffc0208524:	4d38                	lw	a4,88(a0)
ffffffffc0208526:	6785                	lui	a5,0x1
ffffffffc0208528:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020852c:	842a                	mv	s0,a0
ffffffffc020852e:	08f71e63          	bne	a4,a5,ffffffffc02085ca <dev_init_stdin+0xb2>
ffffffffc0208532:	4785                	li	a5,1
ffffffffc0208534:	e41c                	sd	a5,8(s0)
ffffffffc0208536:	00000797          	auipc	a5,0x0
ffffffffc020853a:	dd078793          	addi	a5,a5,-560 # ffffffffc0208306 <stdin_open>
ffffffffc020853e:	e81c                	sd	a5,16(s0)
ffffffffc0208540:	00000797          	auipc	a5,0x0
ffffffffc0208544:	dd078793          	addi	a5,a5,-560 # ffffffffc0208310 <stdin_close>
ffffffffc0208548:	ec1c                	sd	a5,24(s0)
ffffffffc020854a:	00000797          	auipc	a5,0x0
ffffffffc020854e:	dce78793          	addi	a5,a5,-562 # ffffffffc0208318 <stdin_io>
ffffffffc0208552:	f01c                	sd	a5,32(s0)
ffffffffc0208554:	00000797          	auipc	a5,0x0
ffffffffc0208558:	dc078793          	addi	a5,a5,-576 # ffffffffc0208314 <stdin_ioctl>
ffffffffc020855c:	f41c                	sd	a5,40(s0)
ffffffffc020855e:	0008c517          	auipc	a0,0x8c
ffffffffc0208562:	2fa50513          	addi	a0,a0,762 # ffffffffc0294858 <__wait_queue>
ffffffffc0208566:	00043023          	sd	zero,0(s0)
ffffffffc020856a:	0008d797          	auipc	a5,0x8d
ffffffffc020856e:	3807bf23          	sd	zero,926(a5) # ffffffffc0295908 <p_wpos>
ffffffffc0208572:	0008d797          	auipc	a5,0x8d
ffffffffc0208576:	3807b723          	sd	zero,910(a5) # ffffffffc0295900 <p_rpos>
ffffffffc020857a:	eabfb0ef          	jal	ra,ffffffffc0204424 <wait_queue_init>
ffffffffc020857e:	4601                	li	a2,0
ffffffffc0208580:	85a2                	mv	a1,s0
ffffffffc0208582:	00006517          	auipc	a0,0x6
ffffffffc0208586:	aee50513          	addi	a0,a0,-1298 # ffffffffc020e070 <dev_node_ops+0x270>
ffffffffc020858a:	916ff0ef          	jal	ra,ffffffffc02076a0 <vfs_add_dev>
ffffffffc020858e:	e10d                	bnez	a0,ffffffffc02085b0 <dev_init_stdin+0x98>
ffffffffc0208590:	60a2                	ld	ra,8(sp)
ffffffffc0208592:	6402                	ld	s0,0(sp)
ffffffffc0208594:	0141                	addi	sp,sp,16
ffffffffc0208596:	8082                	ret
ffffffffc0208598:	00006617          	auipc	a2,0x6
ffffffffc020859c:	a9860613          	addi	a2,a2,-1384 # ffffffffc020e030 <dev_node_ops+0x230>
ffffffffc02085a0:	07500593          	li	a1,117
ffffffffc02085a4:	00006517          	auipc	a0,0x6
ffffffffc02085a8:	aac50513          	addi	a0,a0,-1364 # ffffffffc020e050 <dev_node_ops+0x250>
ffffffffc02085ac:	ef3f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02085b0:	86aa                	mv	a3,a0
ffffffffc02085b2:	00006617          	auipc	a2,0x6
ffffffffc02085b6:	ac660613          	addi	a2,a2,-1338 # ffffffffc020e078 <dev_node_ops+0x278>
ffffffffc02085ba:	07b00593          	li	a1,123
ffffffffc02085be:	00006517          	auipc	a0,0x6
ffffffffc02085c2:	a9250513          	addi	a0,a0,-1390 # ffffffffc020e050 <dev_node_ops+0x250>
ffffffffc02085c6:	ed9f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02085ca:	00005697          	auipc	a3,0x5
ffffffffc02085ce:	50e68693          	addi	a3,a3,1294 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc02085d2:	00003617          	auipc	a2,0x3
ffffffffc02085d6:	9de60613          	addi	a2,a2,-1570 # ffffffffc020afb0 <commands+0x210>
ffffffffc02085da:	07700593          	li	a1,119
ffffffffc02085de:	00006517          	auipc	a0,0x6
ffffffffc02085e2:	a7250513          	addi	a0,a0,-1422 # ffffffffc020e050 <dev_node_ops+0x250>
ffffffffc02085e6:	eb9f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02085ea <stdout_open>:
ffffffffc02085ea:	4785                	li	a5,1
ffffffffc02085ec:	4501                	li	a0,0
ffffffffc02085ee:	00f59363          	bne	a1,a5,ffffffffc02085f4 <stdout_open+0xa>
ffffffffc02085f2:	8082                	ret
ffffffffc02085f4:	5575                	li	a0,-3
ffffffffc02085f6:	8082                	ret

ffffffffc02085f8 <stdout_close>:
ffffffffc02085f8:	4501                	li	a0,0
ffffffffc02085fa:	8082                	ret

ffffffffc02085fc <stdout_ioctl>:
ffffffffc02085fc:	5575                	li	a0,-3
ffffffffc02085fe:	8082                	ret

ffffffffc0208600 <stdout_io>:
ffffffffc0208600:	ca05                	beqz	a2,ffffffffc0208630 <stdout_io+0x30>
ffffffffc0208602:	6d9c                	ld	a5,24(a1)
ffffffffc0208604:	1101                	addi	sp,sp,-32
ffffffffc0208606:	e822                	sd	s0,16(sp)
ffffffffc0208608:	e426                	sd	s1,8(sp)
ffffffffc020860a:	ec06                	sd	ra,24(sp)
ffffffffc020860c:	6180                	ld	s0,0(a1)
ffffffffc020860e:	84ae                	mv	s1,a1
ffffffffc0208610:	cb91                	beqz	a5,ffffffffc0208624 <stdout_io+0x24>
ffffffffc0208612:	00044503          	lbu	a0,0(s0)
ffffffffc0208616:	0405                	addi	s0,s0,1
ffffffffc0208618:	bcbf70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020861c:	6c9c                	ld	a5,24(s1)
ffffffffc020861e:	17fd                	addi	a5,a5,-1
ffffffffc0208620:	ec9c                	sd	a5,24(s1)
ffffffffc0208622:	fbe5                	bnez	a5,ffffffffc0208612 <stdout_io+0x12>
ffffffffc0208624:	60e2                	ld	ra,24(sp)
ffffffffc0208626:	6442                	ld	s0,16(sp)
ffffffffc0208628:	64a2                	ld	s1,8(sp)
ffffffffc020862a:	4501                	li	a0,0
ffffffffc020862c:	6105                	addi	sp,sp,32
ffffffffc020862e:	8082                	ret
ffffffffc0208630:	5575                	li	a0,-3
ffffffffc0208632:	8082                	ret

ffffffffc0208634 <dev_init_stdout>:
ffffffffc0208634:	1141                	addi	sp,sp,-16
ffffffffc0208636:	e406                	sd	ra,8(sp)
ffffffffc0208638:	9adff0ef          	jal	ra,ffffffffc0207fe4 <dev_create_inode>
ffffffffc020863c:	c939                	beqz	a0,ffffffffc0208692 <dev_init_stdout+0x5e>
ffffffffc020863e:	4d38                	lw	a4,88(a0)
ffffffffc0208640:	6785                	lui	a5,0x1
ffffffffc0208642:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208646:	85aa                	mv	a1,a0
ffffffffc0208648:	06f71e63          	bne	a4,a5,ffffffffc02086c4 <dev_init_stdout+0x90>
ffffffffc020864c:	4785                	li	a5,1
ffffffffc020864e:	e51c                	sd	a5,8(a0)
ffffffffc0208650:	00000797          	auipc	a5,0x0
ffffffffc0208654:	f9a78793          	addi	a5,a5,-102 # ffffffffc02085ea <stdout_open>
ffffffffc0208658:	e91c                	sd	a5,16(a0)
ffffffffc020865a:	00000797          	auipc	a5,0x0
ffffffffc020865e:	f9e78793          	addi	a5,a5,-98 # ffffffffc02085f8 <stdout_close>
ffffffffc0208662:	ed1c                	sd	a5,24(a0)
ffffffffc0208664:	00000797          	auipc	a5,0x0
ffffffffc0208668:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208600 <stdout_io>
ffffffffc020866c:	f11c                	sd	a5,32(a0)
ffffffffc020866e:	00000797          	auipc	a5,0x0
ffffffffc0208672:	f8e78793          	addi	a5,a5,-114 # ffffffffc02085fc <stdout_ioctl>
ffffffffc0208676:	00053023          	sd	zero,0(a0)
ffffffffc020867a:	f51c                	sd	a5,40(a0)
ffffffffc020867c:	4601                	li	a2,0
ffffffffc020867e:	00006517          	auipc	a0,0x6
ffffffffc0208682:	a5a50513          	addi	a0,a0,-1446 # ffffffffc020e0d8 <dev_node_ops+0x2d8>
ffffffffc0208686:	81aff0ef          	jal	ra,ffffffffc02076a0 <vfs_add_dev>
ffffffffc020868a:	e105                	bnez	a0,ffffffffc02086aa <dev_init_stdout+0x76>
ffffffffc020868c:	60a2                	ld	ra,8(sp)
ffffffffc020868e:	0141                	addi	sp,sp,16
ffffffffc0208690:	8082                	ret
ffffffffc0208692:	00006617          	auipc	a2,0x6
ffffffffc0208696:	a0660613          	addi	a2,a2,-1530 # ffffffffc020e098 <dev_node_ops+0x298>
ffffffffc020869a:	03700593          	li	a1,55
ffffffffc020869e:	00006517          	auipc	a0,0x6
ffffffffc02086a2:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020e0b8 <dev_node_ops+0x2b8>
ffffffffc02086a6:	df9f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02086aa:	86aa                	mv	a3,a0
ffffffffc02086ac:	00006617          	auipc	a2,0x6
ffffffffc02086b0:	a3460613          	addi	a2,a2,-1484 # ffffffffc020e0e0 <dev_node_ops+0x2e0>
ffffffffc02086b4:	03d00593          	li	a1,61
ffffffffc02086b8:	00006517          	auipc	a0,0x6
ffffffffc02086bc:	a0050513          	addi	a0,a0,-1536 # ffffffffc020e0b8 <dev_node_ops+0x2b8>
ffffffffc02086c0:	ddff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02086c4:	00005697          	auipc	a3,0x5
ffffffffc02086c8:	41468693          	addi	a3,a3,1044 # ffffffffc020dad8 <syscalls+0xb10>
ffffffffc02086cc:	00003617          	auipc	a2,0x3
ffffffffc02086d0:	8e460613          	addi	a2,a2,-1820 # ffffffffc020afb0 <commands+0x210>
ffffffffc02086d4:	03900593          	li	a1,57
ffffffffc02086d8:	00006517          	auipc	a0,0x6
ffffffffc02086dc:	9e050513          	addi	a0,a0,-1568 # ffffffffc020e0b8 <dev_node_ops+0x2b8>
ffffffffc02086e0:	dbff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02086e4 <bitmap_translate.part.0>:
ffffffffc02086e4:	1141                	addi	sp,sp,-16
ffffffffc02086e6:	00006697          	auipc	a3,0x6
ffffffffc02086ea:	a1a68693          	addi	a3,a3,-1510 # ffffffffc020e100 <dev_node_ops+0x300>
ffffffffc02086ee:	00003617          	auipc	a2,0x3
ffffffffc02086f2:	8c260613          	addi	a2,a2,-1854 # ffffffffc020afb0 <commands+0x210>
ffffffffc02086f6:	04c00593          	li	a1,76
ffffffffc02086fa:	00006517          	auipc	a0,0x6
ffffffffc02086fe:	a1e50513          	addi	a0,a0,-1506 # ffffffffc020e118 <dev_node_ops+0x318>
ffffffffc0208702:	e406                	sd	ra,8(sp)
ffffffffc0208704:	d9bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208708 <bitmap_create>:
ffffffffc0208708:	7139                	addi	sp,sp,-64
ffffffffc020870a:	fc06                	sd	ra,56(sp)
ffffffffc020870c:	f822                	sd	s0,48(sp)
ffffffffc020870e:	f426                	sd	s1,40(sp)
ffffffffc0208710:	f04a                	sd	s2,32(sp)
ffffffffc0208712:	ec4e                	sd	s3,24(sp)
ffffffffc0208714:	e852                	sd	s4,16(sp)
ffffffffc0208716:	e456                	sd	s5,8(sp)
ffffffffc0208718:	c14d                	beqz	a0,ffffffffc02087ba <bitmap_create+0xb2>
ffffffffc020871a:	842a                	mv	s0,a0
ffffffffc020871c:	4541                	li	a0,16
ffffffffc020871e:	871f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208722:	84aa                	mv	s1,a0
ffffffffc0208724:	cd25                	beqz	a0,ffffffffc020879c <bitmap_create+0x94>
ffffffffc0208726:	02041a13          	slli	s4,s0,0x20
ffffffffc020872a:	020a5a13          	srli	s4,s4,0x20
ffffffffc020872e:	01fa0793          	addi	a5,s4,31
ffffffffc0208732:	0057d993          	srli	s3,a5,0x5
ffffffffc0208736:	00299a93          	slli	s5,s3,0x2
ffffffffc020873a:	8556                	mv	a0,s5
ffffffffc020873c:	894e                	mv	s2,s3
ffffffffc020873e:	851f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208742:	c53d                	beqz	a0,ffffffffc02087b0 <bitmap_create+0xa8>
ffffffffc0208744:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208748:	c080                	sw	s0,0(s1)
ffffffffc020874a:	8656                	mv	a2,s5
ffffffffc020874c:	0ff00593          	li	a1,255
ffffffffc0208750:	37e020ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0208754:	e488                	sd	a0,8(s1)
ffffffffc0208756:	0996                	slli	s3,s3,0x5
ffffffffc0208758:	053a0263          	beq	s4,s3,ffffffffc020879c <bitmap_create+0x94>
ffffffffc020875c:	fff9079b          	addiw	a5,s2,-1
ffffffffc0208760:	0057969b          	slliw	a3,a5,0x5
ffffffffc0208764:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208768:	40d4073b          	subw	a4,s0,a3
ffffffffc020876c:	0054541b          	srliw	s0,s0,0x5
ffffffffc0208770:	08f61463          	bne	a2,a5,ffffffffc02087f8 <bitmap_create+0xf0>
ffffffffc0208774:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208778:	47f9                	li	a5,30
ffffffffc020877a:	04d7ef63          	bltu	a5,a3,ffffffffc02087d8 <bitmap_create+0xd0>
ffffffffc020877e:	1402                	slli	s0,s0,0x20
ffffffffc0208780:	8079                	srli	s0,s0,0x1e
ffffffffc0208782:	9522                	add	a0,a0,s0
ffffffffc0208784:	411c                	lw	a5,0(a0)
ffffffffc0208786:	4585                	li	a1,1
ffffffffc0208788:	02000613          	li	a2,32
ffffffffc020878c:	00e596bb          	sllw	a3,a1,a4
ffffffffc0208790:	8fb5                	xor	a5,a5,a3
ffffffffc0208792:	2705                	addiw	a4,a4,1
ffffffffc0208794:	2781                	sext.w	a5,a5
ffffffffc0208796:	fec71be3          	bne	a4,a2,ffffffffc020878c <bitmap_create+0x84>
ffffffffc020879a:	c11c                	sw	a5,0(a0)
ffffffffc020879c:	70e2                	ld	ra,56(sp)
ffffffffc020879e:	7442                	ld	s0,48(sp)
ffffffffc02087a0:	7902                	ld	s2,32(sp)
ffffffffc02087a2:	69e2                	ld	s3,24(sp)
ffffffffc02087a4:	6a42                	ld	s4,16(sp)
ffffffffc02087a6:	6aa2                	ld	s5,8(sp)
ffffffffc02087a8:	8526                	mv	a0,s1
ffffffffc02087aa:	74a2                	ld	s1,40(sp)
ffffffffc02087ac:	6121                	addi	sp,sp,64
ffffffffc02087ae:	8082                	ret
ffffffffc02087b0:	8526                	mv	a0,s1
ffffffffc02087b2:	88df90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02087b6:	4481                	li	s1,0
ffffffffc02087b8:	b7d5                	j	ffffffffc020879c <bitmap_create+0x94>
ffffffffc02087ba:	00006697          	auipc	a3,0x6
ffffffffc02087be:	97668693          	addi	a3,a3,-1674 # ffffffffc020e130 <dev_node_ops+0x330>
ffffffffc02087c2:	00002617          	auipc	a2,0x2
ffffffffc02087c6:	7ee60613          	addi	a2,a2,2030 # ffffffffc020afb0 <commands+0x210>
ffffffffc02087ca:	45d5                	li	a1,21
ffffffffc02087cc:	00006517          	auipc	a0,0x6
ffffffffc02087d0:	94c50513          	addi	a0,a0,-1716 # ffffffffc020e118 <dev_node_ops+0x318>
ffffffffc02087d4:	ccbf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02087d8:	00006697          	auipc	a3,0x6
ffffffffc02087dc:	99868693          	addi	a3,a3,-1640 # ffffffffc020e170 <dev_node_ops+0x370>
ffffffffc02087e0:	00002617          	auipc	a2,0x2
ffffffffc02087e4:	7d060613          	addi	a2,a2,2000 # ffffffffc020afb0 <commands+0x210>
ffffffffc02087e8:	02b00593          	li	a1,43
ffffffffc02087ec:	00006517          	auipc	a0,0x6
ffffffffc02087f0:	92c50513          	addi	a0,a0,-1748 # ffffffffc020e118 <dev_node_ops+0x318>
ffffffffc02087f4:	cabf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02087f8:	00006697          	auipc	a3,0x6
ffffffffc02087fc:	96068693          	addi	a3,a3,-1696 # ffffffffc020e158 <dev_node_ops+0x358>
ffffffffc0208800:	00002617          	auipc	a2,0x2
ffffffffc0208804:	7b060613          	addi	a2,a2,1968 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208808:	02a00593          	li	a1,42
ffffffffc020880c:	00006517          	auipc	a0,0x6
ffffffffc0208810:	90c50513          	addi	a0,a0,-1780 # ffffffffc020e118 <dev_node_ops+0x318>
ffffffffc0208814:	c8bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208818 <bitmap_alloc>:
ffffffffc0208818:	4150                	lw	a2,4(a0)
ffffffffc020881a:	651c                	ld	a5,8(a0)
ffffffffc020881c:	c231                	beqz	a2,ffffffffc0208860 <bitmap_alloc+0x48>
ffffffffc020881e:	4701                	li	a4,0
ffffffffc0208820:	a029                	j	ffffffffc020882a <bitmap_alloc+0x12>
ffffffffc0208822:	2705                	addiw	a4,a4,1
ffffffffc0208824:	0791                	addi	a5,a5,4
ffffffffc0208826:	02e60d63          	beq	a2,a4,ffffffffc0208860 <bitmap_alloc+0x48>
ffffffffc020882a:	4394                	lw	a3,0(a5)
ffffffffc020882c:	dafd                	beqz	a3,ffffffffc0208822 <bitmap_alloc+0xa>
ffffffffc020882e:	4501                	li	a0,0
ffffffffc0208830:	4885                	li	a7,1
ffffffffc0208832:	8e36                	mv	t3,a3
ffffffffc0208834:	02000313          	li	t1,32
ffffffffc0208838:	a021                	j	ffffffffc0208840 <bitmap_alloc+0x28>
ffffffffc020883a:	2505                	addiw	a0,a0,1
ffffffffc020883c:	02650463          	beq	a0,t1,ffffffffc0208864 <bitmap_alloc+0x4c>
ffffffffc0208840:	00a8983b          	sllw	a6,a7,a0
ffffffffc0208844:	0106f633          	and	a2,a3,a6
ffffffffc0208848:	2601                	sext.w	a2,a2
ffffffffc020884a:	da65                	beqz	a2,ffffffffc020883a <bitmap_alloc+0x22>
ffffffffc020884c:	010e4833          	xor	a6,t3,a6
ffffffffc0208850:	0057171b          	slliw	a4,a4,0x5
ffffffffc0208854:	9f29                	addw	a4,a4,a0
ffffffffc0208856:	0107a023          	sw	a6,0(a5)
ffffffffc020885a:	c198                	sw	a4,0(a1)
ffffffffc020885c:	4501                	li	a0,0
ffffffffc020885e:	8082                	ret
ffffffffc0208860:	5571                	li	a0,-4
ffffffffc0208862:	8082                	ret
ffffffffc0208864:	1141                	addi	sp,sp,-16
ffffffffc0208866:	00003697          	auipc	a3,0x3
ffffffffc020886a:	7ca68693          	addi	a3,a3,1994 # ffffffffc020c030 <default_pmm_manager+0x598>
ffffffffc020886e:	00002617          	auipc	a2,0x2
ffffffffc0208872:	74260613          	addi	a2,a2,1858 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208876:	04300593          	li	a1,67
ffffffffc020887a:	00006517          	auipc	a0,0x6
ffffffffc020887e:	89e50513          	addi	a0,a0,-1890 # ffffffffc020e118 <dev_node_ops+0x318>
ffffffffc0208882:	e406                	sd	ra,8(sp)
ffffffffc0208884:	c1bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208888 <bitmap_test>:
ffffffffc0208888:	411c                	lw	a5,0(a0)
ffffffffc020888a:	00f5ff63          	bgeu	a1,a5,ffffffffc02088a8 <bitmap_test+0x20>
ffffffffc020888e:	651c                	ld	a5,8(a0)
ffffffffc0208890:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0208894:	070a                	slli	a4,a4,0x2
ffffffffc0208896:	97ba                	add	a5,a5,a4
ffffffffc0208898:	4388                	lw	a0,0(a5)
ffffffffc020889a:	4785                	li	a5,1
ffffffffc020889c:	00b795bb          	sllw	a1,a5,a1
ffffffffc02088a0:	8d6d                	and	a0,a0,a1
ffffffffc02088a2:	1502                	slli	a0,a0,0x20
ffffffffc02088a4:	9101                	srli	a0,a0,0x20
ffffffffc02088a6:	8082                	ret
ffffffffc02088a8:	1141                	addi	sp,sp,-16
ffffffffc02088aa:	e406                	sd	ra,8(sp)
ffffffffc02088ac:	e39ff0ef          	jal	ra,ffffffffc02086e4 <bitmap_translate.part.0>

ffffffffc02088b0 <bitmap_free>:
ffffffffc02088b0:	411c                	lw	a5,0(a0)
ffffffffc02088b2:	1141                	addi	sp,sp,-16
ffffffffc02088b4:	e406                	sd	ra,8(sp)
ffffffffc02088b6:	02f5f463          	bgeu	a1,a5,ffffffffc02088de <bitmap_free+0x2e>
ffffffffc02088ba:	651c                	ld	a5,8(a0)
ffffffffc02088bc:	0055d71b          	srliw	a4,a1,0x5
ffffffffc02088c0:	070a                	slli	a4,a4,0x2
ffffffffc02088c2:	97ba                	add	a5,a5,a4
ffffffffc02088c4:	4398                	lw	a4,0(a5)
ffffffffc02088c6:	4685                	li	a3,1
ffffffffc02088c8:	00b695bb          	sllw	a1,a3,a1
ffffffffc02088cc:	00b776b3          	and	a3,a4,a1
ffffffffc02088d0:	2681                	sext.w	a3,a3
ffffffffc02088d2:	ea81                	bnez	a3,ffffffffc02088e2 <bitmap_free+0x32>
ffffffffc02088d4:	60a2                	ld	ra,8(sp)
ffffffffc02088d6:	8f4d                	or	a4,a4,a1
ffffffffc02088d8:	c398                	sw	a4,0(a5)
ffffffffc02088da:	0141                	addi	sp,sp,16
ffffffffc02088dc:	8082                	ret
ffffffffc02088de:	e07ff0ef          	jal	ra,ffffffffc02086e4 <bitmap_translate.part.0>
ffffffffc02088e2:	00006697          	auipc	a3,0x6
ffffffffc02088e6:	8b668693          	addi	a3,a3,-1866 # ffffffffc020e198 <dev_node_ops+0x398>
ffffffffc02088ea:	00002617          	auipc	a2,0x2
ffffffffc02088ee:	6c660613          	addi	a2,a2,1734 # ffffffffc020afb0 <commands+0x210>
ffffffffc02088f2:	05f00593          	li	a1,95
ffffffffc02088f6:	00006517          	auipc	a0,0x6
ffffffffc02088fa:	82250513          	addi	a0,a0,-2014 # ffffffffc020e118 <dev_node_ops+0x318>
ffffffffc02088fe:	ba1f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208902 <bitmap_destroy>:
ffffffffc0208902:	1141                	addi	sp,sp,-16
ffffffffc0208904:	e022                	sd	s0,0(sp)
ffffffffc0208906:	842a                	mv	s0,a0
ffffffffc0208908:	6508                	ld	a0,8(a0)
ffffffffc020890a:	e406                	sd	ra,8(sp)
ffffffffc020890c:	f32f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208910:	8522                	mv	a0,s0
ffffffffc0208912:	6402                	ld	s0,0(sp)
ffffffffc0208914:	60a2                	ld	ra,8(sp)
ffffffffc0208916:	0141                	addi	sp,sp,16
ffffffffc0208918:	f26f906f          	j	ffffffffc020203e <kfree>

ffffffffc020891c <bitmap_getdata>:
ffffffffc020891c:	c589                	beqz	a1,ffffffffc0208926 <bitmap_getdata+0xa>
ffffffffc020891e:	00456783          	lwu	a5,4(a0)
ffffffffc0208922:	078a                	slli	a5,a5,0x2
ffffffffc0208924:	e19c                	sd	a5,0(a1)
ffffffffc0208926:	6508                	ld	a0,8(a0)
ffffffffc0208928:	8082                	ret

ffffffffc020892a <sfs_init>:
ffffffffc020892a:	1141                	addi	sp,sp,-16
ffffffffc020892c:	00005517          	auipc	a0,0x5
ffffffffc0208930:	6dc50513          	addi	a0,a0,1756 # ffffffffc020e008 <dev_node_ops+0x208>
ffffffffc0208934:	e406                	sd	ra,8(sp)
ffffffffc0208936:	554000ef          	jal	ra,ffffffffc0208e8a <sfs_mount>
ffffffffc020893a:	e501                	bnez	a0,ffffffffc0208942 <sfs_init+0x18>
ffffffffc020893c:	60a2                	ld	ra,8(sp)
ffffffffc020893e:	0141                	addi	sp,sp,16
ffffffffc0208940:	8082                	ret
ffffffffc0208942:	86aa                	mv	a3,a0
ffffffffc0208944:	00006617          	auipc	a2,0x6
ffffffffc0208948:	86460613          	addi	a2,a2,-1948 # ffffffffc020e1a8 <dev_node_ops+0x3a8>
ffffffffc020894c:	45c1                	li	a1,16
ffffffffc020894e:	00006517          	auipc	a0,0x6
ffffffffc0208952:	87a50513          	addi	a0,a0,-1926 # ffffffffc020e1c8 <dev_node_ops+0x3c8>
ffffffffc0208956:	b49f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020895a <sfs_unmount>:
ffffffffc020895a:	1141                	addi	sp,sp,-16
ffffffffc020895c:	e406                	sd	ra,8(sp)
ffffffffc020895e:	e022                	sd	s0,0(sp)
ffffffffc0208960:	cd1d                	beqz	a0,ffffffffc020899e <sfs_unmount+0x44>
ffffffffc0208962:	0b052783          	lw	a5,176(a0)
ffffffffc0208966:	842a                	mv	s0,a0
ffffffffc0208968:	eb9d                	bnez	a5,ffffffffc020899e <sfs_unmount+0x44>
ffffffffc020896a:	7158                	ld	a4,160(a0)
ffffffffc020896c:	09850793          	addi	a5,a0,152
ffffffffc0208970:	02f71563          	bne	a4,a5,ffffffffc020899a <sfs_unmount+0x40>
ffffffffc0208974:	613c                	ld	a5,64(a0)
ffffffffc0208976:	e7a1                	bnez	a5,ffffffffc02089be <sfs_unmount+0x64>
ffffffffc0208978:	7d08                	ld	a0,56(a0)
ffffffffc020897a:	f89ff0ef          	jal	ra,ffffffffc0208902 <bitmap_destroy>
ffffffffc020897e:	6428                	ld	a0,72(s0)
ffffffffc0208980:	ebef90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208984:	7448                	ld	a0,168(s0)
ffffffffc0208986:	eb8f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020898a:	8522                	mv	a0,s0
ffffffffc020898c:	eb2f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208990:	4501                	li	a0,0
ffffffffc0208992:	60a2                	ld	ra,8(sp)
ffffffffc0208994:	6402                	ld	s0,0(sp)
ffffffffc0208996:	0141                	addi	sp,sp,16
ffffffffc0208998:	8082                	ret
ffffffffc020899a:	5545                	li	a0,-15
ffffffffc020899c:	bfdd                	j	ffffffffc0208992 <sfs_unmount+0x38>
ffffffffc020899e:	00006697          	auipc	a3,0x6
ffffffffc02089a2:	84268693          	addi	a3,a3,-1982 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc02089a6:	00002617          	auipc	a2,0x2
ffffffffc02089aa:	60a60613          	addi	a2,a2,1546 # ffffffffc020afb0 <commands+0x210>
ffffffffc02089ae:	04100593          	li	a1,65
ffffffffc02089b2:	00006517          	auipc	a0,0x6
ffffffffc02089b6:	85e50513          	addi	a0,a0,-1954 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc02089ba:	ae5f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02089be:	00006697          	auipc	a3,0x6
ffffffffc02089c2:	86a68693          	addi	a3,a3,-1942 # ffffffffc020e228 <dev_node_ops+0x428>
ffffffffc02089c6:	00002617          	auipc	a2,0x2
ffffffffc02089ca:	5ea60613          	addi	a2,a2,1514 # ffffffffc020afb0 <commands+0x210>
ffffffffc02089ce:	04500593          	li	a1,69
ffffffffc02089d2:	00006517          	auipc	a0,0x6
ffffffffc02089d6:	83e50513          	addi	a0,a0,-1986 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc02089da:	ac5f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02089de <sfs_cleanup>:
ffffffffc02089de:	1101                	addi	sp,sp,-32
ffffffffc02089e0:	ec06                	sd	ra,24(sp)
ffffffffc02089e2:	e822                	sd	s0,16(sp)
ffffffffc02089e4:	e426                	sd	s1,8(sp)
ffffffffc02089e6:	e04a                	sd	s2,0(sp)
ffffffffc02089e8:	c525                	beqz	a0,ffffffffc0208a50 <sfs_cleanup+0x72>
ffffffffc02089ea:	0b052783          	lw	a5,176(a0)
ffffffffc02089ee:	84aa                	mv	s1,a0
ffffffffc02089f0:	e3a5                	bnez	a5,ffffffffc0208a50 <sfs_cleanup+0x72>
ffffffffc02089f2:	4158                	lw	a4,4(a0)
ffffffffc02089f4:	4514                	lw	a3,8(a0)
ffffffffc02089f6:	00c50913          	addi	s2,a0,12
ffffffffc02089fa:	85ca                	mv	a1,s2
ffffffffc02089fc:	40d7063b          	subw	a2,a4,a3
ffffffffc0208a00:	00006517          	auipc	a0,0x6
ffffffffc0208a04:	84050513          	addi	a0,a0,-1984 # ffffffffc020e240 <dev_node_ops+0x440>
ffffffffc0208a08:	f9ef70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208a0c:	02000413          	li	s0,32
ffffffffc0208a10:	a019                	j	ffffffffc0208a16 <sfs_cleanup+0x38>
ffffffffc0208a12:	347d                	addiw	s0,s0,-1
ffffffffc0208a14:	c819                	beqz	s0,ffffffffc0208a2a <sfs_cleanup+0x4c>
ffffffffc0208a16:	7cdc                	ld	a5,184(s1)
ffffffffc0208a18:	8526                	mv	a0,s1
ffffffffc0208a1a:	9782                	jalr	a5
ffffffffc0208a1c:	f97d                	bnez	a0,ffffffffc0208a12 <sfs_cleanup+0x34>
ffffffffc0208a1e:	60e2                	ld	ra,24(sp)
ffffffffc0208a20:	6442                	ld	s0,16(sp)
ffffffffc0208a22:	64a2                	ld	s1,8(sp)
ffffffffc0208a24:	6902                	ld	s2,0(sp)
ffffffffc0208a26:	6105                	addi	sp,sp,32
ffffffffc0208a28:	8082                	ret
ffffffffc0208a2a:	6442                	ld	s0,16(sp)
ffffffffc0208a2c:	60e2                	ld	ra,24(sp)
ffffffffc0208a2e:	64a2                	ld	s1,8(sp)
ffffffffc0208a30:	86ca                	mv	a3,s2
ffffffffc0208a32:	6902                	ld	s2,0(sp)
ffffffffc0208a34:	872a                	mv	a4,a0
ffffffffc0208a36:	00006617          	auipc	a2,0x6
ffffffffc0208a3a:	82a60613          	addi	a2,a2,-2006 # ffffffffc020e260 <dev_node_ops+0x460>
ffffffffc0208a3e:	05f00593          	li	a1,95
ffffffffc0208a42:	00005517          	auipc	a0,0x5
ffffffffc0208a46:	7ce50513          	addi	a0,a0,1998 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208a4a:	6105                	addi	sp,sp,32
ffffffffc0208a4c:	abbf706f          	j	ffffffffc0200506 <__warn>
ffffffffc0208a50:	00005697          	auipc	a3,0x5
ffffffffc0208a54:	79068693          	addi	a3,a3,1936 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc0208a58:	00002617          	auipc	a2,0x2
ffffffffc0208a5c:	55860613          	addi	a2,a2,1368 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208a60:	05400593          	li	a1,84
ffffffffc0208a64:	00005517          	auipc	a0,0x5
ffffffffc0208a68:	7ac50513          	addi	a0,a0,1964 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208a6c:	a33f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a70 <sfs_sync>:
ffffffffc0208a70:	7179                	addi	sp,sp,-48
ffffffffc0208a72:	f406                	sd	ra,40(sp)
ffffffffc0208a74:	f022                	sd	s0,32(sp)
ffffffffc0208a76:	ec26                	sd	s1,24(sp)
ffffffffc0208a78:	e84a                	sd	s2,16(sp)
ffffffffc0208a7a:	e44e                	sd	s3,8(sp)
ffffffffc0208a7c:	e052                	sd	s4,0(sp)
ffffffffc0208a7e:	cd4d                	beqz	a0,ffffffffc0208b38 <sfs_sync+0xc8>
ffffffffc0208a80:	0b052783          	lw	a5,176(a0)
ffffffffc0208a84:	8a2a                	mv	s4,a0
ffffffffc0208a86:	ebcd                	bnez	a5,ffffffffc0208b38 <sfs_sync+0xc8>
ffffffffc0208a88:	2f3010ef          	jal	ra,ffffffffc020a57a <lock_sfs_fs>
ffffffffc0208a8c:	0a0a3403          	ld	s0,160(s4)
ffffffffc0208a90:	098a0913          	addi	s2,s4,152
ffffffffc0208a94:	02890763          	beq	s2,s0,ffffffffc0208ac2 <sfs_sync+0x52>
ffffffffc0208a98:	00004997          	auipc	s3,0x4
ffffffffc0208a9c:	e8898993          	addi	s3,s3,-376 # ffffffffc020c920 <default_pmm_manager+0xe88>
ffffffffc0208aa0:	7c1c                	ld	a5,56(s0)
ffffffffc0208aa2:	fc840493          	addi	s1,s0,-56
ffffffffc0208aa6:	cbb5                	beqz	a5,ffffffffc0208b1a <sfs_sync+0xaa>
ffffffffc0208aa8:	7b9c                	ld	a5,48(a5)
ffffffffc0208aaa:	cba5                	beqz	a5,ffffffffc0208b1a <sfs_sync+0xaa>
ffffffffc0208aac:	85ce                	mv	a1,s3
ffffffffc0208aae:	8526                	mv	a0,s1
ffffffffc0208ab0:	e28fe0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0208ab4:	7c1c                	ld	a5,56(s0)
ffffffffc0208ab6:	8526                	mv	a0,s1
ffffffffc0208ab8:	7b9c                	ld	a5,48(a5)
ffffffffc0208aba:	9782                	jalr	a5
ffffffffc0208abc:	6400                	ld	s0,8(s0)
ffffffffc0208abe:	fe8911e3          	bne	s2,s0,ffffffffc0208aa0 <sfs_sync+0x30>
ffffffffc0208ac2:	8552                	mv	a0,s4
ffffffffc0208ac4:	2c7010ef          	jal	ra,ffffffffc020a58a <unlock_sfs_fs>
ffffffffc0208ac8:	040a3783          	ld	a5,64(s4)
ffffffffc0208acc:	4501                	li	a0,0
ffffffffc0208ace:	eb89                	bnez	a5,ffffffffc0208ae0 <sfs_sync+0x70>
ffffffffc0208ad0:	70a2                	ld	ra,40(sp)
ffffffffc0208ad2:	7402                	ld	s0,32(sp)
ffffffffc0208ad4:	64e2                	ld	s1,24(sp)
ffffffffc0208ad6:	6942                	ld	s2,16(sp)
ffffffffc0208ad8:	69a2                	ld	s3,8(sp)
ffffffffc0208ada:	6a02                	ld	s4,0(sp)
ffffffffc0208adc:	6145                	addi	sp,sp,48
ffffffffc0208ade:	8082                	ret
ffffffffc0208ae0:	040a3023          	sd	zero,64(s4)
ffffffffc0208ae4:	8552                	mv	a0,s4
ffffffffc0208ae6:	179010ef          	jal	ra,ffffffffc020a45e <sfs_sync_super>
ffffffffc0208aea:	cd01                	beqz	a0,ffffffffc0208b02 <sfs_sync+0x92>
ffffffffc0208aec:	70a2                	ld	ra,40(sp)
ffffffffc0208aee:	7402                	ld	s0,32(sp)
ffffffffc0208af0:	4785                	li	a5,1
ffffffffc0208af2:	04fa3023          	sd	a5,64(s4)
ffffffffc0208af6:	64e2                	ld	s1,24(sp)
ffffffffc0208af8:	6942                	ld	s2,16(sp)
ffffffffc0208afa:	69a2                	ld	s3,8(sp)
ffffffffc0208afc:	6a02                	ld	s4,0(sp)
ffffffffc0208afe:	6145                	addi	sp,sp,48
ffffffffc0208b00:	8082                	ret
ffffffffc0208b02:	8552                	mv	a0,s4
ffffffffc0208b04:	1a1010ef          	jal	ra,ffffffffc020a4a4 <sfs_sync_freemap>
ffffffffc0208b08:	f175                	bnez	a0,ffffffffc0208aec <sfs_sync+0x7c>
ffffffffc0208b0a:	70a2                	ld	ra,40(sp)
ffffffffc0208b0c:	7402                	ld	s0,32(sp)
ffffffffc0208b0e:	64e2                	ld	s1,24(sp)
ffffffffc0208b10:	6942                	ld	s2,16(sp)
ffffffffc0208b12:	69a2                	ld	s3,8(sp)
ffffffffc0208b14:	6a02                	ld	s4,0(sp)
ffffffffc0208b16:	6145                	addi	sp,sp,48
ffffffffc0208b18:	8082                	ret
ffffffffc0208b1a:	00004697          	auipc	a3,0x4
ffffffffc0208b1e:	db668693          	addi	a3,a3,-586 # ffffffffc020c8d0 <default_pmm_manager+0xe38>
ffffffffc0208b22:	00002617          	auipc	a2,0x2
ffffffffc0208b26:	48e60613          	addi	a2,a2,1166 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208b2a:	45ed                	li	a1,27
ffffffffc0208b2c:	00005517          	auipc	a0,0x5
ffffffffc0208b30:	6e450513          	addi	a0,a0,1764 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208b34:	96bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b38:	00005697          	auipc	a3,0x5
ffffffffc0208b3c:	6a868693          	addi	a3,a3,1704 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc0208b40:	00002617          	auipc	a2,0x2
ffffffffc0208b44:	47060613          	addi	a2,a2,1136 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208b48:	45d5                	li	a1,21
ffffffffc0208b4a:	00005517          	auipc	a0,0x5
ffffffffc0208b4e:	6c650513          	addi	a0,a0,1734 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208b52:	94df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b56 <sfs_get_root>:
ffffffffc0208b56:	1101                	addi	sp,sp,-32
ffffffffc0208b58:	ec06                	sd	ra,24(sp)
ffffffffc0208b5a:	cd09                	beqz	a0,ffffffffc0208b74 <sfs_get_root+0x1e>
ffffffffc0208b5c:	0b052783          	lw	a5,176(a0)
ffffffffc0208b60:	eb91                	bnez	a5,ffffffffc0208b74 <sfs_get_root+0x1e>
ffffffffc0208b62:	4605                	li	a2,1
ffffffffc0208b64:	002c                	addi	a1,sp,8
ffffffffc0208b66:	1ea010ef          	jal	ra,ffffffffc0209d50 <sfs_load_inode>
ffffffffc0208b6a:	e50d                	bnez	a0,ffffffffc0208b94 <sfs_get_root+0x3e>
ffffffffc0208b6c:	60e2                	ld	ra,24(sp)
ffffffffc0208b6e:	6522                	ld	a0,8(sp)
ffffffffc0208b70:	6105                	addi	sp,sp,32
ffffffffc0208b72:	8082                	ret
ffffffffc0208b74:	00005697          	auipc	a3,0x5
ffffffffc0208b78:	66c68693          	addi	a3,a3,1644 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc0208b7c:	00002617          	auipc	a2,0x2
ffffffffc0208b80:	43460613          	addi	a2,a2,1076 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208b84:	03600593          	li	a1,54
ffffffffc0208b88:	00005517          	auipc	a0,0x5
ffffffffc0208b8c:	68850513          	addi	a0,a0,1672 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208b90:	90ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b94:	86aa                	mv	a3,a0
ffffffffc0208b96:	00005617          	auipc	a2,0x5
ffffffffc0208b9a:	6ea60613          	addi	a2,a2,1770 # ffffffffc020e280 <dev_node_ops+0x480>
ffffffffc0208b9e:	03700593          	li	a1,55
ffffffffc0208ba2:	00005517          	auipc	a0,0x5
ffffffffc0208ba6:	66e50513          	addi	a0,a0,1646 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208baa:	8f5f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208bae <sfs_do_mount>:
ffffffffc0208bae:	6518                	ld	a4,8(a0)
ffffffffc0208bb0:	7171                	addi	sp,sp,-176
ffffffffc0208bb2:	f506                	sd	ra,168(sp)
ffffffffc0208bb4:	f122                	sd	s0,160(sp)
ffffffffc0208bb6:	ed26                	sd	s1,152(sp)
ffffffffc0208bb8:	e94a                	sd	s2,144(sp)
ffffffffc0208bba:	e54e                	sd	s3,136(sp)
ffffffffc0208bbc:	e152                	sd	s4,128(sp)
ffffffffc0208bbe:	fcd6                	sd	s5,120(sp)
ffffffffc0208bc0:	f8da                	sd	s6,112(sp)
ffffffffc0208bc2:	f4de                	sd	s7,104(sp)
ffffffffc0208bc4:	f0e2                	sd	s8,96(sp)
ffffffffc0208bc6:	ece6                	sd	s9,88(sp)
ffffffffc0208bc8:	e8ea                	sd	s10,80(sp)
ffffffffc0208bca:	e4ee                	sd	s11,72(sp)
ffffffffc0208bcc:	6785                	lui	a5,0x1
ffffffffc0208bce:	24f71663          	bne	a4,a5,ffffffffc0208e1a <sfs_do_mount+0x26c>
ffffffffc0208bd2:	892a                	mv	s2,a0
ffffffffc0208bd4:	4501                	li	a0,0
ffffffffc0208bd6:	8aae                	mv	s5,a1
ffffffffc0208bd8:	f00fe0ef          	jal	ra,ffffffffc02072d8 <__alloc_fs>
ffffffffc0208bdc:	842a                	mv	s0,a0
ffffffffc0208bde:	24050463          	beqz	a0,ffffffffc0208e26 <sfs_do_mount+0x278>
ffffffffc0208be2:	0b052b03          	lw	s6,176(a0)
ffffffffc0208be6:	260b1263          	bnez	s6,ffffffffc0208e4a <sfs_do_mount+0x29c>
ffffffffc0208bea:	03253823          	sd	s2,48(a0)
ffffffffc0208bee:	6505                	lui	a0,0x1
ffffffffc0208bf0:	b9ef90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208bf4:	e428                	sd	a0,72(s0)
ffffffffc0208bf6:	84aa                	mv	s1,a0
ffffffffc0208bf8:	16050363          	beqz	a0,ffffffffc0208d5e <sfs_do_mount+0x1b0>
ffffffffc0208bfc:	85aa                	mv	a1,a0
ffffffffc0208bfe:	4681                	li	a3,0
ffffffffc0208c00:	6605                	lui	a2,0x1
ffffffffc0208c02:	1008                	addi	a0,sp,32
ffffffffc0208c04:	e6cfc0ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc0208c08:	02093783          	ld	a5,32(s2)
ffffffffc0208c0c:	85aa                	mv	a1,a0
ffffffffc0208c0e:	4601                	li	a2,0
ffffffffc0208c10:	854a                	mv	a0,s2
ffffffffc0208c12:	9782                	jalr	a5
ffffffffc0208c14:	8a2a                	mv	s4,a0
ffffffffc0208c16:	10051e63          	bnez	a0,ffffffffc0208d32 <sfs_do_mount+0x184>
ffffffffc0208c1a:	408c                	lw	a1,0(s1)
ffffffffc0208c1c:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc0208c20:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc0208c24:	14c59863          	bne	a1,a2,ffffffffc0208d74 <sfs_do_mount+0x1c6>
ffffffffc0208c28:	40dc                	lw	a5,4(s1)
ffffffffc0208c2a:	00093603          	ld	a2,0(s2)
ffffffffc0208c2e:	02079713          	slli	a4,a5,0x20
ffffffffc0208c32:	9301                	srli	a4,a4,0x20
ffffffffc0208c34:	12e66763          	bltu	a2,a4,ffffffffc0208d62 <sfs_do_mount+0x1b4>
ffffffffc0208c38:	020485a3          	sb	zero,43(s1)
ffffffffc0208c3c:	0084af03          	lw	t5,8(s1)
ffffffffc0208c40:	00c4ae83          	lw	t4,12(s1)
ffffffffc0208c44:	0104ae03          	lw	t3,16(s1)
ffffffffc0208c48:	0144a303          	lw	t1,20(s1)
ffffffffc0208c4c:	0184a883          	lw	a7,24(s1)
ffffffffc0208c50:	01c4a803          	lw	a6,28(s1)
ffffffffc0208c54:	5090                	lw	a2,32(s1)
ffffffffc0208c56:	50d4                	lw	a3,36(s1)
ffffffffc0208c58:	5498                	lw	a4,40(s1)
ffffffffc0208c5a:	6511                	lui	a0,0x4
ffffffffc0208c5c:	c00c                	sw	a1,0(s0)
ffffffffc0208c5e:	c05c                	sw	a5,4(s0)
ffffffffc0208c60:	01e42423          	sw	t5,8(s0)
ffffffffc0208c64:	01d42623          	sw	t4,12(s0)
ffffffffc0208c68:	01c42823          	sw	t3,16(s0)
ffffffffc0208c6c:	00642a23          	sw	t1,20(s0)
ffffffffc0208c70:	01142c23          	sw	a7,24(s0)
ffffffffc0208c74:	01042e23          	sw	a6,28(s0)
ffffffffc0208c78:	d010                	sw	a2,32(s0)
ffffffffc0208c7a:	d054                	sw	a3,36(s0)
ffffffffc0208c7c:	d418                	sw	a4,40(s0)
ffffffffc0208c7e:	b10f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208c82:	f448                	sd	a0,168(s0)
ffffffffc0208c84:	8c2a                	mv	s8,a0
ffffffffc0208c86:	18050c63          	beqz	a0,ffffffffc0208e1e <sfs_do_mount+0x270>
ffffffffc0208c8a:	6711                	lui	a4,0x4
ffffffffc0208c8c:	87aa                	mv	a5,a0
ffffffffc0208c8e:	972a                	add	a4,a4,a0
ffffffffc0208c90:	e79c                	sd	a5,8(a5)
ffffffffc0208c92:	e39c                	sd	a5,0(a5)
ffffffffc0208c94:	07c1                	addi	a5,a5,16
ffffffffc0208c96:	fee79de3          	bne	a5,a4,ffffffffc0208c90 <sfs_do_mount+0xe2>
ffffffffc0208c9a:	0044eb83          	lwu	s7,4(s1)
ffffffffc0208c9e:	67a1                	lui	a5,0x8
ffffffffc0208ca0:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc0208ca4:	9bce                	add	s7,s7,s3
ffffffffc0208ca6:	77e1                	lui	a5,0xffff8
ffffffffc0208ca8:	00fbfbb3          	and	s7,s7,a5
ffffffffc0208cac:	2b81                	sext.w	s7,s7
ffffffffc0208cae:	855e                	mv	a0,s7
ffffffffc0208cb0:	a59ff0ef          	jal	ra,ffffffffc0208708 <bitmap_create>
ffffffffc0208cb4:	fc08                	sd	a0,56(s0)
ffffffffc0208cb6:	8d2a                	mv	s10,a0
ffffffffc0208cb8:	14050f63          	beqz	a0,ffffffffc0208e16 <sfs_do_mount+0x268>
ffffffffc0208cbc:	0044e783          	lwu	a5,4(s1)
ffffffffc0208cc0:	082c                	addi	a1,sp,24
ffffffffc0208cc2:	97ce                	add	a5,a5,s3
ffffffffc0208cc4:	00f7d713          	srli	a4,a5,0xf
ffffffffc0208cc8:	e43a                	sd	a4,8(sp)
ffffffffc0208cca:	40f7d993          	srai	s3,a5,0xf
ffffffffc0208cce:	c4fff0ef          	jal	ra,ffffffffc020891c <bitmap_getdata>
ffffffffc0208cd2:	14050c63          	beqz	a0,ffffffffc0208e2a <sfs_do_mount+0x27c>
ffffffffc0208cd6:	00c9979b          	slliw	a5,s3,0xc
ffffffffc0208cda:	66e2                	ld	a3,24(sp)
ffffffffc0208cdc:	1782                	slli	a5,a5,0x20
ffffffffc0208cde:	9381                	srli	a5,a5,0x20
ffffffffc0208ce0:	14d79563          	bne	a5,a3,ffffffffc0208e2a <sfs_do_mount+0x27c>
ffffffffc0208ce4:	6722                	ld	a4,8(sp)
ffffffffc0208ce6:	6d89                	lui	s11,0x2
ffffffffc0208ce8:	89aa                	mv	s3,a0
ffffffffc0208cea:	00c71c93          	slli	s9,a4,0xc
ffffffffc0208cee:	9caa                	add	s9,s9,a0
ffffffffc0208cf0:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0208cf4:	e711                	bnez	a4,ffffffffc0208d00 <sfs_do_mount+0x152>
ffffffffc0208cf6:	a079                	j	ffffffffc0208d84 <sfs_do_mount+0x1d6>
ffffffffc0208cf8:	6785                	lui	a5,0x1
ffffffffc0208cfa:	99be                	add	s3,s3,a5
ffffffffc0208cfc:	093c8463          	beq	s9,s3,ffffffffc0208d84 <sfs_do_mount+0x1d6>
ffffffffc0208d00:	013d86bb          	addw	a3,s11,s3
ffffffffc0208d04:	1682                	slli	a3,a3,0x20
ffffffffc0208d06:	6605                	lui	a2,0x1
ffffffffc0208d08:	85ce                	mv	a1,s3
ffffffffc0208d0a:	9281                	srli	a3,a3,0x20
ffffffffc0208d0c:	1008                	addi	a0,sp,32
ffffffffc0208d0e:	d62fc0ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc0208d12:	02093783          	ld	a5,32(s2)
ffffffffc0208d16:	85aa                	mv	a1,a0
ffffffffc0208d18:	4601                	li	a2,0
ffffffffc0208d1a:	854a                	mv	a0,s2
ffffffffc0208d1c:	9782                	jalr	a5
ffffffffc0208d1e:	dd69                	beqz	a0,ffffffffc0208cf8 <sfs_do_mount+0x14a>
ffffffffc0208d20:	e42a                	sd	a0,8(sp)
ffffffffc0208d22:	856a                	mv	a0,s10
ffffffffc0208d24:	bdfff0ef          	jal	ra,ffffffffc0208902 <bitmap_destroy>
ffffffffc0208d28:	67a2                	ld	a5,8(sp)
ffffffffc0208d2a:	8a3e                	mv	s4,a5
ffffffffc0208d2c:	8562                	mv	a0,s8
ffffffffc0208d2e:	b10f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208d32:	8526                	mv	a0,s1
ffffffffc0208d34:	b0af90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208d38:	8522                	mv	a0,s0
ffffffffc0208d3a:	b04f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208d3e:	70aa                	ld	ra,168(sp)
ffffffffc0208d40:	740a                	ld	s0,160(sp)
ffffffffc0208d42:	64ea                	ld	s1,152(sp)
ffffffffc0208d44:	694a                	ld	s2,144(sp)
ffffffffc0208d46:	69aa                	ld	s3,136(sp)
ffffffffc0208d48:	7ae6                	ld	s5,120(sp)
ffffffffc0208d4a:	7b46                	ld	s6,112(sp)
ffffffffc0208d4c:	7ba6                	ld	s7,104(sp)
ffffffffc0208d4e:	7c06                	ld	s8,96(sp)
ffffffffc0208d50:	6ce6                	ld	s9,88(sp)
ffffffffc0208d52:	6d46                	ld	s10,80(sp)
ffffffffc0208d54:	6da6                	ld	s11,72(sp)
ffffffffc0208d56:	8552                	mv	a0,s4
ffffffffc0208d58:	6a0a                	ld	s4,128(sp)
ffffffffc0208d5a:	614d                	addi	sp,sp,176
ffffffffc0208d5c:	8082                	ret
ffffffffc0208d5e:	5a71                	li	s4,-4
ffffffffc0208d60:	bfe1                	j	ffffffffc0208d38 <sfs_do_mount+0x18a>
ffffffffc0208d62:	85be                	mv	a1,a5
ffffffffc0208d64:	00005517          	auipc	a0,0x5
ffffffffc0208d68:	57450513          	addi	a0,a0,1396 # ffffffffc020e2d8 <dev_node_ops+0x4d8>
ffffffffc0208d6c:	c3af70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208d70:	5a75                	li	s4,-3
ffffffffc0208d72:	b7c1                	j	ffffffffc0208d32 <sfs_do_mount+0x184>
ffffffffc0208d74:	00005517          	auipc	a0,0x5
ffffffffc0208d78:	52c50513          	addi	a0,a0,1324 # ffffffffc020e2a0 <dev_node_ops+0x4a0>
ffffffffc0208d7c:	c2af70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208d80:	5a75                	li	s4,-3
ffffffffc0208d82:	bf45                	j	ffffffffc0208d32 <sfs_do_mount+0x184>
ffffffffc0208d84:	00442903          	lw	s2,4(s0)
ffffffffc0208d88:	4481                	li	s1,0
ffffffffc0208d8a:	080b8c63          	beqz	s7,ffffffffc0208e22 <sfs_do_mount+0x274>
ffffffffc0208d8e:	85a6                	mv	a1,s1
ffffffffc0208d90:	856a                	mv	a0,s10
ffffffffc0208d92:	af7ff0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc0208d96:	c111                	beqz	a0,ffffffffc0208d9a <sfs_do_mount+0x1ec>
ffffffffc0208d98:	2b05                	addiw	s6,s6,1
ffffffffc0208d9a:	2485                	addiw	s1,s1,1
ffffffffc0208d9c:	fe9b99e3          	bne	s7,s1,ffffffffc0208d8e <sfs_do_mount+0x1e0>
ffffffffc0208da0:	441c                	lw	a5,8(s0)
ffffffffc0208da2:	0d679463          	bne	a5,s6,ffffffffc0208e6a <sfs_do_mount+0x2bc>
ffffffffc0208da6:	4585                	li	a1,1
ffffffffc0208da8:	05040513          	addi	a0,s0,80
ffffffffc0208dac:	04043023          	sd	zero,64(s0)
ffffffffc0208db0:	e38fb0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0208db4:	4585                	li	a1,1
ffffffffc0208db6:	06840513          	addi	a0,s0,104
ffffffffc0208dba:	e2efb0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0208dbe:	4585                	li	a1,1
ffffffffc0208dc0:	08040513          	addi	a0,s0,128
ffffffffc0208dc4:	e24fb0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0208dc8:	09840793          	addi	a5,s0,152
ffffffffc0208dcc:	f05c                	sd	a5,160(s0)
ffffffffc0208dce:	ec5c                	sd	a5,152(s0)
ffffffffc0208dd0:	874a                	mv	a4,s2
ffffffffc0208dd2:	86da                	mv	a3,s6
ffffffffc0208dd4:	4169063b          	subw	a2,s2,s6
ffffffffc0208dd8:	00c40593          	addi	a1,s0,12
ffffffffc0208ddc:	00005517          	auipc	a0,0x5
ffffffffc0208de0:	58c50513          	addi	a0,a0,1420 # ffffffffc020e368 <dev_node_ops+0x568>
ffffffffc0208de4:	bc2f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208de8:	00000797          	auipc	a5,0x0
ffffffffc0208dec:	c8878793          	addi	a5,a5,-888 # ffffffffc0208a70 <sfs_sync>
ffffffffc0208df0:	fc5c                	sd	a5,184(s0)
ffffffffc0208df2:	00000797          	auipc	a5,0x0
ffffffffc0208df6:	d6478793          	addi	a5,a5,-668 # ffffffffc0208b56 <sfs_get_root>
ffffffffc0208dfa:	e07c                	sd	a5,192(s0)
ffffffffc0208dfc:	00000797          	auipc	a5,0x0
ffffffffc0208e00:	b5e78793          	addi	a5,a5,-1186 # ffffffffc020895a <sfs_unmount>
ffffffffc0208e04:	e47c                	sd	a5,200(s0)
ffffffffc0208e06:	00000797          	auipc	a5,0x0
ffffffffc0208e0a:	bd878793          	addi	a5,a5,-1064 # ffffffffc02089de <sfs_cleanup>
ffffffffc0208e0e:	e87c                	sd	a5,208(s0)
ffffffffc0208e10:	008ab023          	sd	s0,0(s5)
ffffffffc0208e14:	b72d                	j	ffffffffc0208d3e <sfs_do_mount+0x190>
ffffffffc0208e16:	5a71                	li	s4,-4
ffffffffc0208e18:	bf11                	j	ffffffffc0208d2c <sfs_do_mount+0x17e>
ffffffffc0208e1a:	5a49                	li	s4,-14
ffffffffc0208e1c:	b70d                	j	ffffffffc0208d3e <sfs_do_mount+0x190>
ffffffffc0208e1e:	5a71                	li	s4,-4
ffffffffc0208e20:	bf09                	j	ffffffffc0208d32 <sfs_do_mount+0x184>
ffffffffc0208e22:	4b01                	li	s6,0
ffffffffc0208e24:	bfb5                	j	ffffffffc0208da0 <sfs_do_mount+0x1f2>
ffffffffc0208e26:	5a71                	li	s4,-4
ffffffffc0208e28:	bf19                	j	ffffffffc0208d3e <sfs_do_mount+0x190>
ffffffffc0208e2a:	00005697          	auipc	a3,0x5
ffffffffc0208e2e:	4de68693          	addi	a3,a3,1246 # ffffffffc020e308 <dev_node_ops+0x508>
ffffffffc0208e32:	00002617          	auipc	a2,0x2
ffffffffc0208e36:	17e60613          	addi	a2,a2,382 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208e3a:	08300593          	li	a1,131
ffffffffc0208e3e:	00005517          	auipc	a0,0x5
ffffffffc0208e42:	3d250513          	addi	a0,a0,978 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208e46:	e58f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e4a:	00005697          	auipc	a3,0x5
ffffffffc0208e4e:	39668693          	addi	a3,a3,918 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc0208e52:	00002617          	auipc	a2,0x2
ffffffffc0208e56:	15e60613          	addi	a2,a2,350 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208e5a:	0a300593          	li	a1,163
ffffffffc0208e5e:	00005517          	auipc	a0,0x5
ffffffffc0208e62:	3b250513          	addi	a0,a0,946 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208e66:	e38f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e6a:	00005697          	auipc	a3,0x5
ffffffffc0208e6e:	4ce68693          	addi	a3,a3,1230 # ffffffffc020e338 <dev_node_ops+0x538>
ffffffffc0208e72:	00002617          	auipc	a2,0x2
ffffffffc0208e76:	13e60613          	addi	a2,a2,318 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208e7a:	0e000593          	li	a1,224
ffffffffc0208e7e:	00005517          	auipc	a0,0x5
ffffffffc0208e82:	39250513          	addi	a0,a0,914 # ffffffffc020e210 <dev_node_ops+0x410>
ffffffffc0208e86:	e18f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e8a <sfs_mount>:
ffffffffc0208e8a:	00000597          	auipc	a1,0x0
ffffffffc0208e8e:	d2458593          	addi	a1,a1,-732 # ffffffffc0208bae <sfs_do_mount>
ffffffffc0208e92:	817fe06f          	j	ffffffffc02076a8 <vfs_mount>

ffffffffc0208e96 <sfs_opendir>:
ffffffffc0208e96:	0235f593          	andi	a1,a1,35
ffffffffc0208e9a:	4501                	li	a0,0
ffffffffc0208e9c:	e191                	bnez	a1,ffffffffc0208ea0 <sfs_opendir+0xa>
ffffffffc0208e9e:	8082                	ret
ffffffffc0208ea0:	553d                	li	a0,-17
ffffffffc0208ea2:	8082                	ret

ffffffffc0208ea4 <sfs_openfile>:
ffffffffc0208ea4:	4501                	li	a0,0
ffffffffc0208ea6:	8082                	ret

ffffffffc0208ea8 <sfs_gettype>:
ffffffffc0208ea8:	1141                	addi	sp,sp,-16
ffffffffc0208eaa:	e406                	sd	ra,8(sp)
ffffffffc0208eac:	c939                	beqz	a0,ffffffffc0208f02 <sfs_gettype+0x5a>
ffffffffc0208eae:	4d34                	lw	a3,88(a0)
ffffffffc0208eb0:	6785                	lui	a5,0x1
ffffffffc0208eb2:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0208eb6:	04e69663          	bne	a3,a4,ffffffffc0208f02 <sfs_gettype+0x5a>
ffffffffc0208eba:	6114                	ld	a3,0(a0)
ffffffffc0208ebc:	4709                	li	a4,2
ffffffffc0208ebe:	0046d683          	lhu	a3,4(a3)
ffffffffc0208ec2:	02e68a63          	beq	a3,a4,ffffffffc0208ef6 <sfs_gettype+0x4e>
ffffffffc0208ec6:	470d                	li	a4,3
ffffffffc0208ec8:	02e68163          	beq	a3,a4,ffffffffc0208eea <sfs_gettype+0x42>
ffffffffc0208ecc:	4705                	li	a4,1
ffffffffc0208ece:	00e68f63          	beq	a3,a4,ffffffffc0208eec <sfs_gettype+0x44>
ffffffffc0208ed2:	00005617          	auipc	a2,0x5
ffffffffc0208ed6:	50660613          	addi	a2,a2,1286 # ffffffffc020e3d8 <dev_node_ops+0x5d8>
ffffffffc0208eda:	36500593          	li	a1,869
ffffffffc0208ede:	00005517          	auipc	a0,0x5
ffffffffc0208ee2:	4e250513          	addi	a0,a0,1250 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0208ee6:	db8f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208eea:	678d                	lui	a5,0x3
ffffffffc0208eec:	60a2                	ld	ra,8(sp)
ffffffffc0208eee:	c19c                	sw	a5,0(a1)
ffffffffc0208ef0:	4501                	li	a0,0
ffffffffc0208ef2:	0141                	addi	sp,sp,16
ffffffffc0208ef4:	8082                	ret
ffffffffc0208ef6:	60a2                	ld	ra,8(sp)
ffffffffc0208ef8:	6789                	lui	a5,0x2
ffffffffc0208efa:	c19c                	sw	a5,0(a1)
ffffffffc0208efc:	4501                	li	a0,0
ffffffffc0208efe:	0141                	addi	sp,sp,16
ffffffffc0208f00:	8082                	ret
ffffffffc0208f02:	00005697          	auipc	a3,0x5
ffffffffc0208f06:	48668693          	addi	a3,a3,1158 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc0208f0a:	00002617          	auipc	a2,0x2
ffffffffc0208f0e:	0a660613          	addi	a2,a2,166 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208f12:	35900593          	li	a1,857
ffffffffc0208f16:	00005517          	auipc	a0,0x5
ffffffffc0208f1a:	4aa50513          	addi	a0,a0,1194 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0208f1e:	d80f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f22 <sfs_fsync>:
ffffffffc0208f22:	7179                	addi	sp,sp,-48
ffffffffc0208f24:	ec26                	sd	s1,24(sp)
ffffffffc0208f26:	7524                	ld	s1,104(a0)
ffffffffc0208f28:	f406                	sd	ra,40(sp)
ffffffffc0208f2a:	f022                	sd	s0,32(sp)
ffffffffc0208f2c:	e84a                	sd	s2,16(sp)
ffffffffc0208f2e:	e44e                	sd	s3,8(sp)
ffffffffc0208f30:	c4bd                	beqz	s1,ffffffffc0208f9e <sfs_fsync+0x7c>
ffffffffc0208f32:	0b04a783          	lw	a5,176(s1)
ffffffffc0208f36:	e7a5                	bnez	a5,ffffffffc0208f9e <sfs_fsync+0x7c>
ffffffffc0208f38:	4d38                	lw	a4,88(a0)
ffffffffc0208f3a:	6785                	lui	a5,0x1
ffffffffc0208f3c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0208f40:	842a                	mv	s0,a0
ffffffffc0208f42:	06f71e63          	bne	a4,a5,ffffffffc0208fbe <sfs_fsync+0x9c>
ffffffffc0208f46:	691c                	ld	a5,16(a0)
ffffffffc0208f48:	4901                	li	s2,0
ffffffffc0208f4a:	eb89                	bnez	a5,ffffffffc0208f5c <sfs_fsync+0x3a>
ffffffffc0208f4c:	70a2                	ld	ra,40(sp)
ffffffffc0208f4e:	7402                	ld	s0,32(sp)
ffffffffc0208f50:	64e2                	ld	s1,24(sp)
ffffffffc0208f52:	69a2                	ld	s3,8(sp)
ffffffffc0208f54:	854a                	mv	a0,s2
ffffffffc0208f56:	6942                	ld	s2,16(sp)
ffffffffc0208f58:	6145                	addi	sp,sp,48
ffffffffc0208f5a:	8082                	ret
ffffffffc0208f5c:	02050993          	addi	s3,a0,32
ffffffffc0208f60:	854e                	mv	a0,s3
ffffffffc0208f62:	c90fb0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0208f66:	681c                	ld	a5,16(s0)
ffffffffc0208f68:	ef81                	bnez	a5,ffffffffc0208f80 <sfs_fsync+0x5e>
ffffffffc0208f6a:	854e                	mv	a0,s3
ffffffffc0208f6c:	c82fb0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0208f70:	70a2                	ld	ra,40(sp)
ffffffffc0208f72:	7402                	ld	s0,32(sp)
ffffffffc0208f74:	64e2                	ld	s1,24(sp)
ffffffffc0208f76:	69a2                	ld	s3,8(sp)
ffffffffc0208f78:	854a                	mv	a0,s2
ffffffffc0208f7a:	6942                	ld	s2,16(sp)
ffffffffc0208f7c:	6145                	addi	sp,sp,48
ffffffffc0208f7e:	8082                	ret
ffffffffc0208f80:	4414                	lw	a3,8(s0)
ffffffffc0208f82:	600c                	ld	a1,0(s0)
ffffffffc0208f84:	00043823          	sd	zero,16(s0)
ffffffffc0208f88:	4701                	li	a4,0
ffffffffc0208f8a:	04000613          	li	a2,64
ffffffffc0208f8e:	8526                	mv	a0,s1
ffffffffc0208f90:	43a010ef          	jal	ra,ffffffffc020a3ca <sfs_wbuf>
ffffffffc0208f94:	892a                	mv	s2,a0
ffffffffc0208f96:	d971                	beqz	a0,ffffffffc0208f6a <sfs_fsync+0x48>
ffffffffc0208f98:	4785                	li	a5,1
ffffffffc0208f9a:	e81c                	sd	a5,16(s0)
ffffffffc0208f9c:	b7f9                	j	ffffffffc0208f6a <sfs_fsync+0x48>
ffffffffc0208f9e:	00005697          	auipc	a3,0x5
ffffffffc0208fa2:	24268693          	addi	a3,a3,578 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc0208fa6:	00002617          	auipc	a2,0x2
ffffffffc0208faa:	00a60613          	addi	a2,a2,10 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208fae:	29d00593          	li	a1,669
ffffffffc0208fb2:	00005517          	auipc	a0,0x5
ffffffffc0208fb6:	40e50513          	addi	a0,a0,1038 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0208fba:	ce4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208fbe:	00005697          	auipc	a3,0x5
ffffffffc0208fc2:	3ca68693          	addi	a3,a3,970 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc0208fc6:	00002617          	auipc	a2,0x2
ffffffffc0208fca:	fea60613          	addi	a2,a2,-22 # ffffffffc020afb0 <commands+0x210>
ffffffffc0208fce:	29e00593          	li	a1,670
ffffffffc0208fd2:	00005517          	auipc	a0,0x5
ffffffffc0208fd6:	3ee50513          	addi	a0,a0,1006 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0208fda:	cc4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208fde <sfs_fstat>:
ffffffffc0208fde:	1101                	addi	sp,sp,-32
ffffffffc0208fe0:	e426                	sd	s1,8(sp)
ffffffffc0208fe2:	84ae                	mv	s1,a1
ffffffffc0208fe4:	e822                	sd	s0,16(sp)
ffffffffc0208fe6:	02000613          	li	a2,32
ffffffffc0208fea:	842a                	mv	s0,a0
ffffffffc0208fec:	4581                	li	a1,0
ffffffffc0208fee:	8526                	mv	a0,s1
ffffffffc0208ff0:	ec06                	sd	ra,24(sp)
ffffffffc0208ff2:	2dd010ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc0208ff6:	c439                	beqz	s0,ffffffffc0209044 <sfs_fstat+0x66>
ffffffffc0208ff8:	783c                	ld	a5,112(s0)
ffffffffc0208ffa:	c7a9                	beqz	a5,ffffffffc0209044 <sfs_fstat+0x66>
ffffffffc0208ffc:	6bbc                	ld	a5,80(a5)
ffffffffc0208ffe:	c3b9                	beqz	a5,ffffffffc0209044 <sfs_fstat+0x66>
ffffffffc0209000:	00005597          	auipc	a1,0x5
ffffffffc0209004:	d7858593          	addi	a1,a1,-648 # ffffffffc020dd78 <syscalls+0xdb0>
ffffffffc0209008:	8522                	mv	a0,s0
ffffffffc020900a:	8cefe0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc020900e:	783c                	ld	a5,112(s0)
ffffffffc0209010:	85a6                	mv	a1,s1
ffffffffc0209012:	8522                	mv	a0,s0
ffffffffc0209014:	6bbc                	ld	a5,80(a5)
ffffffffc0209016:	9782                	jalr	a5
ffffffffc0209018:	e10d                	bnez	a0,ffffffffc020903a <sfs_fstat+0x5c>
ffffffffc020901a:	4c38                	lw	a4,88(s0)
ffffffffc020901c:	6785                	lui	a5,0x1
ffffffffc020901e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209022:	04f71163          	bne	a4,a5,ffffffffc0209064 <sfs_fstat+0x86>
ffffffffc0209026:	601c                	ld	a5,0(s0)
ffffffffc0209028:	0067d683          	lhu	a3,6(a5)
ffffffffc020902c:	0087e703          	lwu	a4,8(a5)
ffffffffc0209030:	0007e783          	lwu	a5,0(a5)
ffffffffc0209034:	e494                	sd	a3,8(s1)
ffffffffc0209036:	e898                	sd	a4,16(s1)
ffffffffc0209038:	ec9c                	sd	a5,24(s1)
ffffffffc020903a:	60e2                	ld	ra,24(sp)
ffffffffc020903c:	6442                	ld	s0,16(sp)
ffffffffc020903e:	64a2                	ld	s1,8(sp)
ffffffffc0209040:	6105                	addi	sp,sp,32
ffffffffc0209042:	8082                	ret
ffffffffc0209044:	00005697          	auipc	a3,0x5
ffffffffc0209048:	ccc68693          	addi	a3,a3,-820 # ffffffffc020dd10 <syscalls+0xd48>
ffffffffc020904c:	00002617          	auipc	a2,0x2
ffffffffc0209050:	f6460613          	addi	a2,a2,-156 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209054:	28e00593          	li	a1,654
ffffffffc0209058:	00005517          	auipc	a0,0x5
ffffffffc020905c:	36850513          	addi	a0,a0,872 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209060:	c3ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209064:	00005697          	auipc	a3,0x5
ffffffffc0209068:	32468693          	addi	a3,a3,804 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc020906c:	00002617          	auipc	a2,0x2
ffffffffc0209070:	f4460613          	addi	a2,a2,-188 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209074:	29100593          	li	a1,657
ffffffffc0209078:	00005517          	auipc	a0,0x5
ffffffffc020907c:	34850513          	addi	a0,a0,840 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209080:	c1ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209084 <sfs_tryseek>:
ffffffffc0209084:	080007b7          	lui	a5,0x8000
ffffffffc0209088:	04f5fd63          	bgeu	a1,a5,ffffffffc02090e2 <sfs_tryseek+0x5e>
ffffffffc020908c:	1101                	addi	sp,sp,-32
ffffffffc020908e:	e822                	sd	s0,16(sp)
ffffffffc0209090:	ec06                	sd	ra,24(sp)
ffffffffc0209092:	e426                	sd	s1,8(sp)
ffffffffc0209094:	842a                	mv	s0,a0
ffffffffc0209096:	c921                	beqz	a0,ffffffffc02090e6 <sfs_tryseek+0x62>
ffffffffc0209098:	4d38                	lw	a4,88(a0)
ffffffffc020909a:	6785                	lui	a5,0x1
ffffffffc020909c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02090a0:	04f71363          	bne	a4,a5,ffffffffc02090e6 <sfs_tryseek+0x62>
ffffffffc02090a4:	611c                	ld	a5,0(a0)
ffffffffc02090a6:	84ae                	mv	s1,a1
ffffffffc02090a8:	0007e783          	lwu	a5,0(a5)
ffffffffc02090ac:	02b7d563          	bge	a5,a1,ffffffffc02090d6 <sfs_tryseek+0x52>
ffffffffc02090b0:	793c                	ld	a5,112(a0)
ffffffffc02090b2:	cbb1                	beqz	a5,ffffffffc0209106 <sfs_tryseek+0x82>
ffffffffc02090b4:	73bc                	ld	a5,96(a5)
ffffffffc02090b6:	cba1                	beqz	a5,ffffffffc0209106 <sfs_tryseek+0x82>
ffffffffc02090b8:	00005597          	auipc	a1,0x5
ffffffffc02090bc:	bb058593          	addi	a1,a1,-1104 # ffffffffc020dc68 <syscalls+0xca0>
ffffffffc02090c0:	818fe0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc02090c4:	783c                	ld	a5,112(s0)
ffffffffc02090c6:	8522                	mv	a0,s0
ffffffffc02090c8:	6442                	ld	s0,16(sp)
ffffffffc02090ca:	60e2                	ld	ra,24(sp)
ffffffffc02090cc:	73bc                	ld	a5,96(a5)
ffffffffc02090ce:	85a6                	mv	a1,s1
ffffffffc02090d0:	64a2                	ld	s1,8(sp)
ffffffffc02090d2:	6105                	addi	sp,sp,32
ffffffffc02090d4:	8782                	jr	a5
ffffffffc02090d6:	60e2                	ld	ra,24(sp)
ffffffffc02090d8:	6442                	ld	s0,16(sp)
ffffffffc02090da:	64a2                	ld	s1,8(sp)
ffffffffc02090dc:	4501                	li	a0,0
ffffffffc02090de:	6105                	addi	sp,sp,32
ffffffffc02090e0:	8082                	ret
ffffffffc02090e2:	5575                	li	a0,-3
ffffffffc02090e4:	8082                	ret
ffffffffc02090e6:	00005697          	auipc	a3,0x5
ffffffffc02090ea:	2a268693          	addi	a3,a3,674 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc02090ee:	00002617          	auipc	a2,0x2
ffffffffc02090f2:	ec260613          	addi	a2,a2,-318 # ffffffffc020afb0 <commands+0x210>
ffffffffc02090f6:	37000593          	li	a1,880
ffffffffc02090fa:	00005517          	auipc	a0,0x5
ffffffffc02090fe:	2c650513          	addi	a0,a0,710 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209102:	b9cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209106:	00005697          	auipc	a3,0x5
ffffffffc020910a:	b0a68693          	addi	a3,a3,-1270 # ffffffffc020dc10 <syscalls+0xc48>
ffffffffc020910e:	00002617          	auipc	a2,0x2
ffffffffc0209112:	ea260613          	addi	a2,a2,-350 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209116:	37200593          	li	a1,882
ffffffffc020911a:	00005517          	auipc	a0,0x5
ffffffffc020911e:	2a650513          	addi	a0,a0,678 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209122:	b7cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209126 <sfs_close>:
ffffffffc0209126:	1141                	addi	sp,sp,-16
ffffffffc0209128:	e406                	sd	ra,8(sp)
ffffffffc020912a:	e022                	sd	s0,0(sp)
ffffffffc020912c:	c11d                	beqz	a0,ffffffffc0209152 <sfs_close+0x2c>
ffffffffc020912e:	793c                	ld	a5,112(a0)
ffffffffc0209130:	842a                	mv	s0,a0
ffffffffc0209132:	c385                	beqz	a5,ffffffffc0209152 <sfs_close+0x2c>
ffffffffc0209134:	7b9c                	ld	a5,48(a5)
ffffffffc0209136:	cf91                	beqz	a5,ffffffffc0209152 <sfs_close+0x2c>
ffffffffc0209138:	00003597          	auipc	a1,0x3
ffffffffc020913c:	7e858593          	addi	a1,a1,2024 # ffffffffc020c920 <default_pmm_manager+0xe88>
ffffffffc0209140:	f99fd0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0209144:	783c                	ld	a5,112(s0)
ffffffffc0209146:	8522                	mv	a0,s0
ffffffffc0209148:	6402                	ld	s0,0(sp)
ffffffffc020914a:	60a2                	ld	ra,8(sp)
ffffffffc020914c:	7b9c                	ld	a5,48(a5)
ffffffffc020914e:	0141                	addi	sp,sp,16
ffffffffc0209150:	8782                	jr	a5
ffffffffc0209152:	00003697          	auipc	a3,0x3
ffffffffc0209156:	77e68693          	addi	a3,a3,1918 # ffffffffc020c8d0 <default_pmm_manager+0xe38>
ffffffffc020915a:	00002617          	auipc	a2,0x2
ffffffffc020915e:	e5660613          	addi	a2,a2,-426 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209162:	21c00593          	li	a1,540
ffffffffc0209166:	00005517          	auipc	a0,0x5
ffffffffc020916a:	25a50513          	addi	a0,a0,602 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020916e:	b30f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209172 <sfs_io.part.0>:
ffffffffc0209172:	1141                	addi	sp,sp,-16
ffffffffc0209174:	00005697          	auipc	a3,0x5
ffffffffc0209178:	21468693          	addi	a3,a3,532 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc020917c:	00002617          	auipc	a2,0x2
ffffffffc0209180:	e3460613          	addi	a2,a2,-460 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209184:	26d00593          	li	a1,621
ffffffffc0209188:	00005517          	auipc	a0,0x5
ffffffffc020918c:	23850513          	addi	a0,a0,568 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209190:	e406                	sd	ra,8(sp)
ffffffffc0209192:	b0cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209196 <sfs_read>:
ffffffffc0209196:	753c                	ld	a5,104(a0)
ffffffffc0209198:	1101                	addi	sp,sp,-32
ffffffffc020919a:	ec06                	sd	ra,24(sp)
ffffffffc020919c:	e822                	sd	s0,16(sp)
ffffffffc020919e:	e426                	sd	s1,8(sp)
ffffffffc02091a0:	e04a                	sd	s2,0(sp)
ffffffffc02091a2:	cba5                	beqz	a5,ffffffffc0209212 <sfs_read+0x7c>
ffffffffc02091a4:	0b07a783          	lw	a5,176(a5)
ffffffffc02091a8:	e7ad                	bnez	a5,ffffffffc0209212 <sfs_read+0x7c>
ffffffffc02091aa:	4d38                	lw	a4,88(a0)
ffffffffc02091ac:	6785                	lui	a5,0x1
ffffffffc02091ae:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02091b2:	842a                	mv	s0,a0
ffffffffc02091b4:	08f71f63          	bne	a4,a5,ffffffffc0209252 <sfs_read+0xbc>
ffffffffc02091b8:	02050913          	addi	s2,a0,32
ffffffffc02091bc:	854a                	mv	a0,s2
ffffffffc02091be:	84ae                	mv	s1,a1
ffffffffc02091c0:	a32fb0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc02091c4:	6014                	ld	a3,0(s0)
ffffffffc02091c6:	4609                	li	a2,2
ffffffffc02091c8:	6c98                	ld	a4,24(s1)
ffffffffc02091ca:	0046d583          	lhu	a1,4(a3)
ffffffffc02091ce:	649c                	ld	a5,8(s1)
ffffffffc02091d0:	06c58163          	beq	a1,a2,ffffffffc0209232 <sfs_read+0x9c>
ffffffffc02091d4:	08000637          	lui	a2,0x8000
ffffffffc02091d8:	973e                	add	a4,a4,a5
ffffffffc02091da:	02c7fa63          	bgeu	a5,a2,ffffffffc020920e <sfs_read+0x78>
ffffffffc02091de:	02f74863          	blt	a4,a5,ffffffffc020920e <sfs_read+0x78>
ffffffffc02091e2:	4481                	li	s1,0
ffffffffc02091e4:	00e78b63          	beq	a5,a4,ffffffffc02091fa <sfs_read+0x64>
ffffffffc02091e8:	0006e703          	lwu	a4,0(a3)
ffffffffc02091ec:	00e7d763          	bge	a5,a4,ffffffffc02091fa <sfs_read+0x64>
ffffffffc02091f0:	00f77563          	bgeu	a4,a5,ffffffffc02091fa <sfs_read+0x64>
ffffffffc02091f4:	c29c                	sw	a5,0(a3)
ffffffffc02091f6:	4785                	li	a5,1
ffffffffc02091f8:	e81c                	sd	a5,16(s0)
ffffffffc02091fa:	854a                	mv	a0,s2
ffffffffc02091fc:	9f2fb0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0209200:	60e2                	ld	ra,24(sp)
ffffffffc0209202:	6442                	ld	s0,16(sp)
ffffffffc0209204:	6902                	ld	s2,0(sp)
ffffffffc0209206:	8526                	mv	a0,s1
ffffffffc0209208:	64a2                	ld	s1,8(sp)
ffffffffc020920a:	6105                	addi	sp,sp,32
ffffffffc020920c:	8082                	ret
ffffffffc020920e:	54f5                	li	s1,-3
ffffffffc0209210:	b7ed                	j	ffffffffc02091fa <sfs_read+0x64>
ffffffffc0209212:	00005697          	auipc	a3,0x5
ffffffffc0209216:	fce68693          	addi	a3,a3,-50 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc020921a:	00002617          	auipc	a2,0x2
ffffffffc020921e:	d9660613          	addi	a2,a2,-618 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209222:	26c00593          	li	a1,620
ffffffffc0209226:	00005517          	auipc	a0,0x5
ffffffffc020922a:	19a50513          	addi	a0,a0,410 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020922e:	a70f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209232:	00005697          	auipc	a3,0x5
ffffffffc0209236:	1be68693          	addi	a3,a3,446 # ffffffffc020e3f0 <dev_node_ops+0x5f0>
ffffffffc020923a:	00002617          	auipc	a2,0x2
ffffffffc020923e:	d7660613          	addi	a2,a2,-650 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209242:	22b00593          	li	a1,555
ffffffffc0209246:	00005517          	auipc	a0,0x5
ffffffffc020924a:	17a50513          	addi	a0,a0,378 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020924e:	a50f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209252:	f21ff0ef          	jal	ra,ffffffffc0209172 <sfs_io.part.0>

ffffffffc0209256 <sfs_write>:
ffffffffc0209256:	753c                	ld	a5,104(a0)
ffffffffc0209258:	1101                	addi	sp,sp,-32
ffffffffc020925a:	ec06                	sd	ra,24(sp)
ffffffffc020925c:	e822                	sd	s0,16(sp)
ffffffffc020925e:	e426                	sd	s1,8(sp)
ffffffffc0209260:	e04a                	sd	s2,0(sp)
ffffffffc0209262:	c7b5                	beqz	a5,ffffffffc02092ce <sfs_write+0x78>
ffffffffc0209264:	0b07a783          	lw	a5,176(a5)
ffffffffc0209268:	e3bd                	bnez	a5,ffffffffc02092ce <sfs_write+0x78>
ffffffffc020926a:	4d38                	lw	a4,88(a0)
ffffffffc020926c:	6785                	lui	a5,0x1
ffffffffc020926e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209272:	842a                	mv	s0,a0
ffffffffc0209274:	08f71d63          	bne	a4,a5,ffffffffc020930e <sfs_write+0xb8>
ffffffffc0209278:	02050913          	addi	s2,a0,32
ffffffffc020927c:	854a                	mv	a0,s2
ffffffffc020927e:	84ae                	mv	s1,a1
ffffffffc0209280:	972fb0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0209284:	6014                	ld	a3,0(s0)
ffffffffc0209286:	4609                	li	a2,2
ffffffffc0209288:	6c98                	ld	a4,24(s1)
ffffffffc020928a:	0046d583          	lhu	a1,4(a3)
ffffffffc020928e:	649c                	ld	a5,8(s1)
ffffffffc0209290:	04c58f63          	beq	a1,a2,ffffffffc02092ee <sfs_write+0x98>
ffffffffc0209294:	08000637          	lui	a2,0x8000
ffffffffc0209298:	973e                	add	a4,a4,a5
ffffffffc020929a:	02c7f863          	bgeu	a5,a2,ffffffffc02092ca <sfs_write+0x74>
ffffffffc020929e:	02f74663          	blt	a4,a5,ffffffffc02092ca <sfs_write+0x74>
ffffffffc02092a2:	4481                	li	s1,0
ffffffffc02092a4:	00e78963          	beq	a5,a4,ffffffffc02092b6 <sfs_write+0x60>
ffffffffc02092a8:	0006e703          	lwu	a4,0(a3)
ffffffffc02092ac:	00f77563          	bgeu	a4,a5,ffffffffc02092b6 <sfs_write+0x60>
ffffffffc02092b0:	c29c                	sw	a5,0(a3)
ffffffffc02092b2:	4785                	li	a5,1
ffffffffc02092b4:	e81c                	sd	a5,16(s0)
ffffffffc02092b6:	854a                	mv	a0,s2
ffffffffc02092b8:	936fb0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02092bc:	60e2                	ld	ra,24(sp)
ffffffffc02092be:	6442                	ld	s0,16(sp)
ffffffffc02092c0:	6902                	ld	s2,0(sp)
ffffffffc02092c2:	8526                	mv	a0,s1
ffffffffc02092c4:	64a2                	ld	s1,8(sp)
ffffffffc02092c6:	6105                	addi	sp,sp,32
ffffffffc02092c8:	8082                	ret
ffffffffc02092ca:	54f5                	li	s1,-3
ffffffffc02092cc:	b7ed                	j	ffffffffc02092b6 <sfs_write+0x60>
ffffffffc02092ce:	00005697          	auipc	a3,0x5
ffffffffc02092d2:	f1268693          	addi	a3,a3,-238 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc02092d6:	00002617          	auipc	a2,0x2
ffffffffc02092da:	cda60613          	addi	a2,a2,-806 # ffffffffc020afb0 <commands+0x210>
ffffffffc02092de:	26c00593          	li	a1,620
ffffffffc02092e2:	00005517          	auipc	a0,0x5
ffffffffc02092e6:	0de50513          	addi	a0,a0,222 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02092ea:	9b4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02092ee:	00005697          	auipc	a3,0x5
ffffffffc02092f2:	10268693          	addi	a3,a3,258 # ffffffffc020e3f0 <dev_node_ops+0x5f0>
ffffffffc02092f6:	00002617          	auipc	a2,0x2
ffffffffc02092fa:	cba60613          	addi	a2,a2,-838 # ffffffffc020afb0 <commands+0x210>
ffffffffc02092fe:	22b00593          	li	a1,555
ffffffffc0209302:	00005517          	auipc	a0,0x5
ffffffffc0209306:	0be50513          	addi	a0,a0,190 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020930a:	994f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020930e:	e65ff0ef          	jal	ra,ffffffffc0209172 <sfs_io.part.0>

ffffffffc0209312 <sfs_block_free>:
ffffffffc0209312:	1101                	addi	sp,sp,-32
ffffffffc0209314:	e426                	sd	s1,8(sp)
ffffffffc0209316:	ec06                	sd	ra,24(sp)
ffffffffc0209318:	e822                	sd	s0,16(sp)
ffffffffc020931a:	4154                	lw	a3,4(a0)
ffffffffc020931c:	84ae                	mv	s1,a1
ffffffffc020931e:	c595                	beqz	a1,ffffffffc020934a <sfs_block_free+0x38>
ffffffffc0209320:	02d5f563          	bgeu	a1,a3,ffffffffc020934a <sfs_block_free+0x38>
ffffffffc0209324:	842a                	mv	s0,a0
ffffffffc0209326:	7d08                	ld	a0,56(a0)
ffffffffc0209328:	d60ff0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc020932c:	ed05                	bnez	a0,ffffffffc0209364 <sfs_block_free+0x52>
ffffffffc020932e:	7c08                	ld	a0,56(s0)
ffffffffc0209330:	85a6                	mv	a1,s1
ffffffffc0209332:	d7eff0ef          	jal	ra,ffffffffc02088b0 <bitmap_free>
ffffffffc0209336:	441c                	lw	a5,8(s0)
ffffffffc0209338:	4705                	li	a4,1
ffffffffc020933a:	60e2                	ld	ra,24(sp)
ffffffffc020933c:	2785                	addiw	a5,a5,1
ffffffffc020933e:	e038                	sd	a4,64(s0)
ffffffffc0209340:	c41c                	sw	a5,8(s0)
ffffffffc0209342:	6442                	ld	s0,16(sp)
ffffffffc0209344:	64a2                	ld	s1,8(sp)
ffffffffc0209346:	6105                	addi	sp,sp,32
ffffffffc0209348:	8082                	ret
ffffffffc020934a:	8726                	mv	a4,s1
ffffffffc020934c:	00005617          	auipc	a2,0x5
ffffffffc0209350:	0c460613          	addi	a2,a2,196 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc0209354:	05300593          	li	a1,83
ffffffffc0209358:	00005517          	auipc	a0,0x5
ffffffffc020935c:	06850513          	addi	a0,a0,104 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209360:	93ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209364:	00005697          	auipc	a3,0x5
ffffffffc0209368:	0e468693          	addi	a3,a3,228 # ffffffffc020e448 <dev_node_ops+0x648>
ffffffffc020936c:	00002617          	auipc	a2,0x2
ffffffffc0209370:	c4460613          	addi	a2,a2,-956 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209374:	06a00593          	li	a1,106
ffffffffc0209378:	00005517          	auipc	a0,0x5
ffffffffc020937c:	04850513          	addi	a0,a0,72 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209380:	91ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209384 <sfs_reclaim>:
ffffffffc0209384:	1101                	addi	sp,sp,-32
ffffffffc0209386:	e426                	sd	s1,8(sp)
ffffffffc0209388:	7524                	ld	s1,104(a0)
ffffffffc020938a:	ec06                	sd	ra,24(sp)
ffffffffc020938c:	e822                	sd	s0,16(sp)
ffffffffc020938e:	e04a                	sd	s2,0(sp)
ffffffffc0209390:	0e048a63          	beqz	s1,ffffffffc0209484 <sfs_reclaim+0x100>
ffffffffc0209394:	0b04a783          	lw	a5,176(s1)
ffffffffc0209398:	0e079663          	bnez	a5,ffffffffc0209484 <sfs_reclaim+0x100>
ffffffffc020939c:	4d38                	lw	a4,88(a0)
ffffffffc020939e:	6785                	lui	a5,0x1
ffffffffc02093a0:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02093a4:	842a                	mv	s0,a0
ffffffffc02093a6:	10f71f63          	bne	a4,a5,ffffffffc02094c4 <sfs_reclaim+0x140>
ffffffffc02093aa:	8526                	mv	a0,s1
ffffffffc02093ac:	1ce010ef          	jal	ra,ffffffffc020a57a <lock_sfs_fs>
ffffffffc02093b0:	4c1c                	lw	a5,24(s0)
ffffffffc02093b2:	0ef05963          	blez	a5,ffffffffc02094a4 <sfs_reclaim+0x120>
ffffffffc02093b6:	fff7871b          	addiw	a4,a5,-1
ffffffffc02093ba:	cc18                	sw	a4,24(s0)
ffffffffc02093bc:	eb59                	bnez	a4,ffffffffc0209452 <sfs_reclaim+0xce>
ffffffffc02093be:	05c42903          	lw	s2,92(s0)
ffffffffc02093c2:	08091863          	bnez	s2,ffffffffc0209452 <sfs_reclaim+0xce>
ffffffffc02093c6:	601c                	ld	a5,0(s0)
ffffffffc02093c8:	0067d783          	lhu	a5,6(a5)
ffffffffc02093cc:	e785                	bnez	a5,ffffffffc02093f4 <sfs_reclaim+0x70>
ffffffffc02093ce:	783c                	ld	a5,112(s0)
ffffffffc02093d0:	10078a63          	beqz	a5,ffffffffc02094e4 <sfs_reclaim+0x160>
ffffffffc02093d4:	73bc                	ld	a5,96(a5)
ffffffffc02093d6:	10078763          	beqz	a5,ffffffffc02094e4 <sfs_reclaim+0x160>
ffffffffc02093da:	00005597          	auipc	a1,0x5
ffffffffc02093de:	88e58593          	addi	a1,a1,-1906 # ffffffffc020dc68 <syscalls+0xca0>
ffffffffc02093e2:	8522                	mv	a0,s0
ffffffffc02093e4:	cf5fd0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc02093e8:	783c                	ld	a5,112(s0)
ffffffffc02093ea:	4581                	li	a1,0
ffffffffc02093ec:	8522                	mv	a0,s0
ffffffffc02093ee:	73bc                	ld	a5,96(a5)
ffffffffc02093f0:	9782                	jalr	a5
ffffffffc02093f2:	e559                	bnez	a0,ffffffffc0209480 <sfs_reclaim+0xfc>
ffffffffc02093f4:	681c                	ld	a5,16(s0)
ffffffffc02093f6:	c39d                	beqz	a5,ffffffffc020941c <sfs_reclaim+0x98>
ffffffffc02093f8:	783c                	ld	a5,112(s0)
ffffffffc02093fa:	10078563          	beqz	a5,ffffffffc0209504 <sfs_reclaim+0x180>
ffffffffc02093fe:	7b9c                	ld	a5,48(a5)
ffffffffc0209400:	10078263          	beqz	a5,ffffffffc0209504 <sfs_reclaim+0x180>
ffffffffc0209404:	8522                	mv	a0,s0
ffffffffc0209406:	00003597          	auipc	a1,0x3
ffffffffc020940a:	51a58593          	addi	a1,a1,1306 # ffffffffc020c920 <default_pmm_manager+0xe88>
ffffffffc020940e:	ccbfd0ef          	jal	ra,ffffffffc02070d8 <inode_check>
ffffffffc0209412:	783c                	ld	a5,112(s0)
ffffffffc0209414:	8522                	mv	a0,s0
ffffffffc0209416:	7b9c                	ld	a5,48(a5)
ffffffffc0209418:	9782                	jalr	a5
ffffffffc020941a:	e13d                	bnez	a0,ffffffffc0209480 <sfs_reclaim+0xfc>
ffffffffc020941c:	7c18                	ld	a4,56(s0)
ffffffffc020941e:	603c                	ld	a5,64(s0)
ffffffffc0209420:	8526                	mv	a0,s1
ffffffffc0209422:	e71c                	sd	a5,8(a4)
ffffffffc0209424:	e398                	sd	a4,0(a5)
ffffffffc0209426:	6438                	ld	a4,72(s0)
ffffffffc0209428:	683c                	ld	a5,80(s0)
ffffffffc020942a:	e71c                	sd	a5,8(a4)
ffffffffc020942c:	e398                	sd	a4,0(a5)
ffffffffc020942e:	15c010ef          	jal	ra,ffffffffc020a58a <unlock_sfs_fs>
ffffffffc0209432:	6008                	ld	a0,0(s0)
ffffffffc0209434:	00655783          	lhu	a5,6(a0)
ffffffffc0209438:	cb85                	beqz	a5,ffffffffc0209468 <sfs_reclaim+0xe4>
ffffffffc020943a:	c05f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020943e:	8522                	mv	a0,s0
ffffffffc0209440:	c2dfd0ef          	jal	ra,ffffffffc020706c <inode_kill>
ffffffffc0209444:	60e2                	ld	ra,24(sp)
ffffffffc0209446:	6442                	ld	s0,16(sp)
ffffffffc0209448:	64a2                	ld	s1,8(sp)
ffffffffc020944a:	854a                	mv	a0,s2
ffffffffc020944c:	6902                	ld	s2,0(sp)
ffffffffc020944e:	6105                	addi	sp,sp,32
ffffffffc0209450:	8082                	ret
ffffffffc0209452:	5945                	li	s2,-15
ffffffffc0209454:	8526                	mv	a0,s1
ffffffffc0209456:	134010ef          	jal	ra,ffffffffc020a58a <unlock_sfs_fs>
ffffffffc020945a:	60e2                	ld	ra,24(sp)
ffffffffc020945c:	6442                	ld	s0,16(sp)
ffffffffc020945e:	64a2                	ld	s1,8(sp)
ffffffffc0209460:	854a                	mv	a0,s2
ffffffffc0209462:	6902                	ld	s2,0(sp)
ffffffffc0209464:	6105                	addi	sp,sp,32
ffffffffc0209466:	8082                	ret
ffffffffc0209468:	440c                	lw	a1,8(s0)
ffffffffc020946a:	8526                	mv	a0,s1
ffffffffc020946c:	ea7ff0ef          	jal	ra,ffffffffc0209312 <sfs_block_free>
ffffffffc0209470:	6008                	ld	a0,0(s0)
ffffffffc0209472:	5d4c                	lw	a1,60(a0)
ffffffffc0209474:	d1f9                	beqz	a1,ffffffffc020943a <sfs_reclaim+0xb6>
ffffffffc0209476:	8526                	mv	a0,s1
ffffffffc0209478:	e9bff0ef          	jal	ra,ffffffffc0209312 <sfs_block_free>
ffffffffc020947c:	6008                	ld	a0,0(s0)
ffffffffc020947e:	bf75                	j	ffffffffc020943a <sfs_reclaim+0xb6>
ffffffffc0209480:	892a                	mv	s2,a0
ffffffffc0209482:	bfc9                	j	ffffffffc0209454 <sfs_reclaim+0xd0>
ffffffffc0209484:	00005697          	auipc	a3,0x5
ffffffffc0209488:	d5c68693          	addi	a3,a3,-676 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc020948c:	00002617          	auipc	a2,0x2
ffffffffc0209490:	b2460613          	addi	a2,a2,-1244 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209494:	32e00593          	li	a1,814
ffffffffc0209498:	00005517          	auipc	a0,0x5
ffffffffc020949c:	f2850513          	addi	a0,a0,-216 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02094a0:	ffff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02094a4:	00005697          	auipc	a3,0x5
ffffffffc02094a8:	fc468693          	addi	a3,a3,-60 # ffffffffc020e468 <dev_node_ops+0x668>
ffffffffc02094ac:	00002617          	auipc	a2,0x2
ffffffffc02094b0:	b0460613          	addi	a2,a2,-1276 # ffffffffc020afb0 <commands+0x210>
ffffffffc02094b4:	33400593          	li	a1,820
ffffffffc02094b8:	00005517          	auipc	a0,0x5
ffffffffc02094bc:	f0850513          	addi	a0,a0,-248 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02094c0:	fdff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02094c4:	00005697          	auipc	a3,0x5
ffffffffc02094c8:	ec468693          	addi	a3,a3,-316 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc02094cc:	00002617          	auipc	a2,0x2
ffffffffc02094d0:	ae460613          	addi	a2,a2,-1308 # ffffffffc020afb0 <commands+0x210>
ffffffffc02094d4:	32f00593          	li	a1,815
ffffffffc02094d8:	00005517          	auipc	a0,0x5
ffffffffc02094dc:	ee850513          	addi	a0,a0,-280 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02094e0:	fbff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02094e4:	00004697          	auipc	a3,0x4
ffffffffc02094e8:	72c68693          	addi	a3,a3,1836 # ffffffffc020dc10 <syscalls+0xc48>
ffffffffc02094ec:	00002617          	auipc	a2,0x2
ffffffffc02094f0:	ac460613          	addi	a2,a2,-1340 # ffffffffc020afb0 <commands+0x210>
ffffffffc02094f4:	33900593          	li	a1,825
ffffffffc02094f8:	00005517          	auipc	a0,0x5
ffffffffc02094fc:	ec850513          	addi	a0,a0,-312 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209500:	f9ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209504:	00003697          	auipc	a3,0x3
ffffffffc0209508:	3cc68693          	addi	a3,a3,972 # ffffffffc020c8d0 <default_pmm_manager+0xe38>
ffffffffc020950c:	00002617          	auipc	a2,0x2
ffffffffc0209510:	aa460613          	addi	a2,a2,-1372 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209514:	33e00593          	li	a1,830
ffffffffc0209518:	00005517          	auipc	a0,0x5
ffffffffc020951c:	ea850513          	addi	a0,a0,-344 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209520:	f7ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209524 <sfs_block_alloc>:
ffffffffc0209524:	1101                	addi	sp,sp,-32
ffffffffc0209526:	e822                	sd	s0,16(sp)
ffffffffc0209528:	842a                	mv	s0,a0
ffffffffc020952a:	7d08                	ld	a0,56(a0)
ffffffffc020952c:	e426                	sd	s1,8(sp)
ffffffffc020952e:	ec06                	sd	ra,24(sp)
ffffffffc0209530:	84ae                	mv	s1,a1
ffffffffc0209532:	ae6ff0ef          	jal	ra,ffffffffc0208818 <bitmap_alloc>
ffffffffc0209536:	e90d                	bnez	a0,ffffffffc0209568 <sfs_block_alloc+0x44>
ffffffffc0209538:	441c                	lw	a5,8(s0)
ffffffffc020953a:	cbad                	beqz	a5,ffffffffc02095ac <sfs_block_alloc+0x88>
ffffffffc020953c:	37fd                	addiw	a5,a5,-1
ffffffffc020953e:	c41c                	sw	a5,8(s0)
ffffffffc0209540:	408c                	lw	a1,0(s1)
ffffffffc0209542:	4785                	li	a5,1
ffffffffc0209544:	e03c                	sd	a5,64(s0)
ffffffffc0209546:	4054                	lw	a3,4(s0)
ffffffffc0209548:	c58d                	beqz	a1,ffffffffc0209572 <sfs_block_alloc+0x4e>
ffffffffc020954a:	02d5f463          	bgeu	a1,a3,ffffffffc0209572 <sfs_block_alloc+0x4e>
ffffffffc020954e:	7c08                	ld	a0,56(s0)
ffffffffc0209550:	b38ff0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc0209554:	ed05                	bnez	a0,ffffffffc020958c <sfs_block_alloc+0x68>
ffffffffc0209556:	8522                	mv	a0,s0
ffffffffc0209558:	6442                	ld	s0,16(sp)
ffffffffc020955a:	408c                	lw	a1,0(s1)
ffffffffc020955c:	60e2                	ld	ra,24(sp)
ffffffffc020955e:	64a2                	ld	s1,8(sp)
ffffffffc0209560:	4605                	li	a2,1
ffffffffc0209562:	6105                	addi	sp,sp,32
ffffffffc0209564:	7b70006f          	j	ffffffffc020a51a <sfs_clear_block>
ffffffffc0209568:	60e2                	ld	ra,24(sp)
ffffffffc020956a:	6442                	ld	s0,16(sp)
ffffffffc020956c:	64a2                	ld	s1,8(sp)
ffffffffc020956e:	6105                	addi	sp,sp,32
ffffffffc0209570:	8082                	ret
ffffffffc0209572:	872e                	mv	a4,a1
ffffffffc0209574:	00005617          	auipc	a2,0x5
ffffffffc0209578:	e9c60613          	addi	a2,a2,-356 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc020957c:	05300593          	li	a1,83
ffffffffc0209580:	00005517          	auipc	a0,0x5
ffffffffc0209584:	e4050513          	addi	a0,a0,-448 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209588:	f17f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020958c:	00005697          	auipc	a3,0x5
ffffffffc0209590:	f1468693          	addi	a3,a3,-236 # ffffffffc020e4a0 <dev_node_ops+0x6a0>
ffffffffc0209594:	00002617          	auipc	a2,0x2
ffffffffc0209598:	a1c60613          	addi	a2,a2,-1508 # ffffffffc020afb0 <commands+0x210>
ffffffffc020959c:	06100593          	li	a1,97
ffffffffc02095a0:	00005517          	auipc	a0,0x5
ffffffffc02095a4:	e2050513          	addi	a0,a0,-480 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02095a8:	ef7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02095ac:	00005697          	auipc	a3,0x5
ffffffffc02095b0:	ed468693          	addi	a3,a3,-300 # ffffffffc020e480 <dev_node_ops+0x680>
ffffffffc02095b4:	00002617          	auipc	a2,0x2
ffffffffc02095b8:	9fc60613          	addi	a2,a2,-1540 # ffffffffc020afb0 <commands+0x210>
ffffffffc02095bc:	05f00593          	li	a1,95
ffffffffc02095c0:	00005517          	auipc	a0,0x5
ffffffffc02095c4:	e0050513          	addi	a0,a0,-512 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02095c8:	ed7f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02095cc <sfs_bmap_load_nolock>:
ffffffffc02095cc:	7159                	addi	sp,sp,-112
ffffffffc02095ce:	f85a                	sd	s6,48(sp)
ffffffffc02095d0:	0005bb03          	ld	s6,0(a1)
ffffffffc02095d4:	f45e                	sd	s7,40(sp)
ffffffffc02095d6:	f486                	sd	ra,104(sp)
ffffffffc02095d8:	008b2b83          	lw	s7,8(s6)
ffffffffc02095dc:	f0a2                	sd	s0,96(sp)
ffffffffc02095de:	eca6                	sd	s1,88(sp)
ffffffffc02095e0:	e8ca                	sd	s2,80(sp)
ffffffffc02095e2:	e4ce                	sd	s3,72(sp)
ffffffffc02095e4:	e0d2                	sd	s4,64(sp)
ffffffffc02095e6:	fc56                	sd	s5,56(sp)
ffffffffc02095e8:	f062                	sd	s8,32(sp)
ffffffffc02095ea:	ec66                	sd	s9,24(sp)
ffffffffc02095ec:	18cbe363          	bltu	s7,a2,ffffffffc0209772 <sfs_bmap_load_nolock+0x1a6>
ffffffffc02095f0:	47ad                	li	a5,11
ffffffffc02095f2:	8aae                	mv	s5,a1
ffffffffc02095f4:	8432                	mv	s0,a2
ffffffffc02095f6:	84aa                	mv	s1,a0
ffffffffc02095f8:	89b6                	mv	s3,a3
ffffffffc02095fa:	04c7f563          	bgeu	a5,a2,ffffffffc0209644 <sfs_bmap_load_nolock+0x78>
ffffffffc02095fe:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209602:	0007069b          	sext.w	a3,a4
ffffffffc0209606:	3ff00793          	li	a5,1023
ffffffffc020960a:	1ad7e163          	bltu	a5,a3,ffffffffc02097ac <sfs_bmap_load_nolock+0x1e0>
ffffffffc020960e:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209612:	02071793          	slli	a5,a4,0x20
ffffffffc0209616:	c602                	sw	zero,12(sp)
ffffffffc0209618:	c452                	sw	s4,8(sp)
ffffffffc020961a:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc020961e:	0e0a1e63          	bnez	s4,ffffffffc020971a <sfs_bmap_load_nolock+0x14e>
ffffffffc0209622:	0acb8663          	beq	s7,a2,ffffffffc02096ce <sfs_bmap_load_nolock+0x102>
ffffffffc0209626:	4a01                	li	s4,0
ffffffffc0209628:	40d4                	lw	a3,4(s1)
ffffffffc020962a:	8752                	mv	a4,s4
ffffffffc020962c:	00005617          	auipc	a2,0x5
ffffffffc0209630:	de460613          	addi	a2,a2,-540 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc0209634:	05300593          	li	a1,83
ffffffffc0209638:	00005517          	auipc	a0,0x5
ffffffffc020963c:	d8850513          	addi	a0,a0,-632 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209640:	e5ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209644:	02061793          	slli	a5,a2,0x20
ffffffffc0209648:	01e7da13          	srli	s4,a5,0x1e
ffffffffc020964c:	9a5a                	add	s4,s4,s6
ffffffffc020964e:	00ca2583          	lw	a1,12(s4)
ffffffffc0209652:	c22e                	sw	a1,4(sp)
ffffffffc0209654:	ed99                	bnez	a1,ffffffffc0209672 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209656:	fccb98e3          	bne	s7,a2,ffffffffc0209626 <sfs_bmap_load_nolock+0x5a>
ffffffffc020965a:	004c                	addi	a1,sp,4
ffffffffc020965c:	ec9ff0ef          	jal	ra,ffffffffc0209524 <sfs_block_alloc>
ffffffffc0209660:	892a                	mv	s2,a0
ffffffffc0209662:	e921                	bnez	a0,ffffffffc02096b2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209664:	4592                	lw	a1,4(sp)
ffffffffc0209666:	4705                	li	a4,1
ffffffffc0209668:	00ba2623          	sw	a1,12(s4)
ffffffffc020966c:	00eab823          	sd	a4,16(s5)
ffffffffc0209670:	d9dd                	beqz	a1,ffffffffc0209626 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209672:	40d4                	lw	a3,4(s1)
ffffffffc0209674:	10d5ff63          	bgeu	a1,a3,ffffffffc0209792 <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209678:	7c88                	ld	a0,56(s1)
ffffffffc020967a:	a0eff0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc020967e:	18051363          	bnez	a0,ffffffffc0209804 <sfs_bmap_load_nolock+0x238>
ffffffffc0209682:	4a12                	lw	s4,4(sp)
ffffffffc0209684:	fa0a02e3          	beqz	s4,ffffffffc0209628 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209688:	40dc                	lw	a5,4(s1)
ffffffffc020968a:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209628 <sfs_bmap_load_nolock+0x5c>
ffffffffc020968e:	7c88                	ld	a0,56(s1)
ffffffffc0209690:	85d2                	mv	a1,s4
ffffffffc0209692:	9f6ff0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc0209696:	12051763          	bnez	a0,ffffffffc02097c4 <sfs_bmap_load_nolock+0x1f8>
ffffffffc020969a:	008b9763          	bne	s7,s0,ffffffffc02096a8 <sfs_bmap_load_nolock+0xdc>
ffffffffc020969e:	008b2783          	lw	a5,8(s6)
ffffffffc02096a2:	2785                	addiw	a5,a5,1
ffffffffc02096a4:	00fb2423          	sw	a5,8(s6)
ffffffffc02096a8:	4901                	li	s2,0
ffffffffc02096aa:	00098463          	beqz	s3,ffffffffc02096b2 <sfs_bmap_load_nolock+0xe6>
ffffffffc02096ae:	0149a023          	sw	s4,0(s3)
ffffffffc02096b2:	70a6                	ld	ra,104(sp)
ffffffffc02096b4:	7406                	ld	s0,96(sp)
ffffffffc02096b6:	64e6                	ld	s1,88(sp)
ffffffffc02096b8:	69a6                	ld	s3,72(sp)
ffffffffc02096ba:	6a06                	ld	s4,64(sp)
ffffffffc02096bc:	7ae2                	ld	s5,56(sp)
ffffffffc02096be:	7b42                	ld	s6,48(sp)
ffffffffc02096c0:	7ba2                	ld	s7,40(sp)
ffffffffc02096c2:	7c02                	ld	s8,32(sp)
ffffffffc02096c4:	6ce2                	ld	s9,24(sp)
ffffffffc02096c6:	854a                	mv	a0,s2
ffffffffc02096c8:	6946                	ld	s2,80(sp)
ffffffffc02096ca:	6165                	addi	sp,sp,112
ffffffffc02096cc:	8082                	ret
ffffffffc02096ce:	002c                	addi	a1,sp,8
ffffffffc02096d0:	e55ff0ef          	jal	ra,ffffffffc0209524 <sfs_block_alloc>
ffffffffc02096d4:	892a                	mv	s2,a0
ffffffffc02096d6:	00c10c93          	addi	s9,sp,12
ffffffffc02096da:	fd61                	bnez	a0,ffffffffc02096b2 <sfs_bmap_load_nolock+0xe6>
ffffffffc02096dc:	85e6                	mv	a1,s9
ffffffffc02096de:	8526                	mv	a0,s1
ffffffffc02096e0:	e45ff0ef          	jal	ra,ffffffffc0209524 <sfs_block_alloc>
ffffffffc02096e4:	892a                	mv	s2,a0
ffffffffc02096e6:	e925                	bnez	a0,ffffffffc0209756 <sfs_bmap_load_nolock+0x18a>
ffffffffc02096e8:	46a2                	lw	a3,8(sp)
ffffffffc02096ea:	85e6                	mv	a1,s9
ffffffffc02096ec:	8762                	mv	a4,s8
ffffffffc02096ee:	4611                	li	a2,4
ffffffffc02096f0:	8526                	mv	a0,s1
ffffffffc02096f2:	4d9000ef          	jal	ra,ffffffffc020a3ca <sfs_wbuf>
ffffffffc02096f6:	45b2                	lw	a1,12(sp)
ffffffffc02096f8:	892a                	mv	s2,a0
ffffffffc02096fa:	e939                	bnez	a0,ffffffffc0209750 <sfs_bmap_load_nolock+0x184>
ffffffffc02096fc:	03cb2683          	lw	a3,60(s6)
ffffffffc0209700:	4722                	lw	a4,8(sp)
ffffffffc0209702:	c22e                	sw	a1,4(sp)
ffffffffc0209704:	f6d706e3          	beq	a4,a3,ffffffffc0209670 <sfs_bmap_load_nolock+0xa4>
ffffffffc0209708:	eef1                	bnez	a3,ffffffffc02097e4 <sfs_bmap_load_nolock+0x218>
ffffffffc020970a:	02eb2e23          	sw	a4,60(s6)
ffffffffc020970e:	4705                	li	a4,1
ffffffffc0209710:	00eab823          	sd	a4,16(s5)
ffffffffc0209714:	f00589e3          	beqz	a1,ffffffffc0209626 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209718:	bfa9                	j	ffffffffc0209672 <sfs_bmap_load_nolock+0xa6>
ffffffffc020971a:	00c10c93          	addi	s9,sp,12
ffffffffc020971e:	8762                	mv	a4,s8
ffffffffc0209720:	86d2                	mv	a3,s4
ffffffffc0209722:	4611                	li	a2,4
ffffffffc0209724:	85e6                	mv	a1,s9
ffffffffc0209726:	425000ef          	jal	ra,ffffffffc020a34a <sfs_rbuf>
ffffffffc020972a:	892a                	mv	s2,a0
ffffffffc020972c:	f159                	bnez	a0,ffffffffc02096b2 <sfs_bmap_load_nolock+0xe6>
ffffffffc020972e:	45b2                	lw	a1,12(sp)
ffffffffc0209730:	e995                	bnez	a1,ffffffffc0209764 <sfs_bmap_load_nolock+0x198>
ffffffffc0209732:	fa8b85e3          	beq	s7,s0,ffffffffc02096dc <sfs_bmap_load_nolock+0x110>
ffffffffc0209736:	03cb2703          	lw	a4,60(s6)
ffffffffc020973a:	47a2                	lw	a5,8(sp)
ffffffffc020973c:	c202                	sw	zero,4(sp)
ffffffffc020973e:	eee784e3          	beq	a5,a4,ffffffffc0209626 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209742:	e34d                	bnez	a4,ffffffffc02097e4 <sfs_bmap_load_nolock+0x218>
ffffffffc0209744:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209748:	4785                	li	a5,1
ffffffffc020974a:	00fab823          	sd	a5,16(s5)
ffffffffc020974e:	bde1                	j	ffffffffc0209626 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209750:	8526                	mv	a0,s1
ffffffffc0209752:	bc1ff0ef          	jal	ra,ffffffffc0209312 <sfs_block_free>
ffffffffc0209756:	45a2                	lw	a1,8(sp)
ffffffffc0209758:	f4ba0de3          	beq	s4,a1,ffffffffc02096b2 <sfs_bmap_load_nolock+0xe6>
ffffffffc020975c:	8526                	mv	a0,s1
ffffffffc020975e:	bb5ff0ef          	jal	ra,ffffffffc0209312 <sfs_block_free>
ffffffffc0209762:	bf81                	j	ffffffffc02096b2 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209764:	03cb2683          	lw	a3,60(s6)
ffffffffc0209768:	4722                	lw	a4,8(sp)
ffffffffc020976a:	c22e                	sw	a1,4(sp)
ffffffffc020976c:	f8e69ee3          	bne	a3,a4,ffffffffc0209708 <sfs_bmap_load_nolock+0x13c>
ffffffffc0209770:	b709                	j	ffffffffc0209672 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209772:	00005697          	auipc	a3,0x5
ffffffffc0209776:	d5668693          	addi	a3,a3,-682 # ffffffffc020e4c8 <dev_node_ops+0x6c8>
ffffffffc020977a:	00002617          	auipc	a2,0x2
ffffffffc020977e:	83660613          	addi	a2,a2,-1994 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209782:	16400593          	li	a1,356
ffffffffc0209786:	00005517          	auipc	a0,0x5
ffffffffc020978a:	c3a50513          	addi	a0,a0,-966 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020978e:	d11f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209792:	872e                	mv	a4,a1
ffffffffc0209794:	00005617          	auipc	a2,0x5
ffffffffc0209798:	c7c60613          	addi	a2,a2,-900 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc020979c:	05300593          	li	a1,83
ffffffffc02097a0:	00005517          	auipc	a0,0x5
ffffffffc02097a4:	c2050513          	addi	a0,a0,-992 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02097a8:	cf7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097ac:	00005617          	auipc	a2,0x5
ffffffffc02097b0:	d4c60613          	addi	a2,a2,-692 # ffffffffc020e4f8 <dev_node_ops+0x6f8>
ffffffffc02097b4:	11e00593          	li	a1,286
ffffffffc02097b8:	00005517          	auipc	a0,0x5
ffffffffc02097bc:	c0850513          	addi	a0,a0,-1016 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02097c0:	cdff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097c4:	00005697          	auipc	a3,0x5
ffffffffc02097c8:	c8468693          	addi	a3,a3,-892 # ffffffffc020e448 <dev_node_ops+0x648>
ffffffffc02097cc:	00001617          	auipc	a2,0x1
ffffffffc02097d0:	7e460613          	addi	a2,a2,2020 # ffffffffc020afb0 <commands+0x210>
ffffffffc02097d4:	16b00593          	li	a1,363
ffffffffc02097d8:	00005517          	auipc	a0,0x5
ffffffffc02097dc:	be850513          	addi	a0,a0,-1048 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02097e0:	cbff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097e4:	00005697          	auipc	a3,0x5
ffffffffc02097e8:	cfc68693          	addi	a3,a3,-772 # ffffffffc020e4e0 <dev_node_ops+0x6e0>
ffffffffc02097ec:	00001617          	auipc	a2,0x1
ffffffffc02097f0:	7c460613          	addi	a2,a2,1988 # ffffffffc020afb0 <commands+0x210>
ffffffffc02097f4:	11800593          	li	a1,280
ffffffffc02097f8:	00005517          	auipc	a0,0x5
ffffffffc02097fc:	bc850513          	addi	a0,a0,-1080 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209800:	c9ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209804:	00005697          	auipc	a3,0x5
ffffffffc0209808:	d2468693          	addi	a3,a3,-732 # ffffffffc020e528 <dev_node_ops+0x728>
ffffffffc020980c:	00001617          	auipc	a2,0x1
ffffffffc0209810:	7a460613          	addi	a2,a2,1956 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209814:	12100593          	li	a1,289
ffffffffc0209818:	00005517          	auipc	a0,0x5
ffffffffc020981c:	ba850513          	addi	a0,a0,-1112 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209820:	c7ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209824 <sfs_dirent_read_nolock>:
ffffffffc0209824:	6198                	ld	a4,0(a1)
ffffffffc0209826:	7179                	addi	sp,sp,-48
ffffffffc0209828:	f406                	sd	ra,40(sp)
ffffffffc020982a:	00475883          	lhu	a7,4(a4) # 4004 <_binary_bin_swap_img_size-0x3cfc>
ffffffffc020982e:	f022                	sd	s0,32(sp)
ffffffffc0209830:	ec26                	sd	s1,24(sp)
ffffffffc0209832:	4809                	li	a6,2
ffffffffc0209834:	05089b63          	bne	a7,a6,ffffffffc020988a <sfs_dirent_read_nolock+0x66>
ffffffffc0209838:	4718                	lw	a4,8(a4)
ffffffffc020983a:	87b2                	mv	a5,a2
ffffffffc020983c:	2601                	sext.w	a2,a2
ffffffffc020983e:	04e7f663          	bgeu	a5,a4,ffffffffc020988a <sfs_dirent_read_nolock+0x66>
ffffffffc0209842:	84b6                	mv	s1,a3
ffffffffc0209844:	0074                	addi	a3,sp,12
ffffffffc0209846:	842a                	mv	s0,a0
ffffffffc0209848:	d85ff0ef          	jal	ra,ffffffffc02095cc <sfs_bmap_load_nolock>
ffffffffc020984c:	c511                	beqz	a0,ffffffffc0209858 <sfs_dirent_read_nolock+0x34>
ffffffffc020984e:	70a2                	ld	ra,40(sp)
ffffffffc0209850:	7402                	ld	s0,32(sp)
ffffffffc0209852:	64e2                	ld	s1,24(sp)
ffffffffc0209854:	6145                	addi	sp,sp,48
ffffffffc0209856:	8082                	ret
ffffffffc0209858:	45b2                	lw	a1,12(sp)
ffffffffc020985a:	4054                	lw	a3,4(s0)
ffffffffc020985c:	c5b9                	beqz	a1,ffffffffc02098aa <sfs_dirent_read_nolock+0x86>
ffffffffc020985e:	04d5f663          	bgeu	a1,a3,ffffffffc02098aa <sfs_dirent_read_nolock+0x86>
ffffffffc0209862:	7c08                	ld	a0,56(s0)
ffffffffc0209864:	824ff0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc0209868:	ed31                	bnez	a0,ffffffffc02098c4 <sfs_dirent_read_nolock+0xa0>
ffffffffc020986a:	46b2                	lw	a3,12(sp)
ffffffffc020986c:	4701                	li	a4,0
ffffffffc020986e:	10400613          	li	a2,260
ffffffffc0209872:	85a6                	mv	a1,s1
ffffffffc0209874:	8522                	mv	a0,s0
ffffffffc0209876:	2d5000ef          	jal	ra,ffffffffc020a34a <sfs_rbuf>
ffffffffc020987a:	f971                	bnez	a0,ffffffffc020984e <sfs_dirent_read_nolock+0x2a>
ffffffffc020987c:	100481a3          	sb	zero,259(s1)
ffffffffc0209880:	70a2                	ld	ra,40(sp)
ffffffffc0209882:	7402                	ld	s0,32(sp)
ffffffffc0209884:	64e2                	ld	s1,24(sp)
ffffffffc0209886:	6145                	addi	sp,sp,48
ffffffffc0209888:	8082                	ret
ffffffffc020988a:	00005697          	auipc	a3,0x5
ffffffffc020988e:	cc668693          	addi	a3,a3,-826 # ffffffffc020e550 <dev_node_ops+0x750>
ffffffffc0209892:	00001617          	auipc	a2,0x1
ffffffffc0209896:	71e60613          	addi	a2,a2,1822 # ffffffffc020afb0 <commands+0x210>
ffffffffc020989a:	18e00593          	li	a1,398
ffffffffc020989e:	00005517          	auipc	a0,0x5
ffffffffc02098a2:	b2250513          	addi	a0,a0,-1246 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02098a6:	bf9f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098aa:	872e                	mv	a4,a1
ffffffffc02098ac:	00005617          	auipc	a2,0x5
ffffffffc02098b0:	b6460613          	addi	a2,a2,-1180 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc02098b4:	05300593          	li	a1,83
ffffffffc02098b8:	00005517          	auipc	a0,0x5
ffffffffc02098bc:	b0850513          	addi	a0,a0,-1272 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02098c0:	bdff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098c4:	00005697          	auipc	a3,0x5
ffffffffc02098c8:	b8468693          	addi	a3,a3,-1148 # ffffffffc020e448 <dev_node_ops+0x648>
ffffffffc02098cc:	00001617          	auipc	a2,0x1
ffffffffc02098d0:	6e460613          	addi	a2,a2,1764 # ffffffffc020afb0 <commands+0x210>
ffffffffc02098d4:	19500593          	li	a1,405
ffffffffc02098d8:	00005517          	auipc	a0,0x5
ffffffffc02098dc:	ae850513          	addi	a0,a0,-1304 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02098e0:	bbff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02098e4 <sfs_getdirentry>:
ffffffffc02098e4:	715d                	addi	sp,sp,-80
ffffffffc02098e6:	ec56                	sd	s5,24(sp)
ffffffffc02098e8:	8aaa                	mv	s5,a0
ffffffffc02098ea:	10400513          	li	a0,260
ffffffffc02098ee:	e85a                	sd	s6,16(sp)
ffffffffc02098f0:	e486                	sd	ra,72(sp)
ffffffffc02098f2:	e0a2                	sd	s0,64(sp)
ffffffffc02098f4:	fc26                	sd	s1,56(sp)
ffffffffc02098f6:	f84a                	sd	s2,48(sp)
ffffffffc02098f8:	f44e                	sd	s3,40(sp)
ffffffffc02098fa:	f052                	sd	s4,32(sp)
ffffffffc02098fc:	e45e                	sd	s7,8(sp)
ffffffffc02098fe:	e062                	sd	s8,0(sp)
ffffffffc0209900:	8b2e                	mv	s6,a1
ffffffffc0209902:	e8cf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209906:	cd61                	beqz	a0,ffffffffc02099de <sfs_getdirentry+0xfa>
ffffffffc0209908:	068abb83          	ld	s7,104(s5)
ffffffffc020990c:	0c0b8b63          	beqz	s7,ffffffffc02099e2 <sfs_getdirentry+0xfe>
ffffffffc0209910:	0b0ba783          	lw	a5,176(s7) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc0209914:	e7f9                	bnez	a5,ffffffffc02099e2 <sfs_getdirentry+0xfe>
ffffffffc0209916:	058aa703          	lw	a4,88(s5)
ffffffffc020991a:	6785                	lui	a5,0x1
ffffffffc020991c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209920:	0ef71163          	bne	a4,a5,ffffffffc0209a02 <sfs_getdirentry+0x11e>
ffffffffc0209924:	008b3983          	ld	s3,8(s6)
ffffffffc0209928:	892a                	mv	s2,a0
ffffffffc020992a:	0a09c163          	bltz	s3,ffffffffc02099cc <sfs_getdirentry+0xe8>
ffffffffc020992e:	0ff9f793          	zext.b	a5,s3
ffffffffc0209932:	efc9                	bnez	a5,ffffffffc02099cc <sfs_getdirentry+0xe8>
ffffffffc0209934:	000ab783          	ld	a5,0(s5)
ffffffffc0209938:	0089d993          	srli	s3,s3,0x8
ffffffffc020993c:	2981                	sext.w	s3,s3
ffffffffc020993e:	479c                	lw	a5,8(a5)
ffffffffc0209940:	0937eb63          	bltu	a5,s3,ffffffffc02099d6 <sfs_getdirentry+0xf2>
ffffffffc0209944:	020a8c13          	addi	s8,s5,32
ffffffffc0209948:	8562                	mv	a0,s8
ffffffffc020994a:	aa9fa0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc020994e:	000ab783          	ld	a5,0(s5)
ffffffffc0209952:	0087aa03          	lw	s4,8(a5)
ffffffffc0209956:	07405663          	blez	s4,ffffffffc02099c2 <sfs_getdirentry+0xde>
ffffffffc020995a:	4481                	li	s1,0
ffffffffc020995c:	a811                	j	ffffffffc0209970 <sfs_getdirentry+0x8c>
ffffffffc020995e:	00092783          	lw	a5,0(s2)
ffffffffc0209962:	c781                	beqz	a5,ffffffffc020996a <sfs_getdirentry+0x86>
ffffffffc0209964:	02098263          	beqz	s3,ffffffffc0209988 <sfs_getdirentry+0xa4>
ffffffffc0209968:	39fd                	addiw	s3,s3,-1
ffffffffc020996a:	2485                	addiw	s1,s1,1
ffffffffc020996c:	049a0b63          	beq	s4,s1,ffffffffc02099c2 <sfs_getdirentry+0xde>
ffffffffc0209970:	86ca                	mv	a3,s2
ffffffffc0209972:	8626                	mv	a2,s1
ffffffffc0209974:	85d6                	mv	a1,s5
ffffffffc0209976:	855e                	mv	a0,s7
ffffffffc0209978:	eadff0ef          	jal	ra,ffffffffc0209824 <sfs_dirent_read_nolock>
ffffffffc020997c:	842a                	mv	s0,a0
ffffffffc020997e:	d165                	beqz	a0,ffffffffc020995e <sfs_getdirentry+0x7a>
ffffffffc0209980:	8562                	mv	a0,s8
ffffffffc0209982:	a6dfa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0209986:	a831                	j	ffffffffc02099a2 <sfs_getdirentry+0xbe>
ffffffffc0209988:	8562                	mv	a0,s8
ffffffffc020998a:	a65fa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020998e:	4701                	li	a4,0
ffffffffc0209990:	4685                	li	a3,1
ffffffffc0209992:	10000613          	li	a2,256
ffffffffc0209996:	00490593          	addi	a1,s2,4
ffffffffc020999a:	855a                	mv	a0,s6
ffffffffc020999c:	8dffb0ef          	jal	ra,ffffffffc020527a <iobuf_move>
ffffffffc02099a0:	842a                	mv	s0,a0
ffffffffc02099a2:	854a                	mv	a0,s2
ffffffffc02099a4:	e9af80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02099a8:	60a6                	ld	ra,72(sp)
ffffffffc02099aa:	8522                	mv	a0,s0
ffffffffc02099ac:	6406                	ld	s0,64(sp)
ffffffffc02099ae:	74e2                	ld	s1,56(sp)
ffffffffc02099b0:	7942                	ld	s2,48(sp)
ffffffffc02099b2:	79a2                	ld	s3,40(sp)
ffffffffc02099b4:	7a02                	ld	s4,32(sp)
ffffffffc02099b6:	6ae2                	ld	s5,24(sp)
ffffffffc02099b8:	6b42                	ld	s6,16(sp)
ffffffffc02099ba:	6ba2                	ld	s7,8(sp)
ffffffffc02099bc:	6c02                	ld	s8,0(sp)
ffffffffc02099be:	6161                	addi	sp,sp,80
ffffffffc02099c0:	8082                	ret
ffffffffc02099c2:	8562                	mv	a0,s8
ffffffffc02099c4:	5441                	li	s0,-16
ffffffffc02099c6:	a29fa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc02099ca:	bfe1                	j	ffffffffc02099a2 <sfs_getdirentry+0xbe>
ffffffffc02099cc:	854a                	mv	a0,s2
ffffffffc02099ce:	e70f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02099d2:	5475                	li	s0,-3
ffffffffc02099d4:	bfd1                	j	ffffffffc02099a8 <sfs_getdirentry+0xc4>
ffffffffc02099d6:	e68f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02099da:	5441                	li	s0,-16
ffffffffc02099dc:	b7f1                	j	ffffffffc02099a8 <sfs_getdirentry+0xc4>
ffffffffc02099de:	5471                	li	s0,-4
ffffffffc02099e0:	b7e1                	j	ffffffffc02099a8 <sfs_getdirentry+0xc4>
ffffffffc02099e2:	00004697          	auipc	a3,0x4
ffffffffc02099e6:	7fe68693          	addi	a3,a3,2046 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc02099ea:	00001617          	auipc	a2,0x1
ffffffffc02099ee:	5c660613          	addi	a2,a2,1478 # ffffffffc020afb0 <commands+0x210>
ffffffffc02099f2:	31000593          	li	a1,784
ffffffffc02099f6:	00005517          	auipc	a0,0x5
ffffffffc02099fa:	9ca50513          	addi	a0,a0,-1590 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc02099fe:	aa1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a02:	00005697          	auipc	a3,0x5
ffffffffc0209a06:	98668693          	addi	a3,a3,-1658 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc0209a0a:	00001617          	auipc	a2,0x1
ffffffffc0209a0e:	5a660613          	addi	a2,a2,1446 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209a12:	31100593          	li	a1,785
ffffffffc0209a16:	00005517          	auipc	a0,0x5
ffffffffc0209a1a:	9aa50513          	addi	a0,a0,-1622 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209a1e:	a81f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209a22 <sfs_dirent_search_nolock.constprop.0>:
ffffffffc0209a22:	715d                	addi	sp,sp,-80
ffffffffc0209a24:	f052                	sd	s4,32(sp)
ffffffffc0209a26:	8a2a                	mv	s4,a0
ffffffffc0209a28:	8532                	mv	a0,a2
ffffffffc0209a2a:	f44e                	sd	s3,40(sp)
ffffffffc0209a2c:	e85a                	sd	s6,16(sp)
ffffffffc0209a2e:	e45e                	sd	s7,8(sp)
ffffffffc0209a30:	e486                	sd	ra,72(sp)
ffffffffc0209a32:	e0a2                	sd	s0,64(sp)
ffffffffc0209a34:	fc26                	sd	s1,56(sp)
ffffffffc0209a36:	f84a                	sd	s2,48(sp)
ffffffffc0209a38:	ec56                	sd	s5,24(sp)
ffffffffc0209a3a:	e062                	sd	s8,0(sp)
ffffffffc0209a3c:	8b32                	mv	s6,a2
ffffffffc0209a3e:	89ae                	mv	s3,a1
ffffffffc0209a40:	8bb6                	mv	s7,a3
ffffffffc0209a42:	7eb000ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc0209a46:	0ff00793          	li	a5,255
ffffffffc0209a4a:	06a7ef63          	bltu	a5,a0,ffffffffc0209ac8 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc0209a4e:	10400513          	li	a0,260
ffffffffc0209a52:	d3cf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209a56:	892a                	mv	s2,a0
ffffffffc0209a58:	c535                	beqz	a0,ffffffffc0209ac4 <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc0209a5a:	0009b783          	ld	a5,0(s3)
ffffffffc0209a5e:	0087aa83          	lw	s5,8(a5)
ffffffffc0209a62:	05505a63          	blez	s5,ffffffffc0209ab6 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc0209a66:	4481                	li	s1,0
ffffffffc0209a68:	00450c13          	addi	s8,a0,4
ffffffffc0209a6c:	a829                	j	ffffffffc0209a86 <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc0209a6e:	00092783          	lw	a5,0(s2)
ffffffffc0209a72:	c799                	beqz	a5,ffffffffc0209a80 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc0209a74:	85e2                	mv	a1,s8
ffffffffc0209a76:	855a                	mv	a0,s6
ffffffffc0209a78:	7fd000ef          	jal	ra,ffffffffc020aa74 <strcmp>
ffffffffc0209a7c:	842a                	mv	s0,a0
ffffffffc0209a7e:	cd15                	beqz	a0,ffffffffc0209aba <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc0209a80:	2485                	addiw	s1,s1,1
ffffffffc0209a82:	029a8a63          	beq	s5,s1,ffffffffc0209ab6 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc0209a86:	86ca                	mv	a3,s2
ffffffffc0209a88:	8626                	mv	a2,s1
ffffffffc0209a8a:	85ce                	mv	a1,s3
ffffffffc0209a8c:	8552                	mv	a0,s4
ffffffffc0209a8e:	d97ff0ef          	jal	ra,ffffffffc0209824 <sfs_dirent_read_nolock>
ffffffffc0209a92:	842a                	mv	s0,a0
ffffffffc0209a94:	dd69                	beqz	a0,ffffffffc0209a6e <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc0209a96:	854a                	mv	a0,s2
ffffffffc0209a98:	da6f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209a9c:	60a6                	ld	ra,72(sp)
ffffffffc0209a9e:	8522                	mv	a0,s0
ffffffffc0209aa0:	6406                	ld	s0,64(sp)
ffffffffc0209aa2:	74e2                	ld	s1,56(sp)
ffffffffc0209aa4:	7942                	ld	s2,48(sp)
ffffffffc0209aa6:	79a2                	ld	s3,40(sp)
ffffffffc0209aa8:	7a02                	ld	s4,32(sp)
ffffffffc0209aaa:	6ae2                	ld	s5,24(sp)
ffffffffc0209aac:	6b42                	ld	s6,16(sp)
ffffffffc0209aae:	6ba2                	ld	s7,8(sp)
ffffffffc0209ab0:	6c02                	ld	s8,0(sp)
ffffffffc0209ab2:	6161                	addi	sp,sp,80
ffffffffc0209ab4:	8082                	ret
ffffffffc0209ab6:	5441                	li	s0,-16
ffffffffc0209ab8:	bff9                	j	ffffffffc0209a96 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc0209aba:	00092783          	lw	a5,0(s2)
ffffffffc0209abe:	00fba023          	sw	a5,0(s7)
ffffffffc0209ac2:	bfd1                	j	ffffffffc0209a96 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc0209ac4:	5471                	li	s0,-4
ffffffffc0209ac6:	bfd9                	j	ffffffffc0209a9c <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc0209ac8:	00005697          	auipc	a3,0x5
ffffffffc0209acc:	ad868693          	addi	a3,a3,-1320 # ffffffffc020e5a0 <dev_node_ops+0x7a0>
ffffffffc0209ad0:	00001617          	auipc	a2,0x1
ffffffffc0209ad4:	4e060613          	addi	a2,a2,1248 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209ad8:	1ba00593          	li	a1,442
ffffffffc0209adc:	00005517          	auipc	a0,0x5
ffffffffc0209ae0:	8e450513          	addi	a0,a0,-1820 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209ae4:	9bbf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209ae8 <sfs_truncfile>:
ffffffffc0209ae8:	7175                	addi	sp,sp,-144
ffffffffc0209aea:	e506                	sd	ra,136(sp)
ffffffffc0209aec:	e122                	sd	s0,128(sp)
ffffffffc0209aee:	fca6                	sd	s1,120(sp)
ffffffffc0209af0:	f8ca                	sd	s2,112(sp)
ffffffffc0209af2:	f4ce                	sd	s3,104(sp)
ffffffffc0209af4:	f0d2                	sd	s4,96(sp)
ffffffffc0209af6:	ecd6                	sd	s5,88(sp)
ffffffffc0209af8:	e8da                	sd	s6,80(sp)
ffffffffc0209afa:	e4de                	sd	s7,72(sp)
ffffffffc0209afc:	e0e2                	sd	s8,64(sp)
ffffffffc0209afe:	fc66                	sd	s9,56(sp)
ffffffffc0209b00:	f86a                	sd	s10,48(sp)
ffffffffc0209b02:	f46e                	sd	s11,40(sp)
ffffffffc0209b04:	080007b7          	lui	a5,0x8000
ffffffffc0209b08:	16b7e463          	bltu	a5,a1,ffffffffc0209c70 <sfs_truncfile+0x188>
ffffffffc0209b0c:	06853c83          	ld	s9,104(a0)
ffffffffc0209b10:	89aa                	mv	s3,a0
ffffffffc0209b12:	160c8163          	beqz	s9,ffffffffc0209c74 <sfs_truncfile+0x18c>
ffffffffc0209b16:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc0209b1a:	14079d63          	bnez	a5,ffffffffc0209c74 <sfs_truncfile+0x18c>
ffffffffc0209b1e:	4d38                	lw	a4,88(a0)
ffffffffc0209b20:	6405                	lui	s0,0x1
ffffffffc0209b22:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209b26:	16f71763          	bne	a4,a5,ffffffffc0209c94 <sfs_truncfile+0x1ac>
ffffffffc0209b2a:	00053a83          	ld	s5,0(a0)
ffffffffc0209b2e:	147d                	addi	s0,s0,-1
ffffffffc0209b30:	942e                	add	s0,s0,a1
ffffffffc0209b32:	000ae783          	lwu	a5,0(s5)
ffffffffc0209b36:	8031                	srli	s0,s0,0xc
ffffffffc0209b38:	8a2e                	mv	s4,a1
ffffffffc0209b3a:	2401                	sext.w	s0,s0
ffffffffc0209b3c:	02b79763          	bne	a5,a1,ffffffffc0209b6a <sfs_truncfile+0x82>
ffffffffc0209b40:	008aa783          	lw	a5,8(s5)
ffffffffc0209b44:	4901                	li	s2,0
ffffffffc0209b46:	18879763          	bne	a5,s0,ffffffffc0209cd4 <sfs_truncfile+0x1ec>
ffffffffc0209b4a:	60aa                	ld	ra,136(sp)
ffffffffc0209b4c:	640a                	ld	s0,128(sp)
ffffffffc0209b4e:	74e6                	ld	s1,120(sp)
ffffffffc0209b50:	79a6                	ld	s3,104(sp)
ffffffffc0209b52:	7a06                	ld	s4,96(sp)
ffffffffc0209b54:	6ae6                	ld	s5,88(sp)
ffffffffc0209b56:	6b46                	ld	s6,80(sp)
ffffffffc0209b58:	6ba6                	ld	s7,72(sp)
ffffffffc0209b5a:	6c06                	ld	s8,64(sp)
ffffffffc0209b5c:	7ce2                	ld	s9,56(sp)
ffffffffc0209b5e:	7d42                	ld	s10,48(sp)
ffffffffc0209b60:	7da2                	ld	s11,40(sp)
ffffffffc0209b62:	854a                	mv	a0,s2
ffffffffc0209b64:	7946                	ld	s2,112(sp)
ffffffffc0209b66:	6149                	addi	sp,sp,144
ffffffffc0209b68:	8082                	ret
ffffffffc0209b6a:	02050b13          	addi	s6,a0,32
ffffffffc0209b6e:	855a                	mv	a0,s6
ffffffffc0209b70:	883fa0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0209b74:	008aa483          	lw	s1,8(s5)
ffffffffc0209b78:	0a84e663          	bltu	s1,s0,ffffffffc0209c24 <sfs_truncfile+0x13c>
ffffffffc0209b7c:	0c947163          	bgeu	s0,s1,ffffffffc0209c3e <sfs_truncfile+0x156>
ffffffffc0209b80:	4dad                	li	s11,11
ffffffffc0209b82:	4b85                	li	s7,1
ffffffffc0209b84:	a09d                	j	ffffffffc0209bea <sfs_truncfile+0x102>
ffffffffc0209b86:	ff37091b          	addiw	s2,a4,-13
ffffffffc0209b8a:	0009079b          	sext.w	a5,s2
ffffffffc0209b8e:	3ff00713          	li	a4,1023
ffffffffc0209b92:	04f76563          	bltu	a4,a5,ffffffffc0209bdc <sfs_truncfile+0xf4>
ffffffffc0209b96:	03cd2c03          	lw	s8,60(s10)
ffffffffc0209b9a:	040c0163          	beqz	s8,ffffffffc0209bdc <sfs_truncfile+0xf4>
ffffffffc0209b9e:	004ca783          	lw	a5,4(s9)
ffffffffc0209ba2:	18fc7963          	bgeu	s8,a5,ffffffffc0209d34 <sfs_truncfile+0x24c>
ffffffffc0209ba6:	038cb503          	ld	a0,56(s9)
ffffffffc0209baa:	85e2                	mv	a1,s8
ffffffffc0209bac:	cddfe0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc0209bb0:	16051263          	bnez	a0,ffffffffc0209d14 <sfs_truncfile+0x22c>
ffffffffc0209bb4:	02091793          	slli	a5,s2,0x20
ffffffffc0209bb8:	01e7d713          	srli	a4,a5,0x1e
ffffffffc0209bbc:	86e2                	mv	a3,s8
ffffffffc0209bbe:	4611                	li	a2,4
ffffffffc0209bc0:	082c                	addi	a1,sp,24
ffffffffc0209bc2:	8566                	mv	a0,s9
ffffffffc0209bc4:	e43a                	sd	a4,8(sp)
ffffffffc0209bc6:	ce02                	sw	zero,28(sp)
ffffffffc0209bc8:	782000ef          	jal	ra,ffffffffc020a34a <sfs_rbuf>
ffffffffc0209bcc:	892a                	mv	s2,a0
ffffffffc0209bce:	e141                	bnez	a0,ffffffffc0209c4e <sfs_truncfile+0x166>
ffffffffc0209bd0:	47e2                	lw	a5,24(sp)
ffffffffc0209bd2:	6722                	ld	a4,8(sp)
ffffffffc0209bd4:	e3c9                	bnez	a5,ffffffffc0209c56 <sfs_truncfile+0x16e>
ffffffffc0209bd6:	008d2603          	lw	a2,8(s10)
ffffffffc0209bda:	367d                	addiw	a2,a2,-1
ffffffffc0209bdc:	00cd2423          	sw	a2,8(s10)
ffffffffc0209be0:	0179b823          	sd	s7,16(s3)
ffffffffc0209be4:	34fd                	addiw	s1,s1,-1
ffffffffc0209be6:	04940a63          	beq	s0,s1,ffffffffc0209c3a <sfs_truncfile+0x152>
ffffffffc0209bea:	0009bd03          	ld	s10,0(s3)
ffffffffc0209bee:	008d2703          	lw	a4,8(s10)
ffffffffc0209bf2:	c369                	beqz	a4,ffffffffc0209cb4 <sfs_truncfile+0x1cc>
ffffffffc0209bf4:	fff7079b          	addiw	a5,a4,-1
ffffffffc0209bf8:	0007861b          	sext.w	a2,a5
ffffffffc0209bfc:	f8cde5e3          	bltu	s11,a2,ffffffffc0209b86 <sfs_truncfile+0x9e>
ffffffffc0209c00:	02079713          	slli	a4,a5,0x20
ffffffffc0209c04:	01e75793          	srli	a5,a4,0x1e
ffffffffc0209c08:	00fd0933          	add	s2,s10,a5
ffffffffc0209c0c:	00c92583          	lw	a1,12(s2)
ffffffffc0209c10:	d5f1                	beqz	a1,ffffffffc0209bdc <sfs_truncfile+0xf4>
ffffffffc0209c12:	8566                	mv	a0,s9
ffffffffc0209c14:	efeff0ef          	jal	ra,ffffffffc0209312 <sfs_block_free>
ffffffffc0209c18:	00092623          	sw	zero,12(s2)
ffffffffc0209c1c:	008d2603          	lw	a2,8(s10)
ffffffffc0209c20:	367d                	addiw	a2,a2,-1
ffffffffc0209c22:	bf6d                	j	ffffffffc0209bdc <sfs_truncfile+0xf4>
ffffffffc0209c24:	4681                	li	a3,0
ffffffffc0209c26:	8626                	mv	a2,s1
ffffffffc0209c28:	85ce                	mv	a1,s3
ffffffffc0209c2a:	8566                	mv	a0,s9
ffffffffc0209c2c:	9a1ff0ef          	jal	ra,ffffffffc02095cc <sfs_bmap_load_nolock>
ffffffffc0209c30:	892a                	mv	s2,a0
ffffffffc0209c32:	ed11                	bnez	a0,ffffffffc0209c4e <sfs_truncfile+0x166>
ffffffffc0209c34:	2485                	addiw	s1,s1,1
ffffffffc0209c36:	fe9417e3          	bne	s0,s1,ffffffffc0209c24 <sfs_truncfile+0x13c>
ffffffffc0209c3a:	008aa483          	lw	s1,8(s5)
ffffffffc0209c3e:	0a941b63          	bne	s0,s1,ffffffffc0209cf4 <sfs_truncfile+0x20c>
ffffffffc0209c42:	014aa023          	sw	s4,0(s5)
ffffffffc0209c46:	4785                	li	a5,1
ffffffffc0209c48:	00f9b823          	sd	a5,16(s3)
ffffffffc0209c4c:	4901                	li	s2,0
ffffffffc0209c4e:	855a                	mv	a0,s6
ffffffffc0209c50:	f9efa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc0209c54:	bddd                	j	ffffffffc0209b4a <sfs_truncfile+0x62>
ffffffffc0209c56:	86e2                	mv	a3,s8
ffffffffc0209c58:	4611                	li	a2,4
ffffffffc0209c5a:	086c                	addi	a1,sp,28
ffffffffc0209c5c:	8566                	mv	a0,s9
ffffffffc0209c5e:	76c000ef          	jal	ra,ffffffffc020a3ca <sfs_wbuf>
ffffffffc0209c62:	892a                	mv	s2,a0
ffffffffc0209c64:	f56d                	bnez	a0,ffffffffc0209c4e <sfs_truncfile+0x166>
ffffffffc0209c66:	45e2                	lw	a1,24(sp)
ffffffffc0209c68:	8566                	mv	a0,s9
ffffffffc0209c6a:	ea8ff0ef          	jal	ra,ffffffffc0209312 <sfs_block_free>
ffffffffc0209c6e:	b7a5                	j	ffffffffc0209bd6 <sfs_truncfile+0xee>
ffffffffc0209c70:	5975                	li	s2,-3
ffffffffc0209c72:	bde1                	j	ffffffffc0209b4a <sfs_truncfile+0x62>
ffffffffc0209c74:	00004697          	auipc	a3,0x4
ffffffffc0209c78:	56c68693          	addi	a3,a3,1388 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc0209c7c:	00001617          	auipc	a2,0x1
ffffffffc0209c80:	33460613          	addi	a2,a2,820 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209c84:	37f00593          	li	a1,895
ffffffffc0209c88:	00004517          	auipc	a0,0x4
ffffffffc0209c8c:	73850513          	addi	a0,a0,1848 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209c90:	80ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c94:	00004697          	auipc	a3,0x4
ffffffffc0209c98:	6f468693          	addi	a3,a3,1780 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc0209c9c:	00001617          	auipc	a2,0x1
ffffffffc0209ca0:	31460613          	addi	a2,a2,788 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209ca4:	38000593          	li	a1,896
ffffffffc0209ca8:	00004517          	auipc	a0,0x4
ffffffffc0209cac:	71850513          	addi	a0,a0,1816 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209cb0:	feef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cb4:	00005697          	auipc	a3,0x5
ffffffffc0209cb8:	92c68693          	addi	a3,a3,-1748 # ffffffffc020e5e0 <dev_node_ops+0x7e0>
ffffffffc0209cbc:	00001617          	auipc	a2,0x1
ffffffffc0209cc0:	2f460613          	addi	a2,a2,756 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209cc4:	17b00593          	li	a1,379
ffffffffc0209cc8:	00004517          	auipc	a0,0x4
ffffffffc0209ccc:	6f850513          	addi	a0,a0,1784 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209cd0:	fcef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cd4:	00005697          	auipc	a3,0x5
ffffffffc0209cd8:	8f468693          	addi	a3,a3,-1804 # ffffffffc020e5c8 <dev_node_ops+0x7c8>
ffffffffc0209cdc:	00001617          	auipc	a2,0x1
ffffffffc0209ce0:	2d460613          	addi	a2,a2,724 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209ce4:	38700593          	li	a1,903
ffffffffc0209ce8:	00004517          	auipc	a0,0x4
ffffffffc0209cec:	6d850513          	addi	a0,a0,1752 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209cf0:	faef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209cf4:	00005697          	auipc	a3,0x5
ffffffffc0209cf8:	93c68693          	addi	a3,a3,-1732 # ffffffffc020e630 <dev_node_ops+0x830>
ffffffffc0209cfc:	00001617          	auipc	a2,0x1
ffffffffc0209d00:	2b460613          	addi	a2,a2,692 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209d04:	3a000593          	li	a1,928
ffffffffc0209d08:	00004517          	auipc	a0,0x4
ffffffffc0209d0c:	6b850513          	addi	a0,a0,1720 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209d10:	f8ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d14:	00005697          	auipc	a3,0x5
ffffffffc0209d18:	8e468693          	addi	a3,a3,-1820 # ffffffffc020e5f8 <dev_node_ops+0x7f8>
ffffffffc0209d1c:	00001617          	auipc	a2,0x1
ffffffffc0209d20:	29460613          	addi	a2,a2,660 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209d24:	12b00593          	li	a1,299
ffffffffc0209d28:	00004517          	auipc	a0,0x4
ffffffffc0209d2c:	69850513          	addi	a0,a0,1688 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209d30:	f6ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d34:	8762                	mv	a4,s8
ffffffffc0209d36:	86be                	mv	a3,a5
ffffffffc0209d38:	00004617          	auipc	a2,0x4
ffffffffc0209d3c:	6d860613          	addi	a2,a2,1752 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc0209d40:	05300593          	li	a1,83
ffffffffc0209d44:	00004517          	auipc	a0,0x4
ffffffffc0209d48:	67c50513          	addi	a0,a0,1660 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209d4c:	f52f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209d50 <sfs_load_inode>:
ffffffffc0209d50:	7139                	addi	sp,sp,-64
ffffffffc0209d52:	fc06                	sd	ra,56(sp)
ffffffffc0209d54:	f822                	sd	s0,48(sp)
ffffffffc0209d56:	f426                	sd	s1,40(sp)
ffffffffc0209d58:	f04a                	sd	s2,32(sp)
ffffffffc0209d5a:	84b2                	mv	s1,a2
ffffffffc0209d5c:	892a                	mv	s2,a0
ffffffffc0209d5e:	ec4e                	sd	s3,24(sp)
ffffffffc0209d60:	e852                	sd	s4,16(sp)
ffffffffc0209d62:	89ae                	mv	s3,a1
ffffffffc0209d64:	e456                	sd	s5,8(sp)
ffffffffc0209d66:	015000ef          	jal	ra,ffffffffc020a57a <lock_sfs_fs>
ffffffffc0209d6a:	45a9                	li	a1,10
ffffffffc0209d6c:	8526                	mv	a0,s1
ffffffffc0209d6e:	0a893403          	ld	s0,168(s2)
ffffffffc0209d72:	029000ef          	jal	ra,ffffffffc020a59a <hash32>
ffffffffc0209d76:	02051793          	slli	a5,a0,0x20
ffffffffc0209d7a:	01c7d713          	srli	a4,a5,0x1c
ffffffffc0209d7e:	9722                	add	a4,a4,s0
ffffffffc0209d80:	843a                	mv	s0,a4
ffffffffc0209d82:	a029                	j	ffffffffc0209d8c <sfs_load_inode+0x3c>
ffffffffc0209d84:	fc042783          	lw	a5,-64(s0)
ffffffffc0209d88:	10978863          	beq	a5,s1,ffffffffc0209e98 <sfs_load_inode+0x148>
ffffffffc0209d8c:	6400                	ld	s0,8(s0)
ffffffffc0209d8e:	fe871be3          	bne	a4,s0,ffffffffc0209d84 <sfs_load_inode+0x34>
ffffffffc0209d92:	04000513          	li	a0,64
ffffffffc0209d96:	9f8f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209d9a:	8aaa                	mv	s5,a0
ffffffffc0209d9c:	16050563          	beqz	a0,ffffffffc0209f06 <sfs_load_inode+0x1b6>
ffffffffc0209da0:	00492683          	lw	a3,4(s2)
ffffffffc0209da4:	18048363          	beqz	s1,ffffffffc0209f2a <sfs_load_inode+0x1da>
ffffffffc0209da8:	18d4f163          	bgeu	s1,a3,ffffffffc0209f2a <sfs_load_inode+0x1da>
ffffffffc0209dac:	03893503          	ld	a0,56(s2)
ffffffffc0209db0:	85a6                	mv	a1,s1
ffffffffc0209db2:	ad7fe0ef          	jal	ra,ffffffffc0208888 <bitmap_test>
ffffffffc0209db6:	18051763          	bnez	a0,ffffffffc0209f44 <sfs_load_inode+0x1f4>
ffffffffc0209dba:	4701                	li	a4,0
ffffffffc0209dbc:	86a6                	mv	a3,s1
ffffffffc0209dbe:	04000613          	li	a2,64
ffffffffc0209dc2:	85d6                	mv	a1,s5
ffffffffc0209dc4:	854a                	mv	a0,s2
ffffffffc0209dc6:	584000ef          	jal	ra,ffffffffc020a34a <sfs_rbuf>
ffffffffc0209dca:	842a                	mv	s0,a0
ffffffffc0209dcc:	0e051563          	bnez	a0,ffffffffc0209eb6 <sfs_load_inode+0x166>
ffffffffc0209dd0:	006ad783          	lhu	a5,6(s5)
ffffffffc0209dd4:	12078b63          	beqz	a5,ffffffffc0209f0a <sfs_load_inode+0x1ba>
ffffffffc0209dd8:	6405                	lui	s0,0x1
ffffffffc0209dda:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209dde:	a64fd0ef          	jal	ra,ffffffffc0207042 <__alloc_inode>
ffffffffc0209de2:	8a2a                	mv	s4,a0
ffffffffc0209de4:	c961                	beqz	a0,ffffffffc0209eb4 <sfs_load_inode+0x164>
ffffffffc0209de6:	004ad683          	lhu	a3,4(s5)
ffffffffc0209dea:	4785                	li	a5,1
ffffffffc0209dec:	0cf69c63          	bne	a3,a5,ffffffffc0209ec4 <sfs_load_inode+0x174>
ffffffffc0209df0:	864a                	mv	a2,s2
ffffffffc0209df2:	00005597          	auipc	a1,0x5
ffffffffc0209df6:	94e58593          	addi	a1,a1,-1714 # ffffffffc020e740 <sfs_node_fileops>
ffffffffc0209dfa:	a64fd0ef          	jal	ra,ffffffffc020705e <inode_init>
ffffffffc0209dfe:	058a2783          	lw	a5,88(s4)
ffffffffc0209e02:	23540413          	addi	s0,s0,565
ffffffffc0209e06:	0e879063          	bne	a5,s0,ffffffffc0209ee6 <sfs_load_inode+0x196>
ffffffffc0209e0a:	4785                	li	a5,1
ffffffffc0209e0c:	00fa2c23          	sw	a5,24(s4)
ffffffffc0209e10:	015a3023          	sd	s5,0(s4)
ffffffffc0209e14:	009a2423          	sw	s1,8(s4)
ffffffffc0209e18:	000a3823          	sd	zero,16(s4)
ffffffffc0209e1c:	4585                	li	a1,1
ffffffffc0209e1e:	020a0513          	addi	a0,s4,32
ffffffffc0209e22:	dc6fa0ef          	jal	ra,ffffffffc02043e8 <sem_init>
ffffffffc0209e26:	058a2703          	lw	a4,88(s4)
ffffffffc0209e2a:	6785                	lui	a5,0x1
ffffffffc0209e2c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209e30:	14f71663          	bne	a4,a5,ffffffffc0209f7c <sfs_load_inode+0x22c>
ffffffffc0209e34:	0a093703          	ld	a4,160(s2)
ffffffffc0209e38:	038a0793          	addi	a5,s4,56
ffffffffc0209e3c:	008a2503          	lw	a0,8(s4)
ffffffffc0209e40:	e31c                	sd	a5,0(a4)
ffffffffc0209e42:	0af93023          	sd	a5,160(s2)
ffffffffc0209e46:	09890793          	addi	a5,s2,152
ffffffffc0209e4a:	0a893403          	ld	s0,168(s2)
ffffffffc0209e4e:	45a9                	li	a1,10
ffffffffc0209e50:	04ea3023          	sd	a4,64(s4)
ffffffffc0209e54:	02fa3c23          	sd	a5,56(s4)
ffffffffc0209e58:	742000ef          	jal	ra,ffffffffc020a59a <hash32>
ffffffffc0209e5c:	02051713          	slli	a4,a0,0x20
ffffffffc0209e60:	01c75793          	srli	a5,a4,0x1c
ffffffffc0209e64:	97a2                	add	a5,a5,s0
ffffffffc0209e66:	6798                	ld	a4,8(a5)
ffffffffc0209e68:	048a0693          	addi	a3,s4,72
ffffffffc0209e6c:	e314                	sd	a3,0(a4)
ffffffffc0209e6e:	e794                	sd	a3,8(a5)
ffffffffc0209e70:	04ea3823          	sd	a4,80(s4)
ffffffffc0209e74:	04fa3423          	sd	a5,72(s4)
ffffffffc0209e78:	854a                	mv	a0,s2
ffffffffc0209e7a:	710000ef          	jal	ra,ffffffffc020a58a <unlock_sfs_fs>
ffffffffc0209e7e:	4401                	li	s0,0
ffffffffc0209e80:	0149b023          	sd	s4,0(s3)
ffffffffc0209e84:	70e2                	ld	ra,56(sp)
ffffffffc0209e86:	8522                	mv	a0,s0
ffffffffc0209e88:	7442                	ld	s0,48(sp)
ffffffffc0209e8a:	74a2                	ld	s1,40(sp)
ffffffffc0209e8c:	7902                	ld	s2,32(sp)
ffffffffc0209e8e:	69e2                	ld	s3,24(sp)
ffffffffc0209e90:	6a42                	ld	s4,16(sp)
ffffffffc0209e92:	6aa2                	ld	s5,8(sp)
ffffffffc0209e94:	6121                	addi	sp,sp,64
ffffffffc0209e96:	8082                	ret
ffffffffc0209e98:	fb840a13          	addi	s4,s0,-72
ffffffffc0209e9c:	8552                	mv	a0,s4
ffffffffc0209e9e:	a22fd0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0209ea2:	4785                	li	a5,1
ffffffffc0209ea4:	fcf51ae3          	bne	a0,a5,ffffffffc0209e78 <sfs_load_inode+0x128>
ffffffffc0209ea8:	fd042783          	lw	a5,-48(s0)
ffffffffc0209eac:	2785                	addiw	a5,a5,1
ffffffffc0209eae:	fcf42823          	sw	a5,-48(s0)
ffffffffc0209eb2:	b7d9                	j	ffffffffc0209e78 <sfs_load_inode+0x128>
ffffffffc0209eb4:	5471                	li	s0,-4
ffffffffc0209eb6:	8556                	mv	a0,s5
ffffffffc0209eb8:	986f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209ebc:	854a                	mv	a0,s2
ffffffffc0209ebe:	6cc000ef          	jal	ra,ffffffffc020a58a <unlock_sfs_fs>
ffffffffc0209ec2:	b7c9                	j	ffffffffc0209e84 <sfs_load_inode+0x134>
ffffffffc0209ec4:	4789                	li	a5,2
ffffffffc0209ec6:	08f69f63          	bne	a3,a5,ffffffffc0209f64 <sfs_load_inode+0x214>
ffffffffc0209eca:	864a                	mv	a2,s2
ffffffffc0209ecc:	00004597          	auipc	a1,0x4
ffffffffc0209ed0:	7f458593          	addi	a1,a1,2036 # ffffffffc020e6c0 <sfs_node_dirops>
ffffffffc0209ed4:	98afd0ef          	jal	ra,ffffffffc020705e <inode_init>
ffffffffc0209ed8:	058a2703          	lw	a4,88(s4)
ffffffffc0209edc:	6785                	lui	a5,0x1
ffffffffc0209ede:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209ee2:	f2f704e3          	beq	a4,a5,ffffffffc0209e0a <sfs_load_inode+0xba>
ffffffffc0209ee6:	00004697          	auipc	a3,0x4
ffffffffc0209eea:	4a268693          	addi	a3,a3,1186 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc0209eee:	00001617          	auipc	a2,0x1
ffffffffc0209ef2:	0c260613          	addi	a2,a2,194 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209ef6:	07700593          	li	a1,119
ffffffffc0209efa:	00004517          	auipc	a0,0x4
ffffffffc0209efe:	4c650513          	addi	a0,a0,1222 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209f02:	d9cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f06:	5471                	li	s0,-4
ffffffffc0209f08:	bf55                	j	ffffffffc0209ebc <sfs_load_inode+0x16c>
ffffffffc0209f0a:	00004697          	auipc	a3,0x4
ffffffffc0209f0e:	73e68693          	addi	a3,a3,1854 # ffffffffc020e648 <dev_node_ops+0x848>
ffffffffc0209f12:	00001617          	auipc	a2,0x1
ffffffffc0209f16:	09e60613          	addi	a2,a2,158 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209f1a:	0ad00593          	li	a1,173
ffffffffc0209f1e:	00004517          	auipc	a0,0x4
ffffffffc0209f22:	4a250513          	addi	a0,a0,1186 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209f26:	d78f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f2a:	8726                	mv	a4,s1
ffffffffc0209f2c:	00004617          	auipc	a2,0x4
ffffffffc0209f30:	4e460613          	addi	a2,a2,1252 # ffffffffc020e410 <dev_node_ops+0x610>
ffffffffc0209f34:	05300593          	li	a1,83
ffffffffc0209f38:	00004517          	auipc	a0,0x4
ffffffffc0209f3c:	48850513          	addi	a0,a0,1160 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209f40:	d5ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f44:	00004697          	auipc	a3,0x4
ffffffffc0209f48:	50468693          	addi	a3,a3,1284 # ffffffffc020e448 <dev_node_ops+0x648>
ffffffffc0209f4c:	00001617          	auipc	a2,0x1
ffffffffc0209f50:	06460613          	addi	a2,a2,100 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209f54:	0a800593          	li	a1,168
ffffffffc0209f58:	00004517          	auipc	a0,0x4
ffffffffc0209f5c:	46850513          	addi	a0,a0,1128 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209f60:	d3ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f64:	00004617          	auipc	a2,0x4
ffffffffc0209f68:	47460613          	addi	a2,a2,1140 # ffffffffc020e3d8 <dev_node_ops+0x5d8>
ffffffffc0209f6c:	02e00593          	li	a1,46
ffffffffc0209f70:	00004517          	auipc	a0,0x4
ffffffffc0209f74:	45050513          	addi	a0,a0,1104 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209f78:	d26f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209f7c:	00004697          	auipc	a3,0x4
ffffffffc0209f80:	40c68693          	addi	a3,a3,1036 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc0209f84:	00001617          	auipc	a2,0x1
ffffffffc0209f88:	02c60613          	addi	a2,a2,44 # ffffffffc020afb0 <commands+0x210>
ffffffffc0209f8c:	0b100593          	li	a1,177
ffffffffc0209f90:	00004517          	auipc	a0,0x4
ffffffffc0209f94:	43050513          	addi	a0,a0,1072 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc0209f98:	d06f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209f9c <sfs_lookup>:
ffffffffc0209f9c:	7139                	addi	sp,sp,-64
ffffffffc0209f9e:	ec4e                	sd	s3,24(sp)
ffffffffc0209fa0:	06853983          	ld	s3,104(a0)
ffffffffc0209fa4:	fc06                	sd	ra,56(sp)
ffffffffc0209fa6:	f822                	sd	s0,48(sp)
ffffffffc0209fa8:	f426                	sd	s1,40(sp)
ffffffffc0209faa:	f04a                	sd	s2,32(sp)
ffffffffc0209fac:	e852                	sd	s4,16(sp)
ffffffffc0209fae:	0a098c63          	beqz	s3,ffffffffc020a066 <sfs_lookup+0xca>
ffffffffc0209fb2:	0b09a783          	lw	a5,176(s3)
ffffffffc0209fb6:	ebc5                	bnez	a5,ffffffffc020a066 <sfs_lookup+0xca>
ffffffffc0209fb8:	0005c783          	lbu	a5,0(a1)
ffffffffc0209fbc:	84ae                	mv	s1,a1
ffffffffc0209fbe:	c7c1                	beqz	a5,ffffffffc020a046 <sfs_lookup+0xaa>
ffffffffc0209fc0:	02f00713          	li	a4,47
ffffffffc0209fc4:	08e78163          	beq	a5,a4,ffffffffc020a046 <sfs_lookup+0xaa>
ffffffffc0209fc8:	842a                	mv	s0,a0
ffffffffc0209fca:	8a32                	mv	s4,a2
ffffffffc0209fcc:	8f4fd0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc0209fd0:	4c38                	lw	a4,88(s0)
ffffffffc0209fd2:	6785                	lui	a5,0x1
ffffffffc0209fd4:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209fd8:	0af71763          	bne	a4,a5,ffffffffc020a086 <sfs_lookup+0xea>
ffffffffc0209fdc:	6018                	ld	a4,0(s0)
ffffffffc0209fde:	4789                	li	a5,2
ffffffffc0209fe0:	00475703          	lhu	a4,4(a4)
ffffffffc0209fe4:	04f71c63          	bne	a4,a5,ffffffffc020a03c <sfs_lookup+0xa0>
ffffffffc0209fe8:	02040913          	addi	s2,s0,32
ffffffffc0209fec:	854a                	mv	a0,s2
ffffffffc0209fee:	c04fa0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc0209ff2:	8626                	mv	a2,s1
ffffffffc0209ff4:	0054                	addi	a3,sp,4
ffffffffc0209ff6:	85a2                	mv	a1,s0
ffffffffc0209ff8:	854e                	mv	a0,s3
ffffffffc0209ffa:	a29ff0ef          	jal	ra,ffffffffc0209a22 <sfs_dirent_search_nolock.constprop.0>
ffffffffc0209ffe:	84aa                	mv	s1,a0
ffffffffc020a000:	854a                	mv	a0,s2
ffffffffc020a002:	becfa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020a006:	cc89                	beqz	s1,ffffffffc020a020 <sfs_lookup+0x84>
ffffffffc020a008:	8522                	mv	a0,s0
ffffffffc020a00a:	984fd0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020a00e:	70e2                	ld	ra,56(sp)
ffffffffc020a010:	7442                	ld	s0,48(sp)
ffffffffc020a012:	7902                	ld	s2,32(sp)
ffffffffc020a014:	69e2                	ld	s3,24(sp)
ffffffffc020a016:	6a42                	ld	s4,16(sp)
ffffffffc020a018:	8526                	mv	a0,s1
ffffffffc020a01a:	74a2                	ld	s1,40(sp)
ffffffffc020a01c:	6121                	addi	sp,sp,64
ffffffffc020a01e:	8082                	ret
ffffffffc020a020:	4612                	lw	a2,4(sp)
ffffffffc020a022:	002c                	addi	a1,sp,8
ffffffffc020a024:	854e                	mv	a0,s3
ffffffffc020a026:	d2bff0ef          	jal	ra,ffffffffc0209d50 <sfs_load_inode>
ffffffffc020a02a:	84aa                	mv	s1,a0
ffffffffc020a02c:	8522                	mv	a0,s0
ffffffffc020a02e:	960fd0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020a032:	fcf1                	bnez	s1,ffffffffc020a00e <sfs_lookup+0x72>
ffffffffc020a034:	67a2                	ld	a5,8(sp)
ffffffffc020a036:	00fa3023          	sd	a5,0(s4)
ffffffffc020a03a:	bfd1                	j	ffffffffc020a00e <sfs_lookup+0x72>
ffffffffc020a03c:	8522                	mv	a0,s0
ffffffffc020a03e:	950fd0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020a042:	54b9                	li	s1,-18
ffffffffc020a044:	b7e9                	j	ffffffffc020a00e <sfs_lookup+0x72>
ffffffffc020a046:	00004697          	auipc	a3,0x4
ffffffffc020a04a:	61a68693          	addi	a3,a3,1562 # ffffffffc020e660 <dev_node_ops+0x860>
ffffffffc020a04e:	00001617          	auipc	a2,0x1
ffffffffc020a052:	f6260613          	addi	a2,a2,-158 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a056:	3b100593          	li	a1,945
ffffffffc020a05a:	00004517          	auipc	a0,0x4
ffffffffc020a05e:	36650513          	addi	a0,a0,870 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a062:	c3cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a066:	00004697          	auipc	a3,0x4
ffffffffc020a06a:	17a68693          	addi	a3,a3,378 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc020a06e:	00001617          	auipc	a2,0x1
ffffffffc020a072:	f4260613          	addi	a2,a2,-190 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a076:	3b000593          	li	a1,944
ffffffffc020a07a:	00004517          	auipc	a0,0x4
ffffffffc020a07e:	34650513          	addi	a0,a0,838 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a082:	c1cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a086:	00004697          	auipc	a3,0x4
ffffffffc020a08a:	30268693          	addi	a3,a3,770 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc020a08e:	00001617          	auipc	a2,0x1
ffffffffc020a092:	f2260613          	addi	a2,a2,-222 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a096:	3b300593          	li	a1,947
ffffffffc020a09a:	00004517          	auipc	a0,0x4
ffffffffc020a09e:	32650513          	addi	a0,a0,806 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a0a2:	bfcf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a0a6 <sfs_namefile>:
ffffffffc020a0a6:	6d98                	ld	a4,24(a1)
ffffffffc020a0a8:	7175                	addi	sp,sp,-144
ffffffffc020a0aa:	e506                	sd	ra,136(sp)
ffffffffc020a0ac:	e122                	sd	s0,128(sp)
ffffffffc020a0ae:	fca6                	sd	s1,120(sp)
ffffffffc020a0b0:	f8ca                	sd	s2,112(sp)
ffffffffc020a0b2:	f4ce                	sd	s3,104(sp)
ffffffffc020a0b4:	f0d2                	sd	s4,96(sp)
ffffffffc020a0b6:	ecd6                	sd	s5,88(sp)
ffffffffc020a0b8:	e8da                	sd	s6,80(sp)
ffffffffc020a0ba:	e4de                	sd	s7,72(sp)
ffffffffc020a0bc:	e0e2                	sd	s8,64(sp)
ffffffffc020a0be:	fc66                	sd	s9,56(sp)
ffffffffc020a0c0:	f86a                	sd	s10,48(sp)
ffffffffc020a0c2:	f46e                	sd	s11,40(sp)
ffffffffc020a0c4:	e42e                	sd	a1,8(sp)
ffffffffc020a0c6:	4789                	li	a5,2
ffffffffc020a0c8:	1ae7f363          	bgeu	a5,a4,ffffffffc020a26e <sfs_namefile+0x1c8>
ffffffffc020a0cc:	89aa                	mv	s3,a0
ffffffffc020a0ce:	10400513          	li	a0,260
ffffffffc020a0d2:	ebdf70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a0d6:	842a                	mv	s0,a0
ffffffffc020a0d8:	18050b63          	beqz	a0,ffffffffc020a26e <sfs_namefile+0x1c8>
ffffffffc020a0dc:	0689b483          	ld	s1,104(s3)
ffffffffc020a0e0:	1e048963          	beqz	s1,ffffffffc020a2d2 <sfs_namefile+0x22c>
ffffffffc020a0e4:	0b04a783          	lw	a5,176(s1)
ffffffffc020a0e8:	1e079563          	bnez	a5,ffffffffc020a2d2 <sfs_namefile+0x22c>
ffffffffc020a0ec:	0589ac83          	lw	s9,88(s3)
ffffffffc020a0f0:	6785                	lui	a5,0x1
ffffffffc020a0f2:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a0f6:	1afc9e63          	bne	s9,a5,ffffffffc020a2b2 <sfs_namefile+0x20c>
ffffffffc020a0fa:	6722                	ld	a4,8(sp)
ffffffffc020a0fc:	854e                	mv	a0,s3
ffffffffc020a0fe:	8ace                	mv	s5,s3
ffffffffc020a100:	6f1c                	ld	a5,24(a4)
ffffffffc020a102:	00073b03          	ld	s6,0(a4)
ffffffffc020a106:	02098a13          	addi	s4,s3,32
ffffffffc020a10a:	ffe78b93          	addi	s7,a5,-2
ffffffffc020a10e:	9b3e                	add	s6,s6,a5
ffffffffc020a110:	00004d17          	auipc	s10,0x4
ffffffffc020a114:	570d0d13          	addi	s10,s10,1392 # ffffffffc020e680 <dev_node_ops+0x880>
ffffffffc020a118:	fa9fc0ef          	jal	ra,ffffffffc02070c0 <inode_ref_inc>
ffffffffc020a11c:	00440c13          	addi	s8,s0,4
ffffffffc020a120:	e066                	sd	s9,0(sp)
ffffffffc020a122:	8552                	mv	a0,s4
ffffffffc020a124:	acefa0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc020a128:	0854                	addi	a3,sp,20
ffffffffc020a12a:	866a                	mv	a2,s10
ffffffffc020a12c:	85d6                	mv	a1,s5
ffffffffc020a12e:	8526                	mv	a0,s1
ffffffffc020a130:	8f3ff0ef          	jal	ra,ffffffffc0209a22 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a134:	8daa                	mv	s11,a0
ffffffffc020a136:	8552                	mv	a0,s4
ffffffffc020a138:	ab6fa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020a13c:	020d8863          	beqz	s11,ffffffffc020a16c <sfs_namefile+0xc6>
ffffffffc020a140:	854e                	mv	a0,s3
ffffffffc020a142:	84cfd0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020a146:	8522                	mv	a0,s0
ffffffffc020a148:	ef7f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a14c:	60aa                	ld	ra,136(sp)
ffffffffc020a14e:	640a                	ld	s0,128(sp)
ffffffffc020a150:	74e6                	ld	s1,120(sp)
ffffffffc020a152:	7946                	ld	s2,112(sp)
ffffffffc020a154:	79a6                	ld	s3,104(sp)
ffffffffc020a156:	7a06                	ld	s4,96(sp)
ffffffffc020a158:	6ae6                	ld	s5,88(sp)
ffffffffc020a15a:	6b46                	ld	s6,80(sp)
ffffffffc020a15c:	6ba6                	ld	s7,72(sp)
ffffffffc020a15e:	6c06                	ld	s8,64(sp)
ffffffffc020a160:	7ce2                	ld	s9,56(sp)
ffffffffc020a162:	7d42                	ld	s10,48(sp)
ffffffffc020a164:	856e                	mv	a0,s11
ffffffffc020a166:	7da2                	ld	s11,40(sp)
ffffffffc020a168:	6149                	addi	sp,sp,144
ffffffffc020a16a:	8082                	ret
ffffffffc020a16c:	4652                	lw	a2,20(sp)
ffffffffc020a16e:	082c                	addi	a1,sp,24
ffffffffc020a170:	8526                	mv	a0,s1
ffffffffc020a172:	bdfff0ef          	jal	ra,ffffffffc0209d50 <sfs_load_inode>
ffffffffc020a176:	8daa                	mv	s11,a0
ffffffffc020a178:	f561                	bnez	a0,ffffffffc020a140 <sfs_namefile+0x9a>
ffffffffc020a17a:	854e                	mv	a0,s3
ffffffffc020a17c:	008aa903          	lw	s2,8(s5)
ffffffffc020a180:	80efd0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020a184:	6ce2                	ld	s9,24(sp)
ffffffffc020a186:	0b3c8463          	beq	s9,s3,ffffffffc020a22e <sfs_namefile+0x188>
ffffffffc020a18a:	100c8463          	beqz	s9,ffffffffc020a292 <sfs_namefile+0x1ec>
ffffffffc020a18e:	058ca703          	lw	a4,88(s9)
ffffffffc020a192:	6782                	ld	a5,0(sp)
ffffffffc020a194:	0ef71f63          	bne	a4,a5,ffffffffc020a292 <sfs_namefile+0x1ec>
ffffffffc020a198:	008ca703          	lw	a4,8(s9)
ffffffffc020a19c:	8ae6                	mv	s5,s9
ffffffffc020a19e:	0d270a63          	beq	a4,s2,ffffffffc020a272 <sfs_namefile+0x1cc>
ffffffffc020a1a2:	000cb703          	ld	a4,0(s9)
ffffffffc020a1a6:	4789                	li	a5,2
ffffffffc020a1a8:	00475703          	lhu	a4,4(a4)
ffffffffc020a1ac:	0cf71363          	bne	a4,a5,ffffffffc020a272 <sfs_namefile+0x1cc>
ffffffffc020a1b0:	020c8a13          	addi	s4,s9,32
ffffffffc020a1b4:	8552                	mv	a0,s4
ffffffffc020a1b6:	a3cfa0ef          	jal	ra,ffffffffc02043f2 <down>
ffffffffc020a1ba:	000cb703          	ld	a4,0(s9)
ffffffffc020a1be:	00872983          	lw	s3,8(a4)
ffffffffc020a1c2:	01304963          	bgtz	s3,ffffffffc020a1d4 <sfs_namefile+0x12e>
ffffffffc020a1c6:	a899                	j	ffffffffc020a21c <sfs_namefile+0x176>
ffffffffc020a1c8:	4018                	lw	a4,0(s0)
ffffffffc020a1ca:	01270e63          	beq	a4,s2,ffffffffc020a1e6 <sfs_namefile+0x140>
ffffffffc020a1ce:	2d85                	addiw	s11,s11,1
ffffffffc020a1d0:	05b98663          	beq	s3,s11,ffffffffc020a21c <sfs_namefile+0x176>
ffffffffc020a1d4:	86a2                	mv	a3,s0
ffffffffc020a1d6:	866e                	mv	a2,s11
ffffffffc020a1d8:	85e6                	mv	a1,s9
ffffffffc020a1da:	8526                	mv	a0,s1
ffffffffc020a1dc:	e48ff0ef          	jal	ra,ffffffffc0209824 <sfs_dirent_read_nolock>
ffffffffc020a1e0:	872a                	mv	a4,a0
ffffffffc020a1e2:	d17d                	beqz	a0,ffffffffc020a1c8 <sfs_namefile+0x122>
ffffffffc020a1e4:	a82d                	j	ffffffffc020a21e <sfs_namefile+0x178>
ffffffffc020a1e6:	8552                	mv	a0,s4
ffffffffc020a1e8:	a06fa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020a1ec:	8562                	mv	a0,s8
ffffffffc020a1ee:	03f000ef          	jal	ra,ffffffffc020aa2c <strlen>
ffffffffc020a1f2:	00150793          	addi	a5,a0,1
ffffffffc020a1f6:	862a                	mv	a2,a0
ffffffffc020a1f8:	06fbe863          	bltu	s7,a5,ffffffffc020a268 <sfs_namefile+0x1c2>
ffffffffc020a1fc:	fff64913          	not	s2,a2
ffffffffc020a200:	995a                	add	s2,s2,s6
ffffffffc020a202:	85e2                	mv	a1,s8
ffffffffc020a204:	854a                	mv	a0,s2
ffffffffc020a206:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020a20a:	117000ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020a20e:	02f00793          	li	a5,47
ffffffffc020a212:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020a216:	89e6                	mv	s3,s9
ffffffffc020a218:	8b4a                	mv	s6,s2
ffffffffc020a21a:	b721                	j	ffffffffc020a122 <sfs_namefile+0x7c>
ffffffffc020a21c:	5741                	li	a4,-16
ffffffffc020a21e:	8552                	mv	a0,s4
ffffffffc020a220:	e03a                	sd	a4,0(sp)
ffffffffc020a222:	9ccfa0ef          	jal	ra,ffffffffc02043ee <up>
ffffffffc020a226:	6702                	ld	a4,0(sp)
ffffffffc020a228:	89e6                	mv	s3,s9
ffffffffc020a22a:	8dba                	mv	s11,a4
ffffffffc020a22c:	bf11                	j	ffffffffc020a140 <sfs_namefile+0x9a>
ffffffffc020a22e:	854e                	mv	a0,s3
ffffffffc020a230:	f5ffc0ef          	jal	ra,ffffffffc020718e <inode_ref_dec>
ffffffffc020a234:	64a2                	ld	s1,8(sp)
ffffffffc020a236:	85da                	mv	a1,s6
ffffffffc020a238:	6c98                	ld	a4,24(s1)
ffffffffc020a23a:	6088                	ld	a0,0(s1)
ffffffffc020a23c:	1779                	addi	a4,a4,-2
ffffffffc020a23e:	41770bb3          	sub	s7,a4,s7
ffffffffc020a242:	865e                	mv	a2,s7
ffffffffc020a244:	0505                	addi	a0,a0,1
ffffffffc020a246:	09b000ef          	jal	ra,ffffffffc020aae0 <memmove>
ffffffffc020a24a:	02f00713          	li	a4,47
ffffffffc020a24e:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020a252:	955e                	add	a0,a0,s7
ffffffffc020a254:	00050023          	sb	zero,0(a0)
ffffffffc020a258:	85de                	mv	a1,s7
ffffffffc020a25a:	8526                	mv	a0,s1
ffffffffc020a25c:	88afb0ef          	jal	ra,ffffffffc02052e6 <iobuf_skip>
ffffffffc020a260:	8522                	mv	a0,s0
ffffffffc020a262:	dddf70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a266:	b5dd                	j	ffffffffc020a14c <sfs_namefile+0xa6>
ffffffffc020a268:	89e6                	mv	s3,s9
ffffffffc020a26a:	5df1                	li	s11,-4
ffffffffc020a26c:	bdd1                	j	ffffffffc020a140 <sfs_namefile+0x9a>
ffffffffc020a26e:	5df1                	li	s11,-4
ffffffffc020a270:	bdf1                	j	ffffffffc020a14c <sfs_namefile+0xa6>
ffffffffc020a272:	00004697          	auipc	a3,0x4
ffffffffc020a276:	41668693          	addi	a3,a3,1046 # ffffffffc020e688 <dev_node_ops+0x888>
ffffffffc020a27a:	00001617          	auipc	a2,0x1
ffffffffc020a27e:	d3660613          	addi	a2,a2,-714 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a282:	2cf00593          	li	a1,719
ffffffffc020a286:	00004517          	auipc	a0,0x4
ffffffffc020a28a:	13a50513          	addi	a0,a0,314 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a28e:	a10f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a292:	00004697          	auipc	a3,0x4
ffffffffc020a296:	0f668693          	addi	a3,a3,246 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc020a29a:	00001617          	auipc	a2,0x1
ffffffffc020a29e:	d1660613          	addi	a2,a2,-746 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a2a2:	2ce00593          	li	a1,718
ffffffffc020a2a6:	00004517          	auipc	a0,0x4
ffffffffc020a2aa:	11a50513          	addi	a0,a0,282 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a2ae:	9f0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a2b2:	00004697          	auipc	a3,0x4
ffffffffc020a2b6:	0d668693          	addi	a3,a3,214 # ffffffffc020e388 <dev_node_ops+0x588>
ffffffffc020a2ba:	00001617          	auipc	a2,0x1
ffffffffc020a2be:	cf660613          	addi	a2,a2,-778 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a2c2:	2bb00593          	li	a1,699
ffffffffc020a2c6:	00004517          	auipc	a0,0x4
ffffffffc020a2ca:	0fa50513          	addi	a0,a0,250 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a2ce:	9d0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a2d2:	00004697          	auipc	a3,0x4
ffffffffc020a2d6:	f0e68693          	addi	a3,a3,-242 # ffffffffc020e1e0 <dev_node_ops+0x3e0>
ffffffffc020a2da:	00001617          	auipc	a2,0x1
ffffffffc020a2de:	cd660613          	addi	a2,a2,-810 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a2e2:	2ba00593          	li	a1,698
ffffffffc020a2e6:	00004517          	auipc	a0,0x4
ffffffffc020a2ea:	0da50513          	addi	a0,a0,218 # ffffffffc020e3c0 <dev_node_ops+0x5c0>
ffffffffc020a2ee:	9b0f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a2f2 <sfs_rwblock_nolock>:
ffffffffc020a2f2:	7139                	addi	sp,sp,-64
ffffffffc020a2f4:	f822                	sd	s0,48(sp)
ffffffffc020a2f6:	f426                	sd	s1,40(sp)
ffffffffc020a2f8:	fc06                	sd	ra,56(sp)
ffffffffc020a2fa:	842a                	mv	s0,a0
ffffffffc020a2fc:	84b6                	mv	s1,a3
ffffffffc020a2fe:	e211                	bnez	a2,ffffffffc020a302 <sfs_rwblock_nolock+0x10>
ffffffffc020a300:	e715                	bnez	a4,ffffffffc020a32c <sfs_rwblock_nolock+0x3a>
ffffffffc020a302:	405c                	lw	a5,4(s0)
ffffffffc020a304:	02f67463          	bgeu	a2,a5,ffffffffc020a32c <sfs_rwblock_nolock+0x3a>
ffffffffc020a308:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020a30c:	1682                	slli	a3,a3,0x20
ffffffffc020a30e:	6605                	lui	a2,0x1
ffffffffc020a310:	9281                	srli	a3,a3,0x20
ffffffffc020a312:	850a                	mv	a0,sp
ffffffffc020a314:	f5dfa0ef          	jal	ra,ffffffffc0205270 <iobuf_init>
ffffffffc020a318:	85aa                	mv	a1,a0
ffffffffc020a31a:	7808                	ld	a0,48(s0)
ffffffffc020a31c:	8626                	mv	a2,s1
ffffffffc020a31e:	7118                	ld	a4,32(a0)
ffffffffc020a320:	9702                	jalr	a4
ffffffffc020a322:	70e2                	ld	ra,56(sp)
ffffffffc020a324:	7442                	ld	s0,48(sp)
ffffffffc020a326:	74a2                	ld	s1,40(sp)
ffffffffc020a328:	6121                	addi	sp,sp,64
ffffffffc020a32a:	8082                	ret
ffffffffc020a32c:	00004697          	auipc	a3,0x4
ffffffffc020a330:	49468693          	addi	a3,a3,1172 # ffffffffc020e7c0 <sfs_node_fileops+0x80>
ffffffffc020a334:	00001617          	auipc	a2,0x1
ffffffffc020a338:	c7c60613          	addi	a2,a2,-900 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a33c:	45d5                	li	a1,21
ffffffffc020a33e:	00004517          	auipc	a0,0x4
ffffffffc020a342:	4ba50513          	addi	a0,a0,1210 # ffffffffc020e7f8 <sfs_node_fileops+0xb8>
ffffffffc020a346:	958f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a34a <sfs_rbuf>:
ffffffffc020a34a:	7179                	addi	sp,sp,-48
ffffffffc020a34c:	f406                	sd	ra,40(sp)
ffffffffc020a34e:	f022                	sd	s0,32(sp)
ffffffffc020a350:	ec26                	sd	s1,24(sp)
ffffffffc020a352:	e84a                	sd	s2,16(sp)
ffffffffc020a354:	e44e                	sd	s3,8(sp)
ffffffffc020a356:	e052                	sd	s4,0(sp)
ffffffffc020a358:	6785                	lui	a5,0x1
ffffffffc020a35a:	04f77863          	bgeu	a4,a5,ffffffffc020a3aa <sfs_rbuf+0x60>
ffffffffc020a35e:	84ba                	mv	s1,a4
ffffffffc020a360:	9732                	add	a4,a4,a2
ffffffffc020a362:	89b2                	mv	s3,a2
ffffffffc020a364:	04e7e363          	bltu	a5,a4,ffffffffc020a3aa <sfs_rbuf+0x60>
ffffffffc020a368:	8936                	mv	s2,a3
ffffffffc020a36a:	842a                	mv	s0,a0
ffffffffc020a36c:	8a2e                	mv	s4,a1
ffffffffc020a36e:	214000ef          	jal	ra,ffffffffc020a582 <lock_sfs_io>
ffffffffc020a372:	642c                	ld	a1,72(s0)
ffffffffc020a374:	864a                	mv	a2,s2
ffffffffc020a376:	4705                	li	a4,1
ffffffffc020a378:	4681                	li	a3,0
ffffffffc020a37a:	8522                	mv	a0,s0
ffffffffc020a37c:	f77ff0ef          	jal	ra,ffffffffc020a2f2 <sfs_rwblock_nolock>
ffffffffc020a380:	892a                	mv	s2,a0
ffffffffc020a382:	cd09                	beqz	a0,ffffffffc020a39c <sfs_rbuf+0x52>
ffffffffc020a384:	8522                	mv	a0,s0
ffffffffc020a386:	20c000ef          	jal	ra,ffffffffc020a592 <unlock_sfs_io>
ffffffffc020a38a:	70a2                	ld	ra,40(sp)
ffffffffc020a38c:	7402                	ld	s0,32(sp)
ffffffffc020a38e:	64e2                	ld	s1,24(sp)
ffffffffc020a390:	69a2                	ld	s3,8(sp)
ffffffffc020a392:	6a02                	ld	s4,0(sp)
ffffffffc020a394:	854a                	mv	a0,s2
ffffffffc020a396:	6942                	ld	s2,16(sp)
ffffffffc020a398:	6145                	addi	sp,sp,48
ffffffffc020a39a:	8082                	ret
ffffffffc020a39c:	642c                	ld	a1,72(s0)
ffffffffc020a39e:	864e                	mv	a2,s3
ffffffffc020a3a0:	8552                	mv	a0,s4
ffffffffc020a3a2:	95a6                	add	a1,a1,s1
ffffffffc020a3a4:	77c000ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020a3a8:	bff1                	j	ffffffffc020a384 <sfs_rbuf+0x3a>
ffffffffc020a3aa:	00004697          	auipc	a3,0x4
ffffffffc020a3ae:	46668693          	addi	a3,a3,1126 # ffffffffc020e810 <sfs_node_fileops+0xd0>
ffffffffc020a3b2:	00001617          	auipc	a2,0x1
ffffffffc020a3b6:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a3ba:	05500593          	li	a1,85
ffffffffc020a3be:	00004517          	auipc	a0,0x4
ffffffffc020a3c2:	43a50513          	addi	a0,a0,1082 # ffffffffc020e7f8 <sfs_node_fileops+0xb8>
ffffffffc020a3c6:	8d8f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a3ca <sfs_wbuf>:
ffffffffc020a3ca:	7139                	addi	sp,sp,-64
ffffffffc020a3cc:	fc06                	sd	ra,56(sp)
ffffffffc020a3ce:	f822                	sd	s0,48(sp)
ffffffffc020a3d0:	f426                	sd	s1,40(sp)
ffffffffc020a3d2:	f04a                	sd	s2,32(sp)
ffffffffc020a3d4:	ec4e                	sd	s3,24(sp)
ffffffffc020a3d6:	e852                	sd	s4,16(sp)
ffffffffc020a3d8:	e456                	sd	s5,8(sp)
ffffffffc020a3da:	6785                	lui	a5,0x1
ffffffffc020a3dc:	06f77163          	bgeu	a4,a5,ffffffffc020a43e <sfs_wbuf+0x74>
ffffffffc020a3e0:	893a                	mv	s2,a4
ffffffffc020a3e2:	9732                	add	a4,a4,a2
ffffffffc020a3e4:	8a32                	mv	s4,a2
ffffffffc020a3e6:	04e7ec63          	bltu	a5,a4,ffffffffc020a43e <sfs_wbuf+0x74>
ffffffffc020a3ea:	842a                	mv	s0,a0
ffffffffc020a3ec:	89b6                	mv	s3,a3
ffffffffc020a3ee:	8aae                	mv	s5,a1
ffffffffc020a3f0:	192000ef          	jal	ra,ffffffffc020a582 <lock_sfs_io>
ffffffffc020a3f4:	642c                	ld	a1,72(s0)
ffffffffc020a3f6:	4705                	li	a4,1
ffffffffc020a3f8:	4681                	li	a3,0
ffffffffc020a3fa:	864e                	mv	a2,s3
ffffffffc020a3fc:	8522                	mv	a0,s0
ffffffffc020a3fe:	ef5ff0ef          	jal	ra,ffffffffc020a2f2 <sfs_rwblock_nolock>
ffffffffc020a402:	84aa                	mv	s1,a0
ffffffffc020a404:	cd11                	beqz	a0,ffffffffc020a420 <sfs_wbuf+0x56>
ffffffffc020a406:	8522                	mv	a0,s0
ffffffffc020a408:	18a000ef          	jal	ra,ffffffffc020a592 <unlock_sfs_io>
ffffffffc020a40c:	70e2                	ld	ra,56(sp)
ffffffffc020a40e:	7442                	ld	s0,48(sp)
ffffffffc020a410:	7902                	ld	s2,32(sp)
ffffffffc020a412:	69e2                	ld	s3,24(sp)
ffffffffc020a414:	6a42                	ld	s4,16(sp)
ffffffffc020a416:	6aa2                	ld	s5,8(sp)
ffffffffc020a418:	8526                	mv	a0,s1
ffffffffc020a41a:	74a2                	ld	s1,40(sp)
ffffffffc020a41c:	6121                	addi	sp,sp,64
ffffffffc020a41e:	8082                	ret
ffffffffc020a420:	6428                	ld	a0,72(s0)
ffffffffc020a422:	8652                	mv	a2,s4
ffffffffc020a424:	85d6                	mv	a1,s5
ffffffffc020a426:	954a                	add	a0,a0,s2
ffffffffc020a428:	6f8000ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020a42c:	642c                	ld	a1,72(s0)
ffffffffc020a42e:	4705                	li	a4,1
ffffffffc020a430:	4685                	li	a3,1
ffffffffc020a432:	864e                	mv	a2,s3
ffffffffc020a434:	8522                	mv	a0,s0
ffffffffc020a436:	ebdff0ef          	jal	ra,ffffffffc020a2f2 <sfs_rwblock_nolock>
ffffffffc020a43a:	84aa                	mv	s1,a0
ffffffffc020a43c:	b7e9                	j	ffffffffc020a406 <sfs_wbuf+0x3c>
ffffffffc020a43e:	00004697          	auipc	a3,0x4
ffffffffc020a442:	3d268693          	addi	a3,a3,978 # ffffffffc020e810 <sfs_node_fileops+0xd0>
ffffffffc020a446:	00001617          	auipc	a2,0x1
ffffffffc020a44a:	b6a60613          	addi	a2,a2,-1174 # ffffffffc020afb0 <commands+0x210>
ffffffffc020a44e:	06b00593          	li	a1,107
ffffffffc020a452:	00004517          	auipc	a0,0x4
ffffffffc020a456:	3a650513          	addi	a0,a0,934 # ffffffffc020e7f8 <sfs_node_fileops+0xb8>
ffffffffc020a45a:	844f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a45e <sfs_sync_super>:
ffffffffc020a45e:	1101                	addi	sp,sp,-32
ffffffffc020a460:	ec06                	sd	ra,24(sp)
ffffffffc020a462:	e822                	sd	s0,16(sp)
ffffffffc020a464:	e426                	sd	s1,8(sp)
ffffffffc020a466:	842a                	mv	s0,a0
ffffffffc020a468:	11a000ef          	jal	ra,ffffffffc020a582 <lock_sfs_io>
ffffffffc020a46c:	6428                	ld	a0,72(s0)
ffffffffc020a46e:	6605                	lui	a2,0x1
ffffffffc020a470:	4581                	li	a1,0
ffffffffc020a472:	65c000ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc020a476:	6428                	ld	a0,72(s0)
ffffffffc020a478:	85a2                	mv	a1,s0
ffffffffc020a47a:	02c00613          	li	a2,44
ffffffffc020a47e:	6a2000ef          	jal	ra,ffffffffc020ab20 <memcpy>
ffffffffc020a482:	642c                	ld	a1,72(s0)
ffffffffc020a484:	4701                	li	a4,0
ffffffffc020a486:	4685                	li	a3,1
ffffffffc020a488:	4601                	li	a2,0
ffffffffc020a48a:	8522                	mv	a0,s0
ffffffffc020a48c:	e67ff0ef          	jal	ra,ffffffffc020a2f2 <sfs_rwblock_nolock>
ffffffffc020a490:	84aa                	mv	s1,a0
ffffffffc020a492:	8522                	mv	a0,s0
ffffffffc020a494:	0fe000ef          	jal	ra,ffffffffc020a592 <unlock_sfs_io>
ffffffffc020a498:	60e2                	ld	ra,24(sp)
ffffffffc020a49a:	6442                	ld	s0,16(sp)
ffffffffc020a49c:	8526                	mv	a0,s1
ffffffffc020a49e:	64a2                	ld	s1,8(sp)
ffffffffc020a4a0:	6105                	addi	sp,sp,32
ffffffffc020a4a2:	8082                	ret

ffffffffc020a4a4 <sfs_sync_freemap>:
ffffffffc020a4a4:	7139                	addi	sp,sp,-64
ffffffffc020a4a6:	ec4e                	sd	s3,24(sp)
ffffffffc020a4a8:	e852                	sd	s4,16(sp)
ffffffffc020a4aa:	00456983          	lwu	s3,4(a0)
ffffffffc020a4ae:	8a2a                	mv	s4,a0
ffffffffc020a4b0:	7d08                	ld	a0,56(a0)
ffffffffc020a4b2:	67a1                	lui	a5,0x8
ffffffffc020a4b4:	17fd                	addi	a5,a5,-1
ffffffffc020a4b6:	4581                	li	a1,0
ffffffffc020a4b8:	f822                	sd	s0,48(sp)
ffffffffc020a4ba:	fc06                	sd	ra,56(sp)
ffffffffc020a4bc:	f426                	sd	s1,40(sp)
ffffffffc020a4be:	f04a                	sd	s2,32(sp)
ffffffffc020a4c0:	e456                	sd	s5,8(sp)
ffffffffc020a4c2:	99be                	add	s3,s3,a5
ffffffffc020a4c4:	c58fe0ef          	jal	ra,ffffffffc020891c <bitmap_getdata>
ffffffffc020a4c8:	00f9d993          	srli	s3,s3,0xf
ffffffffc020a4cc:	842a                	mv	s0,a0
ffffffffc020a4ce:	8552                	mv	a0,s4
ffffffffc020a4d0:	0b2000ef          	jal	ra,ffffffffc020a582 <lock_sfs_io>
ffffffffc020a4d4:	04098163          	beqz	s3,ffffffffc020a516 <sfs_sync_freemap+0x72>
ffffffffc020a4d8:	09b2                	slli	s3,s3,0xc
ffffffffc020a4da:	99a2                	add	s3,s3,s0
ffffffffc020a4dc:	4909                	li	s2,2
ffffffffc020a4de:	6a85                	lui	s5,0x1
ffffffffc020a4e0:	a021                	j	ffffffffc020a4e8 <sfs_sync_freemap+0x44>
ffffffffc020a4e2:	2905                	addiw	s2,s2,1
ffffffffc020a4e4:	02898963          	beq	s3,s0,ffffffffc020a516 <sfs_sync_freemap+0x72>
ffffffffc020a4e8:	85a2                	mv	a1,s0
ffffffffc020a4ea:	864a                	mv	a2,s2
ffffffffc020a4ec:	4705                	li	a4,1
ffffffffc020a4ee:	4685                	li	a3,1
ffffffffc020a4f0:	8552                	mv	a0,s4
ffffffffc020a4f2:	e01ff0ef          	jal	ra,ffffffffc020a2f2 <sfs_rwblock_nolock>
ffffffffc020a4f6:	84aa                	mv	s1,a0
ffffffffc020a4f8:	9456                	add	s0,s0,s5
ffffffffc020a4fa:	d565                	beqz	a0,ffffffffc020a4e2 <sfs_sync_freemap+0x3e>
ffffffffc020a4fc:	8552                	mv	a0,s4
ffffffffc020a4fe:	094000ef          	jal	ra,ffffffffc020a592 <unlock_sfs_io>
ffffffffc020a502:	70e2                	ld	ra,56(sp)
ffffffffc020a504:	7442                	ld	s0,48(sp)
ffffffffc020a506:	7902                	ld	s2,32(sp)
ffffffffc020a508:	69e2                	ld	s3,24(sp)
ffffffffc020a50a:	6a42                	ld	s4,16(sp)
ffffffffc020a50c:	6aa2                	ld	s5,8(sp)
ffffffffc020a50e:	8526                	mv	a0,s1
ffffffffc020a510:	74a2                	ld	s1,40(sp)
ffffffffc020a512:	6121                	addi	sp,sp,64
ffffffffc020a514:	8082                	ret
ffffffffc020a516:	4481                	li	s1,0
ffffffffc020a518:	b7d5                	j	ffffffffc020a4fc <sfs_sync_freemap+0x58>

ffffffffc020a51a <sfs_clear_block>:
ffffffffc020a51a:	7179                	addi	sp,sp,-48
ffffffffc020a51c:	f022                	sd	s0,32(sp)
ffffffffc020a51e:	e84a                	sd	s2,16(sp)
ffffffffc020a520:	e44e                	sd	s3,8(sp)
ffffffffc020a522:	f406                	sd	ra,40(sp)
ffffffffc020a524:	89b2                	mv	s3,a2
ffffffffc020a526:	ec26                	sd	s1,24(sp)
ffffffffc020a528:	892a                	mv	s2,a0
ffffffffc020a52a:	842e                	mv	s0,a1
ffffffffc020a52c:	056000ef          	jal	ra,ffffffffc020a582 <lock_sfs_io>
ffffffffc020a530:	04893503          	ld	a0,72(s2)
ffffffffc020a534:	6605                	lui	a2,0x1
ffffffffc020a536:	4581                	li	a1,0
ffffffffc020a538:	596000ef          	jal	ra,ffffffffc020aace <memset>
ffffffffc020a53c:	02098d63          	beqz	s3,ffffffffc020a576 <sfs_clear_block+0x5c>
ffffffffc020a540:	013409bb          	addw	s3,s0,s3
ffffffffc020a544:	a019                	j	ffffffffc020a54a <sfs_clear_block+0x30>
ffffffffc020a546:	02898863          	beq	s3,s0,ffffffffc020a576 <sfs_clear_block+0x5c>
ffffffffc020a54a:	04893583          	ld	a1,72(s2)
ffffffffc020a54e:	8622                	mv	a2,s0
ffffffffc020a550:	4705                	li	a4,1
ffffffffc020a552:	4685                	li	a3,1
ffffffffc020a554:	854a                	mv	a0,s2
ffffffffc020a556:	d9dff0ef          	jal	ra,ffffffffc020a2f2 <sfs_rwblock_nolock>
ffffffffc020a55a:	84aa                	mv	s1,a0
ffffffffc020a55c:	2405                	addiw	s0,s0,1
ffffffffc020a55e:	d565                	beqz	a0,ffffffffc020a546 <sfs_clear_block+0x2c>
ffffffffc020a560:	854a                	mv	a0,s2
ffffffffc020a562:	030000ef          	jal	ra,ffffffffc020a592 <unlock_sfs_io>
ffffffffc020a566:	70a2                	ld	ra,40(sp)
ffffffffc020a568:	7402                	ld	s0,32(sp)
ffffffffc020a56a:	6942                	ld	s2,16(sp)
ffffffffc020a56c:	69a2                	ld	s3,8(sp)
ffffffffc020a56e:	8526                	mv	a0,s1
ffffffffc020a570:	64e2                	ld	s1,24(sp)
ffffffffc020a572:	6145                	addi	sp,sp,48
ffffffffc020a574:	8082                	ret
ffffffffc020a576:	4481                	li	s1,0
ffffffffc020a578:	b7e5                	j	ffffffffc020a560 <sfs_clear_block+0x46>

ffffffffc020a57a <lock_sfs_fs>:
ffffffffc020a57a:	05050513          	addi	a0,a0,80
ffffffffc020a57e:	e75f906f          	j	ffffffffc02043f2 <down>

ffffffffc020a582 <lock_sfs_io>:
ffffffffc020a582:	06850513          	addi	a0,a0,104
ffffffffc020a586:	e6df906f          	j	ffffffffc02043f2 <down>

ffffffffc020a58a <unlock_sfs_fs>:
ffffffffc020a58a:	05050513          	addi	a0,a0,80
ffffffffc020a58e:	e61f906f          	j	ffffffffc02043ee <up>

ffffffffc020a592 <unlock_sfs_io>:
ffffffffc020a592:	06850513          	addi	a0,a0,104
ffffffffc020a596:	e59f906f          	j	ffffffffc02043ee <up>

ffffffffc020a59a <hash32>:
ffffffffc020a59a:	9e3707b7          	lui	a5,0x9e370
ffffffffc020a59e:	2785                	addiw	a5,a5,1
ffffffffc020a5a0:	02a7853b          	mulw	a0,a5,a0
ffffffffc020a5a4:	02000793          	li	a5,32
ffffffffc020a5a8:	9f8d                	subw	a5,a5,a1
ffffffffc020a5aa:	00f5553b          	srlw	a0,a0,a5
ffffffffc020a5ae:	8082                	ret

ffffffffc020a5b0 <printnum>:
ffffffffc020a5b0:	02071893          	slli	a7,a4,0x20
ffffffffc020a5b4:	7139                	addi	sp,sp,-64
ffffffffc020a5b6:	0208d893          	srli	a7,a7,0x20
ffffffffc020a5ba:	e456                	sd	s5,8(sp)
ffffffffc020a5bc:	0316fab3          	remu	s5,a3,a7
ffffffffc020a5c0:	f822                	sd	s0,48(sp)
ffffffffc020a5c2:	f426                	sd	s1,40(sp)
ffffffffc020a5c4:	f04a                	sd	s2,32(sp)
ffffffffc020a5c6:	ec4e                	sd	s3,24(sp)
ffffffffc020a5c8:	fc06                	sd	ra,56(sp)
ffffffffc020a5ca:	e852                	sd	s4,16(sp)
ffffffffc020a5cc:	84aa                	mv	s1,a0
ffffffffc020a5ce:	89ae                	mv	s3,a1
ffffffffc020a5d0:	8932                	mv	s2,a2
ffffffffc020a5d2:	fff7841b          	addiw	s0,a5,-1
ffffffffc020a5d6:	2a81                	sext.w	s5,s5
ffffffffc020a5d8:	0516f163          	bgeu	a3,a7,ffffffffc020a61a <printnum+0x6a>
ffffffffc020a5dc:	8a42                	mv	s4,a6
ffffffffc020a5de:	00805863          	blez	s0,ffffffffc020a5ee <printnum+0x3e>
ffffffffc020a5e2:	347d                	addiw	s0,s0,-1
ffffffffc020a5e4:	864e                	mv	a2,s3
ffffffffc020a5e6:	85ca                	mv	a1,s2
ffffffffc020a5e8:	8552                	mv	a0,s4
ffffffffc020a5ea:	9482                	jalr	s1
ffffffffc020a5ec:	f87d                	bnez	s0,ffffffffc020a5e2 <printnum+0x32>
ffffffffc020a5ee:	1a82                	slli	s5,s5,0x20
ffffffffc020a5f0:	00004797          	auipc	a5,0x4
ffffffffc020a5f4:	26878793          	addi	a5,a5,616 # ffffffffc020e858 <sfs_node_fileops+0x118>
ffffffffc020a5f8:	020ada93          	srli	s5,s5,0x20
ffffffffc020a5fc:	9abe                	add	s5,s5,a5
ffffffffc020a5fe:	7442                	ld	s0,48(sp)
ffffffffc020a600:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020a604:	70e2                	ld	ra,56(sp)
ffffffffc020a606:	6a42                	ld	s4,16(sp)
ffffffffc020a608:	6aa2                	ld	s5,8(sp)
ffffffffc020a60a:	864e                	mv	a2,s3
ffffffffc020a60c:	85ca                	mv	a1,s2
ffffffffc020a60e:	69e2                	ld	s3,24(sp)
ffffffffc020a610:	7902                	ld	s2,32(sp)
ffffffffc020a612:	87a6                	mv	a5,s1
ffffffffc020a614:	74a2                	ld	s1,40(sp)
ffffffffc020a616:	6121                	addi	sp,sp,64
ffffffffc020a618:	8782                	jr	a5
ffffffffc020a61a:	0316d6b3          	divu	a3,a3,a7
ffffffffc020a61e:	87a2                	mv	a5,s0
ffffffffc020a620:	f91ff0ef          	jal	ra,ffffffffc020a5b0 <printnum>
ffffffffc020a624:	b7e9                	j	ffffffffc020a5ee <printnum+0x3e>

ffffffffc020a626 <sprintputch>:
ffffffffc020a626:	499c                	lw	a5,16(a1)
ffffffffc020a628:	6198                	ld	a4,0(a1)
ffffffffc020a62a:	6594                	ld	a3,8(a1)
ffffffffc020a62c:	2785                	addiw	a5,a5,1
ffffffffc020a62e:	c99c                	sw	a5,16(a1)
ffffffffc020a630:	00d77763          	bgeu	a4,a3,ffffffffc020a63e <sprintputch+0x18>
ffffffffc020a634:	00170793          	addi	a5,a4,1
ffffffffc020a638:	e19c                	sd	a5,0(a1)
ffffffffc020a63a:	00a70023          	sb	a0,0(a4)
ffffffffc020a63e:	8082                	ret

ffffffffc020a640 <vprintfmt>:
ffffffffc020a640:	7119                	addi	sp,sp,-128
ffffffffc020a642:	f4a6                	sd	s1,104(sp)
ffffffffc020a644:	f0ca                	sd	s2,96(sp)
ffffffffc020a646:	ecce                	sd	s3,88(sp)
ffffffffc020a648:	e8d2                	sd	s4,80(sp)
ffffffffc020a64a:	e4d6                	sd	s5,72(sp)
ffffffffc020a64c:	e0da                	sd	s6,64(sp)
ffffffffc020a64e:	fc5e                	sd	s7,56(sp)
ffffffffc020a650:	ec6e                	sd	s11,24(sp)
ffffffffc020a652:	fc86                	sd	ra,120(sp)
ffffffffc020a654:	f8a2                	sd	s0,112(sp)
ffffffffc020a656:	f862                	sd	s8,48(sp)
ffffffffc020a658:	f466                	sd	s9,40(sp)
ffffffffc020a65a:	f06a                	sd	s10,32(sp)
ffffffffc020a65c:	89aa                	mv	s3,a0
ffffffffc020a65e:	892e                	mv	s2,a1
ffffffffc020a660:	84b2                	mv	s1,a2
ffffffffc020a662:	8db6                	mv	s11,a3
ffffffffc020a664:	8aba                	mv	s5,a4
ffffffffc020a666:	02500a13          	li	s4,37
ffffffffc020a66a:	5bfd                	li	s7,-1
ffffffffc020a66c:	00004b17          	auipc	s6,0x4
ffffffffc020a670:	218b0b13          	addi	s6,s6,536 # ffffffffc020e884 <sfs_node_fileops+0x144>
ffffffffc020a674:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020a678:	001d8413          	addi	s0,s11,1
ffffffffc020a67c:	01450b63          	beq	a0,s4,ffffffffc020a692 <vprintfmt+0x52>
ffffffffc020a680:	c129                	beqz	a0,ffffffffc020a6c2 <vprintfmt+0x82>
ffffffffc020a682:	864a                	mv	a2,s2
ffffffffc020a684:	85a6                	mv	a1,s1
ffffffffc020a686:	0405                	addi	s0,s0,1
ffffffffc020a688:	9982                	jalr	s3
ffffffffc020a68a:	fff44503          	lbu	a0,-1(s0)
ffffffffc020a68e:	ff4519e3          	bne	a0,s4,ffffffffc020a680 <vprintfmt+0x40>
ffffffffc020a692:	00044583          	lbu	a1,0(s0)
ffffffffc020a696:	02000813          	li	a6,32
ffffffffc020a69a:	4d01                	li	s10,0
ffffffffc020a69c:	4301                	li	t1,0
ffffffffc020a69e:	5cfd                	li	s9,-1
ffffffffc020a6a0:	5c7d                	li	s8,-1
ffffffffc020a6a2:	05500513          	li	a0,85
ffffffffc020a6a6:	48a5                	li	a7,9
ffffffffc020a6a8:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020a6ac:	0ff67613          	zext.b	a2,a2
ffffffffc020a6b0:	00140d93          	addi	s11,s0,1
ffffffffc020a6b4:	04c56263          	bltu	a0,a2,ffffffffc020a6f8 <vprintfmt+0xb8>
ffffffffc020a6b8:	060a                	slli	a2,a2,0x2
ffffffffc020a6ba:	965a                	add	a2,a2,s6
ffffffffc020a6bc:	4214                	lw	a3,0(a2)
ffffffffc020a6be:	96da                	add	a3,a3,s6
ffffffffc020a6c0:	8682                	jr	a3
ffffffffc020a6c2:	70e6                	ld	ra,120(sp)
ffffffffc020a6c4:	7446                	ld	s0,112(sp)
ffffffffc020a6c6:	74a6                	ld	s1,104(sp)
ffffffffc020a6c8:	7906                	ld	s2,96(sp)
ffffffffc020a6ca:	69e6                	ld	s3,88(sp)
ffffffffc020a6cc:	6a46                	ld	s4,80(sp)
ffffffffc020a6ce:	6aa6                	ld	s5,72(sp)
ffffffffc020a6d0:	6b06                	ld	s6,64(sp)
ffffffffc020a6d2:	7be2                	ld	s7,56(sp)
ffffffffc020a6d4:	7c42                	ld	s8,48(sp)
ffffffffc020a6d6:	7ca2                	ld	s9,40(sp)
ffffffffc020a6d8:	7d02                	ld	s10,32(sp)
ffffffffc020a6da:	6de2                	ld	s11,24(sp)
ffffffffc020a6dc:	6109                	addi	sp,sp,128
ffffffffc020a6de:	8082                	ret
ffffffffc020a6e0:	882e                	mv	a6,a1
ffffffffc020a6e2:	00144583          	lbu	a1,1(s0)
ffffffffc020a6e6:	846e                	mv	s0,s11
ffffffffc020a6e8:	00140d93          	addi	s11,s0,1
ffffffffc020a6ec:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020a6f0:	0ff67613          	zext.b	a2,a2
ffffffffc020a6f4:	fcc572e3          	bgeu	a0,a2,ffffffffc020a6b8 <vprintfmt+0x78>
ffffffffc020a6f8:	864a                	mv	a2,s2
ffffffffc020a6fa:	85a6                	mv	a1,s1
ffffffffc020a6fc:	02500513          	li	a0,37
ffffffffc020a700:	9982                	jalr	s3
ffffffffc020a702:	fff44783          	lbu	a5,-1(s0)
ffffffffc020a706:	8da2                	mv	s11,s0
ffffffffc020a708:	f74786e3          	beq	a5,s4,ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a70c:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020a710:	1dfd                	addi	s11,s11,-1
ffffffffc020a712:	ff479de3          	bne	a5,s4,ffffffffc020a70c <vprintfmt+0xcc>
ffffffffc020a716:	bfb9                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a718:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020a71c:	00144583          	lbu	a1,1(s0)
ffffffffc020a720:	846e                	mv	s0,s11
ffffffffc020a722:	fd05869b          	addiw	a3,a1,-48
ffffffffc020a726:	0005861b          	sext.w	a2,a1
ffffffffc020a72a:	02d8e463          	bltu	a7,a3,ffffffffc020a752 <vprintfmt+0x112>
ffffffffc020a72e:	00144583          	lbu	a1,1(s0)
ffffffffc020a732:	002c969b          	slliw	a3,s9,0x2
ffffffffc020a736:	0196873b          	addw	a4,a3,s9
ffffffffc020a73a:	0017171b          	slliw	a4,a4,0x1
ffffffffc020a73e:	9f31                	addw	a4,a4,a2
ffffffffc020a740:	fd05869b          	addiw	a3,a1,-48
ffffffffc020a744:	0405                	addi	s0,s0,1
ffffffffc020a746:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020a74a:	0005861b          	sext.w	a2,a1
ffffffffc020a74e:	fed8f0e3          	bgeu	a7,a3,ffffffffc020a72e <vprintfmt+0xee>
ffffffffc020a752:	f40c5be3          	bgez	s8,ffffffffc020a6a8 <vprintfmt+0x68>
ffffffffc020a756:	8c66                	mv	s8,s9
ffffffffc020a758:	5cfd                	li	s9,-1
ffffffffc020a75a:	b7b9                	j	ffffffffc020a6a8 <vprintfmt+0x68>
ffffffffc020a75c:	fffc4693          	not	a3,s8
ffffffffc020a760:	96fd                	srai	a3,a3,0x3f
ffffffffc020a762:	00dc77b3          	and	a5,s8,a3
ffffffffc020a766:	00144583          	lbu	a1,1(s0)
ffffffffc020a76a:	00078c1b          	sext.w	s8,a5
ffffffffc020a76e:	846e                	mv	s0,s11
ffffffffc020a770:	bf25                	j	ffffffffc020a6a8 <vprintfmt+0x68>
ffffffffc020a772:	000aac83          	lw	s9,0(s5)
ffffffffc020a776:	00144583          	lbu	a1,1(s0)
ffffffffc020a77a:	0aa1                	addi	s5,s5,8
ffffffffc020a77c:	846e                	mv	s0,s11
ffffffffc020a77e:	bfd1                	j	ffffffffc020a752 <vprintfmt+0x112>
ffffffffc020a780:	4705                	li	a4,1
ffffffffc020a782:	008a8613          	addi	a2,s5,8
ffffffffc020a786:	00674463          	blt	a4,t1,ffffffffc020a78e <vprintfmt+0x14e>
ffffffffc020a78a:	1c030c63          	beqz	t1,ffffffffc020a962 <vprintfmt+0x322>
ffffffffc020a78e:	000ab683          	ld	a3,0(s5)
ffffffffc020a792:	4741                	li	a4,16
ffffffffc020a794:	8ab2                	mv	s5,a2
ffffffffc020a796:	2801                	sext.w	a6,a6
ffffffffc020a798:	87e2                	mv	a5,s8
ffffffffc020a79a:	8626                	mv	a2,s1
ffffffffc020a79c:	85ca                	mv	a1,s2
ffffffffc020a79e:	854e                	mv	a0,s3
ffffffffc020a7a0:	e11ff0ef          	jal	ra,ffffffffc020a5b0 <printnum>
ffffffffc020a7a4:	bdc1                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a7a6:	000aa503          	lw	a0,0(s5)
ffffffffc020a7aa:	864a                	mv	a2,s2
ffffffffc020a7ac:	85a6                	mv	a1,s1
ffffffffc020a7ae:	0aa1                	addi	s5,s5,8
ffffffffc020a7b0:	9982                	jalr	s3
ffffffffc020a7b2:	b5c9                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a7b4:	4705                	li	a4,1
ffffffffc020a7b6:	008a8613          	addi	a2,s5,8
ffffffffc020a7ba:	00674463          	blt	a4,t1,ffffffffc020a7c2 <vprintfmt+0x182>
ffffffffc020a7be:	18030d63          	beqz	t1,ffffffffc020a958 <vprintfmt+0x318>
ffffffffc020a7c2:	000ab683          	ld	a3,0(s5)
ffffffffc020a7c6:	4729                	li	a4,10
ffffffffc020a7c8:	8ab2                	mv	s5,a2
ffffffffc020a7ca:	b7f1                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a7cc:	00144583          	lbu	a1,1(s0)
ffffffffc020a7d0:	4d05                	li	s10,1
ffffffffc020a7d2:	846e                	mv	s0,s11
ffffffffc020a7d4:	bdd1                	j	ffffffffc020a6a8 <vprintfmt+0x68>
ffffffffc020a7d6:	864a                	mv	a2,s2
ffffffffc020a7d8:	85a6                	mv	a1,s1
ffffffffc020a7da:	02500513          	li	a0,37
ffffffffc020a7de:	9982                	jalr	s3
ffffffffc020a7e0:	bd51                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a7e2:	00144583          	lbu	a1,1(s0)
ffffffffc020a7e6:	2305                	addiw	t1,t1,1
ffffffffc020a7e8:	846e                	mv	s0,s11
ffffffffc020a7ea:	bd7d                	j	ffffffffc020a6a8 <vprintfmt+0x68>
ffffffffc020a7ec:	4705                	li	a4,1
ffffffffc020a7ee:	008a8613          	addi	a2,s5,8
ffffffffc020a7f2:	00674463          	blt	a4,t1,ffffffffc020a7fa <vprintfmt+0x1ba>
ffffffffc020a7f6:	14030c63          	beqz	t1,ffffffffc020a94e <vprintfmt+0x30e>
ffffffffc020a7fa:	000ab683          	ld	a3,0(s5)
ffffffffc020a7fe:	4721                	li	a4,8
ffffffffc020a800:	8ab2                	mv	s5,a2
ffffffffc020a802:	bf51                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a804:	03000513          	li	a0,48
ffffffffc020a808:	864a                	mv	a2,s2
ffffffffc020a80a:	85a6                	mv	a1,s1
ffffffffc020a80c:	e042                	sd	a6,0(sp)
ffffffffc020a80e:	9982                	jalr	s3
ffffffffc020a810:	864a                	mv	a2,s2
ffffffffc020a812:	85a6                	mv	a1,s1
ffffffffc020a814:	07800513          	li	a0,120
ffffffffc020a818:	9982                	jalr	s3
ffffffffc020a81a:	0aa1                	addi	s5,s5,8
ffffffffc020a81c:	6802                	ld	a6,0(sp)
ffffffffc020a81e:	4741                	li	a4,16
ffffffffc020a820:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020a824:	bf8d                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a826:	000ab403          	ld	s0,0(s5)
ffffffffc020a82a:	008a8793          	addi	a5,s5,8
ffffffffc020a82e:	e03e                	sd	a5,0(sp)
ffffffffc020a830:	14040c63          	beqz	s0,ffffffffc020a988 <vprintfmt+0x348>
ffffffffc020a834:	11805063          	blez	s8,ffffffffc020a934 <vprintfmt+0x2f4>
ffffffffc020a838:	02d00693          	li	a3,45
ffffffffc020a83c:	0cd81963          	bne	a6,a3,ffffffffc020a90e <vprintfmt+0x2ce>
ffffffffc020a840:	00044683          	lbu	a3,0(s0)
ffffffffc020a844:	0006851b          	sext.w	a0,a3
ffffffffc020a848:	ce8d                	beqz	a3,ffffffffc020a882 <vprintfmt+0x242>
ffffffffc020a84a:	00140a93          	addi	s5,s0,1
ffffffffc020a84e:	05e00413          	li	s0,94
ffffffffc020a852:	000cc563          	bltz	s9,ffffffffc020a85c <vprintfmt+0x21c>
ffffffffc020a856:	3cfd                	addiw	s9,s9,-1
ffffffffc020a858:	037c8363          	beq	s9,s7,ffffffffc020a87e <vprintfmt+0x23e>
ffffffffc020a85c:	864a                	mv	a2,s2
ffffffffc020a85e:	85a6                	mv	a1,s1
ffffffffc020a860:	100d0663          	beqz	s10,ffffffffc020a96c <vprintfmt+0x32c>
ffffffffc020a864:	3681                	addiw	a3,a3,-32
ffffffffc020a866:	10d47363          	bgeu	s0,a3,ffffffffc020a96c <vprintfmt+0x32c>
ffffffffc020a86a:	03f00513          	li	a0,63
ffffffffc020a86e:	9982                	jalr	s3
ffffffffc020a870:	000ac683          	lbu	a3,0(s5)
ffffffffc020a874:	3c7d                	addiw	s8,s8,-1
ffffffffc020a876:	0a85                	addi	s5,s5,1
ffffffffc020a878:	0006851b          	sext.w	a0,a3
ffffffffc020a87c:	faf9                	bnez	a3,ffffffffc020a852 <vprintfmt+0x212>
ffffffffc020a87e:	01805a63          	blez	s8,ffffffffc020a892 <vprintfmt+0x252>
ffffffffc020a882:	3c7d                	addiw	s8,s8,-1
ffffffffc020a884:	864a                	mv	a2,s2
ffffffffc020a886:	85a6                	mv	a1,s1
ffffffffc020a888:	02000513          	li	a0,32
ffffffffc020a88c:	9982                	jalr	s3
ffffffffc020a88e:	fe0c1ae3          	bnez	s8,ffffffffc020a882 <vprintfmt+0x242>
ffffffffc020a892:	6a82                	ld	s5,0(sp)
ffffffffc020a894:	b3c5                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a896:	4705                	li	a4,1
ffffffffc020a898:	008a8d13          	addi	s10,s5,8
ffffffffc020a89c:	00674463          	blt	a4,t1,ffffffffc020a8a4 <vprintfmt+0x264>
ffffffffc020a8a0:	0a030463          	beqz	t1,ffffffffc020a948 <vprintfmt+0x308>
ffffffffc020a8a4:	000ab403          	ld	s0,0(s5)
ffffffffc020a8a8:	0c044463          	bltz	s0,ffffffffc020a970 <vprintfmt+0x330>
ffffffffc020a8ac:	86a2                	mv	a3,s0
ffffffffc020a8ae:	8aea                	mv	s5,s10
ffffffffc020a8b0:	4729                	li	a4,10
ffffffffc020a8b2:	b5d5                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a8b4:	000aa783          	lw	a5,0(s5)
ffffffffc020a8b8:	46e1                	li	a3,24
ffffffffc020a8ba:	0aa1                	addi	s5,s5,8
ffffffffc020a8bc:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020a8c0:	8fb9                	xor	a5,a5,a4
ffffffffc020a8c2:	40e7873b          	subw	a4,a5,a4
ffffffffc020a8c6:	02e6c663          	blt	a3,a4,ffffffffc020a8f2 <vprintfmt+0x2b2>
ffffffffc020a8ca:	00371793          	slli	a5,a4,0x3
ffffffffc020a8ce:	00004697          	auipc	a3,0x4
ffffffffc020a8d2:	2ea68693          	addi	a3,a3,746 # ffffffffc020ebb8 <error_string>
ffffffffc020a8d6:	97b6                	add	a5,a5,a3
ffffffffc020a8d8:	639c                	ld	a5,0(a5)
ffffffffc020a8da:	cf81                	beqz	a5,ffffffffc020a8f2 <vprintfmt+0x2b2>
ffffffffc020a8dc:	873e                	mv	a4,a5
ffffffffc020a8de:	00000697          	auipc	a3,0x0
ffffffffc020a8e2:	28268693          	addi	a3,a3,642 # ffffffffc020ab60 <etext+0x28>
ffffffffc020a8e6:	8626                	mv	a2,s1
ffffffffc020a8e8:	85ca                	mv	a1,s2
ffffffffc020a8ea:	854e                	mv	a0,s3
ffffffffc020a8ec:	0d4000ef          	jal	ra,ffffffffc020a9c0 <printfmt>
ffffffffc020a8f0:	b351                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a8f2:	00004697          	auipc	a3,0x4
ffffffffc020a8f6:	f8668693          	addi	a3,a3,-122 # ffffffffc020e878 <sfs_node_fileops+0x138>
ffffffffc020a8fa:	8626                	mv	a2,s1
ffffffffc020a8fc:	85ca                	mv	a1,s2
ffffffffc020a8fe:	854e                	mv	a0,s3
ffffffffc020a900:	0c0000ef          	jal	ra,ffffffffc020a9c0 <printfmt>
ffffffffc020a904:	bb85                	j	ffffffffc020a674 <vprintfmt+0x34>
ffffffffc020a906:	00004417          	auipc	s0,0x4
ffffffffc020a90a:	f6a40413          	addi	s0,s0,-150 # ffffffffc020e870 <sfs_node_fileops+0x130>
ffffffffc020a90e:	85e6                	mv	a1,s9
ffffffffc020a910:	8522                	mv	a0,s0
ffffffffc020a912:	e442                	sd	a6,8(sp)
ffffffffc020a914:	132000ef          	jal	ra,ffffffffc020aa46 <strnlen>
ffffffffc020a918:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020a91c:	01805c63          	blez	s8,ffffffffc020a934 <vprintfmt+0x2f4>
ffffffffc020a920:	6822                	ld	a6,8(sp)
ffffffffc020a922:	00080a9b          	sext.w	s5,a6
ffffffffc020a926:	3c7d                	addiw	s8,s8,-1
ffffffffc020a928:	864a                	mv	a2,s2
ffffffffc020a92a:	85a6                	mv	a1,s1
ffffffffc020a92c:	8556                	mv	a0,s5
ffffffffc020a92e:	9982                	jalr	s3
ffffffffc020a930:	fe0c1be3          	bnez	s8,ffffffffc020a926 <vprintfmt+0x2e6>
ffffffffc020a934:	00044683          	lbu	a3,0(s0)
ffffffffc020a938:	00140a93          	addi	s5,s0,1
ffffffffc020a93c:	0006851b          	sext.w	a0,a3
ffffffffc020a940:	daa9                	beqz	a3,ffffffffc020a892 <vprintfmt+0x252>
ffffffffc020a942:	05e00413          	li	s0,94
ffffffffc020a946:	b731                	j	ffffffffc020a852 <vprintfmt+0x212>
ffffffffc020a948:	000aa403          	lw	s0,0(s5)
ffffffffc020a94c:	bfb1                	j	ffffffffc020a8a8 <vprintfmt+0x268>
ffffffffc020a94e:	000ae683          	lwu	a3,0(s5)
ffffffffc020a952:	4721                	li	a4,8
ffffffffc020a954:	8ab2                	mv	s5,a2
ffffffffc020a956:	b581                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a958:	000ae683          	lwu	a3,0(s5)
ffffffffc020a95c:	4729                	li	a4,10
ffffffffc020a95e:	8ab2                	mv	s5,a2
ffffffffc020a960:	bd1d                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a962:	000ae683          	lwu	a3,0(s5)
ffffffffc020a966:	4741                	li	a4,16
ffffffffc020a968:	8ab2                	mv	s5,a2
ffffffffc020a96a:	b535                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a96c:	9982                	jalr	s3
ffffffffc020a96e:	b709                	j	ffffffffc020a870 <vprintfmt+0x230>
ffffffffc020a970:	864a                	mv	a2,s2
ffffffffc020a972:	85a6                	mv	a1,s1
ffffffffc020a974:	02d00513          	li	a0,45
ffffffffc020a978:	e042                	sd	a6,0(sp)
ffffffffc020a97a:	9982                	jalr	s3
ffffffffc020a97c:	6802                	ld	a6,0(sp)
ffffffffc020a97e:	8aea                	mv	s5,s10
ffffffffc020a980:	408006b3          	neg	a3,s0
ffffffffc020a984:	4729                	li	a4,10
ffffffffc020a986:	bd01                	j	ffffffffc020a796 <vprintfmt+0x156>
ffffffffc020a988:	03805163          	blez	s8,ffffffffc020a9aa <vprintfmt+0x36a>
ffffffffc020a98c:	02d00693          	li	a3,45
ffffffffc020a990:	f6d81be3          	bne	a6,a3,ffffffffc020a906 <vprintfmt+0x2c6>
ffffffffc020a994:	00004417          	auipc	s0,0x4
ffffffffc020a998:	edc40413          	addi	s0,s0,-292 # ffffffffc020e870 <sfs_node_fileops+0x130>
ffffffffc020a99c:	02800693          	li	a3,40
ffffffffc020a9a0:	02800513          	li	a0,40
ffffffffc020a9a4:	00140a93          	addi	s5,s0,1
ffffffffc020a9a8:	b55d                	j	ffffffffc020a84e <vprintfmt+0x20e>
ffffffffc020a9aa:	00004a97          	auipc	s5,0x4
ffffffffc020a9ae:	ec7a8a93          	addi	s5,s5,-313 # ffffffffc020e871 <sfs_node_fileops+0x131>
ffffffffc020a9b2:	02800513          	li	a0,40
ffffffffc020a9b6:	02800693          	li	a3,40
ffffffffc020a9ba:	05e00413          	li	s0,94
ffffffffc020a9be:	bd51                	j	ffffffffc020a852 <vprintfmt+0x212>

ffffffffc020a9c0 <printfmt>:
ffffffffc020a9c0:	7139                	addi	sp,sp,-64
ffffffffc020a9c2:	02010313          	addi	t1,sp,32
ffffffffc020a9c6:	f03a                	sd	a4,32(sp)
ffffffffc020a9c8:	871a                	mv	a4,t1
ffffffffc020a9ca:	ec06                	sd	ra,24(sp)
ffffffffc020a9cc:	f43e                	sd	a5,40(sp)
ffffffffc020a9ce:	f842                	sd	a6,48(sp)
ffffffffc020a9d0:	fc46                	sd	a7,56(sp)
ffffffffc020a9d2:	e41a                	sd	t1,8(sp)
ffffffffc020a9d4:	c6dff0ef          	jal	ra,ffffffffc020a640 <vprintfmt>
ffffffffc020a9d8:	60e2                	ld	ra,24(sp)
ffffffffc020a9da:	6121                	addi	sp,sp,64
ffffffffc020a9dc:	8082                	ret

ffffffffc020a9de <snprintf>:
ffffffffc020a9de:	711d                	addi	sp,sp,-96
ffffffffc020a9e0:	15fd                	addi	a1,a1,-1
ffffffffc020a9e2:	03810313          	addi	t1,sp,56
ffffffffc020a9e6:	95aa                	add	a1,a1,a0
ffffffffc020a9e8:	f406                	sd	ra,40(sp)
ffffffffc020a9ea:	fc36                	sd	a3,56(sp)
ffffffffc020a9ec:	e0ba                	sd	a4,64(sp)
ffffffffc020a9ee:	e4be                	sd	a5,72(sp)
ffffffffc020a9f0:	e8c2                	sd	a6,80(sp)
ffffffffc020a9f2:	ecc6                	sd	a7,88(sp)
ffffffffc020a9f4:	e01a                	sd	t1,0(sp)
ffffffffc020a9f6:	e42a                	sd	a0,8(sp)
ffffffffc020a9f8:	e82e                	sd	a1,16(sp)
ffffffffc020a9fa:	cc02                	sw	zero,24(sp)
ffffffffc020a9fc:	c515                	beqz	a0,ffffffffc020aa28 <snprintf+0x4a>
ffffffffc020a9fe:	02a5e563          	bltu	a1,a0,ffffffffc020aa28 <snprintf+0x4a>
ffffffffc020aa02:	75dd                	lui	a1,0xffff7
ffffffffc020aa04:	86b2                	mv	a3,a2
ffffffffc020aa06:	00000517          	auipc	a0,0x0
ffffffffc020aa0a:	c2050513          	addi	a0,a0,-992 # ffffffffc020a626 <sprintputch>
ffffffffc020aa0e:	871a                	mv	a4,t1
ffffffffc020aa10:	0030                	addi	a2,sp,8
ffffffffc020aa12:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd611c9>
ffffffffc020aa16:	c2bff0ef          	jal	ra,ffffffffc020a640 <vprintfmt>
ffffffffc020aa1a:	67a2                	ld	a5,8(sp)
ffffffffc020aa1c:	00078023          	sb	zero,0(a5)
ffffffffc020aa20:	4562                	lw	a0,24(sp)
ffffffffc020aa22:	70a2                	ld	ra,40(sp)
ffffffffc020aa24:	6125                	addi	sp,sp,96
ffffffffc020aa26:	8082                	ret
ffffffffc020aa28:	5575                	li	a0,-3
ffffffffc020aa2a:	bfe5                	j	ffffffffc020aa22 <snprintf+0x44>

ffffffffc020aa2c <strlen>:
ffffffffc020aa2c:	00054783          	lbu	a5,0(a0)
ffffffffc020aa30:	872a                	mv	a4,a0
ffffffffc020aa32:	4501                	li	a0,0
ffffffffc020aa34:	cb81                	beqz	a5,ffffffffc020aa44 <strlen+0x18>
ffffffffc020aa36:	0505                	addi	a0,a0,1
ffffffffc020aa38:	00a707b3          	add	a5,a4,a0
ffffffffc020aa3c:	0007c783          	lbu	a5,0(a5)
ffffffffc020aa40:	fbfd                	bnez	a5,ffffffffc020aa36 <strlen+0xa>
ffffffffc020aa42:	8082                	ret
ffffffffc020aa44:	8082                	ret

ffffffffc020aa46 <strnlen>:
ffffffffc020aa46:	4781                	li	a5,0
ffffffffc020aa48:	e589                	bnez	a1,ffffffffc020aa52 <strnlen+0xc>
ffffffffc020aa4a:	a811                	j	ffffffffc020aa5e <strnlen+0x18>
ffffffffc020aa4c:	0785                	addi	a5,a5,1
ffffffffc020aa4e:	00f58863          	beq	a1,a5,ffffffffc020aa5e <strnlen+0x18>
ffffffffc020aa52:	00f50733          	add	a4,a0,a5
ffffffffc020aa56:	00074703          	lbu	a4,0(a4)
ffffffffc020aa5a:	fb6d                	bnez	a4,ffffffffc020aa4c <strnlen+0x6>
ffffffffc020aa5c:	85be                	mv	a1,a5
ffffffffc020aa5e:	852e                	mv	a0,a1
ffffffffc020aa60:	8082                	ret

ffffffffc020aa62 <strcpy>:
ffffffffc020aa62:	87aa                	mv	a5,a0
ffffffffc020aa64:	0005c703          	lbu	a4,0(a1)
ffffffffc020aa68:	0785                	addi	a5,a5,1
ffffffffc020aa6a:	0585                	addi	a1,a1,1
ffffffffc020aa6c:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020aa70:	fb75                	bnez	a4,ffffffffc020aa64 <strcpy+0x2>
ffffffffc020aa72:	8082                	ret

ffffffffc020aa74 <strcmp>:
ffffffffc020aa74:	00054783          	lbu	a5,0(a0)
ffffffffc020aa78:	0005c703          	lbu	a4,0(a1)
ffffffffc020aa7c:	cb89                	beqz	a5,ffffffffc020aa8e <strcmp+0x1a>
ffffffffc020aa7e:	0505                	addi	a0,a0,1
ffffffffc020aa80:	0585                	addi	a1,a1,1
ffffffffc020aa82:	fee789e3          	beq	a5,a4,ffffffffc020aa74 <strcmp>
ffffffffc020aa86:	0007851b          	sext.w	a0,a5
ffffffffc020aa8a:	9d19                	subw	a0,a0,a4
ffffffffc020aa8c:	8082                	ret
ffffffffc020aa8e:	4501                	li	a0,0
ffffffffc020aa90:	bfed                	j	ffffffffc020aa8a <strcmp+0x16>

ffffffffc020aa92 <strncmp>:
ffffffffc020aa92:	c20d                	beqz	a2,ffffffffc020aab4 <strncmp+0x22>
ffffffffc020aa94:	962e                	add	a2,a2,a1
ffffffffc020aa96:	a031                	j	ffffffffc020aaa2 <strncmp+0x10>
ffffffffc020aa98:	0505                	addi	a0,a0,1
ffffffffc020aa9a:	00e79a63          	bne	a5,a4,ffffffffc020aaae <strncmp+0x1c>
ffffffffc020aa9e:	00b60b63          	beq	a2,a1,ffffffffc020aab4 <strncmp+0x22>
ffffffffc020aaa2:	00054783          	lbu	a5,0(a0)
ffffffffc020aaa6:	0585                	addi	a1,a1,1
ffffffffc020aaa8:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020aaac:	f7f5                	bnez	a5,ffffffffc020aa98 <strncmp+0x6>
ffffffffc020aaae:	40e7853b          	subw	a0,a5,a4
ffffffffc020aab2:	8082                	ret
ffffffffc020aab4:	4501                	li	a0,0
ffffffffc020aab6:	8082                	ret

ffffffffc020aab8 <strchr>:
ffffffffc020aab8:	00054783          	lbu	a5,0(a0)
ffffffffc020aabc:	c799                	beqz	a5,ffffffffc020aaca <strchr+0x12>
ffffffffc020aabe:	00f58763          	beq	a1,a5,ffffffffc020aacc <strchr+0x14>
ffffffffc020aac2:	00154783          	lbu	a5,1(a0)
ffffffffc020aac6:	0505                	addi	a0,a0,1
ffffffffc020aac8:	fbfd                	bnez	a5,ffffffffc020aabe <strchr+0x6>
ffffffffc020aaca:	4501                	li	a0,0
ffffffffc020aacc:	8082                	ret

ffffffffc020aace <memset>:
ffffffffc020aace:	ca01                	beqz	a2,ffffffffc020aade <memset+0x10>
ffffffffc020aad0:	962a                	add	a2,a2,a0
ffffffffc020aad2:	87aa                	mv	a5,a0
ffffffffc020aad4:	0785                	addi	a5,a5,1
ffffffffc020aad6:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020aada:	fec79de3          	bne	a5,a2,ffffffffc020aad4 <memset+0x6>
ffffffffc020aade:	8082                	ret

ffffffffc020aae0 <memmove>:
ffffffffc020aae0:	02a5f263          	bgeu	a1,a0,ffffffffc020ab04 <memmove+0x24>
ffffffffc020aae4:	00c587b3          	add	a5,a1,a2
ffffffffc020aae8:	00f57e63          	bgeu	a0,a5,ffffffffc020ab04 <memmove+0x24>
ffffffffc020aaec:	00c50733          	add	a4,a0,a2
ffffffffc020aaf0:	c615                	beqz	a2,ffffffffc020ab1c <memmove+0x3c>
ffffffffc020aaf2:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020aaf6:	17fd                	addi	a5,a5,-1
ffffffffc020aaf8:	177d                	addi	a4,a4,-1
ffffffffc020aafa:	00d70023          	sb	a3,0(a4)
ffffffffc020aafe:	fef59ae3          	bne	a1,a5,ffffffffc020aaf2 <memmove+0x12>
ffffffffc020ab02:	8082                	ret
ffffffffc020ab04:	00c586b3          	add	a3,a1,a2
ffffffffc020ab08:	87aa                	mv	a5,a0
ffffffffc020ab0a:	ca11                	beqz	a2,ffffffffc020ab1e <memmove+0x3e>
ffffffffc020ab0c:	0005c703          	lbu	a4,0(a1)
ffffffffc020ab10:	0585                	addi	a1,a1,1
ffffffffc020ab12:	0785                	addi	a5,a5,1
ffffffffc020ab14:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020ab18:	fed59ae3          	bne	a1,a3,ffffffffc020ab0c <memmove+0x2c>
ffffffffc020ab1c:	8082                	ret
ffffffffc020ab1e:	8082                	ret

ffffffffc020ab20 <memcpy>:
ffffffffc020ab20:	ca19                	beqz	a2,ffffffffc020ab36 <memcpy+0x16>
ffffffffc020ab22:	962e                	add	a2,a2,a1
ffffffffc020ab24:	87aa                	mv	a5,a0
ffffffffc020ab26:	0005c703          	lbu	a4,0(a1)
ffffffffc020ab2a:	0585                	addi	a1,a1,1
ffffffffc020ab2c:	0785                	addi	a5,a5,1
ffffffffc020ab2e:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020ab32:	fec59ae3          	bne	a1,a2,ffffffffc020ab26 <memcpy+0x6>
ffffffffc020ab36:	8082                	ret
