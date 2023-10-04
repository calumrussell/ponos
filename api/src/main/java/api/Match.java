package api;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Match {
    @Id
    private Integer id;
    private Integer homeId;
    private Integer awayId;
    private Integer startDate;
    private boolean broken;

    public Integer getId() {
        return id;
    }
}