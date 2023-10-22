package match;

import entity.*;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {
        Scanner sc = new Scanner(System.in);

        JSONOutput output = new JSONOutput();
        while (sc.hasNextLine()) {
            String json = sc.nextLine();
            JSONObject json_string = new JSONObject(json);
            if (json_string.has("matchCentreData") && !json_string.isNull("matchCentreData")) {
                MatchWrapper matchWrapper = new MatchWrapper(json_string);
                output.addMatchWrapper(matchWrapper);
            }
        }
        System.out.println(output.toJSON());
    }
}
