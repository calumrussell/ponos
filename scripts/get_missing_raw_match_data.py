import os
import psycopg2
import json

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            sql_query = "SELECT data FROM match_data where id in (select id from match where start_date < extract(epoch from now())) and id not in (select distinct(match_id) from team_stats) limit 100"
            cur.execute(sql_query)
            for row in cur:
                print(json.dumps(row[0]))
