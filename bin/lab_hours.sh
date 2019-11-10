#!/bin/bash

COLOUR=(196 208 220 190 118 46)

f2i() {
  awk 'BEGIN{for (i=1; i<ARGC;i++)
   printf "%.0f ", ARGV[i]}' "$@"
}

if [ -f /tmp/hours.tmp ]; then
	HOURS=`cat /tmp/hours.tmp`
	MOD=$(( `date +%s` - `stat -f%c /tmp/hours.tmp` ))
	MOD=$(bc -l <<< $MOD/3600.0)
	HOURS=$(bc -l <<< $HOURS+$MOD)
	{
		printf %.14f $HOURS
	} > /tmp/hours.tmp
else
	MSG=`curl -s https://temp-statusproxy.dark.vc/status/DWpZE1E60RcTEpqEgsl2WTkOUhMFS6EkNq2UqjdXWIqJI1849sYXHUUaiKW8gIc0/dromansk`
	HOURS=`echo "$MSG" | awk 'NR==1{ printf $3 }'`
	{
		printf %.14f $HOURS
	}	> /tmp/hours.tmp
fi
INDEX=$(f2i $HOURS)
INDEX=$(($INDEX/7))
printf "\e[38;5;${COLOUR[$INDEX]}m%.2f\e[m" $HOURS
