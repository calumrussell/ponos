package match;


import entity.*;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.*;

public class MatchWrapper {

    private JSONObject matchCentre;
    private Integer matchId;
    private Integer homeId;
    private Integer awayId;
    private Integer maxMinute;
    private long startTime;
    public HashMap<Integer, Integer> playerMinutes;
    private HashMap<Integer, String> homePlayerIds;
    private HashMap<Integer, String> awayPlayerIds;
    public HashMap<Integer, Integer> passMap;
    public HashMap<Integer, Integer> passCornerMap;
    public HashMap<Integer, Integer> passLongballMap;
    public HashMap<Integer, Integer> passCrossMap;
    public HashMap<Integer, Integer> passBackMap;
    public HashMap<Integer, Integer> passForwardMap;
    public HashMap<Integer, Integer> passLeftMap;
    public HashMap<Integer, Integer> passRightMap;
    public HashMap<Integer, Integer> passShortMap;
    public HashMap<Integer, Integer> passThroughballMap;
    public HashMap<Integer, Integer> passAccurateMap;
    public HashMap<Integer, Integer> passShortAccurateMap;
    public HashMap<Integer, Integer> passCornerAccurateMap;
    public HashMap<Integer, Integer> passLongballAccurateMap;
    public HashMap<Integer, Integer> passCrossAccurateMap;
    public HashMap<Integer, Integer> passThroughballAccurateMap;
    public HashMap<Integer, Integer> passKeyMap;
    public HashMap<Integer, Integer> passKeyCrossMap;
    public HashMap<Integer, Integer> passKeyFreekickMap;
    public HashMap<Integer, Integer> passKeyCornerMap;
    public HashMap<Integer, Integer> passKeyThroughballMap;
    public HashMap<Integer, Integer> shotMap;
    public HashMap<Integer, Integer> shotOnTargetMap;
    public HashMap<Integer, Integer> shotOffTargetMap;
    public HashMap<Integer, Integer> shotBlockedMap;
    public HashMap<Integer, Integer> shotOpenPlayMap;
    public HashMap<Integer, Integer> shotSetPieceMap;
    public HashMap<Integer, Integer> shotOnPostMap;
    public HashMap<Integer, Integer> shotSixYardBoxMap;
    public HashMap<Integer, Integer> shotPenaltyAreaMap;
    public HashMap<Integer, Integer> shotBoxMap;
    public HashMap<Integer, Integer> shotCounterMap;
    public HashMap<Integer, Integer> shotHeadMap;
    public HashMap<Integer, Integer> shotFootMap;
    public HashMap<Integer, Integer> shot0bpMap;
    public HashMap<Integer, Integer> goalMap;

