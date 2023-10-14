import numpy as np
from math import factorial
from scipy.optimize import minimize
import os
import psycopg2
from sklearn.preprocessing import OneHotEncoder

def poiss_pmf(x, a):
    return ((a**x) * (np.exp(-a))) / factorial(x)

def _loss_poisson(par, matches, teams_map):
    if any(v < 0 for v in par):
        return np.inf

    loss = 0
    for match in matches:
        goals = match[0]
        team = match[1]
        team_pos = teams_map[team]
        loss -= np.log(poiss_pmf(goals, par[team_pos]))
    return loss

class Poisson:
    def __init__(self):
        self.params = []
        self.matches = []
        self.optimizer_burn = 50

    def optimize(self):
        teams = set()
        for row in self.matches:
            teams.add(row[1])

        count = len(teams)
        init_params = np.random.uniform(low=0.1, high=1.0, size=(1, count))

        teams_map = {j: i for i,j in enumerate(teams)}
        res = minimize(
            fun=_loss_poisson,
            method='Nelder-Mead',
            ##always intialize to random values at start because we aren't using rolling
            ##window
            x0=init_params[0],
            args=(self.matches, teams_map),
            options={"disp": "true"},
        )
        self.params = { i: j for i, j in  zip(teams, res.x) }
        return

    def update(self, home_team, away_team, home_goals, away_goals):
        self.matches.append([home_goals, home_team])
        self.matches.append([away_goals, away_team])
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
                away.goal as away_goal
                from match
                left join team_stats_full as home
                    on home.team_id=match.home_id and home.match_id=match.id
                left join team_stats_full as away
                    on away.team_id=match.away_id and away.match_id=match.id
                where tournament_id=2 and year=2022
                order by match.start_date asc"""
            cur.execute(query)
            
            rows = cur.fetchall()

            poiss = Poisson()
            for row in rows:
                if row[1] == -1 or row[2] == -1:
                    continue
                poiss.update(row[1], row[2], row[3], row[4])
            poiss.optimize()
            print(poiss.params)
