# CMakeFramework

Framework consists of only two functions for creating projects with C/C++

#### create_module( [ SOURCE &ltfiles&gt ] [ DEPS &ltmodules and libs&gt ] [ SHARED | EXE ] )
  
    Create module (library)
    Name of the module is the name of the directory (you can get it by ${module_name})
    Every dependences are added as private
    If tests dir exists adds it
    If EXE option is specified executable with module_name is added
    
#### add_ut( SOURCE &ltfiles& [ DEPS &ltadditional modules and libs&gt ] )

    Create google tests
    Links gtest_main, module, module dopendencies and DEPS (in this order)

### Including headers
To add header from other module you must also specify its name
```cpp
#include <Module/Header.hpp>
```

## Project structure (Check sampleProject directory)
    ├── CMakeLists.txt
    ├── Headers
    |   ├── CMakeLists.txt
    |   └── include
    |       ├── cout.hpp
    |       ├── string.hpp
    |       └── vector.hpp
    ├── Module
    |   ├── CMakeLists.txt
    |   ├── include
    |   |   ├── Display.hpp
    |   |   └── User.hpp
    |   └── src
    |       ├── Display.cpp
    |       └── User.cpp
    └── MainModule
        ├── CMakeLists.txt
        ├── include
        |   └── MainClass.hpp
        ├── src
        |   └── MainClass.cpp
        └── tests
            ├── CMakeLists.txt
            └── MainClassTests.cpp
