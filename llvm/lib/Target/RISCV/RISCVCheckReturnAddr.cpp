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

using namespace llvm;

#define DEBUG_TYPE "cmp-ra"

//STATISTIC(NumDelJmp, "Number of useless jmp deleted");

static cl::opt<bool> EnableCheckReturnAddr(
  "enable-riscv-check-return-addr",
  cl::init(true),
  cl::desc("Check Return Address when returnig from a call"),
  cl::Hidden);

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
      bool Changed = false;
      if (EnableCheckReturnAddr) {
        MachineFunction::iterator FJ = F.begin();
        if (FJ != F.end())
          FJ++;
        if (FJ == F.end())
          return Changed;
        for (MachineFunction::iterator FI = F.begin(), FE = F.end();
             FJ != FE; ++FI, ++FJ)
          // In STL style, F.end() is the dummy BasicBlock() like '\0' in 
          //  C string. 
          // FJ is the next BasicBlock of FI; When FI range from F.begin() to 
          //  the PreviousBasicBlock of F.end() call runOnMachineBasicBlock().
          Changed |= runOnMachineBasicBlock(*FI, *FJ);
      }
      return Changed;
    }

  };
  char CheckRA::ID = 0;
} // end of anonymous namespace

bool CheckRA::
runOnMachineBasicBlock(MachineBasicBlock &MBB, MachineBasicBlock &MBBN) {
  bool Changed = false;

 /* MachineBasicBlock::iterator I = MBB.end();
  if (I != MBB.begin())
    I--;	// set I to the last instruction
  else
    return Changed;
*/
/*MachineBasicBlock::iterator I = MBB.end() - 1; /*I is the last instruction of a BB. We want to know when 
it's a JR because it means it's a return from a call */

  //if (I->getOpcode() == RISCV::JR){ //when we find a JR

  //for(auto &MBB : MF){
    //for (auto &MI : MBB){
      
        //RISCVInstrInfo *TII;
        /*DebugLoc DL;
        BuildMI(MBB, MI, DL, TII.get(RISCV::LW), DestReg)
        .addReg(RISCV::X1)
        .addImm(0)))*/
        const TargetInstrInfo *TII; //credo sia necessatio definirla per poi usarla nel Build
        for(MachineBasicBlock::iterator I = MBB.begin();I != MBB.end();++I){
        if((I.getOpcode() == RISCV::JAL) || (I.getOpcode() == RISCV::JALR)){ // if CALL detected
        outs() << "Found Call\n";

        //MachineBasicBlock::iterator J = MBB.begin()


        for(MachineBasicBlock::iterator J = MBB.begin();J != MBB.end();++J){ 
          
          if(J==(MBB.end()-1)){
          BuildMI(MBB, DL, TII.get(RISCV::BNE))
          .addReg(RISCV::X1)
          .addReg(RISCV::X5)
          .addMBB(LoopMBB);
          }
          /*BuildMI(MBB,MBB.end(), DL, TII.get(RISCV::BNE))
          .addReg(RISCV::X1)
          .addReg(RISCV::X5)
          .addMBB(LoopMBB);*/  /*versione 2 senza iteratore j dove mettiamo l'istruzione prima di MBB.end()*/
          
          /*da RISCVExpandAtomicPseudoInsts.cpp: 
          MachineBasicBlock *MBB;
          auto LoopMBB = MF->CreateMachineBasicBlock(MBB.getBasicBlock());*/

             }


    }

        }
}
    //save a copy of the return address
    
  // If the block has no terminators, it just falls into the block after it.
  MachineBasicBlock::iterator I = MBB.getLastNonDebugInstr();
  if (I == MBB.end() && (I->getOperand(0) != ))
    return false;

    
  #if (I->getOpcode() == Cpu0::JMP && I->getOperand(0).getMBB() == &MBBN) {
    // I is the instruction of "jmp #offset=0", as follows,
    //     jmp	$BB0_3
    // $BB0_3:
    //     ld	$4, 28($sp)
    ++NumDelJmp;
    MBB.erase(I);	// delete the "JMP 0" instruction
    Changed = true;	// Notify LLVM kernel Changed
  }
  return Changed;



/// createCpu0DelJmpPass - Returns a pass that DelJmp in Cpu0 MachineFunctions
FunctionPass *llvm::createCheckReturnAddr(RISCVTargetMachine &tm) {
  return new CheckRA(tm);
}

#endif
