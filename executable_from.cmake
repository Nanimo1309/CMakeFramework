function(executable_from)
    file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/null.cpp")
    add_executable(${PROJECT_NAME} "${CMAKE_CURRENT_BINARY_DIR}/null.cpp")
    target_link_libraries(${PROJECT_NAME} PRIVATE "" ${ARGV})
    set_target_properties(${PROJECT_NAME} PROPERTIES RUTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
endfunction()
