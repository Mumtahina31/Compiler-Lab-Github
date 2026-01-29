#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define MAX 200

int main() {
    FILE *f = fopen("inputTask10.txt", "r");
    if (!f) {
        printf("Can't open the file.\n");
        return 1;
    }

    char line[MAX];
    int lineNum = 0;

    while (fgets(line, MAX, f)) {
        lineNum++;
        line[strcspn(line, "\n")] = '\0';
        int qCount = 0;
        int p;
        for (p = 0; line[p] != '\0'; p++) {
            if (line[p] == '"')
                qCount++;
        }

        if (qCount % 2 == 1) {
            for (p= 0; line[p] != '\0'; p++) {
                if (line[p] == '"') {
                    printf("%d Error : Unterminated string", lineNum);
                    for (; line[p] != '\0'; p++) {
                        printf("%c", line[p]);
                    }
                    printf("\n");
                    break;
                }
            }
            continue;
        }

        char *token = strtok(line, " \t=;");
        while (token != NULL) {
            if (token[0] == '"' && token[strlen(token)-1] == '"') {
                token = strtok(NULL, " \t=;");
                continue;
            }
            if (isdigit(token[0])) {
                printf("%d Error : Invalid identifier \'%s\'\n", lineNum, token);
                break;
            }
            for (p= 0; token[p] != '\0'; p++) {
                if (token[p] == '@' || token[p] == '$' || token[p] == '#') {
                    printf("%d Error : Invalid identifier \'%s\'\n", lineNum, token);
                    break;
                }
            }

            token = strtok(NULL, " \t=;");
        }
    }

    fclose(f);
    return 0;
}
