package match;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Match {
    @Id
    public Integer id;
    public Integer homeId;
    public Integer awayId;

    public String toJSON() throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(this);
    }

    public Match() {}

    public Match(MatchFacade matchFacade) {
        this.id = matchFacade.getMatchId();
        this.homeId = matchFacade.getHomeId();
        this.awayId = matchFacade.getAwayId();
    }
}
