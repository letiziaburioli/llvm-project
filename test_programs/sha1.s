	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0_m2p0_a2p0_c2p0"
	.file	"sha1.c"
	.globl	message_block_process
	.p2align	1
	.type	message_block_process,@function
message_block_process:
	addi	sp, sp, -368
	sd	s0, 360(sp)
	sd	s1, 352(sp)
	sd	s2, 344(sp)
	sd	s3, 336(sp)
	sd	s4, 328(sp)
	li	a1, 0
	addi	a6, sp, 8
	li	a3, 64
.LBB0_1:
	add	a4, a0, a1
	lb	a5, 28(a4)
	lbu	s1, 29(a4)
	slli	a5, a5, 24
	slli	s1, s1, 16
	lbu	s0, 30(a4)
	or	a5, a5, s1
	lbu	a4, 31(a4)
	add	a2, a6, a1
	slli	s0, s0, 8
	or	a5, a5, s0
	or	a4, a4, a5
	addi	a1, a1, 4
	sw	a4, 0(a2)
	bne	a1, a3, .LBB0_1
	li	a1, 0
	addi	a6, sp, 8
	li	a3, 256
.LBB0_3:
	add	a4, a6, a1
	lw	a5, 52(a4)
	lw	s1, 32(a4)
	lw	s0, 8(a4)
	lw	a2, 0(a4)
	xor	a5, a5, s1
	xor	a5, a5, s0
	xor	a2, a2, a5
	srliw	a5, a2, 31
	slli	a2, a2, 1
	or	a2, a2, a5
	addi	a1, a1, 4
	sw	a2, 64(a4)
	bne	a1, a3, .LBB0_3
	li	s3, 0
	lw	t2, 0(a0)
	lw	t1, 4(a0)
	lw	t0, 8(a0)
	lw	a7, 12(a0)
	lw	a6, 16(a0)
	addi	t3, sp, 8
	lui	a1, 370728
	addiw	t6, a1, -1639
	li	t5, 80
	mv	s2, a6
	mv	s1, a7
	mv	a3, t0
	mv	a4, t1
	mv	a5, t2
.LBB0_5:
	mv	a2, a5
	mv	a1, a3
	mv	t4, s1
	srliw	a3, a5, 27
	slliw	a5, a5, 5
	or	a3, a3, a5
	and	a5, a1, a4
	not	s1, a4
	and	s1, t4, s1
	add	s0, t3, s3
	lw	s0, 0(s0)
	addw	a3, a3, a5
	addw	a3, a3, s1
	addw	a3, a3, s2
	addw	a3, a3, s0
	addw	a5, a3, t6
	srliw	a3, a4, 2
	slliw	a4, a4, 30
	addi	s3, s3, 4
	or	a3, a3, a4
	mv	s2, t4
	mv	s1, a1
	mv	a4, a2
	bne	s3, t5, .LBB0_5
	li	s0, 80
	addi	t6, sp, 8
	lui	a4, 454047
	addiw	a4, a4, -1119
	li	s2, 160
.LBB0_7:
	mv	s1, a5
	mv	t5, a3
	mv	t3, a1
	srliw	a1, a5, 27
	slliw	a3, a5, 5
	or	a1, a1, a3
	xor	a3, t5, a2
	add	a5, t6, s0
	lw	a5, 0(a5)
	xor	a3, a3, t3
	addw	a1, a1, a3
	addw	a1, a1, t4
	addw	a1, a1, a5
	addw	a5, a1, a4
	srliw	a1, a2, 2
	slliw	a3, a2, 30
	addi	s0, s0, 4
	or	a3, a3, a1
	mv	t4, t3
	mv	a1, t5
	mv	a2, s1
	bne	s0, s2, .LBB0_7
	li	t6, 160
	addi	s2, sp, 8
	lui	a1, 586172
	addiw	s4, a1, -804
	li	s3, 240
