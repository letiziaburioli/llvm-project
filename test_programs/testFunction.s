	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0"
	.file	"testFunction.c"
	.globl	TestFunction1                   # -- Begin function TestFunction1
	.p2align	1
	.type	TestFunction1,@function
TestFunction1:                          # @TestFunction1
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 5
	sw	a0, -20(s0)
	li	a0, 3
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	addw	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	sd	ra, 10(zero)
	sd	zero, 18(zero)
	ret
.Lfunc_end0:
	.size	TestFunction1, .Lfunc_end0-TestFunction1
                                        # -- End function
	.globl	TestFunction2                   # -- Begin function TestFunction2
	.p2align	1
	.type	TestFunction2,@function
TestFunction2:                          # @TestFunction2
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	li	a0, 2
	sw	a0, -20(s0)
	li	a0, 4
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	mulw	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	sd	ra, 10(zero)
	sd	zero, 18(zero)
	ret
.Lfunc_end1:
	.size	TestFunction2, .Lfunc_end1-TestFunction2
                                        # -- End function
	.globl	TestFunction3                   # -- Begin function TestFunction3
	.p2align	1
	.type	TestFunction3,@function
TestFunction3:                          # @TestFunction3
# %bb.0:
	addi	sp, sp, -32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -20(s0)
	li	a0, 37
	sw	a0, -24(s0)
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	mulw	a0, a0, a1
	addiw	a0, a0, 10
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	sd	ra, 10(zero)
	sd	zero, 18(zero)
	ret
.Lfunc_end2:
	.size	TestFunction3, .Lfunc_end2-TestFunction3
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -48
	sd	ra, 40(sp)                      # 8-byte Folded Spill
	sd	s0, 32(sp)                      # 8-byte Folded Spill
	addi	s0, sp, 48
	sw	zero, -20(s0)
	sd	ra, 10(zero)
	li	t2, 1
	sd	t2, 18(zero)
	call	TestFunction1
	sw	a0, -24(s0)
	sd	ra, 10(zero)
	li	t2, 1
	sd	t2, 18(zero)
	call	TestFunction2
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	sd	ra, 10(zero)
	li	t2, 1
	sd	t2, 18(zero)
	call	TestFunction3
	sw	a0, -32(s0)
	lw	a0, -24(s0)
	lw	a1, -28(s0)
	addw	a0, a0, a1
	lw	a1, -32(s0)
	addw	a0, a0, a1
	sw	a0, -36(s0)
	li	a0, 0
	ld	ra, 40(sp)                      # 8-byte Folded Reload
	ld	s0, 32(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 48
	sd	ra, 10(zero)
	sd	zero, 18(zero)
	ret
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function
	.ident	"clang version 16.0.0 (https://github.com/letiziaburioli/llvm-project.git 1e627039b3666fbd7a6d5688a8f71092e48cf653)"
	.section	".note.GNU-stack","",@progbits
