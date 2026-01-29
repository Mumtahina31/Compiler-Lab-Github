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
