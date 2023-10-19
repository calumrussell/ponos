package entity;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Match {
    @Id
    public Integer id;
    public Integer homeId;
    public Integer awayId;
    public Integer startDate;
    public boolean broken;
    public Integer seasonId;
    public Integer tournamentId;
    public Integer year;

    public Integer getId() {
        return id;
    }

    public Integer getAwayId() {
        return awayId;
    }

    public Integer getHomeId() {
        return homeId;
    }

    public Integer getStartDate() {
        return startDate;
    }
}