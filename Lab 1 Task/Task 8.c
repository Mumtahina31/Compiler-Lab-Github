#include <stdio.h>
#include <string.h>

int main() {
    char line[1000];
    char *token;

    printf("Enter all tokens in one line:\n");
    fgets(line, sizeof(line), stdin);
    line[strcspn(line, "\n")] = '\0';

    token = strtok(line, " \t");

    int count = 1;

    while (token != NULL) {
        printf("%d ", count++);

        if (token[0] == '"') {
            int len = strlen(token);
            if (len > 1 && token[len - 1] == '"')
                printf("Valid string literal\n");
            else
                printf("Invalid string literal (Unterminated)\n");
        }

        else if (token[0] == '\'') {
            int len = strlen(token);

            if (len == 3)
                printf("Valid character constant\n");
            else if (len == 2)
                printf("Invalid character constant (Empty char)\n");
            else if (len > 3)
                printf("Invalid character constant (Multiple characters)\n");
            else
                printf("Invalid character constant (Unterminated)\n");
        }

        else {
            printf("Unknown token\n");
        }

        token = strtok(NULL, " \t");
    }

    return 0;
}
