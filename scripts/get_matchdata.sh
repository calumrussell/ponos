#!/bin/bash
for i in `ls data`; do 
	cat data/"$i"/matches | xargs -n 1 -d '\n' node xg-puppet/match.js > data/"$i"/match_data
done
