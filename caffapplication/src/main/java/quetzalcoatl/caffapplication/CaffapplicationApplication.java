package quetzalcoatl.caffapplication;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration;

import quetzalcoatl.caffapplication.parser.Parser;

@SpringBootApplication(exclude = UserDetailsServiceAutoConfiguration.class)
public class CaffapplicationApplication {

	public static void main(String[] args) {
		Parser.cleanup();
		SpringApplication.run(CaffapplicationApplication.class, args);
	}

}
