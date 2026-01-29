%{
#include <stdio.h>
%}

%%
\"([^\"\n])*\"        { printf("Valid String: %s\n", yytext); }
\"([^\"\n])*          { printf("Error: Unterminated string: %s\n", yytext); }
\'[a-zA-Z0-9]\'       { printf("Valid Char: %s\n", yytext); }
\'\'                   { printf("Error: Empty char constant: %s\n", yytext); }
\'[^\']{2,}\'          { printf("Error: Multiple characters in char constant: %s\n", yytext); }
\'[^\']*               { printf("Error: Unterminated char constant: %s\n", yytext); }
.|\n                   { /* ignore */ }
%%

int yywrap() {
    return 1;
}
int main() {
    printf("Enter strings/characters:\n");
    yylex();
    return 0;
}
