from sklearn.metrics import mean_squared_error, brier_score_loss
from scipy.optimize import minimize
from sklearn.linear_model import LogisticRegression
import os
import psycopg2

class Elo:
    expected_margin = lambda x_rating, y_rating, p, home_adv: ((x_rating-y_rating)/p) + home_adv
    rating_change = lambda k, actual_margin, expected_margin: k*(actual_margin-expected_margin)
 
    def __init__(self, k=15, p=250):
        self.ratings = {}
        self.match_count = {}
        self.k = k
        self.p = p
        self.h = 0.2
        self.rating_burn = 5
        self.result_buffer = []
        self.result_buffer_len = 150
        self.optimizer_cooldown = 150
        self.optimizer_heat = 101
        self.regression = None
        self.predictions = []
        self.actuals = []
 
    def _optimize_regression(results):
        classes = []
        for result in results:
            if result[1] == 0:
                classes.append('draw')
            elif result[1] > 0:
                classes.append('win')
            else:
                classes.append('loss')
        inputs = [[result[0]] for result in results]
        return LogisticRegression(multi_class="multinomial").fit(inputs, classes)
 
    def _optimize_elo(par_vec, matches):
        actual = []
        expected = []
        for match in matches:
            expected_margin_t1 = match[0] / par_vec[0]
 
            actual.append(match[1])
            expected.append(expected_margin_t1)
        return mean_squared_error(actual, expected)
 
    def _optimizer_update(self):
        if len(self.result_buffer) > self.result_buffer_len:
            if self.optimizer_heat > self.optimizer_cooldown:
                self.result_buffer = self.result_buffer[-self.result_buffer_len:]
 
                ##Need to optimize p and k
                opt_res = minimize(
                    fun=Elo._optimize_elo,
                    method='Nelder-Mead',
                    x0=[self.p, self.h],
                    args=(self.result_buffer))
                self.p = opt_res.x[0]
                self.h = opt_res.x[1]
 
                self.regression = Elo._optimize_regression(self.result_buffer)
                self.optimizer_heat = 0
            else:
                self.optimizer_heat += 1
 
    def update(self, t1, t2, t1_goals, t2_goals):
        if t1 not in self.ratings:
            self.ratings[t1] = 1500
            self.match_count[t1] = 0
        if t2 not in self.ratings:
            self.ratings[t2] = 1500
            self.match_count[t2] = 0
 
        ratings_diff = self.ratings[t1] - self.ratings[t2]
        goal_diff = t1_goals - t2_goals
 
        if self.match_count[t1] > self.rating_burn and self.match_count[t2] > self.rating_burn:
            self.result_buffer.append([self.ratings[t1] - self.ratings[t2], t1_goals - t2_goals])
 
        if self.regression:
            for result, prob in zip(self.regression.classes_, self.regression.predict_proba([[ratings_diff]]).flatten()):
                if result == "win":
                    self.actuals.append(1 if goal_diff > 0 else 0)
                elif result == "draw":
                    self.actuals.append(1 if goal_diff == 0 else 0)
                else:
                    self.actuals.append(1 if goal_diff < 0 else 0)
                self.predictions.append(prob)
 
        t1_x_margin = Elo.expected_margin(self.ratings[t1], self.ratings[t2], self.p, self.h)
        t1_rating_change = Elo.rating_change(self.k, t1_goals - t2_goals, t1_x_margin)

        t2_x_margin = Elo.expected_margin(self.ratings[t2], self.ratings[t1], self.p, self.h)
        t2_rating_change = Elo.rating_change(self.k, t2_goals - t1_goals, t2_x_margin)
 
        self.ratings[t1] += t1_rating_change
        self.match_count[t1] += 1

        self.ratings[t2] += t2_rating_change
        self.match_count[t2] += 1
 
        self._optimizer_update()
 
if __name__ == "__main__":
    conn = psycopg2.connect(os.getenv("DB_CONN"))

    with conn:
        with conn.cursor() as cur:
            query = """
                select 
                match.start_date,
                match.home_id,
                match.away_id,
                home.goal as home_goal,
                away.goal as away_goal
                from match
                left join team_stats_full as home
                    on home.team_id=match.home_id and home.match_id=match.id
                left join team_stats_full as away
                    on away.team_id=match.away_id and away.match_id=match.id
                where year=2021 or year=2022
                order by match.start_date asc"""
            cur.execute(query)
            
            rows = cur.fetchall()

            elo = Elo()
            for row in rows:
                if row[3] and row[4]:
                    elo.update(row[1], row[2], row[3], row[4])

            print(elo.k, elo.p, elo.h)
            print(brier_score_loss(elo.actuals, elo.predictions))

