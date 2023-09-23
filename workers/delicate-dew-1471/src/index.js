import { neon, Client } from '@neondatabase/serverless';

const parseTextRequestToJson = async (request) => {
  const text = await request.text();
  const lines = text.split("\n");
  return lines.slice(0, -1).map(l => {
    return JSON.parse(l);
  })
};

const insertBuilder = (columns, data, name) => {
  const valParser = (v) => {
    if (typeof v === "string" || v instanceof String) {
      return `'${v}'`;
    }
    return v;
  };

  const columnsString = columns.join(",");
  let query = `INSERT INTO ${name}(${columnsString}) VALUES `;
  let queries = data.map(row => {
    let dataList = columns.map(v => valParser(row[v]));
    let dataListJoined = dataList.join(",");
    return `(${dataListJoined})`;
  });
  return `${query} ${queries.join(",")}`;
};

const baseStats = [
    'pass',
    'pass_corner',
    'pass_longball',
    'pass_cross',
    'pass_back',
    'pass_forward',
    'pass_left',
    'pass_right',
    'pass_short',
    'pass_throughball',
    'pass_accurate',
    'pass_short_accurate',
    'pass_corner_accurate',
    'pass_longball_accurate',
    'pass_cross_accurate',
    'pass_throughball_accurate',
    'pass_key',
    'pass_key_cross',
    'pass_key_freekick',
    'pass_key_corner',
    'pass_key_throughball',
    'shot',
    'shot_on_target',
    'shot_off_target',
    'shot_blocked',
    'shot_open_play',
    'shot_set_piece',
    'shot_on_post',
    'shot_six_yard_box',
    'shot_penalty_area',
    'shot_box',
    'shot_counter',
    'shot_head',
    'shot_foot',
    'shot_0bp',
    'goal',
    'goal_normal',
    'goal_head',
    'goal_foot',
    'goal_set_piece',
    'goal_own',
    'goal_counter',
    'goal_open_play',
    'goal_0bp',
    'goal_0box',
    'goal_six_yard_box',
    'goal_penalty_area',
    'assist',
    'assist_cross',
    'assist_corner',
    'assist_throughball',
    'aerial_duel',
    'red_card',
    'yellow_card',
    'second_yellow_card',
    'save',
    'duel',
    'duel_offensive',
    'duel_defensive',
    'dispossessed',
    'turnover',
    'dribble',
    'dribble_won',
    'dribble_lost',
    'dribble_last_man',
    'challenge_lost',
    'blocked_cross',
    'block_outfielder',
    'block_six_yard',
    'block_pass_outfielder',
    'interception',
    'interception_won',
    'interception_in_box',
    'tackle',
    'tackle_won',
    'tackle_lost',
    'tackle_last_man',
    'offside_given',
    'offside_provoked',
    'ball_recovery',
    'clearance',
    'clearance_effective',
    'clearance_off_line',
    'error_leads_to_goal',
    'error_leads_to_shot',
    'touch',
    'penalty_won',
    'penalty_conceded',
    'penalty_scored',
    'big_chance_missed',
    'big_chance_scored',
    'big_chance_created',
    'parried_safe',
    'parried_danger',
    'save_keeper'
];

const insertMatches = (matches) => {
  const vals = ['id', 'start_date', 'home_id', 'away_id'];
  const query = insertBuilder(vals, matches, 'match')
  return `${query} on conflict(id) do update set start_date = EXCLUDED.start_date;`
};

const insertPlayers = (players) => {
  const vals = ['id', 'name'];
  const query = insertBuilder(vals, players, 'player')
  return `${query} on conflict(id) do nothing;`;
};

const insertTeams = (teams) => {
  const vals = ['id', 'name'];
  const query = insertBuilder(vals, teams, 'team')
  return `${query} on conflict(id) do nothing;`;
};

const insertTeamStats = (teamStats) => {
  const vals = ['team_id', 'match_id', 'is_home', ...baseStats];
  const query = insertBuilder(vals, teamStats, 'team_stats')
  const excluded = baseStats.map(stat => ` ${stat} = EXCLUDED.${stat}`).join(",")
  return `${query} on conflict(team_id, match_id) do update set ${excluded};`;
};

const insertPlayerStats = (playerStats) => {
  const vals = ['player_id', 'team_id', 'match_id', 'minutes', ...baseStats];
  const query = insertBuilder(vals, playerStats, 'player_stats')
  const excluded = ['minutes', ...baseStats].map(stat => ` ${stat} = EXCLUDED.${stat}`).join(",")
  return `${query} on conflict(player_id, match_id) do update set ${excluded};`;
};

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const path = url.pathname;
    if (path === "/matches_by_date") {
      let before = url.searchParams.get('before');
      let after = url.searchParams.get('after');

      const sql = neon(env.DATABASE_URL);
      if (before === null && after != null) {
	const res = await sql(`select * from match where start_date > $1`, [after]);
        return new Response(JSON.stringify(res));
      } else if (after === null && before != null) {
	const rows = await sql(`select * from match where start_date < $1`, [before]);
        return new Response(JSON.stringify(rows));
      } else if (after!= null && before != null) {
	const rows = await sql( `select * from match where start_date < $1 and start_date > $2`, [before, after]);
        return new Response(JSON.stringify(rows));
      } else {
        return new Response(JSON.stringify([]));
      }
    } else if (path === "/insert_matches") {
      const contentType = request.headers.get("content-type");
      if (contentType == "application/json") {
	const json = await request.json(); 
        const sql = neon(env.DATABASE_URL);
	await sql(insertMatches(json.matches));
	return new Response(JSON.stringify([]));
      }
    } else if (path === "/insert_players") {
      const contentType = request.headers.get("content-type");
      if (contentType == "application/json") {
	const json = await request.json(); 
        const sql = neon(env.DATABASE_URL);
	await sql(insertPlayers(json.players));
	return new Response(JSON.stringify([]));
      }
    } else if (path === "/insert_teams") {
      const contentType = request.headers.get("content-type");
      if (contentType == "application/json") {
	const json = await request.json(); 
        const sql = neon(env.DATABASE_URL);
	await sql(insertTeams(json.teams));
	return new Response(JSON.stringify([]));
      }
    } else if (path === "/insert_team_stats") {
      const contentType = request.headers.get("content-type");
      if (contentType == "application/json") {
	const json = await request.json(); 
        const sql = neon(env.DATABASE_URL);
	await sql(insertTeamStats(json.team_stats));
	return new Response(JSON.stringify([]));
      }
    } else if (path === "/insert_player_stats") {
      const contentType = request.headers.get("content-type");
      if (contentType == "application/json") {
	const json = await request.json(); 
        const sql = neon(env.DATABASE_URL);
	await sql(insertPlayerStats(json.player_stats));
	return new Response(JSON.stringify([]));
      }
    }
    return new Response(JSON.stringify([]));
  }
}
