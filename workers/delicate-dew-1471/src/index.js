import { Client } from '@neondatabase/serverless';

const parseRequestToJson = async (request) => {
  const text = await request.text();
  const lines = text.split("\n");
  return lines.slice(0, -1).map(l => {
    return JSON.parse(l);
  })
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
	const toJson = parseRequestToJson(request);
	let query = "INSERT INTO match(id, start_date, home_id, away_id) VALUES ";
	toJson.forEach(row => {
	  query += `(${row.match_id}, ${row.start_date}, ${row.home_id}, ${row.away_id})`;
	});
	const client = new Client(env.DATABASE_URL);
	await client.connect();
	const { rows } = await client.query(`${query} on conflict do nothing;`);
	ctx.waitUntil(client.end());
	return new Response(JSON.stringify([]));
      }
      return new Response(JSON.stringify([]));
    }
  return new Response(JSON.stringify([]));
  }
}
