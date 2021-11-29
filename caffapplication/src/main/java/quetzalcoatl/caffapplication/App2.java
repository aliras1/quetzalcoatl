package quetzalcoatl.caffapplication;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.google.gson.Gson;

import quetzalcoatl.caffapplication.parser.GifDto;
import quetzalcoatl.caffapplication.parser.Parser;

/**
 * Hello world!
 *
 */
public class App2 
{
    
	public static void main( String[] args ) throws IOException, SQLException, InterruptedException
    {		
		var gif =Parser.parse(null);
		
		System.out.println(new String(Arrays.copyOfRange(gif.getGif(), 0, 4)));
		System.out.println(gif.getGif().length);
    }
}
