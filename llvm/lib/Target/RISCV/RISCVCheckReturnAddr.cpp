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
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Support/Path.h"
#include "llvm/Target/TargetMachine.h"
#include <unordered_set>


using namespace llvm;

#define DEBUG_TYPE "cmp-ra"

//STATISTIC(NumRAChecked, "Number of comparison performed");

/*static cl::opt<bool> EnableCheckReturnAddr(
  "enable-riscv-check-return-addr",
  cl::init(true),
  cl::desc("Check Return Address when returnig from a call"),
  cl::Hidden);*/

namespace {
  struct CheckRA : public MachineFunctionPass {
    static char ID;
    CheckRA(TargetMachine &tm)
      : MachineFunctionPass(ID) { }

    StringRef getPassName() const override {
      return "RISCV Check Return Address when returnig from a call";
    }

    bool runOnMachineBasicBlock(MachineBasicBlock &MBB, MachineBasicBlock &MBBN);
    bool runOnMachineFunction(MachineFunction &F) override {
      bool Checked = false;

      if (EnableCheckReturnAddr) {
        MachineFunction::iterator FJ = F.begin();
        if (FJ != F.end())
          FJ++;

        if (FJ == F.end())
          return Checked;

        for (MachineFunction::iterator FI = F.begin(), FE = F.end();
             FJ != FE; ++FI, ++FJ)
          // In STL style, F.end() is the dummy BasicBlock() like '\0' in 
          //  C string. 
          // FJ is the next BasicBlock of FI; When FI range from F.begin() to 
          //  the PreviousBasicBlock of F.end() call runOnMachineBasicBlock().

          Checked |= runOnMachineBasicBlock(*FI, *FJ);
      }
      return Checked;
    }

  };
  char CheckRA::ID = 0;
} // end of anonymous namespace

bool CheckRA::
runOnMachineBasicBlock(MachineBasicBlock &MBB, MachineBasicBlock &MBBN) {
  bool Checked = false;

  const TargetInstrInfo *TII; //defined to use it later in the Build
  //const MailBoxAddr = 0x00000001; //define arbitrary address for the mailbox
  Register DestReg; 

  //save a copy of a call return address
  //for(MachineBasicBlock::iterator I = MBB.begin();I != MBB.end();++I){
    for (auto &MBB:MF){
      for (auto &MI:MBB){
        if((I.getOpcode() == RISCV::JAL) || (I.getOpcode() == RISCV::JALR)){

          //if a CALL is detected
          outs() << "Found Call\n"; //print message
          Register FunctionReturnAddress = I.getOperand(0).getReg(); //save call destination register (rd is the first operand in format J)

          //SW FunctionReturnAddress, 0(DestReg) --> FunctionReturnAddress = @(DestReg + 0)
          //this SW is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII.get(RISCV::SW), FunctionReturnAddress) 
              .addReg(DestReg)
              .addImm(0);


        }
  }
}
        /*if((I.getOpcode() == RISCV::JAL) || (I.getOpcode() == RISCV::JALR)){ //if CALL detected (isCall()?)
          outs() << "Found Call\n"; //print message
          Register FunctionReturnAddress = I.getOperand(0).getReg(); //save call destination register (rd is the first operand in format J)
          Register DestReg; //define the "shadow stack" register to hold a copy of ra

          //addi DestReg, ra, 0
          BuildMI(MBB, MBBN, DL, TII.get(RISCV::ADDI), DestReg) //should we use (RISCV::X5)?
            .addReg(FunctionReturnAddress)
            .addImm(0);

        //add a function that creates a MBB for error handling
        MachineBasicBlock *createMBB(MachineFunction &MF, const TargetInstrInfo *TII){

        MachineBasicBlock ErrorMBB = MF.CreateMachineBasicBlock(); //MBB.getBasicBlock()
        DebugLoc DL;

        //MF.insert(ErrorMBB);
        //report_fatal_error("Intruder! Return Address has been modified.")

        BuildMI(ErrorMBB, DL, TII.get(RISCV::???)); //is there a RISCV instruction that generates an error message?
        MF.push_back()

        return ErrorMBB;
        }*/
       

        /*compare return address with shadow stack copy before returning from a function
        for(MachineBasicBlock::iterator J = MBB.begin();J != MBB.end(); ++J){ 
          
          if(J==(MBB.end()-1)){ // identify a ret before it's too late
          BuildMI(MBB, DL, TII.get(RISCV::BNE))
          .addReg(RISCV::X1)
          .addReg(DestReg)
          .addMBB(ErrorMBB); // llvm_unreachable
          }
          
          
          //from RISCVExpandAtomicPseudoInsts.cpp: 
          MachineBasicBlock *MBB;
          auto LoopMBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());
          
             }*/


    /*}

        }
}*/


FunctionPass *llvm::createCheckReturnAddr(RISCVTargetMachine &tm) {
  return new CheckRA(tm);
}

//endif#
