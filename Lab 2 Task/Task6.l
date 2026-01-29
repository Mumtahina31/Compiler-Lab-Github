%{
#include <stdio.h>
%}

%%
[{}();,\[\]\.]   { printf("Special symbol: %s\n", yytext); }
.                { /* ignore */ }
%%

int yywrap() {
    return 1;
}
int main() {
    printf("Enter a line:\n");
    yylex();
    return 0;
}
