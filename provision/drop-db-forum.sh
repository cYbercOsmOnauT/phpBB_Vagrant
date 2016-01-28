#!/bin/bash

mysql="`which mysql` -uroot -pmysql"

if $mysql -e "SHOW DATABASES" mysql | grep -q devdb; then
    echo Dropping database devdb.
    $mysql mysql <<EOF
DROP DATABASE devdb;
DROP USER devdb;
EOF
else
    echo Database devdb does not exist.
fi
