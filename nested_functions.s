	.text
	.file	"nested_functions.c"
	.globl	TestFunction3           # -- Begin function TestFunction3
	.p2align	1
	.type	TestFunction3,@function
TestFunction3:                          # @TestFunction3
.Lfunc_begin0:
	.file	1 "/home/letizia/llvm_repo/llvm-project" "nested_functions.c"
	.loc	1 3 0                   # nested_functions.c:3:0
	.cfi_sections .debug_frame
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sd	ra, 24(sp)
	sd	s0, 16(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	add	a2, zero, a1
	add	a3, zero, a0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
.Ltmp0:
	.loc	1 5 14 prologue_end     # nested_functions.c:5:14
	lw	a0, -20(s0)
	.loc	1 5 16 is_stmt 0        # nested_functions.c:5:16
	lw	a1, -24(s0)
	.loc	1 5 15                  # nested_functions.c:5:15
	xor	a0, a0, a1
	.loc	1 5 6                   # nested_functions.c:5:6
	sw	a0, -28(s0)
	.loc	1 6 14 is_stmt 1        # nested_functions.c:6:14
	lw	a0, -28(s0)
	.loc	1 6 20 is_stmt 0        # nested_functions.c:6:20
	addi	a0, a0, -37
	.loc	1 6 6                   # nested_functions.c:6:6
	sw	a0, -32(s0)
	.loc	1 8 9 is_stmt 1         # nested_functions.c:8:9
	lw	a0, -32(s0)
	.loc	1 8 2 is_stmt 0         # nested_functions.c:8:2
	ld	s0, 16(sp)
	ld	ra, 24(sp)
	addi	sp, sp, 32
	ret
.Ltmp1:
.Lfunc_end0:
	.size	TestFunction3, .Lfunc_end0-TestFunction3
	.cfi_endproc
                                        # -- End function
	.globl	TestFunction2           # -- Begin function TestFunction2
	.p2align	1
	.type	TestFunction2,@function
TestFunction2:                          # @TestFunction2
.Lfunc_begin1:
	.loc	1 11 0 is_stmt 1        # nested_functions.c:11:0
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)
	sd	s0, 32(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 48
	.cfi_def_cfa s0, 0
	add	a2, zero, a1
	add	a3, zero, a0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
.Ltmp2:
	.loc	1 13 26 prologue_end    # nested_functions.c:13:26
	lw	a0, -20(s0)
	.loc	1 13 29 is_stmt 0       # nested_functions.c:13:29
	lw	a1, -24(s0)
	.loc	1 13 12                 # nested_functions.c:13:12
	sd	a2, -40(s0)
	sd	a3, -48(s0)
	call	TestFunction3
	.loc	1 13 6                  # nested_functions.c:13:6
	sw	a0, -28(s0)
	.loc	1 14 14 is_stmt 1       # nested_functions.c:14:14
	lw	a0, -20(s0)
	.loc	1 14 18 is_stmt 0       # nested_functions.c:14:18
	lw	a1, -28(s0)
	.loc	1 14 16                 # nested_functions.c:14:16
	mul	a0, a0, a1
	.loc	1 14 6                  # nested_functions.c:14:6
	sw	a0, -32(s0)
	.loc	1 16 9 is_stmt 1        # nested_functions.c:16:9
	lw	a0, -32(s0)
	.loc	1 16 2 is_stmt 0        # nested_functions.c:16:2
	ld	s0, 32(sp)
	ld	ra, 40(sp)
	addi	sp, sp, 48
	ret
.Ltmp3:
.Lfunc_end1:
	.size	TestFunction2, .Lfunc_end1-TestFunction2
	.cfi_endproc
                                        # -- End function
	.globl	TestFunction1           # -- Begin function TestFunction1
	.p2align	1
	.type	TestFunction1,@function
TestFunction1:                          # @TestFunction1
.Lfunc_begin2:
	.loc	1 19 0 is_stmt 1        # nested_functions.c:19:0
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)
	sd	s0, 32(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 48
	.cfi_def_cfa s0, 0
	add	a2, zero, a1
	add	a3, zero, a0
	sw	a0, -20(s0)
	sw	a1, -24(s0)
.Ltmp4:
	.loc	1 21 27 prologue_end    # nested_functions.c:21:27
	lw	a0, -20(s0)
	.loc	1 21 30 is_stmt 0       # nested_functions.c:21:30
	lw	a1, -24(s0)
	.loc	1 21 13                 # nested_functions.c:21:13
	sd	a2, -40(s0)
	sd	a3, -48(s0)
	call	TestFunction2
	.loc	1 21 6                  # nested_functions.c:21:6
	sw	a0, -28(s0)
	.loc	1 22 14 is_stmt 1       # nested_functions.c:22:14
	lw	a0, -28(s0)
	.loc	1 22 21 is_stmt 0       # nested_functions.c:22:21
	lw	a1, -24(s0)
	.loc	1 22 19                 # nested_functions.c:22:19
	add	a0, a0, a1
	.loc	1 22 6                  # nested_functions.c:22:6
	sw	a0, -32(s0)
	.loc	1 24 9 is_stmt 1        # nested_functions.c:24:9
	lw	a0, -32(s0)
	.loc	1 24 2 is_stmt 0        # nested_functions.c:24:2
	ld	s0, 32(sp)
	ld	ra, 40(sp)
	addi	sp, sp, 48
	ret
.Ltmp5:
.Lfunc_end2:
	.size	TestFunction1, .Lfunc_end2-TestFunction1
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	1
	.type	main,@function
main:                                   # @main
.Lfunc_begin3:
	.loc	1 28 0 is_stmt 1        # nested_functions.c:28:0
	.cfi_startproc
# %bb.0:
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sd	ra, 40(sp)
	sd	s0, 32(sp)
	.cfi_offset ra, -8
	.cfi_offset s0, -16
	addi	s0, sp, 48
	.cfi_def_cfa s0, 0
	mv	a0, zero
	sw	a0, -20(s0)
.Ltmp6:
	.loc	1 29 6 prologue_end     # nested_functions.c:29:6
	sw	a0, -24(s0)
	.loc	1 30 6                  # nested_functions.c:30:6
	sw	a0, -28(s0)
.Ltmp7:
	.loc	1 32 10                 # nested_functions.c:32:10
	sw	a0, -32(s0)
	.loc	1 32 6 is_stmt 0        # nested_functions.c:32:6
	j	.LBB3_1
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
.Ltmp8:
	.loc	1 32 15                 # nested_functions.c:32:15
	lw	a0, -32(s0)
	addi	a1, zero, 3
.Ltmp9:
	.loc	1 32 2                  # nested_functions.c:32:2
	blt	a1, a0, .LBB3_6
	j	.LBB3_2
.LBB3_2:                                #   in Loop: Header=BB3_1 Depth=1
.Ltmp10:
	.loc	1 33 3 is_stmt 1        # nested_functions.c:33:3
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	.loc	1 34 3                  # nested_functions.c:34:3
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
.Ltmp11:
	.loc	1 36 5                  # nested_functions.c:36:5
	lw	a0, -32(s0)
	addi	a1, zero, 2
.Ltmp12:
	.loc	1 36 5 is_stmt 0        # nested_functions.c:36:5
	blt	a1, a0, .LBB3_4
	j	.LBB3_3
.LBB3_3:                                #   in Loop: Header=BB3_1 Depth=1
.Ltmp13:
	.loc	1 37 26 is_stmt 1       # nested_functions.c:37:26
	lw	a0, -24(s0)
	.loc	1 37 29 is_stmt 0       # nested_functions.c:37:29
	lw	a1, -28(s0)
	.loc	1 37 12                 # nested_functions.c:37:12
	call	TestFunction1
	.loc	1 37 6                  # nested_functions.c:37:6
	sw	a0, -36(s0)
	.loc	1 38 2 is_stmt 1        # nested_functions.c:38:2
	j	.LBB3_4
.Ltmp14:
.LBB3_4:                                #   in Loop: Header=BB3_1 Depth=1
	.loc	1 39 2                  # nested_functions.c:39:2
	j	.LBB3_5
.Ltmp15:
.LBB3_5:                                #   in Loop: Header=BB3_1 Depth=1
	.loc	1 32 21                 # nested_functions.c:32:21
	lw	a0, -32(s0)
	addi	a0, a0, 1
	sw	a0, -32(s0)
	.loc	1 32 2 is_stmt 0        # nested_functions.c:32:2
	j	.LBB3_1
.Ltmp16:
.LBB3_6:
	.loc	1 0 2                   # nested_functions.c:0:2
	mv	a0, zero
	.loc	1 41 2 is_stmt 1        # nested_functions.c:41:2
	ld	s0, 32(sp)
	ld	ra, 40(sp)
	addi	sp, sp, 48
	ret
.Ltmp17:
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        # -- End function
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 10.0.0-4ubuntu1 " # string offset=0
.Linfo_string1:
	.asciz	"nested_functions.c"    # string offset=31
.Linfo_string2:
	.asciz	"/home/letizia/llvm_repo/llvm-project" # string offset=50
.Linfo_string3:
	.asciz	"TestFunction3"         # string offset=87
.Linfo_string4:
	.asciz	"int"                   # string offset=101
.Linfo_string5:
	.asciz	"TestFunction2"         # string offset=105
.Linfo_string6:
	.asciz	"TestFunction1"         # string offset=119
.Linfo_string7:
	.asciz	"main"                  # string offset=133
.Linfo_string8:
	.asciz	"a"                     # string offset=138
.Linfo_string9:
	.asciz	"b"                     # string offset=140
.Linfo_string10:
	.asciz	"myPow"                 # string offset=142
.Linfo_string11:
	.asciz	"mySub"                 # string offset=148
.Linfo_string12:
	.asciz	"op1"                   # string offset=154
.Linfo_string13:
	.asciz	"myMul"                 # string offset=158
.Linfo_string14:
	.asciz	"prod"                  # string offset=164
.Linfo_string15:
	.asciz	"mySum"                 # string offset=169
.Linfo_string16:
	.asciz	"i"                     # string offset=175
.Linfo_string17:
	.asciz	"Res"                   # string offset=177
	.section	.debug_abbrev,"",@progbits
	.byte	1                       # Abbreviation Code
	.byte	17                      # DW_TAG_compile_unit
	.byte	1                       # DW_CHILDREN_yes
	.byte	37                      # DW_AT_producer
	.byte	14                      # DW_FORM_strp
	.byte	19                      # DW_AT_language
	.byte	5                       # DW_FORM_data2
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	16                      # DW_AT_stmt_list
	.byte	23                      # DW_FORM_sec_offset
	.byte	27                      # DW_AT_comp_dir
	.byte	14                      # DW_FORM_strp
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	2                       # Abbreviation Code
	.byte	46                      # DW_TAG_subprogram
	.byte	1                       # DW_CHILDREN_yes
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	64                      # DW_AT_frame_base
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	39                      # DW_AT_prototyped
	.byte	25                      # DW_FORM_flag_present
	.byte	73                      # DW_AT_type
	.byte	19                      # DW_FORM_ref4
	.byte	63                      # DW_AT_external
	.byte	25                      # DW_FORM_flag_present
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	3                       # Abbreviation Code
	.byte	5                       # DW_TAG_formal_parameter
	.byte	0                       # DW_CHILDREN_no
	.byte	2                       # DW_AT_location
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	73                      # DW_AT_type
	.byte	19                      # DW_FORM_ref4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	4                       # Abbreviation Code
	.byte	52                      # DW_TAG_variable
	.byte	0                       # DW_CHILDREN_no
	.byte	2                       # DW_AT_location
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	73                      # DW_AT_type
	.byte	19                      # DW_FORM_ref4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	5                       # Abbreviation Code
	.byte	46                      # DW_TAG_subprogram
	.byte	1                       # DW_CHILDREN_yes
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	64                      # DW_AT_frame_base
	.byte	24                      # DW_FORM_exprloc
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	58                      # DW_AT_decl_file
	.byte	11                      # DW_FORM_data1
	.byte	59                      # DW_AT_decl_line
	.byte	11                      # DW_FORM_data1
	.byte	73                      # DW_AT_type
	.byte	19                      # DW_FORM_ref4
	.byte	63                      # DW_AT_external
	.byte	25                      # DW_FORM_flag_present
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	6                       # Abbreviation Code
	.byte	11                      # DW_TAG_lexical_block
	.byte	1                       # DW_CHILDREN_yes
	.byte	17                      # DW_AT_low_pc
	.byte	1                       # DW_FORM_addr
	.byte	18                      # DW_AT_high_pc
	.byte	6                       # DW_FORM_data4
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	7                       # Abbreviation Code
	.byte	36                      # DW_TAG_base_type
	.byte	0                       # DW_CHILDREN_no
	.byte	3                       # DW_AT_name
	.byte	14                      # DW_FORM_strp
	.byte	62                      # DW_AT_encoding
	.byte	11                      # DW_FORM_data1
	.byte	11                      # DW_AT_byte_size
	.byte	11                      # DW_FORM_data1
	.byte	0                       # EOM(1)
	.byte	0                       # EOM(2)
	.byte	0                       # EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.word	.Ldebug_info_end0-.Ldebug_info_start0 # Length of Unit
.Ldebug_info_start0:
	.half	4                       # DWARF version number
	.word	.debug_abbrev           # Offset Into Abbrev. Section
	.byte	8                       # Address Size (in bytes)
	.byte	1                       # Abbrev [1] 0xb:0x18b DW_TAG_compile_unit
	.word	.Linfo_string0          # DW_AT_producer
	.half	12                      # DW_AT_language
	.word	.Linfo_string1          # DW_AT_name
	.word	.Lline_table_start0     # DW_AT_stmt_list
	.word	.Linfo_string2          # DW_AT_comp_dir
	.quad	.Lfunc_begin0           # DW_AT_low_pc
	.word	.Lfunc_end3-.Lfunc_begin0 # DW_AT_high_pc
	.byte	2                       # Abbrev [2] 0x2a:0x52 DW_TAG_subprogram
	.quad	.Lfunc_begin0           # DW_AT_low_pc
	.word	.Lfunc_end0-.Lfunc_begin0 # DW_AT_high_pc
	.byte	1                       # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string3          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	3                       # DW_AT_decl_line
                                        # DW_AT_prototyped
	.word	398                     # DW_AT_type
                                        # DW_AT_external
	.byte	3                       # Abbrev [3] 0x43:0xe DW_TAG_formal_parameter
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	108
	.word	.Linfo_string8          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	3                       # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0x51:0xe DW_TAG_formal_parameter
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string9          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	3                       # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0x5f:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string10         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	5                       # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0x6d:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	96
	.word	.Linfo_string11         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	6                       # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	2                       # Abbrev [2] 0x7c:0x52 DW_TAG_subprogram
	.quad	.Lfunc_begin1           # DW_AT_low_pc
	.word	.Lfunc_end1-.Lfunc_begin1 # DW_AT_high_pc
	.byte	1                       # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string5          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	11                      # DW_AT_decl_line
                                        # DW_AT_prototyped
	.word	398                     # DW_AT_type
                                        # DW_AT_external
	.byte	3                       # Abbrev [3] 0x95:0xe DW_TAG_formal_parameter
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	108
	.word	.Linfo_string8          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	11                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0xa3:0xe DW_TAG_formal_parameter
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string9          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	11                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0xb1:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string12         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	13                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0xbf:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	96
	.word	.Linfo_string13         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	14                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	2                       # Abbrev [2] 0xce:0x52 DW_TAG_subprogram
	.quad	.Lfunc_begin2           # DW_AT_low_pc
	.word	.Lfunc_end2-.Lfunc_begin2 # DW_AT_high_pc
	.byte	1                       # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string6          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	19                      # DW_AT_decl_line
                                        # DW_AT_prototyped
	.word	398                     # DW_AT_type
                                        # DW_AT_external
	.byte	3                       # Abbrev [3] 0xe7:0xe DW_TAG_formal_parameter
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	108
	.word	.Linfo_string8          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	19                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	3                       # Abbrev [3] 0xf5:0xe DW_TAG_formal_parameter
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string9          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	19                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0x103:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string14         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	21                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0x111:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	96
	.word	.Linfo_string15         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	22                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	5                       # Abbrev [5] 0x120:0x6e DW_TAG_subprogram
	.quad	.Lfunc_begin3           # DW_AT_low_pc
	.word	.Lfunc_end3-.Lfunc_begin3 # DW_AT_high_pc
	.byte	1                       # DW_AT_frame_base
	.byte	88
	.word	.Linfo_string7          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	28                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
                                        # DW_AT_external
	.byte	4                       # Abbrev [4] 0x139:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	104
	.word	.Linfo_string8          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	29                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	4                       # Abbrev [4] 0x147:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	100
	.word	.Linfo_string9          # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	30                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	6                       # Abbrev [6] 0x155:0x38 DW_TAG_lexical_block
	.quad	.Ltmp7                  # DW_AT_low_pc
	.word	.Ltmp16-.Ltmp7          # DW_AT_high_pc
	.byte	4                       # Abbrev [4] 0x162:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	96
	.word	.Linfo_string16         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	32                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	6                       # Abbrev [6] 0x170:0x1c DW_TAG_lexical_block
	.quad	.Ltmp13                 # DW_AT_low_pc
	.word	.Ltmp14-.Ltmp13         # DW_AT_high_pc
	.byte	4                       # Abbrev [4] 0x17d:0xe DW_TAG_variable
	.byte	2                       # DW_AT_location
	.byte	145
	.byte	92
	.word	.Linfo_string17         # DW_AT_name
	.byte	1                       # DW_AT_decl_file
	.byte	37                      # DW_AT_decl_line
	.word	398                     # DW_AT_type
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	0                       # End Of Children Mark
	.byte	7                       # Abbrev [7] 0x18e:0x7 DW_TAG_base_type
	.word	.Linfo_string4          # DW_AT_name
	.byte	5                       # DW_AT_encoding
	.byte	4                       # DW_AT_byte_size
	.byte	0                       # End Of Children Mark
.Ldebug_info_end0:
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym TestFunction3
	.addrsig_sym TestFunction2
	.addrsig_sym TestFunction1
	.section	.debug_line,"",@progbits
.Lline_table_start0:
