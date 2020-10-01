#!/bin/sh
DIR=$( cd "$( dirname "$0" )" && pwd )
RAWDIR=`cd $DIR/.. && pwd`
$DIR/refreshqq.sh
cat $DIR/linkmembers.txt | tr -s '\n' > $DIR/linkmemberstmp.txt
mv $DIR/linkmemberstmp.txt $DIR/linkmembers.txt
cat $DIR/linkmembers.txt | while read RAW
do
	QQNUM=`echo $RAW | awk '{print $2}'`
	NAME=`echo $RAW | awk '{print $1}'`
	cat $DIR/groupmembers.txt | grep $QQNUM >> /dev/null
	if [ $? -eq 0 ] ; then
		continue
	else
		cp $DIR/linkmembers.txt $RAWDIR/Backup/members/linkmembers-$(date +%Y-%m-%d-%H:%M).txt
		sed -i '/'${NAME}'/d' $DIR/linkmembers.txt
		echo $NAME
	fi
done
cat $DIR/linkmembers.txt | tr -s '\n' > $DIR/linkmemberstmp.txt
mv $DIR/linkmemberstmp.txt $DIR/linkmembers.txt
