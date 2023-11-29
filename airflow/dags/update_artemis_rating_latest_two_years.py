from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import task
      
with DAG(
    "update_artemis_rating_latest_two_years",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(days=1),
    catchup=False,
) as dag:

    @task.virtualenv(task_id="update_artemis_rating", requirements=["scipy==1.9.0", "numpy==1.24.0"])
    def update_artemis_rating():
        from artemis.common import Poisson 
        from airflow.providers.postgres.hooks.postgres import PostgresHook

        hook = PostgresHook(postgres_conn_id="ponos")
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
        poiss = Poisson()

        for row in rows:
            if row[1] == -1 or row[2] == -1 or row[3] == None or row[4] == None:
                continue
            poiss.update(row[1], row[2], row[3], row[4], row[5], row[0])
        query = "insert into poiss_ratings(team_id, off_rating, def_rating, date) VALUES "
        query += ",".join(poiss.rating_records)
        query += " on conflict(team_id, date) do update set off_rating=excluded.off_rating, def_rating=excluded.def_rating;"

        conn = hook.get_conn()
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        return

    update_artemis_rating()
 

