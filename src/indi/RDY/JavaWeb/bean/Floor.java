package indi.RDY.JavaWeb.bean;
import java.sql.Date;
import java.sql.Timestamp;


public class Floor extends TextContainer {
    private int floorNum;
    private int parentPostId;

    public Floor() {
        super();
    }

    public Floor(int id, int floorNum, int parentPostId, int userId, String content, Timestamp time) {
        super(id, userId, content, time);
        this.floorNum = floorNum;
        this.parentPostId = parentPostId;
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
