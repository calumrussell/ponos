import os
import psycopg2
import json
import sys

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            for line in sys.stdin:
                match = json.loads(line.strip())
                home_id = match['home_id']
                away_id = match['away_id']
                start_date = match['start_date']
                mid = match['id']

                sql_query = f"select rating from elo_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                home_rating_res = cur.fetchone()
                if not home_rating_res:
                    home_rating = 1500
                else:
                    home_rating = home_rating_res[0]

                sql_query = f"select rating from elo_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                away_rating_res = cur.fetchone()
                if not away_rating_res:
                    away_rating = 1500
                else:
                    away_rating = away_rating_res[0]

                print(f"{mid}, {home_rating}, {away_rating}")

