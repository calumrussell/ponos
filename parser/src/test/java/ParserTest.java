import match.Match;
import org.json.JSONObject;
import org.junit.jupiter.api.Test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

public class ParserTest {

    @Test
    public void testParse() throws IOException {
        String fileName = "match.json";

        ClassLoader loader = getClass().getClassLoader();
        InputStream is = loader.getResourceAsStream(fileName);
        InputStreamReader rd = new InputStreamReader(is, StandardCharsets.UTF_8);
        BufferedReader reader = new BufferedReader(rd);

        String line = reader.readLine();
        JSONObject match = new JSONObject(line);
        Match formattedMatch = new Match(match);
        System.out.println(formattedMatch.getPassMap());
        assert true == false;
    }
}
