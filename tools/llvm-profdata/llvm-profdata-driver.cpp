//===-- driver-template.cpp -----------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

int llvm_profdata_main(int argc, char **argv);

int main(int argc, char **argv) { return llvm_profdata_main(argc, argv); }
