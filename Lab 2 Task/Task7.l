%{
#include <stdio.h>
%}

%%
"//".*                           { printf("Single-line comment"); }
"/\\*"([^*]|(\*+[^*/]))*"\\*/"   { printf("Multi-line comment"); }
"/\\*"([^*]|(\*+[^*/]))*         { printf("Error: Unterminated comment"); }
.|\n                             { /* ignore */ }
%%

int yywrap() {
    return 1;
}
int main() {
    printf("Enter a line or comment:\n");
    yylex();
    return 0;
}
