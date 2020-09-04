#include"Knot.h"
#ifndef FILER_H
#define FILER_H

class File{
Knot *k,*end;
public:
File();
bool empty();
void enfiler(Knot &c);
*Philosopher* defiler();
Knot summet();

//	rubrique des pointeurs
void enfilerp(*Philosopher* &c);
*Philosopher* defilerp();
*Philosopher* summetp();



};
#endif
