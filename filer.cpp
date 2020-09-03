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
Knot* File::defiler()
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



Knot* File::summetp()
{
	return k;
}

Knot* File::defilerp()
{
	Knot* q=k;
	if(q!=NULL)
		k=k->svt;
	q->svt=NULL;
	return q;
}

void File::enfilerp(Knot* &c)
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
















