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
        avg(rating) 
        over(
            partition by team_id 
            order by date desc 
            ROWS BETWEEN 4 preceding and current row
        )
    ,2)::real as rating
from elo_ratings