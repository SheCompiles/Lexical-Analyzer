%{ 
/* full project */
%}

digit [0-9]+
hex [0][x|X][0-9A-Fa-f]+
doubleConstant ([0-9]+\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?$
stringConstant  \"[^"\n]*\"

%%

{digit} printf("digit");
{hex} printf("hexadecimal");
{doubleConstant} printf("doubleconstant ");
{stringConstant} printf("stringconstant ");
\n              {printf("line ");}  
([ ])+          {printf("space ");}  
\t              {printf("tab ");}  
"boolean"       {printf("boolean ");}  
"break"         {printf("break ");}  
"double"        {printf("double ");}  
"else"          {printf("else ");}  
"extends"       {printf("extends ");}  
"false"         {printf("false ");}  
"for"           {printf("for ");}  
"if"            {printf("if ");}  
"int"           {printf("int ");}  
"interface"     {printf("interface ");}  
"new"           {printf("new ");}  
"newarray"      {printf("newarray ");}  
"null"          {printf("null ");}  
"println"       {printf("println ");}  
"readln"        {printf("readln ");}  
"return"        {printf("return ");}  
"string"        {printf("string ");}  
"this"          {printf("this ");}  
"true"          {printf("true ");}  
"void"          {printf("void ");}  
"while"         {printf("while ");}  
[a-zA-Z]([a-zA-Z0-9])*            {printf("id ");}  
"+"             printf("plus ");
"-"             printf("minus ");
"*"             printf("multiplication ");
"/"             printf("division ");
"%"             printf("mod ");
"="             printf("assignop ");
"<"             printf("less ");
"<="            printf("lessequal ");
">"             printf("greater ");
">="            printf("greaterequal ");
"=="            printf("equal ");
"!="            printf("notequal ");
"&&"            printf("and ");
"||"            printf("or ");
"!"             printf("not ");
"<<"            printf("rightshift ");
">>"            printf("leftshift ");  
";"             printf("semicolon ");
","             printf("comma ");
"."             printf("period ");
"("             printf("leftparen ");
")"             printf("rightparen ");
"["             printf("leftbracket ");
"]"             printf("rightbracket ");
"{"             printf("leftbrace ");
"}"             printf("rightbrace ");

"//".* { } /* single-line comment */
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] { } /* multi-line comment */

%%

main(int argc, char* argv[]) {
    
    FILE *fh;

    if (argc == 2 && (fh = fopen(argv[1], "r")))
        yyin = fh;
    yylex();
    return 0;
}   

int yywrap() {
    return 1;
}
