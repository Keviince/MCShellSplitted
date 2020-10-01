#!/bin/sh
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
MBS_STATUS=`cat $RAWDIR/ENV | grep MBS_STATUS | awk '{print $3}'`
if [ "$1" = "" ] ; then
	exit
fi
if [ "$1" = "0OFF" ] ; then
	if [ "$MBS_STATUS" = "ON" ] ; then
		sed -i s'/MBS_STATUS = ON/MBS_STATUS = OFF/g' $RAWDIR/ENV
		sleep 1
		$PDIR/watchdog.sh
		exit
	fi
	exit
fi
if [ "$1" = "0ON" ] ; then
	if [ "$MBS_STATUS" = "OFF" ] ; then
		sed -i s'/MBS_STATUS = OFF/MBS_STATUS = ON/g' $RAWDIR/ENV
		sleep 1
		$PDIR/watchdog.sh
		exit
	fi
	exit
fi
sleep 30
if [ "$1" = "ON" ] ; then
	sed -i s'/MBS_STATUS = OFF/MBS_STATUS = ON/g' $RAWDIR/ENV
	$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 在30秒内无人反对，伪和平即将开启……\"}" >> /dev/null
	sleep 1
	$PDIR/watchdog.sh
fi
if [ "$1" = "OFF" ] ; then
	sed -i s'/MBS_STATUS = ON/MBS_STATUS = OFF/g' $RAWDIR/ENV
	$RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 在30秒内无人反对，伪和平即将关闭……\"}" >> /dev/null
	sleep 1
	$PDIR/watchdog.sh
fi
