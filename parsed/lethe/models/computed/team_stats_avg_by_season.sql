{{ 
    config(
        materialized='view',
        indexes = [
            {'columns': ['team_id', 'year', 'tournament'], 'unique': True},
        ],
    ) 
}}

{% set stat_groups = [
    "pass",
    "pass_corner",
    "pass_longball",
    "pass_cross",
    "pass_back",
    "pass_forward",
    "pass_left",
    "pass_right",
    "pass_short",
    "pass_throughball",
    "pass_accurate",
    "pass_short_accurate",
    "pass_corner_accurate",
    "pass_longball_accurate",
    "pass_cross_accurate",
    "pass_throughball_accurate",
    "pass_key",
    "pass_key_cross",
    "pass_key_freekick",
    "pass_key_corner",
    "pass_key_throughball",
    "shot",
    "shot_on_target",
    "shot_off_target",
    "shot_blocked",
    "shot_open_play",
    "shot_set_piece",
    "shot_on_post",
    "shot_six_yard_box",
    "shot_penalty_area",
    "shot_box",
    "shot_counter",
    "shot_head",
    "shot_foot",
    "shot_0bp",
    "goal",
    "goal_normal",
    "goal_head",
    "goal_foot",
    "goal_set_piece",
    "goal_own",
    "goal_counter",
    "goal_open_play",
    "goal_0bp",
    "goal_0box",
    "goal_six_yard_box",
    "goal_penalty_area",
    "assist",
    "assist_cross",
    "assist_corner",
    "assist_throughball",
    "aerial_duel",
    "red_card",
    "yellow_card",
    "second_yellow_card",
    "save",
    "duel",
    "duel_offensive",
    "duel_defensive",
    "dispossessed",
    "turnover",
    "dribble",
    "dribble_won",
    "dribble_lost",
    "dribble_last_man",
    "challenge_lost",
    "blocked_cross",
    "block_outfielder",
    "block_six_yard",
    "block_pass_outfielder",
    "interception",
    "interception_won",
    "interception_in_box",
    "tackle",
    "tackle_won",
    "tackle_lost",
    "tackle_last_man",
    "offside_given",
    "offside_provoked",
    "ball_recovery",
    "clearance",
    "clearance_effective",
    "clearance_off_line",
    "error_leads_to_goal",
    "error_leads_to_shot",
    "touch",
    "penalty_won",
    "penalty_conceded",
    "penalty_scored",
    "big_chance_missed",
    "big_chance_scored",
    "big_chance_created",
    "parried_safe",
    "parried_danger",
    "save_keeper"
] %}

select 
    team_id,
    team,
    {% for stat in stat_groups %}
    sum({{stat}})::real / count(match_id)::real as {{stat}}_avg,
    sum(opp_{{stat}})::real / count(match_id)::real as opp_{{stat}}_avg,
    {% endfor %}
    sum(xg)::real / count(match_id)::real as xg_avg,
    sum(opp_xg)::real / count(match_id)::real as opp_xg_avg,
    year,
    tournament
from {{ref('team_stats_full')}}
group by(team_id, team, year, tournament)