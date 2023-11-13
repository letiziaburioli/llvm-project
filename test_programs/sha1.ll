; ModuleID = 'sha1.c'
source_filename = "sha1.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown-elf"

%struct.sha1_struct = type { [5 x i32], i32, i32, [64 x i8], i32, i32, i32 }

@__const.message_block_process.K = private unnamed_addr constant [4 x i32] [i32 1518500249, i32 1859775393, i32 -1894007588, i32 -899497514], align 4
@.str = private unnamed_addr constant [17 x i8] c"cps exam project\00", align 1

; Function Attrs: noinline nounwind optnone
define dso_local void @message_block_process(%struct.sha1_struct* %0) #0 {
  %2 = alloca %struct.sha1_struct*, align 8
  %3 = alloca [4 x i32], align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca [80 x i32], align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store %struct.sha1_struct* %0, %struct.sha1_struct** %2, align 8
  %12 = bitcast [4 x i32]* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %12, i8* align 4 bitcast ([4 x i32]* @__const.message_block_process.K to i8*), i64 16, i1 false)
  store i32 0, i32* %4, align 4
  br label %13

13:                                               ; preds = %73, %1
  %14 = load i32, i32* %4, align 4
  %15 = icmp slt i32 %14, 16
  br i1 %15, label %16, label %76

16:                                               ; preds = %13
  %17 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %18 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %17, i32 0, i32 3
  %19 = load i32, i32* %4, align 4
  %20 = mul nsw i32 %19, 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [64 x i8], [64 x i8]* %18, i64 0, i64 %21
  %23 = load i8, i8* %22, align 1
  %24 = zext i8 %23 to i32
  %25 = shl i32 %24, 24
  %26 = load i32, i32* %4, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %27
  store i32 %25, i32* %28, align 4
  %29 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %30 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %29, i32 0, i32 3
  %31 = load i32, i32* %4, align 4
  %32 = mul nsw i32 %31, 4
  %33 = add nsw i32 %32, 1
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds [64 x i8], [64 x i8]* %30, i64 0, i64 %34
  %36 = load i8, i8* %35, align 1
  %37 = zext i8 %36 to i32
  %38 = shl i32 %37, 16
  %39 = load i32, i32* %4, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %40
  %42 = load i32, i32* %41, align 4
  %43 = or i32 %42, %38
  store i32 %43, i32* %41, align 4
  %44 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %45 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %44, i32 0, i32 3
  %46 = load i32, i32* %4, align 4
  %47 = mul nsw i32 %46, 4
  %48 = add nsw i32 %47, 2
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [64 x i8], [64 x i8]* %45, i64 0, i64 %49
  %51 = load i8, i8* %50, align 1
  %52 = zext i8 %51 to i32
  %53 = shl i32 %52, 8
  %54 = load i32, i32* %4, align 4
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %55
  %57 = load i32, i32* %56, align 4
  %58 = or i32 %57, %53
  store i32 %58, i32* %56, align 4
  %59 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %60 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %59, i32 0, i32 3
  %61 = load i32, i32* %4, align 4
  %62 = mul nsw i32 %61, 4
  %63 = add nsw i32 %62, 3
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds [64 x i8], [64 x i8]* %60, i64 0, i64 %64
  %66 = load i8, i8* %65, align 1
  %67 = zext i8 %66 to i32
  %68 = load i32, i32* %4, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %69
  %71 = load i32, i32* %70, align 4
  %72 = or i32 %71, %67
  store i32 %72, i32* %70, align 4
  br label %73

73:                                               ; preds = %16
  %74 = load i32, i32* %4, align 4
  %75 = add nsw i32 %74, 1
  store i32 %75, i32* %4, align 4
  br label %13

76:                                               ; preds = %13
  store i32 16, i32* %4, align 4
  br label %77

77:                                               ; preds = %133, %76
  %78 = load i32, i32* %4, align 4
  %79 = icmp slt i32 %78, 80
  br i1 %79, label %80, label %136

