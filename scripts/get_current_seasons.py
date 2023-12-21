import os
import psycopg2
import json

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            sql_query = "SELECT path from seasons where curr='t';"
            cur.execute(sql_query)
            for row in cur:
                print(row[0])
