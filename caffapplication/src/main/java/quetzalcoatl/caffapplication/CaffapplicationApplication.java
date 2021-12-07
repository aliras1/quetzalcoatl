package quetzalcoatl.caffapplication;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.UserDetailsServiceAutoConfiguration;

import quetzalcoatl.caffapplication.parser.Parser;

@SpringBootApplication(exclude = UserDetailsServiceAutoConfiguration.class)
public class CaffapplicationApplication {
	public static void main(String[] args) {
		SpringApplication.run(CaffapplicationApplication.class, args);
	}

}
