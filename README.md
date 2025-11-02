# CMakeFramework

Framework consists of only two functions for creating projects with C/C++

#### create_module( [ SOURCE <files> ] [ DEPS <modules and libs> ] [ SHARED | EXE ] )
  
    Create module (library)
    Name of the module is the name of the directory (you can get it by ${module_name})
    Every dependences are added as private
    If tests dir exists adds it
    If EXE option is specified executable with module_name is added
    
#### add_ut( SOURCE <files> [ DEPS <additional modules and libs> ] )

    Create google tests
    Links gtest_main, module, module dopendencies and DEPS (in this order)

## Add to main CMakeLists.txt
```cmake
include(FetchContent)
FetchContent_Declare(CMakeFramework GIT_REPOSITORY https://github.com/Nanimo1309/CMakeFramework GIT_TAG main GIT_SHALLOW true)
FetchContent_MakeAvailable(CMakeFramework)
```

### Including headers
To add header from other module you must also specify its name
```cpp
#include <Module/Header.hpp>
```

## Sample project structure
    ├── CMakeLists.txt // <CMakeFramework fetch> add_submodule(Headers) add_submodule(Module) add_submodule(MainModule)
    ├── Headers
    |   ├── CMakeLists.txt // create_module()
    |   └── include
    |       ├── cout.hpp
    |       ├── string.hpp
    |       └── vector.hpp
    ├── Module
    |   ├── CMakeLists.txt // create_module(SOURCE Display.cpp User.cpp DEPS Headers)
    |   ├── include
    |   |   ├── Display.hpp
    |   |   └── User.hpp
    |   └── src
    |       ├── Display.cpp
    |       └── User.cpp
    └── MainModule
        ├── CMakeLists.txt // create_module(SOURCE MainClass.cpp DEPS Headers Module)
        ├── include
        |   └── MainClass.hpp
        ├── src
        |   └── MainClass.cpp
        └── tests
            ├── CMakeLists.txt // add_ut(SOURCE mainClassTests.cpp)
            └── MainClassTests.cpp
