package quetzalcoatl.caffapplication.caff;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CaffRepository extends JpaRepository<CaffFile, Long> {
    //
}
