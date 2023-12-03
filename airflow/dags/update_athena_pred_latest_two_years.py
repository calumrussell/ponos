from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import task
      
with DAG(
    "update_athena_pred_latest_two_years",
    start_date=datetime(2021, 1, 1),
    schedule_interval="00 2 * * *",
    catchup=False,
) as dag:

    @task.virtualenv(task_id="update_athena_pred", requirements=["scipy==1.9.0", "numpy==1.24.0"])
    def update_athena_pred():
        from athena.common import Weibull
        from airflow.providers.postgres.hooks.postgres import PostgresHook

        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = """
            select 
            id,
            start_date,
            home_id,
            away_id
            from
            match
            where year=2024 or year=2023"""
        recs = hook.get_records(sql_query)
        vals = []
        for rec in recs:
            mid = rec[0]
            start_date = rec[1]
            home_id = rec[2]
            away_id = rec[3]

            print(mid)
            sql_query = f"select off_rating, off_rating_spread, def_rating, def_rating_spread from wei_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1"
            home_rating_row = hook.get_records(sql_query)
            if not home_rating_row:
                continue

            sql_query = f"select off_rating, off_rating_spread, def_rating, def_rating_spread from wei_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1"
            away_rating_row = hook.get_records(sql_query)
            if not away_rating_row:
                continue
               
            vals.append(str(Weibull.prediction(mid, home_rating_row[0][0], home_rating_row[0][1], home_rating_row[0][2], home_rating_row[0][3], away_rating_row[0][0], away_rating_row[0][1], away_rating_row[0][2], away_rating_row[0][3])))

        joined = ",".join(vals)
        sql_query = f"insert into wei_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
        conn = hook.get_conn()
        cur = conn.cursor()
        cur.execute(sql_query)
        conn.commit()
        return

    update_athena_pred()
