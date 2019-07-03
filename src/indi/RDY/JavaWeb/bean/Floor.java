package indi.RDY.JavaWeb.bean;
import java.sql.Date;


public class Floor {
    private int floorId;
    private int floorNum;
    private int parentPostId;
    private int userId;
    private String floorContent;
    private Date floorTime;

    public Floor(){

    }

    public int getFloorId() {
        return floorId;
    }

    public void setFloorId(int floorId) {
        this.floorId = floorId;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFloorContent() {
        return floorContent;
    }

    public void setFloorContent(String floorContent) {
        this.floorContent = floorContent;
    }

    public Date getFloorTime() {
        return floorTime;
    }

    public void setFloorTime(Date floorTime) {
        this.floorTime = floorTime;
    }
}
