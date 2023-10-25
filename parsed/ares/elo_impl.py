class Rating:
    def __init__(self, team_id, rating, date) -> None:
        self.team_id = team_id
        self.rating = rating
        self.date = date

class DefaultEloModel:
    def __init__(self):
        self.k = 15
        self.p = 320
        self.h = 0.17

class EloImpl:
    """
    Uses computed variables, includes home strength parameter.
    """
    expected_margin = lambda x_rating, y_rating, p, home_adv: ((x_rating-y_rating)/p) + home_adv
    rating_change = lambda actual_margin, expected_margin, k: k*(actual_margin-expected_margin)

    def __init__(self, model):
        self.ratings = {}
        self.team_match_count = {}
        self.rating_record = []
        self.model = model
        self.rating_burn = 5

    ## Must update rating for both teams at once, if we don't do this then we update one
    ## team and then the updated rating will be used again.
    def update(self, t1, t2, t1_goals, t2_goals, start_date):
        if t1 not in self.ratings:
            self.ratings[t1] = 1500
            self.team_match_count[t1] = 0
            self.rating_record.append(Rating(t1, 1500, start_date))

        if t2 not in self.ratings:
            self.ratings[t2] = 1500
            self.team_match_count[t2] = 0
            self.rating_record.append(Rating(t2, 1500, start_date))

        t1_x_margin = EloImpl.expected_margin(self.ratings[t1], self.ratings[t2], self.model.p, self.model.h)
        t1_rating_change = EloImpl.rating_change(t1_goals - t2_goals, t1_x_margin, self.model.k)

        t2_x_margin = EloImpl.expected_margin(self.ratings[t2], self.ratings[t1], self.model.p, -self.model.h)
        t2_rating_change = EloImpl.rating_change(t2_goals - t1_goals, t2_x_margin, self.model.k)
 
        self.ratings[t1] += t1_rating_change
        self.ratings[t2] += t2_rating_change
        self.rating_record.append(Rating(t1, self.ratings[t1], start_date))
        self.rating_record.append(Rating(t2, self.ratings[t2], start_date))
        self.team_match_count[t1] += 1
        self.team_match_count[t2] += 1

