package match;


import com.fasterxml.jackson.core.JsonProcessingException;
import entity.*;
import org.jooq.generated.tables.records.*;
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
    public HashMap<Integer, Integer> shotMap;
    public HashMap<Integer, Integer> shotOnTargetMap;
    public HashMap<Integer, Integer> shotOffTargetMap;
    public HashMap<Integer, Integer> passKeyMap;
    public HashMap<Integer, Integer> dispossessedMap;
    public HashMap<Integer, Integer> goalMap;
    public HashMap<Integer, Integer> aerialDuelMap;
    public HashMap<Integer, Integer> assistMap;
    public HashMap<Integer, Integer> redCardMap;
    public HashMap<Integer, Integer> yellowCardMap;
    public HashMap<Integer, Integer> saveMap;
    public HashMap<Integer, Integer> passCrossMap;
    public HashMap<Integer, Integer> duelMap;

    private void initPlayerIds() {
        this.homePlayerIds= new HashMap<Integer, String>();
        JSONObject homeJson = matchCentre.getJSONObject("home");
        JSONArray homePlayersJSON = homeJson.getJSONArray("players");
        for (Object player: homePlayersJSON) {
            JSONObject player_json = (JSONObject) player;
            String player_name = player_json.getString("name");
            Integer player_id = player_json.getInt("playerId");
            this.homePlayerIds.put(player_id, player_name);
        }

        this.awayPlayerIds= new HashMap<Integer, String>();
        JSONObject awayJson = matchCentre.getJSONObject("away");
        JSONArray awayPlayersJSON = awayJson.getJSONArray("players");
        for (Object player: awayPlayersJSON) {
            JSONObject player_json = (JSONObject) player;
            String player_name = player_json.getString("name");
            Integer player_id = player_json.getInt("playerId");
            this.awayPlayerIds.put(player_id, player_name);
        }
    }

    private void incrementPlayer(boolean should, Event event, HashMap<Integer, Integer> map) {
        if (should) {
            Optional<Integer> playerId = event.getPlayerId();
            if (playerId.isPresent()) {
                if (map.containsKey(playerId.get())) {
                    Integer passes = map.get(playerId.get());
                    map.put(playerId.get(), passes + 1);
                } else {
                    map.put(playerId.get(), 0);
                }
            }
        }
    }

    private void initEvents() {
        this.passMap = new HashMap<>();
        this.shotMap = new HashMap<>();
        this.shotOnTargetMap = new HashMap<>();
        this.shotOffTargetMap = new HashMap<>();
        this.passKeyMap = new HashMap<>();
        this.dispossessedMap = new HashMap<>();
        this.goalMap = new HashMap<>();
        this.aerialDuelMap = new HashMap<>();
        this.assistMap = new HashMap<>();
        this.redCardMap = new HashMap<>();
        this.yellowCardMap = new HashMap<>();
        this.saveMap = new HashMap<>();
        this.passCrossMap = new HashMap<>();
        this.duelMap = new HashMap<>();

        JSONArray events = matchCentre.getJSONArray("events");
        for (Object event : events) {
            JSONObject jsonEvent = (JSONObject)  event;
            Event eventObj = new Event(jsonEvent);
            incrementPlayer(eventObj.isPass(), eventObj, this.passMap);
            incrementPlayer(eventObj.isShot(), eventObj, this.shotMap);
            incrementPlayer(eventObj.isShotOnTarget(), eventObj, this.shotOnTargetMap);
            incrementPlayer(eventObj.isShotOffTarget(), eventObj, this.shotOffTargetMap);
            incrementPlayer(eventObj.isPassKey(), eventObj, this.passKeyMap);
            incrementPlayer(eventObj.isDispossessed(), eventObj, this.dispossessedMap);
            incrementPlayer(eventObj.isGoal(), eventObj, this.goalMap);
            incrementPlayer(eventObj.isAerialDuel(), eventObj, this.aerialDuelMap);
            incrementPlayer(eventObj.isAssist(), eventObj, this.assistMap);
            incrementPlayer(eventObj.isRedCard(), eventObj, this.redCardMap);
            incrementPlayer(eventObj.isYellowCard(), eventObj, this.yellowCardMap);
            incrementPlayer(eventObj.isSave(), eventObj, this.saveMap);
            incrementPlayer(eventObj.isPassCross(), eventObj, this.passCrossMap);
            incrementPlayer(eventObj.isDuel(), eventObj, this.duelMap);
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

    public String toMatchJsonOutput() throws JsonProcessingException {
        return this.toMatchOutput().formatJSON();
    }

    public MatchRecord toMatchOutput () {
        MatchRecord match = new MatchRecord();
        match.setId(matchId);
        match.setHomeId(homeId);
        match.setAwayId(awayId);
        match.setStartDate((int) startTime);
        return match;
    }

    public TeamStatsRecord toHomeTeamStatsOutput () {
        return TeamStatsBuilder.build(this.homeId, this);
    }

    public String toHomeTeamStatsJsonOutput() {
        return this.toHomeTeamStatsOutput().formatJSON();
    }

    public TeamStatsRecord toAwayTeamStatsOutput () {
        return TeamStatsBuilder.build(this.awayId, this);
    }

    public String toAwayTeamStatsJsonOutput() {
        return this.toAwayTeamStatsOutput().formatJSON();
    }

    public Vector<PlayerStatsRecord> toPlayerStatsOutput() {
        Vector<PlayerStatsRecord> res = new Vector<>();
        for (Integer playerId: this.homePlayerIds.keySet()) {
            res.add(PlayerStatsBuilder.build(playerId, homeId, this));
        }
        for (Integer playerId: this.awayPlayerIds.keySet()) {
            res.add(PlayerStatsBuilder.build(playerId, awayId, this));
        }
        return res;
    }

    public JSONArray toPlayerStatsJsonOutput() throws JsonProcessingException {
        JSONArray res = new JSONArray();
        for (PlayerStatsRecord record: this.toPlayerStatsOutput()) {
            res.put(record.formatJSON());

        }
        return res;
    }

    public Vector<TeamRecord> toTeamOutput() {
        Vector<TeamRecord> res = new Vector<>();
        JSONObject home = this.matchCentre.getJSONObject("home");
        String homeName = home.getString("name");
        TeamRecord homeRecord = new TeamRecord();
        homeRecord.setId(homeId);
        homeRecord.setName(homeName);
        res.add(homeRecord);

        JSONObject away = this.matchCentre.getJSONObject("away");
        String awayName = away.getString("name");
        TeamRecord awayRecord = new TeamRecord();
        awayRecord.setId(awayId);
        awayRecord.setName(awayName);
        res.add(awayRecord);
        return res;
    }

    public Vector<PlayerRecord> toPlayerOutput() {
        Vector<PlayerRecord> res = new Vector<>();
        JSONObject players = matchCentre.getJSONObject("playerIdNameDictionary");
        for (String player: players.keySet()) {
            Integer playerId = Integer.parseInt(player);
            String name = players.getString(player);
            PlayerRecord playerRecord = new PlayerRecord();
            playerRecord.setId(playerId);
            playerRecord.setName(name);
            res.add(playerRecord);
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