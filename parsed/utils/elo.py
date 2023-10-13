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
        self.rating_burn = 20
        self.result_buffer = []
        self.result_buffer_len = 200
        self.optimizer_cooldown = 100
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
 
    def update(self, t1, t2, t1_goals, t2_goals, is_home):
        if t1 not in self.ratings:
            self.ratings[t1] = 1500
            self.match_count[t1] = 0
        if t2 not in self.ratings:
            self.ratings[t2] = 1500
            self.match_count[t2] = 0
 
        ratings_diff = self.ratings[t1] - self.ratings[t2]
        goal_diff = t1_goals - t2_goals
 
        if self.match_count[t1] > self.rating_burn and self.match_count[t2] > self.rating_burn:
            self.result_buffer.append([ratings_diff, t1_goals - t2_goals])
 
        if self.regression:
            for result, prob in zip(self.regression.classes_, self.regression.predict_proba([[ratings_diff]]).flatten()):
                if result == "win":
                    self.actuals.append(1 if goal_diff > 0 else 0)
                elif result == "draw":
                    self.actuals.append(1 if goal_diff == 0 else 0)
                else:
                    self.actuals.append(1 if goal_diff < 0 else 0)
                self.predictions.append(prob)
 
        x_margin = Elo.expected_margin(self.ratings[t1], self.ratings[t2], self.p, self.h if is_home else -self.h)
        rating_change = Elo.rating_change(self.k, t1_goals - t2_goals, x_margin)
 
        self.ratings[t1] += rating_change
        self.match_count[t1] += 1
 
        self._optimizer_update()
 
if __name__ == "__main__":
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PWD"),
        dbname=os.getenv("DB_NAME"),
        port=os.getenv("DB_PORT")
    )

    with conn:
        with conn.cursor() as cur:
            query = "select start_date, ts.team_id, ts.opp_id, goal, opp_goal, is_home from team_stats_joined as ts left join match on ts.match_id=match.id where tournament_id=2 and year=2012 order by start_date asc"
            cur.execute(query)
            
            rows = cur.fetchall()

            elo = Elo()
            for row in rows:
                elo.update(row[1], row[2], row[3], row[4], row[5])

            print(brier_score_loss(elo.actuals, elo.predictions))

