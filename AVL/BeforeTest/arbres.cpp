#include"arbres.h"

void Exo1()
{
	cout<<"Exo_1:////////////////////////////////////////////////////////"<<endl;
	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	

}


void infixe(arbre A)
{
	if(A==NULL)
		return;
		infixe(A->fg);
		cout<<A->val<<"-";
		infixe(A->fd);
}



void Exo2()
{
	cout<<"Exo_2:////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	arbre A=tab_arbre(7,T);
	infixe(A);
	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	
}


bool Inserer_arbre(int v,arbre &A)
{

if(A!=NULL)
{	
	Knot* B=A;
	if(seek(v,B))//seek modifie B
			return false;
	if(B->val>v)
		B->fg=new Knot(v);
	else
		B->fd=new Knot(v);
}
	else
		A=new Knot(v);	
	return true;
}
bool seek(int v,Knot* &A)//	I must have called a thousand times
{
	while(A->val!=v)
	{
		if(A->val<v)
		{
			if(A->fd==NULL)
				return false;
			A=A->fd;
		}
		else
		{
			if(A->fg==NULL)
				return false;
			A=A->fg;
		}
	}
	return true;
}
arbre tab_arbre(int n,int *T)
{
	arbre A=NULL;
	for(int i=0;i<n;i++){
		Inserer_arbre(T[i],A);	
		}
	
	return A;
}


void Exo3(){
	cout<<"Exo_3:////////////////////////////////////////////////////////"<<endl;
	//	There was no Task
	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	
}
bool IsEmpty(arbre a)
{return a==NULL;
}
bool IsLeaf(arbre a){
return (a==NULL)?false:((a->fd==NULL)&&(a->fg==NULL));


}
bool IsInternalKnot(arbre a){
	return (a==NULL)?false:(a->fd!=NULL&&a->fg!=NULL);
}

arbre SearchFor(int b,arbre a){
	if(a==NULL)
		return NULL;
	if(a->val==b)
		return a;
	return (a->val>b)?SearchFor(b,a->fg):SearchFor(b,a->fd);
}

void Exo4(){
	cout<<"Exo_4:////////////////////////////////////////////////////////"<<endl;

	int T[]={11,5,66,23,78,54,21,9,63,10};
	arbre a = tab_arbre(10,T);
	cout<<"Prefix :"<<endl;
	Prefix(a);
	cout<<endl;
	cout<<"Iterative Prefix :"<<endl;

	PrefixIterative(a);
	


	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	
}

void Prefix(arbre a){
if(a==NULL)	return;
cout<<a->val<<"-";
Prefix(a->fg);
Prefix(a->fd);
}
     
void Postfix(arbre a){
	if(a==NULL)	return;
	if(IsLeaf(a))
		cout<<a->val<<"-";
	else
	{
		Postfix(a->fg);
		Postfix(a->fd);
		cout<<a->val<<"-";
	}
}

void PrefixIterative(arbre a){
Pile P;
Knot* q;
P.pushp(a);
while(!P.empty()){
	q=P.summetp();
	cout<<q->val<<"-";
	P.popp();
	P.pushp(q->fd);
	P.pushp(q->fg);
}
}


void Exo5(){
	cout<<"Exo_5"<<"////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	arbre a=tab_arbre(7,T);
	cout<<"Parcours par niveau : "<<endl;
	ParNiveau(a);
	cout<<endl<<"Parcours Infixe : "<<endl;
	infixe(a);
	cout<<endl<<"Parcours Infixe Iteratif : "<<endl;
	InfixeIterative(a);
	cout<<endl<<"Parcours Postfixe : "<<endl;
	Postfix(a);
	cout<<endl<<"Parcours Postfixe Iteratif : "<<endl;
	PostfixIterative(a);




	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	
}

void ParNiveau(arbre a )
{
File F;
F.enfilerp(a);
while(!F.empty())
{
	
	cout<<F.summetp()->val<<"-";
	F.enfilerp(F.summetp()->fg);
	F.enfilerp(F.summetp()->fd);
	F.defilerp();
}

}

