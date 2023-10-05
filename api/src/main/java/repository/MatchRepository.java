package repository;

import entity.Match;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MatchRepository extends JpaRepository<Match, Integer> {
    List<Match> findByHomeIdOrAwayId(Integer teamId, Integer teamId1);
    List<Match> findByStartDateGreaterThan(Integer date);
    List<Match> findByStartDateLessThan(Integer date);
}