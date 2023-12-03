from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import task
      
with DAG(
    "update_athena_rating_latest_two_years",
    start_date=datetime(2021, 1, 1),
    schedule_interval="00 01 * * *",
    catchup=False,
) as dag:

    @task.virtualenv(task_id="update_athena_rating", requirements=["scipy==1.9.0", "numpy==1.24.0"])
    def update_athena_rating():
        from athena.common import Weibull
        from airflow.providers.postgres.hooks.postgres import PostgresHook

        hook = PostgresHook(postgres_conn_id="ponos")

        def add_func(x):
            query = "insert into wei_ratings(team_id, off_rating, off_rating_spread, def_rating, def_rating_spread, date) VALUES "
            query += ",".join(x)
            query += " on conflict(team_id, date) do update set off_rating=excluded.off_rating, off_rating_spread=excluded.off_rating_spread, def_rating=excluded.def_rating, def_rating_spread=excluded.def_rating_spread;"
            conn = hook.get_conn()
            cur = conn.cursor()
            cur.execute(query)
            conn.commit()
            return

        sql_query = """
            select 
            match.start_date,
            match.home_id,
            match.away_id,
            home.goal + away.goal_own as home_goal,
            away.goal + home.goal_own as away_goal,
            match.year
            from match
            left join team_stats_full as home
                on home.team_id=match.home_id and home.match_id=match.id
            left join team_stats_full as away
                on away.team_id=match.away_id and away.match_id=match.id
            where match.year=2024 or match.year=2023
            order by match.start_date asc"""
        rows = hook.get_records(sql_query)
        wei = Weibull()

        for row in rows:
            if row[1] == -1 or row[2] == -1 or row[3] == None or row[4] == None:
                continue
            wei.update(row[1], row[2], row[3], row[4], row[5], row[0])
            wei.flush(add_func)
        wei.exit(add_func)
        return

    update_athena_rating()
