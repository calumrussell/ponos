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
    ,2)::real as off_rating,
    round(
        avg(off_rating_spread::numeric)
        over(
            partition by team_id 
            order by date desc 
            ROWS BETWEEN 4 preceding and current row
        )
    ,2)::real as off_rating_spread,
    round(
        avg(def_rating::numeric)
        over(
            partition by team_id 
            order by date desc 
            ROWS BETWEEN 4 preceding and current row
        )
    ,2)::real as def_rating,
    round(
        avg(def_rating_spread::numeric)
        over(
            partition by team_id 
            order by date desc 
            ROWS BETWEEN 4 preceding and current row
        )
    ,2)::real as def_rating_spread
from wei_ratings