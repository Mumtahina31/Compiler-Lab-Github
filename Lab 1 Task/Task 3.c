#include <stdio.h>
#include <string.h>
#include <ctype.h>
int funckey(char *token) {
    char *keywords[] = {"int", "float", "double", "char", "if", "else","for", "while", "return", "void"};
    int i;
    for (i = 0; i < 10; i++) {
        if (strcmp(token, keywords[i]) == 0) {
            return 1;
        }
    }
    return 0;
}

int isLetter(char c) {
    return (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z');
}

int isDigit(char c) {
    return (c >= '0' && c <= '9');
}
int isValidIdentifier(char *token) {
    int i;
    if (!isLetter(token[0]) && token[0] != '_') {
        return 0;
    }
    for (i = 1; token[i] != '\0' && token[i] != '\n'; i++) {
        if (!isLetter(token[i]) && !isDigit(token[i]) && token[i] != '_') {
            return 0;
        }
    }
    if (funckey(token)) {
        return 0;
    }

    return 1;
}

int main() {
    char line[1000];
    char *token;
    printf("Enter identifiers :\n");
    fgets(line, sizeof(line), stdin);
    token = strtok(line, " \t\n");
    while (token != NULL) {
        if (isValidIdentifier(token)) {
            printf("%s: Valid Identifier\n", token);
        } else {
            printf("%s: Invalid Identifier\n", token);
        }
        token = strtok(NULL, " \t\n");
    }

    return 0;
}
