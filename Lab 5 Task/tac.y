%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
int yylex(void);
void yyerror(const char *s);

int tempCount = 1;

char* newTemp() {
    char *t = (char*)malloc(10);
    sprintf(t, "t%d", tempCount++);
    return t;
}
%}

%union {
    char str[50];
}

%token <str> ID NUM
%token PLUS_ASSIGN MINUS_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN POW_ASSIGN
%token AND OR NOT
%token INTDIV POW
%token '\n'

%type <str> expr term factor unary primary rel_expr

/* precedence */
%right '='
%left OR
%left AND
%left '<' '>' GE LE
%left '+' '-'
%left '*' '/' '%' INTDIV
%right POW
%right NOT

%%

program:
      program line
    | line
    ;

line:
      statement '\n'
    | '\n'
    ;

statement:
      ID '=' expr {
            printf("%s = %s\n", $1, $3);
      }
    | ID PLUS_ASSIGN expr {
            printf("%s = %s + %s\n", $1, $1, $3);
      }
    | ID MINUS_ASSIGN expr {
            printf("%s = %s - %s\n", $1, $1, $3);
      }
    | ID MUL_ASSIGN expr {
            printf("%s = %s * %s\n", $1, $1, $3);
      }
    | ID DIV_ASSIGN expr {
            printf("%s = %s / %s\n", $1, $1, $3);
      }
    | ID MOD_ASSIGN expr {
            printf("%s = %s %% %s\n", $1, $1, $3);
      }
    | ID POW_ASSIGN expr {
            printf("%s = %s ** %s\n", $1, $1, $3);
      }
    ;

expr:
      expr '+' term {
            char *t = newTemp();
            printf("%s = %s + %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | expr '-' term {
            char *t = newTemp();
            printf("%s = %s - %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | expr OR term {
            char *t = newTemp();
            printf("%s = %s || %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | term {
            strcpy($$, $1);
      }
    ;

term:
      term '*' factor {
            char *t = newTemp();
            printf("%s = %s * %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | term '/' factor {
            char *t = newTemp();
            printf("%s = %s / %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | term INTDIV factor {
            char *t = newTemp();
            printf("%s = %s // %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | factor {
            strcpy($$, $1);
      }
    ;

factor:
      factor POW unary {
            char *t = newTemp();
            printf("%s = %s ** %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | unary {
            strcpy($$, $1);
      }
    ;

unary:
      NOT unary {
            char *t = newTemp();
            printf("%s = ! %s\n", t, $2);
            strcpy($$, t);
      }
    | '-' unary {
            char *t = newTemp();
            printf("%s = - %s\n", t, $2);
            strcpy($$, t);
      }
    | rel_expr {
            strcpy($$, $1);
      }
    ;

rel_expr:
      primary '>' primary {
            char *t = newTemp();
            printf("%s = %s > %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | primary '<' primary {
            char *t = newTemp();
            printf("%s = %s < %s\n", t, $1, $3);
            strcpy($$, t);
      }
    | primary {
            strcpy($$, $1);
      }
    ;

primary:
      ID  { strcpy($$, $1); }
    | NUM { strcpy($$, $1); }
    | '(' expr ')' { strcpy($$, $2); }
    ;

%%

int yywrap() {
    return 1;
}

int main() {
    yyin = fopen("input.txt", "r");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    printf("Syntax Error\n");
}
