#include <iostream>
#include <ratio>
#include <set>
#include <string>

using namespace std;

// 机器人结构体
struct RobotID {
    string name;
    int id;
};

// 去重 + 排序
struct RobotCompare {
    bool operator()(const RobotID& a, const RobotID& b) const
    {
        // 比较name
        if (a.name != b.name)
        {
            return a.name > b.name;
        }
        return false;
    }
};

// 机器人集合
set<RobotID, RobotCompare> robot_set;

// 添加机器人
void add_robot(const RobotID& robot)
{
    robot_set.insert(robot);
}

// 打印机器人
void print_robots()
{
    for (const auto& r: robot_set)
    {
        cout << r.name << " (ID:" << r.id << ")" << endl;
    }
}

int main(int agc, char* argv[])
{
    // 测试
    add_robot({ "turtle1", 1 });
    add_robot({ "turtle2", 2 });
    add_robot({ "turtle1", 1 });

    // 打印
    print_robots();

    return 0;
}