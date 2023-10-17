#!/bin/bash

while true
do 
	echo `date`
	psql ${DB_CONN} -At -c "select data from match_data where id in (select id from match where start_date < extract(epoch from now())) and id in (select match_id from player_stats where opp_id is NULL)  order by id desc limit 200;" | docker run -i --rm parser | python3 raw/utils/request_single.py
done
