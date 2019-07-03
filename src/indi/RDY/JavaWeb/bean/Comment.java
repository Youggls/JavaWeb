package indi.RDY.JavaWeb.bean;
import java.sql.Date;
public class Comment extends TextContainer {
    private int rootFloorId;
    private int preCommentId;
    private boolean isDeleted;

    public Comment() {
        super();
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


    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
    }
}
