#include "MainClass.hpp"

int main()
{
    MainClass m;
    m.addUser(User{"A"});
    m.addUser(User{"B"});
    m.printAll();

    return 0;
}
