from math import factorial
import numpy as np
np.set_printoptions(suppress=True)
from scipy.special import binom
from scipy.optimize import minimize
import os
import psycopg2

def bipoiss_pmf(x, y, a, b, c):
    if x < 0 or y < 0:
        raise ValueError
 
    first = np.exp(-(a+b+c)) * ((a**x)/factorial(x) * (b**y)/factorial(y)) 
    vals = []
    vals.append(binom(x, 0) * binom(y, 0) * factorial(0) * (c/(a*b)) ** 0)
    for k in range(1, min(x,y)):
        vals.append(binom(x, k) * binom(y, k) * factorial(k) * (c/(a*b)) ** k)
    return first * sum(vals)

def _loss_bivariate(par, matches):
    if par[0] < 0 or par[1] < 0 or par[2] < 0:
        return np.inf
 
    if par[0] < par[2] or par[1] < par[2]:
        return np.inf
 
    loss = 0
    for match in matches:
        loss -= np.log(bipoiss_pmf(match[0], match[1], par[0], par[1], par[2]))
    return loss

class BivariatePoisson:
    """
    This model is working but the correlation parameter is coming back with zero so this
    basically equivalent to two independent poissons, which is what the other poisson
    model is. Worth keeping this code until I work out if I have made a mistake
    somewhere.

    Tried calculating correlation parameter for each team but this impacts the
    interpretability of the model because high-strength teams have their strength rating
    deflated.
    """
    def __init__(self):
        self.matches = {}
        self.rating_records = []
        self.window_length = 20
        self.params = {}
        self.corr = 0.1

    def _optimize(self):
        ##Check that all teams have sufficient history
        if any(len(i) < self.window_length for i in self.matches.values()):
            return

        teams = self.matches.keys()
        for team in teams:
            matches = self.matches[team]
            init_params = np.random.uniform(low=0.1, high=1.0, size=2)
            with_corr = np.append(init_params, self.corr)
            res = minimize(
                fun=_loss_bivariate,
                method='Nelder-Mead',
                x0=with_corr,
                args=(matches[-self.window_length:]),
            )
            self.params[team] = res.x
            self.corr = res.x[2]
            #last_date = matches[-1][3]
        return

    def update(self, home_team, away_team, home_goals, away_goals, year, date):
        if home_team not in self.matches:
            self.matches[home_team] = []
        if away_team not in self.matches:
            self.matches[away_team] = []
        
        self.matches[home_team].append([home_goals, away_goals, year, date])
        self.matches[away_team].append([away_goals, home_goals, year, date])
        self._optimize()
        return

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
            query = """
                select 
                match.start_date,
                match.home_id,
                match.away_id,
                home.goal as home_goal,
                away.goal as away_goal,
                year
                from match
                left join team_stats_full as home
                    on home.team_id=match.home_id and home.match_id=match.id
                left join team_stats_full as away
                    on away.team_id=match.away_id and away.match_id=match.id
                where (year=2022 or year=2023) and tournament_id=2
                order by match.start_date asc"""
            cur.execute(query)
            
            rows = cur.fetchall()

            poiss = BivariatePoisson()
            for row in rows:
                if row[1] == -1 or row[2] == -1:
                    continue
                poiss.update(row[1], row[2], row[3], row[4], row[5], row[0])
            print(poiss.params)
            """
            query = "insert into poiss_ratings(team_id, off_rating, def_rating, date) VALUES "
            values = []
            for rating in poiss.rating_records:
                values.append(f"({rating.team_id}, {rating.off_rating}, {rating.def_rating}, {rating.date})")
            query += ",".join(values)
            query += " on conflict do nothing;"
            cur.execute(query)
        conn.commit()
        """


