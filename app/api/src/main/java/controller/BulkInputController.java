package controller;

import entity.StatsDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import repository.*;

@RestController
public class BulkInputController {

    @Autowired
    PlayerStatsRepository playerStatsRepository;

    @Autowired
    TeamStatsRepository teamStatsRepository;

    @Autowired
    PlayerRepository playerRepository;

    @Autowired
    TeamRepository teamRepository;

    @Autowired
    MatchRepository matchRepository;

    @PostMapping(path = "/bulk_input", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void bulkInsert(@RequestBody StatsDto statsDto) {
        matchRepository.saveAll(statsDto.matches);
        matchRepository.flush();
        playerStatsRepository.saveAll(statsDto.playerStats);
        playerStatsRepository.flush();
        teamStatsRepository.saveAll(statsDto.teamStats);
        teamStatsRepository.flush();
        playerRepository.saveAll(statsDto.players);
        playerRepository.flush();
        teamRepository.saveAll(statsDto.teams);
        teamRepository.flush();
    }
}
