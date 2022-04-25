#ifndef POINTERTEST
#define POINTERTEST

#include <iostream>
using namespace std;

int f1(int);
void pointertest1()
{

    //原则：符号开始，从右向左，由近及远，括号优先
    int a;
    int *pi = &a;
    int **ppi = &pi;
    int ai[10];
    int *api[10]; // a是一个数组，该数组的元素是指针，每个指针都指向一个int型

    int(*pai)[10]; // a是一个指针，该指针指向一个数组，数组元素是int

    int (*pf)(int);      //函数指针，指向有一个参数并且返回类型均为int的函数
    int (*apf[10])(int); // 数组，元素为函数指针，指向有一个参数并且返回类型均为int的函数

    // 使用typedef定义一个函数指针类型；
    typedef int (*tpf)(int);
    tpf pf1 = f1;
    // 使用typedef定义一个函数类型；
    typedef int(tf)(int);
    tf *pf2 = f1;
    // 使用using定义函数指针类型  c++11支持，推荐用法
    using utpf = int (*)(int);
    utpf pf3 = f1;
    // 使用using定义函数类型
    using utf = int(int);
    utf *pf4 = f1;

    pf1(1);
    pf2(2);
    pf3(3);
    pf4(4);
}

int f1(int n)
{
    return ++n;
}
#endif