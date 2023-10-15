import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsPlayerPage } from "@/lib/components";

export async function generateStaticParams() {
  const players = await prisma.player.findMany({});
  return players.map(player => ({id: player.id.toString()}))
}

async function getPlayerStats(id: number) {
  const player_stats = await prisma.player_stats_full.findMany({
    where: {
      player_id: id
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
  const playerStats = await getPlayerStats(parseInt(input.params.id));

  return (
    <main>
      <PlayerStatsPlayerPage player_stats={playerStats} />
    </main>
  )
}