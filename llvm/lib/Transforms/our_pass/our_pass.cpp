//hello world compiler pass

#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {
    struct OurPass : FunctionPass {
        static char ID;
        OurPass() : FunctionPass(ID) {}

        bool runOnFunction(Function &F) override {
            errs() << "OurPass: ";
            errs().write_escaped(F.getName()) << '\n';

            return false;
        }
    }; //End of OurPass
} //End of namespace

char OurPass::ID = 0;

static RegisterPass<OurPass> X("OurPass", "A simple Hello World Pass", false, false);

/*static llvm::RegisterStandardPasses Y(
    llvm::PassManagerBuilder::EP_EarlyAsPossible,
    [](const llvm::PassManagerBuilder &Builder,
    llvm::legacy::PassManagerBase &PM) {
            PM.add(new OurPass()); });*/


