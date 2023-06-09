; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -partial-inliner -skip-partial-inlining-cost-analysis -S < %s | FileCheck %s
define void @_Z26recursive_partial_inliningi(i32 noundef %i) local_unnamed_addr {
; CHECK-LABEL: @_Z26recursive_partial_inliningi(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i32 [[I:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[COMMON_RET2:%.*]], label [[IF_END:%.*]]
; CHECK:       common.ret2:
; CHECK-NEXT:    ret void
; CHECK:       if.end:
; CHECK-NEXT:    [[SUB:%.*]] = add nsw i32 [[I]], -1
; CHECK-NEXT:    [[CMP_I:%.*]] = icmp slt i32 [[SUB]], 0
; CHECK-NEXT:    br i1 [[CMP_I]], label [[_Z26RECURSIVE_PARTIAL_INLININGI_1_EXIT:%.*]], label [[CODEREPL_I:%.*]]
; CHECK:       codeRepl.i:
; CHECK-NEXT:    call void @_Z26recursive_partial_inliningi.1.if.end(i32 [[SUB]])
; CHECK-NEXT:    br label [[_Z26RECURSIVE_PARTIAL_INLININGI_1_EXIT]]
; CHECK:       _Z26recursive_partial_inliningi.1.exit:
; CHECK-NEXT:    br label [[COMMON_RET2]]
;
entry:
  %cmp = icmp slt i32 %i, 0
  br i1 %cmp, label %common.ret2, label %if.end

common.ret2:                                      ; preds = %entry, %if.end
  ret void

if.end:                                           ; preds = %entry
  %sub = add nsw i32 %i, -1
  tail call void @_Z26recursive_partial_inliningi(i32 noundef %sub)
  br label %common.ret2
}
