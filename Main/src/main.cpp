#include <Main/Main.hpp>

int main(int argc, char** argv)
{
    vector<string> args;

    for(int i = 0; i < argc; ++i)
        args.push_back(argv[i]);

    Main(move(args));

    return 0;
}