 #include <stdio.h>
int main(int argc,char* argv[]){

	if(argc!=3)	
		printf("rename takes exactly two arguments!!");
	else{
		rename(argv[1],argv[2]);
	}

	return 0;
}























