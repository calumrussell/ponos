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

def match_load():
    hook = PostgresHook(postgres_conn_id="ponos")
    sql_query = "SELECT data FROM match_data limit 1"
    data = json.dumps(hook.get_records(sql_query)[0][0])
    process = subprocess.run(
            ['docker', 'run', '-i', 'parser'], 
            capture_output=True,
            input=data,
            text=True)
    res = requests.post('http://100.124.40.39:8080/bulk_input', json = json.loads(process.stdout))
    print(res.status_code)
 
      
with DAG(
    "match_load_test",
    start_date=datetime(2023, 10, 22),
    schedule=timedelta(days=1),
    catchup=False,
) as dag:
    t0 = PythonOperator(
        task_id="stage_1",
        python_callable=match_load,
    )

    t0
