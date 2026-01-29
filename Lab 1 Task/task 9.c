#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define MAX 200

char *keywords[] = {"int", "float", "char", "double", "printf", "scanf", "return"};
int keywordCount = 7;

int isKeyword(char str[]) {
    int k;
    for (k = 0; k < keywordCount; k++)
        if (strcmp(str, keywords[k]) == 0)
            return 1;
    return 0;
}

int isOperator(char ch) {
    char operators[] = "+-*/=%<>!";
    int k;
    for (k = 0; operators[k] != '\0';k++)
        if (ch == operators[k])
            return 1;
    return 0;
}

int isSymbol(char ch) {
    char symbols[] = ";,(){}[]";
    int k;
    for (k = 0; symbols[k] != '\0'; k++)
        if (ch == symbols[k])
            return 1;
    return 0;
}

int isNumber(char str[]) {
    int k = 0, dotCount = 0;
    if (str[0] == '-' || str[0] == '+')
        k++;
    for (; str[k] != '\0'; k++) {
        if (str[k] == '.')
            dotCount++;
        else if (!isdigit(str[k]))
            return 0;
    }
    return (dotCount <= 1);
}

int isStringLiteral(char str[]) {
    int len = strlen(str);
    if ((str[0] == '"' && str[len - 1] == '"') || (str[0] == '\'' && str[len - 1] == '\''))
        return 1;
    return 0;
}

int main() {
    FILE *f9 = fopen("inputTask9.txt", "r");
    if (!f9) {
        printf("File cannot opening.\n");
        return 1;
    }

    char line[MAX];
    int tokenNumber = 1;
    int keywordTokens=0, identifierTokens=0, operatorTokens=0, constantTokens=0, SymbolTokens=0, stringLiteralTokens=0, commentTokens=0;

    while (fgets(line, MAX, f9)) {
        int i = 0;
        while (line[i] != '\0') {
            if (isspace(line[i])) {
                i++;
                continue;
            }

            if (line[i] == '/' && line[i+1] == '/') {
                commentTokens++;
                printf("%d <comment , //>\n", tokenNumber++);
                break;
            }

            if (line[i] == '"' || line[i] == '\'') {
                char str[MAX];
                int j = 0;
                char quote = line[i++];
                str[j++] = quote;
                while (line[i] != quote && line[i] != '\0') {
                    str[j++] = line[i++];
                }
                if (line[i] == quote) str[j++] = line[i++];
                str[j] = '\0';
                stringLiteralTokens++;
                printf("%d <string_literal , %s>\n", tokenNumber++, str);
                continue;
            }

            if (isOperator(line[i])) {
                char op[2]; op[0] = line[i]; op[1] = '\0';
                operatorTokens++;
                printf("%d <operator , %s>\n", tokenNumber++, op);
                i++;
                continue;
            }

            if (isSymbol(line[i])) {
                char sym[2]; sym[0] = line[i]; sym[1] = '\0';
                SymbolTokens++;
                printf("%d <symbol , %s>\n", tokenNumber++, sym);
                i++;
                continue;
            }
            char temp[MAX];
            int j = 0;
            while (line[i] != '\0' && !isspace(line[i]) && !isOperator(line[i]) && !isSymbol(line[i])) {
                temp[j++] = line[i++];
            }
            temp[j] = '\0';

            if (isKeyword(temp)) {
                keywordTokens++;
                printf("%d <keyword , %s>\n", tokenNumber++, temp);
            } else if (isNumber(temp)) {
                constantTokens++;
                printf("%d <constant , %s>\n", tokenNumber++, temp);
            } else {
                identifierTokens++;
                printf("%d <identifier , %s>\n", tokenNumber++, temp);
            }
        }
    }
    fclose(f9);

    printf("\nToken Counts:\n");
    printf("Keywords: %d\n", keywordTokens);
    printf("Identifiers: %d\n", identifierTokens);
    printf("Operators: %d\n", operatorTokens);
    printf("Constants: %d\n", constantTokens);
    printf("Symbols: %d\n", SymbolTokens);
    printf("Strings: %d\n", stringLiteralTokens);
    printf("Comments: %d\n", commentTokens);

    return 0;
}
