#/bin/bash
# 根据DIA注册接口 生成 IP黑名单
# IP黑名单位置
LANG=en.UTF-8
ip_file=/www/ipblack/banip
# 日志文件位置
log_file=/www/wwwlogs/cms.diayun.co.log
# 今天的日期，生成和nginx日志中一样的日志
today=`date '+%d/%b/%Y'`
# 要查询的接口
api='/app/public/newRegister'
# 次数 值
acc_num=5
# 获取结果
# 获取结果
ip_data=`grep "$today" $log_file | grep "$api" | awk '{print $1}' |
 sort |uniq -c | sort -nr |
 awk '{if ($1 > 5){print $2}}'` # 大于5次的

for _ip in $ip_data; do
    # echo "===01>>$_ip";
    # 查询是否已经存在文件内
    grep "deny $_ip;" $ip_file > /dev/null
    if [ $? != 0 ]; then
        echo "deny $_ip;" >> $ip_file
        # grep "deny $_ip;" $ip_file
    fi
done
# 一分钟内同一个接口次数过多(15次)的也封IP
# 前一分钟
minute_ago=`date -d "1 minute ago" "+%d/%b/%Y:%H:%M"`
ip_data=`grep "$minute_ago" $log_file |  awk '{print $1,$7}' |
sort |uniq -c | sort -nr |
awk '{if ($1 > 30){print $2}}'`

for _ip in $ip_data; do
    # echo "===01>>$_ip";
    # 查询是否已经存在文件内
    grep "deny $_ip;" $ip_file > /dev/null
    if [ $? != 0 ]; then
        echo "deny $_ip;  #api" >> $ip_file
    fi
done

nginx -s reload