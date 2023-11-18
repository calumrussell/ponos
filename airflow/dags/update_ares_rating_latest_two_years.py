from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import task
      
with DAG(
    "update_ares_rating_latest_two_years",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(hours=3),
    catchup=False,
) as dag:

    @task.virtualenv(task_id="update_ares_rating", requirements=["scikit-learn==1.3.2"], execution_timeout=timedelta(minutes=10))
    def update_ares_rating():
        from ares.common import EloImpl
        from airflow.providers.postgres.hooks.postgres import PostgresHook

        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = """
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
            where (match.year=2023 or match.year=2024)
            and match.start_date < extract(epoch from now())
            order by match.start_date asc"""
        rows = hook.get_records(sql_query)
        conn = hook.get_conn()
        cur = conn.cursor()
        for row in rows:
            start_date = row[0]
            home_id = row[1]
            away_id = row[2]
            home_goals = row[3]
            away_goals = row[4]

            if not home_goals or not away_goals:
                continue

            home_rating = EloImpl.default_rating()
            cur.execute(f"select rating from elo_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1")
            home_rating_previous = cur.fetchone()
            if home_rating_previous:
                home_rating = home_rating_previous[0]
            else:
                #Need to commit 1500 here so the front-end always has values
                cur.execute(f"insert into elo_ratings(team_id, date, rating) values ({home_id}, {start_date-1}, 1500)")

            away_rating = EloImpl.default_rating()
            cur.execute(f"select rating from elo_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1")
            away_rating_previous = cur.fetchone()
            if away_rating_previous:
                away_rating = away_rating_previous[0]
            else:
                cur.execute(f"insert into elo_ratings(team_id, date, rating) values ({away_id}, {start_date-1}, 1500)")

            home_rating_new, away_rating_new = EloImpl.ratings(home_id, away_id, home_goals, away_goals, home_rating, away_rating)
            cur.execute(f"insert into elo_ratings(team_id, date, rating) values ({home_id}, {start_date}, {home_rating_new}), ({away_id}, {start_date}, {away_rating_new}) on conflict do nothing")
            conn.commit()
        return

    update_ares_rating()
