	.text
	.attribute	4, 16
	.attribute	5, "rv64i2p0"
	.file	"testFunction.c"
	.globl	TestFunction1                   # -- Begin function TestFunction1
	.p2align	1
	.type	TestFunction1,@function
TestFunction1:                          # @TestFunction1
.Lfunc_begin0:
	.file	1 "/home/letizia/llvm_repo/llvm-project" "testFunction.c"
	.loc	1 3 0                           # testFunction.c:3:0
	.cfi_sections .debug_frame
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	li	a0, 5
.Ltmp0:
	.loc	1 4 6 prologue_end              # testFunction.c:4:6
	sw	a0, -20(s0)
	li	a0, 3
	.loc	1 5 6                           # testFunction.c:5:6
	sw	a0, -24(s0)
	.loc	1 6 14                          # testFunction.c:6:14
	lw	a0, -20(s0)
	.loc	1 6 18 is_stmt 0                # testFunction.c:6:18
	lw	a1, -24(s0)
	.loc	1 6 16                          # testFunction.c:6:16
	addw	a0, a0, a1
	.loc	1 6 6                           # testFunction.c:6:6
	sw	a0, -28(s0)
	.loc	1 8 9 is_stmt 1                 # testFunction.c:8:9
	lw	a0, -28(s0)
	.loc	1 8 2 is_stmt 0                 # testFunction.c:8:2
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	lw	ra, 1(zero)
	ret
.Ltmp1:
.Lfunc_end0:
	.size	TestFunction1, .Lfunc_end0-TestFunction1
	.cfi_endproc
                                        # -- End function
	.globl	TestFunction2                   # -- Begin function TestFunction2
	.p2align	1
	.type	TestFunction2,@function
TestFunction2:                          # @TestFunction2
.Lfunc_begin1:
	.loc	1 12 0 is_stmt 1                # testFunction.c:12:0
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	li	a0, 2
.Ltmp2:
	.loc	1 13 6 prologue_end             # testFunction.c:13:6
	sw	a0, -20(s0)
	li	a0, 4
	.loc	1 14 6                          # testFunction.c:14:6
	sw	a0, -24(s0)
	.loc	1 15 14                         # testFunction.c:15:14
	lw	a0, -20(s0)
	.loc	1 15 18 is_stmt 0               # testFunction.c:15:18
	lw	a1, -24(s0)
	.loc	1 15 16                         # testFunction.c:15:16
	mulw	a0, a0, a1
	.loc	1 15 6                          # testFunction.c:15:6
	sw	a0, -28(s0)
	.loc	1 17 9 is_stmt 1                # testFunction.c:17:9
	lw	a0, -28(s0)
	.loc	1 17 2 is_stmt 0                # testFunction.c:17:2
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	lw	ra, 1(zero)
	ret
.Ltmp3:
.Lfunc_end1:
	.size	TestFunction2, .Lfunc_end1-TestFunction2
	.cfi_endproc
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
.Lfunc_begin2:
	.loc	1 20 0 is_stmt 1                # testFunction.c:20:0
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)                      # 8-byte Folded Spill
	sd	s0, 16(sp)                      # 8-byte Folded Spill
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	zero, -20(s0)
	sw	ra, 1(zero)
.Ltmp4:
	.loc	1 22 12 prologue_end            # testFunction.c:22:12
	call	TestFunction1
	.loc	1 22 6 is_stmt 0                # testFunction.c:22:6
	sw	a0, -24(s0)
	sw	ra, 1(zero)
	.loc	1 24 13 is_stmt 1               # testFunction.c:24:13
	call	TestFunction2
	.loc	1 24 6 is_stmt 0                # testFunction.c:24:6
	sw	a0, -28(s0)
	.loc	1 26 12 is_stmt 1               # testFunction.c:26:12
	lw	a0, -24(s0)
	.loc	1 26 18 is_stmt 0               # testFunction.c:26:18
	lw	a1, -28(s0)
	.loc	1 26 16                         # testFunction.c:26:16
	addw	a0, a0, a1
	.loc	1 26 6                          # testFunction.c:26:6
	sw	a0, -32(s0)
	.loc	1 28 2 is_stmt 1                # testFunction.c:28:2
	li	a0, 0
	ld	ra, 24(sp)                      # 8-byte Folded Reload
	ld	s0, 16(sp)                      # 8-byte Folded Reload
	addi	sp, sp, 32
	lw	ra, 1(zero)
	ret
