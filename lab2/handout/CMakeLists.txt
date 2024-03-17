cmake_minimum_required(VERSION 3.23.2)
project(handout)

set(CMAKE_CXX_STANDARD 14)

include_directories(cool-support/include)
include_directories(src)
include_directories(src_llvm)

add_executable(handout
        cool-support/include/ast_parse.h
        cool-support/include/cool_tree.h
        cool-support/include/copyright.h
        cool-support/include/stringtab.h
        cool-support/include/symtab.h
        cool-support/include/tree.h
        cool-support/include/utils.h
        cool-support/src/ast_lex.cc
        cool-support/src/ast_parse.cc
        cool-support/src/cgen_main.cc
        cool-support/src/cool_tree.cc
        cool-support/src/dumptype.cc
        cool-support/src/stringtab.cc
        cool-support/src/tree.cc
        cool-support/src/utils.cc
        src/cgen.cc
        src/cgen.h
        src/cool_tree.handcode.h
        src/coolrt.cc
        src/coolrt.h
        src/operand.cc
        src/operand.h
        src/stringtab.handcode.h
        src/value_printer.cc
        src/value_printer.h
        src_llvm/cgen.cc
        src_llvm/cgen.h
        src_llvm/cool_tree.handcode.h
        src_llvm/stringtab.handcode.h)
