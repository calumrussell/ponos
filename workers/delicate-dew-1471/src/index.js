import { Client } from '@neondatabase/serverless';

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
  'shot',
  'shot_on_target',
  'shot_off_target',
  'pass_key',
  'dispossessed',
  'goal',
  'aerial_duel',
  'assist',
  'red_card',
  'yellow_card',
  'save',
  'pass_cross',
  'duel'
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

      let query = "select * from match";
      if (before === null && after != null) {
	query += ` where start_date > ${after}`
      } else if (after === null && before != null) {
	query += ` where start_date < ${before}`
      } else if (after!= null && before != null) {
	query += ` where start_date < ${before} and start_date > ${after}`;
      }

      const client = new Client(env.DATABASE_URL);
      await client.connect();
      const { rows } = await client.query(`${query};`);
      ctx.waitUntil(client.end());

      return new Response(JSON.stringify(rows));
    } else if (path === "/insert_match") {
      const contentType = request.headers.get("content-type");
      if (contentType == "text/plain") {
	const toJson = await parseTextRequestToJson(request);

	let query = insertMatches(toJson);
	const client = new Client(env.DATABASE_URL);
	await client.connect();
	const finalQuery = `${query} on conflict do nothing;`;
	await client.query(finalQuery);
	ctx.waitUntil(client.end());
	return new Response(JSON.stringify([]));
      }
      return new Response(JSON.stringify([]));
    } else if (path == "/insert_parsed") {
      const contentType = request.headers.get("content-type");
      if (contentType == "application/json") {
	const toJson = await request.json(); 


	const client = new Client(env.DATABASE_URL);
	await client.connect();
	await client.query(insertMatches(toJson.matches));
	await client.query(insertPlayers(toJson.players));
	await client.query(insertTeams(toJson.teams));
	await client.query(insertPlayerStats(toJson.playerStats));
	await client.query(insertTeamStats(toJson.teamStats));
	ctx.waitUntil(client.end());
	return new Response(JSON.stringify([]));
      }
	 
    }
  return new Response(JSON.stringify([]));
  }
}
