; ModuleID = 'nested_functions.c'
source_filename = "nested_functions.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "riscv64-unknown-unknown-elf"

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction3(i32 noundef signext %0, i32 noundef signext %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr %4, align 4
  %9 = xor i32 %7, %8
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr %5, align 4
  %11 = sub nsw i32 %10, 37
  store i32 %11, ptr %6, align 4
  %12 = load i32, ptr %6, align 4
  ret i32 %12
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction2(i32 noundef signext %0, i32 noundef signext %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr %4, align 4
  %9 = call signext i32 @TestFunction3(i32 noundef signext %7, i32 noundef signext %8)
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr %3, align 4
  %11 = load i32, ptr %5, align 4
  %12 = mul nsw i32 %10, %11
  store i32 %12, ptr %6, align 4
  %13 = load i32, ptr %6, align 4
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction1(i32 noundef signext %0, i32 noundef signext %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = load i32, ptr %4, align 4
  %9 = call signext i32 @TestFunction2(i32 noundef signext %7, i32 noundef signext %8)
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr %5, align 4
  %11 = load i32, ptr %4, align 4
  %12 = add nsw i32 %10, %11
  store i32 %12, ptr %6, align 4
  %13 = load i32, ptr %6, align 4
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %6

6:                                                ; preds = %14, %0
  %7 = load i32, ptr %4, align 4
  %8 = icmp slt i32 %7, 4
  br i1 %8, label %9, label %17

9:                                                ; preds = %6
  %10 = load i32, ptr %2, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, ptr %2, align 4
  %12 = load i32, ptr %3, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, ptr %3, align 4
  br label %14

14:                                               ; preds = %9
  %15 = load i32, ptr %4, align 4
  %16 = add nsw i32 %15, 1
  store i32 %16, ptr %4, align 4
  br label %6, !llvm.loop !5

17:                                               ; preds = %6
  %18 = load i32, ptr %2, align 4
  %19 = load i32, ptr %3, align 4
  %20 = call signext i32 @TestFunction1(i32 noundef signext %18, i32 noundef signext %19)
  store i32 %20, ptr %5, align 4
  %21 = load i32, ptr %5, align 4
  %22 = mul nsw i32 %21, 2
  store i32 %22, ptr %5, align 4
  ret i32 0
}

attributes #0 = { noinline nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic-rv64" "target-features"="+64bit,+a,+c,+m,+relax,-save-restore" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{!"clang version 16.0.0 (https://github.com/letiziaburioli/llvm-project 1e627039b3666fbd7a6d5688a8f71092e48cf653)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
