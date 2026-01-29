%{
#include <stdio.h>
%}

%%

"=="|"!="|">="|"<="      { printf("Relational Operator: %s\n", yytext); }
">"|"<"                  { printf("Relational Operator: %s\n", yytext); }
"&&"|"||"                 { printf("Logical Operator: %s\n", yytext); }
"!"                       { printf("Logical NOT Operator: %s\n", yytext); }
"="                       { printf("Assignment Operator: %s\n", yytext); }
[+\-*/%]                  { printf("Arithmetic Operator: %s\n", yytext); }
.                         { /* ignore other characters */ }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter a line:\n");
    yylex();
    return 0;
}
