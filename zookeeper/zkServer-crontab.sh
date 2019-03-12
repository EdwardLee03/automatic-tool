#!/usr/bin/env bash

#
# 当ZK服务器进程出现异常时，基于Linux定时器自动执行本脚本重启进程。
# 异常场景：OOM、进程僵死、机器断电
#
# scp ./zookeeper/zkServer-crontab.sh "appweb@<IP>:/data/program/zookeeper-3.5.3-beta/bin/"
# $ crontab -l
# $ crontab -e
# */1 * * * * sh /data/program/zookeeper-3.5.3-beta/bin/zkServer-crontab.sh "/zookeeper-3.5.3-beta/" >/dev/null 2>&1 &
#

# 1. 设置用户环境变量
source ~/.bash_profile

# 2. 检测进程是否活着
ZOO_FILE_NAME=$1
echo "ZooKeeper file name: $ZOO_FILE_NAME"
ZOO_PID=`jps -mlv | grep "$ZOO_FILE_NAME" | awk '{print $1}'`
if [ "x$ZOO_PID" != "x" ]; then
    # ZK进程运行中，无需重启，结束检测
    echo "ZooKeeper server is running, process id: $ZOO_PID"
    exit 1
fi

# 3. 重启服务进程
echo "Restart zookeeper server"
# 使用`restart`命令防止ZK服务器异常终止的场景(`data/zookeeper_server.pid`文件还在)
/data/program/"$ZOO_FILE_NAME"/bin/zkServer.sh restart
# local test
#/usr/local/"$ZOO_FILE_NAME"/bin/zkServer.sh restart

# 4. 发送告警消息
curl -H "Content-Type: application/json" -d '{"title":"ZooKeeper测试集群告警","type":"wechat|email","to":["dannong"],"content":"ZooKeeper测试集群节点 '`hostname`' 已重启"}' http://crow.devops.k2.test.xxx.info/api/message

