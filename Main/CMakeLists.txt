create_module(
    SOURCE
        Main.cpp
    DEPEND
        PUBLIC
            Common
)

add_executable(${PROJECT_NAME} src/main.cpp)
target_link_libraries(${PROJECT_NAME} Main)