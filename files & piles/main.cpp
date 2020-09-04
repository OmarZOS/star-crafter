
#include"filer.h"
#include"piler.h"



int main()
{
	Knot k(1),v(3);
	Pile f;
	f.push(k);
	f.push(v);
	f.pop();
	cout<<f.summet().val<<endl;
	return 0;
}


