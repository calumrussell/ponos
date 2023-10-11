{{ 
    config(
        materialized='table',
        indexes = [
            {'columns': ['player_id', 'match_id'], 'unique': True},
        ],
        post_hook = "alter table player_stats_names alter column player_id set not null; alter table player_stats_names alter column match_id set not null;",
    ) 
}}

select 
player_stats.*,
team.name as team,
player.name as player
from player_stats
left join team on team.id=player_stats.team_id
left join player on player.id=player_stats.player_id