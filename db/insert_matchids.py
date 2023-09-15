import conn 
import sys

import argparse

parser = argparse.ArgumentParser(description ='Insert match data in order: matchid, startTime, homeId, awayId. Last two are optional.')

parser.add_argument(dest ='match', metavar ='match', nargs ='*')

if __name__ == "__main__":
    args = parser.parse_args()
    mid = args.match[0]
    start_date = args.match[1]
    if len(args.match) > 2:
        home_id = args.match[2]
    else:
        home_id = -1

    if len(args.match) > 3:
        away_id = args.match[3]
    else:
        away_id = -1

    with conn.conn:
        with conn.conn.cursor() as cur:
            cur.execute(f'insert into match(id, start_date, home_id, away_id) values({mid}, {start_date}, {home_id}, {away_id}) on conflict do nothing')
        conn.conn.commit()
