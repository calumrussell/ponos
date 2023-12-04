import subprocess
import os
import sys
import psycopg2
import subprocess
import json
import requests
import ast

if __name__ == "__main__":
    num = 50

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            tid = str(sys.argv[1])
            cur.execute(f"select count(id) from match where start_date < extract(epoch from now()) and tournament_id={tid}")
            length = cur.fetchone()[0]

            for offset in range(0, length + num, num):
                print(offset)
                cur.execute(f"select data from match_data where id in (select id from match where start_date < extract(epoch from now()) and tournament_id={tid}) limit {num} offset {offset};")

                vals = "\n".join([json.dumps(row[0]) for row in cur.fetchall()])
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
                    sql_values = ",".join(remove_dups)
                    sql_query = f"INSERT INTO xg(match_id, player_id, event_id, prob) VALUES {sql_values} on conflict(match_id, player_id, event_id) do update set prob=excluded.prob"
                    cur = conn.cursor();
                    cur.execute(sql_query)
                    conn.commit()
                print("Inserted: " + str(len(values)) + " shots")
