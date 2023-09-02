include(FetchContent)

FetchContent_Declare(
    GTest
    GIT_REPOSITORY https://github.com/google/googletest
    GIT_TAG origin/main
    GIT_SHALLOW TRUE
)

set(INSTALL_GTEST OFF)

FetchContent_MakeAvailable(GTest)
