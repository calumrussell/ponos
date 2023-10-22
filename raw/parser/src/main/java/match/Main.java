package match;

import entity.*;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {

        JSONOutput output = new JSONOutput();
        for(String arg: args ) {
            JSONObject json_string = new JSONObject(arg);
            if (json_string.has("matchCentreData") && !json_string.isNull("matchCentreData")) {
                MatchWrapper matchWrapper = new MatchWrapper(json_string);
                output.addMatchWrapper(matchWrapper);
            }
        }
        System.out.println(output.toJSON());
    }
}
