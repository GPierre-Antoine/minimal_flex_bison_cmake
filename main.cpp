#include <iostream>

#include "parser.hpp"


int main()
{
    try
    {
        yyparse();
    }
    catch (const std::runtime_error & e)
    {
        std::cerr << "Bison error : " << e.what() << std::endl;
    }
    return 0;
}