    public HashMap<Integer, Integer> goalNormalMap;
    public HashMap<Integer, Integer> goalHeadMap;
    public HashMap<Integer, Integer> goalFootMap;
    public HashMap<Integer, Integer> goalSetPieceMap;
    public HashMap<Integer, Integer> goalOwnMap;
    public HashMap<Integer, Integer> goalCounterMap;
    public HashMap<Integer, Integer> goalOpenPlayMap;
    public HashMap<Integer, Integer> goal0bpMap;
    public HashMap<Integer, Integer> goal0boxMap;
    public HashMap<Integer, Integer> goalSixYardBoxMap;
    public HashMap<Integer, Integer> goalPenaltyAreaMap;
    public HashMap<Integer, Integer> assistMap;
    public HashMap<Integer, Integer> assistCrossMap;
    public HashMap<Integer, Integer> assistCornerMap;
    public HashMap<Integer, Integer> assistThroughballMap;
    public HashMap<Integer, Integer> aerialDuelMap;
    public HashMap<Integer, Integer> redCardMap;
    public HashMap<Integer, Integer> yellowCardMap;
    public HashMap<Integer, Integer> secondYellowCardMap;
    public HashMap<Integer, Integer> saveMap;
    public HashMap<Integer, Integer> duelMap;
    public HashMap<Integer, Integer> duelOffensiveMap;
    public HashMap<Integer, Integer> duelDefensiveMap;
    public HashMap<Integer, Integer> dispossessedMap;
    public HashMap<Integer, Integer> turnoverMap;
    public HashMap<Integer, Integer> dribbleMap;
    public HashMap<Integer, Integer> dribbleWonMap;
    public HashMap<Integer, Integer> dribbleLostMap;
    public HashMap<Integer, Integer> dribbleLastManMap;
    public HashMap<Integer, Integer> challengeLostMap;
    public HashMap<Integer, Integer> blockedCrossMap;
    public HashMap<Integer, Integer> blockOutfielderMap;
    public HashMap<Integer, Integer> blockSixYardMap;
    public HashMap<Integer, Integer> blockPassOutfielderMap;
    public HashMap<Integer, Integer> interceptionMap;
    public HashMap<Integer, Integer> interceptionWonMap;
    public HashMap<Integer, Integer> interceptionInBoxMap;
    public HashMap<Integer, Integer> tackleMap;
    public HashMap<Integer, Integer> tackleWonMap;
    public HashMap<Integer, Integer> tackleLostMap;
    public HashMap<Integer, Integer> tackleLastManMap;
    public HashMap<Integer, Integer> offsideGivenMap;
    public HashMap<Integer, Integer> offsideProvokedMap;
    public HashMap<Integer, Integer> ballRecoveryMap;
    public HashMap<Integer, Integer> clearanceMap;
    public HashMap<Integer, Integer> clearanceEffectiveMap;
    public HashMap<Integer, Integer> clearanceOffLineMap;
    public HashMap<Integer, Integer> errorLeadsToGoalMap;
    public HashMap<Integer, Integer> errorLeadsToShotMap;
    public HashMap<Integer, Integer> touchMap;
    public HashMap<Integer, Integer> penaltyWonMap;
    public HashMap<Integer, Integer> penaltyConcededMap;
    public HashMap<Integer, Integer> penaltyScoredMap;
    public HashMap<Integer, Integer> bigChanceMissedMap;
    public HashMap<Integer, Integer> bigChanceScoredMap;
    public HashMap<Integer, Integer> bigChanceCreatedMap;
    public HashMap<Integer, Integer> parriedSafeMap;
    public HashMap<Integer, Integer> parriedDangerMap;
    public HashMap<Integer, Integer> saveKeeperMap;

    private String parsePlayerName(String name) {
        return StringUtils.stripAccents(name).replaceAll("'", "''");
    }

    private void initPlayerIds() {
        this.homePlayerIds= new HashMap<Integer, String>();
        JSONObject homeJson = matchCentre.getJSONObject("home");
        JSONArray homePlayersJSON = homeJson.getJSONArray("players");
        for (Object player: homePlayersJSON) {
            JSONObject playerJson = (JSONObject) player;
            String playerName = parsePlayerName(playerJson.getString("name"));
            Integer playerId = playerJson.getInt("playerId");
            this.homePlayerIds.put(playerId, playerName);
        }

        this.awayPlayerIds= new HashMap<Integer, String>();
        JSONObject awayJson = matchCentre.getJSONObject("away");
        JSONArray awayPlayersJSON = awayJson.getJSONArray("players");
        for (Object player: awayPlayersJSON) {
            JSONObject playerJson = (JSONObject) player;
            String playerName = parsePlayerName(playerJson.getString("name"));
            Integer playerId = playerJson.getInt("playerId");
            this.awayPlayerIds.put(playerId, playerName);
        }
    }

    private void incrementPlayer(boolean should, Event event, HashMap<Integer, Integer> map) {
        if (should) {
            Optional<Integer> playerId = event.getPlayerId();
            if (playerId.isPresent()) {
                if (map.containsKey(playerId.get())) {
                    Integer val = map.get(playerId.get());
                    map.put(playerId.get(), val + 1);
                } else {
                    map.put(playerId.get(), 1);
                }
            }
        }
    }

