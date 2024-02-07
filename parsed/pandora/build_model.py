import os
import pickle
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split
from sklearn.model_selection import StratifiedKFold
from sklearn.model_selection import RandomizedSearchCV, GridSearchCV
import xgboost as xgb

from common import Shot

class ShotXGBoost:
    def predict(self, x):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.predict_proba(x)

    def score(self):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.score(self.x_test, self.y_test)

    def run(self, x, y):
        params = {
            'min_child_weight': [1, 5, 10],
            'gamma': [0.5, 1, 1.5, 2, 5],
            'subsample': [0.6, 0.8, 1.0],
            'colsample_bytree': [0.6, 0.8, 1.0],
            'max_depth': [3, 4, 5]
        }

        xgb_model = xgb.XGBClassifier(tree_method='hist')
        random_search = RandomizedSearchCV(
                xgb_model, 
                param_distributions=params, 
                scoring='roc_auc', 
                n_jobs=4, 
                cv=5, 
                verbose=3, 
                random_state=1001
        )

        random_search.fit(x,y)
        self.model = random_search.best_estimator_
        print(random_search.best_score_)
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
        params = {
            'solver': ['newton-cg', 'lbfgs', 'liblinear'],
            'penalty': ['l2'],
            'C': [100, 10, 1.0, 0.1, 0.01],
        }


        logistic_model = LogisticRegression(max_iter=2000)
        random_search = RandomizedSearchCV(
                logistic_model, 
                param_distributions=params, 
                scoring='roc_auc', 
                n_jobs=4, 
                cv=5, 
                verbose=3, 
                random_state=1001
        )
        random_search.fit(x,y)
        self.model = random_search.best_estimator_
        print(random_search.best_score_)
        return

    def score(self):
        if not self.model:
            raise ValueError("Model hasn't been initialized")
        return self.model.score(self.x_test, self.y_test)

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
        return self.model.score()

    def add_shot(self, distance, angle, location, play, body_part, big_chance, fast_break, first_touch, assisted, result):
        self.y.append([result])
        self.x.append([distance, angle, distance * angle, big_chance, fast_break, first_touch, assisted, location, play, body_part])

if __name__ == "__main__":
    import psycopg2
    conn = psycopg2.connect(os.getenv("DB_CONN"))

    model = ShotModel(ShotLogisticRegression())
    with conn:
        with conn.cursor() as cur:
            query = """
                select 
                data
                from 
                match_data
                where id in (select id from match where tournament_id=2 and (year=2023 or year=2022 or year=2021 or year=2020 or year=2019))
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
