import prisma from '@/lib/prisma';
import { Matches } from '@/lib/components';

async function getRecentMatches() {
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
  return matches;
}

export default async function Home() {
  const matches = await getRecentMatches();
  return (
    <main>
      <Matches matches={matches} />
    </main>
  )
}
