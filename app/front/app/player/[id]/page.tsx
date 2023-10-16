import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsPlayerPage } from "@/lib/components";
import { getPlayerStatsByPlayer, getRoute } from "@/lib/functions";

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
  const playerStats = await getPlayerStatsByPlayer(input.params.id);

  return (
    <main>
      <PlayerStatsPlayerPage player_stats={playerStats} />
    </main>
  )
}