80:                                               ; preds = %77
  %81 = load i32, i32* %4, align 4
  %82 = sub nsw i32 %81, 3
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %83
  %85 = load i32, i32* %84, align 4
  %86 = load i32, i32* %4, align 4
  %87 = sub nsw i32 %86, 8
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %88
  %90 = load i32, i32* %89, align 4
  %91 = xor i32 %85, %90
  %92 = load i32, i32* %4, align 4
  %93 = sub nsw i32 %92, 14
  %94 = sext i32 %93 to i64
  %95 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %94
  %96 = load i32, i32* %95, align 4
  %97 = xor i32 %91, %96
  %98 = load i32, i32* %4, align 4
  %99 = sub nsw i32 %98, 16
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %100
  %102 = load i32, i32* %101, align 4
  %103 = xor i32 %97, %102
  %104 = shl i32 %103, 1
  %105 = load i32, i32* %4, align 4
  %106 = sub nsw i32 %105, 3
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %107
  %109 = load i32, i32* %108, align 4
  %110 = load i32, i32* %4, align 4
  %111 = sub nsw i32 %110, 8
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %112
  %114 = load i32, i32* %113, align 4
  %115 = xor i32 %109, %114
  %116 = load i32, i32* %4, align 4
  %117 = sub nsw i32 %116, 14
  %118 = sext i32 %117 to i64
  %119 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %118
  %120 = load i32, i32* %119, align 4
  %121 = xor i32 %115, %120
  %122 = load i32, i32* %4, align 4
  %123 = sub nsw i32 %122, 16
  %124 = sext i32 %123 to i64
  %125 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %124
  %126 = load i32, i32* %125, align 4
  %127 = xor i32 %121, %126
  %128 = lshr i32 %127, 31
  %129 = or i32 %104, %128
  %130 = load i32, i32* %4, align 4
  %131 = sext i32 %130 to i64
  %132 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %131
  store i32 %129, i32* %132, align 4
  br label %133

133:                                              ; preds = %80
  %134 = load i32, i32* %4, align 4
  %135 = add nsw i32 %134, 1
  store i32 %135, i32* %4, align 4
  br label %77

136:                                              ; preds = %77
  %137 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %138 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %137, i32 0, i32 0
  %139 = getelementptr inbounds [5 x i32], [5 x i32]* %138, i64 0, i64 0
  %140 = load i32, i32* %139, align 4
  store i32 %140, i32* %7, align 4
  %141 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %142 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %141, i32 0, i32 0
  %143 = getelementptr inbounds [5 x i32], [5 x i32]* %142, i64 0, i64 1
  %144 = load i32, i32* %143, align 4
  store i32 %144, i32* %8, align 4
  %145 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %146 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %145, i32 0, i32 0
  %147 = getelementptr inbounds [5 x i32], [5 x i32]* %146, i64 0, i64 2
  %148 = load i32, i32* %147, align 4
  store i32 %148, i32* %9, align 4
  %149 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %150 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %149, i32 0, i32 0
  %151 = getelementptr inbounds [5 x i32], [5 x i32]* %150, i64 0, i64 3
  %152 = load i32, i32* %151, align 4
  store i32 %152, i32* %10, align 4
  %153 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %154 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %153, i32 0, i32 0
  %155 = getelementptr inbounds [5 x i32], [5 x i32]* %154, i64 0, i64 4
  %156 = load i32, i32* %155, align 4
  store i32 %156, i32* %11, align 4
  store i32 0, i32* %4, align 4
  br label %157

157:                                              ; preds = %195, %136
  %158 = load i32, i32* %4, align 4
  %159 = icmp slt i32 %158, 20
  br i1 %159, label %160, label %198

