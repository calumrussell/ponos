{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['id'], 'unique': True},
        ],
    ) 
}}

select 
    *
    from match
    where (year = 2023 or year = 2024)
    and id in (select distinct(match_id) from player_stats)
