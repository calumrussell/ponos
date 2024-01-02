import os
import psycopg2
import json

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            sql_query = "SELECT json_build_object('match_id', id) from match where start_date < extract(epoch from now()) and id not in (select id from match_data);"
            cur.execute(sql_query)
            for row in cur:
                print(json.dumps(row[0]))
