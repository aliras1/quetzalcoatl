package quetzalcoatl.caffapplication.auth_user.api;

public class CreateUserRequestDTO {
    private String username;
    private String password;

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }
}
