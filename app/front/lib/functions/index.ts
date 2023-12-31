const { createCipheriv, createDecipheriv } = require('crypto');
import prisma from '@/lib/prisma';
import { request } from 'http';

export const getRoute = (id: string) => {
  const key = process.env.ROUTE_KEY;
  const iv = process.env.ROUTE_IV;
  const cipher = createCipheriv('aes256', key, iv);
  return cipher.update(id, 'utf8', 'hex') + cipher.final('hex');
}

export const findRoute = (id: string) => {
  const key = process.env.ROUTE_KEY;
  const iv = process.env.ROUTE_IV;
  const decipher= createDecipheriv('aes256', key, iv);
  return decipher.update(id, 'hex', 'utf-8') + decipher.final('utf8');
}

const requestFormatter = (vals: any): any => {
  if (vals === undefined || vals === null) {
    return vals;
  }

  const format = (v: any) => {
    if (Object.hasOwn(v, 'id')) {
      const existing = v.id;
      v.id = getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'player_id')) {
      const existing = v.player_id;
      v.player_id = getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'match_id')) {
      const existing = v.match_id;
      v.match_id= getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'team_id')) {
      const existing = v.team_id;
      v.team_id= getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'opp_id')) {
      const existing = v.opp_id;
      v.opp_id= getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'home_id')) {
      const existing = v.home_id;
      v.home_id = getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'away_id')) {
      const existing = v.away_id;
      v.away_id = getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'season_id')) {
      const existing = v.season_id;
      v.season_id = getRoute(existing.toString());
    }
    if (Object.hasOwn(v, 'tournament_id')) {
      const existing = v.tournament_id;
      v.tournament_id = getRoute(existing.toString());
    }
    return v;
  }

  if (Array.isArray(vals)) {
    return vals.map((v: any) => format(v))
  } else {
    return format(vals);
  }
}

export async function getMatch(id: string) {
  const match = await prisma.match_full.findFirst({
    where: {
      id: parseInt(findRoute(id))
    }
  })
  return requestFormatter(match);
}

export async function getTeamStats(id: string) {
  const team_stats = await prisma.team_stats_full.findMany({
    where: {
      match_id: parseInt(findRoute(id))
    }
  })
  return requestFormatter(team_stats);
};

export async function getTeamStatsSeasonAvgsByTeam(id: string) {
  const team_stats = await prisma.team_stats_avg_by_season.findMany({
    where: {
      team_id: parseInt(findRoute(id))
    },
    orderBy: {
      year: 'desc',
    },
    take: 5,
  });
  return requestFormatter(team_stats);
}

export async function getPlayerStats(id: string) {
  const player_stats = await prisma.player_stats_full.findMany({
    where: {
      match_id: parseInt(findRoute(id))
    },
    orderBy: [
      {
        team_id: 'desc',
      },
      {
        minutes: 'desc',
      }
    ]
  });
  return requestFormatter(player_stats);
}

export async function getPlayerStatsPer90SeasonByTeamAndYear(id: string, year: number) {
  const team_stats = await prisma.player_stats_per_ninety_by_season_team.findMany({
    where: {
      AND: [
        {
          team_id: parseInt(findRoute(id)),
        },
        {
          year: year
        }
      ]
    },
    orderBy: {
      minutes: 'desc'
    }
  });
  return requestFormatter(team_stats);
}

export async function getPlayerStatsPer90SeasonByPlayer(id: string) {
  const team_stats = await prisma.player_stats_per_ninety_by_season_team.findMany({
    where: {
      AND: [
        {
          player_id: parseInt(findRoute(id)),
        },
        {
          year: {
            gte: 2020
          }
        }
      ]
    },
    orderBy: {
      year: 'desc',
    },
  });
  return requestFormatter(team_stats);
}

export async function getCurrentArtemisRatingByTeam(team_id: string) {
  const rating = await prisma.poiss_ratings.findFirst({
    where: {
      team_id: parseInt(findRoute(team_id)),
    },
    orderBy: {
      date: 'desc',
    }
  });
  return requestFormatter(rating);
}

export async function getArtemisRatingOverLastTwoYearsByTeam(team_id: string) {
  const now = Date.now()/1000;
  const twoYearsInSeconds = (86400 * 365) * 2
  const rating = await prisma.poiss_ratings.findMany({
    where: {
      AND: [
        {
          date: {
            gt:  now - twoYearsInSeconds,
          }
        },
        {
          team_id: parseInt(findRoute(team_id)),
        }
      ]
    },
    orderBy: {
      date: 'desc'
    }
  });
  return requestFormatter(rating);
}

