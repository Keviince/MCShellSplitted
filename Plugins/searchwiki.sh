#!/bin/sh
#在游戏内输入“!!wiki COMMENT”来触发个人消息
#在游戏内输入“!!wiki -a COMMENT”来触发全体消息
PDIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $PDIR/.. && pwd`
SCREEN_NAME=`cat $RAWDIR/ENV | grep SCREEN_NAME | awk '{print $3}'`
SDIR=`cd $RAWDIR/Server && pwd`
SENDER=`cat $RAWDIR/ENV | grep SENDER | awk '{print $3}'`
#检测LOG内是否含有指定的关键词
tail -1 $PDIR/latest.log | grep "> !!wiki"
if [ $? == 0 ] ; then
	#获得需要的内容并存入变量
	SEARCH=$( tail -1 $PDIR/latest.log | grep "> !!wiki" | awk '{print $NF}' )
	tail -1 $PDIR/latest.log | grep "> !!wiki" | grep "\-a" >> /dev/null
	#判断是否发送给所有人
	if [ $? == 0 ] ; then
		PLAYER='@a'
	else
		PLAYER=$( tail -1 $PDIR/latest.log | grep "> !!wiki" | awk '{print $4}' | sed s'/<//g' | sed s'/>//g' )
	fi
	#向服务器内发送带有URL链接的指定搜索内容
	$RAWDIR/send "tellraw $PLAYER {\"text\":\"[$SENDER] 这是你搜索的关于\",\"color\":\"white\",\"extra\":[{\"text\":\"$SEARCH\",\"color\":\"yellow\",\"underlined\":\"true\",\"clickEvent\":{\"action\":\"open_url\",\"value\":\"https://minecraft-zh.gamepedia.com/index.php?search=$SEARCH\"},\"hoverEvent\":{\"action\":\"show_text\",\"value\":[{\"text\":\"https://minecraft-zh.gamepedia.com/index.php?search=$SEARCH\",\"color\":\"gray\"}]},\"extra\":[{\"text\":\"的内容\",\"color\":\"white\",\"underlined\":\"false\"}]}]}"
fi
