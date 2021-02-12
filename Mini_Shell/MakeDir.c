#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include<dirent.h>

struct stat st = {0};

int main(int argc,char* argv[]){
	for(int i=0;i<argc;i++){
		if (stat(argv[i], &st) == -1) 
		    mkdir(argv[i],0700);	
		//printf("%s",argv[i]);
	}
	return 0;
}
