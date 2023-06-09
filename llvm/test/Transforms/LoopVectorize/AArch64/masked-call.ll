; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize,instsimplify -force-vector-interleave=1 -S | FileCheck %s --check-prefixes=TFNONE
; RUN: opt < %s -passes=loop-vectorize,instsimplify -force-vector-interleave=1 -prefer-predicate-over-epilogue=predicate-dont-vectorize -S | FileCheck %s --check-prefixes=TFALWAYS
; RUN: opt < %s -passes=loop-vectorize,instsimplify -force-vector-interleave=1 -prefer-predicate-over-epilogue=predicate-else-scalar-epilogue -S | FileCheck %s --check-prefixes=TFFALLBACK

target triple = "aarch64-unknown-linux-gnu"

; A call whose argument must be widened. We check that tail folding uses the
; primary mask, and that without tail folding we synthesize an all-true mask.
define void @test_widen(i64* noalias %a, i64* readnone %b) #4 {
; TFNONE-LABEL: @test_widen(
; TFNONE-NEXT:  entry:
; TFNONE-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; TFNONE:       vector.ph:
; TFNONE-NEXT:    br label [[VECTOR_BODY:%.*]]
; TFNONE:       vector.body:
; TFNONE-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; TFNONE-NEXT:    [[TMP0:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDEX]]
; TFNONE-NEXT:    [[TMP1:%.*]] = bitcast i64* [[TMP0]] to <2 x i64>*
; TFNONE-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x i64>, <2 x i64>* [[TMP1]], align 4
; TFNONE-NEXT:    [[TMP2:%.*]] = extractelement <2 x i64> [[WIDE_LOAD]], i32 0
; TFNONE-NEXT:    [[TMP3:%.*]] = call i64 @foo(i64 [[TMP2]]) #[[ATTR2:[0-9]+]]
; TFNONE-NEXT:    [[TMP4:%.*]] = extractelement <2 x i64> [[WIDE_LOAD]], i32 1
; TFNONE-NEXT:    [[TMP5:%.*]] = call i64 @foo(i64 [[TMP4]]) #[[ATTR2]]
; TFNONE-NEXT:    [[TMP6:%.*]] = insertelement <2 x i64> poison, i64 [[TMP3]], i32 0
; TFNONE-NEXT:    [[TMP7:%.*]] = insertelement <2 x i64> [[TMP6]], i64 [[TMP5]], i32 1
; TFNONE-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDEX]]
; TFNONE-NEXT:    [[TMP9:%.*]] = bitcast i64* [[TMP8]] to <2 x i64>*
; TFNONE-NEXT:    store <2 x i64> [[TMP7]], <2 x i64>* [[TMP9]], align 4
; TFNONE-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; TFNONE-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; TFNONE-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; TFNONE:       middle.block:
; TFNONE-NEXT:    br i1 true, label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; TFNONE:       scalar.ph:
; TFNONE-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 1024, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; TFNONE-NEXT:    br label [[FOR_BODY:%.*]]
; TFNONE:       for.body:
; TFNONE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFNONE-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFNONE-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR2]]
; TFNONE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFNONE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFNONE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFNONE-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; TFNONE:       for.cond.cleanup:
; TFNONE-NEXT:    ret void
;
; TFALWAYS-LABEL: @test_widen(
; TFALWAYS-NEXT:  entry:
; TFALWAYS-NEXT:    br label [[FOR_BODY:%.*]]
; TFALWAYS:       for.body:
; TFALWAYS-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFALWAYS-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFALWAYS-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR1:[0-9]+]]
; TFALWAYS-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFALWAYS-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFALWAYS-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFALWAYS-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFALWAYS:       for.cond.cleanup:
; TFALWAYS-NEXT:    ret void
;
; TFFALLBACK-LABEL: @test_widen(
; TFFALLBACK-NEXT:  entry:
; TFFALLBACK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; TFFALLBACK:       vector.ph:
; TFFALLBACK-NEXT:    br label [[VECTOR_BODY:%.*]]
; TFFALLBACK:       vector.body:
; TFFALLBACK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; TFFALLBACK-NEXT:    [[TMP0:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDEX]]
; TFFALLBACK-NEXT:    [[TMP1:%.*]] = bitcast i64* [[TMP0]] to <2 x i64>*
; TFFALLBACK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x i64>, <2 x i64>* [[TMP1]], align 4
; TFFALLBACK-NEXT:    [[TMP2:%.*]] = extractelement <2 x i64> [[WIDE_LOAD]], i32 0
; TFFALLBACK-NEXT:    [[TMP3:%.*]] = call i64 @foo(i64 [[TMP2]]) #[[ATTR2:[0-9]+]]
; TFFALLBACK-NEXT:    [[TMP4:%.*]] = extractelement <2 x i64> [[WIDE_LOAD]], i32 1
; TFFALLBACK-NEXT:    [[TMP5:%.*]] = call i64 @foo(i64 [[TMP4]]) #[[ATTR2]]
; TFFALLBACK-NEXT:    [[TMP6:%.*]] = insertelement <2 x i64> poison, i64 [[TMP3]], i32 0
; TFFALLBACK-NEXT:    [[TMP7:%.*]] = insertelement <2 x i64> [[TMP6]], i64 [[TMP5]], i32 1
; TFFALLBACK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDEX]]
; TFFALLBACK-NEXT:    [[TMP9:%.*]] = bitcast i64* [[TMP8]] to <2 x i64>*
; TFFALLBACK-NEXT:    store <2 x i64> [[TMP7]], <2 x i64>* [[TMP9]], align 4
; TFFALLBACK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 2
; TFFALLBACK-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[INDEX_NEXT]], 1024
; TFFALLBACK-NEXT:    br i1 [[TMP10]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; TFFALLBACK:       middle.block:
; TFFALLBACK-NEXT:    br i1 true, label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; TFFALLBACK:       scalar.ph:
; TFFALLBACK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 1024, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; TFFALLBACK-NEXT:    br label [[FOR_BODY:%.*]]
; TFFALLBACK:       for.body:
; TFFALLBACK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFFALLBACK-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFFALLBACK-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR2]]
; TFFALLBACK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFFALLBACK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFFALLBACK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFFALLBACK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP2:![0-9]+]]
; TFFALLBACK:       for.cond.cleanup:
; TFFALLBACK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gep = getelementptr i64, i64* %b, i64 %indvars.iv
  %load = load i64, i64* %gep
  %call = call i64 @foo(i64 %load) #1
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %indvars.iv
  store i64 %call, i64* %arrayidx
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; Check that a simple conditional call can be vectorized.
define void @test_if_then(i64* noalias %a, i64* readnone %b) #4 {
; TFNONE-LABEL: @test_if_then(
; TFNONE-NEXT:  entry:
; TFNONE-NEXT:    br label [[FOR_BODY:%.*]]
; TFNONE:       for.body:
; TFNONE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; TFNONE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    [[TMP0:%.*]] = load i64, i64* [[ARRAYIDX]], align 8
; TFNONE-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[TMP0]], 50
; TFNONE-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END]]
; TFNONE:       if.then:
; TFNONE-NEXT:    [[TMP1:%.*]] = call i64 @foo(i64 [[TMP0]]) #[[ATTR2]]
; TFNONE-NEXT:    br label [[IF_END]]
; TFNONE:       if.end:
; TFNONE-NEXT:    [[TMP2:%.*]] = phi i64 [ [[TMP1]], [[IF_THEN]] ], [ 0, [[FOR_BODY]] ]
; TFNONE-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    store i64 [[TMP2]], i64* [[ARRAYIDX1]], align 8
; TFNONE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFNONE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFNONE-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFNONE:       for.cond.cleanup:
; TFNONE-NEXT:    ret void
;
; TFALWAYS-LABEL: @test_if_then(
; TFALWAYS-NEXT:  entry:
; TFALWAYS-NEXT:    br label [[FOR_BODY:%.*]]
; TFALWAYS:       for.body:
; TFALWAYS-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; TFALWAYS-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    [[TMP0:%.*]] = load i64, i64* [[ARRAYIDX]], align 8
; TFALWAYS-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[TMP0]], 50
; TFALWAYS-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END]]
; TFALWAYS:       if.then:
; TFALWAYS-NEXT:    [[TMP1:%.*]] = call i64 @foo(i64 [[TMP0]]) #[[ATTR1]]
; TFALWAYS-NEXT:    br label [[IF_END]]
; TFALWAYS:       if.end:
; TFALWAYS-NEXT:    [[TMP2:%.*]] = phi i64 [ [[TMP1]], [[IF_THEN]] ], [ 0, [[FOR_BODY]] ]
; TFALWAYS-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    store i64 [[TMP2]], i64* [[ARRAYIDX1]], align 8
; TFALWAYS-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFALWAYS-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFALWAYS-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFALWAYS:       for.cond.cleanup:
; TFALWAYS-NEXT:    ret void
;
; TFFALLBACK-LABEL: @test_if_then(
; TFFALLBACK-NEXT:  entry:
; TFFALLBACK-NEXT:    br label [[FOR_BODY:%.*]]
; TFFALLBACK:       for.body:
; TFFALLBACK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; TFFALLBACK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    [[TMP0:%.*]] = load i64, i64* [[ARRAYIDX]], align 8
; TFFALLBACK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[TMP0]], 50
; TFFALLBACK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_END]]
; TFFALLBACK:       if.then:
; TFFALLBACK-NEXT:    [[TMP1:%.*]] = call i64 @foo(i64 [[TMP0]]) #[[ATTR2]]
; TFFALLBACK-NEXT:    br label [[IF_END]]
; TFFALLBACK:       if.end:
; TFFALLBACK-NEXT:    [[TMP2:%.*]] = phi i64 [ [[TMP1]], [[IF_THEN]] ], [ 0, [[FOR_BODY]] ]
; TFFALLBACK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    store i64 [[TMP2]], i64* [[ARRAYIDX1]], align 8
; TFFALLBACK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFFALLBACK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFFALLBACK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFFALLBACK:       for.cond.cleanup:
; TFFALLBACK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %indvars.iv
  %0 = load i64, i64* %arrayidx, align 8
  %cmp = icmp ugt i64 %0, 50
  br i1 %cmp, label %if.then, label %if.end

