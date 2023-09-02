#pragma once

#include <Module/Display.hpp>
#include <Headers/vector.hpp>

class MainClass
{
public:
    MainClass();
    void addUser(User&& user);
    void printAll();

private:
    Display _display;
    vector<User> _users;
};

