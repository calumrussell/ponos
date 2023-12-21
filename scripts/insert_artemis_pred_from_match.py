import os
import psycopg2
import json
import sys

from artemis.common import Poisson 

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            vals = []
            for line in sys.stdin:
                match = json.loads(line.strip())
                home_id = match['home_id']
                away_id = match['away_id']
                start_date = match['start_date']
                mid = match['id']

                sql_query = f"select off_rating, def_rating from poiss_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                home_rating_row = cur.fetchone()
                if not home_rating_row:
                    continue

                sql_query = f"select off_rating, def_rating from poiss_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                away_rating_row = cur.fetchone()
                if not away_rating_row:
                    continue
                   
                vals.append(str((Poisson.prediction(mid, home_rating_row[0], home_rating_row[1], away_rating_row[0], away_rating_row[1]))))

            joined = ",".join(vals)
            sql_query = f"insert into poiss_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
            cur.execute(sql_query)
            print("Inserted " + str(len(vals)) + " predictions")
            conn.commit()
 

