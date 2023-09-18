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