160:                                              ; preds = %157
  %161 = load i32, i32* %7, align 4
  %162 = shl i32 %161, 5
  %163 = load i32, i32* %7, align 4
  %164 = lshr i32 %163, 27
  %165 = or i32 %162, %164
  %166 = load i32, i32* %8, align 4
  %167 = load i32, i32* %9, align 4
  %168 = and i32 %166, %167
  %169 = load i32, i32* %8, align 4
  %170 = xor i32 %169, -1
  %171 = load i32, i32* %10, align 4
  %172 = and i32 %170, %171
  %173 = or i32 %168, %172
  %174 = add i32 %165, %173
  %175 = load i32, i32* %11, align 4
  %176 = add i32 %174, %175
  %177 = load i32, i32* %4, align 4
  %178 = sext i32 %177 to i64
  %179 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %178
  %180 = load i32, i32* %179, align 4
  %181 = add i32 %176, %180
  %182 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 0
  %183 = load i32, i32* %182, align 4
  %184 = add i32 %181, %183
  store i32 %184, i32* %5, align 4
  %185 = load i32, i32* %5, align 4
  store i32 %185, i32* %5, align 4
  %186 = load i32, i32* %10, align 4
  store i32 %186, i32* %11, align 4
  %187 = load i32, i32* %9, align 4
  store i32 %187, i32* %10, align 4
  %188 = load i32, i32* %8, align 4
  %189 = shl i32 %188, 30
  %190 = load i32, i32* %8, align 4
  %191 = lshr i32 %190, 2
  %192 = or i32 %189, %191
  store i32 %192, i32* %9, align 4
  %193 = load i32, i32* %7, align 4
  store i32 %193, i32* %8, align 4
  %194 = load i32, i32* %5, align 4
  store i32 %194, i32* %7, align 4
  br label %195

195:                                              ; preds = %160
  %196 = load i32, i32* %4, align 4
  %197 = add nsw i32 %196, 1
  store i32 %197, i32* %4, align 4
  br label %157

198:                                              ; preds = %157
  store i32 20, i32* %4, align 4
  br label %199

199:                                              ; preds = %234, %198
  %200 = load i32, i32* %4, align 4
  %201 = icmp slt i32 %200, 40
  br i1 %201, label %202, label %237

202:                                              ; preds = %199
  %203 = load i32, i32* %7, align 4
  %204 = shl i32 %203, 5
  %205 = load i32, i32* %7, align 4
  %206 = lshr i32 %205, 27
  %207 = or i32 %204, %206
  %208 = load i32, i32* %8, align 4
  %209 = load i32, i32* %9, align 4
  %210 = xor i32 %208, %209
  %211 = load i32, i32* %10, align 4
  %212 = xor i32 %210, %211
  %213 = add i32 %207, %212
  %214 = load i32, i32* %11, align 4
  %215 = add i32 %213, %214
  %216 = load i32, i32* %4, align 4
  %217 = sext i32 %216 to i64
  %218 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %217
  %219 = load i32, i32* %218, align 4
  %220 = add i32 %215, %219
  %221 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 1
  %222 = load i32, i32* %221, align 4
  %223 = add i32 %220, %222
  store i32 %223, i32* %5, align 4
  %224 = load i32, i32* %5, align 4
  store i32 %224, i32* %5, align 4
  %225 = load i32, i32* %10, align 4
  store i32 %225, i32* %11, align 4
  %226 = load i32, i32* %9, align 4
  store i32 %226, i32* %10, align 4
  %227 = load i32, i32* %8, align 4
  %228 = shl i32 %227, 30
  %229 = load i32, i32* %8, align 4
  %230 = lshr i32 %229, 2
  %231 = or i32 %228, %230
  store i32 %231, i32* %9, align 4
  %232 = load i32, i32* %7, align 4
  store i32 %232, i32* %8, align 4
  %233 = load i32, i32* %5, align 4
  store i32 %233, i32* %7, align 4
  br label %234

234:                                              ; preds = %202
  %235 = load i32, i32* %4, align 4
  %236 = add nsw i32 %235, 1
  store i32 %236, i32* %4, align 4
  br label %199

237:                                              ; preds = %199
  store i32 40, i32* %4, align 4
  br label %238

238:                                              ; preds = %279, %237
  %239 = load i32, i32* %4, align 4
  %240 = icmp slt i32 %239, 60
  br i1 %240, label %241, label %282

