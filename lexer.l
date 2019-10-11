%{
#include <iostream>
#include "parser.hpp"

#if defined(LLDEBUG)
    #define yield(expr) std::cout << #expr << std::endl; return expr
#else
    #define yield(expr) return expr
#endif

%}



%%

<<EOF>>         { yield(END);}
"__EOF__"       { yield(END);}

"+"             { yield(ADD); }
"-"             { yield(SUBSTRACT); }
"*"             { yield(MULTIPLY); }
"/"             { yield(DIVIDE); }
"|"             { yield(ABSOLUTE); }
"&"             { yield(BINARY_AND); }
"("             { yield(OPEN_P); }
")"             { yield(CLOSE_P); }
"^"             { yield(POWK); }

-?0x[0-9A-F]+   { yylval = strtol(yytext, NULL, 16); return NUMBER; }
-?0[0-8]+       { yylval = strtol(yytext, NULL, 8); return NUMBER; }
-?[0-9]+        { yylval = atoi(yytext); return NUMBER;}
"//".*|"\n"     { yield(EOL);}
[ \t]           ;
.               { yield(ERROR); };

%%
