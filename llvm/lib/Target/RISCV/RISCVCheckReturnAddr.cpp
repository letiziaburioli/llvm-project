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

//add CommandLine option -m to define MailBox Address
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

    bool runOnMachineFunction(MachineFunction &MF) override; 

    }; //end of struct

  } //end of anonymous namespace

char RISCVCheckReturnAddr::ID = 0;

INITIALIZE_PASS(RISCVCheckReturnAddr, "riscv-checkreturnaddr", "RISCV Check Return Address", false, false)

//define values to check the flow of execution
int countMF = 0;
int countCall = 0;
int countReturn = 0;

bool RISCVCheckReturnAddr::runOnMachineFunction(MachineFunction &MF){
  countMF++;
  std::cout << "MF n. " << countMF << "\n";

  bool Checked = false;

  for(auto &MBB:MF){

    for(auto &MI:MBB){

        const TargetInstrInfo *TII = MF.getSubtarget().getInstrInfo(); //defined to use it later in the BuildMI

        if(MI.isCall()){
        //if((MI.getOpcode() == RISCV::JAL) || (MI.getOpcode() == RISCV::JALR)){ --> this does not recognize call

          //if a CALL is detected
          Checked = true;
          countCall++;
          std::cout << "Call n. " << countCall << "\n";

          //this SW is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII->get(RISCV::SW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr); 

          outs() << "Inserted SW for ra\n"; //print message

        }
        
        // Store the correct Return Address when returning from a call
        if(MI.isReturn()){

          //if a RETURN is detected
          countReturn++;
          std::cout << "Return n. " << countReturn << "\n";          

          //this LW restores the correct ra before ret takes place    
          BuildMI(MBB, MI, DL, TII->get(RISCV::LW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr);

          outs() << "Inserted LW for ra\n"; //print message

        }
    }
  }
std::cout << "Checked: " << Checked << "\n";
return Checked;
}

FunctionPass *llvm::createRISCVCheckReturnAddrPass() {
  return new RISCVCheckReturnAddr();
}


