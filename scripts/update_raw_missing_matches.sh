python3 scripts/get_missing_raw_matches.py | xargs -d '\n' -L 1 docker run -i --rm puppet node match | python3 scripts/insert_raw_from_pipe.py
