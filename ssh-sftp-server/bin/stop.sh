#!/bin/sh

#------------------------
# mazhuang.org
#------------------------

. ./bin/base.sh

if [ -f "${PID_FILE}" ];then
    cat ${PID_FILE} | xargs kill
    rm ${PID_FILE} 
fi

iptables -D INPUT -p tcp --dport ${PORT} -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -D OUTPUT -p tcp --sport ${PORT} -m conntrack --ctstate ESTABLISHED -j ACCEPT

if [ ! -f "${PID_FILE}" ];then
    display_msg 'Stop Succeed!'
else
    display_msg 'Stop Failed!'
fi
