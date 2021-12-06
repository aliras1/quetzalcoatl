package quetzalcoatl.caffapplication.file_storage;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import quetzalcoatl.caffapplication.parser.GifDto;

import java.io.ByteArrayInputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class FilesStorageServiceImpl implements FilesStorageService {

//    private final Path root = Paths.get("gifs"); // on windows
    private final Path root = Paths.get("/app/gifs");

    @Override
    public void save(GifDto gifDto, String filename) {
        try {
            Files.copy(new ByteArrayInputStream(gifDto.getGif()), this.root.resolve(filename + ".gif"));
        } catch (Exception e) {
            throw new RuntimeException("Could not store the file. Error: " + e.getMessage());
        }
    }

    @Override
    public Resource load(String filename) {
        try {
            Path file = root.resolve(filename);
            Resource resource = new UrlResource(file.toUri() + ".gif");

            if (resource.exists() || resource.isReadable()) {
                return resource;
            } else {
                throw new RuntimeException("Could not read the file!");
            }
        } catch (MalformedURLException e) {
            throw new RuntimeException("Error: " + e.getMessage());
        }
    }

    @Override
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(root.toFile());
    }
}
