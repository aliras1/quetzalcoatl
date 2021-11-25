package quetzalcoatl.caffapplication.caff.api;

import java.sql.Blob;

public class CaffFileDTO {
    private final long id;
    private final Blob caff;

    public CaffFileDTO( long id,Blob caff){
        this.id=id;
        this.caff=caff;
    }

    public long getId() {
        return id;
    }

    public Blob getCaff() {
        return caff;
    }

}
