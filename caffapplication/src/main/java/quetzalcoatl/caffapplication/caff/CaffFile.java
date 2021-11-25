package quetzalcoatl.caffapplication.caff;

import quetzalcoatl.caffapplication.base.AbstractEntity;

import javax.persistence.Entity;
import java.sql.Blob;

@Entity
public class CaffFile extends AbstractEntity {
    private Blob caff;


}