.Ltmp5:
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.section	.debug_abbrev,"",@progbits
	.byte	1                               # Abbreviation Code
	.byte	17                              # DW_TAG_compile_unit
	.byte	1                               # DW_CHILDREN_yes
	.byte	37                              # DW_AT_producer
	.byte	14                              # DW_FORM_strp
	.byte	19                              # DW_AT_language
	.byte	5                               # DW_FORM_data2
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	16                              # DW_AT_stmt_list
	.byte	23                              # DW_FORM_sec_offset
	.byte	27                              # DW_AT_comp_dir
	.byte	14                              # DW_FORM_strp
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	2                               # Abbreviation Code
	.byte	46                              # DW_TAG_subprogram
	.byte	1                               # DW_CHILDREN_yes
	.byte	17                              # DW_AT_low_pc
	.byte	1                               # DW_FORM_addr
	.byte	18                              # DW_AT_high_pc
	.byte	6                               # DW_FORM_data4
	.byte	64                              # DW_AT_frame_base
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	63                              # DW_AT_external
	.byte	25                              # DW_FORM_flag_present
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	3                               # Abbreviation Code
	.byte	52                              # DW_TAG_variable
	.byte	0                               # DW_CHILDREN_no
	.byte	2                               # DW_AT_location
	.byte	24                              # DW_FORM_exprloc
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	58                              # DW_AT_decl_file
	.byte	11                              # DW_FORM_data1
	.byte	59                              # DW_AT_decl_line
	.byte	11                              # DW_FORM_data1
	.byte	73                              # DW_AT_type
	.byte	19                              # DW_FORM_ref4
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	4                               # Abbreviation Code
	.byte	36                              # DW_TAG_base_type
	.byte	0                               # DW_CHILDREN_no
	.byte	3                               # DW_AT_name
	.byte	14                              # DW_FORM_strp
	.byte	62                              # DW_AT_encoding
	.byte	11                              # DW_FORM_data1
	.byte	11                              # DW_AT_byte_size
	.byte	11                              # DW_FORM_data1
	.byte	0                               # EOM(1)
	.byte	0                               # EOM(2)
	.byte	0                               # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.half	4                               # DWARF version number
	.word	.debug_abbrev                   # Offset Into Abbrev. Section
	.byte	8                               # Address Size (in bytes)
	.byte	1                               # Abbrev [1] 0xb:0xf3 DW_TAG_compile_unit
	.word	.Linfo_string0                  # DW_AT_producer
	.half	12                              # DW_AT_language
	.word	.Linfo_string1                  # DW_AT_name
	.word	.Lline_table_start0             # DW_AT_stmt_list
	.word	.Linfo_string2                  # DW_AT_comp_dir
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.word	.Lfunc_end2-.Lfunc_begin0       # DW_AT_high_pc
	.byte	2                               # Abbrev [2] 0x2a:0x44 DW_TAG_subprogram
	.quad	.Lfunc_begin0                   # DW_AT_low_pc
	.word	.Lfunc_end0-.Lfunc_begin0       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string3                  # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	3                               # DW_AT_decl_line
	.word	246                             # DW_AT_type
                                        # DW_AT_external
	.byte	3                               # Abbrev [3] 0x43:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	108
	.word	.Linfo_string7                  # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	4                               # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x51:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string8                  # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	5                               # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x5f:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string9                  # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	6                               # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	2                               # Abbrev [2] 0x6e:0x44 DW_TAG_subprogram
	.quad	.Lfunc_begin1                   # DW_AT_low_pc
	.word	.Lfunc_end1-.Lfunc_begin1       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string5                  # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	12                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
                                        # DW_AT_external
	.byte	3                               # Abbrev [3] 0x87:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	108
	.word	.Linfo_string10                 # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	13                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0x95:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string11                 # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	14                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0xa3:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string12                 # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	15                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	2                               # Abbrev [2] 0xb2:0x44 DW_TAG_subprogram
	.quad	.Lfunc_begin2                   # DW_AT_low_pc
	.word	.Lfunc_end2-.Lfunc_begin2       # DW_AT_high_pc
	.byte	1                               # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string6                  # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	20                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
                                        # DW_AT_external
	.byte	3                               # Abbrev [3] 0xcb:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string13                 # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	22                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0xd9:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string14                 # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	24                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	3                               # Abbrev [3] 0xe7:0xe DW_TAG_variable
	.byte	2                               # DW_AT_location
	.byte	145
	.byte	96
	.word	.Linfo_string15                 # DW_AT_name
	.byte	1                               # DW_AT_decl_file
	.byte	26                              # DW_AT_decl_line
	.word	246                             # DW_AT_type
	.byte	0                               # End Of Children Mark
	.byte	4                               # Abbrev [4] 0xf6:0x7 DW_TAG_base_type
	.word	.Linfo_string4                  # DW_AT_name
	.byte	5                               # DW_AT_encoding
	.byte	4                               # DW_AT_byte_size
	.byte	0                               # End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 10.0.0-4ubuntu1 " # string offset=0
.Linfo_string1:
	.asciz	"testFunction.c"                # string offset=31
.Linfo_string2:
	.asciz	"/home/letizia/llvm_repo/llvm-project" # string offset=46
.Linfo_string3:
	.asciz	"TestFunction1"                 # string offset=83
.Linfo_string4:
	.asciz	"int"                           # string offset=97
.Linfo_string5:
	.asciz	"TestFunction2"                 # string offset=101
.Linfo_string6:
	.asciz	"main"                          # string offset=115
.Linfo_string7:
	.asciz	"a"                             # string offset=120
.Linfo_string8:
	.asciz	"b"                             # string offset=122
.Linfo_string9:
	.asciz	"mySum"                         # string offset=124
.Linfo_string10:
	.asciz	"c"                             # string offset=130
.Linfo_string11:
	.asciz	"d"                             # string offset=132
.Linfo_string12:
	.asciz	"myMul"                         # string offset=134
.Linfo_string13:
	.asciz	"Sum"                           # string offset=140
.Linfo_string14:
	.asciz	"Prod"                          # string offset=144
.Linfo_string15:
	.asciz	"Res"                           # string offset=149
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.section	.debug_line,"",@progbits
.Lline_table_start0:
