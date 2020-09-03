 #include<iostream>


using namespace std;

#ifndef KNOT_H
#define KNOT_H
class Knot{
public:
int val;
int height;
Knot *svt,*fd,*fg,*pere;
Knot(int=0,Knot* = NULL);

};
typedef Knot* List;

List Tab_List(int *T,int n);



#endif
