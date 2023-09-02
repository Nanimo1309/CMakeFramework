#pragma once

#include <Headers/string.hpp>

class User
{
public:
    User(string name);
    string_view getName();

private:
    string _name;
};
