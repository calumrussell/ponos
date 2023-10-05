package entity;

import java.io.Serializable;

public class PlayerStatsId implements Serializable {
    public Integer playerId;
    public Integer matchId;

    @Override
    public boolean equals(Object obj) {
        if (obj == this) return true;
        if (!(obj instanceof PlayerStatsId)) return false;
        PlayerStatsId id = (PlayerStatsId) obj;
        return id.playerId.equals(this.playerId) && id.matchId.equals(matchId);
    }

}
