#ifndef STRINGTEST
#define STRINGTEST

#include <iostream>
#include <string>
#include <vector>
#include <string>
using namespace std;

void stringtest1()
{
    string str1("aaa");
    string str2("bbbbb");
    cout << sizeof(str1) << "*****" << sizeof(str2) << "*********" << sizeof(string) << endl;
    string str3(str1);
    string str4 = str2;

    vector<string> strs;

    strs.push_back(str1);
    strs.push_back(str2);
    strs.push_back(str3);
    strs.push_back(str4);
    cout << &strs << endl;
    cout << "str1 address:" << &str1 << "     str1 char arry address:" << str1.c_str() << endl;
    cout << "str1 address:" << &str2 << "     str1 char arry address:" << str2.c_str() << endl;
    cout << "str1 address:" << &str3 << "     str1 char arry address:" << str3.c_str() << endl;
    cout << "str1 address:" << &str4 << "     str1 char arry address:" << str4.c_str() << endl;
}

#endif