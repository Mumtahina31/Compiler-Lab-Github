%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%

"if"        { return IF; }
"else"      { return ELSE; }

[0-9]+      { yylval.num = atoi(yytext); return NUMBER; }
[a-zA-Z]+   { yylval.id = strdup(yytext); return ID; }

"="         { return ASSIGN; }
";"         { return SEMI; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"<"         { return LT; }

"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }

[ \t\n]+    ;   // ignore whitespace

.          {printf("Read character: '%s' (ASCII: %d)\n", yytext, (int)*yytext);return 0;}


%%

int yywrap() {
    return 1;
}
