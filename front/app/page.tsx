import prisma from '@/lib/prisma';
import { Match } from '@/lib/components';

async function getRecentMatches() {
  let epoch = Date.now() / 1000;
  const matches = await prisma.match.findMany({
    where: {
      start_date : {
        gt: epoch - (86400 * 14),
        lt: epoch - (86400 * 2),
      }
    }
  })
  return matches;
}

export default async function Home() {
  const matches = await getRecentMatches();
  return (
    <main>
      {
        matches.map((match) => {
          return <Match key={match.id} {...match} />;
        })
      }
    </main>
  )
}
