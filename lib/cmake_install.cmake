# Install script for directory: /home/letizia/llvm-project/llvm/lib

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/letizia/llvm-project/lib/IR/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/FuzzMutate/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/FileCheck/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/InterfaceStub/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/IRPrinter/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/IRReader/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/CodeGen/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/BinaryFormat/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Bitcode/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Bitstream/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/DWARFLinker/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Extensions/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Frontend/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Transforms/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Linker/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Analysis/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/LTO/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/MC/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/MCA/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/ObjCopy/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Object/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/ObjectYAML/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Option/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Remarks/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Debuginfod/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/DebugInfo/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/DWP/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/ExecutionEngine/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Target/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/AsmParser/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/LineEditor/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/ProfileData/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Passes/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/TextAPI/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/ToolDrivers/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/XRay/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/Testing/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/WindowsDriver/cmake_install.cmake")
  include("/home/letizia/llvm-project/lib/WindowsManifest/cmake_install.cmake")

endif()

