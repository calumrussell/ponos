package entity;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import match.MatchWrapper;

import java.util.Set;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class TeamStats {
    public Integer teamId;
    public Integer matchId;
    public boolean isHome;
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
    public TeamStats(Integer teamId, MatchWrapper matchWrapper) {
        this.teamId = teamId;
        this.matchId = matchWrapper.getMatchId();
        this.isHome = matchWrapper.getHomeId().equals(teamId);

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

        this.pass = pass;
        this.shot = shot;
        this.shotOnTarget = shotOnTarget;
        this.shotOffTarget = shotOffTarget;
        this.passKey = passKey;
        this.dispossessed = dispossessed;
        this.goal = goal;
        this.aerialDuel = aerialDuel;
        this.assist = assist;
        this.redCard = redCard;
        this.yellowCard = yellowCard;
        this.save = save;
        this.passCross = passCross;
        this.duel = duel;
    }
}
