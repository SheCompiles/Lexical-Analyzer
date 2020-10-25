%{ 
/* part 4: program to identify decimal and hexadecimal numbers */
%}

digit [0-9]+
hex [0][x|X][0-9A-Fa-f]+

%%

{digit} printf("DIGIT!");
{hex} printf("HEXADECIMAL!");

%%

int main() {
	yylex();
}

int yywrap() {
	return 1;
}



