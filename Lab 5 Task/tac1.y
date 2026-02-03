%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex();
void yyerror(const char *s);

int tempCount = 1;

char* newTemp() {
    char buf[10];
    sprintf(buf, "t%d", tempCount++);
    return strdup(buf);
}
%}

%union {
    char* str;
}

%token <str> ID NUM
%token SQRT POW LOG EXP SIN COS TAN ABS
%token NEWLINE

%left '+' '-'
%left '*' '/' '%'
%right UMINUS

%type <str> Expression Term Factor FunctionCall Statement

%%

Program
    : StatementList
    ;

StatementList
    : Statement
    | StatementList NEWLINE Statement
    ;

Statement
    : ID '=' Expression
        {
            printf("%s = %s\n", $1, $3);
        }
    ;

Expression
    : Expression '+' Term
        {
            char* t = newTemp();
            printf("%s = %s + %s\n", t, $1, $3);
            $$ = t;
        }
    | Expression '-' Term
        {
            char* t = newTemp();
            printf("%s = %s - %s\n", t, $1, $3);
            $$ = t;
        }
    | Term
        {
            $$ = $1;
        }
    ;

Term
    : Term '*' Factor
        {
            char* t = newTemp();
            printf("%s = %s * %s\n", t, $1, $3);
            $$ = t;
        }
    | Term '/' Factor
        {
            char* t = newTemp();
            printf("%s = %s / %s\n", t, $1, $3);
            $$ = t;
        }
    | Term '%' Factor
        {
            char* t = newTemp();
            printf("%s = %s %% %s\n", t, $1, $3);
            $$ = t;
        }
    | Factor
        {
            $$ = $1;
        }
    ;

Factor
    : FunctionCall
        {
            $$ = $1;
        }
    | '(' Expression ')'
        {
            $$ = $2;
        }
    | '-' Factor %prec UMINUS
        {
            char* t = newTemp();
            printf("%s = -%s\n", t, $2);
            $$ = t;
        }
    | ID
        {
            $$ = $1;
        }
    | NUM
        {
            $$ = $1;
        }
    ;

FunctionCall
    : SQRT '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = sqrt ( %s )\n", t, $3);
            $$ = t;
        }
    | LOG '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = log ( %s )\n", t, $3);
            $$ = t;
        }
    | EXP '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = exp ( %s )\n", t, $3);
            $$ = t;
        }
    | SIN '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = sin ( %s )\n", t, $3);
            $$ = t;
        }
    | COS '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = cos ( %s )\n", t, $3);
            $$ = t;
        }
    | TAN '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = tan ( %s )\n", t, $3);
            $$ = t;
        }
    | ABS '(' Expression ')'
        {
            char* t = newTemp();
            printf("%s = abs ( %s )\n", t, $3);
            $$ = t;
        }
    | POW '(' Expression ',' Expression ')'
        {
            char* t = newTemp();
            printf("%s = pow ( %s , %s )\n", t, $3, $5);
            $$ = t;
        }
    ;

%%

void yyerror(const char *s) {
    printf("Syntax Error\n");
}

int main() {
    freopen("input2.txt", "r", stdin);
    yyparse();
    return 0;
}
