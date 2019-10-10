#!/bin/bash

COLOUR=(46 82 118 154 190 226 220 214 208 202 196)
if [ $OSTYPE == "linux-android" ]; then
	TEMP=$(((((`tsudo cat /sys/class/thermal/thermal_zone0/temp` + 500) / 1000) - 40 ) / 5))
elif [ $OSTYPE == "linux" ]; then
	TEMP=$(echo "(($(acpi -t | awk '{ printf $4 }') - 40) / 5)" | bc)
else
	TEMP=$(echo "(($($HOME/bin/osx-cpu-temp/osx-cpu-temp | sed "s/\..*//") - 40) / 5)" | bc)
fi
if [ $TEMP -lt 0 ]; then
	TEMP=0
elif [ $TEMP -gt 10 ]; then
	TEMP=10
fi
printf "\e[38;5;${COLOUR[$TEMP]}m"
