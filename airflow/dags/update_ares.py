from datetime import datetime, timedelta

from airflow import DAG
from airflow.decorators import task
      
with DAG(
    "update_ares",
    start_date=datetime(2021, 1, 1),
    schedule=timedelta(days=1),
    catchup=False,
) as dag:

    @task.virtualenv(task_id="update_ares", requirements=["scikit-learn==1.3.2"])
    def update_ares():
        from ares.elo_impl import EloImpl, DefaultEloModel
        from airflow.providers.postgres.hooks.postgres import PostgresHook

        hook = PostgresHook(postgres_conn_id="ponos")
        sql_query = """
            select 
            match.start_date,
            match.home_id,
            match.away_id,
            home.goal as home_goal,
            away.goal as away_goal
            from match
            left join team_stats_full as home
                on home.team_id=match.home_id and home.match_id=match.id
            left join team_stats_full as away
                on away.team_id=match.away_id and away.match_id=match.id
            order by match.start_date asc"""
        rows = hook.get_records(sql_query)
        model = DefaultEloModel()
        elo = EloImpl(model)
        for row in rows:
            if row[1] == -1 or row[2] == -1 or row[3] == None or row[4] == None:
                continue
            elo.update(row[1], row[2], row[3], row[4], row[0])
        ratings = elo.rating_record

        query = "insert into elo_ratings(team_id, rating, date) VALUES "
        values = []
        for rating in ratings:
            values.append(f"({rating.team_id}, {rating.rating}, {rating.date})")
        query += ",".join(values)
        query += " on conflict do nothing;"
        conn = hook.get_conn()
        cur = conn.cursor();
        cur.execute(sql_query)
        conn.commit()
        return

    update_ares()
