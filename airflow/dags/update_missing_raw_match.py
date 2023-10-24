from datetime import datetime, timedelta
import json

from airflow import DAG
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import task
import subprocess
      
with DAG(
    "update_missing_raw_match",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(days=1),
    catchup=False,
    concurrency=5,
) as dag:

    @task(task_id="get_missing_matches")
    def get_missing_matches():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT json_build_object('match_id', id) from match where start_date < extract(epoch from now()) and id not in (select id from match_data);"
        return hook.get_records(sql_query)

    @task(task_id="get_and_insert_raw_match")
    def get_match_data(match_id):
        mid = match_id[0]['match_id']
        match_str = json.dumps(match_id[0])
        process = subprocess.run(
            ['docker', 'run', '--rm', 'puppet', 'bash', '-c', 'npm install --silent --no-progress && node match.js \'' + match_str + '\''], 
            capture_output=True)

        raw_match = process.stdout.decode('utf-8').replace("'", "''")
        loaded = json.loads(raw_match)
        if loaded['matchCentreData']:
            raw_match_json = json.dumps(raw_match)
            hook = PostgresHook(postgres_conn_id="ponos")
            conn = hook.get_conn()

            sql_query = f"INSERT INTO match_data (id, data) VALUES ({mid}, '{raw_match_json}') on conflict(id) do update set data=excluded.data"
            cur = conn.cursor();
            cur.execute(sql_query)
            conn.commit()
        return

    get_match_data.expand(match_id=get_missing_matches())
