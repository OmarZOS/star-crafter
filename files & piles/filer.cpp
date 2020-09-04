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
Knot File::defiler()
{
	if(!empty())
	{
		Knot c=*k;
		k=k->svt;
		return c;
	}
}
Knot File::summet()
{
	return *k;
}
