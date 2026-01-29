#include <stdio.h>
#include <string.h>

int main() {
    char line[1000];
    printf("Enter the line:\n");
    fgets(line, sizeof(line), stdin);
    if (strstr(line, "//") != NULL)
     {
        printf("Single line Comment\n");
    }
    else if (strstr(line, "/") != NULL && strstr(line, "/") != NULL)
    {
        printf("Multi line Comment\n");
    }
    else if (strstr(line, "/*") != NULL)
     {
        printf("Multi line Comment start\n");
    }
    else if (strstr(line, "*/") != NULL) {
        printf("Multi line Comment end\n");
    }
    else
     {
        printf("No Comment\n");
    }
    return 0;

}
