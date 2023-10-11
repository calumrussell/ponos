{{ 
    config(
        materialized='table',
        indexes = [
            {'columns': ['id'], 'unique': True},
        ],
        post_hook = "alter table match_names alter column id set not null;",
    )
}}

select 
match.*,
home.name as home,
away.name as away
from match
left join team as home on home.id=match.home_id
left join team as away on away.id=match.away_id