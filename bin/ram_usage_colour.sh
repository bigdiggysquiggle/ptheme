#!/bin/bash
COLOUR=(46 82 118 154 190 226 220 214 208 202 196)

f2i() {
  awk 'BEGIN{for (i=1; i<ARGC;i++)
   printf "%.0f ", ARGV[i]}' "$@"
}

if [ $OSTYPE == "linux-gnu" ]; then
	TOTAL="$(awk '/MemTotal/{ printf $2 }' /proc/meminfo)"
	USED="$(($TOTAL - $(awk '/MemAvailable/{ printf $2 }' /proc/meminfo)))"
else
	eval `vm_stat | awk '/free|inactive|speculative/{ printf $3+0 " " }' |
	awk '{ printf "FREE_BLOCKS=" $1 "; INACTIVE_BLOCKS=" $2 "; SPECULATIVE_BLOCKS=" $3 }'`
	FREE=$((($FREE_BLOCKS+$SPECULATIVE_BLOCKS)*4096/1048576))
	INACTIVE=$(($INACTIVE_BLOCKS*4096/1048576))
	TOTAL_FREE=$((($FREE+$INACTIVE)))
	TOTAL=`ps -caxm -orss= | awk '{ sum += $1 } END { print sum/1024 }'`
	TOTAL=`f2i $TOTAL`
	USED=$((($TOTAL-$TOTAL_FREE)))
fi
PERC=$(($USED * 100 / $TOTAL))
INDEX="$((($PERC - 24) / 6))"
if [ $INDEX -lt 0 ]; then
	INDEX=0
elif [ $INDEX -gt 10 ]; then
	INDEX=10
fi
printf "\e[38;5;${COLOUR[$INDEX]}m"
