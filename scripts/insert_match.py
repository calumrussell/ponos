import os
import psycopg2
import json
import sys
import requests

if __name__ == "__main__":

    matches = []

    conn = psycopg2.connect(os.getenv("DB_CONN"))
    with conn:
        with conn.cursor() as cur:
            for line in sys.stdin:
                row_json = json.loads(line.strip())
                tmp = {}
                tmp['id'] = int(row_json['id'])
                tmp['home_id'] = int(row_json['home_id'])
                tmp['away_id'] = int(row_json['away_id'])
                tmp['start_date'] = int(row_json['start_date'])
                tmp['season_id'] = int(row_json['season_id'])
                tmp['tournament_id'] = int(row_json['tournament_id'])
                tmp['year'] = int(row_json['year'])
                matches.append(tmp)

    res = requests.post('http://100.96.98.54:8080/bulk_matches', json = {"matches": matches})
    print(res.status_code)
