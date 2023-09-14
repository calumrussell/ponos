package entity;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import match.MatchWrapper;
import org.jooq.generated.tables.records.PlayerStatsRecord;

public class PlayerStatsBuilder {
    static public PlayerStatsRecord build(Integer playerId, Integer teamId, MatchWrapper matchWrapper) {
        PlayerStatsRecord ps = new PlayerStatsRecord();
        ps.setPlayerId(playerId);
        ps.setTeamId(teamId);
        ps.setMatchId(matchWrapper.getMatchId());
        //This needs to fail on missing values as it will indicate an error somewhere in the code
        ps.setMinutes(matchWrapper.playerMinutes.get(playerId).shortValue());
        //This can return zero if the player was a substitute but we need to record that they played the game
        ps.setPass(matchWrapper.passMap.getOrDefault(playerId, 0).shortValue());
        ps.setShot(matchWrapper.shotMap.getOrDefault(playerId, 0).shortValue());
        ps.setShotOnTarget(matchWrapper.shotOnTargetMap.getOrDefault(playerId, 0).shortValue());
        ps.setShotOffTarget(matchWrapper.shotOffTargetMap.getOrDefault(playerId, 0).shortValue());
        ps.setPassKey(matchWrapper.passKeyMap.getOrDefault(playerId, 0).shortValue());
        ps.setDispossessed(matchWrapper.dispossessedMap.getOrDefault(playerId, 0).shortValue());
        ps.setGoal(matchWrapper.goalMap.getOrDefault(playerId, 0).shortValue());
        ps.setAerialDuel(matchWrapper.aerialDuelMap.getOrDefault(playerId, 0).shortValue());
        ps.setAssist(matchWrapper.assistMap.getOrDefault(playerId, 0).shortValue());
        ps.setRedCard(matchWrapper.redCardMap.getOrDefault(playerId, 0).shortValue());
        ps.setYellowCard(matchWrapper.yellowCardMap.getOrDefault(playerId, 0).shortValue());
        ps.setSave(matchWrapper.saveMap.getOrDefault(playerId, 0).shortValue());
        ps.setPassCross(matchWrapper.passCrossMap.getOrDefault(playerId, 0).shortValue());
        ps.setDuel(matchWrapper.duelMap.getOrDefault(playerId, 0).shortValue());
        return ps;
    }
}