void InfixeIterative(arbre a){
	bool up=false; // allows to popp the stack without constraints..
	Pile P;
	Knot *q;
	P.pushp(a);
	
	while(!P.empty())	//S'il y'a une Segfault c'est probablement à cause de q..
	{
		if(IsLeaf(P.summetp()))
		{
			cout << P.summetp()->val << "-";
			up=true;
			q=P.popp();
		}
		else{
			if(up){
				if(P.summetp()->fd==q||P.summetp()->fd==NULL)
				{
					cout << P.summetp()->val << "-";
					q=P.popp();
				}
				else
					up=false;				
			}
			else{
				P.pushp(P.summetp()->fd);
				P.pushp(P.summetp()->fg);
			}	
		}


	}
}

void PostfixIterative(arbre a){
	bool up=false;
	Knot *q;
	Pile P;
	P.pushp(a);
	while(!P.empty()){
		if(IsLeaf(P.summetp())){
			cout << P.summetp()->val << "-";
			q=P.popp();
			up=true;
			continue;
		}
		
		if(up){
			if(q==P.summetp()->fd||P.summetp()->fd==NULL){
				cout << P.summetp()->val << "-";
				q=P.popp();
			}
			else
				up=false;
			continue;
		}
		q=P.popp();
		P.pushp(q);
		P.pushp(q->fd);
		P.pushp(q->fg);
		
	}
}


void Exo6(){
	cout<<"Exo_6:"<<"//Recursive Search//////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	arbre a=tab_arbre(7,T);
	T[3]=13;	T[5]=19;
	for(int i=0;i<7;i++)
		cout<<T[i]<<", Is it here ? "<<((SeekRec(T[i],a))?"yes!!":"no..")<<endl;




	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	
}

bool Inserer_arbreRec(int v,arbre &A){
if(A==NULL){
	A=new Knot(v);
	return true;
}
if(A->val==v)
	return false;
if(A->val>v){
	if(A->fd!=NULL)
		return Inserer_arbreRec(v,A->fd);
	else{
		A->fd=new Knot(v);
		return true;
	}
}	
	if(A->fg!=NULL)
		return Inserer_arbreRec(v,A->fg);
	else{
		A->fg=new Knot(v);
		return true;
	}
}

bool SeekRec(int v,arbre a){
return (a==NULL)?false:((v==a->val)?true:((a->val>v)?SeekRec(v,a->fg):SeekRec(v,a->fd)));
}

void Exo7(){
	cout<<"Exo_7"<<"////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	arbre a=tab_arbre(7,T);
	cout<<"Size is : "<<Size(a)<<endl;
	cout<<"The number of leaves is : "<<CountLeaves(a)<<endl;
	
	cout<<"The number of Internal Knots is : "<<CountKnotsInside(a)<<endl;
	cout<<"The height is : "<<height(a)<<endl;


	cout<<endl<<"//////////////////////////////////////////////////////////////"<<endl;	
}

int Size(arbre a){
	return (a==NULL)?0:((IsLeaf(a))?1:1+Size(a->fg)+Size(a->fd));
}

int CountLeaves(arbre a){
	return (a==NULL)?0:((IsLeaf(a))?1:CountLeaves(a->fg)+CountLeaves(a->fd));
}
int CountKnotsInside(arbre a){
	return (a==NULL)?0:((IsLeaf(a))?0:1+CountKnotsInside(a->fg)+CountKnotsInside(a->fd));
}

int height(arbre a){
if(a==NULL)
	return 0;
if(IsLeaf(a))
	return 0; // 1 if the root counts..
int s=height(a->fd);
int b=height(a->fg);
return (s<b)?1+b:1+s;	
}

