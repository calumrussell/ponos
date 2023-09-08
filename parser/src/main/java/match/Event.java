package match;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.List;
import java.util.Optional;
import java.util.Vector;

public class Event {

    private JSONArray eventTypes;
    private Optional<Integer> playerId;

    protected boolean isShot() {
        //Not strictly good for performance reasons but makes this more readable
        Vector<String> shotNames = new Vector<>(List.of("shotSixYardBox", "shotRightFoot"));

        for (Object eventTypeRaw : this.eventTypes) {
            Integer eventType = (Integer) eventTypeRaw;
            String eventName = EventMapping.eventIdMap.get(eventType);
            if (shotNames.contains(eventName)){
                return true;
            }
        }
        return false;
    }

    protected Optional<Integer> getPlayerId() {
        return this.playerId;
    }

    protected boolean isPass() {
        //Not strictly good for performance reasons but makes this more readable
        Vector<String> passNames = new Vector<>(List.of(
                "passCorner",
                "passCornerAccurate",
                "passCornerInaccurate",
                "passFreekick",
                "passBack",
                "passForward",
                "passLeft",
                "passRight",
                "keyPassLong",
                "keyPassShort",
                "keyPassCross",
                "keyPassCorner",
                "keyPassThroughball",
                "keyPassFreekick",
                "keyPassThrowin",
                "keyPassOther"
        ));

        for (Object eventTypeRaw : this.eventTypes) {
            Integer eventType = (Integer) eventTypeRaw;
            String eventName = EventMapping.eventIdMap.get(eventType);
            if (passNames.contains(eventName)){
                return true;
            }
        }
        return false;
    }

    Event (JSONObject event) {
        this.eventTypes = event.getJSONArray("satisfiedEventsTypes");
        if (event.has("playerId")) {
            this.playerId = Optional.of(event.getInt("playerId"));
        } else {
            this.playerId = Optional.empty();
        }
    }
}
