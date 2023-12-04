SELECT
  MATCH.id,
  MATCH.home_id,
  MATCH.away_id,
  MATCH.start_date,
  MATCH.broken,
  MATCH.tournament_id,
  MATCH.season_id,
  MATCH.year
FROM
  MATCH
WHERE
  (
    (
      (MATCH.year = 2023)
      OR (MATCH.year = 2024)
    )
    AND (
      MATCH.id IN (
        SELECT
          DISTINCT player_stats.match_id
        FROM
          player_stats
      )
    )
  );