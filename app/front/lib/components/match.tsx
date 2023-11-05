import React from "react";
import Link from "next/link";

import { team_stats_full, player_stats_full } from "@prisma/client";
import { buildStackedTitles, buildStackedValues } from "./stats";

const TeamStatsRow = (row: team_stats_full) => {
  const  {
    team_id,
    team,
  } = row;
  
  return (
    <tr>
      <td><Link href={`/team/${team_id}`}>{team}</Link></td>
      { buildStackedValues(row) }
    </tr>
  )
}

//Displays stats for team only, no opposition
export const TeamStatsMatchPage = ({ team_stats }: { team_stats: team_stats_full[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Team</th>
          { buildStackedTitles() }
        </tr>
      </thead>
      <tbody>
        {
          team_stats.map(row => {
            return <TeamStatsRow key={row.team_id} {...row} />
          })
        }
      </tbody>
    </table>
  )
}

const PlayerStatsRow = (row: player_stats_full) => {
  const  {
    player,
    player_id,
    position,
    minutes,
  } = row;
  
  return (
    <tr>
      <td><Link href={`/player/${player_id}`}>{player?.slice(0, 18)}</Link></td>
      <td>{position}</td>
      <td>{minutes}</td>
      { buildStackedValues(row) }
    </tr>
  )
}

export const PlayerStatsMatchPage = ({ player_stats }: { player_stats: player_stats_full[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Player</th>
          <th>POS</th>
          <th>MIN</th>
          { buildStackedTitles() }
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