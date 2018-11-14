#!/bin/bash

default_jdk11_url="http://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.tar.gz"
default_jdk8_url="https://download.oracle.com/otn-pub/java/jdk/8u192-b12/750e1c8617c5452694857ad95c3ee230/jdk-8u192-linux-x64.tar.gz"

HOME=~
BASH_RC=${HOME}/.bashrc
########################################
# 执行安装jdk的操作
# @param url        jdk的下载链接
# @param saveDir    jdk的保存目录
# @param saveName   jdk文件夹的名字
########################################
function install() {
    url=$1
    saveDir=$2
    saveName=$3
    tarName=${saveName}.tar.gz
    echo 正在获取jdk

    # 将JDK下载到指定的文件夹下
    wget -O ${tarName} $url --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"
    mv ${tarName} ${saveDir}
    cd ${saveDir}

    mkdir ./${saveName}
    # 解压
    tar -zxvf  ${tarName} -C ./${saveName} --strip-components 1

    # 配置环境变量
    cat << EOF >> $BASH_RC

# java环境配置 
export JAVA_HOME=${saveDir}/${saveName}
export PATH=\$JAVA_HOME/bin:\$PATH
export CLASSPATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
EOF
    
}

# 读取用户配置
echo "开始读取用户配置，直接回车则会使用中括号中的默认值"

# 处理JDK版本号
read -p "要安装的JDK版本[11]: " version
if [ -z "${version}" ];then
    version=11
fi

case ${version} in
    "11")
        url=${default_jdk11_url}
        ;;
    "8")
        url=${default_jdk8_url}
        ;;
    *)
        ;;
esac

# 用户输入下载链接
read -p "请输入jdk的下载链接[$url]：" custom_url
if [ -z "${url}" -a -z "${custom_url}" ];then
    echo "没有版本号为${version}的默认下载链接，请手动填写"
    exit -1
fi


# 处理保存JDK的位置
read -p "JDK保存的位置[~/software]:" savePath
if [ -z "${savePath}" ];then
    savePath=~/software
fi

# 保证保存JDK的目录存在
if [ ! -d "${savePath}" ];then
    echo "文件夹${savePath}不存在，正在创建"
    mkdir -p ${savePath}
fi

install $url $savePath jdk${version}

# 让配置生效
source ${BASH_RC}
java -version
