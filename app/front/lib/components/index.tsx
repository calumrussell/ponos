import React from "react";
import Link from "next/link";

import { match_full } from "@prisma/client";
import { convertDates } from "../functions";

export { TeamStatsMatchPage, PlayerStatsMatchPage } from "./match";
export { TeamStatsTeamPage } from "./team";
export { PlayerStatsPlayerPage } from './player';

export const MatchRow = ({id, home, home_id, away, away_id, start_date} : match_full) => {
  return (
    <tr>
      <td><Link href={`/match/${id}`}>{convertDates(start_date)}</Link></td>
      <td><Link href={`/team/${home_id}`}>{home}</Link></td>
      <td><Link href={`/team/${away_id}`}>{away}</Link></td>
    </tr>
  )
}

export const Matches = ({matches}: {matches: match_full[] }) => {
  return (
    <table>
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

export const GroupedMatches = ({matches}: {matches: match_full[] }) => {

  const groups = new Map();

  matches.forEach(match => {
    const dom = convertDates(match.start_date);
    if (groups.has(dom)) {
      const existing = groups.get(dom);
      const copy = [...existing, match];
      groups.set(dom, copy);
    } else {
      groups.set(dom, [match]);
    }
  })
  
  return (
    <React.Fragment>
      {
        Array.from(groups.keys()).map(k => {
          return (
            <div key={k} className="matches-wrapper">
              <Matches matches={groups.get(k)} />
            </div>
          );
        })
      }
    </React.Fragment>
  )
}