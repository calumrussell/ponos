import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsMatchPage, TeamStatsMatchPage } from "@/lib/components";
import { sortByPosition } from "@/lib/functions";

export async function generateStaticParams() {
  const matches = await prisma.match_front.findMany({});
  return matches.map(match => ({id: match.id.toString()}))
}

async function getMatch(id: number) {
  const match = await prisma.match_full.findFirst({
    where: {
      id: id
    }
  })
  return match;
}

async function getTeamStats(id: number) {
  const team_stats = await prisma.team_stats_full.findMany({
    where: {
      match_id: id
    }
  })
  return team_stats;
};

async function getPlayerStats(id: number) {
  const player_stats = await prisma.player_stats_full.findMany({
    where: {
      match_id: id
    },
    orderBy: [
      {
        team_id: 'desc',
      },
      {
        minutes: 'desc',
      }
    ]
  });
  return player_stats;
}

interface Match {
  params: {
    id: string
  }
}

export default async function Page(input: Match) {
  const playerStats = await getPlayerStats(parseInt(input.params.id));
  const match = await getMatch(parseInt(input.params.id));
  const teamStats = await getTeamStats(parseInt(input.params.id));

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