
python3 raw/scripts/recent_matches.py | xargs -d '\n' -L 1 docker run -i puppet node match
