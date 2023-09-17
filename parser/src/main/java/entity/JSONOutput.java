package entity;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import match.MatchWrapper;

import java.util.Vector;

public class JSONOutput {

    public Vector<Match> matches;
    public Vector<Team> teams;
    public Vector<Player> players;
    public Vector<PlayerStats> playerStats;
    public Vector<TeamStats> teamStats;

    public JSONOutput(){
        this.matches = new Vector<>();
        this.teams = new Vector<>();
        this.players = new Vector<>();
        this.playerStats = new Vector<>();
        this.teamStats = new Vector<>();
    }

    void addMatch(Match match) {
        matches.add(match);
    }

    void addTeam(Team team) {
        teams.add(team);
    }

    void addPlayer(Player player) {
        players.add(player);
    }

    void addPlayerStats(PlayerStats playerStats) {
        this.playerStats.add(playerStats);
    }

    void addTeamStats(TeamStats teamStats) {
        this.teamStats.add(teamStats);
    }

    public void addMatchWrapper(MatchWrapper match){
        addMatch(match.toMatchOutput());
        match.toTeamOutput().stream().forEach(team -> addTeam(team));
        match.toPlayerOutput().stream().forEach(player -> addPlayer(player));
        match.toPlayerStatsOutput().stream().forEach(playerStats -> addPlayerStats(playerStats));
        addTeamStats(match.toHomeTeamStatsOutput());
        addTeamStats(match.toAwayTeamStatsOutput());
    }

    public String toJSON() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(this);
    }

}
