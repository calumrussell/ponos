{{ 
    config(
        materialized='view',
    ) 
}}

select 
player_stats.*,
team.name as team,
player.name as player
from player_stats
left join team on team.id=player_stats.team_id
left join player on player.id=player_stats.player_id