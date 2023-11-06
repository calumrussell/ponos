import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsMatchPage, TeamStatsMatchPage } from "@/lib/components";
import { getMatch, getPlayerStats, getTeamStats, sortByPosition, getRoute, getEloPredictionByMatch, convertDatesWithTime, roundNumber, getLastAresRatingByDateAndTeam, getLastArtemisRatingByDateAndTeam } from "@/lib/functions";
import { match_full, player_stats_full, team_stats_full, elo_pred } from "@prisma/client";

export async function generateStaticParams() {
  const matches = await prisma.match_front.findMany({});
  return matches.map(match => ({id: getRoute(match.id.toString())}))
}

interface Match {
  params: {
    id: string
  }
}

export default async function Page(input: Match) {
  const [
    match,
    prediction,
    playerStats,
    teamStats,
  ] = await Promise.all([
    getMatch(input.params.id),
    getEloPredictionByMatch(input.params.id),
    getPlayerStats(input.params.id),
    getTeamStats(input.params.id),
  ]);
  
  const [
    homeAresRating,
    awayAresRating,
    homeArtemisRating,
    awayArtemisRating,
  ] = await Promise.all([
    getLastAresRatingByDateAndTeam(match.start_date as number, match.home_id as number),
    getLastAresRatingByDateAndTeam(match.start_date as number, match.away_id as number),
    getLastArtemisRatingByDateAndTeam(match.start_date as number, match.home_id as number),
    getLastArtemisRatingByDateAndTeam(match.start_date as number, match.away_id as number),
  ]);

  const homeSide = match?.home;
  const awaySide = match?.away;

  const homePlayerStats = playerStats.length > 0 ? sortByPosition(playerStats.filter((v: any) => v.team_id == match?.home_id)) : null;
  const awayPlayerStats = playerStats.length > 0 ? sortByPosition(playerStats.filter((v: any) => v.team_id == match?.away_id)) : null;

  const homeTeamStats = teamStats.length > 0 ? teamStats.filter((v: any) => v.team_id == match?.home_id)[0] : null;
  const awayTeamStats = teamStats.length > 0 ? teamStats.filter((v: any) => v.team_id == match?.away_id)[0] : null;

  //Zero is falsey value
  const homeGoal = homeTeamStats ? homeTeamStats.goal : null;
  const awayGoal = awayTeamStats ? awayTeamStats.goal : null;

  const homeWin = prediction ? prediction.home_win * 100 : 0.0;
  const awayWin = prediction ? prediction.away_win * 100 : 0.0;
  const draw = prediction ? prediction.draw * 100 : 0.0;

  return (
    <main>
      <h4>Home: {match.home}</h4>
      <h4>Away: {match.away}</h4>
      <h4>Tournament: {match.tournament}</h4>
      <h4>Date: {convertDatesWithTime(match.start_date)}</h4>
      {
        homeGoal != null && awayGoal != null && (
          <h4>{`Score: ${homeGoal} : ${awayGoal}`}</h4>
        )
      }
      <div>
        <h4>Prediction: </h4>
        <p>Home win: {roundNumber(homeWin)}% <em>{roundNumber(1/homeWin)}</em></p>
        <p>Draw: {roundNumber(draw)}% <em>{roundNumber(1/draw)}</em></p>
        <p>Away win: {roundNumber(awayWin)}% <em>{roundNumber(1/awayWin)}</em></p>
      </div>
      <div>
        <h4>Ares rating: </h4>
        <p>Home Rating: {homeAresRating.rating}</p>
        <p>Away Rating: {awayAresRating.rating}</p>
      </div>
      <div>
        <h4>Artemis rating: </h4>
        <p><em>Off/Def</em></p>
        <p>Home Rating: {roundNumber(homeArtemisRating.off_rating)} / {roundNumber(homeArtemisRating.def_rating)} </p>
        <p>Away Rating: {roundNumber(awayArtemisRating.off_rating)} / {roundNumber(awayArtemisRating.def_rating)} </p>
      </div>
      {
        homeTeamStats && awayTeamStats && (
          <TeamStatsMatchPage team_stats={[homeTeamStats, awayTeamStats]} />
        )
      }
      {
        homePlayerStats && (
          <React.Fragment>
            <h4>{homeSide}</h4>
            <PlayerStatsMatchPage player_stats={homePlayerStats} />
          </React.Fragment>
        )
      }
      {
        awayPlayerStats && (
          <React.Fragment>
            <h4>{awaySide}</h4>
            <PlayerStatsMatchPage player_stats={awayPlayerStats} />
          </React.Fragment>
        )
      }
    </main>
  )
}