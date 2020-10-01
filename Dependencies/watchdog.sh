#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
if [ -f $SDIR/.STOP ] ; then
	exit
fi
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`
SCREEN_NAMEDAEMON=$SCREEN_NAME"DAEMON"
SCREEN_NAMECQ=$SCREEN_NAME"CQ"
SCREEN_NAMEMBS=$SCREEN_NAME"MBS"
SCREEN_NAMERCON=$SCREEN_NAME"RCON"
SCREEN_NAMETEST=$SCREEN_NAME"TEST"
MBS_ID=`cat $RAWDIR/ENV | grep MBS_ID | awk '{print $3}'`
BOT_MODE=`cat $RAWDIR/ENV | grep BOT_MODE | awk '{print $3}'`
screen -wipe >> /dev/null
SCREEN=`screen -ls`
echo $SCREEN | grep "$SCREEN_NAME (" >> /dev/null
if [ $? -ne 0 ] ; then
	screen -ls | grep $SCREEN_NAME | cut -d'.' -f 1 | sed s/[[:space:]]//g | while read PID
	do
		kill $PID
	done	
	exit
fi
echo $SCREEN | grep $SCREEN_NAMEDAEMON >> /dev/null
if [ $? -ne 0 ] ; then
	screen -dmSU $SCREEN_NAMEDAEMON $RAWDIR/Plugins/DAEMON
fi
echo $SCREEN | grep $SCREEN_NAMETEST >> /dev/null
if [ $? -ne 0 ] ; then
	screen -dmSU $SCREEN_NAMETEST $PDIR/testloop.sh
fi
echo $SCREEN | grep $SCREEN_NAMECQ >> /dev/null
if [ $? -ne 0 ] ; then
	screen -dmSU $SCREEN_NAMECQ $RAWDIR/CoolQ/DAEMON
fi
echo $SCREEN | grep $SCREEN_NAMERCON >> /dev/null
if [ $? -ne 0 ] ; then
	screen -dmSU $SCREEN_NAMERCON $PDIR/sendcommand/start.sh
	exit
fi
MBS_STATUS=`cat $RAWDIR/ENV | grep MBS_STATUS | awk '{print $3}'`
if [ "$MBS_STATUS" = "ON" ] ; then
	$RAWDIR/list | grep $MBS_ID >> /dev/null
	if [ $? -ne 0 ] ; then
		sleep 3
		$RAWDIR/list | grep $MBS_ID >> /dev/null
		if [ $? -ne 0 ] ; then
			$RAWDIR/mobswitch on
		fi
	else
	ONLINE=`$RAWDIR/list only`
		if [ "$ONLINE" = "1" ] ; then
			$RAWDIR/mobswitch off
		fi
	fi
fi
if [ "$MBS_STATUS" = "OFF" ] ; then
	$RAWDIR/list | grep $MBS_ID >> /dev/null
	if [ $? -eq 0 ] ; then
		$RAWDIR/mobswitch off
	fi
fi
PY3RESULT=`ps -aux | grep /home/mainland/Dependencies/sendcommand/mcdrconnew.py | wc -l`
TARGET=4
if [ $PY3RESULT -gt $TARGET ] ; then
	/usr/local/bin/ekill /home/mainland/Dependencies/sendcommand/mcdrconnew.py
fi
