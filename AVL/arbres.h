#include"Knot.h"


#ifndef ARBRES_H
#define ARBRES_H
typedef Knot *arbre;


void infixe(arbre A);
bool IsEmpty(arbre a);
bool IsLeaf(arbre a);
bool IsInternalKnot(arbre a);
int Height(arbre a);
int Depth_Min(arbre a);
bool Est_equilibre(arbre a);
bool Inserer_arbre(int v,arbre &A);
bool seek(int v,Knot* &A);
arbre tab_arbre(int n,int *T);
void MajHauteur(arbre& a);
int desequilibre(arbre a);
void RotateD(arbre& a);
void RotateG(arbre& a);
void RotateGD(arbre& a);
void RotateDG(arbre& a);
void Reequilibre(arbre& a);
void InsertAVL(arbre& a,int x);
void DeleteAVL(arbre& a,int x);
arbre Minfd(arbre& a);
void Prefix(arbre a);

void Balance(arbre& a,int& cnt);
bool isBalanced(arbre a);
arbre fusion(int v,arbre a,arbre b);
arbre Minfd(arbre& a,arbre& f);
arbre Maxfg(arbre& a,arbre& f);



#endif



