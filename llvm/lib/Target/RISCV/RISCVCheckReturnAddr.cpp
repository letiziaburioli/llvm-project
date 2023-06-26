#include "RISCV.h"
#include "RISCVInstrInfo.h"
#include "RISCVTargetMachine.h"
#include "TargetInfo/RISCVTargetInfo.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
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

#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/ADT/iterator_range.h"
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineOperand.h"
#include "llvm/CodeGen/TargetInstrInfo.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/CodeGen/TargetSubtargetInfo.h"
#include "llvm/Config/llvm-config.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/DebugLoc.h"
#include "llvm/IR/Function.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Compiler.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include <cassert>

//if defined, enable debug comments
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
        Register Reg64_MailBoxAddr = MI.getOperand(1).getReg(); 
        
        if(MI.isCall()){
        
          Checked = true;

          #ifdef CRA_DEBUG
          //if a CALL is detected
          countCall++;
          std::cout << "Call n. " << countCall << "\n";
          #endif
  
          int64_t offset = 0;

          //check if MailBoxAddr exceeds the 12 bits of the Immediate
          if(MailBoxAddr >= 4096){

            //0x800 = 2048 = 2^11
            //fixed_MailBoxAddr is MailBoxAddr + 2048 to compensate unwanted ADDI sign extension
            //int64_t fixed_MailBoxAddr = ((MailBoxAddr >> 11) && 0x00000001) ? (MailBoxAddr + 0x800) : MailBoxAddr; // >> 12) & 0xFFFFF;  
            
            int32_t MailBoxAddr_20MSB = MailBoxAddr & 0xFFFFF000; //select 20 MSB of MailBoxAddr
            int32_t MailBoxAddr_20MSB_fixed = ((MailBoxAddr >> 11) & 0x00000001) ? (MailBoxAddr_20MSB + 0x800) : MailBoxAddr_20MSB;  //add 2048 when needed
            
            int32_t MailBoxAddr_12LSB = MailBoxAddr & 0x00000FFF; //select 12 LSB of MailBoxAddr
            
            //LUI + ADDI required
            BuildMI(MBB, MI, DL, TII->get(RISCV::LUI), Reg64_MailBoxAddr)
              .addImm(MailBoxAddr_20MSB_fixed); 

          
            BuildMI(MBB, MI, DL, TII->get(RISCV::ADDIW), Reg64_MailBoxAddr) 
              .addReg(Reg64_MailBoxAddr)
              .addImm(MailBoxAddr_12LSB); 

          
          }else{
            Reg64_MailBoxAddr = RISCV::X0; 
            offset = MailBoxAddr;
          }
         
          //this SD is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X1) 
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset); 


          #ifdef CRA_DEBUG
          outs() << "Inserted SD for ra\n"; //print message
          #endif
          
          //register to store function ID
          Register Reg_call_ID = MI.getOperand(1).getReg(); //can't be the same as before

          // set call id = 1. This ADDI is turned into a li by the compiler
          BuildMI(MBB, MI, DL, TII->get(RISCV::ADDI), Reg_call_ID)
              .addReg(RISCV::X0)
              .addImm(1);

          //write call id = 1 to mailbox
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), Reg_call_ID)
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset+8);

        } //end if isCall
        
        // Store the correct Return Address when returning from a call
        if(MI.isReturn()){

          //get function name to identify main function
          StringRef fnName = MF.getFunction().getName();
       
          //if MainRet == 0 and fnName == "main", don't execute the pass for the ret
          if(!MainRet && fnName == "main"){
            std::cout << "Optimization pass not executed for main ret" << "\n";
            exit;
            
          }else{

          //if a RETURN is detected
          #ifdef CRA_DEBUG
          countReturn++;
          std::cout << "Return n. " << countReturn << "\n";     
          #endif     

          //register to load upper immediate of the MailBoxAddr. Random initialization
          Register Reg64_MailBoxAddr = MI.getOperand(1).getReg(); 

          int64_t offset = 0;

          //check if MailBoxAddr exceeds the 12 bits of the Immediate
          if(MailBoxAddr >= 4096){

            int32_t MailBoxAddr_20MSB = MailBoxAddr & 0xFFFFF000; //select 20 MSB of MailBoxAddr
            int32_t MailBoxAddr_20MSB_fixed = ((MailBoxAddr >> 11) & 0x00000001) ? (MailBoxAddr_20MSB + 0x800) : MailBoxAddr_20MSB;  //add 2048 when needed
            
            int32_t MailBoxAddr_12LSB = MailBoxAddr & 0x00000FFF; //select 12 LSB of MailBoxAddr

            //LUI + ADDI required
            BuildMI(MBB, MI, DL, TII->get(RISCV::LUI), Reg64_MailBoxAddr)
              .addImm(MailBoxAddr_20MSB_fixed); 

          
            BuildMI(MBB, MI, DL, TII->get(RISCV::ADDIW), Reg64_MailBoxAddr) 
              .addReg(Reg64_MailBoxAddr)
              .addImm(MailBoxAddr_12LSB); 
          
          }else{
            Reg64_MailBoxAddr = RISCV::X0; 
            offset = MailBoxAddr;
          }
         
          //this SD restores the correct ra before ret takes place    
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X1) 
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset);

          #ifdef CRA_DEBUG
          outs() << "Inserted LW for ra\n"; //print message
          #endif
  
          //write ret id = 0 to mailbox
          BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X0)
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset+8);

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