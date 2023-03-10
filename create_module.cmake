function(create_module)
    cmake_parse_arguments("" "" "" "SOURCE;DEPEND" ${ARGN})

    get_filename_component(module_name "${CMAKE_CURRENT_SOURCE_DIR}" NAME)

    set(module_include "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set(module_interface "${CMAKE_CURRENT_BINARY_DIR}/module_interface")
    set(module_src "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set(module_tests "${CMAKE_CURRENT_SOURCE_DIR}/tests")
    set(module_depend ${_DEPEND})

    if(IS_DIRECTORY "${module_include}")
        file(MAKE_DIRECTORY "${module_interface}")
        execute_process(COMMAND "${CMAKE_COMMAND}" -E create_symlink "${module_include}" "${module_interface}/${module_name}")

        string(REPLACE " " "_" module_name ${module_name})
        
        if(_SOURCE)
            if(IS_DIRECTORY "${module_src}")
                list(TRANSFORM _SOURCE PREPEND "${module_src}/")

                add_library(${module_name} ${_SOURCE})
                target_include_directories(${module_name} INTERFACE "${module_interface}" PRIVATE "${module_include}" "${module_src}")
                target_link_libraries(${module_name} PRIVATE ${module_depend})
            else()
                message(SEND_ERROR "Sources given in ${module_name} module but there's no /src directory")
            endif()
        else()
            add_library(${module_name} INTERFACE)
            target_include_directories(${module_name} INTERFACE "${module_interface}")
            target_link_libraries(${module_name} PUBLIC ${module_depend})
        endif()
    else()
        string(REPLACE " " "_" module_name ${module_name})

        if(_SOURCE)
            message(SEND_ERROR "Sources given in ${module_name} module but there's no /include directory")
        endif()

        add_custom_target(${module_name})
        target_link_libraries(${module_name} PUBLIC ${module_depend})
    endif()

    if(BUILD_TESTING AND IS_DIRECTORY "${module_tests}")
        add_subdirectory(tests)
    endif()
endfunction()

