#!/bin/bash

perm_colourizer() {
	i=0
	colour_index=0
	colours=(21 201 51 46)
	[ ${1:0:1} == "r" ] && ((colour_index+=1))
	[ ${1:1:1} == "w" ] && ((colour_index+=2))
	printf "\e[38;5;${colours[$colour_index]}m"
}

LS=`ls -ld 2>/dev/null`
if [ -n "$LS" ]; then
	eval `echo $LS | awk '{ print "DIR_PERMS=" $1 "; DIR_OWNER=" $3 "; DIR_GROUP=" $4 }'`
	if [ "$USER" == "$DIR_OWNER" ]; then
		perm_colourizer "${DIR_PERMS:1:3}"
	elif [ -n "`groups | grep -w "$DIR_GROUP"`" ]; then
		perm_colourizer "${DIR_PERMS:4:3}"
	else
		perm_colourizer "${DIR_PERMS:7:3}"
	fi
else
	printf "\e[38;5;196m"
fi
