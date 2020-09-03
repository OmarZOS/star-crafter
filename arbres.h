#include"filer.h"
#include"piler.h"

#ifndef ARBRES_H
#define ARBRES_H
typedef Knot *arbre;






void Exo1();//		Bien Achevé..
void infixe(arbre A);

void Exo2();//		Bien Achevé..
bool Inserer_arbre(int v,arbre &A);//		true if just created..
bool seek(int v,Knot* &A);
arbre tab_arbre(int n,int *T);

void Exo3();
bool IsEmpty(arbre a);
bool IsLeaf(arbre a);
bool IsInternalKnot(arbre a);
arbre SearchFor(int b,arbre a);

void Exo4();
void Prefix(arbre a);
void Postfix(arbre a);
void PrefixIterative(arbre a);

void Exo5();
void ParNiveau(arbre a );
void InfixeIterative(arbre a);
void PostfixIterative(arbre a);

void Exo6();
bool Inserer_arbreRec(int v,arbre &A);
bool SeekRec(int v,arbre a);

void Exo7();
int Size(arbre a);
int CountLeaves(arbre a);
int CountKnotsInside(arbre a);
int height(arbre a);

void Exo8();
bool Equal(arbre a1,arbre a2);
bool Symmetric(arbre a1,arbre a2);		//It's funny.. the way I wrote this
bool EstABRrec(arbre a);

void Exo9();
arbre SearchAll(arbre a,int v);
bool InsertABRrec(int v,arbre &a); //	true if already existent

void Exo10();
arbre MaxABR(arbre a);
arbre MinABR(arbre a);

void Exo11();
arbre tab_arbre2(int n,int *T);
bool Inserer_arbre2(int v,arbre &A);
arbre List_ABR(List L);
void PostfixIP(arbre a);
void InfixIP(arbre a);
void PrefixIP(arbre a);
















#endif



