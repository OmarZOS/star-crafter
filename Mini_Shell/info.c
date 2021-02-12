#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>
#include <time.h>


void printFileProperties(struct stat stats);


int main(int argc,char* argv[])
{
    struct stat stats;


	for(int i=1;i<argc;i++){
		// stat() returns 0 on successful operation,
		// otherwise returns -1 if unable to get file properties.
		if (stat(argv[i], &stats) == 0)
		{
		    printFileProperties(stats);
		}
		else
		{
		    printf("Unable to get file properties.\n");
		    printf("Please check whether '%s' file exists.\n", argv[i]);
		}
    }

    return 0;
}



/**
 * Function to print file properties.
 */
void printFileProperties(struct stat stats)
{
    struct tm dt;
	printf("i-node : %ld\n",stats.st_ino);
	printf("File type : %d\n",stats.st_mode);
	printf("UID : %d\n",stats.st_uid);
	printf("GID : %d\n",stats.st_gid);

    // File permissions
    printf("File access: ");
    if (stats.st_mode & R_OK)
        printf("r");
    if (stats.st_mode & W_OK)
        printf("w");
    if (stats.st_mode & X_OK)
        printf("x");

	printf("\n");

}
