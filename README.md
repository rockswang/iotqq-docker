# Dockerfile for IOTQQ 3.0.0 (Ubuntu)
本仓库是IOTQQ 3.0.0版本的Dockerfile，用来创建docker镜像。<br/>
注意：
1. 只在腾讯云官方的Ubuntu 18.04镜像上部署测试过，其它版本和系统未测试
2. 基于作者本人踩坑经验，不建议在CentOS上部署IOTQQ

## 构建前准备
* 使用Github账号登录Gitter Developer，获取**Gitter Token**。这里[传送门](https://developer.gitter.im/apps)
* 下载IOTQQ 3.0.0的二进制发布版，请选择IOTQQ_3.0.0_linux_amd64版本。其实在Dockerfile里用wget现下载也是可以的，但是腾讯云连Gitter的速度实在是蛋疼，所以这里预先下载好。这里[传送门](https://gitter.im/IOTQQTalk/IOTQQ)
* 安装Docker：请参考[这篇文章](https://www.jianshu.com/p/80e3fd18a17e)

## 构建镜像
* 把本仓库中的Dockerfile和IOTQQ_3.0.0_linux_amd64.tar.gz放在同一个目录下
* 然后在该目录下执行此命令：
  ```shell
  docker build --no-cache --build-arg Token=<GitterToken> -t iotqq:nobind .
  ```
* 上面命令中的`<GitterToken>`请用你获取到的Gitter Token代替
* 此命令将会构建一个标签为`iotqq:nobind`的docker镜像，镜像中已经正确安装了IOTQQ并修改了配置文件
* 使用`docker images`可以看到你的镜像在本地镜像仓库中
* 可以用`docker rmi iotqq:nobind -f`来删除镜像

## 启动容器
* 执行下面命令：
  ```shell
  docker run -p 0.0.0.0:8888:8888 -d --name iotqq_8888 iotqq:nobind /root/IOTQQ/IOTQQ
  ```
* 这个命令会基于前面的`iotqq:nobind`镜像在后台启动一个docker容器，并把容器的8888端口映射到宿主服务器的8888端口上。容器启动后自动开启IOTQQ
* 可以用这个命令来实时跟踪容器中IOTQQ的日志：`docker logs iotqq_8888 -tf --tail 10`
  看到日志中显示`[D]  Everything is ok!`说明IOTQQ已经成功启动，此时就可以登录了
* 打开浏览器访问http://<宿主服务器公网地址>:8888/v1/Login/GetQRcode即可获取登录二维码，需用手机QQ扫码登录
* 以后可以使用`docker restart iotqq_8888`来重启容器
* 可以用`docker ps -a`来查看容器状态
* 可以用`docker rm iotqq_8888 -f`来删除容器

## 其它注意事项
* 注意前面的IOTQQ的8888端口通过映射直接开放给外网了，这是有一定风险的，更安全的做法是使用`docker run -p 127.0.0.1:8888:8888 ...`来绑定本机访问，并用nginx把API接口反代到外网，然后在nginx上做认证处理

