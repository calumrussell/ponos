import os
import psycopg2

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
  
if __name__ == "__main__":
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PWD"),
        dbname=os.getenv("DB_NAME"),
        port=os.getenv("DB_PORT")
    )

    with conn:
        with conn.cursor() as cur:
            query = """
                select 
                match.start_date,
                match.home_id,
                match.away_id,
                home.goal as home_goal,
                away.goal as away_goal
                from match
                left join team_stats_full as home
                    on home.team_id=match.home_id and home.match_id=match.id
                left join team_stats_full as away
                    on away.team_id=match.away_id and away.match_id=match.id
                order by match.start_date asc"""
            cur.execute(query)
            
            rows = cur.fetchall()

            model = DefaultEloModel()
            elo = EloImpl(model)
            for row in rows:
                if row[1] == -1 or row[2] == -1:
                    continue
                elo.update(row[1], row[2], row[3], row[4], row[0])
            ratings = elo.rating_record
            query = "insert into elo_ratings(team_id, rating, date) VALUES "
            values = []
            for rating in ratings:
                values.append(f"({rating.team_id}, {rating.rating}, {rating.date})")
            query += ",".join(values)
            query += " on conflict do nothing;"
            cur.execute(query)
        conn.commit()


