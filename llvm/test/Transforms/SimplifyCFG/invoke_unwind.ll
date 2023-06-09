; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

declare void @bar()

; This testcase checks to see if the simplifycfg pass is converting invoke
; instructions to call instructions if the handler just rethrows the exception.
define i32 @test1() personality i32 (...)* @__gxx_personality_v0 {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    call void @bar(), !prof !0
; CHECK-NEXT:    ret i32 0
;
  invoke void @bar( )
  to label %1 unwind label %Rethrow, !prof !0
  ret i32 0
Rethrow:
  %exn = landingpad {i8*, i32}
  catch i8* null
  resume { i8*, i32 } %exn
}

!0 = !{!"branch_weights", i32 369, i32 2}

define i32 @test2() personality i32 (...)* @__gxx_personality_v0 {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    call void @bar() [ "foo"(i32 100) ]
; CHECK-NEXT:    ret i32 0
;
  invoke void @bar( ) [ "foo"(i32 100) ]
  to label %1 unwind label %Rethrow
  ret i32 0
Rethrow:
  %exn = landingpad {i8*, i32}
  catch i8* null
  resume { i8*, i32 } %exn
}

declare i64 @dummy1()
declare i64 @dummy2()

; This testcase checks to see if simplifycfg pass can convert two invoke
; instructions to call instructions if they share a common trivial unwind
; block.
define i64 @test3(i1 %cond) personality i32 (...)* @__gxx_personality_v0 {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BR1:%.*]], label [[BR2:%.*]]
; CHECK:       br1:
; CHECK-NEXT:    [[CALL1:%.*]] = call i64 @dummy1()
; CHECK-NEXT:    br label [[INVOKE_CONT:%.*]]
; CHECK:       br2:
; CHECK-NEXT:    [[CALL2:%.*]] = call i64 @dummy2()
; CHECK-NEXT:    br label [[INVOKE_CONT]]
; CHECK:       invoke.cont:
; CHECK-NEXT:    [[C:%.*]] = phi i64 [ [[CALL1]], [[BR1]] ], [ [[CALL2]], [[BR2]] ]
; CHECK-NEXT:    ret i64 [[C]]
;
entry:
  br i1 %cond, label %br1, label %br2

br1:
  %call1 = invoke i64 @dummy1()
  to label %invoke.cont unwind label %lpad1

br2:
  %call2 = invoke i64 @dummy2()
  to label %invoke.cont unwind label %lpad2

invoke.cont:
  %c = phi i64 [%call1, %br1], [%call2, %br2]
  ret i64 %c


lpad1:
  %0 = landingpad { i8*, i32 }
  cleanup
  br label %rethrow

rethrow:
  %lp = phi { i8*, i32 } [%0, %lpad1], [%1, %lpad2]
  resume { i8*, i32 } %lp

lpad2:
  %1 = landingpad { i8*, i32 }
  cleanup
  br label %rethrow
}

declare i32 @__gxx_personality_v0(...)
