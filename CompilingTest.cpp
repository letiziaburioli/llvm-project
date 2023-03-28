int main(){

    int a = 3;
    int b = 5;
    int diff = b-a;
    int somma = diff+a;
    int res= somma+b;

    return res;

    //compile with clang -O0 -target riscv64-unknown-linux-elf -c CompilingTest.cpp -S -o -
}
