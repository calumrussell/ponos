{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['team_id'], 'unique': True},
        ],
    ) 
}}

select 
    wei_ratings.team_id, 
    wei_ratings.off_rating, 
    wei_ratings.off_rating_spread, 
    wei_ratings.def_rating, 
    wei_ratings.def_rating_spread, 
    wei_ratings.date 
    from wei_ratings 
    right join (
        select 
        max(date), 
        team_id 
        from wei_ratings 
        group by team_id
    ) as max 
    on max.team_id=wei_ratings.team_id and max.max=wei_ratings.date