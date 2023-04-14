add_llvm_library(LLVMRISCVCheckReturnAddr MODULE
    RISCVCheckReturnAddr.cpp

    PLUGIN_TOOL
    opt

)