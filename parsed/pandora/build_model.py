import psycopg2
import os
import pickle
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import OneHotEncoder

from common import Shot

class ShotModel:
    
    location = [
        'BoxCentre',
        'BoxLeft',
        'BoxRight',
        'DeepBoxLeft',
        'DeepBoxRight',
        'OutOfBoxCentre',
        'OutOfBoxDeepLeft',
        'OutOfBoxDeepRight',
        'OutOfBoxLeft',
        'OutOfBoxRight',
        'SmallBoxCentre',
        'SmallBoxLeft',
        'SmallBoxRight',
        'ThirtyFivePlusCentre',
        'ThirtyFivePlusLeft',
        'ThirtyFivePlusRight'] 
    
    play = [
        'DirectFreekick',
        'FastBreak',
        'FromCorner',
        'Penalty',
        'RegularPlay',
        'SetPiece',
        'ThrowinSetPiece']
    
    body_part = [
        'Head',
        'LeftFoot',
        'OtherBodyPart',
        'RightFoot']

    def __init__(self):
        self.x = []
        self.y = []

    def baseline(self):
        vals = [i[0] for i in self.y]
        return 1 - (sum(vals) / len(vals))
    
    def predict(self, distance, angle, location, play, body_part):
        one_hot = [[location, play, body_part]]
        one_hot_x = self.encoder.transform(one_hot).toarray()
        x = [[distance, angle, *one_hot_x[0]]]
        return self.reg.predict_proba(x)
    
    def params(self):
        return [self.reg.intercept_[0], *list(self.reg.coef_[0])]

    def run(self):
        self.encoder = OneHotEncoder(handle_unknown='ignore', categories=[ShotModel.location, ShotModel.play, ShotModel.body_part])
        one_hot = [i[2:] for i in self.x]
        self.encoder.fit(one_hot)
        one_hot_x = self.encoder.transform(one_hot).toarray()
        self.x_formatted = [[i[0], i[1], *j] for i, j in zip(self.x, one_hot_x)]
        self.reg = LogisticRegression().fit(self.x_formatted, self.y)
    
    def score(self):
        return self.reg.score(self.x_formatted, self.y)

    def add_shot(self, distance, angle, location, play, body_part, result):
        self.y.append([result])
        self.x.append([distance, angle, location, play, body_part])

if __name__ == "__main__":
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PWD"),
        dbname=os.getenv("DB_NAME"),
        port=os.getenv("DB_PORT")
    )

    model = ShotModel()
    with conn:
        with conn.cursor() as cur:
            query = """
                select 
                data
                from 
                match_data
                where id in (select id from match where tournament_id=2 and (year=2024 or year=2023 or year=2022 or year=2021))
                """
            cur.execute(query)

            rows = cur.fetchall()
            for row in rows:
                events = row[0]['matchCentreData']['events']
                for event in events:
                    if event.get('satisfiedEventsTypes'):
                        types = event['satisfiedEventsTypes']
                        if 10 in types:
                            shot = Shot(event)
                            model.add_shot(shot.distance, shot.angle, shot.shot_location, shot.shot_play, shot.body_part, shot.result)
            model.run()
            print(model.score(), model.baseline())
    
    with open('model.pkl', 'wb') as f:
        pickle.dump(model, f)