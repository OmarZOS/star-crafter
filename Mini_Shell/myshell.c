#include<stdio.h> 
#include<string.h> 
#include<stdlib.h> 
#include<unistd.h> 
#include<sys/types.h> 
#include<sys/wait.h> 


#define PATH_MAX 100
#define MAXLIST 10

void parseSpace(char* str, char** parsed) 
{ 
    int i; 
  
    for (i = 0; i < MAXLIST; i++) { 
        parsed[i] = strsep(&str, " "); 
  
        if (parsed[i] == NULL) 
            break; 
        if (strlen(parsed[i]) == 0) 
            i--; 
    } 
} 

int main() 
{
	
	char cwd[PATH_MAX];
	char cmd[PATH_MAX];
	char* args[MAXLIST];
	if (getcwd(cwd, sizeof(cwd)) != NULL) 
	;//Always wanted to do something here.. but I never did..
	
	strcat(cwd,"#");
	printf("%s",cwd);
	scanf("%[^\n]s",cmd);
  
    while(strncmp(cmd,"exit",4)!=0){
		if(fork()==0){//child process
			parseSpace(cmd,args);
			if(strncmp(args[0],"mytee",5)==0)
				execvp("./mytee",args);
			else{
				if(strncmp(args[0],"MakeDir",7)==0)
					execvp("./MakeDir",args);
				else{
					if(strncmp(args[0],"list",4)==0)
						execvp("./list",args);
					else{
						if(strncmp(args[0],"renommer",8)==0)
							execvp("./renommer",args);
						else{
							if(strncmp(args[0],"lien",4)==0)
								execvp("./lien",args);
							else{
								if(strncmp(args[0],"info",4)==0)
									execvp("./info",args);
								else;	
							}						
						}						
						
					}					
				}
			}
			exit(0);
		}
		else{//parent process waiting for its children to terminate
			wait(NULL);
			wait(NULL);
		}
		printf("%s",cwd);
		scanf("%[^\n]s",cmd);
    }
    return 0; 
}


