241:                                              ; preds = %238
  %242 = load i32, i32* %7, align 4
  %243 = shl i32 %242, 5
  %244 = load i32, i32* %7, align 4
  %245 = lshr i32 %244, 27
  %246 = or i32 %243, %245
  %247 = load i32, i32* %8, align 4
  %248 = load i32, i32* %9, align 4
  %249 = and i32 %247, %248
  %250 = load i32, i32* %8, align 4
  %251 = load i32, i32* %10, align 4
  %252 = and i32 %250, %251
  %253 = or i32 %249, %252
  %254 = load i32, i32* %9, align 4
  %255 = load i32, i32* %10, align 4
  %256 = and i32 %254, %255
  %257 = or i32 %253, %256
  %258 = add i32 %246, %257
  %259 = load i32, i32* %11, align 4
  %260 = add i32 %258, %259
  %261 = load i32, i32* %4, align 4
  %262 = sext i32 %261 to i64
  %263 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %262
  %264 = load i32, i32* %263, align 4
  %265 = add i32 %260, %264
  %266 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 2
  %267 = load i32, i32* %266, align 4
  %268 = add i32 %265, %267
  store i32 %268, i32* %5, align 4
  %269 = load i32, i32* %5, align 4
  store i32 %269, i32* %5, align 4
  %270 = load i32, i32* %10, align 4
  store i32 %270, i32* %11, align 4
  %271 = load i32, i32* %9, align 4
  store i32 %271, i32* %10, align 4
  %272 = load i32, i32* %8, align 4
  %273 = shl i32 %272, 30
  %274 = load i32, i32* %8, align 4
  %275 = lshr i32 %274, 2
  %276 = or i32 %273, %275
  store i32 %276, i32* %9, align 4
  %277 = load i32, i32* %7, align 4
  store i32 %277, i32* %8, align 4
  %278 = load i32, i32* %5, align 4
  store i32 %278, i32* %7, align 4
  br label %279

279:                                              ; preds = %241
  %280 = load i32, i32* %4, align 4
  %281 = add nsw i32 %280, 1
  store i32 %281, i32* %4, align 4
  br label %238

282:                                              ; preds = %238
  store i32 60, i32* %4, align 4
  br label %283

283:                                              ; preds = %318, %282
  %284 = load i32, i32* %4, align 4
  %285 = icmp slt i32 %284, 80
  br i1 %285, label %286, label %321

286:                                              ; preds = %283
  %287 = load i32, i32* %7, align 4
  %288 = shl i32 %287, 5
  %289 = load i32, i32* %7, align 4
  %290 = lshr i32 %289, 27
  %291 = or i32 %288, %290
  %292 = load i32, i32* %8, align 4
  %293 = load i32, i32* %9, align 4
  %294 = xor i32 %292, %293
  %295 = load i32, i32* %10, align 4
  %296 = xor i32 %294, %295
  %297 = add i32 %291, %296
  %298 = load i32, i32* %11, align 4
  %299 = add i32 %297, %298
  %300 = load i32, i32* %4, align 4
  %301 = sext i32 %300 to i64
  %302 = getelementptr inbounds [80 x i32], [80 x i32]* %6, i64 0, i64 %301
  %303 = load i32, i32* %302, align 4
  %304 = add i32 %299, %303
  %305 = getelementptr inbounds [4 x i32], [4 x i32]* %3, i64 0, i64 3
  %306 = load i32, i32* %305, align 4
  %307 = add i32 %304, %306
  store i32 %307, i32* %5, align 4
  %308 = load i32, i32* %5, align 4
  store i32 %308, i32* %5, align 4
  %309 = load i32, i32* %10, align 4
  store i32 %309, i32* %11, align 4
  %310 = load i32, i32* %9, align 4
  store i32 %310, i32* %10, align 4
  %311 = load i32, i32* %8, align 4
  %312 = shl i32 %311, 30
  %313 = load i32, i32* %8, align 4
  %314 = lshr i32 %313, 2
  %315 = or i32 %312, %314
  store i32 %315, i32* %9, align 4
  %316 = load i32, i32* %7, align 4
  store i32 %316, i32* %8, align 4
  %317 = load i32, i32* %5, align 4
  store i32 %317, i32* %7, align 4
  br label %318

318:                                              ; preds = %286
  %319 = load i32, i32* %4, align 4
  %320 = add nsw i32 %319, 1
  store i32 %320, i32* %4, align 4
  br label %283

