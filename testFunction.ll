; ModuleID = 'testFunction.c'
source_filename = "testFunction.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown-elf"

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction1() #0 !dbg !8 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !12, metadata !DIExpression()), !dbg !13
  store i32 5, i32* %1, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %2, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 3, i32* %2, align 4, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %3, metadata !16, metadata !DIExpression()), !dbg !17
  %4 = load i32, i32* %1, align 4, !dbg !18
  %5 = load i32, i32* %2, align 4, !dbg !19
  %6 = add nsw i32 %4, %5, !dbg !20
  store i32 %6, i32* %3, align 4, !dbg !17
  %7 = load i32, i32* %3, align 4, !dbg !21
  ret i32 %7, !dbg !22
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction2() #0 !dbg !23 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 2, i32* %1, align 4, !dbg !25
  call void @llvm.dbg.declare(metadata i32* %2, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 4, i32* %2, align 4, !dbg !27
  call void @llvm.dbg.declare(metadata i32* %3, metadata !28, metadata !DIExpression()), !dbg !29
  %4 = load i32, i32* %1, align 4, !dbg !30
  %5 = load i32, i32* %2, align 4, !dbg !31
  %6 = mul nsw i32 %4, %5, !dbg !32
  store i32 %6, i32* %3, align 4, !dbg !29
  %7 = load i32, i32* %3, align 4, !dbg !33
  ret i32 %7, !dbg !34
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 !dbg !35 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !36, metadata !DIExpression()), !dbg !37
  %5 = call signext i32 @TestFunction1(), !dbg !38
  store i32 %5, i32* %2, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata i32* %3, metadata !39, metadata !DIExpression()), !dbg !40
  %6 = call signext i32 @TestFunction2(), !dbg !41
  store i32 %6, i32* %3, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata i32* %4, metadata !42, metadata !DIExpression()), !dbg !43
  %7 = load i32, i32* %2, align 4, !dbg !44
  %8 = load i32, i32* %3, align 4, !dbg !45
  %9 = add nsw i32 %7, %8, !dbg !46
  store i32 %9, i32* %4, align 4, !dbg !43
  ret i32 0, !dbg !47
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+a,+c,+m,+relax" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "testFunction.c", directory: "/home/letizia/llvm_repo/llvm-project")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 1, !"target-abi", !"lp64"}
!7 = !{!"clang version 10.0.0-4ubuntu1 "}
!8 = distinct !DISubprogram(name: "TestFunction1", scope: !1, file: !1, line: 3, type: !9, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!9 = !DISubroutineType(types: !10)
!10 = !{!11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "a", scope: !8, file: !1, line: 4, type: !11)
!13 = !DILocation(line: 4, column: 6, scope: !8)
!14 = !DILocalVariable(name: "b", scope: !8, file: !1, line: 5, type: !11)
!15 = !DILocation(line: 5, column: 6, scope: !8)
!16 = !DILocalVariable(name: "mySum", scope: !8, file: !1, line: 6, type: !11)
!17 = !DILocation(line: 6, column: 6, scope: !8)
!18 = !DILocation(line: 6, column: 14, scope: !8)
!19 = !DILocation(line: 6, column: 18, scope: !8)
!20 = !DILocation(line: 6, column: 16, scope: !8)
!21 = !DILocation(line: 8, column: 9, scope: !8)
!22 = !DILocation(line: 8, column: 2, scope: !8)
!23 = distinct !DISubprogram(name: "TestFunction2", scope: !1, file: !1, line: 12, type: !9, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!24 = !DILocalVariable(name: "c", scope: !23, file: !1, line: 13, type: !11)
!25 = !DILocation(line: 13, column: 6, scope: !23)
!26 = !DILocalVariable(name: "d", scope: !23, file: !1, line: 14, type: !11)
!27 = !DILocation(line: 14, column: 6, scope: !23)
!28 = !DILocalVariable(name: "myMul", scope: !23, file: !1, line: 15, type: !11)
!29 = !DILocation(line: 15, column: 6, scope: !23)
!30 = !DILocation(line: 15, column: 14, scope: !23)
!31 = !DILocation(line: 15, column: 18, scope: !23)
!32 = !DILocation(line: 15, column: 16, scope: !23)
!33 = !DILocation(line: 17, column: 9, scope: !23)
!34 = !DILocation(line: 17, column: 2, scope: !23)
!35 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 20, type: !9, scopeLine: 20, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!36 = !DILocalVariable(name: "Sum", scope: !35, file: !1, line: 22, type: !11)
!37 = !DILocation(line: 22, column: 6, scope: !35)
!38 = !DILocation(line: 22, column: 12, scope: !35)
!39 = !DILocalVariable(name: "Prod", scope: !35, file: !1, line: 24, type: !11)
!40 = !DILocation(line: 24, column: 6, scope: !35)
!41 = !DILocation(line: 24, column: 13, scope: !35)
!42 = !DILocalVariable(name: "Res", scope: !35, file: !1, line: 26, type: !11)
!43 = !DILocation(line: 26, column: 6, scope: !35)
!44 = !DILocation(line: 26, column: 12, scope: !35)
!45 = !DILocation(line: 26, column: 18, scope: !35)
!46 = !DILocation(line: 26, column: 16, scope: !35)
!47 = !DILocation(line: 28, column: 2, scope: !35)