if.then:
  %1 = call i64 @foo(i64 %0) #1
  br label %if.end

if.end:
  %2 = phi i64 [%1, %if.then], [0, %for.body]
  %arrayidx1 = getelementptr inbounds i64, i64* %b, i64 %indvars.iv
  store i64 %2, i64* %arrayidx1, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; This checks the ability to handle masking of an if-then-else CFG with
; calls inside the conditional blocks. Although one of the calls has a
; uniform parameter and the metadata lists a uniform variant, right now
; we just see a splat of the parameter instead. More work needed.
define void @test_widen_if_then_else(i64* noalias %a, i64* readnone %b) #4 {
; TFNONE-LABEL: @test_widen_if_then_else(
; TFNONE-NEXT:  entry:
; TFNONE-NEXT:    br label [[FOR_BODY:%.*]]
; TFNONE:       for.body:
; TFNONE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; TFNONE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    [[TMP0:%.*]] = load i64, i64* [[ARRAYIDX]], align 8
; TFNONE-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[TMP0]], 50
; TFNONE-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; TFNONE:       if.then:
; TFNONE-NEXT:    [[TMP1:%.*]] = call i64 @foo(i64 [[TMP0]]) #[[ATTR3:[0-9]+]]
; TFNONE-NEXT:    br label [[IF_END]]
; TFNONE:       if.else:
; TFNONE-NEXT:    [[TMP2:%.*]] = call i64 @foo(i64 0) #[[ATTR3]]
; TFNONE-NEXT:    br label [[IF_END]]
; TFNONE:       if.end:
; TFNONE-NEXT:    [[TMP3:%.*]] = phi i64 [ [[TMP1]], [[IF_THEN]] ], [ [[TMP2]], [[IF_ELSE]] ]
; TFNONE-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    store i64 [[TMP3]], i64* [[ARRAYIDX1]], align 8
; TFNONE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFNONE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFNONE-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFNONE:       for.cond.cleanup:
; TFNONE-NEXT:    ret void
;
; TFALWAYS-LABEL: @test_widen_if_then_else(
; TFALWAYS-NEXT:  entry:
; TFALWAYS-NEXT:    br label [[FOR_BODY:%.*]]
; TFALWAYS:       for.body:
; TFALWAYS-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; TFALWAYS-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    [[TMP0:%.*]] = load i64, i64* [[ARRAYIDX]], align 8
; TFALWAYS-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[TMP0]], 50
; TFALWAYS-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; TFALWAYS:       if.then:
; TFALWAYS-NEXT:    [[TMP1:%.*]] = call i64 @foo(i64 [[TMP0]]) #[[ATTR2:[0-9]+]]
; TFALWAYS-NEXT:    br label [[IF_END]]
; TFALWAYS:       if.else:
; TFALWAYS-NEXT:    [[TMP2:%.*]] = call i64 @foo(i64 0) #[[ATTR2]]
; TFALWAYS-NEXT:    br label [[IF_END]]
; TFALWAYS:       if.end:
; TFALWAYS-NEXT:    [[TMP3:%.*]] = phi i64 [ [[TMP1]], [[IF_THEN]] ], [ [[TMP2]], [[IF_ELSE]] ]
; TFALWAYS-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    store i64 [[TMP3]], i64* [[ARRAYIDX1]], align 8
; TFALWAYS-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFALWAYS-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFALWAYS-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFALWAYS:       for.cond.cleanup:
; TFALWAYS-NEXT:    ret void
;
; TFFALLBACK-LABEL: @test_widen_if_then_else(
; TFFALLBACK-NEXT:  entry:
; TFFALLBACK-NEXT:    br label [[FOR_BODY:%.*]]
; TFFALLBACK:       for.body:
; TFFALLBACK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[IF_END:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; TFFALLBACK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    [[TMP0:%.*]] = load i64, i64* [[ARRAYIDX]], align 8
; TFFALLBACK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[TMP0]], 50
; TFFALLBACK-NEXT:    br i1 [[CMP]], label [[IF_THEN:%.*]], label [[IF_ELSE:%.*]]
; TFFALLBACK:       if.then:
; TFFALLBACK-NEXT:    [[TMP1:%.*]] = call i64 @foo(i64 [[TMP0]]) #[[ATTR3:[0-9]+]]
; TFFALLBACK-NEXT:    br label [[IF_END]]
; TFFALLBACK:       if.else:
; TFFALLBACK-NEXT:    [[TMP2:%.*]] = call i64 @foo(i64 0) #[[ATTR3]]
; TFFALLBACK-NEXT:    br label [[IF_END]]
; TFFALLBACK:       if.end:
; TFFALLBACK-NEXT:    [[TMP3:%.*]] = phi i64 [ [[TMP1]], [[IF_THEN]] ], [ [[TMP2]], [[IF_ELSE]] ]
; TFFALLBACK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    store i64 [[TMP3]], i64* [[ARRAYIDX1]], align 8
; TFFALLBACK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFFALLBACK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFFALLBACK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFFALLBACK:       for.cond.cleanup:
; TFFALLBACK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ %indvars.iv.next, %if.end ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %indvars.iv
  %0 = load i64, i64* %arrayidx, align 8
  %cmp = icmp ugt i64 %0, 50
  br i1 %cmp, label %if.then, label %if.else

if.then:
  %1 = call i64 @foo(i64 %0) #0
  br label %if.end

if.else:
  %2 = call i64 @foo(i64 0) #0
  br label %if.end

if.end:
  %3 = phi i64 [%1, %if.then], [%2, %if.else]
  %arrayidx1 = getelementptr inbounds i64, i64* %b, i64 %indvars.iv
  store i64 %3, i64* %arrayidx1, align 8
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; A call whose argument must be widened, where the vector variant does not have
; a mask. Forcing tail folding results in no vectorized call, whereas an
; unpredicated body with scalar tail can use the unmasked variant.
define void @test_widen_nomask(i64* noalias %a, i64* readnone %b) #4 {
; TFNONE-LABEL: @test_widen_nomask(
; TFNONE-NEXT:  entry:
; TFNONE-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; TFNONE-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 2
; TFNONE-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 1024, [[TMP1]]
; TFNONE-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; TFNONE:       vector.ph:
; TFNONE-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; TFNONE-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 2
; TFNONE-NEXT:    [[N_MOD_VF:%.*]] = urem i64 1024, [[TMP3]]
; TFNONE-NEXT:    [[N_VEC:%.*]] = sub i64 1024, [[N_MOD_VF]]
; TFNONE-NEXT:    br label [[VECTOR_BODY:%.*]]
; TFNONE:       vector.body:
; TFNONE-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; TFNONE-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDEX]]
; TFNONE-NEXT:    [[TMP5:%.*]] = bitcast i64* [[TMP4]] to <vscale x 2 x i64>*
; TFNONE-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP5]], align 4
; TFNONE-NEXT:    [[TMP6:%.*]] = call <vscale x 2 x i64> @foo_vector_nomask(<vscale x 2 x i64> [[WIDE_LOAD]])
; TFNONE-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDEX]]
; TFNONE-NEXT:    [[TMP8:%.*]] = bitcast i64* [[TMP7]] to <vscale x 2 x i64>*
; TFNONE-NEXT:    store <vscale x 2 x i64> [[TMP6]], <vscale x 2 x i64>* [[TMP8]], align 4
; TFNONE-NEXT:    [[TMP9:%.*]] = call i64 @llvm.vscale.i64()
; TFNONE-NEXT:    [[TMP10:%.*]] = mul i64 [[TMP9]], 2
; TFNONE-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP10]]
; TFNONE-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; TFNONE-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; TFNONE:       middle.block:
; TFNONE-NEXT:    [[CMP_N:%.*]] = icmp eq i64 1024, [[N_VEC]]
; TFNONE-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; TFNONE:       scalar.ph:
; TFNONE-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; TFNONE-NEXT:    br label [[FOR_BODY:%.*]]
; TFNONE:       for.body:
; TFNONE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFNONE-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFNONE-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR4:[0-9]+]]
; TFNONE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFNONE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFNONE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFNONE-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; TFNONE:       for.cond.cleanup:
; TFNONE-NEXT:    ret void
;
; TFALWAYS-LABEL: @test_widen_nomask(
; TFALWAYS-NEXT:  entry:
; TFALWAYS-NEXT:    br label [[FOR_BODY:%.*]]
; TFALWAYS:       for.body:
; TFALWAYS-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFALWAYS-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFALWAYS-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR3:[0-9]+]]
; TFALWAYS-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFALWAYS-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFALWAYS-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFALWAYS-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFALWAYS:       for.cond.cleanup:
; TFALWAYS-NEXT:    ret void
;
; TFFALLBACK-LABEL: @test_widen_nomask(
; TFFALLBACK-NEXT:  entry:
; TFFALLBACK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; TFFALLBACK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 2
; TFFALLBACK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 1024, [[TMP1]]
; TFFALLBACK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; TFFALLBACK:       vector.ph:
; TFFALLBACK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; TFFALLBACK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 2
; TFFALLBACK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 1024, [[TMP3]]
; TFFALLBACK-NEXT:    [[N_VEC:%.*]] = sub i64 1024, [[N_MOD_VF]]
; TFFALLBACK-NEXT:    br label [[VECTOR_BODY:%.*]]
; TFFALLBACK:       vector.body:
; TFFALLBACK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; TFFALLBACK-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDEX]]
; TFFALLBACK-NEXT:    [[TMP5:%.*]] = bitcast i64* [[TMP4]] to <vscale x 2 x i64>*
; TFFALLBACK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP5]], align 4
; TFFALLBACK-NEXT:    [[TMP6:%.*]] = call <vscale x 2 x i64> @foo_vector_nomask(<vscale x 2 x i64> [[WIDE_LOAD]])
; TFFALLBACK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDEX]]
; TFFALLBACK-NEXT:    [[TMP8:%.*]] = bitcast i64* [[TMP7]] to <vscale x 2 x i64>*
; TFFALLBACK-NEXT:    store <vscale x 2 x i64> [[TMP6]], <vscale x 2 x i64>* [[TMP8]], align 4
; TFFALLBACK-NEXT:    [[TMP9:%.*]] = call i64 @llvm.vscale.i64()
; TFFALLBACK-NEXT:    [[TMP10:%.*]] = mul i64 [[TMP9]], 2
; TFFALLBACK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP10]]
; TFFALLBACK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; TFFALLBACK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; TFFALLBACK:       middle.block:
; TFFALLBACK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 1024, [[N_VEC]]
; TFFALLBACK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; TFFALLBACK:       scalar.ph:
; TFFALLBACK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; TFFALLBACK-NEXT:    br label [[FOR_BODY:%.*]]
; TFFALLBACK:       for.body:
; TFFALLBACK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFFALLBACK-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFFALLBACK-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR4:[0-9]+]]
; TFFALLBACK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFFALLBACK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFFALLBACK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFFALLBACK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP5:![0-9]+]]
; TFFALLBACK:       for.cond.cleanup:
; TFFALLBACK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gep = getelementptr i64, i64* %b, i64 %indvars.iv
  %load = load i64, i64* %gep
  %call = call i64 @foo(i64 %load) #2
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %indvars.iv
  store i64 %call, i64* %arrayidx
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

