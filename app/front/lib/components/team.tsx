import React from "react";
import Link from "next/link";

import { team_stats_full, team_stats_avg_by_season } from "@prisma/client"
import { convertDates } from "../functions";
import { buildMatchTitles, buildMatchValues, buildPlayerSeasonTitles, buildPlayerSeasonValues, buildTeamSeasonTitles, buildTeamSeasonValues } from "./stats";

//Displays team and opposition
export const TeamStatsTeamPage = ({ team_stats }: { team_stats: team_stats_full[] }) => {
  const Row = (row: team_stats_full) => {
    const  {
      team_id,
      team,
      start_date,
      opp,
      opp_id,
      match_id,
    } = row;

  return (
    <tr>
      <td><Link href={`/team/${team_id}`}>{team}</Link></td>
      <td><Link href={`/team/${opp_id}`}>{opp}</Link></td>
      <td><Link href={`/match/${match_id}`}>{convertDates(start_date)}</Link></td>
      { buildMatchValues(row) }
    </tr>
  )
}
  return (
    <table>
      <thead>
        <tr>
          <th>Team</th>
          <th>Opp</th>
          <th>Match</th>
          { buildMatchTitles() }
        </tr>
      </thead>
      <tbody>
        {
          team_stats.map(row => {
            return <Row key={row.team_id} {...row} />
          })
        }
      </tbody>
    </table>
  )
}

//Should be in single row so will use match
export const TeamSeasonStatsTeamPage = ({ team_stats }: { team_stats: team_stats_avg_by_season[] }) => {
  const Row = (row: team_stats_full) => {
    const  {
      year
    } = row;

    return (
      <tr>
        <td>{year}</td>
        { buildTeamSeasonValues(row) }
      </tr>
    )
  }

  return (
    <table>
      <thead>
        <tr>
          <th>Year</th>
          { buildTeamSeasonTitles() }
        </tr>
      </thead>
      <tbody>
        {
          team_stats.map(row => {
            return <Row key={row.team_id} {...row} />
          })
        }
      </tbody>
    </table>
  )
}

export const PlayerSeasonStatsTeamPage = ({ player_stats }: { player_stats: player_stats_per_ninety_by_season_team[] }) => {
  const Row = (row: player_stats_per_ninety_by_season_team) => {
    const  {
      player,
      player_id,
      minutes,
    } = row;

    return (
      <tr>
        <td><Link href={`/player/${player_id}`}>{player?.slice(0, 18)}</Link></td>
        <td>{minutes}</td>
        { buildPlayerSeasonValues(row) }
      </tr>
    )
  }

  return (
    <table>
      <thead>
        <tr>
          <th>Player</th>
          <th>MIN</th>
          { buildPlayerSeasonTitles() }
        </tr>
      </thead>
      <tbody>
        {
          player_stats.map(row => {
            return <Row key={row.player_id} {...row} />
          })
        }
      </tbody>
    </table>
  )
}