package quetzalcoatl.caffapplication.caff.api;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import quetzalcoatl.caffapplication.auth_user.AuthUser;
import quetzalcoatl.caffapplication.auth_user.api.AuthenticatedUserResponseDTO;
import quetzalcoatl.caffapplication.base.auth.Role;
import quetzalcoatl.caffapplication.base.auth.RoleSecured;
import quetzalcoatl.caffapplication.caff.CaffFile;
import quetzalcoatl.caffapplication.caff.CaffRepository;

import javax.websocket.server.PathParam;
import java.util.Set;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/api/caff")
public class CaffFilesController {

    private final CaffRepository caffRepository;

    public CaffFilesController(CaffRepository caffRepository) {
        this.caffRepository = caffRepository;
    }

    @GetMapping("/getCaff/{id}")
    public CaffFile getAuthenticatedUser(@PathVariable("id") long id) {
        return caffRepository.getById(id);
    }

}
