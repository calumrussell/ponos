import numpy as np
from math import factorial
from scipy.optimize import minimize
from dataclasses import dataclass, asdict

@dataclass
class prediction:
    match_id: int
    home_win: float
    away_win: float
    draw: float

    def __str__(self):
        return f"({self.match_id}, {round(self.home_win, 4)}, {round(self.away_win, 4)}, {round(self.draw, 4)})"

@dataclass
class rating:
    team_id: int
    off_rating: float
    def_rating: float
    date: int

    def __str__(self):
        return f"({self.team_id}, {self.date}, {self.off_rating}, {self.def_rating})"

def poiss_pmf(x, a):
    return ((a**x) * (np.exp(-a))) / factorial(x)

def _loss_poisson(par, matches):
    if par[0] < 0 or par[1] < 0:
        return np.inf

    loss = []
    end_year = matches[-1][2]
    off_pmf = [poiss_pmf(i, par[0]) for i in range(15)]
    def_pmf = [poiss_pmf(i, par[1]) for i in range(15)]
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
        self.calculated = {}

    def _optimize(self):
        teams = self.matches.keys()
        for team in teams:
            matches = self.matches[team]
            ##This caused an issue where new teams don't get a rating until 75% into the season
            if len(matches) > self.window_length:
                window = matches[-self.window_length:]
            else:
                window = matches
            last_date = window[-1][3]
            if hash(str(team) + str(last_date)) not in self.calculated:
                init_params = np.random.uniform(low=0.1, high=1.0, size=2)
                res = minimize(
                    fun=_loss_poisson,
                    method='Nelder-Mead',
                    x0=init_params,
                    args=(window),
                )
                self.rating_records.append(str(rating(team, res.x[0], res.x[1], last_date)))
                self.calculated[hash(str(team) + str(last_date))] = 1
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
    
    def prediction(match_id, home_off_rating, home_def_rating, away_off_rating, away_def_rating):
        home_exp = np.exp(home_off_rating - away_def_rating)
        away_exp = np.exp(away_off_rating - home_def_rating)

        home_probs = [poiss_pmf(i, home_exp) for i in range(15)]
        away_probs = [poiss_pmf(i, away_exp) for i in range(15)]

        probs = np.outer(home_probs, away_probs)
        draw = (np.sum(np.diag(probs)))
        home_win = (np.sum(np.tril(probs, -1)))
        away_win = (np.sum(np.triu(probs, 1)))
        return str(prediction(match_id, home_win, away_win, draw))