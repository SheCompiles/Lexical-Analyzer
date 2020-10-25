%{ 
/* part 6: program to identify string constants */
%}

stringConstant ["][\s\S]*([^"\\\n]|\\(.|\n))*["]

%%

{stringConstant} printf("CORRECT!");

%%

int main() {
	yylex();
}

int yywrap() {
	return 1;
}
