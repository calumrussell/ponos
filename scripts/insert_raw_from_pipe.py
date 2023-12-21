import os
import psycopg2
import json
import sys

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            for line in sys.stdin:
                replaced = line.replace("'", "''").strip()
                loaded = json.loads(replaced)
 
                if loaded['matchCentreData']:
                    mid = loaded['matchId']
                    print(mid)
                    sql_query = f"INSERT INTO match_data (id, data) VALUES ({mid}, '{replaced}') on conflict(id) do update set data=excluded.data"
                    cur.execute(sql_query)
            conn.commit()

