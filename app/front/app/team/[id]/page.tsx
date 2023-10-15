import React from "react";

import prisma from "@/lib/prisma";
import { TeamStatsTeamPage } from "@/lib/components";

export async function generateStaticParams() {
  const teams = await prisma.team.findMany({});
  return teams.map(team => ({id: team.id.toString()}))
}

async function getTeamStats(id: number) {
  const team_stats = await prisma.team_stats_full.findMany({
    where: {
      team_id: id
    },
    orderBy: {
      match_id: 'desc'
    },
    take: 10,
  })
  return team_stats;
};

interface Team {
  params: {
    id: string
  }
}

export default async function Page(input: Team) {
  const teamStats = await getTeamStats(parseInt(input.params.id));

  return (
    <main>
      <TeamStatsTeamPage team_stats={teamStats} />
    </main>
  )
}