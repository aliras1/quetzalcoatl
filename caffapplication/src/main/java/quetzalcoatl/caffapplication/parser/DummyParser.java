package quetzalcoatl.caffapplication.parser;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Arrays;

public class DummyParser {
	private static byte[][] dummyGifs = new byte[8][];
	static boolean inited = false;
	private static void init()
	{
		try {
			for (int i = 0; i < dummyGifs.length; i++) {
				dummyGifs[i] =Files.readAllBytes(Paths.get("gifs/h"+i+".gif"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	private static GifDto dummy = new GifDto("", dummyGifs[0], Arrays.asList(new CIFFMetadataDto("Beautiful scenery", Arrays.asList("landscape", "sunset", "mountains")), new CIFFMetadataDto("Beautiful scenery", Arrays.asList("landscape", "sunset", "mountains"))));
	
	
	public static GifDto parse(Blob caff) {
		if(!inited) {
			init();
		}
		try {
			int i =(int)caff.getBytes(100, 1)[0];
			dummy.setGif(dummyGifs[i]);
		} catch (SQLException e) {
			e.printStackTrace();
			//
		}
		return dummy;
	}
}
