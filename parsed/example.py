from math import factorial
import numpy as np
from scipy.special import binom
from scipy.optimize import minimize
from scipy.stats import poisson
from sklearn.metrics import log_loss

def bipoiss_pmf(x, y, a, b, c, acc=50):
    if x < 0 or y < 0:
        raise ValueError

    first = np.exp(-(a+b+c)) * ((a**x)/factorial(x) * (b**y)/factorial(y)) 
    vals = []
    vals.append(binom(x, 0) * binom(y, 0) * factorial(0) * (c/(a*b)) ** 0)
    for k in range(1, min(x,y)):
        vals.append(binom(x, k) * binom(y, k) * factorial(k) * (c/(a*b)) ** k)
    return first * sum(vals)

#prob = bipoiss_pmf(1, 0, 1.2, 1.2, 0.5)

matches = list(zip(np.random.poisson(1.5, 1000), np.random.poisson(0.9, 1000)))

from itertools import product
scores = list(product(list(range(0,7)), list(range(0,7))))

def _loss_bivariate(par, matches):
    if par[0] < 0 or par[1] < 0 or par[2] < 0:
        return np.inf

    if par[0] < par[2] or par[1] < par[2]:
        return np.inf

    actuals = []
    probs = []
    for match in matches:
        result_mtx = np.zeros((7,7))
        for score in scores:
            prob = bipoiss_pmf(score[0], score[1], par[0], par[1], par[2])
            result_mtx[score[0]][score[1]] = prob

        draw = np.trace(result_mtx)
        win = np.triu(result_mtx).reshape(-1).sum()
        loss = np.tril(result_mtx).reshape(-1).sum()

        if match[0] > match[1]:
            actual = 'win'
        elif match[0] < match[1]:
            actual = 'loss'
        else:
            actual = 'draw'

        probs.append([win, draw, loss])
        actuals.append(actual)
    loss = log_loss(actuals, probs, labels=['win', 'draw', 'loss'])
    return loss

def _loss_poisson(par, matches):
    if par[0] < 0 or par[1] < 0:
        return np.inf

    actuals = []
    probs = []
    for match in matches:
        result_mtx = np.zeros((7,7))
        for score in scores:
            prob = poisson.pmf(score[0], par[0]) * poisson.pmf(score[1], par[1])
            result_mtx[score[0]][score[1]] = prob

        draw = np.trace(result_mtx)
        win = np.triu(result_mtx).reshape(-1).sum()
        loss = np.tril(result_mtx).reshape(-1).sum()

        if match[0] > match[1]:
            actual = 'win'
        elif match[0] < match[1]:
            actual = 'loss'
        else:
            actual = 'draw'

        probs.append([win, draw, loss])
        actuals.append(actual)
    loss = log_loss(actuals, probs, labels=['win', 'draw', 'loss'])
    print(loss, par)
    return loss
        
start = np.random.uniform(low=0.1, high=1.0, size=(1, 2))
res = minimize(
    fun=_loss_poisson,
    method='Nelder-Mead',
    x0=start,
    args=(matches)
)
print(res.fun)
print(res.x)
