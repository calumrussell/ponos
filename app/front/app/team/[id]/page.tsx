import React from "react";

import prisma from "@/lib/prisma";
import { TeamStatsTeamPage } from "@/lib/components";
import { getRoute, getTeamStatsByTeam } from "@/lib/functions";

export async function generateStaticParams() {
  const teams = await prisma.team.findMany({});
  return teams.map(team => ({id: getRoute(team.id.toString())}))
}

interface Team {
  params: {
    id: string
  }
}

export default async function Page(input: Team) {
  const teamStats = await getTeamStatsByTeam(input.params.id);

  return (
    <main>
      <TeamStatsTeamPage team_stats={teamStats} />
    </main>
  )
}