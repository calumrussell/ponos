from dataclasses import dataclass, asdict

@dataclass
class pred:
    match_id: int
    home_win: float
    away_win: float
    draw: float

if __name__ == "__main__":
    import pickle
    import os
    import sys
    import json
    from common import EloImpl

    with open("model.pkl", 'rb') as f:
        model = pickle.load(f)

    margins = []
    match_ids = []
    for line in sys.stdin:
        split = line.split(",")
        """
        Expects match_id, home_rating, away_rating
        """
        match_id = int(split[0])
        home_rating = int(split[1])
        away_rating = int(split[2])
        margins.append([EloImpl.margin(home_rating, away_rating, True)])
        match_ids.append(match_id)

    probs = model.predict_proba(margins)
    for match_id, prob in zip(match_ids, probs):
        home = 0
        away = 0
        draw = 0
        for res, i in zip(model.classes_, prob): 
            if res == "draw":
                draw = i
            elif res == "win":
                home = i
            else:
                away = i
        print(json.dumps(asdict(pred(match_id=match_id, home_win=home, away_win=away, draw=draw))))
