%{ 
  #define true 1 
  #define false 0
  #define LENGTH(x) (sizeof(x)/sizeof(*(x)))
  
  struct {
    int dispatch[52];
    char symbol[200];
    int next[200];
  } symbol_table;

  void initTable(void);
  int nextSymbol(char *);
  void insert(char *);
  int findEmpty(char *, int);
  void printSwitch(int *, int);    
  void printSymbol(char *, int); 
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

int main(int argc, char* argv[]) {
    
    initTable();
    while(yylex()) {}
    return 0;
}   

void initTable(void) {
  int i;
  for (i = 0; i < 52; i++)
    symbol_table.dispatch[i] = -1;
  for (i = 0; i < 200; i++)
    symbol_table.symbol[i] = '\0';
  for (i = 0; i < 200; i++)
    symbol_table.next[i] = -1;
}

int nextSymbol (char *s) {
  int p = s[0];
  if (p >= 97) return p - 97 + 26; 
  return p - 65;
}

void insert (char *s) {
  int value = nextSymbol(s); 
  int ptr = symbol_table.dispatch[ value ];
  
  if (ptr == -1) {
    int slot = findEmpty(symbol_table.symbol, LENGTH(symbol_table.symbol));
    symbol_table.dispatch[value] = slot;    
    
    int i = 1;
    while (i < strlen(s)) 
      symbol_table.symbol[slot++] = s[i++];
    symbol_table.symbol[slot] = '@';

  } else { 
    int exit = false;
    int i = 1;      
    int p = ptr;    
    while (i < strlen(s)) {
      if (s[i] == symbol_table.symbol[p]) {
        i++;
        p++;
      } else {
        exit = true; 
        break;
      }
    }

    if (exit == true) {
      int next;
      if (symbol_table.next[p] == -1)
        next = findEmpty(symbol_table.symbol, LENGTH(symbol_table.symbol));
      else
        next = symbol_table.next[p];
          
      symbol_table.next[p] = next;
      
      while (i < strlen(s)) 
        symbol_table.symbol[next++] = s[i++];
      symbol_table.symbol[next] = '@';
    }
  }
}

int findEmpty(char *array, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    if (array[i] == '\0') 
      return i;
}

int yywrap() {
    return 1;
}
