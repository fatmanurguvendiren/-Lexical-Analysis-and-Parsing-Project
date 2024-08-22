 %{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror()
{
	printf( "syntax error\n");
	exit(1);
}
%}
%token INTEGER IDENTIFIER DOUBLEVAL
%token INT_TYPE DOUBLE_TYPE CHAR_TYPE
%token PLUS MINUS DIV EQUAL STAR POW
%token QUESTION_MARK COLON UNDERSCOR
%token OK LOOP_END
%token AND OR NOT
%token GREATER_THAN LESS_THAN EQUAL_EQUAL NOT_EQUAL GREATER_EQUAL LESS_EQUAL
%token COMMENT START STOP LEFT_BRACKET RIGHT_BRACKET SL_BRACKET SR_BRACKET
%token REPEAT IF DO ELSEDO RETURN ENDIF CHARACTER RL_BRACKET

%%
program: START program_definition STOP;
program_definition: stmts | program_definition stmts;
stmts: stmt | stmt stmts;
//assigment atama(x=y+5)
//expression stmt bir degiskene atanmaz 3+5 gibi
// sadece a+5 gibi bir satirin olmasi saçma? o yüzden stmt kismindan expression_stmt kaldiriyorum.
stmt: conditional_stmt | loop_stmt | variable_declaration | assigment_stmt| return_stmt;
return_stmt: RETURN COLON | RETURN INTEGER COLON |RETURN IDENTIFIER COLON |RETURN DOUBLEVAL COLON |RETURN LEFT_BRACKET arithmetic_opr RIGHT_BRACKET COLON |;
assigment_stmt : IDENTIFIER EQUAL expression_stmt COLON ;
expression_stmt: INTEGER |DOUBLEVAL | IDENTIFIER|arithmetic_opr | comparison_opr | logical_opr | LEFT_BRACKET expression_stmt RIGHT_BRACKET;  //pow_opr COLON;
//dort islem
arithmetic_opr : arithmetic_opr PLUS mul_div| arithmetic_opr MINUS mul_div | mul_div;
mul_div : mul_div STAR base_expr | mul_div DIV base_expr | base_expr;
//kuvvet alma
//pow_opr: base_expr POW exponent_expr;

base_expr: INTEGER
         | IDENTIFIER | DOUBLEVAL
         | LEFT_BRACKET arithmetic_opr RIGHT_BRACKET;

//exponent_expr: INTEGER
             //| IDENTIFIER
             //| LEFT_BRACKET arithmetic_opr RIGHT_BRACKET;
//kuvvet alma bitti

logical_opr : expression_stmt AND expression_stmt| expression_stmt OR expression_stmt ;


comparison_opr : base_expr GREATER_THAN base_expr | base_expr LESS_THAN base_expr | base_expr EQUAL_EQUAL base_expr | base_expr NOT_EQUAL base_expr | base_expr LESS_EQUAL base_expr
| base_expr GREATER_EQUAL base_expr ;

variable_declaration: var_type OK IDENTIFIER COLON ;

var_type: INT_TYPE | DOUBLE_TYPE ; //|CHAR_TYPE

conditional_stmt: IF  LEFT_BRACKET conditions RIGHT_BRACKET DO  stmts ENDIF |  IF LEFT_BRACKET conditions RIGHT_BRACKET DO stmts  ELSEDO  stmts ENDIF;

conditions: logical_opr | comparison_opr | assigment_stmt;

loop_stmt: REPEAT IF LEFT_BRACKET conditions RIGHT_BRACKET stmts ;

%%
int main()
{
	yyparse();
	printf("OK!\n");
	return 0;
}


