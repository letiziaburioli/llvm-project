//#include <stdio.h>
//#include "llvm/Support/CommandLine.h"

int TestFunction(){
	/*int a = 5;
	int b = 3;
	int mySum = a + b;*/
	int mySum = 3+5;
	
	return mySum;
	
	//printf("a + b = %d\n", mySum);
	//printf("Test Function Executed!");
}

int TestFunction2(){
	int c = 2;
	
	return c+1;
}

int main(){
	//cl::ParseCommandLineOptions();
	
	TestFunction(); //call function 1
	int d = 7;
	TestFunction2(); //call function 2
	int e = 8;
	return 0;
}
