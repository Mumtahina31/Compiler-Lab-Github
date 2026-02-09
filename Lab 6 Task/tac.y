%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

int tempCount = 1;

char* newTemp() {
    char buf[20];
    sprintf(buf, "t%d", tempCount++);
    return strdup(buf);
}
%}

%union {
    char* str;
}

%token <str> ID NUM
%token PLUS_ASSIGN MINUS_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN POW_ASSIGN IDIV_ASSIGN
%token AND OR NOT POW IDIV GT LT
%token NEWLINE

%left OR
%left AND
%left GT LT
%left '+' '-'
%left '*' '/' '%' IDIV
%right POW
%right NOT UMINUS

%type <str> Expression Term Factor Unary Primary

%%

Program:
    StatementList
    ;

StatementList:
      /* allow empty for trailing newline */
    | Statement
    | StatementList NEWLINE Statement
    ;

Statement:
    ID '=' Expression {
        printf("%s = %s\n", $1, $3);
    }
    | ID PLUS_ASSIGN Expression {
        printf("%s = %s + %s\n", $1, $1, $3);
    }
    | ID MINUS_ASSIGN Expression {
        printf("%s = %s - %s\n", $1, $1, $3);
    }
    | ID MUL_ASSIGN Expression {
        printf("%s = %s * %s\n", $1, $1, $3);
    }
    | ID DIV_ASSIGN Expression {
        printf("%s = %s / %s\n", $1, $1, $3);
    }
    | ID MOD_ASSIGN Expression {
        printf("%s = %s %% %s\n", $1, $1, $3);
    }
    | ID POW_ASSIGN Expression {
        printf("%s = %s ** %s\n", $1, $1, $3);
    }
    | ID IDIV_ASSIGN Expression {
        printf("%s = %s // %s\n", $1, $1, $3);
    }
    ;

Expression:
      Expression OR Expression {
        char* t = newTemp();
        printf("%s = %s || %s\n", t, $1, $3);
        $$ = t;
    }
    | Expression AND Expression {
        char* t = newTemp();
        printf("%s = %s && %s\n", t, $1, $3);
        $$ = t;
    }
    | Expression GT Expression {
        char* t = newTemp();
        printf("%s = %s > %s\n", t, $1, $3);
        $$ = t;
    }
    | Expression LT Expression {
        char* t = newTemp();
        printf("%s = %s < %s\n", t, $1, $3);
        $$ = t;
    }
    | Expression '+' Term {
        char* t = newTemp();
        printf("%s = %s + %s\n", t, $1, $3);
        $$ = t;
    }
    | Expression '-' Term {
        char* t = newTemp();
        printf("%s = %s - %s\n", t, $1, $3);
        $$ = t;
    }
    | Term { $$ = $1; }
    ;

Term:
      Term '*' Factor {
        char* t = newTemp();
        printf("%s = %s * %s\n", t, $1, $3);
        $$ = t;
    }
    | Term '/' Factor {
        char* t = newTemp();
        printf("%s = %s / %s\n", t, $1, $3);
        $$ = t;
    }
    | Term '%' Factor {
        char* t = newTemp();
        printf("%s = %s %% %s\n", t, $1, $3);
        $$ = t;
    }
    | Term IDIV Factor {
        char* t = newTemp();
        printf("%s = %s // %s\n", t, $1, $3);
        $$ = t;
    }
    | Factor { $$ = $1; }
    ;

Factor:
      Unary POW Factor {
        char* t = newTemp();
        printf("%s = %s ** %s\n", t, $1, $3);
        $$ = t;
    }
    | Unary { $$ = $1; }
    ;

Unary:
      NOT Unary {
        char* t = newTemp();
        printf("%s = ! %s\n", t, $2);
        $$ = t;
    }
    | '-' Unary %prec UMINUS {
        char* t = newTemp();
        printf("%s = - %s\n", t, $2);
        $$ = t;
    }
    | Primary { $$ = $1; }
    ;

Primary:
      ID { $$ = $1; }
    | NUM { $$ = $1; }
    | '(' Expression ')' { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
