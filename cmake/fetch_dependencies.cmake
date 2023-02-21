include(FetchContent)

FetchContent_Declare(
    GTest
    GIT_REPOSITORY https://github.com/google/googletest
    GIT_TAG 58d77fa8070e8cec2dc1ed015d66b454c8d78850
    GIT_SHALLOW TRUE
)

set(INSTALL_GTEST OFF)

FetchContent_MakeAvailable(GTest)