321:                                              ; preds = %283
  %322 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %323 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %322, i32 0, i32 0
  %324 = getelementptr inbounds [5 x i32], [5 x i32]* %323, i64 0, i64 0
  %325 = load i32, i32* %324, align 4
  %326 = load i32, i32* %7, align 4
  %327 = add i32 %325, %326
  %328 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %329 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %328, i32 0, i32 0
  %330 = getelementptr inbounds [5 x i32], [5 x i32]* %329, i64 0, i64 0
  store i32 %327, i32* %330, align 4
  %331 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %332 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %331, i32 0, i32 0
  %333 = getelementptr inbounds [5 x i32], [5 x i32]* %332, i64 0, i64 1
  %334 = load i32, i32* %333, align 4
  %335 = load i32, i32* %8, align 4
  %336 = add i32 %334, %335
  %337 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %338 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %337, i32 0, i32 0
  %339 = getelementptr inbounds [5 x i32], [5 x i32]* %338, i64 0, i64 1
  store i32 %336, i32* %339, align 4
  %340 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %341 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %340, i32 0, i32 0
  %342 = getelementptr inbounds [5 x i32], [5 x i32]* %341, i64 0, i64 2
  %343 = load i32, i32* %342, align 4
  %344 = load i32, i32* %9, align 4
  %345 = add i32 %343, %344
  %346 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %347 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %346, i32 0, i32 0
  %348 = getelementptr inbounds [5 x i32], [5 x i32]* %347, i64 0, i64 2
  store i32 %345, i32* %348, align 4
  %349 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %350 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %349, i32 0, i32 0
  %351 = getelementptr inbounds [5 x i32], [5 x i32]* %350, i64 0, i64 3
  %352 = load i32, i32* %351, align 4
  %353 = load i32, i32* %10, align 4
  %354 = add i32 %352, %353
  %355 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %356 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %355, i32 0, i32 0
  %357 = getelementptr inbounds [5 x i32], [5 x i32]* %356, i64 0, i64 3
  store i32 %354, i32* %357, align 4
  %358 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %359 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %358, i32 0, i32 0
  %360 = getelementptr inbounds [5 x i32], [5 x i32]* %359, i64 0, i64 4
  %361 = load i32, i32* %360, align 4
  %362 = load i32, i32* %11, align 4
  %363 = add i32 %361, %362
  %364 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %365 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %364, i32 0, i32 0
  %366 = getelementptr inbounds [5 x i32], [5 x i32]* %365, i64 0, i64 4
  store i32 %363, i32* %366, align 4
  %367 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %368 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %367, i32 0, i32 4
  store i32 0, i32* %368, align 4
  ret void
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: noinline nounwind optnone
define dso_local void @sha1_imbottitura(%struct.sha1_struct* %0) #0 {
  %2 = alloca %struct.sha1_struct*, align 8
  store %struct.sha1_struct* %0, %struct.sha1_struct** %2, align 8
  %3 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %4 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %3, i32 0, i32 4
  %5 = load i32, i32* %4, align 4
  %6 = icmp sgt i32 %5, 55
  br i1 %6, label %7, label %47

7:                                                ; preds = %1
  %8 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %9 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %8, i32 0, i32 3
  %10 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %11 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %10, i32 0, i32 4
  %12 = load i32, i32* %11, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, i32* %11, align 4
  %14 = sext i32 %12 to i64
  %15 = getelementptr inbounds [64 x i8], [64 x i8]* %9, i64 0, i64 %14
  store i8 -128, i8* %15, align 1
  br label %16

16:                                               ; preds = %21, %7
  %17 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %18 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %17, i32 0, i32 4
  %19 = load i32, i32* %18, align 4
  %20 = icmp slt i32 %19, 64
  br i1 %20, label %21, label %30

21:                                               ; preds = %16
  %22 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %23 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %22, i32 0, i32 3
  %24 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %25 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %24, i32 0, i32 4
  %26 = load i32, i32* %25, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, i32* %25, align 4
  %28 = sext i32 %26 to i64
  %29 = getelementptr inbounds [64 x i8], [64 x i8]* %23, i64 0, i64 %28
  store i8 0, i8* %29, align 1
  br label %16

30:                                               ; preds = %16
  %31 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  call void @message_block_process(%struct.sha1_struct* %31)
  br label %32

32:                                               ; preds = %37, %30
  %33 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %34 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %33, i32 0, i32 4
  %35 = load i32, i32* %34, align 4
  %36 = icmp slt i32 %35, 56
  br i1 %36, label %37, label %46

37:                                               ; preds = %32
  %38 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %39 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %38, i32 0, i32 3
  %40 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %41 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %40, i32 0, i32 4
  %42 = load i32, i32* %41, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %41, align 4
  %44 = sext i32 %42 to i64
  %45 = getelementptr inbounds [64 x i8], [64 x i8]* %39, i64 0, i64 %44
  store i8 0, i8* %45, align 1
  br label %32

