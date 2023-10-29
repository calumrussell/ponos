class DefaultEloModel:
    def __init__(self):
        self.k = 15
        self.p = 320
        self.h = 0.17

class EloImpl:
    """
    Uses computed variables, includes home strength parameter.

    Because this model uses joint probability we have a dependency on both teams having
    an updated rating. Therefore, we return updated rating for both teams upon each
    calculation.

    Defaults to 1500 rating and has no rating burn.
    """
    expected_margin = lambda x_rating, y_rating, p, home_adv: ((x_rating-y_rating)/p) + home_adv
    rating_change = lambda actual_margin, expected_margin, k: k*(actual_margin-expected_margin)

    def default_rating():
        return 1500

    def ratings(home_id,  away_id, home_goals, away_goals, home_rating, away_rating):
        model = DefaultEloModel()
        home_x_margin = EloImpl.expected_margin(home_rating, away_rating, model.p, model.h)
        home_rating_change = EloImpl.rating_change(home_goals - away_goals, home_x_margin, model.k)

        away_x_margin = EloImpl.expected_margin(away_rating, home_rating, model.p, -model.h)
        away_rating_change = EloImpl.rating_change(away_goals - home_goals, away_x_margin, model.k)
        return (home_rating + home_rating_change, away_rating + away_rating_change)

    def margin(rating, opp_rating, is_home):
        model = DefaultEloModel()
        return EloPred.expected_margin(home_rating, away_rating, model.p, model.h if is_home else -model.h)

