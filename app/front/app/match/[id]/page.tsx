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
  const match = await getMatch(input.params.id) as match_full;
  const prediction = await getEloPredictionByMatch(input.params.id) as elo_pred;

  const playerStats = await getPlayerStats(input.params.id) as player_stats_full[];
  const teamStats = await getTeamStats(input.params.id) as team_stats_full[];

  const homeAresRating = await getLastAresRatingByDateAndTeam(match.start_date, match.home_id);
  const awayAresRating = await getLastAresRatingByDateAndTeam(match.start_date, match.away_id);

  const homeArtemisRating = await getLastArtemisRatingByDateAndTeam(match.start_date, match.home_id);
  const awayArtemisRating = await getLastArtemisRatingByDateAndTeam(match.start_date, match.away_id);

  const homeSide = match?.home;
  const awaySide = match?.away;

  const homePlayerStats = playerStats.length > 0 ? sortByPosition(playerStats.filter((v) => v.team_id == match?.home_id)) : null;
  const awayPlayerStats = playerStats.length > 0 ? sortByPosition(playerStats.filter((v) => v.team_id == match?.away_id)) : null;

  const homeTeamStats = teamStats.length > 0 ? teamStats.filter((v) => v.team_id == match?.home_id)[0] : null;
  const awayTeamStats = teamStats.length > 0 ? teamStats.filter((v) => v.team_id == match?.away_id)[0] : null;

  //Zero is falsey value
  const homeGoal = homeTeamStats ? homeTeamStats.goal : null;
  const awayGoal = awayTeamStats ? awayTeamStats.goal : null;

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
        <p>Home win: {roundNumber(prediction.home_win * 100)}% <em>{roundNumber(1/prediction.home_win)}</em></p>
        <p>Draw: {roundNumber(prediction.draw * 100)}% <em>{roundNumber(1/prediction.draw)}</em></p>
        <p>Away win: {roundNumber(prediction.away_win * 100)}% <em>{roundNumber(1/prediction.away_win)}</em></p>
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