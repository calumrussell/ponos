import psycopg2
import os
from common import Poisson
from sklearn.metrics import brier_score_loss

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    poiss = Poisson()
    with conn:
        with conn.cursor() as cur:
            cur.execute("select id from match where start_date < extract(epoch from now()) and (year=2022 or year=2021 or year=2019)")
            matches = [match[0] for match in cur.fetchall()]

            win_actuals = []
            win_probs = []
            draw_actuals = []
            draw_probs = []
            loss_actuals = []
            loss_probs = []

            for match in matches:
                #We only look at home team because it has all the information we need about the result
                cur.execute(f"select is_win, is_draw, is_loss from team_stats_full where is_home='t' and match_id={match}")
                match_result = cur.fetchone()

                cur.execute(f"select home_win, draw, away_win from poiss_pred where match_id={match}")
                match_probs = cur.fetchone()

                if match_result and match_probs:
                    win_actuals.append(match_result[0])
                    draw_actuals.append(match_result[1])
                    loss_actuals.append(match_result[2])

                    win_probs.append(match_probs[0])
                    draw_probs.append(match_probs[1])
                    loss_probs.append(match_probs[2])


            print(brier_score_loss(win_actuals, win_probs))
            print(brier_score_loss(draw_actuals, draw_probs))
            print(brier_score_loss(loss_actuals, loss_probs))

