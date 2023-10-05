package entity;

import java.io.Serializable;

public class TeamStatsId implements Serializable {
    public Integer teamId;
    public Integer matchId;

    @Override
    public boolean equals(Object obj) {
        if (obj == this) return true;
        if (!(obj instanceof TeamStatsId)) return false;
        TeamStatsId id = (TeamStatsId) obj;
        return id.teamId.equals(this.teamId) && id.matchId.equals(matchId);
    }

}
