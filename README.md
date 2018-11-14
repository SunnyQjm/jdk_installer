# jdk_installer

这是一个简单易用的Linux JDK安装器，默认支持下载`jdk8_19_02`和最新的`jdk11`。如果要使用其他版本的jdk，需要收到填写下载链接

## 使用
- 首先拉取本项目
```bash
git clone https://github.com/SunnyQjm/jdk_installer.git 
```

- 进入到项目的根目录，执行下面的命令开始安装
```bash
source ./install.sh
```

## 说明
安装完成后jdk的环境配置就完成了，可以用下面的命令查看
```bash
java -version
```

