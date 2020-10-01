#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!help"
if [ $? == 0 ] ; then
	NAME=$( tail -1 $PDIR/latest.log | grep "> !!help" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	tail -1 $PDIR/latest.log | grep "> !!help" | grep "\-a" >> /dev/null
	if [ $? == 0 ] ; then
		NAME='@a'
	fi
	$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入!!tps查看服务器当前TPS\"}" >> /dev/null
	$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入!!day来查看服务器开启天数\"}" >> /dev/null
	$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入!!wiki来查询WIKI内容\"}" >> /dev/null
	$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入!!qq来发送消息到QQ群\"}" >> /dev/null
	$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入!!mbs来控制伪和平\"}" >> /dev/null
fi
