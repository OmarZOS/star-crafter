#ifndef HEADER_H
#define HEADER_H


#include<iostream>
#include<string.h>
using namespace std;


class Box{
public:
double length;
double width;
double height;
Box(double = 1.0 ,double=1.0 ,double=1.0 );
};


class CandyBox:public Box{
public:
	string contents;
	CandyBox(double =4,double= 4,double= 4,string str = "" );
	~CandyBox(){
	}	
		
	

};






#endif
