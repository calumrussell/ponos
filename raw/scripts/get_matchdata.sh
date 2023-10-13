#!/bin/bash
for i in `ls data`; do 
	echo "$i"
	cat data/"$i"/matches | xargs -n 1 -d '\n' node xg-puppet/match.js > data/"$i"/match_data
done
