##Get matches
```
cat data/seasons | xargs -n 1 node xg-puppet/fixtures.js > data/matches
```

##Get match data
```
cat data/matches | xargs -d '\n' -L 1 node xg-puppet/match.js > data/match_data
```

##Insert matches
```
cat data/matches | curl -H "Content-Type: text/plain" -X POST --data-binary @- https://{worker_url}/insert_match
```

##Inser match data
```
cat data/match_data | java -jar parser/target/parser-1.0-SNAPSHOT-jar-with-dependencies.jar | curl -H "Content-Type: application/json" -X POST --data-binary @- https://{worker_url}:8787/insert_parsed
```
