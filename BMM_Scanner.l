%{

#include <stdio.h>
#include <string.h>
#include <math.h>
#include "BMM_Parser.tab.h" //from yacc file
FILE *lexout;
void yyerror(char const *);
%}

%%
^[0-9]{1,3}                   {fprintf (lexout,"LINE_NUMBER : %s\n",yytext);yylval.line = atoi(yytext); return LINE_NUMBER;}
"REM"(.)*\n                               {fprintf (lexout,"COMMENT_CONTENT:%s \n",yytext); return REM;}
"LET"                               {fprintf (lexout,"LET : initialize variable\n"); return LET;}
([A-Z][0-9]?\$)                       {fprintf (lexout,"ID_STRING : %s\n",yytext); yylval.id=strdup(yytext); return ID_STRING;}
([A-Z][0-9]?\#)                      {fprintf (lexout,"ID_DOUBLE : %s\n",yytext); yylval.id=strdup(yytext);  return ID_DOUBLE;}  //Double
([A-Z][0-9]?[\%]?)                         {fprintf (lexout,"ID_INT: %s\n",yytext); yylval.id=strdup(yytext);  return ID_INT;}
([A-Z][0-9]?\!)                       {fprintf (lexout,"ID_SINGLE : %s\n",yytext); yylval.id=strdup(yytext);  return ID_SINGLE;} // float
([0-9]+)                           {yylval.integer=atoi(yytext); fprintf (lexout,"INT_VALUE : %s\n",yytext) ; return INT_VALUE;}
(\"(.)*\")                    {yylval.str=strdup(yytext);fprintf (lexout,"STR_VALUE : %s\n",yytext ); return STR_VALUE;}
([0-9]+\.[0-9]{1,7})                  {fprintf (lexout,"SINGLE_VALUE : %f\n", yylval.Single=atof(yytext)); return SINGLE_VALUE;}
([0-9]+\.[0-9]{8,16})                  {fprintf (lexout,"DOUBLE_VALUE : %d\n", yylval.Double=atof(yytext)); return DOUBLE_VALUE;}
"="                                  {fprintf (lexout,"ASSIGN : =\n"); return ASSIGN;}
"+"                                  {fprintf (lexout,"PLUS : +\n"); return ADD;}
"-"                                  {fprintf (lexout,"MINUS : -\n"); return SUB;}
"/"                                  {fprintf (lexout,"DIV : /\n"); return DIV;}
"*"                                  {fprintf (lexout,"MUL : *\n"); return MUL;}
"^"                                 {fprintf (lexout,"EXPONENTIAL : **\n"); return EXPO;}
[\(]                                {fprintf (lexout,"LEFT_BRAC : (\n"); return LEFT_BRAC;}
[\)]                                {fprintf (lexout,"RIGHT_BRAC : )\n"); return RIGHT_BRAC;}
">"                                 {fprintf (lexout,"GREATER_THAN : >\n"); return GREATER_THAN;}
"<"                                 {fprintf (lexout,"LESS_THAN : <\n"); return LESS_THAN;}
"<="                                {fprintf (lexout,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL;}
">="                                {fprintf (lexout,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL;}
"<>"                                {fprintf (lexout,"COMPARE_NOT_EQUAL : !=\n"); return COMPARE_NOT_EQUAL;}
"NOT"                                {fprintf (lexout,"LOGICAL_NOT : NOT\n"); return LOGICAL_NOT;}
"AND"                                {fprintf (lexout,"LOGICAL_AND : AND\n"); return LOGICAL_AND;}
"OR"                                {fprintf (lexout,"LOGICAL_OR : OR\n"); return LOGICAL_OR;}
"XOR"                                {fprintf (lexout,"LOGICAL_XOR : XOR\n"); return LOGICAL_XOR;}
(DEF[\s]+FN[A-Z])                   {fprintf (lexout,"FUNCTION : function declaration\n"); return FUNCTION;}
"IF"                                 { fprintf (lexout,"IF : IF\n");return IF; }
"THEN"                               { fprintf (lexout,"THEN : THEN\n");return THEN; }
"FOR"                                { fprintf (lexout,"FOR : FOR\n");return FOR; }
"TO"                                 { fprintf (lexout,"TO : TO\n");return TO; }
"STEP"                               {fprintf (lexout,"STEP : STEP\n"); return STEP; }
"NEXT"                               {fprintf (lexout,"NEXT : NEXT\n"); return NEXT; }
"GOTO"                               {fprintf (lexout,"GOTO : GOTO\n"); return GOTO; }
"GOSUB"                              {fprintf (lexout,"GOSUB : GOSUB\n"); return GOSUB; }
"RETURN"                             { fprintf (lexout,"RETURN : RETURN\n");return RETURN; }
"END"                                { fprintf (lexout,"END : END\n");return END; }
"DATA"                               { fprintf (lexout,"DATA : DATA\n");return DATA; }
"DEF"                                { fprintf (lexout,"DEF : DEF\n");return DEF; }
"DIM"                                { fprintf (lexout,"DIM : DIM\n");return DIM; }
"INPUT"                               { fprintf (lexout,"INPUT : INPUT\n");return INPUT; }
"STOP"                                { fprintf (lexout,"STOP : STOP\n");return STOP; }
"PRINT"                                 { fprintf (lexout,"PRINT : PRINT\n");return PRINT; }
[A-Z][\(]                            {fprintf (lexout,"ARRAY : ARRAY\n"); return ARRAY;}
","                                    {fprintf (lexout,"COMMA : COMMA\n"); return COMMA;}
";"                                    {fprintf (lexout,"SEMI_COLON : SEMI\n"); return SEMI;}
FN[A-Z]{1}                                 {fprintf (lexout,"FUNCTION : FN\n"); return FN;}
\n                                   ;
[\s]+                                ;
%%

int yywrap(){
    return 1;
}