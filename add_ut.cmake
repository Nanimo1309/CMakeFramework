function(add_ut)
    cmake_parse_arguments("" "" "" "SOURCE;DEPEND" ${ARGN})

    add_executable("${MODULE_NAME}_UT" ${_SOURCE})
    target_link_libraries("${MODULE_NAME}_UT" PRIVATE GTest::gtest_main "${MODULE_NAME}" "${${MODULE_NAME}_DEPEND}" ${_DEPEND})

    include(GoogleTest)
    gtest_discover_tests("${MODULE_NAME}_UT")

    target_include_directories("${MODULE_NAME}_UT" PRIVATE "${module_include}" "${module_src}")
endfunction()