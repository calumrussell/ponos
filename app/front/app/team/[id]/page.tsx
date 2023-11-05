import React from "react";

import prisma from "@/lib/prisma";
import { TeamStatsTeamPage } from "@/lib/components";
import { getAresRatingOverLastTwoYearsByTeam, getArtemisRatingOverLastTwoYearsByTeam, getRoute, getTeamStatsByTeam } from "@/lib/functions";
import { AresRatingChart, ArtemisRatingChart } from "@/lib/components/chart";

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
  const artemisRatingHistory = await getArtemisRatingOverLastTwoYearsByTeam(input.params.id);
  const aresRatingHistory = await getAresRatingOverLastTwoYearsByTeam(input.params.id);

  return (
    <main>
      <h4>{teamStats[0].team}</h4>
      <div>
        <h4>Last 20 Matches Team Stats </h4>
        <TeamStatsTeamPage team_stats={teamStats} />
      </div>
      <AresRatingChart rating_data={aresRatingHistory} />
      <ArtemisRatingChart rating_data={artemisRatingHistory} />
    </main>
  )
}