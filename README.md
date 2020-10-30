**** Lexical-Analyzer - Toy Program ****

** Project 1: translate any input Toy Program into a sequence of tokens **

========================================
Project 1 Key Components/Specifications:
(1) Keywords which are also reserved words. They cannot be used as identifiers or redefine (such as boolean, break, println, and while)
(2) An Identifier is a sequence of letters, digits, and underscores, starting with a letter. Toy is case-sensitive - e.g., "if" is a keyword,
    but "IF" is an identifier; "hello" and "Hello" are two distinct identifiers
(3) 

How to Run Project 1:
1. lex file.lex
2. cc lex.yy.lc -ll
3. ./a.out < filename
