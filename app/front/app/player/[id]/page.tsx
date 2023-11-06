import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsPlayerPage } from "@/lib/components";
import { getPlayerStatsByPlayer, getPlayerStatsPer90SeasonByPlayer, getRoute } from "@/lib/functions";
import { PlayerStatsSeasonPlayerPage } from "@/lib/components/player";
import Link from "next/link";

export async function generateStaticParams() {
  const players = await prisma.player.findMany({});
  return players.map(player => ({id: getRoute(player.id.toString())}))
}

interface Match {
  params: {
    id: string
  }
}

export default async function Page(input: Match) {
  const [
    playerStats,
    playerStatsAvgs
  ] = await Promise.all([
    getPlayerStatsByPlayer(input.params.id),
    getPlayerStatsPer90SeasonByPlayer(input.params.id),
  ]);

  return (
    <main>

      <h4>{playerStats[0].player}</h4>
      <div>
        <h4>Team:</h4>
        <h4><Link href={`/team/${playerStats[0].team_id}`}>{playerStats[0].team}</Link></h4>
      </div>
      <div>
        <h4>per 90 Season Stats</h4>
        <PlayerStatsSeasonPlayerPage player_stats={playerStatsAvgs} />
      </div>
      <div>
        <h4>Last 20 matches</h4>
        <PlayerStatsPlayerPage player_stats={playerStats} />
      </div>
    </main>
  )
}