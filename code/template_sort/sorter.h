#ifndef SORTER_H
#define SORTER_H

// point 结构体
#include <algorithm>
#include <cstddef>
#include <iostream>
#include <ostream>
#include <vector>
struct Point {
    int m_x;
    int m_y;
    Point(int x, int y): m_x(x), m_y(y) {}
};

// 重载 < 运算符
inline bool operator<(const Point& lhs, const Point& rhs)
{
    return lhs.m_x < rhs.m_x;
}

// 重载 << 运算符
inline std::ostream& operator<<(std::ostream& os, const Point& p)
{
    os << "(" << p.m_x << "," << p.m_y << ")";
    return os;
}

// 冒泡排序
template<typename T>
void bubble_sort(std::vector<T>& vec)
{
    int n = vec.size();
    for (int i = 0; i < n - 1; i++)
    {
        for (int j = 0; j < n - i - 1; j++)
        {
            if (vec[j + 1] < vec[j])
            {
                std::swap(vec[j], vec[j + 1]);
            }
        }
    }
}

// 自定义输出模板函数
template<typename T>
void print_vector(const std::vector<T>& vec)
{
    for (size_t i = 0; i < vec.size(); i++)
    {
        if (i > 0)
        {
            std::cout << ", ";
        }
        std::cout << vec[i];
    }
    std::cout << "\n";
}

#endif