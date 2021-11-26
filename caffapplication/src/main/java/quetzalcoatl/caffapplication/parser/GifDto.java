package quetzalcoatl.caffapplication.parser;

import java.util.ArrayList;
import java.util.List;

public class GifDto {
	private final byte[] gif;
	private final List<CIFFMetadataDto> metadatas;
	public GifDto(byte[] gif, List<CIFFMetadataDto> metadatas) {
		super();
		this.gif = gif;
		this.metadatas = metadatas;
	}
	public byte[] getGif() {
		return gif;
	}
	public List<CIFFMetadataDto> getMetadatas() {
		return new ArrayList<> (metadatas);
	}
	
}
