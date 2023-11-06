SELECT
  player_stats_full.player_id,
  player_stats_full.player,
  player_stats_full.team_id,
  player_stats_full.team,
  (
    (
      (sum(player_stats_full.pass)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_avg,
  (
    (
      (sum(player_stats_full.pass_corner)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_corner_avg,
  (
    (
      (sum(player_stats_full.pass_longball)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_longball_avg,
  (
    (
      (sum(player_stats_full.pass_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_cross_avg,
  (
    (
      (sum(player_stats_full.pass_back)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_back_avg,
  (
    (
      (sum(player_stats_full.pass_forward)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_forward_avg,
  (
    (
      (sum(player_stats_full.pass_left)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_left_avg,
  (
    (
      (sum(player_stats_full.pass_right)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_right_avg,
  (
    (
      (sum(player_stats_full.pass_short)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_short_avg,
  (
    (
      (sum(player_stats_full.pass_throughball)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_throughball_avg,
  (
    (
      (sum(player_stats_full.pass_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_accurate_avg,
  (
    (
      (sum(player_stats_full.pass_short_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_short_accurate_avg,
  (
    (
      (sum(player_stats_full.pass_corner_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_corner_accurate_avg,
  (
    (
      (sum(player_stats_full.pass_longball_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_longball_accurate_avg,
  (
    (
      (sum(player_stats_full.pass_cross_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_cross_accurate_avg,
  (
    (
      (sum(player_stats_full.pass_throughball_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_throughball_accurate_avg,
  (
    (
      (sum(player_stats_full.pass_key)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_key_avg,
  (
    (
      (sum(player_stats_full.pass_key_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_key_cross_avg,
  (
    (
      (sum(player_stats_full.pass_key_freekick)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_key_freekick_avg,
  (
    (
      (sum(player_stats_full.pass_key_corner)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_key_corner_avg,
  (
    (
      (sum(player_stats_full.pass_key_throughball)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS pass_key_throughball_avg,
  (
    (
      (sum(player_stats_full.shot)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_avg,
  (
    (
      (sum(player_stats_full.shot_on_target)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_on_target_avg,
  (
    (
      (sum(player_stats_full.shot_off_target)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_off_target_avg,
  (
    (
      (sum(player_stats_full.shot_blocked)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_blocked_avg,
  (
    (
      (sum(player_stats_full.shot_open_play)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_open_play_avg,
  (
    (
      (sum(player_stats_full.shot_set_piece)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_set_piece_avg,
  (
    (
      (sum(player_stats_full.shot_on_post)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_on_post_avg,
  (
    (
      (sum(player_stats_full.shot_six_yard_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_six_yard_box_avg,
  (
    (
      (sum(player_stats_full.shot_penalty_area)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_penalty_area_avg,
  (
    (
      (sum(player_stats_full.shot_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_box_avg,
  (
    (
      (sum(player_stats_full.shot_counter)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_counter_avg,
  (
    (
      (sum(player_stats_full.shot_head)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_head_avg,
  (
    (
      (sum(player_stats_full.shot_foot)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_foot_avg,
  (
    (
      (sum(player_stats_full.shot_0bp)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS shot_0bp_avg,
  (
    (
      (sum(player_stats_full.goal)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_avg,
  (
    (
      (sum(player_stats_full.goal_normal)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_normal_avg,
  (
    (
      (sum(player_stats_full.goal_head)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_head_avg,
  (
    (
      (sum(player_stats_full.goal_foot)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_foot_avg,
  (
    (
      (sum(player_stats_full.goal_set_piece)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_set_piece_avg,
  (
    (
      (sum(player_stats_full.goal_own)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_own_avg,
  (
    (
      (sum(player_stats_full.goal_counter)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_counter_avg,
  (
    (
      (sum(player_stats_full.goal_open_play)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_open_play_avg,
  (
    (
      (sum(player_stats_full.goal_0bp)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_0bp_avg,
  (
    (
      (sum(player_stats_full.goal_0box)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_0box_avg,
  (
    (
      (sum(player_stats_full.goal_six_yard_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_six_yard_box_avg,
  (
    (
      (sum(player_stats_full.goal_penalty_area)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS goal_penalty_area_avg,
  (
    (
      (sum(player_stats_full.assist)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS assist_avg,
  (
    (
      (sum(player_stats_full.assist_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS assist_cross_avg,
  (
    (
      (sum(player_stats_full.assist_corner)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS assist_corner_avg,
  (
    (
      (sum(player_stats_full.assist_throughball)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS assist_throughball_avg,
  (
    (
      (sum(player_stats_full.aerial_duel)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS aerial_duel_avg,
  (
    (
      (sum(player_stats_full.red_card)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS red_card_avg,
  (
    (
      (sum(player_stats_full.yellow_card)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS yellow_card_avg,
  (
    (
      (sum(player_stats_full.second_yellow_card)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS second_yellow_card_avg,
  (
    (
      (sum(player_stats_full.save)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS save_avg,
  (
    (
      (sum(player_stats_full.duel)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS duel_avg,
  (
    (
      (sum(player_stats_full.duel_offensive)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS duel_offensive_avg,
  (
    (
      (sum(player_stats_full.duel_defensive)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS duel_defensive_avg,
  (
    (
      (sum(player_stats_full.dispossessed)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS dispossessed_avg,
  (
    (
      (sum(player_stats_full.turnover)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS turnover_avg,
  (
    (
      (sum(player_stats_full.dribble)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS dribble_avg,
  (
    (
      (sum(player_stats_full.dribble_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS dribble_won_avg,
  (
    (
      (sum(player_stats_full.dribble_lost)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS dribble_lost_avg,
  (
    (
      (sum(player_stats_full.dribble_last_man)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS dribble_last_man_avg,
  (
    (
      (sum(player_stats_full.challenge_lost)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS challenge_lost_avg,
  (
    (
      (sum(player_stats_full.blocked_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS blocked_cross_avg,
  (
    (
      (sum(player_stats_full.block_outfielder)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS block_outfielder_avg,
  (
    (
      (sum(player_stats_full.block_six_yard)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS block_six_yard_avg,
  (
    (
      (sum(player_stats_full.block_pass_outfielder)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS block_pass_outfielder_avg,
  (
    (
      (sum(player_stats_full.interception)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS interception_avg,
  (
    (
      (sum(player_stats_full.interception_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS interception_won_avg,
  (
    (
      (sum(player_stats_full.interception_in_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS interception_in_box_avg,
  (
    (
      (sum(player_stats_full.tackle)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS tackle_avg,
  (
    (
      (sum(player_stats_full.tackle_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS tackle_won_avg,
  (
    (
      (sum(player_stats_full.tackle_lost)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS tackle_lost_avg,
  (
    (
      (sum(player_stats_full.tackle_last_man)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS tackle_last_man_avg,
  (
    (
      (sum(player_stats_full.offside_given)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS offside_given_avg,
  (
    (
      (sum(player_stats_full.offside_provoked)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS offside_provoked_avg,
  (
    (
      (sum(player_stats_full.ball_recovery)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS ball_recovery_avg,
  (
    (
      (sum(player_stats_full.clearance)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS clearance_avg,
  (
    (
      (sum(player_stats_full.clearance_effective)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS clearance_effective_avg,
  (
    (
      (sum(player_stats_full.clearance_off_line)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS clearance_off_line_avg,
  (
    (
      (sum(player_stats_full.error_leads_to_goal)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS error_leads_to_goal_avg,
  (
    (
      (sum(player_stats_full.error_leads_to_shot)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS error_leads_to_shot_avg,
  (
    (
      (sum(player_stats_full.touch)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS touch_avg,
  (
    (
      (sum(player_stats_full.penalty_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS penalty_won_avg,
  (
    (
      (sum(player_stats_full.penalty_conceded)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS penalty_conceded_avg,
  (
    (
      (sum(player_stats_full.penalty_scored)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS penalty_scored_avg,
  (
    (
      (sum(player_stats_full.big_chance_missed)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS big_chance_missed_avg,
  (
    (
      (sum(player_stats_full.big_chance_scored)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS big_chance_scored_avg,
  (
    (
      (sum(player_stats_full.big_chance_created)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS big_chance_created_avg,
  (
    (
      (sum(player_stats_full.parried_safe)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS parried_safe_avg,
  (
    (
      (sum(player_stats_full.parried_danger)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS parried_danger_avg,
  (
    (
      (sum(player_stats_full.save_keeper)) :: real / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS save_keeper_avg,
  (
    (
      sum(player_stats_full.xg) / (sum(player_stats_full.minutes)) :: double precision
    ) * (90) :: real
  ) AS xg_avg,
  player_stats_full.year,
  player_stats_full.tournament
FROM
  player_stats_full
GROUP BY
  player_stats_full.team,
  player_stats_full.team_id,
  player_stats_full.player_id,
  player_stats_full.player,
  player_stats_full.year,
  player_stats_full.tournament;