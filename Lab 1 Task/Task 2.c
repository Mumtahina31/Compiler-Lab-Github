#include <stdio.h>
#include <string.h>
#include <ctype.h>

char *keywords[] = {"if", "else", "int", "char", "double", "float","break", "case", "continue", "default", "do","for", "goto", "return", "static", "switch","void", "while"};
int i;
int funckey(char w[]) {
    for ( i = 0; i < 18; i++) {
        if (strcmp(w, keywords[i]) == 0)
            return 1;
    }
    return 0;
}

int main() {
    char line[200], w[50];
    int i=0,j = 0;
    printf("Enter the line:\n");
    fgets(line, sizeof(line), stdin);

    for ( i = 0; line[i] != '\0'; i++) {
        if (isalpha(line[i])) {
            w[j++] = line[i];
        } else {
            if (j != 0) {
                w[j] = '\0';
                if (funckey(w))
                    printf("%s: Keyword\n", w);
                j = 0;
            }
        }
    }
    if (j != 0) {
        w[j] = '\0';
        if (funckey(w))
            printf("%s: Keyword\n", w);
    }

    return 0;
}
