package indi.RDY.JavaWeb.bean;
import java.sql.Timestamp;

public class Post extends TextContainer {
    private String postName;
    private String text;

    public Post() {
        super();
    }

    public Post(int id, int userId, String postName, String content, Timestamp time) {
        super(id, userId, content, time);
        this.postName = postName;
        this.text = super.getContent().replaceAll("</?[^>]+>", "");
        this.text = this.text.replaceAll("<a>\\s*|\t|\r|\n</a>", "");
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getText() {
        if (text.length() <= 100) return text;
        else return text.substring(0, 100);
    }
}
