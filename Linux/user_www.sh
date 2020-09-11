#!/bin/bash
#jenkins和web项目用户
USER=www
SKEY='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7hqu67AUbORPgl4L4Uypaupzsm5FemQpRjAcIi3SgyCGu6qZWhv4JqLjc5aamgzKSs87IuJxQjzhUPZJo8v9WooMAbQYTMd/2F6okqcMd2ITh20kkiH9mtRi4nCr5gCMubX7B08a9uhXkPWvDQhDJakjVAKZ5626E1WY9XaBngK0efZanRDf8dcSPrdtd8m3jmy9QQlrc9Xx0WSLJjqQgJKlNi04S+vpzOl+KthVGFa4ZKvYJFu7M2RASjzV0hqT1ffmdvL+y2D/eyoBOQOaUZ6oLQIDgHJfk9PxHdHfuiuZnvgZVT+1hZuZ/TwDUiM+Q9I3Z3HaiHxylCkgmrC+D user@linux'
# 查询用户是否存在
grep "^${USER}:" /etc/passwd > /dev/null 2>&1
if [ $? != 0 ]; then
    useradd ${USER}
fi
cd /home/${USER}
if [ ! -d .ssh ]; then
    mkdir .ssh
fi
if [ ! -f .ssh/authorized_keys ]; then
    touch .ssh/authorized_keys
else
    chown -R root:root .ssh
fi
# 查询是否存在相同的key值
grep "${SKEY}" .ssh/authorized_keys > /dev/null 2>&1
if [ $? != 0 ]; then
    echo "${SKEY}" > .ssh/authorized_keys
fi
# 设置权限
chmod 0600 .ssh/authorized_keys
chmod 0744 .ssh
chown -R ${USER}:${USER} .ssh
