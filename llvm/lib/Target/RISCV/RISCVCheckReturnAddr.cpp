#include "MCTargetDesc/RISCVInstPrinter.h"
#include "MCTargetDesc/RISCVMCExpr.h"
#include "MCTargetDesc/RISCVTargetStreamer.h"
#include "RISCV.h"
#include "RISCVInstrInfo.h"
#include "RISCVTargetMachine.h"
#include "TargetInfo/RISCVTargetInfo.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/BinaryFormat/ELF.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
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
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/Statistic.h"
#include <iostream>
#include "llvm/Support/CommandLine.h"

using namespace llvm;

//#define DEBUG_TYPE "cmp-ra"

//STATISTIC(NumRAChecked, "Number of comparison performed");

/*static cl::opt<bool> EnableCheckReturnAddr(
  "enable-riscv-check-return-addr",
  cl::init(true),
  cl::desc("Check Return Address when returnig from a call"),
  cl::Hidden);*/

static cl::opt<int> MailBoxAddr(
  "m",
  cl::init(1),
  cl::desc("Specify MailBox Address"),
  cl::value_desc("mailbox address")
);

namespace {

    DebugLoc DL;

  struct RISCVCheckReturnAddr : public MachineFunctionPass {
    static char ID;
    RISCVCheckReturnAddr()
      : MachineFunctionPass(ID) { 
        initializeRISCVCheckReturnAddrPass(
        *PassRegistry::getPassRegistry());
      }

    StringRef getPassName() const override {
      return "RISCV Check Return Address";
    }

    //bool runOnMachineBasicBlock(MachineBasicBlock &MBB);

    bool runOnMachineFunction(MachineFunction &MF) override; //{
      //bool Checked = false;
      //std::cout << "Ci sono!\n";*

      /*for (MachineFunction::iterator FI = MF.begin(), FE = MF.end();
             FI != FE; ++FI)

          Checked |= runOnMachineBasicBlock(*FI);*/
      
      //return Checked;
    }; //struct

  } //end of anonymous namespace

char RISCVCheckReturnAddr::ID = 0;

INITIALIZE_PASS(RISCVCheckReturnAddr, "riscv-checkreturnaddr", "RISCV Check Return Address", false, false)

//define debug values
int countMF = 0;
int countCall = 0;
int countReturn = 0;

bool RISCVCheckReturnAddr::runOnMachineFunction(MachineFunction &MF){
  countMF++;
  std::cout << "Ci sono! MF n. " << countMF << "\n";

  //const int MailBoxAddr = 0x00000003; //define arbitrary address for the mailbox
  //let the user choose the MailBox value

  for(auto &MBB:MF){

    for(auto &MI:MBB){

        const TargetInstrInfo *TII = MF.getSubtarget().getInstrInfo(); //defined to use it later in the Build

        if(MI.isCall()){
        //if((MI.getOpcode() == RISCV::JAL) || (MI.getOpcode() == RISCV::JALR)){ --> does not recognize call

          countCall++;
          std::cout << "Call n. " << countCall << "\n";

          //if a CALL is detected
          outs() << "Found Call\n"; //print message

          Register FunctionReturnAddress = MI.getOperand(0).getReg(); //save call destination register (rd is the first operand in format J)

      

          //FunctionReturnAddr saved to @(0 + MailBoxAddr)

          //this SW is inserted before the call takes place
          MachineBasicBlock::iterator MBBI = BuildMI(MBB, MI, DL, TII->get(RISCV::SW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr); 

          outs() << "Inserted SW\n"; //print message
          //return true;

        }
        
        // Store the correct Return Address when returning from a call

        if(MI.isReturn()){

          countReturn++;
          std::cout << "Return n. " << countReturn << "\n"; 

          //if a RETURN is detected
          outs() << "Found Return\n"; //print message

          MachineBasicBlock::iterator MBBI = BuildMI(MBB, MI, DL, TII->get(RISCV::LW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr); 

          outs() << "Done Return\n"; //print message

        }
    }
  }

return false;
}
// } // RunOnMBB


FunctionPass *llvm::createRISCVCheckReturnAddrPass() {
  return new RISCVCheckReturnAddr();
}


