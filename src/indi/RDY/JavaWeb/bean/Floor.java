package indi.RDY.JavaWeb.bean;
import java.sql.Date;


public class Floor extends TextContainer {
    private int floorNum;
    private int parentPostId;

    public Floor() {
        super();
    }


    public int getFloorNum() {
        return floorNum;
    }

    public void setFloorNum(int floorNum) {
        this.floorNum = floorNum;
    }

    public int getParentPostId() {
        return parentPostId;
    }

    public void setParentPostId(int parentPostId) {
        this.parentPostId = parentPostId;
    }
}
