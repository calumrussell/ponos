package entity;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class Team {
    @Id
    public Integer id;
    public String name;
}
