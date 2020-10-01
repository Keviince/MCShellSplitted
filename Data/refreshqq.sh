#!/bin/sh
PDIR=$( cd "$( dirname "$0" )" && pwd )
DIR=`cd $PDIR/.. && pwd`
CQ_HOST=`cat $DIR/ENV | grep CQ_HOST | awk '{print $3}'`
QQ_GROUP=`cat $DIR/ENV | grep QQ_GROUP | awk '{print $3}'`
RAW=`curl -s "$CQ_HOST/get_group_member_list?group_id=$QQ_GROUP"`
ARRAY=(${RAW//\},\{\"age\":/\} \{\"age\":})
rm -f $PDIR/groupmemberstmp.txt
rm -f $PDIR/groupmembers.txt
for ONE in ${ARRAY[@]}
do
	echo $ONE >> $PDIR/groupmemberstmp.txt
done
cat $PDIR/groupmemberstmp.txt | grep user_id | while read ONE1
do
	echo $ONE1 | sed 's/\"user_id\":/ /g' | awk {'print $NF}' | sed 's/\}/\ /g' | awk '{print $1F}' >> $PDIR/groupmembers.txt
done
rm -f $PDIR/groupmemberstmp.txt