void Exo8(){
	cout<<"Exo_8"<<"////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	int P[]={18,15,33,11,21,46,30};
	int V[]={1,15,33,11,21,46,30};
	arbre a1=tab_arbre(7,T);
	arbre a2=tab_arbre(7,P);
	arbre a3=tab_arbre(7,V);
	cout<<"A1 and A2 are "<<((Equal(a1,a2)?"Equal":"Inequal"))<<endl;
	cout<<"A1 and A3 are "<<((Equal(a1,a3)?"Equal":"Inequal"))<<endl;
	

	cout<<"//////////////////////////////////////////////////////////////"<<endl;	
}

bool Equal(arbre a1,arbre a2){		//verification par niveau
File F1,F2;
F1.enfilerp(a1);
F2.enfilerp(a2);
while(!F1.empty()||!F2.empty())
{
	if(F1.summetp()->val!=F2.summetp()->val)
		return false;
	F1.enfilerp(F1.summetp()->fg);
	F1.enfilerp(F1.summetp()->fd);
	F1.defilerp();
	F2.enfilerp(F2.summetp()->fg);
	F2.enfilerp(F2.summetp()->fd);
	F2.defilerp();
	
}

return F1.empty()&&F2.empty();

}

bool Symmetric(arbre a1,arbre a2){		//It's funny.. the way I wrote this
File F1,F2;
F1.enfilerp(a1);
F2.enfilerp(a2);
while(!F1.empty()||!F2.empty())
{
	if(F1.summetp()->val!=F2.summetp()->val)
		return false;
	F1.enfilerp(F1.summetp()->fd);
	F1.enfilerp(F1.summetp()->fg);
	F1.defilerp();
	F2.enfilerp(F2.summetp()->fg);
	F2.enfilerp(F2.summetp()->fd);
	F2.defilerp();
	
}
return F1.empty()&&F2.empty();
}

bool EstABRrec(arbre a){
if(a==NULL)
	return false;
if(IsLeaf(a))
	return true;
if(a->fg!=NULL){
	if(a->fg->val>a->val)
		return false;
	if(!EstABRrec(a->fg))
		return false;	
}
if(a->fd!=NULL){
	if(a->fd->val<a->val)
		return false;
	if(!EstABRrec(a->fd))
		return false;
}
return true;
}

void Exo9(){
	cout<<"Exo_9"<<"////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	arbre a=tab_arbre(7,T);
		T[3]=13;	T[5]=19;
	for(int i=0;i<7;i++)
		cout<<T[i]<<", Is it anywhere here ? "<<((SearchAll(a,T[i]))?"yes!!":"no..")<<endl;
	

	cout<<"//////////////////////////////////////////////////////////////"<<endl;	
}

arbre SearchAll(arbre a,int v){
if(a==NULL)
	return NULL;
if(a->val==v)
	return a;
Knot* b=SearchAll(a->fd,v);
Knot* c=SearchAll(a->fg,v);
return (b!=NULL)?b:c;
}


bool InsertABRrec(int v,arbre &a){
if(a==NULL){
	a=new Knot(v);
	return false;
}
if(v>a->val){
	if(a->fd!=NULL)	
		return InsertABRrec(v,a->fd);
	a->fd=new Knot(v);
	return false;
}
if(v==a->val)
	return true;
if(a->fg!=NULL)	
		return InsertABRrec(v,a->fg);
	a->fg=new Knot(v);
	return false;
}

void Exo10(){
	cout<<"Exo_10"<<"////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	arbre a=tab_arbre(7,T);
	cout<<"the Max is : "<< MaxABR(a)->val<<endl;
	cout<<"the Min is : "<< MinABR(a)->val<<endl;

	cout<<"//////////////////////////////////////////////////////////////"<<endl;	
}

arbre MaxABR(arbre a){
if(a==NULL)
	return NULL;
while(a->fd!=NULL)
	a=a->fd;
return a;
}

arbre MinABR(arbre a){
if(a==NULL)
	return NULL;
while(a->fg!=NULL)
	a=a->fg;
return a;
}

