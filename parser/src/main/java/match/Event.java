package match;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

public class Event {

    private JSONArray eventTypes;
    private Optional<Integer> playerId;
    private Optional<Integer> minute;

    private boolean checkType(List<String> types) {
        for (Object eventTypeRaw : this.eventTypes) {
            Integer eventType = (Integer) eventTypeRaw;
            String eventName = EventMapping.eventIdMap.get(eventType);
            if (types.contains(eventName)){
                return true;
            }
        }
        return false;
    }

    protected boolean isPass() {
        //Checking against names is potentially more buggy but it is far more readable
        return checkType(List.of(
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
    }

    protected boolean isPassCorner() {
        return checkType(List.of("passCorner"));
    }

    protected boolean isPassLongball() {
        return checkType(List.of(
                "passLongBallAccurate",
                "passLongBallInaccurate"
        ));
    }

    protected boolean isPassCross() {
        return checkType(List.of(
                "passCrossAccurate",
                "passCrossInaccurate"
        ));
    }

    protected boolean isPassBack() {
        return checkType(List.of(
                "passBack"
        ));
    }

    protected boolean isPassForward() {
        return checkType(List.of(
                "passForward"
                ));
    }

    protected boolean isPassLeft() {
        return checkType(List.of(
                "passLeft"
        ));
    }

    protected boolean isPassRight() {
        return checkType(List.of(
                "passRight"
        ));
    }

    protected boolean isPassShort() {
        return checkType(List.of(
                "shortPassAccurate",
                "shortPassInaccurate"
        ));
    }

    protected boolean isPassThroughball() {
        return checkType(List.of(
                "passThroughBallAccurate",
                "passThroughBallInaccurate",
                "passThroughBallInacurate"
        ));
    }

    protected boolean isPassAccurate() {
        return checkType(List.of(
                "passAccurate"
        ));
    }

    protected boolean isPassShortAccurate() {
        return checkType(List.of(
                "shortPassAccurate"
        ));
    }

    protected boolean isPassCornerAccurate() {
        return checkType(List.of(
                "passCornerAccurate"
        ));
    }

    protected boolean isPassLongballAccurate() {
        return checkType(List.of(
                "passLongBallAccurate"
        ));
    }

    protected boolean isPassCrossAccurate() {
        return checkType(List.of(
                "passCrossAccurate"
        ));
    }

    protected boolean isPassThroughballAccurate() {
        return checkType(List.of(
                "passThroughBallAccurate"
        ));
    }

    protected boolean isPassKey() {
        return checkType(List.of(
                "keyPassShort",
                "keyPassCross",
                "keyPassCorner",
                "keyPassThroughball",
                "keyPassFreekick",
                "keyPassThrowin",
                "keyPassOther"
        ));
    }

    protected boolean isPassKeyCross() {
        return checkType(List.of(
                "keyPassCross"
        ));
    }

    protected boolean isPassKeyFreekick() {
        return checkType(List.of(
                "keyPassFreekick"
                ));
    }

    protected boolean isPassKeyCorner() {
        return checkType(List.of(
                "keyPassCorner"
        ));
    }

    protected boolean isPassKeyThroughball() {
        return checkType(List.of(
                "keyPassThroughball"
        ));
    }

    protected boolean isShot() {
        return checkType(List.of("shotsTotal"));
    }

    protected boolean isShotOnTarget() {
        return checkType(List.of(
                "shotOnPost",
                "shotOnTarget"
        ));
    }

    protected boolean isShotOffTarget() {
        return checkType(List.of(
                "shotOffTarget"
        ));
    }

    protected boolean isShotBlocked() {
        return checkType(List.of(
                "shotBlocked"
        ));
    }

    protected boolean isShotOpenPlay() {
        return checkType(List.of(
                "shotOpenPlay"
        ));
    }

    protected boolean isShotSetPiece() {
        return checkType(List.of(
                "shotSetPiece"
        ));
    }

    protected boolean isShotOnPost() {
        return checkType(List.of(
                "shotOnPost"
        ));
    }

    protected boolean isShotSixYardBox() {
        return checkType(List.of(
                "shotSixYardBox"
        ));
    }

    protected boolean isShotPenaltyArea() {
        return checkType(List.of(
                "shotPenaltyArea"
        ));
    }

    protected boolean isShotBox() {
        return checkType(List.of(
                "shotBoxTotal"
        ));
    }

    protected boolean isShotCounter() {
        return checkType(List.of(
                "shotCounter"
        ));
    }

    protected boolean isShotHead() {
        return checkType(List.of(
                "shotCounter"
        ));
    }

    protected boolean isShotFoot() {
        return checkType(List.of(
                "shotRightFoot",
                "shotLeftFoot"
        ));
    }

    protected boolean isShot0bp() {
        return checkType(List.of(
                "shot0bp"
        ));
    }

    protected boolean isGoal() {
        return checkType(List.of(
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
    }

    protected boolean isGoalNormal() {
        return checkType(List.of(
                "goalNormal"
        ));
    }

    protected boolean isGoalHead() {
        return checkType(List.of(
                "goalHead"
        ));
    }

    protected boolean isGoalFoot() {
        return checkType(List.of(
                "goalRightFoot",
                "goalLeftFoot"
        ));
    }

    protected boolean isGoalSetPiece() {
        return checkType(List.of(
                "goalSetPiece"
        ));
    }

    protected boolean isGoalOwn() {
        return checkType(List.of(
                "goalOwn"
        ));
    }

    protected boolean isGoalCounter() {
        return checkType(List.of(
                "goalCounter"
        ));
    }

    protected boolean isGoalOpenPlay() {
        return checkType(List.of(
                "goalOpenPlay"
        ));
    }

    protected boolean isGoal0bp() {
        return checkType(List.of(
                "goal0bp"
        ));
    }

    protected boolean isGoal0box() {
        return checkType(List.of(
                "goal0box"
        ));
    }

    protected boolean isGoalSixYardBox() {
        return checkType(List.of(
                "goalSixYardBox"
        ));
    }

    protected boolean isGoalPenaltyArea() {
        return checkType(List.of(
                "goalPenaltyArea"
        ));
    }

    protected boolean isAssist() {
        return checkType(List.of(
                "assistCross",
                "assistCorner",
                "assistThroughball",
                "assistFreekick",
                "assistThrowin",
                "assistOther"
        ));
    }

    protected boolean isAssistCross() {
        return checkType(List.of(
                "assistCross"
        ));
    }

    protected boolean isAssistCorner() {
        return checkType(List.of(
                "assistCorner"
                ));
    }

    protected boolean isAssistThroughBall() {
        return checkType(List.of(
                "assistThroughball"
        ));
    }

    protected boolean isAerialDuel() {
        return checkType(List.of(
                "duelAerialWon",
                "duelAerialLost"
        ));
    }

    protected boolean isRedCard() {
        return checkType(List.of(
                "redCard"
        ));
    }

    protected boolean isYellowCard() {
        //Also have void category
        return checkType(List.of(
                "yellowCard"
        ));
    }

    protected boolean isSecondYellowCard() {
        //Also have void category
        return checkType(List.of(
                "secondYellow"
        ));
    }

    protected boolean isSave() {
        return checkType(List.of(
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
    }

    protected boolean isDuel() {
        return checkType(List.of(
                "offensiveDuel",
                "defensiveDuel"
        ));
    }

    protected boolean isDuelOffensive() {
        return checkType(List.of("offensiveDuel"));
    }

    protected boolean isDuelDefensive() {
        return checkType(List.of("defensiveDuel"));
    }

    protected boolean isDispossessed() {
        return checkType(List.of(
                "dispossessed"
        ));
    }

    protected boolean isTurnover() {
        return checkType(List.of(
                "turnover"
        ));
    }

    protected boolean isDribble() {
        return checkType(List.of(
                "dribbleWon",
                "dribbleLost"
        ));
    }

    protected boolean isDribbleWon() {
        return checkType(List.of(
                "dribbleWon"
        ));
    }

    protected boolean isDribbleLost() {
        return checkType(List.of(
                "dribbleLost"
        ));
    }

    protected boolean isDribbleLastMan() {
        return checkType(List.of(
                "dribbleLastman"
        ));
    }

    protected boolean isChallengeLost() {
        return checkType(List.of(
                "challengeLost"
        ));
    }

    protected boolean isBlockedCross() {
        return checkType(List.of(
                "passCrossBlockedDefensive"
        ));
    }

    protected boolean isBlockOutfielder() {
        return checkType(List.of(
                "outfielderBlock"
        ));
    }

    protected boolean isBlockSixYard() {
        return checkType(List.of(
                "sixYardBlock"
        ));
    }

    protected boolean isBlockPassOutfielder() {
        return checkType(List.of(
                "passCrossBlockedDefensive"
        ));
    }

    protected boolean isInterception() {
        return checkType(List.of(
                "interceptionAll"
        ));
    }

    protected boolean isInterceptionWon() {
        return checkType(List.of(
                "interceptionWon"
        ));
    }

    protected boolean isInterceptionInBox() {
        return checkType(List.of(
                "interceptionIntheBox"
        ));
    }

    protected boolean isTackle() {
        return checkType(List.of(
                "tackleWon",
                "tackleLost"
        ));
    }

    protected boolean isTackleWon() {
        return checkType(List.of(
                "tackleWon"
        ));
    }

    protected boolean isTackleLost() {
        return checkType(List.of(
                "tackleLost"
        ));
    }

    protected boolean isTackleLastMan() {
        return checkType(List.of(
                "tackleLastMan"
        ));
    }

    protected boolean isOffsideGiven() {
        return checkType(List.of(
                "offsideGiven"
        ));
    }

    protected boolean isOffsideProvoked() {
        return checkType(List.of(
                "offsideProvoked"
        ));
    }

    protected boolean isBallRecovery() {
        return checkType(List.of(
                "ballRecovery"
        ));
    }

    protected boolean isClearance() {
        return checkType(List.of(
                "clearanceTotal"
        ));
    }

    protected boolean isClearanceEffective() {
        return checkType(List.of(
                "clearanceEffective"
        ));
    }

    protected boolean isClearanceOffLine() {
        return checkType(List.of(
                "clearanceOffTheLine"
        ));
    }

    protected boolean isErrorLeadsToGoal() {
        return checkType(List.of(
                "errorLeadsToGoal"
        ));
    }

    protected boolean isErrorLeadsToShot() {
        return checkType(List.of(
                "errorLeadsToShot"
        ));
    }

    protected boolean isTouch() {
        return checkType(List.of(
                "touches"
        ));
    }

    protected boolean isPenaltyWon() {
        return checkType(List.of(
                "penaltyWon"
        ));
    }

    protected boolean isPenaltyConceded() {
        return checkType(List.of(
                "penaltyConceded"
        ));
    }

    protected boolean isPenaltyScored() {
        return checkType(List.of(
                "penaltyScored"
        ));
    }

    protected boolean isBigChangeCreated() {
        return checkType(List.of(
                "bigChanceCreated"
        ));
    }

    protected boolean isBigChangeScored() {
        return checkType(List.of(
                "bigChanceScored"
        ));
    }

    protected boolean isBigChangeMissed() {
        return checkType(List.of(
                "bigChanceMissed"
        ));
    }

    protected boolean isParriedSafe() {
        return checkType(List.of(
                "parriedSafe"
        ));
    }

    protected boolean isParriedDanger() {
        return checkType(List.of(
                "parriedDanger"
        ));
    }

    protected boolean isSaveKeeper() {
        return checkType(List.of(
                "keeperSaveTotal"
        ));
    }

    protected boolean isSubbedOn() {
        return checkType(List.of(
                "subOn"
        ));
    }

    protected boolean isSubbedOff() {
        return checkType(List.of(
                "subOff"
        ));
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
