#!/bin/bash
# chang sshd port

PORT=7013
if [ ${1} ] ;then
    if [ "$1" -gt 1024 -a "$1" -lt 65535 ] 2>/dev/null; then
	PORT=$1
    fi
fi

if ! grep -n "^Port" /etc/ssh/sshd_config > /dev/null;then
    sed -i "s/^#Port.*$/Port ${PORT}/" /etc/ssh/sshd_config
fi
firewall-cmd --zone=public --add-port=${PORT}/tcp --permanent
firewall-cmd --reload
systemctl restart sshd

echo "=========================================="
echo -e "\033[36mSSHd [ `grep -n "^Port.*" /etc/ssh/sshd_config | cut -d ":" -f 2` ]\033[0m"