include(FetchContent)

FetchContent_Declare(
    GTest
    GIT_REPOSITORY https://github.com/google/googletest
    GIT_TAG origin/main
    GIT_SHALLOW TRUE
)

set_target_properties(GTest PROPERTIES INSTALL_GTEST NO)

FetchContent_MakeAvailable(GTest)
