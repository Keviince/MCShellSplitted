#!/bin/sh
PDIR=$( cd "$( dirname "$0" )" && pwd )
DIR=`cd $PDIR/.. && pwd`
PLAYER=`$DIR/list only | awk '{print int($0)}'`
TPSRAW=`$DIR/detail tps`
if [ "$TPSRAW" = "" ] ; then 
	sleep 1.5
	TPSRAW=`$DIR/detail tps`
fi
TPS=`echo "$TPSRAW*100" | bc | awk '{print int($0)}'`
if test $PLAYER -ge 0 -a $PLAYER -le 3 ; then
	WHP=1700
	RES=1300
elif test $PLAYER -ge 4 -a $PLAYER -le 6 ; then
	WHP=1400
	RES=1000
elif test $PLAYER -ge 7 -a $PLAYER -le 10 ; then
	WHP=1100
	RES=700
elif test $PLAYER -ge 11 -a $PLAYER -le 15 ; then
	WHP=800
	RES=400
elif test $PLAYER -ge 16 ; then
	WHP=500
	RES=100
fi
if test $TPS -ge $WHP ; then
	echo pass
elif test $TPS -ge $RES -a $TPS -lt $WHP ; then
	echo whp
elif test $TPS -lt $WHP ; then
	echo restart
fi
