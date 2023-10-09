{{ 
    config(
        materialized='table',
        indexes = [
            {'columns': ['team_id', 'match_id'], 'unique': True},
        ],
        post_hook = "alter table team_stats_names alter column team_id set not null; alter table team_stats_names alter column match_id set not null;",
    ) 
}}

select 
team_stats.*,
team.name as team
from team_stats 
left join team on team.id=team_stats.team_id