void Exo11(){
	cout<<"Exo_11"<<"////////////////////////////////////////////////////////"<<endl;
	int T[]={18,15,33,11,21,46,30};
	int V[]={18,15,13,11,9,8,1};
	List l=Tab_List(T,7);
	arbre a=tab_arbre2(7,T);
	arbre c=tab_arbre2(7,T);

	arbre b=List_ABR(l);
	cout<<"Tree with parenting links in Postfix: "<<endl;
	Postfix(a);cout<<endl;
	cout<<"Same Tree with but made from a list (no parent link) : "<<endl;
	Postfix(b);cout<<endl;
	cout<<"Tree with parenting links using linked Postfix: "<<endl;
	PostfixIP(c);cout<<endl;
	PrefixIP(c);cout<<endl;
	Prefix(c);cout<<endl;
	InfixIP(c);cout<<endl;
	infixe(c);cout<<endl;


	cout<<"//////////////////////////////////////////////////////////////"<<endl;	
}

arbre tab_arbre2(int n,int *T)
{
	arbre A=NULL;
	for(int i=0;i<n;i++){
		Inserer_arbre2(T[i],A);	
		}
	
	return A;
}

bool Inserer_arbre2(int v,arbre &A)
{

if(A!=NULL)
{	
	Knot* B=A;
	if(seek(v,B))//seek modifie B
			return false;
	if(B->val>v)
		B->fg=new Knot(v,B);
	else
		B->fd=new Knot(v,B);
}
	else
		A=new Knot(v);	
	return true;
}

arbre List_ABR(List L){
Knot* d;
arbre a=NULL;
while(L!=NULL){
	d=a;
	if(a==NULL)
	{
		a=L;
		L=L->svt;
		continue;
	}
	while(d->val!=L->val){
	if(d->val>L->val)
		{
			if(d->fg==NULL){
				d->fg=L;
				break;
			}
			else
				d=d->fg;
		}
	else{
			if(d->fd==NULL){
				d->fd=L;
				break;
			}
			else
				d=d->fd;
	}
	}
	L=L->svt;
}
return a;
}

void PostfixIP(arbre a)
{
if(a==NULL)
	return;
	
Knot* q=NULL;	
bool up=false;
while(true){
if(a==NULL)
	break;
if(up){
	if(q==a->fg&&a->fd!=NULL){
		up=false;
		q=a;
		a=a->fd;
		continue;
	}
	
	cout<<a->val<<"-";
		q=a;	
		a=a->pere;
	continue;
}
if(IsLeaf(a)){
	cout<<a->val<<"-";
	q=a;	
	a=a->pere;
	up=true;
	continue;	
	}
a=(a->fg==NULL)?a->fd:a->fg;
}
}

void InfixIP(arbre a)
{
if(a==NULL)
	return;
	
Knot* q=NULL;	
bool up=false;
while(true){
if(a==NULL)
	break;
if(up){
	if(q==a->fg&&a->fd!=NULL){
	cout<<a->val<<"-";
		up=false;
		q=a;
		a=a->fd;
		continue;
	}
	if(q!=a->fd)
		cout<<a->val<<"-";	
	q=a;	
	a=a->pere;
	continue;
}
if(IsLeaf(a)){
	cout<<a->val<<"-";
	q=a;	
	a=a->pere;
	up=true;
	continue;	
	}
a=(a->fg==NULL)?a->fd:a->fg;
}
}

void PrefixIP(arbre a)
{
if(a==NULL)
	return;
	
Knot* q=NULL;	
bool up=false;
while(true){
if(a==NULL)
	break;
if(up){
	if(q==a->fg&&a->fd!=NULL){
		up=false;
		q=a;
		a=a->fd;
		continue;
	}
		q=a;	
		a=a->pere;
	continue;
}
if(IsLeaf(a)){
	cout<<a->val<<"-";
	q=a;	
	a=a->pere;
	up=true;
	continue;	
	}
cout<<a->val<<"-";
a=(a->fg==NULL)?a->fd:a->fg;
}
}


















