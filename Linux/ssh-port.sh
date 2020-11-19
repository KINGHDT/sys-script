#!/bin/bash
# chang sshd port

PORT=7013
if [ ${1} ] ;then
	PORT=$1
fi

if ! grep -n "^Port" /etc/ssh/sshd_config > /dev/null;then
    sed -i "s/^#Port.*$/Port ${PORT}/" /etc/ssh/sshd_config
    firewall-cmd --zone=public --add-port=${PORT}/tcp --permanent
    firewall-cmd --reload
    systemctl restart sshd
fi

echo "=========================================="
# 颜色显示
echo -e "\033[36mSSHd [ `grep -n "^Port.*" /etc/ssh/sshd_config | cut -d ":" -f 2` ]\033[0m"