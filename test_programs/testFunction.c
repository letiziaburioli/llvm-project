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

int TestFunction3(int e){
	int f = 37;
	int myRes = (e * f) + 10;
	
	return myRes;
}

int main(){

	int Sum = TestFunction1(); //call function 1
	
	int Prod = TestFunction2(); //call function 2
	
	int Res = TestFunction3(Prod); //call function 3
	
	int Res_final = Sum + Prod + Res;
	
	return 0;
}
