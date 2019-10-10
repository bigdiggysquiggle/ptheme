#!/bin/bash
COLOUR=(46 82 118 154 190 226 220 214 208 202 196)
if [ $OSTYPE == "linux-gnu" ]; then
	TOTAL="$(awk '/MemTotal/{ printf $2 }' /proc/meminfo)"
	USED="$(($TOTAL - $(awk '/MemAvailable/{ printf $2 }' /proc/meminfo)))"
else
	FREE_BLOCKS=$(vm_stat | grep free | awk '{ print $3 }' | sed 's/\.//')
	INACTIVE_BLOCKS=$(vm_stat | grep inactive | awk '{ print $3 }' | sed 's/\.//')
	SPECULATIVE_BLOCKS=$(vm_stat | grep speculative | awk '{ print $3 }' | sed 's/\.//')
	FREE=$((($FREE_BLOCKS+SPECULATIVE_BLOCKS)*4096/1048576))
	INACTIVE=$(($INACTIVE_BLOCKS*4096/1048576))
	TOTAL_FREE=$((($FREE+$INACTIVE)))
	TOTAL=`ps -caxm -orss= | awk '{ sum += $1 } END { print um/1024 }'`
	USED=$((($TOTAL-$TOTALFREE)))
fi
PERC=$(($USED * 100 / $TOTAL))
INDEX="$((($PERC - 24) / 6))"
if [ $INDEX -lt 0 ]; then
	INDEX=0
elif [ $INDEX -gt 10 ]; then
	INDEX=10
fi
printf "\e[38;5;${COLOUR[$INDEX]}m"

#top -l 1 -s 0 | grep PhysMem
