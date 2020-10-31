# sheCompiles - Project 1 (Lexical Analyzer)
For this compiler project, we are referencing a Toy programming language. Our group used the software of Flex, as well as Unix systems (like Linux System and Terminal for Mac) to test and compile our overall program. The purpose of this part of the project is to implement a lexical analyzer for a simple object-oriented programming language called Toy. For this implementation, using our program, it should be able to translate any input Toy program into a sequence of tokens, and create a symbol table using the trie structure for all keywords and user-defined identifiers.

## Contributors
- Patriz Elaine Daroy
- Catherine Gronkiewicz
- Yohanna Tesfay

## Installation
***Install the software of Flex in a Unix environment!***
```
Example for Linux users:
apt-get install lex 
apt-get install bison 

Example for Terminal/Mac users (make sure brew is installed): 
brew install flex
```

## Steps to Run & Compile Project 1's Lexical Analyzer
***Make sure you navigate to the repo folder before running the steps below!***
```
Steps To Run with toyprogram.toy:
1. lex final.lex
2. cc lex.yy.lc -ll
3. ./a.out < toyprogram.toy
```
```
Steps To Run with personalTestCase.toy:
1. lex final.lex
2. cc lex.yy.lc -ll
3. ./a.out < personalTestCase.toy
```
```
Steps To Run with test-VCipher.cpp:
1. lex final.lex
2. cc lex.yy.lc -ll
3. ./a.out < test-VCipher.cpp
```

## Test Cases for Project 1's Lexical Analyzer
```
Input Test Cases (root folder of the repository)
- toyprogram.toy 
- personalTestCase.toy 
- test-VCipher.cpp

Outputs (TestCaseOutputFiles folder)
- finalOutput.txt 
- personalTestCaseOutput.txt 
- test-VCipherOutput.txt
```

## Design & Implementation Explanations of Project 1
```
- Initally, our group split each of the nine tasks of the project among the three of us - once completed, we pushed all the tasks and ran it together for testing
- Quotes in the program: To ensure that stringconstant can be recognized, ensure that the quote is noted as " and not “
- Trie table: We picked '200' as our maxtransition value to ensure we can yield a large enough array to hold all keywords and identifiers

