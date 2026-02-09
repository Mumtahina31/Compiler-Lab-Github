%{
#include "tac.tab.h"
#include <string.h>
#include <stdlib.h>

int yywrap(void) { return 1; }
%}

%%

[ \t]+              ;  /* skip whitespace */
"\n"                { return NEWLINE; }

"\+="               { return PLUS_ASSIGN; }
"-="                { return MINUS_ASSIGN; }
"\*="               { return MUL_ASSIGN; }
"/="                { return DIV_ASSIGN; }
"%="                { return MOD_ASSIGN; }
"\*\*="             { return POW_ASSIGN; }
"//="               { return IDIV_ASSIGN; }

"&&"                { return AND; }
"\|\|"              { return OR; }
"!"                 { return NOT; }

"\*\*"              { return POW; }
"//"                { return IDIV; }

">"                 { return GT; }
"<"                 { return LT; }

"\+"                { return '+'; }
"-"                 { return '-'; }
"\*"                { return '*'; }
"/"                 { return '/'; }
"%"                 { return '%'; }
"="                 { return '='; }

"\("                { return '('; }
"\)"                { return ')'; }

[0-9]+              { yylval.str = strdup(yytext); return NUM; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }

.                   ;  /* ignore any other character */

%%
