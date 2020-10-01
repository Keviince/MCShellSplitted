#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`

tail -1 $PDIR/latest.log | grep "> !!bili" >> /dev/null
if [ $? == 0 ] ; then
	CMD=`tail -1 $PDIR/latest.log | grep "> !!bili" | awk -F " " '{for (i=6;i<=NF;i++)printf("%s ", $i);print ""}'`
	SUBCMD=`echo $CMD | awk '{print $1}'`
	NAME=$( tail -1 $PDIR/latest.log | grep "> !!bili" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	if [ "$SUBCMD" = "" ] ; then
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入\\\"!!bili start 房间号\\\"来开启直播弹幕推送！\"}" >> /dev/null
		$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入\\\"!!bili stop\\\"来关闭直播弹幕推送！\"}" >> /dev/null
	fi
	if [ "$SUBCMD" = "start" ] ; then
		ROOMID=`echo $CMD | awk '{print $2}'`
		if [ "$ROOMID" = "" ] ; then
			$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 输入\\\"!!bili start 房间号\\\"来开启直播弹幕推送！\"}" >> /dev/null
			exit
		fi
		screen -ls | grep "BILI$NAME" >> /dev/null
		if [ $? -eq 0 ] ; then
			$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 你已经开启了直播弹幕推送！\"}" >> /dev/null
		else
			$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 正在开启直播弹幕推送！\"}" >> /dev/null
			SCREEN_NAMEBILI=$SCREEN_NAME"BILI"$NAME"DAEMON"
			screen -dmSU $SCREEN_NAMEBILI $RAWDIR/Dependencies/danmu/start.sh $ROOMID $NAME
		fi
	fi
	if [ "$SUBCMD" = "stop" ] ; then
		screen -ls | grep "BILI$NAME" >> /dev/null
		if [ $? -eq 0 ] ; then
			$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 直播弹幕推送已关闭！\"}" >> /dev/null
			SCREEN_NAMEBILI=$SCREEN_NAME"BILI"$NAME"DAEMON"
			screen -X -S $SCREEN_NAMEBILI quit
		else
			$RAWDIR/send "tellraw $NAME {\"text\":\"[$SENDER] 你没有开启直播弹幕推送！\"}" >> /dev/null
		fi
	fi
fi



