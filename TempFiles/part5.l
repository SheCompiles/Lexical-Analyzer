%{ 
/* part 5: program to identify double constants */
%}

doubleConstant ([0-9]+\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?$

%%

{doubleConstant} printf("doubleconstant");

%%

int main() {
    yylex();
}

int yywrap() {
    return 1;
}
