#!/bin/bash


URL="https://gitee.com/oerbin/sys-script/raw/master/Linux/program/node_exporter-1.0.1.linux-amd64.tar.gz"
# 下载node_exporter
wget "https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz"
#解压缩
tar zxf node_exporter-1.0.1.linux-amd64.tar.gz
# 复制到目录
cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/sbin/
#添加到服务
echo "[Unit]" > /etc/systemd/system/node_exporter.service
echo "Description=node_exporter" >> /etc/systemd/system/node_exporter.service
echo "After=network.target" >> /etc/systemd/system/node_exporter.service
echo "" >> /etc/systemd/system/node_exporter.service
echo "[Service]" >> /etc/systemd/system/node_exporter.service
echo "Restart=on-failure" >> /etc/systemd/system/node_exporter.service
echo "ExecStart=/usr/local/sbin/node_exporter" >> /etc/systemd/system/node_exporter.service
echo "" >> /etc/systemd/system/node_exporter.service
echo "[Install]" >> /etc/systemd/system/node_exporter.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/node_exporter.service
# 添加自启动并启动服务
systemctl enable node_exporter
systemctl start node_exporter

# 删除下载的文件
rm -rf node_exporter*