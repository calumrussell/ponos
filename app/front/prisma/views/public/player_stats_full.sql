WITH xg_player AS (
  SELECT
    sum(xg.prob) AS prob,
    xg.player_id,
    xg.match_id
  FROM
    xg
  GROUP BY
    xg.player_id,
    xg.match_id
)
SELECT
  player_stats.player_id,
  player_stats.team_id,
  player_stats.match_id,
  player_stats.minutes,
  player_stats.pass,
  player_stats.pass_corner,
  player_stats.pass_longball,
  player_stats.pass_cross,
  player_stats.pass_back,
  player_stats.pass_forward,
  player_stats.pass_left,
  player_stats.pass_right,
  player_stats.pass_short,
  player_stats.pass_throughball,
  player_stats.pass_accurate,
  player_stats.pass_short_accurate,
  player_stats.pass_corner_accurate,
  player_stats.pass_longball_accurate,
  player_stats.pass_cross_accurate,
  player_stats.pass_throughball_accurate,
  player_stats.pass_key,
  player_stats.pass_key_cross,
  player_stats.pass_key_freekick,
  player_stats.pass_key_corner,
  player_stats.pass_key_throughball,
  player_stats.shot,
  player_stats.shot_on_target,
  player_stats.shot_off_target,
  player_stats.shot_blocked,
  player_stats.shot_open_play,
  player_stats.shot_set_piece,
  player_stats.shot_on_post,
  player_stats.shot_six_yard_box,
  player_stats.shot_penalty_area,
  player_stats.shot_box,
  player_stats.shot_counter,
  player_stats.shot_head,
  player_stats.shot_foot,
  player_stats.shot_0bp,
  player_stats.goal,
  player_stats.goal_normal,
  player_stats.goal_head,
  player_stats.goal_foot,
  player_stats.goal_set_piece,
  player_stats.goal_own,
  player_stats.goal_counter,
  player_stats.goal_open_play,
  player_stats.goal_0bp,
  player_stats.goal_0box,
  player_stats.goal_six_yard_box,
  player_stats.goal_penalty_area,
  player_stats.assist,
  player_stats.assist_cross,
  player_stats.assist_corner,
  player_stats.assist_throughball,
  player_stats.aerial_duel,
  player_stats.red_card,
  player_stats.yellow_card,
  player_stats.second_yellow_card,
  player_stats.save,
  player_stats.duel,
  player_stats.duel_offensive,
  player_stats.duel_defensive,
  player_stats.dispossessed,
  player_stats.turnover,
  player_stats.dribble,
  player_stats.dribble_won,
  player_stats.dribble_lost,
  player_stats.dribble_last_man,
  player_stats.challenge_lost,
  player_stats.blocked_cross,
  player_stats.block_outfielder,
  player_stats.block_six_yard,
  player_stats.block_pass_outfielder,
  player_stats.interception,
  player_stats.interception_won,
  player_stats.interception_in_box,
  player_stats.tackle,
  player_stats.tackle_won,
  player_stats.tackle_lost,
  player_stats.tackle_last_man,
  player_stats.offside_given,
  player_stats.offside_provoked,
  player_stats.ball_recovery,
  player_stats.clearance,
  player_stats.clearance_effective,
  player_stats.clearance_off_line,
  player_stats.error_leads_to_goal,
  player_stats.error_leads_to_shot,
  player_stats.touch,
  player_stats.penalty_won,
  player_stats.penalty_conceded,
  player_stats.penalty_scored,
  player_stats.big_chance_missed,
  player_stats.big_chance_scored,
  player_stats.big_chance_created,
  player_stats.parried_safe,
  player_stats.parried_danger,
  player_stats.save_keeper,
  player_stats."position",
  player_stats.opp_id,
  team.name AS team,
  player.name AS player,
  MATCH.year,
  tournament.name AS tournament,
  MATCH.start_date,
  CASE
    WHEN (xg_player.prob IS NULL) THEN (0) :: real
    ELSE xg_player.prob
  END AS xg
FROM
  (
    (
      (
        (
          (
            player_stats
            LEFT JOIN team ON ((team.id = player_stats.team_id))
          )
          LEFT JOIN player ON ((player.id = player_stats.player_id))
        )
        LEFT JOIN MATCH ON ((player_stats.match_id = MATCH.id))
      )
      LEFT JOIN xg_player ON (
        (
          (player_stats.player_id = xg_player.player_id)
          AND (player_stats.match_id = xg_player.match_id)
        )
      )
    )
    LEFT JOIN tournament ON ((tournament.id = MATCH.tournament_id))
  );