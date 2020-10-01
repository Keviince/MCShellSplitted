#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`
SCREEN_NAMEVOTE=$SCREEN_NAME"VOTE"
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!vote" >> /dev/null
if [ $? == 0 ];then
	CMD=`tail -1 $PDIR/latest.log | grep "> !!vote" | awk -F " " '{for (i=6;i<=NF;i++)printf("%s ", $i);print ""}'`
	SUBCMD=`echo $CMD | awk '{print $1}'`
	if [ "$SUBCMD" = "mbsoff" ] ; then
		screen -ls | grep $SCREEN_NAMEVOTE >> /dev/null
		if [ $? -eq 0 ] ; then
			screen -X -S $SCREEN_NAMEVOTE quit
			$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 已经中止伪和平开启！\"}" >> /dev/null
		else
			$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 没有正在开启的伪和平进程！\"}" >> /dev/null
		fi
	fi
	if [ "$SUBCMD" = "mbson" ] ; then
		screen -ls | grep $SCREEN_NAMEVOTE >> /dev/null
		if [ $? -eq 0 ] ; then
			screen -X -S $SCREEN_NAMEVOTE quit
			$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 已经中止伪和平关闭！\"}" >> /dev/null
		else
			$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 没有正在关闭的伪和平进程！\"}" >> /dev/null
		fi
	fi
fi