.LBB0_9:
	mv	a4, a5
	mv	a1, a3
	mv	t4, t5
	srliw	a3, a5, 27
	slliw	a5, a5, 5
	or	a3, a3, a5
	or	a5, t5, a1
	and	a5, a5, s1
	and	s0, t5, a1
	add	a2, s2, t6
	lw	a2, 0(a2)
	or	a5, a5, s0
	addw	a3, a3, t3
	addw	a3, a3, a5
	addw	a2, a2, a3
	addw	a5, a2, s4
	srliw	a2, s1, 2
	slliw	a3, s1, 30
	addi	t6, t6, 4
	or	a3, a3, a2
	mv	t3, t5
	mv	t5, a1
	mv	s1, a4
	bne	t6, s3, .LBB0_9
	li	a2, 240
	addi	t3, sp, 8
	lui	s1, 828972
	addiw	t6, s1, 470
	li	t5, 320
.LBB0_11:
	mv	s1, a5
	mv	s0, a3
	mv	s2, a1
	srliw	a1, a5, 27
	slliw	a3, a5, 5
	or	a1, a1, a3
	xor	a3, s0, a4
	add	a5, t3, a2
	lw	a5, 0(a5)
	xor	a3, a3, s2
	addw	a1, a1, a3
	addw	a1, a1, t4
	addw	a1, a1, a5
	addw	a5, a1, t6
	srliw	a1, a4, 2
	slliw	a3, a4, 30
	addi	a2, a2, 4
	or	a3, a3, a1
	mv	t4, s2
	mv	a1, s0
	mv	a4, s1
	bne	a2, t5, .LBB0_11
	addw	a1, a5, t2
	sw	a1, 0(a0)
	addw	a1, s1, t1
	sw	a1, 4(a0)
	addw	a1, a3, t0
	sw	a1, 8(a0)
	addw	a1, s0, a7
	sw	a1, 12(a0)
	addw	a1, s2, a6
	sw	a1, 16(a0)
	sw	zero, 92(a0)
	ld	s0, 360(sp)
	ld	s1, 352(sp)
	ld	s2, 344(sp)
	ld	s3, 336(sp)
	ld	s4, 328(sp)
	addi	sp, sp, 368
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	ret
.Lfunc_end0:
	.size	message_block_process, .Lfunc_end0-message_block_process

	.globl	sha1_imbottitura
	.p2align	1
	.type	sha1_imbottitura,@function
sha1_imbottitura:
	addi	sp, sp, -16
	sd	ra, 8(sp)
	sd	s0, 0(sp)
	mv	s0, a0
	lw	a0, 92(a0)
	addiw	a1, a0, 1
	li	a2, 56
	sw	a1, 92(s0)
	blt	a0, a2, .LBB1_7
	add	a0, a0, s0
	li	a1, 128
	sb	a1, 28(a0)
	lw	a0, 92(s0)
	li	a1, 63
	blt	a1, a0, .LBB1_4
	li	a1, 64
.LBB1_3:
	addiw	a2, a0, 1
	sw	a2, 92(s0)
	add	a0, a0, s0
	sb	zero, 28(a0)
	lw	a0, 92(s0)
	blt	a0, a1, .LBB1_3
.LBB1_4:
	mv	a0, s0
	sd	ra, 12(zero)
	li	t2, 1
	sd	t2, 20(zero)
	call	message_block_process
	lw	a0, 92(s0)
	li	a1, 55
	blt	a1, a0, .LBB1_10
	li	a1, 56
.LBB1_6:
	addiw	a2, a0, 1
	sw	a2, 92(s0)
	add	a0, a0, s0
	sb	zero, 28(a0)
	lw	a0, 92(s0)
	blt	a0, a1, .LBB1_6
	j	.LBB1_10
.LBB1_7:
	add	a0, a0, s0
	li	a1, 128
	sb	a1, 28(a0)
	lw	a0, 92(s0)
	li	a1, 55
	blt	a1, a0, .LBB1_10
	li	a1, 56
.LBB1_9:
	addiw	a2, a0, 1
	sw	a2, 92(s0)
	add	a0, a0, s0
	sb	zero, 28(a0)
	lw	a0, 92(s0)
	blt	a0, a1, .LBB1_9
