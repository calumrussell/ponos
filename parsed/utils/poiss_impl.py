import numpy as np
from math import factorial
from scipy.optimize import minimize
import os
import psycopg2

class Rating:
    def __init__(self, team_id, off_rating, def_rating, date) -> None:
        self.team_id = team_id
        self.off_rating = off_rating
        self.def_rating = def_rating
        self.date = date

def poiss_pmf(x, a):
    return ((a**x) * (np.exp(-a))) / factorial(x)

def _loss_poisson(par, matches):
    if par[0] < 0 or par[1] < 0:
        return np.inf

    loss = []
    end_year = matches[-1][2]
    off_pmf = [poiss_pmf(i, par[0]) for i in range(10)]
    def_pmf = [poiss_pmf(i, par[1]) for i in range(10)]
    for match in matches:
        goals_for = match[0]
        goals_against = match[1]
        year = match[2]
        ##If the match is from a different season then we weight down significantly
        multiplier = 1 if year == end_year else 0.25

        loss.append(multiplier * np.log(off_pmf[goals_for]))
        loss.append(multiplier * np.log(def_pmf[goals_against]))
    return -(sum(loss) / len(loss))

class Poisson:
    """
    Offensive and defensive strength modelled per team as two independent poisson. This
    is calculated over 20-game windows with 75% decay for matches in previous season.

    Calculation is very slow because we calculate each-window, each-team. Possible to
    calculate all teams simultaneously as each variable is independent but this
    significantly complicates window code.
    """
    def __init__(self):
        self.matches = {}
        self.rating_records = []
        self.window_length = 20

    def _optimize(self):
        ##Check that all teams have sufficient history
        if any(len(i) < self.window_length for i in self.matches.values()):
            return

        teams = self.matches.keys()
        for team in teams:
            matches = self.matches[team]
            init_params = np.random.uniform(low=0.1, high=1.0, size=2)
            res = minimize(
                fun=_loss_poisson,
                method='Nelder-Mead',
                x0=init_params,
                args=(matches[-self.window_length:]),
            )
            last_date = matches[-1][3]
            print(res.x)
            self.rating_records.append(Rating(team, res.x[0], res.x[1], last_date))
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
                where (year=2019 or year=2020 or year=2021 or year=2022 or year=2023 or year=2024)
                order by match.start_date asc"""
            cur.execute(query)
            
            rows = cur.fetchall()

            poiss = Poisson()
            for row in rows:
                if row[1] == -1 or row[2] == -1:
                    continue
                poiss.update(row[1], row[2], row[3], row[4], row[5], row[0])
            query = "insert into poiss_ratings(team_id, off_rating, def_rating, date) VALUES "
            values = []
            for rating in poiss.rating_records:
                values.append(f"({rating.team_id}, {rating.off_rating}, {rating.def_rating}, {rating.date})")
            query += ",".join(values)
            query += " on conflict(team_id, date) do update set off_rating=excluded.off_rating, def_rating=excluded.def_rating;"
            cur.execute(query)
        conn.commit()


