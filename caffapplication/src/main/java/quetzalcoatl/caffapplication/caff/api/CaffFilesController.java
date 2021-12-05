package quetzalcoatl.caffapplication.caff.api;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

import javax.sql.rowset.serial.SerialBlob;

import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import quetzalcoatl.caffapplication.caff.CaffFile;
import quetzalcoatl.caffapplication.caff.CaffRepository;
import quetzalcoatl.caffapplication.file_storage.FilesStorageService;
import quetzalcoatl.caffapplication.parser.GifDto;
import quetzalcoatl.caffapplication.parser.Parser;

@RestController
@RequestMapping("/api/caff")
public class CaffFilesController {

    private final CaffRepository caffRepository;
    private final FilesStorageService filesStorageService;

    public CaffFilesController(CaffRepository caffRepository, FilesStorageService filesStorageService) {
        this.caffRepository = caffRepository;
        this.filesStorageService = filesStorageService;
    }

    @GetMapping("/getCaff/{id}")
    public Resource get(@PathVariable("id") Long id) {
        return filesStorageService.load(id.toString());
    }

    @PostMapping(consumes =  {MediaType.MULTIPART_FORM_DATA_VALUE})
    public void uploadImage(@RequestPart("caffFile") MultipartFile caff, @RequestPart("title") String title) throws IOException, SQLException, InterruptedException {
        CaffFile caffFile = new CaffFile();
        GifDto gif = Parser.parse(new SerialBlob(caff.getBytes()));
        caffFile.setTitle(title);
        filesStorageService.save(gif, Objects.requireNonNull(caffRepository.saveAndFlush(caffFile).getId()).toString());
    }
}
