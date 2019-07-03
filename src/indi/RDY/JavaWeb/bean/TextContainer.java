package indi.RDY.JavaWeb.bean;

import java.sql.Timestamp;

public class TextContainer {
    private int id;
    private int userId;
    private String content;
    private Timestamp time;

    public TextContainer() {

    }

    public void setId(int id) {
        this.id = id;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public String getContent() {
        return content;
    }

    public Timestamp getTime() {
        return time;
    }
}