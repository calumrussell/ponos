import React from "react";
import Link from "next/link";

import { team_stats_full, player_stats_full } from "@prisma/client";

const TeamStatsRow = (row: team_stats_full) => {
  const  {
    team_id,
    team,
    pass,
    goal,
    shot,
    shot_on_target,
    tackle_won,
    interception_won,
    clearance_effective,
  } = row;
  
  return (
    <tr>
      <td><Link href={`/team/${team_id}`}>{team}</Link></td>
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

//Displays stats for team only, no opposition
export const TeamStatsMatchPage = ({ team_stats }: { team_stats: team_stats_full[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Team</th>
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

const PlayerStatsRow = (row: player_stats_full) => {
  const  {
    player,
    player_id,
    position,
    minutes,
    pass,
    goal,
    shot,
    shot_on_target,
    tackle_won,
    interception_won,
    clearance_effective,
  } = row;
  
  return (
    <tr>
      <td><Link href={`/player/${player_id}`}>{player?.slice(0, 18)}</Link></td>
      <td>{position}</td>
      <td>{minutes}</td>
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

export const PlayerStatsMatchPage = ({ player_stats }: { player_stats: player_stats_full[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Player</th>
          <th>Position</th>
          <th>Minutes</th>
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
          player_stats.map(row => {
            return <PlayerStatsRow key={row.player_id} {...row} />;
          })
        }
      </tbody>
    </table>
  )
}