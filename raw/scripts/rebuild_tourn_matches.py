import subprocess
import os
import sys
import psycopg2
import subprocess
import json
import requests

if __name__ == "__main__":
    num = 50

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            tid = str(sys.argv[1])
            cur.execute(f"select count(id) from match where tournament_id={tid}")
            length = cur.fetchone()[0]

            for offset in range(0, length + num, num):
                print(offset)
                cur.execute(f"select data from match_data where id in (select id from match where start_date < extract(epoch from now()) and tournament_id={tid}) limit {num} offset {offset};")
                vals = "\n".join([json.dumps(row[0]) for row in cur.fetchall()])
                process = subprocess.Popen(
                        ['docker', 'run', '-i', '--rm', 'parser'], 
                        stdin=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        stdout=subprocess.PIPE,
                        text=True)
                res, err = process.communicate(vals)
                res = requests.post('http://100.96.98.54:8080/bulk_input', json = json.loads(res)) 
                print(res.status_code)
