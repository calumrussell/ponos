from datetime import datetime, timedelta
import json
import requests
import subprocess
import ast

from airflow import DAG
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import task
      
with DAG(
    "update_missing_match",
    start_date=datetime(2021, 1, 1),
    schedule_interval=None,
    catchup=False,
    concurrency=2,
) as dag:

    @task(task_id="get_missing_matches")
    def get_missing_matches():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT json_build_object('match_id', id) from match where start_date < extract(epoch from now()) and id not in (select id from match_data);"
        return hook.get_records(sql_query)

    @task(task_id="get_and_insert_raw_match", execution_timeout=timedelta(seconds=20))
    def get_match_data(match_id):
        mid = match_id[0]['match_id']
        match_str = json.dumps(match_id[0])
        process = subprocess.run(
            ['docker', 'run', '--rm', 'puppet', 'node', 'match.js', match_str], 
            capture_output=True)
 
        raw_match = process.stdout.decode('utf-8')
        if not raw_match:
            return

        replaced = raw_match.replace("'", "''").strip()
        loaded = json.loads(replaced)
        if loaded['matchCentreData']:
            hook = PostgresHook(postgres_conn_id="ponos")
            conn = hook.get_conn()

            sql_query = f"INSERT INTO match_data (id, data) VALUES ({mid}, '{replaced}') on conflict(id) do update set data=excluded.data"
            cur = conn.cursor();
            cur.execute(sql_query)
            conn.commit()
        return

    @task(task_id="fetch_and_parse_matches", execution_timeout=timedelta(minutes=2))
    def match_load():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT data FROM match_data where id in (select id from match where start_date < extract(epoch from now())) and id not in (select distinct(match_id) from team_stats) limit 100"
        vals = "\n".join(json.dumps(i[0]) for i in hook.get_records(sql_query))
        process = subprocess.Popen(
                ['docker', 'run', '-i', '--rm', 'parser'], 
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
                text=True)
        output, err = process.communicate(vals)
        res = requests.post('http://100.96.98.54:8080/bulk_input', json = json.loads(output))
        print(res.status_code)
        return 

    @task(task_id="fetch_and_parse_shots", execution_timeout=timedelta(minutes=2))
    def shots_load():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT data FROM match_data where id in (select id from match where start_date < extract(epoch from now())) and id not in (select distinct(match_id) from xg) limit 100"
        vals = "\n".join(json.dumps(i[0]) for i in hook.get_records(sql_query))
        process = subprocess.Popen(
                ['docker', 'run', '-i','--rm', 'pandora'], 
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
                text=True)
        res, err = process.communicate(vals)

        values = ast.literal_eval(res)
        if len(values) > 0:
            remove_dups = list(set(values))
            conn = hook.get_conn()
            sql_values = ",".join(remove_dups)
            sql_query = f"INSERT INTO xg(match_id, player_id, event_id, prob) VALUES {sql_values} on conflict(match_id, player_id, event_id) do update set prob=excluded.prob"
            cur = conn.cursor();
            cur.execute(sql_query)
            conn.commit()

        print("Inserted: " + str(len(values)) + " shots")
        return 

    get_match_data.expand(match_id=get_missing_matches()) >> [match_load(), shots_load()]

