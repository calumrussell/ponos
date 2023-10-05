package repository;

import entity.TeamStats;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TeamStatsRepository extends CrudRepository<TeamStats, Integer> {
    List<TeamStats> findByMatchId(Integer matchId);
    List<TeamStats> findByTeamId(Integer teamId);
}