; If both masked and unmasked options are present, we expect to see tail folding
; use the masked version and unpredicated body with scalar tail use the unmasked
; version.
define void @test_widen_optmask(i64* noalias %a, i64* readnone %b) #4 {
; TFNONE-LABEL: @test_widen_optmask(
; TFNONE-NEXT:  entry:
; TFNONE-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; TFNONE-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 2
; TFNONE-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 1024, [[TMP1]]
; TFNONE-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; TFNONE:       vector.ph:
; TFNONE-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; TFNONE-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 2
; TFNONE-NEXT:    [[N_MOD_VF:%.*]] = urem i64 1024, [[TMP3]]
; TFNONE-NEXT:    [[N_VEC:%.*]] = sub i64 1024, [[N_MOD_VF]]
; TFNONE-NEXT:    br label [[VECTOR_BODY:%.*]]
; TFNONE:       vector.body:
; TFNONE-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; TFNONE-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDEX]]
; TFNONE-NEXT:    [[TMP5:%.*]] = bitcast i64* [[TMP4]] to <vscale x 2 x i64>*
; TFNONE-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP5]], align 4
; TFNONE-NEXT:    [[TMP6:%.*]] = call <vscale x 2 x i64> @foo_vector_nomask(<vscale x 2 x i64> [[WIDE_LOAD]])
; TFNONE-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDEX]]
; TFNONE-NEXT:    [[TMP8:%.*]] = bitcast i64* [[TMP7]] to <vscale x 2 x i64>*
; TFNONE-NEXT:    store <vscale x 2 x i64> [[TMP6]], <vscale x 2 x i64>* [[TMP8]], align 4
; TFNONE-NEXT:    [[TMP9:%.*]] = call i64 @llvm.vscale.i64()
; TFNONE-NEXT:    [[TMP10:%.*]] = mul i64 [[TMP9]], 2
; TFNONE-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP10]]
; TFNONE-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; TFNONE-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; TFNONE:       middle.block:
; TFNONE-NEXT:    [[CMP_N:%.*]] = icmp eq i64 1024, [[N_VEC]]
; TFNONE-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; TFNONE:       scalar.ph:
; TFNONE-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; TFNONE-NEXT:    br label [[FOR_BODY:%.*]]
; TFNONE:       for.body:
; TFNONE-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFNONE-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFNONE-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR5:[0-9]+]]
; TFNONE-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; TFNONE-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFNONE-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFNONE-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFNONE-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; TFNONE:       for.cond.cleanup:
; TFNONE-NEXT:    ret void
;
; TFALWAYS-LABEL: @test_widen_optmask(
; TFALWAYS-NEXT:  entry:
; TFALWAYS-NEXT:    br label [[FOR_BODY:%.*]]
; TFALWAYS:       for.body:
; TFALWAYS-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFALWAYS-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFALWAYS-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR4:[0-9]+]]
; TFALWAYS-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDVARS_IV]]
; TFALWAYS-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFALWAYS-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFALWAYS-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFALWAYS-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_BODY]]
; TFALWAYS:       for.cond.cleanup:
; TFALWAYS-NEXT:    ret void
;
; TFFALLBACK-LABEL: @test_widen_optmask(
; TFFALLBACK-NEXT:  entry:
; TFFALLBACK-NEXT:    [[TMP0:%.*]] = call i64 @llvm.vscale.i64()
; TFFALLBACK-NEXT:    [[TMP1:%.*]] = mul i64 [[TMP0]], 2
; TFFALLBACK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i64 1024, [[TMP1]]
; TFFALLBACK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; TFFALLBACK:       vector.ph:
; TFFALLBACK-NEXT:    [[TMP2:%.*]] = call i64 @llvm.vscale.i64()
; TFFALLBACK-NEXT:    [[TMP3:%.*]] = mul i64 [[TMP2]], 2
; TFFALLBACK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 1024, [[TMP3]]
; TFFALLBACK-NEXT:    [[N_VEC:%.*]] = sub i64 1024, [[N_MOD_VF]]
; TFFALLBACK-NEXT:    br label [[VECTOR_BODY:%.*]]
; TFFALLBACK:       vector.body:
; TFFALLBACK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; TFFALLBACK-NEXT:    [[TMP4:%.*]] = getelementptr i64, i64* [[B:%.*]], i64 [[INDEX]]
; TFFALLBACK-NEXT:    [[TMP5:%.*]] = bitcast i64* [[TMP4]] to <vscale x 2 x i64>*
; TFFALLBACK-NEXT:    [[WIDE_LOAD:%.*]] = load <vscale x 2 x i64>, <vscale x 2 x i64>* [[TMP5]], align 4
; TFFALLBACK-NEXT:    [[TMP6:%.*]] = call <vscale x 2 x i64> @foo_vector_nomask(<vscale x 2 x i64> [[WIDE_LOAD]])
; TFFALLBACK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i64, i64* [[A:%.*]], i64 [[INDEX]]
; TFFALLBACK-NEXT:    [[TMP8:%.*]] = bitcast i64* [[TMP7]] to <vscale x 2 x i64>*
; TFFALLBACK-NEXT:    store <vscale x 2 x i64> [[TMP6]], <vscale x 2 x i64>* [[TMP8]], align 4
; TFFALLBACK-NEXT:    [[TMP9:%.*]] = call i64 @llvm.vscale.i64()
; TFFALLBACK-NEXT:    [[TMP10:%.*]] = mul i64 [[TMP9]], 2
; TFFALLBACK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], [[TMP10]]
; TFFALLBACK-NEXT:    [[TMP11:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; TFFALLBACK-NEXT:    br i1 [[TMP11]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; TFFALLBACK:       middle.block:
; TFFALLBACK-NEXT:    [[CMP_N:%.*]] = icmp eq i64 1024, [[N_VEC]]
; TFFALLBACK-NEXT:    br i1 [[CMP_N]], label [[FOR_COND_CLEANUP:%.*]], label [[SCALAR_PH]]
; TFFALLBACK:       scalar.ph:
; TFFALLBACK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; TFFALLBACK-NEXT:    br label [[FOR_BODY:%.*]]
; TFFALLBACK:       for.body:
; TFFALLBACK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ]
; TFFALLBACK-NEXT:    [[GEP:%.*]] = getelementptr i64, i64* [[B]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    [[LOAD:%.*]] = load i64, i64* [[GEP]], align 4
; TFFALLBACK-NEXT:    [[CALL:%.*]] = call i64 @foo(i64 [[LOAD]]) #[[ATTR5:[0-9]+]]
; TFFALLBACK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i64, i64* [[A]], i64 [[INDVARS_IV]]
; TFFALLBACK-NEXT:    store i64 [[CALL]], i64* [[ARRAYIDX]], align 4
; TFFALLBACK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; TFFALLBACK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 1024
; TFFALLBACK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY]], !llvm.loop [[LOOP7:![0-9]+]]
; TFFALLBACK:       for.cond.cleanup:
; TFFALLBACK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %gep = getelementptr i64, i64* %b, i64 %indvars.iv
  %load = load i64, i64* %gep
  %call = call i64 @foo(i64 %load) #3
  %arrayidx = getelementptr inbounds i64, i64* %a, i64 %indvars.iv
  store i64 %call, i64* %arrayidx
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 1024
  br i1 %exitcond, label %for.cond.cleanup, label %for.body

for.cond.cleanup:
  ret void
}

declare i64 @foo(i64)

; vector variants of foo
declare <vscale x 2 x i64> @foo_uniform(i64, <vscale x 2 x i1>)
declare <vscale x 2 x i64> @foo_vector(<vscale x 2 x i64>, <vscale x 2 x i1>)
declare <vscale x 2 x i64> @foo_vector_nomask(<vscale x 2 x i64>)

attributes #0 = { nounwind "vector-function-abi-variant"="_ZGV_LLVM_Mxv_foo(foo_vector),_ZGV_LLVM_Mxu_foo(foo_uniform)" }
attributes #1 = { nounwind "vector-function-abi-variant"="_ZGV_LLVM_Mxv_foo(foo_vector)" }
attributes #2 = { nounwind "vector-function-abi-variant"="_ZGV_LLVM_Nxv_foo(foo_vector_nomask)" }
attributes #3 = { nounwind "vector-function-abi-variant"="_ZGV_LLVM_Nxv_foo(foo_vector_nomask),_ZGV_LLVM_Mxv_foo(foo_vector)" }
attributes #4 = { "target-features"="+sve" vscale_range(2,16) "no-trapping-math"="false" }
