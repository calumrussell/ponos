import React from "react";
import { player_stats_full, team_stats_full, team_stats_avg_by_season, player_stats_per_ninety_by_season_team } from "@prisma/client";

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
  'goal_avg' |
  'opp_goal_avg' |
  'xg_avg' |
  'opp_xg_avg' |
  'pass_avg' |
  'opp_pass_avg' |
  'pass_key_avg' |
  'opp_pass_key_avg' |
  'shot_avg' |
  'opp_shot_avg' |
  'shot_on_target_avg' |
  'opp_shot_on_target_avg' |
  'tackle_won_avg' |
  'interception_won_avg' |
  'clearance_effective_avg' |
  'assist_avg'

const playerSeasonStats: supportedStats[] = [
  'goal_avg',
  'xg_avg',
  'assist_avg',
  'pass_avg',
  'pass_key_avg',
  'shot_avg',
  'shot_on_target_avg',
  'tackle_won_avg',
  'interception_won_avg',
  'clearance_effective_avg',
];

const teamSeasonStats: supportedStats[] = [
  'goal_avg',
  'opp_goal_avg',
  'xg_avg',
  'opp_xg_avg',
  'assist_avg',
  'pass_avg',
  'opp_pass_avg',
  'pass_key_avg',
  'opp_pass_key_avg',
  'shot_avg',
  'opp_shot_avg',
  'shot_on_target_avg',
  'opp_shot_on_target_avg',
  'tackle_won_avg',
  'interception_won_avg',
  'clearance_effective_avg',
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
  'goal_avg': 'GOL',
  'opp_goal_avg': 'oGOL',
  'xg_avg': 'xGOL',
  'opp_xg_avg': 'oxGOL',
  'assist_avg': 'AST',
  'pass_avg': 'PAS',
  'opp_pass_avg': 'oPAS',
  'pass_key_avg': 'kPAS',
  'opp_pass_key_avg': 'okPAS',
  'shot_avg': 'SHO',
  'opp_shot_avg': 'oSHO',
  'shot_on_target_avg': 'SON',
  'opp_shot_on_target_avg': 'oSON',
  'tackle_won_avg': 'TWN',
  'interception_won_avg': 'IWN',
  'clearance_effective_avg': 'CWN',
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
  'goal_avg': 'Goal',
  'opp_goal_avg': 'Opposition goal',
  'xg_avg': 'Expected goal',
  'opp_xg_avg': 'Opposition expected goal',
  'assist_avg': 'Assist',
  'pass_avg': 'Pass',
  'opp_pass_avg': 'Opposition pass',
  'pass_key_avg': 'Key pass',
  'opp_pass_key_avg': 'Opposition key pass',
  'shot_avg': 'Shot',
  'opp_shot_avg': 'Opposition shot',
  'shot_on_target_avg': 'Shot on target',
  'opp_shot_on_target_avg': 'Opposition shot on target',
  'tackle_won_avg': 'Tackle won',
  'interception_won_avg': 'Interception won',
  'clearance_effective_avg': 'Clearance effective',
};

const decimal = [
  'xg',
  'opp_xg',
  'goal_avg',
  'opp_goal_avg',
  'xg_avg',
  'opp_xg_avg',
  'pass_avg',
  'opp_pass_avg',
  'pass_key_avg',
  'opp_pass_key_avg',
  'shot_avg',
  'opp_shot_avg',
  'shot_on_target_avg',
  'opp_shot_on_target_avg',
  'tackle_won_avg',
  'interception_won_avg',
  'clearance_effective_avg',
  'assist_avg'
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

export const buildPlayerSeasonTitles = () => {
  return buildTitles(playerSeasonStats);
}

const buildValues = (stats: supportedStats[], row: player_stats_full | team_stats_full | team_stats_avg_by_season | player_stats_per_ninety_by_season_team) => {
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

export const buildPlayerSeasonValues = (row: player_stats_per_ninety_by_season_team) => {
  return buildValues(playerSeasonStats, row);
}