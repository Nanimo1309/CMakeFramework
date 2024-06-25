#include <gtest/gtest.h>

#include "MainClass.hpp"

TEST(MainClassTest, test)
{
    MainClass m;
    m.addUser(User{"A"});
    m.addUser(User{"B"});

    testing::internal::CaptureStdout();

    m.printAll();

    ASSERT_EQ(testing::internal::GetCapturedStdout(), "User: A\nUser: B\n");
}