    private void initEvents() {
        this.passMap = new HashMap<>();
        this.passCornerMap = new HashMap<>();
        this.passLongballMap = new HashMap<>();
        this.passCrossMap = new HashMap<>();
        this.passBackMap = new HashMap<>();
        this.passForwardMap = new HashMap<>();
        this.passLeftMap = new HashMap<>();
        this.passRightMap = new HashMap<>();
        this.passShortMap = new HashMap<>();
        this.passThroughballMap = new HashMap<>();
        this.passAccurateMap = new HashMap<>();
        this.passShortAccurateMap = new HashMap<>();
        this.passCornerAccurateMap = new HashMap<>();
        this.passLongballAccurateMap = new HashMap<>();
        this.passCrossAccurateMap = new HashMap<>();
        this.passThroughballAccurateMap = new HashMap<>();
        this.passKeyMap = new HashMap<>();
        this.passKeyCrossMap = new HashMap<>();
        this.passKeyFreekickMap = new HashMap<>();
        this.passKeyCornerMap = new HashMap<>();
        this.passKeyThroughballMap = new HashMap<>();
        this.shotMap = new HashMap<>();
        this.shotOnTargetMap = new HashMap<>();
        this.shotOffTargetMap = new HashMap<>();
        this.shotBlockedMap = new HashMap<>();
        this.shotOpenPlayMap = new HashMap<>();
        this.shotSetPieceMap = new HashMap<>();
        this.shotOnPostMap = new HashMap<>();
        this.shotSixYardBoxMap = new HashMap<>();
        this.shotPenaltyAreaMap = new HashMap<>();
        this.shotBoxMap = new HashMap<>();
        this.shotCounterMap = new HashMap<>();
        this.shotHeadMap = new HashMap<>();
        this.shotFootMap = new HashMap<>();
        this.shot0bpMap = new HashMap<>();
        this.goalMap = new HashMap<>();
        this.goalNormalMap = new HashMap<>();
        this.goalHeadMap = new HashMap<>();
        this.goalFootMap = new HashMap<>();
        this.goalSetPieceMap = new HashMap<>();
        this.goalOwnMap = new HashMap<>();
        this.goalCounterMap = new HashMap<>();
        this.goalOpenPlayMap = new HashMap<>();
        this.goal0bpMap = new HashMap<>();
        this.goal0boxMap = new HashMap<>();
        this.goalSixYardBoxMap = new HashMap<>();
        this.goalPenaltyAreaMap = new HashMap<>();
        this.assistMap = new HashMap<>();
        this.assistCrossMap = new HashMap<>();
        this.assistCornerMap = new HashMap<>();
        this.assistThroughballMap = new HashMap<>();
        this.aerialDuelMap = new HashMap<>();
        this.redCardMap = new HashMap<>();
        this.yellowCardMap = new HashMap<>();
        this.secondYellowCardMap = new HashMap<>();
        this.saveMap = new HashMap<>();
        this.duelMap = new HashMap<>();
        this.duelOffensiveMap = new HashMap<>();
        this.duelDefensiveMap = new HashMap<>();
        this.dispossessedMap = new HashMap<>();
        this.turnoverMap = new HashMap<>();
        this.dribbleMap = new HashMap<>();
        this.dribbleWonMap = new HashMap<>();
        this.dribbleLostMap = new HashMap<>();
        this.dribbleLastManMap = new HashMap<>();
        this.challengeLostMap = new HashMap<>();
        this.blockedCrossMap = new HashMap<>();
        this.blockOutfielderMap = new HashMap<>();
        this.blockSixYardMap = new HashMap<>();
        this.blockPassOutfielderMap = new HashMap<>();
        this.interceptionMap = new HashMap<>();
        this.interceptionWonMap = new HashMap<>();
        this.interceptionInBoxMap = new HashMap<>();
        this.tackleMap = new HashMap<>();
        this.tackleWonMap = new HashMap<>();
        this.tackleLostMap = new HashMap<>();
        this.tackleLastManMap = new HashMap<>();
        this.offsideGivenMap = new HashMap<>();
        this.offsideProvokedMap = new HashMap<>();
        this.ballRecoveryMap = new HashMap<>();
        this.clearanceMap = new HashMap<>();
        this.clearanceEffectiveMap = new HashMap<>();
        this.clearanceOffLineMap = new HashMap<>();
        this.errorLeadsToGoalMap = new HashMap<>();
        this.errorLeadsToShotMap = new HashMap<>();
        this.touchMap = new HashMap<>();
        this.penaltyWonMap = new HashMap<>();
        this.penaltyConcededMap = new HashMap<>();
        this.penaltyScoredMap = new HashMap<>();
        this.bigChanceMissedMap = new HashMap<>();
        this.bigChanceCreatedMap = new HashMap<>();
        this.bigChanceScoredMap = new HashMap<>();
        this.parriedSafeMap = new HashMap<>();
        this.parriedDangerMap = new HashMap<>();
        this.saveKeeperMap = new HashMap<>();

        JSONArray events = matchCentre.getJSONArray("events");
        for (Object event : events) {
            JSONObject jsonEvent = (JSONObject)  event;
            Event eventObj = new Event(jsonEvent);
            incrementPlayer(eventObj.isPass(), eventObj, this.passMap);
            incrementPlayer(eventObj.isPassCorner(), eventObj, this.passCornerMap);
            incrementPlayer(eventObj.isPassLongball(), eventObj, this.passLongballMap);
            incrementPlayer(eventObj.isPassCross(), eventObj, this.passCrossMap);
            incrementPlayer(eventObj.isPassBack(), eventObj, this.passBackMap);
            incrementPlayer(eventObj.isPassForward(), eventObj, this.passForwardMap);
            incrementPlayer(eventObj.isPassLeft(), eventObj, this.passLeftMap);
            incrementPlayer(eventObj.isPassRight(), eventObj, this.passRightMap);
            incrementPlayer(eventObj.isPassShort(), eventObj, this.passShortMap);
            incrementPlayer(eventObj.isPassThroughball(), eventObj, this.passThroughballMap);
            incrementPlayer(eventObj.isPassAccurate(), eventObj, this.passAccurateMap);
            incrementPlayer(eventObj.isPassShortAccurate(), eventObj, this.passShortAccurateMap);
            incrementPlayer(eventObj.isPassCornerAccurate(), eventObj, this.passCornerAccurateMap);
            incrementPlayer(eventObj.isPassLongballAccurate(), eventObj, this.passLongballAccurateMap);
            incrementPlayer(eventObj.isPassCrossAccurate(), eventObj, this.passCrossAccurateMap);
            incrementPlayer(eventObj.isPassThroughballAccurate(), eventObj, this.passThroughballAccurateMap);
            incrementPlayer(eventObj.isPassKey(), eventObj, this.passKeyMap);
            incrementPlayer(eventObj.isPassKeyCross(), eventObj, this.passKeyCrossMap);
            incrementPlayer(eventObj.isPassKeyFreekick(), eventObj, this.passKeyFreekickMap);
            incrementPlayer(eventObj.isPassKeyCorner(), eventObj, this.passKeyCornerMap);
            incrementPlayer(eventObj.isPassKeyThroughball(), eventObj, this.passKeyThroughballMap);
            incrementPlayer(eventObj.isShot(), eventObj, this.shotMap);
            incrementPlayer(eventObj.isShotOnTarget(), eventObj, this.shotOnTargetMap);
            incrementPlayer(eventObj.isShotOffTarget(), eventObj, this.shotOffTargetMap);
            incrementPlayer(eventObj.isShotBlocked(), eventObj, this.shotBlockedMap);
            incrementPlayer(eventObj.isShotOpenPlay(), eventObj, this.shotOpenPlayMap);
            incrementPlayer(eventObj.isShotSetPiece(), eventObj, this.shotSetPieceMap);
            incrementPlayer(eventObj.isShotOnPost(), eventObj, this.shotOnPostMap);
            incrementPlayer(eventObj.isShotSixYardBox(), eventObj, shotSixYardBoxMap);
            incrementPlayer(eventObj.isShotPenaltyArea(), eventObj, shotPenaltyAreaMap);
            incrementPlayer(eventObj.isShotBox(), eventObj, shotBoxMap);
            incrementPlayer(eventObj.isShotCounter(), eventObj, shotCounterMap);
            incrementPlayer(eventObj.isShotHead(), eventObj, shotHeadMap);
            incrementPlayer(eventObj.isShotFoot(), eventObj, shotFootMap);
            incrementPlayer(eventObj.isShot0bp(), eventObj, shot0bpMap);
            incrementPlayer(eventObj.isGoal(), eventObj, this.goalMap);
            incrementPlayer(eventObj.isGoalNormal(), eventObj, this.goalNormalMap);
            incrementPlayer(eventObj.isGoalHead(), eventObj, this.goalHeadMap);
            incrementPlayer(eventObj.isGoalFoot(), eventObj, this.goalFootMap);
            incrementPlayer(eventObj.isGoalSetPiece(), eventObj, this.goalSetPieceMap);
            incrementPlayer(eventObj.isGoalOwn(), eventObj, this.goalOwnMap);
            incrementPlayer(eventObj.isGoalCounter(), eventObj, this.goalCounterMap);
            incrementPlayer(eventObj.isGoalOpenPlay(), eventObj, this.goalOpenPlayMap);
            incrementPlayer(eventObj.isGoal0bp(), eventObj, this.goal0bpMap);
            incrementPlayer(eventObj.isGoal0box(), eventObj, this.goal0boxMap);
            incrementPlayer(eventObj.isGoalSixYardBox(), eventObj, this.goalSixYardBoxMap);
            incrementPlayer(eventObj.isGoalPenaltyArea(), eventObj, this.goalPenaltyAreaMap);
            incrementPlayer(eventObj.isAssist(), eventObj, this.assistMap);
            incrementPlayer(eventObj.isAssistCross(), eventObj, this.assistCrossMap);
            incrementPlayer(eventObj.isAssistCorner(), eventObj, this.assistCornerMap);
            incrementPlayer(eventObj.isAssistThroughBall(), eventObj, this.assistThroughballMap);
            incrementPlayer(eventObj.isAerialDuel(), eventObj, this.aerialDuelMap);
            incrementPlayer(eventObj.isRedCard(), eventObj, this.redCardMap);
            incrementPlayer(eventObj.isYellowCard(), eventObj, this.yellowCardMap);
            incrementPlayer(eventObj.isSecondYellowCard(), eventObj, this.secondYellowCardMap);
            incrementPlayer(eventObj.isSave(), eventObj, this.saveMap);
            incrementPlayer(eventObj.isDuel(), eventObj, this.duelMap);
            incrementPlayer(eventObj.isDuelOffensive(), eventObj, this.duelOffensiveMap);
            incrementPlayer(eventObj.isDuelDefensive(), eventObj, this.duelDefensiveMap);
            incrementPlayer(eventObj.isDispossessed(), eventObj, this.dispossessedMap);
            incrementPlayer(eventObj.isTurnover(), eventObj, this.turnoverMap);
            incrementPlayer(eventObj.isDribble(), eventObj, this.dribbleMap);
            incrementPlayer(eventObj.isDribbleWon(), eventObj, this.dribbleWonMap);
            incrementPlayer(eventObj.isDribbleLost(), eventObj, this.dribbleLostMap);
            incrementPlayer(eventObj.isDribbleLastMan(), eventObj, this.dribbleLastManMap);
            incrementPlayer(eventObj.isChallengeLost(), eventObj, this.challengeLostMap);
            incrementPlayer(eventObj.isBlockedCross(), eventObj, this.blockedCrossMap);
            incrementPlayer(eventObj.isBlockOutfielder(), eventObj, this.blockOutfielderMap);
            incrementPlayer(eventObj.isBlockSixYard(), eventObj, this.blockSixYardMap);
            incrementPlayer(eventObj.isBlockPassOutfielder(), eventObj, this.blockPassOutfielderMap);
            incrementPlayer(eventObj.isInterception(), eventObj, this.interceptionMap);
            incrementPlayer(eventObj.isInterceptionWon(), eventObj, this.interceptionWonMap);
            incrementPlayer(eventObj.isInterceptionInBox(), eventObj, this.interceptionInBoxMap);
            incrementPlayer(eventObj.isTackle(), eventObj, this.tackleMap);
            incrementPlayer(eventObj.isTackleWon(), eventObj, this.tackleWonMap);
            incrementPlayer(eventObj.isTackleLost(), eventObj, this.tackleLostMap);
            incrementPlayer(eventObj.isTackleLastMan(), eventObj, this.tackleLastManMap);
            incrementPlayer(eventObj.isOffsideGiven(), eventObj, this.offsideGivenMap);
            incrementPlayer(eventObj.isOffsideProvoked(), eventObj, this.offsideProvokedMap);
            incrementPlayer(eventObj.isBallRecovery(), eventObj, this.ballRecoveryMap);
            incrementPlayer(eventObj.isClearance(), eventObj, this.clearanceMap);
            incrementPlayer(eventObj.isClearanceEffective(), eventObj, this.clearanceEffectiveMap);
            incrementPlayer(eventObj.isClearanceOffLine(), eventObj, this.clearanceOffLineMap);
            incrementPlayer(eventObj.isErrorLeadsToGoal(), eventObj, this.errorLeadsToGoalMap);
            incrementPlayer(eventObj.isErrorLeadsToShot(), eventObj, this.errorLeadsToShotMap);
            incrementPlayer(eventObj.isTouch(), eventObj, this.touchMap);
            incrementPlayer(eventObj.isPenaltyWon(), eventObj, this.penaltyWonMap);
            incrementPlayer(eventObj.isPenaltyConceded(), eventObj, this.penaltyConcededMap);
            incrementPlayer(eventObj.isPenaltyScored(), eventObj, this.penaltyScoredMap);
            incrementPlayer(eventObj.isBigChangeMissed(), eventObj, this.bigChanceMissedMap);
            incrementPlayer(eventObj.isBigChangeCreated(), eventObj, this.bigChanceCreatedMap);
            incrementPlayer(eventObj.isBigChangeScored(), eventObj, this.bigChanceScoredMap);
            incrementPlayer(eventObj.isParriedSafe(), eventObj, this.parriedSafeMap);
            incrementPlayer(eventObj.isParriedDanger(), eventObj, this.parriedDangerMap);
            incrementPlayer(eventObj.isSaveKeeper(), eventObj, this.saveKeeperMap);
        }
    }

