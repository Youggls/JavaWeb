package indi.RDY.JavaWeb.bean;
import java.sql.Timestamp;

public class Post extends TextContainer {
    private String postName;

    public Post() {
        super();
    }

    public Post(int id, int userId, String postName, String content, Timestamp time) {
        super(id, userId, content, time);
        this.postName = postName;

    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }
}
