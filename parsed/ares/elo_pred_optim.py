
if __name__ == "__main__":
    from sklearn.linear_model import LogisticRegression
    import os
    import psycopg2
    import pickle
    from common import EloImpl

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    x = []
    y = []
    with conn:
        with conn.cursor() as cur:
            cur.execute("select distinct(start_date) as start_date from match where tournament_id=2 and year=2022")
            dates = [row[0] for row in cur.fetchall()]
            for date in dates:
                cur.execute(f"select home_id, away_id, start_date, id from match where start_date = {date}")
                for home_id, away_id, start_date, match_id in cur:
                    cur.execute(f"select rating from elo_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1")
                    home_rating_row = cur.fetchone()
                    if not home_rating_row:
                        continue
                    home_rating = home_rating_row[0]

                    cur.execute(f"select rating from elo_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1")
                    away_rating_row = cur.fetchone()
                    if not away_rating_row:
                        continue
                    away_rating = away_rating_row[0]

                    home_x_margin = EloImpl.margin(home_rating, away_rating, True)

                    cur.execute(f"select goal, goal_own from team_stats where team_id={home_id} and match_id={match_id}")
                    home_goals_row = cur.fetchone()
                    if not home_goals_row:
                        continue
                    home_goals = home_goals_row[0]
                    home_own_goals = home_goals_row[1]

                    cur.execute(f"select goal, goal_own from team_stats where team_id={away_id} and match_id={match_id}")
                    away_goals_row = cur.fetchone()
                    if not away_goals_row:
                        continue
                    away_goals = away_goals_row[0]
                    away_own_goals = away_goals_row[1]

                    x.append([home_x_margin])
                    if home_goals + away_own_goals > away_goals + home_own_goals:
                        y.append('win')
                    elif home_goals + away_own_goals == away_goals + home_own_goals:
                        y.append('draw')
                    else:
                        y.append('lose')

    reg = LogisticRegression(multi_class="multinomial").fit(x, y)
    print(reg.score(x,y))
    with open('model.pkl', 'wb') as f:
        pickle.dump(reg, f)