46:                                               ; preds = %32
  br label %71

47:                                               ; preds = %1
  %48 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %49 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %48, i32 0, i32 3
  %50 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %51 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %50, i32 0, i32 4
  %52 = load i32, i32* %51, align 4
  %53 = add nsw i32 %52, 1
  store i32 %53, i32* %51, align 4
  %54 = sext i32 %52 to i64
  %55 = getelementptr inbounds [64 x i8], [64 x i8]* %49, i64 0, i64 %54
  store i8 -128, i8* %55, align 1
  br label %56

56:                                               ; preds = %61, %47
  %57 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %58 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %57, i32 0, i32 4
  %59 = load i32, i32* %58, align 4
  %60 = icmp slt i32 %59, 56
  br i1 %60, label %61, label %70

61:                                               ; preds = %56
  %62 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %63 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %62, i32 0, i32 3
  %64 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %65 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %64, i32 0, i32 4
  %66 = load i32, i32* %65, align 4
  %67 = add nsw i32 %66, 1
  store i32 %67, i32* %65, align 4
  %68 = sext i32 %66 to i64
  %69 = getelementptr inbounds [64 x i8], [64 x i8]* %63, i64 0, i64 %68
  store i8 0, i8* %69, align 1
  br label %56

70:                                               ; preds = %56
  br label %71

