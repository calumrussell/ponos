{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['team_id', 'date'], 'unique': True},
        ],
    ) 
}}

select 
    poiss_ratings.team_id, 
    poiss_ratings.off_rating, 
    poiss_ratings.def_rating, 
    poiss_ratings.date 
    from poiss_ratings 
    right join (
        select 
        max(date), 
        team_id 
        from poiss_ratings 
        group by team_id
    ) as max 
    on max.team_id=poiss_ratings.team_id and max.max=poiss_ratings.date