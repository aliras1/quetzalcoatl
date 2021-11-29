package quetzalcoatl.caffapplication.parser;

import java.util.ArrayList;
import java.util.List;

public class GifDto {
	public GifDto(String path, byte[] gif, List<CIFFMetadataDto> ciffs) {
		super();
		this.path = path;
		this.gif = gif;
		this.ciffs = ciffs;
	}
	private final String path;
	public String getPath() {
		return path;
	}
	public void setGif(byte[] gif) {
		this.gif = gif;
	}
	public List<CIFFMetadataDto> getCiffs() {
		return ciffs;
	}
	private byte[] gif;
	private final List<CIFFMetadataDto> ciffs;
	public byte[] getGif() {
		return gif;
	}
	public List<CIFFMetadataDto> getMetadatas() {
		return new ArrayList<> (ciffs);
	}
}
