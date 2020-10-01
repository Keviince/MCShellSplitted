#!/bin/sh
DIR=$( cd "$( dirname "$0" )" && pwd )
RAWDIR=`cd $DIR/.. && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
sh $RAWDIR/dobackup playerdata
#sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] We Are Glad To See You Online.\"}" >> /dev/null
sleep 0.05
#sh $RAWDIR/send "tellraw @a {\"text\":\"[$SENDER] 欢迎来到冒险者大陆！\"}" >> /dev/null
#sh $RAWDIR/Data/checkqq.sh
