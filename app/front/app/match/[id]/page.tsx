import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsMatchPage, TeamStatsMatchPage } from "@/lib/components";
import { getMatch, getPlayerStats, getTeamStats, sortByPosition, getRoute } from "@/lib/functions";
import { match_full, player_stats_full, team_stats_full } from "@prisma/client";

export async function generateStaticParams() {
  const matches = await prisma.match_front.findMany({});
  return matches.map(match => ({id: getRoute(match.id.toString())}))
}

interface Match {
  params: {
    id: string
  }
}

export default async function Page(input: Match) {
  const playerStats = await getPlayerStats(input.params.id) as player_stats_full[];
  const match = await getMatch(input.params.id) as match_full;
  const teamStats = await getTeamStats(input.params.id) as team_stats_full[];

  const homeSide = match?.home;
  const awaySide = match?.away;

  const homePlayerStats = playerStats.filter((v) => v.team_id == match?.home_id)
  const awayPlayerStats = playerStats.filter((v) => v.team_id == match?.away_id)

  sortByPosition(homePlayerStats);
  sortByPosition(awayPlayerStats);

  const homeTeamStats = teamStats.filter((v) => v.team_id == match?.home_id);
  const awayTeamStats = teamStats.filter((v) => v.team_id == match?.away_id);

  const homeGoal = homeTeamStats[0].goal;
  const awayGoal = awayTeamStats[0].goal;

  return (
    <main>
      <h4>{`Score: ${homeGoal} : ${awayGoal}`}</h4>
      <TeamStatsMatchPage team_stats={[homeTeamStats[0], awayTeamStats[0]]} />
      <h4>{homeSide}</h4>
      <PlayerStatsMatchPage player_stats={homePlayerStats} />
      <h4>{awaySide}</h4>
      <PlayerStatsMatchPage player_stats={awayPlayerStats} />
    </main>
  )
}