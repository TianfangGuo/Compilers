# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.23

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /cygdrive/c/Users/taylo/AppData/Local/JetBrains/CLion2022.2/cygwin_cmake/bin/cmake.exe

# The command to remove a file.
RM = /cygdrive/c/Users/taylo/AppData/Local/JetBrains/CLion2022.2/cygwin_cmake/bin/cmake.exe -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/handout.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/handout.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/handout.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/handout.dir/flags.make

CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o: ../cool-support/src/ast_lex.cc
CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o -MF CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/ast_lex.cc

CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/ast_lex.cc > CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.i

CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/ast_lex.cc -o CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.s

CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o: ../cool-support/src/ast_parse.cc
CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o -MF CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/ast_parse.cc

CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/ast_parse.cc > CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.i

CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/ast_parse.cc -o CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.s

CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o: ../cool-support/src/cgen_main.cc
CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o -MF CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/cgen_main.cc

CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/cgen_main.cc > CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.i

CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/cgen_main.cc -o CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.s

CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o: ../cool-support/src/cool_tree.cc
CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o -MF CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/cool_tree.cc

CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/cool_tree.cc > CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.i

CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/cool_tree.cc -o CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.s

CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o: ../cool-support/src/dumptype.cc
CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o -MF CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/dumptype.cc

CMakeFiles/handout.dir/cool-support/src/dumptype.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/dumptype.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/dumptype.cc > CMakeFiles/handout.dir/cool-support/src/dumptype.cc.i

CMakeFiles/handout.dir/cool-support/src/dumptype.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/dumptype.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/dumptype.cc -o CMakeFiles/handout.dir/cool-support/src/dumptype.cc.s

CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o: ../cool-support/src/stringtab.cc
CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o -MF CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/stringtab.cc

CMakeFiles/handout.dir/cool-support/src/stringtab.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/stringtab.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/stringtab.cc > CMakeFiles/handout.dir/cool-support/src/stringtab.cc.i

CMakeFiles/handout.dir/cool-support/src/stringtab.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/stringtab.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/stringtab.cc -o CMakeFiles/handout.dir/cool-support/src/stringtab.cc.s

CMakeFiles/handout.dir/cool-support/src/tree.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/tree.cc.o: ../cool-support/src/tree.cc
CMakeFiles/handout.dir/cool-support/src/tree.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/handout.dir/cool-support/src/tree.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/tree.cc.o -MF CMakeFiles/handout.dir/cool-support/src/tree.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/tree.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/tree.cc

CMakeFiles/handout.dir/cool-support/src/tree.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/tree.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/tree.cc > CMakeFiles/handout.dir/cool-support/src/tree.cc.i

CMakeFiles/handout.dir/cool-support/src/tree.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/tree.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/tree.cc -o CMakeFiles/handout.dir/cool-support/src/tree.cc.s

CMakeFiles/handout.dir/cool-support/src/utils.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/cool-support/src/utils.cc.o: ../cool-support/src/utils.cc
CMakeFiles/handout.dir/cool-support/src/utils.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/handout.dir/cool-support/src/utils.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/cool-support/src/utils.cc.o -MF CMakeFiles/handout.dir/cool-support/src/utils.cc.o.d -o CMakeFiles/handout.dir/cool-support/src/utils.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/utils.cc

CMakeFiles/handout.dir/cool-support/src/utils.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/cool-support/src/utils.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/utils.cc > CMakeFiles/handout.dir/cool-support/src/utils.cc.i

CMakeFiles/handout.dir/cool-support/src/utils.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/cool-support/src/utils.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cool-support/src/utils.cc -o CMakeFiles/handout.dir/cool-support/src/utils.cc.s

CMakeFiles/handout.dir/src/cgen.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/src/cgen.cc.o: ../src/cgen.cc
CMakeFiles/handout.dir/src/cgen.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/handout.dir/src/cgen.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/src/cgen.cc.o -MF CMakeFiles/handout.dir/src/cgen.cc.o.d -o CMakeFiles/handout.dir/src/cgen.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/cgen.cc

CMakeFiles/handout.dir/src/cgen.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/src/cgen.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/cgen.cc > CMakeFiles/handout.dir/src/cgen.cc.i

CMakeFiles/handout.dir/src/cgen.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/src/cgen.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/cgen.cc -o CMakeFiles/handout.dir/src/cgen.cc.s

CMakeFiles/handout.dir/src/coolrt.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/src/coolrt.cc.o: ../src/coolrt.cc
CMakeFiles/handout.dir/src/coolrt.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object CMakeFiles/handout.dir/src/coolrt.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/src/coolrt.cc.o -MF CMakeFiles/handout.dir/src/coolrt.cc.o.d -o CMakeFiles/handout.dir/src/coolrt.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/coolrt.cc

