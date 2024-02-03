Null: 0.8927
    Condition: Shot miss

Basic Logistic Model: 0.9010
    Hash: ba2bf24
    Features:
        * Shot distance (numeric) - distance from shot to middle of goal
        * Shot angle (numeric) - angle between the player and both goal posts
        * Shot location (categorical) - location on the pitch
        * Shot play (categorical) - type of play which generated the shot
        * Shot body part (categorical)

Logistic Model #2: 0.9030
    Hash: a549a7f
    Params:
        << Basic
        * Max iter increased to 500
    Features:
        << Basic
        * Big chance (boolean)

Logistic Model #3: 0.9034
    Hash: c41db07
    Params:
        << #2
        * Max iter increased to 1000
    Features:
        << #2
        * Distance * Angle
        * fastBreak (boolean)
        * assisted (boolean)
        * firstTouch (boolean)

XGBoost Model #1: 0.9092
    Hash: c8ba969
    Features:
        << Logistic Model #3
    

Future:
    * day of month
    * day of week
    * isOppositionError
    * dark arts would be to include categorical variable for team, basically cheating but...possible?
    * another dark art would be to include opposition for categorical...again, feels like cheating
    and may leak into prediction model?
    * could look at doing the chain variables, the problem is that it is tricky to go backwards
    through the events, a way to do this easily would be to hold the previous five events in a
    buffer as we are going through the match, I think Python has a queue library?
        * throughBall in player chain?
        * block in opposition chain?
        * save in opposition chain?
        * error in opposition chain? disposessed, etc.
