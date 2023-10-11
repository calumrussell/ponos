import React from "react";
import Link from "next/link";

import { match_with_names, player_stats_with_names, team_stats_with_names } from "@prisma/client";

const TeamStatsRow = (row: team_stats_with_names) => {
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

//Display for both teams
export const TeamStats = ({ team_stats }: { team_stats: team_stats_with_names[] }) => {
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

const PlayerStatsRow = (row: player_stats_with_names) => {
  const  {
    player,
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
      <td>{player?.slice(0, 18)}</td>
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

export const PlayerStats = ({ player_stats }: { player_stats: player_stats_with_names[] }) => {
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

export const MatchRow = ({id, home, home_id, away, away_id, start_date} : match_with_names) => {
  const js_date = new Date(start_date * 1000);
  return (
    <tr>
      <td><Link href={`/match/${id}`}>{id}</Link></td>
      <td><Link href={`/team/${home_id}`}>{home}</Link></td>
      <td><Link href={`/team/${away_id}`}>{away}</Link></td>
      <td>{js_date.toUTCString()}</td>
    </tr>
  )
}

export const Matches = ({matches}: {matches: match_with_names[] }) => {
  return (
    <table>
      <thead>
        <tr>
          <th>Match</th>
          <th>Home</th>
          <th>Away</th>
          <th>Date</th>
        </tr>
      </thead>
      <tbody>
        {
          matches.map(match => {
            return <MatchRow key={match.id} {...match} />;
          })
        }
      </tbody>
    </table>
  )

}