    private void initTeams() {
        JSONObject home = matchCentre.getJSONObject("home");
        JSONObject away = matchCentre.getJSONObject("away");

        this.homeId = home.getInt("teamId");
        this.awayId = away.getInt("teamId");
    }

    private void initStartTime() {
        String startTime = matchCentre.getString("startTime");
        LocalDateTime startTimeDate = LocalDateTime.parse(startTime);
        this.startTime = startTimeDate.toInstant(ZoneOffset.UTC).getEpochSecond();
    }

    private void initPlayerMinutes() {
        this.playerMinutes = new HashMap<>();
        //We need to initialize from zero so we can calculate players who don't get subbed on
        for (Integer playerId: this.homePlayerIds.keySet()) {
            this.playerMinutes.put(playerId, 0);
        }
        for (Integer playerId: this.awayPlayerIds.keySet()) {
            this.playerMinutes.put(playerId, 0);
        }

        JSONArray events = matchCentre.getJSONArray("events");
        for (Object eventRaw : events) {
            Event event = new Event((JSONObject) eventRaw);
            if (event.isSubbedOn()) {
                Optional<Integer> playerSubbedOn = event.getPlayerId();
                if (playerSubbedOn.isPresent() && event.getMinute().isPresent()) {
                    this.playerMinutes.put(playerSubbedOn.get(), this.maxMinute - event.getMinute().get());
                }
            }

            if (event.isSubbedOff()) {
                Optional<Integer> playerSubbedOff = event.getPlayerId();
                if (playerSubbedOff.isPresent() && event.getMinute().isPresent()) {
                    this.playerMinutes.put(playerSubbedOff.get(), event.getMinute().get());
                }
            }
        }

        JSONObject home = matchCentre.getJSONObject("home");
        JSONArray home_players = home.getJSONArray("players");
        for (Object playerRaw: home_players) {
            JSONObject player = (JSONObject) playerRaw;
            if (player.has("isFirstEleven") && player.getBoolean("isFirstEleven")) {
                Integer playerId = player.getInt("playerId");
                this.playerMinutes.put(playerId, this.maxMinute);
            }
        }

        JSONObject away = matchCentre.getJSONObject("away");
        JSONArray away_players = away.getJSONArray("players");
        for (Object playerRaw: away_players) {
            JSONObject player = (JSONObject) playerRaw;
            if (player.has("isFirstEleven") && player.getBoolean("isFirstEleven")) {
                Integer playerId = player.getInt("playerId");
                this.playerMinutes.put(playerId, this.maxMinute);
            }
        }
    }

