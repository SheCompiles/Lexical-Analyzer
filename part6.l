%{ 
/* part 6: program to identify string constants */
%}

stringConstant ["][\s\S]*([^"\\\n]|\\(.|\n))*["]

%%

{stringConstant} printf("stringconstant");

%%

int main() {
    yylex();
}

int yywrap() {
    return 1;
}
