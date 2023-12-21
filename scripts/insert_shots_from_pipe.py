import ast
import os
import psycopg2
import json
import sys

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            for line in sys.stdin:
                values = ast.literal_eval(line)
                if len(values) > 0:
                    sql_values = ",".join(ast.literal_eval(line))
                    sql_query = f"INSERT INTO xg(match_id, player_id, event_id, prob) VALUES {sql_values} on conflict(match_id, player_id, event_id) do update set prob=excluded.prob"
                    cur = conn.cursor();
                    cur.execute(sql_query)
                    conn.commit()
                print("Inserted: " + str(len(values)) + " shots")
 
