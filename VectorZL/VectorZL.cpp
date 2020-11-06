#include"VectorZL.h"


template<class T> VectorZL<T>::VectorZL(T a, T b,T c){ x=a,y=b,z=c;}

template<class T>VectorZL<T> VectorZL<T>::operator +  (const VectorZL& Vicky)const{
	return VectorZL<T>(x+Vicky.x,y+Vicky.y,z+Vicky.z);
}

template<class T> VectorZL<T> VectorZL<T>::operator - (const VectorZL& Vicky)const{
	return VectorZL<T>(x-Vicky.x,y-Vicky.y,z-Vicky.z);
}

//Produit vectoriel
template<class T> VectorZL<T> VectorZL<T>::operator %  (const VectorZL& Vicky)const{
	return VectorZL<T>(y*Vicky.z-z*Vicky.y,z*Vicky.x-x*Vicky.z,x*Vicky.y-y*Vicky.x);
}

template<class T> T VectorZL<T>::operator *  (const VectorZL& Vicky)const{
	return x*Vicky.x+y*Vicky.y+z*Vicky.z;
}

template<class T>
ostream& operator << (ostream& s,const VectorZL<T>& v){
	s<<"("<< v.x<<","<<v.y<<","<<v.z<<")";
	return s;
}
template<class T>
istream& operator >> (istream& s,VectorZL<T> v){
	s>>v.x;	s>>v.y;	s>>v.z;
	return s;
}
template<class T>
T VectorZL<T>::Rayon()const{
	return sqrt(x*x+y*y+z*z);
}


template<class T>
VectorZL<T> VectorZL<T>::unitVector(){
	T r=Rayon();
	return VectorZL<T>(x/r,y/r,z/r);
}

typedef VectorZL<float> Victor;

void Test(){
	Victor a(2,2,2);	
	cout<< Victor(0,1,0)%Victor(1,0,0)<<endl;
	cout<< Victor(0,0,1)%Victor(1,0,0)<<endl;
	cout<<a%Victor(1,0,0)<<endl;
}


















