%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int yylex();
int end = 0;
void yyerror(char const *);
extern FILE *yyin,*yyout,*lexout;
%}

%token LET COMMA COMMENT_SYMBOL INITIALIZE_VAR ASSIGN ADD SUB DIV MUL LEFT_BRAC RIGHT_BRAC GREATER_THAN LESS_THAN LESS_THAN_EQUAL GREATER_THAN_EQUAL COMPARE_NOT_EQUAL LOGICAL_NOT LOGICAL_AND LOGICAL_OR LOGICAL_XOR FUNCTION IF THEN FOR GOTO NEXT GOSUB TO STEP RETURN END DATA DEF DIM INPUT STOP PRINT ARRAY EXPO REM FN SEMI

%union{
    char* id;
    char* str;
    int integer;
    float Single;
    double Double;
    int line;
}

%token <id> ID_STRING  
%token <id> ID_DOUBLE  
%token <id> ID_INT  
%token <id> ID_SINGLE
%token <integer> INT_VALUE
%token <str> STR_VALUE
%token <Single> SINGLE_VALUE
%token <Double> DOUBLE_VALUE
%token <line> LINE_NUMBER


%left ADD SUB
%left MUL DIV
%left LEFT_BRAC RIGHT_BRAC


%%

program : statement_list
        ;

statement_list:
     statement_list statement
     | statement
     ;

statement :
     LINE_NUMBER  {fprintf(yyout,"Line Number: %d \n",$1);} statement_body
     ;
        
statement_body : 
     REM             {fprintf(yyout,"comment statement \n");}
    | LET  {fprintf(yyout,"assignment : \n");} ids ASSIGN expr  
    | LET  {fprintf(yyout,"assignment : \n");} dim_list ASSIGN expr  
    | INPUT   {fprintf(yyout,"\t input : \n");} id_list   
    | PRINT {fprintf(yyout,"\t print : \n");} print_list  
    | GOTO  {fprintf(yyout,"\t goto : \n");} INT_VALUE
    | GOTO {fprintf(yyout,"\t goto : \n");} LINE_NUMBER 
    | GOSUB {fprintf(yyout,"\t function call below \n");} LINE_NUMBER 
    | GOSUB {fprintf(yyout,"\t function call below \n");} INT_VALUE 
    | RETURN            {fprintf(yyout,"return \n");}
    | IF  {fprintf(yyout,"\t if statement :\n");} mixed_expr THEN INT_VALUE 
    | IF  {fprintf(yyout,"\t if statement :\n");} expr THEN INT_VALUE   
    | FOR    ids ASSIGN expr TO expr step_clause   {fprintf(yyout,"\t for loop above \n");}  
    | FOR  ids ASSIGN expr TO expr    {fprintf(yyout,"\t for loop above \n");} 
    | NEXT  ids   {fprintf(yyout,"NEXT STATEMENT :for loop above \n");}     
    | DIM {fprintf(yyout,"declaration of array(s) : \n");} dim_list  
    | DEF FN  {fprintf(yyout,"\t function define with parameter begin: \n");} LEFT_BRAC id_list RIGHT_BRAC ASSIGN expr  {fprintf(yyout,"\t function define with parameter end \n");} 
    | DEF FN  {fprintf(yyout,"\t function define with parameter begin: \n");} LEFT_BRAC value RIGHT_BRAC ASSIGN expr  {fprintf(yyout,"\t function define with parameter end \n");}    
    | DEF  FN {fprintf(yyout,"\t function define without parameter begin \n");} ASSIGN expr   {fprintf(yyout,"\t function define without parameter end\n");}    
    | DATA      {fprintf(yyout, "\t data_statement begin \n");} data_val  {fprintf(yyout, "\t data_statement end \n");}
    | END       {fprintf(yyout,"end of program \n"); end = 1;}
    | STOP      {fprintf(yyout,"program execution stop \n");}
    ;

data_val:
    value COMMA data_val 
    | value
    ;
