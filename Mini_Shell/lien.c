#include<stdio.h>
#include<string.h>
#include <stdlib.h>
#include<dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

struct stat st = {0};

int main(int argc,char* argv[]){
	struct dirent *pDirent;
        DIR *pDir;
		char* str;
        // Ensure correct argument count.
		int k,j;
    	for(int i=2;i<argc;i++){
		    // Ensure we can open directory.
			if(argv[i][0]!='/'&&argv[i][0]!='~')
				k=symlink(argv[1],argv[0]);		  
			else
				k=symlink(argv[1],strcat(argv[i],strcat(argv[1],"ln")));		  
			//j=symlinkat(argv[1],1,"~/Bureau");		  
			//printf("%d\n",k);
			//printf("%d\n",j);
		    // Close directory and exit.

		    closedir (pDir);
		    
		}
        return 0;
}










