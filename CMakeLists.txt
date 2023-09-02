option(BUILD_TESTING "Build tests" NO)
option(CREATE_EXECUTABLE "Create default executable" YES)

include(fetch_gtest.cmake)
include(create_module.cmake)
include(add_ut.cmake)
include(create_executable.cmake)
