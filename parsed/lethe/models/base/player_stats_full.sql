{{ 
    config(
        materialized='table',
        indexes = [
            {'columns': ['player_id', 'match_id'], 'unique': True},
        ],
        post_hook = "alter table player_stats_full alter column player_id set not null; alter table player_stats_full alter column match_id set not null;"
    ) 
}}

with xg_player as (
    select sum(prob) as prob, player_id, match_id from xg group by(player_id, match_id)
)

select 
player_stats.*,
team.name as team,
opp.name as opp,
player.name as player,
match.year,
tournament.name as tournament,
match.start_date,
CASE WHEN xg_player.prob is NULL THEN 0 ELSE xg_player.prob END AS xg
from player_stats
left join team on team.id=player_stats.team_id
left join team as opp on opp.id=player_stats.opp_id
left join player on player.id=player_stats.player_id
left join match on player_stats.match_id=match.id
left join xg_player on player_stats.player_id=xg_player.player_id and player_stats.match_id=xg_player.match_id
left join tournament on tournament.id=match.tournament_id
