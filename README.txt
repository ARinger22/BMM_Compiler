                                             Compiler for B--
                                          ----------------------

Directory Structure:
--------------------
2021CSB1071  (2021CSB1071_2021CSB1073)
  |
  |- BMM_Scanner.l
  |- BMM_Parser.y
  |- CorrectSample.bmm
  |- IncorrectSample.bmm
  |- README.txt


Dependencies:
--------------
    - flex installed (we have version 2.5.4)
    - bison installed ( we have bison (GNU Bison) 2.4.1)


Combined instruction :
-------------------------
    flex BMM_Scanner.l ; bison -d BMM_Parser.y ; g++ lex.yy.c BMM_Parser.tab.c -o bmm; ./bmm


The following instruction should be followed while running the program:
    A. Open terminal in the directory 2021CSB1071 and Enter the following command to run the program :
        1. flex BMM_Scanner.l (on running this file we get a lex.yy.c file)
        2. bison -d BMM_Parser.y (on runnng it we will get two file BMM_Parser.tab.h and BMM_Parser.tab.c)
        3. g++ lex.yy.c BMM_Parser.tab.c -o bmm
        4. ./bmm

BMM_Scanner.l
---------------

    A. We've tokenized all the variable names, keywords, special characters and numbers.
    B. It will give the output inside the lex.txt file and print every token name in it.

BMM_Parser.y
-----------------

    A. This program contains the BNF grammar rules for the compiler.
    B. This will give the output inside the parseout.txt file and print the parsing of code.
    C. If there would be any error in syntax then an error message "Syntax Error" is printed in the terminal and if you want to know the error go to lex.txt/parseout.txt and locate where the scanning stopped.
    D. "No syntax error" will be printed if the code is correct


CorrectSample.bmm
-------------------

    A. This file contains the code which has correct syntx.
    B. You can add your correct syntax code here and the program would parse it.
    C. UnComment the line 173 (yyin=fopen("CorrectSample.bmm","r");) and comment the line 172(yyin=fopen("IncorrectSample.bmm","r");) to run the program on this file.

IncorrectSample.bmm
---------------------

    A. This file contains the code which has incorrect syntax.
    B. You can add your incorrect synatx code here and the program would parse it and print the error if it is wrong.
    C. Comment the line 173 (yyin=fopen("CorrectSample.bmm","r");) and Uncomment the line 172(yyin=fopen("IncorrectSample.bmm","r");) to run the program on this file.

lex.txt
---------

    A. This file contains the output obtained by the BMM_Scanner.l file, which are all the tokens in the code.

parseout.txt
---------------

    A. This file stores the output obtained by the BMM_Parser.y file, which is parsed by the cucu.y file and printed the steps and different types of statements in it.

Contributors
--------------
    1 . ANUSHTHA PRAKASH (2021CSB1071)
    2 . ARPIT KUMAR GAUTAM (2021CSB1073)



