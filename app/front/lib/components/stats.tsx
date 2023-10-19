import React from "react";
import { player_stats_full, team_stats_full } from "@prisma/client";

const stats = [
  'goal',
  'xg',
  'assist',
  'pass',
  'pass_key',
  'shot',
  'shot_on_target',
  'tackle_won',
  'interception_won',
  'clearance_effective'
] as const;

const titles = [
  'GOL',
  'xGOL',
  'AST',
  'PAS',
  'kPAS',
  'SHO',
  'SON',
  'TWN',
  'IWN',
  'CWN'
] as const;

const tooltips = [
  'Goal',
  'Expected goal',
  'Assist',
  'Pass',
  'Key pass',
  'Shot',
  'Shot on target',
  'Tackle won',
  'Interception won',
  'Clearance effective'
]

const decimal = [
  'xg'
]

export const buildTitles = () => {
  const statCount = stats.length;
  return (
    <React.Fragment>
      {
        Array.from(Array(statCount).keys()).map(v => {
          return <th key={v} className="data" title={tooltips[v]}>{titles[v]}</th>
        })
      }
    </React.Fragment>
  )
}

export const buildValues = (row: player_stats_full | team_stats_full) => {
  return (
    <React.Fragment>
      {
        stats.map(stat => {
          if (decimal.includes(stat) && row[stat] != null) {
            // @ts-ignore
            //return <td key={stat}>{Math.round(row[stat] *100)/100}</td>
            return <td key={stat}>{row[stat]?.toFixed(3)}</td>
          }
          return <td key={stat}>{row[stat]}</td>
        })
      }
    </React.Fragment>
  )
}