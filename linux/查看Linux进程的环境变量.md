

查看Linux进程的环境变量
==============
> 好记性不如烂笔头，这就是我的笔记。

在`Linux`下直接执行`env`命令即可获取**当前的环境变量**：
```
[appweb@web-18-228-hzqsh ~]$ env
HOSTNAME=web-18-228-hzqsh.node.hzqsh.xxx.sdc
TERM=xterm-256color
SHELL=/bin/bash
HISTSIZE=1000
USER=appweb
JAVA_HOME=/data/program/java
HOME=/home/appweb
...
```

**进程的环境变量**可以在`/proc/<pid>/environ`查看，其中`pid`为**进程id**。


### 1. 获取进程id
1.1 使用`ps`获取`pid`
```
[appweb@web-18-228-hzqsh ~]$ jps -mlv | grep "harmony-web"
12880 ./lib/harmony-web-1.0.3.jar -verbose:gc -Xloggc:/data/program/com.xxx.middleware/harmony-web/1.0.3/gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/program/com.xxx.middleware/harmony-web/1.0.3/java.hprof -XX:ErrorFile=/data/program/com.xxx.middleware/harmony-web/1.0.3/java_error.log -Djava.awt.headless=true -DLOG_HOME=/data/program/logs/com.xxx.middleware/harmony-web/app_log -Dapp.log.dir=/data/program/logs/com.xxx.middleware/harmony-web/app_log -Dserver.tomcat.access-log-enabled=true -Dserver.tomcat.basedir=/data/program/com.xxx.middleware/harmony-web -Dmanagement.port=-1 -Dendpoints.shutdown.enabled=true -Dshell.telnet.enabled=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Xms2g -Xmx2g -XX:MetaspaceSize=38m -XX:MaxMetaspaceSize=380m -Djava.security.egd=file:/dev/./urandom -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=20 -XX:GCLogFileSize=500m -XX:NewSize=600m -XX:MaxNewSize=750m -XX:+UseConcMarkSweepGC -XX:CMSMaxAb

[appweb@web-18-228-hzqsh ~]$ ps aux | grep "harmony-web"
[appweb@web-18-228-hzqsh ~]$ ps -ef | grep "harmony-web"
appweb   12880  7.3 41.1 6302652 1669572 ?     Sl    2018 1628:51 /data/program/java/bin/java -verbose:gc -Xloggc:/data/program/com.xxx.middleware/harmony-web/1.0.3/gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/data/program/com.xxx.middleware/harmony-web/1.0.3/java.hprof -XX:ErrorFile=/data/program/com.xxx.middleware/harmony-web/1.0.3/java_error.log -Djava.awt.headless=true -DLOG_HOME=/data/program/logs/com.xxx.middleware/harmony-web/app_log -Dapp.log.dir=/data/program/logs/com.xxx.middleware/harmony-web/app_log -Dserver.tomcat.access-log-enabled=true -Dserver.tomcat.basedir=/data/program/com.xxx.middleware/harmony-web -Dmanagement.port=-1 -Dendpoints.shutdown.enabled=true -Dshell.telnet.enabled=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Xms2g -Xmx2g -XX:MetaspaceSize=38m -XX:MaxMetaspaceSize=380m -Djava.security.egd=file:/dev/./urandom -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=20 -XX:GCLogFileSize=500m -XX:NewSize=600m -XX:MaxNewSize=750m -XX:+UseConcMarkSweepGC -XX:CMSMaxAbortablePrecleanTime=5000 -XX:+CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly -javaagent:./agent/bds-axb-1.0.9.jar=config=http://bds.xxx.info/metric/config,port=7777,host=10.1.18.228 -Dlogging.config=./config/logback.xml -jar ./lib/harmony-web-1.0.3.jar
```
其中`12880`就是`pid`。

1.2 使用`pidof`获取`pid`
`pidof`命令需要知道进程的可执行命令：
```
[appweb@web-18-228-hzqsh ~]$ pidof java
12880
```
它会列出所有执行此命令的进程id。


### 2. 列出进程的环境变量
格式化输出`xargs --null --max-args=1 < /proc/<pid>/environ`、`tr '\0' '\n' < /proc/<pid>/environ`、`cat /proc/<pid>/environ | tr '\0' '\n'`
```
[appweb@web-18-228-hzqsh ~]$ xargs --null --max-args=1 < /proc/12880/environ | grep APP_IDC
[appweb@web-18-228-hzqsh ~]$ cat /proc/12880/environ | tr '\0' '\n' | grep APP_IDC
APP_IDC=hzqsh

[appweb@web-18-228-hzqsh ~]$ xargs --null --max-args=1 < /proc/12880/environ
[appweb@web-18-228-hzqsh ~]$ cat /proc/12880/environ | tr '\0' '\n'
GROUP=com.xxx.middleware
PWD=/data/program/com.xxx.middleware/harmony-web/1.0.3
ARTIFACT=harmony-web
SUDO_COMMAND=/bin/bash -c bash -c cd\ /data/program/com.xxx.middleware/harmony-web/1.0.3\ &&\ ./bin/start.sh
APP_IDC=hzqsh
JAVA_APP_ENV=production
APP_ENV=production
_=/usr/bin/nohup
```


### 参考
* [Linux下查看进程所使用的环境变量](https://www.centos.bz/2017/10/linux%E4%B8%8B%E6%9F%A5%E7%9C%8B%E8%BF%9B%E7%A8%8B%E6%89%80%E4%BD%BF%E7%94%A8%E7%9A%84%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F/)
* [Linux Shell 笔记](https://www.cnblogs.com/cswuyg/p/4668402.html)


------
祝玩得开心！ˇˍˇ
云舒，2019.1.13，杭州

