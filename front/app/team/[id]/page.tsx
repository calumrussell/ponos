import React from "react";

import prisma from "@/lib/prisma";
import { TeamStats } from "@/lib/components";

async function getTeamStats(id: string) {
  const team_stats = await prisma.team_stats_with_names.findMany({
    where: {
      team_id: parseInt(id)
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
  const teamStats = await getTeamStats(input.params.id);

  return (
    <main>
      <TeamStats team_stats={teamStats} />
    </main>
  )
}