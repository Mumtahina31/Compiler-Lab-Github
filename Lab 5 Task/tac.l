%{
#include "y.tab.h"
%}

%%

"**="       { return POW_ASSIGN; }
"+="        { return PLUS_ASSIGN; }
"-="        { return MINUS_ASSIGN; }
"*="        { return MUL_ASSIGN; }
"/="        { return DIV_ASSIGN; }
"%="        { return MOD_ASSIGN; }

"//"        { return INTDIV; }
"**"        { return POW; }

"&&"        { return AND; }
"||"        { return OR; }
"!"         { return NOT; }

">="        { return GE; }
"<="        { return LE; }
">"         { return '>'; }
"<"         { return '<'; }

[a-zA-Z][a-zA-Z0-9]*   { strcpy(yylval.str, yytext); return ID; }
[0-9]+                 { strcpy(yylval.str, yytext); return NUM; }

[\n]        { return '\n'; }
[ \t]       ;
.           { return yytext[0]; }

%%

