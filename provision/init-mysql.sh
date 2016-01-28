#!/bin/bash

set -e

# Initialize MySQL Databases

mysql="`which mysql` -uroot -pmysql"

if ${mysql} -e "SHOW DATABASES" mysql | grep -q devdb; then
    echo Database devdb already exists. Skipping create database.
else
    echo Creating database devdb...
    ${mysql} mysql <<EOF
CREATE DATABASE devdb;
CREATE USER devdb IDENTIFIED BY 'devdb';
GRANT ALL ON devdb.* TO devdb;
EOF
fi

if ${mysql} -e "SELECT Host FROM mysql.user WHERE User = 'root' AND Host = '10.0.2.2'"  | grep -q "10.0.2.2"; then
	echo root user for jdbc connection already exists. Skipping create user.
else
	echo Creating root user for jdbc...
	${mysql} mysql <<EOF
CREATE USER 'root'@'10.0.2.2' IDENTIFIED BY 'mysql';
GRANT ALL ON *.* TO 'root'@'10.0.2.2';
EOF
fi

flyway_version=3.2.1
flyway_commandline=flyway-commandline-${flyway_version}.zip
flyway=flyway-${flyway_version}
export PATH=$PATH:/var/tmp/$flyway

if [ ! -d /var/tmp/${flyway} ] ; then
    (
	apt-get install -y unzip openjdk-7-jre-headless

	cd /var/tmp

	[ -f $flyway_commandline ] && rm $flyway_commandline
	wget http://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/${flyway_version}/${flyway_commandline}
	unzip $flyway_commandline
    )
fi


echo
echo Executing Flyway Migrations for Database devdb...
flyway -url=jdbc:mysql://localhost:3306/devdb/ \
       -user=root -password=mysql \
       -locations=filesystem:/vagrant/flyway/devdb/ \
       -placeholderPrefix='$$.$' \
       migrate
