import React from "react";
import prisma from "@/lib/prisma";

async function getPlayerStats(id: number) {
  const player_stats = await prisma.player_stats.findMany({
    where: {
      match_id: id
    }
  });
  return player_stats;
}

export default async function Page({id} : {id: number}) {
  const player_stats = await getPlayerStats(id);
  console.log(player_stats)
  return <div></div>
}