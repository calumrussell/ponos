import psycopg2
import os

from common import Poisson

if __name__ == "__main__":
    """
    Code used for total prediction updates.
    """

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    poiss = Poisson()
    vals = []
    with conn:
        with conn.cursor() as cur:
            sql_query = """
                select 
                id,
                start_date,
                home_id,
                away_id
                from
                match
                where 
                id not in (select match_id from poiss_pred)
                and start_date < (extract(epoch from now()) + (86400*7))
                order by start_date asc"""
            cur.execute(sql_query)
            matches = [row for row in cur.fetchall()]
            for match_id, start_date, home_id, away_id in matches:
                print(match_id)
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
                    
                vals.append(Poisson.prediction(match_id, home_rating_row[0], home_rating_row[1], away_rating_row[0], away_rating_row[1]))
    joined = ",".join(vals)
    sql_query = f"insert into poiss_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
    cur = conn.cursor()
    cur.execute(sql_query)
    conn.commit() 
