#include <chrono>
#include <string>
#include <thread>
#include <vector>

#include "logger.h"


Logger logger;

// 线程函数
void thread_task(const std::string& thread_name)
{
    for (int i = 0; i < 5; i++)
    {
        std::string log_msg = thread_name + ": message " + std::to_string(i);
        logger.log(log_msg);

        std::this_thread::sleep_for(std::chrono::milliseconds(30));
    }
}

int main(int argc, char* argv[])
{
    std::vector<std::thread> threads;

    threads.emplace_back(thread_task, "Thread A");
    threads.emplace_back(thread_task, "Thread B");
    threads.emplace_back(thread_task, "Thread C");

    for (auto& t: threads)
    {
        if (t.joinable())
        {
            t.join();
        }
    }

    std::this_thread::sleep_for(std::chrono::seconds(1));
    std::cout << "所有日志输出完成！" << std::endl;

    return 0;
}