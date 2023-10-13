package entity;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import jakarta.persistence.*;

@Entity
@IdClass(TeamStatsId.class)
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class TeamStats {
    @Id
    public Integer teamId;
    @Id
    public Integer matchId;
    public Integer oppId;
    public boolean isHome;
    public short pass;
    public short passCorner;
    public short passLongball;
    public short passCross;
    public short passBack;
    public short passForward;
    public short passLeft;
    public short passRight;
    public short passShort;
    public short passThroughball;
    public short passAccurate;
    public short passShortAccurate;
    public short passCornerAccurate;
    public short passLongballAccurate;
    public short passCrossAccurate;
    public short passThroughballAccurate;
    public short passKey;
    public short passKeyCross;
    public short passKeyFreekick;
    public short passKeyCorner;
    public short passKeyThroughball;
    public short shot;
    public short shotOnTarget;
    public short shotOffTarget;
    public short shotBlocked;
    public short shotOpenPlay;
    public short shotSetPiece;
    public short shotOnPost;
    public short shotSixYardBox;
    public short shotPenaltyArea;
    public short shotBox;
    public short shotCounter;
    public short shotHead;
    public short shotFoot;
    @Column(name = "shot_0bp")
    public short shot0bp;
    public short goal;
    public short goalNormal;
    public short goalHead;
    public short goalFoot;
    public short goalSetPiece;
    public short goalOwn;
    public short goalCounter;
    public short goalOpenPlay;
    @Column(name = "goal_0bp")
    public short goal0bp;
    @Column(name = "goal_0box")
    public short goal0box;
    public short goalSixYardBox;
    public short goalPenaltyArea;
    public short assist;
    public short assistCross;
    public short assistCorner;
    public short assistThroughball;
    public short aerialDuel;
    public short redCard;
    public short yellowCard;
    public short secondYellowCard;
    public short save;
    public short duel;
    public short duelOffensive;
    public short duelDefensive;
    public short dispossessed;
    public short turnover;
    public short dribble;
    public short dribbleWon;
    public short dribbleLost;
    public short dribbleLastMan;
    public short challengeLost;
    public short blockedCross;
    public short blockOutfielder;
    public short blockSixYard;
    public short blockPassOutfielder;
    public short interception;
    public short interceptionWon;
    public short interceptionInBox;
    public short tackle;
    public short tackleWon;
    public short tackleLost;
    public short tackleLastMan;
    public short offsideGiven;
    public short offsideProvoked;
    public short ballRecovery;
    public short clearance;
    public short clearanceEffective;
    public short clearanceOffLine;
    public short errorLeadsToGoal;
    public short errorLeadsToShot;
    public short touch;
    public short penaltyWon;
    public short penaltyConceded;
    public short penaltyScored;
    public short bigChanceMissed;
    public short bigChanceScored;
    public short bigChanceCreated;
    public short parriedSafe;
    public short parriedDanger;
    public short saveKeeper;

    public Integer getMatchId() {
        return matchId;
    }

    public Integer getTeamId() {
        return teamId;
    }
}
