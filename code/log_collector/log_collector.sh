#!/bin/bash

# 智能日志自动化收集器 ROS2日志归档脚本
# 需求：收集$HOME/.ros/log最近1小时.log日志，打包归档

# 1. 定义基础路径与时间戳
SRC_LOG_PATH="$HOME/.ros/log"
TIME_STAMP=$(date +%Y%m%d_%H%M)
TARGET_BASE="$HOME/ros_logs_archive"
TARGET_DIR="${TARGET_BASE}/${TIME_STAMP}"
TAR_FILE="${TARGET_BASE}/ros_logs_${TIME_STAMP}.tar.gz"

# 2. 创建目标存放目录
mkdir -p "${TARGET_DIR}" 2>/dev/null

# 3. 查找最近1小时内修改的.log文件，错误输出屏蔽
FOUND_FILES=$(find "${SRC_LOG_PATH}" -type f -name "*.log" -newermt "1 hour ago" 2>/dev/null)

# 4. 判断是否找到日志文件，无文件直接退出
if [ -z "${FOUND_FILES}" ]; then
    echo "未找到最近1小时内的ROS2日志文件，程序退出，不生成压缩包"
    rmdir "${TARGET_DIR}" 2>/dev/null  # 删除空目录
    exit 0
fi

# 5. 将找到的日志复制到时间命名目录
find "${SRC_LOG_PATH}" -type f -name "*.log" -newermt "1 hour ago" -exec cp {} "${TARGET_DIR}" \; 2>/dev/null

# 6. 使用tar -czf 打包压缩
tar -czf "${TAR_FILE}" -C "${HOME}" "ros_logs_archive/${TIME_STAMP}" 2>/dev/null

# 7. 可选：删除临时目录
rm -rf "${TARGET_DIR}"

echo "日志收集完成！归档文件：${TAR_FILE}"