#include <gtest/gtest.h>
#include "Main.hpp"

class MainTest:
    public testing::Test
{
protected:

};

TEST_F(MainTest, test)
{
    testing::internal::CaptureStdout();
    Main({"some", "arguments"});
    string output = testing::internal::GetCapturedStdout();

    ASSERT_EQ(output, "some arguments ");
}
