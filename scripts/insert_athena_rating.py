import os
import psycopg2
import json
import sys
import requests

from athena.common import Weibull

if __name__ == "__main__":
    conn = psycopg2.connect(os.getenv("DB_CONN"))

    def add_func(x):
        print("Added " + str(len(x)) + " ratings")
        query = "insert into wei_ratings(team_id, off_rating, off_rating_spread, def_rating, def_rating_spread, date) VALUES "
        query += ",".join(x)
        query += " on conflict(team_id, date) do update set off_rating=excluded.off_rating, off_rating_spread=excluded.off_rating_spread, def_rating=excluded.def_rating, def_rating_spread=excluded.def_rating_spread;"
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        return

    wei = Weibull()
    with conn:
        with conn.cursor() as cur:
            sql_query = """
                select 
                match.start_date,
                match.home_id,
                match.away_id,
                home.goal + away.goal_own as home_goal,
                away.goal + home.goal_own as away_goal,
                match.year
                from match
                left join team_stats_full as home
                    on home.team_id=match.home_id and home.match_id=match.id
                left join team_stats_full as away
                    on away.team_id=match.away_id and away.match_id=match.id
                where match.year=2024 or match.year=2023
                order by match.start_date asc"""
            cur.execute(sql_query)
            rows = [row for row in cur.fetchall()]
            for row in rows:
                if row[1] == -1 or row[2] == -1 or row[3] == None or row[4] == None:
                    continue
                wei.update(row[1], row[2], row[3], row[4], row[5], row[0])
                wei.flush(add_func)
        wei.exit(add_func)
 
