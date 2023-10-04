import json
import sys
import requests

if __name__ == "__main__":
    base_url = sys.argv[1]
    for line in sys.stdin:
        data = json.loads(line)

        res = requests.post(base_url + '/insert_matches', json = {"matches": data['matches']})
        print(res.status_code)
        res = requests.post(base_url + '/insert_players', json = {"players": data['players']})
        print(res.status_code)
        res = requests.post(base_url + '/insert_teams', json = {"teams": data['teams']})
        print(res.status_code)
        res = requests.post(base_url + '/insert_player_stats', json = {"player_stats": data['playerStats']})
        print(res.status_code)
        res = requests.post(base_url + '/insert_team_stats', json = {"team_stats": data['teamStats']})
        print(res.status_code)
