import json
import sys
import requests

if __name__ == "__main__":
    for line in sys.stdin:
        row_json = json.loads(line)
        res = requests.post('http://localhost:8080/bulk_input', json = row_json)
        print(res.status_code)
