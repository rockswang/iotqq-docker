FROM ubuntu
ARG Token
ARG File=IOTQQ/CoreConf.conf
ADD IOTQQ_3.0.0_linux_amd64.tar /root/
WORKDIR /root
RUN mv IOTQQ_3.0.0_linux_amd64/ IOTQQ \
    && echo "Port = \"0.0.0.0:8888\"">$File \
    && echo "WorkerThread = 50">>$File \
    && echo "IOTQQVer = \"v3.0.0\"">>$File \
    && echo "Token = \"$Token\"">>$File

