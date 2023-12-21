import os
import psycopg2
import json
import sys

from athena.common import Weibull

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            vals = []
            for line in sys.stdin:
                rec = json.loads(line)
                mid = rec['id']
                start_date = rec['start_date']
                home_id = rec['home_id']
                away_id = rec['away_id']

                sql_query = f"select off_rating, off_rating_spread, def_rating, def_rating_spread from wei_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                home_rating_row = cur.fetchone()
                if not home_rating_row:
                    continue

                sql_query = f"select off_rating, off_rating_spread, def_rating, def_rating_spread from wei_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                away_rating_row = cur.fetchone()
                if not away_rating_row:
                    continue
                   
                vals.append(str(Weibull.prediction(mid, home_rating_row[0], home_rating_row[1], home_rating_row[2], home_rating_row[3], away_rating_row[0], away_rating_row[1], away_rating_row[2], away_rating_row[3])))

            joined = ",".join(vals)
            print("Inserted " + str(len(vals)) + " predictions")
            sql_query = f"insert into wei_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
            cur.execute(sql_query)
            conn.commit()

 
