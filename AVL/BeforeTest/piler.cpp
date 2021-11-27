#include"piler.h"





Pile::Pile()
{
	k=NULL;
}
bool Pile::empty()
{
	return k==NULL;
}
void Pile::push(Knot &c)
{
	if(k==NULL)
	{
		k=new Knot;
		*k=c;
		return;
	}
	Knot* x;
	x=new Knot;
	*x=c;
	x->svt=k;
	k=x;	
}
void Pile::pushp(Knot* &c)
{
	if(k==NULL)
	{
		k=c;
		return;
	}
	if(c!=NULL){
	c->svt=k;
	k=c;
	}
}

Knot Pile::pop()
{
	Knot x=*k;
	k=k->svt;
	return x;
}
Knot Pile::summet()
{
	return *k;
}

Knot* Pile::popp()
{
	Knot* x=k;
	k=k->svt;
	x->svt=NULL;
	return x;

}
Knot* Pile::summetp()
{
	return k;
}


















