from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import task
      
with DAG(
    "update_athena",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(days=1),
    catchup=False,
) as dag:

    @task.virtualenv(task_id="update_athena", requirements=["scipy==1.9.0", "numpy==1.24.0"])
    def update_athena():
        from athena.wei_impl import Weibull
        from airflow.providers.postgres.hooks.postgres import PostgresHook
  
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = """
            select 
            match.start_date,
            match.home_id,
            match.away_id,
            home.goal as home_goal,
            away.goal as away_goal,
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

        conn = hook.get_conn()
        cur = conn.cursor()

        def insert_into_db(values):
            print("Updated: " + str(len(values)) + " records.")
            query = "insert into wei_ratings(team_id, off_rating, off_rating_spread, def_rating, def_rating_spread, date) VALUES "
            values = []
            for rating in wei.rating_records:
                values.append(f"({rating.team_id}, {rating.off_rating}, {rating.off_rating_spread}, {rating.def_rating}, {rating.def_rating_spread}, {rating.date})")
            query += ",".join(values)
            query += " on conflict(team_id, date) do update set off_rating=excluded.off_rating, off_rating_spread=excluded.off_rating_spread, def_rating=excluded.def_rating, def_rating_spread=excluded.def_rating_spread;"
            cur.execute(query)
            conn.commit()

        for row in rows:
            if row[1] == -1 or row[2] == -1 or row[3] == None or row[4] == None:
                continue
            wei.update(row[1], row[2], row[3], row[4], row[5], row[0])
            wei.flush(insert_into_db)
        return

    update_athena()
 
