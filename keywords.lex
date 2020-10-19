%{ 
#include<stdio.h> 
#include<string.h> 
%}              
   
%% 
\n              {printf("line ");}  
([ ])+          {printf("space ");}  
\t tc++;        {printf("tab ");}  
(boolean)       {printf("boolean ");}  
(break)         {printf("break ");}  
(double)        {printf("double ");}  
(else)          {printf("else ");}  
(extends)       {printf("extends ");}  
(false)         {printf("false ");}  
(for)           {printf("for ");}  
(if)            {printf("if ");}  
(int)           {printf("int ");}  
(interface)     {printf("interface ");}  
(new)           {printf("new ");}  
(newarray)      {printf("newarray ");}  
(null)          {printf("null ");}  
(println)       {printf("println ");}  
(readln)        {printf("readln ");}  
(return)        {printf("return ");}  
(string)        {printf("string ");}  
(this)          {printf("this ");}  
(true)          {printf("true ");}  
(void)          {printf("void ");}  
(while)         {printf("while ");}  
[a-zA-Z]([a-zA-Z0-9])*            {printf("id ");}  
%%              
  
int yywrap(void){} 
  
int main() 
{    
    yylex(); 
    return 0; 
} 