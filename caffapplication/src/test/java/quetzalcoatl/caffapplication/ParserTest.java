package quetzalcoatl.caffapplication;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Arrays;

import javax.sql.rowset.serial.SerialException;

import org.junit.jupiter.api.Test;

import quetzalcoatl.caffapplication.parser.Parser;

class ParserTest {
	@Test
	void parserTest() throws IOException, SerialException, SQLException, InterruptedException {
		var pd =Paths.get("C:\\Users\\arkos\\git\\quetzalcoatl\\caffapplication\\2.caff");
		var dummyCaff = Files.readAllBytes(pd);
		
		byte[] bytes = dummyCaff;
		Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
		var gif =Parser.parse(blob);
		assertNotNull(gif);
		assertEquals("GIF89", new String(Arrays.copyOfRange(gif.getGif(), 0, 4)));
		assertNotEquals(0,gif.getGif().length);
	}
}
