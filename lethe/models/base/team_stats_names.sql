{{ 
    config(
        materialized='view',
    ) 
}}

select 
team_stats.*,
team.name as team
from team_stats 
left join team on team.id=team_stats.team_id