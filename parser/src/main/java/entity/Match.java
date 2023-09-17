package entity;


import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Match {
    public Integer id;
    public Integer startDate;
    public Integer homeId;
    public Integer awayId;

    public Match(Integer id, Integer startDate, Integer homeId, Integer awayId) {
        this.id = id;
        this.startDate = startDate;
        this.homeId = homeId;
        this.awayId = awayId;
    }
}
