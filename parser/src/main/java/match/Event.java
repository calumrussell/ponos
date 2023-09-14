package match;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.List;
import java.util.Optional;
import java.util.Vector;

public class Event {

    private JSONArray eventTypes;
    private Optional<Integer> playerId;
    private Optional<Integer> minute;

    private boolean checkType(Vector<String> types) {
        for (Object eventTypeRaw : this.eventTypes) {
            Integer eventType = (Integer) eventTypeRaw;
            String eventName = EventMapping.eventIdMap.get(eventType);
            if (types.contains(eventName)){
                return true;
            }
        }
        return false;
    }

    protected boolean isShot() {
        Vector<String> shotNames = new Vector<>(List.of(
                "shotsTotal"
        ));
        return checkType(shotNames);
    }
    protected boolean isShotOnTarget() {
        Vector<String> shotNames = new Vector<>(List.of(
                "shotOnPost",
                "shotOnTarget"
        ));
        return checkType(shotNames);
    }

    protected boolean isShotOffTarget() {
        Vector<String> shotNames = new Vector<>(List.of(
                "shotOffTarget"
                ));
        return checkType(shotNames);
    }

    protected boolean isPass() {
        //Checking against names is potentially more buggy but it is far more readable
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
        return checkType(passNames);
    }

    protected boolean isPassKey() {
        Vector<String> keyPassNames = new Vector<>(List.of(
                "keyPassShort",
                "keyPassCross",
                "keyPassCorner",
                "keyPassThroughball",
                "keyPassFreekick",
                "keyPassThrowin",
                "keyPassOther"
        ));
        return checkType(keyPassNames);
    }

    protected boolean isPassCross() {
        Vector<String> passNames = new Vector<>(List.of(
                "passCorner"
                ));
        return checkType(passNames);
    }

    protected boolean isDispossessed() {
        Vector<String> dispossessedNames = new Vector<>(List.of(
                "dispossessed"
        ));
        return checkType(dispossessedNames);
    }

    protected boolean isGoal() {
        Vector<String> goalNames = new Vector<>(List.of(
            "goalSixYardBox",
            "goalPenaltyArea",
            "goalObox",
            "goalOpenPlay",
            "goalCounter",
            "goalSetPiece",
            "penaltyScored",
            "goalOwn",
            "goalNormal",
            "goalRightFoot",
            "goalLeftFoot",
            "goalHead",
            "goalObp"
        ));
        return checkType(goalNames);
    }

    protected boolean isAerialDuel() {
        Vector<String> aerialDuelsNames = new Vector<>(List.of(
                "duelAerialWon",
                "duelAerialLost"
        ));
        return checkType(aerialDuelsNames);
    }

    protected boolean isAssist() {
        Vector<String> assistNames = new Vector<>(List.of(
                "assistCross",
                "assistCorner",
                "assistThroughball",
                "assistFreekick",
                "assistThrowin",
                "assistOther"
        ));
        return checkType(assistNames);
    }

    protected boolean isRedCard() {
        Vector<String> redCardNames = new Vector<>(List.of(
                "redCard"
        ));
        return checkType(redCardNames);
    }

    protected boolean isYellowCard() {
        //Also have void category
        Vector<String> yellowCardNames = new Vector<>(List.of(
                "yellowCard"
        ));
        return checkType(yellowCardNames);
    }

    protected boolean isSave() {
        Vector<String> saveNames = new Vector<>(List.of(
                "saveLowLeft",
                "saveHighLeft",
                "saveLowCentre",
                "saveHighCentre",
                "saveLowRight",
                "saveHighRight",
                "saveHands",
                "saveFeet",
                "saveObp",
                "saveSixYardBox",
                "savePenaltyArea",
                "saveObox",
                "keeperDivingSave",
                "standingSave"
        ));
        return checkType(saveNames);
    }

    protected boolean isDuel() {
        Vector<String> duelNames = new Vector<>(List.of(
                "offensiveDuel",
                "defensiveDuel"
        ));
        return checkType(duelNames);
    }

    protected boolean isSubbedOn() {
        Vector<String> subOnNames = new Vector<>(List.of(
                "subOn"
        ));
        return checkType(subOnNames);
    }

    protected boolean isSubbedOff() {
        Vector<String> subOffNames = new Vector<>(List.of(
                "subOff"
        ));
        return checkType(subOffNames);
    }

    protected Optional<Integer> getPlayerId() {
        return this.playerId;
    }

    protected Optional<Integer> getMinute() {
        return this.minute;
    }

    private Optional<Integer> getOptionalValue(JSONObject event, String name) {
        if (event.has(name)) {
            return Optional.of(event.getInt(name));
        }
        return Optional.empty();
    }

    Event (JSONObject event) {
        this.eventTypes = event.getJSONArray("satisfiedEventsTypes");
        this.playerId = this.getOptionalValue(event, "playerId");
        this.minute = this.getOptionalValue(event, "minute");
    }
}
