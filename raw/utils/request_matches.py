import json
import sys
import requests

if __name__ == "__main__":
    matches = []
    for line in sys.stdin:
        row_json = json.loads(line)
        if row_json not in matches:
            row_json['id'] = int(row_json['id'])
            row_json['home_id'] = int(row_json['home_id'])
            row_json['away_id'] = int(row_json['away_id'])
            row_json['season_id'] = int(row_json['season_id'])
            row_json['tournament_id'] = int(row_json['tournament_id'])
            row_json['year'] = int(row_json['year'])
            matches.append(row_json)
    res = requests.post('http://localhost:8080/bulk_matches', json = {"matches": matches})
