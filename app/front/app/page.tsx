import { Matches } from '@/lib/components';
import { getRecentMatches } from '@/lib/functions';

export default async function Home() {
  const matches = await getRecentMatches();
  return (
    <main>
      <Matches matches={matches} />
    </main>
  )
}
