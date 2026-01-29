#include <stdio.h>
int main() {
    FILE *ff = fopen("input.txt", "r");
    if (ff == NULL) {
        printf("Cannot open file.\n");
        return 1;
    }

    int c = 0, w = 0, l = 0;
    int inWord = 0;
    char ch;

    while ((ch = fgetc(ff)) != EOF) {
        c++;

        if (ch == '\n')
            l++;

  if (isspace(ch))
            inWord = 0;

        else if (!inWord) {
            inWord = 1;
            w++;
        }
    }

    fclose(ff);

    printf("Total Characters: %d\n", c);
    printf("Total Words: %d\n", w);
    printf("Total Lines: %d\n", l);

    return 0;
}
