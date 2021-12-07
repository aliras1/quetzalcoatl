package quetzalcoatl.caffapplication.parser;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;
import java.util.stream.Collectors;

import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component("parser")
public class Parser {
	private final Set<String> underProcess = new HashSet<>();
	private final Random random = new Random();
	private final Path tmpFolder = Paths.get("./tmp");

	@Value("${environment.parser}")
	private String caffParserPath;

	public Parser() {
		cleanup();
	}

	public GifDto parse(Blob caff) throws IOException, SQLException, InterruptedException {
		createTmpFolder();
		
		String filename = getUniqueTmpFileName();
		
		
		Path caffPath = tmpFolder.resolve(filename + ".caff");
		
		
		String rawJson = runParser(caff, caffPath);
		
		Gson gson = new Gson();
		GifDto ret = gson.fromJson(rawJson, GifDto.class);
		Path gifPath = Paths.get(ret.getPath());
		ret.setGif(Files.readAllBytes(gifPath));
		
		Files.delete(gifPath);
		Files.delete(caffPath);
		underProcess.remove(filename);
		return ret;
	}

	private String runParser(Blob caff, Path caffPath) throws IOException, SQLException, InterruptedException {
		Files.write(caffPath, caff.getBinaryStream().readAllBytes());

		System.out.println(System.getProperty("user.dir"));
		ProcessBuilder pb = new ProcessBuilder(caffParserPath, caffPath.toString());
		Process p = pb.start();
		BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));

		String rawJson = br.readLine();
		p.waitFor();
		return rawJson;
	}

	private String getUniqueTmpFileName() {
		String filename;
		synchronized (underProcess) {
			do {
				filename = String.valueOf(random.nextInt(100000000));
			} while (underProcess.contains(filename));
			underProcess.add(filename);
		}
		return filename;
	}
	
	public void createTmpFolder() {
		if(!Files.exists(tmpFolder)) {
			try {
				Files.createDirectories(tmpFolder);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public void cleanup() {
		createTmpFolder();
		try (var stream = Files.list(tmpFolder)) {
			stream.filter(file -> !Files.isDirectory(file)).collect(Collectors.toSet()).forEach(f -> {
				try {
					Files.delete(f);
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
