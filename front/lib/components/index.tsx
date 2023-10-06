import React from "react";
import Link from "next/link";

export const Match = ({id, home_id, away_id, start_date, broken} : { id: number, home_id: number, away_id: number, start_date: number, broken: boolean | null }) => {
  return (
    <div>
      <span><Link href={`/match/${id}`}>{id}</Link></span>
      <span>{home_id}</span>
      <span>{away_id}</span>
    </div>
  )
}