#include "Header.h"




OMatrix::OMatrix(int a,int b){
	M=new Unit*[a];
	for(int i=0;i<b;i++)
		M[i]=new Unit[b];
	n=a; m=b;
}

ostream& operator << (ostream& out,const OMatrix &a)
{
	for(int i=0;i<a.n;i++)
	{
	for(int j=0;j<a.m;j++)
		out<<a.M[i][j].x<<"  ";
	out<<endl;	
	}
	return out;
}

istream& operator >> (istream& in,OMatrix a)
{
	for(int i=0;i<a.n;i++)
		for(int j=0;j<a.m;j++)
			in>>a.M[i][j].x;
	return in;
}


void OMatrix::vertic(const OMatrix &b,OMatrix fresh)
{
	float tmp;

	for(int j=0;j<b.m;j++ )
	{
		for(int i=0;i<b.n;i++)
		{
		int v;
			tmp=b.M[i][j].x;
			//cout<< tmp<<" vertic "<<""<<endl;
			for(int v=0;v<fresh.n;v++)
			{
				if(fresh.M[i][v].fl2.head==NULL)
					fresh.M[i][v].fl1.enfiler(tmp);
				else
					fresh.M[i][v].x+=tmp*fresh.M[i][v].fl2.defiler();
				
			}
		}
	}
}

void OMatrix::horiz(OMatrix fresh)
{
		float tmp;
	for(int i=0;i<n;i++)
	{
		for(int j=0;j<m;j++ )
		{
			tmp=M[i][j].x;
				//cout<< tmp<<"horiz"<<endl;
			for(int v=0;v<fresh.n;v++)
			{
				if(fresh.M[v][j].fl1.head==NULL)
					fresh.M[v][j].fl2.enfiler(tmp);
				else
					fresh.M[v][j].x+=tmp*fresh.M[v][j].fl1.defiler();
				
			}
		}
		}
}









