#include "RISCV.h"
#include "RISCVInstrInfo.h"
#include "RISCVTargetMachine.h"
#include "TargetInfo/RISCVTargetInfo.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
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

//define a macro to enable debug comments
#define CRA_DEBUG

using namespace llvm;

//add CommandLine option -m to define MailBox Address
static cl::opt<int> MailBoxAddr(
  "mailbox-offset",
  cl::init(0x0008BEAF),
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

#ifdef CRA_DEBUG
//define values to check the flow of execution
int countMF = 0;
int countCall = 0;
int countReturn = 0;
#endif 

bool RISCVCheckReturnAddr::runOnMachineFunction(MachineFunction &MF){
  #ifdef CRA_DEBUG
  countMF++;
  std::cout << "MF n. " << countMF << "\n";
  #endif

  bool Checked = false; //default value if no function is called

  for(auto &MBB:MF){

    for(auto &MI:MBB){

        const TargetInstrInfo *TII = MF.getSubtarget().getInstrInfo(); //defined to use it later in the BuildMI

        if(MI.isCall()){
        //if((MI.getOpcode() == RISCV::JAL) || (MI.getOpcode() == RISCV::JALR)){ --> this does not recognize call

          #ifdef CRA_DEBUG
          //if a CALL is detected
          Checked = true;
          countCall++;
          std::cout << "Call n. " << countCall << "\n";
          #endif

          //this SW is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII->get(RISCV::SW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr); 

          #ifdef CRA_DEBUG
          outs() << "Inserted SW for ra\n"; //print message
          #endif

        }
        
        // Store the correct Return Address when returning from a call
        // Decide if this should be done also for the main ret
        if(MI.isReturn()){

          //if a RETURN is detected
          #ifdef CRA_DEBUG
          countReturn++;
          std::cout << "Return n. " << countReturn << "\n";     
          #endif     

          //this LW restores the correct ra before ret takes place    
          BuildMI(MBB, MI, DL, TII->get(RISCV::LW), RISCV::X1) 
              .addReg(RISCV::X0)
              .addImm(MailBoxAddr);

          #ifdef CRA_DEBUG
          outs() << "Inserted LW for ra\n"; //print message
          #endif
        }
    }
  }

#ifdef CRA_DEBUG
std::cout << "Checked: " << Checked << "\n";
#endif

return Checked;
}

FunctionPass *llvm::createRISCVCheckReturnAddrPass() {
  return new RISCVCheckReturnAddr();
}