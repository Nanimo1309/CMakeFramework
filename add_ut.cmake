function(add_ut)
    cmake_parse_arguments("" "" "" "SOURCE;DEPS" ${ARGN})

    if(_UNPARSED_ARGUMENTS)
        message(SEND_ERROR "In ${module_name}_UT module unrecognized argument given: ${_UNPARSED_ARGUMENTS}")
    endif()

    if(_KEYWORDS_MISSING_VALUES)
        message(SEND_ERROR "In ${module_name}_UT module ${_KEYWORDS_MISSING_VALUES} given with no value")
    endif()

    if(_SOURCE)
        add_executable(${module_name}_UT ${_SOURCE})
        target_link_libraries(${module_name}_UT PRIVATE GTest::gtest_main ${module_name} ${module_depend} ${_DEPS})

        include(GoogleTest)
        gtest_discover_tests(${module_name}_UT)

        target_include_directories(${module_name}_UT PRIVATE "${module_include}" "${module_src}")


        set(testfile_dir ${CMAKE_CURRENT_BINARY_DIR})
        file(WRITE ${testfile_dir}/CTestTestfile.cmake "include(\"${testfile_dir}/${module_name}_UT[1]_include.cmake\")\n")

        while(NOT ${PROJECT_BINARY_DIR} STREQUAL ${testfile_dir})
            get_filename_component(testfile_content ${testfile_dir} NAME)
            set(testfile_command "subdirs(\"${testfile_content}\")\n")

            get_filename_component(testfile_dir ${testfile_dir} DIRECTORY)

            set(testfile "${testfile_dir}/CTestTestfile.cmake")
            if(EXISTS "${testfile}")
                file(READ "${testfile}" testfile_current)

                string(FIND "${testfile_current}" "${testfile_command}" found)

                if(NOT ${found} EQUAL -1)
                    break()
                endif()
            endif()

            file(APPEND ${testfile} "${testfile_command}")
        endwhile()
    else()
        message(FATAL_ERROR "No sources provided in ${module_name} module")
    endif()
endfunction()
