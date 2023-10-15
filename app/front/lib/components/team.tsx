import React from "react";
import Link from "next/link";

import { team_stats_full } from "@prisma/client"

const TeamStatsRow = (row: team_stats_full) => {
  const  {
    team_id,
    team,
    start_date,
    opp,
    opp_id,
    match_id,
    pass,
    goal,
    shot,
    shot_on_target,
    tackle_won,
    interception_won,
    clearance_effective,
  } = row;

  const date = start_date ? new Date(start_date * 1000): new Date();
  const dateStr = date.toLocaleDateString('en-GB', {year: 'numeric', month: 'numeric', day: 'numeric'});
  
  return (
    <tr>
      <td><Link href={`/team/${team_id}`}>{team}</Link></td>
      <td><Link href={`/team/${opp_id}`}>{opp}</Link></td>
      <td><Link href={`/match/${match_id}`}>{dateStr}</Link></td>
      <td>{pass}</td>
      <td>{goal}</td>
      <td>{shot}</td>
      <td>{shot_on_target}</td>
      <td>{tackle_won}</td>
      <td>{interception_won}</td>
      <td>{clearance_effective}</td>
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
          <th>Pass</th>
          <th>Goal</th>
          <th>Shot</th>
          <th>Shot On</th>
          <th>Tackle W</th>
          <th>Int W</th>
          <th>Clearance E</th>
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