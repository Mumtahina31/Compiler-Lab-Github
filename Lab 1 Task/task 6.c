#include <stdio.h>
int main() {
    char line[1000];
    int i;
    printf("Enter the line:\n");
    fgets(line, sizeof(line), stdin);
    printf("Symbols are:\n");
    for (i = 0; line[i] != '\0'; i++) {
        if (line[i] == '{' || line[i] == '}' || line[i] == '(' || line[i] == ')' || line[i] == ';' || line[i] == ',' || line[i] == '[' || line[i] == ']' || line[i] == '.')
        {
            printf("Symbol: %c\n", line[i]);
        }
    }

    return 0;
}
