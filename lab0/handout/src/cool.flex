/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include "cool_parse.h"
#include "utils.h"

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
extern FILE *fin; /* we read from this file */
#undef YY_INPUT
#define YY_INPUT(buf, result, max_size)                                        \
  if ((result = fread((char *)buf, sizeof(char), max_size, fin)) < 0)          \
    YY_FATAL_ERROR("read() in flex scanner failed");

extern int curr_lineno;
/*
 *  Add Your own definitions here
 */

%}

%option noyywrap

/*
 * Define names for regular expressions here.
 */

digit       [0-9]
char  		[0-9a-zA-Z_]
symbols 	[\+\-\*\/\=\<\.\~\,\;\:\(\)\@\{\}]
typeID		[A-Z]{char}*
objID		[a-z]{char}*

%%

 /*
  * Define regular expressions for the tokens of COOL here. Make sure, you
  * handle correctly special cases, like:
  *   - Nested comments
  *   - String constants: They use C like systax and can contain escape
  *     sequences. Escape sequence \c is accepted for all characters c. Except
  *     for \n \t \b \f, the result is c.
  *   - Keywords: They are case-insensitive except for the values true and
  *     false, which must begin with a lower-case letter.
  *   - Multiple-character operators (like <-): The scanner should produce a
  *     single token for every such operator.
  *   - Line counting: You should keep the global variable curr_lineno updated
  *     with the correct line number
  */
  
  /*integers*/================================================================
  {DIGIT}+ {
	cool_yy.symbol = yytext;
	inttable.add_string(yytext);
	return INT_CONST;
  }
  
  /*identifiers*/=============================================================
  {typeID} {
	cool_yy.symbol = yytext;
	inttable.add_string(yytext);
	return TYPEID;
  }
  {objID} {
	cool_yy.symbol = yytext;
	inttable.add_string(yytext);
	return OBJECTID;
  }
  
  /*self, SELF_TYPE*/=========================================================
  
  /*keywords*/================================================================
  t(?i:rue) {
	cool_yylval.boolean = true;
	return BOOL_CONST;
  }
  f(?i:alse) {
	cool_yylval.boolean = true;
	return BOOL_CONST;
  }
  (?i:class){
	return CLASS;
  }
  (?i:else){
	return ELSE;
  }
  (?i:fi){
	return FI;
  }
  (?i:if){
	return IF;
  }
  (?i:in){
	return IN;
  }
  (?i:inherits){
	return INHERITS;
  }
  (?i:isvoid){
	return ISVOID;
  }
  (?i:let){
	return LET;
  }
  (?i:loop){
	return LOOP;
  }
  (?i:pool){
	return POOL;
  }
  (?i:then){
	return THEN;
  }
  (?i:while){
	return WHILE;
  }
  (?i:case){
	return CASE;
  }
  (?i:esac){
	return ESAC;
  }
  (?i:new){
	return NEW;
  }
  (?i:not){
	return NOT;
  }
  (?i:of){
	return OF;
  }
  
  /*symbols*/=================================================================
  {symbol} {
	return yytext[0];
  }
  "<-" {
	return ASSIGN;
  }
  "<=" {
	return LE;
  }
  "=>" {
	return DARROW;
  }
  
  /*strings*/=================================================================
  
  
  /*comments*/================================================================
  
  
  

%%
