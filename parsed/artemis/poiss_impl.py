import psycopg2
import os
from common import Poisson

if __name__ == "__main__":
    """
    Code used for total model updates.
    """
    conn = psycopg2.connect(os.getenv("DB_CONN"))
    poiss = Poisson()
    with conn:
        with conn.cursor() as cur:
            cur.execute("select distinct(start_date) from match where start_date < extract(epoch from now()) order by start_date asc")
            dates = [row[0] for row in cur.fetchall()]
            for date in dates:
                print(date)

                cur.execute(f"select id, start_date, home_id, away_id, year from match_full where start_date = {date}")
                date_matches = [row for row in cur.fetchall()]
                for match_id, start_date, home_id, away_id, year in date_matches:
                    home_goals = -1
                    away_goals = -1
                    home_own_goals = 0
                    away_own_goals = 0
                    cur.execute(f"select team_id, goal, goal_own from team_stats where match_id={match_id}")
                    team_stats = cur.fetchall()
                    for team_id, goal, goal_own in team_stats:
                        if team_id == home_id:
                            home_goals = goal
                            home_own_goals = goal_own
                        else:
                            away_goals = goal
                            away_own_goals = goal_own

                    if home_goals == -1 or away_goals == -1:
                        continue

                    poiss.update(home_id, away_id, home_goals, away_goals, year, date)
            cur.execute(f"insert into poiss_ratings(team_id, date, off_rating, def_rating) VALUES {','.join(poiss.rating_records)} on conflict(team_id, date) do update set off_rating=excluded.off_rating, def_rating=excluded.def_rating;") 
