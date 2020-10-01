#!/bin/sh
DIR=$( cd "$( dirname "$0" )" && pwd )
RAWDIR=`cd $DIR/.. && pwd`
MBS_STATUS=`cat $RAWDIR/ENV | grep MBS_STATUS | awk '{print $3}'`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
MBS_MODE=`cat $RAWDIR/ENV | grep MBS_MODE | awk '{print $3}'`
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`
SCREEN_NAMEVOTE=$SCREEN_NAME"VOTE"
RESULT=`$DIR/tpsrange.sh`
if [ "$RESULT" = "pass" ] ; then
	if [ "$MBS_STATUS" = "ON" ] ; then
		sleep 30
		RESULT=`$DIR/tpsrange.sh`
		if [ "$RESULT" = "res" -o "$RESULT" = "whp" ] ; then
			exit
		elif [ "$RESULT" = "pass" ] ; then
			sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 当前服务器TPS大于伪和平阈值，即将关闭伪和平……\"}" >> /dev/null
			$DIR/vote.sh 0OFF
			exit
		fi
	else
		exit
	fi
elif [ "$RESULT" = "whp" ] ; then
	date +[%Y-%m-%d\ %H:%M:%S]\ MobSwitch\ Threshold >> $RAWDIR/Data/lowtps.txt
	sh $RAWDIR/list >> $RAWDIR/Data/lowtps.txt
	sh $RAWDIR/location all >> $RAWDIR/Data/lowtps.txt
	if [ "$MBS_STATUS" = "ON" ] ; then
		exit
	else
		sleep 30
		RESULT=`$DIR/tpsrange.sh`
		if [ "$RESULT" = "res" -o "$RESULT" = "whp" ] ; then
			screen -ls | grep $SCREEN_NAMEVOTE >> /dev/null
			if [ $? -eq 0 ] ; then
				screen -X -S $SCREEN_NAMEVOTE quit
			fi
			if [ "$MBS_MODE" = "AUTO" ] ; then
				sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 当前服务器TPS小于伪和平阈值，即将开启伪和平……\"}" >> /dev/null
				$DIR/vote.sh 0ON
			else
				sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 当前服务器TPS小于伪和平阈值，即将开启伪和平，请在30秒内输入\"!!vote nowhp\"中止开启伪和平……\"}" >> /dev/null
				screen -dmSU $SCREEN_NAMEVOTE $DIR/vote.sh ON
			fi
		else
			exit
		fi
	fi
elif [ "$RESULT" = "restart" ] ; then
	date +[%Y-%m-%d\ %H:%M:%S]\ Restart\ Threshold >> $RAWDIR/Data/lowtps.txt
	sh $RAWDIR/list >> $RAWDIR/Data/lowtps.txt
	sh $RAWDIR/location all >> $RAWDIR/Data/lowtps.txt
	sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 当前服务器TPS小于重启阈值，将在30秒后进行下一次检测！\"}" >> /dev/null
	sh $RAWDIR/cqsend 当前服务器TPS小于重启阈值，将在30秒后进行下一次检测！
#	sh $RAWDIR/CoolQ/list.sh tps
	sleep 30
	RESULT=`$DIR/tpsrange.sh`
	if [ "$RESULT" = "pass" ] ; then
		sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 第二次检测服务器TPS大于重启阈值，取消重启服务器！\"}" >> /dev/null
		sh $RAWDIR/cqsend 第二次检测服务器TPS大于重启阈值，取消重启服务器！
		exit
	elif [ "$RESULT" = "whp" ] ; then
		if [ "$MBS_STATUS" = "ON" ] ; then
			exit
		else
			screen -ls | grep $SCREEN_NAMEVOTE >> /dev/null
			if [ $? -eq 0 ] ; then
				screen -X -S $SCREEN_NAMEVOTE quit
			fi
			if [ "$MBS_MODE" = "AUTO" ] ; then
				sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 第二次检测服务器TPS小于伪和平阈值，即将开启伪和平……\"}" >> /dev/null
				sh $RAWDIR/cqsend 第二次检测服务器TPS小于伪和平阈值，即将开启伪和平！
				$DIR/vote.sh 0ON
			else
				sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 第二次检测服务器TPS小于伪和平阈值，即将开启伪和平，请在30秒内输入\"!!vote nowhp\"中止开启伪和平……\"}" >> /dev/null
				sh $RAWDIR/cqsend 第二次检测服务器TPS小于伪和平阈值，即将开启伪和平！
				screen -dmSU $SCREEN_NAMEVOTE $DIR/vote.sh ON
			fi
		fi
	elif [ "$RESULT" = "restart" ] ; then
		sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 第二次检测服务器TPS仍小于重启阈值，即将重启服务器！\"}" >> /dev/null
		sh $RAWDIR/cqsend 第二次检测服务器TPS仍小于重启阈值，即将重启服务器！
		sleep 3
		$RAWDIR/restartserver
	fi
fi
