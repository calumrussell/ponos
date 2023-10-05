package controller;

import entity.TeamStats;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import repository.TeamStatsRepository;

@RestController
public class TeamStatsController {
    @Autowired
    TeamStatsRepository teamStatsRepository;

    @GetMapping("/team_stats/match/{id}")
    public Iterable<TeamStats> teamStatsByMatch(@PathVariable Integer id) {
        return teamStatsRepository.findByMatchId(id);
    }

    @GetMapping("/team_stats/team/{id}")
    public Iterable<TeamStats> teamStatsByTeam(@PathVariable Integer id) {
        return teamStatsRepository.findByTeamId(id);
    }
}
