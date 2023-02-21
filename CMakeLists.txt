cmake_minimum_required(VERSION 3.21.3 FATAL_ERROR)

set(CMAKE_C_COMPILER "/usr/local/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/local/bin/clang++")

project(aoeu)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_TESTING "Build the testing tree." OFF)

add_compile_options(-fcolor-diagnostics -ferror-limit=10 -fmacro-backtrace-limit=3 -Werror -Wall -Wextra -Wpedantic)

enable_testing()

add_subdirectory(cmake)

# Modules
add_subdirectory(Main)
add_subdirectory(Common)
