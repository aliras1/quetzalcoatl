package quetzalcoatl.caffapplication.caff.api;

import quetzalcoatl.caffapplication.caff.CaffFile;

public class SearchCaffByNameResponseDTO {
    private final Long id;
    private final String title;

    public SearchCaffByNameResponseDTO(CaffFile caffFile) {
        this.id = caffFile.getId();
        this.title = caffFile.getTitle();
    }

    public Long getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }
}
