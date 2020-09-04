#ifndef HEADER_H
#define HEADER_H
#include<iostream>
 #include <fcntl.h>           /* For O_* constants */
       #include <sys/stat.h>        /* For mode constants */
       #include <semaphore.h>
#include<string>
#include<pthread.h>
#include"filer.h"
using namespace std;


#define PHIL_COUNT 5

struct state{
bool hungry,thinking,eating,fourchette;
};




void *Philosopher(void *i) {
	int x=*(int *)i;
	int j,k;
	while(true){
	j=rand()%13;
	k=rand()%7;
	cout<<"Philosopher "<<x<<" is thinking.."<<endl
	sleep(j);
	cout<<"Philosopher "<<x<<" is hungry.."<<endl;
	this->test(x);
	cout<<"Philosopher "<<x<<" is eating.."<<endl;
	sleep(k);
	cout<<"Philosopher "<<x<<" finished eating.."<<endl;
	
	
	
	}	
}




class Monitor{

	sem_t *critsect;
	
	File F=NULL;
	
	struct state etat[PHIL_COUNT];
	pthread_t Philosophers[PHIL_COUNT];
	int turn=-1;
	public:
	Monitor(string = "");

	

bool wait(int i){
	//carefull here
	if(!etat[(i)%PHIL_COUNT].fourchette||!etat[(i+1)%PHIL_COUNT].fourchette){	
		if(!etat[i].hungry){
			Knot p(i);
			etat[i].hungry=true;
			etat[i].thinking=false;
			etat[i].eating=false;
			F.enfiler(p);
		}
		return true;
	}
	
	etat[i].hungry=false;
	etat[i].thinking=false;
	etat[i].eating=true;
	etat[i].fourchette=true;
	return false;
	
}

void signal(int i){
	
	etat[i].eating=false;
	etat[i].hungry=false;
	etat[i].thinking=true;
	etat[i+1].fourchette=true;



}


~Monitor(){
sem_destroy(critsect);
}



};
















#endif
