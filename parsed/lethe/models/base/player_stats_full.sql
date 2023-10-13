{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['player_id', 'match_id'], 'unique': True},
        ],
    ) 
}}

select 
player_stats.*,
team.name as team,
player.name as player
from player_stats
left join team on team.id=player_stats.team_id
left join player on player.id=player_stats.player_id
left join match on player_stats.match_id=match.id