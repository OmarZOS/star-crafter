#include"filer.h"



File::File()
{
	k=NULL;
}

bool File::empty()
{
 	return k==NULL;
}
void File::enfiler(Knot &c)
{
	if(k==NULL)
	{
		k=new Knot;
		*k=c;
		end=k;
		return;
	}
	end->svt=new Knot;
	end=end->svt;
	*end=c;
	return;
}
*Philosopher* File::defiler()
{
	Knot *P=this->k;
	if(P!=NULL)
		this->k=this->k->svt;
	return P;
}
Knot File::summet()
{
	return *k;
}



*Philosopher* File::summetp()
{
	return k;
}

*Philosopher* File::defilerp()
{
	*Philosopher* q=k;
	if(q!=NULL)
		k=k->svt;
	q->svt=NULL;
	return q;
}

void File::enfilerp(*Philosopher* &c)
{
	if(k==NULL)
	{
		k=c;
		end=k;
		return;
	}
	if(c!=NULL){
	end->svt=c;
	end=end->svt;
	//return;
	}
}
















