#!/bin/bash
# 添加auauthorized_keys 到 root用户

SKEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtLZKj789A0yiLBA37eRxXm0xafkToygqDLwTx8ZLiNnBOK0fiYua8Qr1O8h8tgL68wsF9G2oeblx2qIkSVixHIcH4TYl0HX99KrseU7lnWKJAs3X/z7i3vHXb59NwoL+pd79PmbLxB6oGpp7qm49vageZJMQrTT+7IuaUwN8hnCmDZjgR/qwYA8AD9FOK+YYhQlnmlTkwzpYlMIfUoS3RmHaG0X20MoAGEivLOCL8pQCHRogJVHDY9mSkvsJ7GETvJK49nDW9mZxzFS4hq6peSO/858mKBr8fkneUAXT8TlJRj6AOnbofsup2cfF9ukyTkORIVqy8ZwCXtoTnlU43 root@linux"

if [ ! -d /root/.ssh ]; then
    mkdir /root/.ssh
fi
if [ ! -f /root/.ssh/authorized_keys ]; then
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    chmod 644 /root/.ssh
fi
# 查询是否已添加同样的KEY
grep -n "${SKEY}" /root/.ssh/authorized_keys > /dev/null 2>&1
if [ $? != 0 ]; then
    echo ${SKEY} >> /root/.ssh/authorized_keys
fi

#history 格式化
grep -n "HISTTIMEFORMAT" /etc/profie > /dev/null
if  [ $? != 0 ]; then
    echo "export HISTTIMEFORMAT='[%F %T] '" >> /etc/profile
fi