import psycopg2
import os
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

    def to_row(self):
        return f"({self.match_id}, {self.player_id}, {self.event_id}, {self.prob})"

if __name__ == "__main__":
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PWD"),
        dbname=os.getenv("DB_NAME"),
        port=os.getenv("DB_PORT")
    )

    with open("model.pkl", 'rb') as f:
        model = pickle.load(f)

    with conn:
        with conn.cursor() as cur:
            query = """
                select 
                data, id
                from 
                match_data
                where id in (select id from match where year=2022) limit 500
                """
            cur.execute(query)

            to_add = []
            rows = cur.fetchall()
            for row in rows:
                events = row[0]['matchCentreData']['events']
                match_id = row[1]
                for event in events:
                    if event.get('satisfiedEventsTypes'):
                        types = event['satisfiedEventsTypes']
                        if 10 in types:
                            shot = Shot(event)
                            shot_prob = model.predict(shot.distance, shot.angle, shot.shot_location, shot.shot_play, shot.body_part)[0][1]
                            to_add.append(xg(match_id, shot.player_id, shot.event_id, round(shot_prob, 3)).to_row())
            
            insert_query = "insert into xg(match_id, player_id, event_id, prob) VALUES "
            insert_query += ",".join(to_add)
            insert_query += "on conflict (match_id, player_id, event_id) do update set prob=excluded.prob"
            cur.execute(insert_query)

        conn.commit()
