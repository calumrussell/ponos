{{ 
    config(
        materialized='table',
        indexes = [
            {'columns': ['id'], 'unique': True},
        ],
        post_hook = "alter table match_full alter column id set not null;"
    )
}}

select 
match.*,
home.name as home,
away.name as away,
tournament.name as tournament
from match
left join team as home on home.id=match.home_id
left join team as away on away.id=match.away_id
left join tournament on tournament.id=match.tournament_id