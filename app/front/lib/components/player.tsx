import React from "react";

import { player_stats_full } from "@prisma/client";
import { buildPlayerSeasonTitles, buildPlayerSeasonValues, buildStackedTitles, buildStackedValues } from "./stats";
import Link from "next/link";
import { convertDates } from "../functions";



export const PlayerStatsPlayerPage = ({ player_stats }: { player_stats: player_stats_full[] }) => {
  const Row = (row: player_stats_full) => {
    const  {
      match_id,
      player,
      position,
      minutes,
      start_date,
      opp_id,
      opp,
    } = row;
    
    return (
      <tr>
        <td><Link href={`/match/${match_id}`}>{convertDates(start_date)}</Link></td>
        <td><Link href={`/team/${opp_id}`}>{opp}</Link></td>
        <td>{position}</td>
        <td>{minutes}</td>
        { buildStackedValues(row) }
      </tr>
    )
  }
  return (
    <table>
      <thead>
        <tr>
          <th>Match</th>
          <th>Opp</th>
          <th>POS</th>
          <th>MIN</th>
          { buildStackedTitles() }
        </tr>
      </thead>
      <tbody>
        {
          player_stats.map(row => {
            return <Row key={row.player_id} {...row} />;
          })
        }
      </tbody>
    </table>
  )
}



export const PlayerStatsSeasonPlayerPage = ({ player_stats }: { player_stats: player_stats_per_ninety_by_season_team[] }) => {
  console.log(player_stats)

  const Row = (row: player_stats_per_ninety_by_season_team) => {
    const  {
      year,
      team,
      team_id,
    } = row;
    
    return (
      <tr>
        <td>{year}</td>
        <td><Link href={`/team/${team_id}`}>{team}</Link></td>
        { buildPlayerSeasonValues(row) }
      </tr>
    )
  }

  return (
    <table>
      <thead>
        <tr>
          <th>Year</th>
          <th>Team</th>
          { buildPlayerSeasonTitles() }
        </tr>
      </thead>
      <tbody>
        {
          player_stats.map(row => {
            return <Row key={row.player_id} {...row} />;
          })
        }
      </tbody>
    </table>
  )
}