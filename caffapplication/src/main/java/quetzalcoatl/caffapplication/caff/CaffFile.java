package quetzalcoatl.caffapplication.caff;

import quetzalcoatl.caffapplication.base.AbstractEntity;

import javax.persistence.Entity;

@Entity
public class CaffFile extends AbstractEntity {

    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
