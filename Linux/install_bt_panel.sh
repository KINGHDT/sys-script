#!/bin/bash

if command -v bt ; then
  exit
fi

if [ -d /data ]; then
  if [ ! -d /data/bt-panel ]; then 
    mkdir /data/bt-panel
  fi
  `ls -l / | grep "www -> /data/bt-panel"` > /dev/null 2>&1
  if [ $? = 0 ]; then
    ln -s /data/bt-panel /www
  fi
elif [ ! -d /www ]; then
    mkdir /www
fi

if [[ `cat /proc/partitions | grep ".db"` ]]; then 
    if [[ ! `ls -l / | grep "www" | grep "^l"` ]]; then
        # 有数据盘没链接www退出安装
        exit
    fi
fi

yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && echo y | sh install.sh && rm -f install.sh