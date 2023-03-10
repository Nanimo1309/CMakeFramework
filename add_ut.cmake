function(add_ut)
    cmake_parse_arguments("" "" "" "SOURCE;DEPEND" ${ARGN})

    add_executable(${module_name}_UT ${_SOURCE})
    target_link_libraries(${module_name}_UT PRIVATE GTest::gtest_main ${module_name} ${module_depend} ${_DEPEND})

    include(GoogleTest)
    gtest_discover_tests(${module_name}_UT)

    target_include_directories(${module_name}_UT PRIVATE "${module_include}" "${module_src}")
endfunction()

