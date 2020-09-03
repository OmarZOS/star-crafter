#include"arbres.h"

int main(){
int n;
	srand (time(NULL));
	cout<<"combien de valeurs??"<<endl;
	cin>>n;	
	int *T;
	T=new int[n];
	for(int i=0;i<n;i++)
		  T[i] = rand() % 100 + 1;

	//int T[]={18,15,33,11,21,46,50,40,45,30,10,89,74,17,60,41,9,2,6,7,9,8,32};
	int V[]={305,604,400,300};
	arbre A=tab_arbre(n,T);
		cout << ((isBalanced(A))?"Yes":"No") << endl;
	cout<<A->height<<endl;
	arbre B=tab_arbre(4,V);
	cout<<B->height<<endl;
	Prefix(A);
	cout<<endl;
	Prefix(B);
	cout<<endl;
	cout<<endl;

	arbre C=fusion(100,A,B)	;
	Prefix(C);
	cout<<endl;





return 0;
}
