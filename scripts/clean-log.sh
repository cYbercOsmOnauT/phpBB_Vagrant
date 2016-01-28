#!/bin/bash

if [ ! -d src/devsystem -a ! -d log ]; then
	echo This script must be run from the project root!
	exit 1
fi

git clean -fxd log

echo Checking if Vagrant overlayfs needs a kick...
vm_status_default=`vagrant status | grep default | tr -s " " |  cut -d ' ' -f 2`
case $vm_status_default in
	running )
		vagrant ssh -- sudo /etc/init.d/overlayfs restart
		echo Vagrant overlayfs restarted.
		;;
	* )
		echo Vagrant is not running.
		;;
esac