 #include"Knot.h"




Knot::Knot(int vay,Knot* i)
{
	val=vay;
	pere=i;
	svt=NULL;
	fd=NULL;
	fg=NULL;
}

List Tab_List(int *T,int n){
if(n<1)
	return NULL;
List A=new Knot(T[0]);
List B=A;
for(int i=1;i<n;i++)
{
	B->svt=new Knot(T[i]);
	B=B->svt;
}
return A;
}