    public Match toMatchOutput () {
        return new Match(matchId, (int) startTime, homeId, awayId);
    }

    public TeamStats toHomeTeamStatsOutput () {
        return new TeamStats(this.homeId, this);
    }

    public TeamStats toAwayTeamStatsOutput () {
        return new TeamStats(this.awayId, this);
    }

    public Vector<PlayerStats> toPlayerStatsOutput() {
        Vector<PlayerStats> res = new Vector<>();
        for (Integer playerId: this.homePlayerIds.keySet()) {
            res.add(new PlayerStats(playerId, homeId, this));
        }
        for (Integer playerId: this.awayPlayerIds.keySet()) {
            res.add(new PlayerStats(playerId, awayId, this));
        }
        return res;
    }

    public Vector<Team> toTeamOutput() {
        Vector<Team> res = new Vector<>();
        JSONObject home = this.matchCentre.getJSONObject("home");
        String homeName = home.getString("name");
        Team homeObj = new Team(homeId, homeName);
        res.add(homeObj);

        JSONObject away = this.matchCentre.getJSONObject("away");
        String awayName = away.getString("name");
        Team awayObj = new Team(awayId, awayName);
        res.add(awayObj);
        return res;
    }

    public Vector<Player> toPlayerOutput() {
        Vector<Player> res = new Vector<>();
        JSONObject players = matchCentre.getJSONObject("playerIdNameDictionary");
        for (String player: players.keySet()) {
            Integer playerId = Integer.parseInt(player);
            String name = parsePlayerName(players.getString(player));
            Player playerObj = new Player(playerId, name);
            res.add(playerObj);
        }
        return res;
    }

    public MatchWrapper(JSONObject match) {
        this.matchId = (Integer) match.get("matchId");
        this.matchCentre = (JSONObject) match.get("matchCentreData");
        this.maxMinute = matchCentre.getInt("maxMinute");
        initPlayerIds();
        initEvents();
        initTeams();
        initStartTime();
        initPlayerMinutes();
    }

    public Integer getMatchId() {
        return matchId;
    }

    public Integer getAwayId() {
        return awayId;
    }

    public Integer getHomeId() {
        return homeId;
    }
    public long getStartTime() {
        return startTime;
    }

    public Set<Integer> getHomePlayerIds() {
        return homePlayerIds.keySet();
    }

    public Set<Integer> getAwayPlayerIds() {
        return awayPlayerIds.keySet();
    }

    public Set<Integer> getPlayers(Integer teamId) {
        return this.homeId.equals(teamId) ? this.getHomePlayerIds() : this.getAwayPlayerIds();
    }

}