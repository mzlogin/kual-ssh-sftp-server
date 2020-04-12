#!/bin/sh

#------------------------
# mazhuang.org
#------------------------

. ./bin/base.sh

if [ ! -d "/mnt/us/koreader/settings/" ];then
    mkdir /mnt/us/koreader/settings
fi

if [ ! -d "/mnt/us/koreader/settings/SSH/" ];then
    mkdir /mnt/us/koreader/settings/SSH
fi

if [ -f "${PID_FILE}" ];then
    display_msg 'Start Succeed!'
fi

cd /mnt/us/koreader

/mnt/us/koreader/dropbear -E -R -p ${PORT} -P ${PID_FILE} -n
iptables -A INPUT -p tcp --dport ${PORT} -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport ${PORT} -m conntrack --ctstate ESTABLISHED -j ACCEPT

if [ -f "${PID_FILE}" ];then
    ip_address=`ifconfig wlan0 | grep 'inet addr' | sed 's/^.*addr://g' | sed 's/  Bcast.*$//g'`
    display_msg "Start Succeed in ${ip_address}:${PORT}!"
else
    display_msg 'Start Failed!'
fi
