%{
    #include <stdio.h>
    #include <string.h>

    #define _boolean         1
    #define _break           2
    #define _class           3
    #define _double          4
    #define _else            5
    #define _extends         6
    #define _for             7
    #define _if              8
    #define _implements      9
    #define _int             10
    #define _interface       11
    #define _newarray        12
    #define _println         13
    #define _readln          14
    #define _return          15
    #define _string          16
    #define _void            17
    #define _while           18
    #define _id              19
    #define _null            20
    #define _this            21
    #define _booleanconstant 22
    #define true             23 
    #define false            24
    
    #define LENGTH(x) (sizeof(x)/sizeof(*(x)))
    
  struct {
    int switchSym[52];
    char symbol[200];
    int next[200];
  } trieTable;

  int yylval;
  void initTrie(void);
  int next_symbol(char *);
  int findEmpty(char *, int);
  void printSwitch(int *, int);    
  void printSymbol(char *, int);  
  void insert(char *);
  
%}

hex             [0][x|X][0-9A-Fa-f]+
digit           [0-9]+
stringConstant  \"[^"\n]*\"
doubleConstant  ([0-9]+\.[0-9]+|[0-9]+\.)([eE][+-]?[0-9]+)?$
intConstant     {hex}|{digit}
identifier      [a-zA-Z]([a-zA-Z0-9])*

%%

"/*"(([^*]|(("*"+)[^*/]))*)("*"+)"/"\n {; /* multi-line comment */ }
"//"((.)*)\n                           {; /* single-line comment */ }

\n              {printf("\n ");}  
([ ])+          {;}  
\t              {;} 
boolean     { printf("boolean "); insert(yytext); return (_boolean); } 
break       { printf("break "); insert(yytext); return (_break); }
class       { printf("class "); insert(yytext); return (_class); } 
double      { printf("double "); insert(yytext); return (_double); }
else        { printf("else "); insert(yytext); return (_else); } 
extends     { printf("extends "); insert(yytext); return (_extends); } 
for         { printf("for "); insert(yytext); return (_for); } 
if          { printf("if "); insert(yytext); return (_if); }
int         { printf("int "); insert(yytext); return (_int); } 
implements  { printf("implements "); insert(yytext); return (_implements); } 
interface   { printf("interface "); insert(yytext); return (_interface); } 
newarray    { printf("newarray "); insert(yytext); return (_newarray); } 
null        { printf("null "); insert(yytext); return (_null); } 
println     { printf("println "); insert(yytext); return (_println); } 
readln      { printf("readln "); insert(yytext); return (_readln); }
return      { printf("return "); insert(yytext); return (_return); }
string      { printf("string "); insert(yytext); return (_string); }
this        { printf("this "); insert(yytext); return (_this); } 
true        { printf("true "); return (_booleanconstant); } 
false       { printf("false "); return (_booleanconstant); } 
void        { printf("void "); insert(yytext); return (_void); } 
while       { printf("while "); insert(yytext); return (_while); }

"+"           { printf("plus "); }
"-"           { printf("minus "); }
"*"           { printf("multiplication "); }
"/"           { printf("division ");}
"%"           { printf("mod ");}
"="           { printf("assignop ");}
"<"           { printf("less ");}
"<="          { printf("lessequal ");}
">"           { printf("greater ");}
">="          { printf("greaterequal ");}
"=="          { printf("equal ");}
"!="          { printf("notequal ");}
"&&"          { printf("and ");}
"||"          { printf("or ");}
"!"           { printf("not ");}
"<<"          { printf("rightshift ");}
">>"          { printf("leftshift ");  }
";"           { printf("semicolon ");}
","           { printf("comma ");}
"."           { printf("period ");}
"("           { printf("leftparen ");}
")"           { printf("rightparen ");}
"["           { printf("leftbracket ");}
"]"           { printf("rightbracket ");}
"{"           { printf("leftbrace ");}
"}"           { printf("rightbrace ");}

{intConstant}       { printf("intconstant ");}
{doubleConstant}    { printf("doubleconstant ");}
{stringConstant}    { printf("stringconstant ");}
{identifier}        {printf("id "); insert(yytext); return (_id);}
.                   {; /* ignore unknown characters */ }

%%

int main(int argc, char *argv[]) {

  initTrie();
  
  printf("\nOutput\n");
  while(yylex()) {}
  
  printf("\n\nSwitch Table\n");
  printSwitch(trieTable.switchSym, LENGTH(trieTable.switchSym));
   
  printf("\n\nSymbol Table\n");
  printSymbol(trieTable.symbol, LENGTH(trieTable.symbol));
  
  printf("\n");
  return 0;
}

int yywrap(void) 
{ 
    return (1); 
}

void initTrie(void) {
  int i;
  for (i = 0; i < 52; i++)
    trieTable.switchSym[i] = -1;
  for (i = 0; i < 200; i++)
    trieTable.symbol[i] = '\0';
  for (i = 0; i < 200; i++)
    trieTable.next[i] = -1;
}

int next_symbol (char *s) {
  int p = s[0];
  if (p >= 97) return p - 97 + 26; 
  return p - 65;
}

void insert (char *s) {
  int value = next_symbol(s); 
  int ptr = trieTable.switchSym[ value ];
  if (ptr == -1) {
    int slot = findEmpty(trieTable.symbol, LENGTH(trieTable.symbol));
    trieTable.switchSym[value] = slot;    
    int i = 1;
    while (i < strlen(s)) 
    {
        trieTable.symbol[slot++] = s[i++];
    }
    trieTable.symbol[slot] = '@';
  } 
  else 
  { 
    int exit = false;
    int i = 1;      
    int p = ptr;   
    while (i < strlen(s)) {
      if (s[i] == trieTable.symbol[p]) 
      {
        i++;
        p++;
      } 
      else 
      {
        exit = true; 
        break;
      }
    }
    
    if (exit == true) 
    {
      int next;
      if (trieTable.next[p] == -1)
        next = findEmpty(trieTable.symbol, LENGTH(trieTable.symbol));
      else
        next = trieTable.next[p];
      trieTable.next[p] = next;
      while (i < strlen(s)) 
        trieTable.symbol[next++] = s[i++];
      trieTable.symbol[next] = '@';
    }
  }
}

int findEmpty(char *array, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    if (array[i] == '\0') 
      return i;
}

void printSwitch(int *table, int size) {
  char alphabets[52] = { 'A', 'B', 'C', 'D', 'E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
  int i;
  printf(" ");
  for (i = 0; i < 52; i++)
    printf("%1c  ", alphabets[i]);
  printf("\n"); 
  for (i = 0; i < size; i++) 
    printf("%1d ", table[i]);
}

void printSymbol(char *table, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    printf("%1d ", i); 
  printf("\n");
  for (i = 0; i < size; i++) 
    printf("%1c ", table[i]);
}
