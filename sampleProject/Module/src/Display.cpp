#include "Display.hpp"

Display::Display(string prefix):
    _prefix(prefix)
{}

void Display::print(User& user)
{
    cout << _prefix << user.getName() << '\n';
}
