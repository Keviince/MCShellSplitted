#!/bin/sh
DIR=$( cd "$( dirname "$0" )" && pwd)
while true
do
	HOUR=`date +%H`
	if [[ $HOUR -ge 0 && $HOUR -lt 8 ]] ; then
		sleep 60
		continue
	else
		RAN=`openssl rand -base64 8 | cksum | cut -c 1-6`
		MIN=$(($RAN % 60))
		TIME=$(($MIN * 60))
		sleep $TIME
		sh $DIR/testtps.sh
	fi
done
