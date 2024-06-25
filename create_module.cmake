function(create_module)
    cmake_parse_arguments("" "SHARED;EXE" "" "SOURCE;DEPS;" ${ARGN})

    get_filename_component(module_name "${CMAKE_CURRENT_SOURCE_DIR}" NAME)

    if(module_name MATCHES "[^A-Za-z0-9_]")
        message(FATAL_ERROR "Module folder name can only contain [A-Za-z0-9_]")
    endif()

    set(module_name ${module_name} PARENT_SCOPE)

    if(_SHARED AND _EXE)
        message(FATAL_ERROR "In ${module_name} module both SHARED and EXE options given")
    elseif(_SHARED)
        set(module_linking "SHARED")
    else()
        set(module_linking "STATIC")
    endif()

    if(_UNPARSED_ARGUMENTS)
        message(SEND_ERROR "In ${module_name} module unrecognized argument given: ${_UNPARSED_ARGUMENTS}")
    endif()

    if(_KEYWORDS_MISSING_VALUES)
        message(SEND_ERROR "In ${module_name} module ${_KEYWORDS_MISSING_VALUES} given with no value")
    endif()

    set(module_include "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set(module_interface "${CMAKE_CURRENT_BINARY_DIR}/module_interface")
    set(module_src "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set(module_tests "${CMAKE_CURRENT_SOURCE_DIR}/test")
    set(module_depend ${_DEPS})

    if(IS_DIRECTORY "${module_include}" AND NOT _EXE)
        file(MAKE_DIRECTORY "${module_interface}")
        execute_process(COMMAND "${CMAKE_COMMAND}" -E create_symlink "${module_include}" "${module_interface}/${module_name}")
    endif()

    if(_SOURCE)
        if(NOT IS_DIRECTORY "${module_src}")
            message(FATAL_ERROR "Source given in ${module_name} module but there's no /src directory")
        endif()

        list(TRANSFORM _SOURCE PREPEND "${module_src}/")

        add_library(${module_name} ${module_linking} ${_SOURCE})

        if(NOT IS_DIRECTORY "${module_include}" AND NOT _EXE)
            message(FATAL_ERROR "Source given in ${module_name} module but there's no /include directory")
        endif()

        target_include_directories(${module_name} INTERFACE "${module_interface}" PRIVATE "${module_include}" "${module_src}")
        target_link_libraries(${module_name} PRIVATE ${module_depend})
    else()
        if(_EXE)
            message(FATAL_ERROR "No sources given in ${module_name} executve module")
        endif()

        add_library(${module_name} INTERFACE)

        if(IS_DIRECTORY "${module_include}")
            target_include_directories(${module_name} INTERFACE "${module_interface}")
        endif()
    endif()

    if(_EXE)
        file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/null.cpp")
        add_executable(${module_name}_EXE "${CMAKE_CURRENT_BINARY_DIR}/null.cpp")
        target_link_libraries(${module_name}_EXE PRIVATE ${module_name})
        set_target_properties(${module_name}_EXE PROPERTIES OUTPUT_NAME ${module_name})
    endif()

    if(BUILD_TESTING AND IS_DIRECTORY "${module_tests}")
        add_subdirectory("${module_tests}")
    endif()
endfunction()
