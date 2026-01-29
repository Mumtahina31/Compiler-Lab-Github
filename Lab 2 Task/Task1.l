%{
#include <stdio.h>

int chars = 0;
int words = 0;
int lines = 0;

extern FILE *yyin;
%}

%%
\n              { lines++; chars++; }
[ \t]+          { chars += yyleng; }
[^\t\n ]+       { words++; chars += yyleng; }

%%

int yywrap(){
    return 1;
}

int main()
{
    FILE *f1 = fopen("input1.txt", "r");
    if (!f1) {
        printf("Can't open file\n");
        return 0;
    }

    yyin = f1;
    yylex();
    
    printf("Characters: %d\n", chars);
    printf("Words     : %d\n", words);
    printf("Lines     : %d\n", lines);

    fclose(f1);
    return 0;
}
