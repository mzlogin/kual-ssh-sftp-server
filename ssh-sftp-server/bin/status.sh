#!/bin/sh

#------------------------
# mazhuang.org
#------------------------

. ./bin/base.sh

if [ -f "${PID_FILE}" ];then
    ip_address=`ifconfig wlan0 | grep 'inet addr' | sed 's/^.*addr://g' | sed 's/  Bcast.*$//g'`

    display_msg "Started Succeed in ${ip_address}:${PORT}!"
else
    display_msg 'Stopped!'
fi
