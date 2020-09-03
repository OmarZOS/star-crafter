#include"arbres.h"



bool IsEmpty(arbre a){
	return a==NULL;
}
bool IsLeaf(arbre a){
	return (a==NULL)?false:((a->fd==NULL)&&(a->fg==NULL));
}
bool IsInternalKnot(arbre a){
	return (a==NULL)?false:(a->fd!=NULL&&a->fg!=NULL);
}


int Height(arbre a){
	if(a==NULL)
		return -1;
	return a->height;

}

void MajHauteur(arbre& a){
	if(IsLeaf(a))
		{
		a->height=0;
		return;
		}

	int b=Height(a->fd),c=Height(a->fg);
	a->height= 1+((b>c)?b:c);

}



int Depth_Min(arbre a){

	if(a==NULL)
		return -1;
	if(a->fd==NULL||a->fg==NULL)
		return 0;
	int c=Depth_Min(a->fd);
	int b=Depth_Min(a->fg);
	return ((c>b)?b:c);
	//incmplete

	


}


bool isBalanced(arbre a){
	if(a==NULL) return true;
	if(abs(a->fg->height - a->fd->height)<2)
		return (isBalanced(a->fg) && isBalanced(a->fd));
		
	return false;
}

bool Est_equilibre(arbre a) {
if(a==NULL)
	return true;
int e=a->height-Depth_Min(a);
return (e<=1);
}


arbre tab_arbre(int n,int *T)
{
	arbre A=NULL;
	for(int i=0;i<n;i++)
		InsertAVL(A,T[i]);
//Inserer_arbre(T[i],A);	 //Pour un ABR
		
	return A;
}


void InsertAVL(arbre& a,int x){
	if(a==NULL){
		a=new Knot(x);
		return;
	}
	if(a->val==x)
		return;
	if(a->val>x){
		if(IsEmpty(a->fg))
			a->fg=new Knot(x);
		else
			InsertAVL(a->fg,x);
	}
	else{
		if(IsEmpty(a->fd))
			a->fd=new Knot(x);
		else
			InsertAVL(a->fd,x);
}	

MajHauteur(a);
Reequilibre(a);
}


void infixe(arbre A)
{
		if(A==NULL)
			return;
			infixe(A->fg);
			cout<<A->val<<"-";
			infixe(A->fd);
}

void Prefix(arbre a){
	if(a==NULL)	return;
	cout<<a->val<<"-";
	Prefix(a->fg);
	Prefix(a->fd);
}


int desequilibre(arbre a){
	if(a==NULL)
		return 0;
	return Height(a->fg)-Height(a->fd);
}

void Reequilibre(arbre& a){
	int x1=desequilibre(a);
	if(x1>=2){
		x1=desequilibre(a->fg);
		(x1>=0)?RotateD(a):RotateGD(a);
		return;
	}
	if(x1<=-2){
		x1=desequilibre(a->fd);
		(x1<=0)?RotateG(a):RotateDG(a);
}
}

void RotateD(arbre& a){
	if(a==NULL)
		return;
	if(a->fg==NULL)
		return;
	arbre b=a->fg;
	arbre tmp=NULL;
		if(b!=NULL)
			tmp=b->fd;
	a->fg=tmp;
		if(b!=NULL)
	b->fd=a;
	a=b;

	MajHauteur(a->fd);
	MajHauteur(a);
}

void RotateG(arbre& a){
	if(a==NULL)
		return;
	if(a->fd==NULL)
		return;
	arbre b=a->fd;
	arbre tmp=NULL;
	if(b!=NULL)
		tmp=b->fg;
	a->fd=tmp;
	if(b!=NULL)	
	b->fg=a;
	a=b;
	MajHauteur(a->fg);
	MajHauteur(a);
}

void RotateGD(arbre& a){
	if(a==NULL)
		return;
	RotateG(a->fg);
	RotateD(a);

}
void RotateDG(arbre& a){
	if(a==NULL)
		return;
	RotateD(a->fg);
	RotateG(a);
		
}


void Balance(arbre& a,int& cnt){
	int x=-1;
	while(!isBalanced(a)){//{desequilibre(a)>2||desequilibre(a)<-2)
		cout <<"h"<<endl;
		++x%=5;
		cnt++;
		switch(x){
			case 0 :Reequilibre(a);
					break;
			case 1 :
					Reequilibre(a->fg);	
					break;
			case 2	:
					Balance(a->fg,cnt);
					break;
			case 3 :
					Reequilibre(a->fd);
					break;
			case 4 : 						
					Balance(a->fd,cnt);
					break;

		}
	}
	}
arbre fusion(int v,arbre a,arbre b){
	int count=0;
	arbre c=new Knot(v);
	c->fd=b;
	c->fg=a;
	Balance(c,count);
	cout<<count<<endl;
	return c;
}




/*

void DeleteAVL(arbre& pere,arbre& a,int x){

	if(a==NULL)
		return;
	if(a->val==x){
		if(IsLeaf(a))
		{
			if(pere!=NULL){
				(pere->fd==a)?:;
				
				
			}
			a=NULL;
			return;
		}
		
		if(a->fg!=NULL&&a->fd!=NULL)
		{
		arbre tmp1=Maxfg(a,a->fg);//cela nous retournera le pere du max, ou le min
		if(tmp1==NULL)
			tmp1=Minfd(a,a->fd);
		
		a->val=tmp1->val;
		Reequilibre(a);
		}
		else
		(a->fd==NULL)?RotateD(a):RotateG(a);
	}
	(a->val>x)?DeleteAVL(a->fg,x):DeleteAVL(a->fd,x);
	Reequilibre(a);
}






arbre Minfd(arbre& a,arbre& f){
	if(a==NULL)
		return NULL;
	if(IsLeaf(f)){
		a->fd=NULL;
		return f;
		}
	if(f->fg==NULL){
		RotateG(f);
		a->fg=f;
		arbre B=f->fg;
		f->fg=NULL;
		return f;
	}
	return (Minfd(a,a->fg));
}

arbre Maxfg(arbre& a,arbre& f){
	if(a==NULL)
		return NULL;
	if(IsLeaf(f)){
		a->fg=NULL;
		return f;
		}
	if(f->fd==NULL){
		RotateG(f);
		a->fd=f;
		arbre B=f->fd;
		f->fd=NULL;
		return f;
	}
	return Maxfg(a,a->fd);
}

*/

