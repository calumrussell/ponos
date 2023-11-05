import React from "react";
import Link from "next/link";

import { team_stats_full } from "@prisma/client"
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