ids:
   ID_DOUBLE  {fprintf(yyout,"Datatype : double & variable_name = %s\n",$1);}
   | ID_INT   {fprintf(yyout,"Datatype : int & variable_name = %s\n",$1);}
   | ID_SINGLE  {fprintf(yyout,"Datatype : single & variable_name = %s\n",$1);}
   | ID_STRING  {fprintf(yyout,"Datatype : string & variable_name = %s\n",$1);}
   ;

id_list:
    ids
    | ids COMMA id_list 
    | dim_decl COMMA id_list
    | dim_decl
    ;

print_list:
    | expr 
    | expr SEMI print_list
    | expr COMMA print_list
    ;

dim_list:
    dim_decl 
    | dim_decl {fprintf(yyout,"Multiple array declare\n");} COMMA dim_list 
    ;

dim_decl:
     ARRAY  INT_VALUE RIGHT_BRAC  {fprintf(yyout,"1D Array\n");}
    | ARRAY ID_INT RIGHT_BRAC    {fprintf(yyout,"1D Array\n");}
    | ARRAY expr RIGHT_BRAC
    | ARRAY ID_INT COMMA ID_INT RIGHT_BRAC {fprintf(yyout,"2D Array\n");}
    | ARRAY ID_INT COMMA INT_VALUE RIGHT_BRAC  {fprintf(yyout,"2D Array\n");}
    | ARRAY INT_VALUE COMMA ID_INT RIGHT_BRAC   {fprintf(yyout,"2D Array\n");}
    | ARRAY INT_VALUE COMMA INT_VALUE RIGHT_BRAC  {fprintf(yyout,"2D Array\n");}
    ;

step_clause:
    STEP expr
    ;

value: INT_VALUE   {fprintf(yyout,"integer_value = %d \n",$1);}
    | STR_VALUE     {fprintf(yyout,"string_value = %s \n",$1);}
    | SINGLE_VALUE  {fprintf(yyout,"single_value = %f \n",$1);}
    | DOUBLE_VALUE  {fprintf(yyout,"double_value = %f \n",$1);}
    ;

relational: GREATER_THAN  {fprintf(yyout,"Operator : greater_than \n");}
    | LESS_THAN           {fprintf(yyout,"Operator : less_than \n");}
    | LESS_THAN_EQUAL       {fprintf(yyout,"Operator : less_than_equal \n");}
    | GREATER_THAN_EQUAL    {fprintf(yyout,"Operator : greater_than_equal \n");}
    | COMPARE_NOT_EQUAL     {fprintf(yyout,"Operator : not_equal \n");}
    | ASSIGN                {fprintf(yyout,"Operator : compare_equal \n");}

logical :LOGICAL_AND   {fprintf(yyout,"Operator : logical_and \n");}
    | LOGICAL_OR         {fprintf(yyout,"Operator : logical_or \n");}
    | LOGICAL_XOR        {fprintf(yyout,"Operator : logical_xor \n");}
    ;
 
expr: expr ADD term 
    | expr SUB term 
    | term             
    ;
term: term MUL factor1 
    | term DIV factor1 
    | factor1
    ;

factor1 : 
    SUB factor1
    | factor2 
    ;

factor2 : factor2 EXPO factor 
    | factor
    ;

factor: ids 
    | FN LEFT_BRAC value RIGHT_BRAC
    | FN LEFT_BRAC id_list RIGHT_BRAC
    | FN 
    | LEFT_BRAC expr RIGHT_BRAC 
    | value 
    | dim_decl
    ;

mixed_expr : expr relational expr 
    | bool_expr 
    ;

bool_expr: mixed_expr logical mixed_expr 
    |  LOGICAL_NOT mixed_expr 
    ;

%%
int i =0;
int main()
{
   // yyin=fopen("IncorrectSample.bmm","r");
    yyin=fopen("CorrectSample.bmm","r");
    lexout=fopen("lex.txt","w");
    yyout = fopen("parseout.txt","w");
    yyparse();
    yylex();
    if(i == 0 && end == 1){
        printf("No syntax error");
    }
    else if (i ==0 && end == 0){
        printf("Syntax Error : No program termination");
    }
    return 0;
}

void yyerror(char const *s){
    i = 1;
    printf("Syntax Error\n");
}