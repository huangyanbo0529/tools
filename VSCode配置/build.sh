#!/bin/bash

# 确保脚本在遇到错误时退出
set -e

# 获取脚本所在目录（假设脚本放在 ROS2 工作空间根目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 判断参数并执行构建
if [ $# -eq 0 ] || [ "$1" = "all" ]; then
    echo "开始构建所有功能包..."
    colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON --symlink-install
else
    echo "开始构建指定功能包：$@"
    colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON --symlink-install --packages-select "$@"
fi

echo "构建完成！记得 source install/setup.bash 以更新环境。"
echo  "生成编译数据库文件: ./build/compile_commands.json"
