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
#include <iostream>
#include "llvm/Support/CommandLine.h"


#define CRA_DEBUG //if defined, enable debug comments

using namespace llvm;

//add CommandLine option -mailbox-offset to define MailBox Address
static cl::opt<int> MailBoxAddr(
  "mailbox-offset",
  cl::init(12), 
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


  for(auto &MBB : MF){

    for(auto &MI : MBB){

        const TargetInstrInfo *TII = MF.getSubtarget().getInstrInfo(); //defined to use it later in the BuildMI

	      //make the pass compatible with both RV32 and RV64
	      const auto &STI = MF.getSubtarget<RISCVSubtarget>();
	      bool IsRV64 = STI.hasFeature(RISCV::Feature64Bit);

        //use a temporary register to load upper immediate of the MailBoxAddr
        Register Reg64_MailBoxAddr = RISCV::X6;
        
        if(MI.isCall()) { //if a CALL is detected
        
          Checked = true; //at least a call detected


          #ifdef CRA_DEBUG
          countCall++;
          std::cout << "Call n. " << countCall << "\n";
          #endif
  
          int64_t offset = 0;

          //check if MailBoxAddr exceeds the 12 bits of the Immediate

          if(MailBoxAddr >= 4096){

            int32_t MailBoxAddr_20MSB = MailBoxAddr & 0xFFFFF000; //select 20 MSB of MailBoxAddr

            int32_t MailBoxAddr_20MSB_fixed = ((MailBoxAddr >> 11) & 0x00000001) ? (MailBoxAddr_20MSB + 0x800) : MailBoxAddr_20MSB;  //add 2048 when needed
            
            int32_t MailBoxAddr_12LSB = MailBoxAddr & 0x00000FFF; //select 12 LSB of MailBoxAddr

            //LUI required
            BuildMI(MBB, MI, DL, TII->get(RISCV::LUI), Reg64_MailBoxAddr)
              .addImm(MailBoxAddr_20MSB_fixed); 


	          offset = MailBoxAddr_12LSB;

          
          }else{
            Reg64_MailBoxAddr = RISCV::X0; 
            offset = MailBoxAddr;
          }
         
          //this SD is inserted before the call takes place
          BuildMI(MBB, MI, DL, TII->get(IsRV64? RISCV::SD : RISCV::SW), RISCV::X1) 
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset); 


          #ifdef CRA_DEBUG
          outs() << "Inserted SW/SD for ra\n";
          #endif
          
          //temporary register to store function ID
          Register Reg_call_ID =  RISCV::X7; 

          //set call id = 1. This ADDI is turned into a li by the compiler
          BuildMI(MBB, MI, DL, TII->get(IsRV64? RISCV::ADDIW : RISCV::ADDI), Reg_call_ID)
              .addReg(RISCV::X0)
              .addImm(1);

          //write call id = 1 to mailbox
          if (IsRV64 == true){ //RISCV64
            BuildMI(MBB, MI, DL, TII->get(RISCV::SD), Reg_call_ID)
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset + 8);
          } else { //RISCV32
            BuildMI(MBB, MI, DL, TII->get(RISCV::SW), Reg_call_ID)
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset + 4);
          }

        } //end if isCall
        
        //store the correct Return Address when returning from a call

        if(MI.isReturn()){ //if a RETURN is detected

          //get function name to identify main function
          StringRef fnName = MF.getFunction().getName();
       
          //if MainRet == 0 and fnName == "main", don't execute the pass for the ret
          if(!MainRet && fnName == "main"){
            std::cout << "Optimization pass not executed for main ret" << "\n";
            exit;
            
          }else{

          #ifdef CRA_DEBUG
          countReturn++;
          std::cout << "Return n. " << countReturn << "\n";     
          #endif     

          //temporary register to load upper immediate of the MailBoxAddr
          Register Reg64_MailBoxAddr = RISCV::X6; 

          int64_t offset = 0;

          //check if MailBoxAddr exceeds the 12 bits of the Immediate

          if(MailBoxAddr >= 4096){ //LUI required

            int32_t MailBoxAddr_20MSB = MailBoxAddr & 0xFFFFF000; //select 20 MSB of MailBoxAddr

            int32_t MailBoxAddr_20MSB_fixed = ((MailBoxAddr >> 11) & 0x00000001) ? (MailBoxAddr_20MSB + 0x800) : MailBoxAddr_20MSB;  //add 2048 when needed
            
            int32_t MailBoxAddr_12LSB = MailBoxAddr & 0x00000FFF; //select 12 LSB of MailBoxAddr

            
            //LUI
            BuildMI(MBB, MI, DL, TII->get(RISCV::LUI), Reg64_MailBoxAddr)
              .addImm(MailBoxAddr_20MSB_fixed); 

            
            offset = MailBoxAddr_12LSB;
          
          }else{
            Reg64_MailBoxAddr = RISCV::X0; 
            offset = MailBoxAddr;
          }
         
          //this SD restores the correct ra before ret takes place    
          BuildMI(MBB, MI, DL, TII->get(IsRV64? RISCV::SD : RISCV::SW), RISCV::X1) 
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset);

          #ifdef CRA_DEBUG
          outs() << "Inserted SW/SD for ra\n"; //print message
          #endif
  
          //write ret id = 0 to mailbox
          if(IsRV64 == true){ //RISCV64
            BuildMI(MBB, MI, DL, TII->get(RISCV::SD), RISCV::X0)
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset+8);
          } else { //RISCV32
            BuildMI(MBB, MI, DL, TII->get(RISCV::SW), RISCV::X0)
              .addReg(Reg64_MailBoxAddr)
              .addImm(offset+4);
          }

          }//end "else" of mainRet 
        }//end isReturn
    }//end second loop on &MI
}//end first loop on &MBB


return Checked;
}//end CheckReturnAddr


FunctionPass *llvm::createRISCVCheckReturnAddrPass() {
  return new RISCVCheckReturnAddr();
}
