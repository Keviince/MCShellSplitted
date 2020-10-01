#!/bin/sh
DIR=$( cd "$( dirname "$0" )" && pwd )
until ([[ $MIN > 0 ]] && [[ $MIN < 30 ]]) || ([[ $MIN > 30 ]] && [[ $MIN < 59 ]])
do
	RANDOM=`openssl rand -base64 8|cksum|cut -c 1-6`
	HOUR=$(( $RANDOM % 2 ))
	MIN=$(( $RANDOM % 60 ))
done
#echo $HOUR:$MIN
crontab -l > $DIR/../.TMP/crontabtmp.txt
grep -n "testtps.sh" $DIR/../.TMP/crontabtmp.txt
if [ $? -eq 0 ] ; then
	DELN=`grep -n "testtps.sh" $DIR/../.TMP/crontabtmp.txt | cut -d ':' -f 1`
	sed -i ''${DELN}'d' $DIR/../.TMP/crontabtmp.txt
fi
if [ $HOUR == 0 ] ; then
	echo "$MIN 8,10,12,14,16,18,20,22 * * * "$DIR"/testtps.sh" >> $DIR/../.TMP/crontabtmp.txt
fi
if [ $HOUR == 1 ] ; then
	echo "$MIN 9,11,13,15,17,19,21,23 * * * "$DIR"/testtps.sh" >> $DIR/../.TMP/crontabtmp.txt
fi
crontab $DIR/../.TMP/crontabtmp.txt
