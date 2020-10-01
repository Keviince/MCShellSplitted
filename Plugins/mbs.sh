#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`
SCREEN_NAMEVOTE=$SCREEN_NAME"VOTE"
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
tail -1 $PDIR/latest.log | grep "> !!mbs" >> /dev/null
if [ $? == 0 ] ; then
	cat $RAWDIR/ENV | grep "MBS_MODE" | grep AUTO
	if [ $? -eq 0 ] ; then
		$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 伪和平目前为自动模式！\"}" >> /dev/null
		exit
	fi
	CMD=`tail -1 $PDIR/latest.log | grep "> !!mbs" | awk -F " " '{for (i=6;i<=NF;i++)printf("%s ", $i);print ""}'`
	SUBCMD=`echo $CMD | awk '{print $1}'`
	NAME=$( tail -1 $PDIR/latest.log | grep "> !!mbs" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	if [ "$SUBCMD" = "on" ] ; then
		screen -ls | grep $SCREEN_NAMEVOTE >> /dev/null
		if [ $? -eq 0 ] ; then
			$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 已有一个正在进行的投票进程……\"}" >> /dev/null
			exit
		fi
		$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 即将开启伪和平，请在30秒内输入\\\"!!vote mbsoff\\\"中止开启伪和平！\"}" >> /dev/null
		screen -dmSU $SCREEN_NAMEVOTE $RAWDIR/Dependencies/vote.sh ON
	fi
	if [ "$SUBCMD" = "off" ] ; then
		screen -ls | grep $SCREEN_NAMEVOTE >> /dev/null
		if [ $? -eq 0 ] ; then
			$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 已有一个正在进行的投票进程……\"}" >> /dev/null
			exit
		fi
		$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 即将关闭伪和平，请在30秒内输入\\\"!!vote mbson\\\"中止关闭伪和平！\"}" >> /dev/null
		screen -dmSU $SCREEN_NAMEVOTE $RAWDIR/Dependencies/vote.sh OFF
	fi
	if [ "$SUBCMD" = "" ] ; then
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入\\\"!!mbs on\\\"来开启伪和平！\"}" >> /dev/null
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入\\\"!!mbs off\\\"来关闭伪和平！\"}" >> /dev/null
	fi
fi
