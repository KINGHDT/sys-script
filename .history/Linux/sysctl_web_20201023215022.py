#/bin/bash
optionkey="net.core.rmem_default
net.core.rmem_max
net.core.wmem_default
net.core.wmem_max
net.core.netdev_max_backlog
net.core.somaxconn
net.core.optmem_max
net.ipv4.tcp_mem
net.ipv4.tcp_rmem
net.ipv4.tcp_wmem
net.ipv4.tcp_keepalive_time
net.ipv4.tcp_keepalive_intvl
net.ipv4.tcp_keepalive_probes
net.ipv4.tcp_sack
net.ipv4.tcp_fack
net.ipv4.tcp_timestamps
net.ipv4.tcp_window_scaling
net.ipv4.tcp_syncookies
net.ipv4.tcp_tw_reuse
net.ipv4.tcp_tw_recycle
net.ipv4.tcp_fin_timeout
net.ipv4.ip_local_port_range
net.ipv4.tcp_max_syn_backlog"

for k in $optionkey;
do
    # 修改配置前备份文件
    cp /etc/sysctl.conf /etc/sysctl.conf.bak
    # 删除原来的配置数值
    sed -ie '/$k/d' /etc/sysctl.conf
done

echo "# 高并发优化" >> /etc/sysctl.conf
echo "net.core.rmem_default = 256960" >> /etc/sysctl.conf
echo "net.core.rmem_max = 513920" >> /etc/sysctl.conf
echo "net.core.wmem_default = 256960" >> /etc/sysctl.conf
echo "net.core.wmem_max = 513920" >> /etc/sysctl.conf
echo "net.core.netdev_max_backlog = 2000" >> /etc/sysctl.conf
echo "net.core.somaxconn = 2048" >> /etc/sysctl.conf
echo "net.core.optmem_max = 81920" >> /etc/sysctl.conf
echo "net.ipv4.tcp_mem = 131072  262144  524288" >> /etc/sysctl.conf
echo "net.ipv4.tcp_rmem = 8760  256960  4088000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_wmem = 8760  256960  4088000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_time = 1800" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_intvl = 30" >> /etc/sysctl.conf
echo "net.ipv4.tcp_keepalive_probes = 3" >> /etc/sysctl.conf
echo "net.ipv4.tcp_sack = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fack = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_timestamps = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_window_scaling = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_reuse = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_tw_recycle = 1" >> /etc/sysctl.conf
echo "net.ipv4.tcp_fin_timeout = 120" >> /etc/sysctl.conf
echo "net.ipv4.ip_local_port_range = 1024  65000" >> /etc/sysctl.conf
echo "net.ipv4.tcp_max_syn_backlog = 2048" >> /etc/sysctl.conf

# 使配置生效
sysctl -p