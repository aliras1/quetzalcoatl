package quetzalcoatl.caffapplication.auth_user.api;
import quetzalcoatl.caffapplication.auth_user.AuthUser;
import quetzalcoatl.caffapplication.base.auth.Role;

import java.util.Set;

public class AuthenticatedUserResponseDTO {
    private final Long userId;
    private final Set<Role> roles;
    private final String username;

    public AuthenticatedUserResponseDTO(AuthUser loggedInUser, Set<Role> roles) {
        this.userId = loggedInUser.getId();
        this.username = loggedInUser.getUsername();
        this.roles = roles;
    }

    public Long getUserId() {
        return userId;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public String getUsername() {
        return username;
    }
}
