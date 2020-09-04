#ifndef HEADER_H
#define HEADER_H

#include<iostream>
#include<thread>
#include<chrono>
using namespace std;

class Cell{  //holds members waiting to be multiplied and added to the actual value
public:
float val;
Cell *svt;
Cell(float v)
{
	val=v;
	svt=NULL;
}
};

class File{
public:
Cell *head;
Cell *end;
	File(){
		head=NULL;	end=NULL;
	}
	void enfiler(float v)
	{
		if(head==NULL)
		{
			head= new Cell(v);
			//		cout<<endl<<v<<endl;
			end=head;
		}
		else{
			end->svt=new Cell(v);
			end=end->svt;
			}
	}
	float defiler()
	{
		if(head==NULL)
			{
				cout<<"erreur en defilement.."<<endl;
				return 0;
			}
		float x=head->val;
		head=head->svt;
		return x;
	}
	bool empty(){
	return head==NULL;
	}
};


class Unit{

public:

float x;//the actual value in matrix
File fl1,fl2; //fl1 for vertical values, fl2 for horizontal values
Unit(){ x=0;}	//Constructor initiates null values
void operator = (float v)
{
	x=v;
}


};



class OMatrix{ // Okay, the code seems a bit heavy but it could have gotten a better chance using threads
public:
int n,m;
Unit **M;
OMatrix(int=1,int=1);
friend istream& operator >> (istream& in,OMatrix a);
friend ostream& operator << (ostream& out,const OMatrix &a);
void vertic(const OMatrix &b,OMatrix fresh);
void horiz(OMatrix fresh);
OMatrix operator *(const OMatrix &b)
{
	OMatrix fresh(n,b.m);
	if(b.n!=m)
		{
			cout<<"Multiplication Impossible!!"<<endl;
			return fresh;
		}
	

	thread th1(&OMatrix::vertic,this,b,fresh);
	thread th2(&OMatrix::horiz,this,fresh);	
	th2.join();
	th1.join();


	// here think I could have a chance to stand in front of O(n^3) matrix multiplication Algorithms..
	//Edit :: it calculates in 548827ns while the simple algorithm does it in 4227ns.. not a chance..
	return fresh;
}

OMatrix operator / (const OMatrix &b)
{
	OMatrix fresh(n,b.m);
if(b.n!=m)
		{
			cout<<"Multiplication Impossible!!"<<endl;
			return fresh;
		}
		float s;
	for(int i=0;i<n;i++)
		for(int j=0;j<b.m;j++)
	{
		s=0;
		for(int k=0;k<m;k++)
			s+=M[i][k].x*b.M[k][j].x;
		fresh.M[i][j]=s;
	}

	return fresh;
}
void Cleaner()
{
	for(int i=0;i<2;i++)
for(int j=0;j<2;j++){
while(!M[i][j].fl1.empty())
cout<<"file non vide, y'avait un "<<M[i][j].fl1.defiler()<<" en "<<i<< ","<<j<<endl;
while(!M[i][j].fl2.empty())
cout<<"file non vide, y'avait un "<<M[i][j].fl2.defiler()<<" en "<<i<< ","<<j<<endl;
	
	}

}




};





#endif
