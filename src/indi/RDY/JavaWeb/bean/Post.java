package indi.RDY.JavaWeb.bean;
import java.sql.Timestamp;

public class Post extends TextContainer {
    private String postName;

    public Post() {
        super();
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }
}
