
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	4620b0ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	4c658593          	addi	a1,a1,1222 # ffffffffc020b530 <etext+0x2>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	4de50513          	addi	a0,a0,1246 # ffffffffc020b550 <etext+0x22>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	29b020ef          	jal	ra,ffffffffc0202b20 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	727030ef          	jal	ra,ffffffffc0203fb8 <vmm_init>
ffffffffc0200096:	1be070ef          	jal	ra,ffffffffc0207254 <sched_init>
ffffffffc020009a:	5c5060ef          	jal	ra,ffffffffc0206e5e <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	158050ef          	jal	ra,ffffffffc02051fa <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	77d060ef          	jal	ra,ffffffffc020702a <cpu_idle>

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
ffffffffc02000cc:	49050513          	addi	a0,a0,1168 # ffffffffc020b558 <etext+0x2a>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
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
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
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
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	69d0a0ef          	jal	ra,ffffffffc020b036 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
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
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	6610a0ef          	jal	ra,ffffffffc020b036 <vprintfmt>
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
ffffffffc0200200:	2220b0ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	5d7010ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	3000b0ef          	jal	ra,ffffffffc020b516 <memcpy>
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
ffffffffc0200232:	33250513          	addi	a0,a0,818 # ffffffffc020b560 <etext+0x32>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	33c50513          	addi	a0,a0,828 # ffffffffc020b580 <etext+0x52>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	2de58593          	addi	a1,a1,734 # ffffffffc020b52e <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	34850513          	addi	a0,a0,840 # ffffffffc020b5a0 <etext+0x72>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	35450513          	addi	a0,a0,852 # ffffffffc020b5c0 <etext+0x92>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	36050513          	addi	a0,a0,864 # ffffffffc020b5e0 <etext+0xb2>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	35250513          	addi	a0,a0,850 # ffffffffc020b600 <etext+0xd2>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	37460613          	addi	a2,a2,884 # ffffffffc020b630 <etext+0x102>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	38050513          	addi	a0,a0,896 # ffffffffc020b648 <etext+0x11a>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	38860613          	addi	a2,a2,904 # ffffffffc020b660 <etext+0x132>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	3a058593          	addi	a1,a1,928 # ffffffffc020b680 <etext+0x152>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	3a050513          	addi	a0,a0,928 # ffffffffc020b688 <etext+0x15a>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	3a260613          	addi	a2,a2,930 # ffffffffc020b698 <etext+0x16a>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	3c258593          	addi	a1,a1,962 # ffffffffc020b6c0 <etext+0x192>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	38250513          	addi	a0,a0,898 # ffffffffc020b688 <etext+0x15a>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	3be60613          	addi	a2,a2,958 # ffffffffc020b6d0 <etext+0x1a2>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	3d658593          	addi	a1,a1,982 # ffffffffc020b6f0 <etext+0x1c2>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	36650513          	addi	a0,a0,870 # ffffffffc020b688 <etext+0x15a>
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
ffffffffc0200360:	3a450513          	addi	a0,a0,932 # ffffffffc020b700 <etext+0x1d2>
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
ffffffffc0200382:	3aa50513          	addi	a0,a0,938 # ffffffffc020b728 <etext+0x1fa>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	404c0c13          	addi	s8,s8,1028 # ffffffffc020b798 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	3b490913          	addi	s2,s2,948 # ffffffffc020b750 <etext+0x222>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	3b448493          	addi	s1,s1,948 # ffffffffc020b758 <etext+0x22a>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	3b2b0b13          	addi	s6,s6,946 # ffffffffc020b760 <etext+0x232>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	2caa0a13          	addi	s4,s4,714 # ffffffffc020b680 <etext+0x152>
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
ffffffffc02003dc:	3c0d0d13          	addi	s10,s10,960 # ffffffffc020b798 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	0840b0ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	0700b0ef          	jal	ra,ffffffffc020b46a <strcmp>
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
ffffffffc0200438:	0760b0ef          	jal	ra,ffffffffc020b4ae <strchr>
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
ffffffffc0200476:	0380b0ef          	jal	ra,ffffffffc020b4ae <strchr>
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
ffffffffc0200494:	2f050513          	addi	a0,a0,752 # ffffffffc020b780 <etext+0x252>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
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
ffffffffc02004d0:	31450513          	addi	a0,a0,788 # ffffffffc020b7e0 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	5de50513          	addi	a0,a0,1502 # ffffffffc020cac0 <default_pmm_manager+0x610>
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
ffffffffc020051a:	2ea50513          	addi	a0,a0,746 # ffffffffc020b800 <commands+0x68>
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
ffffffffc020053a:	58a50513          	addi	a0,a0,1418 # ffffffffc020cac0 <default_pmm_manager+0x610>
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
ffffffffc020056c:	2b850513          	addi	a0,a0,696 # ffffffffc020b820 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
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
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
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
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
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
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
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
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	19250513          	addi	a0,a0,402 # ffffffffc020b840 <commands+0xa8>
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
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	17450513          	addi	a0,a0,372 # ffffffffc020b850 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	16e50513          	addi	a0,a0,366 # ffffffffc020b860 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	17650513          	addi	a0,a0,374 # ffffffffc020b878 <commands+0xe0>
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
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
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
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	10c90913          	addi	s2,s2,268 # ffffffffc020b8c8 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	0f648493          	addi	s1,s1,246 # ffffffffc020b8c0 <commands+0x128>
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
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	12250513          	addi	a0,a0,290 # ffffffffc020b940 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	14e50513          	addi	a0,a0,334 # ffffffffc020b978 <commands+0x1e0>
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
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	02e50513          	addi	a0,a0,46 # ffffffffc020b898 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	3ab0a0ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	4030a0ef          	jal	ra,ffffffffc020b488 <strncmp>
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
ffffffffc020091c:	34f0a0ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	fa050513          	addi	a0,a0,-96 # ffffffffc020b8d0 <commands+0x138>
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
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	ef250513          	addi	a0,a0,-270 # ffffffffc020b8f0 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	ef850513          	addi	a0,a0,-264 # ffffffffc020b908 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	f0650513          	addi	a0,a0,-250 # ffffffffc020b928 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	f4a50513          	addi	a0,a0,-182 # ffffffffc020b978 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	ed868693          	addi	a3,a3,-296 # ffffffffc020b990 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	ee860613          	addi	a2,a2,-280 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	ef650513          	addi	a0,a0,-266 # ffffffffc020b9c0 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	f0268693          	addi	a3,a3,-254 # ffffffffc020b9d8 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	eca60613          	addi	a2,a2,-310 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	ed850513          	addi	a0,a0,-296 # ffffffffc020b9c0 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
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
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
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
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
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
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	e5a68693          	addi	a3,a3,-422 # ffffffffc020b9f0 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	e0a60613          	addi	a2,a2,-502 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	e1650513          	addi	a0,a0,-490 # ffffffffc020b9c0 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	e6268693          	addi	a3,a3,-414 # ffffffffc020ba18 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	dea60613          	addi	a2,a2,-534 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	df650513          	addi	a0,a0,-522 # ffffffffc020b9c0 <commands+0x228>
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
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
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
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	dc468693          	addi	a3,a3,-572 # ffffffffc020b9f0 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	d7460613          	addi	a2,a2,-652 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	d8050513          	addi	a0,a0,-640 # ffffffffc020b9c0 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	dcc68693          	addi	a3,a3,-564 # ffffffffc020ba18 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	d5460613          	addi	a2,a2,-684 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	d6050513          	addi	a0,a0,-672 # ffffffffc020b9c0 <commands+0x228>
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
ffffffffc0200c98:	07f0a0ef          	jal	ra,ffffffffc020b516 <memcpy>
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
ffffffffc0200cc2:	0550a0ef          	jal	ra,ffffffffc020b516 <memcpy>
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
ffffffffc0200ce4:	7e00a0ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	d5e50513          	addi	a0,a0,-674 # ffffffffc020ba70 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	d9458593          	addi	a1,a1,-620 # ffffffffc020bac8 <commands+0x330>
ffffffffc0200d3c:	71c0a0ef          	jal	ra,ffffffffc020b458 <strcpy>
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
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	cdc50513          	addi	a0,a0,-804 # ffffffffc020ba58 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	d0e60613          	addi	a2,a2,-754 # ffffffffc020ba98 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	d1a50513          	addi	a0,a0,-742 # ffffffffc020bab0 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	48a78793          	addi	a5,a5,1162 # ffffffffc0201230 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	d1450513          	addi	a0,a0,-748 # ffffffffc020bad8 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	d1c50513          	addi	a0,a0,-740 # ffffffffc020baf0 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	d2650513          	addi	a0,a0,-730 # ffffffffc020bb08 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	d3050513          	addi	a0,a0,-720 # ffffffffc020bb20 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	d3a50513          	addi	a0,a0,-710 # ffffffffc020bb38 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	d4450513          	addi	a0,a0,-700 # ffffffffc020bb50 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	d4e50513          	addi	a0,a0,-690 # ffffffffc020bb68 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	d5850513          	addi	a0,a0,-680 # ffffffffc020bb80 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	d6250513          	addi	a0,a0,-670 # ffffffffc020bb98 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	d6c50513          	addi	a0,a0,-660 # ffffffffc020bbb0 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	d7650513          	addi	a0,a0,-650 # ffffffffc020bbc8 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	d8050513          	addi	a0,a0,-640 # ffffffffc020bbe0 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	d8a50513          	addi	a0,a0,-630 # ffffffffc020bbf8 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	d9450513          	addi	a0,a0,-620 # ffffffffc020bc10 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	d9e50513          	addi	a0,a0,-610 # ffffffffc020bc28 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	da850513          	addi	a0,a0,-600 # ffffffffc020bc40 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	db250513          	addi	a0,a0,-590 # ffffffffc020bc58 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	dbc50513          	addi	a0,a0,-580 # ffffffffc020bc70 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	dc650513          	addi	a0,a0,-570 # ffffffffc020bc88 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	dd050513          	addi	a0,a0,-560 # ffffffffc020bca0 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	dda50513          	addi	a0,a0,-550 # ffffffffc020bcb8 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	de450513          	addi	a0,a0,-540 # ffffffffc020bcd0 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	dee50513          	addi	a0,a0,-530 # ffffffffc020bce8 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	df850513          	addi	a0,a0,-520 # ffffffffc020bd00 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	e0250513          	addi	a0,a0,-510 # ffffffffc020bd18 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	e0c50513          	addi	a0,a0,-500 # ffffffffc020bd30 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	e1650513          	addi	a0,a0,-490 # ffffffffc020bd48 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	e2050513          	addi	a0,a0,-480 # ffffffffc020bd60 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	e2a50513          	addi	a0,a0,-470 # ffffffffc020bd78 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	e3450513          	addi	a0,a0,-460 # ffffffffc020bd90 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	e3e50513          	addi	a0,a0,-450 # ffffffffc020bda8 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	e4450513          	addi	a0,a0,-444 # ffffffffc020bdc0 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	e4650513          	addi	a0,a0,-442 # ffffffffc020bdd8 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	e4650513          	addi	a0,a0,-442 # ffffffffc020bdf0 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	e4e50513          	addi	a0,a0,-434 # ffffffffc020be08 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	e5650513          	addi	a0,a0,-426 # ffffffffc020be20 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	e5250513          	addi	a0,a0,-430 # ffffffffc020be30 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	eee70713          	addi	a4,a4,-274 # ffffffffc020bee8 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	e9c50513          	addi	a0,a0,-356 # ffffffffc020bea8 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	e7050513          	addi	a0,a0,-400 # ffffffffc020be88 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	e2450513          	addi	a0,a0,-476 # ffffffffc020be48 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	e3850513          	addi	a0,a0,-456 # ffffffffc020be68 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00096717          	auipc	a4,0x96
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0296870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	512060ef          	jal	ra,ffffffffc0207564 <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	3d70706f          	j	ffffffffc0208c34 <dev_stdin_write>
ffffffffc0201062:	0000b517          	auipc	a0,0xb
ffffffffc0201066:	e6650513          	addi	a0,a0,-410 # ffffffffc020bec8 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0ef76063          	bltu	a4,a5,ffffffffc020115e <exception_handler+0xee>
ffffffffc0201082:	0000b717          	auipc	a4,0xb
ffffffffc0201086:	04670713          	addi	a4,a4,70 # ffffffffc020c0c8 <commands+0x930>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000b517          	auipc	a0,0xb
ffffffffc0201098:	f6c50513          	addi	a0,a0,-148 # ffffffffc020c000 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	6ca0606f          	j	ffffffffc020777a <syscall>
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	f6c50513          	addi	a0,a0,-148 # ffffffffc020c020 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000b517          	auipc	a0,0xb
ffffffffc02010ca:	f7a50513          	addi	a0,a0,-134 # ffffffffc020c040 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000b517          	auipc	a0,0xb
ffffffffc02010d4:	f9050513          	addi	a0,a0,-112 # ffffffffc020c060 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000b517          	auipc	a0,0xb
ffffffffc02010de:	f9e50513          	addi	a0,a0,-98 # ffffffffc020c078 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000b517          	auipc	a0,0xb
ffffffffc02010e8:	fac50513          	addi	a0,a0,-84 # ffffffffc020c090 <commands+0x8f8>
ffffffffc02010ec:	8baff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010f0:	10043783          	ld	a5,256(s0)
ffffffffc02010f4:	1007f793          	andi	a5,a5,256
ffffffffc02010f8:	ebc1                	bnez	a5,ffffffffc0201188 <exception_handler+0x118>
ffffffffc02010fa:	00095797          	auipc	a5,0x95
ffffffffc02010fe:	7c67b783          	ld	a5,1990(a5) # ffffffffc02968c0 <current>
ffffffffc0201102:	779c                	ld	a5,40(a5)
ffffffffc0201104:	cfb5                	beqz	a5,ffffffffc0201180 <exception_handler+0x110>
ffffffffc0201106:	8522                	mv	a0,s0
ffffffffc0201108:	e83ff0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc020110c:	6402                	ld	s0,0(sp)
ffffffffc020110e:	60a2                	ld	ra,8(sp)
ffffffffc0201110:	555d                	li	a0,-9
ffffffffc0201112:	0141                	addi	sp,sp,16
ffffffffc0201114:	7330406f          	j	ffffffffc0206046 <do_exit>
ffffffffc0201118:	0000b517          	auipc	a0,0xb
ffffffffc020111c:	e0050513          	addi	a0,a0,-512 # ffffffffc020bf18 <commands+0x780>
ffffffffc0201120:	bf71                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201122:	0000b517          	auipc	a0,0xb
ffffffffc0201126:	e1650513          	addi	a0,a0,-490 # ffffffffc020bf38 <commands+0x7a0>
ffffffffc020112a:	bf49                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112c:	0000b517          	auipc	a0,0xb
ffffffffc0201130:	e2c50513          	addi	a0,a0,-468 # ffffffffc020bf58 <commands+0x7c0>
ffffffffc0201134:	b761                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201136:	0000b517          	auipc	a0,0xb
ffffffffc020113a:	e3a50513          	addi	a0,a0,-454 # ffffffffc020bf70 <commands+0x7d8>
ffffffffc020113e:	bfbd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201140:	0000b517          	auipc	a0,0xb
ffffffffc0201144:	e4050513          	addi	a0,a0,-448 # ffffffffc020bf80 <commands+0x7e8>
ffffffffc0201148:	bf95                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020114a:	0000b517          	auipc	a0,0xb
ffffffffc020114e:	e5650513          	addi	a0,a0,-426 # ffffffffc020bfa0 <commands+0x808>
ffffffffc0201152:	b7ad                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201154:	0000b517          	auipc	a0,0xb
ffffffffc0201158:	e9450513          	addi	a0,a0,-364 # ffffffffc020bfe8 <commands+0x850>
ffffffffc020115c:	b785                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020115e:	8522                	mv	a0,s0
ffffffffc0201160:	6402                	ld	s0,0(sp)
ffffffffc0201162:	60a2                	ld	ra,8(sp)
ffffffffc0201164:	0141                	addi	sp,sp,16
ffffffffc0201166:	b515                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc0201168:	0000b617          	auipc	a2,0xb
ffffffffc020116c:	e5060613          	addi	a2,a2,-432 # ffffffffc020bfb8 <commands+0x820>
ffffffffc0201170:	0b100593          	li	a1,177
ffffffffc0201174:	0000b517          	auipc	a0,0xb
ffffffffc0201178:	e5c50513          	addi	a0,a0,-420 # ffffffffc020bfd0 <commands+0x838>
ffffffffc020117c:	b22ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201180:	60a2                	ld	ra,8(sp)
ffffffffc0201182:	6402                	ld	s0,0(sp)
ffffffffc0201184:	0141                	addi	sp,sp,16
ffffffffc0201186:	8082                	ret
ffffffffc0201188:	8522                	mv	a0,s0
ffffffffc020118a:	e01ff0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc020118e:	0000b617          	auipc	a2,0xb
ffffffffc0201192:	f1a60613          	addi	a2,a2,-230 # ffffffffc020c0a8 <commands+0x910>
ffffffffc0201196:	0d100593          	li	a1,209
ffffffffc020119a:	0000b517          	auipc	a0,0xb
ffffffffc020119e:	e3650513          	addi	a0,a0,-458 # ffffffffc020bfd0 <commands+0x838>
ffffffffc02011a2:	afcff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02011a6 <trap>:
ffffffffc02011a6:	1101                	addi	sp,sp,-32
ffffffffc02011a8:	e822                	sd	s0,16(sp)
ffffffffc02011aa:	00095417          	auipc	s0,0x95
ffffffffc02011ae:	71640413          	addi	s0,s0,1814 # ffffffffc02968c0 <current>
ffffffffc02011b2:	6018                	ld	a4,0(s0)
ffffffffc02011b4:	ec06                	sd	ra,24(sp)
ffffffffc02011b6:	e426                	sd	s1,8(sp)
ffffffffc02011b8:	e04a                	sd	s2,0(sp)
ffffffffc02011ba:	11853683          	ld	a3,280(a0)
ffffffffc02011be:	cf1d                	beqz	a4,ffffffffc02011fc <trap+0x56>
ffffffffc02011c0:	10053483          	ld	s1,256(a0)
ffffffffc02011c4:	0a073903          	ld	s2,160(a4)
ffffffffc02011c8:	f348                	sd	a0,160(a4)
ffffffffc02011ca:	1004f493          	andi	s1,s1,256
ffffffffc02011ce:	0206c463          	bltz	a3,ffffffffc02011f6 <trap+0x50>
ffffffffc02011d2:	e9fff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc02011d6:	601c                	ld	a5,0(s0)
ffffffffc02011d8:	0b27b023          	sd	s2,160(a5)
ffffffffc02011dc:	e499                	bnez	s1,ffffffffc02011ea <trap+0x44>
ffffffffc02011de:	0b07a703          	lw	a4,176(a5)
ffffffffc02011e2:	8b05                	andi	a4,a4,1
ffffffffc02011e4:	e329                	bnez	a4,ffffffffc0201226 <trap+0x80>
ffffffffc02011e6:	6f9c                	ld	a5,24(a5)
ffffffffc02011e8:	eb85                	bnez	a5,ffffffffc0201218 <trap+0x72>
ffffffffc02011ea:	60e2                	ld	ra,24(sp)
ffffffffc02011ec:	6442                	ld	s0,16(sp)
ffffffffc02011ee:	64a2                	ld	s1,8(sp)
ffffffffc02011f0:	6902                	ld	s2,0(sp)
ffffffffc02011f2:	6105                	addi	sp,sp,32
ffffffffc02011f4:	8082                	ret
ffffffffc02011f6:	df7ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011fa:	bff1                	j	ffffffffc02011d6 <trap+0x30>
ffffffffc02011fc:	0006c863          	bltz	a3,ffffffffc020120c <trap+0x66>
ffffffffc0201200:	6442                	ld	s0,16(sp)
ffffffffc0201202:	60e2                	ld	ra,24(sp)
ffffffffc0201204:	64a2                	ld	s1,8(sp)
ffffffffc0201206:	6902                	ld	s2,0(sp)
ffffffffc0201208:	6105                	addi	sp,sp,32
ffffffffc020120a:	b59d                	j	ffffffffc0201070 <exception_handler>
ffffffffc020120c:	6442                	ld	s0,16(sp)
ffffffffc020120e:	60e2                	ld	ra,24(sp)
ffffffffc0201210:	64a2                	ld	s1,8(sp)
ffffffffc0201212:	6902                	ld	s2,0(sp)
ffffffffc0201214:	6105                	addi	sp,sp,32
ffffffffc0201216:	bbd9                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc0201218:	6442                	ld	s0,16(sp)
ffffffffc020121a:	60e2                	ld	ra,24(sp)
ffffffffc020121c:	64a2                	ld	s1,8(sp)
ffffffffc020121e:	6902                	ld	s2,0(sp)
ffffffffc0201220:	6105                	addi	sp,sp,32
ffffffffc0201222:	1360606f          	j	ffffffffc0207358 <schedule>
ffffffffc0201226:	555d                	li	a0,-9
ffffffffc0201228:	61f040ef          	jal	ra,ffffffffc0206046 <do_exit>
ffffffffc020122c:	601c                	ld	a5,0(s0)
ffffffffc020122e:	bf65                	j	ffffffffc02011e6 <trap+0x40>

ffffffffc0201230 <__alltraps>:
ffffffffc0201230:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0201234:	00011463          	bnez	sp,ffffffffc020123c <__alltraps+0xc>
ffffffffc0201238:	14002173          	csrr	sp,sscratch
ffffffffc020123c:	712d                	addi	sp,sp,-288
ffffffffc020123e:	e002                	sd	zero,0(sp)
ffffffffc0201240:	e406                	sd	ra,8(sp)
ffffffffc0201242:	ec0e                	sd	gp,24(sp)
ffffffffc0201244:	f012                	sd	tp,32(sp)
ffffffffc0201246:	f416                	sd	t0,40(sp)
ffffffffc0201248:	f81a                	sd	t1,48(sp)
ffffffffc020124a:	fc1e                	sd	t2,56(sp)
ffffffffc020124c:	e0a2                	sd	s0,64(sp)
ffffffffc020124e:	e4a6                	sd	s1,72(sp)
ffffffffc0201250:	e8aa                	sd	a0,80(sp)
ffffffffc0201252:	ecae                	sd	a1,88(sp)
ffffffffc0201254:	f0b2                	sd	a2,96(sp)
ffffffffc0201256:	f4b6                	sd	a3,104(sp)
ffffffffc0201258:	f8ba                	sd	a4,112(sp)
ffffffffc020125a:	fcbe                	sd	a5,120(sp)
ffffffffc020125c:	e142                	sd	a6,128(sp)
ffffffffc020125e:	e546                	sd	a7,136(sp)
ffffffffc0201260:	e94a                	sd	s2,144(sp)
ffffffffc0201262:	ed4e                	sd	s3,152(sp)
ffffffffc0201264:	f152                	sd	s4,160(sp)
ffffffffc0201266:	f556                	sd	s5,168(sp)
ffffffffc0201268:	f95a                	sd	s6,176(sp)
ffffffffc020126a:	fd5e                	sd	s7,184(sp)
ffffffffc020126c:	e1e2                	sd	s8,192(sp)
ffffffffc020126e:	e5e6                	sd	s9,200(sp)
ffffffffc0201270:	e9ea                	sd	s10,208(sp)
ffffffffc0201272:	edee                	sd	s11,216(sp)
ffffffffc0201274:	f1f2                	sd	t3,224(sp)
ffffffffc0201276:	f5f6                	sd	t4,232(sp)
ffffffffc0201278:	f9fa                	sd	t5,240(sp)
ffffffffc020127a:	fdfe                	sd	t6,248(sp)
ffffffffc020127c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201280:	100024f3          	csrr	s1,sstatus
ffffffffc0201284:	14102973          	csrr	s2,sepc
ffffffffc0201288:	143029f3          	csrr	s3,stval
ffffffffc020128c:	14202a73          	csrr	s4,scause
ffffffffc0201290:	e822                	sd	s0,16(sp)
ffffffffc0201292:	e226                	sd	s1,256(sp)
ffffffffc0201294:	e64a                	sd	s2,264(sp)
ffffffffc0201296:	ea4e                	sd	s3,272(sp)
ffffffffc0201298:	ee52                	sd	s4,280(sp)
ffffffffc020129a:	850a                	mv	a0,sp
ffffffffc020129c:	f0bff0ef          	jal	ra,ffffffffc02011a6 <trap>

ffffffffc02012a0 <__trapret>:
ffffffffc02012a0:	6492                	ld	s1,256(sp)
ffffffffc02012a2:	6932                	ld	s2,264(sp)
ffffffffc02012a4:	1004f413          	andi	s0,s1,256
ffffffffc02012a8:	e401                	bnez	s0,ffffffffc02012b0 <__trapret+0x10>
ffffffffc02012aa:	1200                	addi	s0,sp,288
ffffffffc02012ac:	14041073          	csrw	sscratch,s0
ffffffffc02012b0:	10049073          	csrw	sstatus,s1
ffffffffc02012b4:	14191073          	csrw	sepc,s2
ffffffffc02012b8:	60a2                	ld	ra,8(sp)
ffffffffc02012ba:	61e2                	ld	gp,24(sp)
ffffffffc02012bc:	7202                	ld	tp,32(sp)
ffffffffc02012be:	72a2                	ld	t0,40(sp)
ffffffffc02012c0:	7342                	ld	t1,48(sp)
ffffffffc02012c2:	73e2                	ld	t2,56(sp)
ffffffffc02012c4:	6406                	ld	s0,64(sp)
ffffffffc02012c6:	64a6                	ld	s1,72(sp)
ffffffffc02012c8:	6546                	ld	a0,80(sp)
ffffffffc02012ca:	65e6                	ld	a1,88(sp)
ffffffffc02012cc:	7606                	ld	a2,96(sp)
ffffffffc02012ce:	76a6                	ld	a3,104(sp)
ffffffffc02012d0:	7746                	ld	a4,112(sp)
ffffffffc02012d2:	77e6                	ld	a5,120(sp)
ffffffffc02012d4:	680a                	ld	a6,128(sp)
ffffffffc02012d6:	68aa                	ld	a7,136(sp)
ffffffffc02012d8:	694a                	ld	s2,144(sp)
ffffffffc02012da:	69ea                	ld	s3,152(sp)
ffffffffc02012dc:	7a0a                	ld	s4,160(sp)
ffffffffc02012de:	7aaa                	ld	s5,168(sp)
ffffffffc02012e0:	7b4a                	ld	s6,176(sp)
ffffffffc02012e2:	7bea                	ld	s7,184(sp)
ffffffffc02012e4:	6c0e                	ld	s8,192(sp)
ffffffffc02012e6:	6cae                	ld	s9,200(sp)
ffffffffc02012e8:	6d4e                	ld	s10,208(sp)
ffffffffc02012ea:	6dee                	ld	s11,216(sp)
ffffffffc02012ec:	7e0e                	ld	t3,224(sp)
ffffffffc02012ee:	7eae                	ld	t4,232(sp)
ffffffffc02012f0:	7f4e                	ld	t5,240(sp)
ffffffffc02012f2:	7fee                	ld	t6,248(sp)
ffffffffc02012f4:	6142                	ld	sp,16(sp)
ffffffffc02012f6:	10200073          	sret

ffffffffc02012fa <forkrets>:
ffffffffc02012fa:	812a                	mv	sp,a0
ffffffffc02012fc:	b755                	j	ffffffffc02012a0 <__trapret>

ffffffffc02012fe <default_init>:
ffffffffc02012fe:	00090797          	auipc	a5,0x90
ffffffffc0201302:	4aa78793          	addi	a5,a5,1194 # ffffffffc02917a8 <free_area>
ffffffffc0201306:	e79c                	sd	a5,8(a5)
ffffffffc0201308:	e39c                	sd	a5,0(a5)
ffffffffc020130a:	0007a823          	sw	zero,16(a5)
ffffffffc020130e:	8082                	ret

ffffffffc0201310 <default_nr_free_pages>:
ffffffffc0201310:	00090517          	auipc	a0,0x90
ffffffffc0201314:	4a856503          	lwu	a0,1192(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc0201318:	8082                	ret

ffffffffc020131a <default_check>:
ffffffffc020131a:	715d                	addi	sp,sp,-80
ffffffffc020131c:	e0a2                	sd	s0,64(sp)
ffffffffc020131e:	00090417          	auipc	s0,0x90
ffffffffc0201322:	48a40413          	addi	s0,s0,1162 # ffffffffc02917a8 <free_area>
ffffffffc0201326:	641c                	ld	a5,8(s0)
ffffffffc0201328:	e486                	sd	ra,72(sp)
ffffffffc020132a:	fc26                	sd	s1,56(sp)
ffffffffc020132c:	f84a                	sd	s2,48(sp)
ffffffffc020132e:	f44e                	sd	s3,40(sp)
ffffffffc0201330:	f052                	sd	s4,32(sp)
ffffffffc0201332:	ec56                	sd	s5,24(sp)
ffffffffc0201334:	e85a                	sd	s6,16(sp)
ffffffffc0201336:	e45e                	sd	s7,8(sp)
ffffffffc0201338:	e062                	sd	s8,0(sp)
ffffffffc020133a:	2a878d63          	beq	a5,s0,ffffffffc02015f4 <default_check+0x2da>
ffffffffc020133e:	4481                	li	s1,0
ffffffffc0201340:	4901                	li	s2,0
ffffffffc0201342:	ff07b703          	ld	a4,-16(a5)
ffffffffc0201346:	8b09                	andi	a4,a4,2
ffffffffc0201348:	2a070a63          	beqz	a4,ffffffffc02015fc <default_check+0x2e2>
ffffffffc020134c:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201350:	679c                	ld	a5,8(a5)
ffffffffc0201352:	2905                	addiw	s2,s2,1
ffffffffc0201354:	9cb9                	addw	s1,s1,a4
ffffffffc0201356:	fe8796e3          	bne	a5,s0,ffffffffc0201342 <default_check+0x28>
ffffffffc020135a:	89a6                	mv	s3,s1
ffffffffc020135c:	6df000ef          	jal	ra,ffffffffc020223a <nr_free_pages>
ffffffffc0201360:	6f351e63          	bne	a0,s3,ffffffffc0201a5c <default_check+0x742>
ffffffffc0201364:	4505                	li	a0,1
ffffffffc0201366:	657000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020136a:	8aaa                	mv	s5,a0
ffffffffc020136c:	42050863          	beqz	a0,ffffffffc020179c <default_check+0x482>
ffffffffc0201370:	4505                	li	a0,1
ffffffffc0201372:	64b000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201376:	89aa                	mv	s3,a0
ffffffffc0201378:	70050263          	beqz	a0,ffffffffc0201a7c <default_check+0x762>
ffffffffc020137c:	4505                	li	a0,1
ffffffffc020137e:	63f000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201382:	8a2a                	mv	s4,a0
ffffffffc0201384:	48050c63          	beqz	a0,ffffffffc020181c <default_check+0x502>
ffffffffc0201388:	293a8a63          	beq	s5,s3,ffffffffc020161c <default_check+0x302>
ffffffffc020138c:	28aa8863          	beq	s5,a0,ffffffffc020161c <default_check+0x302>
ffffffffc0201390:	28a98663          	beq	s3,a0,ffffffffc020161c <default_check+0x302>
ffffffffc0201394:	000aa783          	lw	a5,0(s5)
ffffffffc0201398:	2a079263          	bnez	a5,ffffffffc020163c <default_check+0x322>
ffffffffc020139c:	0009a783          	lw	a5,0(s3)
ffffffffc02013a0:	28079e63          	bnez	a5,ffffffffc020163c <default_check+0x322>
ffffffffc02013a4:	411c                	lw	a5,0(a0)
ffffffffc02013a6:	28079b63          	bnez	a5,ffffffffc020163c <default_check+0x322>
ffffffffc02013aa:	00095797          	auipc	a5,0x95
ffffffffc02013ae:	4fe7b783          	ld	a5,1278(a5) # ffffffffc02968a8 <pages>
ffffffffc02013b2:	40fa8733          	sub	a4,s5,a5
ffffffffc02013b6:	0000e617          	auipc	a2,0xe
ffffffffc02013ba:	48263603          	ld	a2,1154(a2) # ffffffffc020f838 <nbase>
ffffffffc02013be:	8719                	srai	a4,a4,0x6
ffffffffc02013c0:	9732                	add	a4,a4,a2
ffffffffc02013c2:	00095697          	auipc	a3,0x95
ffffffffc02013c6:	4de6b683          	ld	a3,1246(a3) # ffffffffc02968a0 <npage>
ffffffffc02013ca:	06b2                	slli	a3,a3,0xc
ffffffffc02013cc:	0732                	slli	a4,a4,0xc
ffffffffc02013ce:	28d77763          	bgeu	a4,a3,ffffffffc020165c <default_check+0x342>
ffffffffc02013d2:	40f98733          	sub	a4,s3,a5
ffffffffc02013d6:	8719                	srai	a4,a4,0x6
ffffffffc02013d8:	9732                	add	a4,a4,a2
ffffffffc02013da:	0732                	slli	a4,a4,0xc
ffffffffc02013dc:	4cd77063          	bgeu	a4,a3,ffffffffc020189c <default_check+0x582>
ffffffffc02013e0:	40f507b3          	sub	a5,a0,a5
ffffffffc02013e4:	8799                	srai	a5,a5,0x6
ffffffffc02013e6:	97b2                	add	a5,a5,a2
ffffffffc02013e8:	07b2                	slli	a5,a5,0xc
ffffffffc02013ea:	30d7f963          	bgeu	a5,a3,ffffffffc02016fc <default_check+0x3e2>
ffffffffc02013ee:	4505                	li	a0,1
ffffffffc02013f0:	00043c03          	ld	s8,0(s0)
ffffffffc02013f4:	00843b83          	ld	s7,8(s0)
ffffffffc02013f8:	01042b03          	lw	s6,16(s0)
ffffffffc02013fc:	e400                	sd	s0,8(s0)
ffffffffc02013fe:	e000                	sd	s0,0(s0)
ffffffffc0201400:	00090797          	auipc	a5,0x90
ffffffffc0201404:	3a07ac23          	sw	zero,952(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc0201408:	5b5000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020140c:	2c051863          	bnez	a0,ffffffffc02016dc <default_check+0x3c2>
ffffffffc0201410:	4585                	li	a1,1
ffffffffc0201412:	8556                	mv	a0,s5
ffffffffc0201414:	5e7000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201418:	4585                	li	a1,1
ffffffffc020141a:	854e                	mv	a0,s3
ffffffffc020141c:	5df000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201420:	4585                	li	a1,1
ffffffffc0201422:	8552                	mv	a0,s4
ffffffffc0201424:	5d7000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201428:	4818                	lw	a4,16(s0)
ffffffffc020142a:	478d                	li	a5,3
ffffffffc020142c:	28f71863          	bne	a4,a5,ffffffffc02016bc <default_check+0x3a2>
ffffffffc0201430:	4505                	li	a0,1
ffffffffc0201432:	58b000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201436:	89aa                	mv	s3,a0
ffffffffc0201438:	26050263          	beqz	a0,ffffffffc020169c <default_check+0x382>
ffffffffc020143c:	4505                	li	a0,1
ffffffffc020143e:	57f000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201442:	8aaa                	mv	s5,a0
ffffffffc0201444:	3a050c63          	beqz	a0,ffffffffc02017fc <default_check+0x4e2>
ffffffffc0201448:	4505                	li	a0,1
ffffffffc020144a:	573000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020144e:	8a2a                	mv	s4,a0
ffffffffc0201450:	38050663          	beqz	a0,ffffffffc02017dc <default_check+0x4c2>
ffffffffc0201454:	4505                	li	a0,1
ffffffffc0201456:	567000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020145a:	36051163          	bnez	a0,ffffffffc02017bc <default_check+0x4a2>
ffffffffc020145e:	4585                	li	a1,1
ffffffffc0201460:	854e                	mv	a0,s3
ffffffffc0201462:	599000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201466:	641c                	ld	a5,8(s0)
ffffffffc0201468:	20878a63          	beq	a5,s0,ffffffffc020167c <default_check+0x362>
ffffffffc020146c:	4505                	li	a0,1
ffffffffc020146e:	54f000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201472:	30a99563          	bne	s3,a0,ffffffffc020177c <default_check+0x462>
ffffffffc0201476:	4505                	li	a0,1
ffffffffc0201478:	545000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020147c:	2e051063          	bnez	a0,ffffffffc020175c <default_check+0x442>
ffffffffc0201480:	481c                	lw	a5,16(s0)
ffffffffc0201482:	2a079d63          	bnez	a5,ffffffffc020173c <default_check+0x422>
ffffffffc0201486:	854e                	mv	a0,s3
ffffffffc0201488:	4585                	li	a1,1
ffffffffc020148a:	01843023          	sd	s8,0(s0)
ffffffffc020148e:	01743423          	sd	s7,8(s0)
ffffffffc0201492:	01642823          	sw	s6,16(s0)
ffffffffc0201496:	565000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc020149a:	4585                	li	a1,1
ffffffffc020149c:	8556                	mv	a0,s5
ffffffffc020149e:	55d000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc02014a2:	4585                	li	a1,1
ffffffffc02014a4:	8552                	mv	a0,s4
ffffffffc02014a6:	555000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc02014aa:	4515                	li	a0,5
ffffffffc02014ac:	511000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc02014b0:	89aa                	mv	s3,a0
ffffffffc02014b2:	26050563          	beqz	a0,ffffffffc020171c <default_check+0x402>
ffffffffc02014b6:	651c                	ld	a5,8(a0)
ffffffffc02014b8:	8385                	srli	a5,a5,0x1
ffffffffc02014ba:	8b85                	andi	a5,a5,1
ffffffffc02014bc:	54079063          	bnez	a5,ffffffffc02019fc <default_check+0x6e2>
ffffffffc02014c0:	4505                	li	a0,1
ffffffffc02014c2:	00043b03          	ld	s6,0(s0)
ffffffffc02014c6:	00843a83          	ld	s5,8(s0)
ffffffffc02014ca:	e000                	sd	s0,0(s0)
ffffffffc02014cc:	e400                	sd	s0,8(s0)
ffffffffc02014ce:	4ef000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc02014d2:	50051563          	bnez	a0,ffffffffc02019dc <default_check+0x6c2>
ffffffffc02014d6:	08098a13          	addi	s4,s3,128
ffffffffc02014da:	8552                	mv	a0,s4
ffffffffc02014dc:	458d                	li	a1,3
ffffffffc02014de:	01042b83          	lw	s7,16(s0)
ffffffffc02014e2:	00090797          	auipc	a5,0x90
ffffffffc02014e6:	2c07ab23          	sw	zero,726(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02014ea:	511000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc02014ee:	4511                	li	a0,4
ffffffffc02014f0:	4cd000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc02014f4:	4c051463          	bnez	a0,ffffffffc02019bc <default_check+0x6a2>
ffffffffc02014f8:	0889b783          	ld	a5,136(s3)
ffffffffc02014fc:	8385                	srli	a5,a5,0x1
ffffffffc02014fe:	8b85                	andi	a5,a5,1
ffffffffc0201500:	48078e63          	beqz	a5,ffffffffc020199c <default_check+0x682>
ffffffffc0201504:	0909a703          	lw	a4,144(s3)
ffffffffc0201508:	478d                	li	a5,3
ffffffffc020150a:	48f71963          	bne	a4,a5,ffffffffc020199c <default_check+0x682>
ffffffffc020150e:	450d                	li	a0,3
ffffffffc0201510:	4ad000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201514:	8c2a                	mv	s8,a0
ffffffffc0201516:	46050363          	beqz	a0,ffffffffc020197c <default_check+0x662>
ffffffffc020151a:	4505                	li	a0,1
ffffffffc020151c:	4a1000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201520:	42051e63          	bnez	a0,ffffffffc020195c <default_check+0x642>
ffffffffc0201524:	418a1c63          	bne	s4,s8,ffffffffc020193c <default_check+0x622>
ffffffffc0201528:	4585                	li	a1,1
ffffffffc020152a:	854e                	mv	a0,s3
ffffffffc020152c:	4cf000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201530:	458d                	li	a1,3
ffffffffc0201532:	8552                	mv	a0,s4
ffffffffc0201534:	4c7000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201538:	0089b783          	ld	a5,8(s3)
ffffffffc020153c:	04098c13          	addi	s8,s3,64
ffffffffc0201540:	8385                	srli	a5,a5,0x1
ffffffffc0201542:	8b85                	andi	a5,a5,1
ffffffffc0201544:	3c078c63          	beqz	a5,ffffffffc020191c <default_check+0x602>
ffffffffc0201548:	0109a703          	lw	a4,16(s3)
ffffffffc020154c:	4785                	li	a5,1
ffffffffc020154e:	3cf71763          	bne	a4,a5,ffffffffc020191c <default_check+0x602>
ffffffffc0201552:	008a3783          	ld	a5,8(s4)
ffffffffc0201556:	8385                	srli	a5,a5,0x1
ffffffffc0201558:	8b85                	andi	a5,a5,1
ffffffffc020155a:	3a078163          	beqz	a5,ffffffffc02018fc <default_check+0x5e2>
ffffffffc020155e:	010a2703          	lw	a4,16(s4)
ffffffffc0201562:	478d                	li	a5,3
ffffffffc0201564:	38f71c63          	bne	a4,a5,ffffffffc02018fc <default_check+0x5e2>
ffffffffc0201568:	4505                	li	a0,1
ffffffffc020156a:	453000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020156e:	36a99763          	bne	s3,a0,ffffffffc02018dc <default_check+0x5c2>
ffffffffc0201572:	4585                	li	a1,1
ffffffffc0201574:	487000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201578:	4509                	li	a0,2
ffffffffc020157a:	443000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc020157e:	32aa1f63          	bne	s4,a0,ffffffffc02018bc <default_check+0x5a2>
ffffffffc0201582:	4589                	li	a1,2
ffffffffc0201584:	477000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201588:	4585                	li	a1,1
ffffffffc020158a:	8562                	mv	a0,s8
ffffffffc020158c:	46f000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0201590:	4515                	li	a0,5
ffffffffc0201592:	42b000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201596:	89aa                	mv	s3,a0
ffffffffc0201598:	48050263          	beqz	a0,ffffffffc0201a1c <default_check+0x702>
ffffffffc020159c:	4505                	li	a0,1
ffffffffc020159e:	41f000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc02015a2:	2c051d63          	bnez	a0,ffffffffc020187c <default_check+0x562>
ffffffffc02015a6:	481c                	lw	a5,16(s0)
ffffffffc02015a8:	2a079a63          	bnez	a5,ffffffffc020185c <default_check+0x542>
ffffffffc02015ac:	4595                	li	a1,5
ffffffffc02015ae:	854e                	mv	a0,s3
ffffffffc02015b0:	01742823          	sw	s7,16(s0)
ffffffffc02015b4:	01643023          	sd	s6,0(s0)
ffffffffc02015b8:	01543423          	sd	s5,8(s0)
ffffffffc02015bc:	43f000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc02015c0:	641c                	ld	a5,8(s0)
ffffffffc02015c2:	00878963          	beq	a5,s0,ffffffffc02015d4 <default_check+0x2ba>
ffffffffc02015c6:	ff87a703          	lw	a4,-8(a5)
ffffffffc02015ca:	679c                	ld	a5,8(a5)
ffffffffc02015cc:	397d                	addiw	s2,s2,-1
ffffffffc02015ce:	9c99                	subw	s1,s1,a4
ffffffffc02015d0:	fe879be3          	bne	a5,s0,ffffffffc02015c6 <default_check+0x2ac>
ffffffffc02015d4:	26091463          	bnez	s2,ffffffffc020183c <default_check+0x522>
ffffffffc02015d8:	46049263          	bnez	s1,ffffffffc0201a3c <default_check+0x722>
ffffffffc02015dc:	60a6                	ld	ra,72(sp)
ffffffffc02015de:	6406                	ld	s0,64(sp)
ffffffffc02015e0:	74e2                	ld	s1,56(sp)
ffffffffc02015e2:	7942                	ld	s2,48(sp)
ffffffffc02015e4:	79a2                	ld	s3,40(sp)
ffffffffc02015e6:	7a02                	ld	s4,32(sp)
ffffffffc02015e8:	6ae2                	ld	s5,24(sp)
ffffffffc02015ea:	6b42                	ld	s6,16(sp)
ffffffffc02015ec:	6ba2                	ld	s7,8(sp)
ffffffffc02015ee:	6c02                	ld	s8,0(sp)
ffffffffc02015f0:	6161                	addi	sp,sp,80
ffffffffc02015f2:	8082                	ret
ffffffffc02015f4:	4981                	li	s3,0
ffffffffc02015f6:	4481                	li	s1,0
ffffffffc02015f8:	4901                	li	s2,0
ffffffffc02015fa:	b38d                	j	ffffffffc020135c <default_check+0x42>
ffffffffc02015fc:	0000b697          	auipc	a3,0xb
ffffffffc0201600:	b0c68693          	addi	a3,a3,-1268 # ffffffffc020c108 <commands+0x970>
ffffffffc0201604:	0000a617          	auipc	a2,0xa
ffffffffc0201608:	3a460613          	addi	a2,a2,932 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020160c:	0ef00593          	li	a1,239
ffffffffc0201610:	0000b517          	auipc	a0,0xb
ffffffffc0201614:	b0850513          	addi	a0,a0,-1272 # ffffffffc020c118 <commands+0x980>
ffffffffc0201618:	e87fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020161c:	0000b697          	auipc	a3,0xb
ffffffffc0201620:	b9468693          	addi	a3,a3,-1132 # ffffffffc020c1b0 <commands+0xa18>
ffffffffc0201624:	0000a617          	auipc	a2,0xa
ffffffffc0201628:	38460613          	addi	a2,a2,900 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020162c:	0bc00593          	li	a1,188
ffffffffc0201630:	0000b517          	auipc	a0,0xb
ffffffffc0201634:	ae850513          	addi	a0,a0,-1304 # ffffffffc020c118 <commands+0x980>
ffffffffc0201638:	e67fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020163c:	0000b697          	auipc	a3,0xb
ffffffffc0201640:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020c1d8 <commands+0xa40>
ffffffffc0201644:	0000a617          	auipc	a2,0xa
ffffffffc0201648:	36460613          	addi	a2,a2,868 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020164c:	0bd00593          	li	a1,189
ffffffffc0201650:	0000b517          	auipc	a0,0xb
ffffffffc0201654:	ac850513          	addi	a0,a0,-1336 # ffffffffc020c118 <commands+0x980>
ffffffffc0201658:	e47fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020165c:	0000b697          	auipc	a3,0xb
ffffffffc0201660:	bbc68693          	addi	a3,a3,-1092 # ffffffffc020c218 <commands+0xa80>
ffffffffc0201664:	0000a617          	auipc	a2,0xa
ffffffffc0201668:	34460613          	addi	a2,a2,836 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020166c:	0bf00593          	li	a1,191
ffffffffc0201670:	0000b517          	auipc	a0,0xb
ffffffffc0201674:	aa850513          	addi	a0,a0,-1368 # ffffffffc020c118 <commands+0x980>
ffffffffc0201678:	e27fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020167c:	0000b697          	auipc	a3,0xb
ffffffffc0201680:	c2468693          	addi	a3,a3,-988 # ffffffffc020c2a0 <commands+0xb08>
ffffffffc0201684:	0000a617          	auipc	a2,0xa
ffffffffc0201688:	32460613          	addi	a2,a2,804 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020168c:	0d800593          	li	a1,216
ffffffffc0201690:	0000b517          	auipc	a0,0xb
ffffffffc0201694:	a8850513          	addi	a0,a0,-1400 # ffffffffc020c118 <commands+0x980>
ffffffffc0201698:	e07fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020169c:	0000b697          	auipc	a3,0xb
ffffffffc02016a0:	ab468693          	addi	a3,a3,-1356 # ffffffffc020c150 <commands+0x9b8>
ffffffffc02016a4:	0000a617          	auipc	a2,0xa
ffffffffc02016a8:	30460613          	addi	a2,a2,772 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02016ac:	0d100593          	li	a1,209
ffffffffc02016b0:	0000b517          	auipc	a0,0xb
ffffffffc02016b4:	a6850513          	addi	a0,a0,-1432 # ffffffffc020c118 <commands+0x980>
ffffffffc02016b8:	de7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016bc:	0000b697          	auipc	a3,0xb
ffffffffc02016c0:	bd468693          	addi	a3,a3,-1068 # ffffffffc020c290 <commands+0xaf8>
ffffffffc02016c4:	0000a617          	auipc	a2,0xa
ffffffffc02016c8:	2e460613          	addi	a2,a2,740 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02016cc:	0cf00593          	li	a1,207
ffffffffc02016d0:	0000b517          	auipc	a0,0xb
ffffffffc02016d4:	a4850513          	addi	a0,a0,-1464 # ffffffffc020c118 <commands+0x980>
ffffffffc02016d8:	dc7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016dc:	0000b697          	auipc	a3,0xb
ffffffffc02016e0:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020c278 <commands+0xae0>
ffffffffc02016e4:	0000a617          	auipc	a2,0xa
ffffffffc02016e8:	2c460613          	addi	a2,a2,708 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02016ec:	0ca00593          	li	a1,202
ffffffffc02016f0:	0000b517          	auipc	a0,0xb
ffffffffc02016f4:	a2850513          	addi	a0,a0,-1496 # ffffffffc020c118 <commands+0x980>
ffffffffc02016f8:	da7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016fc:	0000b697          	auipc	a3,0xb
ffffffffc0201700:	b5c68693          	addi	a3,a3,-1188 # ffffffffc020c258 <commands+0xac0>
ffffffffc0201704:	0000a617          	auipc	a2,0xa
ffffffffc0201708:	2a460613          	addi	a2,a2,676 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020170c:	0c100593          	li	a1,193
ffffffffc0201710:	0000b517          	auipc	a0,0xb
ffffffffc0201714:	a0850513          	addi	a0,a0,-1528 # ffffffffc020c118 <commands+0x980>
ffffffffc0201718:	d87fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020171c:	0000b697          	auipc	a3,0xb
ffffffffc0201720:	bcc68693          	addi	a3,a3,-1076 # ffffffffc020c2e8 <commands+0xb50>
ffffffffc0201724:	0000a617          	auipc	a2,0xa
ffffffffc0201728:	28460613          	addi	a2,a2,644 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020172c:	0f700593          	li	a1,247
ffffffffc0201730:	0000b517          	auipc	a0,0xb
ffffffffc0201734:	9e850513          	addi	a0,a0,-1560 # ffffffffc020c118 <commands+0x980>
ffffffffc0201738:	d67fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020173c:	0000b697          	auipc	a3,0xb
ffffffffc0201740:	b9c68693          	addi	a3,a3,-1124 # ffffffffc020c2d8 <commands+0xb40>
ffffffffc0201744:	0000a617          	auipc	a2,0xa
ffffffffc0201748:	26460613          	addi	a2,a2,612 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020174c:	0de00593          	li	a1,222
ffffffffc0201750:	0000b517          	auipc	a0,0xb
ffffffffc0201754:	9c850513          	addi	a0,a0,-1592 # ffffffffc020c118 <commands+0x980>
ffffffffc0201758:	d47fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020175c:	0000b697          	auipc	a3,0xb
ffffffffc0201760:	b1c68693          	addi	a3,a3,-1252 # ffffffffc020c278 <commands+0xae0>
ffffffffc0201764:	0000a617          	auipc	a2,0xa
ffffffffc0201768:	24460613          	addi	a2,a2,580 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020176c:	0dc00593          	li	a1,220
ffffffffc0201770:	0000b517          	auipc	a0,0xb
ffffffffc0201774:	9a850513          	addi	a0,a0,-1624 # ffffffffc020c118 <commands+0x980>
ffffffffc0201778:	d27fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020177c:	0000b697          	auipc	a3,0xb
ffffffffc0201780:	b3c68693          	addi	a3,a3,-1220 # ffffffffc020c2b8 <commands+0xb20>
ffffffffc0201784:	0000a617          	auipc	a2,0xa
ffffffffc0201788:	22460613          	addi	a2,a2,548 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020178c:	0db00593          	li	a1,219
ffffffffc0201790:	0000b517          	auipc	a0,0xb
ffffffffc0201794:	98850513          	addi	a0,a0,-1656 # ffffffffc020c118 <commands+0x980>
ffffffffc0201798:	d07fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020179c:	0000b697          	auipc	a3,0xb
ffffffffc02017a0:	9b468693          	addi	a3,a3,-1612 # ffffffffc020c150 <commands+0x9b8>
ffffffffc02017a4:	0000a617          	auipc	a2,0xa
ffffffffc02017a8:	20460613          	addi	a2,a2,516 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02017ac:	0b800593          	li	a1,184
ffffffffc02017b0:	0000b517          	auipc	a0,0xb
ffffffffc02017b4:	96850513          	addi	a0,a0,-1688 # ffffffffc020c118 <commands+0x980>
ffffffffc02017b8:	ce7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017bc:	0000b697          	auipc	a3,0xb
ffffffffc02017c0:	abc68693          	addi	a3,a3,-1348 # ffffffffc020c278 <commands+0xae0>
ffffffffc02017c4:	0000a617          	auipc	a2,0xa
ffffffffc02017c8:	1e460613          	addi	a2,a2,484 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02017cc:	0d500593          	li	a1,213
ffffffffc02017d0:	0000b517          	auipc	a0,0xb
ffffffffc02017d4:	94850513          	addi	a0,a0,-1720 # ffffffffc020c118 <commands+0x980>
ffffffffc02017d8:	cc7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017dc:	0000b697          	auipc	a3,0xb
ffffffffc02017e0:	9b468693          	addi	a3,a3,-1612 # ffffffffc020c190 <commands+0x9f8>
ffffffffc02017e4:	0000a617          	auipc	a2,0xa
ffffffffc02017e8:	1c460613          	addi	a2,a2,452 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02017ec:	0d300593          	li	a1,211
ffffffffc02017f0:	0000b517          	auipc	a0,0xb
ffffffffc02017f4:	92850513          	addi	a0,a0,-1752 # ffffffffc020c118 <commands+0x980>
ffffffffc02017f8:	ca7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017fc:	0000b697          	auipc	a3,0xb
ffffffffc0201800:	97468693          	addi	a3,a3,-1676 # ffffffffc020c170 <commands+0x9d8>
ffffffffc0201804:	0000a617          	auipc	a2,0xa
ffffffffc0201808:	1a460613          	addi	a2,a2,420 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020180c:	0d200593          	li	a1,210
ffffffffc0201810:	0000b517          	auipc	a0,0xb
ffffffffc0201814:	90850513          	addi	a0,a0,-1784 # ffffffffc020c118 <commands+0x980>
ffffffffc0201818:	c87fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020181c:	0000b697          	auipc	a3,0xb
ffffffffc0201820:	97468693          	addi	a3,a3,-1676 # ffffffffc020c190 <commands+0x9f8>
ffffffffc0201824:	0000a617          	auipc	a2,0xa
ffffffffc0201828:	18460613          	addi	a2,a2,388 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020182c:	0ba00593          	li	a1,186
ffffffffc0201830:	0000b517          	auipc	a0,0xb
ffffffffc0201834:	8e850513          	addi	a0,a0,-1816 # ffffffffc020c118 <commands+0x980>
ffffffffc0201838:	c67fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020183c:	0000b697          	auipc	a3,0xb
ffffffffc0201840:	bfc68693          	addi	a3,a3,-1028 # ffffffffc020c438 <commands+0xca0>
ffffffffc0201844:	0000a617          	auipc	a2,0xa
ffffffffc0201848:	16460613          	addi	a2,a2,356 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020184c:	12400593          	li	a1,292
ffffffffc0201850:	0000b517          	auipc	a0,0xb
ffffffffc0201854:	8c850513          	addi	a0,a0,-1848 # ffffffffc020c118 <commands+0x980>
ffffffffc0201858:	c47fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020185c:	0000b697          	auipc	a3,0xb
ffffffffc0201860:	a7c68693          	addi	a3,a3,-1412 # ffffffffc020c2d8 <commands+0xb40>
ffffffffc0201864:	0000a617          	auipc	a2,0xa
ffffffffc0201868:	14460613          	addi	a2,a2,324 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020186c:	11900593          	li	a1,281
ffffffffc0201870:	0000b517          	auipc	a0,0xb
ffffffffc0201874:	8a850513          	addi	a0,a0,-1880 # ffffffffc020c118 <commands+0x980>
ffffffffc0201878:	c27fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020187c:	0000b697          	auipc	a3,0xb
ffffffffc0201880:	9fc68693          	addi	a3,a3,-1540 # ffffffffc020c278 <commands+0xae0>
ffffffffc0201884:	0000a617          	auipc	a2,0xa
ffffffffc0201888:	12460613          	addi	a2,a2,292 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020188c:	11700593          	li	a1,279
ffffffffc0201890:	0000b517          	auipc	a0,0xb
ffffffffc0201894:	88850513          	addi	a0,a0,-1912 # ffffffffc020c118 <commands+0x980>
ffffffffc0201898:	c07fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020189c:	0000b697          	auipc	a3,0xb
ffffffffc02018a0:	99c68693          	addi	a3,a3,-1636 # ffffffffc020c238 <commands+0xaa0>
ffffffffc02018a4:	0000a617          	auipc	a2,0xa
ffffffffc02018a8:	10460613          	addi	a2,a2,260 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02018ac:	0c000593          	li	a1,192
ffffffffc02018b0:	0000b517          	auipc	a0,0xb
ffffffffc02018b4:	86850513          	addi	a0,a0,-1944 # ffffffffc020c118 <commands+0x980>
ffffffffc02018b8:	be7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018bc:	0000b697          	auipc	a3,0xb
ffffffffc02018c0:	b3c68693          	addi	a3,a3,-1220 # ffffffffc020c3f8 <commands+0xc60>
ffffffffc02018c4:	0000a617          	auipc	a2,0xa
ffffffffc02018c8:	0e460613          	addi	a2,a2,228 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02018cc:	11100593          	li	a1,273
ffffffffc02018d0:	0000b517          	auipc	a0,0xb
ffffffffc02018d4:	84850513          	addi	a0,a0,-1976 # ffffffffc020c118 <commands+0x980>
ffffffffc02018d8:	bc7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018dc:	0000b697          	auipc	a3,0xb
ffffffffc02018e0:	afc68693          	addi	a3,a3,-1284 # ffffffffc020c3d8 <commands+0xc40>
ffffffffc02018e4:	0000a617          	auipc	a2,0xa
ffffffffc02018e8:	0c460613          	addi	a2,a2,196 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02018ec:	10f00593          	li	a1,271
ffffffffc02018f0:	0000b517          	auipc	a0,0xb
ffffffffc02018f4:	82850513          	addi	a0,a0,-2008 # ffffffffc020c118 <commands+0x980>
ffffffffc02018f8:	ba7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018fc:	0000b697          	auipc	a3,0xb
ffffffffc0201900:	ab468693          	addi	a3,a3,-1356 # ffffffffc020c3b0 <commands+0xc18>
ffffffffc0201904:	0000a617          	auipc	a2,0xa
ffffffffc0201908:	0a460613          	addi	a2,a2,164 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020190c:	10d00593          	li	a1,269
ffffffffc0201910:	0000b517          	auipc	a0,0xb
ffffffffc0201914:	80850513          	addi	a0,a0,-2040 # ffffffffc020c118 <commands+0x980>
ffffffffc0201918:	b87fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020191c:	0000b697          	auipc	a3,0xb
ffffffffc0201920:	a6c68693          	addi	a3,a3,-1428 # ffffffffc020c388 <commands+0xbf0>
ffffffffc0201924:	0000a617          	auipc	a2,0xa
ffffffffc0201928:	08460613          	addi	a2,a2,132 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020192c:	10c00593          	li	a1,268
ffffffffc0201930:	0000a517          	auipc	a0,0xa
ffffffffc0201934:	7e850513          	addi	a0,a0,2024 # ffffffffc020c118 <commands+0x980>
ffffffffc0201938:	b67fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020193c:	0000b697          	auipc	a3,0xb
ffffffffc0201940:	a3c68693          	addi	a3,a3,-1476 # ffffffffc020c378 <commands+0xbe0>
ffffffffc0201944:	0000a617          	auipc	a2,0xa
ffffffffc0201948:	06460613          	addi	a2,a2,100 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020194c:	10700593          	li	a1,263
ffffffffc0201950:	0000a517          	auipc	a0,0xa
ffffffffc0201954:	7c850513          	addi	a0,a0,1992 # ffffffffc020c118 <commands+0x980>
ffffffffc0201958:	b47fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020195c:	0000b697          	auipc	a3,0xb
ffffffffc0201960:	91c68693          	addi	a3,a3,-1764 # ffffffffc020c278 <commands+0xae0>
ffffffffc0201964:	0000a617          	auipc	a2,0xa
ffffffffc0201968:	04460613          	addi	a2,a2,68 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020196c:	10600593          	li	a1,262
ffffffffc0201970:	0000a517          	auipc	a0,0xa
ffffffffc0201974:	7a850513          	addi	a0,a0,1960 # ffffffffc020c118 <commands+0x980>
ffffffffc0201978:	b27fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020197c:	0000b697          	auipc	a3,0xb
ffffffffc0201980:	9dc68693          	addi	a3,a3,-1572 # ffffffffc020c358 <commands+0xbc0>
ffffffffc0201984:	0000a617          	auipc	a2,0xa
ffffffffc0201988:	02460613          	addi	a2,a2,36 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020198c:	10500593          	li	a1,261
ffffffffc0201990:	0000a517          	auipc	a0,0xa
ffffffffc0201994:	78850513          	addi	a0,a0,1928 # ffffffffc020c118 <commands+0x980>
ffffffffc0201998:	b07fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020199c:	0000b697          	auipc	a3,0xb
ffffffffc02019a0:	98c68693          	addi	a3,a3,-1652 # ffffffffc020c328 <commands+0xb90>
ffffffffc02019a4:	0000a617          	auipc	a2,0xa
ffffffffc02019a8:	00460613          	addi	a2,a2,4 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02019ac:	10400593          	li	a1,260
ffffffffc02019b0:	0000a517          	auipc	a0,0xa
ffffffffc02019b4:	76850513          	addi	a0,a0,1896 # ffffffffc020c118 <commands+0x980>
ffffffffc02019b8:	ae7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019bc:	0000b697          	auipc	a3,0xb
ffffffffc02019c0:	95468693          	addi	a3,a3,-1708 # ffffffffc020c310 <commands+0xb78>
ffffffffc02019c4:	0000a617          	auipc	a2,0xa
ffffffffc02019c8:	fe460613          	addi	a2,a2,-28 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02019cc:	10300593          	li	a1,259
ffffffffc02019d0:	0000a517          	auipc	a0,0xa
ffffffffc02019d4:	74850513          	addi	a0,a0,1864 # ffffffffc020c118 <commands+0x980>
ffffffffc02019d8:	ac7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019dc:	0000b697          	auipc	a3,0xb
ffffffffc02019e0:	89c68693          	addi	a3,a3,-1892 # ffffffffc020c278 <commands+0xae0>
ffffffffc02019e4:	0000a617          	auipc	a2,0xa
ffffffffc02019e8:	fc460613          	addi	a2,a2,-60 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02019ec:	0fd00593          	li	a1,253
ffffffffc02019f0:	0000a517          	auipc	a0,0xa
ffffffffc02019f4:	72850513          	addi	a0,a0,1832 # ffffffffc020c118 <commands+0x980>
ffffffffc02019f8:	aa7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019fc:	0000b697          	auipc	a3,0xb
ffffffffc0201a00:	8fc68693          	addi	a3,a3,-1796 # ffffffffc020c2f8 <commands+0xb60>
ffffffffc0201a04:	0000a617          	auipc	a2,0xa
ffffffffc0201a08:	fa460613          	addi	a2,a2,-92 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201a0c:	0f800593          	li	a1,248
ffffffffc0201a10:	0000a517          	auipc	a0,0xa
ffffffffc0201a14:	70850513          	addi	a0,a0,1800 # ffffffffc020c118 <commands+0x980>
ffffffffc0201a18:	a87fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a1c:	0000b697          	auipc	a3,0xb
ffffffffc0201a20:	9fc68693          	addi	a3,a3,-1540 # ffffffffc020c418 <commands+0xc80>
ffffffffc0201a24:	0000a617          	auipc	a2,0xa
ffffffffc0201a28:	f8460613          	addi	a2,a2,-124 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201a2c:	11600593          	li	a1,278
ffffffffc0201a30:	0000a517          	auipc	a0,0xa
ffffffffc0201a34:	6e850513          	addi	a0,a0,1768 # ffffffffc020c118 <commands+0x980>
ffffffffc0201a38:	a67fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a3c:	0000b697          	auipc	a3,0xb
ffffffffc0201a40:	a0c68693          	addi	a3,a3,-1524 # ffffffffc020c448 <commands+0xcb0>
ffffffffc0201a44:	0000a617          	auipc	a2,0xa
ffffffffc0201a48:	f6460613          	addi	a2,a2,-156 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201a4c:	12500593          	li	a1,293
ffffffffc0201a50:	0000a517          	auipc	a0,0xa
ffffffffc0201a54:	6c850513          	addi	a0,a0,1736 # ffffffffc020c118 <commands+0x980>
ffffffffc0201a58:	a47fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a5c:	0000a697          	auipc	a3,0xa
ffffffffc0201a60:	6d468693          	addi	a3,a3,1748 # ffffffffc020c130 <commands+0x998>
ffffffffc0201a64:	0000a617          	auipc	a2,0xa
ffffffffc0201a68:	f4460613          	addi	a2,a2,-188 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201a6c:	0f200593          	li	a1,242
ffffffffc0201a70:	0000a517          	auipc	a0,0xa
ffffffffc0201a74:	6a850513          	addi	a0,a0,1704 # ffffffffc020c118 <commands+0x980>
ffffffffc0201a78:	a27fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a7c:	0000a697          	auipc	a3,0xa
ffffffffc0201a80:	6f468693          	addi	a3,a3,1780 # ffffffffc020c170 <commands+0x9d8>
ffffffffc0201a84:	0000a617          	auipc	a2,0xa
ffffffffc0201a88:	f2460613          	addi	a2,a2,-220 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201a8c:	0b900593          	li	a1,185
ffffffffc0201a90:	0000a517          	auipc	a0,0xa
ffffffffc0201a94:	68850513          	addi	a0,a0,1672 # ffffffffc020c118 <commands+0x980>
ffffffffc0201a98:	a07fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a9c <default_free_pages>:
ffffffffc0201a9c:	1141                	addi	sp,sp,-16
ffffffffc0201a9e:	e406                	sd	ra,8(sp)
ffffffffc0201aa0:	14058463          	beqz	a1,ffffffffc0201be8 <default_free_pages+0x14c>
ffffffffc0201aa4:	00659693          	slli	a3,a1,0x6
ffffffffc0201aa8:	96aa                	add	a3,a3,a0
ffffffffc0201aaa:	87aa                	mv	a5,a0
ffffffffc0201aac:	02d50263          	beq	a0,a3,ffffffffc0201ad0 <default_free_pages+0x34>
ffffffffc0201ab0:	6798                	ld	a4,8(a5)
ffffffffc0201ab2:	8b05                	andi	a4,a4,1
ffffffffc0201ab4:	10071a63          	bnez	a4,ffffffffc0201bc8 <default_free_pages+0x12c>
ffffffffc0201ab8:	6798                	ld	a4,8(a5)
ffffffffc0201aba:	8b09                	andi	a4,a4,2
ffffffffc0201abc:	10071663          	bnez	a4,ffffffffc0201bc8 <default_free_pages+0x12c>
ffffffffc0201ac0:	0007b423          	sd	zero,8(a5)
ffffffffc0201ac4:	0007a023          	sw	zero,0(a5)
ffffffffc0201ac8:	04078793          	addi	a5,a5,64
ffffffffc0201acc:	fed792e3          	bne	a5,a3,ffffffffc0201ab0 <default_free_pages+0x14>
ffffffffc0201ad0:	2581                	sext.w	a1,a1
ffffffffc0201ad2:	c90c                	sw	a1,16(a0)
ffffffffc0201ad4:	00850893          	addi	a7,a0,8
ffffffffc0201ad8:	4789                	li	a5,2
ffffffffc0201ada:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201ade:	00090697          	auipc	a3,0x90
ffffffffc0201ae2:	cca68693          	addi	a3,a3,-822 # ffffffffc02917a8 <free_area>
ffffffffc0201ae6:	4a98                	lw	a4,16(a3)
ffffffffc0201ae8:	669c                	ld	a5,8(a3)
ffffffffc0201aea:	01850613          	addi	a2,a0,24
ffffffffc0201aee:	9db9                	addw	a1,a1,a4
ffffffffc0201af0:	ca8c                	sw	a1,16(a3)
ffffffffc0201af2:	0ad78463          	beq	a5,a3,ffffffffc0201b9a <default_free_pages+0xfe>
ffffffffc0201af6:	fe878713          	addi	a4,a5,-24
ffffffffc0201afa:	0006b803          	ld	a6,0(a3)
ffffffffc0201afe:	4581                	li	a1,0
ffffffffc0201b00:	00e56a63          	bltu	a0,a4,ffffffffc0201b14 <default_free_pages+0x78>
ffffffffc0201b04:	6798                	ld	a4,8(a5)
ffffffffc0201b06:	04d70c63          	beq	a4,a3,ffffffffc0201b5e <default_free_pages+0xc2>
ffffffffc0201b0a:	87ba                	mv	a5,a4
ffffffffc0201b0c:	fe878713          	addi	a4,a5,-24
ffffffffc0201b10:	fee57ae3          	bgeu	a0,a4,ffffffffc0201b04 <default_free_pages+0x68>
ffffffffc0201b14:	c199                	beqz	a1,ffffffffc0201b1a <default_free_pages+0x7e>
ffffffffc0201b16:	0106b023          	sd	a6,0(a3)
ffffffffc0201b1a:	6398                	ld	a4,0(a5)
ffffffffc0201b1c:	e390                	sd	a2,0(a5)
ffffffffc0201b1e:	e710                	sd	a2,8(a4)
ffffffffc0201b20:	f11c                	sd	a5,32(a0)
ffffffffc0201b22:	ed18                	sd	a4,24(a0)
ffffffffc0201b24:	00d70d63          	beq	a4,a3,ffffffffc0201b3e <default_free_pages+0xa2>
ffffffffc0201b28:	ff872583          	lw	a1,-8(a4)
ffffffffc0201b2c:	fe870613          	addi	a2,a4,-24
ffffffffc0201b30:	02059813          	slli	a6,a1,0x20
ffffffffc0201b34:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201b38:	97b2                	add	a5,a5,a2
ffffffffc0201b3a:	02f50c63          	beq	a0,a5,ffffffffc0201b72 <default_free_pages+0xd6>
ffffffffc0201b3e:	711c                	ld	a5,32(a0)
ffffffffc0201b40:	00d78c63          	beq	a5,a3,ffffffffc0201b58 <default_free_pages+0xbc>
ffffffffc0201b44:	4910                	lw	a2,16(a0)
ffffffffc0201b46:	fe878693          	addi	a3,a5,-24
ffffffffc0201b4a:	02061593          	slli	a1,a2,0x20
ffffffffc0201b4e:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b52:	972a                	add	a4,a4,a0
ffffffffc0201b54:	04e68a63          	beq	a3,a4,ffffffffc0201ba8 <default_free_pages+0x10c>
ffffffffc0201b58:	60a2                	ld	ra,8(sp)
ffffffffc0201b5a:	0141                	addi	sp,sp,16
ffffffffc0201b5c:	8082                	ret
ffffffffc0201b5e:	e790                	sd	a2,8(a5)
ffffffffc0201b60:	f114                	sd	a3,32(a0)
ffffffffc0201b62:	6798                	ld	a4,8(a5)
ffffffffc0201b64:	ed1c                	sd	a5,24(a0)
ffffffffc0201b66:	02d70763          	beq	a4,a3,ffffffffc0201b94 <default_free_pages+0xf8>
ffffffffc0201b6a:	8832                	mv	a6,a2
ffffffffc0201b6c:	4585                	li	a1,1
ffffffffc0201b6e:	87ba                	mv	a5,a4
ffffffffc0201b70:	bf71                	j	ffffffffc0201b0c <default_free_pages+0x70>
ffffffffc0201b72:	491c                	lw	a5,16(a0)
ffffffffc0201b74:	9dbd                	addw	a1,a1,a5
ffffffffc0201b76:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b7a:	57f5                	li	a5,-3
ffffffffc0201b7c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b80:	01853803          	ld	a6,24(a0)
ffffffffc0201b84:	710c                	ld	a1,32(a0)
ffffffffc0201b86:	8532                	mv	a0,a2
ffffffffc0201b88:	00b83423          	sd	a1,8(a6)
ffffffffc0201b8c:	671c                	ld	a5,8(a4)
ffffffffc0201b8e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b92:	b77d                	j	ffffffffc0201b40 <default_free_pages+0xa4>
ffffffffc0201b94:	e290                	sd	a2,0(a3)
ffffffffc0201b96:	873e                	mv	a4,a5
ffffffffc0201b98:	bf41                	j	ffffffffc0201b28 <default_free_pages+0x8c>
ffffffffc0201b9a:	60a2                	ld	ra,8(sp)
ffffffffc0201b9c:	e390                	sd	a2,0(a5)
ffffffffc0201b9e:	e790                	sd	a2,8(a5)
ffffffffc0201ba0:	f11c                	sd	a5,32(a0)
ffffffffc0201ba2:	ed1c                	sd	a5,24(a0)
ffffffffc0201ba4:	0141                	addi	sp,sp,16
ffffffffc0201ba6:	8082                	ret
ffffffffc0201ba8:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201bac:	ff078693          	addi	a3,a5,-16
ffffffffc0201bb0:	9e39                	addw	a2,a2,a4
ffffffffc0201bb2:	c910                	sw	a2,16(a0)
ffffffffc0201bb4:	5775                	li	a4,-3
ffffffffc0201bb6:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201bba:	6398                	ld	a4,0(a5)
ffffffffc0201bbc:	679c                	ld	a5,8(a5)
ffffffffc0201bbe:	60a2                	ld	ra,8(sp)
ffffffffc0201bc0:	e71c                	sd	a5,8(a4)
ffffffffc0201bc2:	e398                	sd	a4,0(a5)
ffffffffc0201bc4:	0141                	addi	sp,sp,16
ffffffffc0201bc6:	8082                	ret
ffffffffc0201bc8:	0000b697          	auipc	a3,0xb
ffffffffc0201bcc:	89868693          	addi	a3,a3,-1896 # ffffffffc020c460 <commands+0xcc8>
ffffffffc0201bd0:	0000a617          	auipc	a2,0xa
ffffffffc0201bd4:	dd860613          	addi	a2,a2,-552 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201bd8:	08200593          	li	a1,130
ffffffffc0201bdc:	0000a517          	auipc	a0,0xa
ffffffffc0201be0:	53c50513          	addi	a0,a0,1340 # ffffffffc020c118 <commands+0x980>
ffffffffc0201be4:	8bbfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201be8:	0000b697          	auipc	a3,0xb
ffffffffc0201bec:	87068693          	addi	a3,a3,-1936 # ffffffffc020c458 <commands+0xcc0>
ffffffffc0201bf0:	0000a617          	auipc	a2,0xa
ffffffffc0201bf4:	db860613          	addi	a2,a2,-584 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201bf8:	07f00593          	li	a1,127
ffffffffc0201bfc:	0000a517          	auipc	a0,0xa
ffffffffc0201c00:	51c50513          	addi	a0,a0,1308 # ffffffffc020c118 <commands+0x980>
ffffffffc0201c04:	89bfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c08 <default_alloc_pages>:
ffffffffc0201c08:	c941                	beqz	a0,ffffffffc0201c98 <default_alloc_pages+0x90>
ffffffffc0201c0a:	00090597          	auipc	a1,0x90
ffffffffc0201c0e:	b9e58593          	addi	a1,a1,-1122 # ffffffffc02917a8 <free_area>
ffffffffc0201c12:	0105a803          	lw	a6,16(a1)
ffffffffc0201c16:	872a                	mv	a4,a0
ffffffffc0201c18:	02081793          	slli	a5,a6,0x20
ffffffffc0201c1c:	9381                	srli	a5,a5,0x20
ffffffffc0201c1e:	00a7ee63          	bltu	a5,a0,ffffffffc0201c3a <default_alloc_pages+0x32>
ffffffffc0201c22:	87ae                	mv	a5,a1
ffffffffc0201c24:	a801                	j	ffffffffc0201c34 <default_alloc_pages+0x2c>
ffffffffc0201c26:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201c2a:	02069613          	slli	a2,a3,0x20
ffffffffc0201c2e:	9201                	srli	a2,a2,0x20
ffffffffc0201c30:	00e67763          	bgeu	a2,a4,ffffffffc0201c3e <default_alloc_pages+0x36>
ffffffffc0201c34:	679c                	ld	a5,8(a5)
ffffffffc0201c36:	feb798e3          	bne	a5,a1,ffffffffc0201c26 <default_alloc_pages+0x1e>
ffffffffc0201c3a:	4501                	li	a0,0
ffffffffc0201c3c:	8082                	ret
ffffffffc0201c3e:	0007b883          	ld	a7,0(a5)
ffffffffc0201c42:	0087b303          	ld	t1,8(a5)
ffffffffc0201c46:	fe878513          	addi	a0,a5,-24
ffffffffc0201c4a:	00070e1b          	sext.w	t3,a4
ffffffffc0201c4e:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c52:	01133023          	sd	a7,0(t1)
ffffffffc0201c56:	02c77863          	bgeu	a4,a2,ffffffffc0201c86 <default_alloc_pages+0x7e>
ffffffffc0201c5a:	071a                	slli	a4,a4,0x6
ffffffffc0201c5c:	972a                	add	a4,a4,a0
ffffffffc0201c5e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c62:	cb14                	sw	a3,16(a4)
ffffffffc0201c64:	00870613          	addi	a2,a4,8
ffffffffc0201c68:	4689                	li	a3,2
ffffffffc0201c6a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c6e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c72:	01870613          	addi	a2,a4,24
ffffffffc0201c76:	0105a803          	lw	a6,16(a1)
ffffffffc0201c7a:	e290                	sd	a2,0(a3)
ffffffffc0201c7c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c80:	f314                	sd	a3,32(a4)
ffffffffc0201c82:	01173c23          	sd	a7,24(a4)
ffffffffc0201c86:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c8a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c8e:	5775                	li	a4,-3
ffffffffc0201c90:	17c1                	addi	a5,a5,-16
ffffffffc0201c92:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c96:	8082                	ret
ffffffffc0201c98:	1141                	addi	sp,sp,-16
ffffffffc0201c9a:	0000a697          	auipc	a3,0xa
ffffffffc0201c9e:	7be68693          	addi	a3,a3,1982 # ffffffffc020c458 <commands+0xcc0>
ffffffffc0201ca2:	0000a617          	auipc	a2,0xa
ffffffffc0201ca6:	d0660613          	addi	a2,a2,-762 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201caa:	06100593          	li	a1,97
ffffffffc0201cae:	0000a517          	auipc	a0,0xa
ffffffffc0201cb2:	46a50513          	addi	a0,a0,1130 # ffffffffc020c118 <commands+0x980>
ffffffffc0201cb6:	e406                	sd	ra,8(sp)
ffffffffc0201cb8:	fe6fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201cbc <default_init_memmap>:
ffffffffc0201cbc:	1141                	addi	sp,sp,-16
ffffffffc0201cbe:	e406                	sd	ra,8(sp)
ffffffffc0201cc0:	c5f1                	beqz	a1,ffffffffc0201d8c <default_init_memmap+0xd0>
ffffffffc0201cc2:	00659693          	slli	a3,a1,0x6
ffffffffc0201cc6:	96aa                	add	a3,a3,a0
ffffffffc0201cc8:	87aa                	mv	a5,a0
ffffffffc0201cca:	00d50f63          	beq	a0,a3,ffffffffc0201ce8 <default_init_memmap+0x2c>
ffffffffc0201cce:	6798                	ld	a4,8(a5)
ffffffffc0201cd0:	8b05                	andi	a4,a4,1
ffffffffc0201cd2:	cf49                	beqz	a4,ffffffffc0201d6c <default_init_memmap+0xb0>
ffffffffc0201cd4:	0007a823          	sw	zero,16(a5)
ffffffffc0201cd8:	0007b423          	sd	zero,8(a5)
ffffffffc0201cdc:	0007a023          	sw	zero,0(a5)
ffffffffc0201ce0:	04078793          	addi	a5,a5,64
ffffffffc0201ce4:	fed795e3          	bne	a5,a3,ffffffffc0201cce <default_init_memmap+0x12>
ffffffffc0201ce8:	2581                	sext.w	a1,a1
ffffffffc0201cea:	c90c                	sw	a1,16(a0)
ffffffffc0201cec:	4789                	li	a5,2
ffffffffc0201cee:	00850713          	addi	a4,a0,8
ffffffffc0201cf2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201cf6:	00090697          	auipc	a3,0x90
ffffffffc0201cfa:	ab268693          	addi	a3,a3,-1358 # ffffffffc02917a8 <free_area>
ffffffffc0201cfe:	4a98                	lw	a4,16(a3)
ffffffffc0201d00:	669c                	ld	a5,8(a3)
ffffffffc0201d02:	01850613          	addi	a2,a0,24
ffffffffc0201d06:	9db9                	addw	a1,a1,a4
ffffffffc0201d08:	ca8c                	sw	a1,16(a3)
ffffffffc0201d0a:	04d78a63          	beq	a5,a3,ffffffffc0201d5e <default_init_memmap+0xa2>
ffffffffc0201d0e:	fe878713          	addi	a4,a5,-24
ffffffffc0201d12:	0006b803          	ld	a6,0(a3)
ffffffffc0201d16:	4581                	li	a1,0
ffffffffc0201d18:	00e56a63          	bltu	a0,a4,ffffffffc0201d2c <default_init_memmap+0x70>
ffffffffc0201d1c:	6798                	ld	a4,8(a5)
ffffffffc0201d1e:	02d70263          	beq	a4,a3,ffffffffc0201d42 <default_init_memmap+0x86>
ffffffffc0201d22:	87ba                	mv	a5,a4
ffffffffc0201d24:	fe878713          	addi	a4,a5,-24
ffffffffc0201d28:	fee57ae3          	bgeu	a0,a4,ffffffffc0201d1c <default_init_memmap+0x60>
ffffffffc0201d2c:	c199                	beqz	a1,ffffffffc0201d32 <default_init_memmap+0x76>
ffffffffc0201d2e:	0106b023          	sd	a6,0(a3)
ffffffffc0201d32:	6398                	ld	a4,0(a5)
ffffffffc0201d34:	60a2                	ld	ra,8(sp)
ffffffffc0201d36:	e390                	sd	a2,0(a5)
ffffffffc0201d38:	e710                	sd	a2,8(a4)
ffffffffc0201d3a:	f11c                	sd	a5,32(a0)
ffffffffc0201d3c:	ed18                	sd	a4,24(a0)
ffffffffc0201d3e:	0141                	addi	sp,sp,16
ffffffffc0201d40:	8082                	ret
ffffffffc0201d42:	e790                	sd	a2,8(a5)
ffffffffc0201d44:	f114                	sd	a3,32(a0)
ffffffffc0201d46:	6798                	ld	a4,8(a5)
ffffffffc0201d48:	ed1c                	sd	a5,24(a0)
ffffffffc0201d4a:	00d70663          	beq	a4,a3,ffffffffc0201d56 <default_init_memmap+0x9a>
ffffffffc0201d4e:	8832                	mv	a6,a2
ffffffffc0201d50:	4585                	li	a1,1
ffffffffc0201d52:	87ba                	mv	a5,a4
ffffffffc0201d54:	bfc1                	j	ffffffffc0201d24 <default_init_memmap+0x68>
ffffffffc0201d56:	60a2                	ld	ra,8(sp)
ffffffffc0201d58:	e290                	sd	a2,0(a3)
ffffffffc0201d5a:	0141                	addi	sp,sp,16
ffffffffc0201d5c:	8082                	ret
ffffffffc0201d5e:	60a2                	ld	ra,8(sp)
ffffffffc0201d60:	e390                	sd	a2,0(a5)
ffffffffc0201d62:	e790                	sd	a2,8(a5)
ffffffffc0201d64:	f11c                	sd	a5,32(a0)
ffffffffc0201d66:	ed1c                	sd	a5,24(a0)
ffffffffc0201d68:	0141                	addi	sp,sp,16
ffffffffc0201d6a:	8082                	ret
ffffffffc0201d6c:	0000a697          	auipc	a3,0xa
ffffffffc0201d70:	71c68693          	addi	a3,a3,1820 # ffffffffc020c488 <commands+0xcf0>
ffffffffc0201d74:	0000a617          	auipc	a2,0xa
ffffffffc0201d78:	c3460613          	addi	a2,a2,-972 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201d7c:	04800593          	li	a1,72
ffffffffc0201d80:	0000a517          	auipc	a0,0xa
ffffffffc0201d84:	39850513          	addi	a0,a0,920 # ffffffffc020c118 <commands+0x980>
ffffffffc0201d88:	f16fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d8c:	0000a697          	auipc	a3,0xa
ffffffffc0201d90:	6cc68693          	addi	a3,a3,1740 # ffffffffc020c458 <commands+0xcc0>
ffffffffc0201d94:	0000a617          	auipc	a2,0xa
ffffffffc0201d98:	c1460613          	addi	a2,a2,-1004 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201d9c:	04500593          	li	a1,69
ffffffffc0201da0:	0000a517          	auipc	a0,0xa
ffffffffc0201da4:	37850513          	addi	a0,a0,888 # ffffffffc020c118 <commands+0x980>
ffffffffc0201da8:	ef6fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201dac <slob_free>:
ffffffffc0201dac:	c94d                	beqz	a0,ffffffffc0201e5e <slob_free+0xb2>
ffffffffc0201dae:	1141                	addi	sp,sp,-16
ffffffffc0201db0:	e022                	sd	s0,0(sp)
ffffffffc0201db2:	e406                	sd	ra,8(sp)
ffffffffc0201db4:	842a                	mv	s0,a0
ffffffffc0201db6:	e9c1                	bnez	a1,ffffffffc0201e46 <slob_free+0x9a>
ffffffffc0201db8:	100027f3          	csrr	a5,sstatus
ffffffffc0201dbc:	8b89                	andi	a5,a5,2
ffffffffc0201dbe:	4501                	li	a0,0
ffffffffc0201dc0:	ebd9                	bnez	a5,ffffffffc0201e56 <slob_free+0xaa>
ffffffffc0201dc2:	0008f617          	auipc	a2,0x8f
ffffffffc0201dc6:	28e60613          	addi	a2,a2,654 # ffffffffc0291050 <slobfree>
ffffffffc0201dca:	621c                	ld	a5,0(a2)
ffffffffc0201dcc:	873e                	mv	a4,a5
ffffffffc0201dce:	679c                	ld	a5,8(a5)
ffffffffc0201dd0:	02877a63          	bgeu	a4,s0,ffffffffc0201e04 <slob_free+0x58>
ffffffffc0201dd4:	00f46463          	bltu	s0,a5,ffffffffc0201ddc <slob_free+0x30>
ffffffffc0201dd8:	fef76ae3          	bltu	a4,a5,ffffffffc0201dcc <slob_free+0x20>
ffffffffc0201ddc:	400c                	lw	a1,0(s0)
ffffffffc0201dde:	00459693          	slli	a3,a1,0x4
ffffffffc0201de2:	96a2                	add	a3,a3,s0
ffffffffc0201de4:	02d78a63          	beq	a5,a3,ffffffffc0201e18 <slob_free+0x6c>
ffffffffc0201de8:	4314                	lw	a3,0(a4)
ffffffffc0201dea:	e41c                	sd	a5,8(s0)
ffffffffc0201dec:	00469793          	slli	a5,a3,0x4
ffffffffc0201df0:	97ba                	add	a5,a5,a4
ffffffffc0201df2:	02f40e63          	beq	s0,a5,ffffffffc0201e2e <slob_free+0x82>
ffffffffc0201df6:	e700                	sd	s0,8(a4)
ffffffffc0201df8:	e218                	sd	a4,0(a2)
ffffffffc0201dfa:	e129                	bnez	a0,ffffffffc0201e3c <slob_free+0x90>
ffffffffc0201dfc:	60a2                	ld	ra,8(sp)
ffffffffc0201dfe:	6402                	ld	s0,0(sp)
ffffffffc0201e00:	0141                	addi	sp,sp,16
ffffffffc0201e02:	8082                	ret
ffffffffc0201e04:	fcf764e3          	bltu	a4,a5,ffffffffc0201dcc <slob_free+0x20>
ffffffffc0201e08:	fcf472e3          	bgeu	s0,a5,ffffffffc0201dcc <slob_free+0x20>
ffffffffc0201e0c:	400c                	lw	a1,0(s0)
ffffffffc0201e0e:	00459693          	slli	a3,a1,0x4
ffffffffc0201e12:	96a2                	add	a3,a3,s0
ffffffffc0201e14:	fcd79ae3          	bne	a5,a3,ffffffffc0201de8 <slob_free+0x3c>
ffffffffc0201e18:	4394                	lw	a3,0(a5)
ffffffffc0201e1a:	679c                	ld	a5,8(a5)
ffffffffc0201e1c:	9db5                	addw	a1,a1,a3
ffffffffc0201e1e:	c00c                	sw	a1,0(s0)
ffffffffc0201e20:	4314                	lw	a3,0(a4)
ffffffffc0201e22:	e41c                	sd	a5,8(s0)
ffffffffc0201e24:	00469793          	slli	a5,a3,0x4
ffffffffc0201e28:	97ba                	add	a5,a5,a4
ffffffffc0201e2a:	fcf416e3          	bne	s0,a5,ffffffffc0201df6 <slob_free+0x4a>
ffffffffc0201e2e:	401c                	lw	a5,0(s0)
ffffffffc0201e30:	640c                	ld	a1,8(s0)
ffffffffc0201e32:	e218                	sd	a4,0(a2)
ffffffffc0201e34:	9ebd                	addw	a3,a3,a5
ffffffffc0201e36:	c314                	sw	a3,0(a4)
ffffffffc0201e38:	e70c                	sd	a1,8(a4)
ffffffffc0201e3a:	d169                	beqz	a0,ffffffffc0201dfc <slob_free+0x50>
ffffffffc0201e3c:	6402                	ld	s0,0(sp)
ffffffffc0201e3e:	60a2                	ld	ra,8(sp)
ffffffffc0201e40:	0141                	addi	sp,sp,16
ffffffffc0201e42:	e2bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201e46:	25bd                	addiw	a1,a1,15
ffffffffc0201e48:	8191                	srli	a1,a1,0x4
ffffffffc0201e4a:	c10c                	sw	a1,0(a0)
ffffffffc0201e4c:	100027f3          	csrr	a5,sstatus
ffffffffc0201e50:	8b89                	andi	a5,a5,2
ffffffffc0201e52:	4501                	li	a0,0
ffffffffc0201e54:	d7bd                	beqz	a5,ffffffffc0201dc2 <slob_free+0x16>
ffffffffc0201e56:	e1dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e5a:	4505                	li	a0,1
ffffffffc0201e5c:	b79d                	j	ffffffffc0201dc2 <slob_free+0x16>
ffffffffc0201e5e:	8082                	ret

ffffffffc0201e60 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e60:	4785                	li	a5,1
ffffffffc0201e62:	1141                	addi	sp,sp,-16
ffffffffc0201e64:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e68:	e406                	sd	ra,8(sp)
ffffffffc0201e6a:	352000ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0201e6e:	c91d                	beqz	a0,ffffffffc0201ea4 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e70:	00095697          	auipc	a3,0x95
ffffffffc0201e74:	a386b683          	ld	a3,-1480(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e78:	8d15                	sub	a0,a0,a3
ffffffffc0201e7a:	8519                	srai	a0,a0,0x6
ffffffffc0201e7c:	0000e697          	auipc	a3,0xe
ffffffffc0201e80:	9bc6b683          	ld	a3,-1604(a3) # ffffffffc020f838 <nbase>
ffffffffc0201e84:	9536                	add	a0,a0,a3
ffffffffc0201e86:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e8a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e8c:	00095717          	auipc	a4,0x95
ffffffffc0201e90:	a1473703          	ld	a4,-1516(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e94:	0532                	slli	a0,a0,0xc
ffffffffc0201e96:	00e7fa63          	bgeu	a5,a4,ffffffffc0201eaa <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e9a:	00095697          	auipc	a3,0x95
ffffffffc0201e9e:	a1e6b683          	ld	a3,-1506(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201ea2:	9536                	add	a0,a0,a3
ffffffffc0201ea4:	60a2                	ld	ra,8(sp)
ffffffffc0201ea6:	0141                	addi	sp,sp,16
ffffffffc0201ea8:	8082                	ret
ffffffffc0201eaa:	86aa                	mv	a3,a0
ffffffffc0201eac:	0000a617          	auipc	a2,0xa
ffffffffc0201eb0:	63c60613          	addi	a2,a2,1596 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0201eb4:	07100593          	li	a1,113
ffffffffc0201eb8:	0000a517          	auipc	a0,0xa
ffffffffc0201ebc:	65850513          	addi	a0,a0,1624 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0201ec0:	ddefe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201ec4 <slob_alloc.constprop.0>:
ffffffffc0201ec4:	1101                	addi	sp,sp,-32
ffffffffc0201ec6:	ec06                	sd	ra,24(sp)
ffffffffc0201ec8:	e822                	sd	s0,16(sp)
ffffffffc0201eca:	e426                	sd	s1,8(sp)
ffffffffc0201ecc:	e04a                	sd	s2,0(sp)
ffffffffc0201ece:	01050713          	addi	a4,a0,16
ffffffffc0201ed2:	6785                	lui	a5,0x1
ffffffffc0201ed4:	0cf77363          	bgeu	a4,a5,ffffffffc0201f9a <slob_alloc.constprop.0+0xd6>
ffffffffc0201ed8:	00f50493          	addi	s1,a0,15
ffffffffc0201edc:	8091                	srli	s1,s1,0x4
ffffffffc0201ede:	2481                	sext.w	s1,s1
ffffffffc0201ee0:	10002673          	csrr	a2,sstatus
ffffffffc0201ee4:	8a09                	andi	a2,a2,2
ffffffffc0201ee6:	e25d                	bnez	a2,ffffffffc0201f8c <slob_alloc.constprop.0+0xc8>
ffffffffc0201ee8:	0008f917          	auipc	s2,0x8f
ffffffffc0201eec:	16890913          	addi	s2,s2,360 # ffffffffc0291050 <slobfree>
ffffffffc0201ef0:	00093683          	ld	a3,0(s2)
ffffffffc0201ef4:	669c                	ld	a5,8(a3)
ffffffffc0201ef6:	4398                	lw	a4,0(a5)
ffffffffc0201ef8:	08975e63          	bge	a4,s1,ffffffffc0201f94 <slob_alloc.constprop.0+0xd0>
ffffffffc0201efc:	00f68b63          	beq	a3,a5,ffffffffc0201f12 <slob_alloc.constprop.0+0x4e>
ffffffffc0201f00:	6780                	ld	s0,8(a5)
ffffffffc0201f02:	4018                	lw	a4,0(s0)
ffffffffc0201f04:	02975a63          	bge	a4,s1,ffffffffc0201f38 <slob_alloc.constprop.0+0x74>
ffffffffc0201f08:	00093683          	ld	a3,0(s2)
ffffffffc0201f0c:	87a2                	mv	a5,s0
ffffffffc0201f0e:	fef699e3          	bne	a3,a5,ffffffffc0201f00 <slob_alloc.constprop.0+0x3c>
ffffffffc0201f12:	ee31                	bnez	a2,ffffffffc0201f6e <slob_alloc.constprop.0+0xaa>
ffffffffc0201f14:	4501                	li	a0,0
ffffffffc0201f16:	f4bff0ef          	jal	ra,ffffffffc0201e60 <__slob_get_free_pages.constprop.0>
ffffffffc0201f1a:	842a                	mv	s0,a0
ffffffffc0201f1c:	cd05                	beqz	a0,ffffffffc0201f54 <slob_alloc.constprop.0+0x90>
ffffffffc0201f1e:	6585                	lui	a1,0x1
ffffffffc0201f20:	e8dff0ef          	jal	ra,ffffffffc0201dac <slob_free>
ffffffffc0201f24:	10002673          	csrr	a2,sstatus
ffffffffc0201f28:	8a09                	andi	a2,a2,2
ffffffffc0201f2a:	ee05                	bnez	a2,ffffffffc0201f62 <slob_alloc.constprop.0+0x9e>
ffffffffc0201f2c:	00093783          	ld	a5,0(s2)
ffffffffc0201f30:	6780                	ld	s0,8(a5)
ffffffffc0201f32:	4018                	lw	a4,0(s0)
ffffffffc0201f34:	fc974ae3          	blt	a4,s1,ffffffffc0201f08 <slob_alloc.constprop.0+0x44>
ffffffffc0201f38:	04e48763          	beq	s1,a4,ffffffffc0201f86 <slob_alloc.constprop.0+0xc2>
ffffffffc0201f3c:	00449693          	slli	a3,s1,0x4
ffffffffc0201f40:	96a2                	add	a3,a3,s0
ffffffffc0201f42:	e794                	sd	a3,8(a5)
ffffffffc0201f44:	640c                	ld	a1,8(s0)
ffffffffc0201f46:	9f05                	subw	a4,a4,s1
ffffffffc0201f48:	c298                	sw	a4,0(a3)
ffffffffc0201f4a:	e68c                	sd	a1,8(a3)
ffffffffc0201f4c:	c004                	sw	s1,0(s0)
ffffffffc0201f4e:	00f93023          	sd	a5,0(s2)
ffffffffc0201f52:	e20d                	bnez	a2,ffffffffc0201f74 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f54:	60e2                	ld	ra,24(sp)
ffffffffc0201f56:	8522                	mv	a0,s0
ffffffffc0201f58:	6442                	ld	s0,16(sp)
ffffffffc0201f5a:	64a2                	ld	s1,8(sp)
ffffffffc0201f5c:	6902                	ld	s2,0(sp)
ffffffffc0201f5e:	6105                	addi	sp,sp,32
ffffffffc0201f60:	8082                	ret
ffffffffc0201f62:	d11fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f66:	00093783          	ld	a5,0(s2)
ffffffffc0201f6a:	4605                	li	a2,1
ffffffffc0201f6c:	b7d1                	j	ffffffffc0201f30 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f6e:	cfffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f72:	b74d                	j	ffffffffc0201f14 <slob_alloc.constprop.0+0x50>
ffffffffc0201f74:	cf9fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f78:	60e2                	ld	ra,24(sp)
ffffffffc0201f7a:	8522                	mv	a0,s0
ffffffffc0201f7c:	6442                	ld	s0,16(sp)
ffffffffc0201f7e:	64a2                	ld	s1,8(sp)
ffffffffc0201f80:	6902                	ld	s2,0(sp)
ffffffffc0201f82:	6105                	addi	sp,sp,32
ffffffffc0201f84:	8082                	ret
ffffffffc0201f86:	6418                	ld	a4,8(s0)
ffffffffc0201f88:	e798                	sd	a4,8(a5)
ffffffffc0201f8a:	b7d1                	j	ffffffffc0201f4e <slob_alloc.constprop.0+0x8a>
ffffffffc0201f8c:	ce7fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f90:	4605                	li	a2,1
ffffffffc0201f92:	bf99                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x24>
ffffffffc0201f94:	843e                	mv	s0,a5
ffffffffc0201f96:	87b6                	mv	a5,a3
ffffffffc0201f98:	b745                	j	ffffffffc0201f38 <slob_alloc.constprop.0+0x74>
ffffffffc0201f9a:	0000a697          	auipc	a3,0xa
ffffffffc0201f9e:	58668693          	addi	a3,a3,1414 # ffffffffc020c520 <default_pmm_manager+0x70>
ffffffffc0201fa2:	0000a617          	auipc	a2,0xa
ffffffffc0201fa6:	a0660613          	addi	a2,a2,-1530 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0201faa:	06300593          	li	a1,99
ffffffffc0201fae:	0000a517          	auipc	a0,0xa
ffffffffc0201fb2:	59250513          	addi	a0,a0,1426 # ffffffffc020c540 <default_pmm_manager+0x90>
ffffffffc0201fb6:	ce8fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201fba <kmalloc_init>:
ffffffffc0201fba:	1141                	addi	sp,sp,-16
ffffffffc0201fbc:	0000a517          	auipc	a0,0xa
ffffffffc0201fc0:	59c50513          	addi	a0,a0,1436 # ffffffffc020c558 <default_pmm_manager+0xa8>
ffffffffc0201fc4:	e406                	sd	ra,8(sp)
ffffffffc0201fc6:	9e0fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201fca:	60a2                	ld	ra,8(sp)
ffffffffc0201fcc:	0000a517          	auipc	a0,0xa
ffffffffc0201fd0:	5a450513          	addi	a0,a0,1444 # ffffffffc020c570 <default_pmm_manager+0xc0>
ffffffffc0201fd4:	0141                	addi	sp,sp,16
ffffffffc0201fd6:	9d0fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201fda <kallocated>:
ffffffffc0201fda:	4501                	li	a0,0
ffffffffc0201fdc:	8082                	ret

ffffffffc0201fde <kmalloc>:
ffffffffc0201fde:	1101                	addi	sp,sp,-32
ffffffffc0201fe0:	e04a                	sd	s2,0(sp)
ffffffffc0201fe2:	6905                	lui	s2,0x1
ffffffffc0201fe4:	e822                	sd	s0,16(sp)
ffffffffc0201fe6:	ec06                	sd	ra,24(sp)
ffffffffc0201fe8:	e426                	sd	s1,8(sp)
ffffffffc0201fea:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201fee:	842a                	mv	s0,a0
ffffffffc0201ff0:	04a7f963          	bgeu	a5,a0,ffffffffc0202042 <kmalloc+0x64>
ffffffffc0201ff4:	4561                	li	a0,24
ffffffffc0201ff6:	ecfff0ef          	jal	ra,ffffffffc0201ec4 <slob_alloc.constprop.0>
ffffffffc0201ffa:	84aa                	mv	s1,a0
ffffffffc0201ffc:	c929                	beqz	a0,ffffffffc020204e <kmalloc+0x70>
ffffffffc0201ffe:	0004079b          	sext.w	a5,s0
ffffffffc0202002:	4501                	li	a0,0
ffffffffc0202004:	00f95763          	bge	s2,a5,ffffffffc0202012 <kmalloc+0x34>
ffffffffc0202008:	6705                	lui	a4,0x1
ffffffffc020200a:	8785                	srai	a5,a5,0x1
ffffffffc020200c:	2505                	addiw	a0,a0,1
ffffffffc020200e:	fef74ee3          	blt	a4,a5,ffffffffc020200a <kmalloc+0x2c>
ffffffffc0202012:	c088                	sw	a0,0(s1)
ffffffffc0202014:	e4dff0ef          	jal	ra,ffffffffc0201e60 <__slob_get_free_pages.constprop.0>
ffffffffc0202018:	e488                	sd	a0,8(s1)
ffffffffc020201a:	842a                	mv	s0,a0
ffffffffc020201c:	c525                	beqz	a0,ffffffffc0202084 <kmalloc+0xa6>
ffffffffc020201e:	100027f3          	csrr	a5,sstatus
ffffffffc0202022:	8b89                	andi	a5,a5,2
ffffffffc0202024:	ef8d                	bnez	a5,ffffffffc020205e <kmalloc+0x80>
ffffffffc0202026:	00095797          	auipc	a5,0x95
ffffffffc020202a:	86278793          	addi	a5,a5,-1950 # ffffffffc0296888 <bigblocks>
ffffffffc020202e:	6398                	ld	a4,0(a5)
ffffffffc0202030:	e384                	sd	s1,0(a5)
ffffffffc0202032:	e898                	sd	a4,16(s1)
ffffffffc0202034:	60e2                	ld	ra,24(sp)
ffffffffc0202036:	8522                	mv	a0,s0
ffffffffc0202038:	6442                	ld	s0,16(sp)
ffffffffc020203a:	64a2                	ld	s1,8(sp)
ffffffffc020203c:	6902                	ld	s2,0(sp)
ffffffffc020203e:	6105                	addi	sp,sp,32
ffffffffc0202040:	8082                	ret
ffffffffc0202042:	0541                	addi	a0,a0,16
ffffffffc0202044:	e81ff0ef          	jal	ra,ffffffffc0201ec4 <slob_alloc.constprop.0>
ffffffffc0202048:	01050413          	addi	s0,a0,16
ffffffffc020204c:	f565                	bnez	a0,ffffffffc0202034 <kmalloc+0x56>
ffffffffc020204e:	4401                	li	s0,0
ffffffffc0202050:	60e2                	ld	ra,24(sp)
ffffffffc0202052:	8522                	mv	a0,s0
ffffffffc0202054:	6442                	ld	s0,16(sp)
ffffffffc0202056:	64a2                	ld	s1,8(sp)
ffffffffc0202058:	6902                	ld	s2,0(sp)
ffffffffc020205a:	6105                	addi	sp,sp,32
ffffffffc020205c:	8082                	ret
ffffffffc020205e:	c15fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202062:	00095797          	auipc	a5,0x95
ffffffffc0202066:	82678793          	addi	a5,a5,-2010 # ffffffffc0296888 <bigblocks>
ffffffffc020206a:	6398                	ld	a4,0(a5)
ffffffffc020206c:	e384                	sd	s1,0(a5)
ffffffffc020206e:	e898                	sd	a4,16(s1)
ffffffffc0202070:	bfdfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202074:	6480                	ld	s0,8(s1)
ffffffffc0202076:	60e2                	ld	ra,24(sp)
ffffffffc0202078:	64a2                	ld	s1,8(sp)
ffffffffc020207a:	8522                	mv	a0,s0
ffffffffc020207c:	6442                	ld	s0,16(sp)
ffffffffc020207e:	6902                	ld	s2,0(sp)
ffffffffc0202080:	6105                	addi	sp,sp,32
ffffffffc0202082:	8082                	ret
ffffffffc0202084:	45e1                	li	a1,24
ffffffffc0202086:	8526                	mv	a0,s1
ffffffffc0202088:	d25ff0ef          	jal	ra,ffffffffc0201dac <slob_free>
ffffffffc020208c:	b765                	j	ffffffffc0202034 <kmalloc+0x56>

ffffffffc020208e <kfree>:
ffffffffc020208e:	c169                	beqz	a0,ffffffffc0202150 <kfree+0xc2>
ffffffffc0202090:	1101                	addi	sp,sp,-32
ffffffffc0202092:	e822                	sd	s0,16(sp)
ffffffffc0202094:	ec06                	sd	ra,24(sp)
ffffffffc0202096:	e426                	sd	s1,8(sp)
ffffffffc0202098:	03451793          	slli	a5,a0,0x34
ffffffffc020209c:	842a                	mv	s0,a0
ffffffffc020209e:	e3d9                	bnez	a5,ffffffffc0202124 <kfree+0x96>
ffffffffc02020a0:	100027f3          	csrr	a5,sstatus
ffffffffc02020a4:	8b89                	andi	a5,a5,2
ffffffffc02020a6:	e7d9                	bnez	a5,ffffffffc0202134 <kfree+0xa6>
ffffffffc02020a8:	00094797          	auipc	a5,0x94
ffffffffc02020ac:	7e07b783          	ld	a5,2016(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020b0:	4601                	li	a2,0
ffffffffc02020b2:	cbad                	beqz	a5,ffffffffc0202124 <kfree+0x96>
ffffffffc02020b4:	00094697          	auipc	a3,0x94
ffffffffc02020b8:	7d468693          	addi	a3,a3,2004 # ffffffffc0296888 <bigblocks>
ffffffffc02020bc:	a021                	j	ffffffffc02020c4 <kfree+0x36>
ffffffffc02020be:	01048693          	addi	a3,s1,16
ffffffffc02020c2:	c3a5                	beqz	a5,ffffffffc0202122 <kfree+0x94>
ffffffffc02020c4:	6798                	ld	a4,8(a5)
ffffffffc02020c6:	84be                	mv	s1,a5
ffffffffc02020c8:	6b9c                	ld	a5,16(a5)
ffffffffc02020ca:	fe871ae3          	bne	a4,s0,ffffffffc02020be <kfree+0x30>
ffffffffc02020ce:	e29c                	sd	a5,0(a3)
ffffffffc02020d0:	ee2d                	bnez	a2,ffffffffc020214a <kfree+0xbc>
ffffffffc02020d2:	c02007b7          	lui	a5,0xc0200
ffffffffc02020d6:	4098                	lw	a4,0(s1)
ffffffffc02020d8:	08f46963          	bltu	s0,a5,ffffffffc020216a <kfree+0xdc>
ffffffffc02020dc:	00094697          	auipc	a3,0x94
ffffffffc02020e0:	7dc6b683          	ld	a3,2012(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02020e4:	8c15                	sub	s0,s0,a3
ffffffffc02020e6:	8031                	srli	s0,s0,0xc
ffffffffc02020e8:	00094797          	auipc	a5,0x94
ffffffffc02020ec:	7b87b783          	ld	a5,1976(a5) # ffffffffc02968a0 <npage>
ffffffffc02020f0:	06f47163          	bgeu	s0,a5,ffffffffc0202152 <kfree+0xc4>
ffffffffc02020f4:	0000d517          	auipc	a0,0xd
ffffffffc02020f8:	74453503          	ld	a0,1860(a0) # ffffffffc020f838 <nbase>
ffffffffc02020fc:	8c09                	sub	s0,s0,a0
ffffffffc02020fe:	041a                	slli	s0,s0,0x6
ffffffffc0202100:	00094517          	auipc	a0,0x94
ffffffffc0202104:	7a853503          	ld	a0,1960(a0) # ffffffffc02968a8 <pages>
ffffffffc0202108:	4585                	li	a1,1
ffffffffc020210a:	9522                	add	a0,a0,s0
ffffffffc020210c:	00e595bb          	sllw	a1,a1,a4
ffffffffc0202110:	0ea000ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0202114:	6442                	ld	s0,16(sp)
ffffffffc0202116:	60e2                	ld	ra,24(sp)
ffffffffc0202118:	8526                	mv	a0,s1
ffffffffc020211a:	64a2                	ld	s1,8(sp)
ffffffffc020211c:	45e1                	li	a1,24
ffffffffc020211e:	6105                	addi	sp,sp,32
ffffffffc0202120:	b171                	j	ffffffffc0201dac <slob_free>
ffffffffc0202122:	e20d                	bnez	a2,ffffffffc0202144 <kfree+0xb6>
ffffffffc0202124:	ff040513          	addi	a0,s0,-16
ffffffffc0202128:	6442                	ld	s0,16(sp)
ffffffffc020212a:	60e2                	ld	ra,24(sp)
ffffffffc020212c:	64a2                	ld	s1,8(sp)
ffffffffc020212e:	4581                	li	a1,0
ffffffffc0202130:	6105                	addi	sp,sp,32
ffffffffc0202132:	b9ad                	j	ffffffffc0201dac <slob_free>
ffffffffc0202134:	b3ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202138:	00094797          	auipc	a5,0x94
ffffffffc020213c:	7507b783          	ld	a5,1872(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202140:	4605                	li	a2,1
ffffffffc0202142:	fbad                	bnez	a5,ffffffffc02020b4 <kfree+0x26>
ffffffffc0202144:	b29fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202148:	bff1                	j	ffffffffc0202124 <kfree+0x96>
ffffffffc020214a:	b23fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020214e:	b751                	j	ffffffffc02020d2 <kfree+0x44>
ffffffffc0202150:	8082                	ret
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	46660613          	addi	a2,a2,1126 # ffffffffc020c5b8 <default_pmm_manager+0x108>
ffffffffc020215a:	06900593          	li	a1,105
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	3b250513          	addi	a0,a0,946 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0202166:	b38fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020216a:	86a2                	mv	a3,s0
ffffffffc020216c:	0000a617          	auipc	a2,0xa
ffffffffc0202170:	42460613          	addi	a2,a2,1060 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc0202174:	07700593          	li	a1,119
ffffffffc0202178:	0000a517          	auipc	a0,0xa
ffffffffc020217c:	39850513          	addi	a0,a0,920 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0202180:	b1efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202184 <pa2page.part.0>:
ffffffffc0202184:	1141                	addi	sp,sp,-16
ffffffffc0202186:	0000a617          	auipc	a2,0xa
ffffffffc020218a:	43260613          	addi	a2,a2,1074 # ffffffffc020c5b8 <default_pmm_manager+0x108>
ffffffffc020218e:	06900593          	li	a1,105
ffffffffc0202192:	0000a517          	auipc	a0,0xa
ffffffffc0202196:	37e50513          	addi	a0,a0,894 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc020219a:	e406                	sd	ra,8(sp)
ffffffffc020219c:	b02fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02021a0 <pte2page.part.0>:
ffffffffc02021a0:	1141                	addi	sp,sp,-16
ffffffffc02021a2:	0000a617          	auipc	a2,0xa
ffffffffc02021a6:	43660613          	addi	a2,a2,1078 # ffffffffc020c5d8 <default_pmm_manager+0x128>
ffffffffc02021aa:	07f00593          	li	a1,127
ffffffffc02021ae:	0000a517          	auipc	a0,0xa
ffffffffc02021b2:	36250513          	addi	a0,a0,866 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc02021b6:	e406                	sd	ra,8(sp)
ffffffffc02021b8:	ae6fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02021bc <alloc_pages>:
ffffffffc02021bc:	100027f3          	csrr	a5,sstatus
ffffffffc02021c0:	8b89                	andi	a5,a5,2
ffffffffc02021c2:	e799                	bnez	a5,ffffffffc02021d0 <alloc_pages+0x14>
ffffffffc02021c4:	00094797          	auipc	a5,0x94
ffffffffc02021c8:	6ec7b783          	ld	a5,1772(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021cc:	6f9c                	ld	a5,24(a5)
ffffffffc02021ce:	8782                	jr	a5
ffffffffc02021d0:	1141                	addi	sp,sp,-16
ffffffffc02021d2:	e406                	sd	ra,8(sp)
ffffffffc02021d4:	e022                	sd	s0,0(sp)
ffffffffc02021d6:	842a                	mv	s0,a0
ffffffffc02021d8:	a9bfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021dc:	00094797          	auipc	a5,0x94
ffffffffc02021e0:	6d47b783          	ld	a5,1748(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021e4:	6f9c                	ld	a5,24(a5)
ffffffffc02021e6:	8522                	mv	a0,s0
ffffffffc02021e8:	9782                	jalr	a5
ffffffffc02021ea:	842a                	mv	s0,a0
ffffffffc02021ec:	a81fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021f0:	60a2                	ld	ra,8(sp)
ffffffffc02021f2:	8522                	mv	a0,s0
ffffffffc02021f4:	6402                	ld	s0,0(sp)
ffffffffc02021f6:	0141                	addi	sp,sp,16
ffffffffc02021f8:	8082                	ret

ffffffffc02021fa <free_pages>:
ffffffffc02021fa:	100027f3          	csrr	a5,sstatus
ffffffffc02021fe:	8b89                	andi	a5,a5,2
ffffffffc0202200:	e799                	bnez	a5,ffffffffc020220e <free_pages+0x14>
ffffffffc0202202:	00094797          	auipc	a5,0x94
ffffffffc0202206:	6ae7b783          	ld	a5,1710(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020220a:	739c                	ld	a5,32(a5)
ffffffffc020220c:	8782                	jr	a5
ffffffffc020220e:	1101                	addi	sp,sp,-32
ffffffffc0202210:	ec06                	sd	ra,24(sp)
ffffffffc0202212:	e822                	sd	s0,16(sp)
ffffffffc0202214:	e426                	sd	s1,8(sp)
ffffffffc0202216:	842a                	mv	s0,a0
ffffffffc0202218:	84ae                	mv	s1,a1
ffffffffc020221a:	a59fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020221e:	00094797          	auipc	a5,0x94
ffffffffc0202222:	6927b783          	ld	a5,1682(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202226:	739c                	ld	a5,32(a5)
ffffffffc0202228:	85a6                	mv	a1,s1
ffffffffc020222a:	8522                	mv	a0,s0
ffffffffc020222c:	9782                	jalr	a5
ffffffffc020222e:	6442                	ld	s0,16(sp)
ffffffffc0202230:	60e2                	ld	ra,24(sp)
ffffffffc0202232:	64a2                	ld	s1,8(sp)
ffffffffc0202234:	6105                	addi	sp,sp,32
ffffffffc0202236:	a37fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc020223a <nr_free_pages>:
ffffffffc020223a:	100027f3          	csrr	a5,sstatus
ffffffffc020223e:	8b89                	andi	a5,a5,2
ffffffffc0202240:	e799                	bnez	a5,ffffffffc020224e <nr_free_pages+0x14>
ffffffffc0202242:	00094797          	auipc	a5,0x94
ffffffffc0202246:	66e7b783          	ld	a5,1646(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020224a:	779c                	ld	a5,40(a5)
ffffffffc020224c:	8782                	jr	a5
ffffffffc020224e:	1141                	addi	sp,sp,-16
ffffffffc0202250:	e406                	sd	ra,8(sp)
ffffffffc0202252:	e022                	sd	s0,0(sp)
ffffffffc0202254:	a1ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202258:	00094797          	auipc	a5,0x94
ffffffffc020225c:	6587b783          	ld	a5,1624(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202260:	779c                	ld	a5,40(a5)
ffffffffc0202262:	9782                	jalr	a5
ffffffffc0202264:	842a                	mv	s0,a0
ffffffffc0202266:	a07fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020226a:	60a2                	ld	ra,8(sp)
ffffffffc020226c:	8522                	mv	a0,s0
ffffffffc020226e:	6402                	ld	s0,0(sp)
ffffffffc0202270:	0141                	addi	sp,sp,16
ffffffffc0202272:	8082                	ret

ffffffffc0202274 <get_pte>:
ffffffffc0202274:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202278:	1ff7f793          	andi	a5,a5,511
ffffffffc020227c:	7139                	addi	sp,sp,-64
ffffffffc020227e:	078e                	slli	a5,a5,0x3
ffffffffc0202280:	f426                	sd	s1,40(sp)
ffffffffc0202282:	00f504b3          	add	s1,a0,a5
ffffffffc0202286:	6094                	ld	a3,0(s1)
ffffffffc0202288:	f04a                	sd	s2,32(sp)
ffffffffc020228a:	ec4e                	sd	s3,24(sp)
ffffffffc020228c:	e852                	sd	s4,16(sp)
ffffffffc020228e:	fc06                	sd	ra,56(sp)
ffffffffc0202290:	f822                	sd	s0,48(sp)
ffffffffc0202292:	e456                	sd	s5,8(sp)
ffffffffc0202294:	e05a                	sd	s6,0(sp)
ffffffffc0202296:	0016f793          	andi	a5,a3,1
ffffffffc020229a:	892e                	mv	s2,a1
ffffffffc020229c:	8a32                	mv	s4,a2
ffffffffc020229e:	00094997          	auipc	s3,0x94
ffffffffc02022a2:	60298993          	addi	s3,s3,1538 # ffffffffc02968a0 <npage>
ffffffffc02022a6:	efbd                	bnez	a5,ffffffffc0202324 <get_pte+0xb0>
ffffffffc02022a8:	14060c63          	beqz	a2,ffffffffc0202400 <get_pte+0x18c>
ffffffffc02022ac:	100027f3          	csrr	a5,sstatus
ffffffffc02022b0:	8b89                	andi	a5,a5,2
ffffffffc02022b2:	14079963          	bnez	a5,ffffffffc0202404 <get_pte+0x190>
ffffffffc02022b6:	00094797          	auipc	a5,0x94
ffffffffc02022ba:	5fa7b783          	ld	a5,1530(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02022be:	6f9c                	ld	a5,24(a5)
ffffffffc02022c0:	4505                	li	a0,1
ffffffffc02022c2:	9782                	jalr	a5
ffffffffc02022c4:	842a                	mv	s0,a0
ffffffffc02022c6:	12040d63          	beqz	s0,ffffffffc0202400 <get_pte+0x18c>
ffffffffc02022ca:	00094b17          	auipc	s6,0x94
ffffffffc02022ce:	5deb0b13          	addi	s6,s6,1502 # ffffffffc02968a8 <pages>
ffffffffc02022d2:	000b3503          	ld	a0,0(s6)
ffffffffc02022d6:	00080ab7          	lui	s5,0x80
ffffffffc02022da:	00094997          	auipc	s3,0x94
ffffffffc02022de:	5c698993          	addi	s3,s3,1478 # ffffffffc02968a0 <npage>
ffffffffc02022e2:	40a40533          	sub	a0,s0,a0
ffffffffc02022e6:	8519                	srai	a0,a0,0x6
ffffffffc02022e8:	9556                	add	a0,a0,s5
ffffffffc02022ea:	0009b703          	ld	a4,0(s3)
ffffffffc02022ee:	00c51793          	slli	a5,a0,0xc
ffffffffc02022f2:	4685                	li	a3,1
ffffffffc02022f4:	c014                	sw	a3,0(s0)
ffffffffc02022f6:	83b1                	srli	a5,a5,0xc
ffffffffc02022f8:	0532                	slli	a0,a0,0xc
ffffffffc02022fa:	16e7f763          	bgeu	a5,a4,ffffffffc0202468 <get_pte+0x1f4>
ffffffffc02022fe:	00094797          	auipc	a5,0x94
ffffffffc0202302:	5ba7b783          	ld	a5,1466(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202306:	6605                	lui	a2,0x1
ffffffffc0202308:	4581                	li	a1,0
ffffffffc020230a:	953e                	add	a0,a0,a5
ffffffffc020230c:	1b8090ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0202310:	000b3683          	ld	a3,0(s6)
ffffffffc0202314:	40d406b3          	sub	a3,s0,a3
ffffffffc0202318:	8699                	srai	a3,a3,0x6
ffffffffc020231a:	96d6                	add	a3,a3,s5
ffffffffc020231c:	06aa                	slli	a3,a3,0xa
ffffffffc020231e:	0116e693          	ori	a3,a3,17
ffffffffc0202322:	e094                	sd	a3,0(s1)
ffffffffc0202324:	77fd                	lui	a5,0xfffff
ffffffffc0202326:	068a                	slli	a3,a3,0x2
ffffffffc0202328:	0009b703          	ld	a4,0(s3)
ffffffffc020232c:	8efd                	and	a3,a3,a5
ffffffffc020232e:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202332:	10e7ff63          	bgeu	a5,a4,ffffffffc0202450 <get_pte+0x1dc>
ffffffffc0202336:	00094a97          	auipc	s5,0x94
ffffffffc020233a:	582a8a93          	addi	s5,s5,1410 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020233e:	000ab403          	ld	s0,0(s5)
ffffffffc0202342:	01595793          	srli	a5,s2,0x15
ffffffffc0202346:	1ff7f793          	andi	a5,a5,511
ffffffffc020234a:	96a2                	add	a3,a3,s0
ffffffffc020234c:	00379413          	slli	s0,a5,0x3
ffffffffc0202350:	9436                	add	s0,s0,a3
ffffffffc0202352:	6014                	ld	a3,0(s0)
ffffffffc0202354:	0016f793          	andi	a5,a3,1
ffffffffc0202358:	ebad                	bnez	a5,ffffffffc02023ca <get_pte+0x156>
ffffffffc020235a:	0a0a0363          	beqz	s4,ffffffffc0202400 <get_pte+0x18c>
ffffffffc020235e:	100027f3          	csrr	a5,sstatus
ffffffffc0202362:	8b89                	andi	a5,a5,2
ffffffffc0202364:	efcd                	bnez	a5,ffffffffc020241e <get_pte+0x1aa>
ffffffffc0202366:	00094797          	auipc	a5,0x94
ffffffffc020236a:	54a7b783          	ld	a5,1354(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020236e:	6f9c                	ld	a5,24(a5)
ffffffffc0202370:	4505                	li	a0,1
ffffffffc0202372:	9782                	jalr	a5
ffffffffc0202374:	84aa                	mv	s1,a0
ffffffffc0202376:	c4c9                	beqz	s1,ffffffffc0202400 <get_pte+0x18c>
ffffffffc0202378:	00094b17          	auipc	s6,0x94
ffffffffc020237c:	530b0b13          	addi	s6,s6,1328 # ffffffffc02968a8 <pages>
ffffffffc0202380:	000b3503          	ld	a0,0(s6)
ffffffffc0202384:	00080a37          	lui	s4,0x80
ffffffffc0202388:	0009b703          	ld	a4,0(s3)
ffffffffc020238c:	40a48533          	sub	a0,s1,a0
ffffffffc0202390:	8519                	srai	a0,a0,0x6
ffffffffc0202392:	9552                	add	a0,a0,s4
ffffffffc0202394:	00c51793          	slli	a5,a0,0xc
ffffffffc0202398:	4685                	li	a3,1
ffffffffc020239a:	c094                	sw	a3,0(s1)
ffffffffc020239c:	83b1                	srli	a5,a5,0xc
ffffffffc020239e:	0532                	slli	a0,a0,0xc
ffffffffc02023a0:	0ee7f163          	bgeu	a5,a4,ffffffffc0202482 <get_pte+0x20e>
ffffffffc02023a4:	000ab783          	ld	a5,0(s5)
ffffffffc02023a8:	6605                	lui	a2,0x1
ffffffffc02023aa:	4581                	li	a1,0
ffffffffc02023ac:	953e                	add	a0,a0,a5
ffffffffc02023ae:	116090ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc02023b2:	000b3683          	ld	a3,0(s6)
ffffffffc02023b6:	40d486b3          	sub	a3,s1,a3
ffffffffc02023ba:	8699                	srai	a3,a3,0x6
ffffffffc02023bc:	96d2                	add	a3,a3,s4
ffffffffc02023be:	06aa                	slli	a3,a3,0xa
ffffffffc02023c0:	0116e693          	ori	a3,a3,17
ffffffffc02023c4:	e014                	sd	a3,0(s0)
ffffffffc02023c6:	0009b703          	ld	a4,0(s3)
ffffffffc02023ca:	068a                	slli	a3,a3,0x2
ffffffffc02023cc:	757d                	lui	a0,0xfffff
ffffffffc02023ce:	8ee9                	and	a3,a3,a0
ffffffffc02023d0:	00c6d793          	srli	a5,a3,0xc
ffffffffc02023d4:	06e7f263          	bgeu	a5,a4,ffffffffc0202438 <get_pte+0x1c4>
ffffffffc02023d8:	000ab503          	ld	a0,0(s5)
ffffffffc02023dc:	00c95913          	srli	s2,s2,0xc
ffffffffc02023e0:	1ff97913          	andi	s2,s2,511
ffffffffc02023e4:	96aa                	add	a3,a3,a0
ffffffffc02023e6:	00391513          	slli	a0,s2,0x3
ffffffffc02023ea:	9536                	add	a0,a0,a3
ffffffffc02023ec:	70e2                	ld	ra,56(sp)
ffffffffc02023ee:	7442                	ld	s0,48(sp)
ffffffffc02023f0:	74a2                	ld	s1,40(sp)
ffffffffc02023f2:	7902                	ld	s2,32(sp)
ffffffffc02023f4:	69e2                	ld	s3,24(sp)
ffffffffc02023f6:	6a42                	ld	s4,16(sp)
ffffffffc02023f8:	6aa2                	ld	s5,8(sp)
ffffffffc02023fa:	6b02                	ld	s6,0(sp)
ffffffffc02023fc:	6121                	addi	sp,sp,64
ffffffffc02023fe:	8082                	ret
ffffffffc0202400:	4501                	li	a0,0
ffffffffc0202402:	b7ed                	j	ffffffffc02023ec <get_pte+0x178>
ffffffffc0202404:	86ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202408:	00094797          	auipc	a5,0x94
ffffffffc020240c:	4a87b783          	ld	a5,1192(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202410:	6f9c                	ld	a5,24(a5)
ffffffffc0202412:	4505                	li	a0,1
ffffffffc0202414:	9782                	jalr	a5
ffffffffc0202416:	842a                	mv	s0,a0
ffffffffc0202418:	855fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020241c:	b56d                	j	ffffffffc02022c6 <get_pte+0x52>
ffffffffc020241e:	855fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202422:	00094797          	auipc	a5,0x94
ffffffffc0202426:	48e7b783          	ld	a5,1166(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020242a:	6f9c                	ld	a5,24(a5)
ffffffffc020242c:	4505                	li	a0,1
ffffffffc020242e:	9782                	jalr	a5
ffffffffc0202430:	84aa                	mv	s1,a0
ffffffffc0202432:	83bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202436:	b781                	j	ffffffffc0202376 <get_pte+0x102>
ffffffffc0202438:	0000a617          	auipc	a2,0xa
ffffffffc020243c:	0b060613          	addi	a2,a2,176 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0202440:	13200593          	li	a1,306
ffffffffc0202444:	0000a517          	auipc	a0,0xa
ffffffffc0202448:	1bc50513          	addi	a0,a0,444 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020244c:	852fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202450:	0000a617          	auipc	a2,0xa
ffffffffc0202454:	09860613          	addi	a2,a2,152 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0202458:	12500593          	li	a1,293
ffffffffc020245c:	0000a517          	auipc	a0,0xa
ffffffffc0202460:	1a450513          	addi	a0,a0,420 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0202464:	83afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202468:	86aa                	mv	a3,a0
ffffffffc020246a:	0000a617          	auipc	a2,0xa
ffffffffc020246e:	07e60613          	addi	a2,a2,126 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0202472:	12100593          	li	a1,289
ffffffffc0202476:	0000a517          	auipc	a0,0xa
ffffffffc020247a:	18a50513          	addi	a0,a0,394 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020247e:	820fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202482:	86aa                	mv	a3,a0
ffffffffc0202484:	0000a617          	auipc	a2,0xa
ffffffffc0202488:	06460613          	addi	a2,a2,100 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc020248c:	12f00593          	li	a1,303
ffffffffc0202490:	0000a517          	auipc	a0,0xa
ffffffffc0202494:	17050513          	addi	a0,a0,368 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0202498:	806fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020249c <boot_map_segment>:
ffffffffc020249c:	6785                	lui	a5,0x1
ffffffffc020249e:	7139                	addi	sp,sp,-64
ffffffffc02024a0:	00d5c833          	xor	a6,a1,a3
ffffffffc02024a4:	17fd                	addi	a5,a5,-1
ffffffffc02024a6:	fc06                	sd	ra,56(sp)
ffffffffc02024a8:	f822                	sd	s0,48(sp)
ffffffffc02024aa:	f426                	sd	s1,40(sp)
ffffffffc02024ac:	f04a                	sd	s2,32(sp)
ffffffffc02024ae:	ec4e                	sd	s3,24(sp)
ffffffffc02024b0:	e852                	sd	s4,16(sp)
ffffffffc02024b2:	e456                	sd	s5,8(sp)
ffffffffc02024b4:	00f87833          	and	a6,a6,a5
ffffffffc02024b8:	08081563          	bnez	a6,ffffffffc0202542 <boot_map_segment+0xa6>
ffffffffc02024bc:	00f5f4b3          	and	s1,a1,a5
ffffffffc02024c0:	963e                	add	a2,a2,a5
ffffffffc02024c2:	94b2                	add	s1,s1,a2
ffffffffc02024c4:	797d                	lui	s2,0xfffff
ffffffffc02024c6:	80b1                	srli	s1,s1,0xc
ffffffffc02024c8:	0125f5b3          	and	a1,a1,s2
ffffffffc02024cc:	0126f6b3          	and	a3,a3,s2
ffffffffc02024d0:	c0a1                	beqz	s1,ffffffffc0202510 <boot_map_segment+0x74>
ffffffffc02024d2:	00176713          	ori	a4,a4,1
ffffffffc02024d6:	04b2                	slli	s1,s1,0xc
ffffffffc02024d8:	02071993          	slli	s3,a4,0x20
ffffffffc02024dc:	8a2a                	mv	s4,a0
ffffffffc02024de:	842e                	mv	s0,a1
ffffffffc02024e0:	94ae                	add	s1,s1,a1
ffffffffc02024e2:	40b68933          	sub	s2,a3,a1
ffffffffc02024e6:	0209d993          	srli	s3,s3,0x20
ffffffffc02024ea:	6a85                	lui	s5,0x1
ffffffffc02024ec:	4605                	li	a2,1
ffffffffc02024ee:	85a2                	mv	a1,s0
ffffffffc02024f0:	8552                	mv	a0,s4
ffffffffc02024f2:	d83ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc02024f6:	008907b3          	add	a5,s2,s0
ffffffffc02024fa:	c505                	beqz	a0,ffffffffc0202522 <boot_map_segment+0x86>
ffffffffc02024fc:	83b1                	srli	a5,a5,0xc
ffffffffc02024fe:	07aa                	slli	a5,a5,0xa
ffffffffc0202500:	0137e7b3          	or	a5,a5,s3
ffffffffc0202504:	0017e793          	ori	a5,a5,1
ffffffffc0202508:	e11c                	sd	a5,0(a0)
ffffffffc020250a:	9456                	add	s0,s0,s5
ffffffffc020250c:	fe8490e3          	bne	s1,s0,ffffffffc02024ec <boot_map_segment+0x50>
ffffffffc0202510:	70e2                	ld	ra,56(sp)
ffffffffc0202512:	7442                	ld	s0,48(sp)
ffffffffc0202514:	74a2                	ld	s1,40(sp)
ffffffffc0202516:	7902                	ld	s2,32(sp)
ffffffffc0202518:	69e2                	ld	s3,24(sp)
ffffffffc020251a:	6a42                	ld	s4,16(sp)
ffffffffc020251c:	6aa2                	ld	s5,8(sp)
ffffffffc020251e:	6121                	addi	sp,sp,64
ffffffffc0202520:	8082                	ret
ffffffffc0202522:	0000a697          	auipc	a3,0xa
ffffffffc0202526:	10668693          	addi	a3,a3,262 # ffffffffc020c628 <default_pmm_manager+0x178>
ffffffffc020252a:	00009617          	auipc	a2,0x9
ffffffffc020252e:	47e60613          	addi	a2,a2,1150 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0202532:	09c00593          	li	a1,156
ffffffffc0202536:	0000a517          	auipc	a0,0xa
ffffffffc020253a:	0ca50513          	addi	a0,a0,202 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020253e:	f61fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202542:	0000a697          	auipc	a3,0xa
ffffffffc0202546:	0ce68693          	addi	a3,a3,206 # ffffffffc020c610 <default_pmm_manager+0x160>
ffffffffc020254a:	00009617          	auipc	a2,0x9
ffffffffc020254e:	45e60613          	addi	a2,a2,1118 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0202552:	09500593          	li	a1,149
ffffffffc0202556:	0000a517          	auipc	a0,0xa
ffffffffc020255a:	0aa50513          	addi	a0,a0,170 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020255e:	f41fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202562 <get_page>:
ffffffffc0202562:	1141                	addi	sp,sp,-16
ffffffffc0202564:	e022                	sd	s0,0(sp)
ffffffffc0202566:	8432                	mv	s0,a2
ffffffffc0202568:	4601                	li	a2,0
ffffffffc020256a:	e406                	sd	ra,8(sp)
ffffffffc020256c:	d09ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202570:	c011                	beqz	s0,ffffffffc0202574 <get_page+0x12>
ffffffffc0202572:	e008                	sd	a0,0(s0)
ffffffffc0202574:	c511                	beqz	a0,ffffffffc0202580 <get_page+0x1e>
ffffffffc0202576:	611c                	ld	a5,0(a0)
ffffffffc0202578:	4501                	li	a0,0
ffffffffc020257a:	0017f713          	andi	a4,a5,1
ffffffffc020257e:	e709                	bnez	a4,ffffffffc0202588 <get_page+0x26>
ffffffffc0202580:	60a2                	ld	ra,8(sp)
ffffffffc0202582:	6402                	ld	s0,0(sp)
ffffffffc0202584:	0141                	addi	sp,sp,16
ffffffffc0202586:	8082                	ret
ffffffffc0202588:	078a                	slli	a5,a5,0x2
ffffffffc020258a:	83b1                	srli	a5,a5,0xc
ffffffffc020258c:	00094717          	auipc	a4,0x94
ffffffffc0202590:	31473703          	ld	a4,788(a4) # ffffffffc02968a0 <npage>
ffffffffc0202594:	00e7ff63          	bgeu	a5,a4,ffffffffc02025b2 <get_page+0x50>
ffffffffc0202598:	60a2                	ld	ra,8(sp)
ffffffffc020259a:	6402                	ld	s0,0(sp)
ffffffffc020259c:	fff80537          	lui	a0,0xfff80
ffffffffc02025a0:	97aa                	add	a5,a5,a0
ffffffffc02025a2:	079a                	slli	a5,a5,0x6
ffffffffc02025a4:	00094517          	auipc	a0,0x94
ffffffffc02025a8:	30453503          	ld	a0,772(a0) # ffffffffc02968a8 <pages>
ffffffffc02025ac:	953e                	add	a0,a0,a5
ffffffffc02025ae:	0141                	addi	sp,sp,16
ffffffffc02025b0:	8082                	ret
ffffffffc02025b2:	bd3ff0ef          	jal	ra,ffffffffc0202184 <pa2page.part.0>

ffffffffc02025b6 <unmap_range>:
ffffffffc02025b6:	7159                	addi	sp,sp,-112
ffffffffc02025b8:	00c5e7b3          	or	a5,a1,a2
ffffffffc02025bc:	f486                	sd	ra,104(sp)
ffffffffc02025be:	f0a2                	sd	s0,96(sp)
ffffffffc02025c0:	eca6                	sd	s1,88(sp)
ffffffffc02025c2:	e8ca                	sd	s2,80(sp)
ffffffffc02025c4:	e4ce                	sd	s3,72(sp)
ffffffffc02025c6:	e0d2                	sd	s4,64(sp)
ffffffffc02025c8:	fc56                	sd	s5,56(sp)
ffffffffc02025ca:	f85a                	sd	s6,48(sp)
ffffffffc02025cc:	f45e                	sd	s7,40(sp)
ffffffffc02025ce:	f062                	sd	s8,32(sp)
ffffffffc02025d0:	ec66                	sd	s9,24(sp)
ffffffffc02025d2:	e86a                	sd	s10,16(sp)
ffffffffc02025d4:	17d2                	slli	a5,a5,0x34
ffffffffc02025d6:	e3ed                	bnez	a5,ffffffffc02026b8 <unmap_range+0x102>
ffffffffc02025d8:	002007b7          	lui	a5,0x200
ffffffffc02025dc:	842e                	mv	s0,a1
ffffffffc02025de:	0ef5ed63          	bltu	a1,a5,ffffffffc02026d8 <unmap_range+0x122>
ffffffffc02025e2:	8932                	mv	s2,a2
ffffffffc02025e4:	0ec5fa63          	bgeu	a1,a2,ffffffffc02026d8 <unmap_range+0x122>
ffffffffc02025e8:	4785                	li	a5,1
ffffffffc02025ea:	07fe                	slli	a5,a5,0x1f
ffffffffc02025ec:	0ec7e663          	bltu	a5,a2,ffffffffc02026d8 <unmap_range+0x122>
ffffffffc02025f0:	89aa                	mv	s3,a0
ffffffffc02025f2:	6a05                	lui	s4,0x1
ffffffffc02025f4:	00094c97          	auipc	s9,0x94
ffffffffc02025f8:	2acc8c93          	addi	s9,s9,684 # ffffffffc02968a0 <npage>
ffffffffc02025fc:	00094c17          	auipc	s8,0x94
ffffffffc0202600:	2acc0c13          	addi	s8,s8,684 # ffffffffc02968a8 <pages>
ffffffffc0202604:	fff80bb7          	lui	s7,0xfff80
ffffffffc0202608:	00094d17          	auipc	s10,0x94
ffffffffc020260c:	2a8d0d13          	addi	s10,s10,680 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202610:	00200b37          	lui	s6,0x200
ffffffffc0202614:	ffe00ab7          	lui	s5,0xffe00
ffffffffc0202618:	4601                	li	a2,0
ffffffffc020261a:	85a2                	mv	a1,s0
ffffffffc020261c:	854e                	mv	a0,s3
ffffffffc020261e:	c57ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202622:	84aa                	mv	s1,a0
ffffffffc0202624:	cd29                	beqz	a0,ffffffffc020267e <unmap_range+0xc8>
ffffffffc0202626:	611c                	ld	a5,0(a0)
ffffffffc0202628:	e395                	bnez	a5,ffffffffc020264c <unmap_range+0x96>
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	ff2466e3          	bltu	s0,s2,ffffffffc0202618 <unmap_range+0x62>
ffffffffc0202630:	70a6                	ld	ra,104(sp)
ffffffffc0202632:	7406                	ld	s0,96(sp)
ffffffffc0202634:	64e6                	ld	s1,88(sp)
ffffffffc0202636:	6946                	ld	s2,80(sp)
ffffffffc0202638:	69a6                	ld	s3,72(sp)
ffffffffc020263a:	6a06                	ld	s4,64(sp)
ffffffffc020263c:	7ae2                	ld	s5,56(sp)
ffffffffc020263e:	7b42                	ld	s6,48(sp)
ffffffffc0202640:	7ba2                	ld	s7,40(sp)
ffffffffc0202642:	7c02                	ld	s8,32(sp)
ffffffffc0202644:	6ce2                	ld	s9,24(sp)
ffffffffc0202646:	6d42                	ld	s10,16(sp)
ffffffffc0202648:	6165                	addi	sp,sp,112
ffffffffc020264a:	8082                	ret
ffffffffc020264c:	0017f713          	andi	a4,a5,1
ffffffffc0202650:	df69                	beqz	a4,ffffffffc020262a <unmap_range+0x74>
ffffffffc0202652:	000cb703          	ld	a4,0(s9)
ffffffffc0202656:	078a                	slli	a5,a5,0x2
ffffffffc0202658:	83b1                	srli	a5,a5,0xc
ffffffffc020265a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026f8 <unmap_range+0x142>
ffffffffc020265e:	000c3503          	ld	a0,0(s8)
ffffffffc0202662:	97de                	add	a5,a5,s7
ffffffffc0202664:	079a                	slli	a5,a5,0x6
ffffffffc0202666:	953e                	add	a0,a0,a5
ffffffffc0202668:	411c                	lw	a5,0(a0)
ffffffffc020266a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020266e:	c118                	sw	a4,0(a0)
ffffffffc0202670:	cf11                	beqz	a4,ffffffffc020268c <unmap_range+0xd6>
ffffffffc0202672:	0004b023          	sd	zero,0(s1)
ffffffffc0202676:	12040073          	sfence.vma	s0
ffffffffc020267a:	9452                	add	s0,s0,s4
ffffffffc020267c:	bf45                	j	ffffffffc020262c <unmap_range+0x76>
ffffffffc020267e:	945a                	add	s0,s0,s6
ffffffffc0202680:	01547433          	and	s0,s0,s5
ffffffffc0202684:	d455                	beqz	s0,ffffffffc0202630 <unmap_range+0x7a>
ffffffffc0202686:	f92469e3          	bltu	s0,s2,ffffffffc0202618 <unmap_range+0x62>
ffffffffc020268a:	b75d                	j	ffffffffc0202630 <unmap_range+0x7a>
ffffffffc020268c:	100027f3          	csrr	a5,sstatus
ffffffffc0202690:	8b89                	andi	a5,a5,2
ffffffffc0202692:	e799                	bnez	a5,ffffffffc02026a0 <unmap_range+0xea>
ffffffffc0202694:	000d3783          	ld	a5,0(s10)
ffffffffc0202698:	4585                	li	a1,1
ffffffffc020269a:	739c                	ld	a5,32(a5)
ffffffffc020269c:	9782                	jalr	a5
ffffffffc020269e:	bfd1                	j	ffffffffc0202672 <unmap_range+0xbc>
ffffffffc02026a0:	e42a                	sd	a0,8(sp)
ffffffffc02026a2:	dd0fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02026a6:	000d3783          	ld	a5,0(s10)
ffffffffc02026aa:	6522                	ld	a0,8(sp)
ffffffffc02026ac:	4585                	li	a1,1
ffffffffc02026ae:	739c                	ld	a5,32(a5)
ffffffffc02026b0:	9782                	jalr	a5
ffffffffc02026b2:	dbafe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02026b6:	bf75                	j	ffffffffc0202672 <unmap_range+0xbc>
ffffffffc02026b8:	0000a697          	auipc	a3,0xa
ffffffffc02026bc:	f8068693          	addi	a3,a3,-128 # ffffffffc020c638 <default_pmm_manager+0x188>
ffffffffc02026c0:	00009617          	auipc	a2,0x9
ffffffffc02026c4:	2e860613          	addi	a2,a2,744 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02026c8:	15a00593          	li	a1,346
ffffffffc02026cc:	0000a517          	auipc	a0,0xa
ffffffffc02026d0:	f3450513          	addi	a0,a0,-204 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02026d4:	dcbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026d8:	0000a697          	auipc	a3,0xa
ffffffffc02026dc:	f9068693          	addi	a3,a3,-112 # ffffffffc020c668 <default_pmm_manager+0x1b8>
ffffffffc02026e0:	00009617          	auipc	a2,0x9
ffffffffc02026e4:	2c860613          	addi	a2,a2,712 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02026e8:	15b00593          	li	a1,347
ffffffffc02026ec:	0000a517          	auipc	a0,0xa
ffffffffc02026f0:	f1450513          	addi	a0,a0,-236 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02026f4:	dabfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026f8:	a8dff0ef          	jal	ra,ffffffffc0202184 <pa2page.part.0>

ffffffffc02026fc <exit_range>:
ffffffffc02026fc:	7119                	addi	sp,sp,-128
ffffffffc02026fe:	00c5e7b3          	or	a5,a1,a2
ffffffffc0202702:	fc86                	sd	ra,120(sp)
ffffffffc0202704:	f8a2                	sd	s0,112(sp)
ffffffffc0202706:	f4a6                	sd	s1,104(sp)
ffffffffc0202708:	f0ca                	sd	s2,96(sp)
ffffffffc020270a:	ecce                	sd	s3,88(sp)
ffffffffc020270c:	e8d2                	sd	s4,80(sp)
ffffffffc020270e:	e4d6                	sd	s5,72(sp)
ffffffffc0202710:	e0da                	sd	s6,64(sp)
ffffffffc0202712:	fc5e                	sd	s7,56(sp)
ffffffffc0202714:	f862                	sd	s8,48(sp)
ffffffffc0202716:	f466                	sd	s9,40(sp)
ffffffffc0202718:	f06a                	sd	s10,32(sp)
ffffffffc020271a:	ec6e                	sd	s11,24(sp)
ffffffffc020271c:	17d2                	slli	a5,a5,0x34
ffffffffc020271e:	20079a63          	bnez	a5,ffffffffc0202932 <exit_range+0x236>
ffffffffc0202722:	002007b7          	lui	a5,0x200
ffffffffc0202726:	24f5e463          	bltu	a1,a5,ffffffffc020296e <exit_range+0x272>
ffffffffc020272a:	8ab2                	mv	s5,a2
ffffffffc020272c:	24c5f163          	bgeu	a1,a2,ffffffffc020296e <exit_range+0x272>
ffffffffc0202730:	4785                	li	a5,1
ffffffffc0202732:	07fe                	slli	a5,a5,0x1f
ffffffffc0202734:	22c7ed63          	bltu	a5,a2,ffffffffc020296e <exit_range+0x272>
ffffffffc0202738:	c00009b7          	lui	s3,0xc0000
ffffffffc020273c:	0135f9b3          	and	s3,a1,s3
ffffffffc0202740:	ffe00937          	lui	s2,0xffe00
ffffffffc0202744:	400007b7          	lui	a5,0x40000
ffffffffc0202748:	5cfd                	li	s9,-1
ffffffffc020274a:	8c2a                	mv	s8,a0
ffffffffc020274c:	0125f933          	and	s2,a1,s2
ffffffffc0202750:	99be                	add	s3,s3,a5
ffffffffc0202752:	00094d17          	auipc	s10,0x94
ffffffffc0202756:	14ed0d13          	addi	s10,s10,334 # ffffffffc02968a0 <npage>
ffffffffc020275a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020275e:	00094717          	auipc	a4,0x94
ffffffffc0202762:	14a70713          	addi	a4,a4,330 # ffffffffc02968a8 <pages>
ffffffffc0202766:	00094d97          	auipc	s11,0x94
ffffffffc020276a:	14ad8d93          	addi	s11,s11,330 # ffffffffc02968b0 <pmm_manager>
ffffffffc020276e:	c0000437          	lui	s0,0xc0000
ffffffffc0202772:	944e                	add	s0,s0,s3
ffffffffc0202774:	8079                	srli	s0,s0,0x1e
ffffffffc0202776:	1ff47413          	andi	s0,s0,511
ffffffffc020277a:	040e                	slli	s0,s0,0x3
ffffffffc020277c:	9462                	add	s0,s0,s8
ffffffffc020277e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202782:	001a7793          	andi	a5,s4,1
ffffffffc0202786:	eb99                	bnez	a5,ffffffffc020279c <exit_range+0xa0>
ffffffffc0202788:	12098463          	beqz	s3,ffffffffc02028b0 <exit_range+0x1b4>
ffffffffc020278c:	400007b7          	lui	a5,0x40000
ffffffffc0202790:	97ce                	add	a5,a5,s3
ffffffffc0202792:	894e                	mv	s2,s3
ffffffffc0202794:	1159fe63          	bgeu	s3,s5,ffffffffc02028b0 <exit_range+0x1b4>
ffffffffc0202798:	89be                	mv	s3,a5
ffffffffc020279a:	bfd1                	j	ffffffffc020276e <exit_range+0x72>
ffffffffc020279c:	000d3783          	ld	a5,0(s10)
ffffffffc02027a0:	0a0a                	slli	s4,s4,0x2
ffffffffc02027a2:	00ca5a13          	srli	s4,s4,0xc
ffffffffc02027a6:	1cfa7263          	bgeu	s4,a5,ffffffffc020296a <exit_range+0x26e>
ffffffffc02027aa:	fff80637          	lui	a2,0xfff80
ffffffffc02027ae:	9652                	add	a2,a2,s4
ffffffffc02027b0:	000806b7          	lui	a3,0x80
ffffffffc02027b4:	96b2                	add	a3,a3,a2
ffffffffc02027b6:	0196f5b3          	and	a1,a3,s9
ffffffffc02027ba:	061a                	slli	a2,a2,0x6
ffffffffc02027bc:	06b2                	slli	a3,a3,0xc
ffffffffc02027be:	18f5fa63          	bgeu	a1,a5,ffffffffc0202952 <exit_range+0x256>
ffffffffc02027c2:	00094817          	auipc	a6,0x94
ffffffffc02027c6:	0f680813          	addi	a6,a6,246 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02027ca:	00083b03          	ld	s6,0(a6)
ffffffffc02027ce:	4b85                	li	s7,1
ffffffffc02027d0:	fff80e37          	lui	t3,0xfff80
ffffffffc02027d4:	9b36                	add	s6,s6,a3
ffffffffc02027d6:	00080337          	lui	t1,0x80
ffffffffc02027da:	6885                	lui	a7,0x1
ffffffffc02027dc:	a819                	j	ffffffffc02027f2 <exit_range+0xf6>
ffffffffc02027de:	4b81                	li	s7,0
ffffffffc02027e0:	002007b7          	lui	a5,0x200
ffffffffc02027e4:	993e                	add	s2,s2,a5
ffffffffc02027e6:	08090c63          	beqz	s2,ffffffffc020287e <exit_range+0x182>
ffffffffc02027ea:	09397a63          	bgeu	s2,s3,ffffffffc020287e <exit_range+0x182>
ffffffffc02027ee:	0f597063          	bgeu	s2,s5,ffffffffc02028ce <exit_range+0x1d2>
ffffffffc02027f2:	01595493          	srli	s1,s2,0x15
ffffffffc02027f6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027fa:	048e                	slli	s1,s1,0x3
ffffffffc02027fc:	94da                	add	s1,s1,s6
ffffffffc02027fe:	609c                	ld	a5,0(s1)
ffffffffc0202800:	0017f693          	andi	a3,a5,1
ffffffffc0202804:	dee9                	beqz	a3,ffffffffc02027de <exit_range+0xe2>
ffffffffc0202806:	000d3583          	ld	a1,0(s10)
ffffffffc020280a:	078a                	slli	a5,a5,0x2
ffffffffc020280c:	83b1                	srli	a5,a5,0xc
ffffffffc020280e:	14b7fe63          	bgeu	a5,a1,ffffffffc020296a <exit_range+0x26e>
ffffffffc0202812:	97f2                	add	a5,a5,t3
ffffffffc0202814:	006786b3          	add	a3,a5,t1
ffffffffc0202818:	0196feb3          	and	t4,a3,s9
ffffffffc020281c:	00679513          	slli	a0,a5,0x6
ffffffffc0202820:	06b2                	slli	a3,a3,0xc
ffffffffc0202822:	12bef863          	bgeu	t4,a1,ffffffffc0202952 <exit_range+0x256>
ffffffffc0202826:	00083783          	ld	a5,0(a6)
ffffffffc020282a:	96be                	add	a3,a3,a5
ffffffffc020282c:	011685b3          	add	a1,a3,a7
ffffffffc0202830:	629c                	ld	a5,0(a3)
ffffffffc0202832:	8b85                	andi	a5,a5,1
ffffffffc0202834:	f7d5                	bnez	a5,ffffffffc02027e0 <exit_range+0xe4>
ffffffffc0202836:	06a1                	addi	a3,a3,8
ffffffffc0202838:	fed59ce3          	bne	a1,a3,ffffffffc0202830 <exit_range+0x134>
ffffffffc020283c:	631c                	ld	a5,0(a4)
ffffffffc020283e:	953e                	add	a0,a0,a5
ffffffffc0202840:	100027f3          	csrr	a5,sstatus
ffffffffc0202844:	8b89                	andi	a5,a5,2
ffffffffc0202846:	e7d9                	bnez	a5,ffffffffc02028d4 <exit_range+0x1d8>
ffffffffc0202848:	000db783          	ld	a5,0(s11)
ffffffffc020284c:	4585                	li	a1,1
ffffffffc020284e:	e032                	sd	a2,0(sp)
ffffffffc0202850:	739c                	ld	a5,32(a5)
ffffffffc0202852:	9782                	jalr	a5
ffffffffc0202854:	6602                	ld	a2,0(sp)
ffffffffc0202856:	00094817          	auipc	a6,0x94
ffffffffc020285a:	06280813          	addi	a6,a6,98 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020285e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202862:	00080337          	lui	t1,0x80
ffffffffc0202866:	6885                	lui	a7,0x1
ffffffffc0202868:	00094717          	auipc	a4,0x94
ffffffffc020286c:	04070713          	addi	a4,a4,64 # ffffffffc02968a8 <pages>
ffffffffc0202870:	0004b023          	sd	zero,0(s1)
ffffffffc0202874:	002007b7          	lui	a5,0x200
ffffffffc0202878:	993e                	add	s2,s2,a5
ffffffffc020287a:	f60918e3          	bnez	s2,ffffffffc02027ea <exit_range+0xee>
ffffffffc020287e:	f00b85e3          	beqz	s7,ffffffffc0202788 <exit_range+0x8c>
ffffffffc0202882:	000d3783          	ld	a5,0(s10)
ffffffffc0202886:	0efa7263          	bgeu	s4,a5,ffffffffc020296a <exit_range+0x26e>
ffffffffc020288a:	6308                	ld	a0,0(a4)
ffffffffc020288c:	9532                	add	a0,a0,a2
ffffffffc020288e:	100027f3          	csrr	a5,sstatus
ffffffffc0202892:	8b89                	andi	a5,a5,2
ffffffffc0202894:	efad                	bnez	a5,ffffffffc020290e <exit_range+0x212>
ffffffffc0202896:	000db783          	ld	a5,0(s11)
ffffffffc020289a:	4585                	li	a1,1
ffffffffc020289c:	739c                	ld	a5,32(a5)
ffffffffc020289e:	9782                	jalr	a5
ffffffffc02028a0:	00094717          	auipc	a4,0x94
ffffffffc02028a4:	00870713          	addi	a4,a4,8 # ffffffffc02968a8 <pages>
ffffffffc02028a8:	00043023          	sd	zero,0(s0)
ffffffffc02028ac:	ee0990e3          	bnez	s3,ffffffffc020278c <exit_range+0x90>
ffffffffc02028b0:	70e6                	ld	ra,120(sp)
ffffffffc02028b2:	7446                	ld	s0,112(sp)
ffffffffc02028b4:	74a6                	ld	s1,104(sp)
ffffffffc02028b6:	7906                	ld	s2,96(sp)
ffffffffc02028b8:	69e6                	ld	s3,88(sp)
ffffffffc02028ba:	6a46                	ld	s4,80(sp)
ffffffffc02028bc:	6aa6                	ld	s5,72(sp)
ffffffffc02028be:	6b06                	ld	s6,64(sp)
ffffffffc02028c0:	7be2                	ld	s7,56(sp)
ffffffffc02028c2:	7c42                	ld	s8,48(sp)
ffffffffc02028c4:	7ca2                	ld	s9,40(sp)
ffffffffc02028c6:	7d02                	ld	s10,32(sp)
ffffffffc02028c8:	6de2                	ld	s11,24(sp)
ffffffffc02028ca:	6109                	addi	sp,sp,128
ffffffffc02028cc:	8082                	ret
ffffffffc02028ce:	ea0b8fe3          	beqz	s7,ffffffffc020278c <exit_range+0x90>
ffffffffc02028d2:	bf45                	j	ffffffffc0202882 <exit_range+0x186>
ffffffffc02028d4:	e032                	sd	a2,0(sp)
ffffffffc02028d6:	e42a                	sd	a0,8(sp)
ffffffffc02028d8:	b9afe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028dc:	000db783          	ld	a5,0(s11)
ffffffffc02028e0:	6522                	ld	a0,8(sp)
ffffffffc02028e2:	4585                	li	a1,1
ffffffffc02028e4:	739c                	ld	a5,32(a5)
ffffffffc02028e6:	9782                	jalr	a5
ffffffffc02028e8:	b84fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028ec:	6602                	ld	a2,0(sp)
ffffffffc02028ee:	00094717          	auipc	a4,0x94
ffffffffc02028f2:	fba70713          	addi	a4,a4,-70 # ffffffffc02968a8 <pages>
ffffffffc02028f6:	6885                	lui	a7,0x1
ffffffffc02028f8:	00080337          	lui	t1,0x80
ffffffffc02028fc:	fff80e37          	lui	t3,0xfff80
ffffffffc0202900:	00094817          	auipc	a6,0x94
ffffffffc0202904:	fb880813          	addi	a6,a6,-72 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202908:	0004b023          	sd	zero,0(s1)
ffffffffc020290c:	b7a5                	j	ffffffffc0202874 <exit_range+0x178>
ffffffffc020290e:	e02a                	sd	a0,0(sp)
ffffffffc0202910:	b62fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202914:	000db783          	ld	a5,0(s11)
ffffffffc0202918:	6502                	ld	a0,0(sp)
ffffffffc020291a:	4585                	li	a1,1
ffffffffc020291c:	739c                	ld	a5,32(a5)
ffffffffc020291e:	9782                	jalr	a5
ffffffffc0202920:	b4cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202924:	00094717          	auipc	a4,0x94
ffffffffc0202928:	f8470713          	addi	a4,a4,-124 # ffffffffc02968a8 <pages>
ffffffffc020292c:	00043023          	sd	zero,0(s0)
ffffffffc0202930:	bfb5                	j	ffffffffc02028ac <exit_range+0x1b0>
ffffffffc0202932:	0000a697          	auipc	a3,0xa
ffffffffc0202936:	d0668693          	addi	a3,a3,-762 # ffffffffc020c638 <default_pmm_manager+0x188>
ffffffffc020293a:	00009617          	auipc	a2,0x9
ffffffffc020293e:	06e60613          	addi	a2,a2,110 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0202942:	16f00593          	li	a1,367
ffffffffc0202946:	0000a517          	auipc	a0,0xa
ffffffffc020294a:	cba50513          	addi	a0,a0,-838 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020294e:	b51fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202952:	0000a617          	auipc	a2,0xa
ffffffffc0202956:	b9660613          	addi	a2,a2,-1130 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc020295a:	07100593          	li	a1,113
ffffffffc020295e:	0000a517          	auipc	a0,0xa
ffffffffc0202962:	bb250513          	addi	a0,a0,-1102 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0202966:	b39fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020296a:	81bff0ef          	jal	ra,ffffffffc0202184 <pa2page.part.0>
ffffffffc020296e:	0000a697          	auipc	a3,0xa
ffffffffc0202972:	cfa68693          	addi	a3,a3,-774 # ffffffffc020c668 <default_pmm_manager+0x1b8>
ffffffffc0202976:	00009617          	auipc	a2,0x9
ffffffffc020297a:	03260613          	addi	a2,a2,50 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020297e:	17000593          	li	a1,368
ffffffffc0202982:	0000a517          	auipc	a0,0xa
ffffffffc0202986:	c7e50513          	addi	a0,a0,-898 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020298a:	b15fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020298e <page_remove>:
ffffffffc020298e:	7179                	addi	sp,sp,-48
ffffffffc0202990:	4601                	li	a2,0
ffffffffc0202992:	ec26                	sd	s1,24(sp)
ffffffffc0202994:	f406                	sd	ra,40(sp)
ffffffffc0202996:	f022                	sd	s0,32(sp)
ffffffffc0202998:	84ae                	mv	s1,a1
ffffffffc020299a:	8dbff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc020299e:	c511                	beqz	a0,ffffffffc02029aa <page_remove+0x1c>
ffffffffc02029a0:	611c                	ld	a5,0(a0)
ffffffffc02029a2:	842a                	mv	s0,a0
ffffffffc02029a4:	0017f713          	andi	a4,a5,1
ffffffffc02029a8:	e711                	bnez	a4,ffffffffc02029b4 <page_remove+0x26>
ffffffffc02029aa:	70a2                	ld	ra,40(sp)
ffffffffc02029ac:	7402                	ld	s0,32(sp)
ffffffffc02029ae:	64e2                	ld	s1,24(sp)
ffffffffc02029b0:	6145                	addi	sp,sp,48
ffffffffc02029b2:	8082                	ret
ffffffffc02029b4:	078a                	slli	a5,a5,0x2
ffffffffc02029b6:	83b1                	srli	a5,a5,0xc
ffffffffc02029b8:	00094717          	auipc	a4,0x94
ffffffffc02029bc:	ee873703          	ld	a4,-280(a4) # ffffffffc02968a0 <npage>
ffffffffc02029c0:	06e7f363          	bgeu	a5,a4,ffffffffc0202a26 <page_remove+0x98>
ffffffffc02029c4:	fff80537          	lui	a0,0xfff80
ffffffffc02029c8:	97aa                	add	a5,a5,a0
ffffffffc02029ca:	079a                	slli	a5,a5,0x6
ffffffffc02029cc:	00094517          	auipc	a0,0x94
ffffffffc02029d0:	edc53503          	ld	a0,-292(a0) # ffffffffc02968a8 <pages>
ffffffffc02029d4:	953e                	add	a0,a0,a5
ffffffffc02029d6:	411c                	lw	a5,0(a0)
ffffffffc02029d8:	fff7871b          	addiw	a4,a5,-1
ffffffffc02029dc:	c118                	sw	a4,0(a0)
ffffffffc02029de:	cb11                	beqz	a4,ffffffffc02029f2 <page_remove+0x64>
ffffffffc02029e0:	00043023          	sd	zero,0(s0)
ffffffffc02029e4:	12048073          	sfence.vma	s1
ffffffffc02029e8:	70a2                	ld	ra,40(sp)
ffffffffc02029ea:	7402                	ld	s0,32(sp)
ffffffffc02029ec:	64e2                	ld	s1,24(sp)
ffffffffc02029ee:	6145                	addi	sp,sp,48
ffffffffc02029f0:	8082                	ret
ffffffffc02029f2:	100027f3          	csrr	a5,sstatus
ffffffffc02029f6:	8b89                	andi	a5,a5,2
ffffffffc02029f8:	eb89                	bnez	a5,ffffffffc0202a0a <page_remove+0x7c>
ffffffffc02029fa:	00094797          	auipc	a5,0x94
ffffffffc02029fe:	eb67b783          	ld	a5,-330(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a02:	739c                	ld	a5,32(a5)
ffffffffc0202a04:	4585                	li	a1,1
ffffffffc0202a06:	9782                	jalr	a5
ffffffffc0202a08:	bfe1                	j	ffffffffc02029e0 <page_remove+0x52>
ffffffffc0202a0a:	e42a                	sd	a0,8(sp)
ffffffffc0202a0c:	a66fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202a10:	00094797          	auipc	a5,0x94
ffffffffc0202a14:	ea07b783          	ld	a5,-352(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a18:	739c                	ld	a5,32(a5)
ffffffffc0202a1a:	6522                	ld	a0,8(sp)
ffffffffc0202a1c:	4585                	li	a1,1
ffffffffc0202a1e:	9782                	jalr	a5
ffffffffc0202a20:	a4cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202a24:	bf75                	j	ffffffffc02029e0 <page_remove+0x52>
ffffffffc0202a26:	f5eff0ef          	jal	ra,ffffffffc0202184 <pa2page.part.0>

ffffffffc0202a2a <page_insert>:
ffffffffc0202a2a:	7139                	addi	sp,sp,-64
ffffffffc0202a2c:	e852                	sd	s4,16(sp)
ffffffffc0202a2e:	8a32                	mv	s4,a2
ffffffffc0202a30:	f822                	sd	s0,48(sp)
ffffffffc0202a32:	4605                	li	a2,1
ffffffffc0202a34:	842e                	mv	s0,a1
ffffffffc0202a36:	85d2                	mv	a1,s4
ffffffffc0202a38:	f426                	sd	s1,40(sp)
ffffffffc0202a3a:	fc06                	sd	ra,56(sp)
ffffffffc0202a3c:	f04a                	sd	s2,32(sp)
ffffffffc0202a3e:	ec4e                	sd	s3,24(sp)
ffffffffc0202a40:	e456                	sd	s5,8(sp)
ffffffffc0202a42:	84b6                	mv	s1,a3
ffffffffc0202a44:	831ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202a48:	c961                	beqz	a0,ffffffffc0202b18 <page_insert+0xee>
ffffffffc0202a4a:	4014                	lw	a3,0(s0)
ffffffffc0202a4c:	611c                	ld	a5,0(a0)
ffffffffc0202a4e:	89aa                	mv	s3,a0
ffffffffc0202a50:	0016871b          	addiw	a4,a3,1
ffffffffc0202a54:	c018                	sw	a4,0(s0)
ffffffffc0202a56:	0017f713          	andi	a4,a5,1
ffffffffc0202a5a:	ef05                	bnez	a4,ffffffffc0202a92 <page_insert+0x68>
ffffffffc0202a5c:	00094717          	auipc	a4,0x94
ffffffffc0202a60:	e4c73703          	ld	a4,-436(a4) # ffffffffc02968a8 <pages>
ffffffffc0202a64:	8c19                	sub	s0,s0,a4
ffffffffc0202a66:	000807b7          	lui	a5,0x80
ffffffffc0202a6a:	8419                	srai	s0,s0,0x6
ffffffffc0202a6c:	943e                	add	s0,s0,a5
ffffffffc0202a6e:	042a                	slli	s0,s0,0xa
ffffffffc0202a70:	8cc1                	or	s1,s1,s0
ffffffffc0202a72:	0014e493          	ori	s1,s1,1
ffffffffc0202a76:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a7a:	120a0073          	sfence.vma	s4
ffffffffc0202a7e:	4501                	li	a0,0
ffffffffc0202a80:	70e2                	ld	ra,56(sp)
ffffffffc0202a82:	7442                	ld	s0,48(sp)
ffffffffc0202a84:	74a2                	ld	s1,40(sp)
ffffffffc0202a86:	7902                	ld	s2,32(sp)
ffffffffc0202a88:	69e2                	ld	s3,24(sp)
ffffffffc0202a8a:	6a42                	ld	s4,16(sp)
ffffffffc0202a8c:	6aa2                	ld	s5,8(sp)
ffffffffc0202a8e:	6121                	addi	sp,sp,64
ffffffffc0202a90:	8082                	ret
ffffffffc0202a92:	078a                	slli	a5,a5,0x2
ffffffffc0202a94:	83b1                	srli	a5,a5,0xc
ffffffffc0202a96:	00094717          	auipc	a4,0x94
ffffffffc0202a9a:	e0a73703          	ld	a4,-502(a4) # ffffffffc02968a0 <npage>
ffffffffc0202a9e:	06e7ff63          	bgeu	a5,a4,ffffffffc0202b1c <page_insert+0xf2>
ffffffffc0202aa2:	00094a97          	auipc	s5,0x94
ffffffffc0202aa6:	e06a8a93          	addi	s5,s5,-506 # ffffffffc02968a8 <pages>
ffffffffc0202aaa:	000ab703          	ld	a4,0(s5)
ffffffffc0202aae:	fff80937          	lui	s2,0xfff80
ffffffffc0202ab2:	993e                	add	s2,s2,a5
ffffffffc0202ab4:	091a                	slli	s2,s2,0x6
ffffffffc0202ab6:	993a                	add	s2,s2,a4
ffffffffc0202ab8:	01240c63          	beq	s0,s2,ffffffffc0202ad0 <page_insert+0xa6>
ffffffffc0202abc:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202ac0:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202ac4:	00d92023          	sw	a3,0(s2)
ffffffffc0202ac8:	c691                	beqz	a3,ffffffffc0202ad4 <page_insert+0xaa>
ffffffffc0202aca:	120a0073          	sfence.vma	s4
ffffffffc0202ace:	bf59                	j	ffffffffc0202a64 <page_insert+0x3a>
ffffffffc0202ad0:	c014                	sw	a3,0(s0)
ffffffffc0202ad2:	bf49                	j	ffffffffc0202a64 <page_insert+0x3a>
ffffffffc0202ad4:	100027f3          	csrr	a5,sstatus
ffffffffc0202ad8:	8b89                	andi	a5,a5,2
ffffffffc0202ada:	ef91                	bnez	a5,ffffffffc0202af6 <page_insert+0xcc>
ffffffffc0202adc:	00094797          	auipc	a5,0x94
ffffffffc0202ae0:	dd47b783          	ld	a5,-556(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202ae4:	739c                	ld	a5,32(a5)
ffffffffc0202ae6:	4585                	li	a1,1
ffffffffc0202ae8:	854a                	mv	a0,s2
ffffffffc0202aea:	9782                	jalr	a5
ffffffffc0202aec:	000ab703          	ld	a4,0(s5)
ffffffffc0202af0:	120a0073          	sfence.vma	s4
ffffffffc0202af4:	bf85                	j	ffffffffc0202a64 <page_insert+0x3a>
ffffffffc0202af6:	97cfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202afa:	00094797          	auipc	a5,0x94
ffffffffc0202afe:	db67b783          	ld	a5,-586(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b02:	739c                	ld	a5,32(a5)
ffffffffc0202b04:	4585                	li	a1,1
ffffffffc0202b06:	854a                	mv	a0,s2
ffffffffc0202b08:	9782                	jalr	a5
ffffffffc0202b0a:	962fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202b0e:	000ab703          	ld	a4,0(s5)
ffffffffc0202b12:	120a0073          	sfence.vma	s4
ffffffffc0202b16:	b7b9                	j	ffffffffc0202a64 <page_insert+0x3a>
ffffffffc0202b18:	5571                	li	a0,-4
ffffffffc0202b1a:	b79d                	j	ffffffffc0202a80 <page_insert+0x56>
ffffffffc0202b1c:	e68ff0ef          	jal	ra,ffffffffc0202184 <pa2page.part.0>

ffffffffc0202b20 <pmm_init>:
ffffffffc0202b20:	0000a797          	auipc	a5,0xa
ffffffffc0202b24:	99078793          	addi	a5,a5,-1648 # ffffffffc020c4b0 <default_pmm_manager>
ffffffffc0202b28:	638c                	ld	a1,0(a5)
ffffffffc0202b2a:	7159                	addi	sp,sp,-112
ffffffffc0202b2c:	f85a                	sd	s6,48(sp)
ffffffffc0202b2e:	0000a517          	auipc	a0,0xa
ffffffffc0202b32:	b5250513          	addi	a0,a0,-1198 # ffffffffc020c680 <default_pmm_manager+0x1d0>
ffffffffc0202b36:	00094b17          	auipc	s6,0x94
ffffffffc0202b3a:	d7ab0b13          	addi	s6,s6,-646 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202b3e:	f486                	sd	ra,104(sp)
ffffffffc0202b40:	e8ca                	sd	s2,80(sp)
ffffffffc0202b42:	e4ce                	sd	s3,72(sp)
ffffffffc0202b44:	f0a2                	sd	s0,96(sp)
ffffffffc0202b46:	eca6                	sd	s1,88(sp)
ffffffffc0202b48:	e0d2                	sd	s4,64(sp)
ffffffffc0202b4a:	fc56                	sd	s5,56(sp)
ffffffffc0202b4c:	f45e                	sd	s7,40(sp)
ffffffffc0202b4e:	f062                	sd	s8,32(sp)
ffffffffc0202b50:	ec66                	sd	s9,24(sp)
ffffffffc0202b52:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b56:	e50fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b5a:	000b3783          	ld	a5,0(s6)
ffffffffc0202b5e:	00094997          	auipc	s3,0x94
ffffffffc0202b62:	d5a98993          	addi	s3,s3,-678 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202b66:	679c                	ld	a5,8(a5)
ffffffffc0202b68:	9782                	jalr	a5
ffffffffc0202b6a:	57f5                	li	a5,-3
ffffffffc0202b6c:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b6e:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b72:	ed7fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b76:	892a                	mv	s2,a0
ffffffffc0202b78:	edbfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b7c:	280502e3          	beqz	a0,ffffffffc0203600 <pmm_init+0xae0>
ffffffffc0202b80:	84aa                	mv	s1,a0
ffffffffc0202b82:	0000a517          	auipc	a0,0xa
ffffffffc0202b86:	b3650513          	addi	a0,a0,-1226 # ffffffffc020c6b8 <default_pmm_manager+0x208>
ffffffffc0202b8a:	e1cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b8e:	00990433          	add	s0,s2,s1
ffffffffc0202b92:	fff40693          	addi	a3,s0,-1
ffffffffc0202b96:	864a                	mv	a2,s2
ffffffffc0202b98:	85a6                	mv	a1,s1
ffffffffc0202b9a:	0000a517          	auipc	a0,0xa
ffffffffc0202b9e:	b3650513          	addi	a0,a0,-1226 # ffffffffc020c6d0 <default_pmm_manager+0x220>
ffffffffc0202ba2:	e04fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202ba6:	c8000737          	lui	a4,0xc8000
ffffffffc0202baa:	87a2                	mv	a5,s0
ffffffffc0202bac:	5e876e63          	bltu	a4,s0,ffffffffc02031a8 <pmm_init+0x688>
ffffffffc0202bb0:	757d                	lui	a0,0xfffff
ffffffffc0202bb2:	00095617          	auipc	a2,0x95
ffffffffc0202bb6:	d5d60613          	addi	a2,a2,-675 # ffffffffc029790f <end+0xfff>
ffffffffc0202bba:	8e69                	and	a2,a2,a0
ffffffffc0202bbc:	00094497          	auipc	s1,0x94
ffffffffc0202bc0:	ce448493          	addi	s1,s1,-796 # ffffffffc02968a0 <npage>
ffffffffc0202bc4:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202bc8:	00094b97          	auipc	s7,0x94
ffffffffc0202bcc:	ce0b8b93          	addi	s7,s7,-800 # ffffffffc02968a8 <pages>
ffffffffc0202bd0:	e088                	sd	a0,0(s1)
ffffffffc0202bd2:	00cbb023          	sd	a2,0(s7)
ffffffffc0202bd6:	000807b7          	lui	a5,0x80
ffffffffc0202bda:	86b2                	mv	a3,a2
ffffffffc0202bdc:	02f50863          	beq	a0,a5,ffffffffc0202c0c <pmm_init+0xec>
ffffffffc0202be0:	4781                	li	a5,0
ffffffffc0202be2:	4585                	li	a1,1
ffffffffc0202be4:	fff806b7          	lui	a3,0xfff80
ffffffffc0202be8:	00679513          	slli	a0,a5,0x6
ffffffffc0202bec:	9532                	add	a0,a0,a2
ffffffffc0202bee:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202bf2:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202bf6:	6088                	ld	a0,0(s1)
ffffffffc0202bf8:	0785                	addi	a5,a5,1
ffffffffc0202bfa:	000bb603          	ld	a2,0(s7)
ffffffffc0202bfe:	00d50733          	add	a4,a0,a3
ffffffffc0202c02:	fee7e3e3          	bltu	a5,a4,ffffffffc0202be8 <pmm_init+0xc8>
ffffffffc0202c06:	071a                	slli	a4,a4,0x6
ffffffffc0202c08:	00e606b3          	add	a3,a2,a4
ffffffffc0202c0c:	c02007b7          	lui	a5,0xc0200
ffffffffc0202c10:	3af6eae3          	bltu	a3,a5,ffffffffc02037c4 <pmm_init+0xca4>
ffffffffc0202c14:	0009b583          	ld	a1,0(s3)
ffffffffc0202c18:	77fd                	lui	a5,0xfffff
ffffffffc0202c1a:	8c7d                	and	s0,s0,a5
ffffffffc0202c1c:	8e8d                	sub	a3,a3,a1
ffffffffc0202c1e:	5e86e363          	bltu	a3,s0,ffffffffc0203204 <pmm_init+0x6e4>
ffffffffc0202c22:	0000a517          	auipc	a0,0xa
ffffffffc0202c26:	ad650513          	addi	a0,a0,-1322 # ffffffffc020c6f8 <default_pmm_manager+0x248>
ffffffffc0202c2a:	d7cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202c2e:	000b3783          	ld	a5,0(s6)
ffffffffc0202c32:	7b9c                	ld	a5,48(a5)
ffffffffc0202c34:	9782                	jalr	a5
ffffffffc0202c36:	0000a517          	auipc	a0,0xa
ffffffffc0202c3a:	ada50513          	addi	a0,a0,-1318 # ffffffffc020c710 <default_pmm_manager+0x260>
ffffffffc0202c3e:	d68fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202c42:	100027f3          	csrr	a5,sstatus
ffffffffc0202c46:	8b89                	andi	a5,a5,2
ffffffffc0202c48:	5a079363          	bnez	a5,ffffffffc02031ee <pmm_init+0x6ce>
ffffffffc0202c4c:	000b3783          	ld	a5,0(s6)
ffffffffc0202c50:	4505                	li	a0,1
ffffffffc0202c52:	6f9c                	ld	a5,24(a5)
ffffffffc0202c54:	9782                	jalr	a5
ffffffffc0202c56:	842a                	mv	s0,a0
ffffffffc0202c58:	180408e3          	beqz	s0,ffffffffc02035e8 <pmm_init+0xac8>
ffffffffc0202c5c:	000bb683          	ld	a3,0(s7)
ffffffffc0202c60:	5a7d                	li	s4,-1
ffffffffc0202c62:	6098                	ld	a4,0(s1)
ffffffffc0202c64:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c68:	8699                	srai	a3,a3,0x6
ffffffffc0202c6a:	00080437          	lui	s0,0x80
ffffffffc0202c6e:	96a2                	add	a3,a3,s0
ffffffffc0202c70:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c74:	8ff5                	and	a5,a5,a3
ffffffffc0202c76:	06b2                	slli	a3,a3,0xc
ffffffffc0202c78:	30e7fde3          	bgeu	a5,a4,ffffffffc0203792 <pmm_init+0xc72>
ffffffffc0202c7c:	0009b403          	ld	s0,0(s3)
ffffffffc0202c80:	6605                	lui	a2,0x1
ffffffffc0202c82:	4581                	li	a1,0
ffffffffc0202c84:	9436                	add	s0,s0,a3
ffffffffc0202c86:	8522                	mv	a0,s0
ffffffffc0202c88:	03d080ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0202c8c:	0009b683          	ld	a3,0(s3)
ffffffffc0202c90:	77fd                	lui	a5,0xfffff
ffffffffc0202c92:	0000a917          	auipc	s2,0xa
ffffffffc0202c96:	89b90913          	addi	s2,s2,-1893 # ffffffffc020c52d <default_pmm_manager+0x7d>
ffffffffc0202c9a:	00f97933          	and	s2,s2,a5
ffffffffc0202c9e:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202ca2:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202ca6:	964a                	add	a2,a2,s2
ffffffffc0202ca8:	4729                	li	a4,10
ffffffffc0202caa:	40da86b3          	sub	a3,s5,a3
ffffffffc0202cae:	c02005b7          	lui	a1,0xc0200
ffffffffc0202cb2:	8522                	mv	a0,s0
ffffffffc0202cb4:	fe8ff0ef          	jal	ra,ffffffffc020249c <boot_map_segment>
ffffffffc0202cb8:	c8000637          	lui	a2,0xc8000
ffffffffc0202cbc:	41260633          	sub	a2,a2,s2
ffffffffc0202cc0:	3f596ce3          	bltu	s2,s5,ffffffffc02038b8 <pmm_init+0xd98>
ffffffffc0202cc4:	0009b683          	ld	a3,0(s3)
ffffffffc0202cc8:	85ca                	mv	a1,s2
ffffffffc0202cca:	4719                	li	a4,6
ffffffffc0202ccc:	40d906b3          	sub	a3,s2,a3
ffffffffc0202cd0:	8522                	mv	a0,s0
ffffffffc0202cd2:	00094917          	auipc	s2,0x94
ffffffffc0202cd6:	bc690913          	addi	s2,s2,-1082 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202cda:	fc2ff0ef          	jal	ra,ffffffffc020249c <boot_map_segment>
ffffffffc0202cde:	00893023          	sd	s0,0(s2)
ffffffffc0202ce2:	2d5464e3          	bltu	s0,s5,ffffffffc02037aa <pmm_init+0xc8a>
ffffffffc0202ce6:	0009b783          	ld	a5,0(s3)
ffffffffc0202cea:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202cec:	8c1d                	sub	s0,s0,a5
ffffffffc0202cee:	00c45793          	srli	a5,s0,0xc
ffffffffc0202cf2:	00094717          	auipc	a4,0x94
ffffffffc0202cf6:	b8873f23          	sd	s0,-1122(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202cfa:	0147ea33          	or	s4,a5,s4
ffffffffc0202cfe:	180a1073          	csrw	satp,s4
ffffffffc0202d02:	12000073          	sfence.vma
ffffffffc0202d06:	0000a517          	auipc	a0,0xa
ffffffffc0202d0a:	a4a50513          	addi	a0,a0,-1462 # ffffffffc020c750 <default_pmm_manager+0x2a0>
ffffffffc0202d0e:	c98fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202d12:	0000e717          	auipc	a4,0xe
ffffffffc0202d16:	2ee70713          	addi	a4,a4,750 # ffffffffc0211000 <bootstack>
ffffffffc0202d1a:	0000e797          	auipc	a5,0xe
ffffffffc0202d1e:	2e678793          	addi	a5,a5,742 # ffffffffc0211000 <bootstack>
ffffffffc0202d22:	5cf70d63          	beq	a4,a5,ffffffffc02032fc <pmm_init+0x7dc>
ffffffffc0202d26:	100027f3          	csrr	a5,sstatus
ffffffffc0202d2a:	8b89                	andi	a5,a5,2
ffffffffc0202d2c:	4a079763          	bnez	a5,ffffffffc02031da <pmm_init+0x6ba>
ffffffffc0202d30:	000b3783          	ld	a5,0(s6)
ffffffffc0202d34:	779c                	ld	a5,40(a5)
ffffffffc0202d36:	9782                	jalr	a5
ffffffffc0202d38:	842a                	mv	s0,a0
ffffffffc0202d3a:	6098                	ld	a4,0(s1)
ffffffffc0202d3c:	c80007b7          	lui	a5,0xc8000
ffffffffc0202d40:	83b1                	srli	a5,a5,0xc
ffffffffc0202d42:	08e7e3e3          	bltu	a5,a4,ffffffffc02035c8 <pmm_init+0xaa8>
ffffffffc0202d46:	00093503          	ld	a0,0(s2)
ffffffffc0202d4a:	04050fe3          	beqz	a0,ffffffffc02035a8 <pmm_init+0xa88>
ffffffffc0202d4e:	03451793          	slli	a5,a0,0x34
ffffffffc0202d52:	04079be3          	bnez	a5,ffffffffc02035a8 <pmm_init+0xa88>
ffffffffc0202d56:	4601                	li	a2,0
ffffffffc0202d58:	4581                	li	a1,0
ffffffffc0202d5a:	809ff0ef          	jal	ra,ffffffffc0202562 <get_page>
ffffffffc0202d5e:	2e0511e3          	bnez	a0,ffffffffc0203840 <pmm_init+0xd20>
ffffffffc0202d62:	100027f3          	csrr	a5,sstatus
ffffffffc0202d66:	8b89                	andi	a5,a5,2
ffffffffc0202d68:	44079e63          	bnez	a5,ffffffffc02031c4 <pmm_init+0x6a4>
ffffffffc0202d6c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d70:	4505                	li	a0,1
ffffffffc0202d72:	6f9c                	ld	a5,24(a5)
ffffffffc0202d74:	9782                	jalr	a5
ffffffffc0202d76:	8a2a                	mv	s4,a0
ffffffffc0202d78:	00093503          	ld	a0,0(s2)
ffffffffc0202d7c:	4681                	li	a3,0
ffffffffc0202d7e:	4601                	li	a2,0
ffffffffc0202d80:	85d2                	mv	a1,s4
ffffffffc0202d82:	ca9ff0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0202d86:	26051be3          	bnez	a0,ffffffffc02037fc <pmm_init+0xcdc>
ffffffffc0202d8a:	00093503          	ld	a0,0(s2)
ffffffffc0202d8e:	4601                	li	a2,0
ffffffffc0202d90:	4581                	li	a1,0
ffffffffc0202d92:	ce2ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202d96:	280505e3          	beqz	a0,ffffffffc0203820 <pmm_init+0xd00>
ffffffffc0202d9a:	611c                	ld	a5,0(a0)
ffffffffc0202d9c:	0017f713          	andi	a4,a5,1
ffffffffc0202da0:	26070ee3          	beqz	a4,ffffffffc020381c <pmm_init+0xcfc>
ffffffffc0202da4:	6098                	ld	a4,0(s1)
ffffffffc0202da6:	078a                	slli	a5,a5,0x2
ffffffffc0202da8:	83b1                	srli	a5,a5,0xc
ffffffffc0202daa:	62e7f363          	bgeu	a5,a4,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc0202dae:	000bb683          	ld	a3,0(s7)
ffffffffc0202db2:	fff80637          	lui	a2,0xfff80
ffffffffc0202db6:	97b2                	add	a5,a5,a2
ffffffffc0202db8:	079a                	slli	a5,a5,0x6
ffffffffc0202dba:	97b6                	add	a5,a5,a3
ffffffffc0202dbc:	2afa12e3          	bne	s4,a5,ffffffffc0203860 <pmm_init+0xd40>
ffffffffc0202dc0:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202dc4:	4785                	li	a5,1
ffffffffc0202dc6:	2cf699e3          	bne	a3,a5,ffffffffc0203898 <pmm_init+0xd78>
ffffffffc0202dca:	00093503          	ld	a0,0(s2)
ffffffffc0202dce:	77fd                	lui	a5,0xfffff
ffffffffc0202dd0:	6114                	ld	a3,0(a0)
ffffffffc0202dd2:	068a                	slli	a3,a3,0x2
ffffffffc0202dd4:	8efd                	and	a3,a3,a5
ffffffffc0202dd6:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202dda:	2ae673e3          	bgeu	a2,a4,ffffffffc0203880 <pmm_init+0xd60>
ffffffffc0202dde:	0009bc03          	ld	s8,0(s3)
ffffffffc0202de2:	96e2                	add	a3,a3,s8
ffffffffc0202de4:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202de8:	0a8a                	slli	s5,s5,0x2
ffffffffc0202dea:	00fafab3          	and	s5,s5,a5
ffffffffc0202dee:	00cad793          	srli	a5,s5,0xc
ffffffffc0202df2:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203658 <pmm_init+0xb38>
ffffffffc0202df6:	4601                	li	a2,0
ffffffffc0202df8:	6585                	lui	a1,0x1
ffffffffc0202dfa:	9ae2                	add	s5,s5,s8
ffffffffc0202dfc:	c78ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202e00:	0aa1                	addi	s5,s5,8
ffffffffc0202e02:	03551be3          	bne	a0,s5,ffffffffc0203638 <pmm_init+0xb18>
ffffffffc0202e06:	100027f3          	csrr	a5,sstatus
ffffffffc0202e0a:	8b89                	andi	a5,a5,2
ffffffffc0202e0c:	3a079163          	bnez	a5,ffffffffc02031ae <pmm_init+0x68e>
ffffffffc0202e10:	000b3783          	ld	a5,0(s6)
ffffffffc0202e14:	4505                	li	a0,1
ffffffffc0202e16:	6f9c                	ld	a5,24(a5)
ffffffffc0202e18:	9782                	jalr	a5
ffffffffc0202e1a:	8c2a                	mv	s8,a0
ffffffffc0202e1c:	00093503          	ld	a0,0(s2)
ffffffffc0202e20:	46d1                	li	a3,20
ffffffffc0202e22:	6605                	lui	a2,0x1
ffffffffc0202e24:	85e2                	mv	a1,s8
ffffffffc0202e26:	c05ff0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0202e2a:	1a0519e3          	bnez	a0,ffffffffc02037dc <pmm_init+0xcbc>
ffffffffc0202e2e:	00093503          	ld	a0,0(s2)
ffffffffc0202e32:	4601                	li	a2,0
ffffffffc0202e34:	6585                	lui	a1,0x1
ffffffffc0202e36:	c3eff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202e3a:	10050ce3          	beqz	a0,ffffffffc0203752 <pmm_init+0xc32>
ffffffffc0202e3e:	611c                	ld	a5,0(a0)
ffffffffc0202e40:	0107f713          	andi	a4,a5,16
ffffffffc0202e44:	0e0707e3          	beqz	a4,ffffffffc0203732 <pmm_init+0xc12>
ffffffffc0202e48:	8b91                	andi	a5,a5,4
ffffffffc0202e4a:	0c0784e3          	beqz	a5,ffffffffc0203712 <pmm_init+0xbf2>
ffffffffc0202e4e:	00093503          	ld	a0,0(s2)
ffffffffc0202e52:	611c                	ld	a5,0(a0)
ffffffffc0202e54:	8bc1                	andi	a5,a5,16
ffffffffc0202e56:	08078ee3          	beqz	a5,ffffffffc02036f2 <pmm_init+0xbd2>
ffffffffc0202e5a:	000c2703          	lw	a4,0(s8)
ffffffffc0202e5e:	4785                	li	a5,1
ffffffffc0202e60:	06f719e3          	bne	a4,a5,ffffffffc02036d2 <pmm_init+0xbb2>
ffffffffc0202e64:	4681                	li	a3,0
ffffffffc0202e66:	6605                	lui	a2,0x1
ffffffffc0202e68:	85d2                	mv	a1,s4
ffffffffc0202e6a:	bc1ff0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0202e6e:	040512e3          	bnez	a0,ffffffffc02036b2 <pmm_init+0xb92>
ffffffffc0202e72:	000a2703          	lw	a4,0(s4)
ffffffffc0202e76:	4789                	li	a5,2
ffffffffc0202e78:	00f71de3          	bne	a4,a5,ffffffffc0203692 <pmm_init+0xb72>
ffffffffc0202e7c:	000c2783          	lw	a5,0(s8)
ffffffffc0202e80:	7e079963          	bnez	a5,ffffffffc0203672 <pmm_init+0xb52>
ffffffffc0202e84:	00093503          	ld	a0,0(s2)
ffffffffc0202e88:	4601                	li	a2,0
ffffffffc0202e8a:	6585                	lui	a1,0x1
ffffffffc0202e8c:	be8ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202e90:	54050263          	beqz	a0,ffffffffc02033d4 <pmm_init+0x8b4>
ffffffffc0202e94:	6118                	ld	a4,0(a0)
ffffffffc0202e96:	00177793          	andi	a5,a4,1
ffffffffc0202e9a:	180781e3          	beqz	a5,ffffffffc020381c <pmm_init+0xcfc>
ffffffffc0202e9e:	6094                	ld	a3,0(s1)
ffffffffc0202ea0:	00271793          	slli	a5,a4,0x2
ffffffffc0202ea4:	83b1                	srli	a5,a5,0xc
ffffffffc0202ea6:	52d7f563          	bgeu	a5,a3,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc0202eaa:	000bb683          	ld	a3,0(s7)
ffffffffc0202eae:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202eb2:	97d6                	add	a5,a5,s5
ffffffffc0202eb4:	079a                	slli	a5,a5,0x6
ffffffffc0202eb6:	97b6                	add	a5,a5,a3
ffffffffc0202eb8:	58fa1e63          	bne	s4,a5,ffffffffc0203454 <pmm_init+0x934>
ffffffffc0202ebc:	8b41                	andi	a4,a4,16
ffffffffc0202ebe:	56071b63          	bnez	a4,ffffffffc0203434 <pmm_init+0x914>
ffffffffc0202ec2:	00093503          	ld	a0,0(s2)
ffffffffc0202ec6:	4581                	li	a1,0
ffffffffc0202ec8:	ac7ff0ef          	jal	ra,ffffffffc020298e <page_remove>
ffffffffc0202ecc:	000a2c83          	lw	s9,0(s4)
ffffffffc0202ed0:	4785                	li	a5,1
ffffffffc0202ed2:	5cfc9163          	bne	s9,a5,ffffffffc0203494 <pmm_init+0x974>
ffffffffc0202ed6:	000c2783          	lw	a5,0(s8)
ffffffffc0202eda:	58079d63          	bnez	a5,ffffffffc0203474 <pmm_init+0x954>
ffffffffc0202ede:	00093503          	ld	a0,0(s2)
ffffffffc0202ee2:	6585                	lui	a1,0x1
ffffffffc0202ee4:	aabff0ef          	jal	ra,ffffffffc020298e <page_remove>
ffffffffc0202ee8:	000a2783          	lw	a5,0(s4)
ffffffffc0202eec:	200793e3          	bnez	a5,ffffffffc02038f2 <pmm_init+0xdd2>
ffffffffc0202ef0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ef4:	1c079fe3          	bnez	a5,ffffffffc02038d2 <pmm_init+0xdb2>
ffffffffc0202ef8:	00093a03          	ld	s4,0(s2)
ffffffffc0202efc:	608c                	ld	a1,0(s1)
ffffffffc0202efe:	000a3683          	ld	a3,0(s4)
ffffffffc0202f02:	068a                	slli	a3,a3,0x2
ffffffffc0202f04:	82b1                	srli	a3,a3,0xc
ffffffffc0202f06:	4cb6f563          	bgeu	a3,a1,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc0202f0a:	000bb503          	ld	a0,0(s7)
ffffffffc0202f0e:	96d6                	add	a3,a3,s5
ffffffffc0202f10:	069a                	slli	a3,a3,0x6
ffffffffc0202f12:	00d507b3          	add	a5,a0,a3
ffffffffc0202f16:	439c                	lw	a5,0(a5)
ffffffffc0202f18:	4f979e63          	bne	a5,s9,ffffffffc0203414 <pmm_init+0x8f4>
ffffffffc0202f1c:	8699                	srai	a3,a3,0x6
ffffffffc0202f1e:	00080637          	lui	a2,0x80
ffffffffc0202f22:	96b2                	add	a3,a3,a2
ffffffffc0202f24:	00c69713          	slli	a4,a3,0xc
ffffffffc0202f28:	8331                	srli	a4,a4,0xc
ffffffffc0202f2a:	06b2                	slli	a3,a3,0xc
ffffffffc0202f2c:	06b773e3          	bgeu	a4,a1,ffffffffc0203792 <pmm_init+0xc72>
ffffffffc0202f30:	0009b703          	ld	a4,0(s3)
ffffffffc0202f34:	96ba                	add	a3,a3,a4
ffffffffc0202f36:	629c                	ld	a5,0(a3)
ffffffffc0202f38:	078a                	slli	a5,a5,0x2
ffffffffc0202f3a:	83b1                	srli	a5,a5,0xc
ffffffffc0202f3c:	48b7fa63          	bgeu	a5,a1,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc0202f40:	8f91                	sub	a5,a5,a2
ffffffffc0202f42:	079a                	slli	a5,a5,0x6
ffffffffc0202f44:	953e                	add	a0,a0,a5
ffffffffc0202f46:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4a:	8b89                	andi	a5,a5,2
ffffffffc0202f4c:	32079463          	bnez	a5,ffffffffc0203274 <pmm_init+0x754>
ffffffffc0202f50:	000b3783          	ld	a5,0(s6)
ffffffffc0202f54:	4585                	li	a1,1
ffffffffc0202f56:	739c                	ld	a5,32(a5)
ffffffffc0202f58:	9782                	jalr	a5
ffffffffc0202f5a:	000a3783          	ld	a5,0(s4)
ffffffffc0202f5e:	6098                	ld	a4,0(s1)
ffffffffc0202f60:	078a                	slli	a5,a5,0x2
ffffffffc0202f62:	83b1                	srli	a5,a5,0xc
ffffffffc0202f64:	46e7f663          	bgeu	a5,a4,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc0202f68:	000bb503          	ld	a0,0(s7)
ffffffffc0202f6c:	fff80737          	lui	a4,0xfff80
ffffffffc0202f70:	97ba                	add	a5,a5,a4
ffffffffc0202f72:	079a                	slli	a5,a5,0x6
ffffffffc0202f74:	953e                	add	a0,a0,a5
ffffffffc0202f76:	100027f3          	csrr	a5,sstatus
ffffffffc0202f7a:	8b89                	andi	a5,a5,2
ffffffffc0202f7c:	2e079063          	bnez	a5,ffffffffc020325c <pmm_init+0x73c>
ffffffffc0202f80:	000b3783          	ld	a5,0(s6)
ffffffffc0202f84:	4585                	li	a1,1
ffffffffc0202f86:	739c                	ld	a5,32(a5)
ffffffffc0202f88:	9782                	jalr	a5
ffffffffc0202f8a:	00093783          	ld	a5,0(s2)
ffffffffc0202f8e:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0202f92:	12000073          	sfence.vma
ffffffffc0202f96:	100027f3          	csrr	a5,sstatus
ffffffffc0202f9a:	8b89                	andi	a5,a5,2
ffffffffc0202f9c:	2a079663          	bnez	a5,ffffffffc0203248 <pmm_init+0x728>
ffffffffc0202fa0:	000b3783          	ld	a5,0(s6)
ffffffffc0202fa4:	779c                	ld	a5,40(a5)
ffffffffc0202fa6:	9782                	jalr	a5
ffffffffc0202fa8:	8a2a                	mv	s4,a0
ffffffffc0202faa:	7d441463          	bne	s0,s4,ffffffffc0203772 <pmm_init+0xc52>
ffffffffc0202fae:	0000a517          	auipc	a0,0xa
ffffffffc0202fb2:	afa50513          	addi	a0,a0,-1286 # ffffffffc020caa8 <default_pmm_manager+0x5f8>
ffffffffc0202fb6:	9f0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202fba:	100027f3          	csrr	a5,sstatus
ffffffffc0202fbe:	8b89                	andi	a5,a5,2
ffffffffc0202fc0:	26079a63          	bnez	a5,ffffffffc0203234 <pmm_init+0x714>
ffffffffc0202fc4:	000b3783          	ld	a5,0(s6)
ffffffffc0202fc8:	779c                	ld	a5,40(a5)
ffffffffc0202fca:	9782                	jalr	a5
ffffffffc0202fcc:	8c2a                	mv	s8,a0
ffffffffc0202fce:	6098                	ld	a4,0(s1)
ffffffffc0202fd0:	c0200437          	lui	s0,0xc0200
ffffffffc0202fd4:	7afd                	lui	s5,0xfffff
ffffffffc0202fd6:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fda:	6a05                	lui	s4,0x1
ffffffffc0202fdc:	02f47c63          	bgeu	s0,a5,ffffffffc0203014 <pmm_init+0x4f4>
ffffffffc0202fe0:	00c45793          	srli	a5,s0,0xc
ffffffffc0202fe4:	00093503          	ld	a0,0(s2)
ffffffffc0202fe8:	3ae7f763          	bgeu	a5,a4,ffffffffc0203396 <pmm_init+0x876>
ffffffffc0202fec:	0009b583          	ld	a1,0(s3)
ffffffffc0202ff0:	4601                	li	a2,0
ffffffffc0202ff2:	95a2                	add	a1,a1,s0
ffffffffc0202ff4:	a80ff0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc0202ff8:	36050f63          	beqz	a0,ffffffffc0203376 <pmm_init+0x856>
ffffffffc0202ffc:	611c                	ld	a5,0(a0)
ffffffffc0202ffe:	078a                	slli	a5,a5,0x2
ffffffffc0203000:	0157f7b3          	and	a5,a5,s5
ffffffffc0203004:	3a879663          	bne	a5,s0,ffffffffc02033b0 <pmm_init+0x890>
ffffffffc0203008:	6098                	ld	a4,0(s1)
ffffffffc020300a:	9452                	add	s0,s0,s4
ffffffffc020300c:	00c71793          	slli	a5,a4,0xc
ffffffffc0203010:	fcf468e3          	bltu	s0,a5,ffffffffc0202fe0 <pmm_init+0x4c0>
ffffffffc0203014:	00093783          	ld	a5,0(s2)
ffffffffc0203018:	639c                	ld	a5,0(a5)
ffffffffc020301a:	48079d63          	bnez	a5,ffffffffc02034b4 <pmm_init+0x994>
ffffffffc020301e:	100027f3          	csrr	a5,sstatus
ffffffffc0203022:	8b89                	andi	a5,a5,2
ffffffffc0203024:	26079463          	bnez	a5,ffffffffc020328c <pmm_init+0x76c>
ffffffffc0203028:	000b3783          	ld	a5,0(s6)
ffffffffc020302c:	4505                	li	a0,1
ffffffffc020302e:	6f9c                	ld	a5,24(a5)
ffffffffc0203030:	9782                	jalr	a5
ffffffffc0203032:	8a2a                	mv	s4,a0
ffffffffc0203034:	00093503          	ld	a0,0(s2)
ffffffffc0203038:	4699                	li	a3,6
ffffffffc020303a:	10000613          	li	a2,256
ffffffffc020303e:	85d2                	mv	a1,s4
ffffffffc0203040:	9ebff0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0203044:	4a051863          	bnez	a0,ffffffffc02034f4 <pmm_init+0x9d4>
ffffffffc0203048:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020304c:	4785                	li	a5,1
ffffffffc020304e:	48f71363          	bne	a4,a5,ffffffffc02034d4 <pmm_init+0x9b4>
ffffffffc0203052:	00093503          	ld	a0,0(s2)
ffffffffc0203056:	6405                	lui	s0,0x1
ffffffffc0203058:	4699                	li	a3,6
ffffffffc020305a:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc020305e:	85d2                	mv	a1,s4
ffffffffc0203060:	9cbff0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0203064:	38051863          	bnez	a0,ffffffffc02033f4 <pmm_init+0x8d4>
ffffffffc0203068:	000a2703          	lw	a4,0(s4)
ffffffffc020306c:	4789                	li	a5,2
ffffffffc020306e:	4ef71363          	bne	a4,a5,ffffffffc0203554 <pmm_init+0xa34>
ffffffffc0203072:	0000a597          	auipc	a1,0xa
ffffffffc0203076:	b7e58593          	addi	a1,a1,-1154 # ffffffffc020cbf0 <default_pmm_manager+0x740>
ffffffffc020307a:	10000513          	li	a0,256
ffffffffc020307e:	3da080ef          	jal	ra,ffffffffc020b458 <strcpy>
ffffffffc0203082:	10040593          	addi	a1,s0,256
ffffffffc0203086:	10000513          	li	a0,256
ffffffffc020308a:	3e0080ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc020308e:	4a051363          	bnez	a0,ffffffffc0203534 <pmm_init+0xa14>
ffffffffc0203092:	000bb683          	ld	a3,0(s7)
ffffffffc0203096:	00080737          	lui	a4,0x80
ffffffffc020309a:	547d                	li	s0,-1
ffffffffc020309c:	40da06b3          	sub	a3,s4,a3
ffffffffc02030a0:	8699                	srai	a3,a3,0x6
ffffffffc02030a2:	609c                	ld	a5,0(s1)
ffffffffc02030a4:	96ba                	add	a3,a3,a4
ffffffffc02030a6:	8031                	srli	s0,s0,0xc
ffffffffc02030a8:	0086f733          	and	a4,a3,s0
ffffffffc02030ac:	06b2                	slli	a3,a3,0xc
ffffffffc02030ae:	6ef77263          	bgeu	a4,a5,ffffffffc0203792 <pmm_init+0xc72>
ffffffffc02030b2:	0009b783          	ld	a5,0(s3)
ffffffffc02030b6:	10000513          	li	a0,256
ffffffffc02030ba:	96be                	add	a3,a3,a5
ffffffffc02030bc:	10068023          	sb	zero,256(a3)
ffffffffc02030c0:	362080ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc02030c4:	44051863          	bnez	a0,ffffffffc0203514 <pmm_init+0x9f4>
ffffffffc02030c8:	00093a83          	ld	s5,0(s2)
ffffffffc02030cc:	609c                	ld	a5,0(s1)
ffffffffc02030ce:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc02030d2:	068a                	slli	a3,a3,0x2
ffffffffc02030d4:	82b1                	srli	a3,a3,0xc
ffffffffc02030d6:	2ef6fd63          	bgeu	a3,a5,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc02030da:	8c75                	and	s0,s0,a3
ffffffffc02030dc:	06b2                	slli	a3,a3,0xc
ffffffffc02030de:	6af47a63          	bgeu	s0,a5,ffffffffc0203792 <pmm_init+0xc72>
ffffffffc02030e2:	0009b403          	ld	s0,0(s3)
ffffffffc02030e6:	9436                	add	s0,s0,a3
ffffffffc02030e8:	100027f3          	csrr	a5,sstatus
ffffffffc02030ec:	8b89                	andi	a5,a5,2
ffffffffc02030ee:	1e079c63          	bnez	a5,ffffffffc02032e6 <pmm_init+0x7c6>
ffffffffc02030f2:	000b3783          	ld	a5,0(s6)
ffffffffc02030f6:	4585                	li	a1,1
ffffffffc02030f8:	8552                	mv	a0,s4
ffffffffc02030fa:	739c                	ld	a5,32(a5)
ffffffffc02030fc:	9782                	jalr	a5
ffffffffc02030fe:	601c                	ld	a5,0(s0)
ffffffffc0203100:	6098                	ld	a4,0(s1)
ffffffffc0203102:	078a                	slli	a5,a5,0x2
ffffffffc0203104:	83b1                	srli	a5,a5,0xc
ffffffffc0203106:	2ce7f563          	bgeu	a5,a4,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc020310a:	000bb503          	ld	a0,0(s7)
ffffffffc020310e:	fff80737          	lui	a4,0xfff80
ffffffffc0203112:	97ba                	add	a5,a5,a4
ffffffffc0203114:	079a                	slli	a5,a5,0x6
ffffffffc0203116:	953e                	add	a0,a0,a5
ffffffffc0203118:	100027f3          	csrr	a5,sstatus
ffffffffc020311c:	8b89                	andi	a5,a5,2
ffffffffc020311e:	1a079863          	bnez	a5,ffffffffc02032ce <pmm_init+0x7ae>
ffffffffc0203122:	000b3783          	ld	a5,0(s6)
ffffffffc0203126:	4585                	li	a1,1
ffffffffc0203128:	739c                	ld	a5,32(a5)
ffffffffc020312a:	9782                	jalr	a5
ffffffffc020312c:	000ab783          	ld	a5,0(s5)
ffffffffc0203130:	6098                	ld	a4,0(s1)
ffffffffc0203132:	078a                	slli	a5,a5,0x2
ffffffffc0203134:	83b1                	srli	a5,a5,0xc
ffffffffc0203136:	28e7fd63          	bgeu	a5,a4,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc020313a:	000bb503          	ld	a0,0(s7)
ffffffffc020313e:	fff80737          	lui	a4,0xfff80
ffffffffc0203142:	97ba                	add	a5,a5,a4
ffffffffc0203144:	079a                	slli	a5,a5,0x6
ffffffffc0203146:	953e                	add	a0,a0,a5
ffffffffc0203148:	100027f3          	csrr	a5,sstatus
ffffffffc020314c:	8b89                	andi	a5,a5,2
ffffffffc020314e:	16079463          	bnez	a5,ffffffffc02032b6 <pmm_init+0x796>
ffffffffc0203152:	000b3783          	ld	a5,0(s6)
ffffffffc0203156:	4585                	li	a1,1
ffffffffc0203158:	739c                	ld	a5,32(a5)
ffffffffc020315a:	9782                	jalr	a5
ffffffffc020315c:	00093783          	ld	a5,0(s2)
ffffffffc0203160:	0007b023          	sd	zero,0(a5)
ffffffffc0203164:	12000073          	sfence.vma
ffffffffc0203168:	100027f3          	csrr	a5,sstatus
ffffffffc020316c:	8b89                	andi	a5,a5,2
ffffffffc020316e:	12079a63          	bnez	a5,ffffffffc02032a2 <pmm_init+0x782>
ffffffffc0203172:	000b3783          	ld	a5,0(s6)
ffffffffc0203176:	779c                	ld	a5,40(a5)
ffffffffc0203178:	9782                	jalr	a5
ffffffffc020317a:	842a                	mv	s0,a0
ffffffffc020317c:	488c1e63          	bne	s8,s0,ffffffffc0203618 <pmm_init+0xaf8>
ffffffffc0203180:	0000a517          	auipc	a0,0xa
ffffffffc0203184:	ae850513          	addi	a0,a0,-1304 # ffffffffc020cc68 <default_pmm_manager+0x7b8>
ffffffffc0203188:	81efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020318c:	7406                	ld	s0,96(sp)
ffffffffc020318e:	70a6                	ld	ra,104(sp)
ffffffffc0203190:	64e6                	ld	s1,88(sp)
ffffffffc0203192:	6946                	ld	s2,80(sp)
ffffffffc0203194:	69a6                	ld	s3,72(sp)
ffffffffc0203196:	6a06                	ld	s4,64(sp)
ffffffffc0203198:	7ae2                	ld	s5,56(sp)
ffffffffc020319a:	7b42                	ld	s6,48(sp)
ffffffffc020319c:	7ba2                	ld	s7,40(sp)
ffffffffc020319e:	7c02                	ld	s8,32(sp)
ffffffffc02031a0:	6ce2                	ld	s9,24(sp)
ffffffffc02031a2:	6165                	addi	sp,sp,112
ffffffffc02031a4:	e17fe06f          	j	ffffffffc0201fba <kmalloc_init>
ffffffffc02031a8:	c80007b7          	lui	a5,0xc8000
ffffffffc02031ac:	b411                	j	ffffffffc0202bb0 <pmm_init+0x90>
ffffffffc02031ae:	ac5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031b2:	000b3783          	ld	a5,0(s6)
ffffffffc02031b6:	4505                	li	a0,1
ffffffffc02031b8:	6f9c                	ld	a5,24(a5)
ffffffffc02031ba:	9782                	jalr	a5
ffffffffc02031bc:	8c2a                	mv	s8,a0
ffffffffc02031be:	aaffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031c2:	b9a9                	j	ffffffffc0202e1c <pmm_init+0x2fc>
ffffffffc02031c4:	aaffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031c8:	000b3783          	ld	a5,0(s6)
ffffffffc02031cc:	4505                	li	a0,1
ffffffffc02031ce:	6f9c                	ld	a5,24(a5)
ffffffffc02031d0:	9782                	jalr	a5
ffffffffc02031d2:	8a2a                	mv	s4,a0
ffffffffc02031d4:	a99fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031d8:	b645                	j	ffffffffc0202d78 <pmm_init+0x258>
ffffffffc02031da:	a99fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031de:	000b3783          	ld	a5,0(s6)
ffffffffc02031e2:	779c                	ld	a5,40(a5)
ffffffffc02031e4:	9782                	jalr	a5
ffffffffc02031e6:	842a                	mv	s0,a0
ffffffffc02031e8:	a85fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031ec:	b6b9                	j	ffffffffc0202d3a <pmm_init+0x21a>
ffffffffc02031ee:	a85fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031f2:	000b3783          	ld	a5,0(s6)
ffffffffc02031f6:	4505                	li	a0,1
ffffffffc02031f8:	6f9c                	ld	a5,24(a5)
ffffffffc02031fa:	9782                	jalr	a5
ffffffffc02031fc:	842a                	mv	s0,a0
ffffffffc02031fe:	a6ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203202:	bc99                	j	ffffffffc0202c58 <pmm_init+0x138>
ffffffffc0203204:	6705                	lui	a4,0x1
ffffffffc0203206:	177d                	addi	a4,a4,-1
ffffffffc0203208:	96ba                	add	a3,a3,a4
ffffffffc020320a:	8ff5                	and	a5,a5,a3
ffffffffc020320c:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203210:	1ca77063          	bgeu	a4,a0,ffffffffc02033d0 <pmm_init+0x8b0>
ffffffffc0203214:	000b3683          	ld	a3,0(s6)
ffffffffc0203218:	fff80537          	lui	a0,0xfff80
ffffffffc020321c:	972a                	add	a4,a4,a0
ffffffffc020321e:	6a94                	ld	a3,16(a3)
ffffffffc0203220:	8c1d                	sub	s0,s0,a5
ffffffffc0203222:	00671513          	slli	a0,a4,0x6
ffffffffc0203226:	00c45593          	srli	a1,s0,0xc
ffffffffc020322a:	9532                	add	a0,a0,a2
ffffffffc020322c:	9682                	jalr	a3
ffffffffc020322e:	0009b583          	ld	a1,0(s3)
ffffffffc0203232:	bac5                	j	ffffffffc0202c22 <pmm_init+0x102>
ffffffffc0203234:	a3ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203238:	000b3783          	ld	a5,0(s6)
ffffffffc020323c:	779c                	ld	a5,40(a5)
ffffffffc020323e:	9782                	jalr	a5
ffffffffc0203240:	8c2a                	mv	s8,a0
ffffffffc0203242:	a2bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203246:	b361                	j	ffffffffc0202fce <pmm_init+0x4ae>
ffffffffc0203248:	a2bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020324c:	000b3783          	ld	a5,0(s6)
ffffffffc0203250:	779c                	ld	a5,40(a5)
ffffffffc0203252:	9782                	jalr	a5
ffffffffc0203254:	8a2a                	mv	s4,a0
ffffffffc0203256:	a17fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020325a:	bb81                	j	ffffffffc0202faa <pmm_init+0x48a>
ffffffffc020325c:	e42a                	sd	a0,8(sp)
ffffffffc020325e:	a15fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203262:	000b3783          	ld	a5,0(s6)
ffffffffc0203266:	6522                	ld	a0,8(sp)
ffffffffc0203268:	4585                	li	a1,1
ffffffffc020326a:	739c                	ld	a5,32(a5)
ffffffffc020326c:	9782                	jalr	a5
ffffffffc020326e:	9fffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203272:	bb21                	j	ffffffffc0202f8a <pmm_init+0x46a>
ffffffffc0203274:	e42a                	sd	a0,8(sp)
ffffffffc0203276:	9fdfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020327a:	000b3783          	ld	a5,0(s6)
ffffffffc020327e:	6522                	ld	a0,8(sp)
ffffffffc0203280:	4585                	li	a1,1
ffffffffc0203282:	739c                	ld	a5,32(a5)
ffffffffc0203284:	9782                	jalr	a5
ffffffffc0203286:	9e7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020328a:	b9c1                	j	ffffffffc0202f5a <pmm_init+0x43a>
ffffffffc020328c:	9e7fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203290:	000b3783          	ld	a5,0(s6)
ffffffffc0203294:	4505                	li	a0,1
ffffffffc0203296:	6f9c                	ld	a5,24(a5)
ffffffffc0203298:	9782                	jalr	a5
ffffffffc020329a:	8a2a                	mv	s4,a0
ffffffffc020329c:	9d1fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032a0:	bb51                	j	ffffffffc0203034 <pmm_init+0x514>
ffffffffc02032a2:	9d1fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032a6:	000b3783          	ld	a5,0(s6)
ffffffffc02032aa:	779c                	ld	a5,40(a5)
ffffffffc02032ac:	9782                	jalr	a5
ffffffffc02032ae:	842a                	mv	s0,a0
ffffffffc02032b0:	9bdfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032b4:	b5e1                	j	ffffffffc020317c <pmm_init+0x65c>
ffffffffc02032b6:	e42a                	sd	a0,8(sp)
ffffffffc02032b8:	9bbfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032bc:	000b3783          	ld	a5,0(s6)
ffffffffc02032c0:	6522                	ld	a0,8(sp)
ffffffffc02032c2:	4585                	li	a1,1
ffffffffc02032c4:	739c                	ld	a5,32(a5)
ffffffffc02032c6:	9782                	jalr	a5
ffffffffc02032c8:	9a5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032cc:	bd41                	j	ffffffffc020315c <pmm_init+0x63c>
ffffffffc02032ce:	e42a                	sd	a0,8(sp)
ffffffffc02032d0:	9a3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032d4:	000b3783          	ld	a5,0(s6)
ffffffffc02032d8:	6522                	ld	a0,8(sp)
ffffffffc02032da:	4585                	li	a1,1
ffffffffc02032dc:	739c                	ld	a5,32(a5)
ffffffffc02032de:	9782                	jalr	a5
ffffffffc02032e0:	98dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032e4:	b5a1                	j	ffffffffc020312c <pmm_init+0x60c>
ffffffffc02032e6:	98dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02032ea:	000b3783          	ld	a5,0(s6)
ffffffffc02032ee:	4585                	li	a1,1
ffffffffc02032f0:	8552                	mv	a0,s4
ffffffffc02032f2:	739c                	ld	a5,32(a5)
ffffffffc02032f4:	9782                	jalr	a5
ffffffffc02032f6:	977fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032fa:	b511                	j	ffffffffc02030fe <pmm_init+0x5de>
ffffffffc02032fc:	00010417          	auipc	s0,0x10
ffffffffc0203300:	d0440413          	addi	s0,s0,-764 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc0203304:	00010797          	auipc	a5,0x10
ffffffffc0203308:	cfc78793          	addi	a5,a5,-772 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc020330c:	a0f41de3          	bne	s0,a5,ffffffffc0202d26 <pmm_init+0x206>
ffffffffc0203310:	4581                	li	a1,0
ffffffffc0203312:	6605                	lui	a2,0x1
ffffffffc0203314:	8522                	mv	a0,s0
ffffffffc0203316:	1ae080ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc020331a:	0000d597          	auipc	a1,0xd
ffffffffc020331e:	ce658593          	addi	a1,a1,-794 # ffffffffc0210000 <bootstackguard>
ffffffffc0203322:	0000e797          	auipc	a5,0xe
ffffffffc0203326:	cc078ea3          	sb	zero,-803(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc020332a:	0000d797          	auipc	a5,0xd
ffffffffc020332e:	cc078b23          	sb	zero,-810(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc0203332:	00093503          	ld	a0,0(s2)
ffffffffc0203336:	2555ec63          	bltu	a1,s5,ffffffffc020358e <pmm_init+0xa6e>
ffffffffc020333a:	0009b683          	ld	a3,0(s3)
ffffffffc020333e:	4701                	li	a4,0
ffffffffc0203340:	6605                	lui	a2,0x1
ffffffffc0203342:	40d586b3          	sub	a3,a1,a3
ffffffffc0203346:	956ff0ef          	jal	ra,ffffffffc020249c <boot_map_segment>
ffffffffc020334a:	00093503          	ld	a0,0(s2)
ffffffffc020334e:	23546363          	bltu	s0,s5,ffffffffc0203574 <pmm_init+0xa54>
ffffffffc0203352:	0009b683          	ld	a3,0(s3)
ffffffffc0203356:	4701                	li	a4,0
ffffffffc0203358:	6605                	lui	a2,0x1
ffffffffc020335a:	40d406b3          	sub	a3,s0,a3
ffffffffc020335e:	85a2                	mv	a1,s0
ffffffffc0203360:	93cff0ef          	jal	ra,ffffffffc020249c <boot_map_segment>
ffffffffc0203364:	12000073          	sfence.vma
ffffffffc0203368:	00009517          	auipc	a0,0x9
ffffffffc020336c:	41050513          	addi	a0,a0,1040 # ffffffffc020c778 <default_pmm_manager+0x2c8>
ffffffffc0203370:	e37fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203374:	ba4d                	j	ffffffffc0202d26 <pmm_init+0x206>
ffffffffc0203376:	00009697          	auipc	a3,0x9
ffffffffc020337a:	75268693          	addi	a3,a3,1874 # ffffffffc020cac8 <default_pmm_manager+0x618>
ffffffffc020337e:	00008617          	auipc	a2,0x8
ffffffffc0203382:	62a60613          	addi	a2,a2,1578 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203386:	28d00593          	li	a1,653
ffffffffc020338a:	00009517          	auipc	a0,0x9
ffffffffc020338e:	27650513          	addi	a0,a0,630 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203392:	90cfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203396:	86a2                	mv	a3,s0
ffffffffc0203398:	00009617          	auipc	a2,0x9
ffffffffc020339c:	15060613          	addi	a2,a2,336 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc02033a0:	28d00593          	li	a1,653
ffffffffc02033a4:	00009517          	auipc	a0,0x9
ffffffffc02033a8:	25c50513          	addi	a0,a0,604 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02033ac:	8f2fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033b0:	00009697          	auipc	a3,0x9
ffffffffc02033b4:	75868693          	addi	a3,a3,1880 # ffffffffc020cb08 <default_pmm_manager+0x658>
ffffffffc02033b8:	00008617          	auipc	a2,0x8
ffffffffc02033bc:	5f060613          	addi	a2,a2,1520 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02033c0:	28e00593          	li	a1,654
ffffffffc02033c4:	00009517          	auipc	a0,0x9
ffffffffc02033c8:	23c50513          	addi	a0,a0,572 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02033cc:	8d2fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033d0:	db5fe0ef          	jal	ra,ffffffffc0202184 <pa2page.part.0>
ffffffffc02033d4:	00009697          	auipc	a3,0x9
ffffffffc02033d8:	55c68693          	addi	a3,a3,1372 # ffffffffc020c930 <default_pmm_manager+0x480>
ffffffffc02033dc:	00008617          	auipc	a2,0x8
ffffffffc02033e0:	5cc60613          	addi	a2,a2,1484 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02033e4:	26a00593          	li	a1,618
ffffffffc02033e8:	00009517          	auipc	a0,0x9
ffffffffc02033ec:	21850513          	addi	a0,a0,536 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02033f0:	8aefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033f4:	00009697          	auipc	a3,0x9
ffffffffc02033f8:	79c68693          	addi	a3,a3,1948 # ffffffffc020cb90 <default_pmm_manager+0x6e0>
ffffffffc02033fc:	00008617          	auipc	a2,0x8
ffffffffc0203400:	5ac60613          	addi	a2,a2,1452 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203404:	29700593          	li	a1,663
ffffffffc0203408:	00009517          	auipc	a0,0x9
ffffffffc020340c:	1f850513          	addi	a0,a0,504 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203410:	88efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203414:	00009697          	auipc	a3,0x9
ffffffffc0203418:	63c68693          	addi	a3,a3,1596 # ffffffffc020ca50 <default_pmm_manager+0x5a0>
ffffffffc020341c:	00008617          	auipc	a2,0x8
ffffffffc0203420:	58c60613          	addi	a2,a2,1420 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203424:	27600593          	li	a1,630
ffffffffc0203428:	00009517          	auipc	a0,0x9
ffffffffc020342c:	1d850513          	addi	a0,a0,472 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203430:	86efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203434:	00009697          	auipc	a3,0x9
ffffffffc0203438:	5ec68693          	addi	a3,a3,1516 # ffffffffc020ca20 <default_pmm_manager+0x570>
ffffffffc020343c:	00008617          	auipc	a2,0x8
ffffffffc0203440:	56c60613          	addi	a2,a2,1388 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203444:	26c00593          	li	a1,620
ffffffffc0203448:	00009517          	auipc	a0,0x9
ffffffffc020344c:	1b850513          	addi	a0,a0,440 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203450:	84efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203454:	00009697          	auipc	a3,0x9
ffffffffc0203458:	43c68693          	addi	a3,a3,1084 # ffffffffc020c890 <default_pmm_manager+0x3e0>
ffffffffc020345c:	00008617          	auipc	a2,0x8
ffffffffc0203460:	54c60613          	addi	a2,a2,1356 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203464:	26b00593          	li	a1,619
ffffffffc0203468:	00009517          	auipc	a0,0x9
ffffffffc020346c:	19850513          	addi	a0,a0,408 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203470:	82efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203474:	00009697          	auipc	a3,0x9
ffffffffc0203478:	59468693          	addi	a3,a3,1428 # ffffffffc020ca08 <default_pmm_manager+0x558>
ffffffffc020347c:	00008617          	auipc	a2,0x8
ffffffffc0203480:	52c60613          	addi	a2,a2,1324 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203484:	27000593          	li	a1,624
ffffffffc0203488:	00009517          	auipc	a0,0x9
ffffffffc020348c:	17850513          	addi	a0,a0,376 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203490:	80efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203494:	00009697          	auipc	a3,0x9
ffffffffc0203498:	41468693          	addi	a3,a3,1044 # ffffffffc020c8a8 <default_pmm_manager+0x3f8>
ffffffffc020349c:	00008617          	auipc	a2,0x8
ffffffffc02034a0:	50c60613          	addi	a2,a2,1292 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02034a4:	26f00593          	li	a1,623
ffffffffc02034a8:	00009517          	auipc	a0,0x9
ffffffffc02034ac:	15850513          	addi	a0,a0,344 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02034b0:	feffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034b4:	00009697          	auipc	a3,0x9
ffffffffc02034b8:	66c68693          	addi	a3,a3,1644 # ffffffffc020cb20 <default_pmm_manager+0x670>
ffffffffc02034bc:	00008617          	auipc	a2,0x8
ffffffffc02034c0:	4ec60613          	addi	a2,a2,1260 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02034c4:	29100593          	li	a1,657
ffffffffc02034c8:	00009517          	auipc	a0,0x9
ffffffffc02034cc:	13850513          	addi	a0,a0,312 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02034d0:	fcffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034d4:	00009697          	auipc	a3,0x9
ffffffffc02034d8:	6a468693          	addi	a3,a3,1700 # ffffffffc020cb78 <default_pmm_manager+0x6c8>
ffffffffc02034dc:	00008617          	auipc	a2,0x8
ffffffffc02034e0:	4cc60613          	addi	a2,a2,1228 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02034e4:	29600593          	li	a1,662
ffffffffc02034e8:	00009517          	auipc	a0,0x9
ffffffffc02034ec:	11850513          	addi	a0,a0,280 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02034f0:	faffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034f4:	00009697          	auipc	a3,0x9
ffffffffc02034f8:	64468693          	addi	a3,a3,1604 # ffffffffc020cb38 <default_pmm_manager+0x688>
ffffffffc02034fc:	00008617          	auipc	a2,0x8
ffffffffc0203500:	4ac60613          	addi	a2,a2,1196 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203504:	29500593          	li	a1,661
ffffffffc0203508:	00009517          	auipc	a0,0x9
ffffffffc020350c:	0f850513          	addi	a0,a0,248 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203510:	f8ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203514:	00009697          	auipc	a3,0x9
ffffffffc0203518:	72c68693          	addi	a3,a3,1836 # ffffffffc020cc40 <default_pmm_manager+0x790>
ffffffffc020351c:	00008617          	auipc	a2,0x8
ffffffffc0203520:	48c60613          	addi	a2,a2,1164 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203524:	29f00593          	li	a1,671
ffffffffc0203528:	00009517          	auipc	a0,0x9
ffffffffc020352c:	0d850513          	addi	a0,a0,216 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203530:	f6ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203534:	00009697          	auipc	a3,0x9
ffffffffc0203538:	6d468693          	addi	a3,a3,1748 # ffffffffc020cc08 <default_pmm_manager+0x758>
ffffffffc020353c:	00008617          	auipc	a2,0x8
ffffffffc0203540:	46c60613          	addi	a2,a2,1132 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203544:	29c00593          	li	a1,668
ffffffffc0203548:	00009517          	auipc	a0,0x9
ffffffffc020354c:	0b850513          	addi	a0,a0,184 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203550:	f4ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203554:	00009697          	auipc	a3,0x9
ffffffffc0203558:	68468693          	addi	a3,a3,1668 # ffffffffc020cbd8 <default_pmm_manager+0x728>
ffffffffc020355c:	00008617          	auipc	a2,0x8
ffffffffc0203560:	44c60613          	addi	a2,a2,1100 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203564:	29800593          	li	a1,664
ffffffffc0203568:	00009517          	auipc	a0,0x9
ffffffffc020356c:	09850513          	addi	a0,a0,152 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203570:	f2ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203574:	86a2                	mv	a3,s0
ffffffffc0203576:	00009617          	auipc	a2,0x9
ffffffffc020357a:	01a60613          	addi	a2,a2,26 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc020357e:	0dc00593          	li	a1,220
ffffffffc0203582:	00009517          	auipc	a0,0x9
ffffffffc0203586:	07e50513          	addi	a0,a0,126 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020358a:	f15fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020358e:	86ae                	mv	a3,a1
ffffffffc0203590:	00009617          	auipc	a2,0x9
ffffffffc0203594:	00060613          	mv	a2,a2
ffffffffc0203598:	0db00593          	li	a1,219
ffffffffc020359c:	00009517          	auipc	a0,0x9
ffffffffc02035a0:	06450513          	addi	a0,a0,100 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02035a4:	efbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035a8:	00009697          	auipc	a3,0x9
ffffffffc02035ac:	21868693          	addi	a3,a3,536 # ffffffffc020c7c0 <default_pmm_manager+0x310>
ffffffffc02035b0:	00008617          	auipc	a2,0x8
ffffffffc02035b4:	3f860613          	addi	a2,a2,1016 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02035b8:	24f00593          	li	a1,591
ffffffffc02035bc:	00009517          	auipc	a0,0x9
ffffffffc02035c0:	04450513          	addi	a0,a0,68 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02035c4:	edbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c8:	00009697          	auipc	a3,0x9
ffffffffc02035cc:	1d868693          	addi	a3,a3,472 # ffffffffc020c7a0 <default_pmm_manager+0x2f0>
ffffffffc02035d0:	00008617          	auipc	a2,0x8
ffffffffc02035d4:	3d860613          	addi	a2,a2,984 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02035d8:	24e00593          	li	a1,590
ffffffffc02035dc:	00009517          	auipc	a0,0x9
ffffffffc02035e0:	02450513          	addi	a0,a0,36 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02035e4:	ebbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e8:	00009617          	auipc	a2,0x9
ffffffffc02035ec:	14860613          	addi	a2,a2,328 # ffffffffc020c730 <default_pmm_manager+0x280>
ffffffffc02035f0:	0aa00593          	li	a1,170
ffffffffc02035f4:	00009517          	auipc	a0,0x9
ffffffffc02035f8:	00c50513          	addi	a0,a0,12 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02035fc:	ea3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203600:	00009617          	auipc	a2,0x9
ffffffffc0203604:	09860613          	addi	a2,a2,152 # ffffffffc020c698 <default_pmm_manager+0x1e8>
ffffffffc0203608:	06500593          	li	a1,101
ffffffffc020360c:	00009517          	auipc	a0,0x9
ffffffffc0203610:	ff450513          	addi	a0,a0,-12 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203614:	e8bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203618:	00009697          	auipc	a3,0x9
ffffffffc020361c:	46868693          	addi	a3,a3,1128 # ffffffffc020ca80 <default_pmm_manager+0x5d0>
ffffffffc0203620:	00008617          	auipc	a2,0x8
ffffffffc0203624:	38860613          	addi	a2,a2,904 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203628:	2a800593          	li	a1,680
ffffffffc020362c:	00009517          	auipc	a0,0x9
ffffffffc0203630:	fd450513          	addi	a0,a0,-44 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203634:	e6bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203638:	00009697          	auipc	a3,0x9
ffffffffc020363c:	28868693          	addi	a3,a3,648 # ffffffffc020c8c0 <default_pmm_manager+0x410>
ffffffffc0203640:	00008617          	auipc	a2,0x8
ffffffffc0203644:	36860613          	addi	a2,a2,872 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203648:	25d00593          	li	a1,605
ffffffffc020364c:	00009517          	auipc	a0,0x9
ffffffffc0203650:	fb450513          	addi	a0,a0,-76 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203654:	e4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203658:	86d6                	mv	a3,s5
ffffffffc020365a:	00009617          	auipc	a2,0x9
ffffffffc020365e:	e8e60613          	addi	a2,a2,-370 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0203662:	25c00593          	li	a1,604
ffffffffc0203666:	00009517          	auipc	a0,0x9
ffffffffc020366a:	f9a50513          	addi	a0,a0,-102 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020366e:	e31fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203672:	00009697          	auipc	a3,0x9
ffffffffc0203676:	39668693          	addi	a3,a3,918 # ffffffffc020ca08 <default_pmm_manager+0x558>
ffffffffc020367a:	00008617          	auipc	a2,0x8
ffffffffc020367e:	32e60613          	addi	a2,a2,814 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203682:	26900593          	li	a1,617
ffffffffc0203686:	00009517          	auipc	a0,0x9
ffffffffc020368a:	f7a50513          	addi	a0,a0,-134 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020368e:	e11fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203692:	00009697          	auipc	a3,0x9
ffffffffc0203696:	35e68693          	addi	a3,a3,862 # ffffffffc020c9f0 <default_pmm_manager+0x540>
ffffffffc020369a:	00008617          	auipc	a2,0x8
ffffffffc020369e:	30e60613          	addi	a2,a2,782 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02036a2:	26800593          	li	a1,616
ffffffffc02036a6:	00009517          	auipc	a0,0x9
ffffffffc02036aa:	f5a50513          	addi	a0,a0,-166 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02036ae:	df1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036b2:	00009697          	auipc	a3,0x9
ffffffffc02036b6:	30e68693          	addi	a3,a3,782 # ffffffffc020c9c0 <default_pmm_manager+0x510>
ffffffffc02036ba:	00008617          	auipc	a2,0x8
ffffffffc02036be:	2ee60613          	addi	a2,a2,750 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02036c2:	26700593          	li	a1,615
ffffffffc02036c6:	00009517          	auipc	a0,0x9
ffffffffc02036ca:	f3a50513          	addi	a0,a0,-198 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02036ce:	dd1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036d2:	00009697          	auipc	a3,0x9
ffffffffc02036d6:	2d668693          	addi	a3,a3,726 # ffffffffc020c9a8 <default_pmm_manager+0x4f8>
ffffffffc02036da:	00008617          	auipc	a2,0x8
ffffffffc02036de:	2ce60613          	addi	a2,a2,718 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02036e2:	26500593          	li	a1,613
ffffffffc02036e6:	00009517          	auipc	a0,0x9
ffffffffc02036ea:	f1a50513          	addi	a0,a0,-230 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02036ee:	db1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036f2:	00009697          	auipc	a3,0x9
ffffffffc02036f6:	29668693          	addi	a3,a3,662 # ffffffffc020c988 <default_pmm_manager+0x4d8>
ffffffffc02036fa:	00008617          	auipc	a2,0x8
ffffffffc02036fe:	2ae60613          	addi	a2,a2,686 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203702:	26400593          	li	a1,612
ffffffffc0203706:	00009517          	auipc	a0,0x9
ffffffffc020370a:	efa50513          	addi	a0,a0,-262 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020370e:	d91fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203712:	00009697          	auipc	a3,0x9
ffffffffc0203716:	26668693          	addi	a3,a3,614 # ffffffffc020c978 <default_pmm_manager+0x4c8>
ffffffffc020371a:	00008617          	auipc	a2,0x8
ffffffffc020371e:	28e60613          	addi	a2,a2,654 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203722:	26300593          	li	a1,611
ffffffffc0203726:	00009517          	auipc	a0,0x9
ffffffffc020372a:	eda50513          	addi	a0,a0,-294 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020372e:	d71fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203732:	00009697          	auipc	a3,0x9
ffffffffc0203736:	23668693          	addi	a3,a3,566 # ffffffffc020c968 <default_pmm_manager+0x4b8>
ffffffffc020373a:	00008617          	auipc	a2,0x8
ffffffffc020373e:	26e60613          	addi	a2,a2,622 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203742:	26200593          	li	a1,610
ffffffffc0203746:	00009517          	auipc	a0,0x9
ffffffffc020374a:	eba50513          	addi	a0,a0,-326 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020374e:	d51fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203752:	00009697          	auipc	a3,0x9
ffffffffc0203756:	1de68693          	addi	a3,a3,478 # ffffffffc020c930 <default_pmm_manager+0x480>
ffffffffc020375a:	00008617          	auipc	a2,0x8
ffffffffc020375e:	24e60613          	addi	a2,a2,590 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203762:	26100593          	li	a1,609
ffffffffc0203766:	00009517          	auipc	a0,0x9
ffffffffc020376a:	e9a50513          	addi	a0,a0,-358 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020376e:	d31fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203772:	00009697          	auipc	a3,0x9
ffffffffc0203776:	30e68693          	addi	a3,a3,782 # ffffffffc020ca80 <default_pmm_manager+0x5d0>
ffffffffc020377a:	00008617          	auipc	a2,0x8
ffffffffc020377e:	22e60613          	addi	a2,a2,558 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203782:	27e00593          	li	a1,638
ffffffffc0203786:	00009517          	auipc	a0,0x9
ffffffffc020378a:	e7a50513          	addi	a0,a0,-390 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020378e:	d11fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203792:	00009617          	auipc	a2,0x9
ffffffffc0203796:	d5660613          	addi	a2,a2,-682 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc020379a:	07100593          	li	a1,113
ffffffffc020379e:	00009517          	auipc	a0,0x9
ffffffffc02037a2:	d7250513          	addi	a0,a0,-654 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc02037a6:	cf9fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037aa:	86a2                	mv	a3,s0
ffffffffc02037ac:	00009617          	auipc	a2,0x9
ffffffffc02037b0:	de460613          	addi	a2,a2,-540 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc02037b4:	0ca00593          	li	a1,202
ffffffffc02037b8:	00009517          	auipc	a0,0x9
ffffffffc02037bc:	e4850513          	addi	a0,a0,-440 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02037c0:	cdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037c4:	00009617          	auipc	a2,0x9
ffffffffc02037c8:	dcc60613          	addi	a2,a2,-564 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc02037cc:	08100593          	li	a1,129
ffffffffc02037d0:	00009517          	auipc	a0,0x9
ffffffffc02037d4:	e3050513          	addi	a0,a0,-464 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02037d8:	cc7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037dc:	00009697          	auipc	a3,0x9
ffffffffc02037e0:	11468693          	addi	a3,a3,276 # ffffffffc020c8f0 <default_pmm_manager+0x440>
ffffffffc02037e4:	00008617          	auipc	a2,0x8
ffffffffc02037e8:	1c460613          	addi	a2,a2,452 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02037ec:	26000593          	li	a1,608
ffffffffc02037f0:	00009517          	auipc	a0,0x9
ffffffffc02037f4:	e1050513          	addi	a0,a0,-496 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02037f8:	ca7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037fc:	00009697          	auipc	a3,0x9
ffffffffc0203800:	03468693          	addi	a3,a3,52 # ffffffffc020c830 <default_pmm_manager+0x380>
ffffffffc0203804:	00008617          	auipc	a2,0x8
ffffffffc0203808:	1a460613          	addi	a2,a2,420 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020380c:	25400593          	li	a1,596
ffffffffc0203810:	00009517          	auipc	a0,0x9
ffffffffc0203814:	df050513          	addi	a0,a0,-528 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203818:	c87fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020381c:	985fe0ef          	jal	ra,ffffffffc02021a0 <pte2page.part.0>
ffffffffc0203820:	00009697          	auipc	a3,0x9
ffffffffc0203824:	04068693          	addi	a3,a3,64 # ffffffffc020c860 <default_pmm_manager+0x3b0>
ffffffffc0203828:	00008617          	auipc	a2,0x8
ffffffffc020382c:	18060613          	addi	a2,a2,384 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203830:	25700593          	li	a1,599
ffffffffc0203834:	00009517          	auipc	a0,0x9
ffffffffc0203838:	dcc50513          	addi	a0,a0,-564 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020383c:	c63fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203840:	00009697          	auipc	a3,0x9
ffffffffc0203844:	fc068693          	addi	a3,a3,-64 # ffffffffc020c800 <default_pmm_manager+0x350>
ffffffffc0203848:	00008617          	auipc	a2,0x8
ffffffffc020384c:	16060613          	addi	a2,a2,352 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203850:	25000593          	li	a1,592
ffffffffc0203854:	00009517          	auipc	a0,0x9
ffffffffc0203858:	dac50513          	addi	a0,a0,-596 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020385c:	c43fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203860:	00009697          	auipc	a3,0x9
ffffffffc0203864:	03068693          	addi	a3,a3,48 # ffffffffc020c890 <default_pmm_manager+0x3e0>
ffffffffc0203868:	00008617          	auipc	a2,0x8
ffffffffc020386c:	14060613          	addi	a2,a2,320 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203870:	25800593          	li	a1,600
ffffffffc0203874:	00009517          	auipc	a0,0x9
ffffffffc0203878:	d8c50513          	addi	a0,a0,-628 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020387c:	c23fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203880:	00009617          	auipc	a2,0x9
ffffffffc0203884:	c6860613          	addi	a2,a2,-920 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0203888:	25b00593          	li	a1,603
ffffffffc020388c:	00009517          	auipc	a0,0x9
ffffffffc0203890:	d7450513          	addi	a0,a0,-652 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203894:	c0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203898:	00009697          	auipc	a3,0x9
ffffffffc020389c:	01068693          	addi	a3,a3,16 # ffffffffc020c8a8 <default_pmm_manager+0x3f8>
ffffffffc02038a0:	00008617          	auipc	a2,0x8
ffffffffc02038a4:	10860613          	addi	a2,a2,264 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02038a8:	25900593          	li	a1,601
ffffffffc02038ac:	00009517          	auipc	a0,0x9
ffffffffc02038b0:	d5450513          	addi	a0,a0,-684 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02038b4:	bebfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038b8:	86ca                	mv	a3,s2
ffffffffc02038ba:	00009617          	auipc	a2,0x9
ffffffffc02038be:	cd660613          	addi	a2,a2,-810 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc02038c2:	0c600593          	li	a1,198
ffffffffc02038c6:	00009517          	auipc	a0,0x9
ffffffffc02038ca:	d3a50513          	addi	a0,a0,-710 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02038ce:	bd1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038d2:	00009697          	auipc	a3,0x9
ffffffffc02038d6:	13668693          	addi	a3,a3,310 # ffffffffc020ca08 <default_pmm_manager+0x558>
ffffffffc02038da:	00008617          	auipc	a2,0x8
ffffffffc02038de:	0ce60613          	addi	a2,a2,206 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02038e2:	27400593          	li	a1,628
ffffffffc02038e6:	00009517          	auipc	a0,0x9
ffffffffc02038ea:	d1a50513          	addi	a0,a0,-742 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc02038ee:	bb1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038f2:	00009697          	auipc	a3,0x9
ffffffffc02038f6:	14668693          	addi	a3,a3,326 # ffffffffc020ca38 <default_pmm_manager+0x588>
ffffffffc02038fa:	00008617          	auipc	a2,0x8
ffffffffc02038fe:	0ae60613          	addi	a2,a2,174 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203902:	27300593          	li	a1,627
ffffffffc0203906:	00009517          	auipc	a0,0x9
ffffffffc020390a:	cfa50513          	addi	a0,a0,-774 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc020390e:	b91fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203912 <copy_range>:
ffffffffc0203912:	7159                	addi	sp,sp,-112
ffffffffc0203914:	00d667b3          	or	a5,a2,a3
ffffffffc0203918:	f486                	sd	ra,104(sp)
ffffffffc020391a:	f0a2                	sd	s0,96(sp)
ffffffffc020391c:	eca6                	sd	s1,88(sp)
ffffffffc020391e:	e8ca                	sd	s2,80(sp)
ffffffffc0203920:	e4ce                	sd	s3,72(sp)
ffffffffc0203922:	e0d2                	sd	s4,64(sp)
ffffffffc0203924:	fc56                	sd	s5,56(sp)
ffffffffc0203926:	f85a                	sd	s6,48(sp)
ffffffffc0203928:	f45e                	sd	s7,40(sp)
ffffffffc020392a:	f062                	sd	s8,32(sp)
ffffffffc020392c:	ec66                	sd	s9,24(sp)
ffffffffc020392e:	e86a                	sd	s10,16(sp)
ffffffffc0203930:	e46e                	sd	s11,8(sp)
ffffffffc0203932:	17d2                	slli	a5,a5,0x34
ffffffffc0203934:	20079f63          	bnez	a5,ffffffffc0203b52 <copy_range+0x240>
ffffffffc0203938:	002007b7          	lui	a5,0x200
ffffffffc020393c:	8432                	mv	s0,a2
ffffffffc020393e:	1af66263          	bltu	a2,a5,ffffffffc0203ae2 <copy_range+0x1d0>
ffffffffc0203942:	8936                	mv	s2,a3
ffffffffc0203944:	18d67f63          	bgeu	a2,a3,ffffffffc0203ae2 <copy_range+0x1d0>
ffffffffc0203948:	4785                	li	a5,1
ffffffffc020394a:	07fe                	slli	a5,a5,0x1f
ffffffffc020394c:	18d7eb63          	bltu	a5,a3,ffffffffc0203ae2 <copy_range+0x1d0>
ffffffffc0203950:	5b7d                	li	s6,-1
ffffffffc0203952:	8aaa                	mv	s5,a0
ffffffffc0203954:	89ae                	mv	s3,a1
ffffffffc0203956:	6a05                	lui	s4,0x1
ffffffffc0203958:	00093c17          	auipc	s8,0x93
ffffffffc020395c:	f48c0c13          	addi	s8,s8,-184 # ffffffffc02968a0 <npage>
ffffffffc0203960:	00093b97          	auipc	s7,0x93
ffffffffc0203964:	f48b8b93          	addi	s7,s7,-184 # ffffffffc02968a8 <pages>
ffffffffc0203968:	00cb5b13          	srli	s6,s6,0xc
ffffffffc020396c:	00093c97          	auipc	s9,0x93
ffffffffc0203970:	f44c8c93          	addi	s9,s9,-188 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203974:	4601                	li	a2,0
ffffffffc0203976:	85a2                	mv	a1,s0
ffffffffc0203978:	854e                	mv	a0,s3
ffffffffc020397a:	8fbfe0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc020397e:	84aa                	mv	s1,a0
ffffffffc0203980:	0e050c63          	beqz	a0,ffffffffc0203a78 <copy_range+0x166>
ffffffffc0203984:	611c                	ld	a5,0(a0)
ffffffffc0203986:	8b85                	andi	a5,a5,1
ffffffffc0203988:	e785                	bnez	a5,ffffffffc02039b0 <copy_range+0x9e>
ffffffffc020398a:	9452                	add	s0,s0,s4
ffffffffc020398c:	ff2464e3          	bltu	s0,s2,ffffffffc0203974 <copy_range+0x62>
ffffffffc0203990:	4501                	li	a0,0
ffffffffc0203992:	70a6                	ld	ra,104(sp)
ffffffffc0203994:	7406                	ld	s0,96(sp)
ffffffffc0203996:	64e6                	ld	s1,88(sp)
ffffffffc0203998:	6946                	ld	s2,80(sp)
ffffffffc020399a:	69a6                	ld	s3,72(sp)
ffffffffc020399c:	6a06                	ld	s4,64(sp)
ffffffffc020399e:	7ae2                	ld	s5,56(sp)
ffffffffc02039a0:	7b42                	ld	s6,48(sp)
ffffffffc02039a2:	7ba2                	ld	s7,40(sp)
ffffffffc02039a4:	7c02                	ld	s8,32(sp)
ffffffffc02039a6:	6ce2                	ld	s9,24(sp)
ffffffffc02039a8:	6d42                	ld	s10,16(sp)
ffffffffc02039aa:	6da2                	ld	s11,8(sp)
ffffffffc02039ac:	6165                	addi	sp,sp,112
ffffffffc02039ae:	8082                	ret
ffffffffc02039b0:	4605                	li	a2,1
ffffffffc02039b2:	85a2                	mv	a1,s0
ffffffffc02039b4:	8556                	mv	a0,s5
ffffffffc02039b6:	8bffe0ef          	jal	ra,ffffffffc0202274 <get_pte>
ffffffffc02039ba:	c56d                	beqz	a0,ffffffffc0203aa4 <copy_range+0x192>
ffffffffc02039bc:	609c                	ld	a5,0(s1)
ffffffffc02039be:	0017f713          	andi	a4,a5,1
ffffffffc02039c2:	01f7f493          	andi	s1,a5,31
ffffffffc02039c6:	16070a63          	beqz	a4,ffffffffc0203b3a <copy_range+0x228>
ffffffffc02039ca:	000c3683          	ld	a3,0(s8)
ffffffffc02039ce:	078a                	slli	a5,a5,0x2
ffffffffc02039d0:	00c7d713          	srli	a4,a5,0xc
ffffffffc02039d4:	14d77763          	bgeu	a4,a3,ffffffffc0203b22 <copy_range+0x210>
ffffffffc02039d8:	000bb783          	ld	a5,0(s7)
ffffffffc02039dc:	fff806b7          	lui	a3,0xfff80
ffffffffc02039e0:	9736                	add	a4,a4,a3
ffffffffc02039e2:	071a                	slli	a4,a4,0x6
ffffffffc02039e4:	00e78db3          	add	s11,a5,a4
ffffffffc02039e8:	10002773          	csrr	a4,sstatus
ffffffffc02039ec:	8b09                	andi	a4,a4,2
ffffffffc02039ee:	e345                	bnez	a4,ffffffffc0203a8e <copy_range+0x17c>
ffffffffc02039f0:	000cb703          	ld	a4,0(s9)
ffffffffc02039f4:	4505                	li	a0,1
ffffffffc02039f6:	6f18                	ld	a4,24(a4)
ffffffffc02039f8:	9702                	jalr	a4
ffffffffc02039fa:	8d2a                	mv	s10,a0
ffffffffc02039fc:	0c0d8363          	beqz	s11,ffffffffc0203ac2 <copy_range+0x1b0>
ffffffffc0203a00:	100d0163          	beqz	s10,ffffffffc0203b02 <copy_range+0x1f0>
ffffffffc0203a04:	000bb703          	ld	a4,0(s7)
ffffffffc0203a08:	000805b7          	lui	a1,0x80
ffffffffc0203a0c:	000c3603          	ld	a2,0(s8)
ffffffffc0203a10:	40ed86b3          	sub	a3,s11,a4
ffffffffc0203a14:	8699                	srai	a3,a3,0x6
ffffffffc0203a16:	96ae                	add	a3,a3,a1
ffffffffc0203a18:	0166f7b3          	and	a5,a3,s6
ffffffffc0203a1c:	06b2                	slli	a3,a3,0xc
ffffffffc0203a1e:	08c7f663          	bgeu	a5,a2,ffffffffc0203aaa <copy_range+0x198>
ffffffffc0203a22:	40ed07b3          	sub	a5,s10,a4
ffffffffc0203a26:	00093717          	auipc	a4,0x93
ffffffffc0203a2a:	e9270713          	addi	a4,a4,-366 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0203a2e:	6308                	ld	a0,0(a4)
ffffffffc0203a30:	8799                	srai	a5,a5,0x6
ffffffffc0203a32:	97ae                	add	a5,a5,a1
ffffffffc0203a34:	0167f733          	and	a4,a5,s6
ffffffffc0203a38:	00a685b3          	add	a1,a3,a0
ffffffffc0203a3c:	07b2                	slli	a5,a5,0xc
ffffffffc0203a3e:	06c77563          	bgeu	a4,a2,ffffffffc0203aa8 <copy_range+0x196>
ffffffffc0203a42:	6605                	lui	a2,0x1
ffffffffc0203a44:	953e                	add	a0,a0,a5
ffffffffc0203a46:	2d1070ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc0203a4a:	86a6                	mv	a3,s1
ffffffffc0203a4c:	8622                	mv	a2,s0
ffffffffc0203a4e:	85ea                	mv	a1,s10
ffffffffc0203a50:	8556                	mv	a0,s5
ffffffffc0203a52:	fd9fe0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0203a56:	d915                	beqz	a0,ffffffffc020398a <copy_range+0x78>
ffffffffc0203a58:	00009697          	auipc	a3,0x9
ffffffffc0203a5c:	25068693          	addi	a3,a3,592 # ffffffffc020cca8 <default_pmm_manager+0x7f8>
ffffffffc0203a60:	00008617          	auipc	a2,0x8
ffffffffc0203a64:	f4860613          	addi	a2,a2,-184 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203a68:	1ec00593          	li	a1,492
ffffffffc0203a6c:	00009517          	auipc	a0,0x9
ffffffffc0203a70:	b9450513          	addi	a0,a0,-1132 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203a74:	a2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a78:	00200637          	lui	a2,0x200
ffffffffc0203a7c:	9432                	add	s0,s0,a2
ffffffffc0203a7e:	ffe00637          	lui	a2,0xffe00
ffffffffc0203a82:	8c71                	and	s0,s0,a2
ffffffffc0203a84:	f00406e3          	beqz	s0,ffffffffc0203990 <copy_range+0x7e>
ffffffffc0203a88:	ef2466e3          	bltu	s0,s2,ffffffffc0203974 <copy_range+0x62>
ffffffffc0203a8c:	b711                	j	ffffffffc0203990 <copy_range+0x7e>
ffffffffc0203a8e:	9e4fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203a92:	000cb703          	ld	a4,0(s9)
ffffffffc0203a96:	4505                	li	a0,1
ffffffffc0203a98:	6f18                	ld	a4,24(a4)
ffffffffc0203a9a:	9702                	jalr	a4
ffffffffc0203a9c:	8d2a                	mv	s10,a0
ffffffffc0203a9e:	9cefd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203aa2:	bfa9                	j	ffffffffc02039fc <copy_range+0xea>
ffffffffc0203aa4:	5571                	li	a0,-4
ffffffffc0203aa6:	b5f5                	j	ffffffffc0203992 <copy_range+0x80>
ffffffffc0203aa8:	86be                	mv	a3,a5
ffffffffc0203aaa:	00009617          	auipc	a2,0x9
ffffffffc0203aae:	a3e60613          	addi	a2,a2,-1474 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0203ab2:	07100593          	li	a1,113
ffffffffc0203ab6:	00009517          	auipc	a0,0x9
ffffffffc0203aba:	a5a50513          	addi	a0,a0,-1446 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0203abe:	9e1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ac2:	00009697          	auipc	a3,0x9
ffffffffc0203ac6:	1c668693          	addi	a3,a3,454 # ffffffffc020cc88 <default_pmm_manager+0x7d8>
ffffffffc0203aca:	00008617          	auipc	a2,0x8
ffffffffc0203ace:	ede60613          	addi	a2,a2,-290 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203ad2:	1ce00593          	li	a1,462
ffffffffc0203ad6:	00009517          	auipc	a0,0x9
ffffffffc0203ada:	b2a50513          	addi	a0,a0,-1238 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203ade:	9c1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ae2:	00009697          	auipc	a3,0x9
ffffffffc0203ae6:	b8668693          	addi	a3,a3,-1146 # ffffffffc020c668 <default_pmm_manager+0x1b8>
ffffffffc0203aea:	00008617          	auipc	a2,0x8
ffffffffc0203aee:	ebe60613          	addi	a2,a2,-322 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203af2:	1b600593          	li	a1,438
ffffffffc0203af6:	00009517          	auipc	a0,0x9
ffffffffc0203afa:	b0a50513          	addi	a0,a0,-1270 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203afe:	9a1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b02:	00009697          	auipc	a3,0x9
ffffffffc0203b06:	19668693          	addi	a3,a3,406 # ffffffffc020cc98 <default_pmm_manager+0x7e8>
ffffffffc0203b0a:	00008617          	auipc	a2,0x8
ffffffffc0203b0e:	e9e60613          	addi	a2,a2,-354 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203b12:	1cf00593          	li	a1,463
ffffffffc0203b16:	00009517          	auipc	a0,0x9
ffffffffc0203b1a:	aea50513          	addi	a0,a0,-1302 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203b1e:	981fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b22:	00009617          	auipc	a2,0x9
ffffffffc0203b26:	a9660613          	addi	a2,a2,-1386 # ffffffffc020c5b8 <default_pmm_manager+0x108>
ffffffffc0203b2a:	06900593          	li	a1,105
ffffffffc0203b2e:	00009517          	auipc	a0,0x9
ffffffffc0203b32:	9e250513          	addi	a0,a0,-1566 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0203b36:	969fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b3a:	00009617          	auipc	a2,0x9
ffffffffc0203b3e:	a9e60613          	addi	a2,a2,-1378 # ffffffffc020c5d8 <default_pmm_manager+0x128>
ffffffffc0203b42:	07f00593          	li	a1,127
ffffffffc0203b46:	00009517          	auipc	a0,0x9
ffffffffc0203b4a:	9ca50513          	addi	a0,a0,-1590 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0203b4e:	951fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b52:	00009697          	auipc	a3,0x9
ffffffffc0203b56:	ae668693          	addi	a3,a3,-1306 # ffffffffc020c638 <default_pmm_manager+0x188>
ffffffffc0203b5a:	00008617          	auipc	a2,0x8
ffffffffc0203b5e:	e4e60613          	addi	a2,a2,-434 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203b62:	1b500593          	li	a1,437
ffffffffc0203b66:	00009517          	auipc	a0,0x9
ffffffffc0203b6a:	a9a50513          	addi	a0,a0,-1382 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203b6e:	931fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b72 <pgdir_alloc_page>:
ffffffffc0203b72:	7179                	addi	sp,sp,-48
ffffffffc0203b74:	ec26                	sd	s1,24(sp)
ffffffffc0203b76:	e84a                	sd	s2,16(sp)
ffffffffc0203b78:	e052                	sd	s4,0(sp)
ffffffffc0203b7a:	f406                	sd	ra,40(sp)
ffffffffc0203b7c:	f022                	sd	s0,32(sp)
ffffffffc0203b7e:	e44e                	sd	s3,8(sp)
ffffffffc0203b80:	8a2a                	mv	s4,a0
ffffffffc0203b82:	84ae                	mv	s1,a1
ffffffffc0203b84:	8932                	mv	s2,a2
ffffffffc0203b86:	100027f3          	csrr	a5,sstatus
ffffffffc0203b8a:	8b89                	andi	a5,a5,2
ffffffffc0203b8c:	00093997          	auipc	s3,0x93
ffffffffc0203b90:	d2498993          	addi	s3,s3,-732 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203b94:	ef8d                	bnez	a5,ffffffffc0203bce <pgdir_alloc_page+0x5c>
ffffffffc0203b96:	0009b783          	ld	a5,0(s3)
ffffffffc0203b9a:	4505                	li	a0,1
ffffffffc0203b9c:	6f9c                	ld	a5,24(a5)
ffffffffc0203b9e:	9782                	jalr	a5
ffffffffc0203ba0:	842a                	mv	s0,a0
ffffffffc0203ba2:	cc09                	beqz	s0,ffffffffc0203bbc <pgdir_alloc_page+0x4a>
ffffffffc0203ba4:	86ca                	mv	a3,s2
ffffffffc0203ba6:	8626                	mv	a2,s1
ffffffffc0203ba8:	85a2                	mv	a1,s0
ffffffffc0203baa:	8552                	mv	a0,s4
ffffffffc0203bac:	e7ffe0ef          	jal	ra,ffffffffc0202a2a <page_insert>
ffffffffc0203bb0:	e915                	bnez	a0,ffffffffc0203be4 <pgdir_alloc_page+0x72>
ffffffffc0203bb2:	4018                	lw	a4,0(s0)
ffffffffc0203bb4:	fc04                	sd	s1,56(s0)
ffffffffc0203bb6:	4785                	li	a5,1
ffffffffc0203bb8:	04f71e63          	bne	a4,a5,ffffffffc0203c14 <pgdir_alloc_page+0xa2>
ffffffffc0203bbc:	70a2                	ld	ra,40(sp)
ffffffffc0203bbe:	8522                	mv	a0,s0
ffffffffc0203bc0:	7402                	ld	s0,32(sp)
ffffffffc0203bc2:	64e2                	ld	s1,24(sp)
ffffffffc0203bc4:	6942                	ld	s2,16(sp)
ffffffffc0203bc6:	69a2                	ld	s3,8(sp)
ffffffffc0203bc8:	6a02                	ld	s4,0(sp)
ffffffffc0203bca:	6145                	addi	sp,sp,48
ffffffffc0203bcc:	8082                	ret
ffffffffc0203bce:	8a4fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203bd2:	0009b783          	ld	a5,0(s3)
ffffffffc0203bd6:	4505                	li	a0,1
ffffffffc0203bd8:	6f9c                	ld	a5,24(a5)
ffffffffc0203bda:	9782                	jalr	a5
ffffffffc0203bdc:	842a                	mv	s0,a0
ffffffffc0203bde:	88efd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203be2:	b7c1                	j	ffffffffc0203ba2 <pgdir_alloc_page+0x30>
ffffffffc0203be4:	100027f3          	csrr	a5,sstatus
ffffffffc0203be8:	8b89                	andi	a5,a5,2
ffffffffc0203bea:	eb89                	bnez	a5,ffffffffc0203bfc <pgdir_alloc_page+0x8a>
ffffffffc0203bec:	0009b783          	ld	a5,0(s3)
ffffffffc0203bf0:	8522                	mv	a0,s0
ffffffffc0203bf2:	4585                	li	a1,1
ffffffffc0203bf4:	739c                	ld	a5,32(a5)
ffffffffc0203bf6:	4401                	li	s0,0
ffffffffc0203bf8:	9782                	jalr	a5
ffffffffc0203bfa:	b7c9                	j	ffffffffc0203bbc <pgdir_alloc_page+0x4a>
ffffffffc0203bfc:	876fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203c00:	0009b783          	ld	a5,0(s3)
ffffffffc0203c04:	8522                	mv	a0,s0
ffffffffc0203c06:	4585                	li	a1,1
ffffffffc0203c08:	739c                	ld	a5,32(a5)
ffffffffc0203c0a:	4401                	li	s0,0
ffffffffc0203c0c:	9782                	jalr	a5
ffffffffc0203c0e:	85efd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203c12:	b76d                	j	ffffffffc0203bbc <pgdir_alloc_page+0x4a>
ffffffffc0203c14:	00009697          	auipc	a3,0x9
ffffffffc0203c18:	0a468693          	addi	a3,a3,164 # ffffffffc020ccb8 <default_pmm_manager+0x808>
ffffffffc0203c1c:	00008617          	auipc	a2,0x8
ffffffffc0203c20:	d8c60613          	addi	a2,a2,-628 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203c24:	23500593          	li	a1,565
ffffffffc0203c28:	00009517          	auipc	a0,0x9
ffffffffc0203c2c:	9d850513          	addi	a0,a0,-1576 # ffffffffc020c600 <default_pmm_manager+0x150>
ffffffffc0203c30:	86ffc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c34 <check_vma_overlap.part.0>:
ffffffffc0203c34:	1141                	addi	sp,sp,-16
ffffffffc0203c36:	00009697          	auipc	a3,0x9
ffffffffc0203c3a:	09a68693          	addi	a3,a3,154 # ffffffffc020ccd0 <default_pmm_manager+0x820>
ffffffffc0203c3e:	00008617          	auipc	a2,0x8
ffffffffc0203c42:	d6a60613          	addi	a2,a2,-662 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203c46:	07400593          	li	a1,116
ffffffffc0203c4a:	00009517          	auipc	a0,0x9
ffffffffc0203c4e:	0a650513          	addi	a0,a0,166 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203c52:	e406                	sd	ra,8(sp)
ffffffffc0203c54:	84bfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c58 <mm_create>:
ffffffffc0203c58:	1141                	addi	sp,sp,-16
ffffffffc0203c5a:	05800513          	li	a0,88
ffffffffc0203c5e:	e022                	sd	s0,0(sp)
ffffffffc0203c60:	e406                	sd	ra,8(sp)
ffffffffc0203c62:	b7cfe0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0203c66:	842a                	mv	s0,a0
ffffffffc0203c68:	c115                	beqz	a0,ffffffffc0203c8c <mm_create+0x34>
ffffffffc0203c6a:	e408                	sd	a0,8(s0)
ffffffffc0203c6c:	e008                	sd	a0,0(s0)
ffffffffc0203c6e:	00053823          	sd	zero,16(a0)
ffffffffc0203c72:	00053c23          	sd	zero,24(a0)
ffffffffc0203c76:	02052023          	sw	zero,32(a0)
ffffffffc0203c7a:	02053423          	sd	zero,40(a0)
ffffffffc0203c7e:	02052823          	sw	zero,48(a0)
ffffffffc0203c82:	4585                	li	a1,1
ffffffffc0203c84:	03850513          	addi	a0,a0,56
ffffffffc0203c88:	123000ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0203c8c:	60a2                	ld	ra,8(sp)
ffffffffc0203c8e:	8522                	mv	a0,s0
ffffffffc0203c90:	6402                	ld	s0,0(sp)
ffffffffc0203c92:	0141                	addi	sp,sp,16
ffffffffc0203c94:	8082                	ret

ffffffffc0203c96 <find_vma>:
ffffffffc0203c96:	86aa                	mv	a3,a0
ffffffffc0203c98:	c505                	beqz	a0,ffffffffc0203cc0 <find_vma+0x2a>
ffffffffc0203c9a:	6908                	ld	a0,16(a0)
ffffffffc0203c9c:	c501                	beqz	a0,ffffffffc0203ca4 <find_vma+0xe>
ffffffffc0203c9e:	651c                	ld	a5,8(a0)
ffffffffc0203ca0:	02f5f263          	bgeu	a1,a5,ffffffffc0203cc4 <find_vma+0x2e>
ffffffffc0203ca4:	669c                	ld	a5,8(a3)
ffffffffc0203ca6:	00f68d63          	beq	a3,a5,ffffffffc0203cc0 <find_vma+0x2a>
ffffffffc0203caa:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0203cae:	00e5e663          	bltu	a1,a4,ffffffffc0203cba <find_vma+0x24>
ffffffffc0203cb2:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203cb6:	00e5ec63          	bltu	a1,a4,ffffffffc0203cce <find_vma+0x38>
ffffffffc0203cba:	679c                	ld	a5,8(a5)
ffffffffc0203cbc:	fef697e3          	bne	a3,a5,ffffffffc0203caa <find_vma+0x14>
ffffffffc0203cc0:	4501                	li	a0,0
ffffffffc0203cc2:	8082                	ret
ffffffffc0203cc4:	691c                	ld	a5,16(a0)
ffffffffc0203cc6:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203ca4 <find_vma+0xe>
ffffffffc0203cca:	ea88                	sd	a0,16(a3)
ffffffffc0203ccc:	8082                	ret
ffffffffc0203cce:	fe078513          	addi	a0,a5,-32
ffffffffc0203cd2:	ea88                	sd	a0,16(a3)
ffffffffc0203cd4:	8082                	ret

ffffffffc0203cd6 <insert_vma_struct>:
ffffffffc0203cd6:	6590                	ld	a2,8(a1)
ffffffffc0203cd8:	0105b803          	ld	a6,16(a1) # 80010 <_binary_bin_sfs_img_size+0xad10>
ffffffffc0203cdc:	1141                	addi	sp,sp,-16
ffffffffc0203cde:	e406                	sd	ra,8(sp)
ffffffffc0203ce0:	87aa                	mv	a5,a0
ffffffffc0203ce2:	01066763          	bltu	a2,a6,ffffffffc0203cf0 <insert_vma_struct+0x1a>
ffffffffc0203ce6:	a085                	j	ffffffffc0203d46 <insert_vma_struct+0x70>
ffffffffc0203ce8:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203cec:	04e66863          	bltu	a2,a4,ffffffffc0203d3c <insert_vma_struct+0x66>
ffffffffc0203cf0:	86be                	mv	a3,a5
ffffffffc0203cf2:	679c                	ld	a5,8(a5)
ffffffffc0203cf4:	fef51ae3          	bne	a0,a5,ffffffffc0203ce8 <insert_vma_struct+0x12>
ffffffffc0203cf8:	02a68463          	beq	a3,a0,ffffffffc0203d20 <insert_vma_struct+0x4a>
ffffffffc0203cfc:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203d00:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203d04:	08e8f163          	bgeu	a7,a4,ffffffffc0203d86 <insert_vma_struct+0xb0>
ffffffffc0203d08:	04e66f63          	bltu	a2,a4,ffffffffc0203d66 <insert_vma_struct+0x90>
ffffffffc0203d0c:	00f50a63          	beq	a0,a5,ffffffffc0203d20 <insert_vma_struct+0x4a>
ffffffffc0203d10:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203d14:	05076963          	bltu	a4,a6,ffffffffc0203d66 <insert_vma_struct+0x90>
ffffffffc0203d18:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203d1c:	02c77363          	bgeu	a4,a2,ffffffffc0203d42 <insert_vma_struct+0x6c>
ffffffffc0203d20:	5118                	lw	a4,32(a0)
ffffffffc0203d22:	e188                	sd	a0,0(a1)
ffffffffc0203d24:	02058613          	addi	a2,a1,32
ffffffffc0203d28:	e390                	sd	a2,0(a5)
ffffffffc0203d2a:	e690                	sd	a2,8(a3)
ffffffffc0203d2c:	60a2                	ld	ra,8(sp)
ffffffffc0203d2e:	f59c                	sd	a5,40(a1)
ffffffffc0203d30:	f194                	sd	a3,32(a1)
ffffffffc0203d32:	0017079b          	addiw	a5,a4,1
ffffffffc0203d36:	d11c                	sw	a5,32(a0)
ffffffffc0203d38:	0141                	addi	sp,sp,16
ffffffffc0203d3a:	8082                	ret
ffffffffc0203d3c:	fca690e3          	bne	a3,a0,ffffffffc0203cfc <insert_vma_struct+0x26>
ffffffffc0203d40:	bfd1                	j	ffffffffc0203d14 <insert_vma_struct+0x3e>
ffffffffc0203d42:	ef3ff0ef          	jal	ra,ffffffffc0203c34 <check_vma_overlap.part.0>
ffffffffc0203d46:	00009697          	auipc	a3,0x9
ffffffffc0203d4a:	fba68693          	addi	a3,a3,-70 # ffffffffc020cd00 <default_pmm_manager+0x850>
ffffffffc0203d4e:	00008617          	auipc	a2,0x8
ffffffffc0203d52:	c5a60613          	addi	a2,a2,-934 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203d56:	07a00593          	li	a1,122
ffffffffc0203d5a:	00009517          	auipc	a0,0x9
ffffffffc0203d5e:	f9650513          	addi	a0,a0,-106 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203d62:	f3cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d66:	00009697          	auipc	a3,0x9
ffffffffc0203d6a:	fda68693          	addi	a3,a3,-38 # ffffffffc020cd40 <default_pmm_manager+0x890>
ffffffffc0203d6e:	00008617          	auipc	a2,0x8
ffffffffc0203d72:	c3a60613          	addi	a2,a2,-966 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203d76:	07300593          	li	a1,115
ffffffffc0203d7a:	00009517          	auipc	a0,0x9
ffffffffc0203d7e:	f7650513          	addi	a0,a0,-138 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203d82:	f1cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d86:	00009697          	auipc	a3,0x9
ffffffffc0203d8a:	f9a68693          	addi	a3,a3,-102 # ffffffffc020cd20 <default_pmm_manager+0x870>
ffffffffc0203d8e:	00008617          	auipc	a2,0x8
ffffffffc0203d92:	c1a60613          	addi	a2,a2,-998 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203d96:	07200593          	li	a1,114
ffffffffc0203d9a:	00009517          	auipc	a0,0x9
ffffffffc0203d9e:	f5650513          	addi	a0,a0,-170 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203da2:	efcfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203da6 <mm_destroy>:
ffffffffc0203da6:	591c                	lw	a5,48(a0)
ffffffffc0203da8:	1141                	addi	sp,sp,-16
ffffffffc0203daa:	e406                	sd	ra,8(sp)
ffffffffc0203dac:	e022                	sd	s0,0(sp)
ffffffffc0203dae:	e78d                	bnez	a5,ffffffffc0203dd8 <mm_destroy+0x32>
ffffffffc0203db0:	842a                	mv	s0,a0
ffffffffc0203db2:	6508                	ld	a0,8(a0)
ffffffffc0203db4:	00a40c63          	beq	s0,a0,ffffffffc0203dcc <mm_destroy+0x26>
ffffffffc0203db8:	6118                	ld	a4,0(a0)
ffffffffc0203dba:	651c                	ld	a5,8(a0)
ffffffffc0203dbc:	1501                	addi	a0,a0,-32
ffffffffc0203dbe:	e71c                	sd	a5,8(a4)
ffffffffc0203dc0:	e398                	sd	a4,0(a5)
ffffffffc0203dc2:	accfe0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0203dc6:	6408                	ld	a0,8(s0)
ffffffffc0203dc8:	fea418e3          	bne	s0,a0,ffffffffc0203db8 <mm_destroy+0x12>
ffffffffc0203dcc:	8522                	mv	a0,s0
ffffffffc0203dce:	6402                	ld	s0,0(sp)
ffffffffc0203dd0:	60a2                	ld	ra,8(sp)
ffffffffc0203dd2:	0141                	addi	sp,sp,16
ffffffffc0203dd4:	abafe06f          	j	ffffffffc020208e <kfree>
ffffffffc0203dd8:	00009697          	auipc	a3,0x9
ffffffffc0203ddc:	f8868693          	addi	a3,a3,-120 # ffffffffc020cd60 <default_pmm_manager+0x8b0>
ffffffffc0203de0:	00008617          	auipc	a2,0x8
ffffffffc0203de4:	bc860613          	addi	a2,a2,-1080 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203de8:	09e00593          	li	a1,158
ffffffffc0203dec:	00009517          	auipc	a0,0x9
ffffffffc0203df0:	f0450513          	addi	a0,a0,-252 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203df4:	eaafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203df8 <mm_map>:
ffffffffc0203df8:	7139                	addi	sp,sp,-64
ffffffffc0203dfa:	f822                	sd	s0,48(sp)
ffffffffc0203dfc:	6405                	lui	s0,0x1
ffffffffc0203dfe:	147d                	addi	s0,s0,-1
ffffffffc0203e00:	77fd                	lui	a5,0xfffff
ffffffffc0203e02:	9622                	add	a2,a2,s0
ffffffffc0203e04:	962e                	add	a2,a2,a1
ffffffffc0203e06:	f426                	sd	s1,40(sp)
ffffffffc0203e08:	fc06                	sd	ra,56(sp)
ffffffffc0203e0a:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203e0e:	f04a                	sd	s2,32(sp)
ffffffffc0203e10:	ec4e                	sd	s3,24(sp)
ffffffffc0203e12:	e852                	sd	s4,16(sp)
ffffffffc0203e14:	e456                	sd	s5,8(sp)
ffffffffc0203e16:	002005b7          	lui	a1,0x200
ffffffffc0203e1a:	00f67433          	and	s0,a2,a5
ffffffffc0203e1e:	06b4e363          	bltu	s1,a1,ffffffffc0203e84 <mm_map+0x8c>
ffffffffc0203e22:	0684f163          	bgeu	s1,s0,ffffffffc0203e84 <mm_map+0x8c>
ffffffffc0203e26:	4785                	li	a5,1
ffffffffc0203e28:	07fe                	slli	a5,a5,0x1f
ffffffffc0203e2a:	0487ed63          	bltu	a5,s0,ffffffffc0203e84 <mm_map+0x8c>
ffffffffc0203e2e:	89aa                	mv	s3,a0
ffffffffc0203e30:	cd21                	beqz	a0,ffffffffc0203e88 <mm_map+0x90>
ffffffffc0203e32:	85a6                	mv	a1,s1
ffffffffc0203e34:	8ab6                	mv	s5,a3
ffffffffc0203e36:	8a3a                	mv	s4,a4
ffffffffc0203e38:	e5fff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc0203e3c:	c501                	beqz	a0,ffffffffc0203e44 <mm_map+0x4c>
ffffffffc0203e3e:	651c                	ld	a5,8(a0)
ffffffffc0203e40:	0487e263          	bltu	a5,s0,ffffffffc0203e84 <mm_map+0x8c>
ffffffffc0203e44:	03000513          	li	a0,48
ffffffffc0203e48:	996fe0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0203e4c:	892a                	mv	s2,a0
ffffffffc0203e4e:	5571                	li	a0,-4
ffffffffc0203e50:	02090163          	beqz	s2,ffffffffc0203e72 <mm_map+0x7a>
ffffffffc0203e54:	854e                	mv	a0,s3
ffffffffc0203e56:	00993423          	sd	s1,8(s2)
ffffffffc0203e5a:	00893823          	sd	s0,16(s2)
ffffffffc0203e5e:	01592c23          	sw	s5,24(s2)
ffffffffc0203e62:	85ca                	mv	a1,s2
ffffffffc0203e64:	e73ff0ef          	jal	ra,ffffffffc0203cd6 <insert_vma_struct>
ffffffffc0203e68:	4501                	li	a0,0
ffffffffc0203e6a:	000a0463          	beqz	s4,ffffffffc0203e72 <mm_map+0x7a>
ffffffffc0203e6e:	012a3023          	sd	s2,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203e72:	70e2                	ld	ra,56(sp)
ffffffffc0203e74:	7442                	ld	s0,48(sp)
ffffffffc0203e76:	74a2                	ld	s1,40(sp)
ffffffffc0203e78:	7902                	ld	s2,32(sp)
ffffffffc0203e7a:	69e2                	ld	s3,24(sp)
ffffffffc0203e7c:	6a42                	ld	s4,16(sp)
ffffffffc0203e7e:	6aa2                	ld	s5,8(sp)
ffffffffc0203e80:	6121                	addi	sp,sp,64
ffffffffc0203e82:	8082                	ret
ffffffffc0203e84:	5575                	li	a0,-3
ffffffffc0203e86:	b7f5                	j	ffffffffc0203e72 <mm_map+0x7a>
ffffffffc0203e88:	00009697          	auipc	a3,0x9
ffffffffc0203e8c:	ef068693          	addi	a3,a3,-272 # ffffffffc020cd78 <default_pmm_manager+0x8c8>
ffffffffc0203e90:	00008617          	auipc	a2,0x8
ffffffffc0203e94:	b1860613          	addi	a2,a2,-1256 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203e98:	0b300593          	li	a1,179
ffffffffc0203e9c:	00009517          	auipc	a0,0x9
ffffffffc0203ea0:	e5450513          	addi	a0,a0,-428 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203ea4:	dfafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ea8 <dup_mmap>:
ffffffffc0203ea8:	7139                	addi	sp,sp,-64
ffffffffc0203eaa:	fc06                	sd	ra,56(sp)
ffffffffc0203eac:	f822                	sd	s0,48(sp)
ffffffffc0203eae:	f426                	sd	s1,40(sp)
ffffffffc0203eb0:	f04a                	sd	s2,32(sp)
ffffffffc0203eb2:	ec4e                	sd	s3,24(sp)
ffffffffc0203eb4:	e852                	sd	s4,16(sp)
ffffffffc0203eb6:	e456                	sd	s5,8(sp)
ffffffffc0203eb8:	c52d                	beqz	a0,ffffffffc0203f22 <dup_mmap+0x7a>
ffffffffc0203eba:	892a                	mv	s2,a0
ffffffffc0203ebc:	84ae                	mv	s1,a1
ffffffffc0203ebe:	842e                	mv	s0,a1
ffffffffc0203ec0:	e595                	bnez	a1,ffffffffc0203eec <dup_mmap+0x44>
ffffffffc0203ec2:	a085                	j	ffffffffc0203f22 <dup_mmap+0x7a>
ffffffffc0203ec4:	854a                	mv	a0,s2
ffffffffc0203ec6:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203eca:	0145b823          	sd	s4,16(a1)
ffffffffc0203ece:	0135ac23          	sw	s3,24(a1)
ffffffffc0203ed2:	e05ff0ef          	jal	ra,ffffffffc0203cd6 <insert_vma_struct>
ffffffffc0203ed6:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203eda:	fe843603          	ld	a2,-24(s0)
ffffffffc0203ede:	6c8c                	ld	a1,24(s1)
ffffffffc0203ee0:	01893503          	ld	a0,24(s2)
ffffffffc0203ee4:	4701                	li	a4,0
ffffffffc0203ee6:	a2dff0ef          	jal	ra,ffffffffc0203912 <copy_range>
ffffffffc0203eea:	e105                	bnez	a0,ffffffffc0203f0a <dup_mmap+0x62>
ffffffffc0203eec:	6000                	ld	s0,0(s0)
ffffffffc0203eee:	02848863          	beq	s1,s0,ffffffffc0203f1e <dup_mmap+0x76>
ffffffffc0203ef2:	03000513          	li	a0,48
ffffffffc0203ef6:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203efa:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203efe:	ff842983          	lw	s3,-8(s0)
ffffffffc0203f02:	8dcfe0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0203f06:	85aa                	mv	a1,a0
ffffffffc0203f08:	fd55                	bnez	a0,ffffffffc0203ec4 <dup_mmap+0x1c>
ffffffffc0203f0a:	5571                	li	a0,-4
ffffffffc0203f0c:	70e2                	ld	ra,56(sp)
ffffffffc0203f0e:	7442                	ld	s0,48(sp)
ffffffffc0203f10:	74a2                	ld	s1,40(sp)
ffffffffc0203f12:	7902                	ld	s2,32(sp)
ffffffffc0203f14:	69e2                	ld	s3,24(sp)
ffffffffc0203f16:	6a42                	ld	s4,16(sp)
ffffffffc0203f18:	6aa2                	ld	s5,8(sp)
ffffffffc0203f1a:	6121                	addi	sp,sp,64
ffffffffc0203f1c:	8082                	ret
ffffffffc0203f1e:	4501                	li	a0,0
ffffffffc0203f20:	b7f5                	j	ffffffffc0203f0c <dup_mmap+0x64>
ffffffffc0203f22:	00009697          	auipc	a3,0x9
ffffffffc0203f26:	e6668693          	addi	a3,a3,-410 # ffffffffc020cd88 <default_pmm_manager+0x8d8>
ffffffffc0203f2a:	00008617          	auipc	a2,0x8
ffffffffc0203f2e:	a7e60613          	addi	a2,a2,-1410 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203f32:	0cf00593          	li	a1,207
ffffffffc0203f36:	00009517          	auipc	a0,0x9
ffffffffc0203f3a:	dba50513          	addi	a0,a0,-582 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203f3e:	d60fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203f42 <exit_mmap>:
ffffffffc0203f42:	1101                	addi	sp,sp,-32
ffffffffc0203f44:	ec06                	sd	ra,24(sp)
ffffffffc0203f46:	e822                	sd	s0,16(sp)
ffffffffc0203f48:	e426                	sd	s1,8(sp)
ffffffffc0203f4a:	e04a                	sd	s2,0(sp)
ffffffffc0203f4c:	c531                	beqz	a0,ffffffffc0203f98 <exit_mmap+0x56>
ffffffffc0203f4e:	591c                	lw	a5,48(a0)
ffffffffc0203f50:	84aa                	mv	s1,a0
ffffffffc0203f52:	e3b9                	bnez	a5,ffffffffc0203f98 <exit_mmap+0x56>
ffffffffc0203f54:	6500                	ld	s0,8(a0)
ffffffffc0203f56:	01853903          	ld	s2,24(a0)
ffffffffc0203f5a:	02850663          	beq	a0,s0,ffffffffc0203f86 <exit_mmap+0x44>
ffffffffc0203f5e:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f62:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f66:	854a                	mv	a0,s2
ffffffffc0203f68:	e4efe0ef          	jal	ra,ffffffffc02025b6 <unmap_range>
ffffffffc0203f6c:	6400                	ld	s0,8(s0)
ffffffffc0203f6e:	fe8498e3          	bne	s1,s0,ffffffffc0203f5e <exit_mmap+0x1c>
ffffffffc0203f72:	6400                	ld	s0,8(s0)
ffffffffc0203f74:	00848c63          	beq	s1,s0,ffffffffc0203f8c <exit_mmap+0x4a>
ffffffffc0203f78:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f7c:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f80:	854a                	mv	a0,s2
ffffffffc0203f82:	f7afe0ef          	jal	ra,ffffffffc02026fc <exit_range>
ffffffffc0203f86:	6400                	ld	s0,8(s0)
ffffffffc0203f88:	fe8498e3          	bne	s1,s0,ffffffffc0203f78 <exit_mmap+0x36>
ffffffffc0203f8c:	60e2                	ld	ra,24(sp)
ffffffffc0203f8e:	6442                	ld	s0,16(sp)
ffffffffc0203f90:	64a2                	ld	s1,8(sp)
ffffffffc0203f92:	6902                	ld	s2,0(sp)
ffffffffc0203f94:	6105                	addi	sp,sp,32
ffffffffc0203f96:	8082                	ret
ffffffffc0203f98:	00009697          	auipc	a3,0x9
ffffffffc0203f9c:	e1068693          	addi	a3,a3,-496 # ffffffffc020cda8 <default_pmm_manager+0x8f8>
ffffffffc0203fa0:	00008617          	auipc	a2,0x8
ffffffffc0203fa4:	a0860613          	addi	a2,a2,-1528 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0203fa8:	0e800593          	li	a1,232
ffffffffc0203fac:	00009517          	auipc	a0,0x9
ffffffffc0203fb0:	d4450513          	addi	a0,a0,-700 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc0203fb4:	ceafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203fb8 <vmm_init>:
ffffffffc0203fb8:	7139                	addi	sp,sp,-64
ffffffffc0203fba:	05800513          	li	a0,88
ffffffffc0203fbe:	fc06                	sd	ra,56(sp)
ffffffffc0203fc0:	f822                	sd	s0,48(sp)
ffffffffc0203fc2:	f426                	sd	s1,40(sp)
ffffffffc0203fc4:	f04a                	sd	s2,32(sp)
ffffffffc0203fc6:	ec4e                	sd	s3,24(sp)
ffffffffc0203fc8:	e852                	sd	s4,16(sp)
ffffffffc0203fca:	e456                	sd	s5,8(sp)
ffffffffc0203fcc:	812fe0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0203fd0:	2e050963          	beqz	a0,ffffffffc02042c2 <vmm_init+0x30a>
ffffffffc0203fd4:	e508                	sd	a0,8(a0)
ffffffffc0203fd6:	e108                	sd	a0,0(a0)
ffffffffc0203fd8:	00053823          	sd	zero,16(a0)
ffffffffc0203fdc:	00053c23          	sd	zero,24(a0)
ffffffffc0203fe0:	02052023          	sw	zero,32(a0)
ffffffffc0203fe4:	02053423          	sd	zero,40(a0)
ffffffffc0203fe8:	02052823          	sw	zero,48(a0)
ffffffffc0203fec:	84aa                	mv	s1,a0
ffffffffc0203fee:	4585                	li	a1,1
ffffffffc0203ff0:	03850513          	addi	a0,a0,56
ffffffffc0203ff4:	5b6000ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0203ff8:	03200413          	li	s0,50
ffffffffc0203ffc:	a811                	j	ffffffffc0204010 <vmm_init+0x58>
ffffffffc0203ffe:	e500                	sd	s0,8(a0)
ffffffffc0204000:	e91c                	sd	a5,16(a0)
ffffffffc0204002:	00052c23          	sw	zero,24(a0)
ffffffffc0204006:	146d                	addi	s0,s0,-5
ffffffffc0204008:	8526                	mv	a0,s1
ffffffffc020400a:	ccdff0ef          	jal	ra,ffffffffc0203cd6 <insert_vma_struct>
ffffffffc020400e:	c80d                	beqz	s0,ffffffffc0204040 <vmm_init+0x88>
ffffffffc0204010:	03000513          	li	a0,48
ffffffffc0204014:	fcbfd0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0204018:	85aa                	mv	a1,a0
ffffffffc020401a:	00240793          	addi	a5,s0,2
ffffffffc020401e:	f165                	bnez	a0,ffffffffc0203ffe <vmm_init+0x46>
ffffffffc0204020:	00009697          	auipc	a3,0x9
ffffffffc0204024:	f2068693          	addi	a3,a3,-224 # ffffffffc020cf40 <default_pmm_manager+0xa90>
ffffffffc0204028:	00008617          	auipc	a2,0x8
ffffffffc020402c:	98060613          	addi	a2,a2,-1664 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204030:	12c00593          	li	a1,300
ffffffffc0204034:	00009517          	auipc	a0,0x9
ffffffffc0204038:	cbc50513          	addi	a0,a0,-836 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020403c:	c62fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204040:	03700413          	li	s0,55
ffffffffc0204044:	1f900913          	li	s2,505
ffffffffc0204048:	a819                	j	ffffffffc020405e <vmm_init+0xa6>
ffffffffc020404a:	e500                	sd	s0,8(a0)
ffffffffc020404c:	e91c                	sd	a5,16(a0)
ffffffffc020404e:	00052c23          	sw	zero,24(a0)
ffffffffc0204052:	0415                	addi	s0,s0,5
ffffffffc0204054:	8526                	mv	a0,s1
ffffffffc0204056:	c81ff0ef          	jal	ra,ffffffffc0203cd6 <insert_vma_struct>
ffffffffc020405a:	03240a63          	beq	s0,s2,ffffffffc020408e <vmm_init+0xd6>
ffffffffc020405e:	03000513          	li	a0,48
ffffffffc0204062:	f7dfd0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0204066:	85aa                	mv	a1,a0
ffffffffc0204068:	00240793          	addi	a5,s0,2
ffffffffc020406c:	fd79                	bnez	a0,ffffffffc020404a <vmm_init+0x92>
ffffffffc020406e:	00009697          	auipc	a3,0x9
ffffffffc0204072:	ed268693          	addi	a3,a3,-302 # ffffffffc020cf40 <default_pmm_manager+0xa90>
ffffffffc0204076:	00008617          	auipc	a2,0x8
ffffffffc020407a:	93260613          	addi	a2,a2,-1742 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020407e:	13300593          	li	a1,307
ffffffffc0204082:	00009517          	auipc	a0,0x9
ffffffffc0204086:	c6e50513          	addi	a0,a0,-914 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020408a:	c14fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020408e:	649c                	ld	a5,8(s1)
ffffffffc0204090:	471d                	li	a4,7
ffffffffc0204092:	1fb00593          	li	a1,507
ffffffffc0204096:	16f48663          	beq	s1,a5,ffffffffc0204202 <vmm_init+0x24a>
ffffffffc020409a:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc020409e:	ffe70693          	addi	a3,a4,-2
ffffffffc02040a2:	10d61063          	bne	a2,a3,ffffffffc02041a2 <vmm_init+0x1ea>
ffffffffc02040a6:	ff07b683          	ld	a3,-16(a5)
ffffffffc02040aa:	0ed71c63          	bne	a4,a3,ffffffffc02041a2 <vmm_init+0x1ea>
ffffffffc02040ae:	0715                	addi	a4,a4,5
ffffffffc02040b0:	679c                	ld	a5,8(a5)
ffffffffc02040b2:	feb712e3          	bne	a4,a1,ffffffffc0204096 <vmm_init+0xde>
ffffffffc02040b6:	4a1d                	li	s4,7
ffffffffc02040b8:	4415                	li	s0,5
ffffffffc02040ba:	1f900a93          	li	s5,505
ffffffffc02040be:	85a2                	mv	a1,s0
ffffffffc02040c0:	8526                	mv	a0,s1
ffffffffc02040c2:	bd5ff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc02040c6:	892a                	mv	s2,a0
ffffffffc02040c8:	16050d63          	beqz	a0,ffffffffc0204242 <vmm_init+0x28a>
ffffffffc02040cc:	00140593          	addi	a1,s0,1
ffffffffc02040d0:	8526                	mv	a0,s1
ffffffffc02040d2:	bc5ff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc02040d6:	89aa                	mv	s3,a0
ffffffffc02040d8:	14050563          	beqz	a0,ffffffffc0204222 <vmm_init+0x26a>
ffffffffc02040dc:	85d2                	mv	a1,s4
ffffffffc02040de:	8526                	mv	a0,s1
ffffffffc02040e0:	bb7ff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc02040e4:	16051f63          	bnez	a0,ffffffffc0204262 <vmm_init+0x2aa>
ffffffffc02040e8:	00340593          	addi	a1,s0,3
ffffffffc02040ec:	8526                	mv	a0,s1
ffffffffc02040ee:	ba9ff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc02040f2:	1a051863          	bnez	a0,ffffffffc02042a2 <vmm_init+0x2ea>
ffffffffc02040f6:	00440593          	addi	a1,s0,4
ffffffffc02040fa:	8526                	mv	a0,s1
ffffffffc02040fc:	b9bff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc0204100:	18051163          	bnez	a0,ffffffffc0204282 <vmm_init+0x2ca>
ffffffffc0204104:	00893783          	ld	a5,8(s2)
ffffffffc0204108:	0a879d63          	bne	a5,s0,ffffffffc02041c2 <vmm_init+0x20a>
ffffffffc020410c:	01093783          	ld	a5,16(s2)
ffffffffc0204110:	0b479963          	bne	a5,s4,ffffffffc02041c2 <vmm_init+0x20a>
ffffffffc0204114:	0089b783          	ld	a5,8(s3)
ffffffffc0204118:	0c879563          	bne	a5,s0,ffffffffc02041e2 <vmm_init+0x22a>
ffffffffc020411c:	0109b783          	ld	a5,16(s3)
ffffffffc0204120:	0d479163          	bne	a5,s4,ffffffffc02041e2 <vmm_init+0x22a>
ffffffffc0204124:	0415                	addi	s0,s0,5
ffffffffc0204126:	0a15                	addi	s4,s4,5
ffffffffc0204128:	f9541be3          	bne	s0,s5,ffffffffc02040be <vmm_init+0x106>
ffffffffc020412c:	4411                	li	s0,4
ffffffffc020412e:	597d                	li	s2,-1
ffffffffc0204130:	85a2                	mv	a1,s0
ffffffffc0204132:	8526                	mv	a0,s1
ffffffffc0204134:	b63ff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc0204138:	0004059b          	sext.w	a1,s0
ffffffffc020413c:	c90d                	beqz	a0,ffffffffc020416e <vmm_init+0x1b6>
ffffffffc020413e:	6914                	ld	a3,16(a0)
ffffffffc0204140:	6510                	ld	a2,8(a0)
ffffffffc0204142:	00009517          	auipc	a0,0x9
ffffffffc0204146:	d8650513          	addi	a0,a0,-634 # ffffffffc020cec8 <default_pmm_manager+0xa18>
ffffffffc020414a:	85cfc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020414e:	00009697          	auipc	a3,0x9
ffffffffc0204152:	da268693          	addi	a3,a3,-606 # ffffffffc020cef0 <default_pmm_manager+0xa40>
ffffffffc0204156:	00008617          	auipc	a2,0x8
ffffffffc020415a:	85260613          	addi	a2,a2,-1966 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020415e:	15900593          	li	a1,345
ffffffffc0204162:	00009517          	auipc	a0,0x9
ffffffffc0204166:	b8e50513          	addi	a0,a0,-1138 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020416a:	b34fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020416e:	147d                	addi	s0,s0,-1
ffffffffc0204170:	fd2410e3          	bne	s0,s2,ffffffffc0204130 <vmm_init+0x178>
ffffffffc0204174:	8526                	mv	a0,s1
ffffffffc0204176:	c31ff0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc020417a:	00009517          	auipc	a0,0x9
ffffffffc020417e:	d8e50513          	addi	a0,a0,-626 # ffffffffc020cf08 <default_pmm_manager+0xa58>
ffffffffc0204182:	824fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204186:	7442                	ld	s0,48(sp)
ffffffffc0204188:	70e2                	ld	ra,56(sp)
ffffffffc020418a:	74a2                	ld	s1,40(sp)
ffffffffc020418c:	7902                	ld	s2,32(sp)
ffffffffc020418e:	69e2                	ld	s3,24(sp)
ffffffffc0204190:	6a42                	ld	s4,16(sp)
ffffffffc0204192:	6aa2                	ld	s5,8(sp)
ffffffffc0204194:	00009517          	auipc	a0,0x9
ffffffffc0204198:	d9450513          	addi	a0,a0,-620 # ffffffffc020cf28 <default_pmm_manager+0xa78>
ffffffffc020419c:	6121                	addi	sp,sp,64
ffffffffc020419e:	808fc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02041a2:	00009697          	auipc	a3,0x9
ffffffffc02041a6:	c3e68693          	addi	a3,a3,-962 # ffffffffc020cde0 <default_pmm_manager+0x930>
ffffffffc02041aa:	00007617          	auipc	a2,0x7
ffffffffc02041ae:	7fe60613          	addi	a2,a2,2046 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02041b2:	13d00593          	li	a1,317
ffffffffc02041b6:	00009517          	auipc	a0,0x9
ffffffffc02041ba:	b3a50513          	addi	a0,a0,-1222 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc02041be:	ae0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041c2:	00009697          	auipc	a3,0x9
ffffffffc02041c6:	ca668693          	addi	a3,a3,-858 # ffffffffc020ce68 <default_pmm_manager+0x9b8>
ffffffffc02041ca:	00007617          	auipc	a2,0x7
ffffffffc02041ce:	7de60613          	addi	a2,a2,2014 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02041d2:	14e00593          	li	a1,334
ffffffffc02041d6:	00009517          	auipc	a0,0x9
ffffffffc02041da:	b1a50513          	addi	a0,a0,-1254 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc02041de:	ac0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041e2:	00009697          	auipc	a3,0x9
ffffffffc02041e6:	cb668693          	addi	a3,a3,-842 # ffffffffc020ce98 <default_pmm_manager+0x9e8>
ffffffffc02041ea:	00007617          	auipc	a2,0x7
ffffffffc02041ee:	7be60613          	addi	a2,a2,1982 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02041f2:	14f00593          	li	a1,335
ffffffffc02041f6:	00009517          	auipc	a0,0x9
ffffffffc02041fa:	afa50513          	addi	a0,a0,-1286 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc02041fe:	aa0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204202:	00009697          	auipc	a3,0x9
ffffffffc0204206:	bc668693          	addi	a3,a3,-1082 # ffffffffc020cdc8 <default_pmm_manager+0x918>
ffffffffc020420a:	00007617          	auipc	a2,0x7
ffffffffc020420e:	79e60613          	addi	a2,a2,1950 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204212:	13b00593          	li	a1,315
ffffffffc0204216:	00009517          	auipc	a0,0x9
ffffffffc020421a:	ada50513          	addi	a0,a0,-1318 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020421e:	a80fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204222:	00009697          	auipc	a3,0x9
ffffffffc0204226:	c0668693          	addi	a3,a3,-1018 # ffffffffc020ce28 <default_pmm_manager+0x978>
ffffffffc020422a:	00007617          	auipc	a2,0x7
ffffffffc020422e:	77e60613          	addi	a2,a2,1918 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204232:	14600593          	li	a1,326
ffffffffc0204236:	00009517          	auipc	a0,0x9
ffffffffc020423a:	aba50513          	addi	a0,a0,-1350 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020423e:	a60fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204242:	00009697          	auipc	a3,0x9
ffffffffc0204246:	bd668693          	addi	a3,a3,-1066 # ffffffffc020ce18 <default_pmm_manager+0x968>
ffffffffc020424a:	00007617          	auipc	a2,0x7
ffffffffc020424e:	75e60613          	addi	a2,a2,1886 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204252:	14400593          	li	a1,324
ffffffffc0204256:	00009517          	auipc	a0,0x9
ffffffffc020425a:	a9a50513          	addi	a0,a0,-1382 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020425e:	a40fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204262:	00009697          	auipc	a3,0x9
ffffffffc0204266:	bd668693          	addi	a3,a3,-1066 # ffffffffc020ce38 <default_pmm_manager+0x988>
ffffffffc020426a:	00007617          	auipc	a2,0x7
ffffffffc020426e:	73e60613          	addi	a2,a2,1854 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204272:	14800593          	li	a1,328
ffffffffc0204276:	00009517          	auipc	a0,0x9
ffffffffc020427a:	a7a50513          	addi	a0,a0,-1414 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020427e:	a20fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204282:	00009697          	auipc	a3,0x9
ffffffffc0204286:	bd668693          	addi	a3,a3,-1066 # ffffffffc020ce58 <default_pmm_manager+0x9a8>
ffffffffc020428a:	00007617          	auipc	a2,0x7
ffffffffc020428e:	71e60613          	addi	a2,a2,1822 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204292:	14c00593          	li	a1,332
ffffffffc0204296:	00009517          	auipc	a0,0x9
ffffffffc020429a:	a5a50513          	addi	a0,a0,-1446 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc020429e:	a00fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042a2:	00009697          	auipc	a3,0x9
ffffffffc02042a6:	ba668693          	addi	a3,a3,-1114 # ffffffffc020ce48 <default_pmm_manager+0x998>
ffffffffc02042aa:	00007617          	auipc	a2,0x7
ffffffffc02042ae:	6fe60613          	addi	a2,a2,1790 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02042b2:	14a00593          	li	a1,330
ffffffffc02042b6:	00009517          	auipc	a0,0x9
ffffffffc02042ba:	a3a50513          	addi	a0,a0,-1478 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc02042be:	9e0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02042c2:	00009697          	auipc	a3,0x9
ffffffffc02042c6:	ab668693          	addi	a3,a3,-1354 # ffffffffc020cd78 <default_pmm_manager+0x8c8>
ffffffffc02042ca:	00007617          	auipc	a2,0x7
ffffffffc02042ce:	6de60613          	addi	a2,a2,1758 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02042d2:	12400593          	li	a1,292
ffffffffc02042d6:	00009517          	auipc	a0,0x9
ffffffffc02042da:	a1a50513          	addi	a0,a0,-1510 # ffffffffc020ccf0 <default_pmm_manager+0x840>
ffffffffc02042de:	9c0fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02042e2 <user_mem_check>:
ffffffffc02042e2:	7179                	addi	sp,sp,-48
ffffffffc02042e4:	f022                	sd	s0,32(sp)
ffffffffc02042e6:	f406                	sd	ra,40(sp)
ffffffffc02042e8:	ec26                	sd	s1,24(sp)
ffffffffc02042ea:	e84a                	sd	s2,16(sp)
ffffffffc02042ec:	e44e                	sd	s3,8(sp)
ffffffffc02042ee:	e052                	sd	s4,0(sp)
ffffffffc02042f0:	842e                	mv	s0,a1
ffffffffc02042f2:	c135                	beqz	a0,ffffffffc0204356 <user_mem_check+0x74>
ffffffffc02042f4:	002007b7          	lui	a5,0x200
ffffffffc02042f8:	04f5e663          	bltu	a1,a5,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc02042fc:	00c584b3          	add	s1,a1,a2
ffffffffc0204300:	0495f263          	bgeu	a1,s1,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc0204304:	4785                	li	a5,1
ffffffffc0204306:	07fe                	slli	a5,a5,0x1f
ffffffffc0204308:	0297ee63          	bltu	a5,s1,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc020430c:	892a                	mv	s2,a0
ffffffffc020430e:	89b6                	mv	s3,a3
ffffffffc0204310:	6a05                	lui	s4,0x1
ffffffffc0204312:	a821                	j	ffffffffc020432a <user_mem_check+0x48>
ffffffffc0204314:	0027f693          	andi	a3,a5,2
ffffffffc0204318:	9752                	add	a4,a4,s4
ffffffffc020431a:	8ba1                	andi	a5,a5,8
ffffffffc020431c:	c685                	beqz	a3,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc020431e:	c399                	beqz	a5,ffffffffc0204324 <user_mem_check+0x42>
ffffffffc0204320:	02e46263          	bltu	s0,a4,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc0204324:	6900                	ld	s0,16(a0)
ffffffffc0204326:	04947663          	bgeu	s0,s1,ffffffffc0204372 <user_mem_check+0x90>
ffffffffc020432a:	85a2                	mv	a1,s0
ffffffffc020432c:	854a                	mv	a0,s2
ffffffffc020432e:	969ff0ef          	jal	ra,ffffffffc0203c96 <find_vma>
ffffffffc0204332:	c909                	beqz	a0,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc0204334:	6518                	ld	a4,8(a0)
ffffffffc0204336:	00e46763          	bltu	s0,a4,ffffffffc0204344 <user_mem_check+0x62>
ffffffffc020433a:	4d1c                	lw	a5,24(a0)
ffffffffc020433c:	fc099ce3          	bnez	s3,ffffffffc0204314 <user_mem_check+0x32>
ffffffffc0204340:	8b85                	andi	a5,a5,1
ffffffffc0204342:	f3ed                	bnez	a5,ffffffffc0204324 <user_mem_check+0x42>
ffffffffc0204344:	4501                	li	a0,0
ffffffffc0204346:	70a2                	ld	ra,40(sp)
ffffffffc0204348:	7402                	ld	s0,32(sp)
ffffffffc020434a:	64e2                	ld	s1,24(sp)
ffffffffc020434c:	6942                	ld	s2,16(sp)
ffffffffc020434e:	69a2                	ld	s3,8(sp)
ffffffffc0204350:	6a02                	ld	s4,0(sp)
ffffffffc0204352:	6145                	addi	sp,sp,48
ffffffffc0204354:	8082                	ret
ffffffffc0204356:	c02007b7          	lui	a5,0xc0200
ffffffffc020435a:	4501                	li	a0,0
ffffffffc020435c:	fef5e5e3          	bltu	a1,a5,ffffffffc0204346 <user_mem_check+0x64>
ffffffffc0204360:	962e                	add	a2,a2,a1
ffffffffc0204362:	fec5f2e3          	bgeu	a1,a2,ffffffffc0204346 <user_mem_check+0x64>
ffffffffc0204366:	c8000537          	lui	a0,0xc8000
ffffffffc020436a:	0505                	addi	a0,a0,1
ffffffffc020436c:	00a63533          	sltu	a0,a2,a0
ffffffffc0204370:	bfd9                	j	ffffffffc0204346 <user_mem_check+0x64>
ffffffffc0204372:	4505                	li	a0,1
ffffffffc0204374:	bfc9                	j	ffffffffc0204346 <user_mem_check+0x64>

ffffffffc0204376 <copy_from_user>:
ffffffffc0204376:	1101                	addi	sp,sp,-32
ffffffffc0204378:	e822                	sd	s0,16(sp)
ffffffffc020437a:	e426                	sd	s1,8(sp)
ffffffffc020437c:	8432                	mv	s0,a2
ffffffffc020437e:	84b6                	mv	s1,a3
ffffffffc0204380:	e04a                	sd	s2,0(sp)
ffffffffc0204382:	86ba                	mv	a3,a4
ffffffffc0204384:	892e                	mv	s2,a1
ffffffffc0204386:	8626                	mv	a2,s1
ffffffffc0204388:	85a2                	mv	a1,s0
ffffffffc020438a:	ec06                	sd	ra,24(sp)
ffffffffc020438c:	f57ff0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc0204390:	c519                	beqz	a0,ffffffffc020439e <copy_from_user+0x28>
ffffffffc0204392:	8626                	mv	a2,s1
ffffffffc0204394:	85a2                	mv	a1,s0
ffffffffc0204396:	854a                	mv	a0,s2
ffffffffc0204398:	17e070ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020439c:	4505                	li	a0,1
ffffffffc020439e:	60e2                	ld	ra,24(sp)
ffffffffc02043a0:	6442                	ld	s0,16(sp)
ffffffffc02043a2:	64a2                	ld	s1,8(sp)
ffffffffc02043a4:	6902                	ld	s2,0(sp)
ffffffffc02043a6:	6105                	addi	sp,sp,32
ffffffffc02043a8:	8082                	ret

ffffffffc02043aa <copy_to_user>:
ffffffffc02043aa:	1101                	addi	sp,sp,-32
ffffffffc02043ac:	e822                	sd	s0,16(sp)
ffffffffc02043ae:	8436                	mv	s0,a3
ffffffffc02043b0:	e04a                	sd	s2,0(sp)
ffffffffc02043b2:	4685                	li	a3,1
ffffffffc02043b4:	8932                	mv	s2,a2
ffffffffc02043b6:	8622                	mv	a2,s0
ffffffffc02043b8:	e426                	sd	s1,8(sp)
ffffffffc02043ba:	ec06                	sd	ra,24(sp)
ffffffffc02043bc:	84ae                	mv	s1,a1
ffffffffc02043be:	f25ff0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc02043c2:	c519                	beqz	a0,ffffffffc02043d0 <copy_to_user+0x26>
ffffffffc02043c4:	8622                	mv	a2,s0
ffffffffc02043c6:	85ca                	mv	a1,s2
ffffffffc02043c8:	8526                	mv	a0,s1
ffffffffc02043ca:	14c070ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc02043ce:	4505                	li	a0,1
ffffffffc02043d0:	60e2                	ld	ra,24(sp)
ffffffffc02043d2:	6442                	ld	s0,16(sp)
ffffffffc02043d4:	64a2                	ld	s1,8(sp)
ffffffffc02043d6:	6902                	ld	s2,0(sp)
ffffffffc02043d8:	6105                	addi	sp,sp,32
ffffffffc02043da:	8082                	ret

ffffffffc02043dc <copy_string>:
ffffffffc02043dc:	7139                	addi	sp,sp,-64
ffffffffc02043de:	ec4e                	sd	s3,24(sp)
ffffffffc02043e0:	6985                	lui	s3,0x1
ffffffffc02043e2:	99b2                	add	s3,s3,a2
ffffffffc02043e4:	77fd                	lui	a5,0xfffff
ffffffffc02043e6:	00f9f9b3          	and	s3,s3,a5
ffffffffc02043ea:	f426                	sd	s1,40(sp)
ffffffffc02043ec:	f04a                	sd	s2,32(sp)
ffffffffc02043ee:	e852                	sd	s4,16(sp)
ffffffffc02043f0:	e456                	sd	s5,8(sp)
ffffffffc02043f2:	fc06                	sd	ra,56(sp)
ffffffffc02043f4:	f822                	sd	s0,48(sp)
ffffffffc02043f6:	84b2                	mv	s1,a2
ffffffffc02043f8:	8aaa                	mv	s5,a0
ffffffffc02043fa:	8a2e                	mv	s4,a1
ffffffffc02043fc:	8936                	mv	s2,a3
ffffffffc02043fe:	40c989b3          	sub	s3,s3,a2
ffffffffc0204402:	a015                	j	ffffffffc0204426 <copy_string+0x4a>
ffffffffc0204404:	038070ef          	jal	ra,ffffffffc020b43c <strnlen>
ffffffffc0204408:	87aa                	mv	a5,a0
ffffffffc020440a:	85a6                	mv	a1,s1
ffffffffc020440c:	8552                	mv	a0,s4
ffffffffc020440e:	8622                	mv	a2,s0
ffffffffc0204410:	0487e363          	bltu	a5,s0,ffffffffc0204456 <copy_string+0x7a>
ffffffffc0204414:	0329f763          	bgeu	s3,s2,ffffffffc0204442 <copy_string+0x66>
ffffffffc0204418:	0fe070ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020441c:	9a22                	add	s4,s4,s0
ffffffffc020441e:	94a2                	add	s1,s1,s0
ffffffffc0204420:	40890933          	sub	s2,s2,s0
ffffffffc0204424:	6985                	lui	s3,0x1
ffffffffc0204426:	4681                	li	a3,0
ffffffffc0204428:	85a6                	mv	a1,s1
ffffffffc020442a:	8556                	mv	a0,s5
ffffffffc020442c:	844a                	mv	s0,s2
ffffffffc020442e:	0129f363          	bgeu	s3,s2,ffffffffc0204434 <copy_string+0x58>
ffffffffc0204432:	844e                	mv	s0,s3
ffffffffc0204434:	8622                	mv	a2,s0
ffffffffc0204436:	eadff0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc020443a:	87aa                	mv	a5,a0
ffffffffc020443c:	85a2                	mv	a1,s0
ffffffffc020443e:	8526                	mv	a0,s1
ffffffffc0204440:	f3f1                	bnez	a5,ffffffffc0204404 <copy_string+0x28>
ffffffffc0204442:	4501                	li	a0,0
ffffffffc0204444:	70e2                	ld	ra,56(sp)
ffffffffc0204446:	7442                	ld	s0,48(sp)
ffffffffc0204448:	74a2                	ld	s1,40(sp)
ffffffffc020444a:	7902                	ld	s2,32(sp)
ffffffffc020444c:	69e2                	ld	s3,24(sp)
ffffffffc020444e:	6a42                	ld	s4,16(sp)
ffffffffc0204450:	6aa2                	ld	s5,8(sp)
ffffffffc0204452:	6121                	addi	sp,sp,64
ffffffffc0204454:	8082                	ret
ffffffffc0204456:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc020445a:	0bc070ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020445e:	4505                	li	a0,1
ffffffffc0204460:	b7d5                	j	ffffffffc0204444 <copy_string+0x68>

ffffffffc0204462 <__down.constprop.0>:
ffffffffc0204462:	715d                	addi	sp,sp,-80
ffffffffc0204464:	e0a2                	sd	s0,64(sp)
ffffffffc0204466:	e486                	sd	ra,72(sp)
ffffffffc0204468:	fc26                	sd	s1,56(sp)
ffffffffc020446a:	842a                	mv	s0,a0
ffffffffc020446c:	100027f3          	csrr	a5,sstatus
ffffffffc0204470:	8b89                	andi	a5,a5,2
ffffffffc0204472:	ebb1                	bnez	a5,ffffffffc02044c6 <__down.constprop.0+0x64>
ffffffffc0204474:	411c                	lw	a5,0(a0)
ffffffffc0204476:	00f05a63          	blez	a5,ffffffffc020448a <__down.constprop.0+0x28>
ffffffffc020447a:	37fd                	addiw	a5,a5,-1
ffffffffc020447c:	c11c                	sw	a5,0(a0)
ffffffffc020447e:	4501                	li	a0,0
ffffffffc0204480:	60a6                	ld	ra,72(sp)
ffffffffc0204482:	6406                	ld	s0,64(sp)
ffffffffc0204484:	74e2                	ld	s1,56(sp)
ffffffffc0204486:	6161                	addi	sp,sp,80
ffffffffc0204488:	8082                	ret
ffffffffc020448a:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc020448e:	0024                	addi	s1,sp,8
ffffffffc0204490:	10000613          	li	a2,256
ffffffffc0204494:	85a6                	mv	a1,s1
ffffffffc0204496:	8522                	mv	a0,s0
ffffffffc0204498:	2d8000ef          	jal	ra,ffffffffc0204770 <wait_current_set>
ffffffffc020449c:	6bd020ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc02044a0:	100027f3          	csrr	a5,sstatus
ffffffffc02044a4:	8b89                	andi	a5,a5,2
ffffffffc02044a6:	efb9                	bnez	a5,ffffffffc0204504 <__down.constprop.0+0xa2>
ffffffffc02044a8:	8526                	mv	a0,s1
ffffffffc02044aa:	19c000ef          	jal	ra,ffffffffc0204646 <wait_in_queue>
ffffffffc02044ae:	e531                	bnez	a0,ffffffffc02044fa <__down.constprop.0+0x98>
ffffffffc02044b0:	4542                	lw	a0,16(sp)
ffffffffc02044b2:	10000793          	li	a5,256
ffffffffc02044b6:	fcf515e3          	bne	a0,a5,ffffffffc0204480 <__down.constprop.0+0x1e>
ffffffffc02044ba:	60a6                	ld	ra,72(sp)
ffffffffc02044bc:	6406                	ld	s0,64(sp)
ffffffffc02044be:	74e2                	ld	s1,56(sp)
ffffffffc02044c0:	4501                	li	a0,0
ffffffffc02044c2:	6161                	addi	sp,sp,80
ffffffffc02044c4:	8082                	ret
ffffffffc02044c6:	facfc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02044ca:	401c                	lw	a5,0(s0)
ffffffffc02044cc:	00f05c63          	blez	a5,ffffffffc02044e4 <__down.constprop.0+0x82>
ffffffffc02044d0:	37fd                	addiw	a5,a5,-1
ffffffffc02044d2:	c01c                	sw	a5,0(s0)
ffffffffc02044d4:	f98fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044d8:	60a6                	ld	ra,72(sp)
ffffffffc02044da:	6406                	ld	s0,64(sp)
ffffffffc02044dc:	74e2                	ld	s1,56(sp)
ffffffffc02044de:	4501                	li	a0,0
ffffffffc02044e0:	6161                	addi	sp,sp,80
ffffffffc02044e2:	8082                	ret
ffffffffc02044e4:	0421                	addi	s0,s0,8
ffffffffc02044e6:	0024                	addi	s1,sp,8
ffffffffc02044e8:	10000613          	li	a2,256
ffffffffc02044ec:	85a6                	mv	a1,s1
ffffffffc02044ee:	8522                	mv	a0,s0
ffffffffc02044f0:	280000ef          	jal	ra,ffffffffc0204770 <wait_current_set>
ffffffffc02044f4:	f78fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044f8:	b755                	j	ffffffffc020449c <__down.constprop.0+0x3a>
ffffffffc02044fa:	85a6                	mv	a1,s1
ffffffffc02044fc:	8522                	mv	a0,s0
ffffffffc02044fe:	0ee000ef          	jal	ra,ffffffffc02045ec <wait_queue_del>
ffffffffc0204502:	b77d                	j	ffffffffc02044b0 <__down.constprop.0+0x4e>
ffffffffc0204504:	f6efc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204508:	8526                	mv	a0,s1
ffffffffc020450a:	13c000ef          	jal	ra,ffffffffc0204646 <wait_in_queue>
ffffffffc020450e:	e501                	bnez	a0,ffffffffc0204516 <__down.constprop.0+0xb4>
ffffffffc0204510:	f5cfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204514:	bf71                	j	ffffffffc02044b0 <__down.constprop.0+0x4e>
ffffffffc0204516:	85a6                	mv	a1,s1
ffffffffc0204518:	8522                	mv	a0,s0
ffffffffc020451a:	0d2000ef          	jal	ra,ffffffffc02045ec <wait_queue_del>
ffffffffc020451e:	bfcd                	j	ffffffffc0204510 <__down.constprop.0+0xae>

ffffffffc0204520 <__up.constprop.0>:
ffffffffc0204520:	1101                	addi	sp,sp,-32
ffffffffc0204522:	e822                	sd	s0,16(sp)
ffffffffc0204524:	ec06                	sd	ra,24(sp)
ffffffffc0204526:	e426                	sd	s1,8(sp)
ffffffffc0204528:	e04a                	sd	s2,0(sp)
ffffffffc020452a:	842a                	mv	s0,a0
ffffffffc020452c:	100027f3          	csrr	a5,sstatus
ffffffffc0204530:	8b89                	andi	a5,a5,2
ffffffffc0204532:	4901                	li	s2,0
ffffffffc0204534:	eba1                	bnez	a5,ffffffffc0204584 <__up.constprop.0+0x64>
ffffffffc0204536:	00840493          	addi	s1,s0,8
ffffffffc020453a:	8526                	mv	a0,s1
ffffffffc020453c:	0ee000ef          	jal	ra,ffffffffc020462a <wait_queue_first>
ffffffffc0204540:	85aa                	mv	a1,a0
ffffffffc0204542:	cd0d                	beqz	a0,ffffffffc020457c <__up.constprop.0+0x5c>
ffffffffc0204544:	6118                	ld	a4,0(a0)
ffffffffc0204546:	10000793          	li	a5,256
ffffffffc020454a:	0ec72703          	lw	a4,236(a4)
ffffffffc020454e:	02f71f63          	bne	a4,a5,ffffffffc020458c <__up.constprop.0+0x6c>
ffffffffc0204552:	4685                	li	a3,1
ffffffffc0204554:	10000613          	li	a2,256
ffffffffc0204558:	8526                	mv	a0,s1
ffffffffc020455a:	0fa000ef          	jal	ra,ffffffffc0204654 <wakeup_wait>
ffffffffc020455e:	00091863          	bnez	s2,ffffffffc020456e <__up.constprop.0+0x4e>
ffffffffc0204562:	60e2                	ld	ra,24(sp)
ffffffffc0204564:	6442                	ld	s0,16(sp)
ffffffffc0204566:	64a2                	ld	s1,8(sp)
ffffffffc0204568:	6902                	ld	s2,0(sp)
ffffffffc020456a:	6105                	addi	sp,sp,32
ffffffffc020456c:	8082                	ret
ffffffffc020456e:	6442                	ld	s0,16(sp)
ffffffffc0204570:	60e2                	ld	ra,24(sp)
ffffffffc0204572:	64a2                	ld	s1,8(sp)
ffffffffc0204574:	6902                	ld	s2,0(sp)
ffffffffc0204576:	6105                	addi	sp,sp,32
ffffffffc0204578:	ef4fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020457c:	401c                	lw	a5,0(s0)
ffffffffc020457e:	2785                	addiw	a5,a5,1
ffffffffc0204580:	c01c                	sw	a5,0(s0)
ffffffffc0204582:	bff1                	j	ffffffffc020455e <__up.constprop.0+0x3e>
ffffffffc0204584:	eeefc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204588:	4905                	li	s2,1
ffffffffc020458a:	b775                	j	ffffffffc0204536 <__up.constprop.0+0x16>
ffffffffc020458c:	00009697          	auipc	a3,0x9
ffffffffc0204590:	9c468693          	addi	a3,a3,-1596 # ffffffffc020cf50 <default_pmm_manager+0xaa0>
ffffffffc0204594:	00007617          	auipc	a2,0x7
ffffffffc0204598:	41460613          	addi	a2,a2,1044 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020459c:	45e5                	li	a1,25
ffffffffc020459e:	00009517          	auipc	a0,0x9
ffffffffc02045a2:	9da50513          	addi	a0,a0,-1574 # ffffffffc020cf78 <default_pmm_manager+0xac8>
ffffffffc02045a6:	ef9fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045aa <sem_init>:
ffffffffc02045aa:	c10c                	sw	a1,0(a0)
ffffffffc02045ac:	0521                	addi	a0,a0,8
ffffffffc02045ae:	a825                	j	ffffffffc02045e6 <wait_queue_init>

ffffffffc02045b0 <up>:
ffffffffc02045b0:	f71ff06f          	j	ffffffffc0204520 <__up.constprop.0>

ffffffffc02045b4 <down>:
ffffffffc02045b4:	1141                	addi	sp,sp,-16
ffffffffc02045b6:	e406                	sd	ra,8(sp)
ffffffffc02045b8:	eabff0ef          	jal	ra,ffffffffc0204462 <__down.constprop.0>
ffffffffc02045bc:	2501                	sext.w	a0,a0
ffffffffc02045be:	e501                	bnez	a0,ffffffffc02045c6 <down+0x12>
ffffffffc02045c0:	60a2                	ld	ra,8(sp)
ffffffffc02045c2:	0141                	addi	sp,sp,16
ffffffffc02045c4:	8082                	ret
ffffffffc02045c6:	00009697          	auipc	a3,0x9
ffffffffc02045ca:	9c268693          	addi	a3,a3,-1598 # ffffffffc020cf88 <default_pmm_manager+0xad8>
ffffffffc02045ce:	00007617          	auipc	a2,0x7
ffffffffc02045d2:	3da60613          	addi	a2,a2,986 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02045d6:	04000593          	li	a1,64
ffffffffc02045da:	00009517          	auipc	a0,0x9
ffffffffc02045de:	99e50513          	addi	a0,a0,-1634 # ffffffffc020cf78 <default_pmm_manager+0xac8>
ffffffffc02045e2:	ebdfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045e6 <wait_queue_init>:
ffffffffc02045e6:	e508                	sd	a0,8(a0)
ffffffffc02045e8:	e108                	sd	a0,0(a0)
ffffffffc02045ea:	8082                	ret

ffffffffc02045ec <wait_queue_del>:
ffffffffc02045ec:	7198                	ld	a4,32(a1)
ffffffffc02045ee:	01858793          	addi	a5,a1,24
ffffffffc02045f2:	00e78b63          	beq	a5,a4,ffffffffc0204608 <wait_queue_del+0x1c>
ffffffffc02045f6:	6994                	ld	a3,16(a1)
ffffffffc02045f8:	00a69863          	bne	a3,a0,ffffffffc0204608 <wait_queue_del+0x1c>
ffffffffc02045fc:	6d94                	ld	a3,24(a1)
ffffffffc02045fe:	e698                	sd	a4,8(a3)
ffffffffc0204600:	e314                	sd	a3,0(a4)
ffffffffc0204602:	f19c                	sd	a5,32(a1)
ffffffffc0204604:	ed9c                	sd	a5,24(a1)
ffffffffc0204606:	8082                	ret
ffffffffc0204608:	1141                	addi	sp,sp,-16
ffffffffc020460a:	00009697          	auipc	a3,0x9
ffffffffc020460e:	9de68693          	addi	a3,a3,-1570 # ffffffffc020cfe8 <default_pmm_manager+0xb38>
ffffffffc0204612:	00007617          	auipc	a2,0x7
ffffffffc0204616:	39660613          	addi	a2,a2,918 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020461a:	45f1                	li	a1,28
ffffffffc020461c:	00009517          	auipc	a0,0x9
ffffffffc0204620:	9b450513          	addi	a0,a0,-1612 # ffffffffc020cfd0 <default_pmm_manager+0xb20>
ffffffffc0204624:	e406                	sd	ra,8(sp)
ffffffffc0204626:	e79fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020462a <wait_queue_first>:
ffffffffc020462a:	651c                	ld	a5,8(a0)
ffffffffc020462c:	00f50563          	beq	a0,a5,ffffffffc0204636 <wait_queue_first+0xc>
ffffffffc0204630:	fe878513          	addi	a0,a5,-24
ffffffffc0204634:	8082                	ret
ffffffffc0204636:	4501                	li	a0,0
ffffffffc0204638:	8082                	ret

ffffffffc020463a <wait_queue_empty>:
ffffffffc020463a:	651c                	ld	a5,8(a0)
ffffffffc020463c:	40a78533          	sub	a0,a5,a0
ffffffffc0204640:	00153513          	seqz	a0,a0
ffffffffc0204644:	8082                	ret

ffffffffc0204646 <wait_in_queue>:
ffffffffc0204646:	711c                	ld	a5,32(a0)
ffffffffc0204648:	0561                	addi	a0,a0,24
ffffffffc020464a:	40a78533          	sub	a0,a5,a0
ffffffffc020464e:	00a03533          	snez	a0,a0
ffffffffc0204652:	8082                	ret

ffffffffc0204654 <wakeup_wait>:
ffffffffc0204654:	e689                	bnez	a3,ffffffffc020465e <wakeup_wait+0xa>
ffffffffc0204656:	6188                	ld	a0,0(a1)
ffffffffc0204658:	c590                	sw	a2,8(a1)
ffffffffc020465a:	44d0206f          	j	ffffffffc02072a6 <wakeup_proc>
ffffffffc020465e:	7198                	ld	a4,32(a1)
ffffffffc0204660:	01858793          	addi	a5,a1,24
ffffffffc0204664:	00e78e63          	beq	a5,a4,ffffffffc0204680 <wakeup_wait+0x2c>
ffffffffc0204668:	6994                	ld	a3,16(a1)
ffffffffc020466a:	00d51b63          	bne	a0,a3,ffffffffc0204680 <wakeup_wait+0x2c>
ffffffffc020466e:	6d94                	ld	a3,24(a1)
ffffffffc0204670:	6188                	ld	a0,0(a1)
ffffffffc0204672:	e698                	sd	a4,8(a3)
ffffffffc0204674:	e314                	sd	a3,0(a4)
ffffffffc0204676:	f19c                	sd	a5,32(a1)
ffffffffc0204678:	ed9c                	sd	a5,24(a1)
ffffffffc020467a:	c590                	sw	a2,8(a1)
ffffffffc020467c:	42b0206f          	j	ffffffffc02072a6 <wakeup_proc>
ffffffffc0204680:	1141                	addi	sp,sp,-16
ffffffffc0204682:	00009697          	auipc	a3,0x9
ffffffffc0204686:	96668693          	addi	a3,a3,-1690 # ffffffffc020cfe8 <default_pmm_manager+0xb38>
ffffffffc020468a:	00007617          	auipc	a2,0x7
ffffffffc020468e:	31e60613          	addi	a2,a2,798 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204692:	45f1                	li	a1,28
ffffffffc0204694:	00009517          	auipc	a0,0x9
ffffffffc0204698:	93c50513          	addi	a0,a0,-1732 # ffffffffc020cfd0 <default_pmm_manager+0xb20>
ffffffffc020469c:	e406                	sd	ra,8(sp)
ffffffffc020469e:	e01fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046a2 <wakeup_queue>:
ffffffffc02046a2:	651c                	ld	a5,8(a0)
ffffffffc02046a4:	0ca78563          	beq	a5,a0,ffffffffc020476e <wakeup_queue+0xcc>
ffffffffc02046a8:	1101                	addi	sp,sp,-32
ffffffffc02046aa:	e822                	sd	s0,16(sp)
ffffffffc02046ac:	e426                	sd	s1,8(sp)
ffffffffc02046ae:	e04a                	sd	s2,0(sp)
ffffffffc02046b0:	ec06                	sd	ra,24(sp)
ffffffffc02046b2:	84aa                	mv	s1,a0
ffffffffc02046b4:	892e                	mv	s2,a1
ffffffffc02046b6:	fe878413          	addi	s0,a5,-24
ffffffffc02046ba:	e23d                	bnez	a2,ffffffffc0204720 <wakeup_queue+0x7e>
ffffffffc02046bc:	6008                	ld	a0,0(s0)
ffffffffc02046be:	01242423          	sw	s2,8(s0)
ffffffffc02046c2:	3e5020ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc02046c6:	701c                	ld	a5,32(s0)
ffffffffc02046c8:	01840713          	addi	a4,s0,24
ffffffffc02046cc:	02e78463          	beq	a5,a4,ffffffffc02046f4 <wakeup_queue+0x52>
ffffffffc02046d0:	6818                	ld	a4,16(s0)
ffffffffc02046d2:	02e49163          	bne	s1,a4,ffffffffc02046f4 <wakeup_queue+0x52>
ffffffffc02046d6:	02f48f63          	beq	s1,a5,ffffffffc0204714 <wakeup_queue+0x72>
ffffffffc02046da:	fe87b503          	ld	a0,-24(a5)
ffffffffc02046de:	ff27a823          	sw	s2,-16(a5)
ffffffffc02046e2:	fe878413          	addi	s0,a5,-24
ffffffffc02046e6:	3c1020ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc02046ea:	701c                	ld	a5,32(s0)
ffffffffc02046ec:	01840713          	addi	a4,s0,24
ffffffffc02046f0:	fee790e3          	bne	a5,a4,ffffffffc02046d0 <wakeup_queue+0x2e>
ffffffffc02046f4:	00009697          	auipc	a3,0x9
ffffffffc02046f8:	8f468693          	addi	a3,a3,-1804 # ffffffffc020cfe8 <default_pmm_manager+0xb38>
ffffffffc02046fc:	00007617          	auipc	a2,0x7
ffffffffc0204700:	2ac60613          	addi	a2,a2,684 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204704:	02200593          	li	a1,34
ffffffffc0204708:	00009517          	auipc	a0,0x9
ffffffffc020470c:	8c850513          	addi	a0,a0,-1848 # ffffffffc020cfd0 <default_pmm_manager+0xb20>
ffffffffc0204710:	d8ffb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204714:	60e2                	ld	ra,24(sp)
ffffffffc0204716:	6442                	ld	s0,16(sp)
ffffffffc0204718:	64a2                	ld	s1,8(sp)
ffffffffc020471a:	6902                	ld	s2,0(sp)
ffffffffc020471c:	6105                	addi	sp,sp,32
ffffffffc020471e:	8082                	ret
ffffffffc0204720:	6798                	ld	a4,8(a5)
ffffffffc0204722:	02f70763          	beq	a4,a5,ffffffffc0204750 <wakeup_queue+0xae>
ffffffffc0204726:	6814                	ld	a3,16(s0)
ffffffffc0204728:	02d49463          	bne	s1,a3,ffffffffc0204750 <wakeup_queue+0xae>
ffffffffc020472c:	6c14                	ld	a3,24(s0)
ffffffffc020472e:	6008                	ld	a0,0(s0)
ffffffffc0204730:	e698                	sd	a4,8(a3)
ffffffffc0204732:	e314                	sd	a3,0(a4)
ffffffffc0204734:	f01c                	sd	a5,32(s0)
ffffffffc0204736:	ec1c                	sd	a5,24(s0)
ffffffffc0204738:	01242423          	sw	s2,8(s0)
ffffffffc020473c:	36b020ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc0204740:	6480                	ld	s0,8(s1)
ffffffffc0204742:	fc8489e3          	beq	s1,s0,ffffffffc0204714 <wakeup_queue+0x72>
ffffffffc0204746:	6418                	ld	a4,8(s0)
ffffffffc0204748:	87a2                	mv	a5,s0
ffffffffc020474a:	1421                	addi	s0,s0,-24
ffffffffc020474c:	fce79de3          	bne	a5,a4,ffffffffc0204726 <wakeup_queue+0x84>
ffffffffc0204750:	00009697          	auipc	a3,0x9
ffffffffc0204754:	89868693          	addi	a3,a3,-1896 # ffffffffc020cfe8 <default_pmm_manager+0xb38>
ffffffffc0204758:	00007617          	auipc	a2,0x7
ffffffffc020475c:	25060613          	addi	a2,a2,592 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204760:	45f1                	li	a1,28
ffffffffc0204762:	00009517          	auipc	a0,0x9
ffffffffc0204766:	86e50513          	addi	a0,a0,-1938 # ffffffffc020cfd0 <default_pmm_manager+0xb20>
ffffffffc020476a:	d35fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020476e:	8082                	ret

ffffffffc0204770 <wait_current_set>:
ffffffffc0204770:	00092797          	auipc	a5,0x92
ffffffffc0204774:	1507b783          	ld	a5,336(a5) # ffffffffc02968c0 <current>
ffffffffc0204778:	c39d                	beqz	a5,ffffffffc020479e <wait_current_set+0x2e>
ffffffffc020477a:	01858713          	addi	a4,a1,24
ffffffffc020477e:	800006b7          	lui	a3,0x80000
ffffffffc0204782:	ed98                	sd	a4,24(a1)
ffffffffc0204784:	e19c                	sd	a5,0(a1)
ffffffffc0204786:	c594                	sw	a3,8(a1)
ffffffffc0204788:	4685                	li	a3,1
ffffffffc020478a:	c394                	sw	a3,0(a5)
ffffffffc020478c:	0ec7a623          	sw	a2,236(a5)
ffffffffc0204790:	611c                	ld	a5,0(a0)
ffffffffc0204792:	e988                	sd	a0,16(a1)
ffffffffc0204794:	e118                	sd	a4,0(a0)
ffffffffc0204796:	e798                	sd	a4,8(a5)
ffffffffc0204798:	f188                	sd	a0,32(a1)
ffffffffc020479a:	ed9c                	sd	a5,24(a1)
ffffffffc020479c:	8082                	ret
ffffffffc020479e:	1141                	addi	sp,sp,-16
ffffffffc02047a0:	00009697          	auipc	a3,0x9
ffffffffc02047a4:	88868693          	addi	a3,a3,-1912 # ffffffffc020d028 <default_pmm_manager+0xb78>
ffffffffc02047a8:	00007617          	auipc	a2,0x7
ffffffffc02047ac:	20060613          	addi	a2,a2,512 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02047b0:	07400593          	li	a1,116
ffffffffc02047b4:	00009517          	auipc	a0,0x9
ffffffffc02047b8:	81c50513          	addi	a0,a0,-2020 # ffffffffc020cfd0 <default_pmm_manager+0xb20>
ffffffffc02047bc:	e406                	sd	ra,8(sp)
ffffffffc02047be:	ce1fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02047c2 <get_fd_array.part.0>:
ffffffffc02047c2:	1141                	addi	sp,sp,-16
ffffffffc02047c4:	00009697          	auipc	a3,0x9
ffffffffc02047c8:	87468693          	addi	a3,a3,-1932 # ffffffffc020d038 <default_pmm_manager+0xb88>
ffffffffc02047cc:	00007617          	auipc	a2,0x7
ffffffffc02047d0:	1dc60613          	addi	a2,a2,476 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02047d4:	45d1                	li	a1,20
ffffffffc02047d6:	00009517          	auipc	a0,0x9
ffffffffc02047da:	89250513          	addi	a0,a0,-1902 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc02047de:	e406                	sd	ra,8(sp)
ffffffffc02047e0:	cbffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02047e4 <fd_array_alloc>:
ffffffffc02047e4:	00092797          	auipc	a5,0x92
ffffffffc02047e8:	0dc7b783          	ld	a5,220(a5) # ffffffffc02968c0 <current>
ffffffffc02047ec:	1487b783          	ld	a5,328(a5)
ffffffffc02047f0:	1141                	addi	sp,sp,-16
ffffffffc02047f2:	e406                	sd	ra,8(sp)
ffffffffc02047f4:	c3a5                	beqz	a5,ffffffffc0204854 <fd_array_alloc+0x70>
ffffffffc02047f6:	4b98                	lw	a4,16(a5)
ffffffffc02047f8:	04e05e63          	blez	a4,ffffffffc0204854 <fd_array_alloc+0x70>
ffffffffc02047fc:	775d                	lui	a4,0xffff7
ffffffffc02047fe:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204802:	679c                	ld	a5,8(a5)
ffffffffc0204804:	02e50863          	beq	a0,a4,ffffffffc0204834 <fd_array_alloc+0x50>
ffffffffc0204808:	04700713          	li	a4,71
ffffffffc020480c:	04a76263          	bltu	a4,a0,ffffffffc0204850 <fd_array_alloc+0x6c>
ffffffffc0204810:	00351713          	slli	a4,a0,0x3
ffffffffc0204814:	40a70533          	sub	a0,a4,a0
ffffffffc0204818:	050e                	slli	a0,a0,0x3
ffffffffc020481a:	97aa                	add	a5,a5,a0
ffffffffc020481c:	4398                	lw	a4,0(a5)
ffffffffc020481e:	e71d                	bnez	a4,ffffffffc020484c <fd_array_alloc+0x68>
ffffffffc0204820:	5b88                	lw	a0,48(a5)
ffffffffc0204822:	e91d                	bnez	a0,ffffffffc0204858 <fd_array_alloc+0x74>
ffffffffc0204824:	4705                	li	a4,1
ffffffffc0204826:	c398                	sw	a4,0(a5)
ffffffffc0204828:	0207b423          	sd	zero,40(a5)
ffffffffc020482c:	e19c                	sd	a5,0(a1)
ffffffffc020482e:	60a2                	ld	ra,8(sp)
ffffffffc0204830:	0141                	addi	sp,sp,16
ffffffffc0204832:	8082                	ret
ffffffffc0204834:	6685                	lui	a3,0x1
ffffffffc0204836:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020483a:	96be                	add	a3,a3,a5
ffffffffc020483c:	4398                	lw	a4,0(a5)
ffffffffc020483e:	d36d                	beqz	a4,ffffffffc0204820 <fd_array_alloc+0x3c>
ffffffffc0204840:	03878793          	addi	a5,a5,56
ffffffffc0204844:	fef69ce3          	bne	a3,a5,ffffffffc020483c <fd_array_alloc+0x58>
ffffffffc0204848:	5529                	li	a0,-22
ffffffffc020484a:	b7d5                	j	ffffffffc020482e <fd_array_alloc+0x4a>
ffffffffc020484c:	5545                	li	a0,-15
ffffffffc020484e:	b7c5                	j	ffffffffc020482e <fd_array_alloc+0x4a>
ffffffffc0204850:	5575                	li	a0,-3
ffffffffc0204852:	bff1                	j	ffffffffc020482e <fd_array_alloc+0x4a>
ffffffffc0204854:	f6fff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>
ffffffffc0204858:	00009697          	auipc	a3,0x9
ffffffffc020485c:	82068693          	addi	a3,a3,-2016 # ffffffffc020d078 <default_pmm_manager+0xbc8>
ffffffffc0204860:	00007617          	auipc	a2,0x7
ffffffffc0204864:	14860613          	addi	a2,a2,328 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204868:	03b00593          	li	a1,59
ffffffffc020486c:	00008517          	auipc	a0,0x8
ffffffffc0204870:	7fc50513          	addi	a0,a0,2044 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204874:	c2bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204878 <fd_array_free>:
ffffffffc0204878:	411c                	lw	a5,0(a0)
ffffffffc020487a:	1141                	addi	sp,sp,-16
ffffffffc020487c:	e022                	sd	s0,0(sp)
ffffffffc020487e:	e406                	sd	ra,8(sp)
ffffffffc0204880:	4705                	li	a4,1
ffffffffc0204882:	842a                	mv	s0,a0
ffffffffc0204884:	04e78063          	beq	a5,a4,ffffffffc02048c4 <fd_array_free+0x4c>
ffffffffc0204888:	470d                	li	a4,3
ffffffffc020488a:	04e79563          	bne	a5,a4,ffffffffc02048d4 <fd_array_free+0x5c>
ffffffffc020488e:	591c                	lw	a5,48(a0)
ffffffffc0204890:	c38d                	beqz	a5,ffffffffc02048b2 <fd_array_free+0x3a>
ffffffffc0204892:	00008697          	auipc	a3,0x8
ffffffffc0204896:	7e668693          	addi	a3,a3,2022 # ffffffffc020d078 <default_pmm_manager+0xbc8>
ffffffffc020489a:	00007617          	auipc	a2,0x7
ffffffffc020489e:	10e60613          	addi	a2,a2,270 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02048a2:	04500593          	li	a1,69
ffffffffc02048a6:	00008517          	auipc	a0,0x8
ffffffffc02048aa:	7c250513          	addi	a0,a0,1986 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc02048ae:	bf1fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048b2:	7408                	ld	a0,40(s0)
ffffffffc02048b4:	069030ef          	jal	ra,ffffffffc020811c <vfs_close>
ffffffffc02048b8:	60a2                	ld	ra,8(sp)
ffffffffc02048ba:	00042023          	sw	zero,0(s0)
ffffffffc02048be:	6402                	ld	s0,0(sp)
ffffffffc02048c0:	0141                	addi	sp,sp,16
ffffffffc02048c2:	8082                	ret
ffffffffc02048c4:	591c                	lw	a5,48(a0)
ffffffffc02048c6:	f7f1                	bnez	a5,ffffffffc0204892 <fd_array_free+0x1a>
ffffffffc02048c8:	60a2                	ld	ra,8(sp)
ffffffffc02048ca:	00042023          	sw	zero,0(s0)
ffffffffc02048ce:	6402                	ld	s0,0(sp)
ffffffffc02048d0:	0141                	addi	sp,sp,16
ffffffffc02048d2:	8082                	ret
ffffffffc02048d4:	00008697          	auipc	a3,0x8
ffffffffc02048d8:	7dc68693          	addi	a3,a3,2012 # ffffffffc020d0b0 <default_pmm_manager+0xc00>
ffffffffc02048dc:	00007617          	auipc	a2,0x7
ffffffffc02048e0:	0cc60613          	addi	a2,a2,204 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02048e4:	04400593          	li	a1,68
ffffffffc02048e8:	00008517          	auipc	a0,0x8
ffffffffc02048ec:	78050513          	addi	a0,a0,1920 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc02048f0:	baffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02048f4 <fd_array_release>:
ffffffffc02048f4:	4118                	lw	a4,0(a0)
ffffffffc02048f6:	1141                	addi	sp,sp,-16
ffffffffc02048f8:	e406                	sd	ra,8(sp)
ffffffffc02048fa:	4685                	li	a3,1
ffffffffc02048fc:	3779                	addiw	a4,a4,-2
ffffffffc02048fe:	04e6e063          	bltu	a3,a4,ffffffffc020493e <fd_array_release+0x4a>
ffffffffc0204902:	5918                	lw	a4,48(a0)
ffffffffc0204904:	00e05d63          	blez	a4,ffffffffc020491e <fd_array_release+0x2a>
ffffffffc0204908:	fff7069b          	addiw	a3,a4,-1
ffffffffc020490c:	d914                	sw	a3,48(a0)
ffffffffc020490e:	c681                	beqz	a3,ffffffffc0204916 <fd_array_release+0x22>
ffffffffc0204910:	60a2                	ld	ra,8(sp)
ffffffffc0204912:	0141                	addi	sp,sp,16
ffffffffc0204914:	8082                	ret
ffffffffc0204916:	60a2                	ld	ra,8(sp)
ffffffffc0204918:	0141                	addi	sp,sp,16
ffffffffc020491a:	f5fff06f          	j	ffffffffc0204878 <fd_array_free>
ffffffffc020491e:	00009697          	auipc	a3,0x9
ffffffffc0204922:	80268693          	addi	a3,a3,-2046 # ffffffffc020d120 <default_pmm_manager+0xc70>
ffffffffc0204926:	00007617          	auipc	a2,0x7
ffffffffc020492a:	08260613          	addi	a2,a2,130 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020492e:	05600593          	li	a1,86
ffffffffc0204932:	00008517          	auipc	a0,0x8
ffffffffc0204936:	73650513          	addi	a0,a0,1846 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc020493a:	b65fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020493e:	00008697          	auipc	a3,0x8
ffffffffc0204942:	7aa68693          	addi	a3,a3,1962 # ffffffffc020d0e8 <default_pmm_manager+0xc38>
ffffffffc0204946:	00007617          	auipc	a2,0x7
ffffffffc020494a:	06260613          	addi	a2,a2,98 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020494e:	05500593          	li	a1,85
ffffffffc0204952:	00008517          	auipc	a0,0x8
ffffffffc0204956:	71650513          	addi	a0,a0,1814 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc020495a:	b45fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020495e <fd_array_open.part.0>:
ffffffffc020495e:	1141                	addi	sp,sp,-16
ffffffffc0204960:	00008697          	auipc	a3,0x8
ffffffffc0204964:	7d868693          	addi	a3,a3,2008 # ffffffffc020d138 <default_pmm_manager+0xc88>
ffffffffc0204968:	00007617          	auipc	a2,0x7
ffffffffc020496c:	04060613          	addi	a2,a2,64 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204970:	05f00593          	li	a1,95
ffffffffc0204974:	00008517          	auipc	a0,0x8
ffffffffc0204978:	6f450513          	addi	a0,a0,1780 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc020497c:	e406                	sd	ra,8(sp)
ffffffffc020497e:	b21fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204982 <fd_array_init>:
ffffffffc0204982:	4781                	li	a5,0
ffffffffc0204984:	04800713          	li	a4,72
ffffffffc0204988:	cd1c                	sw	a5,24(a0)
ffffffffc020498a:	02052823          	sw	zero,48(a0)
ffffffffc020498e:	00052023          	sw	zero,0(a0)
ffffffffc0204992:	2785                	addiw	a5,a5,1
ffffffffc0204994:	03850513          	addi	a0,a0,56
ffffffffc0204998:	fee798e3          	bne	a5,a4,ffffffffc0204988 <fd_array_init+0x6>
ffffffffc020499c:	8082                	ret

ffffffffc020499e <fd_array_close>:
ffffffffc020499e:	4118                	lw	a4,0(a0)
ffffffffc02049a0:	1141                	addi	sp,sp,-16
ffffffffc02049a2:	e406                	sd	ra,8(sp)
ffffffffc02049a4:	e022                	sd	s0,0(sp)
ffffffffc02049a6:	4789                	li	a5,2
ffffffffc02049a8:	04f71a63          	bne	a4,a5,ffffffffc02049fc <fd_array_close+0x5e>
ffffffffc02049ac:	591c                	lw	a5,48(a0)
ffffffffc02049ae:	842a                	mv	s0,a0
ffffffffc02049b0:	02f05663          	blez	a5,ffffffffc02049dc <fd_array_close+0x3e>
ffffffffc02049b4:	37fd                	addiw	a5,a5,-1
ffffffffc02049b6:	470d                	li	a4,3
ffffffffc02049b8:	c118                	sw	a4,0(a0)
ffffffffc02049ba:	d91c                	sw	a5,48(a0)
ffffffffc02049bc:	0007871b          	sext.w	a4,a5
ffffffffc02049c0:	c709                	beqz	a4,ffffffffc02049ca <fd_array_close+0x2c>
ffffffffc02049c2:	60a2                	ld	ra,8(sp)
ffffffffc02049c4:	6402                	ld	s0,0(sp)
ffffffffc02049c6:	0141                	addi	sp,sp,16
ffffffffc02049c8:	8082                	ret
ffffffffc02049ca:	7508                	ld	a0,40(a0)
ffffffffc02049cc:	750030ef          	jal	ra,ffffffffc020811c <vfs_close>
ffffffffc02049d0:	60a2                	ld	ra,8(sp)
ffffffffc02049d2:	00042023          	sw	zero,0(s0)
ffffffffc02049d6:	6402                	ld	s0,0(sp)
ffffffffc02049d8:	0141                	addi	sp,sp,16
ffffffffc02049da:	8082                	ret
ffffffffc02049dc:	00008697          	auipc	a3,0x8
ffffffffc02049e0:	74468693          	addi	a3,a3,1860 # ffffffffc020d120 <default_pmm_manager+0xc70>
ffffffffc02049e4:	00007617          	auipc	a2,0x7
ffffffffc02049e8:	fc460613          	addi	a2,a2,-60 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02049ec:	06800593          	li	a1,104
ffffffffc02049f0:	00008517          	auipc	a0,0x8
ffffffffc02049f4:	67850513          	addi	a0,a0,1656 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc02049f8:	aa7fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02049fc:	00008697          	auipc	a3,0x8
ffffffffc0204a00:	69468693          	addi	a3,a3,1684 # ffffffffc020d090 <default_pmm_manager+0xbe0>
ffffffffc0204a04:	00007617          	auipc	a2,0x7
ffffffffc0204a08:	fa460613          	addi	a2,a2,-92 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204a0c:	06700593          	li	a1,103
ffffffffc0204a10:	00008517          	auipc	a0,0x8
ffffffffc0204a14:	65850513          	addi	a0,a0,1624 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204a18:	a87fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204a1c <fd_array_dup>:
ffffffffc0204a1c:	7179                	addi	sp,sp,-48
ffffffffc0204a1e:	e84a                	sd	s2,16(sp)
ffffffffc0204a20:	00052903          	lw	s2,0(a0)
ffffffffc0204a24:	f406                	sd	ra,40(sp)
ffffffffc0204a26:	f022                	sd	s0,32(sp)
ffffffffc0204a28:	ec26                	sd	s1,24(sp)
ffffffffc0204a2a:	e44e                	sd	s3,8(sp)
ffffffffc0204a2c:	4785                	li	a5,1
ffffffffc0204a2e:	04f91663          	bne	s2,a5,ffffffffc0204a7a <fd_array_dup+0x5e>
ffffffffc0204a32:	0005a983          	lw	s3,0(a1)
ffffffffc0204a36:	4789                	li	a5,2
ffffffffc0204a38:	04f99163          	bne	s3,a5,ffffffffc0204a7a <fd_array_dup+0x5e>
ffffffffc0204a3c:	7584                	ld	s1,40(a1)
ffffffffc0204a3e:	699c                	ld	a5,16(a1)
ffffffffc0204a40:	7194                	ld	a3,32(a1)
ffffffffc0204a42:	6598                	ld	a4,8(a1)
ffffffffc0204a44:	842a                	mv	s0,a0
ffffffffc0204a46:	e91c                	sd	a5,16(a0)
ffffffffc0204a48:	f114                	sd	a3,32(a0)
ffffffffc0204a4a:	e518                	sd	a4,8(a0)
ffffffffc0204a4c:	8526                	mv	a0,s1
ffffffffc0204a4e:	62d020ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc0204a52:	8526                	mv	a0,s1
ffffffffc0204a54:	633020ef          	jal	ra,ffffffffc0207886 <inode_open_inc>
ffffffffc0204a58:	401c                	lw	a5,0(s0)
ffffffffc0204a5a:	f404                	sd	s1,40(s0)
ffffffffc0204a5c:	03279f63          	bne	a5,s2,ffffffffc0204a9a <fd_array_dup+0x7e>
ffffffffc0204a60:	cc8d                	beqz	s1,ffffffffc0204a9a <fd_array_dup+0x7e>
ffffffffc0204a62:	581c                	lw	a5,48(s0)
ffffffffc0204a64:	01342023          	sw	s3,0(s0)
ffffffffc0204a68:	70a2                	ld	ra,40(sp)
ffffffffc0204a6a:	2785                	addiw	a5,a5,1
ffffffffc0204a6c:	d81c                	sw	a5,48(s0)
ffffffffc0204a6e:	7402                	ld	s0,32(sp)
ffffffffc0204a70:	64e2                	ld	s1,24(sp)
ffffffffc0204a72:	6942                	ld	s2,16(sp)
ffffffffc0204a74:	69a2                	ld	s3,8(sp)
ffffffffc0204a76:	6145                	addi	sp,sp,48
ffffffffc0204a78:	8082                	ret
ffffffffc0204a7a:	00008697          	auipc	a3,0x8
ffffffffc0204a7e:	6ee68693          	addi	a3,a3,1774 # ffffffffc020d168 <default_pmm_manager+0xcb8>
ffffffffc0204a82:	00007617          	auipc	a2,0x7
ffffffffc0204a86:	f2660613          	addi	a2,a2,-218 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204a8a:	07300593          	li	a1,115
ffffffffc0204a8e:	00008517          	auipc	a0,0x8
ffffffffc0204a92:	5da50513          	addi	a0,a0,1498 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204a96:	a09fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a9a:	ec5ff0ef          	jal	ra,ffffffffc020495e <fd_array_open.part.0>

ffffffffc0204a9e <file_testfd>:
ffffffffc0204a9e:	04700793          	li	a5,71
ffffffffc0204aa2:	04a7e263          	bltu	a5,a0,ffffffffc0204ae6 <file_testfd+0x48>
ffffffffc0204aa6:	00092797          	auipc	a5,0x92
ffffffffc0204aaa:	e1a7b783          	ld	a5,-486(a5) # ffffffffc02968c0 <current>
ffffffffc0204aae:	1487b783          	ld	a5,328(a5)
ffffffffc0204ab2:	cf85                	beqz	a5,ffffffffc0204aea <file_testfd+0x4c>
ffffffffc0204ab4:	4b98                	lw	a4,16(a5)
ffffffffc0204ab6:	02e05a63          	blez	a4,ffffffffc0204aea <file_testfd+0x4c>
ffffffffc0204aba:	6798                	ld	a4,8(a5)
ffffffffc0204abc:	00351793          	slli	a5,a0,0x3
ffffffffc0204ac0:	8f89                	sub	a5,a5,a0
ffffffffc0204ac2:	078e                	slli	a5,a5,0x3
ffffffffc0204ac4:	97ba                	add	a5,a5,a4
ffffffffc0204ac6:	4394                	lw	a3,0(a5)
ffffffffc0204ac8:	4709                	li	a4,2
ffffffffc0204aca:	00e69e63          	bne	a3,a4,ffffffffc0204ae6 <file_testfd+0x48>
ffffffffc0204ace:	4f98                	lw	a4,24(a5)
ffffffffc0204ad0:	00a71b63          	bne	a4,a0,ffffffffc0204ae6 <file_testfd+0x48>
ffffffffc0204ad4:	c199                	beqz	a1,ffffffffc0204ada <file_testfd+0x3c>
ffffffffc0204ad6:	6788                	ld	a0,8(a5)
ffffffffc0204ad8:	c901                	beqz	a0,ffffffffc0204ae8 <file_testfd+0x4a>
ffffffffc0204ada:	4505                	li	a0,1
ffffffffc0204adc:	c611                	beqz	a2,ffffffffc0204ae8 <file_testfd+0x4a>
ffffffffc0204ade:	6b88                	ld	a0,16(a5)
ffffffffc0204ae0:	00a03533          	snez	a0,a0
ffffffffc0204ae4:	8082                	ret
ffffffffc0204ae6:	4501                	li	a0,0
ffffffffc0204ae8:	8082                	ret
ffffffffc0204aea:	1141                	addi	sp,sp,-16
ffffffffc0204aec:	e406                	sd	ra,8(sp)
ffffffffc0204aee:	cd5ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>

ffffffffc0204af2 <file_open>:
ffffffffc0204af2:	711d                	addi	sp,sp,-96
ffffffffc0204af4:	ec86                	sd	ra,88(sp)
ffffffffc0204af6:	e8a2                	sd	s0,80(sp)
ffffffffc0204af8:	e4a6                	sd	s1,72(sp)
ffffffffc0204afa:	e0ca                	sd	s2,64(sp)
ffffffffc0204afc:	fc4e                	sd	s3,56(sp)
ffffffffc0204afe:	f852                	sd	s4,48(sp)
ffffffffc0204b00:	0035f793          	andi	a5,a1,3
ffffffffc0204b04:	470d                	li	a4,3
ffffffffc0204b06:	0ce78163          	beq	a5,a4,ffffffffc0204bc8 <file_open+0xd6>
ffffffffc0204b0a:	078e                	slli	a5,a5,0x3
ffffffffc0204b0c:	00009717          	auipc	a4,0x9
ffffffffc0204b10:	8cc70713          	addi	a4,a4,-1844 # ffffffffc020d3d8 <CSWTCH.79>
ffffffffc0204b14:	892a                	mv	s2,a0
ffffffffc0204b16:	00009697          	auipc	a3,0x9
ffffffffc0204b1a:	8aa68693          	addi	a3,a3,-1878 # ffffffffc020d3c0 <CSWTCH.78>
ffffffffc0204b1e:	755d                	lui	a0,0xffff7
ffffffffc0204b20:	96be                	add	a3,a3,a5
ffffffffc0204b22:	84ae                	mv	s1,a1
ffffffffc0204b24:	97ba                	add	a5,a5,a4
ffffffffc0204b26:	858a                	mv	a1,sp
ffffffffc0204b28:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204b2c:	0006ba03          	ld	s4,0(a3)
ffffffffc0204b30:	0007b983          	ld	s3,0(a5)
ffffffffc0204b34:	cb1ff0ef          	jal	ra,ffffffffc02047e4 <fd_array_alloc>
ffffffffc0204b38:	842a                	mv	s0,a0
ffffffffc0204b3a:	c911                	beqz	a0,ffffffffc0204b4e <file_open+0x5c>
ffffffffc0204b3c:	60e6                	ld	ra,88(sp)
ffffffffc0204b3e:	8522                	mv	a0,s0
ffffffffc0204b40:	6446                	ld	s0,80(sp)
ffffffffc0204b42:	64a6                	ld	s1,72(sp)
ffffffffc0204b44:	6906                	ld	s2,64(sp)
ffffffffc0204b46:	79e2                	ld	s3,56(sp)
ffffffffc0204b48:	7a42                	ld	s4,48(sp)
ffffffffc0204b4a:	6125                	addi	sp,sp,96
ffffffffc0204b4c:	8082                	ret
ffffffffc0204b4e:	0030                	addi	a2,sp,8
ffffffffc0204b50:	85a6                	mv	a1,s1
ffffffffc0204b52:	854a                	mv	a0,s2
ffffffffc0204b54:	422030ef          	jal	ra,ffffffffc0207f76 <vfs_open>
ffffffffc0204b58:	842a                	mv	s0,a0
ffffffffc0204b5a:	e13d                	bnez	a0,ffffffffc0204bc0 <file_open+0xce>
ffffffffc0204b5c:	6782                	ld	a5,0(sp)
ffffffffc0204b5e:	0204f493          	andi	s1,s1,32
ffffffffc0204b62:	6422                	ld	s0,8(sp)
ffffffffc0204b64:	0207b023          	sd	zero,32(a5)
ffffffffc0204b68:	c885                	beqz	s1,ffffffffc0204b98 <file_open+0xa6>
ffffffffc0204b6a:	c03d                	beqz	s0,ffffffffc0204bd0 <file_open+0xde>
ffffffffc0204b6c:	783c                	ld	a5,112(s0)
ffffffffc0204b6e:	c3ad                	beqz	a5,ffffffffc0204bd0 <file_open+0xde>
ffffffffc0204b70:	779c                	ld	a5,40(a5)
ffffffffc0204b72:	cfb9                	beqz	a5,ffffffffc0204bd0 <file_open+0xde>
ffffffffc0204b74:	8522                	mv	a0,s0
ffffffffc0204b76:	00008597          	auipc	a1,0x8
ffffffffc0204b7a:	67a58593          	addi	a1,a1,1658 # ffffffffc020d1f0 <default_pmm_manager+0xd40>
ffffffffc0204b7e:	515020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0204b82:	783c                	ld	a5,112(s0)
ffffffffc0204b84:	6522                	ld	a0,8(sp)
ffffffffc0204b86:	080c                	addi	a1,sp,16
ffffffffc0204b88:	779c                	ld	a5,40(a5)
ffffffffc0204b8a:	9782                	jalr	a5
ffffffffc0204b8c:	842a                	mv	s0,a0
ffffffffc0204b8e:	e515                	bnez	a0,ffffffffc0204bba <file_open+0xc8>
ffffffffc0204b90:	6782                	ld	a5,0(sp)
ffffffffc0204b92:	7722                	ld	a4,40(sp)
ffffffffc0204b94:	6422                	ld	s0,8(sp)
ffffffffc0204b96:	f398                	sd	a4,32(a5)
ffffffffc0204b98:	4394                	lw	a3,0(a5)
ffffffffc0204b9a:	f780                	sd	s0,40(a5)
ffffffffc0204b9c:	0147b423          	sd	s4,8(a5)
ffffffffc0204ba0:	0137b823          	sd	s3,16(a5)
ffffffffc0204ba4:	4705                	li	a4,1
ffffffffc0204ba6:	02e69363          	bne	a3,a4,ffffffffc0204bcc <file_open+0xda>
ffffffffc0204baa:	c00d                	beqz	s0,ffffffffc0204bcc <file_open+0xda>
ffffffffc0204bac:	5b98                	lw	a4,48(a5)
ffffffffc0204bae:	4689                	li	a3,2
ffffffffc0204bb0:	4f80                	lw	s0,24(a5)
ffffffffc0204bb2:	2705                	addiw	a4,a4,1
ffffffffc0204bb4:	c394                	sw	a3,0(a5)
ffffffffc0204bb6:	db98                	sw	a4,48(a5)
ffffffffc0204bb8:	b751                	j	ffffffffc0204b3c <file_open+0x4a>
ffffffffc0204bba:	6522                	ld	a0,8(sp)
ffffffffc0204bbc:	560030ef          	jal	ra,ffffffffc020811c <vfs_close>
ffffffffc0204bc0:	6502                	ld	a0,0(sp)
ffffffffc0204bc2:	cb7ff0ef          	jal	ra,ffffffffc0204878 <fd_array_free>
ffffffffc0204bc6:	bf9d                	j	ffffffffc0204b3c <file_open+0x4a>
ffffffffc0204bc8:	5475                	li	s0,-3
ffffffffc0204bca:	bf8d                	j	ffffffffc0204b3c <file_open+0x4a>
ffffffffc0204bcc:	d93ff0ef          	jal	ra,ffffffffc020495e <fd_array_open.part.0>
ffffffffc0204bd0:	00008697          	auipc	a3,0x8
ffffffffc0204bd4:	5d068693          	addi	a3,a3,1488 # ffffffffc020d1a0 <default_pmm_manager+0xcf0>
ffffffffc0204bd8:	00007617          	auipc	a2,0x7
ffffffffc0204bdc:	dd060613          	addi	a2,a2,-560 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204be0:	0b500593          	li	a1,181
ffffffffc0204be4:	00008517          	auipc	a0,0x8
ffffffffc0204be8:	48450513          	addi	a0,a0,1156 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204bec:	8b3fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204bf0 <file_close>:
ffffffffc0204bf0:	04700713          	li	a4,71
ffffffffc0204bf4:	04a76563          	bltu	a4,a0,ffffffffc0204c3e <file_close+0x4e>
ffffffffc0204bf8:	00092717          	auipc	a4,0x92
ffffffffc0204bfc:	cc873703          	ld	a4,-824(a4) # ffffffffc02968c0 <current>
ffffffffc0204c00:	14873703          	ld	a4,328(a4)
ffffffffc0204c04:	1141                	addi	sp,sp,-16
ffffffffc0204c06:	e406                	sd	ra,8(sp)
ffffffffc0204c08:	cf0d                	beqz	a4,ffffffffc0204c42 <file_close+0x52>
ffffffffc0204c0a:	4b14                	lw	a3,16(a4)
ffffffffc0204c0c:	02d05b63          	blez	a3,ffffffffc0204c42 <file_close+0x52>
ffffffffc0204c10:	6718                	ld	a4,8(a4)
ffffffffc0204c12:	87aa                	mv	a5,a0
ffffffffc0204c14:	050e                	slli	a0,a0,0x3
ffffffffc0204c16:	8d1d                	sub	a0,a0,a5
ffffffffc0204c18:	050e                	slli	a0,a0,0x3
ffffffffc0204c1a:	953a                	add	a0,a0,a4
ffffffffc0204c1c:	4114                	lw	a3,0(a0)
ffffffffc0204c1e:	4709                	li	a4,2
ffffffffc0204c20:	00e69b63          	bne	a3,a4,ffffffffc0204c36 <file_close+0x46>
ffffffffc0204c24:	4d18                	lw	a4,24(a0)
ffffffffc0204c26:	00f71863          	bne	a4,a5,ffffffffc0204c36 <file_close+0x46>
ffffffffc0204c2a:	d75ff0ef          	jal	ra,ffffffffc020499e <fd_array_close>
ffffffffc0204c2e:	60a2                	ld	ra,8(sp)
ffffffffc0204c30:	4501                	li	a0,0
ffffffffc0204c32:	0141                	addi	sp,sp,16
ffffffffc0204c34:	8082                	ret
ffffffffc0204c36:	60a2                	ld	ra,8(sp)
ffffffffc0204c38:	5575                	li	a0,-3
ffffffffc0204c3a:	0141                	addi	sp,sp,16
ffffffffc0204c3c:	8082                	ret
ffffffffc0204c3e:	5575                	li	a0,-3
ffffffffc0204c40:	8082                	ret
ffffffffc0204c42:	b81ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>

ffffffffc0204c46 <file_read>:
ffffffffc0204c46:	715d                	addi	sp,sp,-80
ffffffffc0204c48:	e486                	sd	ra,72(sp)
ffffffffc0204c4a:	e0a2                	sd	s0,64(sp)
ffffffffc0204c4c:	fc26                	sd	s1,56(sp)
ffffffffc0204c4e:	f84a                	sd	s2,48(sp)
ffffffffc0204c50:	f44e                	sd	s3,40(sp)
ffffffffc0204c52:	f052                	sd	s4,32(sp)
ffffffffc0204c54:	0006b023          	sd	zero,0(a3)
ffffffffc0204c58:	04700793          	li	a5,71
ffffffffc0204c5c:	0aa7e463          	bltu	a5,a0,ffffffffc0204d04 <file_read+0xbe>
ffffffffc0204c60:	00092797          	auipc	a5,0x92
ffffffffc0204c64:	c607b783          	ld	a5,-928(a5) # ffffffffc02968c0 <current>
ffffffffc0204c68:	1487b783          	ld	a5,328(a5)
ffffffffc0204c6c:	cfd1                	beqz	a5,ffffffffc0204d08 <file_read+0xc2>
ffffffffc0204c6e:	4b98                	lw	a4,16(a5)
ffffffffc0204c70:	08e05c63          	blez	a4,ffffffffc0204d08 <file_read+0xc2>
ffffffffc0204c74:	6780                	ld	s0,8(a5)
ffffffffc0204c76:	00351793          	slli	a5,a0,0x3
ffffffffc0204c7a:	8f89                	sub	a5,a5,a0
ffffffffc0204c7c:	078e                	slli	a5,a5,0x3
ffffffffc0204c7e:	943e                	add	s0,s0,a5
ffffffffc0204c80:	00042983          	lw	s3,0(s0)
ffffffffc0204c84:	4789                	li	a5,2
ffffffffc0204c86:	06f99f63          	bne	s3,a5,ffffffffc0204d04 <file_read+0xbe>
ffffffffc0204c8a:	4c1c                	lw	a5,24(s0)
ffffffffc0204c8c:	06a79c63          	bne	a5,a0,ffffffffc0204d04 <file_read+0xbe>
ffffffffc0204c90:	641c                	ld	a5,8(s0)
ffffffffc0204c92:	cbad                	beqz	a5,ffffffffc0204d04 <file_read+0xbe>
ffffffffc0204c94:	581c                	lw	a5,48(s0)
ffffffffc0204c96:	8a36                	mv	s4,a3
ffffffffc0204c98:	7014                	ld	a3,32(s0)
ffffffffc0204c9a:	2785                	addiw	a5,a5,1
ffffffffc0204c9c:	850a                	mv	a0,sp
ffffffffc0204c9e:	d81c                	sw	a5,48(s0)
ffffffffc0204ca0:	792000ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc0204ca4:	02843903          	ld	s2,40(s0)
ffffffffc0204ca8:	84aa                	mv	s1,a0
ffffffffc0204caa:	06090163          	beqz	s2,ffffffffc0204d0c <file_read+0xc6>
ffffffffc0204cae:	07093783          	ld	a5,112(s2)
ffffffffc0204cb2:	cfa9                	beqz	a5,ffffffffc0204d0c <file_read+0xc6>
ffffffffc0204cb4:	6f9c                	ld	a5,24(a5)
ffffffffc0204cb6:	cbb9                	beqz	a5,ffffffffc0204d0c <file_read+0xc6>
ffffffffc0204cb8:	00008597          	auipc	a1,0x8
ffffffffc0204cbc:	59058593          	addi	a1,a1,1424 # ffffffffc020d248 <default_pmm_manager+0xd98>
ffffffffc0204cc0:	854a                	mv	a0,s2
ffffffffc0204cc2:	3d1020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0204cc6:	07093783          	ld	a5,112(s2)
ffffffffc0204cca:	7408                	ld	a0,40(s0)
ffffffffc0204ccc:	85a6                	mv	a1,s1
ffffffffc0204cce:	6f9c                	ld	a5,24(a5)
ffffffffc0204cd0:	9782                	jalr	a5
ffffffffc0204cd2:	689c                	ld	a5,16(s1)
ffffffffc0204cd4:	6c94                	ld	a3,24(s1)
ffffffffc0204cd6:	4018                	lw	a4,0(s0)
ffffffffc0204cd8:	84aa                	mv	s1,a0
ffffffffc0204cda:	8f95                	sub	a5,a5,a3
ffffffffc0204cdc:	03370063          	beq	a4,s3,ffffffffc0204cfc <file_read+0xb6>
ffffffffc0204ce0:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204ce4:	8522                	mv	a0,s0
ffffffffc0204ce6:	c0fff0ef          	jal	ra,ffffffffc02048f4 <fd_array_release>
ffffffffc0204cea:	60a6                	ld	ra,72(sp)
ffffffffc0204cec:	6406                	ld	s0,64(sp)
ffffffffc0204cee:	7942                	ld	s2,48(sp)
ffffffffc0204cf0:	79a2                	ld	s3,40(sp)
ffffffffc0204cf2:	7a02                	ld	s4,32(sp)
ffffffffc0204cf4:	8526                	mv	a0,s1
ffffffffc0204cf6:	74e2                	ld	s1,56(sp)
ffffffffc0204cf8:	6161                	addi	sp,sp,80
ffffffffc0204cfa:	8082                	ret
ffffffffc0204cfc:	7018                	ld	a4,32(s0)
ffffffffc0204cfe:	973e                	add	a4,a4,a5
ffffffffc0204d00:	f018                	sd	a4,32(s0)
ffffffffc0204d02:	bff9                	j	ffffffffc0204ce0 <file_read+0x9a>
ffffffffc0204d04:	54f5                	li	s1,-3
ffffffffc0204d06:	b7d5                	j	ffffffffc0204cea <file_read+0xa4>
ffffffffc0204d08:	abbff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>
ffffffffc0204d0c:	00008697          	auipc	a3,0x8
ffffffffc0204d10:	4ec68693          	addi	a3,a3,1260 # ffffffffc020d1f8 <default_pmm_manager+0xd48>
ffffffffc0204d14:	00007617          	auipc	a2,0x7
ffffffffc0204d18:	c9460613          	addi	a2,a2,-876 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204d1c:	0de00593          	li	a1,222
ffffffffc0204d20:	00008517          	auipc	a0,0x8
ffffffffc0204d24:	34850513          	addi	a0,a0,840 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204d28:	f76fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204d2c <file_write>:
ffffffffc0204d2c:	715d                	addi	sp,sp,-80
ffffffffc0204d2e:	e486                	sd	ra,72(sp)
ffffffffc0204d30:	e0a2                	sd	s0,64(sp)
ffffffffc0204d32:	fc26                	sd	s1,56(sp)
ffffffffc0204d34:	f84a                	sd	s2,48(sp)
ffffffffc0204d36:	f44e                	sd	s3,40(sp)
ffffffffc0204d38:	f052                	sd	s4,32(sp)
ffffffffc0204d3a:	0006b023          	sd	zero,0(a3)
ffffffffc0204d3e:	04700793          	li	a5,71
ffffffffc0204d42:	0aa7e463          	bltu	a5,a0,ffffffffc0204dea <file_write+0xbe>
ffffffffc0204d46:	00092797          	auipc	a5,0x92
ffffffffc0204d4a:	b7a7b783          	ld	a5,-1158(a5) # ffffffffc02968c0 <current>
ffffffffc0204d4e:	1487b783          	ld	a5,328(a5)
ffffffffc0204d52:	cfd1                	beqz	a5,ffffffffc0204dee <file_write+0xc2>
ffffffffc0204d54:	4b98                	lw	a4,16(a5)
ffffffffc0204d56:	08e05c63          	blez	a4,ffffffffc0204dee <file_write+0xc2>
ffffffffc0204d5a:	6780                	ld	s0,8(a5)
ffffffffc0204d5c:	00351793          	slli	a5,a0,0x3
ffffffffc0204d60:	8f89                	sub	a5,a5,a0
ffffffffc0204d62:	078e                	slli	a5,a5,0x3
ffffffffc0204d64:	943e                	add	s0,s0,a5
ffffffffc0204d66:	00042983          	lw	s3,0(s0)
ffffffffc0204d6a:	4789                	li	a5,2
ffffffffc0204d6c:	06f99f63          	bne	s3,a5,ffffffffc0204dea <file_write+0xbe>
ffffffffc0204d70:	4c1c                	lw	a5,24(s0)
ffffffffc0204d72:	06a79c63          	bne	a5,a0,ffffffffc0204dea <file_write+0xbe>
ffffffffc0204d76:	681c                	ld	a5,16(s0)
ffffffffc0204d78:	cbad                	beqz	a5,ffffffffc0204dea <file_write+0xbe>
ffffffffc0204d7a:	581c                	lw	a5,48(s0)
ffffffffc0204d7c:	8a36                	mv	s4,a3
ffffffffc0204d7e:	7014                	ld	a3,32(s0)
ffffffffc0204d80:	2785                	addiw	a5,a5,1
ffffffffc0204d82:	850a                	mv	a0,sp
ffffffffc0204d84:	d81c                	sw	a5,48(s0)
ffffffffc0204d86:	6ac000ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc0204d8a:	02843903          	ld	s2,40(s0)
ffffffffc0204d8e:	84aa                	mv	s1,a0
ffffffffc0204d90:	06090163          	beqz	s2,ffffffffc0204df2 <file_write+0xc6>
ffffffffc0204d94:	07093783          	ld	a5,112(s2)
ffffffffc0204d98:	cfa9                	beqz	a5,ffffffffc0204df2 <file_write+0xc6>
ffffffffc0204d9a:	739c                	ld	a5,32(a5)
ffffffffc0204d9c:	cbb9                	beqz	a5,ffffffffc0204df2 <file_write+0xc6>
ffffffffc0204d9e:	00008597          	auipc	a1,0x8
ffffffffc0204da2:	50258593          	addi	a1,a1,1282 # ffffffffc020d2a0 <default_pmm_manager+0xdf0>
ffffffffc0204da6:	854a                	mv	a0,s2
ffffffffc0204da8:	2eb020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0204dac:	07093783          	ld	a5,112(s2)
ffffffffc0204db0:	7408                	ld	a0,40(s0)
ffffffffc0204db2:	85a6                	mv	a1,s1
ffffffffc0204db4:	739c                	ld	a5,32(a5)
ffffffffc0204db6:	9782                	jalr	a5
ffffffffc0204db8:	689c                	ld	a5,16(s1)
ffffffffc0204dba:	6c94                	ld	a3,24(s1)
ffffffffc0204dbc:	4018                	lw	a4,0(s0)
ffffffffc0204dbe:	84aa                	mv	s1,a0
ffffffffc0204dc0:	8f95                	sub	a5,a5,a3
ffffffffc0204dc2:	03370063          	beq	a4,s3,ffffffffc0204de2 <file_write+0xb6>
ffffffffc0204dc6:	00fa3023          	sd	a5,0(s4)
ffffffffc0204dca:	8522                	mv	a0,s0
ffffffffc0204dcc:	b29ff0ef          	jal	ra,ffffffffc02048f4 <fd_array_release>
ffffffffc0204dd0:	60a6                	ld	ra,72(sp)
ffffffffc0204dd2:	6406                	ld	s0,64(sp)
ffffffffc0204dd4:	7942                	ld	s2,48(sp)
ffffffffc0204dd6:	79a2                	ld	s3,40(sp)
ffffffffc0204dd8:	7a02                	ld	s4,32(sp)
ffffffffc0204dda:	8526                	mv	a0,s1
ffffffffc0204ddc:	74e2                	ld	s1,56(sp)
ffffffffc0204dde:	6161                	addi	sp,sp,80
ffffffffc0204de0:	8082                	ret
ffffffffc0204de2:	7018                	ld	a4,32(s0)
ffffffffc0204de4:	973e                	add	a4,a4,a5
ffffffffc0204de6:	f018                	sd	a4,32(s0)
ffffffffc0204de8:	bff9                	j	ffffffffc0204dc6 <file_write+0x9a>
ffffffffc0204dea:	54f5                	li	s1,-3
ffffffffc0204dec:	b7d5                	j	ffffffffc0204dd0 <file_write+0xa4>
ffffffffc0204dee:	9d5ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>
ffffffffc0204df2:	00008697          	auipc	a3,0x8
ffffffffc0204df6:	45e68693          	addi	a3,a3,1118 # ffffffffc020d250 <default_pmm_manager+0xda0>
ffffffffc0204dfa:	00007617          	auipc	a2,0x7
ffffffffc0204dfe:	bae60613          	addi	a2,a2,-1106 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204e02:	0f800593          	li	a1,248
ffffffffc0204e06:	00008517          	auipc	a0,0x8
ffffffffc0204e0a:	26250513          	addi	a0,a0,610 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204e0e:	e90fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204e12 <file_seek>:
ffffffffc0204e12:	7139                	addi	sp,sp,-64
ffffffffc0204e14:	fc06                	sd	ra,56(sp)
ffffffffc0204e16:	f822                	sd	s0,48(sp)
ffffffffc0204e18:	f426                	sd	s1,40(sp)
ffffffffc0204e1a:	f04a                	sd	s2,32(sp)
ffffffffc0204e1c:	04700793          	li	a5,71
ffffffffc0204e20:	08a7e863          	bltu	a5,a0,ffffffffc0204eb0 <file_seek+0x9e>
ffffffffc0204e24:	00092797          	auipc	a5,0x92
ffffffffc0204e28:	a9c7b783          	ld	a5,-1380(a5) # ffffffffc02968c0 <current>
ffffffffc0204e2c:	1487b783          	ld	a5,328(a5)
ffffffffc0204e30:	cfdd                	beqz	a5,ffffffffc0204eee <file_seek+0xdc>
ffffffffc0204e32:	4b98                	lw	a4,16(a5)
ffffffffc0204e34:	0ae05d63          	blez	a4,ffffffffc0204eee <file_seek+0xdc>
ffffffffc0204e38:	6780                	ld	s0,8(a5)
ffffffffc0204e3a:	00351793          	slli	a5,a0,0x3
ffffffffc0204e3e:	8f89                	sub	a5,a5,a0
ffffffffc0204e40:	078e                	slli	a5,a5,0x3
ffffffffc0204e42:	943e                	add	s0,s0,a5
ffffffffc0204e44:	4018                	lw	a4,0(s0)
ffffffffc0204e46:	4789                	li	a5,2
ffffffffc0204e48:	06f71463          	bne	a4,a5,ffffffffc0204eb0 <file_seek+0x9e>
ffffffffc0204e4c:	4c1c                	lw	a5,24(s0)
ffffffffc0204e4e:	06a79163          	bne	a5,a0,ffffffffc0204eb0 <file_seek+0x9e>
ffffffffc0204e52:	581c                	lw	a5,48(s0)
ffffffffc0204e54:	4685                	li	a3,1
ffffffffc0204e56:	892e                	mv	s2,a1
ffffffffc0204e58:	2785                	addiw	a5,a5,1
ffffffffc0204e5a:	d81c                	sw	a5,48(s0)
ffffffffc0204e5c:	02d60063          	beq	a2,a3,ffffffffc0204e7c <file_seek+0x6a>
ffffffffc0204e60:	06e60063          	beq	a2,a4,ffffffffc0204ec0 <file_seek+0xae>
ffffffffc0204e64:	54f5                	li	s1,-3
ffffffffc0204e66:	ce11                	beqz	a2,ffffffffc0204e82 <file_seek+0x70>
ffffffffc0204e68:	8522                	mv	a0,s0
ffffffffc0204e6a:	a8bff0ef          	jal	ra,ffffffffc02048f4 <fd_array_release>
ffffffffc0204e6e:	70e2                	ld	ra,56(sp)
ffffffffc0204e70:	7442                	ld	s0,48(sp)
ffffffffc0204e72:	7902                	ld	s2,32(sp)
ffffffffc0204e74:	8526                	mv	a0,s1
ffffffffc0204e76:	74a2                	ld	s1,40(sp)
ffffffffc0204e78:	6121                	addi	sp,sp,64
ffffffffc0204e7a:	8082                	ret
ffffffffc0204e7c:	701c                	ld	a5,32(s0)
ffffffffc0204e7e:	00f58933          	add	s2,a1,a5
ffffffffc0204e82:	7404                	ld	s1,40(s0)
ffffffffc0204e84:	c4bd                	beqz	s1,ffffffffc0204ef2 <file_seek+0xe0>
ffffffffc0204e86:	78bc                	ld	a5,112(s1)
ffffffffc0204e88:	c7ad                	beqz	a5,ffffffffc0204ef2 <file_seek+0xe0>
ffffffffc0204e8a:	6fbc                	ld	a5,88(a5)
ffffffffc0204e8c:	c3bd                	beqz	a5,ffffffffc0204ef2 <file_seek+0xe0>
ffffffffc0204e8e:	8526                	mv	a0,s1
ffffffffc0204e90:	00008597          	auipc	a1,0x8
ffffffffc0204e94:	46858593          	addi	a1,a1,1128 # ffffffffc020d2f8 <default_pmm_manager+0xe48>
ffffffffc0204e98:	1fb020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0204e9c:	78bc                	ld	a5,112(s1)
ffffffffc0204e9e:	7408                	ld	a0,40(s0)
ffffffffc0204ea0:	85ca                	mv	a1,s2
ffffffffc0204ea2:	6fbc                	ld	a5,88(a5)
ffffffffc0204ea4:	9782                	jalr	a5
ffffffffc0204ea6:	84aa                	mv	s1,a0
ffffffffc0204ea8:	f161                	bnez	a0,ffffffffc0204e68 <file_seek+0x56>
ffffffffc0204eaa:	03243023          	sd	s2,32(s0)
ffffffffc0204eae:	bf6d                	j	ffffffffc0204e68 <file_seek+0x56>
ffffffffc0204eb0:	70e2                	ld	ra,56(sp)
ffffffffc0204eb2:	7442                	ld	s0,48(sp)
ffffffffc0204eb4:	54f5                	li	s1,-3
ffffffffc0204eb6:	7902                	ld	s2,32(sp)
ffffffffc0204eb8:	8526                	mv	a0,s1
ffffffffc0204eba:	74a2                	ld	s1,40(sp)
ffffffffc0204ebc:	6121                	addi	sp,sp,64
ffffffffc0204ebe:	8082                	ret
ffffffffc0204ec0:	7404                	ld	s1,40(s0)
ffffffffc0204ec2:	c8a1                	beqz	s1,ffffffffc0204f12 <file_seek+0x100>
ffffffffc0204ec4:	78bc                	ld	a5,112(s1)
ffffffffc0204ec6:	c7b1                	beqz	a5,ffffffffc0204f12 <file_seek+0x100>
ffffffffc0204ec8:	779c                	ld	a5,40(a5)
ffffffffc0204eca:	c7a1                	beqz	a5,ffffffffc0204f12 <file_seek+0x100>
ffffffffc0204ecc:	8526                	mv	a0,s1
ffffffffc0204ece:	00008597          	auipc	a1,0x8
ffffffffc0204ed2:	32258593          	addi	a1,a1,802 # ffffffffc020d1f0 <default_pmm_manager+0xd40>
ffffffffc0204ed6:	1bd020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0204eda:	78bc                	ld	a5,112(s1)
ffffffffc0204edc:	7408                	ld	a0,40(s0)
ffffffffc0204ede:	858a                	mv	a1,sp
ffffffffc0204ee0:	779c                	ld	a5,40(a5)
ffffffffc0204ee2:	9782                	jalr	a5
ffffffffc0204ee4:	84aa                	mv	s1,a0
ffffffffc0204ee6:	f149                	bnez	a0,ffffffffc0204e68 <file_seek+0x56>
ffffffffc0204ee8:	67e2                	ld	a5,24(sp)
ffffffffc0204eea:	993e                	add	s2,s2,a5
ffffffffc0204eec:	bf59                	j	ffffffffc0204e82 <file_seek+0x70>
ffffffffc0204eee:	8d5ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>
ffffffffc0204ef2:	00008697          	auipc	a3,0x8
ffffffffc0204ef6:	3b668693          	addi	a3,a3,950 # ffffffffc020d2a8 <default_pmm_manager+0xdf8>
ffffffffc0204efa:	00007617          	auipc	a2,0x7
ffffffffc0204efe:	aae60613          	addi	a2,a2,-1362 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204f02:	11a00593          	li	a1,282
ffffffffc0204f06:	00008517          	auipc	a0,0x8
ffffffffc0204f0a:	16250513          	addi	a0,a0,354 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204f0e:	d90fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204f12:	00008697          	auipc	a3,0x8
ffffffffc0204f16:	28e68693          	addi	a3,a3,654 # ffffffffc020d1a0 <default_pmm_manager+0xcf0>
ffffffffc0204f1a:	00007617          	auipc	a2,0x7
ffffffffc0204f1e:	a8e60613          	addi	a2,a2,-1394 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204f22:	11200593          	li	a1,274
ffffffffc0204f26:	00008517          	auipc	a0,0x8
ffffffffc0204f2a:	14250513          	addi	a0,a0,322 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204f2e:	d70fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204f32 <file_fstat>:
ffffffffc0204f32:	1101                	addi	sp,sp,-32
ffffffffc0204f34:	ec06                	sd	ra,24(sp)
ffffffffc0204f36:	e822                	sd	s0,16(sp)
ffffffffc0204f38:	e426                	sd	s1,8(sp)
ffffffffc0204f3a:	e04a                	sd	s2,0(sp)
ffffffffc0204f3c:	04700793          	li	a5,71
ffffffffc0204f40:	06a7ef63          	bltu	a5,a0,ffffffffc0204fbe <file_fstat+0x8c>
ffffffffc0204f44:	00092797          	auipc	a5,0x92
ffffffffc0204f48:	97c7b783          	ld	a5,-1668(a5) # ffffffffc02968c0 <current>
ffffffffc0204f4c:	1487b783          	ld	a5,328(a5)
ffffffffc0204f50:	cfd9                	beqz	a5,ffffffffc0204fee <file_fstat+0xbc>
ffffffffc0204f52:	4b98                	lw	a4,16(a5)
ffffffffc0204f54:	08e05d63          	blez	a4,ffffffffc0204fee <file_fstat+0xbc>
ffffffffc0204f58:	6780                	ld	s0,8(a5)
ffffffffc0204f5a:	00351793          	slli	a5,a0,0x3
ffffffffc0204f5e:	8f89                	sub	a5,a5,a0
ffffffffc0204f60:	078e                	slli	a5,a5,0x3
ffffffffc0204f62:	943e                	add	s0,s0,a5
ffffffffc0204f64:	4018                	lw	a4,0(s0)
ffffffffc0204f66:	4789                	li	a5,2
ffffffffc0204f68:	04f71b63          	bne	a4,a5,ffffffffc0204fbe <file_fstat+0x8c>
ffffffffc0204f6c:	4c1c                	lw	a5,24(s0)
ffffffffc0204f6e:	04a79863          	bne	a5,a0,ffffffffc0204fbe <file_fstat+0x8c>
ffffffffc0204f72:	581c                	lw	a5,48(s0)
ffffffffc0204f74:	02843903          	ld	s2,40(s0)
ffffffffc0204f78:	2785                	addiw	a5,a5,1
ffffffffc0204f7a:	d81c                	sw	a5,48(s0)
ffffffffc0204f7c:	04090963          	beqz	s2,ffffffffc0204fce <file_fstat+0x9c>
ffffffffc0204f80:	07093783          	ld	a5,112(s2)
ffffffffc0204f84:	c7a9                	beqz	a5,ffffffffc0204fce <file_fstat+0x9c>
ffffffffc0204f86:	779c                	ld	a5,40(a5)
ffffffffc0204f88:	c3b9                	beqz	a5,ffffffffc0204fce <file_fstat+0x9c>
ffffffffc0204f8a:	84ae                	mv	s1,a1
ffffffffc0204f8c:	854a                	mv	a0,s2
ffffffffc0204f8e:	00008597          	auipc	a1,0x8
ffffffffc0204f92:	26258593          	addi	a1,a1,610 # ffffffffc020d1f0 <default_pmm_manager+0xd40>
ffffffffc0204f96:	0fd020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0204f9a:	07093783          	ld	a5,112(s2)
ffffffffc0204f9e:	7408                	ld	a0,40(s0)
ffffffffc0204fa0:	85a6                	mv	a1,s1
ffffffffc0204fa2:	779c                	ld	a5,40(a5)
ffffffffc0204fa4:	9782                	jalr	a5
ffffffffc0204fa6:	87aa                	mv	a5,a0
ffffffffc0204fa8:	8522                	mv	a0,s0
ffffffffc0204faa:	843e                	mv	s0,a5
ffffffffc0204fac:	949ff0ef          	jal	ra,ffffffffc02048f4 <fd_array_release>
ffffffffc0204fb0:	60e2                	ld	ra,24(sp)
ffffffffc0204fb2:	8522                	mv	a0,s0
ffffffffc0204fb4:	6442                	ld	s0,16(sp)
ffffffffc0204fb6:	64a2                	ld	s1,8(sp)
ffffffffc0204fb8:	6902                	ld	s2,0(sp)
ffffffffc0204fba:	6105                	addi	sp,sp,32
ffffffffc0204fbc:	8082                	ret
ffffffffc0204fbe:	5475                	li	s0,-3
ffffffffc0204fc0:	60e2                	ld	ra,24(sp)
ffffffffc0204fc2:	8522                	mv	a0,s0
ffffffffc0204fc4:	6442                	ld	s0,16(sp)
ffffffffc0204fc6:	64a2                	ld	s1,8(sp)
ffffffffc0204fc8:	6902                	ld	s2,0(sp)
ffffffffc0204fca:	6105                	addi	sp,sp,32
ffffffffc0204fcc:	8082                	ret
ffffffffc0204fce:	00008697          	auipc	a3,0x8
ffffffffc0204fd2:	1d268693          	addi	a3,a3,466 # ffffffffc020d1a0 <default_pmm_manager+0xcf0>
ffffffffc0204fd6:	00007617          	auipc	a2,0x7
ffffffffc0204fda:	9d260613          	addi	a2,a2,-1582 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0204fde:	12c00593          	li	a1,300
ffffffffc0204fe2:	00008517          	auipc	a0,0x8
ffffffffc0204fe6:	08650513          	addi	a0,a0,134 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0204fea:	cb4fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204fee:	fd4ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>

ffffffffc0204ff2 <file_fsync>:
ffffffffc0204ff2:	1101                	addi	sp,sp,-32
ffffffffc0204ff4:	ec06                	sd	ra,24(sp)
ffffffffc0204ff6:	e822                	sd	s0,16(sp)
ffffffffc0204ff8:	e426                	sd	s1,8(sp)
ffffffffc0204ffa:	04700793          	li	a5,71
ffffffffc0204ffe:	06a7e863          	bltu	a5,a0,ffffffffc020506e <file_fsync+0x7c>
ffffffffc0205002:	00092797          	auipc	a5,0x92
ffffffffc0205006:	8be7b783          	ld	a5,-1858(a5) # ffffffffc02968c0 <current>
ffffffffc020500a:	1487b783          	ld	a5,328(a5)
ffffffffc020500e:	c7d9                	beqz	a5,ffffffffc020509c <file_fsync+0xaa>
ffffffffc0205010:	4b98                	lw	a4,16(a5)
ffffffffc0205012:	08e05563          	blez	a4,ffffffffc020509c <file_fsync+0xaa>
ffffffffc0205016:	6780                	ld	s0,8(a5)
ffffffffc0205018:	00351793          	slli	a5,a0,0x3
ffffffffc020501c:	8f89                	sub	a5,a5,a0
ffffffffc020501e:	078e                	slli	a5,a5,0x3
ffffffffc0205020:	943e                	add	s0,s0,a5
ffffffffc0205022:	4018                	lw	a4,0(s0)
ffffffffc0205024:	4789                	li	a5,2
ffffffffc0205026:	04f71463          	bne	a4,a5,ffffffffc020506e <file_fsync+0x7c>
ffffffffc020502a:	4c1c                	lw	a5,24(s0)
ffffffffc020502c:	04a79163          	bne	a5,a0,ffffffffc020506e <file_fsync+0x7c>
ffffffffc0205030:	581c                	lw	a5,48(s0)
ffffffffc0205032:	7404                	ld	s1,40(s0)
ffffffffc0205034:	2785                	addiw	a5,a5,1
ffffffffc0205036:	d81c                	sw	a5,48(s0)
ffffffffc0205038:	c0b1                	beqz	s1,ffffffffc020507c <file_fsync+0x8a>
ffffffffc020503a:	78bc                	ld	a5,112(s1)
ffffffffc020503c:	c3a1                	beqz	a5,ffffffffc020507c <file_fsync+0x8a>
ffffffffc020503e:	7b9c                	ld	a5,48(a5)
ffffffffc0205040:	cf95                	beqz	a5,ffffffffc020507c <file_fsync+0x8a>
ffffffffc0205042:	00008597          	auipc	a1,0x8
ffffffffc0205046:	30e58593          	addi	a1,a1,782 # ffffffffc020d350 <default_pmm_manager+0xea0>
ffffffffc020504a:	8526                	mv	a0,s1
ffffffffc020504c:	047020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0205050:	78bc                	ld	a5,112(s1)
ffffffffc0205052:	7408                	ld	a0,40(s0)
ffffffffc0205054:	7b9c                	ld	a5,48(a5)
ffffffffc0205056:	9782                	jalr	a5
ffffffffc0205058:	87aa                	mv	a5,a0
ffffffffc020505a:	8522                	mv	a0,s0
ffffffffc020505c:	843e                	mv	s0,a5
ffffffffc020505e:	897ff0ef          	jal	ra,ffffffffc02048f4 <fd_array_release>
ffffffffc0205062:	60e2                	ld	ra,24(sp)
ffffffffc0205064:	8522                	mv	a0,s0
ffffffffc0205066:	6442                	ld	s0,16(sp)
ffffffffc0205068:	64a2                	ld	s1,8(sp)
ffffffffc020506a:	6105                	addi	sp,sp,32
ffffffffc020506c:	8082                	ret
ffffffffc020506e:	5475                	li	s0,-3
ffffffffc0205070:	60e2                	ld	ra,24(sp)
ffffffffc0205072:	8522                	mv	a0,s0
ffffffffc0205074:	6442                	ld	s0,16(sp)
ffffffffc0205076:	64a2                	ld	s1,8(sp)
ffffffffc0205078:	6105                	addi	sp,sp,32
ffffffffc020507a:	8082                	ret
ffffffffc020507c:	00008697          	auipc	a3,0x8
ffffffffc0205080:	28468693          	addi	a3,a3,644 # ffffffffc020d300 <default_pmm_manager+0xe50>
ffffffffc0205084:	00007617          	auipc	a2,0x7
ffffffffc0205088:	92460613          	addi	a2,a2,-1756 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020508c:	13a00593          	li	a1,314
ffffffffc0205090:	00008517          	auipc	a0,0x8
ffffffffc0205094:	fd850513          	addi	a0,a0,-40 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc0205098:	c06fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020509c:	f26ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>

ffffffffc02050a0 <file_getdirentry>:
ffffffffc02050a0:	715d                	addi	sp,sp,-80
ffffffffc02050a2:	e486                	sd	ra,72(sp)
ffffffffc02050a4:	e0a2                	sd	s0,64(sp)
ffffffffc02050a6:	fc26                	sd	s1,56(sp)
ffffffffc02050a8:	f84a                	sd	s2,48(sp)
ffffffffc02050aa:	f44e                	sd	s3,40(sp)
ffffffffc02050ac:	04700793          	li	a5,71
ffffffffc02050b0:	0aa7e063          	bltu	a5,a0,ffffffffc0205150 <file_getdirentry+0xb0>
ffffffffc02050b4:	00092797          	auipc	a5,0x92
ffffffffc02050b8:	80c7b783          	ld	a5,-2036(a5) # ffffffffc02968c0 <current>
ffffffffc02050bc:	1487b783          	ld	a5,328(a5)
ffffffffc02050c0:	c3e9                	beqz	a5,ffffffffc0205182 <file_getdirentry+0xe2>
ffffffffc02050c2:	4b98                	lw	a4,16(a5)
ffffffffc02050c4:	0ae05f63          	blez	a4,ffffffffc0205182 <file_getdirentry+0xe2>
ffffffffc02050c8:	6780                	ld	s0,8(a5)
ffffffffc02050ca:	00351793          	slli	a5,a0,0x3
ffffffffc02050ce:	8f89                	sub	a5,a5,a0
ffffffffc02050d0:	078e                	slli	a5,a5,0x3
ffffffffc02050d2:	943e                	add	s0,s0,a5
ffffffffc02050d4:	4018                	lw	a4,0(s0)
ffffffffc02050d6:	4789                	li	a5,2
ffffffffc02050d8:	06f71c63          	bne	a4,a5,ffffffffc0205150 <file_getdirentry+0xb0>
ffffffffc02050dc:	4c1c                	lw	a5,24(s0)
ffffffffc02050de:	06a79963          	bne	a5,a0,ffffffffc0205150 <file_getdirentry+0xb0>
ffffffffc02050e2:	581c                	lw	a5,48(s0)
ffffffffc02050e4:	6194                	ld	a3,0(a1)
ffffffffc02050e6:	84ae                	mv	s1,a1
ffffffffc02050e8:	2785                	addiw	a5,a5,1
ffffffffc02050ea:	10000613          	li	a2,256
ffffffffc02050ee:	d81c                	sw	a5,48(s0)
ffffffffc02050f0:	05a1                	addi	a1,a1,8
ffffffffc02050f2:	850a                	mv	a0,sp
ffffffffc02050f4:	33e000ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc02050f8:	02843983          	ld	s3,40(s0)
ffffffffc02050fc:	892a                	mv	s2,a0
ffffffffc02050fe:	06098263          	beqz	s3,ffffffffc0205162 <file_getdirentry+0xc2>
ffffffffc0205102:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc0205106:	cfb1                	beqz	a5,ffffffffc0205162 <file_getdirentry+0xc2>
ffffffffc0205108:	63bc                	ld	a5,64(a5)
ffffffffc020510a:	cfa1                	beqz	a5,ffffffffc0205162 <file_getdirentry+0xc2>
ffffffffc020510c:	854e                	mv	a0,s3
ffffffffc020510e:	00008597          	auipc	a1,0x8
ffffffffc0205112:	2a258593          	addi	a1,a1,674 # ffffffffc020d3b0 <default_pmm_manager+0xf00>
ffffffffc0205116:	77c020ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020511a:	0709b783          	ld	a5,112(s3)
ffffffffc020511e:	7408                	ld	a0,40(s0)
ffffffffc0205120:	85ca                	mv	a1,s2
ffffffffc0205122:	63bc                	ld	a5,64(a5)
ffffffffc0205124:	9782                	jalr	a5
ffffffffc0205126:	89aa                	mv	s3,a0
ffffffffc0205128:	e909                	bnez	a0,ffffffffc020513a <file_getdirentry+0x9a>
ffffffffc020512a:	609c                	ld	a5,0(s1)
ffffffffc020512c:	01093683          	ld	a3,16(s2)
ffffffffc0205130:	01893703          	ld	a4,24(s2)
ffffffffc0205134:	97b6                	add	a5,a5,a3
ffffffffc0205136:	8f99                	sub	a5,a5,a4
ffffffffc0205138:	e09c                	sd	a5,0(s1)
ffffffffc020513a:	8522                	mv	a0,s0
ffffffffc020513c:	fb8ff0ef          	jal	ra,ffffffffc02048f4 <fd_array_release>
ffffffffc0205140:	60a6                	ld	ra,72(sp)
ffffffffc0205142:	6406                	ld	s0,64(sp)
ffffffffc0205144:	74e2                	ld	s1,56(sp)
ffffffffc0205146:	7942                	ld	s2,48(sp)
ffffffffc0205148:	854e                	mv	a0,s3
ffffffffc020514a:	79a2                	ld	s3,40(sp)
ffffffffc020514c:	6161                	addi	sp,sp,80
ffffffffc020514e:	8082                	ret
ffffffffc0205150:	60a6                	ld	ra,72(sp)
ffffffffc0205152:	6406                	ld	s0,64(sp)
ffffffffc0205154:	59f5                	li	s3,-3
ffffffffc0205156:	74e2                	ld	s1,56(sp)
ffffffffc0205158:	7942                	ld	s2,48(sp)
ffffffffc020515a:	854e                	mv	a0,s3
ffffffffc020515c:	79a2                	ld	s3,40(sp)
ffffffffc020515e:	6161                	addi	sp,sp,80
ffffffffc0205160:	8082                	ret
ffffffffc0205162:	00008697          	auipc	a3,0x8
ffffffffc0205166:	1f668693          	addi	a3,a3,502 # ffffffffc020d358 <default_pmm_manager+0xea8>
ffffffffc020516a:	00007617          	auipc	a2,0x7
ffffffffc020516e:	83e60613          	addi	a2,a2,-1986 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0205172:	14a00593          	li	a1,330
ffffffffc0205176:	00008517          	auipc	a0,0x8
ffffffffc020517a:	ef250513          	addi	a0,a0,-270 # ffffffffc020d068 <default_pmm_manager+0xbb8>
ffffffffc020517e:	b20fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205182:	e40ff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>

ffffffffc0205186 <file_dup>:
ffffffffc0205186:	04700713          	li	a4,71
ffffffffc020518a:	06a76463          	bltu	a4,a0,ffffffffc02051f2 <file_dup+0x6c>
ffffffffc020518e:	00091717          	auipc	a4,0x91
ffffffffc0205192:	73273703          	ld	a4,1842(a4) # ffffffffc02968c0 <current>
ffffffffc0205196:	14873703          	ld	a4,328(a4)
ffffffffc020519a:	1101                	addi	sp,sp,-32
ffffffffc020519c:	ec06                	sd	ra,24(sp)
ffffffffc020519e:	e822                	sd	s0,16(sp)
ffffffffc02051a0:	cb39                	beqz	a4,ffffffffc02051f6 <file_dup+0x70>
ffffffffc02051a2:	4b14                	lw	a3,16(a4)
ffffffffc02051a4:	04d05963          	blez	a3,ffffffffc02051f6 <file_dup+0x70>
ffffffffc02051a8:	6700                	ld	s0,8(a4)
ffffffffc02051aa:	00351713          	slli	a4,a0,0x3
ffffffffc02051ae:	8f09                	sub	a4,a4,a0
ffffffffc02051b0:	070e                	slli	a4,a4,0x3
ffffffffc02051b2:	943a                	add	s0,s0,a4
ffffffffc02051b4:	4014                	lw	a3,0(s0)
ffffffffc02051b6:	4709                	li	a4,2
ffffffffc02051b8:	02e69863          	bne	a3,a4,ffffffffc02051e8 <file_dup+0x62>
ffffffffc02051bc:	4c18                	lw	a4,24(s0)
ffffffffc02051be:	02a71563          	bne	a4,a0,ffffffffc02051e8 <file_dup+0x62>
ffffffffc02051c2:	852e                	mv	a0,a1
ffffffffc02051c4:	002c                	addi	a1,sp,8
ffffffffc02051c6:	e1eff0ef          	jal	ra,ffffffffc02047e4 <fd_array_alloc>
ffffffffc02051ca:	c509                	beqz	a0,ffffffffc02051d4 <file_dup+0x4e>
ffffffffc02051cc:	60e2                	ld	ra,24(sp)
ffffffffc02051ce:	6442                	ld	s0,16(sp)
ffffffffc02051d0:	6105                	addi	sp,sp,32
ffffffffc02051d2:	8082                	ret
ffffffffc02051d4:	6522                	ld	a0,8(sp)
ffffffffc02051d6:	85a2                	mv	a1,s0
ffffffffc02051d8:	845ff0ef          	jal	ra,ffffffffc0204a1c <fd_array_dup>
ffffffffc02051dc:	67a2                	ld	a5,8(sp)
ffffffffc02051de:	60e2                	ld	ra,24(sp)
ffffffffc02051e0:	6442                	ld	s0,16(sp)
ffffffffc02051e2:	4f88                	lw	a0,24(a5)
ffffffffc02051e4:	6105                	addi	sp,sp,32
ffffffffc02051e6:	8082                	ret
ffffffffc02051e8:	60e2                	ld	ra,24(sp)
ffffffffc02051ea:	6442                	ld	s0,16(sp)
ffffffffc02051ec:	5575                	li	a0,-3
ffffffffc02051ee:	6105                	addi	sp,sp,32
ffffffffc02051f0:	8082                	ret
ffffffffc02051f2:	5575                	li	a0,-3
ffffffffc02051f4:	8082                	ret
ffffffffc02051f6:	dccff0ef          	jal	ra,ffffffffc02047c2 <get_fd_array.part.0>

ffffffffc02051fa <fs_init>:
ffffffffc02051fa:	1141                	addi	sp,sp,-16
ffffffffc02051fc:	e406                	sd	ra,8(sp)
ffffffffc02051fe:	0b3020ef          	jal	ra,ffffffffc0207ab0 <vfs_init>
ffffffffc0205202:	58a030ef          	jal	ra,ffffffffc020878c <dev_init>
ffffffffc0205206:	60a2                	ld	ra,8(sp)
ffffffffc0205208:	0141                	addi	sp,sp,16
ffffffffc020520a:	6db0306f          	j	ffffffffc02090e4 <sfs_init>

ffffffffc020520e <fs_cleanup>:
ffffffffc020520e:	2f50206f          	j	ffffffffc0207d02 <vfs_cleanup>

ffffffffc0205212 <lock_files>:
ffffffffc0205212:	0561                	addi	a0,a0,24
ffffffffc0205214:	ba0ff06f          	j	ffffffffc02045b4 <down>

ffffffffc0205218 <unlock_files>:
ffffffffc0205218:	0561                	addi	a0,a0,24
ffffffffc020521a:	b96ff06f          	j	ffffffffc02045b0 <up>

ffffffffc020521e <files_create>:
ffffffffc020521e:	1141                	addi	sp,sp,-16
ffffffffc0205220:	6505                	lui	a0,0x1
ffffffffc0205222:	e022                	sd	s0,0(sp)
ffffffffc0205224:	e406                	sd	ra,8(sp)
ffffffffc0205226:	db9fc0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020522a:	842a                	mv	s0,a0
ffffffffc020522c:	cd19                	beqz	a0,ffffffffc020524a <files_create+0x2c>
ffffffffc020522e:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0205232:	00043023          	sd	zero,0(s0)
ffffffffc0205236:	0561                	addi	a0,a0,24
ffffffffc0205238:	e41c                	sd	a5,8(s0)
ffffffffc020523a:	00042823          	sw	zero,16(s0)
ffffffffc020523e:	4585                	li	a1,1
ffffffffc0205240:	b6aff0ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0205244:	6408                	ld	a0,8(s0)
ffffffffc0205246:	f3cff0ef          	jal	ra,ffffffffc0204982 <fd_array_init>
ffffffffc020524a:	60a2                	ld	ra,8(sp)
ffffffffc020524c:	8522                	mv	a0,s0
ffffffffc020524e:	6402                	ld	s0,0(sp)
ffffffffc0205250:	0141                	addi	sp,sp,16
ffffffffc0205252:	8082                	ret

ffffffffc0205254 <files_destroy>:
ffffffffc0205254:	7179                	addi	sp,sp,-48
ffffffffc0205256:	f406                	sd	ra,40(sp)
ffffffffc0205258:	f022                	sd	s0,32(sp)
ffffffffc020525a:	ec26                	sd	s1,24(sp)
ffffffffc020525c:	e84a                	sd	s2,16(sp)
ffffffffc020525e:	e44e                	sd	s3,8(sp)
ffffffffc0205260:	c52d                	beqz	a0,ffffffffc02052ca <files_destroy+0x76>
ffffffffc0205262:	491c                	lw	a5,16(a0)
ffffffffc0205264:	89aa                	mv	s3,a0
ffffffffc0205266:	e3b5                	bnez	a5,ffffffffc02052ca <files_destroy+0x76>
ffffffffc0205268:	6108                	ld	a0,0(a0)
ffffffffc020526a:	c119                	beqz	a0,ffffffffc0205270 <files_destroy+0x1c>
ffffffffc020526c:	6dc020ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc0205270:	0089b403          	ld	s0,8(s3)
ffffffffc0205274:	6485                	lui	s1,0x1
ffffffffc0205276:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020527a:	94a2                	add	s1,s1,s0
ffffffffc020527c:	4909                	li	s2,2
ffffffffc020527e:	401c                	lw	a5,0(s0)
ffffffffc0205280:	03278063          	beq	a5,s2,ffffffffc02052a0 <files_destroy+0x4c>
ffffffffc0205284:	e39d                	bnez	a5,ffffffffc02052aa <files_destroy+0x56>
ffffffffc0205286:	03840413          	addi	s0,s0,56
ffffffffc020528a:	fe849ae3          	bne	s1,s0,ffffffffc020527e <files_destroy+0x2a>
ffffffffc020528e:	7402                	ld	s0,32(sp)
ffffffffc0205290:	70a2                	ld	ra,40(sp)
ffffffffc0205292:	64e2                	ld	s1,24(sp)
ffffffffc0205294:	6942                	ld	s2,16(sp)
ffffffffc0205296:	854e                	mv	a0,s3
ffffffffc0205298:	69a2                	ld	s3,8(sp)
ffffffffc020529a:	6145                	addi	sp,sp,48
ffffffffc020529c:	df3fc06f          	j	ffffffffc020208e <kfree>
ffffffffc02052a0:	8522                	mv	a0,s0
ffffffffc02052a2:	efcff0ef          	jal	ra,ffffffffc020499e <fd_array_close>
ffffffffc02052a6:	401c                	lw	a5,0(s0)
ffffffffc02052a8:	bff1                	j	ffffffffc0205284 <files_destroy+0x30>
ffffffffc02052aa:	00008697          	auipc	a3,0x8
ffffffffc02052ae:	18668693          	addi	a3,a3,390 # ffffffffc020d430 <CSWTCH.79+0x58>
ffffffffc02052b2:	00006617          	auipc	a2,0x6
ffffffffc02052b6:	6f660613          	addi	a2,a2,1782 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02052ba:	03d00593          	li	a1,61
ffffffffc02052be:	00008517          	auipc	a0,0x8
ffffffffc02052c2:	16250513          	addi	a0,a0,354 # ffffffffc020d420 <CSWTCH.79+0x48>
ffffffffc02052c6:	9d8fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02052ca:	00008697          	auipc	a3,0x8
ffffffffc02052ce:	12668693          	addi	a3,a3,294 # ffffffffc020d3f0 <CSWTCH.79+0x18>
ffffffffc02052d2:	00006617          	auipc	a2,0x6
ffffffffc02052d6:	6d660613          	addi	a2,a2,1750 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02052da:	03300593          	li	a1,51
ffffffffc02052de:	00008517          	auipc	a0,0x8
ffffffffc02052e2:	14250513          	addi	a0,a0,322 # ffffffffc020d420 <CSWTCH.79+0x48>
ffffffffc02052e6:	9b8fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02052ea <files_closeall>:
ffffffffc02052ea:	1101                	addi	sp,sp,-32
ffffffffc02052ec:	ec06                	sd	ra,24(sp)
ffffffffc02052ee:	e822                	sd	s0,16(sp)
ffffffffc02052f0:	e426                	sd	s1,8(sp)
ffffffffc02052f2:	e04a                	sd	s2,0(sp)
ffffffffc02052f4:	c129                	beqz	a0,ffffffffc0205336 <files_closeall+0x4c>
ffffffffc02052f6:	491c                	lw	a5,16(a0)
ffffffffc02052f8:	02f05f63          	blez	a5,ffffffffc0205336 <files_closeall+0x4c>
ffffffffc02052fc:	6504                	ld	s1,8(a0)
ffffffffc02052fe:	6785                	lui	a5,0x1
ffffffffc0205300:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205304:	07048413          	addi	s0,s1,112
ffffffffc0205308:	4909                	li	s2,2
ffffffffc020530a:	94be                	add	s1,s1,a5
ffffffffc020530c:	a029                	j	ffffffffc0205316 <files_closeall+0x2c>
ffffffffc020530e:	03840413          	addi	s0,s0,56
ffffffffc0205312:	00848c63          	beq	s1,s0,ffffffffc020532a <files_closeall+0x40>
ffffffffc0205316:	401c                	lw	a5,0(s0)
ffffffffc0205318:	ff279be3          	bne	a5,s2,ffffffffc020530e <files_closeall+0x24>
ffffffffc020531c:	8522                	mv	a0,s0
ffffffffc020531e:	03840413          	addi	s0,s0,56
ffffffffc0205322:	e7cff0ef          	jal	ra,ffffffffc020499e <fd_array_close>
ffffffffc0205326:	fe8498e3          	bne	s1,s0,ffffffffc0205316 <files_closeall+0x2c>
ffffffffc020532a:	60e2                	ld	ra,24(sp)
ffffffffc020532c:	6442                	ld	s0,16(sp)
ffffffffc020532e:	64a2                	ld	s1,8(sp)
ffffffffc0205330:	6902                	ld	s2,0(sp)
ffffffffc0205332:	6105                	addi	sp,sp,32
ffffffffc0205334:	8082                	ret
ffffffffc0205336:	00008697          	auipc	a3,0x8
ffffffffc020533a:	d0268693          	addi	a3,a3,-766 # ffffffffc020d038 <default_pmm_manager+0xb88>
ffffffffc020533e:	00006617          	auipc	a2,0x6
ffffffffc0205342:	66a60613          	addi	a2,a2,1642 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0205346:	04500593          	li	a1,69
ffffffffc020534a:	00008517          	auipc	a0,0x8
ffffffffc020534e:	0d650513          	addi	a0,a0,214 # ffffffffc020d420 <CSWTCH.79+0x48>
ffffffffc0205352:	94cfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205356 <dup_files>:
ffffffffc0205356:	7179                	addi	sp,sp,-48
ffffffffc0205358:	f406                	sd	ra,40(sp)
ffffffffc020535a:	f022                	sd	s0,32(sp)
ffffffffc020535c:	ec26                	sd	s1,24(sp)
ffffffffc020535e:	e84a                	sd	s2,16(sp)
ffffffffc0205360:	e44e                	sd	s3,8(sp)
ffffffffc0205362:	e052                	sd	s4,0(sp)
ffffffffc0205364:	c52d                	beqz	a0,ffffffffc02053ce <dup_files+0x78>
ffffffffc0205366:	842e                	mv	s0,a1
ffffffffc0205368:	c1bd                	beqz	a1,ffffffffc02053ce <dup_files+0x78>
ffffffffc020536a:	491c                	lw	a5,16(a0)
ffffffffc020536c:	84aa                	mv	s1,a0
ffffffffc020536e:	e3c1                	bnez	a5,ffffffffc02053ee <dup_files+0x98>
ffffffffc0205370:	499c                	lw	a5,16(a1)
ffffffffc0205372:	06f05e63          	blez	a5,ffffffffc02053ee <dup_files+0x98>
ffffffffc0205376:	6188                	ld	a0,0(a1)
ffffffffc0205378:	e088                	sd	a0,0(s1)
ffffffffc020537a:	c119                	beqz	a0,ffffffffc0205380 <dup_files+0x2a>
ffffffffc020537c:	4fe020ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc0205380:	6400                	ld	s0,8(s0)
ffffffffc0205382:	6905                	lui	s2,0x1
ffffffffc0205384:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205388:	6484                	ld	s1,8(s1)
ffffffffc020538a:	9922                	add	s2,s2,s0
ffffffffc020538c:	4989                	li	s3,2
ffffffffc020538e:	4a05                	li	s4,1
ffffffffc0205390:	a039                	j	ffffffffc020539e <dup_files+0x48>
ffffffffc0205392:	03840413          	addi	s0,s0,56
ffffffffc0205396:	03848493          	addi	s1,s1,56
ffffffffc020539a:	02890163          	beq	s2,s0,ffffffffc02053bc <dup_files+0x66>
ffffffffc020539e:	401c                	lw	a5,0(s0)
ffffffffc02053a0:	ff3799e3          	bne	a5,s3,ffffffffc0205392 <dup_files+0x3c>
ffffffffc02053a4:	0144a023          	sw	s4,0(s1)
ffffffffc02053a8:	85a2                	mv	a1,s0
ffffffffc02053aa:	8526                	mv	a0,s1
ffffffffc02053ac:	03840413          	addi	s0,s0,56
ffffffffc02053b0:	e6cff0ef          	jal	ra,ffffffffc0204a1c <fd_array_dup>
ffffffffc02053b4:	03848493          	addi	s1,s1,56
ffffffffc02053b8:	fe8913e3          	bne	s2,s0,ffffffffc020539e <dup_files+0x48>
ffffffffc02053bc:	70a2                	ld	ra,40(sp)
ffffffffc02053be:	7402                	ld	s0,32(sp)
ffffffffc02053c0:	64e2                	ld	s1,24(sp)
ffffffffc02053c2:	6942                	ld	s2,16(sp)
ffffffffc02053c4:	69a2                	ld	s3,8(sp)
ffffffffc02053c6:	6a02                	ld	s4,0(sp)
ffffffffc02053c8:	4501                	li	a0,0
ffffffffc02053ca:	6145                	addi	sp,sp,48
ffffffffc02053cc:	8082                	ret
ffffffffc02053ce:	00008697          	auipc	a3,0x8
ffffffffc02053d2:	9ba68693          	addi	a3,a3,-1606 # ffffffffc020cd88 <default_pmm_manager+0x8d8>
ffffffffc02053d6:	00006617          	auipc	a2,0x6
ffffffffc02053da:	5d260613          	addi	a2,a2,1490 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02053de:	05300593          	li	a1,83
ffffffffc02053e2:	00008517          	auipc	a0,0x8
ffffffffc02053e6:	03e50513          	addi	a0,a0,62 # ffffffffc020d420 <CSWTCH.79+0x48>
ffffffffc02053ea:	8b4fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02053ee:	00008697          	auipc	a3,0x8
ffffffffc02053f2:	05a68693          	addi	a3,a3,90 # ffffffffc020d448 <CSWTCH.79+0x70>
ffffffffc02053f6:	00006617          	auipc	a2,0x6
ffffffffc02053fa:	5b260613          	addi	a2,a2,1458 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02053fe:	05400593          	li	a1,84
ffffffffc0205402:	00008517          	auipc	a0,0x8
ffffffffc0205406:	01e50513          	addi	a0,a0,30 # ffffffffc020d420 <CSWTCH.79+0x48>
ffffffffc020540a:	894fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020540e <iobuf_skip.part.0>:
ffffffffc020540e:	1141                	addi	sp,sp,-16
ffffffffc0205410:	00008697          	auipc	a3,0x8
ffffffffc0205414:	06868693          	addi	a3,a3,104 # ffffffffc020d478 <CSWTCH.79+0xa0>
ffffffffc0205418:	00006617          	auipc	a2,0x6
ffffffffc020541c:	59060613          	addi	a2,a2,1424 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0205420:	04a00593          	li	a1,74
ffffffffc0205424:	00008517          	auipc	a0,0x8
ffffffffc0205428:	06c50513          	addi	a0,a0,108 # ffffffffc020d490 <CSWTCH.79+0xb8>
ffffffffc020542c:	e406                	sd	ra,8(sp)
ffffffffc020542e:	870fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205432 <iobuf_init>:
ffffffffc0205432:	e10c                	sd	a1,0(a0)
ffffffffc0205434:	e514                	sd	a3,8(a0)
ffffffffc0205436:	ed10                	sd	a2,24(a0)
ffffffffc0205438:	e910                	sd	a2,16(a0)
ffffffffc020543a:	8082                	ret

ffffffffc020543c <iobuf_move>:
ffffffffc020543c:	7179                	addi	sp,sp,-48
ffffffffc020543e:	ec26                	sd	s1,24(sp)
ffffffffc0205440:	6d04                	ld	s1,24(a0)
ffffffffc0205442:	f022                	sd	s0,32(sp)
ffffffffc0205444:	e84a                	sd	s2,16(sp)
ffffffffc0205446:	e44e                	sd	s3,8(sp)
ffffffffc0205448:	f406                	sd	ra,40(sp)
ffffffffc020544a:	842a                	mv	s0,a0
ffffffffc020544c:	8932                	mv	s2,a2
ffffffffc020544e:	852e                	mv	a0,a1
ffffffffc0205450:	89ba                	mv	s3,a4
ffffffffc0205452:	00967363          	bgeu	a2,s1,ffffffffc0205458 <iobuf_move+0x1c>
ffffffffc0205456:	84b2                	mv	s1,a2
ffffffffc0205458:	c495                	beqz	s1,ffffffffc0205484 <iobuf_move+0x48>
ffffffffc020545a:	600c                	ld	a1,0(s0)
ffffffffc020545c:	c681                	beqz	a3,ffffffffc0205464 <iobuf_move+0x28>
ffffffffc020545e:	87ae                	mv	a5,a1
ffffffffc0205460:	85aa                	mv	a1,a0
ffffffffc0205462:	853e                	mv	a0,a5
ffffffffc0205464:	8626                	mv	a2,s1
ffffffffc0205466:	070060ef          	jal	ra,ffffffffc020b4d6 <memmove>
ffffffffc020546a:	6c1c                	ld	a5,24(s0)
ffffffffc020546c:	0297ea63          	bltu	a5,s1,ffffffffc02054a0 <iobuf_move+0x64>
ffffffffc0205470:	6014                	ld	a3,0(s0)
ffffffffc0205472:	6418                	ld	a4,8(s0)
ffffffffc0205474:	8f85                	sub	a5,a5,s1
ffffffffc0205476:	96a6                	add	a3,a3,s1
ffffffffc0205478:	9726                	add	a4,a4,s1
ffffffffc020547a:	e014                	sd	a3,0(s0)
ffffffffc020547c:	e418                	sd	a4,8(s0)
ffffffffc020547e:	ec1c                	sd	a5,24(s0)
ffffffffc0205480:	40990933          	sub	s2,s2,s1
ffffffffc0205484:	00098463          	beqz	s3,ffffffffc020548c <iobuf_move+0x50>
ffffffffc0205488:	0099b023          	sd	s1,0(s3)
ffffffffc020548c:	4501                	li	a0,0
ffffffffc020548e:	00091b63          	bnez	s2,ffffffffc02054a4 <iobuf_move+0x68>
ffffffffc0205492:	70a2                	ld	ra,40(sp)
ffffffffc0205494:	7402                	ld	s0,32(sp)
ffffffffc0205496:	64e2                	ld	s1,24(sp)
ffffffffc0205498:	6942                	ld	s2,16(sp)
ffffffffc020549a:	69a2                	ld	s3,8(sp)
ffffffffc020549c:	6145                	addi	sp,sp,48
ffffffffc020549e:	8082                	ret
ffffffffc02054a0:	f6fff0ef          	jal	ra,ffffffffc020540e <iobuf_skip.part.0>
ffffffffc02054a4:	5571                	li	a0,-4
ffffffffc02054a6:	b7f5                	j	ffffffffc0205492 <iobuf_move+0x56>

ffffffffc02054a8 <iobuf_skip>:
ffffffffc02054a8:	6d1c                	ld	a5,24(a0)
ffffffffc02054aa:	00b7eb63          	bltu	a5,a1,ffffffffc02054c0 <iobuf_skip+0x18>
ffffffffc02054ae:	6114                	ld	a3,0(a0)
ffffffffc02054b0:	6518                	ld	a4,8(a0)
ffffffffc02054b2:	8f8d                	sub	a5,a5,a1
ffffffffc02054b4:	96ae                	add	a3,a3,a1
ffffffffc02054b6:	95ba                	add	a1,a1,a4
ffffffffc02054b8:	e114                	sd	a3,0(a0)
ffffffffc02054ba:	e50c                	sd	a1,8(a0)
ffffffffc02054bc:	ed1c                	sd	a5,24(a0)
ffffffffc02054be:	8082                	ret
ffffffffc02054c0:	1141                	addi	sp,sp,-16
ffffffffc02054c2:	e406                	sd	ra,8(sp)
ffffffffc02054c4:	f4bff0ef          	jal	ra,ffffffffc020540e <iobuf_skip.part.0>

ffffffffc02054c8 <copy_path>:
ffffffffc02054c8:	7139                	addi	sp,sp,-64
ffffffffc02054ca:	f04a                	sd	s2,32(sp)
ffffffffc02054cc:	00091917          	auipc	s2,0x91
ffffffffc02054d0:	3f490913          	addi	s2,s2,1012 # ffffffffc02968c0 <current>
ffffffffc02054d4:	00093703          	ld	a4,0(s2)
ffffffffc02054d8:	ec4e                	sd	s3,24(sp)
ffffffffc02054da:	89aa                	mv	s3,a0
ffffffffc02054dc:	6505                	lui	a0,0x1
ffffffffc02054de:	f426                	sd	s1,40(sp)
ffffffffc02054e0:	e852                	sd	s4,16(sp)
ffffffffc02054e2:	fc06                	sd	ra,56(sp)
ffffffffc02054e4:	f822                	sd	s0,48(sp)
ffffffffc02054e6:	e456                	sd	s5,8(sp)
ffffffffc02054e8:	02873a03          	ld	s4,40(a4)
ffffffffc02054ec:	84ae                	mv	s1,a1
ffffffffc02054ee:	af1fc0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc02054f2:	c141                	beqz	a0,ffffffffc0205572 <copy_path+0xaa>
ffffffffc02054f4:	842a                	mv	s0,a0
ffffffffc02054f6:	040a0563          	beqz	s4,ffffffffc0205540 <copy_path+0x78>
ffffffffc02054fa:	038a0a93          	addi	s5,s4,56
ffffffffc02054fe:	8556                	mv	a0,s5
ffffffffc0205500:	8b4ff0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0205504:	00093783          	ld	a5,0(s2)
ffffffffc0205508:	cba1                	beqz	a5,ffffffffc0205558 <copy_path+0x90>
ffffffffc020550a:	43dc                	lw	a5,4(a5)
ffffffffc020550c:	6685                	lui	a3,0x1
ffffffffc020550e:	8626                	mv	a2,s1
ffffffffc0205510:	04fa2823          	sw	a5,80(s4)
ffffffffc0205514:	85a2                	mv	a1,s0
ffffffffc0205516:	8552                	mv	a0,s4
ffffffffc0205518:	ec5fe0ef          	jal	ra,ffffffffc02043dc <copy_string>
ffffffffc020551c:	c529                	beqz	a0,ffffffffc0205566 <copy_path+0x9e>
ffffffffc020551e:	8556                	mv	a0,s5
ffffffffc0205520:	890ff0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0205524:	040a2823          	sw	zero,80(s4)
ffffffffc0205528:	0089b023          	sd	s0,0(s3)
ffffffffc020552c:	4501                	li	a0,0
ffffffffc020552e:	70e2                	ld	ra,56(sp)
ffffffffc0205530:	7442                	ld	s0,48(sp)
ffffffffc0205532:	74a2                	ld	s1,40(sp)
ffffffffc0205534:	7902                	ld	s2,32(sp)
ffffffffc0205536:	69e2                	ld	s3,24(sp)
ffffffffc0205538:	6a42                	ld	s4,16(sp)
ffffffffc020553a:	6aa2                	ld	s5,8(sp)
ffffffffc020553c:	6121                	addi	sp,sp,64
ffffffffc020553e:	8082                	ret
ffffffffc0205540:	85aa                	mv	a1,a0
ffffffffc0205542:	6685                	lui	a3,0x1
ffffffffc0205544:	8626                	mv	a2,s1
ffffffffc0205546:	4501                	li	a0,0
ffffffffc0205548:	e95fe0ef          	jal	ra,ffffffffc02043dc <copy_string>
ffffffffc020554c:	fd71                	bnez	a0,ffffffffc0205528 <copy_path+0x60>
ffffffffc020554e:	8522                	mv	a0,s0
ffffffffc0205550:	b3ffc0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0205554:	5575                	li	a0,-3
ffffffffc0205556:	bfe1                	j	ffffffffc020552e <copy_path+0x66>
ffffffffc0205558:	6685                	lui	a3,0x1
ffffffffc020555a:	8626                	mv	a2,s1
ffffffffc020555c:	85a2                	mv	a1,s0
ffffffffc020555e:	8552                	mv	a0,s4
ffffffffc0205560:	e7dfe0ef          	jal	ra,ffffffffc02043dc <copy_string>
ffffffffc0205564:	fd4d                	bnez	a0,ffffffffc020551e <copy_path+0x56>
ffffffffc0205566:	8556                	mv	a0,s5
ffffffffc0205568:	848ff0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020556c:	040a2823          	sw	zero,80(s4)
ffffffffc0205570:	bff9                	j	ffffffffc020554e <copy_path+0x86>
ffffffffc0205572:	5571                	li	a0,-4
ffffffffc0205574:	bf6d                	j	ffffffffc020552e <copy_path+0x66>

ffffffffc0205576 <sysfile_open>:
ffffffffc0205576:	7179                	addi	sp,sp,-48
ffffffffc0205578:	872a                	mv	a4,a0
ffffffffc020557a:	ec26                	sd	s1,24(sp)
ffffffffc020557c:	0028                	addi	a0,sp,8
ffffffffc020557e:	84ae                	mv	s1,a1
ffffffffc0205580:	85ba                	mv	a1,a4
ffffffffc0205582:	f022                	sd	s0,32(sp)
ffffffffc0205584:	f406                	sd	ra,40(sp)
ffffffffc0205586:	f43ff0ef          	jal	ra,ffffffffc02054c8 <copy_path>
ffffffffc020558a:	842a                	mv	s0,a0
ffffffffc020558c:	e909                	bnez	a0,ffffffffc020559e <sysfile_open+0x28>
ffffffffc020558e:	6522                	ld	a0,8(sp)
ffffffffc0205590:	85a6                	mv	a1,s1
ffffffffc0205592:	d60ff0ef          	jal	ra,ffffffffc0204af2 <file_open>
ffffffffc0205596:	842a                	mv	s0,a0
ffffffffc0205598:	6522                	ld	a0,8(sp)
ffffffffc020559a:	af5fc0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020559e:	70a2                	ld	ra,40(sp)
ffffffffc02055a0:	8522                	mv	a0,s0
ffffffffc02055a2:	7402                	ld	s0,32(sp)
ffffffffc02055a4:	64e2                	ld	s1,24(sp)
ffffffffc02055a6:	6145                	addi	sp,sp,48
ffffffffc02055a8:	8082                	ret

ffffffffc02055aa <sysfile_close>:
ffffffffc02055aa:	e46ff06f          	j	ffffffffc0204bf0 <file_close>

ffffffffc02055ae <sysfile_read>:
ffffffffc02055ae:	7159                	addi	sp,sp,-112
ffffffffc02055b0:	f0a2                	sd	s0,96(sp)
ffffffffc02055b2:	f486                	sd	ra,104(sp)
ffffffffc02055b4:	eca6                	sd	s1,88(sp)
ffffffffc02055b6:	e8ca                	sd	s2,80(sp)
ffffffffc02055b8:	e4ce                	sd	s3,72(sp)
ffffffffc02055ba:	e0d2                	sd	s4,64(sp)
ffffffffc02055bc:	fc56                	sd	s5,56(sp)
ffffffffc02055be:	f85a                	sd	s6,48(sp)
ffffffffc02055c0:	f45e                	sd	s7,40(sp)
ffffffffc02055c2:	f062                	sd	s8,32(sp)
ffffffffc02055c4:	ec66                	sd	s9,24(sp)
ffffffffc02055c6:	4401                	li	s0,0
ffffffffc02055c8:	ee19                	bnez	a2,ffffffffc02055e6 <sysfile_read+0x38>
ffffffffc02055ca:	70a6                	ld	ra,104(sp)
ffffffffc02055cc:	8522                	mv	a0,s0
ffffffffc02055ce:	7406                	ld	s0,96(sp)
ffffffffc02055d0:	64e6                	ld	s1,88(sp)
ffffffffc02055d2:	6946                	ld	s2,80(sp)
ffffffffc02055d4:	69a6                	ld	s3,72(sp)
ffffffffc02055d6:	6a06                	ld	s4,64(sp)
ffffffffc02055d8:	7ae2                	ld	s5,56(sp)
ffffffffc02055da:	7b42                	ld	s6,48(sp)
ffffffffc02055dc:	7ba2                	ld	s7,40(sp)
ffffffffc02055de:	7c02                	ld	s8,32(sp)
ffffffffc02055e0:	6ce2                	ld	s9,24(sp)
ffffffffc02055e2:	6165                	addi	sp,sp,112
ffffffffc02055e4:	8082                	ret
ffffffffc02055e6:	00091c97          	auipc	s9,0x91
ffffffffc02055ea:	2dac8c93          	addi	s9,s9,730 # ffffffffc02968c0 <current>
ffffffffc02055ee:	000cb783          	ld	a5,0(s9)
ffffffffc02055f2:	84b2                	mv	s1,a2
ffffffffc02055f4:	8b2e                	mv	s6,a1
ffffffffc02055f6:	4601                	li	a2,0
ffffffffc02055f8:	4585                	li	a1,1
ffffffffc02055fa:	0287b903          	ld	s2,40(a5)
ffffffffc02055fe:	8aaa                	mv	s5,a0
ffffffffc0205600:	c9eff0ef          	jal	ra,ffffffffc0204a9e <file_testfd>
ffffffffc0205604:	c959                	beqz	a0,ffffffffc020569a <sysfile_read+0xec>
ffffffffc0205606:	6505                	lui	a0,0x1
ffffffffc0205608:	9d7fc0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020560c:	89aa                	mv	s3,a0
ffffffffc020560e:	c941                	beqz	a0,ffffffffc020569e <sysfile_read+0xf0>
ffffffffc0205610:	4b81                	li	s7,0
ffffffffc0205612:	6a05                	lui	s4,0x1
ffffffffc0205614:	03890c13          	addi	s8,s2,56
ffffffffc0205618:	0744ec63          	bltu	s1,s4,ffffffffc0205690 <sysfile_read+0xe2>
ffffffffc020561c:	e452                	sd	s4,8(sp)
ffffffffc020561e:	6605                	lui	a2,0x1
ffffffffc0205620:	0034                	addi	a3,sp,8
ffffffffc0205622:	85ce                	mv	a1,s3
ffffffffc0205624:	8556                	mv	a0,s5
ffffffffc0205626:	e20ff0ef          	jal	ra,ffffffffc0204c46 <file_read>
ffffffffc020562a:	66a2                	ld	a3,8(sp)
ffffffffc020562c:	842a                	mv	s0,a0
ffffffffc020562e:	ca9d                	beqz	a3,ffffffffc0205664 <sysfile_read+0xb6>
ffffffffc0205630:	00090c63          	beqz	s2,ffffffffc0205648 <sysfile_read+0x9a>
ffffffffc0205634:	8562                	mv	a0,s8
ffffffffc0205636:	f7ffe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020563a:	000cb783          	ld	a5,0(s9)
ffffffffc020563e:	cfa1                	beqz	a5,ffffffffc0205696 <sysfile_read+0xe8>
ffffffffc0205640:	43dc                	lw	a5,4(a5)
ffffffffc0205642:	66a2                	ld	a3,8(sp)
ffffffffc0205644:	04f92823          	sw	a5,80(s2)
ffffffffc0205648:	864e                	mv	a2,s3
ffffffffc020564a:	85da                	mv	a1,s6
ffffffffc020564c:	854a                	mv	a0,s2
ffffffffc020564e:	d5dfe0ef          	jal	ra,ffffffffc02043aa <copy_to_user>
ffffffffc0205652:	c50d                	beqz	a0,ffffffffc020567c <sysfile_read+0xce>
ffffffffc0205654:	67a2                	ld	a5,8(sp)
ffffffffc0205656:	04f4e663          	bltu	s1,a5,ffffffffc02056a2 <sysfile_read+0xf4>
ffffffffc020565a:	9b3e                	add	s6,s6,a5
ffffffffc020565c:	8c9d                	sub	s1,s1,a5
ffffffffc020565e:	9bbe                	add	s7,s7,a5
ffffffffc0205660:	02091263          	bnez	s2,ffffffffc0205684 <sysfile_read+0xd6>
ffffffffc0205664:	e401                	bnez	s0,ffffffffc020566c <sysfile_read+0xbe>
ffffffffc0205666:	67a2                	ld	a5,8(sp)
ffffffffc0205668:	c391                	beqz	a5,ffffffffc020566c <sysfile_read+0xbe>
ffffffffc020566a:	f4dd                	bnez	s1,ffffffffc0205618 <sysfile_read+0x6a>
ffffffffc020566c:	854e                	mv	a0,s3
ffffffffc020566e:	a21fc0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0205672:	f40b8ce3          	beqz	s7,ffffffffc02055ca <sysfile_read+0x1c>
ffffffffc0205676:	000b841b          	sext.w	s0,s7
ffffffffc020567a:	bf81                	j	ffffffffc02055ca <sysfile_read+0x1c>
ffffffffc020567c:	e011                	bnez	s0,ffffffffc0205680 <sysfile_read+0xd2>
ffffffffc020567e:	5475                	li	s0,-3
ffffffffc0205680:	fe0906e3          	beqz	s2,ffffffffc020566c <sysfile_read+0xbe>
ffffffffc0205684:	8562                	mv	a0,s8
ffffffffc0205686:	f2bfe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020568a:	04092823          	sw	zero,80(s2)
ffffffffc020568e:	bfd9                	j	ffffffffc0205664 <sysfile_read+0xb6>
ffffffffc0205690:	e426                	sd	s1,8(sp)
ffffffffc0205692:	8626                	mv	a2,s1
ffffffffc0205694:	b771                	j	ffffffffc0205620 <sysfile_read+0x72>
ffffffffc0205696:	66a2                	ld	a3,8(sp)
ffffffffc0205698:	bf45                	j	ffffffffc0205648 <sysfile_read+0x9a>
ffffffffc020569a:	5475                	li	s0,-3
ffffffffc020569c:	b73d                	j	ffffffffc02055ca <sysfile_read+0x1c>
ffffffffc020569e:	5471                	li	s0,-4
ffffffffc02056a0:	b72d                	j	ffffffffc02055ca <sysfile_read+0x1c>
ffffffffc02056a2:	00008697          	auipc	a3,0x8
ffffffffc02056a6:	dfe68693          	addi	a3,a3,-514 # ffffffffc020d4a0 <CSWTCH.79+0xc8>
ffffffffc02056aa:	00006617          	auipc	a2,0x6
ffffffffc02056ae:	2fe60613          	addi	a2,a2,766 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02056b2:	05500593          	li	a1,85
ffffffffc02056b6:	00008517          	auipc	a0,0x8
ffffffffc02056ba:	dfa50513          	addi	a0,a0,-518 # ffffffffc020d4b0 <CSWTCH.79+0xd8>
ffffffffc02056be:	de1fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02056c2 <sysfile_write>:
ffffffffc02056c2:	7159                	addi	sp,sp,-112
ffffffffc02056c4:	e8ca                	sd	s2,80(sp)
ffffffffc02056c6:	f486                	sd	ra,104(sp)
ffffffffc02056c8:	f0a2                	sd	s0,96(sp)
ffffffffc02056ca:	eca6                	sd	s1,88(sp)
ffffffffc02056cc:	e4ce                	sd	s3,72(sp)
ffffffffc02056ce:	e0d2                	sd	s4,64(sp)
ffffffffc02056d0:	fc56                	sd	s5,56(sp)
ffffffffc02056d2:	f85a                	sd	s6,48(sp)
ffffffffc02056d4:	f45e                	sd	s7,40(sp)
ffffffffc02056d6:	f062                	sd	s8,32(sp)
ffffffffc02056d8:	ec66                	sd	s9,24(sp)
ffffffffc02056da:	4901                	li	s2,0
ffffffffc02056dc:	ee19                	bnez	a2,ffffffffc02056fa <sysfile_write+0x38>
ffffffffc02056de:	70a6                	ld	ra,104(sp)
ffffffffc02056e0:	7406                	ld	s0,96(sp)
ffffffffc02056e2:	64e6                	ld	s1,88(sp)
ffffffffc02056e4:	69a6                	ld	s3,72(sp)
ffffffffc02056e6:	6a06                	ld	s4,64(sp)
ffffffffc02056e8:	7ae2                	ld	s5,56(sp)
ffffffffc02056ea:	7b42                	ld	s6,48(sp)
ffffffffc02056ec:	7ba2                	ld	s7,40(sp)
ffffffffc02056ee:	7c02                	ld	s8,32(sp)
ffffffffc02056f0:	6ce2                	ld	s9,24(sp)
ffffffffc02056f2:	854a                	mv	a0,s2
ffffffffc02056f4:	6946                	ld	s2,80(sp)
ffffffffc02056f6:	6165                	addi	sp,sp,112
ffffffffc02056f8:	8082                	ret
ffffffffc02056fa:	00091c17          	auipc	s8,0x91
ffffffffc02056fe:	1c6c0c13          	addi	s8,s8,454 # ffffffffc02968c0 <current>
ffffffffc0205702:	000c3783          	ld	a5,0(s8)
ffffffffc0205706:	8432                	mv	s0,a2
ffffffffc0205708:	89ae                	mv	s3,a1
ffffffffc020570a:	4605                	li	a2,1
ffffffffc020570c:	4581                	li	a1,0
ffffffffc020570e:	7784                	ld	s1,40(a5)
ffffffffc0205710:	8baa                	mv	s7,a0
ffffffffc0205712:	b8cff0ef          	jal	ra,ffffffffc0204a9e <file_testfd>
ffffffffc0205716:	cd59                	beqz	a0,ffffffffc02057b4 <sysfile_write+0xf2>
ffffffffc0205718:	6505                	lui	a0,0x1
ffffffffc020571a:	8c5fc0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020571e:	8a2a                	mv	s4,a0
ffffffffc0205720:	cd41                	beqz	a0,ffffffffc02057b8 <sysfile_write+0xf6>
ffffffffc0205722:	4c81                	li	s9,0
ffffffffc0205724:	6a85                	lui	s5,0x1
ffffffffc0205726:	03848b13          	addi	s6,s1,56
ffffffffc020572a:	05546a63          	bltu	s0,s5,ffffffffc020577e <sysfile_write+0xbc>
ffffffffc020572e:	e456                	sd	s5,8(sp)
ffffffffc0205730:	c8a9                	beqz	s1,ffffffffc0205782 <sysfile_write+0xc0>
ffffffffc0205732:	855a                	mv	a0,s6
ffffffffc0205734:	e81fe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0205738:	000c3783          	ld	a5,0(s8)
ffffffffc020573c:	c399                	beqz	a5,ffffffffc0205742 <sysfile_write+0x80>
ffffffffc020573e:	43dc                	lw	a5,4(a5)
ffffffffc0205740:	c8bc                	sw	a5,80(s1)
ffffffffc0205742:	66a2                	ld	a3,8(sp)
ffffffffc0205744:	4701                	li	a4,0
ffffffffc0205746:	864e                	mv	a2,s3
ffffffffc0205748:	85d2                	mv	a1,s4
ffffffffc020574a:	8526                	mv	a0,s1
ffffffffc020574c:	c2bfe0ef          	jal	ra,ffffffffc0204376 <copy_from_user>
ffffffffc0205750:	c139                	beqz	a0,ffffffffc0205796 <sysfile_write+0xd4>
ffffffffc0205752:	855a                	mv	a0,s6
ffffffffc0205754:	e5dfe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0205758:	0404a823          	sw	zero,80(s1)
ffffffffc020575c:	6622                	ld	a2,8(sp)
ffffffffc020575e:	0034                	addi	a3,sp,8
ffffffffc0205760:	85d2                	mv	a1,s4
ffffffffc0205762:	855e                	mv	a0,s7
ffffffffc0205764:	dc8ff0ef          	jal	ra,ffffffffc0204d2c <file_write>
ffffffffc0205768:	67a2                	ld	a5,8(sp)
ffffffffc020576a:	892a                	mv	s2,a0
ffffffffc020576c:	ef85                	bnez	a5,ffffffffc02057a4 <sysfile_write+0xe2>
ffffffffc020576e:	8552                	mv	a0,s4
ffffffffc0205770:	91ffc0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0205774:	f60c85e3          	beqz	s9,ffffffffc02056de <sysfile_write+0x1c>
ffffffffc0205778:	000c891b          	sext.w	s2,s9
ffffffffc020577c:	b78d                	j	ffffffffc02056de <sysfile_write+0x1c>
ffffffffc020577e:	e422                	sd	s0,8(sp)
ffffffffc0205780:	f8cd                	bnez	s1,ffffffffc0205732 <sysfile_write+0x70>
ffffffffc0205782:	66a2                	ld	a3,8(sp)
ffffffffc0205784:	4701                	li	a4,0
ffffffffc0205786:	864e                	mv	a2,s3
ffffffffc0205788:	85d2                	mv	a1,s4
ffffffffc020578a:	4501                	li	a0,0
ffffffffc020578c:	bebfe0ef          	jal	ra,ffffffffc0204376 <copy_from_user>
ffffffffc0205790:	f571                	bnez	a0,ffffffffc020575c <sysfile_write+0x9a>
ffffffffc0205792:	5975                	li	s2,-3
ffffffffc0205794:	bfe9                	j	ffffffffc020576e <sysfile_write+0xac>
ffffffffc0205796:	855a                	mv	a0,s6
ffffffffc0205798:	e19fe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020579c:	5975                	li	s2,-3
ffffffffc020579e:	0404a823          	sw	zero,80(s1)
ffffffffc02057a2:	b7f1                	j	ffffffffc020576e <sysfile_write+0xac>
ffffffffc02057a4:	00f46c63          	bltu	s0,a5,ffffffffc02057bc <sysfile_write+0xfa>
ffffffffc02057a8:	99be                	add	s3,s3,a5
ffffffffc02057aa:	8c1d                	sub	s0,s0,a5
ffffffffc02057ac:	9cbe                	add	s9,s9,a5
ffffffffc02057ae:	f161                	bnez	a0,ffffffffc020576e <sysfile_write+0xac>
ffffffffc02057b0:	fc2d                	bnez	s0,ffffffffc020572a <sysfile_write+0x68>
ffffffffc02057b2:	bf75                	j	ffffffffc020576e <sysfile_write+0xac>
ffffffffc02057b4:	5975                	li	s2,-3
ffffffffc02057b6:	b725                	j	ffffffffc02056de <sysfile_write+0x1c>
ffffffffc02057b8:	5971                	li	s2,-4
ffffffffc02057ba:	b715                	j	ffffffffc02056de <sysfile_write+0x1c>
ffffffffc02057bc:	00008697          	auipc	a3,0x8
ffffffffc02057c0:	ce468693          	addi	a3,a3,-796 # ffffffffc020d4a0 <CSWTCH.79+0xc8>
ffffffffc02057c4:	00006617          	auipc	a2,0x6
ffffffffc02057c8:	1e460613          	addi	a2,a2,484 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02057cc:	08a00593          	li	a1,138
ffffffffc02057d0:	00008517          	auipc	a0,0x8
ffffffffc02057d4:	ce050513          	addi	a0,a0,-800 # ffffffffc020d4b0 <CSWTCH.79+0xd8>
ffffffffc02057d8:	cc7fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02057dc <sysfile_seek>:
ffffffffc02057dc:	e36ff06f          	j	ffffffffc0204e12 <file_seek>

ffffffffc02057e0 <sysfile_fstat>:
ffffffffc02057e0:	715d                	addi	sp,sp,-80
ffffffffc02057e2:	f44e                	sd	s3,40(sp)
ffffffffc02057e4:	00091997          	auipc	s3,0x91
ffffffffc02057e8:	0dc98993          	addi	s3,s3,220 # ffffffffc02968c0 <current>
ffffffffc02057ec:	0009b703          	ld	a4,0(s3)
ffffffffc02057f0:	fc26                	sd	s1,56(sp)
ffffffffc02057f2:	84ae                	mv	s1,a1
ffffffffc02057f4:	858a                	mv	a1,sp
ffffffffc02057f6:	e0a2                	sd	s0,64(sp)
ffffffffc02057f8:	f84a                	sd	s2,48(sp)
ffffffffc02057fa:	e486                	sd	ra,72(sp)
ffffffffc02057fc:	02873903          	ld	s2,40(a4)
ffffffffc0205800:	f052                	sd	s4,32(sp)
ffffffffc0205802:	f30ff0ef          	jal	ra,ffffffffc0204f32 <file_fstat>
ffffffffc0205806:	842a                	mv	s0,a0
ffffffffc0205808:	e91d                	bnez	a0,ffffffffc020583e <sysfile_fstat+0x5e>
ffffffffc020580a:	04090363          	beqz	s2,ffffffffc0205850 <sysfile_fstat+0x70>
ffffffffc020580e:	03890a13          	addi	s4,s2,56
ffffffffc0205812:	8552                	mv	a0,s4
ffffffffc0205814:	da1fe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0205818:	0009b783          	ld	a5,0(s3)
ffffffffc020581c:	c3b9                	beqz	a5,ffffffffc0205862 <sysfile_fstat+0x82>
ffffffffc020581e:	43dc                	lw	a5,4(a5)
ffffffffc0205820:	02000693          	li	a3,32
ffffffffc0205824:	860a                	mv	a2,sp
ffffffffc0205826:	04f92823          	sw	a5,80(s2)
ffffffffc020582a:	85a6                	mv	a1,s1
ffffffffc020582c:	854a                	mv	a0,s2
ffffffffc020582e:	b7dfe0ef          	jal	ra,ffffffffc02043aa <copy_to_user>
ffffffffc0205832:	c121                	beqz	a0,ffffffffc0205872 <sysfile_fstat+0x92>
ffffffffc0205834:	8552                	mv	a0,s4
ffffffffc0205836:	d7bfe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020583a:	04092823          	sw	zero,80(s2)
ffffffffc020583e:	60a6                	ld	ra,72(sp)
ffffffffc0205840:	8522                	mv	a0,s0
ffffffffc0205842:	6406                	ld	s0,64(sp)
ffffffffc0205844:	74e2                	ld	s1,56(sp)
ffffffffc0205846:	7942                	ld	s2,48(sp)
ffffffffc0205848:	79a2                	ld	s3,40(sp)
ffffffffc020584a:	7a02                	ld	s4,32(sp)
ffffffffc020584c:	6161                	addi	sp,sp,80
ffffffffc020584e:	8082                	ret
ffffffffc0205850:	02000693          	li	a3,32
ffffffffc0205854:	860a                	mv	a2,sp
ffffffffc0205856:	85a6                	mv	a1,s1
ffffffffc0205858:	b53fe0ef          	jal	ra,ffffffffc02043aa <copy_to_user>
ffffffffc020585c:	f16d                	bnez	a0,ffffffffc020583e <sysfile_fstat+0x5e>
ffffffffc020585e:	5475                	li	s0,-3
ffffffffc0205860:	bff9                	j	ffffffffc020583e <sysfile_fstat+0x5e>
ffffffffc0205862:	02000693          	li	a3,32
ffffffffc0205866:	860a                	mv	a2,sp
ffffffffc0205868:	85a6                	mv	a1,s1
ffffffffc020586a:	854a                	mv	a0,s2
ffffffffc020586c:	b3ffe0ef          	jal	ra,ffffffffc02043aa <copy_to_user>
ffffffffc0205870:	f171                	bnez	a0,ffffffffc0205834 <sysfile_fstat+0x54>
ffffffffc0205872:	8552                	mv	a0,s4
ffffffffc0205874:	d3dfe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0205878:	5475                	li	s0,-3
ffffffffc020587a:	04092823          	sw	zero,80(s2)
ffffffffc020587e:	b7c1                	j	ffffffffc020583e <sysfile_fstat+0x5e>

ffffffffc0205880 <sysfile_fsync>:
ffffffffc0205880:	f72ff06f          	j	ffffffffc0204ff2 <file_fsync>

ffffffffc0205884 <sysfile_getcwd>:
ffffffffc0205884:	715d                	addi	sp,sp,-80
ffffffffc0205886:	f44e                	sd	s3,40(sp)
ffffffffc0205888:	00091997          	auipc	s3,0x91
ffffffffc020588c:	03898993          	addi	s3,s3,56 # ffffffffc02968c0 <current>
ffffffffc0205890:	0009b783          	ld	a5,0(s3)
ffffffffc0205894:	f84a                	sd	s2,48(sp)
ffffffffc0205896:	e486                	sd	ra,72(sp)
ffffffffc0205898:	e0a2                	sd	s0,64(sp)
ffffffffc020589a:	fc26                	sd	s1,56(sp)
ffffffffc020589c:	f052                	sd	s4,32(sp)
ffffffffc020589e:	0287b903          	ld	s2,40(a5)
ffffffffc02058a2:	cda9                	beqz	a1,ffffffffc02058fc <sysfile_getcwd+0x78>
ffffffffc02058a4:	842e                	mv	s0,a1
ffffffffc02058a6:	84aa                	mv	s1,a0
ffffffffc02058a8:	04090363          	beqz	s2,ffffffffc02058ee <sysfile_getcwd+0x6a>
ffffffffc02058ac:	03890a13          	addi	s4,s2,56
ffffffffc02058b0:	8552                	mv	a0,s4
ffffffffc02058b2:	d03fe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc02058b6:	0009b783          	ld	a5,0(s3)
ffffffffc02058ba:	c781                	beqz	a5,ffffffffc02058c2 <sysfile_getcwd+0x3e>
ffffffffc02058bc:	43dc                	lw	a5,4(a5)
ffffffffc02058be:	04f92823          	sw	a5,80(s2)
ffffffffc02058c2:	4685                	li	a3,1
ffffffffc02058c4:	8622                	mv	a2,s0
ffffffffc02058c6:	85a6                	mv	a1,s1
ffffffffc02058c8:	854a                	mv	a0,s2
ffffffffc02058ca:	a19fe0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc02058ce:	e90d                	bnez	a0,ffffffffc0205900 <sysfile_getcwd+0x7c>
ffffffffc02058d0:	5475                	li	s0,-3
ffffffffc02058d2:	8552                	mv	a0,s4
ffffffffc02058d4:	cddfe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc02058d8:	04092823          	sw	zero,80(s2)
ffffffffc02058dc:	60a6                	ld	ra,72(sp)
ffffffffc02058de:	8522                	mv	a0,s0
ffffffffc02058e0:	6406                	ld	s0,64(sp)
ffffffffc02058e2:	74e2                	ld	s1,56(sp)
ffffffffc02058e4:	7942                	ld	s2,48(sp)
ffffffffc02058e6:	79a2                	ld	s3,40(sp)
ffffffffc02058e8:	7a02                	ld	s4,32(sp)
ffffffffc02058ea:	6161                	addi	sp,sp,80
ffffffffc02058ec:	8082                	ret
ffffffffc02058ee:	862e                	mv	a2,a1
ffffffffc02058f0:	4685                	li	a3,1
ffffffffc02058f2:	85aa                	mv	a1,a0
ffffffffc02058f4:	4501                	li	a0,0
ffffffffc02058f6:	9edfe0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc02058fa:	ed09                	bnez	a0,ffffffffc0205914 <sysfile_getcwd+0x90>
ffffffffc02058fc:	5475                	li	s0,-3
ffffffffc02058fe:	bff9                	j	ffffffffc02058dc <sysfile_getcwd+0x58>
ffffffffc0205900:	8622                	mv	a2,s0
ffffffffc0205902:	4681                	li	a3,0
ffffffffc0205904:	85a6                	mv	a1,s1
ffffffffc0205906:	850a                	mv	a0,sp
ffffffffc0205908:	b2bff0ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc020590c:	32d020ef          	jal	ra,ffffffffc0208438 <vfs_getcwd>
ffffffffc0205910:	842a                	mv	s0,a0
ffffffffc0205912:	b7c1                	j	ffffffffc02058d2 <sysfile_getcwd+0x4e>
ffffffffc0205914:	8622                	mv	a2,s0
ffffffffc0205916:	4681                	li	a3,0
ffffffffc0205918:	85a6                	mv	a1,s1
ffffffffc020591a:	850a                	mv	a0,sp
ffffffffc020591c:	b17ff0ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc0205920:	319020ef          	jal	ra,ffffffffc0208438 <vfs_getcwd>
ffffffffc0205924:	842a                	mv	s0,a0
ffffffffc0205926:	bf5d                	j	ffffffffc02058dc <sysfile_getcwd+0x58>

ffffffffc0205928 <sysfile_getdirentry>:
ffffffffc0205928:	7139                	addi	sp,sp,-64
ffffffffc020592a:	e852                	sd	s4,16(sp)
ffffffffc020592c:	00091a17          	auipc	s4,0x91
ffffffffc0205930:	f94a0a13          	addi	s4,s4,-108 # ffffffffc02968c0 <current>
ffffffffc0205934:	000a3703          	ld	a4,0(s4)
ffffffffc0205938:	ec4e                	sd	s3,24(sp)
ffffffffc020593a:	89aa                	mv	s3,a0
ffffffffc020593c:	10800513          	li	a0,264
ffffffffc0205940:	f426                	sd	s1,40(sp)
ffffffffc0205942:	f04a                	sd	s2,32(sp)
ffffffffc0205944:	fc06                	sd	ra,56(sp)
ffffffffc0205946:	f822                	sd	s0,48(sp)
ffffffffc0205948:	e456                	sd	s5,8(sp)
ffffffffc020594a:	7704                	ld	s1,40(a4)
ffffffffc020594c:	892e                	mv	s2,a1
ffffffffc020594e:	e90fc0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0205952:	c169                	beqz	a0,ffffffffc0205a14 <sysfile_getdirentry+0xec>
ffffffffc0205954:	842a                	mv	s0,a0
ffffffffc0205956:	c8c1                	beqz	s1,ffffffffc02059e6 <sysfile_getdirentry+0xbe>
ffffffffc0205958:	03848a93          	addi	s5,s1,56
ffffffffc020595c:	8556                	mv	a0,s5
ffffffffc020595e:	c57fe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0205962:	000a3783          	ld	a5,0(s4)
ffffffffc0205966:	c399                	beqz	a5,ffffffffc020596c <sysfile_getdirentry+0x44>
ffffffffc0205968:	43dc                	lw	a5,4(a5)
ffffffffc020596a:	c8bc                	sw	a5,80(s1)
ffffffffc020596c:	4705                	li	a4,1
ffffffffc020596e:	46a1                	li	a3,8
ffffffffc0205970:	864a                	mv	a2,s2
ffffffffc0205972:	85a2                	mv	a1,s0
ffffffffc0205974:	8526                	mv	a0,s1
ffffffffc0205976:	a01fe0ef          	jal	ra,ffffffffc0204376 <copy_from_user>
ffffffffc020597a:	e505                	bnez	a0,ffffffffc02059a2 <sysfile_getdirentry+0x7a>
ffffffffc020597c:	8556                	mv	a0,s5
ffffffffc020597e:	c33fe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0205982:	59f5                	li	s3,-3
ffffffffc0205984:	0404a823          	sw	zero,80(s1)
ffffffffc0205988:	8522                	mv	a0,s0
ffffffffc020598a:	f04fc0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020598e:	70e2                	ld	ra,56(sp)
ffffffffc0205990:	7442                	ld	s0,48(sp)
ffffffffc0205992:	74a2                	ld	s1,40(sp)
ffffffffc0205994:	7902                	ld	s2,32(sp)
ffffffffc0205996:	6a42                	ld	s4,16(sp)
ffffffffc0205998:	6aa2                	ld	s5,8(sp)
ffffffffc020599a:	854e                	mv	a0,s3
ffffffffc020599c:	69e2                	ld	s3,24(sp)
ffffffffc020599e:	6121                	addi	sp,sp,64
ffffffffc02059a0:	8082                	ret
ffffffffc02059a2:	8556                	mv	a0,s5
ffffffffc02059a4:	c0dfe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc02059a8:	854e                	mv	a0,s3
ffffffffc02059aa:	85a2                	mv	a1,s0
ffffffffc02059ac:	0404a823          	sw	zero,80(s1)
ffffffffc02059b0:	ef0ff0ef          	jal	ra,ffffffffc02050a0 <file_getdirentry>
ffffffffc02059b4:	89aa                	mv	s3,a0
ffffffffc02059b6:	f969                	bnez	a0,ffffffffc0205988 <sysfile_getdirentry+0x60>
ffffffffc02059b8:	8556                	mv	a0,s5
ffffffffc02059ba:	bfbfe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc02059be:	000a3783          	ld	a5,0(s4)
ffffffffc02059c2:	c399                	beqz	a5,ffffffffc02059c8 <sysfile_getdirentry+0xa0>
ffffffffc02059c4:	43dc                	lw	a5,4(a5)
ffffffffc02059c6:	c8bc                	sw	a5,80(s1)
ffffffffc02059c8:	10800693          	li	a3,264
ffffffffc02059cc:	8622                	mv	a2,s0
ffffffffc02059ce:	85ca                	mv	a1,s2
ffffffffc02059d0:	8526                	mv	a0,s1
ffffffffc02059d2:	9d9fe0ef          	jal	ra,ffffffffc02043aa <copy_to_user>
ffffffffc02059d6:	e111                	bnez	a0,ffffffffc02059da <sysfile_getdirentry+0xb2>
ffffffffc02059d8:	59f5                	li	s3,-3
ffffffffc02059da:	8556                	mv	a0,s5
ffffffffc02059dc:	bd5fe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc02059e0:	0404a823          	sw	zero,80(s1)
ffffffffc02059e4:	b755                	j	ffffffffc0205988 <sysfile_getdirentry+0x60>
ffffffffc02059e6:	85aa                	mv	a1,a0
ffffffffc02059e8:	4705                	li	a4,1
ffffffffc02059ea:	46a1                	li	a3,8
ffffffffc02059ec:	864a                	mv	a2,s2
ffffffffc02059ee:	4501                	li	a0,0
ffffffffc02059f0:	987fe0ef          	jal	ra,ffffffffc0204376 <copy_from_user>
ffffffffc02059f4:	cd11                	beqz	a0,ffffffffc0205a10 <sysfile_getdirentry+0xe8>
ffffffffc02059f6:	854e                	mv	a0,s3
ffffffffc02059f8:	85a2                	mv	a1,s0
ffffffffc02059fa:	ea6ff0ef          	jal	ra,ffffffffc02050a0 <file_getdirentry>
ffffffffc02059fe:	89aa                	mv	s3,a0
ffffffffc0205a00:	f541                	bnez	a0,ffffffffc0205988 <sysfile_getdirentry+0x60>
ffffffffc0205a02:	10800693          	li	a3,264
ffffffffc0205a06:	8622                	mv	a2,s0
ffffffffc0205a08:	85ca                	mv	a1,s2
ffffffffc0205a0a:	9a1fe0ef          	jal	ra,ffffffffc02043aa <copy_to_user>
ffffffffc0205a0e:	fd2d                	bnez	a0,ffffffffc0205988 <sysfile_getdirentry+0x60>
ffffffffc0205a10:	59f5                	li	s3,-3
ffffffffc0205a12:	bf9d                	j	ffffffffc0205988 <sysfile_getdirentry+0x60>
ffffffffc0205a14:	59f1                	li	s3,-4
ffffffffc0205a16:	bfa5                	j	ffffffffc020598e <sysfile_getdirentry+0x66>

ffffffffc0205a18 <sysfile_dup>:
ffffffffc0205a18:	f6eff06f          	j	ffffffffc0205186 <file_dup>

ffffffffc0205a1c <kernel_thread_entry>:
ffffffffc0205a1c:	8526                	mv	a0,s1
ffffffffc0205a1e:	9402                	jalr	s0
ffffffffc0205a20:	626000ef          	jal	ra,ffffffffc0206046 <do_exit>

ffffffffc0205a24 <alloc_proc>:
ffffffffc0205a24:	1141                	addi	sp,sp,-16
ffffffffc0205a26:	15000513          	li	a0,336
ffffffffc0205a2a:	e022                	sd	s0,0(sp)
ffffffffc0205a2c:	e406                	sd	ra,8(sp)
ffffffffc0205a2e:	db0fc0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0205a32:	842a                	mv	s0,a0
ffffffffc0205a34:	c141                	beqz	a0,ffffffffc0205ab4 <alloc_proc+0x90>
ffffffffc0205a36:	57fd                	li	a5,-1
ffffffffc0205a38:	1782                	slli	a5,a5,0x20
ffffffffc0205a3a:	e11c                	sd	a5,0(a0)
ffffffffc0205a3c:	07000613          	li	a2,112
ffffffffc0205a40:	4581                	li	a1,0
ffffffffc0205a42:	00052423          	sw	zero,8(a0)
ffffffffc0205a46:	00053823          	sd	zero,16(a0)
ffffffffc0205a4a:	00053c23          	sd	zero,24(a0)
ffffffffc0205a4e:	02053023          	sd	zero,32(a0)
ffffffffc0205a52:	02053423          	sd	zero,40(a0)
ffffffffc0205a56:	03050513          	addi	a0,a0,48
ffffffffc0205a5a:	26b050ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0205a5e:	00091797          	auipc	a5,0x91
ffffffffc0205a62:	e327b783          	ld	a5,-462(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205a66:	f45c                	sd	a5,168(s0)
ffffffffc0205a68:	0a043023          	sd	zero,160(s0)
ffffffffc0205a6c:	0a042823          	sw	zero,176(s0)
ffffffffc0205a70:	463d                	li	a2,15
ffffffffc0205a72:	4581                	li	a1,0
ffffffffc0205a74:	0b440513          	addi	a0,s0,180
ffffffffc0205a78:	24d050ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0205a7c:	11040793          	addi	a5,s0,272
ffffffffc0205a80:	0e042623          	sw	zero,236(s0)
ffffffffc0205a84:	0e043c23          	sd	zero,248(s0)
ffffffffc0205a88:	10043023          	sd	zero,256(s0)
ffffffffc0205a8c:	0e043823          	sd	zero,240(s0)
ffffffffc0205a90:	10043423          	sd	zero,264(s0)
ffffffffc0205a94:	10f43c23          	sd	a5,280(s0)
ffffffffc0205a98:	10f43823          	sd	a5,272(s0)
ffffffffc0205a9c:	12042023          	sw	zero,288(s0)
ffffffffc0205aa0:	12043423          	sd	zero,296(s0)
ffffffffc0205aa4:	12043823          	sd	zero,304(s0)
ffffffffc0205aa8:	12043c23          	sd	zero,312(s0)
ffffffffc0205aac:	14043023          	sd	zero,320(s0)
ffffffffc0205ab0:	14043423          	sd	zero,328(s0)
ffffffffc0205ab4:	60a2                	ld	ra,8(sp)
ffffffffc0205ab6:	8522                	mv	a0,s0
ffffffffc0205ab8:	6402                	ld	s0,0(sp)
ffffffffc0205aba:	0141                	addi	sp,sp,16
ffffffffc0205abc:	8082                	ret

ffffffffc0205abe <forkret>:
ffffffffc0205abe:	00091797          	auipc	a5,0x91
ffffffffc0205ac2:	e027b783          	ld	a5,-510(a5) # ffffffffc02968c0 <current>
ffffffffc0205ac6:	73c8                	ld	a0,160(a5)
ffffffffc0205ac8:	833fb06f          	j	ffffffffc02012fa <forkrets>

ffffffffc0205acc <put_pgdir.isra.0>:
ffffffffc0205acc:	1141                	addi	sp,sp,-16
ffffffffc0205ace:	e406                	sd	ra,8(sp)
ffffffffc0205ad0:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ad4:	02f56e63          	bltu	a0,a5,ffffffffc0205b10 <put_pgdir.isra.0+0x44>
ffffffffc0205ad8:	00091697          	auipc	a3,0x91
ffffffffc0205adc:	de06b683          	ld	a3,-544(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205ae0:	8d15                	sub	a0,a0,a3
ffffffffc0205ae2:	8131                	srli	a0,a0,0xc
ffffffffc0205ae4:	00091797          	auipc	a5,0x91
ffffffffc0205ae8:	dbc7b783          	ld	a5,-580(a5) # ffffffffc02968a0 <npage>
ffffffffc0205aec:	02f57f63          	bgeu	a0,a5,ffffffffc0205b2a <put_pgdir.isra.0+0x5e>
ffffffffc0205af0:	0000a697          	auipc	a3,0xa
ffffffffc0205af4:	d486b683          	ld	a3,-696(a3) # ffffffffc020f838 <nbase>
ffffffffc0205af8:	60a2                	ld	ra,8(sp)
ffffffffc0205afa:	8d15                	sub	a0,a0,a3
ffffffffc0205afc:	00091797          	auipc	a5,0x91
ffffffffc0205b00:	dac7b783          	ld	a5,-596(a5) # ffffffffc02968a8 <pages>
ffffffffc0205b04:	051a                	slli	a0,a0,0x6
ffffffffc0205b06:	4585                	li	a1,1
ffffffffc0205b08:	953e                	add	a0,a0,a5
ffffffffc0205b0a:	0141                	addi	sp,sp,16
ffffffffc0205b0c:	eeefc06f          	j	ffffffffc02021fa <free_pages>
ffffffffc0205b10:	86aa                	mv	a3,a0
ffffffffc0205b12:	00007617          	auipc	a2,0x7
ffffffffc0205b16:	a7e60613          	addi	a2,a2,-1410 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc0205b1a:	07700593          	li	a1,119
ffffffffc0205b1e:	00007517          	auipc	a0,0x7
ffffffffc0205b22:	9f250513          	addi	a0,a0,-1550 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0205b26:	979fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b2a:	00007617          	auipc	a2,0x7
ffffffffc0205b2e:	a8e60613          	addi	a2,a2,-1394 # ffffffffc020c5b8 <default_pmm_manager+0x108>
ffffffffc0205b32:	06900593          	li	a1,105
ffffffffc0205b36:	00007517          	auipc	a0,0x7
ffffffffc0205b3a:	9da50513          	addi	a0,a0,-1574 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0205b3e:	961fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205b42 <proc_run>:
ffffffffc0205b42:	7179                	addi	sp,sp,-48
ffffffffc0205b44:	ec4a                	sd	s2,24(sp)
ffffffffc0205b46:	00091917          	auipc	s2,0x91
ffffffffc0205b4a:	d7a90913          	addi	s2,s2,-646 # ffffffffc02968c0 <current>
ffffffffc0205b4e:	f026                	sd	s1,32(sp)
ffffffffc0205b50:	00093483          	ld	s1,0(s2)
ffffffffc0205b54:	f406                	sd	ra,40(sp)
ffffffffc0205b56:	e84e                	sd	s3,16(sp)
ffffffffc0205b58:	02a48a63          	beq	s1,a0,ffffffffc0205b8c <proc_run+0x4a>
ffffffffc0205b5c:	100027f3          	csrr	a5,sstatus
ffffffffc0205b60:	8b89                	andi	a5,a5,2
ffffffffc0205b62:	4981                	li	s3,0
ffffffffc0205b64:	e3a9                	bnez	a5,ffffffffc0205ba6 <proc_run+0x64>
ffffffffc0205b66:	755c                	ld	a5,168(a0)
ffffffffc0205b68:	577d                	li	a4,-1
ffffffffc0205b6a:	177e                	slli	a4,a4,0x3f
ffffffffc0205b6c:	83b1                	srli	a5,a5,0xc
ffffffffc0205b6e:	00a93023          	sd	a0,0(s2)
ffffffffc0205b72:	8fd9                	or	a5,a5,a4
ffffffffc0205b74:	18079073          	csrw	satp,a5
ffffffffc0205b78:	12000073          	sfence.vma
ffffffffc0205b7c:	03050593          	addi	a1,a0,48
ffffffffc0205b80:	03048513          	addi	a0,s1,48
ffffffffc0205b84:	57e010ef          	jal	ra,ffffffffc0207102 <switch_to>
ffffffffc0205b88:	00099863          	bnez	s3,ffffffffc0205b98 <proc_run+0x56>
ffffffffc0205b8c:	70a2                	ld	ra,40(sp)
ffffffffc0205b8e:	7482                	ld	s1,32(sp)
ffffffffc0205b90:	6962                	ld	s2,24(sp)
ffffffffc0205b92:	69c2                	ld	s3,16(sp)
ffffffffc0205b94:	6145                	addi	sp,sp,48
ffffffffc0205b96:	8082                	ret
ffffffffc0205b98:	70a2                	ld	ra,40(sp)
ffffffffc0205b9a:	7482                	ld	s1,32(sp)
ffffffffc0205b9c:	6962                	ld	s2,24(sp)
ffffffffc0205b9e:	69c2                	ld	s3,16(sp)
ffffffffc0205ba0:	6145                	addi	sp,sp,48
ffffffffc0205ba2:	8cafb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205ba6:	e42a                	sd	a0,8(sp)
ffffffffc0205ba8:	8cafb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205bac:	6522                	ld	a0,8(sp)
ffffffffc0205bae:	4985                	li	s3,1
ffffffffc0205bb0:	bf5d                	j	ffffffffc0205b66 <proc_run+0x24>

ffffffffc0205bb2 <do_fork>:
ffffffffc0205bb2:	7119                	addi	sp,sp,-128
ffffffffc0205bb4:	f0ca                	sd	s2,96(sp)
ffffffffc0205bb6:	00091917          	auipc	s2,0x91
ffffffffc0205bba:	d2290913          	addi	s2,s2,-734 # ffffffffc02968d8 <nr_process>
ffffffffc0205bbe:	00092783          	lw	a5,0(s2)
ffffffffc0205bc2:	ecce                	sd	s3,88(sp)
ffffffffc0205bc4:	fc86                	sd	ra,120(sp)
ffffffffc0205bc6:	f8a2                	sd	s0,112(sp)
ffffffffc0205bc8:	f4a6                	sd	s1,104(sp)
ffffffffc0205bca:	e8d2                	sd	s4,80(sp)
ffffffffc0205bcc:	e4d6                	sd	s5,72(sp)
ffffffffc0205bce:	e0da                	sd	s6,64(sp)
ffffffffc0205bd0:	fc5e                	sd	s7,56(sp)
ffffffffc0205bd2:	f862                	sd	s8,48(sp)
ffffffffc0205bd4:	f466                	sd	s9,40(sp)
ffffffffc0205bd6:	f06a                	sd	s10,32(sp)
ffffffffc0205bd8:	ec6e                	sd	s11,24(sp)
ffffffffc0205bda:	6985                	lui	s3,0x1
ffffffffc0205bdc:	e432                	sd	a2,8(sp)
ffffffffc0205bde:	3737d763          	bge	a5,s3,ffffffffc0205f4c <do_fork+0x39a>
ffffffffc0205be2:	8a2a                	mv	s4,a0
ffffffffc0205be4:	8aae                	mv	s5,a1
ffffffffc0205be6:	e3fff0ef          	jal	ra,ffffffffc0205a24 <alloc_proc>
ffffffffc0205bea:	842a                	mv	s0,a0
ffffffffc0205bec:	34050963          	beqz	a0,ffffffffc0205f3e <do_fork+0x38c>
ffffffffc0205bf0:	00091b17          	auipc	s6,0x91
ffffffffc0205bf4:	cd0b0b13          	addi	s6,s6,-816 # ffffffffc02968c0 <current>
ffffffffc0205bf8:	000b3783          	ld	a5,0(s6)
ffffffffc0205bfc:	0ec7a703          	lw	a4,236(a5)
ffffffffc0205c00:	f11c                	sd	a5,32(a0)
ffffffffc0205c02:	3c071a63          	bnez	a4,ffffffffc0205fd6 <do_fork+0x424>
ffffffffc0205c06:	4509                	li	a0,2
ffffffffc0205c08:	db4fc0ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0205c0c:	32050663          	beqz	a0,ffffffffc0205f38 <do_fork+0x386>
ffffffffc0205c10:	00091c17          	auipc	s8,0x91
ffffffffc0205c14:	c98c0c13          	addi	s8,s8,-872 # ffffffffc02968a8 <pages>
ffffffffc0205c18:	000c3683          	ld	a3,0(s8)
ffffffffc0205c1c:	0000ab97          	auipc	s7,0xa
ffffffffc0205c20:	c1cbbb83          	ld	s7,-996(s7) # ffffffffc020f838 <nbase>
ffffffffc0205c24:	00091c97          	auipc	s9,0x91
ffffffffc0205c28:	c7cc8c93          	addi	s9,s9,-900 # ffffffffc02968a0 <npage>
ffffffffc0205c2c:	40d506b3          	sub	a3,a0,a3
ffffffffc0205c30:	8699                	srai	a3,a3,0x6
ffffffffc0205c32:	96de                	add	a3,a3,s7
ffffffffc0205c34:	000cb703          	ld	a4,0(s9)
ffffffffc0205c38:	00c69793          	slli	a5,a3,0xc
ffffffffc0205c3c:	83b1                	srli	a5,a5,0xc
ffffffffc0205c3e:	06b2                	slli	a3,a3,0xc
ffffffffc0205c40:	30e7fb63          	bgeu	a5,a4,ffffffffc0205f56 <do_fork+0x3a4>
ffffffffc0205c44:	000b3603          	ld	a2,0(s6)
ffffffffc0205c48:	00091d17          	auipc	s10,0x91
ffffffffc0205c4c:	c70d0d13          	addi	s10,s10,-912 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205c50:	000d3783          	ld	a5,0(s10)
ffffffffc0205c54:	14863d83          	ld	s11,328(a2)
ffffffffc0205c58:	96be                	add	a3,a3,a5
ffffffffc0205c5a:	e814                	sd	a3,16(s0)
ffffffffc0205c5c:	340d8d63          	beqz	s11,ffffffffc0205fb6 <do_fork+0x404>
ffffffffc0205c60:	80098993          	addi	s3,s3,-2048 # 800 <_binary_bin_swap_img_size-0x7500>
ffffffffc0205c64:	013a79b3          	and	s3,s4,s3
ffffffffc0205c68:	1c098a63          	beqz	s3,ffffffffc0205e3c <do_fork+0x28a>
ffffffffc0205c6c:	010da703          	lw	a4,16(s11)
ffffffffc0205c70:	7604                	ld	s1,40(a2)
ffffffffc0205c72:	2705                	addiw	a4,a4,1
ffffffffc0205c74:	00eda823          	sw	a4,16(s11)
ffffffffc0205c78:	15b43423          	sd	s11,328(s0)
ffffffffc0205c7c:	c095                	beqz	s1,ffffffffc0205ca0 <do_fork+0xee>
ffffffffc0205c7e:	100a7a13          	andi	s4,s4,256
ffffffffc0205c82:	1c0a0963          	beqz	s4,ffffffffc0205e54 <do_fork+0x2a2>
ffffffffc0205c86:	5898                	lw	a4,48(s1)
ffffffffc0205c88:	6c94                	ld	a3,24(s1)
ffffffffc0205c8a:	c0200637          	lui	a2,0xc0200
ffffffffc0205c8e:	2705                	addiw	a4,a4,1
ffffffffc0205c90:	d898                	sw	a4,48(s1)
ffffffffc0205c92:	f404                	sd	s1,40(s0)
ffffffffc0205c94:	2ec6e963          	bltu	a3,a2,ffffffffc0205f86 <do_fork+0x3d4>
ffffffffc0205c98:	000d3783          	ld	a5,0(s10)
ffffffffc0205c9c:	8e9d                	sub	a3,a3,a5
ffffffffc0205c9e:	f454                	sd	a3,168(s0)
ffffffffc0205ca0:	6818                	ld	a4,16(s0)
ffffffffc0205ca2:	6622                	ld	a2,8(sp)
ffffffffc0205ca4:	6789                	lui	a5,0x2
ffffffffc0205ca6:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205caa:	973e                	add	a4,a4,a5
ffffffffc0205cac:	f058                	sd	a4,160(s0)
ffffffffc0205cae:	87ba                	mv	a5,a4
ffffffffc0205cb0:	12060893          	addi	a7,a2,288 # ffffffffc0200120 <readline+0x6e>
ffffffffc0205cb4:	00063803          	ld	a6,0(a2)
ffffffffc0205cb8:	6608                	ld	a0,8(a2)
ffffffffc0205cba:	6a0c                	ld	a1,16(a2)
ffffffffc0205cbc:	6e14                	ld	a3,24(a2)
ffffffffc0205cbe:	0107b023          	sd	a6,0(a5)
ffffffffc0205cc2:	e788                	sd	a0,8(a5)
ffffffffc0205cc4:	eb8c                	sd	a1,16(a5)
ffffffffc0205cc6:	ef94                	sd	a3,24(a5)
ffffffffc0205cc8:	02060613          	addi	a2,a2,32
ffffffffc0205ccc:	02078793          	addi	a5,a5,32
ffffffffc0205cd0:	ff1612e3          	bne	a2,a7,ffffffffc0205cb4 <do_fork+0x102>
ffffffffc0205cd4:	04073823          	sd	zero,80(a4)
ffffffffc0205cd8:	120a8f63          	beqz	s5,ffffffffc0205e16 <do_fork+0x264>
ffffffffc0205cdc:	01573823          	sd	s5,16(a4)
ffffffffc0205ce0:	00000797          	auipc	a5,0x0
ffffffffc0205ce4:	dde78793          	addi	a5,a5,-546 # ffffffffc0205abe <forkret>
ffffffffc0205ce8:	f81c                	sd	a5,48(s0)
ffffffffc0205cea:	fc18                	sd	a4,56(s0)
ffffffffc0205cec:	100027f3          	csrr	a5,sstatus
ffffffffc0205cf0:	8b89                	andi	a5,a5,2
ffffffffc0205cf2:	4981                	li	s3,0
ffffffffc0205cf4:	14079063          	bnez	a5,ffffffffc0205e34 <do_fork+0x282>
ffffffffc0205cf8:	0008b817          	auipc	a6,0x8b
ffffffffc0205cfc:	36080813          	addi	a6,a6,864 # ffffffffc0291058 <last_pid.1>
ffffffffc0205d00:	00082783          	lw	a5,0(a6)
ffffffffc0205d04:	6709                	lui	a4,0x2
ffffffffc0205d06:	0017851b          	addiw	a0,a5,1
ffffffffc0205d0a:	00a82023          	sw	a0,0(a6)
ffffffffc0205d0e:	08e55d63          	bge	a0,a4,ffffffffc0205da8 <do_fork+0x1f6>
ffffffffc0205d12:	0008b317          	auipc	t1,0x8b
ffffffffc0205d16:	34a30313          	addi	t1,t1,842 # ffffffffc029105c <next_safe.0>
ffffffffc0205d1a:	00032783          	lw	a5,0(t1)
ffffffffc0205d1e:	00090497          	auipc	s1,0x90
ffffffffc0205d22:	aa248493          	addi	s1,s1,-1374 # ffffffffc02957c0 <proc_list>
ffffffffc0205d26:	08f55963          	bge	a0,a5,ffffffffc0205db8 <do_fork+0x206>
ffffffffc0205d2a:	c048                	sw	a0,4(s0)
ffffffffc0205d2c:	45a9                	li	a1,10
ffffffffc0205d2e:	2501                	sext.w	a0,a0
ffffffffc0205d30:	260050ef          	jal	ra,ffffffffc020af90 <hash32>
ffffffffc0205d34:	02051793          	slli	a5,a0,0x20
ffffffffc0205d38:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205d3c:	0008c797          	auipc	a5,0x8c
ffffffffc0205d40:	a8478793          	addi	a5,a5,-1404 # ffffffffc02917c0 <hash_list>
ffffffffc0205d44:	953e                	add	a0,a0,a5
ffffffffc0205d46:	650c                	ld	a1,8(a0)
ffffffffc0205d48:	7014                	ld	a3,32(s0)
ffffffffc0205d4a:	0d840793          	addi	a5,s0,216
ffffffffc0205d4e:	e19c                	sd	a5,0(a1)
ffffffffc0205d50:	6490                	ld	a2,8(s1)
ffffffffc0205d52:	e51c                	sd	a5,8(a0)
ffffffffc0205d54:	7af8                	ld	a4,240(a3)
ffffffffc0205d56:	0c840793          	addi	a5,s0,200
ffffffffc0205d5a:	f06c                	sd	a1,224(s0)
ffffffffc0205d5c:	ec68                	sd	a0,216(s0)
ffffffffc0205d5e:	e21c                	sd	a5,0(a2)
ffffffffc0205d60:	e49c                	sd	a5,8(s1)
ffffffffc0205d62:	e870                	sd	a2,208(s0)
ffffffffc0205d64:	e464                	sd	s1,200(s0)
ffffffffc0205d66:	0e043c23          	sd	zero,248(s0)
ffffffffc0205d6a:	10e43023          	sd	a4,256(s0)
ffffffffc0205d6e:	c311                	beqz	a4,ffffffffc0205d72 <do_fork+0x1c0>
ffffffffc0205d70:	ff60                	sd	s0,248(a4)
ffffffffc0205d72:	00092783          	lw	a5,0(s2)
ffffffffc0205d76:	fae0                	sd	s0,240(a3)
ffffffffc0205d78:	2785                	addiw	a5,a5,1
ffffffffc0205d7a:	00f92023          	sw	a5,0(s2)
ffffffffc0205d7e:	14099663          	bnez	s3,ffffffffc0205eca <do_fork+0x318>
ffffffffc0205d82:	8522                	mv	a0,s0
ffffffffc0205d84:	522010ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc0205d88:	4048                	lw	a0,4(s0)
ffffffffc0205d8a:	70e6                	ld	ra,120(sp)
ffffffffc0205d8c:	7446                	ld	s0,112(sp)
ffffffffc0205d8e:	74a6                	ld	s1,104(sp)
ffffffffc0205d90:	7906                	ld	s2,96(sp)
ffffffffc0205d92:	69e6                	ld	s3,88(sp)
ffffffffc0205d94:	6a46                	ld	s4,80(sp)
ffffffffc0205d96:	6aa6                	ld	s5,72(sp)
ffffffffc0205d98:	6b06                	ld	s6,64(sp)
ffffffffc0205d9a:	7be2                	ld	s7,56(sp)
ffffffffc0205d9c:	7c42                	ld	s8,48(sp)
ffffffffc0205d9e:	7ca2                	ld	s9,40(sp)
ffffffffc0205da0:	7d02                	ld	s10,32(sp)
ffffffffc0205da2:	6de2                	ld	s11,24(sp)
ffffffffc0205da4:	6109                	addi	sp,sp,128
ffffffffc0205da6:	8082                	ret
ffffffffc0205da8:	4785                	li	a5,1
ffffffffc0205daa:	00f82023          	sw	a5,0(a6)
ffffffffc0205dae:	4505                	li	a0,1
ffffffffc0205db0:	0008b317          	auipc	t1,0x8b
ffffffffc0205db4:	2ac30313          	addi	t1,t1,684 # ffffffffc029105c <next_safe.0>
ffffffffc0205db8:	00090497          	auipc	s1,0x90
ffffffffc0205dbc:	a0848493          	addi	s1,s1,-1528 # ffffffffc02957c0 <proc_list>
ffffffffc0205dc0:	0084be03          	ld	t3,8(s1)
ffffffffc0205dc4:	6789                	lui	a5,0x2
ffffffffc0205dc6:	00f32023          	sw	a5,0(t1)
ffffffffc0205dca:	86aa                	mv	a3,a0
ffffffffc0205dcc:	4581                	li	a1,0
ffffffffc0205dce:	6e89                	lui	t4,0x2
ffffffffc0205dd0:	169e0963          	beq	t3,s1,ffffffffc0205f42 <do_fork+0x390>
ffffffffc0205dd4:	88ae                	mv	a7,a1
ffffffffc0205dd6:	87f2                	mv	a5,t3
ffffffffc0205dd8:	6609                	lui	a2,0x2
ffffffffc0205dda:	a811                	j	ffffffffc0205dee <do_fork+0x23c>
ffffffffc0205ddc:	00e6d663          	bge	a3,a4,ffffffffc0205de8 <do_fork+0x236>
ffffffffc0205de0:	00c75463          	bge	a4,a2,ffffffffc0205de8 <do_fork+0x236>
ffffffffc0205de4:	863a                	mv	a2,a4
ffffffffc0205de6:	4885                	li	a7,1
ffffffffc0205de8:	679c                	ld	a5,8(a5)
ffffffffc0205dea:	00978d63          	beq	a5,s1,ffffffffc0205e04 <do_fork+0x252>
ffffffffc0205dee:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205df2:	fed715e3          	bne	a4,a3,ffffffffc0205ddc <do_fork+0x22a>
ffffffffc0205df6:	2685                	addiw	a3,a3,1
ffffffffc0205df8:	0cc6dc63          	bge	a3,a2,ffffffffc0205ed0 <do_fork+0x31e>
ffffffffc0205dfc:	679c                	ld	a5,8(a5)
ffffffffc0205dfe:	4585                	li	a1,1
ffffffffc0205e00:	fe9797e3          	bne	a5,s1,ffffffffc0205dee <do_fork+0x23c>
ffffffffc0205e04:	c581                	beqz	a1,ffffffffc0205e0c <do_fork+0x25a>
ffffffffc0205e06:	00d82023          	sw	a3,0(a6)
ffffffffc0205e0a:	8536                	mv	a0,a3
ffffffffc0205e0c:	f0088fe3          	beqz	a7,ffffffffc0205d2a <do_fork+0x178>
ffffffffc0205e10:	00c32023          	sw	a2,0(t1)
ffffffffc0205e14:	bf19                	j	ffffffffc0205d2a <do_fork+0x178>
ffffffffc0205e16:	8aba                	mv	s5,a4
ffffffffc0205e18:	01573823          	sd	s5,16(a4) # 2010 <_binary_bin_swap_img_size-0x5cf0>
ffffffffc0205e1c:	00000797          	auipc	a5,0x0
ffffffffc0205e20:	ca278793          	addi	a5,a5,-862 # ffffffffc0205abe <forkret>
ffffffffc0205e24:	f81c                	sd	a5,48(s0)
ffffffffc0205e26:	fc18                	sd	a4,56(s0)
ffffffffc0205e28:	100027f3          	csrr	a5,sstatus
ffffffffc0205e2c:	8b89                	andi	a5,a5,2
ffffffffc0205e2e:	4981                	li	s3,0
ffffffffc0205e30:	ec0784e3          	beqz	a5,ffffffffc0205cf8 <do_fork+0x146>
ffffffffc0205e34:	e3ffa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205e38:	4985                	li	s3,1
ffffffffc0205e3a:	bd7d                	j	ffffffffc0205cf8 <do_fork+0x146>
ffffffffc0205e3c:	be2ff0ef          	jal	ra,ffffffffc020521e <files_create>
ffffffffc0205e40:	89aa                	mv	s3,a0
ffffffffc0205e42:	c561                	beqz	a0,ffffffffc0205f0a <do_fork+0x358>
ffffffffc0205e44:	85ee                	mv	a1,s11
ffffffffc0205e46:	d10ff0ef          	jal	ra,ffffffffc0205356 <dup_files>
ffffffffc0205e4a:	ed4d                	bnez	a0,ffffffffc0205f04 <do_fork+0x352>
ffffffffc0205e4c:	000b3603          	ld	a2,0(s6)
ffffffffc0205e50:	8dce                	mv	s11,s3
ffffffffc0205e52:	bd29                	j	ffffffffc0205c6c <do_fork+0xba>
ffffffffc0205e54:	e05fd0ef          	jal	ra,ffffffffc0203c58 <mm_create>
ffffffffc0205e58:	8a2a                	mv	s4,a0
ffffffffc0205e5a:	c951                	beqz	a0,ffffffffc0205eee <do_fork+0x33c>
ffffffffc0205e5c:	4505                	li	a0,1
ffffffffc0205e5e:	b5efc0ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0205e62:	c159                	beqz	a0,ffffffffc0205ee8 <do_fork+0x336>
ffffffffc0205e64:	000c3683          	ld	a3,0(s8)
ffffffffc0205e68:	000cb603          	ld	a2,0(s9)
ffffffffc0205e6c:	40d506b3          	sub	a3,a0,a3
ffffffffc0205e70:	8699                	srai	a3,a3,0x6
ffffffffc0205e72:	96de                	add	a3,a3,s7
ffffffffc0205e74:	00c69713          	slli	a4,a3,0xc
ffffffffc0205e78:	8331                	srli	a4,a4,0xc
ffffffffc0205e7a:	06b2                	slli	a3,a3,0xc
ffffffffc0205e7c:	0cc77d63          	bgeu	a4,a2,ffffffffc0205f56 <do_fork+0x3a4>
ffffffffc0205e80:	000d3983          	ld	s3,0(s10)
ffffffffc0205e84:	6605                	lui	a2,0x1
ffffffffc0205e86:	00091597          	auipc	a1,0x91
ffffffffc0205e8a:	a125b583          	ld	a1,-1518(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205e8e:	99b6                	add	s3,s3,a3
ffffffffc0205e90:	854e                	mv	a0,s3
ffffffffc0205e92:	684050ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc0205e96:	03848d93          	addi	s11,s1,56
ffffffffc0205e9a:	013a3c23          	sd	s3,24(s4)
ffffffffc0205e9e:	856e                	mv	a0,s11
ffffffffc0205ea0:	f14fe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0205ea4:	000b3703          	ld	a4,0(s6)
ffffffffc0205ea8:	c319                	beqz	a4,ffffffffc0205eae <do_fork+0x2fc>
ffffffffc0205eaa:	4358                	lw	a4,4(a4)
ffffffffc0205eac:	c8b8                	sw	a4,80(s1)
ffffffffc0205eae:	85a6                	mv	a1,s1
ffffffffc0205eb0:	8552                	mv	a0,s4
ffffffffc0205eb2:	ff7fd0ef          	jal	ra,ffffffffc0203ea8 <dup_mmap>
ffffffffc0205eb6:	89aa                	mv	s3,a0
ffffffffc0205eb8:	856e                	mv	a0,s11
ffffffffc0205eba:	ef6fe0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0205ebe:	0404a823          	sw	zero,80(s1)
ffffffffc0205ec2:	00099c63          	bnez	s3,ffffffffc0205eda <do_fork+0x328>
ffffffffc0205ec6:	84d2                	mv	s1,s4
ffffffffc0205ec8:	bb7d                	j	ffffffffc0205c86 <do_fork+0xd4>
ffffffffc0205eca:	da3fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0205ece:	bd55                	j	ffffffffc0205d82 <do_fork+0x1d0>
ffffffffc0205ed0:	01d6c363          	blt	a3,t4,ffffffffc0205ed6 <do_fork+0x324>
ffffffffc0205ed4:	4685                	li	a3,1
ffffffffc0205ed6:	4585                	li	a1,1
ffffffffc0205ed8:	bde5                	j	ffffffffc0205dd0 <do_fork+0x21e>
ffffffffc0205eda:	8552                	mv	a0,s4
ffffffffc0205edc:	866fe0ef          	jal	ra,ffffffffc0203f42 <exit_mmap>
ffffffffc0205ee0:	018a3503          	ld	a0,24(s4)
ffffffffc0205ee4:	be9ff0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc0205ee8:	8552                	mv	a0,s4
ffffffffc0205eea:	ebdfd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0205eee:	14843503          	ld	a0,328(s0)
ffffffffc0205ef2:	cd01                	beqz	a0,ffffffffc0205f0a <do_fork+0x358>
ffffffffc0205ef4:	491c                	lw	a5,16(a0)
ffffffffc0205ef6:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205efa:	c918                	sw	a4,16(a0)
ffffffffc0205efc:	e719                	bnez	a4,ffffffffc0205f0a <do_fork+0x358>
ffffffffc0205efe:	b56ff0ef          	jal	ra,ffffffffc0205254 <files_destroy>
ffffffffc0205f02:	a021                	j	ffffffffc0205f0a <do_fork+0x358>
ffffffffc0205f04:	854e                	mv	a0,s3
ffffffffc0205f06:	b4eff0ef          	jal	ra,ffffffffc0205254 <files_destroy>
ffffffffc0205f0a:	6814                	ld	a3,16(s0)
ffffffffc0205f0c:	c02007b7          	lui	a5,0xc0200
ffffffffc0205f10:	04f6ef63          	bltu	a3,a5,ffffffffc0205f6e <do_fork+0x3bc>
ffffffffc0205f14:	000d3783          	ld	a5,0(s10)
ffffffffc0205f18:	000cb703          	ld	a4,0(s9)
ffffffffc0205f1c:	40f687b3          	sub	a5,a3,a5
ffffffffc0205f20:	83b1                	srli	a5,a5,0xc
ffffffffc0205f22:	06e7fe63          	bgeu	a5,a4,ffffffffc0205f9e <do_fork+0x3ec>
ffffffffc0205f26:	000c3503          	ld	a0,0(s8)
ffffffffc0205f2a:	417787b3          	sub	a5,a5,s7
ffffffffc0205f2e:	079a                	slli	a5,a5,0x6
ffffffffc0205f30:	4589                	li	a1,2
ffffffffc0205f32:	953e                	add	a0,a0,a5
ffffffffc0205f34:	ac6fc0ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc0205f38:	8522                	mv	a0,s0
ffffffffc0205f3a:	954fc0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0205f3e:	5571                	li	a0,-4
ffffffffc0205f40:	b5a9                	j	ffffffffc0205d8a <do_fork+0x1d8>
ffffffffc0205f42:	c599                	beqz	a1,ffffffffc0205f50 <do_fork+0x39e>
ffffffffc0205f44:	00d82023          	sw	a3,0(a6)
ffffffffc0205f48:	8536                	mv	a0,a3
ffffffffc0205f4a:	b3c5                	j	ffffffffc0205d2a <do_fork+0x178>
ffffffffc0205f4c:	556d                	li	a0,-5
ffffffffc0205f4e:	bd35                	j	ffffffffc0205d8a <do_fork+0x1d8>
ffffffffc0205f50:	00082503          	lw	a0,0(a6)
ffffffffc0205f54:	bbd9                	j	ffffffffc0205d2a <do_fork+0x178>
ffffffffc0205f56:	00006617          	auipc	a2,0x6
ffffffffc0205f5a:	59260613          	addi	a2,a2,1426 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0205f5e:	07100593          	li	a1,113
ffffffffc0205f62:	00006517          	auipc	a0,0x6
ffffffffc0205f66:	5ae50513          	addi	a0,a0,1454 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0205f6a:	d34fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f6e:	00006617          	auipc	a2,0x6
ffffffffc0205f72:	62260613          	addi	a2,a2,1570 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc0205f76:	07700593          	li	a1,119
ffffffffc0205f7a:	00006517          	auipc	a0,0x6
ffffffffc0205f7e:	59650513          	addi	a0,a0,1430 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0205f82:	d1cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f86:	00006617          	auipc	a2,0x6
ffffffffc0205f8a:	60a60613          	addi	a2,a2,1546 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc0205f8e:	19c00593          	li	a1,412
ffffffffc0205f92:	00007517          	auipc	a0,0x7
ffffffffc0205f96:	55650513          	addi	a0,a0,1366 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0205f9a:	d04fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f9e:	00006617          	auipc	a2,0x6
ffffffffc0205fa2:	61a60613          	addi	a2,a2,1562 # ffffffffc020c5b8 <default_pmm_manager+0x108>
ffffffffc0205fa6:	06900593          	li	a1,105
ffffffffc0205faa:	00006517          	auipc	a0,0x6
ffffffffc0205fae:	56650513          	addi	a0,a0,1382 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0205fb2:	cecfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fb6:	00007697          	auipc	a3,0x7
ffffffffc0205fba:	54a68693          	addi	a3,a3,1354 # ffffffffc020d500 <CSWTCH.79+0x128>
ffffffffc0205fbe:	00006617          	auipc	a2,0x6
ffffffffc0205fc2:	9ea60613          	addi	a2,a2,-1558 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0205fc6:	1bc00593          	li	a1,444
ffffffffc0205fca:	00007517          	auipc	a0,0x7
ffffffffc0205fce:	51e50513          	addi	a0,a0,1310 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0205fd2:	cccfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205fd6:	00007697          	auipc	a3,0x7
ffffffffc0205fda:	4f268693          	addi	a3,a3,1266 # ffffffffc020d4c8 <CSWTCH.79+0xf0>
ffffffffc0205fde:	00006617          	auipc	a2,0x6
ffffffffc0205fe2:	9ca60613          	addi	a2,a2,-1590 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0205fe6:	1fd00593          	li	a1,509
ffffffffc0205fea:	00007517          	auipc	a0,0x7
ffffffffc0205fee:	4fe50513          	addi	a0,a0,1278 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0205ff2:	cacfa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205ff6 <kernel_thread>:
ffffffffc0205ff6:	7129                	addi	sp,sp,-320
ffffffffc0205ff8:	fa22                	sd	s0,304(sp)
ffffffffc0205ffa:	f626                	sd	s1,296(sp)
ffffffffc0205ffc:	f24a                	sd	s2,288(sp)
ffffffffc0205ffe:	84ae                	mv	s1,a1
ffffffffc0206000:	892a                	mv	s2,a0
ffffffffc0206002:	8432                	mv	s0,a2
ffffffffc0206004:	4581                	li	a1,0
ffffffffc0206006:	12000613          	li	a2,288
ffffffffc020600a:	850a                	mv	a0,sp
ffffffffc020600c:	fe06                	sd	ra,312(sp)
ffffffffc020600e:	4b6050ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0206012:	e0ca                	sd	s2,64(sp)
ffffffffc0206014:	e4a6                	sd	s1,72(sp)
ffffffffc0206016:	100027f3          	csrr	a5,sstatus
ffffffffc020601a:	edd7f793          	andi	a5,a5,-291
ffffffffc020601e:	1207e793          	ori	a5,a5,288
ffffffffc0206022:	e23e                	sd	a5,256(sp)
ffffffffc0206024:	860a                	mv	a2,sp
ffffffffc0206026:	10046513          	ori	a0,s0,256
ffffffffc020602a:	00000797          	auipc	a5,0x0
ffffffffc020602e:	9f278793          	addi	a5,a5,-1550 # ffffffffc0205a1c <kernel_thread_entry>
ffffffffc0206032:	4581                	li	a1,0
ffffffffc0206034:	e63e                	sd	a5,264(sp)
ffffffffc0206036:	b7dff0ef          	jal	ra,ffffffffc0205bb2 <do_fork>
ffffffffc020603a:	70f2                	ld	ra,312(sp)
ffffffffc020603c:	7452                	ld	s0,304(sp)
ffffffffc020603e:	74b2                	ld	s1,296(sp)
ffffffffc0206040:	7912                	ld	s2,288(sp)
ffffffffc0206042:	6131                	addi	sp,sp,320
ffffffffc0206044:	8082                	ret

ffffffffc0206046 <do_exit>:
ffffffffc0206046:	7179                	addi	sp,sp,-48
ffffffffc0206048:	f022                	sd	s0,32(sp)
ffffffffc020604a:	00091417          	auipc	s0,0x91
ffffffffc020604e:	87640413          	addi	s0,s0,-1930 # ffffffffc02968c0 <current>
ffffffffc0206052:	601c                	ld	a5,0(s0)
ffffffffc0206054:	f406                	sd	ra,40(sp)
ffffffffc0206056:	ec26                	sd	s1,24(sp)
ffffffffc0206058:	e84a                	sd	s2,16(sp)
ffffffffc020605a:	e44e                	sd	s3,8(sp)
ffffffffc020605c:	e052                	sd	s4,0(sp)
ffffffffc020605e:	00091717          	auipc	a4,0x91
ffffffffc0206062:	86a73703          	ld	a4,-1942(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0206066:	0ee78763          	beq	a5,a4,ffffffffc0206154 <do_exit+0x10e>
ffffffffc020606a:	00091497          	auipc	s1,0x91
ffffffffc020606e:	86648493          	addi	s1,s1,-1946 # ffffffffc02968d0 <initproc>
ffffffffc0206072:	6098                	ld	a4,0(s1)
ffffffffc0206074:	10e78763          	beq	a5,a4,ffffffffc0206182 <do_exit+0x13c>
ffffffffc0206078:	0287b983          	ld	s3,40(a5)
ffffffffc020607c:	892a                	mv	s2,a0
ffffffffc020607e:	02098e63          	beqz	s3,ffffffffc02060ba <do_exit+0x74>
ffffffffc0206082:	00091797          	auipc	a5,0x91
ffffffffc0206086:	80e7b783          	ld	a5,-2034(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc020608a:	577d                	li	a4,-1
ffffffffc020608c:	177e                	slli	a4,a4,0x3f
ffffffffc020608e:	83b1                	srli	a5,a5,0xc
ffffffffc0206090:	8fd9                	or	a5,a5,a4
ffffffffc0206092:	18079073          	csrw	satp,a5
ffffffffc0206096:	0309a783          	lw	a5,48(s3)
ffffffffc020609a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020609e:	02e9a823          	sw	a4,48(s3)
ffffffffc02060a2:	c769                	beqz	a4,ffffffffc020616c <do_exit+0x126>
ffffffffc02060a4:	601c                	ld	a5,0(s0)
ffffffffc02060a6:	1487b503          	ld	a0,328(a5)
ffffffffc02060aa:	0207b423          	sd	zero,40(a5)
ffffffffc02060ae:	c511                	beqz	a0,ffffffffc02060ba <do_exit+0x74>
ffffffffc02060b0:	491c                	lw	a5,16(a0)
ffffffffc02060b2:	fff7871b          	addiw	a4,a5,-1
ffffffffc02060b6:	c918                	sw	a4,16(a0)
ffffffffc02060b8:	cb59                	beqz	a4,ffffffffc020614e <do_exit+0x108>
ffffffffc02060ba:	601c                	ld	a5,0(s0)
ffffffffc02060bc:	470d                	li	a4,3
ffffffffc02060be:	c398                	sw	a4,0(a5)
ffffffffc02060c0:	0f27a423          	sw	s2,232(a5)
ffffffffc02060c4:	100027f3          	csrr	a5,sstatus
ffffffffc02060c8:	8b89                	andi	a5,a5,2
ffffffffc02060ca:	4a01                	li	s4,0
ffffffffc02060cc:	e7f9                	bnez	a5,ffffffffc020619a <do_exit+0x154>
ffffffffc02060ce:	6018                	ld	a4,0(s0)
ffffffffc02060d0:	800007b7          	lui	a5,0x80000
ffffffffc02060d4:	0785                	addi	a5,a5,1
ffffffffc02060d6:	7308                	ld	a0,32(a4)
ffffffffc02060d8:	0ec52703          	lw	a4,236(a0)
ffffffffc02060dc:	0cf70363          	beq	a4,a5,ffffffffc02061a2 <do_exit+0x15c>
ffffffffc02060e0:	6018                	ld	a4,0(s0)
ffffffffc02060e2:	7b7c                	ld	a5,240(a4)
ffffffffc02060e4:	c3a1                	beqz	a5,ffffffffc0206124 <do_exit+0xde>
ffffffffc02060e6:	800009b7          	lui	s3,0x80000
ffffffffc02060ea:	490d                	li	s2,3
ffffffffc02060ec:	0985                	addi	s3,s3,1
ffffffffc02060ee:	a021                	j	ffffffffc02060f6 <do_exit+0xb0>
ffffffffc02060f0:	6018                	ld	a4,0(s0)
ffffffffc02060f2:	7b7c                	ld	a5,240(a4)
ffffffffc02060f4:	cb85                	beqz	a5,ffffffffc0206124 <do_exit+0xde>
ffffffffc02060f6:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc02060fa:	6088                	ld	a0,0(s1)
ffffffffc02060fc:	fb74                	sd	a3,240(a4)
ffffffffc02060fe:	7978                	ld	a4,240(a0)
ffffffffc0206100:	0e07bc23          	sd	zero,248(a5)
ffffffffc0206104:	10e7b023          	sd	a4,256(a5)
ffffffffc0206108:	c311                	beqz	a4,ffffffffc020610c <do_exit+0xc6>
ffffffffc020610a:	ff7c                	sd	a5,248(a4)
ffffffffc020610c:	4398                	lw	a4,0(a5)
ffffffffc020610e:	f388                	sd	a0,32(a5)
ffffffffc0206110:	f97c                	sd	a5,240(a0)
ffffffffc0206112:	fd271fe3          	bne	a4,s2,ffffffffc02060f0 <do_exit+0xaa>
ffffffffc0206116:	0ec52783          	lw	a5,236(a0)
ffffffffc020611a:	fd379be3          	bne	a5,s3,ffffffffc02060f0 <do_exit+0xaa>
ffffffffc020611e:	188010ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc0206122:	b7f9                	j	ffffffffc02060f0 <do_exit+0xaa>
ffffffffc0206124:	020a1263          	bnez	s4,ffffffffc0206148 <do_exit+0x102>
ffffffffc0206128:	230010ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc020612c:	601c                	ld	a5,0(s0)
ffffffffc020612e:	00007617          	auipc	a2,0x7
ffffffffc0206132:	40a60613          	addi	a2,a2,1034 # ffffffffc020d538 <CSWTCH.79+0x160>
ffffffffc0206136:	26600593          	li	a1,614
ffffffffc020613a:	43d4                	lw	a3,4(a5)
ffffffffc020613c:	00007517          	auipc	a0,0x7
ffffffffc0206140:	3ac50513          	addi	a0,a0,940 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206144:	b5afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206148:	b25fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020614c:	bff1                	j	ffffffffc0206128 <do_exit+0xe2>
ffffffffc020614e:	906ff0ef          	jal	ra,ffffffffc0205254 <files_destroy>
ffffffffc0206152:	b7a5                	j	ffffffffc02060ba <do_exit+0x74>
ffffffffc0206154:	00007617          	auipc	a2,0x7
ffffffffc0206158:	3c460613          	addi	a2,a2,964 # ffffffffc020d518 <CSWTCH.79+0x140>
ffffffffc020615c:	23100593          	li	a1,561
ffffffffc0206160:	00007517          	auipc	a0,0x7
ffffffffc0206164:	38850513          	addi	a0,a0,904 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206168:	b36fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020616c:	854e                	mv	a0,s3
ffffffffc020616e:	dd5fd0ef          	jal	ra,ffffffffc0203f42 <exit_mmap>
ffffffffc0206172:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc0206176:	957ff0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc020617a:	854e                	mv	a0,s3
ffffffffc020617c:	c2bfd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0206180:	b715                	j	ffffffffc02060a4 <do_exit+0x5e>
ffffffffc0206182:	00007617          	auipc	a2,0x7
ffffffffc0206186:	3a660613          	addi	a2,a2,934 # ffffffffc020d528 <CSWTCH.79+0x150>
ffffffffc020618a:	23500593          	li	a1,565
ffffffffc020618e:	00007517          	auipc	a0,0x7
ffffffffc0206192:	35a50513          	addi	a0,a0,858 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206196:	b08fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020619a:	ad9fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020619e:	4a05                	li	s4,1
ffffffffc02061a0:	b73d                	j	ffffffffc02060ce <do_exit+0x88>
ffffffffc02061a2:	104010ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc02061a6:	bf2d                	j	ffffffffc02060e0 <do_exit+0x9a>

ffffffffc02061a8 <do_wait.part.0>:
ffffffffc02061a8:	715d                	addi	sp,sp,-80
ffffffffc02061aa:	f84a                	sd	s2,48(sp)
ffffffffc02061ac:	f44e                	sd	s3,40(sp)
ffffffffc02061ae:	80000937          	lui	s2,0x80000
ffffffffc02061b2:	6989                	lui	s3,0x2
ffffffffc02061b4:	fc26                	sd	s1,56(sp)
ffffffffc02061b6:	f052                	sd	s4,32(sp)
ffffffffc02061b8:	ec56                	sd	s5,24(sp)
ffffffffc02061ba:	e85a                	sd	s6,16(sp)
ffffffffc02061bc:	e45e                	sd	s7,8(sp)
ffffffffc02061be:	e486                	sd	ra,72(sp)
ffffffffc02061c0:	e0a2                	sd	s0,64(sp)
ffffffffc02061c2:	84aa                	mv	s1,a0
ffffffffc02061c4:	8a2e                	mv	s4,a1
ffffffffc02061c6:	00090b97          	auipc	s7,0x90
ffffffffc02061ca:	6fab8b93          	addi	s7,s7,1786 # ffffffffc02968c0 <current>
ffffffffc02061ce:	00050b1b          	sext.w	s6,a0
ffffffffc02061d2:	fff50a9b          	addiw	s5,a0,-1
ffffffffc02061d6:	19f9                	addi	s3,s3,-2
ffffffffc02061d8:	0905                	addi	s2,s2,1
ffffffffc02061da:	ccbd                	beqz	s1,ffffffffc0206258 <do_wait.part.0+0xb0>
ffffffffc02061dc:	0359e863          	bltu	s3,s5,ffffffffc020620c <do_wait.part.0+0x64>
ffffffffc02061e0:	45a9                	li	a1,10
ffffffffc02061e2:	855a                	mv	a0,s6
ffffffffc02061e4:	5ad040ef          	jal	ra,ffffffffc020af90 <hash32>
ffffffffc02061e8:	02051793          	slli	a5,a0,0x20
ffffffffc02061ec:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02061f0:	0008b797          	auipc	a5,0x8b
ffffffffc02061f4:	5d078793          	addi	a5,a5,1488 # ffffffffc02917c0 <hash_list>
ffffffffc02061f8:	953e                	add	a0,a0,a5
ffffffffc02061fa:	842a                	mv	s0,a0
ffffffffc02061fc:	a029                	j	ffffffffc0206206 <do_wait.part.0+0x5e>
ffffffffc02061fe:	f2c42783          	lw	a5,-212(s0)
ffffffffc0206202:	02978163          	beq	a5,s1,ffffffffc0206224 <do_wait.part.0+0x7c>
ffffffffc0206206:	6400                	ld	s0,8(s0)
ffffffffc0206208:	fe851be3          	bne	a0,s0,ffffffffc02061fe <do_wait.part.0+0x56>
ffffffffc020620c:	5579                	li	a0,-2
ffffffffc020620e:	60a6                	ld	ra,72(sp)
ffffffffc0206210:	6406                	ld	s0,64(sp)
ffffffffc0206212:	74e2                	ld	s1,56(sp)
ffffffffc0206214:	7942                	ld	s2,48(sp)
ffffffffc0206216:	79a2                	ld	s3,40(sp)
ffffffffc0206218:	7a02                	ld	s4,32(sp)
ffffffffc020621a:	6ae2                	ld	s5,24(sp)
ffffffffc020621c:	6b42                	ld	s6,16(sp)
ffffffffc020621e:	6ba2                	ld	s7,8(sp)
ffffffffc0206220:	6161                	addi	sp,sp,80
ffffffffc0206222:	8082                	ret
ffffffffc0206224:	000bb683          	ld	a3,0(s7)
ffffffffc0206228:	f4843783          	ld	a5,-184(s0)
ffffffffc020622c:	fed790e3          	bne	a5,a3,ffffffffc020620c <do_wait.part.0+0x64>
ffffffffc0206230:	f2842703          	lw	a4,-216(s0)
ffffffffc0206234:	478d                	li	a5,3
ffffffffc0206236:	0ef70b63          	beq	a4,a5,ffffffffc020632c <do_wait.part.0+0x184>
ffffffffc020623a:	4785                	li	a5,1
ffffffffc020623c:	c29c                	sw	a5,0(a3)
ffffffffc020623e:	0f26a623          	sw	s2,236(a3)
ffffffffc0206242:	116010ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc0206246:	000bb783          	ld	a5,0(s7)
ffffffffc020624a:	0b07a783          	lw	a5,176(a5)
ffffffffc020624e:	8b85                	andi	a5,a5,1
ffffffffc0206250:	d7c9                	beqz	a5,ffffffffc02061da <do_wait.part.0+0x32>
ffffffffc0206252:	555d                	li	a0,-9
ffffffffc0206254:	df3ff0ef          	jal	ra,ffffffffc0206046 <do_exit>
ffffffffc0206258:	000bb683          	ld	a3,0(s7)
ffffffffc020625c:	7ae0                	ld	s0,240(a3)
ffffffffc020625e:	d45d                	beqz	s0,ffffffffc020620c <do_wait.part.0+0x64>
ffffffffc0206260:	470d                	li	a4,3
ffffffffc0206262:	a021                	j	ffffffffc020626a <do_wait.part.0+0xc2>
ffffffffc0206264:	10043403          	ld	s0,256(s0)
ffffffffc0206268:	d869                	beqz	s0,ffffffffc020623a <do_wait.part.0+0x92>
ffffffffc020626a:	401c                	lw	a5,0(s0)
ffffffffc020626c:	fee79ce3          	bne	a5,a4,ffffffffc0206264 <do_wait.part.0+0xbc>
ffffffffc0206270:	00090797          	auipc	a5,0x90
ffffffffc0206274:	6587b783          	ld	a5,1624(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0206278:	0c878963          	beq	a5,s0,ffffffffc020634a <do_wait.part.0+0x1a2>
ffffffffc020627c:	00090797          	auipc	a5,0x90
ffffffffc0206280:	6547b783          	ld	a5,1620(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206284:	0cf40363          	beq	s0,a5,ffffffffc020634a <do_wait.part.0+0x1a2>
ffffffffc0206288:	000a0663          	beqz	s4,ffffffffc0206294 <do_wait.part.0+0xec>
ffffffffc020628c:	0e842783          	lw	a5,232(s0)
ffffffffc0206290:	00fa2023          	sw	a5,0(s4)
ffffffffc0206294:	100027f3          	csrr	a5,sstatus
ffffffffc0206298:	8b89                	andi	a5,a5,2
ffffffffc020629a:	4581                	li	a1,0
ffffffffc020629c:	e7c1                	bnez	a5,ffffffffc0206324 <do_wait.part.0+0x17c>
ffffffffc020629e:	6c70                	ld	a2,216(s0)
ffffffffc02062a0:	7074                	ld	a3,224(s0)
ffffffffc02062a2:	10043703          	ld	a4,256(s0)
ffffffffc02062a6:	7c7c                	ld	a5,248(s0)
ffffffffc02062a8:	e614                	sd	a3,8(a2)
ffffffffc02062aa:	e290                	sd	a2,0(a3)
ffffffffc02062ac:	6470                	ld	a2,200(s0)
ffffffffc02062ae:	6874                	ld	a3,208(s0)
ffffffffc02062b0:	e614                	sd	a3,8(a2)
ffffffffc02062b2:	e290                	sd	a2,0(a3)
ffffffffc02062b4:	c319                	beqz	a4,ffffffffc02062ba <do_wait.part.0+0x112>
ffffffffc02062b6:	ff7c                	sd	a5,248(a4)
ffffffffc02062b8:	7c7c                	ld	a5,248(s0)
ffffffffc02062ba:	c3b5                	beqz	a5,ffffffffc020631e <do_wait.part.0+0x176>
ffffffffc02062bc:	10e7b023          	sd	a4,256(a5)
ffffffffc02062c0:	00090717          	auipc	a4,0x90
ffffffffc02062c4:	61870713          	addi	a4,a4,1560 # ffffffffc02968d8 <nr_process>
ffffffffc02062c8:	431c                	lw	a5,0(a4)
ffffffffc02062ca:	37fd                	addiw	a5,a5,-1
ffffffffc02062cc:	c31c                	sw	a5,0(a4)
ffffffffc02062ce:	e5a9                	bnez	a1,ffffffffc0206318 <do_wait.part.0+0x170>
ffffffffc02062d0:	6814                	ld	a3,16(s0)
ffffffffc02062d2:	c02007b7          	lui	a5,0xc0200
ffffffffc02062d6:	04f6ee63          	bltu	a3,a5,ffffffffc0206332 <do_wait.part.0+0x18a>
ffffffffc02062da:	00090797          	auipc	a5,0x90
ffffffffc02062de:	5de7b783          	ld	a5,1502(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02062e2:	8e9d                	sub	a3,a3,a5
ffffffffc02062e4:	82b1                	srli	a3,a3,0xc
ffffffffc02062e6:	00090797          	auipc	a5,0x90
ffffffffc02062ea:	5ba7b783          	ld	a5,1466(a5) # ffffffffc02968a0 <npage>
ffffffffc02062ee:	06f6fa63          	bgeu	a3,a5,ffffffffc0206362 <do_wait.part.0+0x1ba>
ffffffffc02062f2:	00009517          	auipc	a0,0x9
ffffffffc02062f6:	54653503          	ld	a0,1350(a0) # ffffffffc020f838 <nbase>
ffffffffc02062fa:	8e89                	sub	a3,a3,a0
ffffffffc02062fc:	069a                	slli	a3,a3,0x6
ffffffffc02062fe:	00090517          	auipc	a0,0x90
ffffffffc0206302:	5aa53503          	ld	a0,1450(a0) # ffffffffc02968a8 <pages>
ffffffffc0206306:	9536                	add	a0,a0,a3
ffffffffc0206308:	4589                	li	a1,2
ffffffffc020630a:	ef1fb0ef          	jal	ra,ffffffffc02021fa <free_pages>
ffffffffc020630e:	8522                	mv	a0,s0
ffffffffc0206310:	d7ffb0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0206314:	4501                	li	a0,0
ffffffffc0206316:	bde5                	j	ffffffffc020620e <do_wait.part.0+0x66>
ffffffffc0206318:	955fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020631c:	bf55                	j	ffffffffc02062d0 <do_wait.part.0+0x128>
ffffffffc020631e:	701c                	ld	a5,32(s0)
ffffffffc0206320:	fbf8                	sd	a4,240(a5)
ffffffffc0206322:	bf79                	j	ffffffffc02062c0 <do_wait.part.0+0x118>
ffffffffc0206324:	94ffa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206328:	4585                	li	a1,1
ffffffffc020632a:	bf95                	j	ffffffffc020629e <do_wait.part.0+0xf6>
ffffffffc020632c:	f2840413          	addi	s0,s0,-216
ffffffffc0206330:	b781                	j	ffffffffc0206270 <do_wait.part.0+0xc8>
ffffffffc0206332:	00006617          	auipc	a2,0x6
ffffffffc0206336:	25e60613          	addi	a2,a2,606 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc020633a:	07700593          	li	a1,119
ffffffffc020633e:	00006517          	auipc	a0,0x6
ffffffffc0206342:	1d250513          	addi	a0,a0,466 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0206346:	958fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020634a:	00007617          	auipc	a2,0x7
ffffffffc020634e:	20e60613          	addi	a2,a2,526 # ffffffffc020d558 <CSWTCH.79+0x180>
ffffffffc0206352:	3e800593          	li	a1,1000
ffffffffc0206356:	00007517          	auipc	a0,0x7
ffffffffc020635a:	19250513          	addi	a0,a0,402 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc020635e:	940fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206362:	00006617          	auipc	a2,0x6
ffffffffc0206366:	25660613          	addi	a2,a2,598 # ffffffffc020c5b8 <default_pmm_manager+0x108>
ffffffffc020636a:	06900593          	li	a1,105
ffffffffc020636e:	00006517          	auipc	a0,0x6
ffffffffc0206372:	1a250513          	addi	a0,a0,418 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0206376:	928fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020637a <init_main>:
ffffffffc020637a:	1141                	addi	sp,sp,-16
ffffffffc020637c:	00007517          	auipc	a0,0x7
ffffffffc0206380:	1fc50513          	addi	a0,a0,508 # ffffffffc020d578 <CSWTCH.79+0x1a0>
ffffffffc0206384:	e406                	sd	ra,8(sp)
ffffffffc0206386:	742010ef          	jal	ra,ffffffffc0207ac8 <vfs_set_bootfs>
ffffffffc020638a:	e179                	bnez	a0,ffffffffc0206450 <init_main+0xd6>
ffffffffc020638c:	eaffb0ef          	jal	ra,ffffffffc020223a <nr_free_pages>
ffffffffc0206390:	c4bfb0ef          	jal	ra,ffffffffc0201fda <kallocated>
ffffffffc0206394:	4601                	li	a2,0
ffffffffc0206396:	4581                	li	a1,0
ffffffffc0206398:	00001517          	auipc	a0,0x1
ffffffffc020639c:	96850513          	addi	a0,a0,-1688 # ffffffffc0206d00 <user_main>
ffffffffc02063a0:	c57ff0ef          	jal	ra,ffffffffc0205ff6 <kernel_thread>
ffffffffc02063a4:	00a04563          	bgtz	a0,ffffffffc02063ae <init_main+0x34>
ffffffffc02063a8:	a841                	j	ffffffffc0206438 <init_main+0xbe>
ffffffffc02063aa:	7af000ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc02063ae:	4581                	li	a1,0
ffffffffc02063b0:	4501                	li	a0,0
ffffffffc02063b2:	df7ff0ef          	jal	ra,ffffffffc02061a8 <do_wait.part.0>
ffffffffc02063b6:	d975                	beqz	a0,ffffffffc02063aa <init_main+0x30>
ffffffffc02063b8:	e57fe0ef          	jal	ra,ffffffffc020520e <fs_cleanup>
ffffffffc02063bc:	00007517          	auipc	a0,0x7
ffffffffc02063c0:	20450513          	addi	a0,a0,516 # ffffffffc020d5c0 <CSWTCH.79+0x1e8>
ffffffffc02063c4:	de3f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02063c8:	00090797          	auipc	a5,0x90
ffffffffc02063cc:	5087b783          	ld	a5,1288(a5) # ffffffffc02968d0 <initproc>
ffffffffc02063d0:	7bf8                	ld	a4,240(a5)
ffffffffc02063d2:	e339                	bnez	a4,ffffffffc0206418 <init_main+0x9e>
ffffffffc02063d4:	7ff8                	ld	a4,248(a5)
ffffffffc02063d6:	e329                	bnez	a4,ffffffffc0206418 <init_main+0x9e>
ffffffffc02063d8:	1007b703          	ld	a4,256(a5)
ffffffffc02063dc:	ef15                	bnez	a4,ffffffffc0206418 <init_main+0x9e>
ffffffffc02063de:	00090697          	auipc	a3,0x90
ffffffffc02063e2:	4fa6a683          	lw	a3,1274(a3) # ffffffffc02968d8 <nr_process>
ffffffffc02063e6:	4709                	li	a4,2
ffffffffc02063e8:	0ce69163          	bne	a3,a4,ffffffffc02064aa <init_main+0x130>
ffffffffc02063ec:	0008f717          	auipc	a4,0x8f
ffffffffc02063f0:	3d470713          	addi	a4,a4,980 # ffffffffc02957c0 <proc_list>
ffffffffc02063f4:	6714                	ld	a3,8(a4)
ffffffffc02063f6:	0c878793          	addi	a5,a5,200
ffffffffc02063fa:	08d79863          	bne	a5,a3,ffffffffc020648a <init_main+0x110>
ffffffffc02063fe:	6318                	ld	a4,0(a4)
ffffffffc0206400:	06e79563          	bne	a5,a4,ffffffffc020646a <init_main+0xf0>
ffffffffc0206404:	00007517          	auipc	a0,0x7
ffffffffc0206408:	2a450513          	addi	a0,a0,676 # ffffffffc020d6a8 <CSWTCH.79+0x2d0>
ffffffffc020640c:	d9bf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206410:	60a2                	ld	ra,8(sp)
ffffffffc0206412:	4501                	li	a0,0
ffffffffc0206414:	0141                	addi	sp,sp,16
ffffffffc0206416:	8082                	ret
ffffffffc0206418:	00007697          	auipc	a3,0x7
ffffffffc020641c:	1d068693          	addi	a3,a3,464 # ffffffffc020d5e8 <CSWTCH.79+0x210>
ffffffffc0206420:	00005617          	auipc	a2,0x5
ffffffffc0206424:	58860613          	addi	a2,a2,1416 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206428:	45e00593          	li	a1,1118
ffffffffc020642c:	00007517          	auipc	a0,0x7
ffffffffc0206430:	0bc50513          	addi	a0,a0,188 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206434:	86afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206438:	00007617          	auipc	a2,0x7
ffffffffc020643c:	16860613          	addi	a2,a2,360 # ffffffffc020d5a0 <CSWTCH.79+0x1c8>
ffffffffc0206440:	45100593          	li	a1,1105
ffffffffc0206444:	00007517          	auipc	a0,0x7
ffffffffc0206448:	0a450513          	addi	a0,a0,164 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc020644c:	852fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206450:	86aa                	mv	a3,a0
ffffffffc0206452:	00007617          	auipc	a2,0x7
ffffffffc0206456:	12e60613          	addi	a2,a2,302 # ffffffffc020d580 <CSWTCH.79+0x1a8>
ffffffffc020645a:	44900593          	li	a1,1097
ffffffffc020645e:	00007517          	auipc	a0,0x7
ffffffffc0206462:	08a50513          	addi	a0,a0,138 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206466:	838fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020646a:	00007697          	auipc	a3,0x7
ffffffffc020646e:	20e68693          	addi	a3,a3,526 # ffffffffc020d678 <CSWTCH.79+0x2a0>
ffffffffc0206472:	00005617          	auipc	a2,0x5
ffffffffc0206476:	53660613          	addi	a2,a2,1334 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020647a:	46100593          	li	a1,1121
ffffffffc020647e:	00007517          	auipc	a0,0x7
ffffffffc0206482:	06a50513          	addi	a0,a0,106 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206486:	818fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020648a:	00007697          	auipc	a3,0x7
ffffffffc020648e:	1be68693          	addi	a3,a3,446 # ffffffffc020d648 <CSWTCH.79+0x270>
ffffffffc0206492:	00005617          	auipc	a2,0x5
ffffffffc0206496:	51660613          	addi	a2,a2,1302 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020649a:	46000593          	li	a1,1120
ffffffffc020649e:	00007517          	auipc	a0,0x7
ffffffffc02064a2:	04a50513          	addi	a0,a0,74 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc02064a6:	ff9f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02064aa:	00007697          	auipc	a3,0x7
ffffffffc02064ae:	18e68693          	addi	a3,a3,398 # ffffffffc020d638 <CSWTCH.79+0x260>
ffffffffc02064b2:	00005617          	auipc	a2,0x5
ffffffffc02064b6:	4f660613          	addi	a2,a2,1270 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02064ba:	45f00593          	li	a1,1119
ffffffffc02064be:	00007517          	auipc	a0,0x7
ffffffffc02064c2:	02a50513          	addi	a0,a0,42 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc02064c6:	fd9f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02064ca <do_execve>:
ffffffffc02064ca:	d9010113          	addi	sp,sp,-624
ffffffffc02064ce:	23713423          	sd	s7,552(sp)
ffffffffc02064d2:	00090b97          	auipc	s7,0x90
ffffffffc02064d6:	3eeb8b93          	addi	s7,s7,1006 # ffffffffc02968c0 <current>
ffffffffc02064da:	000bb683          	ld	a3,0(s7)
ffffffffc02064de:	fff5871b          	addiw	a4,a1,-1
ffffffffc02064e2:	25413023          	sd	s4,576(sp)
ffffffffc02064e6:	26113423          	sd	ra,616(sp)
ffffffffc02064ea:	26813023          	sd	s0,608(sp)
ffffffffc02064ee:	24913c23          	sd	s1,600(sp)
ffffffffc02064f2:	25213823          	sd	s2,592(sp)
ffffffffc02064f6:	25313423          	sd	s3,584(sp)
ffffffffc02064fa:	23513c23          	sd	s5,568(sp)
ffffffffc02064fe:	23613823          	sd	s6,560(sp)
ffffffffc0206502:	23813023          	sd	s8,544(sp)
ffffffffc0206506:	21913c23          	sd	s9,536(sp)
ffffffffc020650a:	21a13823          	sd	s10,528(sp)
ffffffffc020650e:	21b13423          	sd	s11,520(sp)
ffffffffc0206512:	d43a                	sw	a4,40(sp)
ffffffffc0206514:	47fd                	li	a5,31
ffffffffc0206516:	0286ba03          	ld	s4,40(a3)
ffffffffc020651a:	6ee7e263          	bltu	a5,a4,ffffffffc0206bfe <do_execve+0x734>
ffffffffc020651e:	842e                	mv	s0,a1
ffffffffc0206520:	84aa                	mv	s1,a0
ffffffffc0206522:	8b32                	mv	s6,a2
ffffffffc0206524:	4581                	li	a1,0
ffffffffc0206526:	4641                	li	a2,16
ffffffffc0206528:	18a8                	addi	a0,sp,120
ffffffffc020652a:	79b040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc020652e:	000a0c63          	beqz	s4,ffffffffc0206546 <do_execve+0x7c>
ffffffffc0206532:	038a0513          	addi	a0,s4,56
ffffffffc0206536:	87efe0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020653a:	000bb783          	ld	a5,0(s7)
ffffffffc020653e:	c781                	beqz	a5,ffffffffc0206546 <do_execve+0x7c>
ffffffffc0206540:	43dc                	lw	a5,4(a5)
ffffffffc0206542:	04fa2823          	sw	a5,80(s4)
ffffffffc0206546:	24048463          	beqz	s1,ffffffffc020678e <do_execve+0x2c4>
ffffffffc020654a:	46c1                	li	a3,16
ffffffffc020654c:	8626                	mv	a2,s1
ffffffffc020654e:	18ac                	addi	a1,sp,120
ffffffffc0206550:	8552                	mv	a0,s4
ffffffffc0206552:	e8bfd0ef          	jal	ra,ffffffffc02043dc <copy_string>
ffffffffc0206556:	6a050c63          	beqz	a0,ffffffffc0206c0e <do_execve+0x744>
ffffffffc020655a:	00341793          	slli	a5,s0,0x3
ffffffffc020655e:	4681                	li	a3,0
ffffffffc0206560:	863e                	mv	a2,a5
ffffffffc0206562:	85da                	mv	a1,s6
ffffffffc0206564:	8552                	mv	a0,s4
ffffffffc0206566:	f83e                	sd	a5,48(sp)
ffffffffc0206568:	d7bfd0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc020656c:	89da                	mv	s3,s6
ffffffffc020656e:	68050c63          	beqz	a0,ffffffffc0206c06 <do_execve+0x73c>
ffffffffc0206572:	10010a93          	addi	s5,sp,256
ffffffffc0206576:	4481                	li	s1,0
ffffffffc0206578:	a011                	j	ffffffffc020657c <do_execve+0xb2>
ffffffffc020657a:	84ee                	mv	s1,s11
ffffffffc020657c:	6505                	lui	a0,0x1
ffffffffc020657e:	a61fb0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0206582:	892a                	mv	s2,a0
ffffffffc0206584:	18050263          	beqz	a0,ffffffffc0206708 <do_execve+0x23e>
ffffffffc0206588:	0009b603          	ld	a2,0(s3) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020658c:	85aa                	mv	a1,a0
ffffffffc020658e:	6685                	lui	a3,0x1
ffffffffc0206590:	8552                	mv	a0,s4
ffffffffc0206592:	e4bfd0ef          	jal	ra,ffffffffc02043dc <copy_string>
ffffffffc0206596:	1e050763          	beqz	a0,ffffffffc0206784 <do_execve+0x2ba>
ffffffffc020659a:	012ab023          	sd	s2,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020659e:	00148d9b          	addiw	s11,s1,1
ffffffffc02065a2:	0aa1                	addi	s5,s5,8
ffffffffc02065a4:	09a1                	addi	s3,s3,8
ffffffffc02065a6:	fdb41ae3          	bne	s0,s11,ffffffffc020657a <do_execve+0xb0>
ffffffffc02065aa:	000b3903          	ld	s2,0(s6)
ffffffffc02065ae:	100a0a63          	beqz	s4,ffffffffc02066c2 <do_execve+0x1f8>
ffffffffc02065b2:	038a0513          	addi	a0,s4,56
ffffffffc02065b6:	ffbfd0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc02065ba:	000bb703          	ld	a4,0(s7)
ffffffffc02065be:	040a2823          	sw	zero,80(s4)
ffffffffc02065c2:	14873503          	ld	a0,328(a4)
ffffffffc02065c6:	d25fe0ef          	jal	ra,ffffffffc02052ea <files_closeall>
ffffffffc02065ca:	4581                	li	a1,0
ffffffffc02065cc:	854a                	mv	a0,s2
ffffffffc02065ce:	fa9fe0ef          	jal	ra,ffffffffc0205576 <sysfile_open>
ffffffffc02065d2:	8b2a                	mv	s6,a0
ffffffffc02065d4:	0c054163          	bltz	a0,ffffffffc0206696 <do_execve+0x1cc>
ffffffffc02065d8:	00090717          	auipc	a4,0x90
ffffffffc02065dc:	2b873703          	ld	a4,696(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc02065e0:	56fd                	li	a3,-1
ffffffffc02065e2:	16fe                	slli	a3,a3,0x3f
ffffffffc02065e4:	8331                	srli	a4,a4,0xc
ffffffffc02065e6:	8f55                	or	a4,a4,a3
ffffffffc02065e8:	18071073          	csrw	satp,a4
ffffffffc02065ec:	030a2703          	lw	a4,48(s4)
ffffffffc02065f0:	fff7069b          	addiw	a3,a4,-1
ffffffffc02065f4:	02da2823          	sw	a3,48(s4)
ffffffffc02065f8:	3c068363          	beqz	a3,ffffffffc02069be <do_execve+0x4f4>
ffffffffc02065fc:	000bb703          	ld	a4,0(s7)
ffffffffc0206600:	02073423          	sd	zero,40(a4)
ffffffffc0206604:	e54fd0ef          	jal	ra,ffffffffc0203c58 <mm_create>
ffffffffc0206608:	8aaa                	mv	s5,a0
ffffffffc020660a:	0e050d63          	beqz	a0,ffffffffc0206704 <do_execve+0x23a>
ffffffffc020660e:	4505                	li	a0,1
ffffffffc0206610:	badfb0ef          	jal	ra,ffffffffc02021bc <alloc_pages>
ffffffffc0206614:	0e050563          	beqz	a0,ffffffffc02066fe <do_execve+0x234>
ffffffffc0206618:	00090997          	auipc	s3,0x90
ffffffffc020661c:	29098993          	addi	s3,s3,656 # ffffffffc02968a8 <pages>
ffffffffc0206620:	0009b683          	ld	a3,0(s3)
ffffffffc0206624:	00090d17          	auipc	s10,0x90
ffffffffc0206628:	27cd0d13          	addi	s10,s10,636 # ffffffffc02968a0 <npage>
ffffffffc020662c:	00009797          	auipc	a5,0x9
ffffffffc0206630:	20c7b783          	ld	a5,524(a5) # ffffffffc020f838 <nbase>
ffffffffc0206634:	40d506b3          	sub	a3,a0,a3
ffffffffc0206638:	567d                	li	a2,-1
ffffffffc020663a:	8699                	srai	a3,a3,0x6
ffffffffc020663c:	000d3703          	ld	a4,0(s10)
ffffffffc0206640:	96be                	add	a3,a3,a5
ffffffffc0206642:	ec3e                	sd	a5,24(sp)
ffffffffc0206644:	00c65793          	srli	a5,a2,0xc
ffffffffc0206648:	00f6f633          	and	a2,a3,a5
ffffffffc020664c:	e43e                	sd	a5,8(sp)
ffffffffc020664e:	06b2                	slli	a3,a3,0xc
ffffffffc0206650:	5ee67363          	bgeu	a2,a4,ffffffffc0206c36 <do_execve+0x76c>
ffffffffc0206654:	00090797          	auipc	a5,0x90
ffffffffc0206658:	26478793          	addi	a5,a5,612 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020665c:	0007b903          	ld	s2,0(a5)
ffffffffc0206660:	6605                	lui	a2,0x1
ffffffffc0206662:	00090597          	auipc	a1,0x90
ffffffffc0206666:	2365b583          	ld	a1,566(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc020666a:	9936                	add	s2,s2,a3
ffffffffc020666c:	854a                	mv	a0,s2
ffffffffc020666e:	6a9040ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc0206672:	4601                	li	a2,0
ffffffffc0206674:	012abc23          	sd	s2,24(s5)
ffffffffc0206678:	4581                	li	a1,0
ffffffffc020667a:	855a                	mv	a0,s6
ffffffffc020667c:	960ff0ef          	jal	ra,ffffffffc02057dc <sysfile_seek>
ffffffffc0206680:	8c2a                	mv	s8,a0
ffffffffc0206682:	12050263          	beqz	a0,ffffffffc02067a6 <do_execve+0x2dc>
ffffffffc0206686:	018ab503          	ld	a0,24(s5)
ffffffffc020668a:	8b62                	mv	s6,s8
ffffffffc020668c:	c40ff0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc0206690:	8556                	mv	a0,s5
ffffffffc0206692:	f14fd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0206696:	77c2                	ld	a5,48(sp)
ffffffffc0206698:	1984                	addi	s1,sp,240
ffffffffc020669a:	147d                	addi	s0,s0,-1
ffffffffc020669c:	94be                	add	s1,s1,a5
ffffffffc020669e:	77a2                	ld	a5,40(sp)
ffffffffc02066a0:	040e                	slli	s0,s0,0x3
ffffffffc02066a2:	02079713          	slli	a4,a5,0x20
ffffffffc02066a6:	01d75793          	srli	a5,a4,0x1d
ffffffffc02066aa:	0218                	addi	a4,sp,256
ffffffffc02066ac:	943a                	add	s0,s0,a4
ffffffffc02066ae:	8c9d                	sub	s1,s1,a5
ffffffffc02066b0:	6008                	ld	a0,0(s0)
ffffffffc02066b2:	1461                	addi	s0,s0,-8
ffffffffc02066b4:	9dbfb0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc02066b8:	fe941ce3          	bne	s0,s1,ffffffffc02066b0 <do_execve+0x1e6>
ffffffffc02066bc:	855a                	mv	a0,s6
ffffffffc02066be:	989ff0ef          	jal	ra,ffffffffc0206046 <do_exit>
ffffffffc02066c2:	000bb703          	ld	a4,0(s7)
ffffffffc02066c6:	14873503          	ld	a0,328(a4)
ffffffffc02066ca:	c21fe0ef          	jal	ra,ffffffffc02052ea <files_closeall>
ffffffffc02066ce:	4581                	li	a1,0
ffffffffc02066d0:	854a                	mv	a0,s2
ffffffffc02066d2:	ea5fe0ef          	jal	ra,ffffffffc0205576 <sysfile_open>
ffffffffc02066d6:	8b2a                	mv	s6,a0
ffffffffc02066d8:	fa054fe3          	bltz	a0,ffffffffc0206696 <do_execve+0x1cc>
ffffffffc02066dc:	000bb703          	ld	a4,0(s7)
ffffffffc02066e0:	7718                	ld	a4,40(a4)
ffffffffc02066e2:	f20701e3          	beqz	a4,ffffffffc0206604 <do_execve+0x13a>
ffffffffc02066e6:	00007617          	auipc	a2,0x7
ffffffffc02066ea:	ff260613          	addi	a2,a2,-14 # ffffffffc020d6d8 <CSWTCH.79+0x300>
ffffffffc02066ee:	27f00593          	li	a1,639
ffffffffc02066f2:	00007517          	auipc	a0,0x7
ffffffffc02066f6:	df650513          	addi	a0,a0,-522 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc02066fa:	da5f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02066fe:	8556                	mv	a0,s5
ffffffffc0206700:	ea6fd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0206704:	5b71                	li	s6,-4
ffffffffc0206706:	bf41                	j	ffffffffc0206696 <do_execve+0x1cc>
ffffffffc0206708:	5c71                	li	s8,-4
ffffffffc020670a:	c49d                	beqz	s1,ffffffffc0206738 <do_execve+0x26e>
ffffffffc020670c:	00349713          	slli	a4,s1,0x3
ffffffffc0206710:	fff48413          	addi	s0,s1,-1
ffffffffc0206714:	199c                	addi	a5,sp,240
ffffffffc0206716:	34fd                	addiw	s1,s1,-1
ffffffffc0206718:	97ba                	add	a5,a5,a4
ffffffffc020671a:	02049713          	slli	a4,s1,0x20
ffffffffc020671e:	01d75493          	srli	s1,a4,0x1d
ffffffffc0206722:	040e                	slli	s0,s0,0x3
ffffffffc0206724:	0218                	addi	a4,sp,256
ffffffffc0206726:	943a                	add	s0,s0,a4
ffffffffc0206728:	409784b3          	sub	s1,a5,s1
ffffffffc020672c:	6008                	ld	a0,0(s0)
ffffffffc020672e:	1461                	addi	s0,s0,-8
ffffffffc0206730:	95ffb0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0206734:	fe849ce3          	bne	s1,s0,ffffffffc020672c <do_execve+0x262>
ffffffffc0206738:	000a0863          	beqz	s4,ffffffffc0206748 <do_execve+0x27e>
ffffffffc020673c:	038a0513          	addi	a0,s4,56
ffffffffc0206740:	e71fd0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0206744:	040a2823          	sw	zero,80(s4)
ffffffffc0206748:	26813083          	ld	ra,616(sp)
ffffffffc020674c:	26013403          	ld	s0,608(sp)
ffffffffc0206750:	25813483          	ld	s1,600(sp)
ffffffffc0206754:	25013903          	ld	s2,592(sp)
ffffffffc0206758:	24813983          	ld	s3,584(sp)
ffffffffc020675c:	24013a03          	ld	s4,576(sp)
ffffffffc0206760:	23813a83          	ld	s5,568(sp)
ffffffffc0206764:	23013b03          	ld	s6,560(sp)
ffffffffc0206768:	22813b83          	ld	s7,552(sp)
ffffffffc020676c:	21813c83          	ld	s9,536(sp)
ffffffffc0206770:	21013d03          	ld	s10,528(sp)
ffffffffc0206774:	20813d83          	ld	s11,520(sp)
ffffffffc0206778:	8562                	mv	a0,s8
ffffffffc020677a:	22013c03          	ld	s8,544(sp)
ffffffffc020677e:	27010113          	addi	sp,sp,624
ffffffffc0206782:	8082                	ret
ffffffffc0206784:	854a                	mv	a0,s2
ffffffffc0206786:	909fb0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020678a:	5c75                	li	s8,-3
ffffffffc020678c:	bfbd                	j	ffffffffc020670a <do_execve+0x240>
ffffffffc020678e:	000bb783          	ld	a5,0(s7)
ffffffffc0206792:	00007617          	auipc	a2,0x7
ffffffffc0206796:	f3660613          	addi	a2,a2,-202 # ffffffffc020d6c8 <CSWTCH.79+0x2f0>
ffffffffc020679a:	45c1                	li	a1,16
ffffffffc020679c:	43d4                	lw	a3,4(a5)
ffffffffc020679e:	18a8                	addi	a0,sp,120
ffffffffc02067a0:	435040ef          	jal	ra,ffffffffc020b3d4 <snprintf>
ffffffffc02067a4:	bb5d                	j	ffffffffc020655a <do_execve+0x90>
ffffffffc02067a6:	04000613          	li	a2,64
ffffffffc02067aa:	018c                	addi	a1,sp,192
ffffffffc02067ac:	855a                	mv	a0,s6
ffffffffc02067ae:	e01fe0ef          	jal	ra,ffffffffc02055ae <sysfile_read>
ffffffffc02067b2:	04000713          	li	a4,64
ffffffffc02067b6:	00e50863          	beq	a0,a4,ffffffffc02067c6 <do_execve+0x2fc>
ffffffffc02067ba:	00050c1b          	sext.w	s8,a0
ffffffffc02067be:	ec0544e3          	bltz	a0,ffffffffc0206686 <do_execve+0x1bc>
ffffffffc02067c2:	5c7d                	li	s8,-1
ffffffffc02067c4:	b5c9                	j	ffffffffc0206686 <do_execve+0x1bc>
ffffffffc02067c6:	468e                	lw	a3,192(sp)
ffffffffc02067c8:	464c4737          	lui	a4,0x464c4
ffffffffc02067cc:	57f70713          	addi	a4,a4,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc02067d0:	2ee69e63          	bne	a3,a4,ffffffffc0206acc <do_execve+0x602>
ffffffffc02067d4:	0f815703          	lhu	a4,248(sp)
ffffffffc02067d8:	c749                	beqz	a4,ffffffffc0206862 <do_execve+0x398>
ffffffffc02067da:	e882                	sd	zero,80(sp)
ffffffffc02067dc:	e482                	sd	zero,72(sp)
ffffffffc02067de:	e802                	sd	zero,16(sp)
ffffffffc02067e0:	f0ee                	sd	s11,96(sp)
ffffffffc02067e2:	f4a6                	sd	s1,104(sp)
ffffffffc02067e4:	ece2                	sd	s8,88(sp)
ffffffffc02067e6:	e0a2                	sd	s0,64(sp)
ffffffffc02067e8:	758e                	ld	a1,224(sp)
ffffffffc02067ea:	67a6                	ld	a5,72(sp)
ffffffffc02067ec:	4601                	li	a2,0
ffffffffc02067ee:	855a                	mv	a0,s6
ffffffffc02067f0:	95be                	add	a1,a1,a5
ffffffffc02067f2:	febfe0ef          	jal	ra,ffffffffc02057dc <sysfile_seek>
ffffffffc02067f6:	e02a                	sd	a0,0(sp)
ffffffffc02067f8:	e121                	bnez	a0,ffffffffc0206838 <do_execve+0x36e>
ffffffffc02067fa:	03800613          	li	a2,56
ffffffffc02067fe:	012c                	addi	a1,sp,136
ffffffffc0206800:	855a                	mv	a0,s6
ffffffffc0206802:	dadfe0ef          	jal	ra,ffffffffc02055ae <sysfile_read>
ffffffffc0206806:	03800793          	li	a5,56
ffffffffc020680a:	02f50963          	beq	a0,a5,ffffffffc020683c <do_execve+0x372>
ffffffffc020680e:	6406                	ld	s0,64(sp)
ffffffffc0206810:	8a2a                	mv	s4,a0
ffffffffc0206812:	00054363          	bltz	a0,ffffffffc0206818 <do_execve+0x34e>
ffffffffc0206816:	5a7d                	li	s4,-1
ffffffffc0206818:	000a079b          	sext.w	a5,s4
ffffffffc020681c:	e03e                	sd	a5,0(sp)
ffffffffc020681e:	8556                	mv	a0,s5
ffffffffc0206820:	f22fd0ef          	jal	ra,ffffffffc0203f42 <exit_mmap>
ffffffffc0206824:	018ab503          	ld	a0,24(s5)
ffffffffc0206828:	6b02                	ld	s6,0(sp)
ffffffffc020682a:	aa2ff0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc020682e:	8556                	mv	a0,s5
ffffffffc0206830:	d76fd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0206834:	b58d                	j	ffffffffc0206696 <do_execve+0x1cc>
ffffffffc0206836:	6ac2                	ld	s5,16(sp)
ffffffffc0206838:	6406                	ld	s0,64(sp)
ffffffffc020683a:	b7d5                	j	ffffffffc020681e <do_execve+0x354>
ffffffffc020683c:	47aa                	lw	a5,136(sp)
ffffffffc020683e:	4705                	li	a4,1
ffffffffc0206840:	18e78a63          	beq	a5,a4,ffffffffc02069d4 <do_execve+0x50a>
ffffffffc0206844:	6746                	ld	a4,80(sp)
ffffffffc0206846:	66a6                	ld	a3,72(sp)
ffffffffc0206848:	0f815783          	lhu	a5,248(sp)
ffffffffc020684c:	2705                	addiw	a4,a4,1
ffffffffc020684e:	03868693          	addi	a3,a3,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc0206852:	e8ba                	sd	a4,80(sp)
ffffffffc0206854:	e4b6                	sd	a3,72(sp)
ffffffffc0206856:	f8f749e3          	blt	a4,a5,ffffffffc02067e8 <do_execve+0x31e>
ffffffffc020685a:	7d86                	ld	s11,96(sp)
ffffffffc020685c:	74a6                	ld	s1,104(sp)
ffffffffc020685e:	6c66                	ld	s8,88(sp)
ffffffffc0206860:	6406                	ld	s0,64(sp)
ffffffffc0206862:	4701                	li	a4,0
ffffffffc0206864:	46ad                	li	a3,11
ffffffffc0206866:	00100637          	lui	a2,0x100
ffffffffc020686a:	7ff005b7          	lui	a1,0x7ff00
ffffffffc020686e:	8556                	mv	a0,s5
ffffffffc0206870:	d88fd0ef          	jal	ra,ffffffffc0203df8 <mm_map>
ffffffffc0206874:	e02a                	sd	a0,0(sp)
ffffffffc0206876:	f545                	bnez	a0,ffffffffc020681e <do_execve+0x354>
ffffffffc0206878:	018ab503          	ld	a0,24(s5)
ffffffffc020687c:	467d                	li	a2,31
ffffffffc020687e:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0206882:	af0fd0ef          	jal	ra,ffffffffc0203b72 <pgdir_alloc_page>
ffffffffc0206886:	44050d63          	beqz	a0,ffffffffc0206ce0 <do_execve+0x816>
ffffffffc020688a:	018ab503          	ld	a0,24(s5)
ffffffffc020688e:	467d                	li	a2,31
ffffffffc0206890:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0206894:	adefd0ef          	jal	ra,ffffffffc0203b72 <pgdir_alloc_page>
ffffffffc0206898:	42050463          	beqz	a0,ffffffffc0206cc0 <do_execve+0x7f6>
ffffffffc020689c:	018ab503          	ld	a0,24(s5)
ffffffffc02068a0:	467d                	li	a2,31
ffffffffc02068a2:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02068a6:	accfd0ef          	jal	ra,ffffffffc0203b72 <pgdir_alloc_page>
ffffffffc02068aa:	3e050b63          	beqz	a0,ffffffffc0206ca0 <do_execve+0x7d6>
ffffffffc02068ae:	018ab503          	ld	a0,24(s5)
ffffffffc02068b2:	467d                	li	a2,31
ffffffffc02068b4:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02068b8:	abafd0ef          	jal	ra,ffffffffc0203b72 <pgdir_alloc_page>
ffffffffc02068bc:	3c050263          	beqz	a0,ffffffffc0206c80 <do_execve+0x7b6>
ffffffffc02068c0:	030aa703          	lw	a4,48(s5)
ffffffffc02068c4:	000bb603          	ld	a2,0(s7)
ffffffffc02068c8:	018ab683          	ld	a3,24(s5)
ffffffffc02068cc:	2705                	addiw	a4,a4,1
ffffffffc02068ce:	02eaa823          	sw	a4,48(s5)
ffffffffc02068d2:	03563423          	sd	s5,40(a2) # 100028 <_binary_bin_sfs_img_size+0x8ad28>
ffffffffc02068d6:	c0200737          	lui	a4,0xc0200
ffffffffc02068da:	38e6e763          	bltu	a3,a4,ffffffffc0206c68 <do_execve+0x79e>
ffffffffc02068de:	00090797          	auipc	a5,0x90
ffffffffc02068e2:	fda78793          	addi	a5,a5,-38 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02068e6:	6398                	ld	a4,0(a5)
ffffffffc02068e8:	8e99                	sub	a3,a3,a4
ffffffffc02068ea:	00c6d713          	srli	a4,a3,0xc
ffffffffc02068ee:	f654                	sd	a3,168(a2)
ffffffffc02068f0:	56fd                	li	a3,-1
ffffffffc02068f2:	16fe                	slli	a3,a3,0x3f
ffffffffc02068f4:	8f55                	or	a4,a4,a3
ffffffffc02068f6:	18071073          	csrw	satp,a4
ffffffffc02068fa:	10000937          	lui	s2,0x10000
ffffffffc02068fe:	0024871b          	addiw	a4,s1,2
ffffffffc0206902:	00cd999b          	slliw	s3,s11,0xc
ffffffffc0206906:	40e90933          	sub	s2,s2,a4
ffffffffc020690a:	090e                	slli	s2,s2,0x3
ffffffffc020690c:	41b987bb          	subw	a5,s3,s11
ffffffffc0206910:	6d02                	ld	s10,0(sp)
ffffffffc0206912:	40f909b3          	sub	s3,s2,a5
ffffffffc0206916:	10010c93          	addi	s9,sp,256
ffffffffc020691a:	6a85                	lui	s5,0x1
ffffffffc020691c:	8a4e                	mv	s4,s3
ffffffffc020691e:	41990b33          	sub	s6,s2,s9
ffffffffc0206922:	1afd                	addi	s5,s5,-1
ffffffffc0206924:	000cb583          	ld	a1,0(s9)
ffffffffc0206928:	8552                	mv	a0,s4
ffffffffc020692a:	9a56                	add	s4,s4,s5
ffffffffc020692c:	32d040ef          	jal	ra,ffffffffc020b458 <strcpy>
ffffffffc0206930:	019b0733          	add	a4,s6,s9
ffffffffc0206934:	87ea                	mv	a5,s10
ffffffffc0206936:	e308                	sd	a0,0(a4)
ffffffffc0206938:	2d05                	addiw	s10,s10,1
ffffffffc020693a:	0ca1                	addi	s9,s9,8
ffffffffc020693c:	fe97c4e3          	blt	a5,s1,ffffffffc0206924 <do_execve+0x45a>
ffffffffc0206940:	000bb783          	ld	a5,0(s7)
ffffffffc0206944:	7742                	ld	a4,48(sp)
ffffffffc0206946:	12000613          	li	a2,288
ffffffffc020694a:	73c4                	ld	s1,160(a5)
ffffffffc020694c:	974a                	add	a4,a4,s2
ffffffffc020694e:	00073023          	sd	zero,0(a4) # ffffffffc0200000 <kern_entry>
ffffffffc0206952:	1004ba03          	ld	s4,256(s1)
ffffffffc0206956:	4581                	li	a1,0
ffffffffc0206958:	8526                	mv	a0,s1
ffffffffc020695a:	36b040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc020695e:	676e                	ld	a4,216(sp)
ffffffffc0206960:	edfa7793          	andi	a5,s4,-289
ffffffffc0206964:	0207e793          	ori	a5,a5,32
ffffffffc0206968:	0134b823          	sd	s3,16(s1)
ffffffffc020696c:	10e4b423          	sd	a4,264(s1)
ffffffffc0206970:	10f4b023          	sd	a5,256(s1)
ffffffffc0206974:	e8a0                	sd	s0,80(s1)
ffffffffc0206976:	0524bc23          	sd	s2,88(s1)
ffffffffc020697a:	77c2                	ld	a5,48(sp)
ffffffffc020697c:	1984                	addi	s1,sp,240
ffffffffc020697e:	147d                	addi	s0,s0,-1
ffffffffc0206980:	94be                	add	s1,s1,a5
ffffffffc0206982:	77a2                	ld	a5,40(sp)
ffffffffc0206984:	040e                	slli	s0,s0,0x3
ffffffffc0206986:	02079713          	slli	a4,a5,0x20
ffffffffc020698a:	01d75793          	srli	a5,a4,0x1d
ffffffffc020698e:	0218                	addi	a4,sp,256
ffffffffc0206990:	943a                	add	s0,s0,a4
ffffffffc0206992:	8c9d                	sub	s1,s1,a5
ffffffffc0206994:	6008                	ld	a0,0(s0)
ffffffffc0206996:	1461                	addi	s0,s0,-8
ffffffffc0206998:	ef6fb0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020699c:	fe941ce3          	bne	s0,s1,ffffffffc0206994 <do_execve+0x4ca>
ffffffffc02069a0:	000bb403          	ld	s0,0(s7)
ffffffffc02069a4:	4641                	li	a2,16
ffffffffc02069a6:	4581                	li	a1,0
ffffffffc02069a8:	0b440413          	addi	s0,s0,180
ffffffffc02069ac:	8522                	mv	a0,s0
ffffffffc02069ae:	317040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc02069b2:	463d                	li	a2,15
ffffffffc02069b4:	18ac                	addi	a1,sp,120
ffffffffc02069b6:	8522                	mv	a0,s0
ffffffffc02069b8:	35f040ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc02069bc:	b371                	j	ffffffffc0206748 <do_execve+0x27e>
ffffffffc02069be:	8552                	mv	a0,s4
ffffffffc02069c0:	d82fd0ef          	jal	ra,ffffffffc0203f42 <exit_mmap>
ffffffffc02069c4:	018a3503          	ld	a0,24(s4)
ffffffffc02069c8:	904ff0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc02069cc:	8552                	mv	a0,s4
ffffffffc02069ce:	bd8fd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc02069d2:	b12d                	j	ffffffffc02065fc <do_execve+0x132>
ffffffffc02069d4:	764a                	ld	a2,176(sp)
ffffffffc02069d6:	77aa                	ld	a5,168(sp)
ffffffffc02069d8:	24f66a63          	bltu	a2,a5,ffffffffc0206c2c <do_execve+0x762>
ffffffffc02069dc:	47ba                	lw	a5,140(sp)
ffffffffc02069de:	0017f693          	andi	a3,a5,1
ffffffffc02069e2:	c291                	beqz	a3,ffffffffc02069e6 <do_execve+0x51c>
ffffffffc02069e4:	4691                	li	a3,4
ffffffffc02069e6:	0027f713          	andi	a4,a5,2
ffffffffc02069ea:	8b91                	andi	a5,a5,4
ffffffffc02069ec:	cf5d                	beqz	a4,ffffffffc0206aaa <do_execve+0x5e0>
ffffffffc02069ee:	0026e693          	ori	a3,a3,2
ffffffffc02069f2:	efdd                	bnez	a5,ffffffffc0206ab0 <do_execve+0x5e6>
ffffffffc02069f4:	47dd                	li	a5,23
ffffffffc02069f6:	fc3e                	sd	a5,56(sp)
ffffffffc02069f8:	0046f793          	andi	a5,a3,4
ffffffffc02069fc:	c789                	beqz	a5,ffffffffc0206a06 <do_execve+0x53c>
ffffffffc02069fe:	77e2                	ld	a5,56(sp)
ffffffffc0206a00:	0087e793          	ori	a5,a5,8
ffffffffc0206a04:	fc3e                	sd	a5,56(sp)
ffffffffc0206a06:	65ea                	ld	a1,152(sp)
ffffffffc0206a08:	4701                	li	a4,0
ffffffffc0206a0a:	8556                	mv	a0,s5
ffffffffc0206a0c:	becfd0ef          	jal	ra,ffffffffc0203df8 <mm_map>
ffffffffc0206a10:	e02a                	sd	a0,0(sp)
ffffffffc0206a12:	e20513e3          	bnez	a0,ffffffffc0206838 <do_execve+0x36e>
ffffffffc0206a16:	646a                	ld	s0,152(sp)
ffffffffc0206a18:	7caa                	ld	s9,168(sp)
ffffffffc0206a1a:	77fd                	lui	a5,0xfffff
ffffffffc0206a1c:	6c4a                	ld	s8,144(sp)
ffffffffc0206a1e:	01940a33          	add	s4,s0,s9
ffffffffc0206a22:	00f474b3          	and	s1,s0,a5
ffffffffc0206a26:	1f447e63          	bgeu	s0,s4,ffffffffc0206c22 <do_execve+0x758>
ffffffffc0206a2a:	57f1                	li	a5,-4
ffffffffc0206a2c:	e03e                	sd	a5,0(sp)
ffffffffc0206a2e:	8ca6                	mv	s9,s1
ffffffffc0206a30:	e856                	sd	s5,16(sp)
ffffffffc0206a32:	67c2                	ld	a5,16(sp)
ffffffffc0206a34:	7662                	ld	a2,56(sp)
ffffffffc0206a36:	85e6                	mv	a1,s9
ffffffffc0206a38:	6f88                	ld	a0,24(a5)
ffffffffc0206a3a:	938fd0ef          	jal	ra,ffffffffc0203b72 <pgdir_alloc_page>
ffffffffc0206a3e:	84aa                	mv	s1,a0
ffffffffc0206a40:	cd59                	beqz	a0,ffffffffc0206ade <do_execve+0x614>
ffffffffc0206a42:	6785                	lui	a5,0x1
ffffffffc0206a44:	00fc8db3          	add	s11,s9,a5
ffffffffc0206a48:	408d8ab3          	sub	s5,s11,s0
ffffffffc0206a4c:	01ba7463          	bgeu	s4,s11,ffffffffc0206a54 <do_execve+0x58a>
ffffffffc0206a50:	408a0ab3          	sub	s5,s4,s0
ffffffffc0206a54:	0009b903          	ld	s2,0(s3)
ffffffffc0206a58:	67e2                	ld	a5,24(sp)
ffffffffc0206a5a:	000d3603          	ld	a2,0(s10)
ffffffffc0206a5e:	41248933          	sub	s2,s1,s2
ffffffffc0206a62:	40695913          	srai	s2,s2,0x6
ffffffffc0206a66:	993e                	add	s2,s2,a5
ffffffffc0206a68:	67a2                	ld	a5,8(sp)
ffffffffc0206a6a:	00f975b3          	and	a1,s2,a5
ffffffffc0206a6e:	0932                	slli	s2,s2,0xc
ffffffffc0206a70:	1cc5f263          	bgeu	a1,a2,ffffffffc0206c34 <do_execve+0x76a>
ffffffffc0206a74:	00090797          	auipc	a5,0x90
ffffffffc0206a78:	e4478793          	addi	a5,a5,-444 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206a7c:	639c                	ld	a5,0(a5)
ffffffffc0206a7e:	4601                	li	a2,0
ffffffffc0206a80:	85e2                	mv	a1,s8
ffffffffc0206a82:	855a                	mv	a0,s6
ffffffffc0206a84:	f03e                	sd	a5,32(sp)
ffffffffc0206a86:	d57fe0ef          	jal	ra,ffffffffc02057dc <sysfile_seek>
ffffffffc0206a8a:	e02a                	sd	a0,0(sp)
ffffffffc0206a8c:	da0515e3          	bnez	a0,ffffffffc0206836 <do_execve+0x36c>
ffffffffc0206a90:	7782                	ld	a5,32(sp)
ffffffffc0206a92:	419405b3          	sub	a1,s0,s9
ffffffffc0206a96:	8656                	mv	a2,s5
ffffffffc0206a98:	993e                	add	s2,s2,a5
ffffffffc0206a9a:	95ca                	add	a1,a1,s2
ffffffffc0206a9c:	855a                	mv	a0,s6
ffffffffc0206a9e:	b11fe0ef          	jal	ra,ffffffffc02055ae <sysfile_read>
ffffffffc0206aa2:	00aa8f63          	beq	s5,a0,ffffffffc0206ac0 <do_execve+0x5f6>
ffffffffc0206aa6:	6ac2                	ld	s5,16(sp)
ffffffffc0206aa8:	b39d                	j	ffffffffc020680e <do_execve+0x344>
ffffffffc0206aaa:	4745                	li	a4,17
ffffffffc0206aac:	fc3a                	sd	a4,56(sp)
ffffffffc0206aae:	c789                	beqz	a5,ffffffffc0206ab8 <do_execve+0x5ee>
ffffffffc0206ab0:	47cd                	li	a5,19
ffffffffc0206ab2:	0016e693          	ori	a3,a3,1
ffffffffc0206ab6:	fc3e                	sd	a5,56(sp)
ffffffffc0206ab8:	0026f793          	andi	a5,a3,2
ffffffffc0206abc:	df95                	beqz	a5,ffffffffc02069f8 <do_execve+0x52e>
ffffffffc0206abe:	bf1d                	j	ffffffffc02069f4 <do_execve+0x52a>
ffffffffc0206ac0:	9456                	add	s0,s0,s5
ffffffffc0206ac2:	9c56                	add	s8,s8,s5
ffffffffc0206ac4:	03447f63          	bgeu	s0,s4,ffffffffc0206b02 <do_execve+0x638>
ffffffffc0206ac8:	8cee                	mv	s9,s11
ffffffffc0206aca:	b7a5                	j	ffffffffc0206a32 <do_execve+0x568>
ffffffffc0206acc:	018ab503          	ld	a0,24(s5) # 1018 <_binary_bin_swap_img_size-0x6ce8>
ffffffffc0206ad0:	5b61                	li	s6,-8
ffffffffc0206ad2:	ffbfe0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc0206ad6:	8556                	mv	a0,s5
ffffffffc0206ad8:	acefd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0206adc:	be6d                	j	ffffffffc0206696 <do_execve+0x1cc>
ffffffffc0206ade:	6ac2                	ld	s5,16(sp)
ffffffffc0206ae0:	6c66                	ld	s8,88(sp)
ffffffffc0206ae2:	6406                	ld	s0,64(sp)
ffffffffc0206ae4:	8556                	mv	a0,s5
ffffffffc0206ae6:	c5cfd0ef          	jal	ra,ffffffffc0203f42 <exit_mmap>
ffffffffc0206aea:	018ab503          	ld	a0,24(s5)
ffffffffc0206aee:	fdffe0ef          	jal	ra,ffffffffc0205acc <put_pgdir.isra.0>
ffffffffc0206af2:	8556                	mv	a0,s5
ffffffffc0206af4:	ab2fd0ef          	jal	ra,ffffffffc0203da6 <mm_destroy>
ffffffffc0206af8:	6782                	ld	a5,0(sp)
ffffffffc0206afa:	e80780e3          	beqz	a5,ffffffffc020697a <do_execve+0x4b0>
ffffffffc0206afe:	6b02                	ld	s6,0(sp)
ffffffffc0206b00:	be59                	j	ffffffffc0206696 <do_execve+0x1cc>
ffffffffc0206b02:	67ea                	ld	a5,152(sp)
ffffffffc0206b04:	6ac2                	ld	s5,16(sp)
ffffffffc0206b06:	e826                	sd	s1,16(sp)
ffffffffc0206b08:	76ca                	ld	a3,176(sp)
ffffffffc0206b0a:	00d784b3          	add	s1,a5,a3
ffffffffc0206b0e:	09b47463          	bgeu	s0,s11,ffffffffc0206b96 <do_execve+0x6cc>
ffffffffc0206b12:	d28489e3          	beq	s1,s0,ffffffffc0206844 <do_execve+0x37a>
ffffffffc0206b16:	6785                	lui	a5,0x1
ffffffffc0206b18:	00f40533          	add	a0,s0,a5
ffffffffc0206b1c:	41b50533          	sub	a0,a0,s11
ffffffffc0206b20:	40848933          	sub	s2,s1,s0
ffffffffc0206b24:	01b4e463          	bltu	s1,s11,ffffffffc0206b2c <do_execve+0x662>
ffffffffc0206b28:	408d8933          	sub	s2,s11,s0
ffffffffc0206b2c:	67c2                	ld	a5,16(sp)
ffffffffc0206b2e:	0009b683          	ld	a3,0(s3)
ffffffffc0206b32:	000d3603          	ld	a2,0(s10)
ffffffffc0206b36:	40d786b3          	sub	a3,a5,a3
ffffffffc0206b3a:	67e2                	ld	a5,24(sp)
ffffffffc0206b3c:	8699                	srai	a3,a3,0x6
ffffffffc0206b3e:	96be                	add	a3,a3,a5
ffffffffc0206b40:	67a2                	ld	a5,8(sp)
ffffffffc0206b42:	00f6f5b3          	and	a1,a3,a5
ffffffffc0206b46:	06b2                	slli	a3,a3,0xc
ffffffffc0206b48:	0ec5f763          	bgeu	a1,a2,ffffffffc0206c36 <do_execve+0x76c>
ffffffffc0206b4c:	00090797          	auipc	a5,0x90
ffffffffc0206b50:	d6c78793          	addi	a5,a5,-660 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206b54:	0007b803          	ld	a6,0(a5)
ffffffffc0206b58:	864a                	mv	a2,s2
ffffffffc0206b5a:	4581                	li	a1,0
ffffffffc0206b5c:	96c2                	add	a3,a3,a6
ffffffffc0206b5e:	9536                	add	a0,a0,a3
ffffffffc0206b60:	165040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0206b64:	008907b3          	add	a5,s2,s0
ffffffffc0206b68:	03b4f463          	bgeu	s1,s11,ffffffffc0206b90 <do_execve+0x6c6>
ffffffffc0206b6c:	ccf48ce3          	beq	s1,a5,ffffffffc0206844 <do_execve+0x37a>
ffffffffc0206b70:	00007697          	auipc	a3,0x7
ffffffffc0206b74:	b9068693          	addi	a3,a3,-1136 # ffffffffc020d700 <CSWTCH.79+0x328>
ffffffffc0206b78:	00005617          	auipc	a2,0x5
ffffffffc0206b7c:	e3060613          	addi	a2,a2,-464 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206b80:	2ec00593          	li	a1,748
ffffffffc0206b84:	00007517          	auipc	a0,0x7
ffffffffc0206b88:	96450513          	addi	a0,a0,-1692 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206b8c:	913f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b90:	ffb790e3          	bne	a5,s11,ffffffffc0206b70 <do_execve+0x6a6>
ffffffffc0206b94:	846e                	mv	s0,s11
ffffffffc0206b96:	ca9477e3          	bgeu	s0,s1,ffffffffc0206844 <do_execve+0x37a>
ffffffffc0206b9a:	7962                	ld	s2,56(sp)
ffffffffc0206b9c:	6c62                	ld	s8,24(sp)
ffffffffc0206b9e:	a0a9                	j	ffffffffc0206be8 <do_execve+0x71e>
ffffffffc0206ba0:	6785                	lui	a5,0x1
ffffffffc0206ba2:	41b40533          	sub	a0,s0,s11
ffffffffc0206ba6:	9dbe                	add	s11,s11,a5
ffffffffc0206ba8:	408d8633          	sub	a2,s11,s0
ffffffffc0206bac:	01b4f463          	bgeu	s1,s11,ffffffffc0206bb4 <do_execve+0x6ea>
ffffffffc0206bb0:	40848633          	sub	a2,s1,s0
ffffffffc0206bb4:	0009b783          	ld	a5,0(s3)
ffffffffc0206bb8:	66a2                	ld	a3,8(sp)
ffffffffc0206bba:	000d3703          	ld	a4,0(s10)
ffffffffc0206bbe:	40fa07b3          	sub	a5,s4,a5
ffffffffc0206bc2:	8799                	srai	a5,a5,0x6
ffffffffc0206bc4:	97e2                	add	a5,a5,s8
ffffffffc0206bc6:	8efd                	and	a3,a3,a5
ffffffffc0206bc8:	07b2                	slli	a5,a5,0xc
ffffffffc0206bca:	08e6f263          	bgeu	a3,a4,ffffffffc0206c4e <do_execve+0x784>
ffffffffc0206bce:	00090717          	auipc	a4,0x90
ffffffffc0206bd2:	cea70713          	addi	a4,a4,-790 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206bd6:	6318                	ld	a4,0(a4)
ffffffffc0206bd8:	9432                	add	s0,s0,a2
ffffffffc0206bda:	4581                	li	a1,0
ffffffffc0206bdc:	97ba                	add	a5,a5,a4
ffffffffc0206bde:	953e                	add	a0,a0,a5
ffffffffc0206be0:	0e5040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0206be4:	00947f63          	bgeu	s0,s1,ffffffffc0206c02 <do_execve+0x738>
ffffffffc0206be8:	018ab503          	ld	a0,24(s5)
ffffffffc0206bec:	864a                	mv	a2,s2
ffffffffc0206bee:	85ee                	mv	a1,s11
ffffffffc0206bf0:	f83fc0ef          	jal	ra,ffffffffc0203b72 <pgdir_alloc_page>
ffffffffc0206bf4:	8a2a                	mv	s4,a0
ffffffffc0206bf6:	f54d                	bnez	a0,ffffffffc0206ba0 <do_execve+0x6d6>
ffffffffc0206bf8:	6c66                	ld	s8,88(sp)
ffffffffc0206bfa:	6406                	ld	s0,64(sp)
ffffffffc0206bfc:	b5e5                	j	ffffffffc0206ae4 <do_execve+0x61a>
ffffffffc0206bfe:	5c75                	li	s8,-3
ffffffffc0206c00:	b6a1                	j	ffffffffc0206748 <do_execve+0x27e>
ffffffffc0206c02:	e852                	sd	s4,16(sp)
ffffffffc0206c04:	b181                	j	ffffffffc0206844 <do_execve+0x37a>
ffffffffc0206c06:	5c75                	li	s8,-3
ffffffffc0206c08:	b20a1ae3          	bnez	s4,ffffffffc020673c <do_execve+0x272>
ffffffffc0206c0c:	be35                	j	ffffffffc0206748 <do_execve+0x27e>
ffffffffc0206c0e:	fe0a08e3          	beqz	s4,ffffffffc0206bfe <do_execve+0x734>
ffffffffc0206c12:	038a0513          	addi	a0,s4,56
ffffffffc0206c16:	99bfd0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0206c1a:	5c75                	li	s8,-3
ffffffffc0206c1c:	040a2823          	sw	zero,80(s4)
ffffffffc0206c20:	b625                	j	ffffffffc0206748 <do_execve+0x27e>
ffffffffc0206c22:	5771                	li	a4,-4
ffffffffc0206c24:	87a2                	mv	a5,s0
ffffffffc0206c26:	8da6                	mv	s11,s1
ffffffffc0206c28:	e03a                	sd	a4,0(sp)
ffffffffc0206c2a:	bdf9                	j	ffffffffc0206b08 <do_execve+0x63e>
ffffffffc0206c2c:	57e1                	li	a5,-8
ffffffffc0206c2e:	6406                	ld	s0,64(sp)
ffffffffc0206c30:	e03e                	sd	a5,0(sp)
ffffffffc0206c32:	b6f5                	j	ffffffffc020681e <do_execve+0x354>
ffffffffc0206c34:	86ca                	mv	a3,s2
ffffffffc0206c36:	00006617          	auipc	a2,0x6
ffffffffc0206c3a:	8b260613          	addi	a2,a2,-1870 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0206c3e:	07100593          	li	a1,113
ffffffffc0206c42:	00006517          	auipc	a0,0x6
ffffffffc0206c46:	8ce50513          	addi	a0,a0,-1842 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0206c4a:	855f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206c4e:	86be                	mv	a3,a5
ffffffffc0206c50:	00006617          	auipc	a2,0x6
ffffffffc0206c54:	89860613          	addi	a2,a2,-1896 # ffffffffc020c4e8 <default_pmm_manager+0x38>
ffffffffc0206c58:	07100593          	li	a1,113
ffffffffc0206c5c:	00006517          	auipc	a0,0x6
ffffffffc0206c60:	8b450513          	addi	a0,a0,-1868 # ffffffffc020c510 <default_pmm_manager+0x60>
ffffffffc0206c64:	83bf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206c68:	00006617          	auipc	a2,0x6
ffffffffc0206c6c:	92860613          	addi	a2,a2,-1752 # ffffffffc020c590 <default_pmm_manager+0xe0>
ffffffffc0206c70:	30a00593          	li	a1,778
ffffffffc0206c74:	00007517          	auipc	a0,0x7
ffffffffc0206c78:	87450513          	addi	a0,a0,-1932 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206c7c:	823f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206c80:	00007697          	auipc	a3,0x7
ffffffffc0206c84:	b9868693          	addi	a3,a3,-1128 # ffffffffc020d818 <CSWTCH.79+0x440>
ffffffffc0206c88:	00005617          	auipc	a2,0x5
ffffffffc0206c8c:	d2060613          	addi	a2,a2,-736 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206c90:	30500593          	li	a1,773
ffffffffc0206c94:	00007517          	auipc	a0,0x7
ffffffffc0206c98:	85450513          	addi	a0,a0,-1964 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206c9c:	803f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ca0:	00007697          	auipc	a3,0x7
ffffffffc0206ca4:	b3068693          	addi	a3,a3,-1232 # ffffffffc020d7d0 <CSWTCH.79+0x3f8>
ffffffffc0206ca8:	00005617          	auipc	a2,0x5
ffffffffc0206cac:	d0060613          	addi	a2,a2,-768 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206cb0:	30400593          	li	a1,772
ffffffffc0206cb4:	00007517          	auipc	a0,0x7
ffffffffc0206cb8:	83450513          	addi	a0,a0,-1996 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206cbc:	fe2f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206cc0:	00007697          	auipc	a3,0x7
ffffffffc0206cc4:	ac868693          	addi	a3,a3,-1336 # ffffffffc020d788 <CSWTCH.79+0x3b0>
ffffffffc0206cc8:	00005617          	auipc	a2,0x5
ffffffffc0206ccc:	ce060613          	addi	a2,a2,-800 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206cd0:	30300593          	li	a1,771
ffffffffc0206cd4:	00007517          	auipc	a0,0x7
ffffffffc0206cd8:	81450513          	addi	a0,a0,-2028 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206cdc:	fc2f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ce0:	00007697          	auipc	a3,0x7
ffffffffc0206ce4:	a6068693          	addi	a3,a3,-1440 # ffffffffc020d740 <CSWTCH.79+0x368>
ffffffffc0206ce8:	00005617          	auipc	a2,0x5
ffffffffc0206cec:	cc060613          	addi	a2,a2,-832 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206cf0:	30200593          	li	a1,770
ffffffffc0206cf4:	00006517          	auipc	a0,0x6
ffffffffc0206cf8:	7f450513          	addi	a0,a0,2036 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206cfc:	fa2f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206d00 <user_main>:
ffffffffc0206d00:	7179                	addi	sp,sp,-48
ffffffffc0206d02:	e84a                	sd	s2,16(sp)
ffffffffc0206d04:	00090917          	auipc	s2,0x90
ffffffffc0206d08:	bbc90913          	addi	s2,s2,-1092 # ffffffffc02968c0 <current>
ffffffffc0206d0c:	00093783          	ld	a5,0(s2)
ffffffffc0206d10:	00007617          	auipc	a2,0x7
ffffffffc0206d14:	b5060613          	addi	a2,a2,-1200 # ffffffffc020d860 <CSWTCH.79+0x488>
ffffffffc0206d18:	00007517          	auipc	a0,0x7
ffffffffc0206d1c:	b5050513          	addi	a0,a0,-1200 # ffffffffc020d868 <CSWTCH.79+0x490>
ffffffffc0206d20:	43cc                	lw	a1,4(a5)
ffffffffc0206d22:	f406                	sd	ra,40(sp)
ffffffffc0206d24:	f022                	sd	s0,32(sp)
ffffffffc0206d26:	ec26                	sd	s1,24(sp)
ffffffffc0206d28:	e032                	sd	a2,0(sp)
ffffffffc0206d2a:	e402                	sd	zero,8(sp)
ffffffffc0206d2c:	c7af90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206d30:	6782                	ld	a5,0(sp)
ffffffffc0206d32:	cfb9                	beqz	a5,ffffffffc0206d90 <user_main+0x90>
ffffffffc0206d34:	003c                	addi	a5,sp,8
ffffffffc0206d36:	4401                	li	s0,0
ffffffffc0206d38:	6398                	ld	a4,0(a5)
ffffffffc0206d3a:	0405                	addi	s0,s0,1
ffffffffc0206d3c:	07a1                	addi	a5,a5,8
ffffffffc0206d3e:	ff6d                	bnez	a4,ffffffffc0206d38 <user_main+0x38>
ffffffffc0206d40:	00093783          	ld	a5,0(s2)
ffffffffc0206d44:	12000613          	li	a2,288
ffffffffc0206d48:	6b84                	ld	s1,16(a5)
ffffffffc0206d4a:	73cc                	ld	a1,160(a5)
ffffffffc0206d4c:	6789                	lui	a5,0x2
ffffffffc0206d4e:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206d52:	94be                	add	s1,s1,a5
ffffffffc0206d54:	8526                	mv	a0,s1
ffffffffc0206d56:	7c0040ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc0206d5a:	00093783          	ld	a5,0(s2)
ffffffffc0206d5e:	860a                	mv	a2,sp
ffffffffc0206d60:	0004059b          	sext.w	a1,s0
ffffffffc0206d64:	f3c4                	sd	s1,160(a5)
ffffffffc0206d66:	00007517          	auipc	a0,0x7
ffffffffc0206d6a:	afa50513          	addi	a0,a0,-1286 # ffffffffc020d860 <CSWTCH.79+0x488>
ffffffffc0206d6e:	f5cff0ef          	jal	ra,ffffffffc02064ca <do_execve>
ffffffffc0206d72:	8126                	mv	sp,s1
ffffffffc0206d74:	d2cfa06f          	j	ffffffffc02012a0 <__trapret>
ffffffffc0206d78:	00007617          	auipc	a2,0x7
ffffffffc0206d7c:	b1860613          	addi	a2,a2,-1256 # ffffffffc020d890 <CSWTCH.79+0x4b8>
ffffffffc0206d80:	43f00593          	li	a1,1087
ffffffffc0206d84:	00006517          	auipc	a0,0x6
ffffffffc0206d88:	76450513          	addi	a0,a0,1892 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206d8c:	f12f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d90:	4401                	li	s0,0
ffffffffc0206d92:	b77d                	j	ffffffffc0206d40 <user_main+0x40>

ffffffffc0206d94 <do_yield>:
ffffffffc0206d94:	00090797          	auipc	a5,0x90
ffffffffc0206d98:	b2c7b783          	ld	a5,-1236(a5) # ffffffffc02968c0 <current>
ffffffffc0206d9c:	4705                	li	a4,1
ffffffffc0206d9e:	ef98                	sd	a4,24(a5)
ffffffffc0206da0:	4501                	li	a0,0
ffffffffc0206da2:	8082                	ret

ffffffffc0206da4 <do_wait>:
ffffffffc0206da4:	1101                	addi	sp,sp,-32
ffffffffc0206da6:	e822                	sd	s0,16(sp)
ffffffffc0206da8:	e426                	sd	s1,8(sp)
ffffffffc0206daa:	ec06                	sd	ra,24(sp)
ffffffffc0206dac:	842e                	mv	s0,a1
ffffffffc0206dae:	84aa                	mv	s1,a0
ffffffffc0206db0:	c999                	beqz	a1,ffffffffc0206dc6 <do_wait+0x22>
ffffffffc0206db2:	00090797          	auipc	a5,0x90
ffffffffc0206db6:	b0e7b783          	ld	a5,-1266(a5) # ffffffffc02968c0 <current>
ffffffffc0206dba:	7788                	ld	a0,40(a5)
ffffffffc0206dbc:	4685                	li	a3,1
ffffffffc0206dbe:	4611                	li	a2,4
ffffffffc0206dc0:	d22fd0ef          	jal	ra,ffffffffc02042e2 <user_mem_check>
ffffffffc0206dc4:	c909                	beqz	a0,ffffffffc0206dd6 <do_wait+0x32>
ffffffffc0206dc6:	85a2                	mv	a1,s0
ffffffffc0206dc8:	6442                	ld	s0,16(sp)
ffffffffc0206dca:	60e2                	ld	ra,24(sp)
ffffffffc0206dcc:	8526                	mv	a0,s1
ffffffffc0206dce:	64a2                	ld	s1,8(sp)
ffffffffc0206dd0:	6105                	addi	sp,sp,32
ffffffffc0206dd2:	bd6ff06f          	j	ffffffffc02061a8 <do_wait.part.0>
ffffffffc0206dd6:	60e2                	ld	ra,24(sp)
ffffffffc0206dd8:	6442                	ld	s0,16(sp)
ffffffffc0206dda:	64a2                	ld	s1,8(sp)
ffffffffc0206ddc:	5575                	li	a0,-3
ffffffffc0206dde:	6105                	addi	sp,sp,32
ffffffffc0206de0:	8082                	ret

ffffffffc0206de2 <do_kill>:
ffffffffc0206de2:	1141                	addi	sp,sp,-16
ffffffffc0206de4:	6789                	lui	a5,0x2
ffffffffc0206de6:	e406                	sd	ra,8(sp)
ffffffffc0206de8:	e022                	sd	s0,0(sp)
ffffffffc0206dea:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206dee:	17f9                	addi	a5,a5,-2
ffffffffc0206df0:	02e7e963          	bltu	a5,a4,ffffffffc0206e22 <do_kill+0x40>
ffffffffc0206df4:	842a                	mv	s0,a0
ffffffffc0206df6:	45a9                	li	a1,10
ffffffffc0206df8:	2501                	sext.w	a0,a0
ffffffffc0206dfa:	196040ef          	jal	ra,ffffffffc020af90 <hash32>
ffffffffc0206dfe:	02051793          	slli	a5,a0,0x20
ffffffffc0206e02:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206e06:	0008b797          	auipc	a5,0x8b
ffffffffc0206e0a:	9ba78793          	addi	a5,a5,-1606 # ffffffffc02917c0 <hash_list>
ffffffffc0206e0e:	953e                	add	a0,a0,a5
ffffffffc0206e10:	87aa                	mv	a5,a0
ffffffffc0206e12:	a029                	j	ffffffffc0206e1c <do_kill+0x3a>
ffffffffc0206e14:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206e18:	00870b63          	beq	a4,s0,ffffffffc0206e2e <do_kill+0x4c>
ffffffffc0206e1c:	679c                	ld	a5,8(a5)
ffffffffc0206e1e:	fef51be3          	bne	a0,a5,ffffffffc0206e14 <do_kill+0x32>
ffffffffc0206e22:	5475                	li	s0,-3
ffffffffc0206e24:	60a2                	ld	ra,8(sp)
ffffffffc0206e26:	8522                	mv	a0,s0
ffffffffc0206e28:	6402                	ld	s0,0(sp)
ffffffffc0206e2a:	0141                	addi	sp,sp,16
ffffffffc0206e2c:	8082                	ret
ffffffffc0206e2e:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206e32:	00177693          	andi	a3,a4,1
ffffffffc0206e36:	e295                	bnez	a3,ffffffffc0206e5a <do_kill+0x78>
ffffffffc0206e38:	4bd4                	lw	a3,20(a5)
ffffffffc0206e3a:	00176713          	ori	a4,a4,1
ffffffffc0206e3e:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206e42:	4401                	li	s0,0
ffffffffc0206e44:	fe06d0e3          	bgez	a3,ffffffffc0206e24 <do_kill+0x42>
ffffffffc0206e48:	f2878513          	addi	a0,a5,-216
ffffffffc0206e4c:	45a000ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc0206e50:	60a2                	ld	ra,8(sp)
ffffffffc0206e52:	8522                	mv	a0,s0
ffffffffc0206e54:	6402                	ld	s0,0(sp)
ffffffffc0206e56:	0141                	addi	sp,sp,16
ffffffffc0206e58:	8082                	ret
ffffffffc0206e5a:	545d                	li	s0,-9
ffffffffc0206e5c:	b7e1                	j	ffffffffc0206e24 <do_kill+0x42>

ffffffffc0206e5e <proc_init>:
ffffffffc0206e5e:	1101                	addi	sp,sp,-32
ffffffffc0206e60:	e426                	sd	s1,8(sp)
ffffffffc0206e62:	0008f797          	auipc	a5,0x8f
ffffffffc0206e66:	95e78793          	addi	a5,a5,-1698 # ffffffffc02957c0 <proc_list>
ffffffffc0206e6a:	ec06                	sd	ra,24(sp)
ffffffffc0206e6c:	e822                	sd	s0,16(sp)
ffffffffc0206e6e:	e04a                	sd	s2,0(sp)
ffffffffc0206e70:	0008b497          	auipc	s1,0x8b
ffffffffc0206e74:	95048493          	addi	s1,s1,-1712 # ffffffffc02917c0 <hash_list>
ffffffffc0206e78:	e79c                	sd	a5,8(a5)
ffffffffc0206e7a:	e39c                	sd	a5,0(a5)
ffffffffc0206e7c:	0008f717          	auipc	a4,0x8f
ffffffffc0206e80:	94470713          	addi	a4,a4,-1724 # ffffffffc02957c0 <proc_list>
ffffffffc0206e84:	87a6                	mv	a5,s1
ffffffffc0206e86:	e79c                	sd	a5,8(a5)
ffffffffc0206e88:	e39c                	sd	a5,0(a5)
ffffffffc0206e8a:	07c1                	addi	a5,a5,16
ffffffffc0206e8c:	fef71de3          	bne	a4,a5,ffffffffc0206e86 <proc_init+0x28>
ffffffffc0206e90:	b95fe0ef          	jal	ra,ffffffffc0205a24 <alloc_proc>
ffffffffc0206e94:	00090917          	auipc	s2,0x90
ffffffffc0206e98:	a3490913          	addi	s2,s2,-1484 # ffffffffc02968c8 <idleproc>
ffffffffc0206e9c:	00a93023          	sd	a0,0(s2)
ffffffffc0206ea0:	842a                	mv	s0,a0
ffffffffc0206ea2:	12050863          	beqz	a0,ffffffffc0206fd2 <proc_init+0x174>
ffffffffc0206ea6:	4789                	li	a5,2
ffffffffc0206ea8:	e11c                	sd	a5,0(a0)
ffffffffc0206eaa:	0000a797          	auipc	a5,0xa
ffffffffc0206eae:	15678793          	addi	a5,a5,342 # ffffffffc0211000 <bootstack>
ffffffffc0206eb2:	e91c                	sd	a5,16(a0)
ffffffffc0206eb4:	4785                	li	a5,1
ffffffffc0206eb6:	ed1c                	sd	a5,24(a0)
ffffffffc0206eb8:	b66fe0ef          	jal	ra,ffffffffc020521e <files_create>
ffffffffc0206ebc:	14a43423          	sd	a0,328(s0)
ffffffffc0206ec0:	0e050d63          	beqz	a0,ffffffffc0206fba <proc_init+0x15c>
ffffffffc0206ec4:	00093403          	ld	s0,0(s2)
ffffffffc0206ec8:	4641                	li	a2,16
ffffffffc0206eca:	4581                	li	a1,0
ffffffffc0206ecc:	14843703          	ld	a4,328(s0)
ffffffffc0206ed0:	0b440413          	addi	s0,s0,180
ffffffffc0206ed4:	8522                	mv	a0,s0
ffffffffc0206ed6:	4b1c                	lw	a5,16(a4)
ffffffffc0206ed8:	2785                	addiw	a5,a5,1
ffffffffc0206eda:	cb1c                	sw	a5,16(a4)
ffffffffc0206edc:	5e8040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0206ee0:	463d                	li	a2,15
ffffffffc0206ee2:	00007597          	auipc	a1,0x7
ffffffffc0206ee6:	a0e58593          	addi	a1,a1,-1522 # ffffffffc020d8f0 <CSWTCH.79+0x518>
ffffffffc0206eea:	8522                	mv	a0,s0
ffffffffc0206eec:	62a040ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc0206ef0:	00090717          	auipc	a4,0x90
ffffffffc0206ef4:	9e870713          	addi	a4,a4,-1560 # ffffffffc02968d8 <nr_process>
ffffffffc0206ef8:	431c                	lw	a5,0(a4)
ffffffffc0206efa:	00093683          	ld	a3,0(s2)
ffffffffc0206efe:	4601                	li	a2,0
ffffffffc0206f00:	2785                	addiw	a5,a5,1
ffffffffc0206f02:	4581                	li	a1,0
ffffffffc0206f04:	fffff517          	auipc	a0,0xfffff
ffffffffc0206f08:	47650513          	addi	a0,a0,1142 # ffffffffc020637a <init_main>
ffffffffc0206f0c:	c31c                	sw	a5,0(a4)
ffffffffc0206f0e:	00090797          	auipc	a5,0x90
ffffffffc0206f12:	9ad7b923          	sd	a3,-1614(a5) # ffffffffc02968c0 <current>
ffffffffc0206f16:	8e0ff0ef          	jal	ra,ffffffffc0205ff6 <kernel_thread>
ffffffffc0206f1a:	842a                	mv	s0,a0
ffffffffc0206f1c:	08a05363          	blez	a0,ffffffffc0206fa2 <proc_init+0x144>
ffffffffc0206f20:	6789                	lui	a5,0x2
ffffffffc0206f22:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206f26:	17f9                	addi	a5,a5,-2
ffffffffc0206f28:	2501                	sext.w	a0,a0
ffffffffc0206f2a:	02e7e363          	bltu	a5,a4,ffffffffc0206f50 <proc_init+0xf2>
ffffffffc0206f2e:	45a9                	li	a1,10
ffffffffc0206f30:	060040ef          	jal	ra,ffffffffc020af90 <hash32>
ffffffffc0206f34:	02051793          	slli	a5,a0,0x20
ffffffffc0206f38:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206f3c:	96a6                	add	a3,a3,s1
ffffffffc0206f3e:	87b6                	mv	a5,a3
ffffffffc0206f40:	a029                	j	ffffffffc0206f4a <proc_init+0xec>
ffffffffc0206f42:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206f46:	04870b63          	beq	a4,s0,ffffffffc0206f9c <proc_init+0x13e>
ffffffffc0206f4a:	679c                	ld	a5,8(a5)
ffffffffc0206f4c:	fef69be3          	bne	a3,a5,ffffffffc0206f42 <proc_init+0xe4>
ffffffffc0206f50:	4781                	li	a5,0
ffffffffc0206f52:	0b478493          	addi	s1,a5,180
ffffffffc0206f56:	4641                	li	a2,16
ffffffffc0206f58:	4581                	li	a1,0
ffffffffc0206f5a:	00090417          	auipc	s0,0x90
ffffffffc0206f5e:	97640413          	addi	s0,s0,-1674 # ffffffffc02968d0 <initproc>
ffffffffc0206f62:	8526                	mv	a0,s1
ffffffffc0206f64:	e01c                	sd	a5,0(s0)
ffffffffc0206f66:	55e040ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0206f6a:	463d                	li	a2,15
ffffffffc0206f6c:	00007597          	auipc	a1,0x7
ffffffffc0206f70:	9ac58593          	addi	a1,a1,-1620 # ffffffffc020d918 <CSWTCH.79+0x540>
ffffffffc0206f74:	8526                	mv	a0,s1
ffffffffc0206f76:	5a0040ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc0206f7a:	00093783          	ld	a5,0(s2)
ffffffffc0206f7e:	c7d1                	beqz	a5,ffffffffc020700a <proc_init+0x1ac>
ffffffffc0206f80:	43dc                	lw	a5,4(a5)
ffffffffc0206f82:	e7c1                	bnez	a5,ffffffffc020700a <proc_init+0x1ac>
ffffffffc0206f84:	601c                	ld	a5,0(s0)
ffffffffc0206f86:	c3b5                	beqz	a5,ffffffffc0206fea <proc_init+0x18c>
ffffffffc0206f88:	43d8                	lw	a4,4(a5)
ffffffffc0206f8a:	4785                	li	a5,1
ffffffffc0206f8c:	04f71f63          	bne	a4,a5,ffffffffc0206fea <proc_init+0x18c>
ffffffffc0206f90:	60e2                	ld	ra,24(sp)
ffffffffc0206f92:	6442                	ld	s0,16(sp)
ffffffffc0206f94:	64a2                	ld	s1,8(sp)
ffffffffc0206f96:	6902                	ld	s2,0(sp)
ffffffffc0206f98:	6105                	addi	sp,sp,32
ffffffffc0206f9a:	8082                	ret
ffffffffc0206f9c:	f2878793          	addi	a5,a5,-216
ffffffffc0206fa0:	bf4d                	j	ffffffffc0206f52 <proc_init+0xf4>
ffffffffc0206fa2:	00007617          	auipc	a2,0x7
ffffffffc0206fa6:	95660613          	addi	a2,a2,-1706 # ffffffffc020d8f8 <CSWTCH.79+0x520>
ffffffffc0206faa:	48b00593          	li	a1,1163
ffffffffc0206fae:	00006517          	auipc	a0,0x6
ffffffffc0206fb2:	53a50513          	addi	a0,a0,1338 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206fb6:	ce8f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206fba:	00007617          	auipc	a2,0x7
ffffffffc0206fbe:	90e60613          	addi	a2,a2,-1778 # ffffffffc020d8c8 <CSWTCH.79+0x4f0>
ffffffffc0206fc2:	47f00593          	li	a1,1151
ffffffffc0206fc6:	00006517          	auipc	a0,0x6
ffffffffc0206fca:	52250513          	addi	a0,a0,1314 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206fce:	cd0f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206fd2:	00007617          	auipc	a2,0x7
ffffffffc0206fd6:	8de60613          	addi	a2,a2,-1826 # ffffffffc020d8b0 <CSWTCH.79+0x4d8>
ffffffffc0206fda:	47500593          	li	a1,1141
ffffffffc0206fde:	00006517          	auipc	a0,0x6
ffffffffc0206fe2:	50a50513          	addi	a0,a0,1290 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0206fe6:	cb8f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206fea:	00007697          	auipc	a3,0x7
ffffffffc0206fee:	95e68693          	addi	a3,a3,-1698 # ffffffffc020d948 <CSWTCH.79+0x570>
ffffffffc0206ff2:	00005617          	auipc	a2,0x5
ffffffffc0206ff6:	9b660613          	addi	a2,a2,-1610 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0206ffa:	49200593          	li	a1,1170
ffffffffc0206ffe:	00006517          	auipc	a0,0x6
ffffffffc0207002:	4ea50513          	addi	a0,a0,1258 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0207006:	c98f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020700a:	00007697          	auipc	a3,0x7
ffffffffc020700e:	91668693          	addi	a3,a3,-1770 # ffffffffc020d920 <CSWTCH.79+0x548>
ffffffffc0207012:	00005617          	auipc	a2,0x5
ffffffffc0207016:	99660613          	addi	a2,a2,-1642 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020701a:	49100593          	li	a1,1169
ffffffffc020701e:	00006517          	auipc	a0,0x6
ffffffffc0207022:	4ca50513          	addi	a0,a0,1226 # ffffffffc020d4e8 <CSWTCH.79+0x110>
ffffffffc0207026:	c78f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020702a <cpu_idle>:
ffffffffc020702a:	1141                	addi	sp,sp,-16
ffffffffc020702c:	e022                	sd	s0,0(sp)
ffffffffc020702e:	e406                	sd	ra,8(sp)
ffffffffc0207030:	00090417          	auipc	s0,0x90
ffffffffc0207034:	89040413          	addi	s0,s0,-1904 # ffffffffc02968c0 <current>
ffffffffc0207038:	6018                	ld	a4,0(s0)
ffffffffc020703a:	6f1c                	ld	a5,24(a4)
ffffffffc020703c:	dffd                	beqz	a5,ffffffffc020703a <cpu_idle+0x10>
ffffffffc020703e:	31a000ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc0207042:	bfdd                	j	ffffffffc0207038 <cpu_idle+0xe>

ffffffffc0207044 <lab6_set_priority>:
ffffffffc0207044:	1141                	addi	sp,sp,-16
ffffffffc0207046:	e022                	sd	s0,0(sp)
ffffffffc0207048:	85aa                	mv	a1,a0
ffffffffc020704a:	842a                	mv	s0,a0
ffffffffc020704c:	00007517          	auipc	a0,0x7
ffffffffc0207050:	92450513          	addi	a0,a0,-1756 # ffffffffc020d970 <CSWTCH.79+0x598>
ffffffffc0207054:	e406                	sd	ra,8(sp)
ffffffffc0207056:	950f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020705a:	00090797          	auipc	a5,0x90
ffffffffc020705e:	8667b783          	ld	a5,-1946(a5) # ffffffffc02968c0 <current>
ffffffffc0207062:	e801                	bnez	s0,ffffffffc0207072 <lab6_set_priority+0x2e>
ffffffffc0207064:	60a2                	ld	ra,8(sp)
ffffffffc0207066:	6402                	ld	s0,0(sp)
ffffffffc0207068:	4705                	li	a4,1
ffffffffc020706a:	14e7a223          	sw	a4,324(a5)
ffffffffc020706e:	0141                	addi	sp,sp,16
ffffffffc0207070:	8082                	ret
ffffffffc0207072:	60a2                	ld	ra,8(sp)
ffffffffc0207074:	1487a223          	sw	s0,324(a5)
ffffffffc0207078:	6402                	ld	s0,0(sp)
ffffffffc020707a:	0141                	addi	sp,sp,16
ffffffffc020707c:	8082                	ret

ffffffffc020707e <do_sleep>:
ffffffffc020707e:	c539                	beqz	a0,ffffffffc02070cc <do_sleep+0x4e>
ffffffffc0207080:	7179                	addi	sp,sp,-48
ffffffffc0207082:	f022                	sd	s0,32(sp)
ffffffffc0207084:	f406                	sd	ra,40(sp)
ffffffffc0207086:	842a                	mv	s0,a0
ffffffffc0207088:	100027f3          	csrr	a5,sstatus
ffffffffc020708c:	8b89                	andi	a5,a5,2
ffffffffc020708e:	e3a9                	bnez	a5,ffffffffc02070d0 <do_sleep+0x52>
ffffffffc0207090:	00090797          	auipc	a5,0x90
ffffffffc0207094:	8307b783          	ld	a5,-2000(a5) # ffffffffc02968c0 <current>
ffffffffc0207098:	0818                	addi	a4,sp,16
ffffffffc020709a:	c02a                	sw	a0,0(sp)
ffffffffc020709c:	ec3a                	sd	a4,24(sp)
ffffffffc020709e:	e83a                	sd	a4,16(sp)
ffffffffc02070a0:	e43e                	sd	a5,8(sp)
ffffffffc02070a2:	4705                	li	a4,1
ffffffffc02070a4:	c398                	sw	a4,0(a5)
ffffffffc02070a6:	80000737          	lui	a4,0x80000
ffffffffc02070aa:	840a                	mv	s0,sp
ffffffffc02070ac:	0709                	addi	a4,a4,2
ffffffffc02070ae:	0ee7a623          	sw	a4,236(a5)
ffffffffc02070b2:	8522                	mv	a0,s0
ffffffffc02070b4:	364000ef          	jal	ra,ffffffffc0207418 <add_timer>
ffffffffc02070b8:	2a0000ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc02070bc:	8522                	mv	a0,s0
ffffffffc02070be:	422000ef          	jal	ra,ffffffffc02074e0 <del_timer>
ffffffffc02070c2:	70a2                	ld	ra,40(sp)
ffffffffc02070c4:	7402                	ld	s0,32(sp)
ffffffffc02070c6:	4501                	li	a0,0
ffffffffc02070c8:	6145                	addi	sp,sp,48
ffffffffc02070ca:	8082                	ret
ffffffffc02070cc:	4501                	li	a0,0
ffffffffc02070ce:	8082                	ret
ffffffffc02070d0:	ba3f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02070d4:	0008f797          	auipc	a5,0x8f
ffffffffc02070d8:	7ec7b783          	ld	a5,2028(a5) # ffffffffc02968c0 <current>
ffffffffc02070dc:	0818                	addi	a4,sp,16
ffffffffc02070de:	c022                	sw	s0,0(sp)
ffffffffc02070e0:	e43e                	sd	a5,8(sp)
ffffffffc02070e2:	ec3a                	sd	a4,24(sp)
ffffffffc02070e4:	e83a                	sd	a4,16(sp)
ffffffffc02070e6:	4705                	li	a4,1
ffffffffc02070e8:	c398                	sw	a4,0(a5)
ffffffffc02070ea:	80000737          	lui	a4,0x80000
ffffffffc02070ee:	0709                	addi	a4,a4,2
ffffffffc02070f0:	840a                	mv	s0,sp
ffffffffc02070f2:	8522                	mv	a0,s0
ffffffffc02070f4:	0ee7a623          	sw	a4,236(a5)
ffffffffc02070f8:	320000ef          	jal	ra,ffffffffc0207418 <add_timer>
ffffffffc02070fc:	b71f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0207100:	bf65                	j	ffffffffc02070b8 <do_sleep+0x3a>

ffffffffc0207102 <switch_to>:
ffffffffc0207102:	00153023          	sd	ra,0(a0)
ffffffffc0207106:	00253423          	sd	sp,8(a0)
ffffffffc020710a:	e900                	sd	s0,16(a0)
ffffffffc020710c:	ed04                	sd	s1,24(a0)
ffffffffc020710e:	03253023          	sd	s2,32(a0)
ffffffffc0207112:	03353423          	sd	s3,40(a0)
ffffffffc0207116:	03453823          	sd	s4,48(a0)
ffffffffc020711a:	03553c23          	sd	s5,56(a0)
ffffffffc020711e:	05653023          	sd	s6,64(a0)
ffffffffc0207122:	05753423          	sd	s7,72(a0)
ffffffffc0207126:	05853823          	sd	s8,80(a0)
ffffffffc020712a:	05953c23          	sd	s9,88(a0)
ffffffffc020712e:	07a53023          	sd	s10,96(a0)
ffffffffc0207132:	07b53423          	sd	s11,104(a0)
ffffffffc0207136:	0005b083          	ld	ra,0(a1)
ffffffffc020713a:	0085b103          	ld	sp,8(a1)
ffffffffc020713e:	6980                	ld	s0,16(a1)
ffffffffc0207140:	6d84                	ld	s1,24(a1)
ffffffffc0207142:	0205b903          	ld	s2,32(a1)
ffffffffc0207146:	0285b983          	ld	s3,40(a1)
ffffffffc020714a:	0305ba03          	ld	s4,48(a1)
ffffffffc020714e:	0385ba83          	ld	s5,56(a1)
ffffffffc0207152:	0405bb03          	ld	s6,64(a1)
ffffffffc0207156:	0485bb83          	ld	s7,72(a1)
ffffffffc020715a:	0505bc03          	ld	s8,80(a1)
ffffffffc020715e:	0585bc83          	ld	s9,88(a1)
ffffffffc0207162:	0605bd03          	ld	s10,96(a1)
ffffffffc0207166:	0685bd83          	ld	s11,104(a1)
ffffffffc020716a:	8082                	ret

ffffffffc020716c <RR_init>:
ffffffffc020716c:	e508                	sd	a0,8(a0)
ffffffffc020716e:	e108                	sd	a0,0(a0)
ffffffffc0207170:	00052823          	sw	zero,16(a0)
ffffffffc0207174:	8082                	ret

ffffffffc0207176 <RR_pick_next>:
ffffffffc0207176:	651c                	ld	a5,8(a0)
ffffffffc0207178:	00f50563          	beq	a0,a5,ffffffffc0207182 <RR_pick_next+0xc>
ffffffffc020717c:	ef078513          	addi	a0,a5,-272
ffffffffc0207180:	8082                	ret
ffffffffc0207182:	4501                	li	a0,0
ffffffffc0207184:	8082                	ret

ffffffffc0207186 <RR_proc_tick>:
ffffffffc0207186:	1205a783          	lw	a5,288(a1)
ffffffffc020718a:	00f05563          	blez	a5,ffffffffc0207194 <RR_proc_tick+0xe>
ffffffffc020718e:	37fd                	addiw	a5,a5,-1
ffffffffc0207190:	12f5a023          	sw	a5,288(a1)
ffffffffc0207194:	e399                	bnez	a5,ffffffffc020719a <RR_proc_tick+0x14>
ffffffffc0207196:	4785                	li	a5,1
ffffffffc0207198:	ed9c                	sd	a5,24(a1)
ffffffffc020719a:	8082                	ret

ffffffffc020719c <RR_dequeue>:
ffffffffc020719c:	1185b703          	ld	a4,280(a1)
ffffffffc02071a0:	11058793          	addi	a5,a1,272
ffffffffc02071a4:	02e78363          	beq	a5,a4,ffffffffc02071ca <RR_dequeue+0x2e>
ffffffffc02071a8:	1085b683          	ld	a3,264(a1)
ffffffffc02071ac:	00a69f63          	bne	a3,a0,ffffffffc02071ca <RR_dequeue+0x2e>
ffffffffc02071b0:	1105b503          	ld	a0,272(a1)
ffffffffc02071b4:	4a90                	lw	a2,16(a3)
ffffffffc02071b6:	e518                	sd	a4,8(a0)
ffffffffc02071b8:	e308                	sd	a0,0(a4)
ffffffffc02071ba:	10f5bc23          	sd	a5,280(a1)
ffffffffc02071be:	10f5b823          	sd	a5,272(a1)
ffffffffc02071c2:	fff6079b          	addiw	a5,a2,-1
ffffffffc02071c6:	ca9c                	sw	a5,16(a3)
ffffffffc02071c8:	8082                	ret
ffffffffc02071ca:	1141                	addi	sp,sp,-16
ffffffffc02071cc:	00006697          	auipc	a3,0x6
ffffffffc02071d0:	7bc68693          	addi	a3,a3,1980 # ffffffffc020d988 <CSWTCH.79+0x5b0>
ffffffffc02071d4:	00004617          	auipc	a2,0x4
ffffffffc02071d8:	7d460613          	addi	a2,a2,2004 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02071dc:	03c00593          	li	a1,60
ffffffffc02071e0:	00006517          	auipc	a0,0x6
ffffffffc02071e4:	7e050513          	addi	a0,a0,2016 # ffffffffc020d9c0 <CSWTCH.79+0x5e8>
ffffffffc02071e8:	e406                	sd	ra,8(sp)
ffffffffc02071ea:	ab4f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02071ee <RR_enqueue>:
ffffffffc02071ee:	1185b703          	ld	a4,280(a1)
ffffffffc02071f2:	11058793          	addi	a5,a1,272
ffffffffc02071f6:	02e79d63          	bne	a5,a4,ffffffffc0207230 <RR_enqueue+0x42>
ffffffffc02071fa:	6118                	ld	a4,0(a0)
ffffffffc02071fc:	1205a683          	lw	a3,288(a1)
ffffffffc0207200:	e11c                	sd	a5,0(a0)
ffffffffc0207202:	e71c                	sd	a5,8(a4)
ffffffffc0207204:	10a5bc23          	sd	a0,280(a1)
ffffffffc0207208:	10e5b823          	sd	a4,272(a1)
ffffffffc020720c:	495c                	lw	a5,20(a0)
ffffffffc020720e:	ea89                	bnez	a3,ffffffffc0207220 <RR_enqueue+0x32>
ffffffffc0207210:	12f5a023          	sw	a5,288(a1)
ffffffffc0207214:	491c                	lw	a5,16(a0)
ffffffffc0207216:	10a5b423          	sd	a0,264(a1)
ffffffffc020721a:	2785                	addiw	a5,a5,1
ffffffffc020721c:	c91c                	sw	a5,16(a0)
ffffffffc020721e:	8082                	ret
ffffffffc0207220:	fed7c8e3          	blt	a5,a3,ffffffffc0207210 <RR_enqueue+0x22>
ffffffffc0207224:	491c                	lw	a5,16(a0)
ffffffffc0207226:	10a5b423          	sd	a0,264(a1)
ffffffffc020722a:	2785                	addiw	a5,a5,1
ffffffffc020722c:	c91c                	sw	a5,16(a0)
ffffffffc020722e:	8082                	ret
ffffffffc0207230:	1141                	addi	sp,sp,-16
ffffffffc0207232:	00006697          	auipc	a3,0x6
ffffffffc0207236:	7ae68693          	addi	a3,a3,1966 # ffffffffc020d9e0 <CSWTCH.79+0x608>
ffffffffc020723a:	00004617          	auipc	a2,0x4
ffffffffc020723e:	76e60613          	addi	a2,a2,1902 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207242:	02800593          	li	a1,40
ffffffffc0207246:	00006517          	auipc	a0,0x6
ffffffffc020724a:	77a50513          	addi	a0,a0,1914 # ffffffffc020d9c0 <CSWTCH.79+0x5e8>
ffffffffc020724e:	e406                	sd	ra,8(sp)
ffffffffc0207250:	a4ef90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207254 <sched_init>:
ffffffffc0207254:	1141                	addi	sp,sp,-16
ffffffffc0207256:	0008a717          	auipc	a4,0x8a
ffffffffc020725a:	dca70713          	addi	a4,a4,-566 # ffffffffc0291020 <default_sched_class>
ffffffffc020725e:	e022                	sd	s0,0(sp)
ffffffffc0207260:	e406                	sd	ra,8(sp)
ffffffffc0207262:	0008e797          	auipc	a5,0x8e
ffffffffc0207266:	58e78793          	addi	a5,a5,1422 # ffffffffc02957f0 <timer_list>
ffffffffc020726a:	6714                	ld	a3,8(a4)
ffffffffc020726c:	0008e517          	auipc	a0,0x8e
ffffffffc0207270:	56450513          	addi	a0,a0,1380 # ffffffffc02957d0 <__rq>
ffffffffc0207274:	e79c                	sd	a5,8(a5)
ffffffffc0207276:	e39c                	sd	a5,0(a5)
ffffffffc0207278:	4795                	li	a5,5
ffffffffc020727a:	c95c                	sw	a5,20(a0)
ffffffffc020727c:	0008f417          	auipc	s0,0x8f
ffffffffc0207280:	66c40413          	addi	s0,s0,1644 # ffffffffc02968e8 <sched_class>
ffffffffc0207284:	0008f797          	auipc	a5,0x8f
ffffffffc0207288:	64a7be23          	sd	a0,1628(a5) # ffffffffc02968e0 <rq>
ffffffffc020728c:	e018                	sd	a4,0(s0)
ffffffffc020728e:	9682                	jalr	a3
ffffffffc0207290:	601c                	ld	a5,0(s0)
ffffffffc0207292:	6402                	ld	s0,0(sp)
ffffffffc0207294:	60a2                	ld	ra,8(sp)
ffffffffc0207296:	638c                	ld	a1,0(a5)
ffffffffc0207298:	00006517          	auipc	a0,0x6
ffffffffc020729c:	77850513          	addi	a0,a0,1912 # ffffffffc020da10 <CSWTCH.79+0x638>
ffffffffc02072a0:	0141                	addi	sp,sp,16
ffffffffc02072a2:	f05f806f          	j	ffffffffc02001a6 <cprintf>

ffffffffc02072a6 <wakeup_proc>:
ffffffffc02072a6:	4118                	lw	a4,0(a0)
ffffffffc02072a8:	1101                	addi	sp,sp,-32
ffffffffc02072aa:	ec06                	sd	ra,24(sp)
ffffffffc02072ac:	e822                	sd	s0,16(sp)
ffffffffc02072ae:	e426                	sd	s1,8(sp)
ffffffffc02072b0:	478d                	li	a5,3
ffffffffc02072b2:	08f70363          	beq	a4,a5,ffffffffc0207338 <wakeup_proc+0x92>
ffffffffc02072b6:	842a                	mv	s0,a0
ffffffffc02072b8:	100027f3          	csrr	a5,sstatus
ffffffffc02072bc:	8b89                	andi	a5,a5,2
ffffffffc02072be:	4481                	li	s1,0
ffffffffc02072c0:	e7bd                	bnez	a5,ffffffffc020732e <wakeup_proc+0x88>
ffffffffc02072c2:	4789                	li	a5,2
ffffffffc02072c4:	04f70863          	beq	a4,a5,ffffffffc0207314 <wakeup_proc+0x6e>
ffffffffc02072c8:	c01c                	sw	a5,0(s0)
ffffffffc02072ca:	0e042623          	sw	zero,236(s0)
ffffffffc02072ce:	0008f797          	auipc	a5,0x8f
ffffffffc02072d2:	5f27b783          	ld	a5,1522(a5) # ffffffffc02968c0 <current>
ffffffffc02072d6:	02878363          	beq	a5,s0,ffffffffc02072fc <wakeup_proc+0x56>
ffffffffc02072da:	0008f797          	auipc	a5,0x8f
ffffffffc02072de:	5ee7b783          	ld	a5,1518(a5) # ffffffffc02968c8 <idleproc>
ffffffffc02072e2:	00f40d63          	beq	s0,a5,ffffffffc02072fc <wakeup_proc+0x56>
ffffffffc02072e6:	0008f797          	auipc	a5,0x8f
ffffffffc02072ea:	6027b783          	ld	a5,1538(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02072ee:	6b9c                	ld	a5,16(a5)
ffffffffc02072f0:	85a2                	mv	a1,s0
ffffffffc02072f2:	0008f517          	auipc	a0,0x8f
ffffffffc02072f6:	5ee53503          	ld	a0,1518(a0) # ffffffffc02968e0 <rq>
ffffffffc02072fa:	9782                	jalr	a5
ffffffffc02072fc:	e491                	bnez	s1,ffffffffc0207308 <wakeup_proc+0x62>
ffffffffc02072fe:	60e2                	ld	ra,24(sp)
ffffffffc0207300:	6442                	ld	s0,16(sp)
ffffffffc0207302:	64a2                	ld	s1,8(sp)
ffffffffc0207304:	6105                	addi	sp,sp,32
ffffffffc0207306:	8082                	ret
ffffffffc0207308:	6442                	ld	s0,16(sp)
ffffffffc020730a:	60e2                	ld	ra,24(sp)
ffffffffc020730c:	64a2                	ld	s1,8(sp)
ffffffffc020730e:	6105                	addi	sp,sp,32
ffffffffc0207310:	95df906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207314:	00006617          	auipc	a2,0x6
ffffffffc0207318:	74c60613          	addi	a2,a2,1868 # ffffffffc020da60 <CSWTCH.79+0x688>
ffffffffc020731c:	05200593          	li	a1,82
ffffffffc0207320:	00006517          	auipc	a0,0x6
ffffffffc0207324:	72850513          	addi	a0,a0,1832 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc0207328:	9def90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020732c:	bfc1                	j	ffffffffc02072fc <wakeup_proc+0x56>
ffffffffc020732e:	945f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207332:	4018                	lw	a4,0(s0)
ffffffffc0207334:	4485                	li	s1,1
ffffffffc0207336:	b771                	j	ffffffffc02072c2 <wakeup_proc+0x1c>
ffffffffc0207338:	00006697          	auipc	a3,0x6
ffffffffc020733c:	6f068693          	addi	a3,a3,1776 # ffffffffc020da28 <CSWTCH.79+0x650>
ffffffffc0207340:	00004617          	auipc	a2,0x4
ffffffffc0207344:	66860613          	addi	a2,a2,1640 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207348:	04300593          	li	a1,67
ffffffffc020734c:	00006517          	auipc	a0,0x6
ffffffffc0207350:	6fc50513          	addi	a0,a0,1788 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc0207354:	94af90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207358 <schedule>:
ffffffffc0207358:	7179                	addi	sp,sp,-48
ffffffffc020735a:	f406                	sd	ra,40(sp)
ffffffffc020735c:	f022                	sd	s0,32(sp)
ffffffffc020735e:	ec26                	sd	s1,24(sp)
ffffffffc0207360:	e84a                	sd	s2,16(sp)
ffffffffc0207362:	e44e                	sd	s3,8(sp)
ffffffffc0207364:	e052                	sd	s4,0(sp)
ffffffffc0207366:	100027f3          	csrr	a5,sstatus
ffffffffc020736a:	8b89                	andi	a5,a5,2
ffffffffc020736c:	4a01                	li	s4,0
ffffffffc020736e:	e3cd                	bnez	a5,ffffffffc0207410 <schedule+0xb8>
ffffffffc0207370:	0008f497          	auipc	s1,0x8f
ffffffffc0207374:	55048493          	addi	s1,s1,1360 # ffffffffc02968c0 <current>
ffffffffc0207378:	608c                	ld	a1,0(s1)
ffffffffc020737a:	0008f997          	auipc	s3,0x8f
ffffffffc020737e:	56e98993          	addi	s3,s3,1390 # ffffffffc02968e8 <sched_class>
ffffffffc0207382:	0008f917          	auipc	s2,0x8f
ffffffffc0207386:	55e90913          	addi	s2,s2,1374 # ffffffffc02968e0 <rq>
ffffffffc020738a:	4194                	lw	a3,0(a1)
ffffffffc020738c:	0005bc23          	sd	zero,24(a1)
ffffffffc0207390:	4709                	li	a4,2
ffffffffc0207392:	0009b783          	ld	a5,0(s3)
ffffffffc0207396:	00093503          	ld	a0,0(s2)
ffffffffc020739a:	04e68e63          	beq	a3,a4,ffffffffc02073f6 <schedule+0x9e>
ffffffffc020739e:	739c                	ld	a5,32(a5)
ffffffffc02073a0:	9782                	jalr	a5
ffffffffc02073a2:	842a                	mv	s0,a0
ffffffffc02073a4:	c521                	beqz	a0,ffffffffc02073ec <schedule+0x94>
ffffffffc02073a6:	0009b783          	ld	a5,0(s3)
ffffffffc02073aa:	00093503          	ld	a0,0(s2)
ffffffffc02073ae:	85a2                	mv	a1,s0
ffffffffc02073b0:	6f9c                	ld	a5,24(a5)
ffffffffc02073b2:	9782                	jalr	a5
ffffffffc02073b4:	441c                	lw	a5,8(s0)
ffffffffc02073b6:	6098                	ld	a4,0(s1)
ffffffffc02073b8:	2785                	addiw	a5,a5,1
ffffffffc02073ba:	c41c                	sw	a5,8(s0)
ffffffffc02073bc:	00870563          	beq	a4,s0,ffffffffc02073c6 <schedule+0x6e>
ffffffffc02073c0:	8522                	mv	a0,s0
ffffffffc02073c2:	f80fe0ef          	jal	ra,ffffffffc0205b42 <proc_run>
ffffffffc02073c6:	000a1a63          	bnez	s4,ffffffffc02073da <schedule+0x82>
ffffffffc02073ca:	70a2                	ld	ra,40(sp)
ffffffffc02073cc:	7402                	ld	s0,32(sp)
ffffffffc02073ce:	64e2                	ld	s1,24(sp)
ffffffffc02073d0:	6942                	ld	s2,16(sp)
ffffffffc02073d2:	69a2                	ld	s3,8(sp)
ffffffffc02073d4:	6a02                	ld	s4,0(sp)
ffffffffc02073d6:	6145                	addi	sp,sp,48
ffffffffc02073d8:	8082                	ret
ffffffffc02073da:	7402                	ld	s0,32(sp)
ffffffffc02073dc:	70a2                	ld	ra,40(sp)
ffffffffc02073de:	64e2                	ld	s1,24(sp)
ffffffffc02073e0:	6942                	ld	s2,16(sp)
ffffffffc02073e2:	69a2                	ld	s3,8(sp)
ffffffffc02073e4:	6a02                	ld	s4,0(sp)
ffffffffc02073e6:	6145                	addi	sp,sp,48
ffffffffc02073e8:	885f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02073ec:	0008f417          	auipc	s0,0x8f
ffffffffc02073f0:	4dc43403          	ld	s0,1244(s0) # ffffffffc02968c8 <idleproc>
ffffffffc02073f4:	b7c1                	j	ffffffffc02073b4 <schedule+0x5c>
ffffffffc02073f6:	0008f717          	auipc	a4,0x8f
ffffffffc02073fa:	4d273703          	ld	a4,1234(a4) # ffffffffc02968c8 <idleproc>
ffffffffc02073fe:	fae580e3          	beq	a1,a4,ffffffffc020739e <schedule+0x46>
ffffffffc0207402:	6b9c                	ld	a5,16(a5)
ffffffffc0207404:	9782                	jalr	a5
ffffffffc0207406:	0009b783          	ld	a5,0(s3)
ffffffffc020740a:	00093503          	ld	a0,0(s2)
ffffffffc020740e:	bf41                	j	ffffffffc020739e <schedule+0x46>
ffffffffc0207410:	863f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207414:	4a05                	li	s4,1
ffffffffc0207416:	bfa9                	j	ffffffffc0207370 <schedule+0x18>

ffffffffc0207418 <add_timer>:
ffffffffc0207418:	1141                	addi	sp,sp,-16
ffffffffc020741a:	e022                	sd	s0,0(sp)
ffffffffc020741c:	e406                	sd	ra,8(sp)
ffffffffc020741e:	842a                	mv	s0,a0
ffffffffc0207420:	100027f3          	csrr	a5,sstatus
ffffffffc0207424:	8b89                	andi	a5,a5,2
ffffffffc0207426:	4501                	li	a0,0
ffffffffc0207428:	eba5                	bnez	a5,ffffffffc0207498 <add_timer+0x80>
ffffffffc020742a:	401c                	lw	a5,0(s0)
ffffffffc020742c:	cbb5                	beqz	a5,ffffffffc02074a0 <add_timer+0x88>
ffffffffc020742e:	6418                	ld	a4,8(s0)
ffffffffc0207430:	cb25                	beqz	a4,ffffffffc02074a0 <add_timer+0x88>
ffffffffc0207432:	6c18                	ld	a4,24(s0)
ffffffffc0207434:	01040593          	addi	a1,s0,16
ffffffffc0207438:	08e59463          	bne	a1,a4,ffffffffc02074c0 <add_timer+0xa8>
ffffffffc020743c:	0008e617          	auipc	a2,0x8e
ffffffffc0207440:	3b460613          	addi	a2,a2,948 # ffffffffc02957f0 <timer_list>
ffffffffc0207444:	6618                	ld	a4,8(a2)
ffffffffc0207446:	00c71863          	bne	a4,a2,ffffffffc0207456 <add_timer+0x3e>
ffffffffc020744a:	a80d                	j	ffffffffc020747c <add_timer+0x64>
ffffffffc020744c:	6718                	ld	a4,8(a4)
ffffffffc020744e:	9f95                	subw	a5,a5,a3
ffffffffc0207450:	c01c                	sw	a5,0(s0)
ffffffffc0207452:	02c70563          	beq	a4,a2,ffffffffc020747c <add_timer+0x64>
ffffffffc0207456:	ff072683          	lw	a3,-16(a4)
ffffffffc020745a:	fed7f9e3          	bgeu	a5,a3,ffffffffc020744c <add_timer+0x34>
ffffffffc020745e:	40f687bb          	subw	a5,a3,a5
ffffffffc0207462:	fef72823          	sw	a5,-16(a4)
ffffffffc0207466:	631c                	ld	a5,0(a4)
ffffffffc0207468:	e30c                	sd	a1,0(a4)
ffffffffc020746a:	e78c                	sd	a1,8(a5)
ffffffffc020746c:	ec18                	sd	a4,24(s0)
ffffffffc020746e:	e81c                	sd	a5,16(s0)
ffffffffc0207470:	c105                	beqz	a0,ffffffffc0207490 <add_timer+0x78>
ffffffffc0207472:	6402                	ld	s0,0(sp)
ffffffffc0207474:	60a2                	ld	ra,8(sp)
ffffffffc0207476:	0141                	addi	sp,sp,16
ffffffffc0207478:	ff4f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020747c:	0008e717          	auipc	a4,0x8e
ffffffffc0207480:	37470713          	addi	a4,a4,884 # ffffffffc02957f0 <timer_list>
ffffffffc0207484:	631c                	ld	a5,0(a4)
ffffffffc0207486:	e30c                	sd	a1,0(a4)
ffffffffc0207488:	e78c                	sd	a1,8(a5)
ffffffffc020748a:	ec18                	sd	a4,24(s0)
ffffffffc020748c:	e81c                	sd	a5,16(s0)
ffffffffc020748e:	f175                	bnez	a0,ffffffffc0207472 <add_timer+0x5a>
ffffffffc0207490:	60a2                	ld	ra,8(sp)
ffffffffc0207492:	6402                	ld	s0,0(sp)
ffffffffc0207494:	0141                	addi	sp,sp,16
ffffffffc0207496:	8082                	ret
ffffffffc0207498:	fdaf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020749c:	4505                	li	a0,1
ffffffffc020749e:	b771                	j	ffffffffc020742a <add_timer+0x12>
ffffffffc02074a0:	00006697          	auipc	a3,0x6
ffffffffc02074a4:	5e068693          	addi	a3,a3,1504 # ffffffffc020da80 <CSWTCH.79+0x6a8>
ffffffffc02074a8:	00004617          	auipc	a2,0x4
ffffffffc02074ac:	50060613          	addi	a2,a2,1280 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02074b0:	07a00593          	li	a1,122
ffffffffc02074b4:	00006517          	auipc	a0,0x6
ffffffffc02074b8:	59450513          	addi	a0,a0,1428 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc02074bc:	fe3f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02074c0:	00006697          	auipc	a3,0x6
ffffffffc02074c4:	5f068693          	addi	a3,a3,1520 # ffffffffc020dab0 <CSWTCH.79+0x6d8>
ffffffffc02074c8:	00004617          	auipc	a2,0x4
ffffffffc02074cc:	4e060613          	addi	a2,a2,1248 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02074d0:	07b00593          	li	a1,123
ffffffffc02074d4:	00006517          	auipc	a0,0x6
ffffffffc02074d8:	57450513          	addi	a0,a0,1396 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc02074dc:	fc3f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02074e0 <del_timer>:
ffffffffc02074e0:	1101                	addi	sp,sp,-32
ffffffffc02074e2:	e822                	sd	s0,16(sp)
ffffffffc02074e4:	ec06                	sd	ra,24(sp)
ffffffffc02074e6:	e426                	sd	s1,8(sp)
ffffffffc02074e8:	842a                	mv	s0,a0
ffffffffc02074ea:	100027f3          	csrr	a5,sstatus
ffffffffc02074ee:	8b89                	andi	a5,a5,2
ffffffffc02074f0:	01050493          	addi	s1,a0,16
ffffffffc02074f4:	eb9d                	bnez	a5,ffffffffc020752a <del_timer+0x4a>
ffffffffc02074f6:	6d1c                	ld	a5,24(a0)
ffffffffc02074f8:	02978463          	beq	a5,s1,ffffffffc0207520 <del_timer+0x40>
ffffffffc02074fc:	4114                	lw	a3,0(a0)
ffffffffc02074fe:	6918                	ld	a4,16(a0)
ffffffffc0207500:	ce81                	beqz	a3,ffffffffc0207518 <del_timer+0x38>
ffffffffc0207502:	0008e617          	auipc	a2,0x8e
ffffffffc0207506:	2ee60613          	addi	a2,a2,750 # ffffffffc02957f0 <timer_list>
ffffffffc020750a:	00c78763          	beq	a5,a2,ffffffffc0207518 <del_timer+0x38>
ffffffffc020750e:	ff07a603          	lw	a2,-16(a5)
ffffffffc0207512:	9eb1                	addw	a3,a3,a2
ffffffffc0207514:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207518:	e71c                	sd	a5,8(a4)
ffffffffc020751a:	e398                	sd	a4,0(a5)
ffffffffc020751c:	ec04                	sd	s1,24(s0)
ffffffffc020751e:	e804                	sd	s1,16(s0)
ffffffffc0207520:	60e2                	ld	ra,24(sp)
ffffffffc0207522:	6442                	ld	s0,16(sp)
ffffffffc0207524:	64a2                	ld	s1,8(sp)
ffffffffc0207526:	6105                	addi	sp,sp,32
ffffffffc0207528:	8082                	ret
ffffffffc020752a:	f48f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020752e:	6c1c                	ld	a5,24(s0)
ffffffffc0207530:	02978463          	beq	a5,s1,ffffffffc0207558 <del_timer+0x78>
ffffffffc0207534:	4014                	lw	a3,0(s0)
ffffffffc0207536:	6818                	ld	a4,16(s0)
ffffffffc0207538:	ce81                	beqz	a3,ffffffffc0207550 <del_timer+0x70>
ffffffffc020753a:	0008e617          	auipc	a2,0x8e
ffffffffc020753e:	2b660613          	addi	a2,a2,694 # ffffffffc02957f0 <timer_list>
ffffffffc0207542:	00c78763          	beq	a5,a2,ffffffffc0207550 <del_timer+0x70>
ffffffffc0207546:	ff07a603          	lw	a2,-16(a5)
ffffffffc020754a:	9eb1                	addw	a3,a3,a2
ffffffffc020754c:	fed7a823          	sw	a3,-16(a5)
ffffffffc0207550:	e71c                	sd	a5,8(a4)
ffffffffc0207552:	e398                	sd	a4,0(a5)
ffffffffc0207554:	ec04                	sd	s1,24(s0)
ffffffffc0207556:	e804                	sd	s1,16(s0)
ffffffffc0207558:	6442                	ld	s0,16(sp)
ffffffffc020755a:	60e2                	ld	ra,24(sp)
ffffffffc020755c:	64a2                	ld	s1,8(sp)
ffffffffc020755e:	6105                	addi	sp,sp,32
ffffffffc0207560:	f0cf906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc0207564 <run_timer_list>:
ffffffffc0207564:	7139                	addi	sp,sp,-64
ffffffffc0207566:	fc06                	sd	ra,56(sp)
ffffffffc0207568:	f822                	sd	s0,48(sp)
ffffffffc020756a:	f426                	sd	s1,40(sp)
ffffffffc020756c:	f04a                	sd	s2,32(sp)
ffffffffc020756e:	ec4e                	sd	s3,24(sp)
ffffffffc0207570:	e852                	sd	s4,16(sp)
ffffffffc0207572:	e456                	sd	s5,8(sp)
ffffffffc0207574:	e05a                	sd	s6,0(sp)
ffffffffc0207576:	100027f3          	csrr	a5,sstatus
ffffffffc020757a:	8b89                	andi	a5,a5,2
ffffffffc020757c:	4b01                	li	s6,0
ffffffffc020757e:	efe9                	bnez	a5,ffffffffc0207658 <run_timer_list+0xf4>
ffffffffc0207580:	0008e997          	auipc	s3,0x8e
ffffffffc0207584:	27098993          	addi	s3,s3,624 # ffffffffc02957f0 <timer_list>
ffffffffc0207588:	0089b403          	ld	s0,8(s3)
ffffffffc020758c:	07340a63          	beq	s0,s3,ffffffffc0207600 <run_timer_list+0x9c>
ffffffffc0207590:	ff042783          	lw	a5,-16(s0)
ffffffffc0207594:	ff040913          	addi	s2,s0,-16
ffffffffc0207598:	0e078763          	beqz	a5,ffffffffc0207686 <run_timer_list+0x122>
ffffffffc020759c:	fff7871b          	addiw	a4,a5,-1
ffffffffc02075a0:	fee42823          	sw	a4,-16(s0)
ffffffffc02075a4:	ef31                	bnez	a4,ffffffffc0207600 <run_timer_list+0x9c>
ffffffffc02075a6:	00006a97          	auipc	s5,0x6
ffffffffc02075aa:	572a8a93          	addi	s5,s5,1394 # ffffffffc020db18 <CSWTCH.79+0x740>
ffffffffc02075ae:	00006a17          	auipc	s4,0x6
ffffffffc02075b2:	49aa0a13          	addi	s4,s4,1178 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc02075b6:	a005                	j	ffffffffc02075d6 <run_timer_list+0x72>
ffffffffc02075b8:	0a07d763          	bgez	a5,ffffffffc0207666 <run_timer_list+0x102>
ffffffffc02075bc:	8526                	mv	a0,s1
ffffffffc02075be:	ce9ff0ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc02075c2:	854a                	mv	a0,s2
ffffffffc02075c4:	f1dff0ef          	jal	ra,ffffffffc02074e0 <del_timer>
ffffffffc02075c8:	03340c63          	beq	s0,s3,ffffffffc0207600 <run_timer_list+0x9c>
ffffffffc02075cc:	ff042783          	lw	a5,-16(s0)
ffffffffc02075d0:	ff040913          	addi	s2,s0,-16
ffffffffc02075d4:	e795                	bnez	a5,ffffffffc0207600 <run_timer_list+0x9c>
ffffffffc02075d6:	00893483          	ld	s1,8(s2)
ffffffffc02075da:	6400                	ld	s0,8(s0)
ffffffffc02075dc:	0ec4a783          	lw	a5,236(s1)
ffffffffc02075e0:	ffe1                	bnez	a5,ffffffffc02075b8 <run_timer_list+0x54>
ffffffffc02075e2:	40d4                	lw	a3,4(s1)
ffffffffc02075e4:	8656                	mv	a2,s5
ffffffffc02075e6:	0ba00593          	li	a1,186
ffffffffc02075ea:	8552                	mv	a0,s4
ffffffffc02075ec:	f1bf80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02075f0:	8526                	mv	a0,s1
ffffffffc02075f2:	cb5ff0ef          	jal	ra,ffffffffc02072a6 <wakeup_proc>
ffffffffc02075f6:	854a                	mv	a0,s2
ffffffffc02075f8:	ee9ff0ef          	jal	ra,ffffffffc02074e0 <del_timer>
ffffffffc02075fc:	fd3418e3          	bne	s0,s3,ffffffffc02075cc <run_timer_list+0x68>
ffffffffc0207600:	0008f597          	auipc	a1,0x8f
ffffffffc0207604:	2c05b583          	ld	a1,704(a1) # ffffffffc02968c0 <current>
ffffffffc0207608:	c18d                	beqz	a1,ffffffffc020762a <run_timer_list+0xc6>
ffffffffc020760a:	0008f797          	auipc	a5,0x8f
ffffffffc020760e:	2be7b783          	ld	a5,702(a5) # ffffffffc02968c8 <idleproc>
ffffffffc0207612:	04f58763          	beq	a1,a5,ffffffffc0207660 <run_timer_list+0xfc>
ffffffffc0207616:	0008f797          	auipc	a5,0x8f
ffffffffc020761a:	2d27b783          	ld	a5,722(a5) # ffffffffc02968e8 <sched_class>
ffffffffc020761e:	779c                	ld	a5,40(a5)
ffffffffc0207620:	0008f517          	auipc	a0,0x8f
ffffffffc0207624:	2c053503          	ld	a0,704(a0) # ffffffffc02968e0 <rq>
ffffffffc0207628:	9782                	jalr	a5
ffffffffc020762a:	000b1c63          	bnez	s6,ffffffffc0207642 <run_timer_list+0xde>
ffffffffc020762e:	70e2                	ld	ra,56(sp)
ffffffffc0207630:	7442                	ld	s0,48(sp)
ffffffffc0207632:	74a2                	ld	s1,40(sp)
ffffffffc0207634:	7902                	ld	s2,32(sp)
ffffffffc0207636:	69e2                	ld	s3,24(sp)
ffffffffc0207638:	6a42                	ld	s4,16(sp)
ffffffffc020763a:	6aa2                	ld	s5,8(sp)
ffffffffc020763c:	6b02                	ld	s6,0(sp)
ffffffffc020763e:	6121                	addi	sp,sp,64
ffffffffc0207640:	8082                	ret
ffffffffc0207642:	7442                	ld	s0,48(sp)
ffffffffc0207644:	70e2                	ld	ra,56(sp)
ffffffffc0207646:	74a2                	ld	s1,40(sp)
ffffffffc0207648:	7902                	ld	s2,32(sp)
ffffffffc020764a:	69e2                	ld	s3,24(sp)
ffffffffc020764c:	6a42                	ld	s4,16(sp)
ffffffffc020764e:	6aa2                	ld	s5,8(sp)
ffffffffc0207650:	6b02                	ld	s6,0(sp)
ffffffffc0207652:	6121                	addi	sp,sp,64
ffffffffc0207654:	e18f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207658:	e1af90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020765c:	4b05                	li	s6,1
ffffffffc020765e:	b70d                	j	ffffffffc0207580 <run_timer_list+0x1c>
ffffffffc0207660:	4785                	li	a5,1
ffffffffc0207662:	ed9c                	sd	a5,24(a1)
ffffffffc0207664:	b7d9                	j	ffffffffc020762a <run_timer_list+0xc6>
ffffffffc0207666:	00006697          	auipc	a3,0x6
ffffffffc020766a:	48a68693          	addi	a3,a3,1162 # ffffffffc020daf0 <CSWTCH.79+0x718>
ffffffffc020766e:	00004617          	auipc	a2,0x4
ffffffffc0207672:	33a60613          	addi	a2,a2,826 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207676:	0b600593          	li	a1,182
ffffffffc020767a:	00006517          	auipc	a0,0x6
ffffffffc020767e:	3ce50513          	addi	a0,a0,974 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc0207682:	e1df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207686:	00006697          	auipc	a3,0x6
ffffffffc020768a:	45268693          	addi	a3,a3,1106 # ffffffffc020dad8 <CSWTCH.79+0x700>
ffffffffc020768e:	00004617          	auipc	a2,0x4
ffffffffc0207692:	31a60613          	addi	a2,a2,794 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207696:	0ae00593          	li	a1,174
ffffffffc020769a:	00006517          	auipc	a0,0x6
ffffffffc020769e:	3ae50513          	addi	a0,a0,942 # ffffffffc020da48 <CSWTCH.79+0x670>
ffffffffc02076a2:	dfdf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076a6 <sys_getpid>:
ffffffffc02076a6:	0008f797          	auipc	a5,0x8f
ffffffffc02076aa:	21a7b783          	ld	a5,538(a5) # ffffffffc02968c0 <current>
ffffffffc02076ae:	43c8                	lw	a0,4(a5)
ffffffffc02076b0:	8082                	ret

ffffffffc02076b2 <sys_pgdir>:
ffffffffc02076b2:	4501                	li	a0,0
ffffffffc02076b4:	8082                	ret

ffffffffc02076b6 <sys_gettime>:
ffffffffc02076b6:	0008f797          	auipc	a5,0x8f
ffffffffc02076ba:	1ba7b783          	ld	a5,442(a5) # ffffffffc0296870 <ticks>
ffffffffc02076be:	0027951b          	slliw	a0,a5,0x2
ffffffffc02076c2:	9d3d                	addw	a0,a0,a5
ffffffffc02076c4:	0015151b          	slliw	a0,a0,0x1
ffffffffc02076c8:	8082                	ret

ffffffffc02076ca <sys_lab6_set_priority>:
ffffffffc02076ca:	4108                	lw	a0,0(a0)
ffffffffc02076cc:	1141                	addi	sp,sp,-16
ffffffffc02076ce:	e406                	sd	ra,8(sp)
ffffffffc02076d0:	975ff0ef          	jal	ra,ffffffffc0207044 <lab6_set_priority>
ffffffffc02076d4:	60a2                	ld	ra,8(sp)
ffffffffc02076d6:	4501                	li	a0,0
ffffffffc02076d8:	0141                	addi	sp,sp,16
ffffffffc02076da:	8082                	ret

ffffffffc02076dc <sys_dup>:
ffffffffc02076dc:	450c                	lw	a1,8(a0)
ffffffffc02076de:	4108                	lw	a0,0(a0)
ffffffffc02076e0:	b38fe06f          	j	ffffffffc0205a18 <sysfile_dup>

ffffffffc02076e4 <sys_getdirentry>:
ffffffffc02076e4:	650c                	ld	a1,8(a0)
ffffffffc02076e6:	4108                	lw	a0,0(a0)
ffffffffc02076e8:	a40fe06f          	j	ffffffffc0205928 <sysfile_getdirentry>

ffffffffc02076ec <sys_getcwd>:
ffffffffc02076ec:	650c                	ld	a1,8(a0)
ffffffffc02076ee:	6108                	ld	a0,0(a0)
ffffffffc02076f0:	994fe06f          	j	ffffffffc0205884 <sysfile_getcwd>

ffffffffc02076f4 <sys_fsync>:
ffffffffc02076f4:	4108                	lw	a0,0(a0)
ffffffffc02076f6:	98afe06f          	j	ffffffffc0205880 <sysfile_fsync>

ffffffffc02076fa <sys_fstat>:
ffffffffc02076fa:	650c                	ld	a1,8(a0)
ffffffffc02076fc:	4108                	lw	a0,0(a0)
ffffffffc02076fe:	8e2fe06f          	j	ffffffffc02057e0 <sysfile_fstat>

ffffffffc0207702 <sys_seek>:
ffffffffc0207702:	4910                	lw	a2,16(a0)
ffffffffc0207704:	650c                	ld	a1,8(a0)
ffffffffc0207706:	4108                	lw	a0,0(a0)
ffffffffc0207708:	8d4fe06f          	j	ffffffffc02057dc <sysfile_seek>

ffffffffc020770c <sys_write>:
ffffffffc020770c:	6910                	ld	a2,16(a0)
ffffffffc020770e:	650c                	ld	a1,8(a0)
ffffffffc0207710:	4108                	lw	a0,0(a0)
ffffffffc0207712:	fb1fd06f          	j	ffffffffc02056c2 <sysfile_write>

ffffffffc0207716 <sys_read>:
ffffffffc0207716:	6910                	ld	a2,16(a0)
ffffffffc0207718:	650c                	ld	a1,8(a0)
ffffffffc020771a:	4108                	lw	a0,0(a0)
ffffffffc020771c:	e93fd06f          	j	ffffffffc02055ae <sysfile_read>

ffffffffc0207720 <sys_close>:
ffffffffc0207720:	4108                	lw	a0,0(a0)
ffffffffc0207722:	e89fd06f          	j	ffffffffc02055aa <sysfile_close>

ffffffffc0207726 <sys_open>:
ffffffffc0207726:	450c                	lw	a1,8(a0)
ffffffffc0207728:	6108                	ld	a0,0(a0)
ffffffffc020772a:	e4dfd06f          	j	ffffffffc0205576 <sysfile_open>

ffffffffc020772e <sys_putc>:
ffffffffc020772e:	4108                	lw	a0,0(a0)
ffffffffc0207730:	1141                	addi	sp,sp,-16
ffffffffc0207732:	e406                	sd	ra,8(sp)
ffffffffc0207734:	aaff80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0207738:	60a2                	ld	ra,8(sp)
ffffffffc020773a:	4501                	li	a0,0
ffffffffc020773c:	0141                	addi	sp,sp,16
ffffffffc020773e:	8082                	ret

ffffffffc0207740 <sys_kill>:
ffffffffc0207740:	4108                	lw	a0,0(a0)
ffffffffc0207742:	ea0ff06f          	j	ffffffffc0206de2 <do_kill>

ffffffffc0207746 <sys_sleep>:
ffffffffc0207746:	4108                	lw	a0,0(a0)
ffffffffc0207748:	937ff06f          	j	ffffffffc020707e <do_sleep>

ffffffffc020774c <sys_yield>:
ffffffffc020774c:	e48ff06f          	j	ffffffffc0206d94 <do_yield>

ffffffffc0207750 <sys_exec>:
ffffffffc0207750:	6910                	ld	a2,16(a0)
ffffffffc0207752:	450c                	lw	a1,8(a0)
ffffffffc0207754:	6108                	ld	a0,0(a0)
ffffffffc0207756:	d75fe06f          	j	ffffffffc02064ca <do_execve>

ffffffffc020775a <sys_wait>:
ffffffffc020775a:	650c                	ld	a1,8(a0)
ffffffffc020775c:	4108                	lw	a0,0(a0)
ffffffffc020775e:	e46ff06f          	j	ffffffffc0206da4 <do_wait>

ffffffffc0207762 <sys_fork>:
ffffffffc0207762:	0008f797          	auipc	a5,0x8f
ffffffffc0207766:	15e7b783          	ld	a5,350(a5) # ffffffffc02968c0 <current>
ffffffffc020776a:	73d0                	ld	a2,160(a5)
ffffffffc020776c:	4501                	li	a0,0
ffffffffc020776e:	6a0c                	ld	a1,16(a2)
ffffffffc0207770:	c42fe06f          	j	ffffffffc0205bb2 <do_fork>

ffffffffc0207774 <sys_exit>:
ffffffffc0207774:	4108                	lw	a0,0(a0)
ffffffffc0207776:	8d1fe06f          	j	ffffffffc0206046 <do_exit>

ffffffffc020777a <syscall>:
ffffffffc020777a:	715d                	addi	sp,sp,-80
ffffffffc020777c:	fc26                	sd	s1,56(sp)
ffffffffc020777e:	0008f497          	auipc	s1,0x8f
ffffffffc0207782:	14248493          	addi	s1,s1,322 # ffffffffc02968c0 <current>
ffffffffc0207786:	6098                	ld	a4,0(s1)
ffffffffc0207788:	e0a2                	sd	s0,64(sp)
ffffffffc020778a:	f84a                	sd	s2,48(sp)
ffffffffc020778c:	7340                	ld	s0,160(a4)
ffffffffc020778e:	e486                	sd	ra,72(sp)
ffffffffc0207790:	0ff00793          	li	a5,255
ffffffffc0207794:	05042903          	lw	s2,80(s0)
ffffffffc0207798:	0327ee63          	bltu	a5,s2,ffffffffc02077d4 <syscall+0x5a>
ffffffffc020779c:	00391713          	slli	a4,s2,0x3
ffffffffc02077a0:	00006797          	auipc	a5,0x6
ffffffffc02077a4:	3e078793          	addi	a5,a5,992 # ffffffffc020db80 <syscalls>
ffffffffc02077a8:	97ba                	add	a5,a5,a4
ffffffffc02077aa:	639c                	ld	a5,0(a5)
ffffffffc02077ac:	c785                	beqz	a5,ffffffffc02077d4 <syscall+0x5a>
ffffffffc02077ae:	6c28                	ld	a0,88(s0)
ffffffffc02077b0:	702c                	ld	a1,96(s0)
ffffffffc02077b2:	7430                	ld	a2,104(s0)
ffffffffc02077b4:	7834                	ld	a3,112(s0)
ffffffffc02077b6:	7c38                	ld	a4,120(s0)
ffffffffc02077b8:	e42a                	sd	a0,8(sp)
ffffffffc02077ba:	e82e                	sd	a1,16(sp)
ffffffffc02077bc:	ec32                	sd	a2,24(sp)
ffffffffc02077be:	f036                	sd	a3,32(sp)
ffffffffc02077c0:	f43a                	sd	a4,40(sp)
ffffffffc02077c2:	0028                	addi	a0,sp,8
ffffffffc02077c4:	9782                	jalr	a5
ffffffffc02077c6:	60a6                	ld	ra,72(sp)
ffffffffc02077c8:	e828                	sd	a0,80(s0)
ffffffffc02077ca:	6406                	ld	s0,64(sp)
ffffffffc02077cc:	74e2                	ld	s1,56(sp)
ffffffffc02077ce:	7942                	ld	s2,48(sp)
ffffffffc02077d0:	6161                	addi	sp,sp,80
ffffffffc02077d2:	8082                	ret
ffffffffc02077d4:	8522                	mv	a0,s0
ffffffffc02077d6:	fb4f90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc02077da:	609c                	ld	a5,0(s1)
ffffffffc02077dc:	86ca                	mv	a3,s2
ffffffffc02077de:	00006617          	auipc	a2,0x6
ffffffffc02077e2:	35a60613          	addi	a2,a2,858 # ffffffffc020db38 <CSWTCH.79+0x760>
ffffffffc02077e6:	43d8                	lw	a4,4(a5)
ffffffffc02077e8:	0d800593          	li	a1,216
ffffffffc02077ec:	0b478793          	addi	a5,a5,180
ffffffffc02077f0:	00006517          	auipc	a0,0x6
ffffffffc02077f4:	37850513          	addi	a0,a0,888 # ffffffffc020db68 <CSWTCH.79+0x790>
ffffffffc02077f8:	ca7f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02077fc <__alloc_inode>:
ffffffffc02077fc:	1141                	addi	sp,sp,-16
ffffffffc02077fe:	e022                	sd	s0,0(sp)
ffffffffc0207800:	842a                	mv	s0,a0
ffffffffc0207802:	07800513          	li	a0,120
ffffffffc0207806:	e406                	sd	ra,8(sp)
ffffffffc0207808:	fd6fa0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020780c:	c111                	beqz	a0,ffffffffc0207810 <__alloc_inode+0x14>
ffffffffc020780e:	cd20                	sw	s0,88(a0)
ffffffffc0207810:	60a2                	ld	ra,8(sp)
ffffffffc0207812:	6402                	ld	s0,0(sp)
ffffffffc0207814:	0141                	addi	sp,sp,16
ffffffffc0207816:	8082                	ret

ffffffffc0207818 <inode_init>:
ffffffffc0207818:	4785                	li	a5,1
ffffffffc020781a:	06052023          	sw	zero,96(a0)
ffffffffc020781e:	f92c                	sd	a1,112(a0)
ffffffffc0207820:	f530                	sd	a2,104(a0)
ffffffffc0207822:	cd7c                	sw	a5,92(a0)
ffffffffc0207824:	8082                	ret

ffffffffc0207826 <inode_kill>:
ffffffffc0207826:	4d78                	lw	a4,92(a0)
ffffffffc0207828:	1141                	addi	sp,sp,-16
ffffffffc020782a:	e406                	sd	ra,8(sp)
ffffffffc020782c:	e719                	bnez	a4,ffffffffc020783a <inode_kill+0x14>
ffffffffc020782e:	513c                	lw	a5,96(a0)
ffffffffc0207830:	e78d                	bnez	a5,ffffffffc020785a <inode_kill+0x34>
ffffffffc0207832:	60a2                	ld	ra,8(sp)
ffffffffc0207834:	0141                	addi	sp,sp,16
ffffffffc0207836:	859fa06f          	j	ffffffffc020208e <kfree>
ffffffffc020783a:	00007697          	auipc	a3,0x7
ffffffffc020783e:	b4668693          	addi	a3,a3,-1210 # ffffffffc020e380 <syscalls+0x800>
ffffffffc0207842:	00004617          	auipc	a2,0x4
ffffffffc0207846:	16660613          	addi	a2,a2,358 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020784a:	02900593          	li	a1,41
ffffffffc020784e:	00007517          	auipc	a0,0x7
ffffffffc0207852:	b5250513          	addi	a0,a0,-1198 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207856:	c49f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020785a:	00007697          	auipc	a3,0x7
ffffffffc020785e:	b5e68693          	addi	a3,a3,-1186 # ffffffffc020e3b8 <syscalls+0x838>
ffffffffc0207862:	00004617          	auipc	a2,0x4
ffffffffc0207866:	14660613          	addi	a2,a2,326 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020786a:	02a00593          	li	a1,42
ffffffffc020786e:	00007517          	auipc	a0,0x7
ffffffffc0207872:	b3250513          	addi	a0,a0,-1230 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207876:	c29f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020787a <inode_ref_inc>:
ffffffffc020787a:	4d7c                	lw	a5,92(a0)
ffffffffc020787c:	2785                	addiw	a5,a5,1
ffffffffc020787e:	cd7c                	sw	a5,92(a0)
ffffffffc0207880:	0007851b          	sext.w	a0,a5
ffffffffc0207884:	8082                	ret

ffffffffc0207886 <inode_open_inc>:
ffffffffc0207886:	513c                	lw	a5,96(a0)
ffffffffc0207888:	2785                	addiw	a5,a5,1
ffffffffc020788a:	d13c                	sw	a5,96(a0)
ffffffffc020788c:	0007851b          	sext.w	a0,a5
ffffffffc0207890:	8082                	ret

ffffffffc0207892 <inode_check>:
ffffffffc0207892:	1141                	addi	sp,sp,-16
ffffffffc0207894:	e406                	sd	ra,8(sp)
ffffffffc0207896:	c90d                	beqz	a0,ffffffffc02078c8 <inode_check+0x36>
ffffffffc0207898:	793c                	ld	a5,112(a0)
ffffffffc020789a:	c79d                	beqz	a5,ffffffffc02078c8 <inode_check+0x36>
ffffffffc020789c:	6398                	ld	a4,0(a5)
ffffffffc020789e:	4625d7b7          	lui	a5,0x4625d
ffffffffc02078a2:	0786                	slli	a5,a5,0x1
ffffffffc02078a4:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc02078a8:	08f71063          	bne	a4,a5,ffffffffc0207928 <inode_check+0x96>
ffffffffc02078ac:	4d78                	lw	a4,92(a0)
ffffffffc02078ae:	513c                	lw	a5,96(a0)
ffffffffc02078b0:	04f74c63          	blt	a4,a5,ffffffffc0207908 <inode_check+0x76>
ffffffffc02078b4:	0407ca63          	bltz	a5,ffffffffc0207908 <inode_check+0x76>
ffffffffc02078b8:	66c1                	lui	a3,0x10
ffffffffc02078ba:	02d75763          	bge	a4,a3,ffffffffc02078e8 <inode_check+0x56>
ffffffffc02078be:	02d7d563          	bge	a5,a3,ffffffffc02078e8 <inode_check+0x56>
ffffffffc02078c2:	60a2                	ld	ra,8(sp)
ffffffffc02078c4:	0141                	addi	sp,sp,16
ffffffffc02078c6:	8082                	ret
ffffffffc02078c8:	00007697          	auipc	a3,0x7
ffffffffc02078cc:	b1068693          	addi	a3,a3,-1264 # ffffffffc020e3d8 <syscalls+0x858>
ffffffffc02078d0:	00004617          	auipc	a2,0x4
ffffffffc02078d4:	0d860613          	addi	a2,a2,216 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02078d8:	06e00593          	li	a1,110
ffffffffc02078dc:	00007517          	auipc	a0,0x7
ffffffffc02078e0:	ac450513          	addi	a0,a0,-1340 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc02078e4:	bbbf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02078e8:	00007697          	auipc	a3,0x7
ffffffffc02078ec:	b7068693          	addi	a3,a3,-1168 # ffffffffc020e458 <syscalls+0x8d8>
ffffffffc02078f0:	00004617          	auipc	a2,0x4
ffffffffc02078f4:	0b860613          	addi	a2,a2,184 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02078f8:	07200593          	li	a1,114
ffffffffc02078fc:	00007517          	auipc	a0,0x7
ffffffffc0207900:	aa450513          	addi	a0,a0,-1372 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207904:	b9bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207908:	00007697          	auipc	a3,0x7
ffffffffc020790c:	b2068693          	addi	a3,a3,-1248 # ffffffffc020e428 <syscalls+0x8a8>
ffffffffc0207910:	00004617          	auipc	a2,0x4
ffffffffc0207914:	09860613          	addi	a2,a2,152 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207918:	07100593          	li	a1,113
ffffffffc020791c:	00007517          	auipc	a0,0x7
ffffffffc0207920:	a8450513          	addi	a0,a0,-1404 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207924:	b7bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207928:	00007697          	auipc	a3,0x7
ffffffffc020792c:	ad868693          	addi	a3,a3,-1320 # ffffffffc020e400 <syscalls+0x880>
ffffffffc0207930:	00004617          	auipc	a2,0x4
ffffffffc0207934:	07860613          	addi	a2,a2,120 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207938:	06f00593          	li	a1,111
ffffffffc020793c:	00007517          	auipc	a0,0x7
ffffffffc0207940:	a6450513          	addi	a0,a0,-1436 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207944:	b5bf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207948 <inode_ref_dec>:
ffffffffc0207948:	4d7c                	lw	a5,92(a0)
ffffffffc020794a:	1101                	addi	sp,sp,-32
ffffffffc020794c:	ec06                	sd	ra,24(sp)
ffffffffc020794e:	e822                	sd	s0,16(sp)
ffffffffc0207950:	e426                	sd	s1,8(sp)
ffffffffc0207952:	e04a                	sd	s2,0(sp)
ffffffffc0207954:	06f05e63          	blez	a5,ffffffffc02079d0 <inode_ref_dec+0x88>
ffffffffc0207958:	fff7849b          	addiw	s1,a5,-1
ffffffffc020795c:	cd64                	sw	s1,92(a0)
ffffffffc020795e:	842a                	mv	s0,a0
ffffffffc0207960:	e09d                	bnez	s1,ffffffffc0207986 <inode_ref_dec+0x3e>
ffffffffc0207962:	793c                	ld	a5,112(a0)
ffffffffc0207964:	c7b1                	beqz	a5,ffffffffc02079b0 <inode_ref_dec+0x68>
ffffffffc0207966:	0487b903          	ld	s2,72(a5)
ffffffffc020796a:	04090363          	beqz	s2,ffffffffc02079b0 <inode_ref_dec+0x68>
ffffffffc020796e:	00007597          	auipc	a1,0x7
ffffffffc0207972:	b9a58593          	addi	a1,a1,-1126 # ffffffffc020e508 <syscalls+0x988>
ffffffffc0207976:	f1dff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020797a:	8522                	mv	a0,s0
ffffffffc020797c:	9902                	jalr	s2
ffffffffc020797e:	c501                	beqz	a0,ffffffffc0207986 <inode_ref_dec+0x3e>
ffffffffc0207980:	57c5                	li	a5,-15
ffffffffc0207982:	00f51963          	bne	a0,a5,ffffffffc0207994 <inode_ref_dec+0x4c>
ffffffffc0207986:	60e2                	ld	ra,24(sp)
ffffffffc0207988:	6442                	ld	s0,16(sp)
ffffffffc020798a:	6902                	ld	s2,0(sp)
ffffffffc020798c:	8526                	mv	a0,s1
ffffffffc020798e:	64a2                	ld	s1,8(sp)
ffffffffc0207990:	6105                	addi	sp,sp,32
ffffffffc0207992:	8082                	ret
ffffffffc0207994:	85aa                	mv	a1,a0
ffffffffc0207996:	00007517          	auipc	a0,0x7
ffffffffc020799a:	b7a50513          	addi	a0,a0,-1158 # ffffffffc020e510 <syscalls+0x990>
ffffffffc020799e:	809f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02079a2:	60e2                	ld	ra,24(sp)
ffffffffc02079a4:	6442                	ld	s0,16(sp)
ffffffffc02079a6:	6902                	ld	s2,0(sp)
ffffffffc02079a8:	8526                	mv	a0,s1
ffffffffc02079aa:	64a2                	ld	s1,8(sp)
ffffffffc02079ac:	6105                	addi	sp,sp,32
ffffffffc02079ae:	8082                	ret
ffffffffc02079b0:	00007697          	auipc	a3,0x7
ffffffffc02079b4:	b0868693          	addi	a3,a3,-1272 # ffffffffc020e4b8 <syscalls+0x938>
ffffffffc02079b8:	00004617          	auipc	a2,0x4
ffffffffc02079bc:	ff060613          	addi	a2,a2,-16 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02079c0:	04400593          	li	a1,68
ffffffffc02079c4:	00007517          	auipc	a0,0x7
ffffffffc02079c8:	9dc50513          	addi	a0,a0,-1572 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc02079cc:	ad3f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02079d0:	00007697          	auipc	a3,0x7
ffffffffc02079d4:	ac868693          	addi	a3,a3,-1336 # ffffffffc020e498 <syscalls+0x918>
ffffffffc02079d8:	00004617          	auipc	a2,0x4
ffffffffc02079dc:	fd060613          	addi	a2,a2,-48 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02079e0:	03f00593          	li	a1,63
ffffffffc02079e4:	00007517          	auipc	a0,0x7
ffffffffc02079e8:	9bc50513          	addi	a0,a0,-1604 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc02079ec:	ab3f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02079f0 <inode_open_dec>:
ffffffffc02079f0:	513c                	lw	a5,96(a0)
ffffffffc02079f2:	1101                	addi	sp,sp,-32
ffffffffc02079f4:	ec06                	sd	ra,24(sp)
ffffffffc02079f6:	e822                	sd	s0,16(sp)
ffffffffc02079f8:	e426                	sd	s1,8(sp)
ffffffffc02079fa:	e04a                	sd	s2,0(sp)
ffffffffc02079fc:	06f05b63          	blez	a5,ffffffffc0207a72 <inode_open_dec+0x82>
ffffffffc0207a00:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207a04:	d124                	sw	s1,96(a0)
ffffffffc0207a06:	842a                	mv	s0,a0
ffffffffc0207a08:	e085                	bnez	s1,ffffffffc0207a28 <inode_open_dec+0x38>
ffffffffc0207a0a:	793c                	ld	a5,112(a0)
ffffffffc0207a0c:	c3b9                	beqz	a5,ffffffffc0207a52 <inode_open_dec+0x62>
ffffffffc0207a0e:	0107b903          	ld	s2,16(a5)
ffffffffc0207a12:	04090063          	beqz	s2,ffffffffc0207a52 <inode_open_dec+0x62>
ffffffffc0207a16:	00007597          	auipc	a1,0x7
ffffffffc0207a1a:	b8a58593          	addi	a1,a1,-1142 # ffffffffc020e5a0 <syscalls+0xa20>
ffffffffc0207a1e:	e75ff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0207a22:	8522                	mv	a0,s0
ffffffffc0207a24:	9902                	jalr	s2
ffffffffc0207a26:	e901                	bnez	a0,ffffffffc0207a36 <inode_open_dec+0x46>
ffffffffc0207a28:	60e2                	ld	ra,24(sp)
ffffffffc0207a2a:	6442                	ld	s0,16(sp)
ffffffffc0207a2c:	6902                	ld	s2,0(sp)
ffffffffc0207a2e:	8526                	mv	a0,s1
ffffffffc0207a30:	64a2                	ld	s1,8(sp)
ffffffffc0207a32:	6105                	addi	sp,sp,32
ffffffffc0207a34:	8082                	ret
ffffffffc0207a36:	85aa                	mv	a1,a0
ffffffffc0207a38:	00007517          	auipc	a0,0x7
ffffffffc0207a3c:	b7050513          	addi	a0,a0,-1168 # ffffffffc020e5a8 <syscalls+0xa28>
ffffffffc0207a40:	f66f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207a44:	60e2                	ld	ra,24(sp)
ffffffffc0207a46:	6442                	ld	s0,16(sp)
ffffffffc0207a48:	6902                	ld	s2,0(sp)
ffffffffc0207a4a:	8526                	mv	a0,s1
ffffffffc0207a4c:	64a2                	ld	s1,8(sp)
ffffffffc0207a4e:	6105                	addi	sp,sp,32
ffffffffc0207a50:	8082                	ret
ffffffffc0207a52:	00007697          	auipc	a3,0x7
ffffffffc0207a56:	afe68693          	addi	a3,a3,-1282 # ffffffffc020e550 <syscalls+0x9d0>
ffffffffc0207a5a:	00004617          	auipc	a2,0x4
ffffffffc0207a5e:	f4e60613          	addi	a2,a2,-178 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207a62:	06100593          	li	a1,97
ffffffffc0207a66:	00007517          	auipc	a0,0x7
ffffffffc0207a6a:	93a50513          	addi	a0,a0,-1734 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207a6e:	a31f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a72:	00007697          	auipc	a3,0x7
ffffffffc0207a76:	abe68693          	addi	a3,a3,-1346 # ffffffffc020e530 <syscalls+0x9b0>
ffffffffc0207a7a:	00004617          	auipc	a2,0x4
ffffffffc0207a7e:	f2e60613          	addi	a2,a2,-210 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207a82:	05c00593          	li	a1,92
ffffffffc0207a86:	00007517          	auipc	a0,0x7
ffffffffc0207a8a:	91a50513          	addi	a0,a0,-1766 # ffffffffc020e3a0 <syscalls+0x820>
ffffffffc0207a8e:	a11f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a92 <__alloc_fs>:
ffffffffc0207a92:	1141                	addi	sp,sp,-16
ffffffffc0207a94:	e022                	sd	s0,0(sp)
ffffffffc0207a96:	842a                	mv	s0,a0
ffffffffc0207a98:	0d800513          	li	a0,216
ffffffffc0207a9c:	e406                	sd	ra,8(sp)
ffffffffc0207a9e:	d40fa0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0207aa2:	c119                	beqz	a0,ffffffffc0207aa8 <__alloc_fs+0x16>
ffffffffc0207aa4:	0a852823          	sw	s0,176(a0)
ffffffffc0207aa8:	60a2                	ld	ra,8(sp)
ffffffffc0207aaa:	6402                	ld	s0,0(sp)
ffffffffc0207aac:	0141                	addi	sp,sp,16
ffffffffc0207aae:	8082                	ret

ffffffffc0207ab0 <vfs_init>:
ffffffffc0207ab0:	1141                	addi	sp,sp,-16
ffffffffc0207ab2:	4585                	li	a1,1
ffffffffc0207ab4:	0008e517          	auipc	a0,0x8e
ffffffffc0207ab8:	d4c50513          	addi	a0,a0,-692 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207abc:	e406                	sd	ra,8(sp)
ffffffffc0207abe:	aedfc0ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0207ac2:	60a2                	ld	ra,8(sp)
ffffffffc0207ac4:	0141                	addi	sp,sp,16
ffffffffc0207ac6:	a40d                	j	ffffffffc0207ce8 <vfs_devlist_init>

ffffffffc0207ac8 <vfs_set_bootfs>:
ffffffffc0207ac8:	7179                	addi	sp,sp,-48
ffffffffc0207aca:	f022                	sd	s0,32(sp)
ffffffffc0207acc:	f406                	sd	ra,40(sp)
ffffffffc0207ace:	ec26                	sd	s1,24(sp)
ffffffffc0207ad0:	e402                	sd	zero,8(sp)
ffffffffc0207ad2:	842a                	mv	s0,a0
ffffffffc0207ad4:	c915                	beqz	a0,ffffffffc0207b08 <vfs_set_bootfs+0x40>
ffffffffc0207ad6:	03a00593          	li	a1,58
ffffffffc0207ada:	1d5030ef          	jal	ra,ffffffffc020b4ae <strchr>
ffffffffc0207ade:	c135                	beqz	a0,ffffffffc0207b42 <vfs_set_bootfs+0x7a>
ffffffffc0207ae0:	00154783          	lbu	a5,1(a0)
ffffffffc0207ae4:	efb9                	bnez	a5,ffffffffc0207b42 <vfs_set_bootfs+0x7a>
ffffffffc0207ae6:	8522                	mv	a0,s0
ffffffffc0207ae8:	11f000ef          	jal	ra,ffffffffc0208406 <vfs_chdir>
ffffffffc0207aec:	842a                	mv	s0,a0
ffffffffc0207aee:	c519                	beqz	a0,ffffffffc0207afc <vfs_set_bootfs+0x34>
ffffffffc0207af0:	70a2                	ld	ra,40(sp)
ffffffffc0207af2:	8522                	mv	a0,s0
ffffffffc0207af4:	7402                	ld	s0,32(sp)
ffffffffc0207af6:	64e2                	ld	s1,24(sp)
ffffffffc0207af8:	6145                	addi	sp,sp,48
ffffffffc0207afa:	8082                	ret
ffffffffc0207afc:	0028                	addi	a0,sp,8
ffffffffc0207afe:	013000ef          	jal	ra,ffffffffc0208310 <vfs_get_curdir>
ffffffffc0207b02:	842a                	mv	s0,a0
ffffffffc0207b04:	f575                	bnez	a0,ffffffffc0207af0 <vfs_set_bootfs+0x28>
ffffffffc0207b06:	6422                	ld	s0,8(sp)
ffffffffc0207b08:	0008e517          	auipc	a0,0x8e
ffffffffc0207b0c:	cf850513          	addi	a0,a0,-776 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b10:	aa5fc0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0207b14:	0008f797          	auipc	a5,0x8f
ffffffffc0207b18:	ddc78793          	addi	a5,a5,-548 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207b1c:	6384                	ld	s1,0(a5)
ffffffffc0207b1e:	0008e517          	auipc	a0,0x8e
ffffffffc0207b22:	ce250513          	addi	a0,a0,-798 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b26:	e380                	sd	s0,0(a5)
ffffffffc0207b28:	4401                	li	s0,0
ffffffffc0207b2a:	a87fc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207b2e:	d0e9                	beqz	s1,ffffffffc0207af0 <vfs_set_bootfs+0x28>
ffffffffc0207b30:	8526                	mv	a0,s1
ffffffffc0207b32:	e17ff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc0207b36:	70a2                	ld	ra,40(sp)
ffffffffc0207b38:	8522                	mv	a0,s0
ffffffffc0207b3a:	7402                	ld	s0,32(sp)
ffffffffc0207b3c:	64e2                	ld	s1,24(sp)
ffffffffc0207b3e:	6145                	addi	sp,sp,48
ffffffffc0207b40:	8082                	ret
ffffffffc0207b42:	5475                	li	s0,-3
ffffffffc0207b44:	b775                	j	ffffffffc0207af0 <vfs_set_bootfs+0x28>

ffffffffc0207b46 <vfs_get_bootfs>:
ffffffffc0207b46:	1101                	addi	sp,sp,-32
ffffffffc0207b48:	e426                	sd	s1,8(sp)
ffffffffc0207b4a:	0008f497          	auipc	s1,0x8f
ffffffffc0207b4e:	da648493          	addi	s1,s1,-602 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207b52:	609c                	ld	a5,0(s1)
ffffffffc0207b54:	ec06                	sd	ra,24(sp)
ffffffffc0207b56:	e822                	sd	s0,16(sp)
ffffffffc0207b58:	c3a1                	beqz	a5,ffffffffc0207b98 <vfs_get_bootfs+0x52>
ffffffffc0207b5a:	842a                	mv	s0,a0
ffffffffc0207b5c:	0008e517          	auipc	a0,0x8e
ffffffffc0207b60:	ca450513          	addi	a0,a0,-860 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b64:	a51fc0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0207b68:	6084                	ld	s1,0(s1)
ffffffffc0207b6a:	c08d                	beqz	s1,ffffffffc0207b8c <vfs_get_bootfs+0x46>
ffffffffc0207b6c:	8526                	mv	a0,s1
ffffffffc0207b6e:	d0dff0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc0207b72:	0008e517          	auipc	a0,0x8e
ffffffffc0207b76:	c8e50513          	addi	a0,a0,-882 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b7a:	a37fc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207b7e:	4501                	li	a0,0
ffffffffc0207b80:	e004                	sd	s1,0(s0)
ffffffffc0207b82:	60e2                	ld	ra,24(sp)
ffffffffc0207b84:	6442                	ld	s0,16(sp)
ffffffffc0207b86:	64a2                	ld	s1,8(sp)
ffffffffc0207b88:	6105                	addi	sp,sp,32
ffffffffc0207b8a:	8082                	ret
ffffffffc0207b8c:	0008e517          	auipc	a0,0x8e
ffffffffc0207b90:	c7450513          	addi	a0,a0,-908 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b94:	a1dfc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207b98:	5541                	li	a0,-16
ffffffffc0207b9a:	b7e5                	j	ffffffffc0207b82 <vfs_get_bootfs+0x3c>

ffffffffc0207b9c <vfs_do_add>:
ffffffffc0207b9c:	7139                	addi	sp,sp,-64
ffffffffc0207b9e:	fc06                	sd	ra,56(sp)
ffffffffc0207ba0:	f822                	sd	s0,48(sp)
ffffffffc0207ba2:	f426                	sd	s1,40(sp)
ffffffffc0207ba4:	f04a                	sd	s2,32(sp)
ffffffffc0207ba6:	ec4e                	sd	s3,24(sp)
ffffffffc0207ba8:	e852                	sd	s4,16(sp)
ffffffffc0207baa:	e456                	sd	s5,8(sp)
ffffffffc0207bac:	e05a                	sd	s6,0(sp)
ffffffffc0207bae:	0e050b63          	beqz	a0,ffffffffc0207ca4 <vfs_do_add+0x108>
ffffffffc0207bb2:	842a                	mv	s0,a0
ffffffffc0207bb4:	8a2e                	mv	s4,a1
ffffffffc0207bb6:	8b32                	mv	s6,a2
ffffffffc0207bb8:	8ab6                	mv	s5,a3
ffffffffc0207bba:	c5cd                	beqz	a1,ffffffffc0207c64 <vfs_do_add+0xc8>
ffffffffc0207bbc:	4db8                	lw	a4,88(a1)
ffffffffc0207bbe:	6785                	lui	a5,0x1
ffffffffc0207bc0:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207bc4:	0af71163          	bne	a4,a5,ffffffffc0207c66 <vfs_do_add+0xca>
ffffffffc0207bc8:	8522                	mv	a0,s0
ffffffffc0207bca:	059030ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc0207bce:	47fd                	li	a5,31
ffffffffc0207bd0:	0ca7e663          	bltu	a5,a0,ffffffffc0207c9c <vfs_do_add+0x100>
ffffffffc0207bd4:	8522                	mv	a0,s0
ffffffffc0207bd6:	e1ef80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207bda:	84aa                	mv	s1,a0
ffffffffc0207bdc:	c171                	beqz	a0,ffffffffc0207ca0 <vfs_do_add+0x104>
ffffffffc0207bde:	03000513          	li	a0,48
ffffffffc0207be2:	bfcfa0ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0207be6:	89aa                	mv	s3,a0
ffffffffc0207be8:	c92d                	beqz	a0,ffffffffc0207c5a <vfs_do_add+0xbe>
ffffffffc0207bea:	0008e517          	auipc	a0,0x8e
ffffffffc0207bee:	c3e50513          	addi	a0,a0,-962 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207bf2:	0008e917          	auipc	s2,0x8e
ffffffffc0207bf6:	c2690913          	addi	s2,s2,-986 # ffffffffc0295818 <vdev_list>
ffffffffc0207bfa:	9bbfc0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0207bfe:	844a                	mv	s0,s2
ffffffffc0207c00:	a039                	j	ffffffffc0207c0e <vfs_do_add+0x72>
ffffffffc0207c02:	fe043503          	ld	a0,-32(s0)
ffffffffc0207c06:	85a6                	mv	a1,s1
ffffffffc0207c08:	063030ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc0207c0c:	cd2d                	beqz	a0,ffffffffc0207c86 <vfs_do_add+0xea>
ffffffffc0207c0e:	6400                	ld	s0,8(s0)
ffffffffc0207c10:	ff2419e3          	bne	s0,s2,ffffffffc0207c02 <vfs_do_add+0x66>
ffffffffc0207c14:	6418                	ld	a4,8(s0)
ffffffffc0207c16:	02098793          	addi	a5,s3,32
ffffffffc0207c1a:	0099b023          	sd	s1,0(s3)
ffffffffc0207c1e:	0149b423          	sd	s4,8(s3)
ffffffffc0207c22:	0159bc23          	sd	s5,24(s3)
ffffffffc0207c26:	0169b823          	sd	s6,16(s3)
ffffffffc0207c2a:	e31c                	sd	a5,0(a4)
ffffffffc0207c2c:	0289b023          	sd	s0,32(s3)
ffffffffc0207c30:	02e9b423          	sd	a4,40(s3)
ffffffffc0207c34:	0008e517          	auipc	a0,0x8e
ffffffffc0207c38:	bf450513          	addi	a0,a0,-1036 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c3c:	e41c                	sd	a5,8(s0)
ffffffffc0207c3e:	4401                	li	s0,0
ffffffffc0207c40:	971fc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207c44:	70e2                	ld	ra,56(sp)
ffffffffc0207c46:	8522                	mv	a0,s0
ffffffffc0207c48:	7442                	ld	s0,48(sp)
ffffffffc0207c4a:	74a2                	ld	s1,40(sp)
ffffffffc0207c4c:	7902                	ld	s2,32(sp)
ffffffffc0207c4e:	69e2                	ld	s3,24(sp)
ffffffffc0207c50:	6a42                	ld	s4,16(sp)
ffffffffc0207c52:	6aa2                	ld	s5,8(sp)
ffffffffc0207c54:	6b02                	ld	s6,0(sp)
ffffffffc0207c56:	6121                	addi	sp,sp,64
ffffffffc0207c58:	8082                	ret
ffffffffc0207c5a:	5471                	li	s0,-4
ffffffffc0207c5c:	8526                	mv	a0,s1
ffffffffc0207c5e:	c30fa0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0207c62:	b7cd                	j	ffffffffc0207c44 <vfs_do_add+0xa8>
ffffffffc0207c64:	d2b5                	beqz	a3,ffffffffc0207bc8 <vfs_do_add+0x2c>
ffffffffc0207c66:	00007697          	auipc	a3,0x7
ffffffffc0207c6a:	98a68693          	addi	a3,a3,-1654 # ffffffffc020e5f0 <syscalls+0xa70>
ffffffffc0207c6e:	00004617          	auipc	a2,0x4
ffffffffc0207c72:	d3a60613          	addi	a2,a2,-710 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207c76:	08f00593          	li	a1,143
ffffffffc0207c7a:	00007517          	auipc	a0,0x7
ffffffffc0207c7e:	95e50513          	addi	a0,a0,-1698 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207c82:	81df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207c86:	0008e517          	auipc	a0,0x8e
ffffffffc0207c8a:	ba250513          	addi	a0,a0,-1118 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c8e:	923fc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207c92:	854e                	mv	a0,s3
ffffffffc0207c94:	bfafa0ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0207c98:	5425                	li	s0,-23
ffffffffc0207c9a:	b7c9                	j	ffffffffc0207c5c <vfs_do_add+0xc0>
ffffffffc0207c9c:	5451                	li	s0,-12
ffffffffc0207c9e:	b75d                	j	ffffffffc0207c44 <vfs_do_add+0xa8>
ffffffffc0207ca0:	5471                	li	s0,-4
ffffffffc0207ca2:	b74d                	j	ffffffffc0207c44 <vfs_do_add+0xa8>
ffffffffc0207ca4:	00007697          	auipc	a3,0x7
ffffffffc0207ca8:	92468693          	addi	a3,a3,-1756 # ffffffffc020e5c8 <syscalls+0xa48>
ffffffffc0207cac:	00004617          	auipc	a2,0x4
ffffffffc0207cb0:	cfc60613          	addi	a2,a2,-772 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207cb4:	08e00593          	li	a1,142
ffffffffc0207cb8:	00007517          	auipc	a0,0x7
ffffffffc0207cbc:	92050513          	addi	a0,a0,-1760 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207cc0:	fdef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207cc4 <find_mount.part.0>:
ffffffffc0207cc4:	1141                	addi	sp,sp,-16
ffffffffc0207cc6:	00007697          	auipc	a3,0x7
ffffffffc0207cca:	90268693          	addi	a3,a3,-1790 # ffffffffc020e5c8 <syscalls+0xa48>
ffffffffc0207cce:	00004617          	auipc	a2,0x4
ffffffffc0207cd2:	cda60613          	addi	a2,a2,-806 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207cd6:	0cd00593          	li	a1,205
ffffffffc0207cda:	00007517          	auipc	a0,0x7
ffffffffc0207cde:	8fe50513          	addi	a0,a0,-1794 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207ce2:	e406                	sd	ra,8(sp)
ffffffffc0207ce4:	fbaf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ce8 <vfs_devlist_init>:
ffffffffc0207ce8:	0008e797          	auipc	a5,0x8e
ffffffffc0207cec:	b3078793          	addi	a5,a5,-1232 # ffffffffc0295818 <vdev_list>
ffffffffc0207cf0:	4585                	li	a1,1
ffffffffc0207cf2:	0008e517          	auipc	a0,0x8e
ffffffffc0207cf6:	b3650513          	addi	a0,a0,-1226 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207cfa:	e79c                	sd	a5,8(a5)
ffffffffc0207cfc:	e39c                	sd	a5,0(a5)
ffffffffc0207cfe:	8adfc06f          	j	ffffffffc02045aa <sem_init>

ffffffffc0207d02 <vfs_cleanup>:
ffffffffc0207d02:	1101                	addi	sp,sp,-32
ffffffffc0207d04:	e426                	sd	s1,8(sp)
ffffffffc0207d06:	0008e497          	auipc	s1,0x8e
ffffffffc0207d0a:	b1248493          	addi	s1,s1,-1262 # ffffffffc0295818 <vdev_list>
ffffffffc0207d0e:	649c                	ld	a5,8(s1)
ffffffffc0207d10:	ec06                	sd	ra,24(sp)
ffffffffc0207d12:	e822                	sd	s0,16(sp)
ffffffffc0207d14:	02978e63          	beq	a5,s1,ffffffffc0207d50 <vfs_cleanup+0x4e>
ffffffffc0207d18:	0008e517          	auipc	a0,0x8e
ffffffffc0207d1c:	b1050513          	addi	a0,a0,-1264 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207d20:	895fc0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0207d24:	6480                	ld	s0,8(s1)
ffffffffc0207d26:	00940b63          	beq	s0,s1,ffffffffc0207d3c <vfs_cleanup+0x3a>
ffffffffc0207d2a:	ff043783          	ld	a5,-16(s0)
ffffffffc0207d2e:	853e                	mv	a0,a5
ffffffffc0207d30:	c399                	beqz	a5,ffffffffc0207d36 <vfs_cleanup+0x34>
ffffffffc0207d32:	6bfc                	ld	a5,208(a5)
ffffffffc0207d34:	9782                	jalr	a5
ffffffffc0207d36:	6400                	ld	s0,8(s0)
ffffffffc0207d38:	fe9419e3          	bne	s0,s1,ffffffffc0207d2a <vfs_cleanup+0x28>
ffffffffc0207d3c:	6442                	ld	s0,16(sp)
ffffffffc0207d3e:	60e2                	ld	ra,24(sp)
ffffffffc0207d40:	64a2                	ld	s1,8(sp)
ffffffffc0207d42:	0008e517          	auipc	a0,0x8e
ffffffffc0207d46:	ae650513          	addi	a0,a0,-1306 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207d4a:	6105                	addi	sp,sp,32
ffffffffc0207d4c:	865fc06f          	j	ffffffffc02045b0 <up>
ffffffffc0207d50:	60e2                	ld	ra,24(sp)
ffffffffc0207d52:	6442                	ld	s0,16(sp)
ffffffffc0207d54:	64a2                	ld	s1,8(sp)
ffffffffc0207d56:	6105                	addi	sp,sp,32
ffffffffc0207d58:	8082                	ret

ffffffffc0207d5a <vfs_get_root>:
ffffffffc0207d5a:	7179                	addi	sp,sp,-48
ffffffffc0207d5c:	f406                	sd	ra,40(sp)
ffffffffc0207d5e:	f022                	sd	s0,32(sp)
ffffffffc0207d60:	ec26                	sd	s1,24(sp)
ffffffffc0207d62:	e84a                	sd	s2,16(sp)
ffffffffc0207d64:	e44e                	sd	s3,8(sp)
ffffffffc0207d66:	e052                	sd	s4,0(sp)
ffffffffc0207d68:	c541                	beqz	a0,ffffffffc0207df0 <vfs_get_root+0x96>
ffffffffc0207d6a:	0008e917          	auipc	s2,0x8e
ffffffffc0207d6e:	aae90913          	addi	s2,s2,-1362 # ffffffffc0295818 <vdev_list>
ffffffffc0207d72:	00893783          	ld	a5,8(s2)
ffffffffc0207d76:	07278b63          	beq	a5,s2,ffffffffc0207dec <vfs_get_root+0x92>
ffffffffc0207d7a:	89aa                	mv	s3,a0
ffffffffc0207d7c:	0008e517          	auipc	a0,0x8e
ffffffffc0207d80:	aac50513          	addi	a0,a0,-1364 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207d84:	8a2e                	mv	s4,a1
ffffffffc0207d86:	844a                	mv	s0,s2
ffffffffc0207d88:	82dfc0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0207d8c:	a801                	j	ffffffffc0207d9c <vfs_get_root+0x42>
ffffffffc0207d8e:	fe043583          	ld	a1,-32(s0)
ffffffffc0207d92:	854e                	mv	a0,s3
ffffffffc0207d94:	6d6030ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc0207d98:	84aa                	mv	s1,a0
ffffffffc0207d9a:	c505                	beqz	a0,ffffffffc0207dc2 <vfs_get_root+0x68>
ffffffffc0207d9c:	6400                	ld	s0,8(s0)
ffffffffc0207d9e:	ff2418e3          	bne	s0,s2,ffffffffc0207d8e <vfs_get_root+0x34>
ffffffffc0207da2:	54cd                	li	s1,-13
ffffffffc0207da4:	0008e517          	auipc	a0,0x8e
ffffffffc0207da8:	a8450513          	addi	a0,a0,-1404 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207dac:	805fc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207db0:	70a2                	ld	ra,40(sp)
ffffffffc0207db2:	7402                	ld	s0,32(sp)
ffffffffc0207db4:	6942                	ld	s2,16(sp)
ffffffffc0207db6:	69a2                	ld	s3,8(sp)
ffffffffc0207db8:	6a02                	ld	s4,0(sp)
ffffffffc0207dba:	8526                	mv	a0,s1
ffffffffc0207dbc:	64e2                	ld	s1,24(sp)
ffffffffc0207dbe:	6145                	addi	sp,sp,48
ffffffffc0207dc0:	8082                	ret
ffffffffc0207dc2:	ff043503          	ld	a0,-16(s0)
ffffffffc0207dc6:	c519                	beqz	a0,ffffffffc0207dd4 <vfs_get_root+0x7a>
ffffffffc0207dc8:	617c                	ld	a5,192(a0)
ffffffffc0207dca:	9782                	jalr	a5
ffffffffc0207dcc:	c519                	beqz	a0,ffffffffc0207dda <vfs_get_root+0x80>
ffffffffc0207dce:	00aa3023          	sd	a0,0(s4)
ffffffffc0207dd2:	bfc9                	j	ffffffffc0207da4 <vfs_get_root+0x4a>
ffffffffc0207dd4:	ff843783          	ld	a5,-8(s0)
ffffffffc0207dd8:	c399                	beqz	a5,ffffffffc0207dde <vfs_get_root+0x84>
ffffffffc0207dda:	54c9                	li	s1,-14
ffffffffc0207ddc:	b7e1                	j	ffffffffc0207da4 <vfs_get_root+0x4a>
ffffffffc0207dde:	fe843503          	ld	a0,-24(s0)
ffffffffc0207de2:	a99ff0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc0207de6:	fe843503          	ld	a0,-24(s0)
ffffffffc0207dea:	b7cd                	j	ffffffffc0207dcc <vfs_get_root+0x72>
ffffffffc0207dec:	54cd                	li	s1,-13
ffffffffc0207dee:	b7c9                	j	ffffffffc0207db0 <vfs_get_root+0x56>
ffffffffc0207df0:	00006697          	auipc	a3,0x6
ffffffffc0207df4:	7d868693          	addi	a3,a3,2008 # ffffffffc020e5c8 <syscalls+0xa48>
ffffffffc0207df8:	00004617          	auipc	a2,0x4
ffffffffc0207dfc:	bb060613          	addi	a2,a2,-1104 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207e00:	04500593          	li	a1,69
ffffffffc0207e04:	00006517          	auipc	a0,0x6
ffffffffc0207e08:	7d450513          	addi	a0,a0,2004 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207e0c:	e92f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e10 <vfs_get_devname>:
ffffffffc0207e10:	0008e697          	auipc	a3,0x8e
ffffffffc0207e14:	a0868693          	addi	a3,a3,-1528 # ffffffffc0295818 <vdev_list>
ffffffffc0207e18:	87b6                	mv	a5,a3
ffffffffc0207e1a:	e511                	bnez	a0,ffffffffc0207e26 <vfs_get_devname+0x16>
ffffffffc0207e1c:	a829                	j	ffffffffc0207e36 <vfs_get_devname+0x26>
ffffffffc0207e1e:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207e22:	00a70763          	beq	a4,a0,ffffffffc0207e30 <vfs_get_devname+0x20>
ffffffffc0207e26:	679c                	ld	a5,8(a5)
ffffffffc0207e28:	fed79be3          	bne	a5,a3,ffffffffc0207e1e <vfs_get_devname+0xe>
ffffffffc0207e2c:	4501                	li	a0,0
ffffffffc0207e2e:	8082                	ret
ffffffffc0207e30:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207e34:	8082                	ret
ffffffffc0207e36:	1141                	addi	sp,sp,-16
ffffffffc0207e38:	00007697          	auipc	a3,0x7
ffffffffc0207e3c:	81868693          	addi	a3,a3,-2024 # ffffffffc020e650 <syscalls+0xad0>
ffffffffc0207e40:	00004617          	auipc	a2,0x4
ffffffffc0207e44:	b6860613          	addi	a2,a2,-1176 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207e48:	06a00593          	li	a1,106
ffffffffc0207e4c:	00006517          	auipc	a0,0x6
ffffffffc0207e50:	78c50513          	addi	a0,a0,1932 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207e54:	e406                	sd	ra,8(sp)
ffffffffc0207e56:	e48f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e5a <vfs_add_dev>:
ffffffffc0207e5a:	86b2                	mv	a3,a2
ffffffffc0207e5c:	4601                	li	a2,0
ffffffffc0207e5e:	d3fff06f          	j	ffffffffc0207b9c <vfs_do_add>

ffffffffc0207e62 <vfs_mount>:
ffffffffc0207e62:	7179                	addi	sp,sp,-48
ffffffffc0207e64:	e84a                	sd	s2,16(sp)
ffffffffc0207e66:	892a                	mv	s2,a0
ffffffffc0207e68:	0008e517          	auipc	a0,0x8e
ffffffffc0207e6c:	9c050513          	addi	a0,a0,-1600 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207e70:	e44e                	sd	s3,8(sp)
ffffffffc0207e72:	f406                	sd	ra,40(sp)
ffffffffc0207e74:	f022                	sd	s0,32(sp)
ffffffffc0207e76:	ec26                	sd	s1,24(sp)
ffffffffc0207e78:	89ae                	mv	s3,a1
ffffffffc0207e7a:	f3afc0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0207e7e:	08090a63          	beqz	s2,ffffffffc0207f12 <vfs_mount+0xb0>
ffffffffc0207e82:	0008e497          	auipc	s1,0x8e
ffffffffc0207e86:	99648493          	addi	s1,s1,-1642 # ffffffffc0295818 <vdev_list>
ffffffffc0207e8a:	6480                	ld	s0,8(s1)
ffffffffc0207e8c:	00941663          	bne	s0,s1,ffffffffc0207e98 <vfs_mount+0x36>
ffffffffc0207e90:	a8ad                	j	ffffffffc0207f0a <vfs_mount+0xa8>
ffffffffc0207e92:	6400                	ld	s0,8(s0)
ffffffffc0207e94:	06940b63          	beq	s0,s1,ffffffffc0207f0a <vfs_mount+0xa8>
ffffffffc0207e98:	ff843783          	ld	a5,-8(s0)
ffffffffc0207e9c:	dbfd                	beqz	a5,ffffffffc0207e92 <vfs_mount+0x30>
ffffffffc0207e9e:	fe043503          	ld	a0,-32(s0)
ffffffffc0207ea2:	85ca                	mv	a1,s2
ffffffffc0207ea4:	5c6030ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc0207ea8:	f56d                	bnez	a0,ffffffffc0207e92 <vfs_mount+0x30>
ffffffffc0207eaa:	ff043783          	ld	a5,-16(s0)
ffffffffc0207eae:	e3a5                	bnez	a5,ffffffffc0207f0e <vfs_mount+0xac>
ffffffffc0207eb0:	fe043783          	ld	a5,-32(s0)
ffffffffc0207eb4:	c3c9                	beqz	a5,ffffffffc0207f36 <vfs_mount+0xd4>
ffffffffc0207eb6:	ff843783          	ld	a5,-8(s0)
ffffffffc0207eba:	cfb5                	beqz	a5,ffffffffc0207f36 <vfs_mount+0xd4>
ffffffffc0207ebc:	fe843503          	ld	a0,-24(s0)
ffffffffc0207ec0:	c939                	beqz	a0,ffffffffc0207f16 <vfs_mount+0xb4>
ffffffffc0207ec2:	4d38                	lw	a4,88(a0)
ffffffffc0207ec4:	6785                	lui	a5,0x1
ffffffffc0207ec6:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207eca:	04f71663          	bne	a4,a5,ffffffffc0207f16 <vfs_mount+0xb4>
ffffffffc0207ece:	ff040593          	addi	a1,s0,-16
ffffffffc0207ed2:	9982                	jalr	s3
ffffffffc0207ed4:	84aa                	mv	s1,a0
ffffffffc0207ed6:	ed01                	bnez	a0,ffffffffc0207eee <vfs_mount+0x8c>
ffffffffc0207ed8:	ff043783          	ld	a5,-16(s0)
ffffffffc0207edc:	cfad                	beqz	a5,ffffffffc0207f56 <vfs_mount+0xf4>
ffffffffc0207ede:	fe043583          	ld	a1,-32(s0)
ffffffffc0207ee2:	00006517          	auipc	a0,0x6
ffffffffc0207ee6:	7fe50513          	addi	a0,a0,2046 # ffffffffc020e6e0 <syscalls+0xb60>
ffffffffc0207eea:	abcf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207eee:	0008e517          	auipc	a0,0x8e
ffffffffc0207ef2:	93a50513          	addi	a0,a0,-1734 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207ef6:	ebafc0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc0207efa:	70a2                	ld	ra,40(sp)
ffffffffc0207efc:	7402                	ld	s0,32(sp)
ffffffffc0207efe:	6942                	ld	s2,16(sp)
ffffffffc0207f00:	69a2                	ld	s3,8(sp)
ffffffffc0207f02:	8526                	mv	a0,s1
ffffffffc0207f04:	64e2                	ld	s1,24(sp)
ffffffffc0207f06:	6145                	addi	sp,sp,48
ffffffffc0207f08:	8082                	ret
ffffffffc0207f0a:	54cd                	li	s1,-13
ffffffffc0207f0c:	b7cd                	j	ffffffffc0207eee <vfs_mount+0x8c>
ffffffffc0207f0e:	54c5                	li	s1,-15
ffffffffc0207f10:	bff9                	j	ffffffffc0207eee <vfs_mount+0x8c>
ffffffffc0207f12:	db3ff0ef          	jal	ra,ffffffffc0207cc4 <find_mount.part.0>
ffffffffc0207f16:	00006697          	auipc	a3,0x6
ffffffffc0207f1a:	77a68693          	addi	a3,a3,1914 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0207f1e:	00004617          	auipc	a2,0x4
ffffffffc0207f22:	a8a60613          	addi	a2,a2,-1398 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207f26:	0ed00593          	li	a1,237
ffffffffc0207f2a:	00006517          	auipc	a0,0x6
ffffffffc0207f2e:	6ae50513          	addi	a0,a0,1710 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207f32:	d6cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207f36:	00006697          	auipc	a3,0x6
ffffffffc0207f3a:	72a68693          	addi	a3,a3,1834 # ffffffffc020e660 <syscalls+0xae0>
ffffffffc0207f3e:	00004617          	auipc	a2,0x4
ffffffffc0207f42:	a6a60613          	addi	a2,a2,-1430 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207f46:	0eb00593          	li	a1,235
ffffffffc0207f4a:	00006517          	auipc	a0,0x6
ffffffffc0207f4e:	68e50513          	addi	a0,a0,1678 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207f52:	d4cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207f56:	00006697          	auipc	a3,0x6
ffffffffc0207f5a:	77268693          	addi	a3,a3,1906 # ffffffffc020e6c8 <syscalls+0xb48>
ffffffffc0207f5e:	00004617          	auipc	a2,0x4
ffffffffc0207f62:	a4a60613          	addi	a2,a2,-1462 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0207f66:	0ef00593          	li	a1,239
ffffffffc0207f6a:	00006517          	auipc	a0,0x6
ffffffffc0207f6e:	66e50513          	addi	a0,a0,1646 # ffffffffc020e5d8 <syscalls+0xa58>
ffffffffc0207f72:	d2cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207f76 <vfs_open>:
ffffffffc0207f76:	711d                	addi	sp,sp,-96
ffffffffc0207f78:	e4a6                	sd	s1,72(sp)
ffffffffc0207f7a:	e0ca                	sd	s2,64(sp)
ffffffffc0207f7c:	fc4e                	sd	s3,56(sp)
ffffffffc0207f7e:	ec86                	sd	ra,88(sp)
ffffffffc0207f80:	e8a2                	sd	s0,80(sp)
ffffffffc0207f82:	f852                	sd	s4,48(sp)
ffffffffc0207f84:	f456                	sd	s5,40(sp)
ffffffffc0207f86:	0035f793          	andi	a5,a1,3
ffffffffc0207f8a:	84ae                	mv	s1,a1
ffffffffc0207f8c:	892a                	mv	s2,a0
ffffffffc0207f8e:	89b2                	mv	s3,a2
ffffffffc0207f90:	0e078663          	beqz	a5,ffffffffc020807c <vfs_open+0x106>
ffffffffc0207f94:	470d                	li	a4,3
ffffffffc0207f96:	0105fa93          	andi	s5,a1,16
ffffffffc0207f9a:	0ce78f63          	beq	a5,a4,ffffffffc0208078 <vfs_open+0x102>
ffffffffc0207f9e:	002c                	addi	a1,sp,8
ffffffffc0207fa0:	854a                	mv	a0,s2
ffffffffc0207fa2:	2ae000ef          	jal	ra,ffffffffc0208250 <vfs_lookup>
ffffffffc0207fa6:	842a                	mv	s0,a0
ffffffffc0207fa8:	0044fa13          	andi	s4,s1,4
ffffffffc0207fac:	e159                	bnez	a0,ffffffffc0208032 <vfs_open+0xbc>
ffffffffc0207fae:	00c4f793          	andi	a5,s1,12
ffffffffc0207fb2:	4731                	li	a4,12
ffffffffc0207fb4:	0ee78263          	beq	a5,a4,ffffffffc0208098 <vfs_open+0x122>
ffffffffc0207fb8:	6422                	ld	s0,8(sp)
ffffffffc0207fba:	12040163          	beqz	s0,ffffffffc02080dc <vfs_open+0x166>
ffffffffc0207fbe:	783c                	ld	a5,112(s0)
ffffffffc0207fc0:	cff1                	beqz	a5,ffffffffc020809c <vfs_open+0x126>
ffffffffc0207fc2:	679c                	ld	a5,8(a5)
ffffffffc0207fc4:	cfe1                	beqz	a5,ffffffffc020809c <vfs_open+0x126>
ffffffffc0207fc6:	8522                	mv	a0,s0
ffffffffc0207fc8:	00006597          	auipc	a1,0x6
ffffffffc0207fcc:	7f858593          	addi	a1,a1,2040 # ffffffffc020e7c0 <syscalls+0xc40>
ffffffffc0207fd0:	8c3ff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0207fd4:	783c                	ld	a5,112(s0)
ffffffffc0207fd6:	6522                	ld	a0,8(sp)
ffffffffc0207fd8:	85a6                	mv	a1,s1
ffffffffc0207fda:	679c                	ld	a5,8(a5)
ffffffffc0207fdc:	9782                	jalr	a5
ffffffffc0207fde:	842a                	mv	s0,a0
ffffffffc0207fe0:	6522                	ld	a0,8(sp)
ffffffffc0207fe2:	e845                	bnez	s0,ffffffffc0208092 <vfs_open+0x11c>
ffffffffc0207fe4:	015a6a33          	or	s4,s4,s5
ffffffffc0207fe8:	89fff0ef          	jal	ra,ffffffffc0207886 <inode_open_inc>
ffffffffc0207fec:	020a0663          	beqz	s4,ffffffffc0208018 <vfs_open+0xa2>
ffffffffc0207ff0:	64a2                	ld	s1,8(sp)
ffffffffc0207ff2:	c4e9                	beqz	s1,ffffffffc02080bc <vfs_open+0x146>
ffffffffc0207ff4:	78bc                	ld	a5,112(s1)
ffffffffc0207ff6:	c3f9                	beqz	a5,ffffffffc02080bc <vfs_open+0x146>
ffffffffc0207ff8:	73bc                	ld	a5,96(a5)
ffffffffc0207ffa:	c3e9                	beqz	a5,ffffffffc02080bc <vfs_open+0x146>
ffffffffc0207ffc:	00007597          	auipc	a1,0x7
ffffffffc0208000:	82458593          	addi	a1,a1,-2012 # ffffffffc020e820 <syscalls+0xca0>
ffffffffc0208004:	8526                	mv	a0,s1
ffffffffc0208006:	88dff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020800a:	78bc                	ld	a5,112(s1)
ffffffffc020800c:	6522                	ld	a0,8(sp)
ffffffffc020800e:	4581                	li	a1,0
ffffffffc0208010:	73bc                	ld	a5,96(a5)
ffffffffc0208012:	9782                	jalr	a5
ffffffffc0208014:	87aa                	mv	a5,a0
ffffffffc0208016:	e92d                	bnez	a0,ffffffffc0208088 <vfs_open+0x112>
ffffffffc0208018:	67a2                	ld	a5,8(sp)
ffffffffc020801a:	00f9b023          	sd	a5,0(s3)
ffffffffc020801e:	60e6                	ld	ra,88(sp)
ffffffffc0208020:	8522                	mv	a0,s0
ffffffffc0208022:	6446                	ld	s0,80(sp)
ffffffffc0208024:	64a6                	ld	s1,72(sp)
ffffffffc0208026:	6906                	ld	s2,64(sp)
ffffffffc0208028:	79e2                	ld	s3,56(sp)
ffffffffc020802a:	7a42                	ld	s4,48(sp)
ffffffffc020802c:	7aa2                	ld	s5,40(sp)
ffffffffc020802e:	6125                	addi	sp,sp,96
ffffffffc0208030:	8082                	ret
ffffffffc0208032:	57c1                	li	a5,-16
ffffffffc0208034:	fef515e3          	bne	a0,a5,ffffffffc020801e <vfs_open+0xa8>
ffffffffc0208038:	fe0a03e3          	beqz	s4,ffffffffc020801e <vfs_open+0xa8>
ffffffffc020803c:	0810                	addi	a2,sp,16
ffffffffc020803e:	082c                	addi	a1,sp,24
ffffffffc0208040:	854a                	mv	a0,s2
ffffffffc0208042:	2a4000ef          	jal	ra,ffffffffc02082e6 <vfs_lookup_parent>
ffffffffc0208046:	842a                	mv	s0,a0
ffffffffc0208048:	f979                	bnez	a0,ffffffffc020801e <vfs_open+0xa8>
ffffffffc020804a:	6462                	ld	s0,24(sp)
ffffffffc020804c:	c845                	beqz	s0,ffffffffc02080fc <vfs_open+0x186>
ffffffffc020804e:	783c                	ld	a5,112(s0)
ffffffffc0208050:	c7d5                	beqz	a5,ffffffffc02080fc <vfs_open+0x186>
ffffffffc0208052:	77bc                	ld	a5,104(a5)
ffffffffc0208054:	c7c5                	beqz	a5,ffffffffc02080fc <vfs_open+0x186>
ffffffffc0208056:	8522                	mv	a0,s0
ffffffffc0208058:	00006597          	auipc	a1,0x6
ffffffffc020805c:	70058593          	addi	a1,a1,1792 # ffffffffc020e758 <syscalls+0xbd8>
ffffffffc0208060:	833ff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0208064:	783c                	ld	a5,112(s0)
ffffffffc0208066:	65c2                	ld	a1,16(sp)
ffffffffc0208068:	6562                	ld	a0,24(sp)
ffffffffc020806a:	77bc                	ld	a5,104(a5)
ffffffffc020806c:	4034d613          	srai	a2,s1,0x3
ffffffffc0208070:	0034                	addi	a3,sp,8
ffffffffc0208072:	8a05                	andi	a2,a2,1
ffffffffc0208074:	9782                	jalr	a5
ffffffffc0208076:	b789                	j	ffffffffc0207fb8 <vfs_open+0x42>
ffffffffc0208078:	5475                	li	s0,-3
ffffffffc020807a:	b755                	j	ffffffffc020801e <vfs_open+0xa8>
ffffffffc020807c:	0105fa93          	andi	s5,a1,16
ffffffffc0208080:	5475                	li	s0,-3
ffffffffc0208082:	f80a9ee3          	bnez	s5,ffffffffc020801e <vfs_open+0xa8>
ffffffffc0208086:	bf21                	j	ffffffffc0207f9e <vfs_open+0x28>
ffffffffc0208088:	6522                	ld	a0,8(sp)
ffffffffc020808a:	843e                	mv	s0,a5
ffffffffc020808c:	965ff0ef          	jal	ra,ffffffffc02079f0 <inode_open_dec>
ffffffffc0208090:	6522                	ld	a0,8(sp)
ffffffffc0208092:	8b7ff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc0208096:	b761                	j	ffffffffc020801e <vfs_open+0xa8>
ffffffffc0208098:	5425                	li	s0,-23
ffffffffc020809a:	b751                	j	ffffffffc020801e <vfs_open+0xa8>
ffffffffc020809c:	00006697          	auipc	a3,0x6
ffffffffc02080a0:	6d468693          	addi	a3,a3,1748 # ffffffffc020e770 <syscalls+0xbf0>
ffffffffc02080a4:	00004617          	auipc	a2,0x4
ffffffffc02080a8:	90460613          	addi	a2,a2,-1788 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02080ac:	03300593          	li	a1,51
ffffffffc02080b0:	00006517          	auipc	a0,0x6
ffffffffc02080b4:	69050513          	addi	a0,a0,1680 # ffffffffc020e740 <syscalls+0xbc0>
ffffffffc02080b8:	be6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02080bc:	00006697          	auipc	a3,0x6
ffffffffc02080c0:	70c68693          	addi	a3,a3,1804 # ffffffffc020e7c8 <syscalls+0xc48>
ffffffffc02080c4:	00004617          	auipc	a2,0x4
ffffffffc02080c8:	8e460613          	addi	a2,a2,-1820 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02080cc:	03a00593          	li	a1,58
ffffffffc02080d0:	00006517          	auipc	a0,0x6
ffffffffc02080d4:	67050513          	addi	a0,a0,1648 # ffffffffc020e740 <syscalls+0xbc0>
ffffffffc02080d8:	bc6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02080dc:	00006697          	auipc	a3,0x6
ffffffffc02080e0:	68468693          	addi	a3,a3,1668 # ffffffffc020e760 <syscalls+0xbe0>
ffffffffc02080e4:	00004617          	auipc	a2,0x4
ffffffffc02080e8:	8c460613          	addi	a2,a2,-1852 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02080ec:	03100593          	li	a1,49
ffffffffc02080f0:	00006517          	auipc	a0,0x6
ffffffffc02080f4:	65050513          	addi	a0,a0,1616 # ffffffffc020e740 <syscalls+0xbc0>
ffffffffc02080f8:	ba6f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02080fc:	00006697          	auipc	a3,0x6
ffffffffc0208100:	5f468693          	addi	a3,a3,1524 # ffffffffc020e6f0 <syscalls+0xb70>
ffffffffc0208104:	00004617          	auipc	a2,0x4
ffffffffc0208108:	8a460613          	addi	a2,a2,-1884 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020810c:	02c00593          	li	a1,44
ffffffffc0208110:	00006517          	auipc	a0,0x6
ffffffffc0208114:	63050513          	addi	a0,a0,1584 # ffffffffc020e740 <syscalls+0xbc0>
ffffffffc0208118:	b86f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020811c <vfs_close>:
ffffffffc020811c:	1141                	addi	sp,sp,-16
ffffffffc020811e:	e406                	sd	ra,8(sp)
ffffffffc0208120:	e022                	sd	s0,0(sp)
ffffffffc0208122:	842a                	mv	s0,a0
ffffffffc0208124:	8cdff0ef          	jal	ra,ffffffffc02079f0 <inode_open_dec>
ffffffffc0208128:	8522                	mv	a0,s0
ffffffffc020812a:	81fff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020812e:	60a2                	ld	ra,8(sp)
ffffffffc0208130:	6402                	ld	s0,0(sp)
ffffffffc0208132:	4501                	li	a0,0
ffffffffc0208134:	0141                	addi	sp,sp,16
ffffffffc0208136:	8082                	ret

ffffffffc0208138 <get_device>:
ffffffffc0208138:	7179                	addi	sp,sp,-48
ffffffffc020813a:	ec26                	sd	s1,24(sp)
ffffffffc020813c:	e84a                	sd	s2,16(sp)
ffffffffc020813e:	f406                	sd	ra,40(sp)
ffffffffc0208140:	f022                	sd	s0,32(sp)
ffffffffc0208142:	00054303          	lbu	t1,0(a0)
ffffffffc0208146:	892e                	mv	s2,a1
ffffffffc0208148:	84b2                	mv	s1,a2
ffffffffc020814a:	02030463          	beqz	t1,ffffffffc0208172 <get_device+0x3a>
ffffffffc020814e:	00150413          	addi	s0,a0,1
ffffffffc0208152:	86a2                	mv	a3,s0
ffffffffc0208154:	879a                	mv	a5,t1
ffffffffc0208156:	4701                	li	a4,0
ffffffffc0208158:	03a00813          	li	a6,58
ffffffffc020815c:	02f00893          	li	a7,47
ffffffffc0208160:	03078263          	beq	a5,a6,ffffffffc0208184 <get_device+0x4c>
ffffffffc0208164:	05178963          	beq	a5,a7,ffffffffc02081b6 <get_device+0x7e>
ffffffffc0208168:	0006c783          	lbu	a5,0(a3)
ffffffffc020816c:	2705                	addiw	a4,a4,1
ffffffffc020816e:	0685                	addi	a3,a3,1
ffffffffc0208170:	fbe5                	bnez	a5,ffffffffc0208160 <get_device+0x28>
ffffffffc0208172:	7402                	ld	s0,32(sp)
ffffffffc0208174:	00a93023          	sd	a0,0(s2)
ffffffffc0208178:	70a2                	ld	ra,40(sp)
ffffffffc020817a:	6942                	ld	s2,16(sp)
ffffffffc020817c:	8526                	mv	a0,s1
ffffffffc020817e:	64e2                	ld	s1,24(sp)
ffffffffc0208180:	6145                	addi	sp,sp,48
ffffffffc0208182:	a279                	j	ffffffffc0208310 <vfs_get_curdir>
ffffffffc0208184:	cb15                	beqz	a4,ffffffffc02081b8 <get_device+0x80>
ffffffffc0208186:	00e507b3          	add	a5,a0,a4
ffffffffc020818a:	0705                	addi	a4,a4,1
ffffffffc020818c:	00078023          	sb	zero,0(a5)
ffffffffc0208190:	972a                	add	a4,a4,a0
ffffffffc0208192:	02f00613          	li	a2,47
ffffffffc0208196:	00074783          	lbu	a5,0(a4)
ffffffffc020819a:	86ba                	mv	a3,a4
ffffffffc020819c:	0705                	addi	a4,a4,1
ffffffffc020819e:	fec78ce3          	beq	a5,a2,ffffffffc0208196 <get_device+0x5e>
ffffffffc02081a2:	7402                	ld	s0,32(sp)
ffffffffc02081a4:	70a2                	ld	ra,40(sp)
ffffffffc02081a6:	00d93023          	sd	a3,0(s2)
ffffffffc02081aa:	85a6                	mv	a1,s1
ffffffffc02081ac:	6942                	ld	s2,16(sp)
ffffffffc02081ae:	64e2                	ld	s1,24(sp)
ffffffffc02081b0:	6145                	addi	sp,sp,48
ffffffffc02081b2:	ba9ff06f          	j	ffffffffc0207d5a <vfs_get_root>
ffffffffc02081b6:	ff55                	bnez	a4,ffffffffc0208172 <get_device+0x3a>
ffffffffc02081b8:	02f00793          	li	a5,47
ffffffffc02081bc:	04f30563          	beq	t1,a5,ffffffffc0208206 <get_device+0xce>
ffffffffc02081c0:	03a00793          	li	a5,58
ffffffffc02081c4:	06f31663          	bne	t1,a5,ffffffffc0208230 <get_device+0xf8>
ffffffffc02081c8:	0028                	addi	a0,sp,8
ffffffffc02081ca:	146000ef          	jal	ra,ffffffffc0208310 <vfs_get_curdir>
ffffffffc02081ce:	e515                	bnez	a0,ffffffffc02081fa <get_device+0xc2>
ffffffffc02081d0:	67a2                	ld	a5,8(sp)
ffffffffc02081d2:	77a8                	ld	a0,104(a5)
ffffffffc02081d4:	cd15                	beqz	a0,ffffffffc0208210 <get_device+0xd8>
ffffffffc02081d6:	617c                	ld	a5,192(a0)
ffffffffc02081d8:	9782                	jalr	a5
ffffffffc02081da:	87aa                	mv	a5,a0
ffffffffc02081dc:	6522                	ld	a0,8(sp)
ffffffffc02081de:	e09c                	sd	a5,0(s1)
ffffffffc02081e0:	f68ff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc02081e4:	02f00713          	li	a4,47
ffffffffc02081e8:	a011                	j	ffffffffc02081ec <get_device+0xb4>
ffffffffc02081ea:	0405                	addi	s0,s0,1
ffffffffc02081ec:	00044783          	lbu	a5,0(s0)
ffffffffc02081f0:	fee78de3          	beq	a5,a4,ffffffffc02081ea <get_device+0xb2>
ffffffffc02081f4:	00893023          	sd	s0,0(s2)
ffffffffc02081f8:	4501                	li	a0,0
ffffffffc02081fa:	70a2                	ld	ra,40(sp)
ffffffffc02081fc:	7402                	ld	s0,32(sp)
ffffffffc02081fe:	64e2                	ld	s1,24(sp)
ffffffffc0208200:	6942                	ld	s2,16(sp)
ffffffffc0208202:	6145                	addi	sp,sp,48
ffffffffc0208204:	8082                	ret
ffffffffc0208206:	8526                	mv	a0,s1
ffffffffc0208208:	93fff0ef          	jal	ra,ffffffffc0207b46 <vfs_get_bootfs>
ffffffffc020820c:	dd61                	beqz	a0,ffffffffc02081e4 <get_device+0xac>
ffffffffc020820e:	b7f5                	j	ffffffffc02081fa <get_device+0xc2>
ffffffffc0208210:	00006697          	auipc	a3,0x6
ffffffffc0208214:	64868693          	addi	a3,a3,1608 # ffffffffc020e858 <syscalls+0xcd8>
ffffffffc0208218:	00003617          	auipc	a2,0x3
ffffffffc020821c:	79060613          	addi	a2,a2,1936 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208220:	03900593          	li	a1,57
ffffffffc0208224:	00006517          	auipc	a0,0x6
ffffffffc0208228:	61c50513          	addi	a0,a0,1564 # ffffffffc020e840 <syscalls+0xcc0>
ffffffffc020822c:	a72f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208230:	00006697          	auipc	a3,0x6
ffffffffc0208234:	60068693          	addi	a3,a3,1536 # ffffffffc020e830 <syscalls+0xcb0>
ffffffffc0208238:	00003617          	auipc	a2,0x3
ffffffffc020823c:	77060613          	addi	a2,a2,1904 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208240:	03300593          	li	a1,51
ffffffffc0208244:	00006517          	auipc	a0,0x6
ffffffffc0208248:	5fc50513          	addi	a0,a0,1532 # ffffffffc020e840 <syscalls+0xcc0>
ffffffffc020824c:	a52f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208250 <vfs_lookup>:
ffffffffc0208250:	7139                	addi	sp,sp,-64
ffffffffc0208252:	f426                	sd	s1,40(sp)
ffffffffc0208254:	0830                	addi	a2,sp,24
ffffffffc0208256:	84ae                	mv	s1,a1
ffffffffc0208258:	002c                	addi	a1,sp,8
ffffffffc020825a:	f822                	sd	s0,48(sp)
ffffffffc020825c:	fc06                	sd	ra,56(sp)
ffffffffc020825e:	f04a                	sd	s2,32(sp)
ffffffffc0208260:	e42a                	sd	a0,8(sp)
ffffffffc0208262:	ed7ff0ef          	jal	ra,ffffffffc0208138 <get_device>
ffffffffc0208266:	842a                	mv	s0,a0
ffffffffc0208268:	ed1d                	bnez	a0,ffffffffc02082a6 <vfs_lookup+0x56>
ffffffffc020826a:	67a2                	ld	a5,8(sp)
ffffffffc020826c:	6962                	ld	s2,24(sp)
ffffffffc020826e:	0007c783          	lbu	a5,0(a5)
ffffffffc0208272:	c3a9                	beqz	a5,ffffffffc02082b4 <vfs_lookup+0x64>
ffffffffc0208274:	04090963          	beqz	s2,ffffffffc02082c6 <vfs_lookup+0x76>
ffffffffc0208278:	07093783          	ld	a5,112(s2)
ffffffffc020827c:	c7a9                	beqz	a5,ffffffffc02082c6 <vfs_lookup+0x76>
ffffffffc020827e:	7bbc                	ld	a5,112(a5)
ffffffffc0208280:	c3b9                	beqz	a5,ffffffffc02082c6 <vfs_lookup+0x76>
ffffffffc0208282:	854a                	mv	a0,s2
ffffffffc0208284:	00006597          	auipc	a1,0x6
ffffffffc0208288:	63c58593          	addi	a1,a1,1596 # ffffffffc020e8c0 <syscalls+0xd40>
ffffffffc020828c:	e06ff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0208290:	07093783          	ld	a5,112(s2)
ffffffffc0208294:	65a2                	ld	a1,8(sp)
ffffffffc0208296:	6562                	ld	a0,24(sp)
ffffffffc0208298:	7bbc                	ld	a5,112(a5)
ffffffffc020829a:	8626                	mv	a2,s1
ffffffffc020829c:	9782                	jalr	a5
ffffffffc020829e:	842a                	mv	s0,a0
ffffffffc02082a0:	6562                	ld	a0,24(sp)
ffffffffc02082a2:	ea6ff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc02082a6:	70e2                	ld	ra,56(sp)
ffffffffc02082a8:	8522                	mv	a0,s0
ffffffffc02082aa:	7442                	ld	s0,48(sp)
ffffffffc02082ac:	74a2                	ld	s1,40(sp)
ffffffffc02082ae:	7902                	ld	s2,32(sp)
ffffffffc02082b0:	6121                	addi	sp,sp,64
ffffffffc02082b2:	8082                	ret
ffffffffc02082b4:	70e2                	ld	ra,56(sp)
ffffffffc02082b6:	8522                	mv	a0,s0
ffffffffc02082b8:	7442                	ld	s0,48(sp)
ffffffffc02082ba:	0124b023          	sd	s2,0(s1)
ffffffffc02082be:	74a2                	ld	s1,40(sp)
ffffffffc02082c0:	7902                	ld	s2,32(sp)
ffffffffc02082c2:	6121                	addi	sp,sp,64
ffffffffc02082c4:	8082                	ret
ffffffffc02082c6:	00006697          	auipc	a3,0x6
ffffffffc02082ca:	5aa68693          	addi	a3,a3,1450 # ffffffffc020e870 <syscalls+0xcf0>
ffffffffc02082ce:	00003617          	auipc	a2,0x3
ffffffffc02082d2:	6da60613          	addi	a2,a2,1754 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02082d6:	04f00593          	li	a1,79
ffffffffc02082da:	00006517          	auipc	a0,0x6
ffffffffc02082de:	56650513          	addi	a0,a0,1382 # ffffffffc020e840 <syscalls+0xcc0>
ffffffffc02082e2:	9bcf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02082e6 <vfs_lookup_parent>:
ffffffffc02082e6:	7139                	addi	sp,sp,-64
ffffffffc02082e8:	f822                	sd	s0,48(sp)
ffffffffc02082ea:	f426                	sd	s1,40(sp)
ffffffffc02082ec:	842e                	mv	s0,a1
ffffffffc02082ee:	84b2                	mv	s1,a2
ffffffffc02082f0:	002c                	addi	a1,sp,8
ffffffffc02082f2:	0830                	addi	a2,sp,24
ffffffffc02082f4:	fc06                	sd	ra,56(sp)
ffffffffc02082f6:	e42a                	sd	a0,8(sp)
ffffffffc02082f8:	e41ff0ef          	jal	ra,ffffffffc0208138 <get_device>
ffffffffc02082fc:	e509                	bnez	a0,ffffffffc0208306 <vfs_lookup_parent+0x20>
ffffffffc02082fe:	67a2                	ld	a5,8(sp)
ffffffffc0208300:	e09c                	sd	a5,0(s1)
ffffffffc0208302:	67e2                	ld	a5,24(sp)
ffffffffc0208304:	e01c                	sd	a5,0(s0)
ffffffffc0208306:	70e2                	ld	ra,56(sp)
ffffffffc0208308:	7442                	ld	s0,48(sp)
ffffffffc020830a:	74a2                	ld	s1,40(sp)
ffffffffc020830c:	6121                	addi	sp,sp,64
ffffffffc020830e:	8082                	ret

ffffffffc0208310 <vfs_get_curdir>:
ffffffffc0208310:	0008e797          	auipc	a5,0x8e
ffffffffc0208314:	5b07b783          	ld	a5,1456(a5) # ffffffffc02968c0 <current>
ffffffffc0208318:	1487b783          	ld	a5,328(a5)
ffffffffc020831c:	1101                	addi	sp,sp,-32
ffffffffc020831e:	e426                	sd	s1,8(sp)
ffffffffc0208320:	6384                	ld	s1,0(a5)
ffffffffc0208322:	ec06                	sd	ra,24(sp)
ffffffffc0208324:	e822                	sd	s0,16(sp)
ffffffffc0208326:	cc81                	beqz	s1,ffffffffc020833e <vfs_get_curdir+0x2e>
ffffffffc0208328:	842a                	mv	s0,a0
ffffffffc020832a:	8526                	mv	a0,s1
ffffffffc020832c:	d4eff0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc0208330:	4501                	li	a0,0
ffffffffc0208332:	e004                	sd	s1,0(s0)
ffffffffc0208334:	60e2                	ld	ra,24(sp)
ffffffffc0208336:	6442                	ld	s0,16(sp)
ffffffffc0208338:	64a2                	ld	s1,8(sp)
ffffffffc020833a:	6105                	addi	sp,sp,32
ffffffffc020833c:	8082                	ret
ffffffffc020833e:	5541                	li	a0,-16
ffffffffc0208340:	bfd5                	j	ffffffffc0208334 <vfs_get_curdir+0x24>

ffffffffc0208342 <vfs_set_curdir>:
ffffffffc0208342:	7139                	addi	sp,sp,-64
ffffffffc0208344:	f04a                	sd	s2,32(sp)
ffffffffc0208346:	0008e917          	auipc	s2,0x8e
ffffffffc020834a:	57a90913          	addi	s2,s2,1402 # ffffffffc02968c0 <current>
ffffffffc020834e:	00093783          	ld	a5,0(s2)
ffffffffc0208352:	f822                	sd	s0,48(sp)
ffffffffc0208354:	842a                	mv	s0,a0
ffffffffc0208356:	1487b503          	ld	a0,328(a5)
ffffffffc020835a:	ec4e                	sd	s3,24(sp)
ffffffffc020835c:	fc06                	sd	ra,56(sp)
ffffffffc020835e:	f426                	sd	s1,40(sp)
ffffffffc0208360:	eb3fc0ef          	jal	ra,ffffffffc0205212 <lock_files>
ffffffffc0208364:	00093783          	ld	a5,0(s2)
ffffffffc0208368:	1487b503          	ld	a0,328(a5)
ffffffffc020836c:	00053983          	ld	s3,0(a0)
ffffffffc0208370:	07340963          	beq	s0,s3,ffffffffc02083e2 <vfs_set_curdir+0xa0>
ffffffffc0208374:	cc39                	beqz	s0,ffffffffc02083d2 <vfs_set_curdir+0x90>
ffffffffc0208376:	783c                	ld	a5,112(s0)
ffffffffc0208378:	c7bd                	beqz	a5,ffffffffc02083e6 <vfs_set_curdir+0xa4>
ffffffffc020837a:	6bbc                	ld	a5,80(a5)
ffffffffc020837c:	c7ad                	beqz	a5,ffffffffc02083e6 <vfs_set_curdir+0xa4>
ffffffffc020837e:	00006597          	auipc	a1,0x6
ffffffffc0208382:	5b258593          	addi	a1,a1,1458 # ffffffffc020e930 <syscalls+0xdb0>
ffffffffc0208386:	8522                	mv	a0,s0
ffffffffc0208388:	d0aff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020838c:	783c                	ld	a5,112(s0)
ffffffffc020838e:	006c                	addi	a1,sp,12
ffffffffc0208390:	8522                	mv	a0,s0
ffffffffc0208392:	6bbc                	ld	a5,80(a5)
ffffffffc0208394:	9782                	jalr	a5
ffffffffc0208396:	84aa                	mv	s1,a0
ffffffffc0208398:	e901                	bnez	a0,ffffffffc02083a8 <vfs_set_curdir+0x66>
ffffffffc020839a:	47b2                	lw	a5,12(sp)
ffffffffc020839c:	669d                	lui	a3,0x7
ffffffffc020839e:	6709                	lui	a4,0x2
ffffffffc02083a0:	8ff5                	and	a5,a5,a3
ffffffffc02083a2:	54b9                	li	s1,-18
ffffffffc02083a4:	02e78063          	beq	a5,a4,ffffffffc02083c4 <vfs_set_curdir+0x82>
ffffffffc02083a8:	00093783          	ld	a5,0(s2)
ffffffffc02083ac:	1487b503          	ld	a0,328(a5)
ffffffffc02083b0:	e69fc0ef          	jal	ra,ffffffffc0205218 <unlock_files>
ffffffffc02083b4:	70e2                	ld	ra,56(sp)
ffffffffc02083b6:	7442                	ld	s0,48(sp)
ffffffffc02083b8:	7902                	ld	s2,32(sp)
ffffffffc02083ba:	69e2                	ld	s3,24(sp)
ffffffffc02083bc:	8526                	mv	a0,s1
ffffffffc02083be:	74a2                	ld	s1,40(sp)
ffffffffc02083c0:	6121                	addi	sp,sp,64
ffffffffc02083c2:	8082                	ret
ffffffffc02083c4:	8522                	mv	a0,s0
ffffffffc02083c6:	cb4ff0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc02083ca:	00093783          	ld	a5,0(s2)
ffffffffc02083ce:	1487b503          	ld	a0,328(a5)
ffffffffc02083d2:	e100                	sd	s0,0(a0)
ffffffffc02083d4:	4481                	li	s1,0
ffffffffc02083d6:	fc098de3          	beqz	s3,ffffffffc02083b0 <vfs_set_curdir+0x6e>
ffffffffc02083da:	854e                	mv	a0,s3
ffffffffc02083dc:	d6cff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc02083e0:	b7e1                	j	ffffffffc02083a8 <vfs_set_curdir+0x66>
ffffffffc02083e2:	4481                	li	s1,0
ffffffffc02083e4:	b7f1                	j	ffffffffc02083b0 <vfs_set_curdir+0x6e>
ffffffffc02083e6:	00006697          	auipc	a3,0x6
ffffffffc02083ea:	4e268693          	addi	a3,a3,1250 # ffffffffc020e8c8 <syscalls+0xd48>
ffffffffc02083ee:	00003617          	auipc	a2,0x3
ffffffffc02083f2:	5ba60613          	addi	a2,a2,1466 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02083f6:	04300593          	li	a1,67
ffffffffc02083fa:	00006517          	auipc	a0,0x6
ffffffffc02083fe:	51e50513          	addi	a0,a0,1310 # ffffffffc020e918 <syscalls+0xd98>
ffffffffc0208402:	89cf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208406 <vfs_chdir>:
ffffffffc0208406:	1101                	addi	sp,sp,-32
ffffffffc0208408:	002c                	addi	a1,sp,8
ffffffffc020840a:	e822                	sd	s0,16(sp)
ffffffffc020840c:	ec06                	sd	ra,24(sp)
ffffffffc020840e:	e43ff0ef          	jal	ra,ffffffffc0208250 <vfs_lookup>
ffffffffc0208412:	842a                	mv	s0,a0
ffffffffc0208414:	c511                	beqz	a0,ffffffffc0208420 <vfs_chdir+0x1a>
ffffffffc0208416:	60e2                	ld	ra,24(sp)
ffffffffc0208418:	8522                	mv	a0,s0
ffffffffc020841a:	6442                	ld	s0,16(sp)
ffffffffc020841c:	6105                	addi	sp,sp,32
ffffffffc020841e:	8082                	ret
ffffffffc0208420:	6522                	ld	a0,8(sp)
ffffffffc0208422:	f21ff0ef          	jal	ra,ffffffffc0208342 <vfs_set_curdir>
ffffffffc0208426:	842a                	mv	s0,a0
ffffffffc0208428:	6522                	ld	a0,8(sp)
ffffffffc020842a:	d1eff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020842e:	60e2                	ld	ra,24(sp)
ffffffffc0208430:	8522                	mv	a0,s0
ffffffffc0208432:	6442                	ld	s0,16(sp)
ffffffffc0208434:	6105                	addi	sp,sp,32
ffffffffc0208436:	8082                	ret

ffffffffc0208438 <vfs_getcwd>:
ffffffffc0208438:	0008e797          	auipc	a5,0x8e
ffffffffc020843c:	4887b783          	ld	a5,1160(a5) # ffffffffc02968c0 <current>
ffffffffc0208440:	1487b783          	ld	a5,328(a5)
ffffffffc0208444:	7179                	addi	sp,sp,-48
ffffffffc0208446:	ec26                	sd	s1,24(sp)
ffffffffc0208448:	6384                	ld	s1,0(a5)
ffffffffc020844a:	f406                	sd	ra,40(sp)
ffffffffc020844c:	f022                	sd	s0,32(sp)
ffffffffc020844e:	e84a                	sd	s2,16(sp)
ffffffffc0208450:	ccbd                	beqz	s1,ffffffffc02084ce <vfs_getcwd+0x96>
ffffffffc0208452:	892a                	mv	s2,a0
ffffffffc0208454:	8526                	mv	a0,s1
ffffffffc0208456:	c24ff0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc020845a:	74a8                	ld	a0,104(s1)
ffffffffc020845c:	c93d                	beqz	a0,ffffffffc02084d2 <vfs_getcwd+0x9a>
ffffffffc020845e:	9b3ff0ef          	jal	ra,ffffffffc0207e10 <vfs_get_devname>
ffffffffc0208462:	842a                	mv	s0,a0
ffffffffc0208464:	7bf020ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc0208468:	862a                	mv	a2,a0
ffffffffc020846a:	85a2                	mv	a1,s0
ffffffffc020846c:	4701                	li	a4,0
ffffffffc020846e:	4685                	li	a3,1
ffffffffc0208470:	854a                	mv	a0,s2
ffffffffc0208472:	fcbfc0ef          	jal	ra,ffffffffc020543c <iobuf_move>
ffffffffc0208476:	842a                	mv	s0,a0
ffffffffc0208478:	c919                	beqz	a0,ffffffffc020848e <vfs_getcwd+0x56>
ffffffffc020847a:	8526                	mv	a0,s1
ffffffffc020847c:	cccff0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc0208480:	70a2                	ld	ra,40(sp)
ffffffffc0208482:	8522                	mv	a0,s0
ffffffffc0208484:	7402                	ld	s0,32(sp)
ffffffffc0208486:	64e2                	ld	s1,24(sp)
ffffffffc0208488:	6942                	ld	s2,16(sp)
ffffffffc020848a:	6145                	addi	sp,sp,48
ffffffffc020848c:	8082                	ret
ffffffffc020848e:	03a00793          	li	a5,58
ffffffffc0208492:	4701                	li	a4,0
ffffffffc0208494:	4685                	li	a3,1
ffffffffc0208496:	4605                	li	a2,1
ffffffffc0208498:	00f10593          	addi	a1,sp,15
ffffffffc020849c:	854a                	mv	a0,s2
ffffffffc020849e:	00f107a3          	sb	a5,15(sp)
ffffffffc02084a2:	f9bfc0ef          	jal	ra,ffffffffc020543c <iobuf_move>
ffffffffc02084a6:	842a                	mv	s0,a0
ffffffffc02084a8:	f969                	bnez	a0,ffffffffc020847a <vfs_getcwd+0x42>
ffffffffc02084aa:	78bc                	ld	a5,112(s1)
ffffffffc02084ac:	c3b9                	beqz	a5,ffffffffc02084f2 <vfs_getcwd+0xba>
ffffffffc02084ae:	7f9c                	ld	a5,56(a5)
ffffffffc02084b0:	c3a9                	beqz	a5,ffffffffc02084f2 <vfs_getcwd+0xba>
ffffffffc02084b2:	00006597          	auipc	a1,0x6
ffffffffc02084b6:	4de58593          	addi	a1,a1,1246 # ffffffffc020e990 <syscalls+0xe10>
ffffffffc02084ba:	8526                	mv	a0,s1
ffffffffc02084bc:	bd6ff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc02084c0:	78bc                	ld	a5,112(s1)
ffffffffc02084c2:	85ca                	mv	a1,s2
ffffffffc02084c4:	8526                	mv	a0,s1
ffffffffc02084c6:	7f9c                	ld	a5,56(a5)
ffffffffc02084c8:	9782                	jalr	a5
ffffffffc02084ca:	842a                	mv	s0,a0
ffffffffc02084cc:	b77d                	j	ffffffffc020847a <vfs_getcwd+0x42>
ffffffffc02084ce:	5441                	li	s0,-16
ffffffffc02084d0:	bf45                	j	ffffffffc0208480 <vfs_getcwd+0x48>
ffffffffc02084d2:	00006697          	auipc	a3,0x6
ffffffffc02084d6:	38668693          	addi	a3,a3,902 # ffffffffc020e858 <syscalls+0xcd8>
ffffffffc02084da:	00003617          	auipc	a2,0x3
ffffffffc02084de:	4ce60613          	addi	a2,a2,1230 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02084e2:	06e00593          	li	a1,110
ffffffffc02084e6:	00006517          	auipc	a0,0x6
ffffffffc02084ea:	43250513          	addi	a0,a0,1074 # ffffffffc020e918 <syscalls+0xd98>
ffffffffc02084ee:	fb1f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02084f2:	00006697          	auipc	a3,0x6
ffffffffc02084f6:	44668693          	addi	a3,a3,1094 # ffffffffc020e938 <syscalls+0xdb8>
ffffffffc02084fa:	00003617          	auipc	a2,0x3
ffffffffc02084fe:	4ae60613          	addi	a2,a2,1198 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208502:	07800593          	li	a1,120
ffffffffc0208506:	00006517          	auipc	a0,0x6
ffffffffc020850a:	41250513          	addi	a0,a0,1042 # ffffffffc020e918 <syscalls+0xd98>
ffffffffc020850e:	f91f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208512 <dev_lookup>:
ffffffffc0208512:	0005c783          	lbu	a5,0(a1)
ffffffffc0208516:	e385                	bnez	a5,ffffffffc0208536 <dev_lookup+0x24>
ffffffffc0208518:	1101                	addi	sp,sp,-32
ffffffffc020851a:	e822                	sd	s0,16(sp)
ffffffffc020851c:	e426                	sd	s1,8(sp)
ffffffffc020851e:	ec06                	sd	ra,24(sp)
ffffffffc0208520:	84aa                	mv	s1,a0
ffffffffc0208522:	8432                	mv	s0,a2
ffffffffc0208524:	b56ff0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc0208528:	60e2                	ld	ra,24(sp)
ffffffffc020852a:	e004                	sd	s1,0(s0)
ffffffffc020852c:	6442                	ld	s0,16(sp)
ffffffffc020852e:	64a2                	ld	s1,8(sp)
ffffffffc0208530:	4501                	li	a0,0
ffffffffc0208532:	6105                	addi	sp,sp,32
ffffffffc0208534:	8082                	ret
ffffffffc0208536:	5541                	li	a0,-16
ffffffffc0208538:	8082                	ret

ffffffffc020853a <dev_fstat>:
ffffffffc020853a:	1101                	addi	sp,sp,-32
ffffffffc020853c:	e426                	sd	s1,8(sp)
ffffffffc020853e:	84ae                	mv	s1,a1
ffffffffc0208540:	e822                	sd	s0,16(sp)
ffffffffc0208542:	02000613          	li	a2,32
ffffffffc0208546:	842a                	mv	s0,a0
ffffffffc0208548:	4581                	li	a1,0
ffffffffc020854a:	8526                	mv	a0,s1
ffffffffc020854c:	ec06                	sd	ra,24(sp)
ffffffffc020854e:	777020ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0208552:	c429                	beqz	s0,ffffffffc020859c <dev_fstat+0x62>
ffffffffc0208554:	783c                	ld	a5,112(s0)
ffffffffc0208556:	c3b9                	beqz	a5,ffffffffc020859c <dev_fstat+0x62>
ffffffffc0208558:	6bbc                	ld	a5,80(a5)
ffffffffc020855a:	c3a9                	beqz	a5,ffffffffc020859c <dev_fstat+0x62>
ffffffffc020855c:	00006597          	auipc	a1,0x6
ffffffffc0208560:	3d458593          	addi	a1,a1,980 # ffffffffc020e930 <syscalls+0xdb0>
ffffffffc0208564:	8522                	mv	a0,s0
ffffffffc0208566:	b2cff0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020856a:	783c                	ld	a5,112(s0)
ffffffffc020856c:	85a6                	mv	a1,s1
ffffffffc020856e:	8522                	mv	a0,s0
ffffffffc0208570:	6bbc                	ld	a5,80(a5)
ffffffffc0208572:	9782                	jalr	a5
ffffffffc0208574:	ed19                	bnez	a0,ffffffffc0208592 <dev_fstat+0x58>
ffffffffc0208576:	4c38                	lw	a4,88(s0)
ffffffffc0208578:	6785                	lui	a5,0x1
ffffffffc020857a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020857e:	02f71f63          	bne	a4,a5,ffffffffc02085bc <dev_fstat+0x82>
ffffffffc0208582:	6018                	ld	a4,0(s0)
ffffffffc0208584:	641c                	ld	a5,8(s0)
ffffffffc0208586:	4685                	li	a3,1
ffffffffc0208588:	e494                	sd	a3,8(s1)
ffffffffc020858a:	02e787b3          	mul	a5,a5,a4
ffffffffc020858e:	e898                	sd	a4,16(s1)
ffffffffc0208590:	ec9c                	sd	a5,24(s1)
ffffffffc0208592:	60e2                	ld	ra,24(sp)
ffffffffc0208594:	6442                	ld	s0,16(sp)
ffffffffc0208596:	64a2                	ld	s1,8(sp)
ffffffffc0208598:	6105                	addi	sp,sp,32
ffffffffc020859a:	8082                	ret
ffffffffc020859c:	00006697          	auipc	a3,0x6
ffffffffc02085a0:	32c68693          	addi	a3,a3,812 # ffffffffc020e8c8 <syscalls+0xd48>
ffffffffc02085a4:	00003617          	auipc	a2,0x3
ffffffffc02085a8:	40460613          	addi	a2,a2,1028 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02085ac:	04200593          	li	a1,66
ffffffffc02085b0:	00006517          	auipc	a0,0x6
ffffffffc02085b4:	3f050513          	addi	a0,a0,1008 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc02085b8:	ee7f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02085bc:	00006697          	auipc	a3,0x6
ffffffffc02085c0:	0d468693          	addi	a3,a3,212 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc02085c4:	00003617          	auipc	a2,0x3
ffffffffc02085c8:	3e460613          	addi	a2,a2,996 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02085cc:	04500593          	li	a1,69
ffffffffc02085d0:	00006517          	auipc	a0,0x6
ffffffffc02085d4:	3d050513          	addi	a0,a0,976 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc02085d8:	ec7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02085dc <dev_ioctl>:
ffffffffc02085dc:	c909                	beqz	a0,ffffffffc02085ee <dev_ioctl+0x12>
ffffffffc02085de:	4d34                	lw	a3,88(a0)
ffffffffc02085e0:	6705                	lui	a4,0x1
ffffffffc02085e2:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02085e6:	00e69463          	bne	a3,a4,ffffffffc02085ee <dev_ioctl+0x12>
ffffffffc02085ea:	751c                	ld	a5,40(a0)
ffffffffc02085ec:	8782                	jr	a5
ffffffffc02085ee:	1141                	addi	sp,sp,-16
ffffffffc02085f0:	00006697          	auipc	a3,0x6
ffffffffc02085f4:	0a068693          	addi	a3,a3,160 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc02085f8:	00003617          	auipc	a2,0x3
ffffffffc02085fc:	3b060613          	addi	a2,a2,944 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208600:	03500593          	li	a1,53
ffffffffc0208604:	00006517          	auipc	a0,0x6
ffffffffc0208608:	39c50513          	addi	a0,a0,924 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc020860c:	e406                	sd	ra,8(sp)
ffffffffc020860e:	e91f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208612 <dev_tryseek>:
ffffffffc0208612:	c51d                	beqz	a0,ffffffffc0208640 <dev_tryseek+0x2e>
ffffffffc0208614:	4d38                	lw	a4,88(a0)
ffffffffc0208616:	6785                	lui	a5,0x1
ffffffffc0208618:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020861c:	02f71263          	bne	a4,a5,ffffffffc0208640 <dev_tryseek+0x2e>
ffffffffc0208620:	611c                	ld	a5,0(a0)
ffffffffc0208622:	cf89                	beqz	a5,ffffffffc020863c <dev_tryseek+0x2a>
ffffffffc0208624:	6518                	ld	a4,8(a0)
ffffffffc0208626:	02e5f6b3          	remu	a3,a1,a4
ffffffffc020862a:	ea89                	bnez	a3,ffffffffc020863c <dev_tryseek+0x2a>
ffffffffc020862c:	0005c863          	bltz	a1,ffffffffc020863c <dev_tryseek+0x2a>
ffffffffc0208630:	02e787b3          	mul	a5,a5,a4
ffffffffc0208634:	00f5f463          	bgeu	a1,a5,ffffffffc020863c <dev_tryseek+0x2a>
ffffffffc0208638:	4501                	li	a0,0
ffffffffc020863a:	8082                	ret
ffffffffc020863c:	5575                	li	a0,-3
ffffffffc020863e:	8082                	ret
ffffffffc0208640:	1141                	addi	sp,sp,-16
ffffffffc0208642:	00006697          	auipc	a3,0x6
ffffffffc0208646:	04e68693          	addi	a3,a3,78 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc020864a:	00003617          	auipc	a2,0x3
ffffffffc020864e:	35e60613          	addi	a2,a2,862 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208652:	05f00593          	li	a1,95
ffffffffc0208656:	00006517          	auipc	a0,0x6
ffffffffc020865a:	34a50513          	addi	a0,a0,842 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc020865e:	e406                	sd	ra,8(sp)
ffffffffc0208660:	e3ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208664 <dev_gettype>:
ffffffffc0208664:	c10d                	beqz	a0,ffffffffc0208686 <dev_gettype+0x22>
ffffffffc0208666:	4d38                	lw	a4,88(a0)
ffffffffc0208668:	6785                	lui	a5,0x1
ffffffffc020866a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020866e:	00f71c63          	bne	a4,a5,ffffffffc0208686 <dev_gettype+0x22>
ffffffffc0208672:	6118                	ld	a4,0(a0)
ffffffffc0208674:	6795                	lui	a5,0x5
ffffffffc0208676:	c701                	beqz	a4,ffffffffc020867e <dev_gettype+0x1a>
ffffffffc0208678:	c19c                	sw	a5,0(a1)
ffffffffc020867a:	4501                	li	a0,0
ffffffffc020867c:	8082                	ret
ffffffffc020867e:	6791                	lui	a5,0x4
ffffffffc0208680:	c19c                	sw	a5,0(a1)
ffffffffc0208682:	4501                	li	a0,0
ffffffffc0208684:	8082                	ret
ffffffffc0208686:	1141                	addi	sp,sp,-16
ffffffffc0208688:	00006697          	auipc	a3,0x6
ffffffffc020868c:	00868693          	addi	a3,a3,8 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208690:	00003617          	auipc	a2,0x3
ffffffffc0208694:	31860613          	addi	a2,a2,792 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208698:	05300593          	li	a1,83
ffffffffc020869c:	00006517          	auipc	a0,0x6
ffffffffc02086a0:	30450513          	addi	a0,a0,772 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc02086a4:	e406                	sd	ra,8(sp)
ffffffffc02086a6:	df9f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02086aa <dev_write>:
ffffffffc02086aa:	c911                	beqz	a0,ffffffffc02086be <dev_write+0x14>
ffffffffc02086ac:	4d34                	lw	a3,88(a0)
ffffffffc02086ae:	6705                	lui	a4,0x1
ffffffffc02086b0:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02086b4:	00e69563          	bne	a3,a4,ffffffffc02086be <dev_write+0x14>
ffffffffc02086b8:	711c                	ld	a5,32(a0)
ffffffffc02086ba:	4605                	li	a2,1
ffffffffc02086bc:	8782                	jr	a5
ffffffffc02086be:	1141                	addi	sp,sp,-16
ffffffffc02086c0:	00006697          	auipc	a3,0x6
ffffffffc02086c4:	fd068693          	addi	a3,a3,-48 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc02086c8:	00003617          	auipc	a2,0x3
ffffffffc02086cc:	2e060613          	addi	a2,a2,736 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02086d0:	02c00593          	li	a1,44
ffffffffc02086d4:	00006517          	auipc	a0,0x6
ffffffffc02086d8:	2cc50513          	addi	a0,a0,716 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc02086dc:	e406                	sd	ra,8(sp)
ffffffffc02086de:	dc1f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02086e2 <dev_read>:
ffffffffc02086e2:	c911                	beqz	a0,ffffffffc02086f6 <dev_read+0x14>
ffffffffc02086e4:	4d34                	lw	a3,88(a0)
ffffffffc02086e6:	6705                	lui	a4,0x1
ffffffffc02086e8:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02086ec:	00e69563          	bne	a3,a4,ffffffffc02086f6 <dev_read+0x14>
ffffffffc02086f0:	711c                	ld	a5,32(a0)
ffffffffc02086f2:	4601                	li	a2,0
ffffffffc02086f4:	8782                	jr	a5
ffffffffc02086f6:	1141                	addi	sp,sp,-16
ffffffffc02086f8:	00006697          	auipc	a3,0x6
ffffffffc02086fc:	f9868693          	addi	a3,a3,-104 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208700:	00003617          	auipc	a2,0x3
ffffffffc0208704:	2a860613          	addi	a2,a2,680 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208708:	02300593          	li	a1,35
ffffffffc020870c:	00006517          	auipc	a0,0x6
ffffffffc0208710:	29450513          	addi	a0,a0,660 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc0208714:	e406                	sd	ra,8(sp)
ffffffffc0208716:	d89f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020871a <dev_close>:
ffffffffc020871a:	c909                	beqz	a0,ffffffffc020872c <dev_close+0x12>
ffffffffc020871c:	4d34                	lw	a3,88(a0)
ffffffffc020871e:	6705                	lui	a4,0x1
ffffffffc0208720:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208724:	00e69463          	bne	a3,a4,ffffffffc020872c <dev_close+0x12>
ffffffffc0208728:	6d1c                	ld	a5,24(a0)
ffffffffc020872a:	8782                	jr	a5
ffffffffc020872c:	1141                	addi	sp,sp,-16
ffffffffc020872e:	00006697          	auipc	a3,0x6
ffffffffc0208732:	f6268693          	addi	a3,a3,-158 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208736:	00003617          	auipc	a2,0x3
ffffffffc020873a:	27260613          	addi	a2,a2,626 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020873e:	45e9                	li	a1,26
ffffffffc0208740:	00006517          	auipc	a0,0x6
ffffffffc0208744:	26050513          	addi	a0,a0,608 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc0208748:	e406                	sd	ra,8(sp)
ffffffffc020874a:	d55f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020874e <dev_open>:
ffffffffc020874e:	03c5f713          	andi	a4,a1,60
ffffffffc0208752:	eb11                	bnez	a4,ffffffffc0208766 <dev_open+0x18>
ffffffffc0208754:	c919                	beqz	a0,ffffffffc020876a <dev_open+0x1c>
ffffffffc0208756:	4d34                	lw	a3,88(a0)
ffffffffc0208758:	6705                	lui	a4,0x1
ffffffffc020875a:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020875e:	00e69663          	bne	a3,a4,ffffffffc020876a <dev_open+0x1c>
ffffffffc0208762:	691c                	ld	a5,16(a0)
ffffffffc0208764:	8782                	jr	a5
ffffffffc0208766:	5575                	li	a0,-3
ffffffffc0208768:	8082                	ret
ffffffffc020876a:	1141                	addi	sp,sp,-16
ffffffffc020876c:	00006697          	auipc	a3,0x6
ffffffffc0208770:	f2468693          	addi	a3,a3,-220 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208774:	00003617          	auipc	a2,0x3
ffffffffc0208778:	23460613          	addi	a2,a2,564 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020877c:	45c5                	li	a1,17
ffffffffc020877e:	00006517          	auipc	a0,0x6
ffffffffc0208782:	22250513          	addi	a0,a0,546 # ffffffffc020e9a0 <syscalls+0xe20>
ffffffffc0208786:	e406                	sd	ra,8(sp)
ffffffffc0208788:	d17f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020878c <dev_init>:
ffffffffc020878c:	1141                	addi	sp,sp,-16
ffffffffc020878e:	e406                	sd	ra,8(sp)
ffffffffc0208790:	542000ef          	jal	ra,ffffffffc0208cd2 <dev_init_stdin>
ffffffffc0208794:	65a000ef          	jal	ra,ffffffffc0208dee <dev_init_stdout>
ffffffffc0208798:	60a2                	ld	ra,8(sp)
ffffffffc020879a:	0141                	addi	sp,sp,16
ffffffffc020879c:	a439                	j	ffffffffc02089aa <dev_init_disk0>

ffffffffc020879e <dev_create_inode>:
ffffffffc020879e:	6505                	lui	a0,0x1
ffffffffc02087a0:	1141                	addi	sp,sp,-16
ffffffffc02087a2:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02087a6:	e022                	sd	s0,0(sp)
ffffffffc02087a8:	e406                	sd	ra,8(sp)
ffffffffc02087aa:	852ff0ef          	jal	ra,ffffffffc02077fc <__alloc_inode>
ffffffffc02087ae:	842a                	mv	s0,a0
ffffffffc02087b0:	c901                	beqz	a0,ffffffffc02087c0 <dev_create_inode+0x22>
ffffffffc02087b2:	4601                	li	a2,0
ffffffffc02087b4:	00006597          	auipc	a1,0x6
ffffffffc02087b8:	20458593          	addi	a1,a1,516 # ffffffffc020e9b8 <dev_node_ops>
ffffffffc02087bc:	85cff0ef          	jal	ra,ffffffffc0207818 <inode_init>
ffffffffc02087c0:	60a2                	ld	ra,8(sp)
ffffffffc02087c2:	8522                	mv	a0,s0
ffffffffc02087c4:	6402                	ld	s0,0(sp)
ffffffffc02087c6:	0141                	addi	sp,sp,16
ffffffffc02087c8:	8082                	ret

ffffffffc02087ca <disk0_open>:
ffffffffc02087ca:	4501                	li	a0,0
ffffffffc02087cc:	8082                	ret

ffffffffc02087ce <disk0_close>:
ffffffffc02087ce:	4501                	li	a0,0
ffffffffc02087d0:	8082                	ret

ffffffffc02087d2 <disk0_ioctl>:
ffffffffc02087d2:	5531                	li	a0,-20
ffffffffc02087d4:	8082                	ret

ffffffffc02087d6 <disk0_io>:
ffffffffc02087d6:	659c                	ld	a5,8(a1)
ffffffffc02087d8:	7159                	addi	sp,sp,-112
ffffffffc02087da:	eca6                	sd	s1,88(sp)
ffffffffc02087dc:	f45e                	sd	s7,40(sp)
ffffffffc02087de:	6d84                	ld	s1,24(a1)
ffffffffc02087e0:	6b85                	lui	s7,0x1
ffffffffc02087e2:	1bfd                	addi	s7,s7,-1
ffffffffc02087e4:	e4ce                	sd	s3,72(sp)
ffffffffc02087e6:	43f7d993          	srai	s3,a5,0x3f
ffffffffc02087ea:	0179f9b3          	and	s3,s3,s7
ffffffffc02087ee:	99be                	add	s3,s3,a5
ffffffffc02087f0:	8fc5                	or	a5,a5,s1
ffffffffc02087f2:	f486                	sd	ra,104(sp)
ffffffffc02087f4:	f0a2                	sd	s0,96(sp)
ffffffffc02087f6:	e8ca                	sd	s2,80(sp)
ffffffffc02087f8:	e0d2                	sd	s4,64(sp)
ffffffffc02087fa:	fc56                	sd	s5,56(sp)
ffffffffc02087fc:	f85a                	sd	s6,48(sp)
ffffffffc02087fe:	f062                	sd	s8,32(sp)
ffffffffc0208800:	ec66                	sd	s9,24(sp)
ffffffffc0208802:	e86a                	sd	s10,16(sp)
ffffffffc0208804:	0177f7b3          	and	a5,a5,s7
ffffffffc0208808:	10079d63          	bnez	a5,ffffffffc0208922 <disk0_io+0x14c>
ffffffffc020880c:	40c9d993          	srai	s3,s3,0xc
ffffffffc0208810:	00c4d713          	srli	a4,s1,0xc
ffffffffc0208814:	2981                	sext.w	s3,s3
ffffffffc0208816:	2701                	sext.w	a4,a4
ffffffffc0208818:	00e987bb          	addw	a5,s3,a4
ffffffffc020881c:	6114                	ld	a3,0(a0)
ffffffffc020881e:	1782                	slli	a5,a5,0x20
ffffffffc0208820:	9381                	srli	a5,a5,0x20
ffffffffc0208822:	10f6e063          	bltu	a3,a5,ffffffffc0208922 <disk0_io+0x14c>
ffffffffc0208826:	4501                	li	a0,0
ffffffffc0208828:	ef19                	bnez	a4,ffffffffc0208846 <disk0_io+0x70>
ffffffffc020882a:	70a6                	ld	ra,104(sp)
ffffffffc020882c:	7406                	ld	s0,96(sp)
ffffffffc020882e:	64e6                	ld	s1,88(sp)
ffffffffc0208830:	6946                	ld	s2,80(sp)
ffffffffc0208832:	69a6                	ld	s3,72(sp)
ffffffffc0208834:	6a06                	ld	s4,64(sp)
ffffffffc0208836:	7ae2                	ld	s5,56(sp)
ffffffffc0208838:	7b42                	ld	s6,48(sp)
ffffffffc020883a:	7ba2                	ld	s7,40(sp)
ffffffffc020883c:	7c02                	ld	s8,32(sp)
ffffffffc020883e:	6ce2                	ld	s9,24(sp)
ffffffffc0208840:	6d42                	ld	s10,16(sp)
ffffffffc0208842:	6165                	addi	sp,sp,112
ffffffffc0208844:	8082                	ret
ffffffffc0208846:	0008d517          	auipc	a0,0x8d
ffffffffc020884a:	ffa50513          	addi	a0,a0,-6 # ffffffffc0295840 <disk0_sem>
ffffffffc020884e:	8b2e                	mv	s6,a1
ffffffffc0208850:	8c32                	mv	s8,a2
ffffffffc0208852:	0008ea97          	auipc	s5,0x8e
ffffffffc0208856:	0a6a8a93          	addi	s5,s5,166 # ffffffffc02968f8 <disk0_buffer>
ffffffffc020885a:	d5bfb0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020885e:	6c91                	lui	s9,0x4
ffffffffc0208860:	e4b9                	bnez	s1,ffffffffc02088ae <disk0_io+0xd8>
ffffffffc0208862:	a845                	j	ffffffffc0208912 <disk0_io+0x13c>
ffffffffc0208864:	00c4d413          	srli	s0,s1,0xc
ffffffffc0208868:	0034169b          	slliw	a3,s0,0x3
ffffffffc020886c:	00068d1b          	sext.w	s10,a3
ffffffffc0208870:	1682                	slli	a3,a3,0x20
ffffffffc0208872:	2401                	sext.w	s0,s0
ffffffffc0208874:	9281                	srli	a3,a3,0x20
ffffffffc0208876:	8926                	mv	s2,s1
ffffffffc0208878:	00399a1b          	slliw	s4,s3,0x3
ffffffffc020887c:	862e                	mv	a2,a1
ffffffffc020887e:	4509                	li	a0,2
ffffffffc0208880:	85d2                	mv	a1,s4
ffffffffc0208882:	abef80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208886:	e165                	bnez	a0,ffffffffc0208966 <disk0_io+0x190>
ffffffffc0208888:	000ab583          	ld	a1,0(s5)
ffffffffc020888c:	0038                	addi	a4,sp,8
ffffffffc020888e:	4685                	li	a3,1
ffffffffc0208890:	864a                	mv	a2,s2
ffffffffc0208892:	855a                	mv	a0,s6
ffffffffc0208894:	ba9fc0ef          	jal	ra,ffffffffc020543c <iobuf_move>
ffffffffc0208898:	67a2                	ld	a5,8(sp)
ffffffffc020889a:	09279663          	bne	a5,s2,ffffffffc0208926 <disk0_io+0x150>
ffffffffc020889e:	017977b3          	and	a5,s2,s7
ffffffffc02088a2:	e3d1                	bnez	a5,ffffffffc0208926 <disk0_io+0x150>
ffffffffc02088a4:	412484b3          	sub	s1,s1,s2
ffffffffc02088a8:	013409bb          	addw	s3,s0,s3
ffffffffc02088ac:	c0bd                	beqz	s1,ffffffffc0208912 <disk0_io+0x13c>
ffffffffc02088ae:	000ab583          	ld	a1,0(s5)
ffffffffc02088b2:	000c1b63          	bnez	s8,ffffffffc02088c8 <disk0_io+0xf2>
ffffffffc02088b6:	fb94e7e3          	bltu	s1,s9,ffffffffc0208864 <disk0_io+0x8e>
ffffffffc02088ba:	02000693          	li	a3,32
ffffffffc02088be:	02000d13          	li	s10,32
ffffffffc02088c2:	4411                	li	s0,4
ffffffffc02088c4:	6911                	lui	s2,0x4
ffffffffc02088c6:	bf4d                	j	ffffffffc0208878 <disk0_io+0xa2>
ffffffffc02088c8:	0038                	addi	a4,sp,8
ffffffffc02088ca:	4681                	li	a3,0
ffffffffc02088cc:	6611                	lui	a2,0x4
ffffffffc02088ce:	855a                	mv	a0,s6
ffffffffc02088d0:	b6dfc0ef          	jal	ra,ffffffffc020543c <iobuf_move>
ffffffffc02088d4:	6422                	ld	s0,8(sp)
ffffffffc02088d6:	c825                	beqz	s0,ffffffffc0208946 <disk0_io+0x170>
ffffffffc02088d8:	0684e763          	bltu	s1,s0,ffffffffc0208946 <disk0_io+0x170>
ffffffffc02088dc:	017477b3          	and	a5,s0,s7
ffffffffc02088e0:	e3bd                	bnez	a5,ffffffffc0208946 <disk0_io+0x170>
ffffffffc02088e2:	8031                	srli	s0,s0,0xc
ffffffffc02088e4:	0034179b          	slliw	a5,s0,0x3
ffffffffc02088e8:	000ab603          	ld	a2,0(s5)
ffffffffc02088ec:	0039991b          	slliw	s2,s3,0x3
ffffffffc02088f0:	02079693          	slli	a3,a5,0x20
ffffffffc02088f4:	9281                	srli	a3,a3,0x20
ffffffffc02088f6:	85ca                	mv	a1,s2
ffffffffc02088f8:	4509                	li	a0,2
ffffffffc02088fa:	2401                	sext.w	s0,s0
ffffffffc02088fc:	00078a1b          	sext.w	s4,a5
ffffffffc0208900:	ad6f80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc0208904:	e151                	bnez	a0,ffffffffc0208988 <disk0_io+0x1b2>
ffffffffc0208906:	6922                	ld	s2,8(sp)
ffffffffc0208908:	013409bb          	addw	s3,s0,s3
ffffffffc020890c:	412484b3          	sub	s1,s1,s2
ffffffffc0208910:	fcd9                	bnez	s1,ffffffffc02088ae <disk0_io+0xd8>
ffffffffc0208912:	0008d517          	auipc	a0,0x8d
ffffffffc0208916:	f2e50513          	addi	a0,a0,-210 # ffffffffc0295840 <disk0_sem>
ffffffffc020891a:	c97fb0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020891e:	4501                	li	a0,0
ffffffffc0208920:	b729                	j	ffffffffc020882a <disk0_io+0x54>
ffffffffc0208922:	5575                	li	a0,-3
ffffffffc0208924:	b719                	j	ffffffffc020882a <disk0_io+0x54>
ffffffffc0208926:	00006697          	auipc	a3,0x6
ffffffffc020892a:	20a68693          	addi	a3,a3,522 # ffffffffc020eb30 <dev_node_ops+0x178>
ffffffffc020892e:	00003617          	auipc	a2,0x3
ffffffffc0208932:	07a60613          	addi	a2,a2,122 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208936:	06200593          	li	a1,98
ffffffffc020893a:	00006517          	auipc	a0,0x6
ffffffffc020893e:	13e50513          	addi	a0,a0,318 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208942:	b5df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208946:	00006697          	auipc	a3,0x6
ffffffffc020894a:	0f268693          	addi	a3,a3,242 # ffffffffc020ea38 <dev_node_ops+0x80>
ffffffffc020894e:	00003617          	auipc	a2,0x3
ffffffffc0208952:	05a60613          	addi	a2,a2,90 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208956:	05700593          	li	a1,87
ffffffffc020895a:	00006517          	auipc	a0,0x6
ffffffffc020895e:	11e50513          	addi	a0,a0,286 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208962:	b3df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208966:	88aa                	mv	a7,a0
ffffffffc0208968:	886a                	mv	a6,s10
ffffffffc020896a:	87a2                	mv	a5,s0
ffffffffc020896c:	8752                	mv	a4,s4
ffffffffc020896e:	86ce                	mv	a3,s3
ffffffffc0208970:	00006617          	auipc	a2,0x6
ffffffffc0208974:	17860613          	addi	a2,a2,376 # ffffffffc020eae8 <dev_node_ops+0x130>
ffffffffc0208978:	02d00593          	li	a1,45
ffffffffc020897c:	00006517          	auipc	a0,0x6
ffffffffc0208980:	0fc50513          	addi	a0,a0,252 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208984:	b1bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208988:	88aa                	mv	a7,a0
ffffffffc020898a:	8852                	mv	a6,s4
ffffffffc020898c:	87a2                	mv	a5,s0
ffffffffc020898e:	874a                	mv	a4,s2
ffffffffc0208990:	86ce                	mv	a3,s3
ffffffffc0208992:	00006617          	auipc	a2,0x6
ffffffffc0208996:	10660613          	addi	a2,a2,262 # ffffffffc020ea98 <dev_node_ops+0xe0>
ffffffffc020899a:	03700593          	li	a1,55
ffffffffc020899e:	00006517          	auipc	a0,0x6
ffffffffc02089a2:	0da50513          	addi	a0,a0,218 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc02089a6:	af9f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02089aa <dev_init_disk0>:
ffffffffc02089aa:	1101                	addi	sp,sp,-32
ffffffffc02089ac:	ec06                	sd	ra,24(sp)
ffffffffc02089ae:	e822                	sd	s0,16(sp)
ffffffffc02089b0:	e426                	sd	s1,8(sp)
ffffffffc02089b2:	dedff0ef          	jal	ra,ffffffffc020879e <dev_create_inode>
ffffffffc02089b6:	c541                	beqz	a0,ffffffffc0208a3e <dev_init_disk0+0x94>
ffffffffc02089b8:	4d38                	lw	a4,88(a0)
ffffffffc02089ba:	6485                	lui	s1,0x1
ffffffffc02089bc:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02089c0:	842a                	mv	s0,a0
ffffffffc02089c2:	0cf71f63          	bne	a4,a5,ffffffffc0208aa0 <dev_init_disk0+0xf6>
ffffffffc02089c6:	4509                	li	a0,2
ffffffffc02089c8:	92cf80ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc02089cc:	cd55                	beqz	a0,ffffffffc0208a88 <dev_init_disk0+0xde>
ffffffffc02089ce:	4509                	li	a0,2
ffffffffc02089d0:	948f80ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc02089d4:	00355793          	srli	a5,a0,0x3
ffffffffc02089d8:	e01c                	sd	a5,0(s0)
ffffffffc02089da:	00000797          	auipc	a5,0x0
ffffffffc02089de:	df078793          	addi	a5,a5,-528 # ffffffffc02087ca <disk0_open>
ffffffffc02089e2:	e81c                	sd	a5,16(s0)
ffffffffc02089e4:	00000797          	auipc	a5,0x0
ffffffffc02089e8:	dea78793          	addi	a5,a5,-534 # ffffffffc02087ce <disk0_close>
ffffffffc02089ec:	ec1c                	sd	a5,24(s0)
ffffffffc02089ee:	00000797          	auipc	a5,0x0
ffffffffc02089f2:	de878793          	addi	a5,a5,-536 # ffffffffc02087d6 <disk0_io>
ffffffffc02089f6:	f01c                	sd	a5,32(s0)
ffffffffc02089f8:	00000797          	auipc	a5,0x0
ffffffffc02089fc:	dda78793          	addi	a5,a5,-550 # ffffffffc02087d2 <disk0_ioctl>
ffffffffc0208a00:	f41c                	sd	a5,40(s0)
ffffffffc0208a02:	4585                	li	a1,1
ffffffffc0208a04:	0008d517          	auipc	a0,0x8d
ffffffffc0208a08:	e3c50513          	addi	a0,a0,-452 # ffffffffc0295840 <disk0_sem>
ffffffffc0208a0c:	e404                	sd	s1,8(s0)
ffffffffc0208a0e:	b9dfb0ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0208a12:	6511                	lui	a0,0x4
ffffffffc0208a14:	dcaf90ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0208a18:	0008e797          	auipc	a5,0x8e
ffffffffc0208a1c:	eea7b023          	sd	a0,-288(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208a20:	c921                	beqz	a0,ffffffffc0208a70 <dev_init_disk0+0xc6>
ffffffffc0208a22:	4605                	li	a2,1
ffffffffc0208a24:	85a2                	mv	a1,s0
ffffffffc0208a26:	00006517          	auipc	a0,0x6
ffffffffc0208a2a:	19a50513          	addi	a0,a0,410 # ffffffffc020ebc0 <dev_node_ops+0x208>
ffffffffc0208a2e:	c2cff0ef          	jal	ra,ffffffffc0207e5a <vfs_add_dev>
ffffffffc0208a32:	e115                	bnez	a0,ffffffffc0208a56 <dev_init_disk0+0xac>
ffffffffc0208a34:	60e2                	ld	ra,24(sp)
ffffffffc0208a36:	6442                	ld	s0,16(sp)
ffffffffc0208a38:	64a2                	ld	s1,8(sp)
ffffffffc0208a3a:	6105                	addi	sp,sp,32
ffffffffc0208a3c:	8082                	ret
ffffffffc0208a3e:	00006617          	auipc	a2,0x6
ffffffffc0208a42:	12260613          	addi	a2,a2,290 # ffffffffc020eb60 <dev_node_ops+0x1a8>
ffffffffc0208a46:	08700593          	li	a1,135
ffffffffc0208a4a:	00006517          	auipc	a0,0x6
ffffffffc0208a4e:	02e50513          	addi	a0,a0,46 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208a52:	a4df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208a56:	86aa                	mv	a3,a0
ffffffffc0208a58:	00006617          	auipc	a2,0x6
ffffffffc0208a5c:	17060613          	addi	a2,a2,368 # ffffffffc020ebc8 <dev_node_ops+0x210>
ffffffffc0208a60:	08d00593          	li	a1,141
ffffffffc0208a64:	00006517          	auipc	a0,0x6
ffffffffc0208a68:	01450513          	addi	a0,a0,20 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208a6c:	a33f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208a70:	00006617          	auipc	a2,0x6
ffffffffc0208a74:	13060613          	addi	a2,a2,304 # ffffffffc020eba0 <dev_node_ops+0x1e8>
ffffffffc0208a78:	07f00593          	li	a1,127
ffffffffc0208a7c:	00006517          	auipc	a0,0x6
ffffffffc0208a80:	ffc50513          	addi	a0,a0,-4 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208a84:	a1bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208a88:	00006617          	auipc	a2,0x6
ffffffffc0208a8c:	0f860613          	addi	a2,a2,248 # ffffffffc020eb80 <dev_node_ops+0x1c8>
ffffffffc0208a90:	07300593          	li	a1,115
ffffffffc0208a94:	00006517          	auipc	a0,0x6
ffffffffc0208a98:	fe450513          	addi	a0,a0,-28 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208a9c:	a03f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208aa0:	00006697          	auipc	a3,0x6
ffffffffc0208aa4:	bf068693          	addi	a3,a3,-1040 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208aa8:	00003617          	auipc	a2,0x3
ffffffffc0208aac:	f0060613          	addi	a2,a2,-256 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208ab0:	08900593          	li	a1,137
ffffffffc0208ab4:	00006517          	auipc	a0,0x6
ffffffffc0208ab8:	fc450513          	addi	a0,a0,-60 # ffffffffc020ea78 <dev_node_ops+0xc0>
ffffffffc0208abc:	9e3f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ac0 <stdin_open>:
ffffffffc0208ac0:	4501                	li	a0,0
ffffffffc0208ac2:	e191                	bnez	a1,ffffffffc0208ac6 <stdin_open+0x6>
ffffffffc0208ac4:	8082                	ret
ffffffffc0208ac6:	5575                	li	a0,-3
ffffffffc0208ac8:	8082                	ret

ffffffffc0208aca <stdin_close>:
ffffffffc0208aca:	4501                	li	a0,0
ffffffffc0208acc:	8082                	ret

ffffffffc0208ace <stdin_ioctl>:
ffffffffc0208ace:	5575                	li	a0,-3
ffffffffc0208ad0:	8082                	ret

ffffffffc0208ad2 <stdin_io>:
ffffffffc0208ad2:	7135                	addi	sp,sp,-160
ffffffffc0208ad4:	ed06                	sd	ra,152(sp)
ffffffffc0208ad6:	e922                	sd	s0,144(sp)
ffffffffc0208ad8:	e526                	sd	s1,136(sp)
ffffffffc0208ada:	e14a                	sd	s2,128(sp)
ffffffffc0208adc:	fcce                	sd	s3,120(sp)
ffffffffc0208ade:	f8d2                	sd	s4,112(sp)
ffffffffc0208ae0:	f4d6                	sd	s5,104(sp)
ffffffffc0208ae2:	f0da                	sd	s6,96(sp)
ffffffffc0208ae4:	ecde                	sd	s7,88(sp)
ffffffffc0208ae6:	e8e2                	sd	s8,80(sp)
ffffffffc0208ae8:	e4e6                	sd	s9,72(sp)
ffffffffc0208aea:	e0ea                	sd	s10,64(sp)
ffffffffc0208aec:	fc6e                	sd	s11,56(sp)
ffffffffc0208aee:	14061163          	bnez	a2,ffffffffc0208c30 <stdin_io+0x15e>
ffffffffc0208af2:	0005bd83          	ld	s11,0(a1)
ffffffffc0208af6:	0185bd03          	ld	s10,24(a1)
ffffffffc0208afa:	8b2e                	mv	s6,a1
ffffffffc0208afc:	100027f3          	csrr	a5,sstatus
ffffffffc0208b00:	8b89                	andi	a5,a5,2
ffffffffc0208b02:	10079e63          	bnez	a5,ffffffffc0208c1e <stdin_io+0x14c>
ffffffffc0208b06:	4401                	li	s0,0
ffffffffc0208b08:	100d0963          	beqz	s10,ffffffffc0208c1a <stdin_io+0x148>
ffffffffc0208b0c:	0008e997          	auipc	s3,0x8e
ffffffffc0208b10:	df498993          	addi	s3,s3,-524 # ffffffffc0296900 <p_rpos>
ffffffffc0208b14:	0009b783          	ld	a5,0(s3)
ffffffffc0208b18:	800004b7          	lui	s1,0x80000
ffffffffc0208b1c:	6c85                	lui	s9,0x1
ffffffffc0208b1e:	4a81                	li	s5,0
ffffffffc0208b20:	0008ea17          	auipc	s4,0x8e
ffffffffc0208b24:	de8a0a13          	addi	s4,s4,-536 # ffffffffc0296908 <p_wpos>
ffffffffc0208b28:	0491                	addi	s1,s1,4
ffffffffc0208b2a:	0008d917          	auipc	s2,0x8d
ffffffffc0208b2e:	d2e90913          	addi	s2,s2,-722 # ffffffffc0295858 <__wait_queue>
ffffffffc0208b32:	1cfd                	addi	s9,s9,-1
ffffffffc0208b34:	000a3703          	ld	a4,0(s4)
ffffffffc0208b38:	000a8c1b          	sext.w	s8,s5
ffffffffc0208b3c:	8be2                	mv	s7,s8
ffffffffc0208b3e:	02e7d763          	bge	a5,a4,ffffffffc0208b6c <stdin_io+0x9a>
ffffffffc0208b42:	a859                	j	ffffffffc0208bd8 <stdin_io+0x106>
ffffffffc0208b44:	815fe0ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc0208b48:	100027f3          	csrr	a5,sstatus
ffffffffc0208b4c:	8b89                	andi	a5,a5,2
ffffffffc0208b4e:	4401                	li	s0,0
ffffffffc0208b50:	ef8d                	bnez	a5,ffffffffc0208b8a <stdin_io+0xb8>
ffffffffc0208b52:	0028                	addi	a0,sp,8
ffffffffc0208b54:	af3fb0ef          	jal	ra,ffffffffc0204646 <wait_in_queue>
ffffffffc0208b58:	e121                	bnez	a0,ffffffffc0208b98 <stdin_io+0xc6>
ffffffffc0208b5a:	47c2                	lw	a5,16(sp)
ffffffffc0208b5c:	04979563          	bne	a5,s1,ffffffffc0208ba6 <stdin_io+0xd4>
ffffffffc0208b60:	0009b783          	ld	a5,0(s3)
ffffffffc0208b64:	000a3703          	ld	a4,0(s4)
ffffffffc0208b68:	06e7c863          	blt	a5,a4,ffffffffc0208bd8 <stdin_io+0x106>
ffffffffc0208b6c:	8626                	mv	a2,s1
ffffffffc0208b6e:	002c                	addi	a1,sp,8
ffffffffc0208b70:	854a                	mv	a0,s2
ffffffffc0208b72:	bfffb0ef          	jal	ra,ffffffffc0204770 <wait_current_set>
ffffffffc0208b76:	d479                	beqz	s0,ffffffffc0208b44 <stdin_io+0x72>
ffffffffc0208b78:	8f4f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208b7c:	fdcfe0ef          	jal	ra,ffffffffc0207358 <schedule>
ffffffffc0208b80:	100027f3          	csrr	a5,sstatus
ffffffffc0208b84:	8b89                	andi	a5,a5,2
ffffffffc0208b86:	4401                	li	s0,0
ffffffffc0208b88:	d7e9                	beqz	a5,ffffffffc0208b52 <stdin_io+0x80>
ffffffffc0208b8a:	8e8f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208b8e:	0028                	addi	a0,sp,8
ffffffffc0208b90:	4405                	li	s0,1
ffffffffc0208b92:	ab5fb0ef          	jal	ra,ffffffffc0204646 <wait_in_queue>
ffffffffc0208b96:	d171                	beqz	a0,ffffffffc0208b5a <stdin_io+0x88>
ffffffffc0208b98:	002c                	addi	a1,sp,8
ffffffffc0208b9a:	854a                	mv	a0,s2
ffffffffc0208b9c:	a51fb0ef          	jal	ra,ffffffffc02045ec <wait_queue_del>
ffffffffc0208ba0:	47c2                	lw	a5,16(sp)
ffffffffc0208ba2:	fa978fe3          	beq	a5,s1,ffffffffc0208b60 <stdin_io+0x8e>
ffffffffc0208ba6:	e435                	bnez	s0,ffffffffc0208c12 <stdin_io+0x140>
ffffffffc0208ba8:	060b8963          	beqz	s7,ffffffffc0208c1a <stdin_io+0x148>
ffffffffc0208bac:	018b3783          	ld	a5,24(s6)
ffffffffc0208bb0:	41578ab3          	sub	s5,a5,s5
ffffffffc0208bb4:	015b3c23          	sd	s5,24(s6)
ffffffffc0208bb8:	60ea                	ld	ra,152(sp)
ffffffffc0208bba:	644a                	ld	s0,144(sp)
ffffffffc0208bbc:	64aa                	ld	s1,136(sp)
ffffffffc0208bbe:	690a                	ld	s2,128(sp)
ffffffffc0208bc0:	79e6                	ld	s3,120(sp)
ffffffffc0208bc2:	7a46                	ld	s4,112(sp)
ffffffffc0208bc4:	7aa6                	ld	s5,104(sp)
ffffffffc0208bc6:	7b06                	ld	s6,96(sp)
ffffffffc0208bc8:	6c46                	ld	s8,80(sp)
ffffffffc0208bca:	6ca6                	ld	s9,72(sp)
ffffffffc0208bcc:	6d06                	ld	s10,64(sp)
ffffffffc0208bce:	7de2                	ld	s11,56(sp)
ffffffffc0208bd0:	855e                	mv	a0,s7
ffffffffc0208bd2:	6be6                	ld	s7,88(sp)
ffffffffc0208bd4:	610d                	addi	sp,sp,160
ffffffffc0208bd6:	8082                	ret
ffffffffc0208bd8:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208bdc:	03475693          	srli	a3,a4,0x34
ffffffffc0208be0:	00d78733          	add	a4,a5,a3
ffffffffc0208be4:	01977733          	and	a4,a4,s9
ffffffffc0208be8:	8f15                	sub	a4,a4,a3
ffffffffc0208bea:	0008d697          	auipc	a3,0x8d
ffffffffc0208bee:	c7e68693          	addi	a3,a3,-898 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208bf2:	9736                	add	a4,a4,a3
ffffffffc0208bf4:	00074683          	lbu	a3,0(a4)
ffffffffc0208bf8:	0785                	addi	a5,a5,1
ffffffffc0208bfa:	015d8733          	add	a4,s11,s5
ffffffffc0208bfe:	00d70023          	sb	a3,0(a4)
ffffffffc0208c02:	00f9b023          	sd	a5,0(s3)
ffffffffc0208c06:	0a85                	addi	s5,s5,1
ffffffffc0208c08:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208c0c:	f3aae4e3          	bltu	s5,s10,ffffffffc0208b34 <stdin_io+0x62>
ffffffffc0208c10:	dc51                	beqz	s0,ffffffffc0208bac <stdin_io+0xda>
ffffffffc0208c12:	85af80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208c16:	f80b9be3          	bnez	s7,ffffffffc0208bac <stdin_io+0xda>
ffffffffc0208c1a:	4b81                	li	s7,0
ffffffffc0208c1c:	bf71                	j	ffffffffc0208bb8 <stdin_io+0xe6>
ffffffffc0208c1e:	854f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208c22:	4405                	li	s0,1
ffffffffc0208c24:	ee0d14e3          	bnez	s10,ffffffffc0208b0c <stdin_io+0x3a>
ffffffffc0208c28:	844f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208c2c:	4b81                	li	s7,0
ffffffffc0208c2e:	b769                	j	ffffffffc0208bb8 <stdin_io+0xe6>
ffffffffc0208c30:	5bf5                	li	s7,-3
ffffffffc0208c32:	b759                	j	ffffffffc0208bb8 <stdin_io+0xe6>

ffffffffc0208c34 <dev_stdin_write>:
ffffffffc0208c34:	e111                	bnez	a0,ffffffffc0208c38 <dev_stdin_write+0x4>
ffffffffc0208c36:	8082                	ret
ffffffffc0208c38:	1101                	addi	sp,sp,-32
ffffffffc0208c3a:	e822                	sd	s0,16(sp)
ffffffffc0208c3c:	ec06                	sd	ra,24(sp)
ffffffffc0208c3e:	e426                	sd	s1,8(sp)
ffffffffc0208c40:	842a                	mv	s0,a0
ffffffffc0208c42:	100027f3          	csrr	a5,sstatus
ffffffffc0208c46:	8b89                	andi	a5,a5,2
ffffffffc0208c48:	4481                	li	s1,0
ffffffffc0208c4a:	e3c1                	bnez	a5,ffffffffc0208cca <dev_stdin_write+0x96>
ffffffffc0208c4c:	0008e597          	auipc	a1,0x8e
ffffffffc0208c50:	cbc58593          	addi	a1,a1,-836 # ffffffffc0296908 <p_wpos>
ffffffffc0208c54:	6198                	ld	a4,0(a1)
ffffffffc0208c56:	6605                	lui	a2,0x1
ffffffffc0208c58:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0208c5c:	43f75693          	srai	a3,a4,0x3f
ffffffffc0208c60:	92d1                	srli	a3,a3,0x34
ffffffffc0208c62:	00d707b3          	add	a5,a4,a3
ffffffffc0208c66:	8fe9                	and	a5,a5,a0
ffffffffc0208c68:	8f95                	sub	a5,a5,a3
ffffffffc0208c6a:	0008d697          	auipc	a3,0x8d
ffffffffc0208c6e:	bfe68693          	addi	a3,a3,-1026 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208c72:	97b6                	add	a5,a5,a3
ffffffffc0208c74:	00878023          	sb	s0,0(a5)
ffffffffc0208c78:	0008e797          	auipc	a5,0x8e
ffffffffc0208c7c:	c887b783          	ld	a5,-888(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208c80:	40f707b3          	sub	a5,a4,a5
ffffffffc0208c84:	00c7d463          	bge	a5,a2,ffffffffc0208c8c <dev_stdin_write+0x58>
ffffffffc0208c88:	0705                	addi	a4,a4,1
ffffffffc0208c8a:	e198                	sd	a4,0(a1)
ffffffffc0208c8c:	0008d517          	auipc	a0,0x8d
ffffffffc0208c90:	bcc50513          	addi	a0,a0,-1076 # ffffffffc0295858 <__wait_queue>
ffffffffc0208c94:	9a7fb0ef          	jal	ra,ffffffffc020463a <wait_queue_empty>
ffffffffc0208c98:	cd09                	beqz	a0,ffffffffc0208cb2 <dev_stdin_write+0x7e>
ffffffffc0208c9a:	e491                	bnez	s1,ffffffffc0208ca6 <dev_stdin_write+0x72>
ffffffffc0208c9c:	60e2                	ld	ra,24(sp)
ffffffffc0208c9e:	6442                	ld	s0,16(sp)
ffffffffc0208ca0:	64a2                	ld	s1,8(sp)
ffffffffc0208ca2:	6105                	addi	sp,sp,32
ffffffffc0208ca4:	8082                	ret
ffffffffc0208ca6:	6442                	ld	s0,16(sp)
ffffffffc0208ca8:	60e2                	ld	ra,24(sp)
ffffffffc0208caa:	64a2                	ld	s1,8(sp)
ffffffffc0208cac:	6105                	addi	sp,sp,32
ffffffffc0208cae:	fbff706f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0208cb2:	800005b7          	lui	a1,0x80000
ffffffffc0208cb6:	4605                	li	a2,1
ffffffffc0208cb8:	0591                	addi	a1,a1,4
ffffffffc0208cba:	0008d517          	auipc	a0,0x8d
ffffffffc0208cbe:	b9e50513          	addi	a0,a0,-1122 # ffffffffc0295858 <__wait_queue>
ffffffffc0208cc2:	9e1fb0ef          	jal	ra,ffffffffc02046a2 <wakeup_queue>
ffffffffc0208cc6:	d8f9                	beqz	s1,ffffffffc0208c9c <dev_stdin_write+0x68>
ffffffffc0208cc8:	bff9                	j	ffffffffc0208ca6 <dev_stdin_write+0x72>
ffffffffc0208cca:	fa9f70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208cce:	4485                	li	s1,1
ffffffffc0208cd0:	bfb5                	j	ffffffffc0208c4c <dev_stdin_write+0x18>

ffffffffc0208cd2 <dev_init_stdin>:
ffffffffc0208cd2:	1141                	addi	sp,sp,-16
ffffffffc0208cd4:	e406                	sd	ra,8(sp)
ffffffffc0208cd6:	e022                	sd	s0,0(sp)
ffffffffc0208cd8:	ac7ff0ef          	jal	ra,ffffffffc020879e <dev_create_inode>
ffffffffc0208cdc:	c93d                	beqz	a0,ffffffffc0208d52 <dev_init_stdin+0x80>
ffffffffc0208cde:	4d38                	lw	a4,88(a0)
ffffffffc0208ce0:	6785                	lui	a5,0x1
ffffffffc0208ce2:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208ce6:	842a                	mv	s0,a0
ffffffffc0208ce8:	08f71e63          	bne	a4,a5,ffffffffc0208d84 <dev_init_stdin+0xb2>
ffffffffc0208cec:	4785                	li	a5,1
ffffffffc0208cee:	e41c                	sd	a5,8(s0)
ffffffffc0208cf0:	00000797          	auipc	a5,0x0
ffffffffc0208cf4:	dd078793          	addi	a5,a5,-560 # ffffffffc0208ac0 <stdin_open>
ffffffffc0208cf8:	e81c                	sd	a5,16(s0)
ffffffffc0208cfa:	00000797          	auipc	a5,0x0
ffffffffc0208cfe:	dd078793          	addi	a5,a5,-560 # ffffffffc0208aca <stdin_close>
ffffffffc0208d02:	ec1c                	sd	a5,24(s0)
ffffffffc0208d04:	00000797          	auipc	a5,0x0
ffffffffc0208d08:	dce78793          	addi	a5,a5,-562 # ffffffffc0208ad2 <stdin_io>
ffffffffc0208d0c:	f01c                	sd	a5,32(s0)
ffffffffc0208d0e:	00000797          	auipc	a5,0x0
ffffffffc0208d12:	dc078793          	addi	a5,a5,-576 # ffffffffc0208ace <stdin_ioctl>
ffffffffc0208d16:	f41c                	sd	a5,40(s0)
ffffffffc0208d18:	0008d517          	auipc	a0,0x8d
ffffffffc0208d1c:	b4050513          	addi	a0,a0,-1216 # ffffffffc0295858 <__wait_queue>
ffffffffc0208d20:	00043023          	sd	zero,0(s0)
ffffffffc0208d24:	0008e797          	auipc	a5,0x8e
ffffffffc0208d28:	be07b223          	sd	zero,-1052(a5) # ffffffffc0296908 <p_wpos>
ffffffffc0208d2c:	0008e797          	auipc	a5,0x8e
ffffffffc0208d30:	bc07ba23          	sd	zero,-1068(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208d34:	8b3fb0ef          	jal	ra,ffffffffc02045e6 <wait_queue_init>
ffffffffc0208d38:	4601                	li	a2,0
ffffffffc0208d3a:	85a2                	mv	a1,s0
ffffffffc0208d3c:	00006517          	auipc	a0,0x6
ffffffffc0208d40:	eec50513          	addi	a0,a0,-276 # ffffffffc020ec28 <dev_node_ops+0x270>
ffffffffc0208d44:	916ff0ef          	jal	ra,ffffffffc0207e5a <vfs_add_dev>
ffffffffc0208d48:	e10d                	bnez	a0,ffffffffc0208d6a <dev_init_stdin+0x98>
ffffffffc0208d4a:	60a2                	ld	ra,8(sp)
ffffffffc0208d4c:	6402                	ld	s0,0(sp)
ffffffffc0208d4e:	0141                	addi	sp,sp,16
ffffffffc0208d50:	8082                	ret
ffffffffc0208d52:	00006617          	auipc	a2,0x6
ffffffffc0208d56:	e9660613          	addi	a2,a2,-362 # ffffffffc020ebe8 <dev_node_ops+0x230>
ffffffffc0208d5a:	07500593          	li	a1,117
ffffffffc0208d5e:	00006517          	auipc	a0,0x6
ffffffffc0208d62:	eaa50513          	addi	a0,a0,-342 # ffffffffc020ec08 <dev_node_ops+0x250>
ffffffffc0208d66:	f38f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d6a:	86aa                	mv	a3,a0
ffffffffc0208d6c:	00006617          	auipc	a2,0x6
ffffffffc0208d70:	ec460613          	addi	a2,a2,-316 # ffffffffc020ec30 <dev_node_ops+0x278>
ffffffffc0208d74:	07b00593          	li	a1,123
ffffffffc0208d78:	00006517          	auipc	a0,0x6
ffffffffc0208d7c:	e9050513          	addi	a0,a0,-368 # ffffffffc020ec08 <dev_node_ops+0x250>
ffffffffc0208d80:	f1ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d84:	00006697          	auipc	a3,0x6
ffffffffc0208d88:	90c68693          	addi	a3,a3,-1780 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208d8c:	00003617          	auipc	a2,0x3
ffffffffc0208d90:	c1c60613          	addi	a2,a2,-996 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208d94:	07700593          	li	a1,119
ffffffffc0208d98:	00006517          	auipc	a0,0x6
ffffffffc0208d9c:	e7050513          	addi	a0,a0,-400 # ffffffffc020ec08 <dev_node_ops+0x250>
ffffffffc0208da0:	efef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208da4 <stdout_open>:
ffffffffc0208da4:	4785                	li	a5,1
ffffffffc0208da6:	4501                	li	a0,0
ffffffffc0208da8:	00f59363          	bne	a1,a5,ffffffffc0208dae <stdout_open+0xa>
ffffffffc0208dac:	8082                	ret
ffffffffc0208dae:	5575                	li	a0,-3
ffffffffc0208db0:	8082                	ret

ffffffffc0208db2 <stdout_close>:
ffffffffc0208db2:	4501                	li	a0,0
ffffffffc0208db4:	8082                	ret

ffffffffc0208db6 <stdout_ioctl>:
ffffffffc0208db6:	5575                	li	a0,-3
ffffffffc0208db8:	8082                	ret

ffffffffc0208dba <stdout_io>:
ffffffffc0208dba:	ca05                	beqz	a2,ffffffffc0208dea <stdout_io+0x30>
ffffffffc0208dbc:	6d9c                	ld	a5,24(a1)
ffffffffc0208dbe:	1101                	addi	sp,sp,-32
ffffffffc0208dc0:	e822                	sd	s0,16(sp)
ffffffffc0208dc2:	e426                	sd	s1,8(sp)
ffffffffc0208dc4:	ec06                	sd	ra,24(sp)
ffffffffc0208dc6:	6180                	ld	s0,0(a1)
ffffffffc0208dc8:	84ae                	mv	s1,a1
ffffffffc0208dca:	cb91                	beqz	a5,ffffffffc0208dde <stdout_io+0x24>
ffffffffc0208dcc:	00044503          	lbu	a0,0(s0)
ffffffffc0208dd0:	0405                	addi	s0,s0,1
ffffffffc0208dd2:	c10f70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0208dd6:	6c9c                	ld	a5,24(s1)
ffffffffc0208dd8:	17fd                	addi	a5,a5,-1
ffffffffc0208dda:	ec9c                	sd	a5,24(s1)
ffffffffc0208ddc:	fbe5                	bnez	a5,ffffffffc0208dcc <stdout_io+0x12>
ffffffffc0208dde:	60e2                	ld	ra,24(sp)
ffffffffc0208de0:	6442                	ld	s0,16(sp)
ffffffffc0208de2:	64a2                	ld	s1,8(sp)
ffffffffc0208de4:	4501                	li	a0,0
ffffffffc0208de6:	6105                	addi	sp,sp,32
ffffffffc0208de8:	8082                	ret
ffffffffc0208dea:	5575                	li	a0,-3
ffffffffc0208dec:	8082                	ret

ffffffffc0208dee <dev_init_stdout>:
ffffffffc0208dee:	1141                	addi	sp,sp,-16
ffffffffc0208df0:	e406                	sd	ra,8(sp)
ffffffffc0208df2:	9adff0ef          	jal	ra,ffffffffc020879e <dev_create_inode>
ffffffffc0208df6:	c939                	beqz	a0,ffffffffc0208e4c <dev_init_stdout+0x5e>
ffffffffc0208df8:	4d38                	lw	a4,88(a0)
ffffffffc0208dfa:	6785                	lui	a5,0x1
ffffffffc0208dfc:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208e00:	85aa                	mv	a1,a0
ffffffffc0208e02:	06f71e63          	bne	a4,a5,ffffffffc0208e7e <dev_init_stdout+0x90>
ffffffffc0208e06:	4785                	li	a5,1
ffffffffc0208e08:	e51c                	sd	a5,8(a0)
ffffffffc0208e0a:	00000797          	auipc	a5,0x0
ffffffffc0208e0e:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208da4 <stdout_open>
ffffffffc0208e12:	e91c                	sd	a5,16(a0)
ffffffffc0208e14:	00000797          	auipc	a5,0x0
ffffffffc0208e18:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208db2 <stdout_close>
ffffffffc0208e1c:	ed1c                	sd	a5,24(a0)
ffffffffc0208e1e:	00000797          	auipc	a5,0x0
ffffffffc0208e22:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208dba <stdout_io>
ffffffffc0208e26:	f11c                	sd	a5,32(a0)
ffffffffc0208e28:	00000797          	auipc	a5,0x0
ffffffffc0208e2c:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208db6 <stdout_ioctl>
ffffffffc0208e30:	00053023          	sd	zero,0(a0)
ffffffffc0208e34:	f51c                	sd	a5,40(a0)
ffffffffc0208e36:	4601                	li	a2,0
ffffffffc0208e38:	00006517          	auipc	a0,0x6
ffffffffc0208e3c:	e5850513          	addi	a0,a0,-424 # ffffffffc020ec90 <dev_node_ops+0x2d8>
ffffffffc0208e40:	81aff0ef          	jal	ra,ffffffffc0207e5a <vfs_add_dev>
ffffffffc0208e44:	e105                	bnez	a0,ffffffffc0208e64 <dev_init_stdout+0x76>
ffffffffc0208e46:	60a2                	ld	ra,8(sp)
ffffffffc0208e48:	0141                	addi	sp,sp,16
ffffffffc0208e4a:	8082                	ret
ffffffffc0208e4c:	00006617          	auipc	a2,0x6
ffffffffc0208e50:	e0460613          	addi	a2,a2,-508 # ffffffffc020ec50 <dev_node_ops+0x298>
ffffffffc0208e54:	03700593          	li	a1,55
ffffffffc0208e58:	00006517          	auipc	a0,0x6
ffffffffc0208e5c:	e1850513          	addi	a0,a0,-488 # ffffffffc020ec70 <dev_node_ops+0x2b8>
ffffffffc0208e60:	e3ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e64:	86aa                	mv	a3,a0
ffffffffc0208e66:	00006617          	auipc	a2,0x6
ffffffffc0208e6a:	e3260613          	addi	a2,a2,-462 # ffffffffc020ec98 <dev_node_ops+0x2e0>
ffffffffc0208e6e:	03d00593          	li	a1,61
ffffffffc0208e72:	00006517          	auipc	a0,0x6
ffffffffc0208e76:	dfe50513          	addi	a0,a0,-514 # ffffffffc020ec70 <dev_node_ops+0x2b8>
ffffffffc0208e7a:	e24f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e7e:	00006697          	auipc	a3,0x6
ffffffffc0208e82:	81268693          	addi	a3,a3,-2030 # ffffffffc020e690 <syscalls+0xb10>
ffffffffc0208e86:	00003617          	auipc	a2,0x3
ffffffffc0208e8a:	b2260613          	addi	a2,a2,-1246 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208e8e:	03900593          	li	a1,57
ffffffffc0208e92:	00006517          	auipc	a0,0x6
ffffffffc0208e96:	dde50513          	addi	a0,a0,-546 # ffffffffc020ec70 <dev_node_ops+0x2b8>
ffffffffc0208e9a:	e04f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e9e <bitmap_translate.part.0>:
ffffffffc0208e9e:	1141                	addi	sp,sp,-16
ffffffffc0208ea0:	00006697          	auipc	a3,0x6
ffffffffc0208ea4:	e1868693          	addi	a3,a3,-488 # ffffffffc020ecb8 <dev_node_ops+0x300>
ffffffffc0208ea8:	00003617          	auipc	a2,0x3
ffffffffc0208eac:	b0060613          	addi	a2,a2,-1280 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208eb0:	04c00593          	li	a1,76
ffffffffc0208eb4:	00006517          	auipc	a0,0x6
ffffffffc0208eb8:	e1c50513          	addi	a0,a0,-484 # ffffffffc020ecd0 <dev_node_ops+0x318>
ffffffffc0208ebc:	e406                	sd	ra,8(sp)
ffffffffc0208ebe:	de0f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208ec2 <bitmap_create>:
ffffffffc0208ec2:	7139                	addi	sp,sp,-64
ffffffffc0208ec4:	fc06                	sd	ra,56(sp)
ffffffffc0208ec6:	f822                	sd	s0,48(sp)
ffffffffc0208ec8:	f426                	sd	s1,40(sp)
ffffffffc0208eca:	f04a                	sd	s2,32(sp)
ffffffffc0208ecc:	ec4e                	sd	s3,24(sp)
ffffffffc0208ece:	e852                	sd	s4,16(sp)
ffffffffc0208ed0:	e456                	sd	s5,8(sp)
ffffffffc0208ed2:	c14d                	beqz	a0,ffffffffc0208f74 <bitmap_create+0xb2>
ffffffffc0208ed4:	842a                	mv	s0,a0
ffffffffc0208ed6:	4541                	li	a0,16
ffffffffc0208ed8:	906f90ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0208edc:	84aa                	mv	s1,a0
ffffffffc0208ede:	cd25                	beqz	a0,ffffffffc0208f56 <bitmap_create+0x94>
ffffffffc0208ee0:	02041a13          	slli	s4,s0,0x20
ffffffffc0208ee4:	020a5a13          	srli	s4,s4,0x20
ffffffffc0208ee8:	01fa0793          	addi	a5,s4,31
ffffffffc0208eec:	0057d993          	srli	s3,a5,0x5
ffffffffc0208ef0:	00299a93          	slli	s5,s3,0x2
ffffffffc0208ef4:	8556                	mv	a0,s5
ffffffffc0208ef6:	894e                	mv	s2,s3
ffffffffc0208ef8:	8e6f90ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc0208efc:	c53d                	beqz	a0,ffffffffc0208f6a <bitmap_create+0xa8>
ffffffffc0208efe:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208f02:	c080                	sw	s0,0(s1)
ffffffffc0208f04:	8656                	mv	a2,s5
ffffffffc0208f06:	0ff00593          	li	a1,255
ffffffffc0208f0a:	5ba020ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc0208f0e:	e488                	sd	a0,8(s1)
ffffffffc0208f10:	0996                	slli	s3,s3,0x5
ffffffffc0208f12:	053a0263          	beq	s4,s3,ffffffffc0208f56 <bitmap_create+0x94>
ffffffffc0208f16:	fff9079b          	addiw	a5,s2,-1
ffffffffc0208f1a:	0057969b          	slliw	a3,a5,0x5
ffffffffc0208f1e:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208f22:	40d4073b          	subw	a4,s0,a3
ffffffffc0208f26:	0054541b          	srliw	s0,s0,0x5
ffffffffc0208f2a:	08f61463          	bne	a2,a5,ffffffffc0208fb2 <bitmap_create+0xf0>
ffffffffc0208f2e:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208f32:	47f9                	li	a5,30
ffffffffc0208f34:	04d7ef63          	bltu	a5,a3,ffffffffc0208f92 <bitmap_create+0xd0>
ffffffffc0208f38:	1402                	slli	s0,s0,0x20
ffffffffc0208f3a:	8079                	srli	s0,s0,0x1e
ffffffffc0208f3c:	9522                	add	a0,a0,s0
ffffffffc0208f3e:	411c                	lw	a5,0(a0)
ffffffffc0208f40:	4585                	li	a1,1
ffffffffc0208f42:	02000613          	li	a2,32
ffffffffc0208f46:	00e596bb          	sllw	a3,a1,a4
ffffffffc0208f4a:	8fb5                	xor	a5,a5,a3
ffffffffc0208f4c:	2705                	addiw	a4,a4,1
ffffffffc0208f4e:	2781                	sext.w	a5,a5
ffffffffc0208f50:	fec71be3          	bne	a4,a2,ffffffffc0208f46 <bitmap_create+0x84>
ffffffffc0208f54:	c11c                	sw	a5,0(a0)
ffffffffc0208f56:	70e2                	ld	ra,56(sp)
ffffffffc0208f58:	7442                	ld	s0,48(sp)
ffffffffc0208f5a:	7902                	ld	s2,32(sp)
ffffffffc0208f5c:	69e2                	ld	s3,24(sp)
ffffffffc0208f5e:	6a42                	ld	s4,16(sp)
ffffffffc0208f60:	6aa2                	ld	s5,8(sp)
ffffffffc0208f62:	8526                	mv	a0,s1
ffffffffc0208f64:	74a2                	ld	s1,40(sp)
ffffffffc0208f66:	6121                	addi	sp,sp,64
ffffffffc0208f68:	8082                	ret
ffffffffc0208f6a:	8526                	mv	a0,s1
ffffffffc0208f6c:	922f90ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0208f70:	4481                	li	s1,0
ffffffffc0208f72:	b7d5                	j	ffffffffc0208f56 <bitmap_create+0x94>
ffffffffc0208f74:	00006697          	auipc	a3,0x6
ffffffffc0208f78:	d7468693          	addi	a3,a3,-652 # ffffffffc020ece8 <dev_node_ops+0x330>
ffffffffc0208f7c:	00003617          	auipc	a2,0x3
ffffffffc0208f80:	a2c60613          	addi	a2,a2,-1492 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208f84:	45d5                	li	a1,21
ffffffffc0208f86:	00006517          	auipc	a0,0x6
ffffffffc0208f8a:	d4a50513          	addi	a0,a0,-694 # ffffffffc020ecd0 <dev_node_ops+0x318>
ffffffffc0208f8e:	d10f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f92:	00006697          	auipc	a3,0x6
ffffffffc0208f96:	d9668693          	addi	a3,a3,-618 # ffffffffc020ed28 <dev_node_ops+0x370>
ffffffffc0208f9a:	00003617          	auipc	a2,0x3
ffffffffc0208f9e:	a0e60613          	addi	a2,a2,-1522 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208fa2:	02b00593          	li	a1,43
ffffffffc0208fa6:	00006517          	auipc	a0,0x6
ffffffffc0208faa:	d2a50513          	addi	a0,a0,-726 # ffffffffc020ecd0 <dev_node_ops+0x318>
ffffffffc0208fae:	cf0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208fb2:	00006697          	auipc	a3,0x6
ffffffffc0208fb6:	d5e68693          	addi	a3,a3,-674 # ffffffffc020ed10 <dev_node_ops+0x358>
ffffffffc0208fba:	00003617          	auipc	a2,0x3
ffffffffc0208fbe:	9ee60613          	addi	a2,a2,-1554 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0208fc2:	02a00593          	li	a1,42
ffffffffc0208fc6:	00006517          	auipc	a0,0x6
ffffffffc0208fca:	d0a50513          	addi	a0,a0,-758 # ffffffffc020ecd0 <dev_node_ops+0x318>
ffffffffc0208fce:	cd0f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208fd2 <bitmap_alloc>:
ffffffffc0208fd2:	4150                	lw	a2,4(a0)
ffffffffc0208fd4:	651c                	ld	a5,8(a0)
ffffffffc0208fd6:	c231                	beqz	a2,ffffffffc020901a <bitmap_alloc+0x48>
ffffffffc0208fd8:	4701                	li	a4,0
ffffffffc0208fda:	a029                	j	ffffffffc0208fe4 <bitmap_alloc+0x12>
ffffffffc0208fdc:	2705                	addiw	a4,a4,1
ffffffffc0208fde:	0791                	addi	a5,a5,4
ffffffffc0208fe0:	02e60d63          	beq	a2,a4,ffffffffc020901a <bitmap_alloc+0x48>
ffffffffc0208fe4:	4394                	lw	a3,0(a5)
ffffffffc0208fe6:	dafd                	beqz	a3,ffffffffc0208fdc <bitmap_alloc+0xa>
ffffffffc0208fe8:	4501                	li	a0,0
ffffffffc0208fea:	4885                	li	a7,1
ffffffffc0208fec:	8e36                	mv	t3,a3
ffffffffc0208fee:	02000313          	li	t1,32
ffffffffc0208ff2:	a021                	j	ffffffffc0208ffa <bitmap_alloc+0x28>
ffffffffc0208ff4:	2505                	addiw	a0,a0,1
ffffffffc0208ff6:	02650463          	beq	a0,t1,ffffffffc020901e <bitmap_alloc+0x4c>
ffffffffc0208ffa:	00a8983b          	sllw	a6,a7,a0
ffffffffc0208ffe:	0106f633          	and	a2,a3,a6
ffffffffc0209002:	2601                	sext.w	a2,a2
ffffffffc0209004:	da65                	beqz	a2,ffffffffc0208ff4 <bitmap_alloc+0x22>
ffffffffc0209006:	010e4833          	xor	a6,t3,a6
ffffffffc020900a:	0057171b          	slliw	a4,a4,0x5
ffffffffc020900e:	9f29                	addw	a4,a4,a0
ffffffffc0209010:	0107a023          	sw	a6,0(a5)
ffffffffc0209014:	c198                	sw	a4,0(a1)
ffffffffc0209016:	4501                	li	a0,0
ffffffffc0209018:	8082                	ret
ffffffffc020901a:	5571                	li	a0,-4
ffffffffc020901c:	8082                	ret
ffffffffc020901e:	1141                	addi	sp,sp,-16
ffffffffc0209020:	00004697          	auipc	a3,0x4
ffffffffc0209024:	a2868693          	addi	a3,a3,-1496 # ffffffffc020ca48 <default_pmm_manager+0x598>
ffffffffc0209028:	00003617          	auipc	a2,0x3
ffffffffc020902c:	98060613          	addi	a2,a2,-1664 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209030:	04300593          	li	a1,67
ffffffffc0209034:	00006517          	auipc	a0,0x6
ffffffffc0209038:	c9c50513          	addi	a0,a0,-868 # ffffffffc020ecd0 <dev_node_ops+0x318>
ffffffffc020903c:	e406                	sd	ra,8(sp)
ffffffffc020903e:	c60f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209042 <bitmap_test>:
ffffffffc0209042:	411c                	lw	a5,0(a0)
ffffffffc0209044:	00f5ff63          	bgeu	a1,a5,ffffffffc0209062 <bitmap_test+0x20>
ffffffffc0209048:	651c                	ld	a5,8(a0)
ffffffffc020904a:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020904e:	070a                	slli	a4,a4,0x2
ffffffffc0209050:	97ba                	add	a5,a5,a4
ffffffffc0209052:	4388                	lw	a0,0(a5)
ffffffffc0209054:	4785                	li	a5,1
ffffffffc0209056:	00b795bb          	sllw	a1,a5,a1
ffffffffc020905a:	8d6d                	and	a0,a0,a1
ffffffffc020905c:	1502                	slli	a0,a0,0x20
ffffffffc020905e:	9101                	srli	a0,a0,0x20
ffffffffc0209060:	8082                	ret
ffffffffc0209062:	1141                	addi	sp,sp,-16
ffffffffc0209064:	e406                	sd	ra,8(sp)
ffffffffc0209066:	e39ff0ef          	jal	ra,ffffffffc0208e9e <bitmap_translate.part.0>

ffffffffc020906a <bitmap_free>:
ffffffffc020906a:	411c                	lw	a5,0(a0)
ffffffffc020906c:	1141                	addi	sp,sp,-16
ffffffffc020906e:	e406                	sd	ra,8(sp)
ffffffffc0209070:	02f5f463          	bgeu	a1,a5,ffffffffc0209098 <bitmap_free+0x2e>
ffffffffc0209074:	651c                	ld	a5,8(a0)
ffffffffc0209076:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020907a:	070a                	slli	a4,a4,0x2
ffffffffc020907c:	97ba                	add	a5,a5,a4
ffffffffc020907e:	4398                	lw	a4,0(a5)
ffffffffc0209080:	4685                	li	a3,1
ffffffffc0209082:	00b695bb          	sllw	a1,a3,a1
ffffffffc0209086:	00b776b3          	and	a3,a4,a1
ffffffffc020908a:	2681                	sext.w	a3,a3
ffffffffc020908c:	ea81                	bnez	a3,ffffffffc020909c <bitmap_free+0x32>
ffffffffc020908e:	60a2                	ld	ra,8(sp)
ffffffffc0209090:	8f4d                	or	a4,a4,a1
ffffffffc0209092:	c398                	sw	a4,0(a5)
ffffffffc0209094:	0141                	addi	sp,sp,16
ffffffffc0209096:	8082                	ret
ffffffffc0209098:	e07ff0ef          	jal	ra,ffffffffc0208e9e <bitmap_translate.part.0>
ffffffffc020909c:	00006697          	auipc	a3,0x6
ffffffffc02090a0:	cb468693          	addi	a3,a3,-844 # ffffffffc020ed50 <dev_node_ops+0x398>
ffffffffc02090a4:	00003617          	auipc	a2,0x3
ffffffffc02090a8:	90460613          	addi	a2,a2,-1788 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02090ac:	05f00593          	li	a1,95
ffffffffc02090b0:	00006517          	auipc	a0,0x6
ffffffffc02090b4:	c2050513          	addi	a0,a0,-992 # ffffffffc020ecd0 <dev_node_ops+0x318>
ffffffffc02090b8:	be6f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02090bc <bitmap_destroy>:
ffffffffc02090bc:	1141                	addi	sp,sp,-16
ffffffffc02090be:	e022                	sd	s0,0(sp)
ffffffffc02090c0:	842a                	mv	s0,a0
ffffffffc02090c2:	6508                	ld	a0,8(a0)
ffffffffc02090c4:	e406                	sd	ra,8(sp)
ffffffffc02090c6:	fc9f80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc02090ca:	8522                	mv	a0,s0
ffffffffc02090cc:	6402                	ld	s0,0(sp)
ffffffffc02090ce:	60a2                	ld	ra,8(sp)
ffffffffc02090d0:	0141                	addi	sp,sp,16
ffffffffc02090d2:	fbdf806f          	j	ffffffffc020208e <kfree>

ffffffffc02090d6 <bitmap_getdata>:
ffffffffc02090d6:	c589                	beqz	a1,ffffffffc02090e0 <bitmap_getdata+0xa>
ffffffffc02090d8:	00456783          	lwu	a5,4(a0)
ffffffffc02090dc:	078a                	slli	a5,a5,0x2
ffffffffc02090de:	e19c                	sd	a5,0(a1)
ffffffffc02090e0:	6508                	ld	a0,8(a0)
ffffffffc02090e2:	8082                	ret

ffffffffc02090e4 <sfs_init>:
ffffffffc02090e4:	1141                	addi	sp,sp,-16
ffffffffc02090e6:	00006517          	auipc	a0,0x6
ffffffffc02090ea:	ada50513          	addi	a0,a0,-1318 # ffffffffc020ebc0 <dev_node_ops+0x208>
ffffffffc02090ee:	e406                	sd	ra,8(sp)
ffffffffc02090f0:	554000ef          	jal	ra,ffffffffc0209644 <sfs_mount>
ffffffffc02090f4:	e501                	bnez	a0,ffffffffc02090fc <sfs_init+0x18>
ffffffffc02090f6:	60a2                	ld	ra,8(sp)
ffffffffc02090f8:	0141                	addi	sp,sp,16
ffffffffc02090fa:	8082                	ret
ffffffffc02090fc:	86aa                	mv	a3,a0
ffffffffc02090fe:	00006617          	auipc	a2,0x6
ffffffffc0209102:	c6260613          	addi	a2,a2,-926 # ffffffffc020ed60 <dev_node_ops+0x3a8>
ffffffffc0209106:	45c1                	li	a1,16
ffffffffc0209108:	00006517          	auipc	a0,0x6
ffffffffc020910c:	c7850513          	addi	a0,a0,-904 # ffffffffc020ed80 <dev_node_ops+0x3c8>
ffffffffc0209110:	b8ef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209114 <sfs_unmount>:
ffffffffc0209114:	1141                	addi	sp,sp,-16
ffffffffc0209116:	e406                	sd	ra,8(sp)
ffffffffc0209118:	e022                	sd	s0,0(sp)
ffffffffc020911a:	cd1d                	beqz	a0,ffffffffc0209158 <sfs_unmount+0x44>
ffffffffc020911c:	0b052783          	lw	a5,176(a0)
ffffffffc0209120:	842a                	mv	s0,a0
ffffffffc0209122:	eb9d                	bnez	a5,ffffffffc0209158 <sfs_unmount+0x44>
ffffffffc0209124:	7158                	ld	a4,160(a0)
ffffffffc0209126:	09850793          	addi	a5,a0,152
ffffffffc020912a:	02f71563          	bne	a4,a5,ffffffffc0209154 <sfs_unmount+0x40>
ffffffffc020912e:	613c                	ld	a5,64(a0)
ffffffffc0209130:	e7a1                	bnez	a5,ffffffffc0209178 <sfs_unmount+0x64>
ffffffffc0209132:	7d08                	ld	a0,56(a0)
ffffffffc0209134:	f89ff0ef          	jal	ra,ffffffffc02090bc <bitmap_destroy>
ffffffffc0209138:	6428                	ld	a0,72(s0)
ffffffffc020913a:	f55f80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020913e:	7448                	ld	a0,168(s0)
ffffffffc0209140:	f4ff80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0209144:	8522                	mv	a0,s0
ffffffffc0209146:	f49f80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020914a:	4501                	li	a0,0
ffffffffc020914c:	60a2                	ld	ra,8(sp)
ffffffffc020914e:	6402                	ld	s0,0(sp)
ffffffffc0209150:	0141                	addi	sp,sp,16
ffffffffc0209152:	8082                	ret
ffffffffc0209154:	5545                	li	a0,-15
ffffffffc0209156:	bfdd                	j	ffffffffc020914c <sfs_unmount+0x38>
ffffffffc0209158:	00006697          	auipc	a3,0x6
ffffffffc020915c:	c4068693          	addi	a3,a3,-960 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc0209160:	00003617          	auipc	a2,0x3
ffffffffc0209164:	84860613          	addi	a2,a2,-1976 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209168:	04100593          	li	a1,65
ffffffffc020916c:	00006517          	auipc	a0,0x6
ffffffffc0209170:	c5c50513          	addi	a0,a0,-932 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209174:	b2af70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209178:	00006697          	auipc	a3,0x6
ffffffffc020917c:	c6868693          	addi	a3,a3,-920 # ffffffffc020ede0 <dev_node_ops+0x428>
ffffffffc0209180:	00003617          	auipc	a2,0x3
ffffffffc0209184:	82860613          	addi	a2,a2,-2008 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209188:	04500593          	li	a1,69
ffffffffc020918c:	00006517          	auipc	a0,0x6
ffffffffc0209190:	c3c50513          	addi	a0,a0,-964 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209194:	b0af70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209198 <sfs_cleanup>:
ffffffffc0209198:	1101                	addi	sp,sp,-32
ffffffffc020919a:	ec06                	sd	ra,24(sp)
ffffffffc020919c:	e822                	sd	s0,16(sp)
ffffffffc020919e:	e426                	sd	s1,8(sp)
ffffffffc02091a0:	e04a                	sd	s2,0(sp)
ffffffffc02091a2:	c525                	beqz	a0,ffffffffc020920a <sfs_cleanup+0x72>
ffffffffc02091a4:	0b052783          	lw	a5,176(a0)
ffffffffc02091a8:	84aa                	mv	s1,a0
ffffffffc02091aa:	e3a5                	bnez	a5,ffffffffc020920a <sfs_cleanup+0x72>
ffffffffc02091ac:	4158                	lw	a4,4(a0)
ffffffffc02091ae:	4514                	lw	a3,8(a0)
ffffffffc02091b0:	00c50913          	addi	s2,a0,12
ffffffffc02091b4:	85ca                	mv	a1,s2
ffffffffc02091b6:	40d7063b          	subw	a2,a4,a3
ffffffffc02091ba:	00006517          	auipc	a0,0x6
ffffffffc02091be:	c3e50513          	addi	a0,a0,-962 # ffffffffc020edf8 <dev_node_ops+0x440>
ffffffffc02091c2:	fe5f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02091c6:	02000413          	li	s0,32
ffffffffc02091ca:	a019                	j	ffffffffc02091d0 <sfs_cleanup+0x38>
ffffffffc02091cc:	347d                	addiw	s0,s0,-1
ffffffffc02091ce:	c819                	beqz	s0,ffffffffc02091e4 <sfs_cleanup+0x4c>
ffffffffc02091d0:	7cdc                	ld	a5,184(s1)
ffffffffc02091d2:	8526                	mv	a0,s1
ffffffffc02091d4:	9782                	jalr	a5
ffffffffc02091d6:	f97d                	bnez	a0,ffffffffc02091cc <sfs_cleanup+0x34>
ffffffffc02091d8:	60e2                	ld	ra,24(sp)
ffffffffc02091da:	6442                	ld	s0,16(sp)
ffffffffc02091dc:	64a2                	ld	s1,8(sp)
ffffffffc02091de:	6902                	ld	s2,0(sp)
ffffffffc02091e0:	6105                	addi	sp,sp,32
ffffffffc02091e2:	8082                	ret
ffffffffc02091e4:	6442                	ld	s0,16(sp)
ffffffffc02091e6:	60e2                	ld	ra,24(sp)
ffffffffc02091e8:	64a2                	ld	s1,8(sp)
ffffffffc02091ea:	86ca                	mv	a3,s2
ffffffffc02091ec:	6902                	ld	s2,0(sp)
ffffffffc02091ee:	872a                	mv	a4,a0
ffffffffc02091f0:	00006617          	auipc	a2,0x6
ffffffffc02091f4:	c2860613          	addi	a2,a2,-984 # ffffffffc020ee18 <dev_node_ops+0x460>
ffffffffc02091f8:	05f00593          	li	a1,95
ffffffffc02091fc:	00006517          	auipc	a0,0x6
ffffffffc0209200:	bcc50513          	addi	a0,a0,-1076 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209204:	6105                	addi	sp,sp,32
ffffffffc0209206:	b00f706f          	j	ffffffffc0200506 <__warn>
ffffffffc020920a:	00006697          	auipc	a3,0x6
ffffffffc020920e:	b8e68693          	addi	a3,a3,-1138 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc0209212:	00002617          	auipc	a2,0x2
ffffffffc0209216:	79660613          	addi	a2,a2,1942 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020921a:	05400593          	li	a1,84
ffffffffc020921e:	00006517          	auipc	a0,0x6
ffffffffc0209222:	baa50513          	addi	a0,a0,-1110 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209226:	a78f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020922a <sfs_sync>:
ffffffffc020922a:	7179                	addi	sp,sp,-48
ffffffffc020922c:	f406                	sd	ra,40(sp)
ffffffffc020922e:	f022                	sd	s0,32(sp)
ffffffffc0209230:	ec26                	sd	s1,24(sp)
ffffffffc0209232:	e84a                	sd	s2,16(sp)
ffffffffc0209234:	e44e                	sd	s3,8(sp)
ffffffffc0209236:	e052                	sd	s4,0(sp)
ffffffffc0209238:	cd4d                	beqz	a0,ffffffffc02092f2 <sfs_sync+0xc8>
ffffffffc020923a:	0b052783          	lw	a5,176(a0)
ffffffffc020923e:	8a2a                	mv	s4,a0
ffffffffc0209240:	ebcd                	bnez	a5,ffffffffc02092f2 <sfs_sync+0xc8>
ffffffffc0209242:	52f010ef          	jal	ra,ffffffffc020af70 <lock_sfs_fs>
ffffffffc0209246:	0a0a3403          	ld	s0,160(s4)
ffffffffc020924a:	098a0913          	addi	s2,s4,152
ffffffffc020924e:	02890763          	beq	s2,s0,ffffffffc020927c <sfs_sync+0x52>
ffffffffc0209252:	00004997          	auipc	s3,0x4
ffffffffc0209256:	0fe98993          	addi	s3,s3,254 # ffffffffc020d350 <default_pmm_manager+0xea0>
ffffffffc020925a:	7c1c                	ld	a5,56(s0)
ffffffffc020925c:	fc840493          	addi	s1,s0,-56
ffffffffc0209260:	cbb5                	beqz	a5,ffffffffc02092d4 <sfs_sync+0xaa>
ffffffffc0209262:	7b9c                	ld	a5,48(a5)
ffffffffc0209264:	cba5                	beqz	a5,ffffffffc02092d4 <sfs_sync+0xaa>
ffffffffc0209266:	85ce                	mv	a1,s3
ffffffffc0209268:	8526                	mv	a0,s1
ffffffffc020926a:	e28fe0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020926e:	7c1c                	ld	a5,56(s0)
ffffffffc0209270:	8526                	mv	a0,s1
ffffffffc0209272:	7b9c                	ld	a5,48(a5)
ffffffffc0209274:	9782                	jalr	a5
ffffffffc0209276:	6400                	ld	s0,8(s0)
ffffffffc0209278:	fe8911e3          	bne	s2,s0,ffffffffc020925a <sfs_sync+0x30>
ffffffffc020927c:	8552                	mv	a0,s4
ffffffffc020927e:	503010ef          	jal	ra,ffffffffc020af80 <unlock_sfs_fs>
ffffffffc0209282:	040a3783          	ld	a5,64(s4)
ffffffffc0209286:	4501                	li	a0,0
ffffffffc0209288:	eb89                	bnez	a5,ffffffffc020929a <sfs_sync+0x70>
ffffffffc020928a:	70a2                	ld	ra,40(sp)
ffffffffc020928c:	7402                	ld	s0,32(sp)
ffffffffc020928e:	64e2                	ld	s1,24(sp)
ffffffffc0209290:	6942                	ld	s2,16(sp)
ffffffffc0209292:	69a2                	ld	s3,8(sp)
ffffffffc0209294:	6a02                	ld	s4,0(sp)
ffffffffc0209296:	6145                	addi	sp,sp,48
ffffffffc0209298:	8082                	ret
ffffffffc020929a:	040a3023          	sd	zero,64(s4)
ffffffffc020929e:	8552                	mv	a0,s4
ffffffffc02092a0:	3b5010ef          	jal	ra,ffffffffc020ae54 <sfs_sync_super>
ffffffffc02092a4:	cd01                	beqz	a0,ffffffffc02092bc <sfs_sync+0x92>
ffffffffc02092a6:	70a2                	ld	ra,40(sp)
ffffffffc02092a8:	7402                	ld	s0,32(sp)
ffffffffc02092aa:	4785                	li	a5,1
ffffffffc02092ac:	04fa3023          	sd	a5,64(s4)
ffffffffc02092b0:	64e2                	ld	s1,24(sp)
ffffffffc02092b2:	6942                	ld	s2,16(sp)
ffffffffc02092b4:	69a2                	ld	s3,8(sp)
ffffffffc02092b6:	6a02                	ld	s4,0(sp)
ffffffffc02092b8:	6145                	addi	sp,sp,48
ffffffffc02092ba:	8082                	ret
ffffffffc02092bc:	8552                	mv	a0,s4
ffffffffc02092be:	3dd010ef          	jal	ra,ffffffffc020ae9a <sfs_sync_freemap>
ffffffffc02092c2:	f175                	bnez	a0,ffffffffc02092a6 <sfs_sync+0x7c>
ffffffffc02092c4:	70a2                	ld	ra,40(sp)
ffffffffc02092c6:	7402                	ld	s0,32(sp)
ffffffffc02092c8:	64e2                	ld	s1,24(sp)
ffffffffc02092ca:	6942                	ld	s2,16(sp)
ffffffffc02092cc:	69a2                	ld	s3,8(sp)
ffffffffc02092ce:	6a02                	ld	s4,0(sp)
ffffffffc02092d0:	6145                	addi	sp,sp,48
ffffffffc02092d2:	8082                	ret
ffffffffc02092d4:	00004697          	auipc	a3,0x4
ffffffffc02092d8:	02c68693          	addi	a3,a3,44 # ffffffffc020d300 <default_pmm_manager+0xe50>
ffffffffc02092dc:	00002617          	auipc	a2,0x2
ffffffffc02092e0:	6cc60613          	addi	a2,a2,1740 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02092e4:	45ed                	li	a1,27
ffffffffc02092e6:	00006517          	auipc	a0,0x6
ffffffffc02092ea:	ae250513          	addi	a0,a0,-1310 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc02092ee:	9b0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02092f2:	00006697          	auipc	a3,0x6
ffffffffc02092f6:	aa668693          	addi	a3,a3,-1370 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc02092fa:	00002617          	auipc	a2,0x2
ffffffffc02092fe:	6ae60613          	addi	a2,a2,1710 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209302:	45d5                	li	a1,21
ffffffffc0209304:	00006517          	auipc	a0,0x6
ffffffffc0209308:	ac450513          	addi	a0,a0,-1340 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc020930c:	992f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209310 <sfs_get_root>:
ffffffffc0209310:	1101                	addi	sp,sp,-32
ffffffffc0209312:	ec06                	sd	ra,24(sp)
ffffffffc0209314:	cd09                	beqz	a0,ffffffffc020932e <sfs_get_root+0x1e>
ffffffffc0209316:	0b052783          	lw	a5,176(a0)
ffffffffc020931a:	eb91                	bnez	a5,ffffffffc020932e <sfs_get_root+0x1e>
ffffffffc020931c:	4605                	li	a2,1
ffffffffc020931e:	002c                	addi	a1,sp,8
ffffffffc0209320:	366010ef          	jal	ra,ffffffffc020a686 <sfs_load_inode>
ffffffffc0209324:	e50d                	bnez	a0,ffffffffc020934e <sfs_get_root+0x3e>
ffffffffc0209326:	60e2                	ld	ra,24(sp)
ffffffffc0209328:	6522                	ld	a0,8(sp)
ffffffffc020932a:	6105                	addi	sp,sp,32
ffffffffc020932c:	8082                	ret
ffffffffc020932e:	00006697          	auipc	a3,0x6
ffffffffc0209332:	a6a68693          	addi	a3,a3,-1430 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc0209336:	00002617          	auipc	a2,0x2
ffffffffc020933a:	67260613          	addi	a2,a2,1650 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020933e:	03600593          	li	a1,54
ffffffffc0209342:	00006517          	auipc	a0,0x6
ffffffffc0209346:	a8650513          	addi	a0,a0,-1402 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc020934a:	954f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020934e:	86aa                	mv	a3,a0
ffffffffc0209350:	00006617          	auipc	a2,0x6
ffffffffc0209354:	ae860613          	addi	a2,a2,-1304 # ffffffffc020ee38 <dev_node_ops+0x480>
ffffffffc0209358:	03700593          	li	a1,55
ffffffffc020935c:	00006517          	auipc	a0,0x6
ffffffffc0209360:	a6c50513          	addi	a0,a0,-1428 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209364:	93af70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209368 <sfs_do_mount>:
ffffffffc0209368:	6518                	ld	a4,8(a0)
ffffffffc020936a:	7171                	addi	sp,sp,-176
ffffffffc020936c:	f506                	sd	ra,168(sp)
ffffffffc020936e:	f122                	sd	s0,160(sp)
ffffffffc0209370:	ed26                	sd	s1,152(sp)
ffffffffc0209372:	e94a                	sd	s2,144(sp)
ffffffffc0209374:	e54e                	sd	s3,136(sp)
ffffffffc0209376:	e152                	sd	s4,128(sp)
ffffffffc0209378:	fcd6                	sd	s5,120(sp)
ffffffffc020937a:	f8da                	sd	s6,112(sp)
ffffffffc020937c:	f4de                	sd	s7,104(sp)
ffffffffc020937e:	f0e2                	sd	s8,96(sp)
ffffffffc0209380:	ece6                	sd	s9,88(sp)
ffffffffc0209382:	e8ea                	sd	s10,80(sp)
ffffffffc0209384:	e4ee                	sd	s11,72(sp)
ffffffffc0209386:	6785                	lui	a5,0x1
ffffffffc0209388:	24f71663          	bne	a4,a5,ffffffffc02095d4 <sfs_do_mount+0x26c>
ffffffffc020938c:	892a                	mv	s2,a0
ffffffffc020938e:	4501                	li	a0,0
ffffffffc0209390:	8aae                	mv	s5,a1
ffffffffc0209392:	f00fe0ef          	jal	ra,ffffffffc0207a92 <__alloc_fs>
ffffffffc0209396:	842a                	mv	s0,a0
ffffffffc0209398:	24050463          	beqz	a0,ffffffffc02095e0 <sfs_do_mount+0x278>
ffffffffc020939c:	0b052b03          	lw	s6,176(a0)
ffffffffc02093a0:	260b1263          	bnez	s6,ffffffffc0209604 <sfs_do_mount+0x29c>
ffffffffc02093a4:	03253823          	sd	s2,48(a0)
ffffffffc02093a8:	6505                	lui	a0,0x1
ffffffffc02093aa:	c35f80ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc02093ae:	e428                	sd	a0,72(s0)
ffffffffc02093b0:	84aa                	mv	s1,a0
ffffffffc02093b2:	16050363          	beqz	a0,ffffffffc0209518 <sfs_do_mount+0x1b0>
ffffffffc02093b6:	85aa                	mv	a1,a0
ffffffffc02093b8:	4681                	li	a3,0
ffffffffc02093ba:	6605                	lui	a2,0x1
ffffffffc02093bc:	1008                	addi	a0,sp,32
ffffffffc02093be:	874fc0ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc02093c2:	02093783          	ld	a5,32(s2)
ffffffffc02093c6:	85aa                	mv	a1,a0
ffffffffc02093c8:	4601                	li	a2,0
ffffffffc02093ca:	854a                	mv	a0,s2
ffffffffc02093cc:	9782                	jalr	a5
ffffffffc02093ce:	8a2a                	mv	s4,a0
ffffffffc02093d0:	10051e63          	bnez	a0,ffffffffc02094ec <sfs_do_mount+0x184>
ffffffffc02093d4:	408c                	lw	a1,0(s1)
ffffffffc02093d6:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc02093da:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc02093de:	14c59863          	bne	a1,a2,ffffffffc020952e <sfs_do_mount+0x1c6>
ffffffffc02093e2:	40dc                	lw	a5,4(s1)
ffffffffc02093e4:	00093603          	ld	a2,0(s2)
ffffffffc02093e8:	02079713          	slli	a4,a5,0x20
ffffffffc02093ec:	9301                	srli	a4,a4,0x20
ffffffffc02093ee:	12e66763          	bltu	a2,a4,ffffffffc020951c <sfs_do_mount+0x1b4>
ffffffffc02093f2:	020485a3          	sb	zero,43(s1)
ffffffffc02093f6:	0084af03          	lw	t5,8(s1)
ffffffffc02093fa:	00c4ae83          	lw	t4,12(s1)
ffffffffc02093fe:	0104ae03          	lw	t3,16(s1)
ffffffffc0209402:	0144a303          	lw	t1,20(s1)
ffffffffc0209406:	0184a883          	lw	a7,24(s1)
ffffffffc020940a:	01c4a803          	lw	a6,28(s1)
ffffffffc020940e:	5090                	lw	a2,32(s1)
ffffffffc0209410:	50d4                	lw	a3,36(s1)
ffffffffc0209412:	5498                	lw	a4,40(s1)
ffffffffc0209414:	6511                	lui	a0,0x4
ffffffffc0209416:	c00c                	sw	a1,0(s0)
ffffffffc0209418:	c05c                	sw	a5,4(s0)
ffffffffc020941a:	01e42423          	sw	t5,8(s0)
ffffffffc020941e:	01d42623          	sw	t4,12(s0)
ffffffffc0209422:	01c42823          	sw	t3,16(s0)
ffffffffc0209426:	00642a23          	sw	t1,20(s0)
ffffffffc020942a:	01142c23          	sw	a7,24(s0)
ffffffffc020942e:	01042e23          	sw	a6,28(s0)
ffffffffc0209432:	d010                	sw	a2,32(s0)
ffffffffc0209434:	d054                	sw	a3,36(s0)
ffffffffc0209436:	d418                	sw	a4,40(s0)
ffffffffc0209438:	ba7f80ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020943c:	f448                	sd	a0,168(s0)
ffffffffc020943e:	8c2a                	mv	s8,a0
ffffffffc0209440:	18050c63          	beqz	a0,ffffffffc02095d8 <sfs_do_mount+0x270>
ffffffffc0209444:	6711                	lui	a4,0x4
ffffffffc0209446:	87aa                	mv	a5,a0
ffffffffc0209448:	972a                	add	a4,a4,a0
ffffffffc020944a:	e79c                	sd	a5,8(a5)
ffffffffc020944c:	e39c                	sd	a5,0(a5)
ffffffffc020944e:	07c1                	addi	a5,a5,16
ffffffffc0209450:	fee79de3          	bne	a5,a4,ffffffffc020944a <sfs_do_mount+0xe2>
ffffffffc0209454:	0044eb83          	lwu	s7,4(s1)
ffffffffc0209458:	67a1                	lui	a5,0x8
ffffffffc020945a:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc020945e:	9bce                	add	s7,s7,s3
ffffffffc0209460:	77e1                	lui	a5,0xffff8
ffffffffc0209462:	00fbfbb3          	and	s7,s7,a5
ffffffffc0209466:	2b81                	sext.w	s7,s7
ffffffffc0209468:	855e                	mv	a0,s7
ffffffffc020946a:	a59ff0ef          	jal	ra,ffffffffc0208ec2 <bitmap_create>
ffffffffc020946e:	fc08                	sd	a0,56(s0)
ffffffffc0209470:	8d2a                	mv	s10,a0
ffffffffc0209472:	14050f63          	beqz	a0,ffffffffc02095d0 <sfs_do_mount+0x268>
ffffffffc0209476:	0044e783          	lwu	a5,4(s1)
ffffffffc020947a:	082c                	addi	a1,sp,24
ffffffffc020947c:	97ce                	add	a5,a5,s3
ffffffffc020947e:	00f7d713          	srli	a4,a5,0xf
ffffffffc0209482:	e43a                	sd	a4,8(sp)
ffffffffc0209484:	40f7d993          	srai	s3,a5,0xf
ffffffffc0209488:	c4fff0ef          	jal	ra,ffffffffc02090d6 <bitmap_getdata>
ffffffffc020948c:	14050c63          	beqz	a0,ffffffffc02095e4 <sfs_do_mount+0x27c>
ffffffffc0209490:	00c9979b          	slliw	a5,s3,0xc
ffffffffc0209494:	66e2                	ld	a3,24(sp)
ffffffffc0209496:	1782                	slli	a5,a5,0x20
ffffffffc0209498:	9381                	srli	a5,a5,0x20
ffffffffc020949a:	14d79563          	bne	a5,a3,ffffffffc02095e4 <sfs_do_mount+0x27c>
ffffffffc020949e:	6722                	ld	a4,8(sp)
ffffffffc02094a0:	6d89                	lui	s11,0x2
ffffffffc02094a2:	89aa                	mv	s3,a0
ffffffffc02094a4:	00c71c93          	slli	s9,a4,0xc
ffffffffc02094a8:	9caa                	add	s9,s9,a0
ffffffffc02094aa:	40ad8dbb          	subw	s11,s11,a0
ffffffffc02094ae:	e711                	bnez	a4,ffffffffc02094ba <sfs_do_mount+0x152>
ffffffffc02094b0:	a079                	j	ffffffffc020953e <sfs_do_mount+0x1d6>
ffffffffc02094b2:	6785                	lui	a5,0x1
ffffffffc02094b4:	99be                	add	s3,s3,a5
ffffffffc02094b6:	093c8463          	beq	s9,s3,ffffffffc020953e <sfs_do_mount+0x1d6>
ffffffffc02094ba:	013d86bb          	addw	a3,s11,s3
ffffffffc02094be:	1682                	slli	a3,a3,0x20
ffffffffc02094c0:	6605                	lui	a2,0x1
ffffffffc02094c2:	85ce                	mv	a1,s3
ffffffffc02094c4:	9281                	srli	a3,a3,0x20
ffffffffc02094c6:	1008                	addi	a0,sp,32
ffffffffc02094c8:	f6bfb0ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc02094cc:	02093783          	ld	a5,32(s2)
ffffffffc02094d0:	85aa                	mv	a1,a0
ffffffffc02094d2:	4601                	li	a2,0
ffffffffc02094d4:	854a                	mv	a0,s2
ffffffffc02094d6:	9782                	jalr	a5
ffffffffc02094d8:	dd69                	beqz	a0,ffffffffc02094b2 <sfs_do_mount+0x14a>
ffffffffc02094da:	e42a                	sd	a0,8(sp)
ffffffffc02094dc:	856a                	mv	a0,s10
ffffffffc02094de:	bdfff0ef          	jal	ra,ffffffffc02090bc <bitmap_destroy>
ffffffffc02094e2:	67a2                	ld	a5,8(sp)
ffffffffc02094e4:	8a3e                	mv	s4,a5
ffffffffc02094e6:	8562                	mv	a0,s8
ffffffffc02094e8:	ba7f80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc02094ec:	8526                	mv	a0,s1
ffffffffc02094ee:	ba1f80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc02094f2:	8522                	mv	a0,s0
ffffffffc02094f4:	b9bf80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc02094f8:	70aa                	ld	ra,168(sp)
ffffffffc02094fa:	740a                	ld	s0,160(sp)
ffffffffc02094fc:	64ea                	ld	s1,152(sp)
ffffffffc02094fe:	694a                	ld	s2,144(sp)
ffffffffc0209500:	69aa                	ld	s3,136(sp)
ffffffffc0209502:	7ae6                	ld	s5,120(sp)
ffffffffc0209504:	7b46                	ld	s6,112(sp)
ffffffffc0209506:	7ba6                	ld	s7,104(sp)
ffffffffc0209508:	7c06                	ld	s8,96(sp)
ffffffffc020950a:	6ce6                	ld	s9,88(sp)
ffffffffc020950c:	6d46                	ld	s10,80(sp)
ffffffffc020950e:	6da6                	ld	s11,72(sp)
ffffffffc0209510:	8552                	mv	a0,s4
ffffffffc0209512:	6a0a                	ld	s4,128(sp)
ffffffffc0209514:	614d                	addi	sp,sp,176
ffffffffc0209516:	8082                	ret
ffffffffc0209518:	5a71                	li	s4,-4
ffffffffc020951a:	bfe1                	j	ffffffffc02094f2 <sfs_do_mount+0x18a>
ffffffffc020951c:	85be                	mv	a1,a5
ffffffffc020951e:	00006517          	auipc	a0,0x6
ffffffffc0209522:	97250513          	addi	a0,a0,-1678 # ffffffffc020ee90 <dev_node_ops+0x4d8>
ffffffffc0209526:	c81f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020952a:	5a75                	li	s4,-3
ffffffffc020952c:	b7c1                	j	ffffffffc02094ec <sfs_do_mount+0x184>
ffffffffc020952e:	00006517          	auipc	a0,0x6
ffffffffc0209532:	92a50513          	addi	a0,a0,-1750 # ffffffffc020ee58 <dev_node_ops+0x4a0>
ffffffffc0209536:	c71f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020953a:	5a75                	li	s4,-3
ffffffffc020953c:	bf45                	j	ffffffffc02094ec <sfs_do_mount+0x184>
ffffffffc020953e:	00442903          	lw	s2,4(s0)
ffffffffc0209542:	4481                	li	s1,0
ffffffffc0209544:	080b8c63          	beqz	s7,ffffffffc02095dc <sfs_do_mount+0x274>
ffffffffc0209548:	85a6                	mv	a1,s1
ffffffffc020954a:	856a                	mv	a0,s10
ffffffffc020954c:	af7ff0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc0209550:	c111                	beqz	a0,ffffffffc0209554 <sfs_do_mount+0x1ec>
ffffffffc0209552:	2b05                	addiw	s6,s6,1
ffffffffc0209554:	2485                	addiw	s1,s1,1
ffffffffc0209556:	fe9b99e3          	bne	s7,s1,ffffffffc0209548 <sfs_do_mount+0x1e0>
ffffffffc020955a:	441c                	lw	a5,8(s0)
ffffffffc020955c:	0d679463          	bne	a5,s6,ffffffffc0209624 <sfs_do_mount+0x2bc>
ffffffffc0209560:	4585                	li	a1,1
ffffffffc0209562:	05040513          	addi	a0,s0,80
ffffffffc0209566:	04043023          	sd	zero,64(s0)
ffffffffc020956a:	840fb0ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc020956e:	4585                	li	a1,1
ffffffffc0209570:	06840513          	addi	a0,s0,104
ffffffffc0209574:	836fb0ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0209578:	4585                	li	a1,1
ffffffffc020957a:	08040513          	addi	a0,s0,128
ffffffffc020957e:	82cfb0ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc0209582:	09840793          	addi	a5,s0,152
ffffffffc0209586:	f05c                	sd	a5,160(s0)
ffffffffc0209588:	ec5c                	sd	a5,152(s0)
ffffffffc020958a:	874a                	mv	a4,s2
ffffffffc020958c:	86da                	mv	a3,s6
ffffffffc020958e:	4169063b          	subw	a2,s2,s6
ffffffffc0209592:	00c40593          	addi	a1,s0,12
ffffffffc0209596:	00006517          	auipc	a0,0x6
ffffffffc020959a:	98a50513          	addi	a0,a0,-1654 # ffffffffc020ef20 <dev_node_ops+0x568>
ffffffffc020959e:	c09f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02095a2:	00000797          	auipc	a5,0x0
ffffffffc02095a6:	c8878793          	addi	a5,a5,-888 # ffffffffc020922a <sfs_sync>
ffffffffc02095aa:	fc5c                	sd	a5,184(s0)
ffffffffc02095ac:	00000797          	auipc	a5,0x0
ffffffffc02095b0:	d6478793          	addi	a5,a5,-668 # ffffffffc0209310 <sfs_get_root>
ffffffffc02095b4:	e07c                	sd	a5,192(s0)
ffffffffc02095b6:	00000797          	auipc	a5,0x0
ffffffffc02095ba:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0209114 <sfs_unmount>
ffffffffc02095be:	e47c                	sd	a5,200(s0)
ffffffffc02095c0:	00000797          	auipc	a5,0x0
ffffffffc02095c4:	bd878793          	addi	a5,a5,-1064 # ffffffffc0209198 <sfs_cleanup>
ffffffffc02095c8:	e87c                	sd	a5,208(s0)
ffffffffc02095ca:	008ab023          	sd	s0,0(s5)
ffffffffc02095ce:	b72d                	j	ffffffffc02094f8 <sfs_do_mount+0x190>
ffffffffc02095d0:	5a71                	li	s4,-4
ffffffffc02095d2:	bf11                	j	ffffffffc02094e6 <sfs_do_mount+0x17e>
ffffffffc02095d4:	5a49                	li	s4,-14
ffffffffc02095d6:	b70d                	j	ffffffffc02094f8 <sfs_do_mount+0x190>
ffffffffc02095d8:	5a71                	li	s4,-4
ffffffffc02095da:	bf09                	j	ffffffffc02094ec <sfs_do_mount+0x184>
ffffffffc02095dc:	4b01                	li	s6,0
ffffffffc02095de:	bfb5                	j	ffffffffc020955a <sfs_do_mount+0x1f2>
ffffffffc02095e0:	5a71                	li	s4,-4
ffffffffc02095e2:	bf19                	j	ffffffffc02094f8 <sfs_do_mount+0x190>
ffffffffc02095e4:	00006697          	auipc	a3,0x6
ffffffffc02095e8:	8dc68693          	addi	a3,a3,-1828 # ffffffffc020eec0 <dev_node_ops+0x508>
ffffffffc02095ec:	00002617          	auipc	a2,0x2
ffffffffc02095f0:	3bc60613          	addi	a2,a2,956 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02095f4:	08300593          	li	a1,131
ffffffffc02095f8:	00005517          	auipc	a0,0x5
ffffffffc02095fc:	7d050513          	addi	a0,a0,2000 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209600:	e9ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209604:	00005697          	auipc	a3,0x5
ffffffffc0209608:	79468693          	addi	a3,a3,1940 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020960c:	00002617          	auipc	a2,0x2
ffffffffc0209610:	39c60613          	addi	a2,a2,924 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209614:	0a300593          	li	a1,163
ffffffffc0209618:	00005517          	auipc	a0,0x5
ffffffffc020961c:	7b050513          	addi	a0,a0,1968 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209620:	e7ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209624:	00006697          	auipc	a3,0x6
ffffffffc0209628:	8cc68693          	addi	a3,a3,-1844 # ffffffffc020eef0 <dev_node_ops+0x538>
ffffffffc020962c:	00002617          	auipc	a2,0x2
ffffffffc0209630:	37c60613          	addi	a2,a2,892 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209634:	0e000593          	li	a1,224
ffffffffc0209638:	00005517          	auipc	a0,0x5
ffffffffc020963c:	79050513          	addi	a0,a0,1936 # ffffffffc020edc8 <dev_node_ops+0x410>
ffffffffc0209640:	e5ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209644 <sfs_mount>:
ffffffffc0209644:	00000597          	auipc	a1,0x0
ffffffffc0209648:	d2458593          	addi	a1,a1,-732 # ffffffffc0209368 <sfs_do_mount>
ffffffffc020964c:	817fe06f          	j	ffffffffc0207e62 <vfs_mount>

ffffffffc0209650 <sfs_opendir>:
ffffffffc0209650:	0235f593          	andi	a1,a1,35
ffffffffc0209654:	4501                	li	a0,0
ffffffffc0209656:	e191                	bnez	a1,ffffffffc020965a <sfs_opendir+0xa>
ffffffffc0209658:	8082                	ret
ffffffffc020965a:	553d                	li	a0,-17
ffffffffc020965c:	8082                	ret

ffffffffc020965e <sfs_openfile>:
ffffffffc020965e:	4501                	li	a0,0
ffffffffc0209660:	8082                	ret

ffffffffc0209662 <sfs_gettype>:
ffffffffc0209662:	1141                	addi	sp,sp,-16
ffffffffc0209664:	e406                	sd	ra,8(sp)
ffffffffc0209666:	c939                	beqz	a0,ffffffffc02096bc <sfs_gettype+0x5a>
ffffffffc0209668:	4d34                	lw	a3,88(a0)
ffffffffc020966a:	6785                	lui	a5,0x1
ffffffffc020966c:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209670:	04e69663          	bne	a3,a4,ffffffffc02096bc <sfs_gettype+0x5a>
ffffffffc0209674:	6114                	ld	a3,0(a0)
ffffffffc0209676:	4709                	li	a4,2
ffffffffc0209678:	0046d683          	lhu	a3,4(a3)
ffffffffc020967c:	02e68a63          	beq	a3,a4,ffffffffc02096b0 <sfs_gettype+0x4e>
ffffffffc0209680:	470d                	li	a4,3
ffffffffc0209682:	02e68163          	beq	a3,a4,ffffffffc02096a4 <sfs_gettype+0x42>
ffffffffc0209686:	4705                	li	a4,1
ffffffffc0209688:	00e68f63          	beq	a3,a4,ffffffffc02096a6 <sfs_gettype+0x44>
ffffffffc020968c:	00006617          	auipc	a2,0x6
ffffffffc0209690:	90460613          	addi	a2,a2,-1788 # ffffffffc020ef90 <dev_node_ops+0x5d8>
ffffffffc0209694:	38e00593          	li	a1,910
ffffffffc0209698:	00006517          	auipc	a0,0x6
ffffffffc020969c:	8e050513          	addi	a0,a0,-1824 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc02096a0:	dfff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02096a4:	678d                	lui	a5,0x3
ffffffffc02096a6:	60a2                	ld	ra,8(sp)
ffffffffc02096a8:	c19c                	sw	a5,0(a1)
ffffffffc02096aa:	4501                	li	a0,0
ffffffffc02096ac:	0141                	addi	sp,sp,16
ffffffffc02096ae:	8082                	ret
ffffffffc02096b0:	60a2                	ld	ra,8(sp)
ffffffffc02096b2:	6789                	lui	a5,0x2
ffffffffc02096b4:	c19c                	sw	a5,0(a1)
ffffffffc02096b6:	4501                	li	a0,0
ffffffffc02096b8:	0141                	addi	sp,sp,16
ffffffffc02096ba:	8082                	ret
ffffffffc02096bc:	00006697          	auipc	a3,0x6
ffffffffc02096c0:	88468693          	addi	a3,a3,-1916 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc02096c4:	00002617          	auipc	a2,0x2
ffffffffc02096c8:	2e460613          	addi	a2,a2,740 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02096cc:	38200593          	li	a1,898
ffffffffc02096d0:	00006517          	auipc	a0,0x6
ffffffffc02096d4:	8a850513          	addi	a0,a0,-1880 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc02096d8:	dc7f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02096dc <sfs_fsync>:
ffffffffc02096dc:	7179                	addi	sp,sp,-48
ffffffffc02096de:	ec26                	sd	s1,24(sp)
ffffffffc02096e0:	7524                	ld	s1,104(a0)
ffffffffc02096e2:	f406                	sd	ra,40(sp)
ffffffffc02096e4:	f022                	sd	s0,32(sp)
ffffffffc02096e6:	e84a                	sd	s2,16(sp)
ffffffffc02096e8:	e44e                	sd	s3,8(sp)
ffffffffc02096ea:	c4bd                	beqz	s1,ffffffffc0209758 <sfs_fsync+0x7c>
ffffffffc02096ec:	0b04a783          	lw	a5,176(s1)
ffffffffc02096f0:	e7a5                	bnez	a5,ffffffffc0209758 <sfs_fsync+0x7c>
ffffffffc02096f2:	4d38                	lw	a4,88(a0)
ffffffffc02096f4:	6785                	lui	a5,0x1
ffffffffc02096f6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02096fa:	842a                	mv	s0,a0
ffffffffc02096fc:	06f71e63          	bne	a4,a5,ffffffffc0209778 <sfs_fsync+0x9c>
ffffffffc0209700:	691c                	ld	a5,16(a0)
ffffffffc0209702:	4901                	li	s2,0
ffffffffc0209704:	eb89                	bnez	a5,ffffffffc0209716 <sfs_fsync+0x3a>
ffffffffc0209706:	70a2                	ld	ra,40(sp)
ffffffffc0209708:	7402                	ld	s0,32(sp)
ffffffffc020970a:	64e2                	ld	s1,24(sp)
ffffffffc020970c:	69a2                	ld	s3,8(sp)
ffffffffc020970e:	854a                	mv	a0,s2
ffffffffc0209710:	6942                	ld	s2,16(sp)
ffffffffc0209712:	6145                	addi	sp,sp,48
ffffffffc0209714:	8082                	ret
ffffffffc0209716:	02050993          	addi	s3,a0,32
ffffffffc020971a:	854e                	mv	a0,s3
ffffffffc020971c:	e99fa0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc0209720:	681c                	ld	a5,16(s0)
ffffffffc0209722:	ef81                	bnez	a5,ffffffffc020973a <sfs_fsync+0x5e>
ffffffffc0209724:	854e                	mv	a0,s3
ffffffffc0209726:	e8bfa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020972a:	70a2                	ld	ra,40(sp)
ffffffffc020972c:	7402                	ld	s0,32(sp)
ffffffffc020972e:	64e2                	ld	s1,24(sp)
ffffffffc0209730:	69a2                	ld	s3,8(sp)
ffffffffc0209732:	854a                	mv	a0,s2
ffffffffc0209734:	6942                	ld	s2,16(sp)
ffffffffc0209736:	6145                	addi	sp,sp,48
ffffffffc0209738:	8082                	ret
ffffffffc020973a:	4414                	lw	a3,8(s0)
ffffffffc020973c:	600c                	ld	a1,0(s0)
ffffffffc020973e:	00043823          	sd	zero,16(s0)
ffffffffc0209742:	4701                	li	a4,0
ffffffffc0209744:	04000613          	li	a2,64
ffffffffc0209748:	8526                	mv	a0,s1
ffffffffc020974a:	676010ef          	jal	ra,ffffffffc020adc0 <sfs_wbuf>
ffffffffc020974e:	892a                	mv	s2,a0
ffffffffc0209750:	d971                	beqz	a0,ffffffffc0209724 <sfs_fsync+0x48>
ffffffffc0209752:	4785                	li	a5,1
ffffffffc0209754:	e81c                	sd	a5,16(s0)
ffffffffc0209756:	b7f9                	j	ffffffffc0209724 <sfs_fsync+0x48>
ffffffffc0209758:	00005697          	auipc	a3,0x5
ffffffffc020975c:	64068693          	addi	a3,a3,1600 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc0209760:	00002617          	auipc	a2,0x2
ffffffffc0209764:	24860613          	addi	a2,a2,584 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209768:	2c600593          	li	a1,710
ffffffffc020976c:	00006517          	auipc	a0,0x6
ffffffffc0209770:	80c50513          	addi	a0,a0,-2036 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209774:	d2bf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209778:	00005697          	auipc	a3,0x5
ffffffffc020977c:	7c868693          	addi	a3,a3,1992 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc0209780:	00002617          	auipc	a2,0x2
ffffffffc0209784:	22860613          	addi	a2,a2,552 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209788:	2c700593          	li	a1,711
ffffffffc020978c:	00005517          	auipc	a0,0x5
ffffffffc0209790:	7ec50513          	addi	a0,a0,2028 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209794:	d0bf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209798 <sfs_fstat>:
ffffffffc0209798:	1101                	addi	sp,sp,-32
ffffffffc020979a:	e426                	sd	s1,8(sp)
ffffffffc020979c:	84ae                	mv	s1,a1
ffffffffc020979e:	e822                	sd	s0,16(sp)
ffffffffc02097a0:	02000613          	li	a2,32
ffffffffc02097a4:	842a                	mv	s0,a0
ffffffffc02097a6:	4581                	li	a1,0
ffffffffc02097a8:	8526                	mv	a0,s1
ffffffffc02097aa:	ec06                	sd	ra,24(sp)
ffffffffc02097ac:	519010ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc02097b0:	c439                	beqz	s0,ffffffffc02097fe <sfs_fstat+0x66>
ffffffffc02097b2:	783c                	ld	a5,112(s0)
ffffffffc02097b4:	c7a9                	beqz	a5,ffffffffc02097fe <sfs_fstat+0x66>
ffffffffc02097b6:	6bbc                	ld	a5,80(a5)
ffffffffc02097b8:	c3b9                	beqz	a5,ffffffffc02097fe <sfs_fstat+0x66>
ffffffffc02097ba:	00005597          	auipc	a1,0x5
ffffffffc02097be:	17658593          	addi	a1,a1,374 # ffffffffc020e930 <syscalls+0xdb0>
ffffffffc02097c2:	8522                	mv	a0,s0
ffffffffc02097c4:	8cefe0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc02097c8:	783c                	ld	a5,112(s0)
ffffffffc02097ca:	85a6                	mv	a1,s1
ffffffffc02097cc:	8522                	mv	a0,s0
ffffffffc02097ce:	6bbc                	ld	a5,80(a5)
ffffffffc02097d0:	9782                	jalr	a5
ffffffffc02097d2:	e10d                	bnez	a0,ffffffffc02097f4 <sfs_fstat+0x5c>
ffffffffc02097d4:	4c38                	lw	a4,88(s0)
ffffffffc02097d6:	6785                	lui	a5,0x1
ffffffffc02097d8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02097dc:	04f71163          	bne	a4,a5,ffffffffc020981e <sfs_fstat+0x86>
ffffffffc02097e0:	601c                	ld	a5,0(s0)
ffffffffc02097e2:	0067d683          	lhu	a3,6(a5)
ffffffffc02097e6:	0087e703          	lwu	a4,8(a5)
ffffffffc02097ea:	0007e783          	lwu	a5,0(a5)
ffffffffc02097ee:	e494                	sd	a3,8(s1)
ffffffffc02097f0:	e898                	sd	a4,16(s1)
ffffffffc02097f2:	ec9c                	sd	a5,24(s1)
ffffffffc02097f4:	60e2                	ld	ra,24(sp)
ffffffffc02097f6:	6442                	ld	s0,16(sp)
ffffffffc02097f8:	64a2                	ld	s1,8(sp)
ffffffffc02097fa:	6105                	addi	sp,sp,32
ffffffffc02097fc:	8082                	ret
ffffffffc02097fe:	00005697          	auipc	a3,0x5
ffffffffc0209802:	0ca68693          	addi	a3,a3,202 # ffffffffc020e8c8 <syscalls+0xd48>
ffffffffc0209806:	00002617          	auipc	a2,0x2
ffffffffc020980a:	1a260613          	addi	a2,a2,418 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020980e:	2b700593          	li	a1,695
ffffffffc0209812:	00005517          	auipc	a0,0x5
ffffffffc0209816:	76650513          	addi	a0,a0,1894 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020981a:	c85f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020981e:	00005697          	auipc	a3,0x5
ffffffffc0209822:	72268693          	addi	a3,a3,1826 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc0209826:	00002617          	auipc	a2,0x2
ffffffffc020982a:	18260613          	addi	a2,a2,386 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020982e:	2ba00593          	li	a1,698
ffffffffc0209832:	00005517          	auipc	a0,0x5
ffffffffc0209836:	74650513          	addi	a0,a0,1862 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020983a:	c65f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020983e <sfs_tryseek>:
ffffffffc020983e:	080007b7          	lui	a5,0x8000
ffffffffc0209842:	04f5fd63          	bgeu	a1,a5,ffffffffc020989c <sfs_tryseek+0x5e>
ffffffffc0209846:	1101                	addi	sp,sp,-32
ffffffffc0209848:	e822                	sd	s0,16(sp)
ffffffffc020984a:	ec06                	sd	ra,24(sp)
ffffffffc020984c:	e426                	sd	s1,8(sp)
ffffffffc020984e:	842a                	mv	s0,a0
ffffffffc0209850:	c921                	beqz	a0,ffffffffc02098a0 <sfs_tryseek+0x62>
ffffffffc0209852:	4d38                	lw	a4,88(a0)
ffffffffc0209854:	6785                	lui	a5,0x1
ffffffffc0209856:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020985a:	04f71363          	bne	a4,a5,ffffffffc02098a0 <sfs_tryseek+0x62>
ffffffffc020985e:	611c                	ld	a5,0(a0)
ffffffffc0209860:	84ae                	mv	s1,a1
ffffffffc0209862:	0007e783          	lwu	a5,0(a5)
ffffffffc0209866:	02b7d563          	bge	a5,a1,ffffffffc0209890 <sfs_tryseek+0x52>
ffffffffc020986a:	793c                	ld	a5,112(a0)
ffffffffc020986c:	cbb1                	beqz	a5,ffffffffc02098c0 <sfs_tryseek+0x82>
ffffffffc020986e:	73bc                	ld	a5,96(a5)
ffffffffc0209870:	cba1                	beqz	a5,ffffffffc02098c0 <sfs_tryseek+0x82>
ffffffffc0209872:	00005597          	auipc	a1,0x5
ffffffffc0209876:	fae58593          	addi	a1,a1,-82 # ffffffffc020e820 <syscalls+0xca0>
ffffffffc020987a:	818fe0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc020987e:	783c                	ld	a5,112(s0)
ffffffffc0209880:	8522                	mv	a0,s0
ffffffffc0209882:	6442                	ld	s0,16(sp)
ffffffffc0209884:	60e2                	ld	ra,24(sp)
ffffffffc0209886:	73bc                	ld	a5,96(a5)
ffffffffc0209888:	85a6                	mv	a1,s1
ffffffffc020988a:	64a2                	ld	s1,8(sp)
ffffffffc020988c:	6105                	addi	sp,sp,32
ffffffffc020988e:	8782                	jr	a5
ffffffffc0209890:	60e2                	ld	ra,24(sp)
ffffffffc0209892:	6442                	ld	s0,16(sp)
ffffffffc0209894:	64a2                	ld	s1,8(sp)
ffffffffc0209896:	4501                	li	a0,0
ffffffffc0209898:	6105                	addi	sp,sp,32
ffffffffc020989a:	8082                	ret
ffffffffc020989c:	5575                	li	a0,-3
ffffffffc020989e:	8082                	ret
ffffffffc02098a0:	00005697          	auipc	a3,0x5
ffffffffc02098a4:	6a068693          	addi	a3,a3,1696 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc02098a8:	00002617          	auipc	a2,0x2
ffffffffc02098ac:	10060613          	addi	a2,a2,256 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02098b0:	39900593          	li	a1,921
ffffffffc02098b4:	00005517          	auipc	a0,0x5
ffffffffc02098b8:	6c450513          	addi	a0,a0,1732 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc02098bc:	be3f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098c0:	00005697          	auipc	a3,0x5
ffffffffc02098c4:	f0868693          	addi	a3,a3,-248 # ffffffffc020e7c8 <syscalls+0xc48>
ffffffffc02098c8:	00002617          	auipc	a2,0x2
ffffffffc02098cc:	0e060613          	addi	a2,a2,224 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02098d0:	39b00593          	li	a1,923
ffffffffc02098d4:	00005517          	auipc	a0,0x5
ffffffffc02098d8:	6a450513          	addi	a0,a0,1700 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc02098dc:	bc3f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02098e0 <sfs_close>:
ffffffffc02098e0:	1141                	addi	sp,sp,-16
ffffffffc02098e2:	e406                	sd	ra,8(sp)
ffffffffc02098e4:	e022                	sd	s0,0(sp)
ffffffffc02098e6:	c11d                	beqz	a0,ffffffffc020990c <sfs_close+0x2c>
ffffffffc02098e8:	793c                	ld	a5,112(a0)
ffffffffc02098ea:	842a                	mv	s0,a0
ffffffffc02098ec:	c385                	beqz	a5,ffffffffc020990c <sfs_close+0x2c>
ffffffffc02098ee:	7b9c                	ld	a5,48(a5)
ffffffffc02098f0:	cf91                	beqz	a5,ffffffffc020990c <sfs_close+0x2c>
ffffffffc02098f2:	00004597          	auipc	a1,0x4
ffffffffc02098f6:	a5e58593          	addi	a1,a1,-1442 # ffffffffc020d350 <default_pmm_manager+0xea0>
ffffffffc02098fa:	f99fd0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc02098fe:	783c                	ld	a5,112(s0)
ffffffffc0209900:	8522                	mv	a0,s0
ffffffffc0209902:	6402                	ld	s0,0(sp)
ffffffffc0209904:	60a2                	ld	ra,8(sp)
ffffffffc0209906:	7b9c                	ld	a5,48(a5)
ffffffffc0209908:	0141                	addi	sp,sp,16
ffffffffc020990a:	8782                	jr	a5
ffffffffc020990c:	00004697          	auipc	a3,0x4
ffffffffc0209910:	9f468693          	addi	a3,a3,-1548 # ffffffffc020d300 <default_pmm_manager+0xe50>
ffffffffc0209914:	00002617          	auipc	a2,0x2
ffffffffc0209918:	09460613          	addi	a2,a2,148 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020991c:	21c00593          	li	a1,540
ffffffffc0209920:	00005517          	auipc	a0,0x5
ffffffffc0209924:	65850513          	addi	a0,a0,1624 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209928:	b77f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020992c <sfs_io.part.0>:
ffffffffc020992c:	1141                	addi	sp,sp,-16
ffffffffc020992e:	00005697          	auipc	a3,0x5
ffffffffc0209932:	61268693          	addi	a3,a3,1554 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc0209936:	00002617          	auipc	a2,0x2
ffffffffc020993a:	07260613          	addi	a2,a2,114 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020993e:	29600593          	li	a1,662
ffffffffc0209942:	00005517          	auipc	a0,0x5
ffffffffc0209946:	63650513          	addi	a0,a0,1590 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020994a:	e406                	sd	ra,8(sp)
ffffffffc020994c:	b53f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209950 <sfs_block_free>:
ffffffffc0209950:	1101                	addi	sp,sp,-32
ffffffffc0209952:	e426                	sd	s1,8(sp)
ffffffffc0209954:	ec06                	sd	ra,24(sp)
ffffffffc0209956:	e822                	sd	s0,16(sp)
ffffffffc0209958:	4154                	lw	a3,4(a0)
ffffffffc020995a:	84ae                	mv	s1,a1
ffffffffc020995c:	c595                	beqz	a1,ffffffffc0209988 <sfs_block_free+0x38>
ffffffffc020995e:	02d5f563          	bgeu	a1,a3,ffffffffc0209988 <sfs_block_free+0x38>
ffffffffc0209962:	842a                	mv	s0,a0
ffffffffc0209964:	7d08                	ld	a0,56(a0)
ffffffffc0209966:	edcff0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc020996a:	ed05                	bnez	a0,ffffffffc02099a2 <sfs_block_free+0x52>
ffffffffc020996c:	7c08                	ld	a0,56(s0)
ffffffffc020996e:	85a6                	mv	a1,s1
ffffffffc0209970:	efaff0ef          	jal	ra,ffffffffc020906a <bitmap_free>
ffffffffc0209974:	441c                	lw	a5,8(s0)
ffffffffc0209976:	4705                	li	a4,1
ffffffffc0209978:	60e2                	ld	ra,24(sp)
ffffffffc020997a:	2785                	addiw	a5,a5,1
ffffffffc020997c:	e038                	sd	a4,64(s0)
ffffffffc020997e:	c41c                	sw	a5,8(s0)
ffffffffc0209980:	6442                	ld	s0,16(sp)
ffffffffc0209982:	64a2                	ld	s1,8(sp)
ffffffffc0209984:	6105                	addi	sp,sp,32
ffffffffc0209986:	8082                	ret
ffffffffc0209988:	8726                	mv	a4,s1
ffffffffc020998a:	00005617          	auipc	a2,0x5
ffffffffc020998e:	61e60613          	addi	a2,a2,1566 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc0209992:	05300593          	li	a1,83
ffffffffc0209996:	00005517          	auipc	a0,0x5
ffffffffc020999a:	5e250513          	addi	a0,a0,1506 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020999e:	b01f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02099a2:	00005697          	auipc	a3,0x5
ffffffffc02099a6:	63e68693          	addi	a3,a3,1598 # ffffffffc020efe0 <dev_node_ops+0x628>
ffffffffc02099aa:	00002617          	auipc	a2,0x2
ffffffffc02099ae:	ffe60613          	addi	a2,a2,-2 # ffffffffc020b9a8 <commands+0x210>
ffffffffc02099b2:	06a00593          	li	a1,106
ffffffffc02099b6:	00005517          	auipc	a0,0x5
ffffffffc02099ba:	5c250513          	addi	a0,a0,1474 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc02099be:	ae1f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02099c2 <sfs_reclaim>:
ffffffffc02099c2:	1101                	addi	sp,sp,-32
ffffffffc02099c4:	e426                	sd	s1,8(sp)
ffffffffc02099c6:	7524                	ld	s1,104(a0)
ffffffffc02099c8:	ec06                	sd	ra,24(sp)
ffffffffc02099ca:	e822                	sd	s0,16(sp)
ffffffffc02099cc:	e04a                	sd	s2,0(sp)
ffffffffc02099ce:	0e048a63          	beqz	s1,ffffffffc0209ac2 <sfs_reclaim+0x100>
ffffffffc02099d2:	0b04a783          	lw	a5,176(s1)
ffffffffc02099d6:	0e079663          	bnez	a5,ffffffffc0209ac2 <sfs_reclaim+0x100>
ffffffffc02099da:	4d38                	lw	a4,88(a0)
ffffffffc02099dc:	6785                	lui	a5,0x1
ffffffffc02099de:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02099e2:	842a                	mv	s0,a0
ffffffffc02099e4:	10f71f63          	bne	a4,a5,ffffffffc0209b02 <sfs_reclaim+0x140>
ffffffffc02099e8:	8526                	mv	a0,s1
ffffffffc02099ea:	586010ef          	jal	ra,ffffffffc020af70 <lock_sfs_fs>
ffffffffc02099ee:	4c1c                	lw	a5,24(s0)
ffffffffc02099f0:	0ef05963          	blez	a5,ffffffffc0209ae2 <sfs_reclaim+0x120>
ffffffffc02099f4:	fff7871b          	addiw	a4,a5,-1
ffffffffc02099f8:	cc18                	sw	a4,24(s0)
ffffffffc02099fa:	eb59                	bnez	a4,ffffffffc0209a90 <sfs_reclaim+0xce>
ffffffffc02099fc:	05c42903          	lw	s2,92(s0)
ffffffffc0209a00:	08091863          	bnez	s2,ffffffffc0209a90 <sfs_reclaim+0xce>
ffffffffc0209a04:	601c                	ld	a5,0(s0)
ffffffffc0209a06:	0067d783          	lhu	a5,6(a5)
ffffffffc0209a0a:	e785                	bnez	a5,ffffffffc0209a32 <sfs_reclaim+0x70>
ffffffffc0209a0c:	783c                	ld	a5,112(s0)
ffffffffc0209a0e:	10078a63          	beqz	a5,ffffffffc0209b22 <sfs_reclaim+0x160>
ffffffffc0209a12:	73bc                	ld	a5,96(a5)
ffffffffc0209a14:	10078763          	beqz	a5,ffffffffc0209b22 <sfs_reclaim+0x160>
ffffffffc0209a18:	00005597          	auipc	a1,0x5
ffffffffc0209a1c:	e0858593          	addi	a1,a1,-504 # ffffffffc020e820 <syscalls+0xca0>
ffffffffc0209a20:	8522                	mv	a0,s0
ffffffffc0209a22:	e71fd0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0209a26:	783c                	ld	a5,112(s0)
ffffffffc0209a28:	4581                	li	a1,0
ffffffffc0209a2a:	8522                	mv	a0,s0
ffffffffc0209a2c:	73bc                	ld	a5,96(a5)
ffffffffc0209a2e:	9782                	jalr	a5
ffffffffc0209a30:	e559                	bnez	a0,ffffffffc0209abe <sfs_reclaim+0xfc>
ffffffffc0209a32:	681c                	ld	a5,16(s0)
ffffffffc0209a34:	c39d                	beqz	a5,ffffffffc0209a5a <sfs_reclaim+0x98>
ffffffffc0209a36:	783c                	ld	a5,112(s0)
ffffffffc0209a38:	10078563          	beqz	a5,ffffffffc0209b42 <sfs_reclaim+0x180>
ffffffffc0209a3c:	7b9c                	ld	a5,48(a5)
ffffffffc0209a3e:	10078263          	beqz	a5,ffffffffc0209b42 <sfs_reclaim+0x180>
ffffffffc0209a42:	8522                	mv	a0,s0
ffffffffc0209a44:	00004597          	auipc	a1,0x4
ffffffffc0209a48:	90c58593          	addi	a1,a1,-1780 # ffffffffc020d350 <default_pmm_manager+0xea0>
ffffffffc0209a4c:	e47fd0ef          	jal	ra,ffffffffc0207892 <inode_check>
ffffffffc0209a50:	783c                	ld	a5,112(s0)
ffffffffc0209a52:	8522                	mv	a0,s0
ffffffffc0209a54:	7b9c                	ld	a5,48(a5)
ffffffffc0209a56:	9782                	jalr	a5
ffffffffc0209a58:	e13d                	bnez	a0,ffffffffc0209abe <sfs_reclaim+0xfc>
ffffffffc0209a5a:	7c18                	ld	a4,56(s0)
ffffffffc0209a5c:	603c                	ld	a5,64(s0)
ffffffffc0209a5e:	8526                	mv	a0,s1
ffffffffc0209a60:	e71c                	sd	a5,8(a4)
ffffffffc0209a62:	e398                	sd	a4,0(a5)
ffffffffc0209a64:	6438                	ld	a4,72(s0)
ffffffffc0209a66:	683c                	ld	a5,80(s0)
ffffffffc0209a68:	e71c                	sd	a5,8(a4)
ffffffffc0209a6a:	e398                	sd	a4,0(a5)
ffffffffc0209a6c:	514010ef          	jal	ra,ffffffffc020af80 <unlock_sfs_fs>
ffffffffc0209a70:	6008                	ld	a0,0(s0)
ffffffffc0209a72:	00655783          	lhu	a5,6(a0)
ffffffffc0209a76:	cb85                	beqz	a5,ffffffffc0209aa6 <sfs_reclaim+0xe4>
ffffffffc0209a78:	e16f80ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc0209a7c:	8522                	mv	a0,s0
ffffffffc0209a7e:	da9fd0ef          	jal	ra,ffffffffc0207826 <inode_kill>
ffffffffc0209a82:	60e2                	ld	ra,24(sp)
ffffffffc0209a84:	6442                	ld	s0,16(sp)
ffffffffc0209a86:	64a2                	ld	s1,8(sp)
ffffffffc0209a88:	854a                	mv	a0,s2
ffffffffc0209a8a:	6902                	ld	s2,0(sp)
ffffffffc0209a8c:	6105                	addi	sp,sp,32
ffffffffc0209a8e:	8082                	ret
ffffffffc0209a90:	5945                	li	s2,-15
ffffffffc0209a92:	8526                	mv	a0,s1
ffffffffc0209a94:	4ec010ef          	jal	ra,ffffffffc020af80 <unlock_sfs_fs>
ffffffffc0209a98:	60e2                	ld	ra,24(sp)
ffffffffc0209a9a:	6442                	ld	s0,16(sp)
ffffffffc0209a9c:	64a2                	ld	s1,8(sp)
ffffffffc0209a9e:	854a                	mv	a0,s2
ffffffffc0209aa0:	6902                	ld	s2,0(sp)
ffffffffc0209aa2:	6105                	addi	sp,sp,32
ffffffffc0209aa4:	8082                	ret
ffffffffc0209aa6:	440c                	lw	a1,8(s0)
ffffffffc0209aa8:	8526                	mv	a0,s1
ffffffffc0209aaa:	ea7ff0ef          	jal	ra,ffffffffc0209950 <sfs_block_free>
ffffffffc0209aae:	6008                	ld	a0,0(s0)
ffffffffc0209ab0:	5d4c                	lw	a1,60(a0)
ffffffffc0209ab2:	d1f9                	beqz	a1,ffffffffc0209a78 <sfs_reclaim+0xb6>
ffffffffc0209ab4:	8526                	mv	a0,s1
ffffffffc0209ab6:	e9bff0ef          	jal	ra,ffffffffc0209950 <sfs_block_free>
ffffffffc0209aba:	6008                	ld	a0,0(s0)
ffffffffc0209abc:	bf75                	j	ffffffffc0209a78 <sfs_reclaim+0xb6>
ffffffffc0209abe:	892a                	mv	s2,a0
ffffffffc0209ac0:	bfc9                	j	ffffffffc0209a92 <sfs_reclaim+0xd0>
ffffffffc0209ac2:	00005697          	auipc	a3,0x5
ffffffffc0209ac6:	2d668693          	addi	a3,a3,726 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc0209aca:	00002617          	auipc	a2,0x2
ffffffffc0209ace:	ede60613          	addi	a2,a2,-290 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209ad2:	35700593          	li	a1,855
ffffffffc0209ad6:	00005517          	auipc	a0,0x5
ffffffffc0209ada:	4a250513          	addi	a0,a0,1186 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209ade:	9c1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209ae2:	00005697          	auipc	a3,0x5
ffffffffc0209ae6:	51e68693          	addi	a3,a3,1310 # ffffffffc020f000 <dev_node_ops+0x648>
ffffffffc0209aea:	00002617          	auipc	a2,0x2
ffffffffc0209aee:	ebe60613          	addi	a2,a2,-322 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209af2:	35d00593          	li	a1,861
ffffffffc0209af6:	00005517          	auipc	a0,0x5
ffffffffc0209afa:	48250513          	addi	a0,a0,1154 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209afe:	9a1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b02:	00005697          	auipc	a3,0x5
ffffffffc0209b06:	43e68693          	addi	a3,a3,1086 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc0209b0a:	00002617          	auipc	a2,0x2
ffffffffc0209b0e:	e9e60613          	addi	a2,a2,-354 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209b12:	35800593          	li	a1,856
ffffffffc0209b16:	00005517          	auipc	a0,0x5
ffffffffc0209b1a:	46250513          	addi	a0,a0,1122 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209b1e:	981f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b22:	00005697          	auipc	a3,0x5
ffffffffc0209b26:	ca668693          	addi	a3,a3,-858 # ffffffffc020e7c8 <syscalls+0xc48>
ffffffffc0209b2a:	00002617          	auipc	a2,0x2
ffffffffc0209b2e:	e7e60613          	addi	a2,a2,-386 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209b32:	36200593          	li	a1,866
ffffffffc0209b36:	00005517          	auipc	a0,0x5
ffffffffc0209b3a:	44250513          	addi	a0,a0,1090 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209b3e:	961f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b42:	00003697          	auipc	a3,0x3
ffffffffc0209b46:	7be68693          	addi	a3,a3,1982 # ffffffffc020d300 <default_pmm_manager+0xe50>
ffffffffc0209b4a:	00002617          	auipc	a2,0x2
ffffffffc0209b4e:	e5e60613          	addi	a2,a2,-418 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209b52:	36700593          	li	a1,871
ffffffffc0209b56:	00005517          	auipc	a0,0x5
ffffffffc0209b5a:	42250513          	addi	a0,a0,1058 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209b5e:	941f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b62 <sfs_block_alloc>:
ffffffffc0209b62:	1101                	addi	sp,sp,-32
ffffffffc0209b64:	e822                	sd	s0,16(sp)
ffffffffc0209b66:	842a                	mv	s0,a0
ffffffffc0209b68:	7d08                	ld	a0,56(a0)
ffffffffc0209b6a:	e426                	sd	s1,8(sp)
ffffffffc0209b6c:	ec06                	sd	ra,24(sp)
ffffffffc0209b6e:	84ae                	mv	s1,a1
ffffffffc0209b70:	c62ff0ef          	jal	ra,ffffffffc0208fd2 <bitmap_alloc>
ffffffffc0209b74:	e90d                	bnez	a0,ffffffffc0209ba6 <sfs_block_alloc+0x44>
ffffffffc0209b76:	441c                	lw	a5,8(s0)
ffffffffc0209b78:	cbad                	beqz	a5,ffffffffc0209bea <sfs_block_alloc+0x88>
ffffffffc0209b7a:	37fd                	addiw	a5,a5,-1
ffffffffc0209b7c:	c41c                	sw	a5,8(s0)
ffffffffc0209b7e:	408c                	lw	a1,0(s1)
ffffffffc0209b80:	4785                	li	a5,1
ffffffffc0209b82:	e03c                	sd	a5,64(s0)
ffffffffc0209b84:	4054                	lw	a3,4(s0)
ffffffffc0209b86:	c58d                	beqz	a1,ffffffffc0209bb0 <sfs_block_alloc+0x4e>
ffffffffc0209b88:	02d5f463          	bgeu	a1,a3,ffffffffc0209bb0 <sfs_block_alloc+0x4e>
ffffffffc0209b8c:	7c08                	ld	a0,56(s0)
ffffffffc0209b8e:	cb4ff0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc0209b92:	ed05                	bnez	a0,ffffffffc0209bca <sfs_block_alloc+0x68>
ffffffffc0209b94:	8522                	mv	a0,s0
ffffffffc0209b96:	6442                	ld	s0,16(sp)
ffffffffc0209b98:	408c                	lw	a1,0(s1)
ffffffffc0209b9a:	60e2                	ld	ra,24(sp)
ffffffffc0209b9c:	64a2                	ld	s1,8(sp)
ffffffffc0209b9e:	4605                	li	a2,1
ffffffffc0209ba0:	6105                	addi	sp,sp,32
ffffffffc0209ba2:	36e0106f          	j	ffffffffc020af10 <sfs_clear_block>
ffffffffc0209ba6:	60e2                	ld	ra,24(sp)
ffffffffc0209ba8:	6442                	ld	s0,16(sp)
ffffffffc0209baa:	64a2                	ld	s1,8(sp)
ffffffffc0209bac:	6105                	addi	sp,sp,32
ffffffffc0209bae:	8082                	ret
ffffffffc0209bb0:	872e                	mv	a4,a1
ffffffffc0209bb2:	00005617          	auipc	a2,0x5
ffffffffc0209bb6:	3f660613          	addi	a2,a2,1014 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc0209bba:	05300593          	li	a1,83
ffffffffc0209bbe:	00005517          	auipc	a0,0x5
ffffffffc0209bc2:	3ba50513          	addi	a0,a0,954 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209bc6:	8d9f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bca:	00005697          	auipc	a3,0x5
ffffffffc0209bce:	46e68693          	addi	a3,a3,1134 # ffffffffc020f038 <dev_node_ops+0x680>
ffffffffc0209bd2:	00002617          	auipc	a2,0x2
ffffffffc0209bd6:	dd660613          	addi	a2,a2,-554 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209bda:	06100593          	li	a1,97
ffffffffc0209bde:	00005517          	auipc	a0,0x5
ffffffffc0209be2:	39a50513          	addi	a0,a0,922 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209be6:	8b9f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bea:	00005697          	auipc	a3,0x5
ffffffffc0209bee:	42e68693          	addi	a3,a3,1070 # ffffffffc020f018 <dev_node_ops+0x660>
ffffffffc0209bf2:	00002617          	auipc	a2,0x2
ffffffffc0209bf6:	db660613          	addi	a2,a2,-586 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209bfa:	05f00593          	li	a1,95
ffffffffc0209bfe:	00005517          	auipc	a0,0x5
ffffffffc0209c02:	37a50513          	addi	a0,a0,890 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209c06:	899f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c0a <sfs_bmap_load_nolock>:
ffffffffc0209c0a:	7159                	addi	sp,sp,-112
ffffffffc0209c0c:	f85a                	sd	s6,48(sp)
ffffffffc0209c0e:	0005bb03          	ld	s6,0(a1)
ffffffffc0209c12:	f45e                	sd	s7,40(sp)
ffffffffc0209c14:	f486                	sd	ra,104(sp)
ffffffffc0209c16:	008b2b83          	lw	s7,8(s6)
ffffffffc0209c1a:	f0a2                	sd	s0,96(sp)
ffffffffc0209c1c:	eca6                	sd	s1,88(sp)
ffffffffc0209c1e:	e8ca                	sd	s2,80(sp)
ffffffffc0209c20:	e4ce                	sd	s3,72(sp)
ffffffffc0209c22:	e0d2                	sd	s4,64(sp)
ffffffffc0209c24:	fc56                	sd	s5,56(sp)
ffffffffc0209c26:	f062                	sd	s8,32(sp)
ffffffffc0209c28:	ec66                	sd	s9,24(sp)
ffffffffc0209c2a:	18cbe363          	bltu	s7,a2,ffffffffc0209db0 <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209c2e:	47ad                	li	a5,11
ffffffffc0209c30:	8aae                	mv	s5,a1
ffffffffc0209c32:	8432                	mv	s0,a2
ffffffffc0209c34:	84aa                	mv	s1,a0
ffffffffc0209c36:	89b6                	mv	s3,a3
ffffffffc0209c38:	04c7f563          	bgeu	a5,a2,ffffffffc0209c82 <sfs_bmap_load_nolock+0x78>
ffffffffc0209c3c:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209c40:	0007069b          	sext.w	a3,a4
ffffffffc0209c44:	3ff00793          	li	a5,1023
ffffffffc0209c48:	1ad7e163          	bltu	a5,a3,ffffffffc0209dea <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209c4c:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209c50:	02071793          	slli	a5,a4,0x20
ffffffffc0209c54:	c602                	sw	zero,12(sp)
ffffffffc0209c56:	c452                	sw	s4,8(sp)
ffffffffc0209c58:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209c5c:	0e0a1e63          	bnez	s4,ffffffffc0209d58 <sfs_bmap_load_nolock+0x14e>
ffffffffc0209c60:	0acb8663          	beq	s7,a2,ffffffffc0209d0c <sfs_bmap_load_nolock+0x102>
ffffffffc0209c64:	4a01                	li	s4,0
ffffffffc0209c66:	40d4                	lw	a3,4(s1)
ffffffffc0209c68:	8752                	mv	a4,s4
ffffffffc0209c6a:	00005617          	auipc	a2,0x5
ffffffffc0209c6e:	33e60613          	addi	a2,a2,830 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc0209c72:	05300593          	li	a1,83
ffffffffc0209c76:	00005517          	auipc	a0,0x5
ffffffffc0209c7a:	30250513          	addi	a0,a0,770 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209c7e:	821f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c82:	02061793          	slli	a5,a2,0x20
ffffffffc0209c86:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209c8a:	9a5a                	add	s4,s4,s6
ffffffffc0209c8c:	00ca2583          	lw	a1,12(s4)
ffffffffc0209c90:	c22e                	sw	a1,4(sp)
ffffffffc0209c92:	ed99                	bnez	a1,ffffffffc0209cb0 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209c94:	fccb98e3          	bne	s7,a2,ffffffffc0209c64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209c98:	004c                	addi	a1,sp,4
ffffffffc0209c9a:	ec9ff0ef          	jal	ra,ffffffffc0209b62 <sfs_block_alloc>
ffffffffc0209c9e:	892a                	mv	s2,a0
ffffffffc0209ca0:	e921                	bnez	a0,ffffffffc0209cf0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209ca2:	4592                	lw	a1,4(sp)
ffffffffc0209ca4:	4705                	li	a4,1
ffffffffc0209ca6:	00ba2623          	sw	a1,12(s4)
ffffffffc0209caa:	00eab823          	sd	a4,16(s5)
ffffffffc0209cae:	d9dd                	beqz	a1,ffffffffc0209c64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209cb0:	40d4                	lw	a3,4(s1)
ffffffffc0209cb2:	10d5ff63          	bgeu	a1,a3,ffffffffc0209dd0 <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209cb6:	7c88                	ld	a0,56(s1)
ffffffffc0209cb8:	b8aff0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc0209cbc:	18051363          	bnez	a0,ffffffffc0209e42 <sfs_bmap_load_nolock+0x238>
ffffffffc0209cc0:	4a12                	lw	s4,4(sp)
ffffffffc0209cc2:	fa0a02e3          	beqz	s4,ffffffffc0209c66 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209cc6:	40dc                	lw	a5,4(s1)
ffffffffc0209cc8:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209c66 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209ccc:	7c88                	ld	a0,56(s1)
ffffffffc0209cce:	85d2                	mv	a1,s4
ffffffffc0209cd0:	b72ff0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc0209cd4:	12051763          	bnez	a0,ffffffffc0209e02 <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209cd8:	008b9763          	bne	s7,s0,ffffffffc0209ce6 <sfs_bmap_load_nolock+0xdc>
ffffffffc0209cdc:	008b2783          	lw	a5,8(s6)
ffffffffc0209ce0:	2785                	addiw	a5,a5,1
ffffffffc0209ce2:	00fb2423          	sw	a5,8(s6)
ffffffffc0209ce6:	4901                	li	s2,0
ffffffffc0209ce8:	00098463          	beqz	s3,ffffffffc0209cf0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209cec:	0149a023          	sw	s4,0(s3)
ffffffffc0209cf0:	70a6                	ld	ra,104(sp)
ffffffffc0209cf2:	7406                	ld	s0,96(sp)
ffffffffc0209cf4:	64e6                	ld	s1,88(sp)
ffffffffc0209cf6:	69a6                	ld	s3,72(sp)
ffffffffc0209cf8:	6a06                	ld	s4,64(sp)
ffffffffc0209cfa:	7ae2                	ld	s5,56(sp)
ffffffffc0209cfc:	7b42                	ld	s6,48(sp)
ffffffffc0209cfe:	7ba2                	ld	s7,40(sp)
ffffffffc0209d00:	7c02                	ld	s8,32(sp)
ffffffffc0209d02:	6ce2                	ld	s9,24(sp)
ffffffffc0209d04:	854a                	mv	a0,s2
ffffffffc0209d06:	6946                	ld	s2,80(sp)
ffffffffc0209d08:	6165                	addi	sp,sp,112
ffffffffc0209d0a:	8082                	ret
ffffffffc0209d0c:	002c                	addi	a1,sp,8
ffffffffc0209d0e:	e55ff0ef          	jal	ra,ffffffffc0209b62 <sfs_block_alloc>
ffffffffc0209d12:	892a                	mv	s2,a0
ffffffffc0209d14:	00c10c93          	addi	s9,sp,12
ffffffffc0209d18:	fd61                	bnez	a0,ffffffffc0209cf0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209d1a:	85e6                	mv	a1,s9
ffffffffc0209d1c:	8526                	mv	a0,s1
ffffffffc0209d1e:	e45ff0ef          	jal	ra,ffffffffc0209b62 <sfs_block_alloc>
ffffffffc0209d22:	892a                	mv	s2,a0
ffffffffc0209d24:	e925                	bnez	a0,ffffffffc0209d94 <sfs_bmap_load_nolock+0x18a>
ffffffffc0209d26:	46a2                	lw	a3,8(sp)
ffffffffc0209d28:	85e6                	mv	a1,s9
ffffffffc0209d2a:	8762                	mv	a4,s8
ffffffffc0209d2c:	4611                	li	a2,4
ffffffffc0209d2e:	8526                	mv	a0,s1
ffffffffc0209d30:	090010ef          	jal	ra,ffffffffc020adc0 <sfs_wbuf>
ffffffffc0209d34:	45b2                	lw	a1,12(sp)
ffffffffc0209d36:	892a                	mv	s2,a0
ffffffffc0209d38:	e939                	bnez	a0,ffffffffc0209d8e <sfs_bmap_load_nolock+0x184>
ffffffffc0209d3a:	03cb2683          	lw	a3,60(s6)
ffffffffc0209d3e:	4722                	lw	a4,8(sp)
ffffffffc0209d40:	c22e                	sw	a1,4(sp)
ffffffffc0209d42:	f6d706e3          	beq	a4,a3,ffffffffc0209cae <sfs_bmap_load_nolock+0xa4>
ffffffffc0209d46:	eef1                	bnez	a3,ffffffffc0209e22 <sfs_bmap_load_nolock+0x218>
ffffffffc0209d48:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209d4c:	4705                	li	a4,1
ffffffffc0209d4e:	00eab823          	sd	a4,16(s5)
ffffffffc0209d52:	f00589e3          	beqz	a1,ffffffffc0209c64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209d56:	bfa9                	j	ffffffffc0209cb0 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209d58:	00c10c93          	addi	s9,sp,12
ffffffffc0209d5c:	8762                	mv	a4,s8
ffffffffc0209d5e:	86d2                	mv	a3,s4
ffffffffc0209d60:	4611                	li	a2,4
ffffffffc0209d62:	85e6                	mv	a1,s9
ffffffffc0209d64:	7dd000ef          	jal	ra,ffffffffc020ad40 <sfs_rbuf>
ffffffffc0209d68:	892a                	mv	s2,a0
ffffffffc0209d6a:	f159                	bnez	a0,ffffffffc0209cf0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209d6c:	45b2                	lw	a1,12(sp)
ffffffffc0209d6e:	e995                	bnez	a1,ffffffffc0209da2 <sfs_bmap_load_nolock+0x198>
ffffffffc0209d70:	fa8b85e3          	beq	s7,s0,ffffffffc0209d1a <sfs_bmap_load_nolock+0x110>
ffffffffc0209d74:	03cb2703          	lw	a4,60(s6)
ffffffffc0209d78:	47a2                	lw	a5,8(sp)
ffffffffc0209d7a:	c202                	sw	zero,4(sp)
ffffffffc0209d7c:	eee784e3          	beq	a5,a4,ffffffffc0209c64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209d80:	e34d                	bnez	a4,ffffffffc0209e22 <sfs_bmap_load_nolock+0x218>
ffffffffc0209d82:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209d86:	4785                	li	a5,1
ffffffffc0209d88:	00fab823          	sd	a5,16(s5)
ffffffffc0209d8c:	bde1                	j	ffffffffc0209c64 <sfs_bmap_load_nolock+0x5a>
ffffffffc0209d8e:	8526                	mv	a0,s1
ffffffffc0209d90:	bc1ff0ef          	jal	ra,ffffffffc0209950 <sfs_block_free>
ffffffffc0209d94:	45a2                	lw	a1,8(sp)
ffffffffc0209d96:	f4ba0de3          	beq	s4,a1,ffffffffc0209cf0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209d9a:	8526                	mv	a0,s1
ffffffffc0209d9c:	bb5ff0ef          	jal	ra,ffffffffc0209950 <sfs_block_free>
ffffffffc0209da0:	bf81                	j	ffffffffc0209cf0 <sfs_bmap_load_nolock+0xe6>
ffffffffc0209da2:	03cb2683          	lw	a3,60(s6)
ffffffffc0209da6:	4722                	lw	a4,8(sp)
ffffffffc0209da8:	c22e                	sw	a1,4(sp)
ffffffffc0209daa:	f8e69ee3          	bne	a3,a4,ffffffffc0209d46 <sfs_bmap_load_nolock+0x13c>
ffffffffc0209dae:	b709                	j	ffffffffc0209cb0 <sfs_bmap_load_nolock+0xa6>
ffffffffc0209db0:	00005697          	auipc	a3,0x5
ffffffffc0209db4:	2b068693          	addi	a3,a3,688 # ffffffffc020f060 <dev_node_ops+0x6a8>
ffffffffc0209db8:	00002617          	auipc	a2,0x2
ffffffffc0209dbc:	bf060613          	addi	a2,a2,-1040 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209dc0:	16400593          	li	a1,356
ffffffffc0209dc4:	00005517          	auipc	a0,0x5
ffffffffc0209dc8:	1b450513          	addi	a0,a0,436 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209dcc:	ed2f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209dd0:	872e                	mv	a4,a1
ffffffffc0209dd2:	00005617          	auipc	a2,0x5
ffffffffc0209dd6:	1d660613          	addi	a2,a2,470 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc0209dda:	05300593          	li	a1,83
ffffffffc0209dde:	00005517          	auipc	a0,0x5
ffffffffc0209de2:	19a50513          	addi	a0,a0,410 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209de6:	eb8f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209dea:	00005617          	auipc	a2,0x5
ffffffffc0209dee:	2a660613          	addi	a2,a2,678 # ffffffffc020f090 <dev_node_ops+0x6d8>
ffffffffc0209df2:	11e00593          	li	a1,286
ffffffffc0209df6:	00005517          	auipc	a0,0x5
ffffffffc0209dfa:	18250513          	addi	a0,a0,386 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209dfe:	ea0f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e02:	00005697          	auipc	a3,0x5
ffffffffc0209e06:	1de68693          	addi	a3,a3,478 # ffffffffc020efe0 <dev_node_ops+0x628>
ffffffffc0209e0a:	00002617          	auipc	a2,0x2
ffffffffc0209e0e:	b9e60613          	addi	a2,a2,-1122 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209e12:	16b00593          	li	a1,363
ffffffffc0209e16:	00005517          	auipc	a0,0x5
ffffffffc0209e1a:	16250513          	addi	a0,a0,354 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209e1e:	e80f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e22:	00005697          	auipc	a3,0x5
ffffffffc0209e26:	25668693          	addi	a3,a3,598 # ffffffffc020f078 <dev_node_ops+0x6c0>
ffffffffc0209e2a:	00002617          	auipc	a2,0x2
ffffffffc0209e2e:	b7e60613          	addi	a2,a2,-1154 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209e32:	11800593          	li	a1,280
ffffffffc0209e36:	00005517          	auipc	a0,0x5
ffffffffc0209e3a:	14250513          	addi	a0,a0,322 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209e3e:	e60f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e42:	00005697          	auipc	a3,0x5
ffffffffc0209e46:	27e68693          	addi	a3,a3,638 # ffffffffc020f0c0 <dev_node_ops+0x708>
ffffffffc0209e4a:	00002617          	auipc	a2,0x2
ffffffffc0209e4e:	b5e60613          	addi	a2,a2,-1186 # ffffffffc020b9a8 <commands+0x210>
ffffffffc0209e52:	12100593          	li	a1,289
ffffffffc0209e56:	00005517          	auipc	a0,0x5
ffffffffc0209e5a:	12250513          	addi	a0,a0,290 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc0209e5e:	e40f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209e62 <sfs_io_nolock>:
ffffffffc0209e62:	7175                	addi	sp,sp,-144
ffffffffc0209e64:	f0d2                	sd	s4,96(sp)
ffffffffc0209e66:	8a2e                	mv	s4,a1
ffffffffc0209e68:	618c                	ld	a1,0(a1)
ffffffffc0209e6a:	e506                	sd	ra,136(sp)
ffffffffc0209e6c:	e122                	sd	s0,128(sp)
ffffffffc0209e6e:	0045d883          	lhu	a7,4(a1)
ffffffffc0209e72:	fca6                	sd	s1,120(sp)
ffffffffc0209e74:	f8ca                	sd	s2,112(sp)
ffffffffc0209e76:	f4ce                	sd	s3,104(sp)
ffffffffc0209e78:	ecd6                	sd	s5,88(sp)
ffffffffc0209e7a:	e8da                	sd	s6,80(sp)
ffffffffc0209e7c:	e4de                	sd	s7,72(sp)
ffffffffc0209e7e:	e0e2                	sd	s8,64(sp)
ffffffffc0209e80:	fc66                	sd	s9,56(sp)
ffffffffc0209e82:	f86a                	sd	s10,48(sp)
ffffffffc0209e84:	f46e                	sd	s11,40(sp)
ffffffffc0209e86:	4809                	li	a6,2
ffffffffc0209e88:	19088763          	beq	a7,a6,ffffffffc020a016 <sfs_io_nolock+0x1b4>
ffffffffc0209e8c:	00073a83          	ld	s5,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc0209e90:	8c3a                	mv	s8,a4
ffffffffc0209e92:	000c3023          	sd	zero,0(s8)
ffffffffc0209e96:	08000737          	lui	a4,0x8000
ffffffffc0209e9a:	84b6                	mv	s1,a3
ffffffffc0209e9c:	8d36                	mv	s10,a3
ffffffffc0209e9e:	9ab6                	add	s5,s5,a3
ffffffffc0209ea0:	16e6f963          	bgeu	a3,a4,ffffffffc020a012 <sfs_io_nolock+0x1b0>
ffffffffc0209ea4:	16dac763          	blt	s5,a3,ffffffffc020a012 <sfs_io_nolock+0x1b0>
ffffffffc0209ea8:	892a                	mv	s2,a0
ffffffffc0209eaa:	4501                	li	a0,0
ffffffffc0209eac:	0d568163          	beq	a3,s5,ffffffffc0209f6e <sfs_io_nolock+0x10c>
ffffffffc0209eb0:	8432                	mv	s0,a2
ffffffffc0209eb2:	01577463          	bgeu	a4,s5,ffffffffc0209eba <sfs_io_nolock+0x58>
ffffffffc0209eb6:	08000ab7          	lui	s5,0x8000
ffffffffc0209eba:	cbe9                	beqz	a5,ffffffffc0209f8c <sfs_io_nolock+0x12a>
ffffffffc0209ebc:	00001797          	auipc	a5,0x1
ffffffffc0209ec0:	f0478793          	addi	a5,a5,-252 # ffffffffc020adc0 <sfs_wbuf>
ffffffffc0209ec4:	00001c97          	auipc	s9,0x1
ffffffffc0209ec8:	e1cc8c93          	addi	s9,s9,-484 # ffffffffc020ace0 <sfs_wblock>
ffffffffc0209ecc:	e03e                	sd	a5,0(sp)
ffffffffc0209ece:	6705                	lui	a4,0x1
ffffffffc0209ed0:	40c4dd93          	srai	s11,s1,0xc
ffffffffc0209ed4:	40cadb13          	srai	s6,s5,0xc
ffffffffc0209ed8:	fff70b93          	addi	s7,a4,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0209edc:	41bb07bb          	subw	a5,s6,s11
ffffffffc0209ee0:	0174fbb3          	and	s7,s1,s7
ffffffffc0209ee4:	8b3e                	mv	s6,a5
ffffffffc0209ee6:	2d81                	sext.w	s11,s11
ffffffffc0209ee8:	89de                	mv	s3,s7
ffffffffc0209eea:	020b8b63          	beqz	s7,ffffffffc0209f20 <sfs_io_nolock+0xbe>
ffffffffc0209eee:	409a89b3          	sub	s3,s5,s1
ffffffffc0209ef2:	efd5                	bnez	a5,ffffffffc0209fae <sfs_io_nolock+0x14c>
ffffffffc0209ef4:	0874                	addi	a3,sp,28
ffffffffc0209ef6:	866e                	mv	a2,s11
ffffffffc0209ef8:	85d2                	mv	a1,s4
ffffffffc0209efa:	854a                	mv	a0,s2
ffffffffc0209efc:	e43e                	sd	a5,8(sp)
ffffffffc0209efe:	d0dff0ef          	jal	ra,ffffffffc0209c0a <sfs_bmap_load_nolock>
ffffffffc0209f02:	e161                	bnez	a0,ffffffffc0209fc2 <sfs_io_nolock+0x160>
ffffffffc0209f04:	46f2                	lw	a3,28(sp)
ffffffffc0209f06:	6782                	ld	a5,0(sp)
ffffffffc0209f08:	875e                	mv	a4,s7
ffffffffc0209f0a:	864e                	mv	a2,s3
ffffffffc0209f0c:	85a2                	mv	a1,s0
ffffffffc0209f0e:	854a                	mv	a0,s2
ffffffffc0209f10:	9782                	jalr	a5
ffffffffc0209f12:	e945                	bnez	a0,ffffffffc0209fc2 <sfs_io_nolock+0x160>
ffffffffc0209f14:	67a2                	ld	a5,8(sp)
ffffffffc0209f16:	cf85                	beqz	a5,ffffffffc0209f4e <sfs_io_nolock+0xec>
ffffffffc0209f18:	944e                	add	s0,s0,s3
ffffffffc0209f1a:	2d85                	addiw	s11,s11,1
ffffffffc0209f1c:	fffb079b          	addiw	a5,s6,-1
ffffffffc0209f20:	cfd5                	beqz	a5,ffffffffc0209fdc <sfs_io_nolock+0x17a>
ffffffffc0209f22:	01b78bbb          	addw	s7,a5,s11
ffffffffc0209f26:	6b05                	lui	s6,0x1
ffffffffc0209f28:	a821                	j	ffffffffc0209f40 <sfs_io_nolock+0xde>
ffffffffc0209f2a:	4672                	lw	a2,28(sp)
ffffffffc0209f2c:	4685                	li	a3,1
ffffffffc0209f2e:	85a2                	mv	a1,s0
ffffffffc0209f30:	854a                	mv	a0,s2
ffffffffc0209f32:	9c82                	jalr	s9
ffffffffc0209f34:	ed09                	bnez	a0,ffffffffc0209f4e <sfs_io_nolock+0xec>
ffffffffc0209f36:	2d85                	addiw	s11,s11,1
ffffffffc0209f38:	99da                	add	s3,s3,s6
ffffffffc0209f3a:	945a                	add	s0,s0,s6
ffffffffc0209f3c:	0b7d8163          	beq	s11,s7,ffffffffc0209fde <sfs_io_nolock+0x17c>
ffffffffc0209f40:	0874                	addi	a3,sp,28
ffffffffc0209f42:	866e                	mv	a2,s11
ffffffffc0209f44:	85d2                	mv	a1,s4
ffffffffc0209f46:	854a                	mv	a0,s2
ffffffffc0209f48:	cc3ff0ef          	jal	ra,ffffffffc0209c0a <sfs_bmap_load_nolock>
ffffffffc0209f4c:	dd79                	beqz	a0,ffffffffc0209f2a <sfs_io_nolock+0xc8>
ffffffffc0209f4e:	01348d33          	add	s10,s1,s3
ffffffffc0209f52:	000a3783          	ld	a5,0(s4)
ffffffffc0209f56:	013c3023          	sd	s3,0(s8)
ffffffffc0209f5a:	0007e703          	lwu	a4,0(a5)
ffffffffc0209f5e:	01a77863          	bgeu	a4,s10,ffffffffc0209f6e <sfs_io_nolock+0x10c>
ffffffffc0209f62:	013484bb          	addw	s1,s1,s3
ffffffffc0209f66:	c384                	sw	s1,0(a5)
ffffffffc0209f68:	4785                	li	a5,1
ffffffffc0209f6a:	00fa3823          	sd	a5,16(s4)
ffffffffc0209f6e:	60aa                	ld	ra,136(sp)
ffffffffc0209f70:	640a                	ld	s0,128(sp)
ffffffffc0209f72:	74e6                	ld	s1,120(sp)
ffffffffc0209f74:	7946                	ld	s2,112(sp)
ffffffffc0209f76:	79a6                	ld	s3,104(sp)
ffffffffc0209f78:	7a06                	ld	s4,96(sp)
ffffffffc0209f7a:	6ae6                	ld	s5,88(sp)
ffffffffc0209f7c:	6b46                	ld	s6,80(sp)
ffffffffc0209f7e:	6ba6                	ld	s7,72(sp)
ffffffffc0209f80:	6c06                	ld	s8,64(sp)
ffffffffc0209f82:	7ce2                	ld	s9,56(sp)
ffffffffc0209f84:	7d42                	ld	s10,48(sp)
ffffffffc0209f86:	7da2                	ld	s11,40(sp)
ffffffffc0209f88:	6149                	addi	sp,sp,144
ffffffffc0209f8a:	8082                	ret
ffffffffc0209f8c:	0005e783          	lwu	a5,0(a1)
ffffffffc0209f90:	4501                	li	a0,0
ffffffffc0209f92:	fcf4dee3          	bge	s1,a5,ffffffffc0209f6e <sfs_io_nolock+0x10c>
ffffffffc0209f96:	0357c863          	blt	a5,s5,ffffffffc0209fc6 <sfs_io_nolock+0x164>
ffffffffc0209f9a:	00001797          	auipc	a5,0x1
ffffffffc0209f9e:	da678793          	addi	a5,a5,-602 # ffffffffc020ad40 <sfs_rbuf>
ffffffffc0209fa2:	00001c97          	auipc	s9,0x1
ffffffffc0209fa6:	cdec8c93          	addi	s9,s9,-802 # ffffffffc020ac80 <sfs_rblock>
ffffffffc0209faa:	e03e                	sd	a5,0(sp)
ffffffffc0209fac:	b70d                	j	ffffffffc0209ece <sfs_io_nolock+0x6c>
ffffffffc0209fae:	0874                	addi	a3,sp,28
ffffffffc0209fb0:	866e                	mv	a2,s11
ffffffffc0209fb2:	85d2                	mv	a1,s4
ffffffffc0209fb4:	854a                	mv	a0,s2
ffffffffc0209fb6:	417709b3          	sub	s3,a4,s7
ffffffffc0209fba:	e43e                	sd	a5,8(sp)
ffffffffc0209fbc:	c4fff0ef          	jal	ra,ffffffffc0209c0a <sfs_bmap_load_nolock>
ffffffffc0209fc0:	d131                	beqz	a0,ffffffffc0209f04 <sfs_io_nolock+0xa2>
ffffffffc0209fc2:	4981                	li	s3,0
ffffffffc0209fc4:	b779                	j	ffffffffc0209f52 <sfs_io_nolock+0xf0>
ffffffffc0209fc6:	8abe                	mv	s5,a5
ffffffffc0209fc8:	00001797          	auipc	a5,0x1
ffffffffc0209fcc:	d7878793          	addi	a5,a5,-648 # ffffffffc020ad40 <sfs_rbuf>
ffffffffc0209fd0:	00001c97          	auipc	s9,0x1
ffffffffc0209fd4:	cb0c8c93          	addi	s9,s9,-848 # ffffffffc020ac80 <sfs_rblock>
ffffffffc0209fd8:	e03e                	sd	a5,0(sp)
ffffffffc0209fda:	bdd5                	j	ffffffffc0209ece <sfs_io_nolock+0x6c>
ffffffffc0209fdc:	8bee                	mv	s7,s11
ffffffffc0209fde:	1ad2                	slli	s5,s5,0x34
ffffffffc0209fe0:	034adb13          	srli	s6,s5,0x34
ffffffffc0209fe4:	000a9663          	bnez	s5,ffffffffc0209ff0 <sfs_io_nolock+0x18e>
ffffffffc0209fe8:	01348d33          	add	s10,s1,s3
ffffffffc0209fec:	4501                	li	a0,0
ffffffffc0209fee:	b795                	j	ffffffffc0209f52 <sfs_io_nolock+0xf0>
ffffffffc0209ff0:	0874                	addi	a3,sp,28
ffffffffc0209ff2:	865e                	mv	a2,s7
ffffffffc0209ff4:	85d2                	mv	a1,s4
ffffffffc0209ff6:	854a                	mv	a0,s2
ffffffffc0209ff8:	c13ff0ef          	jal	ra,ffffffffc0209c0a <sfs_bmap_load_nolock>
ffffffffc0209ffc:	f929                	bnez	a0,ffffffffc0209f4e <sfs_io_nolock+0xec>
ffffffffc0209ffe:	46f2                	lw	a3,28(sp)
ffffffffc020a000:	6782                	ld	a5,0(sp)
ffffffffc020a002:	4701                	li	a4,0
ffffffffc020a004:	865a                	mv	a2,s6
ffffffffc020a006:	85a2                	mv	a1,s0
ffffffffc020a008:	854a                	mv	a0,s2
ffffffffc020a00a:	9782                	jalr	a5
ffffffffc020a00c:	f129                	bnez	a0,ffffffffc0209f4e <sfs_io_nolock+0xec>
ffffffffc020a00e:	99da                	add	s3,s3,s6
ffffffffc020a010:	bf3d                	j	ffffffffc0209f4e <sfs_io_nolock+0xec>
ffffffffc020a012:	5575                	li	a0,-3
ffffffffc020a014:	bfa9                	j	ffffffffc0209f6e <sfs_io_nolock+0x10c>
ffffffffc020a016:	00005697          	auipc	a3,0x5
ffffffffc020a01a:	0d268693          	addi	a3,a3,210 # ffffffffc020f0e8 <dev_node_ops+0x730>
ffffffffc020a01e:	00002617          	auipc	a2,0x2
ffffffffc020a022:	98a60613          	addi	a2,a2,-1654 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a026:	22b00593          	li	a1,555
ffffffffc020a02a:	00005517          	auipc	a0,0x5
ffffffffc020a02e:	f4e50513          	addi	a0,a0,-178 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a032:	c6cf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a036 <sfs_read>:
ffffffffc020a036:	7139                	addi	sp,sp,-64
ffffffffc020a038:	f04a                	sd	s2,32(sp)
ffffffffc020a03a:	06853903          	ld	s2,104(a0)
ffffffffc020a03e:	fc06                	sd	ra,56(sp)
ffffffffc020a040:	f822                	sd	s0,48(sp)
ffffffffc020a042:	f426                	sd	s1,40(sp)
ffffffffc020a044:	ec4e                	sd	s3,24(sp)
ffffffffc020a046:	04090f63          	beqz	s2,ffffffffc020a0a4 <sfs_read+0x6e>
ffffffffc020a04a:	0b092783          	lw	a5,176(s2)
ffffffffc020a04e:	ebb9                	bnez	a5,ffffffffc020a0a4 <sfs_read+0x6e>
ffffffffc020a050:	4d38                	lw	a4,88(a0)
ffffffffc020a052:	6785                	lui	a5,0x1
ffffffffc020a054:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a058:	842a                	mv	s0,a0
ffffffffc020a05a:	06f71563          	bne	a4,a5,ffffffffc020a0c4 <sfs_read+0x8e>
ffffffffc020a05e:	02050993          	addi	s3,a0,32
ffffffffc020a062:	854e                	mv	a0,s3
ffffffffc020a064:	84ae                	mv	s1,a1
ffffffffc020a066:	d4efa0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020a06a:	0184b803          	ld	a6,24(s1)
ffffffffc020a06e:	6494                	ld	a3,8(s1)
ffffffffc020a070:	6090                	ld	a2,0(s1)
ffffffffc020a072:	85a2                	mv	a1,s0
ffffffffc020a074:	4781                	li	a5,0
ffffffffc020a076:	0038                	addi	a4,sp,8
ffffffffc020a078:	854a                	mv	a0,s2
ffffffffc020a07a:	e442                	sd	a6,8(sp)
ffffffffc020a07c:	de7ff0ef          	jal	ra,ffffffffc0209e62 <sfs_io_nolock>
ffffffffc020a080:	65a2                	ld	a1,8(sp)
ffffffffc020a082:	842a                	mv	s0,a0
ffffffffc020a084:	ed81                	bnez	a1,ffffffffc020a09c <sfs_read+0x66>
ffffffffc020a086:	854e                	mv	a0,s3
ffffffffc020a088:	d28fa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a08c:	70e2                	ld	ra,56(sp)
ffffffffc020a08e:	8522                	mv	a0,s0
ffffffffc020a090:	7442                	ld	s0,48(sp)
ffffffffc020a092:	74a2                	ld	s1,40(sp)
ffffffffc020a094:	7902                	ld	s2,32(sp)
ffffffffc020a096:	69e2                	ld	s3,24(sp)
ffffffffc020a098:	6121                	addi	sp,sp,64
ffffffffc020a09a:	8082                	ret
ffffffffc020a09c:	8526                	mv	a0,s1
ffffffffc020a09e:	c0afb0ef          	jal	ra,ffffffffc02054a8 <iobuf_skip>
ffffffffc020a0a2:	b7d5                	j	ffffffffc020a086 <sfs_read+0x50>
ffffffffc020a0a4:	00005697          	auipc	a3,0x5
ffffffffc020a0a8:	cf468693          	addi	a3,a3,-780 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020a0ac:	00002617          	auipc	a2,0x2
ffffffffc020a0b0:	8fc60613          	addi	a2,a2,-1796 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a0b4:	29500593          	li	a1,661
ffffffffc020a0b8:	00005517          	auipc	a0,0x5
ffffffffc020a0bc:	ec050513          	addi	a0,a0,-320 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a0c0:	bdef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a0c4:	869ff0ef          	jal	ra,ffffffffc020992c <sfs_io.part.0>

ffffffffc020a0c8 <sfs_write>:
ffffffffc020a0c8:	7139                	addi	sp,sp,-64
ffffffffc020a0ca:	f04a                	sd	s2,32(sp)
ffffffffc020a0cc:	06853903          	ld	s2,104(a0)
ffffffffc020a0d0:	fc06                	sd	ra,56(sp)
ffffffffc020a0d2:	f822                	sd	s0,48(sp)
ffffffffc020a0d4:	f426                	sd	s1,40(sp)
ffffffffc020a0d6:	ec4e                	sd	s3,24(sp)
ffffffffc020a0d8:	04090f63          	beqz	s2,ffffffffc020a136 <sfs_write+0x6e>
ffffffffc020a0dc:	0b092783          	lw	a5,176(s2)
ffffffffc020a0e0:	ebb9                	bnez	a5,ffffffffc020a136 <sfs_write+0x6e>
ffffffffc020a0e2:	4d38                	lw	a4,88(a0)
ffffffffc020a0e4:	6785                	lui	a5,0x1
ffffffffc020a0e6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a0ea:	842a                	mv	s0,a0
ffffffffc020a0ec:	06f71563          	bne	a4,a5,ffffffffc020a156 <sfs_write+0x8e>
ffffffffc020a0f0:	02050993          	addi	s3,a0,32
ffffffffc020a0f4:	854e                	mv	a0,s3
ffffffffc020a0f6:	84ae                	mv	s1,a1
ffffffffc020a0f8:	cbcfa0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020a0fc:	0184b803          	ld	a6,24(s1)
ffffffffc020a100:	6494                	ld	a3,8(s1)
ffffffffc020a102:	6090                	ld	a2,0(s1)
ffffffffc020a104:	85a2                	mv	a1,s0
ffffffffc020a106:	4785                	li	a5,1
ffffffffc020a108:	0038                	addi	a4,sp,8
ffffffffc020a10a:	854a                	mv	a0,s2
ffffffffc020a10c:	e442                	sd	a6,8(sp)
ffffffffc020a10e:	d55ff0ef          	jal	ra,ffffffffc0209e62 <sfs_io_nolock>
ffffffffc020a112:	65a2                	ld	a1,8(sp)
ffffffffc020a114:	842a                	mv	s0,a0
ffffffffc020a116:	ed81                	bnez	a1,ffffffffc020a12e <sfs_write+0x66>
ffffffffc020a118:	854e                	mv	a0,s3
ffffffffc020a11a:	c96fa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a11e:	70e2                	ld	ra,56(sp)
ffffffffc020a120:	8522                	mv	a0,s0
ffffffffc020a122:	7442                	ld	s0,48(sp)
ffffffffc020a124:	74a2                	ld	s1,40(sp)
ffffffffc020a126:	7902                	ld	s2,32(sp)
ffffffffc020a128:	69e2                	ld	s3,24(sp)
ffffffffc020a12a:	6121                	addi	sp,sp,64
ffffffffc020a12c:	8082                	ret
ffffffffc020a12e:	8526                	mv	a0,s1
ffffffffc020a130:	b78fb0ef          	jal	ra,ffffffffc02054a8 <iobuf_skip>
ffffffffc020a134:	b7d5                	j	ffffffffc020a118 <sfs_write+0x50>
ffffffffc020a136:	00005697          	auipc	a3,0x5
ffffffffc020a13a:	c6268693          	addi	a3,a3,-926 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020a13e:	00002617          	auipc	a2,0x2
ffffffffc020a142:	86a60613          	addi	a2,a2,-1942 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a146:	29500593          	li	a1,661
ffffffffc020a14a:	00005517          	auipc	a0,0x5
ffffffffc020a14e:	e2e50513          	addi	a0,a0,-466 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a152:	b4cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a156:	fd6ff0ef          	jal	ra,ffffffffc020992c <sfs_io.part.0>

ffffffffc020a15a <sfs_dirent_read_nolock>:
ffffffffc020a15a:	6198                	ld	a4,0(a1)
ffffffffc020a15c:	7179                	addi	sp,sp,-48
ffffffffc020a15e:	f406                	sd	ra,40(sp)
ffffffffc020a160:	00475883          	lhu	a7,4(a4)
ffffffffc020a164:	f022                	sd	s0,32(sp)
ffffffffc020a166:	ec26                	sd	s1,24(sp)
ffffffffc020a168:	4809                	li	a6,2
ffffffffc020a16a:	05089b63          	bne	a7,a6,ffffffffc020a1c0 <sfs_dirent_read_nolock+0x66>
ffffffffc020a16e:	4718                	lw	a4,8(a4)
ffffffffc020a170:	87b2                	mv	a5,a2
ffffffffc020a172:	2601                	sext.w	a2,a2
ffffffffc020a174:	04e7f663          	bgeu	a5,a4,ffffffffc020a1c0 <sfs_dirent_read_nolock+0x66>
ffffffffc020a178:	84b6                	mv	s1,a3
ffffffffc020a17a:	0074                	addi	a3,sp,12
ffffffffc020a17c:	842a                	mv	s0,a0
ffffffffc020a17e:	a8dff0ef          	jal	ra,ffffffffc0209c0a <sfs_bmap_load_nolock>
ffffffffc020a182:	c511                	beqz	a0,ffffffffc020a18e <sfs_dirent_read_nolock+0x34>
ffffffffc020a184:	70a2                	ld	ra,40(sp)
ffffffffc020a186:	7402                	ld	s0,32(sp)
ffffffffc020a188:	64e2                	ld	s1,24(sp)
ffffffffc020a18a:	6145                	addi	sp,sp,48
ffffffffc020a18c:	8082                	ret
ffffffffc020a18e:	45b2                	lw	a1,12(sp)
ffffffffc020a190:	4054                	lw	a3,4(s0)
ffffffffc020a192:	c5b9                	beqz	a1,ffffffffc020a1e0 <sfs_dirent_read_nolock+0x86>
ffffffffc020a194:	04d5f663          	bgeu	a1,a3,ffffffffc020a1e0 <sfs_dirent_read_nolock+0x86>
ffffffffc020a198:	7c08                	ld	a0,56(s0)
ffffffffc020a19a:	ea9fe0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc020a19e:	ed31                	bnez	a0,ffffffffc020a1fa <sfs_dirent_read_nolock+0xa0>
ffffffffc020a1a0:	46b2                	lw	a3,12(sp)
ffffffffc020a1a2:	4701                	li	a4,0
ffffffffc020a1a4:	10400613          	li	a2,260
ffffffffc020a1a8:	85a6                	mv	a1,s1
ffffffffc020a1aa:	8522                	mv	a0,s0
ffffffffc020a1ac:	395000ef          	jal	ra,ffffffffc020ad40 <sfs_rbuf>
ffffffffc020a1b0:	f971                	bnez	a0,ffffffffc020a184 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a1b2:	100481a3          	sb	zero,259(s1)
ffffffffc020a1b6:	70a2                	ld	ra,40(sp)
ffffffffc020a1b8:	7402                	ld	s0,32(sp)
ffffffffc020a1ba:	64e2                	ld	s1,24(sp)
ffffffffc020a1bc:	6145                	addi	sp,sp,48
ffffffffc020a1be:	8082                	ret
ffffffffc020a1c0:	00005697          	auipc	a3,0x5
ffffffffc020a1c4:	f4868693          	addi	a3,a3,-184 # ffffffffc020f108 <dev_node_ops+0x750>
ffffffffc020a1c8:	00001617          	auipc	a2,0x1
ffffffffc020a1cc:	7e060613          	addi	a2,a2,2016 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a1d0:	18e00593          	li	a1,398
ffffffffc020a1d4:	00005517          	auipc	a0,0x5
ffffffffc020a1d8:	da450513          	addi	a0,a0,-604 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a1dc:	ac2f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a1e0:	872e                	mv	a4,a1
ffffffffc020a1e2:	00005617          	auipc	a2,0x5
ffffffffc020a1e6:	dc660613          	addi	a2,a2,-570 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc020a1ea:	05300593          	li	a1,83
ffffffffc020a1ee:	00005517          	auipc	a0,0x5
ffffffffc020a1f2:	d8a50513          	addi	a0,a0,-630 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a1f6:	aa8f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a1fa:	00005697          	auipc	a3,0x5
ffffffffc020a1fe:	de668693          	addi	a3,a3,-538 # ffffffffc020efe0 <dev_node_ops+0x628>
ffffffffc020a202:	00001617          	auipc	a2,0x1
ffffffffc020a206:	7a660613          	addi	a2,a2,1958 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a20a:	19500593          	li	a1,405
ffffffffc020a20e:	00005517          	auipc	a0,0x5
ffffffffc020a212:	d6a50513          	addi	a0,a0,-662 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a216:	a88f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a21a <sfs_getdirentry>:
ffffffffc020a21a:	715d                	addi	sp,sp,-80
ffffffffc020a21c:	ec56                	sd	s5,24(sp)
ffffffffc020a21e:	8aaa                	mv	s5,a0
ffffffffc020a220:	10400513          	li	a0,260
ffffffffc020a224:	e85a                	sd	s6,16(sp)
ffffffffc020a226:	e486                	sd	ra,72(sp)
ffffffffc020a228:	e0a2                	sd	s0,64(sp)
ffffffffc020a22a:	fc26                	sd	s1,56(sp)
ffffffffc020a22c:	f84a                	sd	s2,48(sp)
ffffffffc020a22e:	f44e                	sd	s3,40(sp)
ffffffffc020a230:	f052                	sd	s4,32(sp)
ffffffffc020a232:	e45e                	sd	s7,8(sp)
ffffffffc020a234:	e062                	sd	s8,0(sp)
ffffffffc020a236:	8b2e                	mv	s6,a1
ffffffffc020a238:	da7f70ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020a23c:	cd61                	beqz	a0,ffffffffc020a314 <sfs_getdirentry+0xfa>
ffffffffc020a23e:	068abb83          	ld	s7,104(s5) # 8000068 <_binary_bin_sfs_img_size+0x7f8ad68>
ffffffffc020a242:	0c0b8b63          	beqz	s7,ffffffffc020a318 <sfs_getdirentry+0xfe>
ffffffffc020a246:	0b0ba783          	lw	a5,176(s7) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a24a:	e7f9                	bnez	a5,ffffffffc020a318 <sfs_getdirentry+0xfe>
ffffffffc020a24c:	058aa703          	lw	a4,88(s5)
ffffffffc020a250:	6785                	lui	a5,0x1
ffffffffc020a252:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a256:	0ef71163          	bne	a4,a5,ffffffffc020a338 <sfs_getdirentry+0x11e>
ffffffffc020a25a:	008b3983          	ld	s3,8(s6) # 1008 <_binary_bin_swap_img_size-0x6cf8>
ffffffffc020a25e:	892a                	mv	s2,a0
ffffffffc020a260:	0a09c163          	bltz	s3,ffffffffc020a302 <sfs_getdirentry+0xe8>
ffffffffc020a264:	0ff9f793          	zext.b	a5,s3
ffffffffc020a268:	efc9                	bnez	a5,ffffffffc020a302 <sfs_getdirentry+0xe8>
ffffffffc020a26a:	000ab783          	ld	a5,0(s5)
ffffffffc020a26e:	0089d993          	srli	s3,s3,0x8
ffffffffc020a272:	2981                	sext.w	s3,s3
ffffffffc020a274:	479c                	lw	a5,8(a5)
ffffffffc020a276:	0937eb63          	bltu	a5,s3,ffffffffc020a30c <sfs_getdirentry+0xf2>
ffffffffc020a27a:	020a8c13          	addi	s8,s5,32
ffffffffc020a27e:	8562                	mv	a0,s8
ffffffffc020a280:	b34fa0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020a284:	000ab783          	ld	a5,0(s5)
ffffffffc020a288:	0087aa03          	lw	s4,8(a5)
ffffffffc020a28c:	07405663          	blez	s4,ffffffffc020a2f8 <sfs_getdirentry+0xde>
ffffffffc020a290:	4481                	li	s1,0
ffffffffc020a292:	a811                	j	ffffffffc020a2a6 <sfs_getdirentry+0x8c>
ffffffffc020a294:	00092783          	lw	a5,0(s2)
ffffffffc020a298:	c781                	beqz	a5,ffffffffc020a2a0 <sfs_getdirentry+0x86>
ffffffffc020a29a:	02098263          	beqz	s3,ffffffffc020a2be <sfs_getdirentry+0xa4>
ffffffffc020a29e:	39fd                	addiw	s3,s3,-1
ffffffffc020a2a0:	2485                	addiw	s1,s1,1
ffffffffc020a2a2:	049a0b63          	beq	s4,s1,ffffffffc020a2f8 <sfs_getdirentry+0xde>
ffffffffc020a2a6:	86ca                	mv	a3,s2
ffffffffc020a2a8:	8626                	mv	a2,s1
ffffffffc020a2aa:	85d6                	mv	a1,s5
ffffffffc020a2ac:	855e                	mv	a0,s7
ffffffffc020a2ae:	eadff0ef          	jal	ra,ffffffffc020a15a <sfs_dirent_read_nolock>
ffffffffc020a2b2:	842a                	mv	s0,a0
ffffffffc020a2b4:	d165                	beqz	a0,ffffffffc020a294 <sfs_getdirentry+0x7a>
ffffffffc020a2b6:	8562                	mv	a0,s8
ffffffffc020a2b8:	af8fa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a2bc:	a831                	j	ffffffffc020a2d8 <sfs_getdirentry+0xbe>
ffffffffc020a2be:	8562                	mv	a0,s8
ffffffffc020a2c0:	af0fa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a2c4:	4701                	li	a4,0
ffffffffc020a2c6:	4685                	li	a3,1
ffffffffc020a2c8:	10000613          	li	a2,256
ffffffffc020a2cc:	00490593          	addi	a1,s2,4
ffffffffc020a2d0:	855a                	mv	a0,s6
ffffffffc020a2d2:	96afb0ef          	jal	ra,ffffffffc020543c <iobuf_move>
ffffffffc020a2d6:	842a                	mv	s0,a0
ffffffffc020a2d8:	854a                	mv	a0,s2
ffffffffc020a2da:	db5f70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020a2de:	60a6                	ld	ra,72(sp)
ffffffffc020a2e0:	8522                	mv	a0,s0
ffffffffc020a2e2:	6406                	ld	s0,64(sp)
ffffffffc020a2e4:	74e2                	ld	s1,56(sp)
ffffffffc020a2e6:	7942                	ld	s2,48(sp)
ffffffffc020a2e8:	79a2                	ld	s3,40(sp)
ffffffffc020a2ea:	7a02                	ld	s4,32(sp)
ffffffffc020a2ec:	6ae2                	ld	s5,24(sp)
ffffffffc020a2ee:	6b42                	ld	s6,16(sp)
ffffffffc020a2f0:	6ba2                	ld	s7,8(sp)
ffffffffc020a2f2:	6c02                	ld	s8,0(sp)
ffffffffc020a2f4:	6161                	addi	sp,sp,80
ffffffffc020a2f6:	8082                	ret
ffffffffc020a2f8:	8562                	mv	a0,s8
ffffffffc020a2fa:	5441                	li	s0,-16
ffffffffc020a2fc:	ab4fa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a300:	bfe1                	j	ffffffffc020a2d8 <sfs_getdirentry+0xbe>
ffffffffc020a302:	854a                	mv	a0,s2
ffffffffc020a304:	d8bf70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020a308:	5475                	li	s0,-3
ffffffffc020a30a:	bfd1                	j	ffffffffc020a2de <sfs_getdirentry+0xc4>
ffffffffc020a30c:	d83f70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020a310:	5441                	li	s0,-16
ffffffffc020a312:	b7f1                	j	ffffffffc020a2de <sfs_getdirentry+0xc4>
ffffffffc020a314:	5471                	li	s0,-4
ffffffffc020a316:	b7e1                	j	ffffffffc020a2de <sfs_getdirentry+0xc4>
ffffffffc020a318:	00005697          	auipc	a3,0x5
ffffffffc020a31c:	a8068693          	addi	a3,a3,-1408 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020a320:	00001617          	auipc	a2,0x1
ffffffffc020a324:	68860613          	addi	a2,a2,1672 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a328:	33900593          	li	a1,825
ffffffffc020a32c:	00005517          	auipc	a0,0x5
ffffffffc020a330:	c4c50513          	addi	a0,a0,-948 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a334:	96af60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a338:	00005697          	auipc	a3,0x5
ffffffffc020a33c:	c0868693          	addi	a3,a3,-1016 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020a340:	00001617          	auipc	a2,0x1
ffffffffc020a344:	66860613          	addi	a2,a2,1640 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a348:	33a00593          	li	a1,826
ffffffffc020a34c:	00005517          	auipc	a0,0x5
ffffffffc020a350:	c2c50513          	addi	a0,a0,-980 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a354:	94af60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a358 <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a358:	715d                	addi	sp,sp,-80
ffffffffc020a35a:	f052                	sd	s4,32(sp)
ffffffffc020a35c:	8a2a                	mv	s4,a0
ffffffffc020a35e:	8532                	mv	a0,a2
ffffffffc020a360:	f44e                	sd	s3,40(sp)
ffffffffc020a362:	e85a                	sd	s6,16(sp)
ffffffffc020a364:	e45e                	sd	s7,8(sp)
ffffffffc020a366:	e486                	sd	ra,72(sp)
ffffffffc020a368:	e0a2                	sd	s0,64(sp)
ffffffffc020a36a:	fc26                	sd	s1,56(sp)
ffffffffc020a36c:	f84a                	sd	s2,48(sp)
ffffffffc020a36e:	ec56                	sd	s5,24(sp)
ffffffffc020a370:	e062                	sd	s8,0(sp)
ffffffffc020a372:	8b32                	mv	s6,a2
ffffffffc020a374:	89ae                	mv	s3,a1
ffffffffc020a376:	8bb6                	mv	s7,a3
ffffffffc020a378:	0aa010ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc020a37c:	0ff00793          	li	a5,255
ffffffffc020a380:	06a7ef63          	bltu	a5,a0,ffffffffc020a3fe <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a384:	10400513          	li	a0,260
ffffffffc020a388:	c57f70ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020a38c:	892a                	mv	s2,a0
ffffffffc020a38e:	c535                	beqz	a0,ffffffffc020a3fa <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a390:	0009b783          	ld	a5,0(s3)
ffffffffc020a394:	0087aa83          	lw	s5,8(a5)
ffffffffc020a398:	05505a63          	blez	s5,ffffffffc020a3ec <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a39c:	4481                	li	s1,0
ffffffffc020a39e:	00450c13          	addi	s8,a0,4
ffffffffc020a3a2:	a829                	j	ffffffffc020a3bc <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a3a4:	00092783          	lw	a5,0(s2)
ffffffffc020a3a8:	c799                	beqz	a5,ffffffffc020a3b6 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a3aa:	85e2                	mv	a1,s8
ffffffffc020a3ac:	855a                	mv	a0,s6
ffffffffc020a3ae:	0bc010ef          	jal	ra,ffffffffc020b46a <strcmp>
ffffffffc020a3b2:	842a                	mv	s0,a0
ffffffffc020a3b4:	cd15                	beqz	a0,ffffffffc020a3f0 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a3b6:	2485                	addiw	s1,s1,1
ffffffffc020a3b8:	029a8a63          	beq	s5,s1,ffffffffc020a3ec <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a3bc:	86ca                	mv	a3,s2
ffffffffc020a3be:	8626                	mv	a2,s1
ffffffffc020a3c0:	85ce                	mv	a1,s3
ffffffffc020a3c2:	8552                	mv	a0,s4
ffffffffc020a3c4:	d97ff0ef          	jal	ra,ffffffffc020a15a <sfs_dirent_read_nolock>
ffffffffc020a3c8:	842a                	mv	s0,a0
ffffffffc020a3ca:	dd69                	beqz	a0,ffffffffc020a3a4 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a3cc:	854a                	mv	a0,s2
ffffffffc020a3ce:	cc1f70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020a3d2:	60a6                	ld	ra,72(sp)
ffffffffc020a3d4:	8522                	mv	a0,s0
ffffffffc020a3d6:	6406                	ld	s0,64(sp)
ffffffffc020a3d8:	74e2                	ld	s1,56(sp)
ffffffffc020a3da:	7942                	ld	s2,48(sp)
ffffffffc020a3dc:	79a2                	ld	s3,40(sp)
ffffffffc020a3de:	7a02                	ld	s4,32(sp)
ffffffffc020a3e0:	6ae2                	ld	s5,24(sp)
ffffffffc020a3e2:	6b42                	ld	s6,16(sp)
ffffffffc020a3e4:	6ba2                	ld	s7,8(sp)
ffffffffc020a3e6:	6c02                	ld	s8,0(sp)
ffffffffc020a3e8:	6161                	addi	sp,sp,80
ffffffffc020a3ea:	8082                	ret
ffffffffc020a3ec:	5441                	li	s0,-16
ffffffffc020a3ee:	bff9                	j	ffffffffc020a3cc <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a3f0:	00092783          	lw	a5,0(s2)
ffffffffc020a3f4:	00fba023          	sw	a5,0(s7)
ffffffffc020a3f8:	bfd1                	j	ffffffffc020a3cc <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a3fa:	5471                	li	s0,-4
ffffffffc020a3fc:	bfd9                	j	ffffffffc020a3d2 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a3fe:	00005697          	auipc	a3,0x5
ffffffffc020a402:	d5a68693          	addi	a3,a3,-678 # ffffffffc020f158 <dev_node_ops+0x7a0>
ffffffffc020a406:	00001617          	auipc	a2,0x1
ffffffffc020a40a:	5a260613          	addi	a2,a2,1442 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a40e:	1ba00593          	li	a1,442
ffffffffc020a412:	00005517          	auipc	a0,0x5
ffffffffc020a416:	b6650513          	addi	a0,a0,-1178 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a41a:	884f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a41e <sfs_truncfile>:
ffffffffc020a41e:	7175                	addi	sp,sp,-144
ffffffffc020a420:	e506                	sd	ra,136(sp)
ffffffffc020a422:	e122                	sd	s0,128(sp)
ffffffffc020a424:	fca6                	sd	s1,120(sp)
ffffffffc020a426:	f8ca                	sd	s2,112(sp)
ffffffffc020a428:	f4ce                	sd	s3,104(sp)
ffffffffc020a42a:	f0d2                	sd	s4,96(sp)
ffffffffc020a42c:	ecd6                	sd	s5,88(sp)
ffffffffc020a42e:	e8da                	sd	s6,80(sp)
ffffffffc020a430:	e4de                	sd	s7,72(sp)
ffffffffc020a432:	e0e2                	sd	s8,64(sp)
ffffffffc020a434:	fc66                	sd	s9,56(sp)
ffffffffc020a436:	f86a                	sd	s10,48(sp)
ffffffffc020a438:	f46e                	sd	s11,40(sp)
ffffffffc020a43a:	080007b7          	lui	a5,0x8000
ffffffffc020a43e:	16b7e463          	bltu	a5,a1,ffffffffc020a5a6 <sfs_truncfile+0x188>
ffffffffc020a442:	06853c83          	ld	s9,104(a0)
ffffffffc020a446:	89aa                	mv	s3,a0
ffffffffc020a448:	160c8163          	beqz	s9,ffffffffc020a5aa <sfs_truncfile+0x18c>
ffffffffc020a44c:	0b0ca783          	lw	a5,176(s9)
ffffffffc020a450:	14079d63          	bnez	a5,ffffffffc020a5aa <sfs_truncfile+0x18c>
ffffffffc020a454:	4d38                	lw	a4,88(a0)
ffffffffc020a456:	6405                	lui	s0,0x1
ffffffffc020a458:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a45c:	16f71763          	bne	a4,a5,ffffffffc020a5ca <sfs_truncfile+0x1ac>
ffffffffc020a460:	00053a83          	ld	s5,0(a0)
ffffffffc020a464:	147d                	addi	s0,s0,-1
ffffffffc020a466:	942e                	add	s0,s0,a1
ffffffffc020a468:	000ae783          	lwu	a5,0(s5)
ffffffffc020a46c:	8031                	srli	s0,s0,0xc
ffffffffc020a46e:	8a2e                	mv	s4,a1
ffffffffc020a470:	2401                	sext.w	s0,s0
ffffffffc020a472:	02b79763          	bne	a5,a1,ffffffffc020a4a0 <sfs_truncfile+0x82>
ffffffffc020a476:	008aa783          	lw	a5,8(s5)
ffffffffc020a47a:	4901                	li	s2,0
ffffffffc020a47c:	18879763          	bne	a5,s0,ffffffffc020a60a <sfs_truncfile+0x1ec>
ffffffffc020a480:	60aa                	ld	ra,136(sp)
ffffffffc020a482:	640a                	ld	s0,128(sp)
ffffffffc020a484:	74e6                	ld	s1,120(sp)
ffffffffc020a486:	79a6                	ld	s3,104(sp)
ffffffffc020a488:	7a06                	ld	s4,96(sp)
ffffffffc020a48a:	6ae6                	ld	s5,88(sp)
ffffffffc020a48c:	6b46                	ld	s6,80(sp)
ffffffffc020a48e:	6ba6                	ld	s7,72(sp)
ffffffffc020a490:	6c06                	ld	s8,64(sp)
ffffffffc020a492:	7ce2                	ld	s9,56(sp)
ffffffffc020a494:	7d42                	ld	s10,48(sp)
ffffffffc020a496:	7da2                	ld	s11,40(sp)
ffffffffc020a498:	854a                	mv	a0,s2
ffffffffc020a49a:	7946                	ld	s2,112(sp)
ffffffffc020a49c:	6149                	addi	sp,sp,144
ffffffffc020a49e:	8082                	ret
ffffffffc020a4a0:	02050b13          	addi	s6,a0,32
ffffffffc020a4a4:	855a                	mv	a0,s6
ffffffffc020a4a6:	90efa0ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020a4aa:	008aa483          	lw	s1,8(s5)
ffffffffc020a4ae:	0a84e663          	bltu	s1,s0,ffffffffc020a55a <sfs_truncfile+0x13c>
ffffffffc020a4b2:	0c947163          	bgeu	s0,s1,ffffffffc020a574 <sfs_truncfile+0x156>
ffffffffc020a4b6:	4dad                	li	s11,11
ffffffffc020a4b8:	4b85                	li	s7,1
ffffffffc020a4ba:	a09d                	j	ffffffffc020a520 <sfs_truncfile+0x102>
ffffffffc020a4bc:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a4c0:	0009079b          	sext.w	a5,s2
ffffffffc020a4c4:	3ff00713          	li	a4,1023
ffffffffc020a4c8:	04f76563          	bltu	a4,a5,ffffffffc020a512 <sfs_truncfile+0xf4>
ffffffffc020a4cc:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a4d0:	040c0163          	beqz	s8,ffffffffc020a512 <sfs_truncfile+0xf4>
ffffffffc020a4d4:	004ca783          	lw	a5,4(s9)
ffffffffc020a4d8:	18fc7963          	bgeu	s8,a5,ffffffffc020a66a <sfs_truncfile+0x24c>
ffffffffc020a4dc:	038cb503          	ld	a0,56(s9)
ffffffffc020a4e0:	85e2                	mv	a1,s8
ffffffffc020a4e2:	b61fe0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc020a4e6:	16051263          	bnez	a0,ffffffffc020a64a <sfs_truncfile+0x22c>
ffffffffc020a4ea:	02091793          	slli	a5,s2,0x20
ffffffffc020a4ee:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a4f2:	86e2                	mv	a3,s8
ffffffffc020a4f4:	4611                	li	a2,4
ffffffffc020a4f6:	082c                	addi	a1,sp,24
ffffffffc020a4f8:	8566                	mv	a0,s9
ffffffffc020a4fa:	e43a                	sd	a4,8(sp)
ffffffffc020a4fc:	ce02                	sw	zero,28(sp)
ffffffffc020a4fe:	043000ef          	jal	ra,ffffffffc020ad40 <sfs_rbuf>
ffffffffc020a502:	892a                	mv	s2,a0
ffffffffc020a504:	e141                	bnez	a0,ffffffffc020a584 <sfs_truncfile+0x166>
ffffffffc020a506:	47e2                	lw	a5,24(sp)
ffffffffc020a508:	6722                	ld	a4,8(sp)
ffffffffc020a50a:	e3c9                	bnez	a5,ffffffffc020a58c <sfs_truncfile+0x16e>
ffffffffc020a50c:	008d2603          	lw	a2,8(s10)
ffffffffc020a510:	367d                	addiw	a2,a2,-1
ffffffffc020a512:	00cd2423          	sw	a2,8(s10)
ffffffffc020a516:	0179b823          	sd	s7,16(s3)
ffffffffc020a51a:	34fd                	addiw	s1,s1,-1
ffffffffc020a51c:	04940a63          	beq	s0,s1,ffffffffc020a570 <sfs_truncfile+0x152>
ffffffffc020a520:	0009bd03          	ld	s10,0(s3)
ffffffffc020a524:	008d2703          	lw	a4,8(s10)
ffffffffc020a528:	c369                	beqz	a4,ffffffffc020a5ea <sfs_truncfile+0x1cc>
ffffffffc020a52a:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a52e:	0007861b          	sext.w	a2,a5
ffffffffc020a532:	f8cde5e3          	bltu	s11,a2,ffffffffc020a4bc <sfs_truncfile+0x9e>
ffffffffc020a536:	02079713          	slli	a4,a5,0x20
ffffffffc020a53a:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a53e:	00fd0933          	add	s2,s10,a5
ffffffffc020a542:	00c92583          	lw	a1,12(s2)
ffffffffc020a546:	d5f1                	beqz	a1,ffffffffc020a512 <sfs_truncfile+0xf4>
ffffffffc020a548:	8566                	mv	a0,s9
ffffffffc020a54a:	c06ff0ef          	jal	ra,ffffffffc0209950 <sfs_block_free>
ffffffffc020a54e:	00092623          	sw	zero,12(s2)
ffffffffc020a552:	008d2603          	lw	a2,8(s10)
ffffffffc020a556:	367d                	addiw	a2,a2,-1
ffffffffc020a558:	bf6d                	j	ffffffffc020a512 <sfs_truncfile+0xf4>
ffffffffc020a55a:	4681                	li	a3,0
ffffffffc020a55c:	8626                	mv	a2,s1
ffffffffc020a55e:	85ce                	mv	a1,s3
ffffffffc020a560:	8566                	mv	a0,s9
ffffffffc020a562:	ea8ff0ef          	jal	ra,ffffffffc0209c0a <sfs_bmap_load_nolock>
ffffffffc020a566:	892a                	mv	s2,a0
ffffffffc020a568:	ed11                	bnez	a0,ffffffffc020a584 <sfs_truncfile+0x166>
ffffffffc020a56a:	2485                	addiw	s1,s1,1
ffffffffc020a56c:	fe9417e3          	bne	s0,s1,ffffffffc020a55a <sfs_truncfile+0x13c>
ffffffffc020a570:	008aa483          	lw	s1,8(s5)
ffffffffc020a574:	0a941b63          	bne	s0,s1,ffffffffc020a62a <sfs_truncfile+0x20c>
ffffffffc020a578:	014aa023          	sw	s4,0(s5)
ffffffffc020a57c:	4785                	li	a5,1
ffffffffc020a57e:	00f9b823          	sd	a5,16(s3)
ffffffffc020a582:	4901                	li	s2,0
ffffffffc020a584:	855a                	mv	a0,s6
ffffffffc020a586:	82afa0ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a58a:	bddd                	j	ffffffffc020a480 <sfs_truncfile+0x62>
ffffffffc020a58c:	86e2                	mv	a3,s8
ffffffffc020a58e:	4611                	li	a2,4
ffffffffc020a590:	086c                	addi	a1,sp,28
ffffffffc020a592:	8566                	mv	a0,s9
ffffffffc020a594:	02d000ef          	jal	ra,ffffffffc020adc0 <sfs_wbuf>
ffffffffc020a598:	892a                	mv	s2,a0
ffffffffc020a59a:	f56d                	bnez	a0,ffffffffc020a584 <sfs_truncfile+0x166>
ffffffffc020a59c:	45e2                	lw	a1,24(sp)
ffffffffc020a59e:	8566                	mv	a0,s9
ffffffffc020a5a0:	bb0ff0ef          	jal	ra,ffffffffc0209950 <sfs_block_free>
ffffffffc020a5a4:	b7a5                	j	ffffffffc020a50c <sfs_truncfile+0xee>
ffffffffc020a5a6:	5975                	li	s2,-3
ffffffffc020a5a8:	bde1                	j	ffffffffc020a480 <sfs_truncfile+0x62>
ffffffffc020a5aa:	00004697          	auipc	a3,0x4
ffffffffc020a5ae:	7ee68693          	addi	a3,a3,2030 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020a5b2:	00001617          	auipc	a2,0x1
ffffffffc020a5b6:	3f660613          	addi	a2,a2,1014 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a5ba:	3a800593          	li	a1,936
ffffffffc020a5be:	00005517          	auipc	a0,0x5
ffffffffc020a5c2:	9ba50513          	addi	a0,a0,-1606 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a5c6:	ed9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5ca:	00005697          	auipc	a3,0x5
ffffffffc020a5ce:	97668693          	addi	a3,a3,-1674 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020a5d2:	00001617          	auipc	a2,0x1
ffffffffc020a5d6:	3d660613          	addi	a2,a2,982 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a5da:	3a900593          	li	a1,937
ffffffffc020a5de:	00005517          	auipc	a0,0x5
ffffffffc020a5e2:	99a50513          	addi	a0,a0,-1638 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a5e6:	eb9f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a5ea:	00005697          	auipc	a3,0x5
ffffffffc020a5ee:	bae68693          	addi	a3,a3,-1106 # ffffffffc020f198 <dev_node_ops+0x7e0>
ffffffffc020a5f2:	00001617          	auipc	a2,0x1
ffffffffc020a5f6:	3b660613          	addi	a2,a2,950 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a5fa:	17b00593          	li	a1,379
ffffffffc020a5fe:	00005517          	auipc	a0,0x5
ffffffffc020a602:	97a50513          	addi	a0,a0,-1670 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a606:	e99f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a60a:	00005697          	auipc	a3,0x5
ffffffffc020a60e:	b7668693          	addi	a3,a3,-1162 # ffffffffc020f180 <dev_node_ops+0x7c8>
ffffffffc020a612:	00001617          	auipc	a2,0x1
ffffffffc020a616:	39660613          	addi	a2,a2,918 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a61a:	3b000593          	li	a1,944
ffffffffc020a61e:	00005517          	auipc	a0,0x5
ffffffffc020a622:	95a50513          	addi	a0,a0,-1702 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a626:	e79f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a62a:	00005697          	auipc	a3,0x5
ffffffffc020a62e:	bbe68693          	addi	a3,a3,-1090 # ffffffffc020f1e8 <dev_node_ops+0x830>
ffffffffc020a632:	00001617          	auipc	a2,0x1
ffffffffc020a636:	37660613          	addi	a2,a2,886 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a63a:	3c900593          	li	a1,969
ffffffffc020a63e:	00005517          	auipc	a0,0x5
ffffffffc020a642:	93a50513          	addi	a0,a0,-1734 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a646:	e59f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a64a:	00005697          	auipc	a3,0x5
ffffffffc020a64e:	b6668693          	addi	a3,a3,-1178 # ffffffffc020f1b0 <dev_node_ops+0x7f8>
ffffffffc020a652:	00001617          	auipc	a2,0x1
ffffffffc020a656:	35660613          	addi	a2,a2,854 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a65a:	12b00593          	li	a1,299
ffffffffc020a65e:	00005517          	auipc	a0,0x5
ffffffffc020a662:	91a50513          	addi	a0,a0,-1766 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a666:	e39f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a66a:	8762                	mv	a4,s8
ffffffffc020a66c:	86be                	mv	a3,a5
ffffffffc020a66e:	00005617          	auipc	a2,0x5
ffffffffc020a672:	93a60613          	addi	a2,a2,-1734 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc020a676:	05300593          	li	a1,83
ffffffffc020a67a:	00005517          	auipc	a0,0x5
ffffffffc020a67e:	8fe50513          	addi	a0,a0,-1794 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a682:	e1df50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a686 <sfs_load_inode>:
ffffffffc020a686:	7139                	addi	sp,sp,-64
ffffffffc020a688:	fc06                	sd	ra,56(sp)
ffffffffc020a68a:	f822                	sd	s0,48(sp)
ffffffffc020a68c:	f426                	sd	s1,40(sp)
ffffffffc020a68e:	f04a                	sd	s2,32(sp)
ffffffffc020a690:	84b2                	mv	s1,a2
ffffffffc020a692:	892a                	mv	s2,a0
ffffffffc020a694:	ec4e                	sd	s3,24(sp)
ffffffffc020a696:	e852                	sd	s4,16(sp)
ffffffffc020a698:	89ae                	mv	s3,a1
ffffffffc020a69a:	e456                	sd	s5,8(sp)
ffffffffc020a69c:	0d5000ef          	jal	ra,ffffffffc020af70 <lock_sfs_fs>
ffffffffc020a6a0:	45a9                	li	a1,10
ffffffffc020a6a2:	8526                	mv	a0,s1
ffffffffc020a6a4:	0a893403          	ld	s0,168(s2)
ffffffffc020a6a8:	0e9000ef          	jal	ra,ffffffffc020af90 <hash32>
ffffffffc020a6ac:	02051793          	slli	a5,a0,0x20
ffffffffc020a6b0:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a6b4:	9722                	add	a4,a4,s0
ffffffffc020a6b6:	843a                	mv	s0,a4
ffffffffc020a6b8:	a029                	j	ffffffffc020a6c2 <sfs_load_inode+0x3c>
ffffffffc020a6ba:	fc042783          	lw	a5,-64(s0)
ffffffffc020a6be:	10978863          	beq	a5,s1,ffffffffc020a7ce <sfs_load_inode+0x148>
ffffffffc020a6c2:	6400                	ld	s0,8(s0)
ffffffffc020a6c4:	fe871be3          	bne	a4,s0,ffffffffc020a6ba <sfs_load_inode+0x34>
ffffffffc020a6c8:	04000513          	li	a0,64
ffffffffc020a6cc:	913f70ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020a6d0:	8aaa                	mv	s5,a0
ffffffffc020a6d2:	16050563          	beqz	a0,ffffffffc020a83c <sfs_load_inode+0x1b6>
ffffffffc020a6d6:	00492683          	lw	a3,4(s2)
ffffffffc020a6da:	18048363          	beqz	s1,ffffffffc020a860 <sfs_load_inode+0x1da>
ffffffffc020a6de:	18d4f163          	bgeu	s1,a3,ffffffffc020a860 <sfs_load_inode+0x1da>
ffffffffc020a6e2:	03893503          	ld	a0,56(s2)
ffffffffc020a6e6:	85a6                	mv	a1,s1
ffffffffc020a6e8:	95bfe0ef          	jal	ra,ffffffffc0209042 <bitmap_test>
ffffffffc020a6ec:	18051763          	bnez	a0,ffffffffc020a87a <sfs_load_inode+0x1f4>
ffffffffc020a6f0:	4701                	li	a4,0
ffffffffc020a6f2:	86a6                	mv	a3,s1
ffffffffc020a6f4:	04000613          	li	a2,64
ffffffffc020a6f8:	85d6                	mv	a1,s5
ffffffffc020a6fa:	854a                	mv	a0,s2
ffffffffc020a6fc:	644000ef          	jal	ra,ffffffffc020ad40 <sfs_rbuf>
ffffffffc020a700:	842a                	mv	s0,a0
ffffffffc020a702:	0e051563          	bnez	a0,ffffffffc020a7ec <sfs_load_inode+0x166>
ffffffffc020a706:	006ad783          	lhu	a5,6(s5)
ffffffffc020a70a:	12078b63          	beqz	a5,ffffffffc020a840 <sfs_load_inode+0x1ba>
ffffffffc020a70e:	6405                	lui	s0,0x1
ffffffffc020a710:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a714:	8e8fd0ef          	jal	ra,ffffffffc02077fc <__alloc_inode>
ffffffffc020a718:	8a2a                	mv	s4,a0
ffffffffc020a71a:	c961                	beqz	a0,ffffffffc020a7ea <sfs_load_inode+0x164>
ffffffffc020a71c:	004ad683          	lhu	a3,4(s5)
ffffffffc020a720:	4785                	li	a5,1
ffffffffc020a722:	0cf69c63          	bne	a3,a5,ffffffffc020a7fa <sfs_load_inode+0x174>
ffffffffc020a726:	864a                	mv	a2,s2
ffffffffc020a728:	00005597          	auipc	a1,0x5
ffffffffc020a72c:	bd058593          	addi	a1,a1,-1072 # ffffffffc020f2f8 <sfs_node_fileops>
ffffffffc020a730:	8e8fd0ef          	jal	ra,ffffffffc0207818 <inode_init>
ffffffffc020a734:	058a2783          	lw	a5,88(s4)
ffffffffc020a738:	23540413          	addi	s0,s0,565
ffffffffc020a73c:	0e879063          	bne	a5,s0,ffffffffc020a81c <sfs_load_inode+0x196>
ffffffffc020a740:	4785                	li	a5,1
ffffffffc020a742:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a746:	015a3023          	sd	s5,0(s4)
ffffffffc020a74a:	009a2423          	sw	s1,8(s4)
ffffffffc020a74e:	000a3823          	sd	zero,16(s4)
ffffffffc020a752:	4585                	li	a1,1
ffffffffc020a754:	020a0513          	addi	a0,s4,32
ffffffffc020a758:	e53f90ef          	jal	ra,ffffffffc02045aa <sem_init>
ffffffffc020a75c:	058a2703          	lw	a4,88(s4)
ffffffffc020a760:	6785                	lui	a5,0x1
ffffffffc020a762:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a766:	14f71663          	bne	a4,a5,ffffffffc020a8b2 <sfs_load_inode+0x22c>
ffffffffc020a76a:	0a093703          	ld	a4,160(s2)
ffffffffc020a76e:	038a0793          	addi	a5,s4,56
ffffffffc020a772:	008a2503          	lw	a0,8(s4)
ffffffffc020a776:	e31c                	sd	a5,0(a4)
ffffffffc020a778:	0af93023          	sd	a5,160(s2)
ffffffffc020a77c:	09890793          	addi	a5,s2,152
ffffffffc020a780:	0a893403          	ld	s0,168(s2)
ffffffffc020a784:	45a9                	li	a1,10
ffffffffc020a786:	04ea3023          	sd	a4,64(s4)
ffffffffc020a78a:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a78e:	003000ef          	jal	ra,ffffffffc020af90 <hash32>
ffffffffc020a792:	02051713          	slli	a4,a0,0x20
ffffffffc020a796:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a79a:	97a2                	add	a5,a5,s0
ffffffffc020a79c:	6798                	ld	a4,8(a5)
ffffffffc020a79e:	048a0693          	addi	a3,s4,72
ffffffffc020a7a2:	e314                	sd	a3,0(a4)
ffffffffc020a7a4:	e794                	sd	a3,8(a5)
ffffffffc020a7a6:	04ea3823          	sd	a4,80(s4)
ffffffffc020a7aa:	04fa3423          	sd	a5,72(s4)
ffffffffc020a7ae:	854a                	mv	a0,s2
ffffffffc020a7b0:	7d0000ef          	jal	ra,ffffffffc020af80 <unlock_sfs_fs>
ffffffffc020a7b4:	4401                	li	s0,0
ffffffffc020a7b6:	0149b023          	sd	s4,0(s3)
ffffffffc020a7ba:	70e2                	ld	ra,56(sp)
ffffffffc020a7bc:	8522                	mv	a0,s0
ffffffffc020a7be:	7442                	ld	s0,48(sp)
ffffffffc020a7c0:	74a2                	ld	s1,40(sp)
ffffffffc020a7c2:	7902                	ld	s2,32(sp)
ffffffffc020a7c4:	69e2                	ld	s3,24(sp)
ffffffffc020a7c6:	6a42                	ld	s4,16(sp)
ffffffffc020a7c8:	6aa2                	ld	s5,8(sp)
ffffffffc020a7ca:	6121                	addi	sp,sp,64
ffffffffc020a7cc:	8082                	ret
ffffffffc020a7ce:	fb840a13          	addi	s4,s0,-72
ffffffffc020a7d2:	8552                	mv	a0,s4
ffffffffc020a7d4:	8a6fd0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc020a7d8:	4785                	li	a5,1
ffffffffc020a7da:	fcf51ae3          	bne	a0,a5,ffffffffc020a7ae <sfs_load_inode+0x128>
ffffffffc020a7de:	fd042783          	lw	a5,-48(s0)
ffffffffc020a7e2:	2785                	addiw	a5,a5,1
ffffffffc020a7e4:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a7e8:	b7d9                	j	ffffffffc020a7ae <sfs_load_inode+0x128>
ffffffffc020a7ea:	5471                	li	s0,-4
ffffffffc020a7ec:	8556                	mv	a0,s5
ffffffffc020a7ee:	8a1f70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020a7f2:	854a                	mv	a0,s2
ffffffffc020a7f4:	78c000ef          	jal	ra,ffffffffc020af80 <unlock_sfs_fs>
ffffffffc020a7f8:	b7c9                	j	ffffffffc020a7ba <sfs_load_inode+0x134>
ffffffffc020a7fa:	4789                	li	a5,2
ffffffffc020a7fc:	08f69f63          	bne	a3,a5,ffffffffc020a89a <sfs_load_inode+0x214>
ffffffffc020a800:	864a                	mv	a2,s2
ffffffffc020a802:	00005597          	auipc	a1,0x5
ffffffffc020a806:	a7658593          	addi	a1,a1,-1418 # ffffffffc020f278 <sfs_node_dirops>
ffffffffc020a80a:	80efd0ef          	jal	ra,ffffffffc0207818 <inode_init>
ffffffffc020a80e:	058a2703          	lw	a4,88(s4)
ffffffffc020a812:	6785                	lui	a5,0x1
ffffffffc020a814:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a818:	f2f704e3          	beq	a4,a5,ffffffffc020a740 <sfs_load_inode+0xba>
ffffffffc020a81c:	00004697          	auipc	a3,0x4
ffffffffc020a820:	72468693          	addi	a3,a3,1828 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020a824:	00001617          	auipc	a2,0x1
ffffffffc020a828:	18460613          	addi	a2,a2,388 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a82c:	07700593          	li	a1,119
ffffffffc020a830:	00004517          	auipc	a0,0x4
ffffffffc020a834:	74850513          	addi	a0,a0,1864 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a838:	c67f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a83c:	5471                	li	s0,-4
ffffffffc020a83e:	bf55                	j	ffffffffc020a7f2 <sfs_load_inode+0x16c>
ffffffffc020a840:	00005697          	auipc	a3,0x5
ffffffffc020a844:	9c068693          	addi	a3,a3,-1600 # ffffffffc020f200 <dev_node_ops+0x848>
ffffffffc020a848:	00001617          	auipc	a2,0x1
ffffffffc020a84c:	16060613          	addi	a2,a2,352 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a850:	0ad00593          	li	a1,173
ffffffffc020a854:	00004517          	auipc	a0,0x4
ffffffffc020a858:	72450513          	addi	a0,a0,1828 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a85c:	c43f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a860:	8726                	mv	a4,s1
ffffffffc020a862:	00004617          	auipc	a2,0x4
ffffffffc020a866:	74660613          	addi	a2,a2,1862 # ffffffffc020efa8 <dev_node_ops+0x5f0>
ffffffffc020a86a:	05300593          	li	a1,83
ffffffffc020a86e:	00004517          	auipc	a0,0x4
ffffffffc020a872:	70a50513          	addi	a0,a0,1802 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a876:	c29f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a87a:	00004697          	auipc	a3,0x4
ffffffffc020a87e:	76668693          	addi	a3,a3,1894 # ffffffffc020efe0 <dev_node_ops+0x628>
ffffffffc020a882:	00001617          	auipc	a2,0x1
ffffffffc020a886:	12660613          	addi	a2,a2,294 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a88a:	0a800593          	li	a1,168
ffffffffc020a88e:	00004517          	auipc	a0,0x4
ffffffffc020a892:	6ea50513          	addi	a0,a0,1770 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a896:	c09f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a89a:	00004617          	auipc	a2,0x4
ffffffffc020a89e:	6f660613          	addi	a2,a2,1782 # ffffffffc020ef90 <dev_node_ops+0x5d8>
ffffffffc020a8a2:	02e00593          	li	a1,46
ffffffffc020a8a6:	00004517          	auipc	a0,0x4
ffffffffc020a8aa:	6d250513          	addi	a0,a0,1746 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a8ae:	bf1f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a8b2:	00004697          	auipc	a3,0x4
ffffffffc020a8b6:	68e68693          	addi	a3,a3,1678 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020a8ba:	00001617          	auipc	a2,0x1
ffffffffc020a8be:	0ee60613          	addi	a2,a2,238 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a8c2:	0b100593          	li	a1,177
ffffffffc020a8c6:	00004517          	auipc	a0,0x4
ffffffffc020a8ca:	6b250513          	addi	a0,a0,1714 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a8ce:	bd1f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a8d2 <sfs_lookup>:
ffffffffc020a8d2:	7139                	addi	sp,sp,-64
ffffffffc020a8d4:	ec4e                	sd	s3,24(sp)
ffffffffc020a8d6:	06853983          	ld	s3,104(a0)
ffffffffc020a8da:	fc06                	sd	ra,56(sp)
ffffffffc020a8dc:	f822                	sd	s0,48(sp)
ffffffffc020a8de:	f426                	sd	s1,40(sp)
ffffffffc020a8e0:	f04a                	sd	s2,32(sp)
ffffffffc020a8e2:	e852                	sd	s4,16(sp)
ffffffffc020a8e4:	0a098c63          	beqz	s3,ffffffffc020a99c <sfs_lookup+0xca>
ffffffffc020a8e8:	0b09a783          	lw	a5,176(s3)
ffffffffc020a8ec:	ebc5                	bnez	a5,ffffffffc020a99c <sfs_lookup+0xca>
ffffffffc020a8ee:	0005c783          	lbu	a5,0(a1)
ffffffffc020a8f2:	84ae                	mv	s1,a1
ffffffffc020a8f4:	c7c1                	beqz	a5,ffffffffc020a97c <sfs_lookup+0xaa>
ffffffffc020a8f6:	02f00713          	li	a4,47
ffffffffc020a8fa:	08e78163          	beq	a5,a4,ffffffffc020a97c <sfs_lookup+0xaa>
ffffffffc020a8fe:	842a                	mv	s0,a0
ffffffffc020a900:	8a32                	mv	s4,a2
ffffffffc020a902:	f79fc0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc020a906:	4c38                	lw	a4,88(s0)
ffffffffc020a908:	6785                	lui	a5,0x1
ffffffffc020a90a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a90e:	0af71763          	bne	a4,a5,ffffffffc020a9bc <sfs_lookup+0xea>
ffffffffc020a912:	6018                	ld	a4,0(s0)
ffffffffc020a914:	4789                	li	a5,2
ffffffffc020a916:	00475703          	lhu	a4,4(a4)
ffffffffc020a91a:	04f71c63          	bne	a4,a5,ffffffffc020a972 <sfs_lookup+0xa0>
ffffffffc020a91e:	02040913          	addi	s2,s0,32
ffffffffc020a922:	854a                	mv	a0,s2
ffffffffc020a924:	c91f90ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020a928:	8626                	mv	a2,s1
ffffffffc020a92a:	0054                	addi	a3,sp,4
ffffffffc020a92c:	85a2                	mv	a1,s0
ffffffffc020a92e:	854e                	mv	a0,s3
ffffffffc020a930:	a29ff0ef          	jal	ra,ffffffffc020a358 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a934:	84aa                	mv	s1,a0
ffffffffc020a936:	854a                	mv	a0,s2
ffffffffc020a938:	c79f90ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020a93c:	cc89                	beqz	s1,ffffffffc020a956 <sfs_lookup+0x84>
ffffffffc020a93e:	8522                	mv	a0,s0
ffffffffc020a940:	808fd0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020a944:	70e2                	ld	ra,56(sp)
ffffffffc020a946:	7442                	ld	s0,48(sp)
ffffffffc020a948:	7902                	ld	s2,32(sp)
ffffffffc020a94a:	69e2                	ld	s3,24(sp)
ffffffffc020a94c:	6a42                	ld	s4,16(sp)
ffffffffc020a94e:	8526                	mv	a0,s1
ffffffffc020a950:	74a2                	ld	s1,40(sp)
ffffffffc020a952:	6121                	addi	sp,sp,64
ffffffffc020a954:	8082                	ret
ffffffffc020a956:	4612                	lw	a2,4(sp)
ffffffffc020a958:	002c                	addi	a1,sp,8
ffffffffc020a95a:	854e                	mv	a0,s3
ffffffffc020a95c:	d2bff0ef          	jal	ra,ffffffffc020a686 <sfs_load_inode>
ffffffffc020a960:	84aa                	mv	s1,a0
ffffffffc020a962:	8522                	mv	a0,s0
ffffffffc020a964:	fe5fc0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020a968:	fcf1                	bnez	s1,ffffffffc020a944 <sfs_lookup+0x72>
ffffffffc020a96a:	67a2                	ld	a5,8(sp)
ffffffffc020a96c:	00fa3023          	sd	a5,0(s4)
ffffffffc020a970:	bfd1                	j	ffffffffc020a944 <sfs_lookup+0x72>
ffffffffc020a972:	8522                	mv	a0,s0
ffffffffc020a974:	fd5fc0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020a978:	54b9                	li	s1,-18
ffffffffc020a97a:	b7e9                	j	ffffffffc020a944 <sfs_lookup+0x72>
ffffffffc020a97c:	00005697          	auipc	a3,0x5
ffffffffc020a980:	89c68693          	addi	a3,a3,-1892 # ffffffffc020f218 <dev_node_ops+0x860>
ffffffffc020a984:	00001617          	auipc	a2,0x1
ffffffffc020a988:	02460613          	addi	a2,a2,36 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a98c:	3da00593          	li	a1,986
ffffffffc020a990:	00004517          	auipc	a0,0x4
ffffffffc020a994:	5e850513          	addi	a0,a0,1512 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a998:	b07f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a99c:	00004697          	auipc	a3,0x4
ffffffffc020a9a0:	3fc68693          	addi	a3,a3,1020 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020a9a4:	00001617          	auipc	a2,0x1
ffffffffc020a9a8:	00460613          	addi	a2,a2,4 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a9ac:	3d900593          	li	a1,985
ffffffffc020a9b0:	00004517          	auipc	a0,0x4
ffffffffc020a9b4:	5c850513          	addi	a0,a0,1480 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a9b8:	ae7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a9bc:	00004697          	auipc	a3,0x4
ffffffffc020a9c0:	58468693          	addi	a3,a3,1412 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020a9c4:	00001617          	auipc	a2,0x1
ffffffffc020a9c8:	fe460613          	addi	a2,a2,-28 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020a9cc:	3dc00593          	li	a1,988
ffffffffc020a9d0:	00004517          	auipc	a0,0x4
ffffffffc020a9d4:	5a850513          	addi	a0,a0,1448 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020a9d8:	ac7f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a9dc <sfs_namefile>:
ffffffffc020a9dc:	6d98                	ld	a4,24(a1)
ffffffffc020a9de:	7175                	addi	sp,sp,-144
ffffffffc020a9e0:	e506                	sd	ra,136(sp)
ffffffffc020a9e2:	e122                	sd	s0,128(sp)
ffffffffc020a9e4:	fca6                	sd	s1,120(sp)
ffffffffc020a9e6:	f8ca                	sd	s2,112(sp)
ffffffffc020a9e8:	f4ce                	sd	s3,104(sp)
ffffffffc020a9ea:	f0d2                	sd	s4,96(sp)
ffffffffc020a9ec:	ecd6                	sd	s5,88(sp)
ffffffffc020a9ee:	e8da                	sd	s6,80(sp)
ffffffffc020a9f0:	e4de                	sd	s7,72(sp)
ffffffffc020a9f2:	e0e2                	sd	s8,64(sp)
ffffffffc020a9f4:	fc66                	sd	s9,56(sp)
ffffffffc020a9f6:	f86a                	sd	s10,48(sp)
ffffffffc020a9f8:	f46e                	sd	s11,40(sp)
ffffffffc020a9fa:	e42e                	sd	a1,8(sp)
ffffffffc020a9fc:	4789                	li	a5,2
ffffffffc020a9fe:	1ae7f363          	bgeu	a5,a4,ffffffffc020aba4 <sfs_namefile+0x1c8>
ffffffffc020aa02:	89aa                	mv	s3,a0
ffffffffc020aa04:	10400513          	li	a0,260
ffffffffc020aa08:	dd6f70ef          	jal	ra,ffffffffc0201fde <kmalloc>
ffffffffc020aa0c:	842a                	mv	s0,a0
ffffffffc020aa0e:	18050b63          	beqz	a0,ffffffffc020aba4 <sfs_namefile+0x1c8>
ffffffffc020aa12:	0689b483          	ld	s1,104(s3)
ffffffffc020aa16:	1e048963          	beqz	s1,ffffffffc020ac08 <sfs_namefile+0x22c>
ffffffffc020aa1a:	0b04a783          	lw	a5,176(s1)
ffffffffc020aa1e:	1e079563          	bnez	a5,ffffffffc020ac08 <sfs_namefile+0x22c>
ffffffffc020aa22:	0589ac83          	lw	s9,88(s3)
ffffffffc020aa26:	6785                	lui	a5,0x1
ffffffffc020aa28:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020aa2c:	1afc9e63          	bne	s9,a5,ffffffffc020abe8 <sfs_namefile+0x20c>
ffffffffc020aa30:	6722                	ld	a4,8(sp)
ffffffffc020aa32:	854e                	mv	a0,s3
ffffffffc020aa34:	8ace                	mv	s5,s3
ffffffffc020aa36:	6f1c                	ld	a5,24(a4)
ffffffffc020aa38:	00073b03          	ld	s6,0(a4)
ffffffffc020aa3c:	02098a13          	addi	s4,s3,32
ffffffffc020aa40:	ffe78b93          	addi	s7,a5,-2
ffffffffc020aa44:	9b3e                	add	s6,s6,a5
ffffffffc020aa46:	00004d17          	auipc	s10,0x4
ffffffffc020aa4a:	7f2d0d13          	addi	s10,s10,2034 # ffffffffc020f238 <dev_node_ops+0x880>
ffffffffc020aa4e:	e2dfc0ef          	jal	ra,ffffffffc020787a <inode_ref_inc>
ffffffffc020aa52:	00440c13          	addi	s8,s0,4
ffffffffc020aa56:	e066                	sd	s9,0(sp)
ffffffffc020aa58:	8552                	mv	a0,s4
ffffffffc020aa5a:	b5bf90ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020aa5e:	0854                	addi	a3,sp,20
ffffffffc020aa60:	866a                	mv	a2,s10
ffffffffc020aa62:	85d6                	mv	a1,s5
ffffffffc020aa64:	8526                	mv	a0,s1
ffffffffc020aa66:	8f3ff0ef          	jal	ra,ffffffffc020a358 <sfs_dirent_search_nolock.constprop.0>
ffffffffc020aa6a:	8daa                	mv	s11,a0
ffffffffc020aa6c:	8552                	mv	a0,s4
ffffffffc020aa6e:	b43f90ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020aa72:	020d8863          	beqz	s11,ffffffffc020aaa2 <sfs_namefile+0xc6>
ffffffffc020aa76:	854e                	mv	a0,s3
ffffffffc020aa78:	ed1fc0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020aa7c:	8522                	mv	a0,s0
ffffffffc020aa7e:	e10f70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020aa82:	60aa                	ld	ra,136(sp)
ffffffffc020aa84:	640a                	ld	s0,128(sp)
ffffffffc020aa86:	74e6                	ld	s1,120(sp)
ffffffffc020aa88:	7946                	ld	s2,112(sp)
ffffffffc020aa8a:	79a6                	ld	s3,104(sp)
ffffffffc020aa8c:	7a06                	ld	s4,96(sp)
ffffffffc020aa8e:	6ae6                	ld	s5,88(sp)
ffffffffc020aa90:	6b46                	ld	s6,80(sp)
ffffffffc020aa92:	6ba6                	ld	s7,72(sp)
ffffffffc020aa94:	6c06                	ld	s8,64(sp)
ffffffffc020aa96:	7ce2                	ld	s9,56(sp)
ffffffffc020aa98:	7d42                	ld	s10,48(sp)
ffffffffc020aa9a:	856e                	mv	a0,s11
ffffffffc020aa9c:	7da2                	ld	s11,40(sp)
ffffffffc020aa9e:	6149                	addi	sp,sp,144
ffffffffc020aaa0:	8082                	ret
ffffffffc020aaa2:	4652                	lw	a2,20(sp)
ffffffffc020aaa4:	082c                	addi	a1,sp,24
ffffffffc020aaa6:	8526                	mv	a0,s1
ffffffffc020aaa8:	bdfff0ef          	jal	ra,ffffffffc020a686 <sfs_load_inode>
ffffffffc020aaac:	8daa                	mv	s11,a0
ffffffffc020aaae:	f561                	bnez	a0,ffffffffc020aa76 <sfs_namefile+0x9a>
ffffffffc020aab0:	854e                	mv	a0,s3
ffffffffc020aab2:	008aa903          	lw	s2,8(s5)
ffffffffc020aab6:	e93fc0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020aaba:	6ce2                	ld	s9,24(sp)
ffffffffc020aabc:	0b3c8463          	beq	s9,s3,ffffffffc020ab64 <sfs_namefile+0x188>
ffffffffc020aac0:	100c8463          	beqz	s9,ffffffffc020abc8 <sfs_namefile+0x1ec>
ffffffffc020aac4:	058ca703          	lw	a4,88(s9)
ffffffffc020aac8:	6782                	ld	a5,0(sp)
ffffffffc020aaca:	0ef71f63          	bne	a4,a5,ffffffffc020abc8 <sfs_namefile+0x1ec>
ffffffffc020aace:	008ca703          	lw	a4,8(s9)
ffffffffc020aad2:	8ae6                	mv	s5,s9
ffffffffc020aad4:	0d270a63          	beq	a4,s2,ffffffffc020aba8 <sfs_namefile+0x1cc>
ffffffffc020aad8:	000cb703          	ld	a4,0(s9)
ffffffffc020aadc:	4789                	li	a5,2
ffffffffc020aade:	00475703          	lhu	a4,4(a4)
ffffffffc020aae2:	0cf71363          	bne	a4,a5,ffffffffc020aba8 <sfs_namefile+0x1cc>
ffffffffc020aae6:	020c8a13          	addi	s4,s9,32
ffffffffc020aaea:	8552                	mv	a0,s4
ffffffffc020aaec:	ac9f90ef          	jal	ra,ffffffffc02045b4 <down>
ffffffffc020aaf0:	000cb703          	ld	a4,0(s9)
ffffffffc020aaf4:	00872983          	lw	s3,8(a4)
ffffffffc020aaf8:	01304963          	bgtz	s3,ffffffffc020ab0a <sfs_namefile+0x12e>
ffffffffc020aafc:	a899                	j	ffffffffc020ab52 <sfs_namefile+0x176>
ffffffffc020aafe:	4018                	lw	a4,0(s0)
ffffffffc020ab00:	01270e63          	beq	a4,s2,ffffffffc020ab1c <sfs_namefile+0x140>
ffffffffc020ab04:	2d85                	addiw	s11,s11,1
ffffffffc020ab06:	05b98663          	beq	s3,s11,ffffffffc020ab52 <sfs_namefile+0x176>
ffffffffc020ab0a:	86a2                	mv	a3,s0
ffffffffc020ab0c:	866e                	mv	a2,s11
ffffffffc020ab0e:	85e6                	mv	a1,s9
ffffffffc020ab10:	8526                	mv	a0,s1
ffffffffc020ab12:	e48ff0ef          	jal	ra,ffffffffc020a15a <sfs_dirent_read_nolock>
ffffffffc020ab16:	872a                	mv	a4,a0
ffffffffc020ab18:	d17d                	beqz	a0,ffffffffc020aafe <sfs_namefile+0x122>
ffffffffc020ab1a:	a82d                	j	ffffffffc020ab54 <sfs_namefile+0x178>
ffffffffc020ab1c:	8552                	mv	a0,s4
ffffffffc020ab1e:	a93f90ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020ab22:	8562                	mv	a0,s8
ffffffffc020ab24:	0ff000ef          	jal	ra,ffffffffc020b422 <strlen>
ffffffffc020ab28:	00150793          	addi	a5,a0,1
ffffffffc020ab2c:	862a                	mv	a2,a0
ffffffffc020ab2e:	06fbe863          	bltu	s7,a5,ffffffffc020ab9e <sfs_namefile+0x1c2>
ffffffffc020ab32:	fff64913          	not	s2,a2
ffffffffc020ab36:	995a                	add	s2,s2,s6
ffffffffc020ab38:	85e2                	mv	a1,s8
ffffffffc020ab3a:	854a                	mv	a0,s2
ffffffffc020ab3c:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020ab40:	1d7000ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020ab44:	02f00793          	li	a5,47
ffffffffc020ab48:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020ab4c:	89e6                	mv	s3,s9
ffffffffc020ab4e:	8b4a                	mv	s6,s2
ffffffffc020ab50:	b721                	j	ffffffffc020aa58 <sfs_namefile+0x7c>
ffffffffc020ab52:	5741                	li	a4,-16
ffffffffc020ab54:	8552                	mv	a0,s4
ffffffffc020ab56:	e03a                	sd	a4,0(sp)
ffffffffc020ab58:	a59f90ef          	jal	ra,ffffffffc02045b0 <up>
ffffffffc020ab5c:	6702                	ld	a4,0(sp)
ffffffffc020ab5e:	89e6                	mv	s3,s9
ffffffffc020ab60:	8dba                	mv	s11,a4
ffffffffc020ab62:	bf11                	j	ffffffffc020aa76 <sfs_namefile+0x9a>
ffffffffc020ab64:	854e                	mv	a0,s3
ffffffffc020ab66:	de3fc0ef          	jal	ra,ffffffffc0207948 <inode_ref_dec>
ffffffffc020ab6a:	64a2                	ld	s1,8(sp)
ffffffffc020ab6c:	85da                	mv	a1,s6
ffffffffc020ab6e:	6c98                	ld	a4,24(s1)
ffffffffc020ab70:	6088                	ld	a0,0(s1)
ffffffffc020ab72:	1779                	addi	a4,a4,-2
ffffffffc020ab74:	41770bb3          	sub	s7,a4,s7
ffffffffc020ab78:	865e                	mv	a2,s7
ffffffffc020ab7a:	0505                	addi	a0,a0,1
ffffffffc020ab7c:	15b000ef          	jal	ra,ffffffffc020b4d6 <memmove>
ffffffffc020ab80:	02f00713          	li	a4,47
ffffffffc020ab84:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020ab88:	955e                	add	a0,a0,s7
ffffffffc020ab8a:	00050023          	sb	zero,0(a0)
ffffffffc020ab8e:	85de                	mv	a1,s7
ffffffffc020ab90:	8526                	mv	a0,s1
ffffffffc020ab92:	917fa0ef          	jal	ra,ffffffffc02054a8 <iobuf_skip>
ffffffffc020ab96:	8522                	mv	a0,s0
ffffffffc020ab98:	cf6f70ef          	jal	ra,ffffffffc020208e <kfree>
ffffffffc020ab9c:	b5dd                	j	ffffffffc020aa82 <sfs_namefile+0xa6>
ffffffffc020ab9e:	89e6                	mv	s3,s9
ffffffffc020aba0:	5df1                	li	s11,-4
ffffffffc020aba2:	bdd1                	j	ffffffffc020aa76 <sfs_namefile+0x9a>
ffffffffc020aba4:	5df1                	li	s11,-4
ffffffffc020aba6:	bdf1                	j	ffffffffc020aa82 <sfs_namefile+0xa6>
ffffffffc020aba8:	00004697          	auipc	a3,0x4
ffffffffc020abac:	69868693          	addi	a3,a3,1688 # ffffffffc020f240 <dev_node_ops+0x888>
ffffffffc020abb0:	00001617          	auipc	a2,0x1
ffffffffc020abb4:	df860613          	addi	a2,a2,-520 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020abb8:	2f800593          	li	a1,760
ffffffffc020abbc:	00004517          	auipc	a0,0x4
ffffffffc020abc0:	3bc50513          	addi	a0,a0,956 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020abc4:	8dbf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020abc8:	00004697          	auipc	a3,0x4
ffffffffc020abcc:	37868693          	addi	a3,a3,888 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020abd0:	00001617          	auipc	a2,0x1
ffffffffc020abd4:	dd860613          	addi	a2,a2,-552 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020abd8:	2f700593          	li	a1,759
ffffffffc020abdc:	00004517          	auipc	a0,0x4
ffffffffc020abe0:	39c50513          	addi	a0,a0,924 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020abe4:	8bbf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020abe8:	00004697          	auipc	a3,0x4
ffffffffc020abec:	35868693          	addi	a3,a3,856 # ffffffffc020ef40 <dev_node_ops+0x588>
ffffffffc020abf0:	00001617          	auipc	a2,0x1
ffffffffc020abf4:	db860613          	addi	a2,a2,-584 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020abf8:	2e400593          	li	a1,740
ffffffffc020abfc:	00004517          	auipc	a0,0x4
ffffffffc020ac00:	37c50513          	addi	a0,a0,892 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020ac04:	89bf50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ac08:	00004697          	auipc	a3,0x4
ffffffffc020ac0c:	19068693          	addi	a3,a3,400 # ffffffffc020ed98 <dev_node_ops+0x3e0>
ffffffffc020ac10:	00001617          	auipc	a2,0x1
ffffffffc020ac14:	d9860613          	addi	a2,a2,-616 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020ac18:	2e300593          	li	a1,739
ffffffffc020ac1c:	00004517          	auipc	a0,0x4
ffffffffc020ac20:	35c50513          	addi	a0,a0,860 # ffffffffc020ef78 <dev_node_ops+0x5c0>
ffffffffc020ac24:	87bf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ac28 <sfs_rwblock_nolock>:
ffffffffc020ac28:	7139                	addi	sp,sp,-64
ffffffffc020ac2a:	f822                	sd	s0,48(sp)
ffffffffc020ac2c:	f426                	sd	s1,40(sp)
ffffffffc020ac2e:	fc06                	sd	ra,56(sp)
ffffffffc020ac30:	842a                	mv	s0,a0
ffffffffc020ac32:	84b6                	mv	s1,a3
ffffffffc020ac34:	e211                	bnez	a2,ffffffffc020ac38 <sfs_rwblock_nolock+0x10>
ffffffffc020ac36:	e715                	bnez	a4,ffffffffc020ac62 <sfs_rwblock_nolock+0x3a>
ffffffffc020ac38:	405c                	lw	a5,4(s0)
ffffffffc020ac3a:	02f67463          	bgeu	a2,a5,ffffffffc020ac62 <sfs_rwblock_nolock+0x3a>
ffffffffc020ac3e:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020ac42:	1682                	slli	a3,a3,0x20
ffffffffc020ac44:	6605                	lui	a2,0x1
ffffffffc020ac46:	9281                	srli	a3,a3,0x20
ffffffffc020ac48:	850a                	mv	a0,sp
ffffffffc020ac4a:	fe8fa0ef          	jal	ra,ffffffffc0205432 <iobuf_init>
ffffffffc020ac4e:	85aa                	mv	a1,a0
ffffffffc020ac50:	7808                	ld	a0,48(s0)
ffffffffc020ac52:	8626                	mv	a2,s1
ffffffffc020ac54:	7118                	ld	a4,32(a0)
ffffffffc020ac56:	9702                	jalr	a4
ffffffffc020ac58:	70e2                	ld	ra,56(sp)
ffffffffc020ac5a:	7442                	ld	s0,48(sp)
ffffffffc020ac5c:	74a2                	ld	s1,40(sp)
ffffffffc020ac5e:	6121                	addi	sp,sp,64
ffffffffc020ac60:	8082                	ret
ffffffffc020ac62:	00004697          	auipc	a3,0x4
ffffffffc020ac66:	71668693          	addi	a3,a3,1814 # ffffffffc020f378 <sfs_node_fileops+0x80>
ffffffffc020ac6a:	00001617          	auipc	a2,0x1
ffffffffc020ac6e:	d3e60613          	addi	a2,a2,-706 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020ac72:	45d5                	li	a1,21
ffffffffc020ac74:	00004517          	auipc	a0,0x4
ffffffffc020ac78:	73c50513          	addi	a0,a0,1852 # ffffffffc020f3b0 <sfs_node_fileops+0xb8>
ffffffffc020ac7c:	823f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ac80 <sfs_rblock>:
ffffffffc020ac80:	7139                	addi	sp,sp,-64
ffffffffc020ac82:	ec4e                	sd	s3,24(sp)
ffffffffc020ac84:	89b6                	mv	s3,a3
ffffffffc020ac86:	f822                	sd	s0,48(sp)
ffffffffc020ac88:	f04a                	sd	s2,32(sp)
ffffffffc020ac8a:	e852                	sd	s4,16(sp)
ffffffffc020ac8c:	fc06                	sd	ra,56(sp)
ffffffffc020ac8e:	f426                	sd	s1,40(sp)
ffffffffc020ac90:	e456                	sd	s5,8(sp)
ffffffffc020ac92:	8a2a                	mv	s4,a0
ffffffffc020ac94:	892e                	mv	s2,a1
ffffffffc020ac96:	8432                	mv	s0,a2
ffffffffc020ac98:	2e0000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020ac9c:	04098063          	beqz	s3,ffffffffc020acdc <sfs_rblock+0x5c>
ffffffffc020aca0:	013409bb          	addw	s3,s0,s3
ffffffffc020aca4:	6a85                	lui	s5,0x1
ffffffffc020aca6:	a021                	j	ffffffffc020acae <sfs_rblock+0x2e>
ffffffffc020aca8:	9956                	add	s2,s2,s5
ffffffffc020acaa:	02898963          	beq	s3,s0,ffffffffc020acdc <sfs_rblock+0x5c>
ffffffffc020acae:	8622                	mv	a2,s0
ffffffffc020acb0:	85ca                	mv	a1,s2
ffffffffc020acb2:	4705                	li	a4,1
ffffffffc020acb4:	4681                	li	a3,0
ffffffffc020acb6:	8552                	mv	a0,s4
ffffffffc020acb8:	f71ff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020acbc:	84aa                	mv	s1,a0
ffffffffc020acbe:	2405                	addiw	s0,s0,1
ffffffffc020acc0:	d565                	beqz	a0,ffffffffc020aca8 <sfs_rblock+0x28>
ffffffffc020acc2:	8552                	mv	a0,s4
ffffffffc020acc4:	2c4000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020acc8:	70e2                	ld	ra,56(sp)
ffffffffc020acca:	7442                	ld	s0,48(sp)
ffffffffc020accc:	7902                	ld	s2,32(sp)
ffffffffc020acce:	69e2                	ld	s3,24(sp)
ffffffffc020acd0:	6a42                	ld	s4,16(sp)
ffffffffc020acd2:	6aa2                	ld	s5,8(sp)
ffffffffc020acd4:	8526                	mv	a0,s1
ffffffffc020acd6:	74a2                	ld	s1,40(sp)
ffffffffc020acd8:	6121                	addi	sp,sp,64
ffffffffc020acda:	8082                	ret
ffffffffc020acdc:	4481                	li	s1,0
ffffffffc020acde:	b7d5                	j	ffffffffc020acc2 <sfs_rblock+0x42>

ffffffffc020ace0 <sfs_wblock>:
ffffffffc020ace0:	7139                	addi	sp,sp,-64
ffffffffc020ace2:	ec4e                	sd	s3,24(sp)
ffffffffc020ace4:	89b6                	mv	s3,a3
ffffffffc020ace6:	f822                	sd	s0,48(sp)
ffffffffc020ace8:	f04a                	sd	s2,32(sp)
ffffffffc020acea:	e852                	sd	s4,16(sp)
ffffffffc020acec:	fc06                	sd	ra,56(sp)
ffffffffc020acee:	f426                	sd	s1,40(sp)
ffffffffc020acf0:	e456                	sd	s5,8(sp)
ffffffffc020acf2:	8a2a                	mv	s4,a0
ffffffffc020acf4:	892e                	mv	s2,a1
ffffffffc020acf6:	8432                	mv	s0,a2
ffffffffc020acf8:	280000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020acfc:	04098063          	beqz	s3,ffffffffc020ad3c <sfs_wblock+0x5c>
ffffffffc020ad00:	013409bb          	addw	s3,s0,s3
ffffffffc020ad04:	6a85                	lui	s5,0x1
ffffffffc020ad06:	a021                	j	ffffffffc020ad0e <sfs_wblock+0x2e>
ffffffffc020ad08:	9956                	add	s2,s2,s5
ffffffffc020ad0a:	02898963          	beq	s3,s0,ffffffffc020ad3c <sfs_wblock+0x5c>
ffffffffc020ad0e:	8622                	mv	a2,s0
ffffffffc020ad10:	85ca                	mv	a1,s2
ffffffffc020ad12:	4705                	li	a4,1
ffffffffc020ad14:	4685                	li	a3,1
ffffffffc020ad16:	8552                	mv	a0,s4
ffffffffc020ad18:	f11ff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020ad1c:	84aa                	mv	s1,a0
ffffffffc020ad1e:	2405                	addiw	s0,s0,1
ffffffffc020ad20:	d565                	beqz	a0,ffffffffc020ad08 <sfs_wblock+0x28>
ffffffffc020ad22:	8552                	mv	a0,s4
ffffffffc020ad24:	264000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020ad28:	70e2                	ld	ra,56(sp)
ffffffffc020ad2a:	7442                	ld	s0,48(sp)
ffffffffc020ad2c:	7902                	ld	s2,32(sp)
ffffffffc020ad2e:	69e2                	ld	s3,24(sp)
ffffffffc020ad30:	6a42                	ld	s4,16(sp)
ffffffffc020ad32:	6aa2                	ld	s5,8(sp)
ffffffffc020ad34:	8526                	mv	a0,s1
ffffffffc020ad36:	74a2                	ld	s1,40(sp)
ffffffffc020ad38:	6121                	addi	sp,sp,64
ffffffffc020ad3a:	8082                	ret
ffffffffc020ad3c:	4481                	li	s1,0
ffffffffc020ad3e:	b7d5                	j	ffffffffc020ad22 <sfs_wblock+0x42>

ffffffffc020ad40 <sfs_rbuf>:
ffffffffc020ad40:	7179                	addi	sp,sp,-48
ffffffffc020ad42:	f406                	sd	ra,40(sp)
ffffffffc020ad44:	f022                	sd	s0,32(sp)
ffffffffc020ad46:	ec26                	sd	s1,24(sp)
ffffffffc020ad48:	e84a                	sd	s2,16(sp)
ffffffffc020ad4a:	e44e                	sd	s3,8(sp)
ffffffffc020ad4c:	e052                	sd	s4,0(sp)
ffffffffc020ad4e:	6785                	lui	a5,0x1
ffffffffc020ad50:	04f77863          	bgeu	a4,a5,ffffffffc020ada0 <sfs_rbuf+0x60>
ffffffffc020ad54:	84ba                	mv	s1,a4
ffffffffc020ad56:	9732                	add	a4,a4,a2
ffffffffc020ad58:	89b2                	mv	s3,a2
ffffffffc020ad5a:	04e7e363          	bltu	a5,a4,ffffffffc020ada0 <sfs_rbuf+0x60>
ffffffffc020ad5e:	8936                	mv	s2,a3
ffffffffc020ad60:	842a                	mv	s0,a0
ffffffffc020ad62:	8a2e                	mv	s4,a1
ffffffffc020ad64:	214000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020ad68:	642c                	ld	a1,72(s0)
ffffffffc020ad6a:	864a                	mv	a2,s2
ffffffffc020ad6c:	4705                	li	a4,1
ffffffffc020ad6e:	4681                	li	a3,0
ffffffffc020ad70:	8522                	mv	a0,s0
ffffffffc020ad72:	eb7ff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020ad76:	892a                	mv	s2,a0
ffffffffc020ad78:	cd09                	beqz	a0,ffffffffc020ad92 <sfs_rbuf+0x52>
ffffffffc020ad7a:	8522                	mv	a0,s0
ffffffffc020ad7c:	20c000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020ad80:	70a2                	ld	ra,40(sp)
ffffffffc020ad82:	7402                	ld	s0,32(sp)
ffffffffc020ad84:	64e2                	ld	s1,24(sp)
ffffffffc020ad86:	69a2                	ld	s3,8(sp)
ffffffffc020ad88:	6a02                	ld	s4,0(sp)
ffffffffc020ad8a:	854a                	mv	a0,s2
ffffffffc020ad8c:	6942                	ld	s2,16(sp)
ffffffffc020ad8e:	6145                	addi	sp,sp,48
ffffffffc020ad90:	8082                	ret
ffffffffc020ad92:	642c                	ld	a1,72(s0)
ffffffffc020ad94:	864e                	mv	a2,s3
ffffffffc020ad96:	8552                	mv	a0,s4
ffffffffc020ad98:	95a6                	add	a1,a1,s1
ffffffffc020ad9a:	77c000ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020ad9e:	bff1                	j	ffffffffc020ad7a <sfs_rbuf+0x3a>
ffffffffc020ada0:	00004697          	auipc	a3,0x4
ffffffffc020ada4:	62868693          	addi	a3,a3,1576 # ffffffffc020f3c8 <sfs_node_fileops+0xd0>
ffffffffc020ada8:	00001617          	auipc	a2,0x1
ffffffffc020adac:	c0060613          	addi	a2,a2,-1024 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020adb0:	05500593          	li	a1,85
ffffffffc020adb4:	00004517          	auipc	a0,0x4
ffffffffc020adb8:	5fc50513          	addi	a0,a0,1532 # ffffffffc020f3b0 <sfs_node_fileops+0xb8>
ffffffffc020adbc:	ee2f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020adc0 <sfs_wbuf>:
ffffffffc020adc0:	7139                	addi	sp,sp,-64
ffffffffc020adc2:	fc06                	sd	ra,56(sp)
ffffffffc020adc4:	f822                	sd	s0,48(sp)
ffffffffc020adc6:	f426                	sd	s1,40(sp)
ffffffffc020adc8:	f04a                	sd	s2,32(sp)
ffffffffc020adca:	ec4e                	sd	s3,24(sp)
ffffffffc020adcc:	e852                	sd	s4,16(sp)
ffffffffc020adce:	e456                	sd	s5,8(sp)
ffffffffc020add0:	6785                	lui	a5,0x1
ffffffffc020add2:	06f77163          	bgeu	a4,a5,ffffffffc020ae34 <sfs_wbuf+0x74>
ffffffffc020add6:	893a                	mv	s2,a4
ffffffffc020add8:	9732                	add	a4,a4,a2
ffffffffc020adda:	8a32                	mv	s4,a2
ffffffffc020addc:	04e7ec63          	bltu	a5,a4,ffffffffc020ae34 <sfs_wbuf+0x74>
ffffffffc020ade0:	842a                	mv	s0,a0
ffffffffc020ade2:	89b6                	mv	s3,a3
ffffffffc020ade4:	8aae                	mv	s5,a1
ffffffffc020ade6:	192000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020adea:	642c                	ld	a1,72(s0)
ffffffffc020adec:	4705                	li	a4,1
ffffffffc020adee:	4681                	li	a3,0
ffffffffc020adf0:	864e                	mv	a2,s3
ffffffffc020adf2:	8522                	mv	a0,s0
ffffffffc020adf4:	e35ff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020adf8:	84aa                	mv	s1,a0
ffffffffc020adfa:	cd11                	beqz	a0,ffffffffc020ae16 <sfs_wbuf+0x56>
ffffffffc020adfc:	8522                	mv	a0,s0
ffffffffc020adfe:	18a000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020ae02:	70e2                	ld	ra,56(sp)
ffffffffc020ae04:	7442                	ld	s0,48(sp)
ffffffffc020ae06:	7902                	ld	s2,32(sp)
ffffffffc020ae08:	69e2                	ld	s3,24(sp)
ffffffffc020ae0a:	6a42                	ld	s4,16(sp)
ffffffffc020ae0c:	6aa2                	ld	s5,8(sp)
ffffffffc020ae0e:	8526                	mv	a0,s1
ffffffffc020ae10:	74a2                	ld	s1,40(sp)
ffffffffc020ae12:	6121                	addi	sp,sp,64
ffffffffc020ae14:	8082                	ret
ffffffffc020ae16:	6428                	ld	a0,72(s0)
ffffffffc020ae18:	8652                	mv	a2,s4
ffffffffc020ae1a:	85d6                	mv	a1,s5
ffffffffc020ae1c:	954a                	add	a0,a0,s2
ffffffffc020ae1e:	6f8000ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020ae22:	642c                	ld	a1,72(s0)
ffffffffc020ae24:	4705                	li	a4,1
ffffffffc020ae26:	4685                	li	a3,1
ffffffffc020ae28:	864e                	mv	a2,s3
ffffffffc020ae2a:	8522                	mv	a0,s0
ffffffffc020ae2c:	dfdff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020ae30:	84aa                	mv	s1,a0
ffffffffc020ae32:	b7e9                	j	ffffffffc020adfc <sfs_wbuf+0x3c>
ffffffffc020ae34:	00004697          	auipc	a3,0x4
ffffffffc020ae38:	59468693          	addi	a3,a3,1428 # ffffffffc020f3c8 <sfs_node_fileops+0xd0>
ffffffffc020ae3c:	00001617          	auipc	a2,0x1
ffffffffc020ae40:	b6c60613          	addi	a2,a2,-1172 # ffffffffc020b9a8 <commands+0x210>
ffffffffc020ae44:	06b00593          	li	a1,107
ffffffffc020ae48:	00004517          	auipc	a0,0x4
ffffffffc020ae4c:	56850513          	addi	a0,a0,1384 # ffffffffc020f3b0 <sfs_node_fileops+0xb8>
ffffffffc020ae50:	e4ef50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ae54 <sfs_sync_super>:
ffffffffc020ae54:	1101                	addi	sp,sp,-32
ffffffffc020ae56:	ec06                	sd	ra,24(sp)
ffffffffc020ae58:	e822                	sd	s0,16(sp)
ffffffffc020ae5a:	e426                	sd	s1,8(sp)
ffffffffc020ae5c:	842a                	mv	s0,a0
ffffffffc020ae5e:	11a000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020ae62:	6428                	ld	a0,72(s0)
ffffffffc020ae64:	6605                	lui	a2,0x1
ffffffffc020ae66:	4581                	li	a1,0
ffffffffc020ae68:	65c000ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc020ae6c:	6428                	ld	a0,72(s0)
ffffffffc020ae6e:	85a2                	mv	a1,s0
ffffffffc020ae70:	02c00613          	li	a2,44
ffffffffc020ae74:	6a2000ef          	jal	ra,ffffffffc020b516 <memcpy>
ffffffffc020ae78:	642c                	ld	a1,72(s0)
ffffffffc020ae7a:	4701                	li	a4,0
ffffffffc020ae7c:	4685                	li	a3,1
ffffffffc020ae7e:	4601                	li	a2,0
ffffffffc020ae80:	8522                	mv	a0,s0
ffffffffc020ae82:	da7ff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020ae86:	84aa                	mv	s1,a0
ffffffffc020ae88:	8522                	mv	a0,s0
ffffffffc020ae8a:	0fe000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020ae8e:	60e2                	ld	ra,24(sp)
ffffffffc020ae90:	6442                	ld	s0,16(sp)
ffffffffc020ae92:	8526                	mv	a0,s1
ffffffffc020ae94:	64a2                	ld	s1,8(sp)
ffffffffc020ae96:	6105                	addi	sp,sp,32
ffffffffc020ae98:	8082                	ret

ffffffffc020ae9a <sfs_sync_freemap>:
ffffffffc020ae9a:	7139                	addi	sp,sp,-64
ffffffffc020ae9c:	ec4e                	sd	s3,24(sp)
ffffffffc020ae9e:	e852                	sd	s4,16(sp)
ffffffffc020aea0:	00456983          	lwu	s3,4(a0)
ffffffffc020aea4:	8a2a                	mv	s4,a0
ffffffffc020aea6:	7d08                	ld	a0,56(a0)
ffffffffc020aea8:	67a1                	lui	a5,0x8
ffffffffc020aeaa:	17fd                	addi	a5,a5,-1
ffffffffc020aeac:	4581                	li	a1,0
ffffffffc020aeae:	f822                	sd	s0,48(sp)
ffffffffc020aeb0:	fc06                	sd	ra,56(sp)
ffffffffc020aeb2:	f426                	sd	s1,40(sp)
ffffffffc020aeb4:	f04a                	sd	s2,32(sp)
ffffffffc020aeb6:	e456                	sd	s5,8(sp)
ffffffffc020aeb8:	99be                	add	s3,s3,a5
ffffffffc020aeba:	a1cfe0ef          	jal	ra,ffffffffc02090d6 <bitmap_getdata>
ffffffffc020aebe:	00f9d993          	srli	s3,s3,0xf
ffffffffc020aec2:	842a                	mv	s0,a0
ffffffffc020aec4:	8552                	mv	a0,s4
ffffffffc020aec6:	0b2000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020aeca:	04098163          	beqz	s3,ffffffffc020af0c <sfs_sync_freemap+0x72>
ffffffffc020aece:	09b2                	slli	s3,s3,0xc
ffffffffc020aed0:	99a2                	add	s3,s3,s0
ffffffffc020aed2:	4909                	li	s2,2
ffffffffc020aed4:	6a85                	lui	s5,0x1
ffffffffc020aed6:	a021                	j	ffffffffc020aede <sfs_sync_freemap+0x44>
ffffffffc020aed8:	2905                	addiw	s2,s2,1
ffffffffc020aeda:	02898963          	beq	s3,s0,ffffffffc020af0c <sfs_sync_freemap+0x72>
ffffffffc020aede:	85a2                	mv	a1,s0
ffffffffc020aee0:	864a                	mv	a2,s2
ffffffffc020aee2:	4705                	li	a4,1
ffffffffc020aee4:	4685                	li	a3,1
ffffffffc020aee6:	8552                	mv	a0,s4
ffffffffc020aee8:	d41ff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020aeec:	84aa                	mv	s1,a0
ffffffffc020aeee:	9456                	add	s0,s0,s5
ffffffffc020aef0:	d565                	beqz	a0,ffffffffc020aed8 <sfs_sync_freemap+0x3e>
ffffffffc020aef2:	8552                	mv	a0,s4
ffffffffc020aef4:	094000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020aef8:	70e2                	ld	ra,56(sp)
ffffffffc020aefa:	7442                	ld	s0,48(sp)
ffffffffc020aefc:	7902                	ld	s2,32(sp)
ffffffffc020aefe:	69e2                	ld	s3,24(sp)
ffffffffc020af00:	6a42                	ld	s4,16(sp)
ffffffffc020af02:	6aa2                	ld	s5,8(sp)
ffffffffc020af04:	8526                	mv	a0,s1
ffffffffc020af06:	74a2                	ld	s1,40(sp)
ffffffffc020af08:	6121                	addi	sp,sp,64
ffffffffc020af0a:	8082                	ret
ffffffffc020af0c:	4481                	li	s1,0
ffffffffc020af0e:	b7d5                	j	ffffffffc020aef2 <sfs_sync_freemap+0x58>

ffffffffc020af10 <sfs_clear_block>:
ffffffffc020af10:	7179                	addi	sp,sp,-48
ffffffffc020af12:	f022                	sd	s0,32(sp)
ffffffffc020af14:	e84a                	sd	s2,16(sp)
ffffffffc020af16:	e44e                	sd	s3,8(sp)
ffffffffc020af18:	f406                	sd	ra,40(sp)
ffffffffc020af1a:	89b2                	mv	s3,a2
ffffffffc020af1c:	ec26                	sd	s1,24(sp)
ffffffffc020af1e:	892a                	mv	s2,a0
ffffffffc020af20:	842e                	mv	s0,a1
ffffffffc020af22:	056000ef          	jal	ra,ffffffffc020af78 <lock_sfs_io>
ffffffffc020af26:	04893503          	ld	a0,72(s2)
ffffffffc020af2a:	6605                	lui	a2,0x1
ffffffffc020af2c:	4581                	li	a1,0
ffffffffc020af2e:	596000ef          	jal	ra,ffffffffc020b4c4 <memset>
ffffffffc020af32:	02098d63          	beqz	s3,ffffffffc020af6c <sfs_clear_block+0x5c>
ffffffffc020af36:	013409bb          	addw	s3,s0,s3
ffffffffc020af3a:	a019                	j	ffffffffc020af40 <sfs_clear_block+0x30>
ffffffffc020af3c:	02898863          	beq	s3,s0,ffffffffc020af6c <sfs_clear_block+0x5c>
ffffffffc020af40:	04893583          	ld	a1,72(s2)
ffffffffc020af44:	8622                	mv	a2,s0
ffffffffc020af46:	4705                	li	a4,1
ffffffffc020af48:	4685                	li	a3,1
ffffffffc020af4a:	854a                	mv	a0,s2
ffffffffc020af4c:	cddff0ef          	jal	ra,ffffffffc020ac28 <sfs_rwblock_nolock>
ffffffffc020af50:	84aa                	mv	s1,a0
ffffffffc020af52:	2405                	addiw	s0,s0,1
ffffffffc020af54:	d565                	beqz	a0,ffffffffc020af3c <sfs_clear_block+0x2c>
ffffffffc020af56:	854a                	mv	a0,s2
ffffffffc020af58:	030000ef          	jal	ra,ffffffffc020af88 <unlock_sfs_io>
ffffffffc020af5c:	70a2                	ld	ra,40(sp)
ffffffffc020af5e:	7402                	ld	s0,32(sp)
ffffffffc020af60:	6942                	ld	s2,16(sp)
ffffffffc020af62:	69a2                	ld	s3,8(sp)
ffffffffc020af64:	8526                	mv	a0,s1
ffffffffc020af66:	64e2                	ld	s1,24(sp)
ffffffffc020af68:	6145                	addi	sp,sp,48
ffffffffc020af6a:	8082                	ret
ffffffffc020af6c:	4481                	li	s1,0
ffffffffc020af6e:	b7e5                	j	ffffffffc020af56 <sfs_clear_block+0x46>

ffffffffc020af70 <lock_sfs_fs>:
ffffffffc020af70:	05050513          	addi	a0,a0,80
ffffffffc020af74:	e40f906f          	j	ffffffffc02045b4 <down>

ffffffffc020af78 <lock_sfs_io>:
ffffffffc020af78:	06850513          	addi	a0,a0,104
ffffffffc020af7c:	e38f906f          	j	ffffffffc02045b4 <down>

ffffffffc020af80 <unlock_sfs_fs>:
ffffffffc020af80:	05050513          	addi	a0,a0,80
ffffffffc020af84:	e2cf906f          	j	ffffffffc02045b0 <up>

ffffffffc020af88 <unlock_sfs_io>:
ffffffffc020af88:	06850513          	addi	a0,a0,104
ffffffffc020af8c:	e24f906f          	j	ffffffffc02045b0 <up>

ffffffffc020af90 <hash32>:
ffffffffc020af90:	9e3707b7          	lui	a5,0x9e370
ffffffffc020af94:	2785                	addiw	a5,a5,1
ffffffffc020af96:	02a7853b          	mulw	a0,a5,a0
ffffffffc020af9a:	02000793          	li	a5,32
ffffffffc020af9e:	9f8d                	subw	a5,a5,a1
ffffffffc020afa0:	00f5553b          	srlw	a0,a0,a5
ffffffffc020afa4:	8082                	ret

ffffffffc020afa6 <printnum>:
ffffffffc020afa6:	02071893          	slli	a7,a4,0x20
ffffffffc020afaa:	7139                	addi	sp,sp,-64
ffffffffc020afac:	0208d893          	srli	a7,a7,0x20
ffffffffc020afb0:	e456                	sd	s5,8(sp)
ffffffffc020afb2:	0316fab3          	remu	s5,a3,a7
ffffffffc020afb6:	f822                	sd	s0,48(sp)
ffffffffc020afb8:	f426                	sd	s1,40(sp)
ffffffffc020afba:	f04a                	sd	s2,32(sp)
ffffffffc020afbc:	ec4e                	sd	s3,24(sp)
ffffffffc020afbe:	fc06                	sd	ra,56(sp)
ffffffffc020afc0:	e852                	sd	s4,16(sp)
ffffffffc020afc2:	84aa                	mv	s1,a0
ffffffffc020afc4:	89ae                	mv	s3,a1
ffffffffc020afc6:	8932                	mv	s2,a2
ffffffffc020afc8:	fff7841b          	addiw	s0,a5,-1
ffffffffc020afcc:	2a81                	sext.w	s5,s5
ffffffffc020afce:	0516f163          	bgeu	a3,a7,ffffffffc020b010 <printnum+0x6a>
ffffffffc020afd2:	8a42                	mv	s4,a6
ffffffffc020afd4:	00805863          	blez	s0,ffffffffc020afe4 <printnum+0x3e>
ffffffffc020afd8:	347d                	addiw	s0,s0,-1
ffffffffc020afda:	864e                	mv	a2,s3
ffffffffc020afdc:	85ca                	mv	a1,s2
ffffffffc020afde:	8552                	mv	a0,s4
ffffffffc020afe0:	9482                	jalr	s1
ffffffffc020afe2:	f87d                	bnez	s0,ffffffffc020afd8 <printnum+0x32>
ffffffffc020afe4:	1a82                	slli	s5,s5,0x20
ffffffffc020afe6:	00004797          	auipc	a5,0x4
ffffffffc020afea:	42a78793          	addi	a5,a5,1066 # ffffffffc020f410 <sfs_node_fileops+0x118>
ffffffffc020afee:	020ada93          	srli	s5,s5,0x20
ffffffffc020aff2:	9abe                	add	s5,s5,a5
ffffffffc020aff4:	7442                	ld	s0,48(sp)
ffffffffc020aff6:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020affa:	70e2                	ld	ra,56(sp)
ffffffffc020affc:	6a42                	ld	s4,16(sp)
ffffffffc020affe:	6aa2                	ld	s5,8(sp)
ffffffffc020b000:	864e                	mv	a2,s3
ffffffffc020b002:	85ca                	mv	a1,s2
ffffffffc020b004:	69e2                	ld	s3,24(sp)
ffffffffc020b006:	7902                	ld	s2,32(sp)
ffffffffc020b008:	87a6                	mv	a5,s1
ffffffffc020b00a:	74a2                	ld	s1,40(sp)
ffffffffc020b00c:	6121                	addi	sp,sp,64
ffffffffc020b00e:	8782                	jr	a5
ffffffffc020b010:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b014:	87a2                	mv	a5,s0
ffffffffc020b016:	f91ff0ef          	jal	ra,ffffffffc020afa6 <printnum>
ffffffffc020b01a:	b7e9                	j	ffffffffc020afe4 <printnum+0x3e>

ffffffffc020b01c <sprintputch>:
ffffffffc020b01c:	499c                	lw	a5,16(a1)
ffffffffc020b01e:	6198                	ld	a4,0(a1)
ffffffffc020b020:	6594                	ld	a3,8(a1)
ffffffffc020b022:	2785                	addiw	a5,a5,1
ffffffffc020b024:	c99c                	sw	a5,16(a1)
ffffffffc020b026:	00d77763          	bgeu	a4,a3,ffffffffc020b034 <sprintputch+0x18>
ffffffffc020b02a:	00170793          	addi	a5,a4,1
ffffffffc020b02e:	e19c                	sd	a5,0(a1)
ffffffffc020b030:	00a70023          	sb	a0,0(a4)
ffffffffc020b034:	8082                	ret

ffffffffc020b036 <vprintfmt>:
ffffffffc020b036:	7119                	addi	sp,sp,-128
ffffffffc020b038:	f4a6                	sd	s1,104(sp)
ffffffffc020b03a:	f0ca                	sd	s2,96(sp)
ffffffffc020b03c:	ecce                	sd	s3,88(sp)
ffffffffc020b03e:	e8d2                	sd	s4,80(sp)
ffffffffc020b040:	e4d6                	sd	s5,72(sp)
ffffffffc020b042:	e0da                	sd	s6,64(sp)
ffffffffc020b044:	fc5e                	sd	s7,56(sp)
ffffffffc020b046:	ec6e                	sd	s11,24(sp)
ffffffffc020b048:	fc86                	sd	ra,120(sp)
ffffffffc020b04a:	f8a2                	sd	s0,112(sp)
ffffffffc020b04c:	f862                	sd	s8,48(sp)
ffffffffc020b04e:	f466                	sd	s9,40(sp)
ffffffffc020b050:	f06a                	sd	s10,32(sp)
ffffffffc020b052:	89aa                	mv	s3,a0
ffffffffc020b054:	892e                	mv	s2,a1
ffffffffc020b056:	84b2                	mv	s1,a2
ffffffffc020b058:	8db6                	mv	s11,a3
ffffffffc020b05a:	8aba                	mv	s5,a4
ffffffffc020b05c:	02500a13          	li	s4,37
ffffffffc020b060:	5bfd                	li	s7,-1
ffffffffc020b062:	00004b17          	auipc	s6,0x4
ffffffffc020b066:	3dab0b13          	addi	s6,s6,986 # ffffffffc020f43c <sfs_node_fileops+0x144>
ffffffffc020b06a:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b06e:	001d8413          	addi	s0,s11,1
ffffffffc020b072:	01450b63          	beq	a0,s4,ffffffffc020b088 <vprintfmt+0x52>
ffffffffc020b076:	c129                	beqz	a0,ffffffffc020b0b8 <vprintfmt+0x82>
ffffffffc020b078:	864a                	mv	a2,s2
ffffffffc020b07a:	85a6                	mv	a1,s1
ffffffffc020b07c:	0405                	addi	s0,s0,1
ffffffffc020b07e:	9982                	jalr	s3
ffffffffc020b080:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b084:	ff4519e3          	bne	a0,s4,ffffffffc020b076 <vprintfmt+0x40>
ffffffffc020b088:	00044583          	lbu	a1,0(s0)
ffffffffc020b08c:	02000813          	li	a6,32
ffffffffc020b090:	4d01                	li	s10,0
ffffffffc020b092:	4301                	li	t1,0
ffffffffc020b094:	5cfd                	li	s9,-1
ffffffffc020b096:	5c7d                	li	s8,-1
ffffffffc020b098:	05500513          	li	a0,85
ffffffffc020b09c:	48a5                	li	a7,9
ffffffffc020b09e:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b0a2:	0ff67613          	zext.b	a2,a2
ffffffffc020b0a6:	00140d93          	addi	s11,s0,1
ffffffffc020b0aa:	04c56263          	bltu	a0,a2,ffffffffc020b0ee <vprintfmt+0xb8>
ffffffffc020b0ae:	060a                	slli	a2,a2,0x2
ffffffffc020b0b0:	965a                	add	a2,a2,s6
ffffffffc020b0b2:	4214                	lw	a3,0(a2)
ffffffffc020b0b4:	96da                	add	a3,a3,s6
ffffffffc020b0b6:	8682                	jr	a3
ffffffffc020b0b8:	70e6                	ld	ra,120(sp)
ffffffffc020b0ba:	7446                	ld	s0,112(sp)
ffffffffc020b0bc:	74a6                	ld	s1,104(sp)
ffffffffc020b0be:	7906                	ld	s2,96(sp)
ffffffffc020b0c0:	69e6                	ld	s3,88(sp)
ffffffffc020b0c2:	6a46                	ld	s4,80(sp)
ffffffffc020b0c4:	6aa6                	ld	s5,72(sp)
ffffffffc020b0c6:	6b06                	ld	s6,64(sp)
ffffffffc020b0c8:	7be2                	ld	s7,56(sp)
ffffffffc020b0ca:	7c42                	ld	s8,48(sp)
ffffffffc020b0cc:	7ca2                	ld	s9,40(sp)
ffffffffc020b0ce:	7d02                	ld	s10,32(sp)
ffffffffc020b0d0:	6de2                	ld	s11,24(sp)
ffffffffc020b0d2:	6109                	addi	sp,sp,128
ffffffffc020b0d4:	8082                	ret
ffffffffc020b0d6:	882e                	mv	a6,a1
ffffffffc020b0d8:	00144583          	lbu	a1,1(s0)
ffffffffc020b0dc:	846e                	mv	s0,s11
ffffffffc020b0de:	00140d93          	addi	s11,s0,1
ffffffffc020b0e2:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b0e6:	0ff67613          	zext.b	a2,a2
ffffffffc020b0ea:	fcc572e3          	bgeu	a0,a2,ffffffffc020b0ae <vprintfmt+0x78>
ffffffffc020b0ee:	864a                	mv	a2,s2
ffffffffc020b0f0:	85a6                	mv	a1,s1
ffffffffc020b0f2:	02500513          	li	a0,37
ffffffffc020b0f6:	9982                	jalr	s3
ffffffffc020b0f8:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b0fc:	8da2                	mv	s11,s0
ffffffffc020b0fe:	f74786e3          	beq	a5,s4,ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b102:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b106:	1dfd                	addi	s11,s11,-1
ffffffffc020b108:	ff479de3          	bne	a5,s4,ffffffffc020b102 <vprintfmt+0xcc>
ffffffffc020b10c:	bfb9                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b10e:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b112:	00144583          	lbu	a1,1(s0)
ffffffffc020b116:	846e                	mv	s0,s11
ffffffffc020b118:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b11c:	0005861b          	sext.w	a2,a1
ffffffffc020b120:	02d8e463          	bltu	a7,a3,ffffffffc020b148 <vprintfmt+0x112>
ffffffffc020b124:	00144583          	lbu	a1,1(s0)
ffffffffc020b128:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b12c:	0196873b          	addw	a4,a3,s9
ffffffffc020b130:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b134:	9f31                	addw	a4,a4,a2
ffffffffc020b136:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b13a:	0405                	addi	s0,s0,1
ffffffffc020b13c:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b140:	0005861b          	sext.w	a2,a1
ffffffffc020b144:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b124 <vprintfmt+0xee>
ffffffffc020b148:	f40c5be3          	bgez	s8,ffffffffc020b09e <vprintfmt+0x68>
ffffffffc020b14c:	8c66                	mv	s8,s9
ffffffffc020b14e:	5cfd                	li	s9,-1
ffffffffc020b150:	b7b9                	j	ffffffffc020b09e <vprintfmt+0x68>
ffffffffc020b152:	fffc4693          	not	a3,s8
ffffffffc020b156:	96fd                	srai	a3,a3,0x3f
ffffffffc020b158:	00dc77b3          	and	a5,s8,a3
ffffffffc020b15c:	00144583          	lbu	a1,1(s0)
ffffffffc020b160:	00078c1b          	sext.w	s8,a5
ffffffffc020b164:	846e                	mv	s0,s11
ffffffffc020b166:	bf25                	j	ffffffffc020b09e <vprintfmt+0x68>
ffffffffc020b168:	000aac83          	lw	s9,0(s5)
ffffffffc020b16c:	00144583          	lbu	a1,1(s0)
ffffffffc020b170:	0aa1                	addi	s5,s5,8
ffffffffc020b172:	846e                	mv	s0,s11
ffffffffc020b174:	bfd1                	j	ffffffffc020b148 <vprintfmt+0x112>
ffffffffc020b176:	4705                	li	a4,1
ffffffffc020b178:	008a8613          	addi	a2,s5,8
ffffffffc020b17c:	00674463          	blt	a4,t1,ffffffffc020b184 <vprintfmt+0x14e>
ffffffffc020b180:	1c030c63          	beqz	t1,ffffffffc020b358 <vprintfmt+0x322>
ffffffffc020b184:	000ab683          	ld	a3,0(s5)
ffffffffc020b188:	4741                	li	a4,16
ffffffffc020b18a:	8ab2                	mv	s5,a2
ffffffffc020b18c:	2801                	sext.w	a6,a6
ffffffffc020b18e:	87e2                	mv	a5,s8
ffffffffc020b190:	8626                	mv	a2,s1
ffffffffc020b192:	85ca                	mv	a1,s2
ffffffffc020b194:	854e                	mv	a0,s3
ffffffffc020b196:	e11ff0ef          	jal	ra,ffffffffc020afa6 <printnum>
ffffffffc020b19a:	bdc1                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b19c:	000aa503          	lw	a0,0(s5)
ffffffffc020b1a0:	864a                	mv	a2,s2
ffffffffc020b1a2:	85a6                	mv	a1,s1
ffffffffc020b1a4:	0aa1                	addi	s5,s5,8
ffffffffc020b1a6:	9982                	jalr	s3
ffffffffc020b1a8:	b5c9                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b1aa:	4705                	li	a4,1
ffffffffc020b1ac:	008a8613          	addi	a2,s5,8
ffffffffc020b1b0:	00674463          	blt	a4,t1,ffffffffc020b1b8 <vprintfmt+0x182>
ffffffffc020b1b4:	18030d63          	beqz	t1,ffffffffc020b34e <vprintfmt+0x318>
ffffffffc020b1b8:	000ab683          	ld	a3,0(s5)
ffffffffc020b1bc:	4729                	li	a4,10
ffffffffc020b1be:	8ab2                	mv	s5,a2
ffffffffc020b1c0:	b7f1                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b1c2:	00144583          	lbu	a1,1(s0)
ffffffffc020b1c6:	4d05                	li	s10,1
ffffffffc020b1c8:	846e                	mv	s0,s11
ffffffffc020b1ca:	bdd1                	j	ffffffffc020b09e <vprintfmt+0x68>
ffffffffc020b1cc:	864a                	mv	a2,s2
ffffffffc020b1ce:	85a6                	mv	a1,s1
ffffffffc020b1d0:	02500513          	li	a0,37
ffffffffc020b1d4:	9982                	jalr	s3
ffffffffc020b1d6:	bd51                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b1d8:	00144583          	lbu	a1,1(s0)
ffffffffc020b1dc:	2305                	addiw	t1,t1,1
ffffffffc020b1de:	846e                	mv	s0,s11
ffffffffc020b1e0:	bd7d                	j	ffffffffc020b09e <vprintfmt+0x68>
ffffffffc020b1e2:	4705                	li	a4,1
ffffffffc020b1e4:	008a8613          	addi	a2,s5,8
ffffffffc020b1e8:	00674463          	blt	a4,t1,ffffffffc020b1f0 <vprintfmt+0x1ba>
ffffffffc020b1ec:	14030c63          	beqz	t1,ffffffffc020b344 <vprintfmt+0x30e>
ffffffffc020b1f0:	000ab683          	ld	a3,0(s5)
ffffffffc020b1f4:	4721                	li	a4,8
ffffffffc020b1f6:	8ab2                	mv	s5,a2
ffffffffc020b1f8:	bf51                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b1fa:	03000513          	li	a0,48
ffffffffc020b1fe:	864a                	mv	a2,s2
ffffffffc020b200:	85a6                	mv	a1,s1
ffffffffc020b202:	e042                	sd	a6,0(sp)
ffffffffc020b204:	9982                	jalr	s3
ffffffffc020b206:	864a                	mv	a2,s2
ffffffffc020b208:	85a6                	mv	a1,s1
ffffffffc020b20a:	07800513          	li	a0,120
ffffffffc020b20e:	9982                	jalr	s3
ffffffffc020b210:	0aa1                	addi	s5,s5,8
ffffffffc020b212:	6802                	ld	a6,0(sp)
ffffffffc020b214:	4741                	li	a4,16
ffffffffc020b216:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b21a:	bf8d                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b21c:	000ab403          	ld	s0,0(s5)
ffffffffc020b220:	008a8793          	addi	a5,s5,8
ffffffffc020b224:	e03e                	sd	a5,0(sp)
ffffffffc020b226:	14040c63          	beqz	s0,ffffffffc020b37e <vprintfmt+0x348>
ffffffffc020b22a:	11805063          	blez	s8,ffffffffc020b32a <vprintfmt+0x2f4>
ffffffffc020b22e:	02d00693          	li	a3,45
ffffffffc020b232:	0cd81963          	bne	a6,a3,ffffffffc020b304 <vprintfmt+0x2ce>
ffffffffc020b236:	00044683          	lbu	a3,0(s0)
ffffffffc020b23a:	0006851b          	sext.w	a0,a3
ffffffffc020b23e:	ce8d                	beqz	a3,ffffffffc020b278 <vprintfmt+0x242>
ffffffffc020b240:	00140a93          	addi	s5,s0,1
ffffffffc020b244:	05e00413          	li	s0,94
ffffffffc020b248:	000cc563          	bltz	s9,ffffffffc020b252 <vprintfmt+0x21c>
ffffffffc020b24c:	3cfd                	addiw	s9,s9,-1
ffffffffc020b24e:	037c8363          	beq	s9,s7,ffffffffc020b274 <vprintfmt+0x23e>
ffffffffc020b252:	864a                	mv	a2,s2
ffffffffc020b254:	85a6                	mv	a1,s1
ffffffffc020b256:	100d0663          	beqz	s10,ffffffffc020b362 <vprintfmt+0x32c>
ffffffffc020b25a:	3681                	addiw	a3,a3,-32
ffffffffc020b25c:	10d47363          	bgeu	s0,a3,ffffffffc020b362 <vprintfmt+0x32c>
ffffffffc020b260:	03f00513          	li	a0,63
ffffffffc020b264:	9982                	jalr	s3
ffffffffc020b266:	000ac683          	lbu	a3,0(s5)
ffffffffc020b26a:	3c7d                	addiw	s8,s8,-1
ffffffffc020b26c:	0a85                	addi	s5,s5,1
ffffffffc020b26e:	0006851b          	sext.w	a0,a3
ffffffffc020b272:	faf9                	bnez	a3,ffffffffc020b248 <vprintfmt+0x212>
ffffffffc020b274:	01805a63          	blez	s8,ffffffffc020b288 <vprintfmt+0x252>
ffffffffc020b278:	3c7d                	addiw	s8,s8,-1
ffffffffc020b27a:	864a                	mv	a2,s2
ffffffffc020b27c:	85a6                	mv	a1,s1
ffffffffc020b27e:	02000513          	li	a0,32
ffffffffc020b282:	9982                	jalr	s3
ffffffffc020b284:	fe0c1ae3          	bnez	s8,ffffffffc020b278 <vprintfmt+0x242>
ffffffffc020b288:	6a82                	ld	s5,0(sp)
ffffffffc020b28a:	b3c5                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b28c:	4705                	li	a4,1
ffffffffc020b28e:	008a8d13          	addi	s10,s5,8
ffffffffc020b292:	00674463          	blt	a4,t1,ffffffffc020b29a <vprintfmt+0x264>
ffffffffc020b296:	0a030463          	beqz	t1,ffffffffc020b33e <vprintfmt+0x308>
ffffffffc020b29a:	000ab403          	ld	s0,0(s5)
ffffffffc020b29e:	0c044463          	bltz	s0,ffffffffc020b366 <vprintfmt+0x330>
ffffffffc020b2a2:	86a2                	mv	a3,s0
ffffffffc020b2a4:	8aea                	mv	s5,s10
ffffffffc020b2a6:	4729                	li	a4,10
ffffffffc020b2a8:	b5d5                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b2aa:	000aa783          	lw	a5,0(s5)
ffffffffc020b2ae:	46e1                	li	a3,24
ffffffffc020b2b0:	0aa1                	addi	s5,s5,8
ffffffffc020b2b2:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b2b6:	8fb9                	xor	a5,a5,a4
ffffffffc020b2b8:	40e7873b          	subw	a4,a5,a4
ffffffffc020b2bc:	02e6c663          	blt	a3,a4,ffffffffc020b2e8 <vprintfmt+0x2b2>
ffffffffc020b2c0:	00371793          	slli	a5,a4,0x3
ffffffffc020b2c4:	00004697          	auipc	a3,0x4
ffffffffc020b2c8:	4ac68693          	addi	a3,a3,1196 # ffffffffc020f770 <error_string>
ffffffffc020b2cc:	97b6                	add	a5,a5,a3
ffffffffc020b2ce:	639c                	ld	a5,0(a5)
ffffffffc020b2d0:	cf81                	beqz	a5,ffffffffc020b2e8 <vprintfmt+0x2b2>
ffffffffc020b2d2:	873e                	mv	a4,a5
ffffffffc020b2d4:	00000697          	auipc	a3,0x0
ffffffffc020b2d8:	28468693          	addi	a3,a3,644 # ffffffffc020b558 <etext+0x2a>
ffffffffc020b2dc:	8626                	mv	a2,s1
ffffffffc020b2de:	85ca                	mv	a1,s2
ffffffffc020b2e0:	854e                	mv	a0,s3
ffffffffc020b2e2:	0d4000ef          	jal	ra,ffffffffc020b3b6 <printfmt>
ffffffffc020b2e6:	b351                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b2e8:	00004697          	auipc	a3,0x4
ffffffffc020b2ec:	14868693          	addi	a3,a3,328 # ffffffffc020f430 <sfs_node_fileops+0x138>
ffffffffc020b2f0:	8626                	mv	a2,s1
ffffffffc020b2f2:	85ca                	mv	a1,s2
ffffffffc020b2f4:	854e                	mv	a0,s3
ffffffffc020b2f6:	0c0000ef          	jal	ra,ffffffffc020b3b6 <printfmt>
ffffffffc020b2fa:	bb85                	j	ffffffffc020b06a <vprintfmt+0x34>
ffffffffc020b2fc:	00004417          	auipc	s0,0x4
ffffffffc020b300:	12c40413          	addi	s0,s0,300 # ffffffffc020f428 <sfs_node_fileops+0x130>
ffffffffc020b304:	85e6                	mv	a1,s9
ffffffffc020b306:	8522                	mv	a0,s0
ffffffffc020b308:	e442                	sd	a6,8(sp)
ffffffffc020b30a:	132000ef          	jal	ra,ffffffffc020b43c <strnlen>
ffffffffc020b30e:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b312:	01805c63          	blez	s8,ffffffffc020b32a <vprintfmt+0x2f4>
ffffffffc020b316:	6822                	ld	a6,8(sp)
ffffffffc020b318:	00080a9b          	sext.w	s5,a6
ffffffffc020b31c:	3c7d                	addiw	s8,s8,-1
ffffffffc020b31e:	864a                	mv	a2,s2
ffffffffc020b320:	85a6                	mv	a1,s1
ffffffffc020b322:	8556                	mv	a0,s5
ffffffffc020b324:	9982                	jalr	s3
ffffffffc020b326:	fe0c1be3          	bnez	s8,ffffffffc020b31c <vprintfmt+0x2e6>
ffffffffc020b32a:	00044683          	lbu	a3,0(s0)
ffffffffc020b32e:	00140a93          	addi	s5,s0,1
ffffffffc020b332:	0006851b          	sext.w	a0,a3
ffffffffc020b336:	daa9                	beqz	a3,ffffffffc020b288 <vprintfmt+0x252>
ffffffffc020b338:	05e00413          	li	s0,94
ffffffffc020b33c:	b731                	j	ffffffffc020b248 <vprintfmt+0x212>
ffffffffc020b33e:	000aa403          	lw	s0,0(s5)
ffffffffc020b342:	bfb1                	j	ffffffffc020b29e <vprintfmt+0x268>
ffffffffc020b344:	000ae683          	lwu	a3,0(s5)
ffffffffc020b348:	4721                	li	a4,8
ffffffffc020b34a:	8ab2                	mv	s5,a2
ffffffffc020b34c:	b581                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b34e:	000ae683          	lwu	a3,0(s5)
ffffffffc020b352:	4729                	li	a4,10
ffffffffc020b354:	8ab2                	mv	s5,a2
ffffffffc020b356:	bd1d                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b358:	000ae683          	lwu	a3,0(s5)
ffffffffc020b35c:	4741                	li	a4,16
ffffffffc020b35e:	8ab2                	mv	s5,a2
ffffffffc020b360:	b535                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b362:	9982                	jalr	s3
ffffffffc020b364:	b709                	j	ffffffffc020b266 <vprintfmt+0x230>
ffffffffc020b366:	864a                	mv	a2,s2
ffffffffc020b368:	85a6                	mv	a1,s1
ffffffffc020b36a:	02d00513          	li	a0,45
ffffffffc020b36e:	e042                	sd	a6,0(sp)
ffffffffc020b370:	9982                	jalr	s3
ffffffffc020b372:	6802                	ld	a6,0(sp)
ffffffffc020b374:	8aea                	mv	s5,s10
ffffffffc020b376:	408006b3          	neg	a3,s0
ffffffffc020b37a:	4729                	li	a4,10
ffffffffc020b37c:	bd01                	j	ffffffffc020b18c <vprintfmt+0x156>
ffffffffc020b37e:	03805163          	blez	s8,ffffffffc020b3a0 <vprintfmt+0x36a>
ffffffffc020b382:	02d00693          	li	a3,45
ffffffffc020b386:	f6d81be3          	bne	a6,a3,ffffffffc020b2fc <vprintfmt+0x2c6>
ffffffffc020b38a:	00004417          	auipc	s0,0x4
ffffffffc020b38e:	09e40413          	addi	s0,s0,158 # ffffffffc020f428 <sfs_node_fileops+0x130>
ffffffffc020b392:	02800693          	li	a3,40
ffffffffc020b396:	02800513          	li	a0,40
ffffffffc020b39a:	00140a93          	addi	s5,s0,1
ffffffffc020b39e:	b55d                	j	ffffffffc020b244 <vprintfmt+0x20e>
ffffffffc020b3a0:	00004a97          	auipc	s5,0x4
ffffffffc020b3a4:	089a8a93          	addi	s5,s5,137 # ffffffffc020f429 <sfs_node_fileops+0x131>
ffffffffc020b3a8:	02800513          	li	a0,40
ffffffffc020b3ac:	02800693          	li	a3,40
ffffffffc020b3b0:	05e00413          	li	s0,94
ffffffffc020b3b4:	bd51                	j	ffffffffc020b248 <vprintfmt+0x212>

ffffffffc020b3b6 <printfmt>:
ffffffffc020b3b6:	7139                	addi	sp,sp,-64
ffffffffc020b3b8:	02010313          	addi	t1,sp,32
ffffffffc020b3bc:	f03a                	sd	a4,32(sp)
ffffffffc020b3be:	871a                	mv	a4,t1
ffffffffc020b3c0:	ec06                	sd	ra,24(sp)
ffffffffc020b3c2:	f43e                	sd	a5,40(sp)
ffffffffc020b3c4:	f842                	sd	a6,48(sp)
ffffffffc020b3c6:	fc46                	sd	a7,56(sp)
ffffffffc020b3c8:	e41a                	sd	t1,8(sp)
ffffffffc020b3ca:	c6dff0ef          	jal	ra,ffffffffc020b036 <vprintfmt>
ffffffffc020b3ce:	60e2                	ld	ra,24(sp)
ffffffffc020b3d0:	6121                	addi	sp,sp,64
ffffffffc020b3d2:	8082                	ret

ffffffffc020b3d4 <snprintf>:
ffffffffc020b3d4:	711d                	addi	sp,sp,-96
ffffffffc020b3d6:	15fd                	addi	a1,a1,-1
ffffffffc020b3d8:	03810313          	addi	t1,sp,56
ffffffffc020b3dc:	95aa                	add	a1,a1,a0
ffffffffc020b3de:	f406                	sd	ra,40(sp)
ffffffffc020b3e0:	fc36                	sd	a3,56(sp)
ffffffffc020b3e2:	e0ba                	sd	a4,64(sp)
ffffffffc020b3e4:	e4be                	sd	a5,72(sp)
ffffffffc020b3e6:	e8c2                	sd	a6,80(sp)
ffffffffc020b3e8:	ecc6                	sd	a7,88(sp)
ffffffffc020b3ea:	e01a                	sd	t1,0(sp)
ffffffffc020b3ec:	e42a                	sd	a0,8(sp)
ffffffffc020b3ee:	e82e                	sd	a1,16(sp)
ffffffffc020b3f0:	cc02                	sw	zero,24(sp)
ffffffffc020b3f2:	c515                	beqz	a0,ffffffffc020b41e <snprintf+0x4a>
ffffffffc020b3f4:	02a5e563          	bltu	a1,a0,ffffffffc020b41e <snprintf+0x4a>
ffffffffc020b3f8:	75dd                	lui	a1,0xffff7
ffffffffc020b3fa:	86b2                	mv	a3,a2
ffffffffc020b3fc:	00000517          	auipc	a0,0x0
ffffffffc020b400:	c2050513          	addi	a0,a0,-992 # ffffffffc020b01c <sprintputch>
ffffffffc020b404:	871a                	mv	a4,t1
ffffffffc020b406:	0030                	addi	a2,sp,8
ffffffffc020b408:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b40c:	c2bff0ef          	jal	ra,ffffffffc020b036 <vprintfmt>
ffffffffc020b410:	67a2                	ld	a5,8(sp)
ffffffffc020b412:	00078023          	sb	zero,0(a5)
ffffffffc020b416:	4562                	lw	a0,24(sp)
ffffffffc020b418:	70a2                	ld	ra,40(sp)
ffffffffc020b41a:	6125                	addi	sp,sp,96
ffffffffc020b41c:	8082                	ret
ffffffffc020b41e:	5575                	li	a0,-3
ffffffffc020b420:	bfe5                	j	ffffffffc020b418 <snprintf+0x44>

ffffffffc020b422 <strlen>:
ffffffffc020b422:	00054783          	lbu	a5,0(a0)
ffffffffc020b426:	872a                	mv	a4,a0
ffffffffc020b428:	4501                	li	a0,0
ffffffffc020b42a:	cb81                	beqz	a5,ffffffffc020b43a <strlen+0x18>
ffffffffc020b42c:	0505                	addi	a0,a0,1
ffffffffc020b42e:	00a707b3          	add	a5,a4,a0
ffffffffc020b432:	0007c783          	lbu	a5,0(a5)
ffffffffc020b436:	fbfd                	bnez	a5,ffffffffc020b42c <strlen+0xa>
ffffffffc020b438:	8082                	ret
ffffffffc020b43a:	8082                	ret

ffffffffc020b43c <strnlen>:
ffffffffc020b43c:	4781                	li	a5,0
ffffffffc020b43e:	e589                	bnez	a1,ffffffffc020b448 <strnlen+0xc>
ffffffffc020b440:	a811                	j	ffffffffc020b454 <strnlen+0x18>
ffffffffc020b442:	0785                	addi	a5,a5,1
ffffffffc020b444:	00f58863          	beq	a1,a5,ffffffffc020b454 <strnlen+0x18>
ffffffffc020b448:	00f50733          	add	a4,a0,a5
ffffffffc020b44c:	00074703          	lbu	a4,0(a4)
ffffffffc020b450:	fb6d                	bnez	a4,ffffffffc020b442 <strnlen+0x6>
ffffffffc020b452:	85be                	mv	a1,a5
ffffffffc020b454:	852e                	mv	a0,a1
ffffffffc020b456:	8082                	ret

ffffffffc020b458 <strcpy>:
ffffffffc020b458:	87aa                	mv	a5,a0
ffffffffc020b45a:	0005c703          	lbu	a4,0(a1)
ffffffffc020b45e:	0785                	addi	a5,a5,1
ffffffffc020b460:	0585                	addi	a1,a1,1
ffffffffc020b462:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b466:	fb75                	bnez	a4,ffffffffc020b45a <strcpy+0x2>
ffffffffc020b468:	8082                	ret

ffffffffc020b46a <strcmp>:
ffffffffc020b46a:	00054783          	lbu	a5,0(a0)
ffffffffc020b46e:	0005c703          	lbu	a4,0(a1)
ffffffffc020b472:	cb89                	beqz	a5,ffffffffc020b484 <strcmp+0x1a>
ffffffffc020b474:	0505                	addi	a0,a0,1
ffffffffc020b476:	0585                	addi	a1,a1,1
ffffffffc020b478:	fee789e3          	beq	a5,a4,ffffffffc020b46a <strcmp>
ffffffffc020b47c:	0007851b          	sext.w	a0,a5
ffffffffc020b480:	9d19                	subw	a0,a0,a4
ffffffffc020b482:	8082                	ret
ffffffffc020b484:	4501                	li	a0,0
ffffffffc020b486:	bfed                	j	ffffffffc020b480 <strcmp+0x16>

ffffffffc020b488 <strncmp>:
ffffffffc020b488:	c20d                	beqz	a2,ffffffffc020b4aa <strncmp+0x22>
ffffffffc020b48a:	962e                	add	a2,a2,a1
ffffffffc020b48c:	a031                	j	ffffffffc020b498 <strncmp+0x10>
ffffffffc020b48e:	0505                	addi	a0,a0,1
ffffffffc020b490:	00e79a63          	bne	a5,a4,ffffffffc020b4a4 <strncmp+0x1c>
ffffffffc020b494:	00b60b63          	beq	a2,a1,ffffffffc020b4aa <strncmp+0x22>
ffffffffc020b498:	00054783          	lbu	a5,0(a0)
ffffffffc020b49c:	0585                	addi	a1,a1,1
ffffffffc020b49e:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b4a2:	f7f5                	bnez	a5,ffffffffc020b48e <strncmp+0x6>
ffffffffc020b4a4:	40e7853b          	subw	a0,a5,a4
ffffffffc020b4a8:	8082                	ret
ffffffffc020b4aa:	4501                	li	a0,0
ffffffffc020b4ac:	8082                	ret

ffffffffc020b4ae <strchr>:
ffffffffc020b4ae:	00054783          	lbu	a5,0(a0)
ffffffffc020b4b2:	c799                	beqz	a5,ffffffffc020b4c0 <strchr+0x12>
ffffffffc020b4b4:	00f58763          	beq	a1,a5,ffffffffc020b4c2 <strchr+0x14>
ffffffffc020b4b8:	00154783          	lbu	a5,1(a0)
ffffffffc020b4bc:	0505                	addi	a0,a0,1
ffffffffc020b4be:	fbfd                	bnez	a5,ffffffffc020b4b4 <strchr+0x6>
ffffffffc020b4c0:	4501                	li	a0,0
ffffffffc020b4c2:	8082                	ret

ffffffffc020b4c4 <memset>:
ffffffffc020b4c4:	ca01                	beqz	a2,ffffffffc020b4d4 <memset+0x10>
ffffffffc020b4c6:	962a                	add	a2,a2,a0
ffffffffc020b4c8:	87aa                	mv	a5,a0
ffffffffc020b4ca:	0785                	addi	a5,a5,1
ffffffffc020b4cc:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b4d0:	fec79de3          	bne	a5,a2,ffffffffc020b4ca <memset+0x6>
ffffffffc020b4d4:	8082                	ret

ffffffffc020b4d6 <memmove>:
ffffffffc020b4d6:	02a5f263          	bgeu	a1,a0,ffffffffc020b4fa <memmove+0x24>
ffffffffc020b4da:	00c587b3          	add	a5,a1,a2
ffffffffc020b4de:	00f57e63          	bgeu	a0,a5,ffffffffc020b4fa <memmove+0x24>
ffffffffc020b4e2:	00c50733          	add	a4,a0,a2
ffffffffc020b4e6:	c615                	beqz	a2,ffffffffc020b512 <memmove+0x3c>
ffffffffc020b4e8:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b4ec:	17fd                	addi	a5,a5,-1
ffffffffc020b4ee:	177d                	addi	a4,a4,-1
ffffffffc020b4f0:	00d70023          	sb	a3,0(a4)
ffffffffc020b4f4:	fef59ae3          	bne	a1,a5,ffffffffc020b4e8 <memmove+0x12>
ffffffffc020b4f8:	8082                	ret
ffffffffc020b4fa:	00c586b3          	add	a3,a1,a2
ffffffffc020b4fe:	87aa                	mv	a5,a0
ffffffffc020b500:	ca11                	beqz	a2,ffffffffc020b514 <memmove+0x3e>
ffffffffc020b502:	0005c703          	lbu	a4,0(a1)
ffffffffc020b506:	0585                	addi	a1,a1,1
ffffffffc020b508:	0785                	addi	a5,a5,1
ffffffffc020b50a:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b50e:	fed59ae3          	bne	a1,a3,ffffffffc020b502 <memmove+0x2c>
ffffffffc020b512:	8082                	ret
ffffffffc020b514:	8082                	ret

ffffffffc020b516 <memcpy>:
ffffffffc020b516:	ca19                	beqz	a2,ffffffffc020b52c <memcpy+0x16>
ffffffffc020b518:	962e                	add	a2,a2,a1
ffffffffc020b51a:	87aa                	mv	a5,a0
ffffffffc020b51c:	0005c703          	lbu	a4,0(a1)
ffffffffc020b520:	0585                	addi	a1,a1,1
ffffffffc020b522:	0785                	addi	a5,a5,1
ffffffffc020b524:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b528:	fec59ae3          	bne	a1,a2,ffffffffc020b51c <memcpy+0x6>
ffffffffc020b52c:	8082                	ret
