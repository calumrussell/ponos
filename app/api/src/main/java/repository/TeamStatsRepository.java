package repository;

import entity.TeamStats;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TeamStatsRepository extends JpaRepository<TeamStats, Integer> {
    List<TeamStats> findByMatchId(Integer matchId);
    List<TeamStats> findByTeamId(Integer teamId);
}
