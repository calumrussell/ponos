package match;

import org.aspectj.apache.bcel.classfile.ExceptionTable;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import java.util.Scanner;

@SpringBootApplication
@EnableJpaRepositories(basePackageClasses = MatchRepository.class)
public class Main implements CommandLineRunner {
    @Autowired
    MatchRepository matchRepository;

    @Autowired
    TeamStatsRepository teamStatsRepository;

    public static void main(String[] args) {
        SpringApplication.run(Main.class, args);
    }

    @Override
    public void run(String... strings) throws Exception {
        Scanner sc = new Scanner(System.in);
        while (sc.hasNextLine()) {
            String json = sc.nextLine();
            JSONObject json_string = new JSONObject(json);
            MatchFacade matchFacade = new MatchFacade(json_string);
            try {
                matchRepository.save(matchFacade.toMatchOutput());
            } catch (Exception e) {
                System.out.println(e);
            }
            try {
                teamStatsRepository.save(matchFacade.toHomeTeamStatsOutput());
            } catch (Exception e) {
                System.out.println(e);
            }
            try {
                teamStatsRepository.save(matchFacade.toAwayTeamStatsOutput());
            } catch (Exception e) {
                System.out.println(e);
            }
            //MatchOutput out = new MatchOutput(match);
            //matchRepository.save(out);
        }
    }
}