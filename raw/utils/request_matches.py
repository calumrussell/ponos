import json
import sys
import requests

if __name__ == "__main__":
    matches = []
    for line in sys.stdin:
        row_json = json.loads(line)
        if row_json not in matches:
            row_json['match_id'] = int(row_json['match_id'])
            row_json['home_id'] = int(row_json['home_id'])
            row_json['away_id'] = int(row_json['away_id'])
            matches.append(row_json)
    res = requests.post('http://100.124.40.39:8080/bulk_input', json = {"matches": matches})
