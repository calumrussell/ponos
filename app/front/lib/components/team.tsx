import React from "react";
import Link from "next/link";

import { team_stats_full, team_stats_sum_by_season } from "@prisma/client"
import { convertDates } from "../functions";
import { buildMatchTitles, buildMatchValues } from "./stats";

const TeamStatsRow = (row: team_stats_full) => {
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

//Displays team and opposition
export const TeamStatsTeamPage = ({ team_stats }: { team_stats: team_stats_full[] }) => {
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
            return <TeamStatsRow key={row.team_id} {...row} />
          })
        }
      </tbody>
    </table>
  )
}

const TeamSeasonStatsRow = (row: team_stats_full) => {
  const  {
    year
  } = row;

  return (
    <tr>
      <td>{year}</td>
      { buildMatchValues(row) }
    </tr>
  )
}

//Should be in single row so will use match
export const TeamSeasonStatsTeamPage = ({ team_stats }: { team_stats: team_stats_sum_by_season[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Year</th>
          { buildMatchTitles() }
        </tr>
      </thead>
      <tbody>
        {
          team_stats.map(row => {
            return <TeamSeasonStatsRow key={row.team_id} {...row} />
          })
        }
      </tbody>
    </table>
  )
}