package entity;

import org.springframework.beans.factory.annotation.Autowired;
import repository.*;

import java.util.List;

public class StatsDto {
    public List<PlayerStats> playerStats;
    public List<TeamStats> teamStats;
    public List<Player> players;
    public List<Team> teams;
    public List<Match> matches;

}
