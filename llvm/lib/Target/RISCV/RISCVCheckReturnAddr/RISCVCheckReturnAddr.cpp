#include "MCTargetDesc/RISCVInstPrinter.h"
#include "MCTargetDesc/RISCVMCExpr.h"
#include "MCTargetDesc/RISCVTargetStreamer.h"
#include "RISCV.h"
#include "RISCVTargetMachine.h"
#include "TargetInfo/RISCVTargetInfo.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/BinaryFormat/ELF.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstBuilder.h"
#include "llvm/MC/MCObjectFileInfo.h"
#include "llvm/MC/MCSectionELF.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Instrumentation/HWAddressSanitizer.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/Statistic.h"

using namespace llvm;

//#define DEBUG_TYPE "cmp-ra"

//STATISTIC(NumRAChecked, "Number of comparison performed");

/*static cl::opt<bool> EnableCheckReturnAddr(
  "enable-riscv-check-return-addr",
  cl::init(true),
  cl::desc("Check Return Address when returnig from a call"),
  cl::Hidden);*/

namespace {

    DebugLoc DL;

  struct CheckRA : public MachineFunctionPass {
    static char ID;
    CheckRA()
      : MachineFunctionPass(ID) { 
        initializeRISCVCheckReturnAddr(
        *PassRegistry::getPassRegistry());
      }

    StringRef getPassName() const override {
      return "RISCV Check Return Address";
    }

    bool runOnMachineBasicBlock(MachineBasicBlock &MBB);
    
    bool runOnMachineFunction(MachineFunction &MF) override {
      bool Checked = false;

      for (MachineFunction::iterator FI = MF.begin(), FE = MF.end();
             FI != FE; ++FI)
        
          Checked |= runOnMachineBasicBlock(*FI);
      
      return Checked;
    }

  };

  char CheckRA::ID = 0;
  static llvm::RegisterPass<CheckRA> X("CheckReturnAddr", 
                                                  "RISCV Check Return Address",
                                                  false,
                                                  false);
} // end of anonymous namespace

bool CheckRA::runOnMachineBasicBlock(MachineBasicBlock &MBB) {
  bool Checked = false;

  const TargetInstrInfo *TII; //defined to use it later in the Build
  const int MailBoxAddr = 0x00000001; //define arbitrary address for the mailbox
  //Register DestReg; 

  //MachineFunction &MF;

  //save a copy of a call return address
  //for(MachineFunction::iterator I = MF.begin(); I != MF.end(); ++I){
  //for (auto &MBB:*MF){
    for (auto &MI:MBB){
      //if((MI.getOpcode() == RISCV::JAL) || (MI.getOpcode() == RISCV::JALR)){

        // Save Return Address before a function is called

        if(MI.isCall()){

          Checked = true;

          //if a CALL is detected
          outs() << "Found Call\n"; //print message
          Register FunctionReturnAddress = MI.getOperand(0).getReg(); //save call destination register (rd is the first operand in format J)

          //SW FunctionReturnAddress, 0(DestReg) --> FunctionReturnAddress saved to @(DestReg + 0) --> if DestReg is used

          //FunctionReturnAddr saved to @(0 + MailBoxAddr)

          //this SW is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII->get(RISCV::SW), FunctionReturnAddress) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr); 
        }
        
        // Store the correct Return Address when returning from a call

        if(MI.isReturn()){

          Checked = true;

          //if a RETURN is detected
          outs() << "Found Return\n"; //print message

          BuildMI(MBB, MI, DL, TII->get(RISCV::LW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr); 

        }

    }
  //}

return Checked;
}


FunctionPass *llvm::createRISCVCheckReturnAddr() {
  return new CheckRA();
}


