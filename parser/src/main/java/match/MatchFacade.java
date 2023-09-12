package match;


import com.fasterxml.jackson.core.JsonProcessingException;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Optional;
import java.util.Set;

public class MatchFacade {

    private Integer matchId;
    private Integer homeId;
    private Integer awayId;
    private HashMap<Integer, String> homePlayerIds;
    private HashMap<Integer, String> awayPlayerIds;
    private HashMap<Integer, Integer> passMap;

    private void initPlayerIds(JSONObject matchCentre) {
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

    private void initEvents(JSONObject matchCentre) {
        this.passMap = new HashMap<>();

        JSONArray events = matchCentre.getJSONArray("events");
        for (Object event : events) {
            JSONObject jsonEvent = (JSONObject)  event;
            Event eventObj = new Event(jsonEvent);
            if (eventObj.isPass()) {
                Optional<Integer> playerId = eventObj.getPlayerId();
                if (playerId.isPresent()) {
                    if (this.passMap.containsKey(playerId.get())) {
                        Integer passes = this.passMap.get(playerId.get());
                        this.passMap.put(playerId.get(), passes + 1);
                    } else {
                        this.passMap.put(playerId.get(), 0);
                    }
                }
            }
        }
    }

    private void initTeams(JSONObject matchCentre) {
        JSONObject home = matchCentre.getJSONObject("home");
        JSONObject away = matchCentre.getJSONObject("away");

        this.homeId = home.getInt("teamId");
        this.awayId = away.getInt("teamId");
    }

    public String toMatchJsonOutput() throws JsonProcessingException {
        Match output = new Match(this);
        return output.toJSON();
    }

    public Match toMatchOutput () {
        return new Match(this);
    }

    public TeamStats toHomeTeamStatsOutput () {
        return new TeamStats(this.homeId, this);
    }

    public String toHomeTeamStatsJsonOutput() throws JsonProcessingException {
        TeamStats output = new TeamStats(this.homeId, this);
        return output.toJSON();
    }

    public TeamStats toAwayTeamStatsOutput () {
        return new TeamStats(this.awayId, this);
    }

    public String toAwayTeamStatsJsonOutput() throws JsonProcessingException {
        TeamStats output = new TeamStats(this.awayId, this);
        return output.toJSON();
    }

    public MatchFacade(JSONObject match) {
        this.matchId = (Integer) match.get("matchId");

        JSONObject matchCentre = (JSONObject) match.get("matchCentreData");
        initPlayerIds(matchCentre);
        initEvents(matchCentre);
        initTeams(matchCentre);
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

    public HashMap<Integer, Integer> getPassMap() {
        return passMap;
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