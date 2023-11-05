{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['team_id', 'date'], 'unique': True},
        ],
    ) 
}}

select 
    team_id, 
    date, 
    round(
        avg(off_rating::numeric)
        over(
            partition by team_id 
            order by date desc 
            ROWS BETWEEN 4 preceding and current row
        )
    ,2) as off_rating,
    round(
        avg(def_rating::numeric)
        over(
            partition by team_id 
            order by date desc 
            ROWS BETWEEN 4 preceding and current row
        )
    ,2) as def_rating
from poiss_ratings