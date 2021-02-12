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

        // Ensure correct argument count.

    	for(int i=1;i<argc;i++){
		    // Ensure we can open directory.
			printf ("%s/\n",argv[i]);
		    pDir = opendir (argv[i]);
		    if (pDir == NULL) {
		        printf ("Cannot open directory '%s'\n", argv[1]);
		        return 1;
		    }

		    // Process each entry.

		    while ((pDirent = readdir(pDir)) != NULL) {
		        printf ("[%s]\n", pDirent->d_name);
		    }

		    // Close directory and exit.

		    closedir (pDir);
		    
		}
        return 0;
}
