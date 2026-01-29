#include <stdio.h>
#include <string.h>
#include <ctype.h>

int isInteger(char *token) {
    int i = 0;
    if (token[0] == '+' || token[0] == '-') {
        i = 1;
    }
    if (token[i] == '\0')
        return 0;

    for (; token[i] != '\0'; i++) {
        if (!isdigit(token[i]))
            return 0;
    }
    return 1;
}
int isFloat(char *token) {
    int i = 0;
    int dotCount = 0;
    int eCount = 0;

    if (token[0] == '+' || token[0] == '-') {
        i = 1;
    }

    if (token[i] == '\0') return 0;

    for (; token[i] != '\0'; i++) {
        if (isdigit(token[i])) continue;
        else if (token[i] == '.') {
            dotCount++;
            if (dotCount > 1) return 0;
        } else if (token[i] == 'e' || token[i] == 'E') {
            eCount++;
            if (eCount > 1) return 0;
            i++;
            if (token[i] == '+' || token[i] == '-') i++;
            if (!isdigit(token[i])) return 0;
        } else {
            return 0;
        }
    }

    return (dotCount > 0 || eCount > 0);
}

int main() {
    char line[1000];
    char *token;

    printf("Enter numbers separated by spaces:\n");
    fgets(line, sizeof(line), stdin);

    token = strtok(line, " \t\n");
    while (token != NULL) {
        if (isInteger(token)) {
            printf("%s: Integer Constant\n", token);
        } else if (isFloat(token)) {
            printf("%s: Float Constant\n", token);
        } else {
            printf("%s: Invalid Constant\n", token);
        }
        token = strtok(NULL, " \t\n");
    }

    return 0;
}
