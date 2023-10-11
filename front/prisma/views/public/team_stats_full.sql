SELECT
  MATCH.start_date,
  team_stats.team_id,
  team_stats.opp_id,
  team_stats.match_id,
  team_stats.is_home,
  team_stats.pass,
  opp_stats.pass AS opp_pass,
  team_stats.pass_corner,
  opp_stats.pass_corner AS opp_pass_corner,
  team_stats.pass_longball,
  opp_stats.pass_longball AS opp_pass_longball,
  team_stats.pass_cross,
  opp_stats.pass_cross AS opp_pass_cross,
  team_stats.pass_back,
  opp_stats.pass_back AS opp_pass_back,
  team_stats.pass_forward,
  opp_stats.pass_forward AS opp_pass_forward,
  team_stats.pass_left,
  opp_stats.pass_left AS opp_pass_left,
  team_stats.pass_right,
  opp_stats.pass_right AS opp_pass_right,
  team_stats.pass_short,
  opp_stats.pass_short AS opp_pass_short,
  team_stats.pass_throughball,
  opp_stats.pass_throughball AS opp_pass_throughball,
  team_stats.pass_accurate,
  opp_stats.pass_accurate AS opp_pass_accurate,
  team_stats.pass_short_accurate,
  opp_stats.pass_short_accurate AS opp_pass_short_accurate,
  team_stats.pass_corner_accurate,
  opp_stats.pass_corner_accurate AS opp_pass_corner_accurate,
  team_stats.pass_longball_accurate,
  opp_stats.pass_longball_accurate AS opp_pass_longball_accurate,
  team_stats.pass_cross_accurate,
  opp_stats.pass_cross_accurate AS opp_pass_cross_accurate,
  team_stats.pass_throughball_accurate,
  opp_stats.pass_throughball_accurate AS opp_pass_throughball_accurate,
  team_stats.pass_key,
  opp_stats.pass_key AS opp_pass_key,
  team_stats.pass_key_cross,
  opp_stats.pass_key_cross AS opp_pass_key_cross,
  team_stats.pass_key_freekick,
  opp_stats.pass_key_freekick AS opp_pass_key_freekick,
  team_stats.pass_key_corner,
  opp_stats.pass_key_corner AS opp_pass_key_corner,
  team_stats.pass_key_throughball,
  opp_stats.pass_key_throughball AS opp_pass_key_throughball,
  team_stats.shot,
  opp_stats.shot AS opp_shot,
  team_stats.shot_on_target,
  opp_stats.shot_on_target AS opp_shot_on_target,
  team_stats.shot_off_target,
  opp_stats.shot_off_target AS opp_shot_off_target,
  team_stats.shot_blocked,
  opp_stats.shot_blocked AS opp_shot_blocked,
  team_stats.shot_open_play,
  opp_stats.shot_open_play AS opp_shot_open_play,
  team_stats.shot_set_piece,
  opp_stats.shot_set_piece AS opp_shot_set_piece,
  team_stats.shot_on_post,
  opp_stats.shot_on_post AS opp_shot_on_post,
  team_stats.shot_six_yard_box,
  opp_stats.shot_six_yard_box AS opp_shot_six_yard_box,
  team_stats.shot_penalty_area,
  opp_stats.shot_penalty_area AS opp_shot_penalty_area,
  team_stats.shot_box,
  opp_stats.shot_box AS opp_shot_box,
  team_stats.shot_counter,
  opp_stats.shot_counter AS opp_shot_counter,
  team_stats.shot_head,
  opp_stats.shot_head AS opp_shot_head,
  team_stats.shot_foot,
  opp_stats.shot_foot AS opp_shot_foot,
  team_stats.shot_0bp,
  opp_stats.shot_0bp AS opp_shot_0bp,
  team_stats.goal,
  opp_stats.goal AS opp_goal,
  team_stats.goal_normal,
  opp_stats.goal_normal AS opp_goal_normal,
  team_stats.goal_head,
  opp_stats.goal_head AS opp_goal_head,
  team_stats.goal_foot,
  opp_stats.goal_foot AS opp_goal_foot,
  team_stats.goal_set_piece,
  opp_stats.goal_set_piece AS opp_goal_set_piece,
  team_stats.goal_own,
  opp_stats.goal_own AS opp_goal_own,
  team_stats.goal_counter,
  opp_stats.goal_counter AS opp_goal_counter,
  team_stats.goal_open_play,
  opp_stats.goal_open_play AS opp_goal_open_play,
  team_stats.goal_0bp,
  opp_stats.goal_0bp AS opp_goal_0bp,
  team_stats.goal_0box,
  opp_stats.goal_0box AS opp_goal_0box,
  team_stats.goal_six_yard_box,
  opp_stats.goal_six_yard_box AS opp_goal_six_yard_box,
  team_stats.goal_penalty_area,
  opp_stats.goal_penalty_area AS opp_goal_penalty_area,
  team_stats.assist,
  opp_stats.assist AS opp_assist,
  team_stats.assist_cross,
  opp_stats.assist_cross AS opp_assist_cross,
  team_stats.assist_corner,
  opp_stats.assist_corner AS opp_assist_corner,
  team_stats.assist_throughball,
  opp_stats.assist_throughball AS opp_assist_throughball,
  team_stats.aerial_duel,
  opp_stats.aerial_duel AS opp_aerial_duel,
  team_stats.red_card,
  opp_stats.red_card AS opp_red_card,
  team_stats.yellow_card,
  opp_stats.yellow_card AS opp_yellow_card,
  team_stats.second_yellow_card,
  opp_stats.second_yellow_card AS opp_second_yellow_card,
  team_stats.save,
  opp_stats.save AS opp_save,
  team_stats.duel,
  opp_stats.duel AS opp_duel,
  team_stats.duel_offensive,
  opp_stats.duel_offensive AS opp_duel_offensive,
  team_stats.duel_defensive,
  opp_stats.duel_defensive AS opp_duel_defensive,
  team_stats.dispossessed,
  opp_stats.dispossessed AS opp_dispossessed,
  team_stats.turnover,
  opp_stats.turnover AS opp_turnover,
  team_stats.dribble,
  opp_stats.dribble AS opp_dribble,
  team_stats.dribble_won,
  opp_stats.dribble_won AS opp_dribble_won,
  team_stats.dribble_lost,
  opp_stats.dribble_lost AS opp_dribble_lost,
  team_stats.dribble_last_man,
  opp_stats.dribble_last_man AS opp_dribble_last_man,
  team_stats.challenge_lost,
  opp_stats.challenge_lost AS opp_challenge_lost,
  team_stats.blocked_cross,
  opp_stats.blocked_cross AS opp_blocked_cross,
  team_stats.block_outfielder,
  opp_stats.block_outfielder AS opp_block_outfielder,
  team_stats.block_six_yard,
  opp_stats.block_six_yard AS opp_block_six_yard,
  team_stats.block_pass_outfielder,
  opp_stats.block_pass_outfielder AS opp_block_pass_outfielder,
  team_stats.interception,
  opp_stats.interception AS opp_interception,
  team_stats.interception_won,
  opp_stats.interception_won AS opp_interception_won,
  team_stats.interception_in_box,
  opp_stats.interception_in_box AS opp_interception_in_box,
  team_stats.tackle,
  opp_stats.tackle AS opp_tackle,
  team_stats.tackle_won,
  opp_stats.tackle_won AS opp_tackle_won,
  team_stats.tackle_lost,
  opp_stats.tackle_lost AS opp_tackle_lost,
  team_stats.tackle_last_man,
  opp_stats.tackle_last_man AS opp_tackle_last_man,
  team_stats.offside_given,
  opp_stats.offside_given AS opp_offside_given,
  team_stats.offside_provoked,
  opp_stats.offside_provoked AS opp_offside_provoked,
  team_stats.ball_recovery,
  opp_stats.ball_recovery AS opp_ball_recovery,
  team_stats.clearance,
  opp_stats.clearance AS opp_clearance,
  team_stats.clearance_effective,
  opp_stats.clearance_effective AS opp_clearance_effective,
  team_stats.clearance_off_line,
  opp_stats.clearance_off_line AS opp_clearance_off_line,
  team_stats.error_leads_to_goal,
  opp_stats.error_leads_to_goal AS opp_error_leads_to_goal,
  team_stats.error_leads_to_shot,
  opp_stats.error_leads_to_shot AS opp_error_leads_to_shot,
  team_stats.touch,
  opp_stats.touch AS opp_touch,
  team_stats.penalty_won,
  opp_stats.penalty_won AS opp_penalty_won,
  team_stats.penalty_conceded,
  opp_stats.penalty_conceded AS opp_penalty_conceded,
  team_stats.penalty_scored,
  opp_stats.penalty_scored AS opp_penalty_scored,
  team_stats.big_chance_missed,
  opp_stats.big_chance_missed AS opp_big_chance_missed,
  team_stats.big_chance_scored,
  opp_stats.big_chance_scored AS opp_big_chance_scored,
  team_stats.big_chance_created,
  opp_stats.big_chance_created AS opp_big_chance_created,
  team_stats.parried_safe,
  opp_stats.parried_safe AS opp_parried_safe,
  team_stats.parried_danger,
  opp_stats.parried_danger AS opp_parried_danger,
  team_stats.save_keeper,
  opp_stats.save_keeper AS opp_save_keeper,
  (team_stats.touch / opp_stats.touch) AS posession,
  CASE
    WHEN (team_stats.pass <> 0) THEN (
      (team_stats.pass_accurate) :: real / (team_stats.pass) :: real
    )
    ELSE (0) :: real
  END AS pass_accuracy,
  CASE
    WHEN (team_stats.pass_short <> 0) THEN (
      (team_stats.pass_short_accurate) :: real / (team_stats.pass_short) :: real
    )
    ELSE (0) :: real
  END AS pass_short_accuracy,
  CASE
    WHEN (team_stats.dribble <> 0) THEN (
      (team_stats.dribble_won) :: real / (team_stats.dribble) :: real
    )
    ELSE (0) :: real
  END AS dribble_conversion,
  CASE
    WHEN (team_stats.interception <> 0) THEN (
      (team_stats.interception_won) :: real / (team_stats.interception) :: real
    )
    ELSE (0) :: real
  END AS interception_conversion,
  CASE
    WHEN (team_stats.tackle <> 0) THEN (
      (team_stats.tackle_won) :: real / (team_stats.tackle) :: real
    )
    ELSE (0) :: real
  END AS tackle_conversion,
  CASE
    WHEN (team_stats.clearance <> 0) THEN (
      (team_stats.clearance_effective) :: real / (team_stats.clearance) :: real
    )
    ELSE (0) :: real
  END AS clearance_conversion,
  CASE
    WHEN (team_stats.big_chance_created <> 0) THEN (
      (team_stats.big_chance_scored) :: real / (team_stats.big_chance_created) :: real
    )
    ELSE (0.0) :: real
  END AS big_chance_conversion,
  team.name AS team,
  opp.name AS opp
FROM
  (
    (
      (
        (
          team_stats
          LEFT JOIN team_stats opp_stats ON (
            (
              (team_stats.team_id = opp_stats.opp_id)
              AND (team_stats.match_id = opp_stats.match_id)
            )
          )
        )
        LEFT JOIN team ON ((team.id = team_stats.team_id))
      )
      LEFT JOIN team opp ON ((opp.id = team_stats.opp_id))
    )
    LEFT JOIN MATCH ON ((team_stats.match_id = MATCH.id))
  );