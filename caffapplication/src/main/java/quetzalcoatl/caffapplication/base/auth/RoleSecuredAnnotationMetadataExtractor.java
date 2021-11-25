package quetzalcoatl.caffapplication.base.auth;

import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.access.annotation.AnnotationMetadataExtractor;

import java.util.Arrays;
import java.util.Collection;
import java.util.stream.Collectors;

public class RoleSecuredAnnotationMetadataExtractor implements AnnotationMetadataExtractor<RoleSecured> {

    public Collection<ConfigAttribute> extractAttributes(RoleSecured annotation) {
        return Arrays.stream(annotation.value()).map(Role::name).map(SecurityConfig::new).collect(Collectors.toSet());
    }
}
