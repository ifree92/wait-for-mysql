#!/bin/bash

echo "$0: started"

wait_timeout=5
wait_log="yes"
wait_show_err="no"
params=""
MYSQL_READY=no

for param in $@
do
	case $1 in
		--wait-timeout=*)
		wait_timeout=$(echo $1 | sed "s/.*=//")
		shift
		;;
		--no-wait-log*)
		wait_log="no"
		shift
		;;
		--wait-show-err*)
		wait_show_err="yes"
		shift
		;;
		*)
		params+=$1
		params+=" "
		shift
		;;
	esac
done

while [ $MYSQL_READY == "no" ]
do
	if [ $wait_show_err == "yes" ]
	then
		mysql $params
	else
		mysql $params 2>/dev/null
	fi

	if [ $? -eq 0 ]
	then
		echo "mysql connected"
		MYSQL_READY=yes
	else

		if [ $wait_log == "yes" ]
		then
			echo "wait for mysql..."
		fi

		sleep $wait_timeout

	fi

done

echo "$0: finished"