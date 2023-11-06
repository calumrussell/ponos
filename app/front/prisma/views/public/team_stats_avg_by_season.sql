SELECT
  team_stats_full.team_id,
  team_stats_full.team,
  (
    (sum(team_stats_full.pass)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_avg,
  (
    (sum(team_stats_full.opp_pass)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_avg,
  (
    (sum(team_stats_full.pass_corner)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_corner_avg,
  (
    (sum(team_stats_full.opp_pass_corner)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_corner_avg,
  (
    (sum(team_stats_full.pass_longball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_longball_avg,
  (
    (sum(team_stats_full.opp_pass_longball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_longball_avg,
  (
    (sum(team_stats_full.pass_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_cross_avg,
  (
    (sum(team_stats_full.opp_pass_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_cross_avg,
  (
    (sum(team_stats_full.pass_back)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_back_avg,
  (
    (sum(team_stats_full.opp_pass_back)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_back_avg,
  (
    (sum(team_stats_full.pass_forward)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_forward_avg,
  (
    (sum(team_stats_full.opp_pass_forward)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_forward_avg,
  (
    (sum(team_stats_full.pass_left)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_left_avg,
  (
    (sum(team_stats_full.opp_pass_left)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_left_avg,
  (
    (sum(team_stats_full.pass_right)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_right_avg,
  (
    (sum(team_stats_full.opp_pass_right)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_right_avg,
  (
    (sum(team_stats_full.pass_short)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_short_avg,
  (
    (sum(team_stats_full.opp_pass_short)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_short_avg,
  (
    (sum(team_stats_full.pass_throughball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_throughball_avg,
  (
    (sum(team_stats_full.opp_pass_throughball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_throughball_avg,
  (
    (sum(team_stats_full.pass_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_accurate_avg,
  (
    (sum(team_stats_full.opp_pass_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_accurate_avg,
  (
    (sum(team_stats_full.pass_short_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_short_accurate_avg,
  (
    (sum(team_stats_full.opp_pass_short_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_short_accurate_avg,
  (
    (sum(team_stats_full.pass_corner_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_corner_accurate_avg,
  (
    (sum(team_stats_full.opp_pass_corner_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_corner_accurate_avg,
  (
    (sum(team_stats_full.pass_longball_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_longball_accurate_avg,
  (
    (sum(team_stats_full.opp_pass_longball_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_longball_accurate_avg,
  (
    (sum(team_stats_full.pass_cross_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_cross_accurate_avg,
  (
    (sum(team_stats_full.opp_pass_cross_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_cross_accurate_avg,
  (
    (sum(team_stats_full.pass_throughball_accurate)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_throughball_accurate_avg,
  (
    (
      sum(team_stats_full.opp_pass_throughball_accurate)
    ) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_throughball_accurate_avg,
  (
    (sum(team_stats_full.pass_key)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_key_avg,
  (
    (sum(team_stats_full.opp_pass_key)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_key_avg,
  (
    (sum(team_stats_full.pass_key_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_key_cross_avg,
  (
    (sum(team_stats_full.opp_pass_key_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_key_cross_avg,
  (
    (sum(team_stats_full.pass_key_freekick)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_key_freekick_avg,
  (
    (sum(team_stats_full.opp_pass_key_freekick)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_key_freekick_avg,
  (
    (sum(team_stats_full.pass_key_corner)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_key_corner_avg,
  (
    (sum(team_stats_full.opp_pass_key_corner)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_key_corner_avg,
  (
    (sum(team_stats_full.pass_key_throughball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS pass_key_throughball_avg,
  (
    (sum(team_stats_full.opp_pass_key_throughball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_pass_key_throughball_avg,
  (
    (sum(team_stats_full.shot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_avg,
  (
    (sum(team_stats_full.opp_shot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_avg,
  (
    (sum(team_stats_full.shot_on_target)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_on_target_avg,
  (
    (sum(team_stats_full.opp_shot_on_target)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_on_target_avg,
  (
    (sum(team_stats_full.shot_off_target)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_off_target_avg,
  (
    (sum(team_stats_full.opp_shot_off_target)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_off_target_avg,
  (
    (sum(team_stats_full.shot_blocked)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_blocked_avg,
  (
    (sum(team_stats_full.opp_shot_blocked)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_blocked_avg,
  (
    (sum(team_stats_full.shot_open_play)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_open_play_avg,
  (
    (sum(team_stats_full.opp_shot_open_play)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_open_play_avg,
  (
    (sum(team_stats_full.shot_set_piece)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_set_piece_avg,
  (
    (sum(team_stats_full.opp_shot_set_piece)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_set_piece_avg,
  (
    (sum(team_stats_full.shot_on_post)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_on_post_avg,
  (
    (sum(team_stats_full.opp_shot_on_post)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_on_post_avg,
  (
    (sum(team_stats_full.shot_six_yard_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_six_yard_box_avg,
  (
    (sum(team_stats_full.opp_shot_six_yard_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_six_yard_box_avg,
  (
    (sum(team_stats_full.shot_penalty_area)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_penalty_area_avg,
  (
    (sum(team_stats_full.opp_shot_penalty_area)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_penalty_area_avg,
  (
    (sum(team_stats_full.shot_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_box_avg,
  (
    (sum(team_stats_full.opp_shot_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_box_avg,
  (
    (sum(team_stats_full.shot_counter)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_counter_avg,
  (
    (sum(team_stats_full.opp_shot_counter)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_counter_avg,
  (
    (sum(team_stats_full.shot_head)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_head_avg,
  (
    (sum(team_stats_full.opp_shot_head)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_head_avg,
  (
    (sum(team_stats_full.shot_foot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_foot_avg,
  (
    (sum(team_stats_full.opp_shot_foot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_foot_avg,
  (
    (sum(team_stats_full.shot_0bp)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS shot_0bp_avg,
  (
    (sum(team_stats_full.opp_shot_0bp)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_shot_0bp_avg,
  (
    (sum(team_stats_full.goal)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_avg,
  (
    (sum(team_stats_full.opp_goal)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_avg,
  (
    (sum(team_stats_full.goal_normal)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_normal_avg,
  (
    (sum(team_stats_full.opp_goal_normal)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_normal_avg,
  (
    (sum(team_stats_full.goal_head)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_head_avg,
  (
    (sum(team_stats_full.opp_goal_head)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_head_avg,
  (
    (sum(team_stats_full.goal_foot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_foot_avg,
  (
    (sum(team_stats_full.opp_goal_foot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_foot_avg,
  (
    (sum(team_stats_full.goal_set_piece)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_set_piece_avg,
  (
    (sum(team_stats_full.opp_goal_set_piece)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_set_piece_avg,
  (
    (sum(team_stats_full.goal_own)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_own_avg,
  (
    (sum(team_stats_full.opp_goal_own)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_own_avg,
  (
    (sum(team_stats_full.goal_counter)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_counter_avg,
  (
    (sum(team_stats_full.opp_goal_counter)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_counter_avg,
  (
    (sum(team_stats_full.goal_open_play)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_open_play_avg,
  (
    (sum(team_stats_full.opp_goal_open_play)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_open_play_avg,
  (
    (sum(team_stats_full.goal_0bp)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_0bp_avg,
  (
    (sum(team_stats_full.opp_goal_0bp)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_0bp_avg,
  (
    (sum(team_stats_full.goal_0box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_0box_avg,
  (
    (sum(team_stats_full.opp_goal_0box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_0box_avg,
  (
    (sum(team_stats_full.goal_six_yard_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_six_yard_box_avg,
  (
    (sum(team_stats_full.opp_goal_six_yard_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_six_yard_box_avg,
  (
    (sum(team_stats_full.goal_penalty_area)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS goal_penalty_area_avg,
  (
    (sum(team_stats_full.opp_goal_penalty_area)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_goal_penalty_area_avg,
  (
    (sum(team_stats_full.assist)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS assist_avg,
  (
    (sum(team_stats_full.opp_assist)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_assist_avg,
  (
    (sum(team_stats_full.assist_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS assist_cross_avg,
  (
    (sum(team_stats_full.opp_assist_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_assist_cross_avg,
  (
    (sum(team_stats_full.assist_corner)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS assist_corner_avg,
  (
    (sum(team_stats_full.opp_assist_corner)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_assist_corner_avg,
  (
    (sum(team_stats_full.assist_throughball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS assist_throughball_avg,
  (
    (sum(team_stats_full.opp_assist_throughball)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_assist_throughball_avg,
  (
    (sum(team_stats_full.aerial_duel)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS aerial_duel_avg,
  (
    (sum(team_stats_full.opp_aerial_duel)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_aerial_duel_avg,
  (
    (sum(team_stats_full.red_card)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS red_card_avg,
  (
    (sum(team_stats_full.opp_red_card)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_red_card_avg,
  (
    (sum(team_stats_full.yellow_card)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS yellow_card_avg,
  (
    (sum(team_stats_full.opp_yellow_card)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_yellow_card_avg,
  (
    (sum(team_stats_full.second_yellow_card)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS second_yellow_card_avg,
  (
    (sum(team_stats_full.opp_second_yellow_card)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_second_yellow_card_avg,
  (
    (sum(team_stats_full.save)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS save_avg,
  (
    (sum(team_stats_full.opp_save)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_save_avg,
  (
    (sum(team_stats_full.duel)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS duel_avg,
  (
    (sum(team_stats_full.opp_duel)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_duel_avg,
  (
    (sum(team_stats_full.duel_offensive)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS duel_offensive_avg,
  (
    (sum(team_stats_full.opp_duel_offensive)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_duel_offensive_avg,
  (
    (sum(team_stats_full.duel_defensive)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS duel_defensive_avg,
  (
    (sum(team_stats_full.opp_duel_defensive)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_duel_defensive_avg,
  (
    (sum(team_stats_full.dispossessed)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS dispossessed_avg,
  (
    (sum(team_stats_full.opp_dispossessed)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_dispossessed_avg,
  (
    (sum(team_stats_full.turnover)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS turnover_avg,
  (
    (sum(team_stats_full.opp_turnover)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_turnover_avg,
  (
    (sum(team_stats_full.dribble)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS dribble_avg,
  (
    (sum(team_stats_full.opp_dribble)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_dribble_avg,
  (
    (sum(team_stats_full.dribble_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS dribble_won_avg,
  (
    (sum(team_stats_full.opp_dribble_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_dribble_won_avg,
  (
    (sum(team_stats_full.dribble_lost)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS dribble_lost_avg,
  (
    (sum(team_stats_full.opp_dribble_lost)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_dribble_lost_avg,
  (
    (sum(team_stats_full.dribble_last_man)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS dribble_last_man_avg,
  (
    (sum(team_stats_full.opp_dribble_last_man)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_dribble_last_man_avg,
  (
    (sum(team_stats_full.challenge_lost)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS challenge_lost_avg,
  (
    (sum(team_stats_full.opp_challenge_lost)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_challenge_lost_avg,
  (
    (sum(team_stats_full.blocked_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS blocked_cross_avg,
  (
    (sum(team_stats_full.opp_blocked_cross)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_blocked_cross_avg,
  (
    (sum(team_stats_full.block_outfielder)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS block_outfielder_avg,
  (
    (sum(team_stats_full.opp_block_outfielder)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_block_outfielder_avg,
  (
    (sum(team_stats_full.block_six_yard)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS block_six_yard_avg,
  (
    (sum(team_stats_full.opp_block_six_yard)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_block_six_yard_avg,
  (
    (sum(team_stats_full.block_pass_outfielder)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS block_pass_outfielder_avg,
  (
    (sum(team_stats_full.opp_block_pass_outfielder)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_block_pass_outfielder_avg,
  (
    (sum(team_stats_full.interception)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS interception_avg,
  (
    (sum(team_stats_full.opp_interception)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_interception_avg,
  (
    (sum(team_stats_full.interception_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS interception_won_avg,
  (
    (sum(team_stats_full.opp_interception_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_interception_won_avg,
  (
    (sum(team_stats_full.interception_in_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS interception_in_box_avg,
  (
    (sum(team_stats_full.opp_interception_in_box)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_interception_in_box_avg,
  (
    (sum(team_stats_full.tackle)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS tackle_avg,
  (
    (sum(team_stats_full.opp_tackle)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_tackle_avg,
  (
    (sum(team_stats_full.tackle_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS tackle_won_avg,
  (
    (sum(team_stats_full.opp_tackle_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_tackle_won_avg,
  (
    (sum(team_stats_full.tackle_lost)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS tackle_lost_avg,
  (
    (sum(team_stats_full.opp_tackle_lost)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_tackle_lost_avg,
  (
    (sum(team_stats_full.tackle_last_man)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS tackle_last_man_avg,
  (
    (sum(team_stats_full.opp_tackle_last_man)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_tackle_last_man_avg,
  (
    (sum(team_stats_full.offside_given)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS offside_given_avg,
  (
    (sum(team_stats_full.opp_offside_given)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_offside_given_avg,
  (
    (sum(team_stats_full.offside_provoked)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS offside_provoked_avg,
  (
    (sum(team_stats_full.opp_offside_provoked)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_offside_provoked_avg,
  (
    (sum(team_stats_full.ball_recovery)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS ball_recovery_avg,
  (
    (sum(team_stats_full.opp_ball_recovery)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_ball_recovery_avg,
  (
    (sum(team_stats_full.clearance)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS clearance_avg,
  (
    (sum(team_stats_full.opp_clearance)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_clearance_avg,
  (
    (sum(team_stats_full.clearance_effective)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS clearance_effective_avg,
  (
    (sum(team_stats_full.opp_clearance_effective)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_clearance_effective_avg,
  (
    (sum(team_stats_full.clearance_off_line)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS clearance_off_line_avg,
  (
    (sum(team_stats_full.opp_clearance_off_line)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_clearance_off_line_avg,
  (
    (sum(team_stats_full.error_leads_to_goal)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS error_leads_to_goal_avg,
  (
    (sum(team_stats_full.opp_error_leads_to_goal)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_error_leads_to_goal_avg,
  (
    (sum(team_stats_full.error_leads_to_shot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS error_leads_to_shot_avg,
  (
    (sum(team_stats_full.opp_error_leads_to_shot)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_error_leads_to_shot_avg,
  (
    (sum(team_stats_full.touch)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS touch_avg,
  (
    (sum(team_stats_full.opp_touch)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_touch_avg,
  (
    (sum(team_stats_full.penalty_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS penalty_won_avg,
  (
    (sum(team_stats_full.opp_penalty_won)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_penalty_won_avg,
  (
    (sum(team_stats_full.penalty_conceded)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS penalty_conceded_avg,
  (
    (sum(team_stats_full.opp_penalty_conceded)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_penalty_conceded_avg,
  (
    (sum(team_stats_full.penalty_scored)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS penalty_scored_avg,
  (
    (sum(team_stats_full.opp_penalty_scored)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_penalty_scored_avg,
  (
    (sum(team_stats_full.big_chance_missed)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS big_chance_missed_avg,
  (
    (sum(team_stats_full.opp_big_chance_missed)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_big_chance_missed_avg,
  (
    (sum(team_stats_full.big_chance_scored)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS big_chance_scored_avg,
  (
    (sum(team_stats_full.opp_big_chance_scored)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_big_chance_scored_avg,
  (
    (sum(team_stats_full.big_chance_created)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS big_chance_created_avg,
  (
    (sum(team_stats_full.opp_big_chance_created)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_big_chance_created_avg,
  (
    (sum(team_stats_full.parried_safe)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS parried_safe_avg,
  (
    (sum(team_stats_full.opp_parried_safe)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_parried_safe_avg,
  (
    (sum(team_stats_full.parried_danger)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS parried_danger_avg,
  (
    (sum(team_stats_full.opp_parried_danger)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_parried_danger_avg,
  (
    (sum(team_stats_full.save_keeper)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS save_keeper_avg,
  (
    (sum(team_stats_full.opp_save_keeper)) :: real / (count(team_stats_full.match_id)) :: real
  ) AS opp_save_keeper_avg,
  (
    sum(team_stats_full.xg) / (count(team_stats_full.match_id)) :: real
  ) AS xg_avg,
  (
    sum(team_stats_full.opp_xg) / (count(team_stats_full.match_id)) :: real
  ) AS opp_xg_avg,
  team_stats_full.year,
  team_stats_full.tournament
FROM
  team_stats_full
GROUP BY
  team_stats_full.team_id,
  team_stats_full.team,
  team_stats_full.year,
  team_stats_full.tournament;