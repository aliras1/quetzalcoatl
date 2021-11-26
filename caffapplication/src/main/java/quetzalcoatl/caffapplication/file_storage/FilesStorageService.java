package quetzalcoatl.caffapplication.file_storage;

import org.springframework.core.io.Resource;
import quetzalcoatl.caffapplication.parser.GifDto;

public interface FilesStorageService {
    void save(GifDto gifDto, String filename);

    Resource load(String filename);

    void deleteAll();
}
