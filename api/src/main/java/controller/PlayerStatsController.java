package controller;

import entity.PlayerStats;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import repository.PlayerStatsRepository;

@RestController
public class PlayerStatsController {

    @Autowired
    PlayerStatsRepository playerStatsRepository;

    @GetMapping("/player_stats/match/{id}")
    public Iterable<PlayerStats> playerStatsByMatch(@PathVariable Integer id) {
        return playerStatsRepository.findByMatchId(id);
    }

    @GetMapping("/player_stats/team/{id}")
    public Iterable<PlayerStats> playerStatsByTeam(@PathVariable Integer id) {
        return playerStatsRepository.findByTeamId(id);
    }

    @GetMapping("/player_stats/player/{id}")
    public Iterable<PlayerStats> playerStatsByPlayer(@PathVariable Integer id) {
        return playerStatsRepository.findByPlayerId(id);
    }

    @PostMapping(path = "/player_stats", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void playerStatsInsert(@RequestBody PlayerStats playerStats) {
        playerStatsRepository.save(playerStats);
    }
}
