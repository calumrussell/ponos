import os
import pickle
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
import xgboost as xgb

from common import Shot

class ShotXGBoost:
    def predict(self, x):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.predict_proba(x)

    def score(self, x, y):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.score(x, y)

    def run(self, x, y):

        x_train, x_test, y_train, y_test = train_test_split(x, y, stratify=y, random_state=94)
        self.model = xgb.XGBClassifier(tree_method='hist', early_stopping_rounds=2).fit(x_train, y_train, eval_set=[(x_test, y_test)])
        return

    def __init__(self):
        self.model = None

class ShotLogisticRegression:
    def predict(self, x):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.predict_proba(x)

    def params(self):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return [self.model.intercept_[0], *list(self.model.coef_[0])]

    def run(self, x, y):
        self.model = LogisticRegression(max_iter=1000).fit(x, y)
        return

    def score(self, x, y):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.score(x, y)

    def __init__(self):
        self.model = None

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

    def __init__(self, model):
        self.x = []
        self.y = []
        self.model = model

    def baseline(self):
        vals = [i[0] for i in self.y]
        return 1 - (sum(vals) / len(vals))
    
    def predict(self, distance, angle, location, play, body_part, big_chance, fast_break, first_touch, assisted):
        one_hot = [[location, play, body_part]]
        one_hot_x = self.encoder.transform(one_hot).toarray()
        x = [[distance, angle, distance * angle, big_chance, fast_break, first_touch, assisted, *one_hot_x[0]]]
        return self.model.predict(x)
    
    def params(self):
        return self.model.params()

    def run(self):
        self.encoder = OneHotEncoder(handle_unknown='ignore', categories=[ShotModel.location, ShotModel.play, ShotModel.body_part])
        one_hot = [i[7:] for i in self.x]
        self.encoder.fit(one_hot)
        one_hot_x = self.encoder.transform(one_hot).toarray()
        self.x_formatted = [[i[0], i[1], i[2], i[3], i[4], i[5], i[6], *j] for i, j in zip(self.x, one_hot_x)]
        self.model.run(self.x_formatted, self.y)
    
    def score(self):
        return self.model.score(self.x_formatted, self. y)

    def add_shot(self, distance, angle, location, play, body_part, big_chance, fast_break, first_touch, assisted, result):
        self.y.append([result])
        self.x.append([distance, angle, distance * angle, big_chance, fast_break, first_touch, assisted, location, play, body_part])

if __name__ == "__main__":
    import psycopg2
    conn = psycopg2.connect(os.getenv("DB_CONN"))

    model = ShotModel(ShotXGBoost())
    with conn:
        with conn.cursor() as cur:
            query = """
                select 
                data
                from 
                match_data
                where id in (select id from match where tournament_id=2 and (year=2023 or year=2022 or year=2021))
                """
            cur.execute(query)
            for row in cur:
                events = row[0]['matchCentreData']['events']
                for event in events:
                    if event.get('satisfiedEventsTypes'):
                        types = event['satisfiedEventsTypes']
                        if 10 in types:
                            shot = Shot(event)
                            model.add_shot(shot.distance, shot.angle, shot.shot_location, shot.shot_play, shot.body_part, shot.big_chance, shot.fast_break, shot.first_touch, shot.assisted, shot.result)
            model.run()
            print(model.score(), model.baseline())
    
    with open('model.pkl', 'wb') as f:
        pickle.dump(model, f)
