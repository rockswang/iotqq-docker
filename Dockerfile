FROM ubuntu
# 从命令行的build-arg读取Token参数
ARG Token
ARG File=IOTQQ/CoreConf.conf
# 把预先下载的IOTQQ二进制包传送到镜像，会自动解压缩
ADD iotbot_3.0.1_linux_amd64.tar.gz /root/
WORKDIR /root
# IOTQQ依赖wget拉取资源，因此要先安装wget；然后根据Token参数生成配置文件
RUN apt-get update \
    && apt-get install -y wget \
    && mv iotbot_3.0.1_linux_amd64/ IOTQQ \
    && echo "Port = \"0.0.0.0:8888\"">$File \
    && echo "WorkerThread = 50">>$File \
    && echo "IOTQQVer = \"v3.0.1\"">>$File \
    && echo "Token = \"$Token\"">>$File
