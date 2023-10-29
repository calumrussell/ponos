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

    Because this model uses joint probability we have a dependency on both teams having
    an updated rating. Therefore, we return updated rating for both teams upon each
    calculation.

    Defaults to 1500 rating and has no rating burn.
    """
    expected_margin = lambda x_rating, y_rating, p, home_adv: ((x_rating-y_rating)/p) + home_adv
    rating_change = lambda actual_margin, expected_margin, k: k*(actual_margin-expected_margin)

    def default_rating():
        return 1500

    def new_ratings(home_id,  away_id, home_goals, away_goals, home_rating, away_rating):
        model = DefaultEloModel()
        home_x_margin = EloImpl.expected_margin(home_rating, away_rating, model.p, model.h)
        home_rating_change = EloImpl.rating_change(home_goals - away_goals, home_x_margin, model.k)

        away_x_margin = EloImpl.expected_margin(away_rating, home_rating, model.p, -model.h)
        away_rating_change = EloImpl.rating_change(away_goals - home_goals, away_x_margin, model.k)
        return (home_rating + home_rating_change, away_rating + away_rating_change)

if __name__ == "__main__":
    """
    Code used for total model updates.

    Ratings are modelled as joint probability so we have to iterate through matches over
    time. We cannot break this up by team or season (because we have tournaments that
    involve teams across tournaments, we cannot do season).
    """
    import psycopg2
    import os

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:

            cur.execute("select distinct(start_date) from match where start_date < extract(epoch from now()) order by start_date asc")
            dates = [row[0] for row in cur.fetchall()]
            for date in dates:
                print(date)
                cur.execute(f"select id, start_date, home_id, away_id from match where start_date = {date}")
                date_matches = [row for row in cur.fetchall()]
                for match_id, start_date, home_id, away_id in date_matches:
                    home_goals = -1
                    away_goals = -1
                    cur.execute(f"select team_id, goal from team_stats where match_id={match_id}")
                    team_stats = cur.fetchall()
                    for team_id, goal in team_stats:
                        if team_id == home_id:
                            home_goals = goal
                        else:
                            away_goals = goal

                    if home_goals == -1 or away_goals == -1:
                        continue

                    home_rating = EloImpl.default_rating()
                    cur.execute(f"select rating from elo_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1")
                    home_rating_previous = cur.fetchone()
                    if home_rating_previous:
                        home_rating = home_rating_previous[0]

                    away_rating = EloImpl.default_rating()
                    cur.execute(f"select rating from elo_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1")
                    away_rating_previous = cur.fetchone()
                    if away_rating_previous:
                        away_rating = away_rating_previous[0]

                    ##We should never have 1500 committed, if both are 1500 then we update from there
                    home_rating_new, away_rating_new = EloImpl.new_ratings(home_id, away_id, home_goals, away_goals, home_rating, away_rating)
                    ##Must update the rows rather than cache as they will be needed for next computations in row
                    cur.execute(f"insert into elo_ratings(team_id, date, rating) values ({home_id}, {start_date}, {home_rating_new}), ({away_id}, {start_date}, {away_rating_new}) on conflict do nothing")
                    conn.commit()
