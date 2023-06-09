//===- MaskableOpInterfaces.td - Masking Interfaces Decls  -*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This is the definition file for the MaskableOpInterface.
//
//===----------------------------------------------------------------------===//

#ifndef MLIR_DIALECT_VECTOR_INTERFACES_MASKABLEOPINTERFACE_TD
#define MLIR_DIALECT_VECTOR_INTERFACES_MASKABLEOPINTERFACE_TD

include "mlir/IR/OpBase.td"

def MaskableOpInterface : OpInterface<"MaskableOpInterface"> {
  let description = [{
    The 'MaskableOpInterface' defines an operation that can be masked using a
    MaskingOpInterface (e.g., `vector.mask`) and provides information about its
    masking constraints and semantics.
  }];
  let cppNamespace = "::mlir::vector";
  let methods = [
    InterfaceMethod<
      /*desc=*/"Returns true if the operation is masked by a "
               "MaskingOpInterface.",
      /*retTy=*/"bool",
      /*methodName=*/"isMasked",
      /*args=*/(ins),
      /*methodBody=*/"",
      /*defaultImplementation=*/[{
        return mlir::isa<mlir::vector::MaskingOpInterface>($_op->getParentOp());
    }]>,
    InterfaceMethod<
      /*desc=*/"Returns the MaskingOpInterface masking this operation.",
      /*retTy=*/"mlir::vector::MaskingOpInterface",
      /*methodName=*/"getMaskingOp",
      /*args=*/(ins),
      /*methodBody=*/"",
      /*defaultImplementation=*/[{
        return mlir::cast<mlir::vector::MaskingOpInterface>(
          $_op->getParentOp());
    }]>,
    InterfaceMethod<
      /*desc=*/"Returns true if the operation can have a passthru argument when"
               " masked.",
      /*retTy=*/"bool",
      /*methodName=*/"supportsPassthru",
      /*args=*/(ins),
      /*methodBody=*/"",
      /*defaultImplementation=*/[{
        return false;
    }]>,
    InterfaceMethod<
      /*desc=*/"Returns the mask type expected by this operation. It requires "
               "the operation to be vectorized.",
      /*retTy=*/"mlir::VectorType",
      /*methodName=*/"getExpectedMaskType",
      /*args=*/(ins),
      /*methodBody=*/"",
      /*defaultImplementation=*/[{
      // Default implementation is only aimed for operations that implement the
      // `getVectorType()` method.
        return $_op.getVectorType().cloneWith(/*shape=*/std::nullopt,
          IntegerType::get($_op.getContext(), /*width=*/1));
    }]>,
  ];
}

#endif // MLIR_DIALECT_VECTOR_INTERFACES_MASKABLEOPINTERFACE_TD
