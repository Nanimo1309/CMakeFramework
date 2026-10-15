option(BUILD_TESTING "Build tests" NO)

include(create_module.cmake)

if(BUILD_TESTING)
    include(fetch_gtest.cmake)
    include(add_ut.cmake)

    file(REMOVE_RECURSE "${PROJECT_BINARY_DIR}/*/CTestTestfile.cmake")
    file(REMOVE "${PROJECT_BINARY_DIR}/CTestTestfile.cmake")
endif()
