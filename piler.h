#include"Knot.h"
#ifndef PILER_H
#define PILER_H

class Pile{
Knot *k;
public:
Pile();
bool empty();
void push(Knot &c);	//	push method does not clean memory..
Knot pop();
Knot summet();
// p suffix is for pointer managing..
Knot* popp();
Knot* summetp();	//	used for built-in pointers preventing data copying, Just be careful..
void pushp(Knot* &c);




};
#endif
