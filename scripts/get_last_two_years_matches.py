import os
import psycopg2
import json
import psycopg2.extras

if __name__ == "__main__":

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor(cursor_factory=psycopg2.extras.DictCursor) as cur:
            sql_query = """
                select 
                id,
                start_date,
                home_id,
                away_id
                from
                match
                where year=2024 or year=2023"""
            cur.execute(sql_query)
            for row in cur:
                print(json.dumps(dict(row)))