.LBB1_10:
	lw	a0, 24(s0)
	srli	a1, a0, 8
	lui	a2, 16
	addiw	a2, a2, -256
	and	a1, a1, a2
	srliw	a3, a0, 24
	or	a1, a1, a3
	and	a3, a0, a2
	slli	a3, a3, 8
	slli	a0, a0, 24
	lw	a4, 20(s0)
	or	a0, a0, a3
	or	a0, a0, a1
	sw	a0, 84(s0)
	srli	a0, a4, 8
	and	a0, a0, a2
	srliw	a1, a4, 24
	or	a0, a0, a1
	and	a2, a2, a4
	slli	a2, a2, 8
	slli	a4, a4, 24
	or	a2, a2, a4
	or	a0, a0, a2
	sw	a0, 88(s0)
	mv	a0, s0
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	addi	sp, sp, 16
	sd	ra, 12(zero)
	li	t2, 1
	sd	t2, 20(zero)
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	tail	message_block_process
.Lfunc_end1:
	.size	sha1_imbottitura, .Lfunc_end1-sha1_imbottitura

	.globl	sha1_init
	.p2align	1
	.type	sha1_init,@function
sha1_init:
	sw	zero, 20(a0)
	sw	zero, 24(a0)
	sw	zero, 92(a0)
	lui	a1, 422994
	addiw	a1, a1, 769
	sw	a1, 0(a0)
	lui	a1, 982235
	addiw	a1, a1, -1143
	sw	a1, 4(a0)
	lui	a1, 625582
	addiw	a1, a1, -770
	sw	a1, 8(a0)
	lui	a1, 66341
	addiw	a1, a1, 1142
	sw	a1, 12(a0)
	lui	a1, 802094
	addiw	a1, a1, 496
	sw	a1, 16(a0)
	sw	zero, 96(a0)
	sw	zero, 100(a0)
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	ret
.Lfunc_end2:
	.size	sha1_init, .Lfunc_end2-sha1_init

	.globl	sha1_result
	.p2align	1
	.type	sha1_result,@function
sha1_result:
	addi	sp, sp, -16
	sd	ra, 8(sp)
	sd	s0, 0(sp)
	mv	s0, a0
	lw	a0, 100(a0)
	beqz	a0, .LBB3_3
	li	a0, 0
.LBB3_2:
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	addi	sp, sp, 16
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	ret
.LBB3_3:
	lw	a1, 96(s0)
	li	a0, 1
	bnez	a1, .LBB3_2
	mv	a0, s0
	sd	ra, 12(zero)
	li	t2, 1
	sd	t2, 20(zero)
	call	sha1_imbottitura
	li	a0, 1
	sw	a0, 96(s0)
	ld	ra, 8(sp)
	ld	s0, 0(sp)
	addi	sp, sp, 16
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	ret
.Lfunc_end3:
	.size	sha1_result, .Lfunc_end3-sha1_result

	.globl	sha1_input
	.p2align	1
	.type	sha1_input,@function
sha1_input:
	addi	sp, sp, -48
	sd	ra, 40(sp)
	sd	s0, 32(sp)
	sd	s1, 24(sp)
	sd	s2, 16(sp)
	sd	s3, 8(sp)
	sd	s4, 0(sp)
	beqz	a2, .LBB4_4
	mv	s0, a0
	lw	a0, 96(a0)
	bnez	a0, .LBB4_3
	lw	a0, 100(s0)
	beqz	a0, .LBB4_5
.LBB4_3:
	li	a0, 1
	sw	a0, 100(s0)
.LBB4_4:
	ld	ra, 40(sp)
	ld	s0, 32(sp)
	ld	s1, 24(sp)
	ld	s2, 16(sp)
	ld	s3, 8(sp)
	ld	s4, 0(sp)
	addi	sp, sp, 48
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	ret
.LBB4_5:
	mv	s1, a2
	mv	s2, a1
	li	s3, 1
	li	s4, 64
	j	.LBB4_7
.LBB4_6:
	addiw	s1, s1, -1
	addi	s2, s2, 1
	beqz	s1, .LBB4_4
