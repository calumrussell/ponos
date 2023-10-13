import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsPlayerPage } from "@/lib/components";

async function getPlayerStats(id: string) {
  const player_stats = await prisma.player_stats_full.findMany({
    where: {
      player_id: parseInt(id)
    },
    take: 10,
  });
  return player_stats;
}

interface Match {
  params: {
    id: string 
  }
}

export default async function Page(input: Match) {
  const playerStats = await getPlayerStats(input.params.id);

  return (
    <main>
      <PlayerStatsPlayerPage player_stats={playerStats} />
    </main>
  )
}