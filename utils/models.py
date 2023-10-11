from math import factorial
import numpy as np
np.set_printoptions(suppress=True)
from scipy.special import binom, gamma, gammaln
from scipy.optimize import minimize
from scipy.stats import poisson
 
def bipoiss_pmf(x, y, a, b, c):
    if x < 0 or y < 0:
        raise ValueError
 
    first = np.exp(-(a+b+c)) * ((a**x)/factorial(x) * (b**y)/factorial(y)) 
    vals = []
    vals.append(binom(x, 0) * binom(y, 0) * factorial(0) * (c/(a*b)) ** 0)
    for k in range(1, min(x,y)):
        vals.append(binom(x, k) * binom(y, k) * factorial(k) * (c/(a*b)) ** k)
    return first * sum(vals)
 
def poiss_pmf(x, a):
    return ((a**x) * (np.exp(-a))) / factorial(x)
 
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
 
def _loss_bivariate(par, matches):
    if par[0] < 0 or par[1] < 0 or par[2] < 0:
        return np.inf
 
    if par[0] < par[2] or par[1] < par[2]:
        return np.inf
 
    loss = 0
    for match in matches:
        loss -= np.log(bipoiss_pmf(match[0], match[1], par[0], par[1], par[2]))
    return loss
 
def _loss_weibull(par, matches):
    if par[0] < 0 or par[1] < 0:
        return np.inf
 
    loss = 0
    for match in matches:
        prob_dist_a = weibull_count_pmf(par[0], par[1])
        loss -= np.log(prob_dist_a[match[0]])
 
        prob_dist_b = weibull_count_pmf(par[2], par[3])
        loss -= np.log(prob_dist_b[match[1]])
    return loss
 
def _loss_poisson(par, matches):
    if par[0] < 0 or par[1] < 0:
        return np.inf
    loss = 0
    for match in matches:
        loss -= np.log(poiss_pmf(match[0], par[0]))
        loss -= np.log(poiss_pmf(match[1], par[1]))
    return loss
 
##When the shape is 1 then weibull_count is equal to poisson
weibull_count_pmf(3, 1)[2], poisson.pmf(2,3)
 
matches = list(zip(np.random.poisson(1.5, 1000), np.random.poisson(0.9, 1000)))
##This should come out to (1.5, 1, 0.9, 1), weibull equal to poisson when the
##shape variable is 1, because we have two independent poisson the shape of each
##should converge to 1, and the first variable is the mu for each poisson
res = minimize(
    fun=_loss_weibull,
    method='Nelder-Mead',
    x0=np.random.uniform(low=0.1, high=1.0, size=(1, 4)),
    args=(matches),
    options={"maxiter": 1000, "disp": "true"},
)
print(res.x)
 
matches = list(zip(np.random.poisson(1.5, 1000), np.random.poisson(0.9, 1000)))
##This should come out to (1.5, 0.9, 0.0), we are modelling two independent poissons
##so the correlation should be zero, has problems converging due, I think, to the
##correlation param being zero
res = minimize(
    fun=_loss_bivariate,
    method='Nelder-Mead',
    x0=np.random.uniform(low=0.1, high=1.0, size=(1, 3)),
    args=(matches),
    options={"maxiter": 10000, "disp": "true"},
)
print(res.x)
 
matches = list(zip(np.random.poisson(1.5, 1000), np.random.poisson(0.9, 1000)))
##This should come out to (1.5, 0.9)
res = minimize(
    fun=_loss_poisson,
    method='Nelder-Mead',
    x0=np.random.uniform(low=0.1, high=1.0, size=(1, 2)),
    args=(matches),
    options={"maxiter": 1000, "disp": "true"},
)
print(res.x)