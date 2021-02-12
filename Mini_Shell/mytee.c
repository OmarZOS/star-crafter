#include<stdio.h>
#include<string.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc,char* argv[]){
	char input[100];
	if(argc<=1){
		scanf("%s",input);
		while(strcmp(input,"fin")!=0){
			printf("%s\n",input);	
			scanf("%s",input);
		}
		
	}
	else{
		short append=0;
		int files[argc];
		for(int i=1;i<argc;i++){	
			if(argv[i][0]=='-'){	//very basic argument managing..
				if(argv[i][1]=='a')
					append=1;
				continue;
			}
			if(append==1)
				files[i] = open(argv[i],O_RDWR|O_APPEND);		
			else
				files[i] = open(argv[i],O_WRONLY | O_CREAT);		
		}
		scanf("%s",input);
		while(strncmp(input,"fin",4)!=0){
			printf("%s\n",input);
			strcat(input,"\n");	
			for(int i=1;i<argc;i++){
				if(argv[i][0]=='-')	//very basic argument managing..
					continue;
				//printf("writing to %s",argv[i+1]);
				if(write(files[i],input,strlen(input))<0)
				{
					printf("failed to write into file %s\n",argv[i]);
				}
				
			}
			
			scanf("%s",input);	
		}
	}

	return 0;
}









































