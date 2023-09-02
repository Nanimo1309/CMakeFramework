cmake_minimum_required(VERSION 3.21.0 FATAL_ERROR)

project(ProjectName)

include(FetchContent)
FetchContent_Declare(CMakeFramework GIT_REPOSITORY https://github.com/Nanimo1309/CMakeFramework GIT_TAG main)
FetchContent_MakeAvailable(CMakeFramework)

add_subdirectory(Headers)
add_subdirectory(MainModule)
add_subdirectory(Module)
