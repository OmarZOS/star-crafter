#include"Matrix.h"


Matrix::Matrix(int a,int b)
{
count++;
n=a;
m=b;
	A=new double*[n];
	for(int i=0;i<n;i++)
	A[i]=new double[m];
  // cout<<"A new Matrix joined the pack"<<endl;
}

istream& operator >> (istream& in,Matrix a)
{
	a.count++;
	cout<<"Inputting ["<<a.n<<"]["<<a.m<<"]"<<endl;
	for(int i=0;i<a.n;i++)
		for(int j=0;j<a.m;j++)
			in>> a.A[i][j];
	return in;
}

	


ostream& operator << (ostream& out,const Matrix &a)
{
	for(int i=0;i<a.n;i++)
	{
		for(int j=0;j<a.m;j++)
			out<<a.A[i][j]<<"  ";
		cout<<endl;
	}
	return out;
}

Matrix Matrix::operator + (const Matrix &b)
{
	if(n==b.n&&m==b.m)
	{
		Matrix d(n,m);
		for(int i=0;i<n;i++)
			for(int j=0;j<m;j++)
			 	d.A[i][j]=A[i][j]+b.A[i][j];
		return d;		
	}
	Matrix fail(0,0);
	return fail;
}
	
Matrix operator * (const Matrix &b)
{

cout<<"Still working on it.."<<endl;
return b;
}

int Matrix::count=0;

Matrix::~Matrix()
{
  cout<<((count<=1)?"Matrices told me that the end is near..":"A Matrix is gone")<<endl;
count--;
}









