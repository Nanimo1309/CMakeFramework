#include "User.hpp"

User::User(string name):
    _name(name)
{}

string_view User::getName()
{
    return _name;
}
