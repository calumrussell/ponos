package controller;

import entity.Match;
import entity.PlayerStats;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import repository.MatchRepository;

import java.util.List;
import java.util.Optional;

@RestController
public class MatchController {
    @Autowired
    MatchRepository matchRepository;

    @GetMapping("/match/all")
    public Iterable<Match> matchAll() {
        return matchRepository.findAll();
    }

    @GetMapping("/match/id/{id}")
    public Optional<Match> matchByMatch(@PathVariable Integer id) {
        return matchRepository.findById(id);
    }

    @GetMapping("/match/team/{id}")
    public List<Match> matchByTeam(@PathVariable Integer id) {
        return matchRepository.findByHomeIdOrAwayId(id, id);
    }

    @GetMapping("/match/after/{date}")
    public List<Match> matchStartDateAfter(@PathVariable Integer date) {
        return matchRepository.findByStartDateGreaterThan(date);
    }

    @GetMapping("/match/before/{date}")
    public List<Match> matchStartDateBefore(@PathVariable Integer date) {
        return matchRepository.findByStartDateLessThan(date);
    }

    @PostMapping(path = "/match", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void matchInsert(@RequestBody Match match) {
        matchRepository.save(match);
        matchRepository.flush();
    }
}
