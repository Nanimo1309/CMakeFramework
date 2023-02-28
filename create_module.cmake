function(create_module)
    cmake_parse_arguments("" "" "" "SOURCE;DEPEND" ${ARGN})

    get_filename_component(MODULE_NAME "${CMAKE_CURRENT_SOURCE_DIR}" NAME)

    set(module_interface "${CMAKE_CURRENT_BINARY_DIR}/module_interface")
    file(MAKE_DIRECTORY "${module_interface}")
    execute_process(COMMAND "${CMAKE_COMMAND}" -E create_symlink "${CMAKE_CURRENT_SOURCE_DIR}/include" "${module_interface}/${MODULE_NAME}")

    set(module_include "${CMAKE_CURRENT_SOURCE_DIR}/include")

    if(_SOURCE)
        set(module_src "${CMAKE_CURRENT_SOURCE_DIR}/src")

        list(TRANSFORM _SOURCE PREPEND "${module_src}/")

        add_library("${MODULE_NAME}" ${_SOURCE})
        target_include_directories("${MODULE_NAME}" INTERFACE "${module_interface}" PRIVATE "${module_include}" "${module_src}")
    else()
        add_library("${MODULE_NAME}" INTERFACE)
        target_include_directories("${MODULE_NAME}" INTERFACE "${module_interface}")
    endif()

    target_link_libraries("${MODULE_NAME}" ${_DEPEND})

    set("${MODULE_NAME}_DEPEND")

    if(BUILD_TESTING AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/tests")
        add_subdirectory(tests)
    endif()
endfunction()