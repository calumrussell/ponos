import React from "react";

import prisma from "@/lib/prisma";
import { TeamStatsTeamPage } from "@/lib/components";
import { getAresRatingOverLastTwoYearsByTeam, getArtemisRatingOverLastTwoYearsByTeam, getCurrentAresRatingByTeam, getCurrentArtemisRatingByTeam, getPlayerStatsPer90SeasonByTeamAndYear, getRoute, getTeamStatsByTeam, getTeamStatsSeasonAvgsByTeam, roundNumber } from "@/lib/functions";
import { AresRatingChart, ArtemisRatingChart } from "@/lib/components/chart";
import { TeamSeasonStatsTeamPage, PlayerSeasonStatsTeamPage } from "@/lib/components/team";

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
  const [
    teamStats,
    artemisRatingHistory,
    aresRatingHistory,
    artemisRatingCurrent,
    aresRatingCurrent,
    teamSeasonAvgs
  ] = await Promise.all([
    getTeamStatsByTeam(input.params.id),
    getArtemisRatingOverLastTwoYearsByTeam(input.params.id),
    getAresRatingOverLastTwoYearsByTeam(input.params.id),
    getCurrentArtemisRatingByTeam(input.params.id),
    getCurrentAresRatingByTeam(input.params.id),
    getTeamStatsSeasonAvgsByTeam(input.params.id),
  ]);

  const playerSeasonAvgs = await getPlayerStatsPer90SeasonByTeamAndYear(input.params.id, teamStats[0].year)

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
        <p>{roundNumber(artemisRatingCurrent.off_rating)} / {roundNumber(artemisRatingCurrent.def_rating)}</p>
      </div>
      <div>
        <h4>Per Game Season Stats</h4>
        <TeamSeasonStatsTeamPage team_stats={teamSeasonAvgs} />
      </div>
      <div>
        <h4>Last 20 Matches</h4>
        <TeamStatsTeamPage team_stats={teamStats} />
      </div>
      <div>
        <h4>Per 90 Player Stats for current season</h4>
        <PlayerSeasonStatsTeamPage player_stats={playerSeasonAvgs} />
      </div>
      <AresRatingChart rating_data={aresRatingHistory} />
      <ArtemisRatingChart rating_data={artemisRatingHistory} />
    </main>
  )
}