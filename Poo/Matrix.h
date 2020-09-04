#ifndef MATRIX_H
#define MATRIX_H


#include<iostream>
using namespace std;


class Matrix
{
	public:
	double **A;
	static int count;
	int size,n,m;
	Matrix(int =1,int =1);
	friend istream& operator >> (istream& in,Matrix a);
	friend ostream& operator << (ostream& out,const Matrix &a);
	Matrix operator + (const Matrix &b);
	Matrix operator * (const Matrix &b);
	double det();
	Matrix invert();
	~Matrix();


};


#endif













