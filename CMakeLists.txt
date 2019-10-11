cmake_minimum_required(VERSION 3.14)
project(CMakeFlexBison)

set(CMAKE_CXX_STANDARD 17)

find_package(BISON)
find_package(FLEX)


BISON_TARGET(parser ${CMAKE_CURRENT_SOURCE_DIR}/parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp)
FLEX_TARGET(scanner ${CMAKE_CURRENT_SOURCE_DIR}/lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp)
ADD_FLEX_BISON_DEPENDENCY(scanner parser)

#add_definitions(-DLLDEBUG)

include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_executable(a.out
        main.cpp
        ${BISON_parser_OUTPUTS}
        ${FLEX_scanner_OUTPUTS}
)

target_link_libraries(a.out fl)