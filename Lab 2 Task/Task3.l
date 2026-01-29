%{
#include <stdio.h>
%}

%%
[a-zA-Z_][a-zA-Z0-9_]*  { printf("Valid Identifier: %s\n", yytext); }
[0-9][a-zA-Z0-9_]*       { printf("Invalid Identifier: %s\n", yytext); }
.                        { /* ignore commas/spaces */ }
%%
%{
#include <stdio.h>
%}

%%
[0-9]+\.[0-9]+     { printf("Floating-point constant: %s\n", yytext); }
[0-9]+             { printf("Integer constant: %s\n", yytext); }
.|\n                { /* ignore */ }
%%

int yywrap(){
    return 1;
}
int main() {
    printf("Enter a line:\n");
    yylex();
    return 0;
}
