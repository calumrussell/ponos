SELECT
  wei_ratings.team_id,
  wei_ratings.off_rating,
  wei_ratings.off_rating_spread,
  wei_ratings.def_rating,
  wei_ratings.def_rating_spread,
  wei_ratings.date
FROM
  (
    wei_ratings
    RIGHT JOIN (
      SELECT
        max(wei_ratings_1.date) AS max,
        wei_ratings_1.team_id
      FROM
        wei_ratings wei_ratings_1
      GROUP BY
        wei_ratings_1.team_id
    ) max ON (
      (
        (max.team_id = wei_ratings.team_id)
        AND (max.max = wei_ratings.date)
      )
    )
  );