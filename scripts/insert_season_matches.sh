python3 scripts/get_current_seasons.py | xargs -d '\n' -L 1 docker run -i puppet node fixtures.js | python3 scripts/insert_match.py
