#!/bin/bash
for i in `ls data`; do 
	cat data/"$i"/matches | xargs -d '\n' -L 1 -P 4 node xg-puppet/match.js | split -l 5 - data/"$i"/chunk_
	for j in `ls data/"$i"/chunk*`; do
		cat "$j" | docker run -i parser | curl -H "Content-Type: application/json" -X POST --data-binary @- "$worker_url"/insert_parsed
	rm data/"$i"/chunk*
	done
done
