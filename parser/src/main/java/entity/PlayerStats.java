package entity;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import match.MatchWrapper;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class PlayerStats {
    public Integer playerId;
    public Integer teamId;
    public Integer matchId;
    public short minutes;
    public short pass;
    public short shot;
    public short shotOnTarget;
    public short shotOffTarget;
    public short passKey;
    public short dispossessed;
    public short goal;
    public short aerialDuel;
    public short assist;
    public short redCard;
    public short yellowCard;
    public short save;
    public short passCross;
    public short duel;

    public PlayerStats(Integer playerId, Integer teamId, MatchWrapper matchWrapper) {
        this.playerId = playerId;
        this.teamId = teamId;
        this.matchId = matchWrapper.getMatchId();;
        //This needs to fail on missing values as it will indicate an error somewhere in the code
        this.minutes = matchWrapper.playerMinutes.get(playerId).shortValue();
        //This can return zero if the player was a substitute but we need to record that they played the game
        this.pass = matchWrapper.passMap.getOrDefault(playerId, 0).shortValue();
        this.shot = matchWrapper.shotMap.getOrDefault(playerId, 0).shortValue();
        this.shotOnTarget = matchWrapper.shotOnTargetMap.getOrDefault(playerId, 0).shortValue();
        this.shotOffTarget = matchWrapper.shotOffTargetMap.getOrDefault(playerId, 0).shortValue();
        this.passKey = matchWrapper.passKeyMap.getOrDefault(playerId, 0).shortValue();
        this.dispossessed = matchWrapper.dispossessedMap.getOrDefault(playerId, 0).shortValue();
        this.goal = matchWrapper.goalMap.getOrDefault(playerId, 0).shortValue();
        this.aerialDuel = matchWrapper.aerialDuelMap.getOrDefault(playerId, 0).shortValue();
        this.assist = matchWrapper.assistMap.getOrDefault(playerId, 0).shortValue();
        this.redCard = matchWrapper.redCardMap.getOrDefault(playerId, 0).shortValue();
        this.yellowCard = matchWrapper.yellowCardMap.getOrDefault(playerId, 0).shortValue();
        this.save = matchWrapper.saveMap.getOrDefault(playerId, 0).shortValue();
        this.passCross = matchWrapper.passCrossMap.getOrDefault(playerId, 0).shortValue();
        this.duel = matchWrapper.duelMap.getOrDefault(playerId, 0).shortValue();
    }
}
