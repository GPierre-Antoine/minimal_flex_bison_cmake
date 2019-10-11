%{
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <iostream>
#include <stdexcept>

int yylex();
void yyerror (char const *s)
{
    throw std::runtime_error(s);
}

%}

%token END ERROR
%token NUMBER
%token ADD SUBSTRACT MULTIPLY DIVIDE POWK ABSOLUTE BINARY_AND OPEN_P CLOSE_P
%token EOL

%%

calculation: /* empty */
 | calculation END {  YYACCEPT; }
 | calculation EOL	{ std::cout << "EOL" << std::endl; }
 | calculation addition EOL { std::cout << "=" << $2 << std::endl; }
;

addition: factor
 | addition ADD factor        { $$ = $1 + $3; }
 | addition SUBSTRACT factor  { $$ = $1 - $3; }
 | addition ABSOLUTE factor   { $$ = $1 | $3; }
 | addition BINARY_AND factor { $$ = $1 & $3; }
;

factor: power
 | factor MULTIPLY power   { $$ = $1 * $3; }
 | factor DIVIDE power     { $$ = $1 / $3; }
;

power: terminal
 | terminal POWK terminal   { $$=pow($1, $3); }


terminal: NUMBER
 | ABSOLUTE NUMBER            { $$ = $2 > 0 ? $2 : -$2; }
 | OPEN_P addition CLOSE_P    { $$ = $2; }
;

%%

