from datetime import datetime, timedelta
import subprocess
import json

from airflow import DAG
from airflow.decorators import task
from airflow.providers.postgres.hooks.postgres import PostgresHook
      
with DAG(
    "update_ares_pred_latest_two_years",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(hours=3),
    catchup=False,
) as dag:

    @task(task_id="get_match_pred", execution_timeout=timedelta(minutes=10))
    def get_match_pred():
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
        vals = []
        recs = hook.get_records(sql_query)
        for rec in recs:
            mid = rec[0]
            start_date = rec[1]
            home_id = rec[2]
            away_id = rec[3]

            hook = PostgresHook(postgres_conn_id="ponos")
            sql_query = f"select rating from elo_ratings where team_id={home_id} and date < {start_date} order by date desc limit 1"
            home_rating_recs = hook.get_records(sql_query)
            if len(home_rating_recs) == 0:
                home_rating = 1500
            else:
                home_rating = home_rating_recs[0][0]

            sql_query = f"select rating from elo_ratings where team_id={away_id} and date < {start_date} order by date desc limit 1"
            away_rating_recs = hook.get_records(sql_query)
            if len(away_rating_recs) == 0:
                away_rating = 1500
            else:
                away_rating = away_rating_recs[0][0]
            print(home_rating, away_rating)
            vals.append(f"{mid}, {home_rating}, {away_rating}")
            
        process = subprocess.Popen(
                ['docker', 'run', '-i', '--rm', 'ares'], 
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
                text=True)
        res, err = process.communicate("\n".join(vals))
        vals = []
        for row in res.split("\n"):
            if not row:
                continue
            json_row = json.loads(row)
            match_id = json_row['match_id']
            home_win = float(json_row['home_win'])
            away_win = float(json_row['away_win'])
            draw = float(json_row['draw'])
            vals.append(f"({match_id},{home_win},{away_win},{draw})")
        if not vals:
            return

        joined = ",".join(vals)
        sql_query = f"insert into elo_pred(match_id, home_win, away_win, draw) VALUES {joined} on conflict(match_id) do update set home_win=excluded.home_win, away_win=excluded.away_win, draw=excluded.draw;"
        conn = hook.get_conn()
        cur = conn.cursor()
        cur.execute(sql_query)
        conn.commit()
        return 

    get_match_pred()
