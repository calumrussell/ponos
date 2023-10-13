package repository;

import entity.PlayerStats;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PlayerStatsRepository extends JpaRepository<PlayerStats, Integer> {
    List<PlayerStats> findByMatchId(Integer match);
    List<PlayerStats> findByTeamId(Integer teamId);
    List<PlayerStats> findByPlayerId(Integer playerId);
}
