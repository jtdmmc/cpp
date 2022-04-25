#ifndef VECTORTEST
#define VECTORTEST

#include <iostream>
#include <vector>
#include <string.h>

using namespace std;

class Person
{
public:
    char *name;
    int age;

public:
    Person()
    {
        //如果不对name指针进行初始化，那么添加vector到中默认构造的person对象的name都是野指针，当vector扩容的时候调用拷贝构造函数访问other.name将报错 SegmentFault 。
        name = new char[1];
        *name = '\0';

        cout << "Person 默认构造" << endl;
    }

    Person(const char *str)
    {
        if (!str)
        { //为空。String a()
            name = new char[1];
            *name = '\0';
        }
        else
        {
            int length = strlen(str);
            name = new char[length + 1];
            strcpy(name, str); //会拷贝源的结束符
            name[length] = '\0';
        }
        cout << "Person 字符串构造" << endl;
    }
    Person(const Person &other)
    {
        this->name = new char[strlen(other.name) + 1];
        strcpy(this->name, other.name);
        this->age = other.age;

        cout << "Person 拷贝构造" << endl;
    }

    Person &operator=(const Person &other)
    {

        if (this == &other)
            return *this; // 1 自我赋值，返回自身引用

        delete[] name; // 2 删除原有数据

        this->name = new char[strlen(other.name) + 1];
        strcpy(name, other.name);
        this->age = other.age;

        cout << "Person 赋值操作" << endl;
        return *this;
    }

    ~Person()
    {
        if (name)
        {
            cout << "析构：地址：" << &name << endl;
            delete[] name;
        }
    }
};

void vectortest1()
{

    vector<Person> persons(4);
    Person p1("aa");
    Person p2("bb");
    Person p3("cc");
    //赋值操作
    p3 = p1;
    // vector扩容的时候先调用拷贝构造函数拷贝数据到新内存，然后调用析构函数释放原内存；
    //  persons.push_back(p1);调用拷贝构造 ，新建对象。
    persons.push_back("xx");
    persons.push_back(p1);
    persons.push_back(p2);
    persons.push_back(p1);
}

#endif