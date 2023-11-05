SELECT
  wei_ratings.team_id,
  wei_ratings.date,
  (
    round(
      avg((wei_ratings.off_rating) :: numeric) OVER (
        PARTITION BY wei_ratings.team_id
        ORDER BY
          wei_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
      ),
      2
    )
  ) :: real AS off_rating,
  (
    round(
      avg((wei_ratings.off_rating_spread) :: numeric) OVER (
        PARTITION BY wei_ratings.team_id
        ORDER BY
          wei_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
      ),
      2
    )
  ) :: real AS off_rating_spread,
  (
    round(
      avg((wei_ratings.def_rating) :: numeric) OVER (
        PARTITION BY wei_ratings.team_id
        ORDER BY
          wei_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
      ),
      2
    )
  ) :: real AS def_rating,
  (
    round(
      avg((wei_ratings.def_rating_spread) :: numeric) OVER (
        PARTITION BY wei_ratings.team_id
        ORDER BY
          wei_ratings.date DESC ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
      ),
      2
    )
  ) :: real AS def_rating_spread
FROM
  wei_ratings;