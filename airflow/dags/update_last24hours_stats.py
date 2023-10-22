from datetime import datetime, timedelta
import json
import requests 
from airflow import DAG

from airflow.operators.bash import BashOperator
from airflow.providers.docker.operators.docker import DockerOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.operators.python_operator import PythonOperator
from airflow.decorators import task
import subprocess
      
with DAG(
    "update_last24hours_stats",
    start_date=datetime(2023, 10, 22),
    schedule=timedelta(minutes=30),
    catchup=False,
) as dag:

    @task(task_id="fetch_and_parse")
    def match_load():
        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = "SELECT data FROM match_data where id in (select id from match where start_date < extract(epoch from now()) and start_date > (extract(epoch from now()) - 86400))"
        recs = hook.get_records(sql_query)
        process = subprocess.Popen(
                ['docker', 'run', '-i', 'parser'], 
                stdin=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdout=subprocess.PIPE,
                text=True)
        for item in recs:
            process.stdin.write(item[0])
        process.stdin.flush()
        process.stdin.close()
        output = process.stdout.read()
        process.wait()
        res = requests.post('http://100.124.40.39:8080/bulk_input', json = json.loads(output))
        print(res.status_code)
        return 

    match_load()
