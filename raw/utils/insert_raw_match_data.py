import psycopg2
import os
import sys
import json

conn = psycopg2.connect(os.getenv("DB_CONN"))
"""
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PWD"),
    dbname=os.getenv("DB_NAME"),
    port=os.getenv("DB_PORT")
)
"""

for line in sys.stdin:
    json_row = json.loads(line)
    match_id = json_row['matchId']

    parsed_line = line.replace("'", "''")
    with conn:
        with conn.cursor() as cur:
            cur.execute(f"insert into match_data(id, data) values({match_id}, '{parsed_line}') on conflict do nothing;");
        conn.commit()
