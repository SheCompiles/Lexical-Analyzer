%{ 
/* part 8+9: program to identify operators, punctuation, and comments */
%}

%%

"+" printf("plus");
"-" printf("minus");
"*" printf("multiplication");
"/" printf("division");
"%" printf("mod");
"=" printf("assignop");
"<" printf("less");
"<=" printf("lessequal");
">" printf("greater");
">=" printf("greaterequal");
"==" printf("equal");
"!=" printf("notequal");
"&&" printf("and");
"||" printf("or");
"!" printf("exclamation");
"<<" printf("rightshift");
">>" printf("leftshift");  
";" printf("semicolon");
"," printf("comma");
"." printf("period");
"(" printf("leftparen");
")" printf("rightparen");
"[" printf("leftbracket");
"]" printf("rightbracket");
"{" printf("leftcurly");
"}" printf("rightcurly");

"//".* { }
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] { }


%%

int main() {
    yylex();
}

int yywrap() {
    return 1;
}