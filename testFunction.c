//testFunction: call 2 functions --> Checked = 1

int TestFunction1(){
	int a = 5;
	int b = 3;
	int mySum = a + b;
	
	return mySum;

}

int TestFunction2(){
	int c = 2;
	int d = 4;
	int myMul = c * d;
	
	return myMul;
}

int main(){

	int Sum = TestFunction1(); //call function 1
	
	int Prod = TestFunction2(); //call function 2
	
	int Res = Sum + Prod;
	
	return 0;
}
