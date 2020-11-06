#ifndef VECTORZL_H
#define VECTORZL_H

#include<iostream>
#include<math.h>

using namespace std;

void Test();

template<class T> class VectorZL{
	public:
	T x,y,z;
 	VectorZL<T>(T a,T b,T c);
	VectorZL<T> operator +  (const VectorZL<T>& Vicky)const;
 	T operator *  (const VectorZL<T>& Vicky)const;
 	VectorZL<T> operator -  (const VectorZL<T>& Vicky)const;
 	//Produit vectoriel
 	VectorZL<T> operator %  (const VectorZL<T>& Vicky)const;
	T Rayon()const;
	VectorZL<T> unitVector();


	//streams	
 	template<class U>
	friend ostream& operator << (ostream& s,const VectorZL<U>& v);
	template<class U>
	friend istream& operator >> (istream& s,VectorZL<U> v);
};






#endif
