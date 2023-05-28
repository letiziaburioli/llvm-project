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
#include "llvm/CodeGen/Register.h"
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

//add CommandLine option -mailbox-offset to define MailBox Address
static cl::opt<int> MailBoxAddr(
  "mailbox-offset",
  cl::init(12), //(0x0008BEAF),
  cl::desc("Specify MailBox Address"),
  cl::value_desc("mailbox address")
);

/*add CommandLine option -main-ret to decide if the pass should 
be applied also to the ret of the main function */
static cl::opt<int> MainRet(
  "main-ret",
  cl::init(1), 
  cl::desc("Apply Pass to ret of main function"),
  cl::value_desc("protect main ret")
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
int countCall = 0;
int countMF = 0;
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

        //register to load upper immediate of the MailBoxAddr. Random initialization
        Register UI_MailBoxAddr = MI.getOperand(0).getReg(); //RISCV::X0; 
        
        if(MI.isCall()){
        
          Checked = true;

          #ifdef CRA_DEBUG
          //if a CALL is detected
          countCall++;
          std::cout << "Call n. " << countCall << "\n";
          #endif


          //check if MailBoxAddr exceeds the 12 bits of the Immediate
          if(MailBoxAddr >= 4096){
            
            //LUI required
            //int64_t Hi20 = ((MailBoxAddr + 0x800) >> 12) & 0xFFFFF;
            //BuildMI(MBB, MI, DL, TII->get(RISCV::LUI, Hi20));
            BuildMI(MBB, MI, DL, TII->get(RISCV::LUI), RISCV::X5)
              .addImm(MailBoxAddr); 
          
          }else{
            UI_MailBoxAddr = RISCV::X0; 
          }
         
          //this SD is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X1) 
              .addReg(RISCV::X5)
              .addImm(MailBoxAddr); 


          #ifdef CRA_DEBUG
          outs() << "Inserted SD for ra\n"; //print message
          #endif
          
          //register to store function ID
          Register Reg_call_ID = MI.getOperand(1).getReg(); 

          // set call id = 1. This ADDI is turned into a li by the compiler
          BuildMI(MBB, MI, DL, TII->get(RISCV::ADDI), Reg_call_ID)
              .addReg(RISCV::X0)
              .addImm(1);

          //write call id = 1 to mailbox
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), Reg_call_ID)
              .addReg(RISCV::X5)
              .addImm(MailBoxAddr+8);

        } //end if isCall
        
        // Store the correct Return Address when returning from a call
        // Decide if this should be done also for the main ret
        if(MI.isReturn()){

          StringRef fnName = MF.getFunction().getName();
       
          if(!MainRet && fnName == "main"){
            std::cout << "Optimization pass not executed for main ret " << "\n";
            exit;
            
          }else{

          //if a RETURN is detected
          #ifdef CRA_DEBUG
          countReturn++;
          std::cout << "Return n. " << countReturn << "\n";     
          #endif     

          //register to load upper immediate of the MailBoxAddr. Random initialization
          Register UI_MailBoxAddr = MI.getOperand(1).getReg(); 

          //check if MailBoxAddr exceeds the 12 bits of the Immediate
          if(MailBoxAddr >= 4096){

            //LUI required. RISCV::X5: temporary register 0
            BuildMI(MBB, MI, DL, TII->get(RISCV::LUI), RISCV::X5) 
              .addImm(MailBoxAddr); 
          
          }else{
            UI_MailBoxAddr = RISCV::X0; 
          }
         
          //this SD restores the correct ra before ret takes place    
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X1) 
              .addReg(RISCV::X5)
              .addImm(MailBoxAddr);

          #ifdef CRA_DEBUG
          outs() << "Inserted LW for ra\n"; //print message
          #endif
  
          //write ret id = 0 to mailbox
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X0)
              .addReg(UI_MailBoxAddr)
              .addImm(MailBoxAddr+8);

          } //end else for main ret
        }//end isReturn
    }//end second loop
}//end first loop

#ifdef CRA_DEBUG
std::cout << "Checked: " << Checked << "\n";
#endif

return Checked;
}//end CheckReturnAddr


FunctionPass *llvm::createRISCVCheckReturnAddrPass() {
  return new RISCVCheckReturnAddr();
}