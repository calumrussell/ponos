import React from "react";
import { player_stats_full, team_stats_full } from "@prisma/client";

type supportedStats = 
  'goal' |
  'opp_goal' |
  'xg' |
  'opp_xg' |
  'pass' |
  'opp_pass' |
  'pass_key' |
  'opp_pass_key' |
  'shot' |
  'opp_shot' |
  'shot_on_target' |
  'opp_shot_on_target' |
  'tackle_won' |
  'interception_won' |
  'clearance_effective' |
  'assist'

const matchStats: supportedStats[] = [
  'goal',
  'opp_goal',
  'xg',
  'opp_xg',
  'pass',
  'opp_pass',
  'pass_key',
  'opp_pass_key',
  'shot',
  'opp_shot',
  'shot_on_target',
  'opp_shot_on_target',
  'tackle_won',
  'interception_won',
  'clearance_effective'
];

const stackedStats: supportedStats[] = [
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
];

type StatMap = {[k in supportedStats]: string}

const titleMap: StatMap = {
  'goal': 'GOL',
  'opp_goal': 'oGOL',
  'xg': 'xGOL',
  'opp_xg': 'oxGOL',
  'assist': 'AST',
  'pass': 'PAS',
  'opp_pass': 'oPAS',
  'pass_key': 'kPAS',
  'opp_pass_key': 'okPAS',
  'shot': 'SHO',
  'opp_shot': 'oSHO',
  'shot_on_target': 'SON',
  'opp_shot_on_target': 'oSON',
  'tackle_won': 'TWN',
  'interception_won': 'IWN',
  'clearance_effective': 'CWN',
};

const tooltipMap: StatMap = {
  'goal': 'Goal',
  'opp_goal': 'Opposition goal',
  'xg': 'Expected goal',
  'opp_xg': 'Opposition expected goal',
  'assist': 'Assist',
  'pass': 'Pass',
  'opp_pass': 'Opposition pass',
  'pass_key': 'Key pass',
  'opp_pass_key': 'Opposition key pass',
  'shot': 'Shot',
  'opp_shot': 'Opposition shot',
  'shot_on_target': 'Shot on target',
  'opp_shot_on_target': 'Opposition shot on target',
  'tackle_won': 'Tackle won',
  'interception_won': 'Interception won',
  'clearance_effective': 'Clearance effective',
};

const decimal = [
  'xg',
  'opp_xg',
]

const buildTitles = (stats: supportedStats[]) => {
  return (
    <React.Fragment>
      {
        stats.map((v, i) => {
          return <th key={i} className="data" title={tooltipMap[v]}>{titleMap[v]}</th>
        })
      }
    </React.Fragment>
  )
}

export const buildStackedTitles = () => {
  return buildTitles(stackedStats);
}

export const buildMatchTitles = () => {
  return buildTitles(matchStats);
}

const buildValues = (stats: supportedStats[], row: player_stats_full | team_stats_full) => {
  return (
    <React.Fragment>
      {
        stats.map(stat => {
          //@ts-ignore
          if (decimal.includes(stat) && row[stat] != null) {
            //@ts-ignore
            return <td key={stat}>{row[stat].toFixed(2)}</td>
          }
          //@ts-ignore
          return <td key={stat}>{row[stat]}</td>
        })
      }
    </React.Fragment>
  )
}

export const buildStackedValues = (row: player_stats_full | team_stats_full) => {
  return buildValues(stackedStats, row);
}

export const buildMatchValues = (row: player_stats_full | team_stats_full) => {
  return buildValues(matchStats, row);
}