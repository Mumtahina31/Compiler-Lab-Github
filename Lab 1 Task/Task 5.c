#include <stdio.h>
#include <string.h>

int main() {
    char line[1000];
    int i;
    printf("Enter  function:\n");
    fgets(line, sizeof(line), stdin);
    printf("Operators are:\n");
    for (i = 0; line[i] != '\0'; i++) {
        if (line[i] == '=' && line[i+1] == '=') {
            printf("Operator: ==\n");
            i++;
        }
        else if (line[i] == '!' && line[i+1] == '=') {
            printf("Operator: !=\n");
            i++;
        }
         else if (line[i] == '>' && line[i+1] == '=') {
            printf("Operator: >=\n");
            i++;
        }
         else if (line[i] == '<' && line[i+1] == '=') {
            printf("Operator: <=\n");
            i++;
        }
         else if (line[i] == '&' && line[i+1] == '&') {
            printf("Operator: &&\n");
            i++;
        }
        else if (line[i] == '|' && line[i+1] == '|') {
            printf("Operator: ||\n");
            i++;
        }
        else if (line[i] == '+' || line[i] == '-' || line[i] == '*' || line[i] == '/' || line[i] == '%' || line[i] == '=' || line[i] == '>' || line[i] == '<' || line[i] == '!' ||
                 line[i] == ';')
        {
            printf("Operator: %c\n", line[i]);
        }
    }

    return 0;
}
