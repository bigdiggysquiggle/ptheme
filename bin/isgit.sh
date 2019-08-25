#!/bin/sh

STATUS=$(git status -sb 2> /dev/null)

if [ -n "$STATUS" ]; then
	printf "\e[38;5;57m"
else
	printf "\e[38;5;81m"
fi
