SELECT
  poiss_ratings.team_id,
  poiss_ratings.off_rating,
  poiss_ratings.def_rating,
  poiss_ratings.date
FROM
  (
    poiss_ratings
    RIGHT JOIN (
      SELECT
        max(poiss_ratings_1.date) AS max,
        poiss_ratings_1.team_id
      FROM
        poiss_ratings poiss_ratings_1
      GROUP BY
        poiss_ratings_1.team_id
    ) max ON (
      (
        (max.team_id = poiss_ratings.team_id)
        AND (max.max = poiss_ratings.date)
      )
    )
  );