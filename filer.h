#include"Knot.h"
#ifndef FILER_H
#define FILER_H

class File{
Knot *k,*end;
public:
File();
bool empty();
void enfiler(Knot &c);
Knot* defiler();
Knot summet();

//	rubrique des pointeurs
void enfilerp(Knot* &c);
Knot* defilerp();
Knot* summetp();



};
#endif
