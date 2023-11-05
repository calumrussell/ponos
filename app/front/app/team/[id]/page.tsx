import React from "react";

import prisma from "@/lib/prisma";
import { TeamStatsTeamPage } from "@/lib/components";
import { getAresRatingOverLastTwoYearsByTeam, getArtemisRatingOverLastTwoYearsByTeam, getCurrentAresRatingByTeam, getCurrentArtemisRatingByTeam, getRoute, getSeasonTotalsByTeam, getTeamStatsByTeam, getTeamStatsSeasonTotalsByTeam } from "@/lib/functions";
import { AresRatingChart, ArtemisRatingChart } from "@/lib/components/chart";
import { TeamSeasonStatsTeamPage } from "@/lib/components/team";

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
  const artemisRatingCurrent = await getCurrentArtemisRatingByTeam(input.params.id);
  const aresRatingCurrent = await getCurrentAresRatingByTeam(input.params.id);
  const teamSeasonTotals = await getTeamStatsSeasonTotalsByTeam(input.params.id);

  return (
    <main>
      <h4>{teamStats[0].team}</h4>
      <div>
        <h4>Ares Rating:</h4>
        <p>{aresRatingCurrent.rating}</p>
      </div>
      <div>
        <h4>Artemis Rating:</h4>
        <p><em>Off/Def</em></p>
        <p>{artemisRatingCurrent.off_rating} / {artemisRatingCurrent.def_rating}</p>
      </div>
      <div>
        <h4>Season Stats</h4>
        <TeamSeasonStatsTeamPage team_stats={teamSeasonTotals} />
      </div>
      <div>
        <h4>Last 20 Matches Team Stats </h4>
        <TeamStatsTeamPage team_stats={teamStats} />
      </div>
      <AresRatingChart rating_data={aresRatingHistory} />
      <ArtemisRatingChart rating_data={artemisRatingHistory} />
    </main>
  )
}