package match;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jooq.DSLContext;
import org.jooq.SQLDialect;
import org.jooq.generated.tables.records.*;
import org.jooq.impl.DSL;
import org.json.JSONObject;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.Scanner;
import java.util.Vector;

public class Main {
    public static void main(String[] args) throws IOException {
        Scanner sc = new Scanner(System.in);

        Vector<MatchRecord> matches = new Vector<>();
        Vector<TeamStatsRecord> teamStats = new Vector<>();
        Vector<PlayerStatsRecord> playerStats = new Vector<>();
        Vector<TeamRecord> teams = new Vector<>();
        Vector<PlayerRecord> players = new Vector<>();
        while (sc.hasNextLine()) {
            String json = sc.nextLine();
            JSONObject json_string = new JSONObject(json);
            if (json_string.has("matchCentreData") && !json_string.isNull("matchCentreData")) {
                MatchWrapper matchWrapper = new MatchWrapper(json_string);
                System.out.println(matchWrapper.getMatchId());
                matches.add(matchWrapper.toMatchOutput());
                teamStats.add(matchWrapper.toHomeTeamStatsOutput());
                teamStats.add(matchWrapper.toAwayTeamStatsOutput());
                playerStats.addAll(matchWrapper.toPlayerStatsOutput());
                teams.addAll(matchWrapper.toTeamOutput());
                players.addAll(matchWrapper.toPlayerOutput());
            }
        }

        Properties props = new Properties();
        props.load(new FileInputStream("src/main/resources/application.properties"));
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(props.getProperty("db.url"));
        HikariDataSource dataSource = new HikariDataSource(config);

        DSLContext dslContext = DSL.using(dataSource, SQLDialect.POSTGRES);

        dslContext.batchMerge(matches).execute();
        dslContext.batchMerge(teamStats).execute();
        dslContext.batchMerge(playerStats).execute();
        dslContext.batchMerge(teams).execute();
        dslContext.batchMerge(players).execute();
    }
}