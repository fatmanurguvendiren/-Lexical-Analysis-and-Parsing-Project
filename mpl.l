
%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}
%option noyywrap
%%

"start"  {return START;}   /* programin baslangici ve bitisi */
"stop"   {return STOP;}
"if"     {return IF;}
"repeat" {return REPEAT;}
"do"     {return DO;}
"elsedo" {return ELSEDO;}
"endif"  {return ENDIF;}
"return" {return RETURN;}

"int"    { return INT_TYPE; }
"double" { return DOUBLE_TYPE; }
"char"   { return CHAR_TYPE; }

"and" {return AND;} /* logical operations */
"or"  {return OR;}
"not" {return NOT;}



[0-9]+      {
    
    return INTEGER;
}

\'.\'       {return CHARACTER;}

([_]?[a-zA-Z][A-Za-z0-9_]*) {
    
    return IDENTIFIER;
}

([0-9]+\.[0-9]+) {
    
    return DOUBLEVAL;
}


"+"   { return PLUS;} /* dort islem ve kullanacagim semboller */
"-"   { return MINUS;}
"/"   { return DIV;}
"="   { return EQUAL;}
"*"   { return STAR;}
"^^"  { return POW;}
"?"   { return QUESTION_MARK;} /* conditional stat if ?() >> do << else */
":"   { return COLON;}        /* int _ num: */
"_"   { return UNDERSCOR;}
"->"  {return OK;}
"<-"  {return LOOP_END;}
"("   {return LEFT_BRACKET;}
")"   {return RIGHT_BRACKET;}
"{"   {return SL_BRACKET;}
"}"   {return RL_BRACKET;}

">"   {return GREATER_THAN;} /* comparison operations */
"<"   {return LESS_THAN;}
"=="  {return EQUAL_EQUAL;}
"!="  {return NOT_EQUAL;}
">="  {return GREATER_EQUAL;}
"<="  {return LESS_EQUAL;}
("#".*) {return COMMENT;} /* comment line */

\n { /* ignore end of line */ }
[ \t]+ { /* ignore whitespace */ }

%%


