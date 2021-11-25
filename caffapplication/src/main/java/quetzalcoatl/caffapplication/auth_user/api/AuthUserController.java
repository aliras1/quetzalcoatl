package quetzalcoatl.caffapplication.auth_user.api;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import quetzalcoatl.caffapplication.auth_user.AuthUser;
import quetzalcoatl.caffapplication.auth_user.AuthUserRepository;
import quetzalcoatl.caffapplication.auth_user.AuthUserService;
import quetzalcoatl.caffapplication.base.auth.Role;
import quetzalcoatl.caffapplication.base.auth.RoleSecured;

import java.util.Set;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/users")
public class AuthUserController {

    private final AuthUserRepository authUserRepository;
    private final AuthUserService authUserService;

    public AuthUserController(AuthUserRepository authUserRepository, AuthUserService authUserService) {
        this.authUserRepository = authUserRepository;
        this.authUserService = authUserService;
    }

    @GetMapping("/getAuthenticatedUser")
    @RoleSecured({})
    public AuthenticatedUserResponseDTO getAuthenticatedUser(Authentication authentication) {
        UserDetails principal = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        AuthUser loggedInUser = authUserRepository.findByUsername(principal.getUsername()).orElseThrow(
                        () -> new RuntimeException("Logged user not present in database"));
        Set<Role> roles = authentication.getAuthorities().stream().map(ga -> Role.valueOf(ga.getAuthority())).collect(Collectors.toSet());
        return new AuthenticatedUserResponseDTO(loggedInUser, roles);
    }

    @PostMapping
    public ResponseEntity<Object> post(@RequestBody CreateUserRequestDTO requestDTO) {
        authUserService.create(requestDTO);
        return ResponseEntity.ok().build();
    }

}
