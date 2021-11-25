package quetzalcoatl.caffapplication.caff;

import quetzalcoatl.caffapplication.base.AbstractEntity;

import javax.persistence.Entity;
import javax.persistence.Lob;

@Entity
public class CaffFile extends AbstractEntity {

    @Lob
    private byte[] caff;

    public byte[] getCaff() {
        return caff;
    }

    public void setCaff(byte[] caff) {
        this.caff = caff;
    }
}
