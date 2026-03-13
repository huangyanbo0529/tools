#!/bin/bash

# 确保脚本在遇到错误时退出
set -e

# 获取脚本所在目录（假设脚本放在 ROS2 工作空间根目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# 判断参数并执行清理
if [ $# -eq 0 ] || [ "$1" = "all" ]; then
    echo "正在清理所有构建产物 (build/ install/ log/)..."
    rm -rf build install log
    echo "所有构建产物已清理完成。"
else
    echo "正在清理指定功能包的构建产物..."
    for pkg in "$@"; do
        echo "清理功能包：$pkg"
        # 清理 build 和 install 目录下的对应包
        rm -rf "build/$pkg" "install/$pkg"
    done
    echo "指定功能包构建产物已清理完成。"
fi
