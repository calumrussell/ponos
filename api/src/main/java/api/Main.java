package api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.core.JdbcTemplate;

@SpringBootApplication
public class Main {
    public static void main(String args[]) {
        SpringApplication.run(Main.class, args);
    }

    @Autowired
    MatchRepository matchRepository;

    @Bean
    public CommandLineRunner run() {
        return (args) -> {
            Iterable<Match> matches = matchRepository.findAll();
            for (Match match: matches) {
                System.out.println(match.getId());
            }
        };
    }
}