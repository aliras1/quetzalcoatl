package quetzalcoatl.caffapplication.parser;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Blob;
import java.util.Arrays;

public class Parser {
	private static byte[] dummyGif;
	{
		try {
			dummyGif =Files.readAllBytes(Paths.get("1.caff.gif"));
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	private static GifDto dummy = new GifDto(dummyGif, Arrays.asList(new CIFFMetadataDto("Beautiful scenery", Arrays.asList("landscape", "sunset", "mountains")), new CIFFMetadataDto("Beautiful scenery", Arrays.asList("landscape", "sunset", "mountains"))));
	
	
	public static GifDto parse(Blob caff) {
		return dummy;
	}
}
