import numpy as np
from scipy.special import gamma, gammaln
from scipy.optimize import minimize
import psycopg2
import os

class Rating:
    def __init__(self, team_id, off_rating, off_rating_spread, def_rating, def_rating_spread, date) -> None:
        self.team_id = team_id
        self.off_rating = off_rating
        self.off_rating_spread = off_rating_spread
        self.def_rating = def_rating
        self.def_rating_spread = def_rating_spread
        self.date = date

def weibull_count_pmf(rate, shape, precision = 20, outcomes = 10, time = 1):
    cache = np.zeros((outcomes, precision))
 
    def inner(j, m):
        return np.exp(gammaln(shape*(j-m)+1) - gammaln(j-m+1))
 
    def outer(j, n, alpha):
        return ((-1)**(j+n) * (rate * time ** shape)**j*alpha)/gamma(shape*j+1)
 
    def base(n):
        if n == 0:
            vals = np.array([
                inner(i, 0) 
                for i 
                in range(precision)
            ])
            cache[n] = vals
            return vals
        else:
            buf = np.zeros(precision)
            for i, j in enumerate(range(n, n+precision)):
                new_vals = np.array([
                    inner(j, i) 
                    for i 
                    in range(n-1, j)
                ])
                last = cache[n-1][:len(new_vals)]
                buf[i] = np.dot(last, new_vals)
            cache[n] = buf
            return buf
 
    result_buff = np.array([
            sum(outer(
                np.array(list(range(e, e+precision))),
                e,
                base(e)
            )) 
            for e 
            in range(outcomes)
        ])
    for i, j in enumerate(result_buff):
        if j < 0:
            result_buff[i] = np.inf
    return result_buff
 
def _loss_weibull(par, matches):
    if par[0] < 0 or par[1] < 0 or par[2] < 0 or par[3] < 0:
        return np.inf
 
    loss = []
    end_year = matches[-1][2]
    prob_dist_a = weibull_count_pmf(par[0], par[1])
    prob_dist_b = weibull_count_pmf(par[2], par[3])
    for match in matches:
        goals_for = match[0]
        goals_against = match[1]
        year = match[2]
        ##If the match is from a different season then we weight down significantly
        multiplier = 1 if year == end_year else 0.25
        loss.append(multiplier * np.log(prob_dist_a[goals_for]))
        loss.append(multiplier * np.log(prob_dist_b[goals_against]))
    return -(sum(loss) / len(loss))

class Weibull:
    def __init__(self):
        self.matches = {}
        self.rating_records = []
        self.window_length = 20
        self.calculated = {}

    def _optimize(self):
        ##Check that all teams have sufficient history
        if any(len(i) < self.window_length for i in self.matches.values()):
            return

        teams = self.matches.keys()
        for team in teams:
            matches = self.matches[team]
            if len(matches) > self.window_length:
                last_date = matches[-1][3]
                if hash(str(team) + str(last_date)) not in self.calculated:
 
                    init_params = np.random.uniform(low=0.1, high=1.0, size=4)
                    res = minimize(
                        fun=_loss_weibull,
                        method='Nelder-Mead',
                        x0=init_params,
                        args=(matches[-self.window_length:]),
                    )
                    self.rating_records.append(Rating(team, res.x[0], res.x[1], res.x[2], res.x[3], last_date))
                    self.calculated[hash(str(team) + str(last_date))] = 1
        return
    
    def flush(self, func):
        if len(self.rating_records) > 10:
            print(self.rating_records)
            func(self.rating_records)
            self.rating_records = []
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
