#!/bin/bash
COLOUR=(46 82 118 154 190 226 220 214 208 202 196)
STATUS=$(tsudo cat /proc/meminfo)
TOTAL=$(echo $STATUS | awk '/MemTotal/{ print $2 }')
USED=$(($TOTAL - (`echo $STATUS | awk '/MemAvailable/{ print $2 }'` + `echo $STATUS | awk '/MemFree/{ print $2 }'`)))
PERC=$(($USED * 100 / $TOTAL))
INDEX="$((($PERC - 24) / 6))"
if [ $INDEX -lt 0 ]; then
	INDEX=0
elif [ $INDEX -gt 10 ]; then
	INDEX=10
fi
printf "\e[38;5;${COLOUR[$INDEX]}m"
