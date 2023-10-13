SELECT
  MATCH.id,
  MATCH.home_id,
  MATCH.away_id,
  MATCH.start_date,
  MATCH.broken,
  MATCH.tournament_id,
  MATCH.season_id,
  MATCH.year,
  home.name AS home,
  away.name AS away
FROM
  (
    (
      MATCH
      LEFT JOIN team home ON ((home.id = MATCH.home_id))
    )
    LEFT JOIN team away ON ((away.id = MATCH.away_id))
  );