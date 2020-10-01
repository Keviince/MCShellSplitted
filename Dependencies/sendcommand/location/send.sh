#!/bin/sh
DIR=$( cd "$( dirname "$0" )" && pwd )
DIR=`cd $DIR/.. && pwd`
for ONE in $*
do
        if [ "$STR" = "" ] ; then
                STR=$ONE
                continue
        fi
        STR=$STR" "$ONE
done
echo $STR > $DIR/location/in/input.txt & timeout 0.2s inotifywait -e modify -qq $DIR/location/out/output.txt
if [ $? -eq 0 ] ; then
        head -1 $DIR/location/out/output.txt
else
        echo Error3 Error3 Error3 Error3 Error3 Error3 Error3 Error3 Error3 Error3 Error3 Error3 Error3
fi
