package quetzalcoatl.caffapplication;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Arrays;

import quetzalcoatl.caffapplication.parser.Parser;

/**
 * Hello world!
 *
 */
public class App2 
{
    
	public static void main( String[] args ) throws IOException, SQLException, InterruptedException
	{
		var pd =Paths.get("C:\\Users\\arkos\\git\\quetzalcoatl\\caffapplication\\2.caff");
		var dummyCaff = Files.readAllBytes(pd);
		
		byte[] bytes = dummyCaff;
		Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
		var gif =Parser.parse(blob);
		
		System.out.println(new String(Arrays.copyOfRange(gif.getGif(), 0, 4)));
		System.out.println(gif.getGif().length);
    }
}
