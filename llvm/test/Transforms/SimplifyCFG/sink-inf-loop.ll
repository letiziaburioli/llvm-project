; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -keep-loops=false -sink-common-insts=true -S | FileCheck %s

; This would infinite-loop because we allowed code sinking to examine an infinite-loop block (%j).

define void @PR49541(i32* %t1, i32 %a, i1 %bool) {
; CHECK-LABEL: @PR49541(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[I:%.*]]
; CHECK:       j:
; CHECK-NEXT:    [[T3:%.*]] = phi i32 [ [[B:%.*]], [[J:%.*]] ], [ [[A:%.*]], [[COND_TRUE:%.*]] ], [ [[A]], [[COND_FALSE:%.*]] ]
; CHECK-NEXT:    [[T2:%.*]] = phi i32 [ [[T2]], [[J]] ], [ [[PRE2:%.*]], [[COND_TRUE]] ], [ 0, [[COND_FALSE]] ]
; CHECK-NEXT:    [[B]] = load i32, i32* [[T1:%.*]], align 4
; CHECK-NEXT:    br label [[J]]
; CHECK:       i:
; CHECK-NEXT:    [[G_1:%.*]] = phi i16 [ undef, [[ENTRY:%.*]] ], [ [[G_1]], [[COND_FALSE]] ]
; CHECK-NEXT:    br i1 [[BOOL:%.*]], label [[COND_FALSE]], label [[COND_TRUE]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[TOBOOL9_NOT:%.*]] = icmp eq i16 [[G_1]], 0
; CHECK-NEXT:    [[PRE2]] = load i32, i32* [[T1]], align 4
; CHECK-NEXT:    br label [[J]]
; CHECK:       cond.false:
; CHECK-NEXT:    [[T5:%.*]] = load i32, i32* [[T1]], align 4
; CHECK-NEXT:    [[B2:%.*]] = icmp eq i32 [[T5]], 0
; CHECK-NEXT:    br i1 [[B2]], label [[J]], label [[I]]
;
entry:
  br label %i

j:
  %t3 = phi i32 [ %b, %j ], [ %a, %cond.true ], [ %a, %cond.false ]
  %t2 = phi i32 [ %t2, %j ], [ %pre2, %cond.true ], [ 0, %cond.false ]
  %b = load i32, i32* %t1, align 4
  br label %j

i:
  %g.1 = phi i16 [ undef, %entry ], [ %g.1, %cond.false ]
  br i1 %bool, label %cond.false, label %cond.true

cond.true:
  %tobool9.not = icmp eq i16 %g.1, 0
  %pre2 = load i32, i32* %t1, align 4
  br label %j

cond.false:
  %t5 = load i32, i32* %t1, align 4
  %b2 = icmp eq i32 %t5, 0
  br i1 %b2, label %j, label %i
}
