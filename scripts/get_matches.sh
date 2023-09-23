#!/bin/bash
for i in `ls data`; do 
	cat data/"$i"/seasons | xargs -n 1 node xg-puppet/fixtures.js > data/"$i"/matches
done
