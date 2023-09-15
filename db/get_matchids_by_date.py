import conn 
import sys

import argparse

parser = argparse.ArgumentParser(description ='Return match ids before/after certain date')

parser.add_argument('-b', dest ='before', action ='store', help ='before date')
parser.add_argument('-a', dest ='after', action ='store', help ='after date')

if __name__ == "__main__":
    args = parser.parse_args()
    if args.before != None and args.after != None and int(args.before) <= int(args.after):
        raise ValueError("Before must be greater than after")

    with conn.conn:
        with conn.conn.cursor() as cur:
            cur.execute("select * from match")
            for row in cur:
                date = row[3]
                match_id = row[0]
                if args.before != None and args.after == None and date < int(args.before):
                    print(match_id)

                if args.after != None and args.before == None and date > int(args.after):
                    print(match_id)

                if args.before != None and args.after != None and date < int(args.before) and date > int(args.after):
                    print(match_id)

