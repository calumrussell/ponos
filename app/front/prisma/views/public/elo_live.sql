SELECT
  elo_ratings.team_id,
  elo_ratings.rating,
  elo_ratings.date
FROM
  (
    elo_ratings
    RIGHT JOIN (
      SELECT
        max(elo_ratings_1.date) AS max,
        elo_ratings_1.team_id
      FROM
        elo_ratings elo_ratings_1
      GROUP BY
        elo_ratings_1.team_id
    ) max ON (
      (
        (max.team_id = elo_ratings.team_id)
        AND (max.max = elo_ratings.date)
      )
    )
  );