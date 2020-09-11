#!/bin/bash

BACK_DIR=/data/backup


# 要备份的主机，不要带中文
HOSTS=(
    "APO"
    "Kun_test"
    "DIA"
    "HtcCoin"
    )
# 远程目录方式
# 端口 用户@HOST
APO_HOST=("7202" "www@8.210.126.92")
# 数组的方式添加要备份的内容
# 备份名称：备份路径
APO_DIR=(
    "db:/www/backup/database/"  # 数据库备份目录
    "db-bin:/www/server/data/mysql-bin.*"  # binlog日志文件
    )
# Kun_test_HOST=("7202" "www@8.210.126.92")
# 数组的方式添加要备份的内容
# 备份名称：备份路径
Kun_test_DIR=(
    "db:/www/backup/database/"  # 数据库备份目录
    "db-bin:/www/server/data/mysql-bin.*"  # binlog日志文件
    )
DIA_HOST=("22" "www@8.210.122.172")
# 数组的方式添加要备份的内容
# 备份名称：备份路径
DIA_DIR=(
    "db:/www/backup/database/"  # 数据库备份目录
    "db-bin:/www/server/data/mysql-bin\.[0-9]*"  # binlog日志文件
    )
HtcCoin_HOST=("22" "www@8.210.34.60")
# 数组的方式添加要备份的内容
# 备份名称：备份路径
HtcCoin_DIR=(
    "db:/www/backup/database/"  # 数据库备份目录
    "db-bin:/www/server/data/mysql-bin.*"  # binlog日志文件
    )


# -----------------------------------------------------
# 同步备份
# 第一个参数为项目名称
rsync_file(){
    host=($2)  # 添加括号 生成数组
    array=($3)
    if [ ! -d /${BACK_DIR}/$1 ]
    then
        mkdir /${BACK_DIR}/$1
    fi

    for i in ${array[@]}
    do
        name=`echo $i|awk -F':' '{print $1}'`
        path=`echo $i|awk -F':' '{print $2}'`
        if [[ ${host} ]];  # 远程主机
        then
            rsync -avz --delete -e "ssh -p ${host[0]}" ${host[1]}:${path} ${BACK_DIR}/$1/$name/
        else
            rsync -avz --delete ${path} ${BACK_DIR}/$1/$name/
        fi
    done
}


# ----------------------- 正式调用部分 ----------------------
for i in ${HOSTS[@]}
do
    if [[ `eval echo '$'${i}_DIR` ]]; then
        # 动态调用
        tmp_host=${i}_HOST[@]
        HOST=(${!tmp_host})
        tmp_dir=${i}_DIR[@]
        DIR=(${!tmp_dir})
        # rsync_file $i $(eval echo '$'${i}_HOST) $(eval echo '$'${i}_DIR)
        rsync_file $i "${HOST[*]}" "${DIR[*]}"
    else
        echo "请设置 ${i} 备份目录"
    fi
done
