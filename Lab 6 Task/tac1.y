%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern FILE *yyin;
void yyerror(const char *s);

int temp_count = 0;

char* new_temp() {
    temp_count++;
    char *temp = (char*)malloc(10);
    sprintf(temp, "t%d", temp_count);
    return temp;
}
%}

%union {
    char* str;
}

/* Tokens with semantic values */
%token <str> ID NUM
%token PLUS MINUS MULT DIV MOD EQUAL LPAREN RPAREN COMMA NEWLINE
%token SQRT POW LOG EXP SIN COS TAN ABS

%type <str> program statement_list statement expression factor

%left PLUS MINUS
%left MULT DIV MOD
%right UMINUS

%%

program:
    statement_list
;

statement_list:
      statement
    | statement_list NEWLINE statement
;

statement:
    ID EQUAL expression
    {
        printf("%s = %s\n", $1, $3);          // TAC
        printf("MOV %s , R0\n", $1);          // ASM
        $$ = $3;
    }
;

expression:
      expression PLUS expression
    {
        char *temp = new_temp();
        printf("%s = %s + %s\n", temp, $1, $3);
        printf("ADD R0 , R1\n");
        $$ = temp;
    }
    | expression MINUS expression
    {
        char *temp = new_temp();
        printf("%s = %s - %s\n", temp, $1, $3);
        printf("SUB R0 , R1\n");
        $$ = temp;
    }
    | expression MULT expression
    {
        char *temp = new_temp();
        printf("%s = %s * %s\n", temp, $1, $3);
        printf("MUL R0 , R1\n");
        $$ = temp;
    }
    | expression DIV expression
    {
        char *temp = new_temp();
        printf("%s = %s / %s\n", temp, $1, $3);
        printf("DIV R0 , R1\n");
        $$ = temp;
    }
    | expression MOD expression
    {
        char *temp = new_temp();
        printf("%s = %s %% %s\n", temp, $1, $3);
        printf("MOD R0 , R1\n");
        $$ = temp;
    }
    | MINUS expression %prec UMINUS
    {
        char *temp = new_temp();
        printf("%s = -%s\n", temp, $2);
        printf("NEG R0\n");
        $$ = temp;
    }
    | LPAREN expression RPAREN
    {
        $$ = $2;
    }
    | factor
    {
        $$ = $1;
    }
;

factor:
      NUM
    {
        char *temp = new_temp();
        printf("%s = %s\n", temp, $1);
        printf("MOV R0 , #%s\n", $1);
        $$ = temp;
    }
    | ID
    {
        char *temp = new_temp();
        printf("%s = %s\n", temp, $1);
        printf("MOV R0 , %s\n", $1);
        $$ = temp;
    }
    | SQRT LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = sqrt(%s)\n", temp, $3);
        printf("SQRT R0\n");
        $$ = temp;
    }
    | POW LPAREN expression COMMA expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = pow(%s , %s)\n", temp, $3, $5);
        printf("POW R0 , R1\n");
        $$ = temp;
    }
    | LOG LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = log(%s)\n", temp, $3);
        printf("LOG R0\n");
        $$ = temp;
    }
    | EXP LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = exp(%s)\n", temp, $3);
        printf("EXP R0\n");
        $$ = temp;
    }
    | SIN LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = sin(%s)\n", temp, $3);
        printf("SIN R0\n");
        $$ = temp;
    }
    | COS LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = cos(%s)\n", temp, $3);
        printf("COS R0\n");
        $$ = temp;
    }
    | TAN LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = tan(%s)\n", temp, $3);
        printf("TAN R0\n");
        $$ = temp;
    }
    | ABS LPAREN expression RPAREN
    {
        char *temp = new_temp();
        printf("%s = abs(%s)\n", temp, $3);
        printf("ABS R0\n");
        $$ = temp;
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(int argc, char **argv) {
    if(argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if(!file) { printf("Cannot open file %s\n", argv[1]); return 1; }
        yyin = file;
    }
    yyparse();
    return 0;
}
