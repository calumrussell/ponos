{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['team_id'], 'unique': True},
        ],
    ) 
}}

select 
    elo_ratings.team_id, 
    elo_ratings.rating, 
    elo_ratings.date 
    from elo_ratings 
    right join (
        select 
        max(date), 
        team_id 
        from elo_ratings 
        group by team_id
    ) as max 
    on max.team_id=elo_ratings.team_id and max.max=elo_ratings.date