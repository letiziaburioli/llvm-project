add_llvm_library( LLVMOurPass MODULE
    our_pass.cpp #source file

    PLUGIN_TOOL
    opt
)