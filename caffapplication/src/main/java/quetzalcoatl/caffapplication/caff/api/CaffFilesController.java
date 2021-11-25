package quetzalcoatl.caffapplication.caff.api;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;
import quetzalcoatl.caffapplication.auth_user.AuthUser;
import quetzalcoatl.caffapplication.auth_user.api.AuthenticatedUserResponseDTO;
import quetzalcoatl.caffapplication.base.auth.Role;
import quetzalcoatl.caffapplication.base.auth.RoleSecured;
import quetzalcoatl.caffapplication.caff.CaffFile;
import quetzalcoatl.caffapplication.caff.CaffRepository;

import javax.websocket.server.PathParam;
import java.awt.Image;
import java.util.Optional;
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
    public Resource get(@PathVariable("id") long id) {
        byte[] caff = caffRepository.findById(id).orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND)).getCaff();
        return new ByteArrayResource(caff);
    }
}
