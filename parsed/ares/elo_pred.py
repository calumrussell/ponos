
if __name__ == "__main__":
    """
    Code used to update all predictions 
    """
    import psycopg2
    import os
    from common import EloImpl, pred
    import pickle

    with open("model.pkl", 'rb') as f:
        model = pickle.load(f)

    margins = []
    match_ids = []
    conn = psycopg2.connect(os.getenv("DB_CONN"))
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
                id not in (select match_id from elo_pred)
                and start_date < (extract(epoch from now()) + (86400*7))"""
            cur.execute(sql_query)
            matches = [row for row in cur.fetchall()]
            for match_id, start_date, home_id, away_id in matches:
                sql_query = f"select rating from elo_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                home_rating_row = cur.fetchone()
                if not home_rating_row:
                    continue
                home_rating = home_rating_row[0]

                sql_query = f"select rating from elo_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1"
                cur.execute(sql_query)
                away_rating_row = cur.fetchone()
                if not away_rating_row:
                    continue
                away_rating = away_rating_row[0]

                x_margin = EloImpl.margin(home_rating, away_rating, True)
                margins.append([x_margin])
                match_ids.append(match_id)

    vals = []
    probs = model.predict_proba(margins)
    for match_id, prob in zip(match_ids, probs):
        home = 0
        away = 0
        draw = 0
        for res, i in zip(model.classes_, prob): 
            if res == "draw":
                draw = i
            elif res == "win":
                home = i
            else:
                away = i

        p = pred(match_id=match_id, home_win=home, away_win=away, draw=draw)
        vals.append(f"({p.match_id}, {p.home_win}, {p.away_win}, {p.draw})")

    joined = ",".join(vals)
    sql_query = f"insert into elo_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
    cur = conn.cursor()
    cur.execute(sql_query)
    conn.commit() 
