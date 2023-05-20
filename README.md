<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <br />
<p align="center">

  <h3 align="center">BMM_Compiler</h3>

  <p align="center">
    A compiler for a simple language (called B--) from scratch
    <br />
    <a href="https://github.com/anushthaPrakash/BMM_Compiler/blob/main/Docs.pdf"><strong>Explore the problem statement »</strong></a>
 
  </p>
</p>
<h1  style="color:blue;text-align:center" ><strong> Compiler for B--</strong></h1>

<br/>
<h2>Table of Contents</h2>
<ul>
  <li><a href="#dependencies">Dependencies</a></li>
  <li><a href="#running">Running the compiler</a></li>
  <li><a href="#files">Files Specification</a></li>
  <li><a href="#contributors">Contributors</a></li>
</ul>
<br>
<h2 id="dependencies">Dependencies</h2>

#### Softwares Used
- `flex : ` (we have version 2.5.4)
- `bison : ` ( we have bison (GNU Bison) 2.4.1)

<br>
<h3 id = "running">Running</h3>
<ul>
  <li>Combined instruction</li>
  <pre><code>
   flex BMM_Scanner.l ; bison -d BMM_Parser.y ; g++ lex.yy.c BMM_Parser.tab.c -o bmm; ./bmm
 </code></pre>
  <li>Download the zip file of the repository</li>
  <li>Open terminal in the directory 2021CSB1071 and Enter the following command to run the program :</li>
  <pre><code>
   cd 2021CSB1071
 </code></pre>
  <li>Now run the following command in terminal (on running this file we get lex.yy.c, MM_Parser.tab.h and BMM_Parser.tab file)</li>
  <pre><code>
    flex BMM_Scanner.l
    bison -d BMM_Parser.y
    g++ lex.yy.c BMM_Parser.tab.c -o bmm
    ./bmm
  </code></pre>
</ul>
<h3 id = "files" >Files Specification</h3>
  
  <h4>Directory Structure</h4>
  <pre><code>
  2021CSB1071  (2021CSB1071_2021CSB1073)
  |
  |- BMM_Scanner.l
  |- BMM_Parser.y
  |- CorrectSample.bmm
  |- IncorrectSample.bmm
  |- README.txt
  </code></pre>
  
  
  <h4>BMM_Scanner.l</h4>
<ul>
  <li>We've tokenized all the variable names, keywords, special characters and numbers.</li>
  <li>It will give the output inside the lex.txt file and print every token name in it.</li>
</ul>
    <h4>BMM_Parser.y</h4>
<ul>
  <li>This program contains the BNF grammar rules for the compiler.</li>
  <li>This will give the output inside the parseout.txt file and print the parsing of code.</li>
   <li>If there would be any error in syntax then an error message "Syntax Error" is printed in the terminal and if you want to know the error go to lex.txt/parseout.txt and locate where the scanning stopped.</li>
  <li>"No syntax error" will be printed if the code is correct</li>
</ul>
    <h4>CorrectSample.bmm</h4>
<ul>
  <li>This file contains the code which has correct syntx.</li>
  <li>You can add your correct syntax code here and the program would parse it.</li>
  <li>UnComment the line 173 (yyin=fopen("CorrectSample.bmm","r");) and comment the line 172(yyin=fopen("IncorrectSample.bmm","r");) to run the program on this file.</li>
</ul>
    <h4>IncorrectSample.bmm</h4>
<ul>
  <li>This file contains the code which has incorrect syntax.</li>
  <li>You can add your incorrect synatx code here and the program would parse it and print the error if it is wrong.</li>
  <li>Comment the line 173 (yyin=fopen("CorrectSample.bmm","r");) and Uncomment the line 172(yyin=fopen("IncorrectSample.bmm","r");) to run the program on this file.</li>
</ul>
<br>

<h3>Output Format</h3>

Check the generated folder for details of compilation. It contains:

- `lex.txt :` This file contains the output obtained by the BMM_Scanner.l file, which are all the tokens in the code.
- `parseout.txt :` This file stores the output obtained by the BMM_Parser.y file, which is parsed by the cucu.y file and printed the steps and different types of statements in it.


<h2 id="contributors">Contributors</h2>

<div align="center">
  <strong>
    <a href="https://github.com/anushthaPrakash">Anushtha Prakash</a> &emsp;
    <a href="https://github.com/ARinger22">Arpit Kumar Gautam</a> &emsp;
  </strong>
</div>

</body>
</html>
