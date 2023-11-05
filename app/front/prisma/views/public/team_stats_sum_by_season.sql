SELECT
  team_stats_full.team_id,
  team_stats_full.team,
  sum(team_stats_full.pass) AS pass,
  sum(team_stats_full.opp_pass) AS opp_pass,
  sum(team_stats_full.pass_corner) AS pass_corner,
  sum(team_stats_full.opp_pass_corner) AS opp_pass_corner,
  sum(team_stats_full.pass_longball) AS pass_longball,
  sum(team_stats_full.opp_pass_longball) AS opp_pass_longball,
  sum(team_stats_full.pass_cross) AS pass_cross,
  sum(team_stats_full.opp_pass_cross) AS opp_pass_cross,
  sum(team_stats_full.pass_back) AS pass_back,
  sum(team_stats_full.opp_pass_back) AS opp_pass_back,
  sum(team_stats_full.pass_forward) AS pass_forward,
  sum(team_stats_full.opp_pass_forward) AS opp_pass_forward,
  sum(team_stats_full.pass_left) AS pass_left,
  sum(team_stats_full.opp_pass_left) AS opp_pass_left,
  sum(team_stats_full.pass_right) AS pass_right,
  sum(team_stats_full.opp_pass_right) AS opp_pass_right,
  sum(team_stats_full.pass_short) AS pass_short,
  sum(team_stats_full.opp_pass_short) AS opp_pass_short,
  sum(team_stats_full.pass_throughball) AS pass_throughball,
  sum(team_stats_full.opp_pass_throughball) AS opp_pass_throughball,
  sum(team_stats_full.pass_accurate) AS pass_accurate,
  sum(team_stats_full.opp_pass_accurate) AS opp_pass_accurate,
  sum(team_stats_full.pass_short_accurate) AS pass_short_accurate,
  sum(team_stats_full.opp_pass_short_accurate) AS opp_pass_short_accurate,
  sum(team_stats_full.pass_corner_accurate) AS pass_corner_accurate,
  sum(team_stats_full.opp_pass_corner_accurate) AS opp_pass_corner_accurate,
  sum(team_stats_full.pass_longball_accurate) AS pass_longball_accurate,
  sum(team_stats_full.opp_pass_longball_accurate) AS opp_pass_longball_accurate,
  sum(team_stats_full.pass_cross_accurate) AS pass_cross_accurate,
  sum(team_stats_full.opp_pass_cross_accurate) AS opp_pass_cross_accurate,
  sum(team_stats_full.pass_throughball_accurate) AS pass_throughball_accurate,
  sum(team_stats_full.opp_pass_throughball_accurate) AS opp_pass_throughball_accurate,
  sum(team_stats_full.pass_key) AS pass_key,
  sum(team_stats_full.opp_pass_key) AS opp_pass_key,
  sum(team_stats_full.pass_key_cross) AS pass_key_cross,
  sum(team_stats_full.opp_pass_key_cross) AS opp_pass_key_cross,
  sum(team_stats_full.pass_key_freekick) AS pass_key_freekick,
  sum(team_stats_full.opp_pass_key_freekick) AS opp_pass_key_freekick,
  sum(team_stats_full.pass_key_corner) AS pass_key_corner,
  sum(team_stats_full.opp_pass_key_corner) AS opp_pass_key_corner,
  sum(team_stats_full.pass_key_throughball) AS pass_key_throughball,
  sum(team_stats_full.opp_pass_key_throughball) AS opp_pass_key_throughball,
  sum(team_stats_full.shot) AS shot,
  sum(team_stats_full.opp_shot) AS opp_shot,
  sum(team_stats_full.shot_on_target) AS shot_on_target,
  sum(team_stats_full.opp_shot_on_target) AS opp_shot_on_target,
  sum(team_stats_full.shot_off_target) AS shot_off_target,
  sum(team_stats_full.opp_shot_off_target) AS opp_shot_off_target,
  sum(team_stats_full.shot_blocked) AS shot_blocked,
  sum(team_stats_full.opp_shot_blocked) AS opp_shot_blocked,
  sum(team_stats_full.shot_open_play) AS shot_open_play,
  sum(team_stats_full.opp_shot_open_play) AS opp_shot_open_play,
  sum(team_stats_full.shot_set_piece) AS shot_set_piece,
  sum(team_stats_full.opp_shot_set_piece) AS opp_shot_set_piece,
  sum(team_stats_full.shot_on_post) AS shot_on_post,
  sum(team_stats_full.opp_shot_on_post) AS opp_shot_on_post,
  sum(team_stats_full.shot_six_yard_box) AS shot_six_yard_box,
  sum(team_stats_full.opp_shot_six_yard_box) AS opp_shot_six_yard_box,
  sum(team_stats_full.shot_penalty_area) AS shot_penalty_area,
  sum(team_stats_full.opp_shot_penalty_area) AS opp_shot_penalty_area,
  sum(team_stats_full.shot_box) AS shot_box,
  sum(team_stats_full.opp_shot_box) AS opp_shot_box,
  sum(team_stats_full.shot_counter) AS shot_counter,
  sum(team_stats_full.opp_shot_counter) AS opp_shot_counter,
  sum(team_stats_full.shot_head) AS shot_head,
  sum(team_stats_full.opp_shot_head) AS opp_shot_head,
  sum(team_stats_full.shot_foot) AS shot_foot,
  sum(team_stats_full.opp_shot_foot) AS opp_shot_foot,
  sum(team_stats_full.shot_0bp) AS shot_0bp,
  sum(team_stats_full.opp_shot_0bp) AS opp_shot_0bp,
  sum(team_stats_full.goal) AS goal,
  sum(team_stats_full.opp_goal) AS opp_goal,
  sum(team_stats_full.goal_normal) AS goal_normal,
  sum(team_stats_full.opp_goal_normal) AS opp_goal_normal,
  sum(team_stats_full.goal_head) AS goal_head,
  sum(team_stats_full.opp_goal_head) AS opp_goal_head,
  sum(team_stats_full.goal_foot) AS goal_foot,
  sum(team_stats_full.opp_goal_foot) AS opp_goal_foot,
  sum(team_stats_full.goal_set_piece) AS goal_set_piece,
  sum(team_stats_full.opp_goal_set_piece) AS opp_goal_set_piece,
  sum(team_stats_full.goal_own) AS goal_own,
  sum(team_stats_full.opp_goal_own) AS opp_goal_own,
  sum(team_stats_full.goal_counter) AS goal_counter,
  sum(team_stats_full.opp_goal_counter) AS opp_goal_counter,
  sum(team_stats_full.goal_open_play) AS goal_open_play,
  sum(team_stats_full.opp_goal_open_play) AS opp_goal_open_play,
  sum(team_stats_full.goal_0bp) AS goal_0bp,
  sum(team_stats_full.opp_goal_0bp) AS opp_goal_0bp,
  sum(team_stats_full.goal_0box) AS goal_0box,
  sum(team_stats_full.opp_goal_0box) AS opp_goal_0box,
  sum(team_stats_full.goal_six_yard_box) AS goal_six_yard_box,
  sum(team_stats_full.opp_goal_six_yard_box) AS opp_goal_six_yard_box,
  sum(team_stats_full.goal_penalty_area) AS goal_penalty_area,
  sum(team_stats_full.opp_goal_penalty_area) AS opp_goal_penalty_area,
  sum(team_stats_full.assist) AS assist,
  sum(team_stats_full.opp_assist) AS opp_assist,
  sum(team_stats_full.assist_cross) AS assist_cross,
  sum(team_stats_full.opp_assist_cross) AS opp_assist_cross,
  sum(team_stats_full.assist_corner) AS assist_corner,
  sum(team_stats_full.opp_assist_corner) AS opp_assist_corner,
  sum(team_stats_full.assist_throughball) AS assist_throughball,
  sum(team_stats_full.opp_assist_throughball) AS opp_assist_throughball,
  sum(team_stats_full.aerial_duel) AS aerial_duel,
  sum(team_stats_full.opp_aerial_duel) AS opp_aerial_duel,
  sum(team_stats_full.red_card) AS red_card,
  sum(team_stats_full.opp_red_card) AS opp_red_card,
  sum(team_stats_full.yellow_card) AS yellow_card,
  sum(team_stats_full.opp_yellow_card) AS opp_yellow_card,
  sum(team_stats_full.second_yellow_card) AS second_yellow_card,
  sum(team_stats_full.opp_second_yellow_card) AS opp_second_yellow_card,
  sum(team_stats_full.save) AS save,
  sum(team_stats_full.opp_save) AS opp_save,
  sum(team_stats_full.duel) AS duel,
  sum(team_stats_full.opp_duel) AS opp_duel,
  sum(team_stats_full.duel_offensive) AS duel_offensive,
  sum(team_stats_full.opp_duel_offensive) AS opp_duel_offensive,
  sum(team_stats_full.duel_defensive) AS duel_defensive,
  sum(team_stats_full.opp_duel_defensive) AS opp_duel_defensive,
  sum(team_stats_full.dispossessed) AS dispossessed,
  sum(team_stats_full.opp_dispossessed) AS opp_dispossessed,
  sum(team_stats_full.turnover) AS turnover,
  sum(team_stats_full.opp_turnover) AS opp_turnover,
  sum(team_stats_full.dribble) AS dribble,
  sum(team_stats_full.opp_dribble) AS opp_dribble,
  sum(team_stats_full.dribble_won) AS dribble_won,
  sum(team_stats_full.opp_dribble_won) AS opp_dribble_won,
  sum(team_stats_full.dribble_lost) AS dribble_lost,
  sum(team_stats_full.opp_dribble_lost) AS opp_dribble_lost,
  sum(team_stats_full.dribble_last_man) AS dribble_last_man,
  sum(team_stats_full.opp_dribble_last_man) AS opp_dribble_last_man,
  sum(team_stats_full.challenge_lost) AS challenge_lost,
  sum(team_stats_full.opp_challenge_lost) AS opp_challenge_lost,
  sum(team_stats_full.blocked_cross) AS blocked_cross,
  sum(team_stats_full.opp_blocked_cross) AS opp_blocked_cross,
  sum(team_stats_full.block_outfielder) AS block_outfielder,
  sum(team_stats_full.opp_block_outfielder) AS opp_block_outfielder,
  sum(team_stats_full.block_six_yard) AS block_six_yard,
  sum(team_stats_full.opp_block_six_yard) AS opp_block_six_yard,
  sum(team_stats_full.block_pass_outfielder) AS block_pass_outfielder,
  sum(team_stats_full.opp_block_pass_outfielder) AS opp_block_pass_outfielder,
  sum(team_stats_full.interception) AS interception,
  sum(team_stats_full.opp_interception) AS opp_interception,
  sum(team_stats_full.interception_won) AS interception_won,
  sum(team_stats_full.opp_interception_won) AS opp_interception_won,
  sum(team_stats_full.interception_in_box) AS interception_in_box,
  sum(team_stats_full.opp_interception_in_box) AS opp_interception_in_box,
  sum(team_stats_full.tackle) AS tackle,
  sum(team_stats_full.opp_tackle) AS opp_tackle,
  sum(team_stats_full.tackle_won) AS tackle_won,
  sum(team_stats_full.opp_tackle_won) AS opp_tackle_won,
  sum(team_stats_full.tackle_lost) AS tackle_lost,
  sum(team_stats_full.opp_tackle_lost) AS opp_tackle_lost,
  sum(team_stats_full.tackle_last_man) AS tackle_last_man,
  sum(team_stats_full.opp_tackle_last_man) AS opp_tackle_last_man,
  sum(team_stats_full.offside_given) AS offside_given,
  sum(team_stats_full.opp_offside_given) AS opp_offside_given,
  sum(team_stats_full.offside_provoked) AS offside_provoked,
  sum(team_stats_full.opp_offside_provoked) AS opp_offside_provoked,
  sum(team_stats_full.ball_recovery) AS ball_recovery,
  sum(team_stats_full.opp_ball_recovery) AS opp_ball_recovery,
  sum(team_stats_full.clearance) AS clearance,
  sum(team_stats_full.opp_clearance) AS opp_clearance,
  sum(team_stats_full.clearance_effective) AS clearance_effective,
  sum(team_stats_full.opp_clearance_effective) AS opp_clearance_effective,
  sum(team_stats_full.clearance_off_line) AS clearance_off_line,
  sum(team_stats_full.opp_clearance_off_line) AS opp_clearance_off_line,
  sum(team_stats_full.error_leads_to_goal) AS error_leads_to_goal,
  sum(team_stats_full.opp_error_leads_to_goal) AS opp_error_leads_to_goal,
  sum(team_stats_full.error_leads_to_shot) AS error_leads_to_shot,
  sum(team_stats_full.opp_error_leads_to_shot) AS opp_error_leads_to_shot,
  sum(team_stats_full.touch) AS touch,
  sum(team_stats_full.opp_touch) AS opp_touch,
  sum(team_stats_full.penalty_won) AS penalty_won,
  sum(team_stats_full.opp_penalty_won) AS opp_penalty_won,
  sum(team_stats_full.penalty_conceded) AS penalty_conceded,
  sum(team_stats_full.opp_penalty_conceded) AS opp_penalty_conceded,
  sum(team_stats_full.penalty_scored) AS penalty_scored,
  sum(team_stats_full.opp_penalty_scored) AS opp_penalty_scored,
  sum(team_stats_full.big_chance_missed) AS big_chance_missed,
  sum(team_stats_full.opp_big_chance_missed) AS opp_big_chance_missed,
  sum(team_stats_full.big_chance_scored) AS big_chance_scored,
  sum(team_stats_full.opp_big_chance_scored) AS opp_big_chance_scored,
  sum(team_stats_full.big_chance_created) AS big_chance_created,
  sum(team_stats_full.opp_big_chance_created) AS opp_big_chance_created,
  sum(team_stats_full.parried_safe) AS parried_safe,
  sum(team_stats_full.opp_parried_safe) AS opp_parried_safe,
  sum(team_stats_full.parried_danger) AS parried_danger,
  sum(team_stats_full.opp_parried_danger) AS opp_parried_danger,
  sum(team_stats_full.save_keeper) AS save_keeper,
  sum(team_stats_full.opp_save_keeper) AS opp_save_keeper,
  team_stats_full.year,
  team_stats_full.tournament
FROM
  team_stats_full
GROUP BY
  team_stats_full.team_id,
  team_stats_full.team,
  team_stats_full.year,
  team_stats_full.tournament;