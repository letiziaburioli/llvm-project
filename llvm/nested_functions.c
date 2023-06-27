//testFunction: call 2 functions --> Checked = 1

int TestFunction3(int a, int b){ //elevate a^b and subtract 37

	int myPow = a^b;
	int mySub = myPow - 37;
	
	return mySub;
}

int TestFunction2(int a, int b){ //multiply the inputs

	int op1 = TestFunction3(a, b);
	int myMul = a * op1;
	
	return myMul;
}

int TestFunction1(int a, int b){ //sum the product of the inputs to the second input

	int prod = TestFunction2(a, b);
	int mySum = prod + b;
	
	return mySum;

}


int main(){
	int a=0;
	int b=0;
	
	for(int i=0; i<4; i++){
	a++;
	b++;
	
	int Res = TestFunction1(a, b);
	}
		
	return 0;
}
