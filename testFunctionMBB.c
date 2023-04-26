//testFunction: call 2 functions --> Checked = 1

int TestFunction2(int a, int b){
	int myMul = a * b;
	
	return myMul;
}

int TestFunction1(int a, int b){
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
	
	if(i<3){
	int Res = TestFunction1(a, b);
	}
	}
	
	
	
	return 0;
}
