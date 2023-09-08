package match;


import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Optional;
import java.util.Vector;

public class Match {

    private Integer matchId;
    private Integer homeId;
    private Integer awayId;
    private HashMap<Integer, String> playerIds;
    private HashMap<Integer, Integer> passMap;

    private void initPlayerIds(JSONObject matchCentre) {
        this.playerIds = new HashMap<Integer, String>();
        JSONObject playersJson = (JSONObject) matchCentre.get("playerIdNameDictionary");
        for (Iterator<String> it = playersJson.keys(); it.hasNext(); ) {
            String playerIdString = it.next();
            Integer playerId = Integer.parseInt(playerIdString);
            String name = playersJson.getString(playerIdString);
            this.playerIds.put(playerId, name);
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

    public Match(JSONObject match) {
        this.matchId = (Integer) match.get("matchId");

        JSONObject matchCentre = (JSONObject) match.get("matchCentreData");
        initPlayerIds(matchCentre);
        initEvents(matchCentre);
        initTeams(matchCentre);
    }

    public HashMap<Integer, Integer> getPassMap() {
        return passMap;
    }
}
