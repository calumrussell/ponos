from datetime import datetime, timedelta
import json
import requests
import subprocess
import ast

from airflow import DAG
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.decorators import task
      
with DAG(
    "update_last24hours_match",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(minutes=30),
    catchup=False,
    concurrency=5,
) as dag:

    @task(task_id="get_recent_matches")
    def get_recent_matches():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT json_build_object('match_id', id) from match where start_date < extract(epoch from now()) and start_date > (extract(epoch from now()) - 86400)"
        return hook.get_records(sql_query)

    @task(task_id="get_and_insert_raw_match")
    def get_match_data(match_id):
        mid = match_id[0]['match_id']
        match_str = json.dumps(match_id[0])
        process = subprocess.run(
            ['docker', 'run', '--rm', 'puppet', 'bash', '-c', 'npm install --silent --no-progress && node match.js \'' + match_str + '\''], 
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

    @task(task_id="fetch_and_parse_match")
    def match_load():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT data FROM match_data where id in (select id from match where start_date < extract(epoch from now()) and start_date > (extract(epoch from now()) - 86400))"
        vals = "\n".join(json.dumps(i[0]) for i in hook.get_records(sql_query))
        process = subprocess.Popen(
                ['docker', 'run', '-i', '--rm', 'parser'], 
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
                text=True)
        res, err = process.communicate(vals)
        res = requests.post('http://100.124.40.39:8080/bulk_input', json = json.loads(res))
        print(res.status_code)
        return 

    @task(task_id="fetch_and_parse_shots")
    def shots_load():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT data FROM match_data where id in (select id from match where start_date < extract(epoch from now()) and start_date > (extract(epoch from now()) - 86400))"
        vals = "\n".join(json.dumps(i[0]) for i in hook.get_records(sql_query))
        process = subprocess.Popen(
                ['docker', 'run', '-i','--rm', 'pandora'], 
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
                text=True)
        res, err = process.communicate(vals)

        conn = hook.get_conn()
        values = ast.literal_eval(res)
        if len(values) > 0:
            sql_values = ",".join(ast.literal_eval(res))
            sql_query = f"INSERT INTO xg(match_id, player_id, event_id, prob) VALUES {sql_values} on conflict(match_id, player_id, event_id) do update set prob=excluded.prob"
            cur = conn.cursor();
            cur.execute(sql_query)
            conn.commit()
        print("Inserted: " + str(len(values)) + " shots")
        return 

    get_match_data.expand(match_id=get_recent_matches()) >> [match_load(), shots_load()]

