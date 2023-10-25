import psycopg2
import os
import sys
import json
import pickle
from dataclasses import dataclass

from common import Shot
from build_model import ShotModel

@dataclass
class xg:
    match_id: int
    player_id: int
    event_id: int
    prob: float

    def __str__(self):
        return f"({self.match_id}, {self.player_id}, {self.event_id}, {self.prob})"

if __name__ == "__main__":
    with open("model.pkl", 'rb') as f:
        model = pickle.load(f)

    to_add = []
    for line in sys.stdin:
        data = json.loads(line)
        events = data['matchCentreData']['events']
        match_id = data['matchId']
        for event in events:
            if event.get('satisfiedEventsTypes'):
                types = event['satisfiedEventsTypes']
                if 10 in types:
                    shot = Shot(event)
                    shot_prob = model.predict(shot.distance, shot.angle, shot.shot_location, shot.shot_play, shot.body_part)[0][1]
                    to_add.append(str(xg(match_id, shot.player_id, shot.event_id, round(shot_prob, 3))))
    print(to_add)
