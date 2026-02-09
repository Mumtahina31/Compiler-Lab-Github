%{
#include "tac1.tab.h"
#include <stdlib.h>
#include <string.h>

int yywrap(void) { return 1; }
%}

%%

[ \t]+            { /* skip spaces and tabs */ }
\n                { return NEWLINE; }

"="               { return EQUAL; }
"+"               { return PLUS; }
"-"               { return MINUS; }
"*"               { return MULT; }
"/"               { return DIV; }
"%"               { return MOD; }
"("               { return LPAREN; }
")"               { return RPAREN; }
","               { return COMMA; }

"sqrt"            { return SQRT; }
"pow"             { return POW; }
"log"             { return LOG; }
"exp"             { return EXP; }
"sin"             { return SIN; }
"cos"             { return COS; }
"tan"             { return TAN; }
"abs"             { return ABS; }

[0-9]+            { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }

.                 { /* ignore other characters */ }

%%