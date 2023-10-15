import React from "react";
import Link from "next/link";

import { match_full } from "@prisma/client";

export { TeamStatsMatchPage, PlayerStatsMatchPage } from "./match";
export { TeamStatsTeamPage } from "./team";
export { PlayerStatsPlayerPage } from './player';

export const MatchRow = ({id, home, home_id, away, away_id, start_date} : match_full) => {
  const js_date = start_date ? new Date(start_date * 1000) : new Date();
  return (
    <tr>
      <td><Link href={`/match/${id}`}>{id}</Link></td>
      <td><Link href={`/team/${home_id}`}>{home}</Link></td>
      <td><Link href={`/team/${away_id}`}>{away}</Link></td>
      <td>{js_date.toUTCString()}</td>
    </tr>
  )
}

export const Matches = ({matches}: {matches: match_full[] }) => {
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