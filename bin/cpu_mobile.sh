#!/bin/bash

COLOUR=(46 82 118 154 190 226 220 214 208 202 196)
TEMP=$(((((`tsudo cat /sys/class/thermal/thermal_zone0/temp` + 500) / 1000) - 40 ) / 5))
if [ $TEMP -lt 0 ]; then
	TEMP=0
elif [ $TEMP -gt 10 ]; then
	TEMP=10
fi
printf "\e[38;5;${COLOUR[$TEMP]}m"
