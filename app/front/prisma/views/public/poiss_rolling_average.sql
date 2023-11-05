SELECT
  poiss_ratings.team_id,
  poiss_ratings.date,
  round(
    avg((poiss_ratings.off_rating) :: numeric) OVER (
      PARTITION BY poiss_ratings.team_id
      ORDER BY
        poiss_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ),
    2
  ) AS off_rating,
  round(
    avg((poiss_ratings.def_rating) :: numeric) OVER (
      PARTITION BY poiss_ratings.team_id
      ORDER BY
        poiss_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ),
    2
  ) AS def_rating
FROM
  poiss_ratings;