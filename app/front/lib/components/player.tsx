import React from "react";

import { player_stats_full } from "@prisma/client";
import { buildTitles, buildValues } from "./stats";

const PlayerStatsRow = (row: player_stats_full) => {
  const  {
    player,
    position,
    minutes,
  } = row;
  
  return (
    <tr>
      <td>{player?.slice(0, 18)}</td>
      <td>{position}</td>
      <td>{minutes}</td>
      { buildValues(row) }
    </tr>
  )
}

export const PlayerStatsPlayerPage = ({ player_stats }: { player_stats: player_stats_full[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Player</th>
          <th>POS</th>
          <th>MIN</th>
          { buildTitles() }
        </tr>
      </thead>
      <tbody>
        {
          player_stats.map(row => {
            return <PlayerStatsRow key={row.player_id} {...row} />;
          })
        }
      </tbody>
    </table>
  )
}