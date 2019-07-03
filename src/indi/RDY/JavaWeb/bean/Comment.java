package indi.RDY.JavaWeb.bean;
import java.sql.Date;
public class Comment {
    private int commentId;
    private int userId;
    private int rootFloorId;
    private int preCommentId;
    private String content;
    private Date commentTime;
    private boolean isDeleted;

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRootFloorId() {
        return rootFloorId;
    }

    public void setRootFloorId(int rootFloorId) {
        this.rootFloorId = rootFloorId;
    }

    public int getPreCommentId() {
        return preCommentId;
    }

    public void setPreCommentId(int preCommentId) {
        this.preCommentId = preCommentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }
}
