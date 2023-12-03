#!/bin/bash
offset=0
val=$(psql ${DB_CONN} -At -c "select count(id) from match where tournament_id=$1")

while true
do 
	echo offset
	psql ${DB_CONN} -At -c "select data from match_data where id in (select id from match where start_date < extract(epoch from now()) and tournament_id=$1) limit 100 offset $offset;" | docker run --rm -i parser | python3 raw/utils/request_single.py
	if
done
