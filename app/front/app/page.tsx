import { GroupedMatches, Matches } from '@/lib/components';
import { getRecentMatches } from '@/lib/functions';
import { match_full } from '@prisma/client';

export default async function Home() {
  const matches = await getRecentMatches();

  const filterFunc = (tourn: string) => (match: match_full) => {
    return match.tournament === tourn;
  }

  const eplMatches = matches.filter(filterFunc('EPL'))
  const bunMatches = matches.filter(filterFunc('BUN'))
  const itaMatches = matches.filter(filterFunc('ITA'))
  const ligaMatches = matches.filter(filterFunc('LIGA'))

  return (
    <main>
      <section>
        <h2>EPL</h2>
        <GroupedMatches matches={eplMatches} />
      </section>
      <section>
        <h2>BUN</h2>
        <GroupedMatches matches={bunMatches} />
      </section>
      <section>
        <h2>LIGA</h2>
        <GroupedMatches matches={ligaMatches} />
      </section>
     <section>
        <h2>ITA</h2>
        <GroupedMatches matches={itaMatches} />
      </section>

    </main>
  )
}
