package quetzalcoatl.caffapplication.caff;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CaffRepository extends JpaRepository<CaffFile, Long> {
    //
}
