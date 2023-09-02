#include "MainClass.hpp"

#include <memory>

MainClass::MainClass():
    _display("User: ")
{}

void MainClass::addUser(User&& user)
{
    _users.push_back(std::move(user));
}

void MainClass::printAll()
{
    for(auto& u : _users)
        _display.print(u);
}

