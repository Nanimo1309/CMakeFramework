#include "Main.hpp"

Main::Main(vector<string> args)
{
    for(auto& a : args)
        cout << a << ' ';

    cout << flush;
}
