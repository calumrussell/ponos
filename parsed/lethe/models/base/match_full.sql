{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['id'], 'unique': True},
        ]
    )
}}

select 
match.*,
home.name as home,
away.name as away
from match
left join team as home on home.id=match.home_id
left join team as away on away.id=match.away_id