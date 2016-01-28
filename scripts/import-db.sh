#!/bin/bash

set -e
set -x

dump=` ls -t /mnt/data/live/home/backup/forum/*sql.bz2 | head -n 1`

[ -f $dump ] || exit -1

mysql -uroot -pmysql -e 'DROP DATABASE forum' mysql 
mysql -uroot -pmysql -e 'CREATE DATABASE forum' mysql 
pv $dump | bunzip2 | mysql -uforum -pforum forum

