from datetime import datetime, timedelta
import json
import requests
import subprocess

from airflow import DAG
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import task
      
with DAG(
    "update_liveseasons_match",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(days=1),
    catchup=False,
) as dag:

    @task(task_id="get_current_seasons")
    def get_current_seasons():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT path from seasons where curr='t';"
        return hook.get_records(sql_query)

    @task(task_id="get_season_matches", execution_timeout=timedelta(minutes=5))
    def get_season_matches(season_str):
        season_row = season_str[0]
        process = subprocess.run(
            ['docker', 'run', '--rm', 'puppet', 'bash', '-c', 'npm install --silent --no-progress && node fixtures.js \'' + season_row + '\''], 
            capture_output=True)

        lines = process.stdout.decode('utf-8').split("\n")

        matches = []
        for row in lines:
            if not row:
                continue
            row_json = json.loads(row.strip())
            tmp = {}
            tmp['id'] = int(row_json['id'])
            tmp['home_id'] = int(row_json['home_id'])
            tmp['away_id'] = int(row_json['away_id'])
            tmp['start_date'] = int(row_json['start_date'])
            tmp['season_id'] = int(row_json['season_id'])
            tmp['tournament_id'] = int(row_json['tournament_id'])
            tmp['year'] = int(row_json['year'])
            matches.append(tmp)

        res = requests.post('http://100.111.31.32:8080/bulk_matches', json = {"matches": matches})
        print(res.status_code)
        return

    get_season_matches.expand(season_str=get_current_seasons())
