#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] The Server Will Restart In 5 Minutes. Please Make Sure You Are Ready.\"}" >> /dev/null
$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 服务器将会在5分钟内重启，请大家做好准备，谢谢配合。\"}" >> /dev/null
