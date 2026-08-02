#ifndef LOGGER_H
#define LOGGER_H

#include <iostream>
#include <mutex>
#include <string>

class Logger
{
  public:
    // 打印日志
    void log(const std::string& msg)
    {
        // 上锁 -- 防止打印错乱
        m_mutex.lock();
        std::cout << "[LOG] " << msg << std::endl;
        // 去锁
        m_mutex.unlock();
    }


  private:
    std::mutex m_mutex;
};

#endif