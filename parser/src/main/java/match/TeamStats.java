package match;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.*;

import java.util.HashMap;
import java.util.Set;

@Entity
public class TeamStats {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "team_stats_id_seq")
    @SequenceGenerator(name = "team_stats_id_seq", sequenceName = "team_stats_id_seq", allocationSize = 1)
    public Integer id;
    public Integer teamId;
    public Integer matchId;
    public Integer passes;

    public String toJSON() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(this);
    }

    public TeamStats() {}

    public TeamStats(Integer teamId, Integer matchId, Integer passes) {
        this.teamId = teamId;
        this.matchId = matchId;
        this.passes = passes;
    }

    public TeamStats(Integer teamId, MatchFacade matchFacade) {
        this.teamId = teamId;
        this.matchId = matchFacade.getMatchId();
        Set<Integer> players = matchFacade.getPlayers(teamId);
        HashMap<Integer, Integer> passMap = matchFacade.getPassMap();
        this.passes = 0;
        for (Integer player: players) {
            //This can return zero, and we need stats for all players regardless of whether they passed the ball
            passes += passMap.getOrDefault(player, 0);
        }
    }
}
