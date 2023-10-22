#!/bin/bash

#psql ${DB_CONN} -At -c "select json_build_object('match_id', id) from match where start_date < extract(epoch from now()) and id not in (select id from match_data);" |  xargs -n 1 -d '\n' node raw/xg-puppet/match.js | python raw/utils/insert_raw_match_data.py

psql ${DB_CONN} -At -c "select data from match_data where id in (select id from match where start_date < extract(epoch from now())) and (id not in (select distinct(match_id) from team_stats) or id not in (select distinct(match_id) from player_stats));" | docker run -i parser | python3 raw/utils/request_single.py
