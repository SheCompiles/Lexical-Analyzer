%{
    #include <stdio.h>
    #include <string.h>
    
    /* token definitions */
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
  
  /* defining structure of symbol & switch trie table */
  struct {
    int switchSym[52];
    char symbol[200];
    int next[200];
  } trieTable;

  int yylval;
  void initTrie(void);
  int nextSymbol(char *);
  int findEmpty(char *, int);
  void printSwitch(int *, int);    
  void printSymbol(char *, int);  
  void insert(char *);
  
%}

hex               [0][xX][0-9A-Fa-f]+
digit             [0-9]+
doubleOne         [0-9]+\.[0-9]*([Ee][+-]?[0-9]+)?
doubleTwo         [0-9]+([Ee][+-]?[0-9]+)? 
doubleConstant    {doubleOne}|{doubleTwo} 
intConstant       {hex}|{digit}
stringConstant    \"[^"\n]*\"  
identifier        [a-zA-Z]([a-zA-Z0-9])* 

%%

"/*"(([^*]|(("*"+)[^*/]))*)("*"+)"/"\n {; /* multi-line comment */ }
"//"((.)*)\n                           {; /* single-line comment */ }

\n              {printf("\n ");}  /* new line */
([ ])+          {;}  /* space */
\t              {;} /* tab */

 /* keywords and returning the definition to be inserted into the trie */
boolean     { printf("boolean "); insert(yytext); return (_boolean); } 
break       { printf("break "); insert(yytext); return (_break); }
class       { printf("class "); insert(yytext); return (_class); } 
double      { printf("double "); insert(yytext); return (_double); }
else        { printf("else "); insert(yytext); return (_else); } 
extends     { printf("extends "); insert(yytext); return (_extends); }
false       { printf("booleanconstant "); insert(yytext); return (_booleanconstant); }
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
true        { printf("booleanconstant "); insert(yytext); return (_booleanconstant); } 
void        { printf("void "); insert(yytext); return (_void); } 
while       { printf("while "); insert(yytext); return (_while); }

 /* operators & punctuation characters */
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
  
  printf("\n");
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

 /* initializing the trie */
void initTrie(void) {
  int i;
  for (i = 0; i < 52; i++)
    trieTable.switchSym[i] = -1;
  for (i = 0; i < 200; i++)
    trieTable.symbol[i] = '\0';         // empty character
  for (i = 0; i < 200; i++)
    trieTable.next[i] = -1;
}

 /* updates the trie values based on the ascii value of the character */
int nextSymbol (char *s) {
  int p = s[0];
  if (p >= 97) return p - 97 + 26;      // if a lower case letter, grabs the ascii value and subtracts 97 (ascii value of 'a') and adds 26 to get to its respective index
  return p - 65;                        // if an uppercase letters, grabs the ascii value and subtracts 65 to get to its respective index
}

 /* inserting the character of each token and identifier into the trie */
void insert (char *s) {
  int val = nextSymbol(s);  // val holds the index of the character
  int ptr = trieTable.switchSym[val];   // ptr points to the index
  if (ptr == -1) {  // if there is nothing in the ptr then we find the next empty slot
    int slot = findEmpty(trieTable.symbol, LENGTH(trieTable.symbol));
    trieTable.switchSym[val] = slot;    // once we find the empty slot we set the value of the switch table to the next empty slot
    int i = 1;
    while (i < strlen(s)) // we do the same to iterate through the rest of the identifier into the symbol table
    {
        trieTable.symbol[slot++] = s[i++];
    }
    trieTable.symbol[slot] = '@';
  } 
  else // if the ptr is not empty we check the next table to find the next empty slot
  { 
    int exit = false;
    int i = 1;      
    int p = ptr;   
    while (i < strlen(s)) { // continue to iterate through the rest of the identifier/keyword
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
      if (trieTable.next[p] == -1)  // if next value is empty, we navigate to next empty slot
      {
        next = findEmpty(trieTable.symbol, LENGTH(trieTable.symbol));
      }
      else  // otherwise we keep going through the next table until we encounter an empty slot
      {
        next = trieTable.next[p];
      }
      trieTable.next[p] = next;
      while (i < strlen(s)) // populates the symbol table until we reach the end of the identifier/keyword
      {
        trieTable.symbol[next++] = s[i++];
      }
      trieTable.symbol[next] = '@';         // delimiter indicating end of a token
    }
  }
}

 /* locates the next empty slot in the symbol table */
int findEmpty(char *array, int size) {
  int i; 
  for (i = 0; i < size; i++) 
    if (array[i] == '\0')   // if the index holds an empty character value then it returns the current empty slot
      return i;
}

 /* prints the switch table */
void printSwitch(int *table, int size) {
  char alphabets[52] = { 'A', 'B', 'C', 'D', 'E', 'F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
  int i;
  printf(" ");
  for (i = 0; i < 52; i++)  // prints out the alphabet as reference
    printf("%1c  ", alphabets[i]);
  printf("\n"); 
  for (i = 0; i < size; i++) // prints out the results
    printf("%1d ", table[i]);
}

 /* prints the symbol table */
void printSymbol(char *table, int size) {
  int i; 
  for (i = 0; i < size; i++)    // prints out the indices
    printf("%1d ", i); 
  printf("\n");
  for (i = 0; i < size; i++)    // prints out the results
    printf("%1c ", table[i]);
}
