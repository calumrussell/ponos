package controller;

import entity.MatchesDto;
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

    @PostMapping(path = "/bulk_matches", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void bulkMatches(@RequestBody MatchesDto matchesDto) {
        matchRepository.saveAll(matchesDto.matches);
        matchRepository.flush();
    }

    @PostMapping(path = "/bulk_input", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void bulkInsert(@RequestBody StatsDto statsDto) {
        //Bulk insert should never touch matches
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
