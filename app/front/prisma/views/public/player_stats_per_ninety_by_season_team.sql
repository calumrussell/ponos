SELECT
  player_stats_full.player_id,
  player_stats_full.player,
  player_stats_full.team_id,
  player_stats_full.team,
  (sum(player_stats_full.minutes)) :: real AS minutes,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_corner)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_corner_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_longball)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_longball_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_cross_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_back)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_back_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_forward)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_forward_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_left)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_left_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_right)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_right_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_short)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_short_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_throughball)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_throughball_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_accurate_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_short_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_short_accurate_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_corner_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_corner_accurate_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_longball_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_longball_accurate_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_cross_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_cross_accurate_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_throughball_accurate)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_throughball_accurate_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_key)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_key_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_key_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_key_cross_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_key_freekick)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_key_freekick_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_key_corner)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_key_corner_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.pass_key_throughball)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS pass_key_throughball_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_on_target)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_on_target_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_off_target)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_off_target_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_blocked)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_blocked_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_open_play)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_open_play_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_set_piece)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_set_piece_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_on_post)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_on_post_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_six_yard_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_six_yard_box_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_penalty_area)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_penalty_area_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_box_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_counter)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_counter_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_head)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_head_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_foot)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_foot_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.shot_0bp)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS shot_0bp_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_normal)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_normal_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_head)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_head_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_foot)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_foot_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_set_piece)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_set_piece_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_own)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_own_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_counter)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_counter_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_open_play)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_open_play_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_0bp)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_0bp_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_0box)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_0box_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_six_yard_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_six_yard_box_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.goal_penalty_area)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS goal_penalty_area_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.assist)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS assist_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.assist_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS assist_cross_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.assist_corner)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS assist_corner_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.assist_throughball)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS assist_throughball_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.aerial_duel)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS aerial_duel_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.red_card)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS red_card_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.yellow_card)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS yellow_card_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.second_yellow_card)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS second_yellow_card_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.save)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS save_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.duel)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS duel_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.duel_offensive)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS duel_offensive_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.duel_defensive)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS duel_defensive_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.dispossessed)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS dispossessed_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.turnover)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS turnover_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.dribble)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS dribble_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.dribble_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS dribble_won_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.dribble_lost)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS dribble_lost_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.dribble_last_man)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS dribble_last_man_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.challenge_lost)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS challenge_lost_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.blocked_cross)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS blocked_cross_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.block_outfielder)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS block_outfielder_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.block_six_yard)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS block_six_yard_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.block_pass_outfielder)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS block_pass_outfielder_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.interception)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS interception_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.interception_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS interception_won_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.interception_in_box)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS interception_in_box_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.tackle)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS tackle_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.tackle_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS tackle_won_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.tackle_lost)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS tackle_lost_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.tackle_last_man)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS tackle_last_man_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.offside_given)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS offside_given_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.offside_provoked)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS offside_provoked_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.ball_recovery)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS ball_recovery_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.clearance)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS clearance_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.clearance_effective)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS clearance_effective_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.clearance_off_line)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS clearance_off_line_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.error_leads_to_goal)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS error_leads_to_goal_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.error_leads_to_shot)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS error_leads_to_shot_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.touch)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS touch_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.penalty_won)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS penalty_won_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.penalty_conceded)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS penalty_conceded_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.penalty_scored)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS penalty_scored_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.big_chance_missed)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS big_chance_missed_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.big_chance_scored)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS big_chance_scored_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.big_chance_created)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS big_chance_created_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.parried_safe)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS parried_safe_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.parried_danger)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS parried_danger_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        (sum(player_stats_full.save_keeper)) :: real / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS save_keeper_avg,
  CASE
    WHEN (sum(player_stats_full.minutes) <> 0) THEN (
      (
        sum(player_stats_full.xg) / (sum(player_stats_full.minutes)) :: double precision
      ) * (90) :: real
    )
    ELSE (0) :: double precision
  END AS xg_avg,
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