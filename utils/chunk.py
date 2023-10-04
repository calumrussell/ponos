import sys
for line in sys.stdin:
    stripped = line.strip()
    if not stripped: continue
    print('{"match_id":' + stripped + '}')
