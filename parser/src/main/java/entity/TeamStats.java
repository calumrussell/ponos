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
    public short shot0bp;
    public short goal;
    public short goalNormal;
    public short goalHead;
    public short goalFoot;
    public short goalSetPiece;
    public short goalOwn;
    public short goalCounter;
    public short goalOpenPlay;
    public short goal0bp;
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

    public TeamStats(Integer teamId, MatchWrapper matchWrapper) {
        this.teamId = teamId;
        this.matchId = matchWrapper.getMatchId();
        this.isHome = matchWrapper.getHomeId().equals(teamId);

        Set<Integer> players = matchWrapper.getPlayers(teamId);
        this.pass = 0;
        this.passCorner = 0;
        this.passLongball = 0;
        this.passCross = 0;
        this.passBack = 0;
        this.passForward = 0;
        this.passLeft = 0;
        this.passRight = 0;
        this.passShort = 0;
        this.passThroughball = 0;
        this.passAccurate = 0;
        this.passShortAccurate = 0;
        this.passCornerAccurate = 0;
        this.passLongballAccurate = 0;
        this.passCrossAccurate = 0;
        this.passThroughballAccurate = 0;
        this.passKey = 0;
        this.passKeyCross = 0;
        this.passKeyFreekick = 0;
        this.passKeyCorner = 0;
        this.passKeyThroughball = 0;
        this.shot = 0;
        this.shotOnTarget = 0;
        this.shotOffTarget = 0;
        this.shotBlocked = 0;
        this.shotOpenPlay = 0;
        this.shotSetPiece = 0;
        this.shotOnPost = 0;
        this.shotSixYardBox = 0;
        this.shotPenaltyArea = 0;
        this.shotBox = 0;
        this.shotCounter = 0;
        this.shotHead = 0;
        this.shotFoot = 0;
        this.shot0bp = 0;
        this.goal = 0;
        this.goalNormal = 0;
        this.goalHead = 0;
        this.goalFoot = 0;
        this.goalSetPiece = 0;
        this.goalOwn = 0;
        this.goalCounter = 0;
        this.goalOpenPlay = 0;
        this.goal0bp = 0;
        this.goal0box = 0;
        this.goalSixYardBox = 0;
        this.goalPenaltyArea = 0;
        this.assist = 0;
        this.assistCross = 0;
        this.assistCorner = 0;
        this.assistThroughball = 0;
        this.aerialDuel = 0;
        this.redCard = 0;
        this.yellowCard = 0;
        this.secondYellowCard = 0;
        this.save = 0;
        this.duel = 0;
        this.duelOffensive = 0;
        this.duelDefensive = 0;
        this.dispossessed = 0;
        this.turnover = 0;
        this.dribble = 0;
        this.dribbleWon = 0;
        this.dribbleLost = 0;
        this.dribbleLastMan = 0;
        this.challengeLost = 0;
        this.blockedCross = 0;
        this.blockOutfielder = 0;
        this.blockSixYard = 0;
        this.blockPassOutfielder = 0;
        this.interception = 0;
        this.interceptionWon = 0;
        this.interceptionInBox = 0;
        this.tackle = 0;
        this.tackleWon = 0;
        this.tackleLost = 0;
        this.tackleLastMan = 0;
        this.offsideGiven = 0;
        this.offsideProvoked = 0;
        this.ballRecovery = 0;
        this.clearance = 0;
        this.clearanceEffective = 0;
        this.clearanceOffLine = 0;
        this.errorLeadsToGoal = 0;
        this.errorLeadsToShot = 0;
        this.touch = 0;
        this.penaltyWon = 0;
        this.penaltyConceded = 0;
        this.penaltyScored = 0;
        this.bigChanceMissed = 0;
        this.bigChanceScored = 0;
        this.bigChanceCreated = 0;
        this.parriedSafe = 0;
        this.parriedDanger = 0;
        this.saveKeeper = 0;

        for (Integer player: players) {
            //This can return zero, and we need stats for all players regardless of whether they passed the ball
            pass += matchWrapper.passMap.getOrDefault(player, 0).shortValue();
            passCorner += matchWrapper.passCornerMap.getOrDefault(player, 0).shortValue();
            passLongball += matchWrapper.passLongballMap.getOrDefault(player, 0).shortValue();
            passCross += matchWrapper.passCrossMap.getOrDefault(player, 0).shortValue();
            passBack += matchWrapper.passBackMap.getOrDefault(player, 0).shortValue();
            passForward += matchWrapper.passForwardMap.getOrDefault(player, 0).shortValue();
            passLeft += matchWrapper.passLeftMap.getOrDefault(player, 0).shortValue();
            passRight += matchWrapper.passRightMap.getOrDefault(player, 0).shortValue();
            passShort += matchWrapper.passShortMap.getOrDefault(player, 0).shortValue();
            passThroughball += matchWrapper.passThroughballMap.getOrDefault(player, 0).shortValue();
            passAccurate += matchWrapper.passAccurateMap.getOrDefault(player, 0).shortValue();
            passShortAccurate += matchWrapper.passShortAccurateMap.getOrDefault(player, 0).shortValue();
            passCornerAccurate += matchWrapper.passCornerAccurateMap.getOrDefault(player, 0).shortValue();
            passLongballAccurate += matchWrapper.passLongballAccurateMap.getOrDefault(player, 0).shortValue();
            passCrossAccurate += matchWrapper.passCrossAccurateMap.getOrDefault(player, 0).shortValue();
            passThroughballAccurate += matchWrapper.passThroughballAccurateMap.getOrDefault(player, 0).shortValue();
            passKey += matchWrapper.passKeyMap.getOrDefault(player, 0).shortValue();
            passKeyCross += matchWrapper.passKeyCrossMap.getOrDefault(player, 0).shortValue();
            passKeyFreekick += matchWrapper.passKeyFreekickMap.getOrDefault(player, 0).shortValue();
            passKeyCorner += matchWrapper.passKeyCornerMap.getOrDefault(player, 0).shortValue();
            passKeyThroughball += matchWrapper.passKeyThroughballMap.getOrDefault(player, 0).shortValue();
            shot += matchWrapper.shotMap.getOrDefault(player, 0).shortValue();
            shotOnTarget += matchWrapper.shotOnTargetMap.getOrDefault(player, 0).shortValue();
            shotOffTarget += matchWrapper.shotOffTargetMap.getOrDefault(player, 0).shortValue();
            shotBlocked += matchWrapper.shotBlockedMap.getOrDefault(player, 0).shortValue();
            shotOpenPlay += matchWrapper.shotOpenPlayMap.getOrDefault(player, 0).shortValue();
            shotSetPiece += matchWrapper.shotSetPieceMap.getOrDefault(player, 0).shortValue();
            shotOnPost += matchWrapper.shotOnPostMap.getOrDefault(player, 0).shortValue();
            shotSixYardBox += matchWrapper.shotSixYardBoxMap.getOrDefault(player, 0).shortValue();
            shotPenaltyArea += matchWrapper.shotPenaltyAreaMap.getOrDefault(player, 0).shortValue();
            shotBox += matchWrapper.shotBoxMap.getOrDefault(player, 0).shortValue();
            shotCounter += matchWrapper.shotCounterMap.getOrDefault(player, 0).shortValue();
            shotHead += matchWrapper.shotHeadMap.getOrDefault(player, 0).shortValue();
            shotFoot += matchWrapper.shotFootMap.getOrDefault(player, 0).shortValue();
            shot0bp += matchWrapper.shot0bpMap.getOrDefault(player, 0).shortValue();
            goal += matchWrapper.goalMap.getOrDefault(player, 0).shortValue();
            goalNormal += matchWrapper.goalNormalMap.getOrDefault(player, 0).shortValue();
            goalHead += matchWrapper.goalHeadMap.getOrDefault(player, 0).shortValue();
            goalFoot += matchWrapper.goalFootMap.getOrDefault(player, 0).shortValue();
            goalSetPiece += matchWrapper.goalSetPieceMap.getOrDefault(player, 0).shortValue();
            goalOwn += matchWrapper.goalOwnMap.getOrDefault(player, 0).shortValue();
            goalCounter += matchWrapper.goalCounterMap.getOrDefault(player, 0).shortValue();
            goalOpenPlay += matchWrapper.goalOpenPlayMap.getOrDefault(player, 0).shortValue();
            goal0bp += matchWrapper.goal0bpMap.getOrDefault(player, 0).shortValue();
            goal0box += matchWrapper.goal0boxMap.getOrDefault(player, 0).shortValue();
            goalSixYardBox += matchWrapper.goalSixYardBoxMap.getOrDefault(player, 0).shortValue();
            goalPenaltyArea += matchWrapper.goalPenaltyAreaMap.getOrDefault(player, 0).shortValue();
            assist += matchWrapper.assistMap.getOrDefault(player, 0).shortValue();
            assistCross += matchWrapper.assistCrossMap.getOrDefault(player, 0).shortValue();
            assistCorner += matchWrapper.assistCornerMap.getOrDefault(player, 0).shortValue();
            assistThroughball += matchWrapper.assistThroughballMap.getOrDefault(player, 0).shortValue();
            aerialDuel += matchWrapper.aerialDuelMap.getOrDefault(player, 0).shortValue();
            redCard += matchWrapper.redCardMap.getOrDefault(player, 0).shortValue();
            yellowCard += matchWrapper.yellowCardMap.getOrDefault(player, 0).shortValue();
            secondYellowCard += matchWrapper.secondYellowCardMap.getOrDefault(player, 0).shortValue();
            save += matchWrapper.saveMap.getOrDefault(player, 0).shortValue();
            duel += matchWrapper.duelMap.getOrDefault(player, 0).shortValue();
            duelOffensive += matchWrapper.duelOffensiveMap.getOrDefault(player, 0).shortValue();
            duelDefensive += matchWrapper.duelDefensiveMap.getOrDefault(player, 0).shortValue();
            dispossessed += matchWrapper.dispossessedMap.getOrDefault(player, 0).shortValue();
            turnover += matchWrapper.turnoverMap.getOrDefault(player, 0).shortValue();
            dribble += matchWrapper.dribbleMap.getOrDefault(player, 0).shortValue();
            dribbleWon += matchWrapper.dribbleWonMap.getOrDefault(player, 0).shortValue();
            dribbleLost += matchWrapper.dribbleLostMap.getOrDefault(player, 0).shortValue();
            dribbleLastMan += matchWrapper.dribbleLastManMap.getOrDefault(player, 0).shortValue();
            challengeLost += matchWrapper.challengeLostMap.getOrDefault(player, 0).shortValue();
            blockedCross += matchWrapper.blockedCrossMap.getOrDefault(player, 0).shortValue();
            blockOutfielder += matchWrapper.blockOutfielderMap.getOrDefault(player, 0).shortValue();
            blockSixYard += matchWrapper.blockSixYardMap.getOrDefault(player, 0).shortValue();
            blockPassOutfielder += matchWrapper.blockPassOutfielderMap.getOrDefault(player, 0).shortValue();
            interception += matchWrapper.interceptionMap.getOrDefault(player, 0).shortValue();
            interceptionWon += matchWrapper.interceptionWonMap.getOrDefault(player, 0).shortValue();
            interceptionInBox += matchWrapper.interceptionInBoxMap.getOrDefault(player, 0).shortValue();
            tackle += matchWrapper.tackleMap.getOrDefault(player, 0).shortValue();
            tackleWon += matchWrapper.tackleWonMap.getOrDefault(player, 0).shortValue();
            tackleLost += matchWrapper.tackleLostMap.getOrDefault(player, 0).shortValue();
            tackleLastMan += matchWrapper.tackleLastManMap.getOrDefault(player, 0).shortValue();
            offsideGiven += matchWrapper.offsideGivenMap.getOrDefault(player, 0).shortValue();
            offsideProvoked += matchWrapper.offsideProvokedMap.getOrDefault(player, 0).shortValue();
            ballRecovery += matchWrapper.ballRecoveryMap.getOrDefault(player, 0).shortValue();
            clearance += matchWrapper.clearanceMap.getOrDefault(player, 0).shortValue();
            clearanceEffective += matchWrapper.clearanceEffectiveMap.getOrDefault(player, 0).shortValue();
            clearanceOffLine += matchWrapper.clearanceOffLineMap.getOrDefault(player, 0).shortValue();
            errorLeadsToGoal += matchWrapper.errorLeadsToGoalMap.getOrDefault(player, 0).shortValue();
            errorLeadsToShot += matchWrapper.errorLeadsToShotMap.getOrDefault(player, 0).shortValue();
            touch += matchWrapper.touchMap.getOrDefault(player, 0).shortValue();
            penaltyWon += matchWrapper.penaltyWonMap.getOrDefault(player, 0).shortValue();
            penaltyConceded += matchWrapper.penaltyConcededMap.getOrDefault(player, 0).shortValue();
            penaltyScored += matchWrapper.penaltyScoredMap.getOrDefault(player, 0).shortValue();
            bigChanceMissed += matchWrapper.bigChanceMissedMap.getOrDefault(player, 0).shortValue();
            bigChanceScored += matchWrapper.bigChanceScoredMap.getOrDefault(player, 0).shortValue();
            bigChanceCreated += matchWrapper.bigChanceCreatedMap.getOrDefault(player, 0).shortValue();
            parriedSafe += matchWrapper.parriedSafeMap.getOrDefault(player, 0).shortValue();
            parriedDanger += matchWrapper.parriedDangerMap.getOrDefault(player, 0).shortValue();
            saveKeeper += matchWrapper.saveKeeperMap.getOrDefault(player, 0).shortValue();
        }
    }
}
