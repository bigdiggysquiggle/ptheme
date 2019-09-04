#!/bin/bash
#      0  1  2  3  4   5   6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22 23
HOURS=(55 56 57 97 135 141 111 38 45 44 87 117 123 116 153 159 153 152 151 184  178 172 134 92)
i=0;

# this block is for testing the gradient
#while [ $i -lt 24 ]; do
#	printf "\e[38;5;${HOURS[$i]}m%d\e[m\n" $i
#	((i++))
#done
#exit
printf "\e[38;5;${HOURS[$(date '+%_H')]}m"