export async function getLastArtemisRatingByDateAndTeam(match_date: number, team_id: number) {
  const rating = await prisma.poiss_rolling_average.findFirst({
    where: {
      AND: [
        {
          date: {
            lt: match_date,
          }
        },
        {
          team_id: parseInt(findRoute(team_id.toString())),
        }
      ]
    },
    orderBy: {
      date: 'desc'
    }
  });
  //Because of the contruction of artemis ratings, it is possible to have a valid empty result so
  //we need to return a value if empty too, this should only impact 1 or 2 games a season
  if (rating == null) {
    return requestFormatter({team_id: team_id, date: match_date, off_rating: 0.0, def_rating: 0.0})
  }
  return requestFormatter(rating);
}

export async function getCurrentAresRatingByTeam(team_id: string) {
  const rating = await prisma.elo_ratings.findFirst({
    where: {
      team_id: parseInt(findRoute(team_id)),
    },
    orderBy: {
      date: 'desc',
    }
  });
  return requestFormatter(rating);
}

export async function getAresRatingOverLastTwoYearsByTeam(team_id: string) {
  const now = Date.now()/1000;
  const twoYearsInSeconds = (86400 * 365) * 2
  const rating = await prisma.elo_rolling_average.findMany({
    where: {
      AND: [
        {
          date: {
            gt:  now - twoYearsInSeconds,
          }
        },
        {
          team_id: parseInt(findRoute(team_id)),
        }
      ]
    },
    orderBy: {
      date: 'desc'
    }
  })
  return requestFormatter(rating);
}

export async function getLastAresRatingByDateAndTeam(match_date: number, team_id: number) {
  const rating = await prisma.elo_ratings.findFirst({
    where: {
      AND: [
        {
          date: {
            lt: match_date,
          }
        },
        {
          team_id: parseInt(findRoute(team_id.toString())),
        }
      ]
    },
    orderBy: {
      date: 'desc'
    }
  })
  return requestFormatter(rating);
}

export async function getEloPredictionByMatch(id: string) {
  const prediction = await prisma.elo_pred.findUnique({
    where: {
      match_id: parseInt(findRoute(id))
    }
  })
  return requestFormatter(prediction);
}

export async function getArtemisPredictionByMatch(id: string) {
  const prediction = await prisma.poiss_pred.findUnique({
    where : {
      match_id: parseInt(findRoute(id))
    }
  })
  return requestFormatter(prediction);
}

export async function getAthenaPredictionByMatch(id: string) {
  const prediction = await prisma.wei_pred.findUnique({
    where: {
      match_id: parseInt(findRoute(id))
    }
  })
  return requestFormatter(prediction);
}

export async function getPlayerStatsByPlayer(id: string) {
  const player_stats = await prisma.player_stats_full.findMany({
    where: {
      player_id: parseInt(findRoute(id))
    },
    orderBy: {
      start_date: 'desc'
    },
    take: 20,
  });
  return requestFormatter(player_stats);
}

export async function getTeamStatsByTeam(id: string) {
  const team_stats = await prisma.team_stats_full.findMany({
    where: {
      team_id: parseInt(findRoute(id))
    },
    orderBy: {
      start_date: 'desc'
    },
    take: 20,
  })
  return requestFormatter(team_stats);
};

export async function getRecentMatches() {
  let epoch = Date.now() / 1000;
  const matches = await prisma.match_full.findMany({
    where: {
      start_date : {
        gt: epoch - (86400 * 20),
        lt: epoch + (86400),
      }
    },
    orderBy: [
      {
        tournament_id: 'desc',
      },
      {
        start_date: 'desc',
      }
    ]
  })
  return requestFormatter(matches);
}

export const sortByPosition = (arr: any) => {
  const positionOrder = [
    'GK',
    'DL',
    'DC',
    'DR',
    'DML',
    'DMC',
    'DMR',
    'ML',
    'MC',
    'MR',
    'AML',
    'AMC',
    'AMR',
    'FWL',
    'FW',
    'FWR',
    'Sub'
  ];

  const orderForIndexVals = positionOrder.slice(0).reverse();
  arr.sort((a: any, b: any) => {
    const aIndex = -orderForIndexVals.indexOf(a.position);
    const bIndex = -orderForIndexVals.indexOf(b.position);
    return aIndex - bIndex;
  });
  return arr;
}

export const convertDates = (epoch: number | null) => {
  const date = epoch ? new Date(epoch * 1000): new Date();
  return date.toLocaleDateString('en-GB', {year: 'numeric', month: 'numeric', day: 'numeric'});
}

export const convertDatesWithTime = (epoch: number | null) => {
  const date = epoch ? new Date(epoch * 1000): new Date();
  return date.toLocaleDateString('en-GB', {hour: 'numeric', minute: 'numeric', year: 'numeric', month: 'numeric', day: 'numeric'});
}

export const roundNumber = (val: number) => {
  return val.toFixed(2);
}