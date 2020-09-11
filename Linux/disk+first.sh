#!/bin/sh
# 仅挂载第一块数据盘 /dev/?db1 ,分成一个区
# Auto format and mount first disk on /data

disk_new=`cat /proc/partitions | grep ".db$" | awk '{print $4}'`
#  盘已经有分区则退出
if [ -b /dev/$disk_new ] && [  -b /dev/${disk_new}1 ]; then
    echo $disk_new "is already have partions!!!"
    echo "Bye!"
    exit
fi
# 进行分区并挂载
fdisk /dev/${disk_new} << EOF
n
p
1


wq
EOF

# format
mkfs.ext4 /dev/${disk_new}1

# mount to /data
mkdir /data
mount /dev/${disk_new}1 /data

# auto mount disk onboot
echo "/dev/${disk_new}1 /data   ext4    defaults        0 0" >> /etc/fstab

echo "=========================================="
echo -e "\033[36m[ `df -Th | grep $disk_new | awk '{print $1, " ",  $7}'` ]\033[0m"
