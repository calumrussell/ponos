SELECT
  elo_ratings.team_id,
  elo_ratings.date,
  round(
    avg(elo_ratings.rating) OVER (
      PARTITION BY elo_ratings.team_id
      ORDER BY
        elo_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ),
    2
  ) AS rating
FROM
  elo_ratings;