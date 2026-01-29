grammar task1;

expr: expr POW expr           # PowerExpr
    | expr (MUL | DIV) expr   # MulDivExpr
    | expr (ADD | SUB) expr   # AddSubExpr
    | '(' expr ')'            # ParenExpr
    | NUMBER                  # NumberExpr
    | ID                      # IdExpr
    ;

POW: '^';
MUL: '*';
DIV: '/';
ADD: '+';
SUB: '-';

NUMBER: [0-9]+ ( '.' [0-9]+ )? ;
ID: [a-zA-Z_] [a-zA-Z0-9_]* ;
WS: [ \t\r\n]+ -> skip ;