71:                                               ; preds = %70, %46
  %72 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %73 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %72, i32 0, i32 2
  %74 = load i32, i32* %73, align 4
  %75 = lshr i32 %74, 24
  %76 = and i32 %75, 255
  %77 = trunc i32 %76 to i8
  %78 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %79 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %78, i32 0, i32 3
  %80 = getelementptr inbounds [64 x i8], [64 x i8]* %79, i64 0, i64 56
  store i8 %77, i8* %80, align 4
  %81 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %82 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %81, i32 0, i32 2
  %83 = load i32, i32* %82, align 4
  %84 = lshr i32 %83, 16
  %85 = and i32 %84, 255
  %86 = trunc i32 %85 to i8
  %87 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %88 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %87, i32 0, i32 3
  %89 = getelementptr inbounds [64 x i8], [64 x i8]* %88, i64 0, i64 57
  store i8 %86, i8* %89, align 1
  %90 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %91 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %90, i32 0, i32 2
  %92 = load i32, i32* %91, align 4
  %93 = lshr i32 %92, 8
  %94 = and i32 %93, 255
  %95 = trunc i32 %94 to i8
  %96 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %97 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %96, i32 0, i32 3
  %98 = getelementptr inbounds [64 x i8], [64 x i8]* %97, i64 0, i64 58
  store i8 %95, i8* %98, align 2
  %99 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %100 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %99, i32 0, i32 2
  %101 = load i32, i32* %100, align 4
  %102 = and i32 %101, 255
  %103 = trunc i32 %102 to i8
  %104 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %105 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %104, i32 0, i32 3
  %106 = getelementptr inbounds [64 x i8], [64 x i8]* %105, i64 0, i64 59
  store i8 %103, i8* %106, align 1
  %107 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %108 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %107, i32 0, i32 1
  %109 = load i32, i32* %108, align 4
  %110 = lshr i32 %109, 24
  %111 = and i32 %110, 255
  %112 = trunc i32 %111 to i8
  %113 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %114 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %113, i32 0, i32 3
  %115 = getelementptr inbounds [64 x i8], [64 x i8]* %114, i64 0, i64 60
  store i8 %112, i8* %115, align 4
  %116 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %117 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %116, i32 0, i32 1
  %118 = load i32, i32* %117, align 4
  %119 = lshr i32 %118, 16
  %120 = and i32 %119, 255
  %121 = trunc i32 %120 to i8
  %122 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %123 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %122, i32 0, i32 3
  %124 = getelementptr inbounds [64 x i8], [64 x i8]* %123, i64 0, i64 61
  store i8 %121, i8* %124, align 1
  %125 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %126 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %125, i32 0, i32 1
  %127 = load i32, i32* %126, align 4
  %128 = lshr i32 %127, 8
  %129 = and i32 %128, 255
  %130 = trunc i32 %129 to i8
  %131 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %132 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %131, i32 0, i32 3
  %133 = getelementptr inbounds [64 x i8], [64 x i8]* %132, i64 0, i64 62
  store i8 %130, i8* %133, align 2
  %134 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %135 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %134, i32 0, i32 1
  %136 = load i32, i32* %135, align 4
  %137 = and i32 %136, 255
  %138 = trunc i32 %137 to i8
  %139 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %140 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %139, i32 0, i32 3
  %141 = getelementptr inbounds [64 x i8], [64 x i8]* %140, i64 0, i64 63
  store i8 %138, i8* %141, align 1
  %142 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  call void @message_block_process(%struct.sha1_struct* %142)
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @sha1_init(%struct.sha1_struct* %0) #0 {
  %2 = alloca %struct.sha1_struct*, align 8
  store %struct.sha1_struct* %0, %struct.sha1_struct** %2, align 8
  %3 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %4 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %3, i32 0, i32 1
  store i32 0, i32* %4, align 4
  %5 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %6 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %5, i32 0, i32 2
  store i32 0, i32* %6, align 4
  %7 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %8 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %7, i32 0, i32 4
  store i32 0, i32* %8, align 4
  %9 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %10 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %9, i32 0, i32 0
  %11 = getelementptr inbounds [5 x i32], [5 x i32]* %10, i64 0, i64 0
  store i32 1732584193, i32* %11, align 4
  %12 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %13 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %12, i32 0, i32 0
  %14 = getelementptr inbounds [5 x i32], [5 x i32]* %13, i64 0, i64 1
  store i32 -271733879, i32* %14, align 4
  %15 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %16 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %15, i32 0, i32 0
  %17 = getelementptr inbounds [5 x i32], [5 x i32]* %16, i64 0, i64 2
  store i32 -1732584194, i32* %17, align 4
  %18 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %19 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %18, i32 0, i32 0
  %20 = getelementptr inbounds [5 x i32], [5 x i32]* %19, i64 0, i64 3
  store i32 271733878, i32* %20, align 4
  %21 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %22 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %21, i32 0, i32 0
  %23 = getelementptr inbounds [5 x i32], [5 x i32]* %22, i64 0, i64 4
  store i32 -1009589776, i32* %23, align 4
  %24 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %25 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %24, i32 0, i32 5
  store i32 0, i32* %25, align 4
  %26 = load %struct.sha1_struct*, %struct.sha1_struct** %2, align 8
  %27 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %26, i32 0, i32 6
  store i32 0, i32* %27, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @sha1_result(%struct.sha1_struct* %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.sha1_struct*, align 8
  store %struct.sha1_struct* %0, %struct.sha1_struct** %3, align 8
  %4 = load %struct.sha1_struct*, %struct.sha1_struct** %3, align 8
  %5 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %4, i32 0, i32 6
  %6 = load i32, i32* %5, align 4
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  store i32 0, i32* %2, align 4
  br label %19

9:                                                ; preds = %1
  %10 = load %struct.sha1_struct*, %struct.sha1_struct** %3, align 8
  %11 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %10, i32 0, i32 5
  %12 = load i32, i32* %11, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %18, label %14

14:                                               ; preds = %9
  %15 = load %struct.sha1_struct*, %struct.sha1_struct** %3, align 8
  call void @sha1_imbottitura(%struct.sha1_struct* %15)
  %16 = load %struct.sha1_struct*, %struct.sha1_struct** %3, align 8
  %17 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %16, i32 0, i32 5
  store i32 1, i32* %17, align 4
  br label %18

18:                                               ; preds = %14, %9
  store i32 1, i32* %2, align 4
  br label %19

19:                                               ; preds = %18, %8
  %20 = load i32, i32* %2, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone
define dso_local void @sha1_input(%struct.sha1_struct* %0, i8* %1, i32 signext %2) #0 {
  %4 = alloca %struct.sha1_struct*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store %struct.sha1_struct* %0, %struct.sha1_struct** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %6, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  br label %87

10:                                               ; preds = %3
  %11 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %12 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %11, i32 0, i32 5
  %13 = load i32, i32* %12, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %20, label %15

15:                                               ; preds = %10
  %16 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %17 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %16, i32 0, i32 6
  %18 = load i32, i32* %17, align 4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %20, label %23

20:                                               ; preds = %15, %10
  %21 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %22 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %21, i32 0, i32 6
  store i32 1, i32* %22, align 4
  br label %87

23:                                               ; preds = %15
  br label %24

24:                                               ; preds = %84, %23
  %25 = load i32, i32* %6, align 4
  %26 = add i32 %25, -1
  store i32 %26, i32* %6, align 4
  %27 = icmp ne i32 %25, 0
  br i1 %27, label %28, label %34

28:                                               ; preds = %24
  %29 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %30 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %29, i32 0, i32 6
  %31 = load i32, i32* %30, align 4
  %32 = icmp ne i32 %31, 0
  %33 = xor i1 %32, true
  br label %34

34:                                               ; preds = %28, %24
  %35 = phi i1 [ false, %24 ], [ %33, %28 ]
  br i1 %35, label %36, label %87

36:                                               ; preds = %34
  %37 = load i8*, i8** %5, align 8
  %38 = load i8, i8* %37, align 1
  %39 = zext i8 %38 to i32
  %40 = and i32 %39, 255
  %41 = trunc i32 %40 to i8
  %42 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %43 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %42, i32 0, i32 3
  %44 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %45 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %44, i32 0, i32 4
  %46 = load i32, i32* %45, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, i32* %45, align 4
  %48 = sext i32 %46 to i64
  %49 = getelementptr inbounds [64 x i8], [64 x i8]* %43, i64 0, i64 %48
  store i8 %41, i8* %49, align 1
  %50 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %51 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %50, i32 0, i32 1
  %52 = load i32, i32* %51, align 4
  %53 = add i32 %52, 8
  store i32 %53, i32* %51, align 4
  %54 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %55 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %54, i32 0, i32 1
  %56 = load i32, i32* %55, align 4
  store i32 %56, i32* %55, align 4
  %57 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %58 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %57, i32 0, i32 1
  %59 = load i32, i32* %58, align 4
  %60 = icmp eq i32 %59, 0
  br i1 %60, label %61, label %77

61:                                               ; preds = %36
  %62 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %63 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %62, i32 0, i32 2
  %64 = load i32, i32* %63, align 4
  %65 = add i32 %64, 1
  store i32 %65, i32* %63, align 4
  %66 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %67 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %66, i32 0, i32 2
  %68 = load i32, i32* %67, align 4
  store i32 %68, i32* %67, align 4
  %69 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %70 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %69, i32 0, i32 2
  %71 = load i32, i32* %70, align 4
  %72 = icmp eq i32 %71, 0
  br i1 %72, label %73, label %76

73:                                               ; preds = %61
  %74 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %75 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %74, i32 0, i32 6
  store i32 1, i32* %75, align 4
  br label %76

76:                                               ; preds = %73, %61
  br label %77

77:                                               ; preds = %76, %36
  %78 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  %79 = getelementptr inbounds %struct.sha1_struct, %struct.sha1_struct* %78, i32 0, i32 4
  %80 = load i32, i32* %79, align 4
  %81 = icmp eq i32 %80, 64
  br i1 %81, label %82, label %84

82:                                               ; preds = %77
  %83 = load %struct.sha1_struct*, %struct.sha1_struct** %4, align 8
  call void @message_block_process(%struct.sha1_struct* %83)
  br label %84

84:                                               ; preds = %82, %77
  %85 = load i8*, i8** %5, align 8
  %86 = getelementptr inbounds i8, i8* %85, i32 1
  store i8* %86, i8** %5, align 8
  br label %24

87:                                               ; preds = %9, %20, %34
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local signext i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.sha1_struct, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @sha1_init(%struct.sha1_struct* %2)
  store i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i64 0, i64 0), i8** %3, align 8
  store i32 16, i32* %4, align 4
  %5 = load i8*, i8** %3, align 8
  %6 = load i32, i32* %4, align 4
  call void @sha1_input(%struct.sha1_struct* %2, i8* %5, i32 signext %6)
  ret i32 0
}

attributes #0 = { noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-features"="+a,+c,+m,+relax" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64"}
!2 = !{!"clang version 10.0.0-4ubuntu1 "}
