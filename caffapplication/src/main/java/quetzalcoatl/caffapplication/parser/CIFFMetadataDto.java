package quetzalcoatl.caffapplication.parser;

import java.util.ArrayList;
import java.util.List;

public class CIFFMetadataDto {
	private final String caption;
	private final List<String> tags;
	public CIFFMetadataDto(String caption, List<String> tags) {
		super();
		this.caption = caption;
		this.tags = tags;
	}
	public String getCaption() {
		return caption;
	}
	public List<String> getTags() {
		return new ArrayList<>(tags);
	}
	
}
