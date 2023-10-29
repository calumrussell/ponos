@dataclass
class pred:
    match_id: int
    home_win: float
    away_win: float
    draw: float

if __name__ == "__main__":
    import pickle
    import os
    from common import EloImpl

    with open("model.pkl", 'rb') as f:
        model = pickle.load(f)

    to_add = []
    for line in sys.stdin:
        """
        Expects match_id, home_rating, away_rating
        """
        home_x_margin = EloImpl.margin(home_rating, away_rating, True)
        res.append(home_x_margin)
        res = model.predict_proba([[home_x_margin]])


