	.text
	.file	"testFunction.c"
	.globl	TestFunction1           # -- Begin function TestFunction1
	.p2align	1
	.type	TestFunction1,@function
TestFunction1:                          # @TestFunction1
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)
	sd	s0, 16(sp)
	addi	s0, sp, 32
	addi	a0, zero, 5
	sw	a0, -20(s0)
	addi	a0, zero, 3
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	ld	s0, 16(sp)
	ld	ra, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	TestFunction1, .Lfunc_end0-TestFunction1
                                        # -- End function
	.globl	TestFunction2           # -- Begin function TestFunction2
	.p2align	1
	.type	TestFunction2,@function
TestFunction2:                          # @TestFunction2
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)
	sd	s0, 16(sp)
	addi	s0, sp, 32
	addi	a0, zero, 2
	sw	a0, -20(s0)
	addi	a0, zero, 4
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	mul	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	ld	s0, 16(sp)
	ld	ra, 24(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	TestFunction2, .Lfunc_end1-TestFunction2
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)
	sd	s0, 32(sp)
	addi	s0, sp, 48
	mv	a0, zero
	sw	a0, -20(s0)
	sd	a0, -40(s0)
	call	TestFunction1
	sw	a0, -24(s0)
	call	TestFunction2
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	add	a0, a0, a1
	sw	a0, -32(s0)
	ld	a0, -40(s0)
	ld	s0, 32(sp)
	ld	ra, 40(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym TestFunction1
	.addrsig_sym TestFunction2
