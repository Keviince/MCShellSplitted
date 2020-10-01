#!/bin/sh
DIR=`cd "$( dirname "$0" )" && pwd`
RAWDIR=`cd $DIR/../.. && pwd`
PDIR=`cd $DIR/.. && pwd`
LDIR=`cd $DIR/location && pwd`
cd $DIR
PORT=`cat $RAWDIR/ENV | grep RCON_PORT | awk '{print $3}'`
PASS=`cat $RAWDIR/ENV | grep RCON_PASS | awk '{print $3}'`
python3 $DIR/mcdrconnew.py $PORT $PASS $LDIR
