#ifndef CASTTEST
#define CASTTEST

#include <iostream>
using namespace std;

/*

// 当 a　是局部变量时，下面代码能正常运行
const int a = 0;
cout << "&a = " << (&a) << endl;
int *pa  = const_cast<int*>(&a);
*pa = 1;
cout << "*(int*)(&a) = " << *(int*)(&a) << endl; //　输出 1 (用的是符号表中的地址的内容)
cout << "a = " << a << endl; //　输出 0 (因为用的是符号常量的值来替代)


// 当 a　是全局变量时，则不能正常运行
const int a = 0;	
Fun()
{
cout << "&a = " << (&a) << endl;
int *pa  = const_cast<int*>(&a);
*pa = 1;  //　出错
cout << "*(int*)(&a) = " << *(int*)(&a) << endl; 
cout << "a = " << a << endl;
}


刚查了一下，const是一种约束，告诉编译器这个变量不可以被修改，技术是用了类似宏定义的方法，比如：define x 1（读取值时采用，写入直接编译器警告即可）；
后续读取这个变量的值的时候，直接进行替换，但是如果对这个变量取地址等操作，又表现出变量的特性。总的来说，const变量在不用语境下表现不同，同时具有符号常量和变量的特点。

基本上，你用了const_cast就都是一种设计上错误。
这东西主要是给“库”“架构”代码用的，用来去掉形参的const属性的。

*/
void constcasttest()
{
    const int x = 1;

    int &use_value = const_cast<int &>(x);
    int *use_pointer1 = const_cast<int *>(&x);
    int *use_pointer2 = (int *)(&x);

    use_value = 2;
    *use_pointer1 = 3;
    *use_pointer2 = 4;
    cout << &x << " " << use_pointer1 << endl;
    cout << x << " " << *use_pointer2 << endl;
}

#endif
