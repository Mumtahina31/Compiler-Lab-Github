%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

[ \t]+              ;
"\n"                { return NEWLINE; }

"sqrt"              { return SQRT; }
"pow"               { return POW; }
"log"               { return LOG; }
"exp"               { return EXP; }
"sin"               { return SIN; }
"cos"               { return COS; }
"tan"               { return TAN; }
"abs"               { return ABS; }

"+"                 { return '+'; }
"-"                 { return '-'; }
"*"                 { return '*'; }
"/"                 { return '/'; }
"%"                 { return '%'; }
"="                 { return '='; }
","                 { return ','; }
"("                 { return '('; }
")"                 { return ')'; }

[0-9]+              {
                        yylval.str = strdup(yytext);
                        return NUM;
                    }

[a-zA-Z][a-zA-Z0-9]* {
                        yylval.str = strdup(yytext);
                        return ID;
                    }

.                   ;

%%

int yywrap() { return 1; }
