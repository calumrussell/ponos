import psycopg2
import os
from common import Poisson
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import brier_score_loss

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    poiss = Poisson()
    with conn:
        with conn.cursor() as cur:
            ## Build test set
            cur.execute("select id, start_date, home_id, away_id from match where start_date < extract(epoch from now()) and (year=2018 or year=2017)")
            matches = [(match[0], match[1], match[2], match[3]) for match in cur.fetchall()]

            x = []
            y = []

            for match, start_date, home_id, away_id in matches:
                #We only look at home team because it has all the information we need about the result
                cur.execute(f"select is_win, is_draw, is_loss from team_stats_full where is_home='t' and match_id={match}")
                match_result = cur.fetchone()

                cur.execute(f"select off_rating, def_rating from poiss_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1")
                home_rating = cur.fetchone()

                cur.execute(f"select off_rating, def_rating from poiss_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1")
                away_rating = cur.fetchone()
                if not home_rating or not away_rating:
                    continue

                home_match_rating = home_rating[0] * away_rating[1]
                away_match_rating = home_rating[1] * away_rating[0]

                if match_result[0] == 1:
                    y.append("win")
                elif match_result[1] == 1:
                    y.append("draw")
                else:
                    y.append("loss")

                x.append([home_match_rating - away_match_rating, home_match_rating * away_match_rating])

            reg = LogisticRegression(multi_class='multinomial')
            reg.fit(x, y)

            cur.execute("select id, start_date, home_id, away_id from match where start_date < extract(epoch from now()) and (year=2022 or year=2021 or year=2019)")
            matches = [(match[0], match[1], match[2], match[3]) for match in cur.fetchall()]

            ratings = []
            outcomes = []
            for match, start_date, home_id, away_id in matches:
                cur.execute(f"select is_win, is_draw, is_loss from team_stats_full where is_home='t' and match_id={match}")
                match_result = cur.fetchone()

                cur.execute(f"select off_rating, def_rating from poiss_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1")
                home_rating = cur.fetchone()

                cur.execute(f"select off_rating, def_rating from poiss_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1")
                away_rating = cur.fetchone()
                if not home_rating or not away_rating:
                    continue

                home_match_rating = home_rating[0] * away_rating[1]
                away_match_rating = home_rating[1] * away_rating[0]
                ratings.append([home_match_rating - away_match_rating, home_match_rating * away_match_rating])

                outcomes.append(match_result)


            actuals = []
            pred = []

            probs = reg.predict_proba(ratings)
            for outcome, prob in zip(outcomes, probs):
                draw = 0
                win = 0
                loss = 0

                for i, j in zip(reg.classes_, prob):
                    if i == "draw": 
                        draw = j
                    elif i == "win": 
                        win = j
                    else:
                        loss = j

                actuals.extend(outcome)
                pred.extend([win, loss, draw])
            print(actuals, pred)
            print(brier_score_loss(actuals, pred))
