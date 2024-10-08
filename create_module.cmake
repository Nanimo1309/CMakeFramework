function(create_module)
    cmake_parse_arguments("" "SHARED;EXE" "" "SOURCE;DEPS;" ${ARGN})

    get_filename_component(module_name "${CMAKE_CURRENT_SOURCE_DIR}" NAME)

    if(module_name MATCHES "[^A-Za-z0-9_]")
        message(FATAL_ERROR "Module folder name can only contain [A-Za-z0-9_]")
    endif()

    set(module_name "${module_name}" PARENT_SCOPE)

    if(module_parents)
        set(module_parents "${module_parents};${module_name}" PARENT_SCOPE)
        string(JOIN "_" module ${module_parents} "${module_name}")
        string(JOIN "::" module_alias ${module_parents} "${module_name}")
    else()
        set(module_parents "${module_name}" PARENT_SCOPE)
        set(module "${module_name}")
        set(module_alias "${module_name}")
    endif()

    set(module "${module}" PARENT_SCOPE)

    if(_SHARED AND _EXE)
        message(FATAL_ERROR "In ${module_alias} module both SHARED and EXE options given")
    elseif(_SHARED)
        set(module_linking "SHARED")
    else()
        set(module_linking "STATIC")
    endif()

    if(_UNPARSED_ARGUMENTS)
        message(SEND_ERROR "In ${module_alias} module unrecognized argument given: ${_UNPARSED_ARGUMENTS}")
    endif()

    if(_KEYWORDS_MISSING_VALUES)
        message(SEND_ERROR "In ${module_alias} module ${_KEYWORDS_MISSING_VALUES} given with no value")
    endif()

    set(module_include "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set(module_src "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set(module_tests "${CMAKE_CURRENT_SOURCE_DIR}/test")
    set(module_depend ${_DEPS})

    set(module_interface "${CMAKE_CURRENT_BINARY_DIR}/module_interface")

    if(IS_DIRECTORY "${module_include}")
        string(JOIN "/" module_interface_dir "${module_interface}" ${module_parents})
        file(MAKE_DIRECTORY "${module_interface_dir}")
        execute_process(COMMAND "${CMAKE_COMMAND}" -E create_symlink "${module_include}" "${module_interface_dir}/${module_name}")
    endif()

    if(_SOURCE)
        if(NOT IS_DIRECTORY "${module_src}")
            message(FATAL_ERROR "Source given in ${module_alias} module but there's no /src directory")
        endif()

        list(TRANSFORM _SOURCE PREPEND "${module_src}/")

        add_library(${module} ${module_linking} ${_SOURCE})

        if(module_parents)
            add_library(${module_alias} ALIAS ${module})
        endif()

        if(NOT IS_DIRECTORY "${module_include}" AND NOT _EXE)
            message(FATAL_ERROR "Source given in ${module_alias} module but there's no /include directory")
        endif()

        target_include_directories(${module} INTERFACE "${module_interface}" PRIVATE "${module_include}" "${module_src}")
        target_link_libraries(${module} PRIVATE ${module_depend})

        if(_EXE)
            file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/null.cpp")
            add_executable(${module}_EXE "${CMAKE_CURRENT_BINARY_DIR}/null.cpp")
            target_link_libraries(${module}_EXE PRIVATE ${module})
            set_target_properties(${module}_EXE PROPERTIES OUTPUT_NAME ${module_name})
        endif()
    else()
        if(_EXE)
            message(FATAL_ERROR "No sources given in ${module_alias} executve module")
        endif()

        add_library(${module} INTERFACE)

        if(module_parents)
            add_library(${module_alias} ALIAS ${module})
        endif()

        if(IS_DIRECTORY "${module_include}")
            target_include_directories(${module} INTERFACE "${module_interface}")
        endif()
    endif()

    if(BUILD_TESTING AND IS_DIRECTORY "${module_tests}")
        add_subdirectory("${module_tests}")
    endif()
endfunction()