.LBB4_7:
	lw	a0, 100(s0)
	bnez	a0, .LBB4_4
	lw	a0, 92(s0)
	lb	a1, 0(s2)
	addiw	a2, a0, 1
	sw	a2, 92(s0)
	add	a0, a0, s0
	sb	a1, 28(a0)
	lw	a0, 20(s0)
	addiw	a0, a0, 8
	sw	a0, 20(s0)
	bnez	a0, .LBB4_11
	lw	a0, 24(s0)
	addiw	a0, a0, 1
	sw	a0, 24(s0)
	bnez	a0, .LBB4_11
	sw	s3, 100(s0)
.LBB4_11:
	lw	a0, 92(s0)
	bne	a0, s4, .LBB4_6
	mv	a0, s0
	sd	ra, 12(zero)
	li	t2, 1
	sd	t2, 20(zero)
	call	message_block_process
	j	.LBB4_6
.Lfunc_end4:
	.size	sha1_input, .Lfunc_end4-sha1_input

	.section	.sdata,"aw",@progbits
	.p2align	3
.LCPI5_0:
	.quad	-1167088121787636991
.LCPI5_1:
	.quad	1167088121787636990
	.text
	.globl	main
	.p2align	1
	.type	main,@function
main:
	addi	sp, sp, -160
	sd	ra, 152(sp)
	sd	s0, 144(sp)
	sd	s1, 136(sp)
	sd	s2, 128(sp)
	sd	s3, 120(sp)
	sd	s4, 112(sp)
	lui	a0, %hi(.LCPI5_0)
	ld	a0, %lo(.LCPI5_0)(a0)
	lui	a1, %hi(.LCPI5_1)
	ld	a1, %lo(.LCPI5_1)(a1)
	sw	zero, 32(sp)
	sw	zero, 100(sp)
	sd	a0, 8(sp)
	sd	a1, 16(sp)
	lui	a0, 401047
	slli	a0, a0, 1
	addi	a0, a0, 496
	sd	a0, 24(sp)
	sd	zero, 104(sp)
	lui	a0, %hi(.L.str)
	addi	s0, a0, %lo(.L.str)
	li	s1, -16
	addi	s2, sp, 8
	li	s3, 1
	li	s4, 64
.LBB5_1:
	lw	a0, 100(sp)
	lb	a1, 0(s0)
	addiw	a2, a0, 1
	sw	a2, 100(sp)
	add	a0, a0, s2
	sb	a1, 28(a0)
	lw	a0, 28(sp)
	addiw	a0, a0, 8
	sw	a0, 28(sp)
	bnez	a0, .LBB5_4
	lw	a0, 32(sp)
	addiw	a0, a0, 1
	sw	a0, 32(sp)
	bnez	a0, .LBB5_4
	sw	s3, 108(sp)
.LBB5_4:
	lw	a0, 100(sp)
	bne	a0, s4, .LBB5_6
	addi	a0, sp, 8
	sd	ra, 12(zero)
	li	t2, 1
	sd	t2, 20(zero)
	call	message_block_process
.LBB5_6:
	addiw	s1, s1, 1
	beqz	s1, .LBB5_8
	lw	a0, 108(sp)
	addi	s0, s0, 1
	beqz	a0, .LBB5_1
.LBB5_8:
	li	a0, 0
	ld	ra, 152(sp)
	ld	s0, 144(sp)
	ld	s1, 136(sp)
	ld	s2, 128(sp)
	ld	s3, 120(sp)
	ld	s4, 112(sp)
	addi	sp, sp, 160
	sd	ra, 12(zero)
	sd	zero, 20(zero)
	ret
.Lfunc_end5:
	.size	main, .Lfunc_end5-main

	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"cps exam project"
	.size	.L.str, 17

	.ident	"clang version 16.0.0 (https://github.com/letiziaburioli/llvm-project.git 1e627039b3666fbd7a6d5688a8f71092e48cf653)"
	.section	".note.GNU-stack","",@progbits
	.addrsig
