# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build

# Include any dependencies generated for this target.
include CMakeFiles/read_write.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/read_write.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/read_write.dir/flags.make

CMakeFiles/read_write.dir/src/k_Read_Write.cpp.o: CMakeFiles/read_write.dir/flags.make
CMakeFiles/read_write.dir/src/k_Read_Write.cpp.o: ../src/k_Read_Write.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/read_write.dir/src/k_Read_Write.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/read_write.dir/src/k_Read_Write.cpp.o -c /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/src/k_Read_Write.cpp

CMakeFiles/read_write.dir/src/k_Read_Write.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/read_write.dir/src/k_Read_Write.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/src/k_Read_Write.cpp > CMakeFiles/read_write.dir/src/k_Read_Write.cpp.i

CMakeFiles/read_write.dir/src/k_Read_Write.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/read_write.dir/src/k_Read_Write.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/src/k_Read_Write.cpp -o CMakeFiles/read_write.dir/src/k_Read_Write.cpp.s

# Object files for target read_write
read_write_OBJECTS = \
"CMakeFiles/read_write.dir/src/k_Read_Write.cpp.o"

# External object files for target read_write
read_write_EXTERNAL_OBJECTS =

read_write: CMakeFiles/read_write.dir/src/k_Read_Write.cpp.o
read_write: CMakeFiles/read_write.dir/build.make
read_write: libdynamixel_workbench.a
read_write: /usr/local/lib/libdxl_sbc_cpp.so
read_write: CMakeFiles/read_write.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable read_write"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/read_write.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/read_write.dir/build: read_write

.PHONY : CMakeFiles/read_write.dir/build

CMakeFiles/read_write.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/read_write.dir/cmake_clean.cmake
.PHONY : CMakeFiles/read_write.dir/clean

CMakeFiles/read_write.dir/depend:
	cd /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build /home/pi/dynamixel/dynamixel-workbench/dynamixel_workbench_toolbox/examples/build/CMakeFiles/read_write.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/read_write.dir/depend

