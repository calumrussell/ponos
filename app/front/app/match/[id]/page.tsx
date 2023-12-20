import React from "react";

import prisma from "@/lib/prisma";
import { PlayerStatsMatchPage, TeamStatsMatchPage } from "@/lib/components";
import { getMatch, getPlayerStats, getTeamStats, sortByPosition, getRoute, getEloPredictionByMatch, getArtemisPredictionByMatch, getAthenaPredictionByMatch, convertDatesWithTime, roundNumber, getLastAresRatingByDateAndTeam, getLastArtemisRatingByDateAndTeam } from "@/lib/functions";

export const revalidate = 10;

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
    aresPrediction,
    artemisPrediction,
    athenaPrediction,
    playerStats,
    teamStats,
  ] = await Promise.all([
    getMatch(input.params.id),
    getEloPredictionByMatch(input.params.id),
    getArtemisPredictionByMatch(input.params.id),
    getAthenaPredictionByMatch(input.params.id),
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
  const homeGoal = homeTeamStats ? homeTeamStats.goal + awayTeamStats.goal_own : null;
  const awayGoal = awayTeamStats ? awayTeamStats.goal + homeTeamStats.goal_own : null;

  const aresHomeWin = aresPrediction ? aresPrediction.home_win * 100 : 0.0;
  const aresAwayWin = aresPrediction ? aresPrediction.away_win * 100 : 0.0;
  const aresDraw = aresPrediction ? aresPrediction.draw * 100 : 0.0;

  const artemisHomeWin = artemisPrediction ? artemisPrediction.home_win * 100 : 0.0;
  const artemisAwayWin = artemisPrediction ? artemisPrediction.away_win * 100 : 0.0;
  const artemisDraw = artemisPrediction ? artemisPrediction.draw * 100 : 0.0;

  const athenaHomeWin = athenaPrediction ? athenaPrediction.home_win * 100 : 0.0;
  const athenaAwayWin = athenaPrediction ? athenaPrediction.away_win * 100 : 0.0;
  const athenaDraw = athenaPrediction ? athenaPrediction.draw * 100 : 0.0;

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
        <h4>Ares Prediction: </h4>
        <p>Home win: {roundNumber(aresHomeWin)}% <em>{roundNumber(1/(aresHomeWin/100))}</em></p>
        <p>Draw: {roundNumber(aresDraw)}% <em>{roundNumber(1/(aresDraw/100))}</em></p>
        <p>Away win: {roundNumber(aresAwayWin)}% <em>{roundNumber(1/(aresAwayWin/100))}</em></p>
      </div>
      <div>
        <h4>Ares rating: </h4>
        <p>Home Rating: {homeAresRating.rating}</p>
        <p>Away Rating: {awayAresRating.rating}</p>
      </div>
      <div>
        <h4>Artemis Prediction: </h4>
        <p>Home win: {roundNumber(artemisHomeWin)}% <em>{roundNumber(1/(artemisHomeWin/100))}</em></p>
        <p>Draw: {roundNumber(artemisDraw)}% <em>{roundNumber(1/(artemisDraw/100))}</em></p>
        <p>Away win: {roundNumber(artemisAwayWin)}% <em>{roundNumber(1/(artemisAwayWin/100))}</em></p>
      </div>
      <div>
        <h4>Artemis rating: </h4>
        <p><em>Off/Def</em></p>
        <p>Home Rating: {roundNumber(homeArtemisRating.off_rating)} / {roundNumber(homeArtemisRating.def_rating)} </p>
        <p>Away Rating: {roundNumber(awayArtemisRating.off_rating)} / {roundNumber(awayArtemisRating.def_rating)} </p>
      </div>
      {
        athenaHomeWin != 0.0 && athenaDraw != 0.0 && athenaAwayWin && (
          <div>
            <h4>Athena Prediction: </h4>
            <p>Home win: {roundNumber(athenaHomeWin)}% <em>{roundNumber(1/(athenaHomeWin/100))}</em></p>
            <p>Draw: {roundNumber(athenaDraw)}% <em>{roundNumber(1/(athenaDraw/100))}</em></p>
            <p>Away win: {roundNumber(athenaAwayWin)}% <em>{roundNumber(1/(athenaAwayWin/100))}</em></p>
          </div>
        )
      }
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
