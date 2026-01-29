%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

// Define the union for semantic values
%union {
    int num;
    char* id;
}

%token IF ELSE
%token ID NUMBER
%token ASSIGN SEMI
%token PLUS MINUS MUL DIV
%token LT
%token LPAREN RPAREN LBRACE RBRACE

%type <num> NUMBER
%type <id> ID

%%

program
    : stmt_list { printf("Parsing successful!\n"); }
    ;

stmt_list
    : stmt_list stmt
    | stmt
    ;

stmt
    : assign_stmt
    | if_stmt
    ;

assign_stmt
    : ID ASSIGN expr SEMI
    ;

if_stmt
    : IF LPAREN expr RPAREN block ELSE block
    ;

block
    : LBRACE stmt_list RBRACE
    ;

expr
    : expr PLUS term
    | expr MINUS term
    | expr LT term
    | term
    ;

term
    : term MUL factor
    | term DIV factor
    | factor
    ;

factor
    : ID
    | NUMBER
    | LPAREN expr RPAREN
    ;

%%

void yyerror(const char *s) {
    printf("Syntax error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
