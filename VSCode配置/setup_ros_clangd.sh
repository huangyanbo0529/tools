#!/bin/bash
set -euo pipefail  # 开启严格错误检查

# -------------------------- 配置变量 --------------------------
ROS_INCLUDE_DIR="/opt/ros/humble/include"  # ROS Humble 头文件目录
CLANGD_CONFIG="$HOME/.config/clangd/config.yaml"  # clangd 配置文件路径

# -------------------------- 前置检查 --------------------------
# 1. 检查 ROS Humble include 目录是否存在
if [ ! -d "$ROS_INCLUDE_DIR" ]; then
    echo -e "\033[31m错误：ROS Humble include 目录不存在: $ROS_INCLUDE_DIR\033[0m" >&2
    exit 1
fi

# 2. 创建 clangd 配置目录（如果不存在）
mkdir -p "$(dirname "$CLANGD_CONFIG")"

# -------------------------- 初始化配置文件结构 --------------------------
# 如果配置文件不存在，或没有 CompileFlags 部分，则初始化基础结构
if [ ! -f "$CLANGD_CONFIG" ] || ! grep -q "^CompileFlags:" "$CLANGD_CONFIG"; then
    cat > "$CLANGD_CONFIG" <<EOF
CompileFlags:
  Add:
EOF
    echo "已初始化 clangd 配置文件基础结构"
fi

# 确保 CompileFlags 下有 Add 列表（防止只有 CompileFlags 但没有 Add）
if ! grep -q "^  Add:" "$CLANGD_CONFIG"; then
    sed -i "/^CompileFlags:/a \  Add:" "$CLANGD_CONFIG"
    echo "已在 CompileFlags 下添加 Add 列表"
fi

# -------------------------- 添加 include 目录 --------------------------
echo "开始扫描 $ROS_INCLUDE_DIR 下的第一级子目录..."

# 使用 find -print0 + read -d '' 处理带空格的目录名，安全可靠
find "$ROS_INCLUDE_DIR" -type d -maxdepth 1 -mindepth 1 -print0 | while IFS= read -r -d '' dir; do
    include_entry="    - -I$dir"  # yaml 格式：4空格缩进 + -I路径
    
    # 【核心修复】使用 grep -x 整行匹配，彻底避免子串误判
    if grep -qx "$include_entry" "$CLANGD_CONFIG"; then
        echo -e "\033[33m已存在，跳过: $dir\033[0m"
    else
        # 在 "  Add:" 行后插入新的 include 路径
        sed -i "/^  Add:/a \\$include_entry" "$CLANGD_CONFIG"
        echo -e "\033[32m已添加: $dir\033[0m"
    fi
done

echo -e "\n\033[32m完成！所有第一级子目录已同步到 $CLANGD_CONFIG\033[0m"
