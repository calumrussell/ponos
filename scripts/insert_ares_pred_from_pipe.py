import os
import psycopg2
import json
import sys

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            vals = []
            for line in sys.stdin:
                pred = json.loads(line)
                match_id = pred['match_id']
                home_win = float(pred['home_win'])
                away_win = float(pred['away_win'])
                draw = float(pred['draw'])
                vals.append(f"({match_id},{home_win},{away_win},{draw})")

            joined = ",".join(vals)
            sql_query = f"insert into elo_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
            cur.execute(sql_query)
        print("Inserted " + str(len(vals)) + " predictions")
        conn.commit()
 
