# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/levi/mjpg-streamer-master/mjpg-streamer-experimental

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/levi/mjpg-streamer-master/mjpg-streamer-experimental

# Include any dependencies generated for this target.
include plugins/output_udp/CMakeFiles/output_udp.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include plugins/output_udp/CMakeFiles/output_udp.dir/compiler_depend.make

# Include the progress variables for this target.
include plugins/output_udp/CMakeFiles/output_udp.dir/progress.make

# Include the compile flags for this target's objects.
include plugins/output_udp/CMakeFiles/output_udp.dir/flags.make

plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.o: plugins/output_udp/CMakeFiles/output_udp.dir/flags.make
plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.o: plugins/output_udp/output_udp.c
plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.o: plugins/output_udp/CMakeFiles/output_udp.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.o"
	cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.o -MF CMakeFiles/output_udp.dir/output_udp.c.o.d -o CMakeFiles/output_udp.dir/output_udp.c.o -c /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp/output_udp.c

plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/output_udp.dir/output_udp.c.i"
	cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp/output_udp.c > CMakeFiles/output_udp.dir/output_udp.c.i

plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/output_udp.dir/output_udp.c.s"
	cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp/output_udp.c -o CMakeFiles/output_udp.dir/output_udp.c.s

# Object files for target output_udp
output_udp_OBJECTS = \
"CMakeFiles/output_udp.dir/output_udp.c.o"

# External object files for target output_udp
output_udp_EXTERNAL_OBJECTS =

plugins/output_udp/output_udp.so: plugins/output_udp/CMakeFiles/output_udp.dir/output_udp.c.o
plugins/output_udp/output_udp.so: plugins/output_udp/CMakeFiles/output_udp.dir/build.make
plugins/output_udp/output_udp.so: plugins/output_udp/CMakeFiles/output_udp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/levi/mjpg-streamer-master/mjpg-streamer-experimental/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C shared library output_udp.so"
	cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/output_udp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
plugins/output_udp/CMakeFiles/output_udp.dir/build: plugins/output_udp/output_udp.so
.PHONY : plugins/output_udp/CMakeFiles/output_udp.dir/build

plugins/output_udp/CMakeFiles/output_udp.dir/clean:
	cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp && $(CMAKE_COMMAND) -P CMakeFiles/output_udp.dir/cmake_clean.cmake
.PHONY : plugins/output_udp/CMakeFiles/output_udp.dir/clean

plugins/output_udp/CMakeFiles/output_udp.dir/depend:
	cd /home/levi/mjpg-streamer-master/mjpg-streamer-experimental && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/levi/mjpg-streamer-master/mjpg-streamer-experimental /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp /home/levi/mjpg-streamer-master/mjpg-streamer-experimental /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp /home/levi/mjpg-streamer-master/mjpg-streamer-experimental/plugins/output_udp/CMakeFiles/output_udp.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : plugins/output_udp/CMakeFiles/output_udp.dir/depend

