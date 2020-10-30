# sheCompiles - Project I (Lexical Analyzer)
For this compiler project we are referencing a Toy programming language. Our group used the software of Flex, as well as Unix systems (like Linux for Windows and Terminal for Mac) to test and compile our overall program. The purpose of this part of the project is to implement a lexical analyzer for a simple object-oriented programming language called Toy. For this implementation, using our program, it should be able to translate any input Toy program into a sequence of tokens, and create a symbol table using the trie structure for all keywords and user-defined identifiers.

## Contributors
- Patriz Elaine Daroy
- Catherine Gronkiewicz
- Yohanna Tesfay

## Installation
Install the software of Flex in a Unix environment! <br/>

*Example for Window users:* <br/>
*Example for Terminal/Mac users (make sure brew is installed):* <br/>
**brew install flex**

## Steps to Run & Compile Project I's Lexical Analyzer:
> 1. lex final.lex
> 2. cc lex.yy.lc -ll
> 3. ./a.out < toyprogram.lex

## Test Cases for Project I's Lexical Analyzer:
- toyprogram.lex (test input case provided for project) <br/>
- (our own test input case for project) <br/>

- (output of toyprogram.lex)
- (output of our own test case)
