import React from "react";
import { player_stats_full, team_stats_full, team_stats_avg_by_season } from "@prisma/client";

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
  'assist' |
  'goal_sum' |
  'opp_goal_sum' |
  'xg_sum' |
  'opp_xg_sum' |
  'pass_sum' |
  'opp_pass_sum' |
  'pass_key_sum' |
  'opp_pass_key_sum' |
  'shot_sum' |
  'opp_shot_sum' |
  'shot_on_target_sum' |
  'opp_shot_on_target_sum' |
  'tackle_won_sum' |
  'interception_won_sum' |
  'clearance_effective_sum' |
  'assist_sum'

const teamSeasonStats: supportedStats[] = [
  'goal_sum',
  'opp_goal_sum',
  'xg_sum',
  'opp_xg_sum',
  'pass_sum',
  'opp_pass_sum',
  'pass_key_sum',
  'opp_pass_key_sum',
  'shot_sum',
  'opp_shot_sum',
  'shot_on_target_sum',
  'opp_shot_on_target_sum',
  'tackle_won_sum',
  'interception_won_sum',
  'clearance_effective_sum',
  'assist_sum'
];

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
  'goal_sum': 'GOL',
  'opp_goal_sum': 'oGOL',
  'xg_sum': 'xGOL',
  'opp_xg_sum': 'oxGOL',
  'assist_sum': 'AST',
  'pass_sum': 'PAS',
  'opp_pass_sum': 'oPAS',
  'pass_key_sum': 'kPAS',
  'opp_pass_key_sum': 'okPAS',
  'shot_sum': 'SHO',
  'opp_shot_sum': 'oSHO',
  'shot_on_target_sum': 'SON',
  'opp_shot_on_target_sum': 'oSON',
  'tackle_won_sum': 'TWN',
  'interception_won_sum': 'IWN',
  'clearance_effective_sum': 'CWN',
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
  'goal_sum': 'Goal',
  'opp_goal_sum': 'Opposition goal',
  'xg_sum': 'Expected goal',
  'opp_xg_sum': 'Opposition expected goal',
  'assist_sum': 'Assist',
  'pass_sum': 'Pass',
  'opp_pass_sum': 'Opposition pass',
  'pass_key_sum': 'Key pass',
  'opp_pass_key_sum': 'Opposition key pass',
  'shot_sum': 'Shot',
  'opp_shot_sum': 'Opposition shot',
  'shot_on_target_sum': 'Shot on target',
  'opp_shot_on_target_sum': 'Opposition shot on target',
  'tackle_won_sum': 'Tackle won',
  'interception_won_sum': 'Interception won',
  'clearance_effective_sum': 'Clearance effective',
};

const decimal = [
  'xg',
  'opp_xg',
  'goal_sum',
  'opp_goal_sum',
  'xg_sum',
  'opp_xg_sum',
  'pass_sum',
  'opp_pass_sum',
  'pass_key_sum',
  'opp_pass_key_sum',
  'shot_sum',
  'opp_shot_sum',
  'shot_on_target_sum',
  'opp_shot_on_target_sum',
  'tackle_won_sum',
  'interception_won_sum',
  'clearance_effective_sum',
  'assist_sum'
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

export const buildTeamSeasonTitles = () => {
  return buildTitles(teamSeasonStats);
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

export const buildTeamSeasonValues = (row: team_stats_avg_by_season) => {
  return buildValues(teamSeasonStats, row);
}