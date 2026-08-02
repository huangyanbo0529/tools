1.设置可执行权限
chmod a+x log_collector.sh

2.测试方法
# 创建测试日志
mkdir -p ~/.ros/log
echo "test" > ~/.ros/log/node_1.log
touch -d "5 minutes ago" ~/.ros/log/node_1.log
# 执行脚本
./log_collector.sh

