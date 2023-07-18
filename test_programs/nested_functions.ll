; ModuleID = 'nested_functions.c'
source_filename = "nested_functions.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown-elf"

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction3(i32 signext %0, i32 signext %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %7 = load i32, i32* %3, align 4
  %8 = load i32, i32* %4, align 4
  %9 = xor i32 %7, %8
  store i32 %9, i32* %5, align 4
  %10 = load i32, i32* %5, align 4
  %11 = sub nsw i32 %10, 37
  store i32 %11, i32* %6, align 4
  %12 = load i32, i32* %6, align 4
  ret i32 %12
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction2(i32 signext %0, i32 signext %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %7 = load i32, i32* %3, align 4
  %8 = load i32, i32* %4, align 4
  %9 = call signext i32 @TestFunction3(i32 signext %7, i32 signext %8)
  store i32 %9, i32* %5, align 4
  %10 = load i32, i32* %3, align 4
  %11 = load i32, i32* %5, align 4
  %12 = mul nsw i32 %10, %11
  store i32 %12, i32* %6, align 4
  %13 = load i32, i32* %6, align 4
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @TestFunction1(i32 signext %0, i32 signext %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %7 = load i32, i32* %3, align 4
  %8 = load i32, i32* %4, align 4
  %9 = call signext i32 @TestFunction2(i32 signext %7, i32 signext %8)
  store i32 %9, i32* %5, align 4
  %10 = load i32, i32* %5, align 4
  %11 = load i32, i32* %4, align 4
  %12 = add nsw i32 %10, %11
  store i32 %12, i32* %6, align 4
  %13 = load i32, i32* %6, align 4
  ret i32 %13
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %2, align 4
  store i32 0, i32* %3, align 4
  store i32 0, i32* %4, align 4
  br label %6

6:                                                ; preds = %17, %0
  %7 = load i32, i32* %4, align 4
  %8 = icmp slt i32 %7, 4
  br i1 %8, label %9, label %20

9:                                                ; preds = %6
  %10 = load i32, i32* %2, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, i32* %2, align 4
  %12 = load i32, i32* %3, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, i32* %3, align 4
  %14 = load i32, i32* %2, align 4
  %15 = load i32, i32* %3, align 4
  %16 = call signext i32 @TestFunction1(i32 signext %14, i32 signext %15)
  store i32 %16, i32* %5, align 4
  br label %17

17:                                               ; preds = %9
  %18 = load i32, i32* %4, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, i32* %4, align 4
  br label %6

20:                                               ; preds = %6
  ret i32 0
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+a,+c,+m,+relax" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{!"clang version 10.0.0-4ubuntu1 "}
