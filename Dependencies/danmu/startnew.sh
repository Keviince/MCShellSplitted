#!/bin/bash
DIR=$( cd "$( dirname "$0" )" && pwd )
RAWDIR=`cd $DIR/../.. && pwd`
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`
SCREEN_NAMEBILI=$SCREEN_NAME"BILI"$1"TO"$2
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
PORT=`cat $RAWDIR/ENV | grep RCON_PORT | awk '{print $3}'`
PASS=`cat $RAWDIR/ENV | grep RCON_PASS | awk '{print $3}'`

rm -f $DIR/logs/$1.log
screen -X -S $SCREEN_NAMEBILI quit
screen -dmSU $SCREEN_NAMEBILI $DIR/startnow.sh $1

trap "screen -X -S $SCREEN_NAMEBILI quit ; rm -f $DIR/logs/$1.log" EXIT
#trap "screen -X -S $SCREEN_NAMEBILI quit" EXIT

sleep 3
echo "tellraw "$2" {\"text\":\"[$SENDER] 已开启直播弹幕推送！\"}" > $RAWDIR/Dependencies/sendcommand/in/input.txt

while true ; do
	python3 $DIR/send.py $PORT $PASS /home/mainland/Dependencies/danmu/logs/$1.log $2
done
