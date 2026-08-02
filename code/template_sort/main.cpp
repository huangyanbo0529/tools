#include <iostream>
#include <vector>

#include "sorter.h"

int main(int argc, char* argv[])
{
    // 测试 int 类型
    std::cout << "===== int 排序测试 =====" << std::endl;
    std::vector<int> nums = { 4, 5, 1, 6, 2, 9, 8 };
    bubble_sort(nums);
    print_vector(nums);

    // 测试 string 字符串
    std::cout << "===== string 排序测试 =====" << std::endl;
    std::vector<std::string> strs = { "banana", "apple", "pear", "orange" };
    bubble_sort(strs);
    print_vector(strs);
    std::cout << std::endl;

    // 测试 Point自定义类型
    std::cout << "===== Point 排序测试 =====" << std::endl;
    std::vector<Point> pts = { { 3, 1 }, { 1, 2 }, { 2, 3 } };
    bubble_sort(pts);
    print_vector(pts);
    return 0;
}