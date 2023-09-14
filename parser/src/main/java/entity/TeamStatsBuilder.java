package entity;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import match.MatchWrapper;
import org.jooq.generated.tables.records.TeamStatsRecord;

import java.util.Set;

public class TeamStatsBuilder {
    static public TeamStatsRecord build(Integer teamId, MatchWrapper matchWrapper) {
        TeamStatsRecord ts = new TeamStatsRecord();
        ts.setTeamId(teamId);
        ts.setMatchId(matchWrapper.getMatchId());
        ts.setIsHome(matchWrapper.getHomeId().equals(teamId));
        Set<Integer> players = matchWrapper.getPlayers(teamId);
        short pass = 0;
        short shot = 0;
        short shotOnTarget = 0;
        short shotOffTarget = 0;
        short passKey = 0;
        short dispossessed = 0;
        short goal = 0;
        short aerialDuel = 0;
        short assist = 0;
        short redCard = 0;
        short yellowCard = 0;
        short save = 0;
        short passCross = 0;
        short duel = 0;

        for (Integer player: players) {
            //This can return zero, and we need stats for all players regardless of whether they passed the ball
            pass += matchWrapper.passMap.getOrDefault(player, 0);
            shot += matchWrapper.shotMap.getOrDefault(player, 0);
            shotOnTarget += matchWrapper.shotOnTargetMap.getOrDefault(player, 0);
            shotOffTarget += matchWrapper.shotOffTargetMap.getOrDefault(player, 0);
            passKey += matchWrapper.passKeyMap.getOrDefault(player, 0);
            dispossessed += matchWrapper.dispossessedMap.getOrDefault(player, 0);
            goal += matchWrapper.goalMap.getOrDefault(player, 0);
            aerialDuel += matchWrapper.aerialDuelMap.getOrDefault(player, 0);
            assist += matchWrapper.assistMap.getOrDefault(player, 0);
            redCard += matchWrapper.redCardMap.getOrDefault(player, 0);
            yellowCard += matchWrapper.yellowCardMap.getOrDefault(player, 0);
            save += matchWrapper.saveMap.getOrDefault(player, 0);
            passCross += matchWrapper.passCrossMap.getOrDefault(player, 0);
            duel += matchWrapper.duelMap.getOrDefault(player, 0);
        }

        ts.setPass(pass);
        ts.setShot(shot);
        ts.setShotOnTarget(shotOnTarget);
        ts.setShotOffTarget(shotOffTarget);
        ts.setPassKey(passKey);
        ts.setDispossessed(dispossessed);
        ts.setGoal(goal);
        ts.setAerialDuel(aerialDuel);
        ts.setAssist(assist);
        ts.setRedCard(redCard);
        ts.setYellowCard(yellowCard);
        ts.setSave(save);
        ts.setPassCross(passCross);
        ts.setDuel(duel);
        return ts;
    }
}
