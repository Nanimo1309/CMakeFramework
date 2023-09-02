#pragma once

#include <Headers/cout.hpp>

#include "User.hpp"

class Display
{
public:
    Display(string prefix);
    void print(User& user);

private:
    string _prefix;
};