CMakeFiles/handout.dir/src/coolrt.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/src/coolrt.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/coolrt.cc > CMakeFiles/handout.dir/src/coolrt.cc.i

CMakeFiles/handout.dir/src/coolrt.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/src/coolrt.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/coolrt.cc -o CMakeFiles/handout.dir/src/coolrt.cc.s

CMakeFiles/handout.dir/src/operand.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/src/operand.cc.o: ../src/operand.cc
CMakeFiles/handout.dir/src/operand.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object CMakeFiles/handout.dir/src/operand.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/src/operand.cc.o -MF CMakeFiles/handout.dir/src/operand.cc.o.d -o CMakeFiles/handout.dir/src/operand.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/operand.cc

CMakeFiles/handout.dir/src/operand.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/src/operand.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/operand.cc > CMakeFiles/handout.dir/src/operand.cc.i

CMakeFiles/handout.dir/src/operand.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/src/operand.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/operand.cc -o CMakeFiles/handout.dir/src/operand.cc.s

CMakeFiles/handout.dir/src/value_printer.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/src/value_printer.cc.o: ../src/value_printer.cc
CMakeFiles/handout.dir/src/value_printer.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object CMakeFiles/handout.dir/src/value_printer.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/src/value_printer.cc.o -MF CMakeFiles/handout.dir/src/value_printer.cc.o.d -o CMakeFiles/handout.dir/src/value_printer.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/value_printer.cc

CMakeFiles/handout.dir/src/value_printer.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/src/value_printer.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/value_printer.cc > CMakeFiles/handout.dir/src/value_printer.cc.i

CMakeFiles/handout.dir/src/value_printer.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/src/value_printer.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src/value_printer.cc -o CMakeFiles/handout.dir/src/value_printer.cc.s

CMakeFiles/handout.dir/src_llvm/cgen.cc.o: CMakeFiles/handout.dir/flags.make
CMakeFiles/handout.dir/src_llvm/cgen.cc.o: ../src_llvm/cgen.cc
CMakeFiles/handout.dir/src_llvm/cgen.cc.o: CMakeFiles/handout.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Building CXX object CMakeFiles/handout.dir/src_llvm/cgen.cc.o"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/handout.dir/src_llvm/cgen.cc.o -MF CMakeFiles/handout.dir/src_llvm/cgen.cc.o.d -o CMakeFiles/handout.dir/src_llvm/cgen.cc.o -c /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src_llvm/cgen.cc

CMakeFiles/handout.dir/src_llvm/cgen.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/handout.dir/src_llvm/cgen.cc.i"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src_llvm/cgen.cc > CMakeFiles/handout.dir/src_llvm/cgen.cc.i

CMakeFiles/handout.dir/src_llvm/cgen.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/handout.dir/src_llvm/cgen.cc.s"
	/usr/bin/c++.exe $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/src_llvm/cgen.cc -o CMakeFiles/handout.dir/src_llvm/cgen.cc.s

# Object files for target handout
handout_OBJECTS = \
"CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/tree.cc.o" \
"CMakeFiles/handout.dir/cool-support/src/utils.cc.o" \
"CMakeFiles/handout.dir/src/cgen.cc.o" \
"CMakeFiles/handout.dir/src/coolrt.cc.o" \
"CMakeFiles/handout.dir/src/operand.cc.o" \
"CMakeFiles/handout.dir/src/value_printer.cc.o" \
"CMakeFiles/handout.dir/src_llvm/cgen.cc.o"

# External object files for target handout
handout_EXTERNAL_OBJECTS =

handout.exe: CMakeFiles/handout.dir/cool-support/src/ast_lex.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/ast_parse.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/cgen_main.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/cool_tree.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/dumptype.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/stringtab.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/tree.cc.o
handout.exe: CMakeFiles/handout.dir/cool-support/src/utils.cc.o
handout.exe: CMakeFiles/handout.dir/src/cgen.cc.o
handout.exe: CMakeFiles/handout.dir/src/coolrt.cc.o
handout.exe: CMakeFiles/handout.dir/src/operand.cc.o
handout.exe: CMakeFiles/handout.dir/src/value_printer.cc.o
handout.exe: CMakeFiles/handout.dir/src_llvm/cgen.cc.o
handout.exe: CMakeFiles/handout.dir/build.make
handout.exe: CMakeFiles/handout.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_14) "Linking CXX executable handout.exe"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/handout.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/handout.dir/build: handout.exe
.PHONY : CMakeFiles/handout.dir/build

CMakeFiles/handout.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/handout.dir/cmake_clean.cmake
.PHONY : CMakeFiles/handout.dir/clean

CMakeFiles/handout.dir/depend:
	cd /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug /cygdrive/c/Users/taylo/Documents/GitHub/Compilers/lab2/handout/cmake-build-debug/CMakeFiles/handout.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/handout.dir/depend

