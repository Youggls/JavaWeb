package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.*;

import java.util.*;
import java.sql.*;

public class SearchUtil {
    private Connection conn;

    public SearchUtil() {
        DbUtil dbUtil = new DbUtil();
        this.conn = dbUtil.getConnection();
    }

    public List<User> searchUser(String name) {
        String sql = "{call search_user_by_name(?)}";
        ArrayList<User> users = new ArrayList<>();
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setString(1, name);
            search.executeUpdate();
            addUserToList(users, search);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchUser(int id) {
        String sql = "{call search_user_by_id(?)}";
        ArrayList<User> users = new ArrayList<>();
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setInt(1, id);
            search.executeUpdate();
            addUserToList(users, search);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    public List<TextContainer> searchTextByUser(String nickName) {
        List<TextContainer> texts = new ArrayList<>();
        texts.addAll(searchPostByUser(nickName));
        texts.addAll(searchFloorByUser(nickName));
        texts.addAll(searchCommentByUser(nickName));
        Collections.sort(texts);
        return texts;
    }

    public List<Post> searchPostByUser(String nickName) {
        List<Post> posts = new ArrayList<>();
        String sql1 = "{call search_post_by_user(?)}";

        try {
            CallableStatement search = conn.prepareCall(sql1);
            search.setString(1, nickName);
            search.executeUpdate();
            addPostFromResult(posts, search);
            Collections.sort(posts);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public List<Floor> searchFloorByUser(String nickName) {
        List<Floor> floors = new ArrayList<>();
        String sql1 = "{call search_floor_by_user(?)}";

        return addFloorToList(nickName, floors, sql1);
    }

    public List<Comment> searchCommentByUser(String nickName) {
        List<Comment> comments = new ArrayList<>();
        String sql = "{call search_comment_by_user(?)}";
        String content;
        return addCommentsToList(nickName, comments, sql);
    }

    private List<Comment> addCommentsToList(String nickName, List<Comment> comments, String sql) {
        String content;
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setString(1, nickName);
            search.executeUpdate();
            ResultSet rs = search.getResultSet();
            while (rs.next()) {
                int id = rs.getInt("comment_id");
                int userId = rs.getInt("user_id");
                int rootFloorId = rs.getInt("root_floor_id");
                int preCommentId = rs.getInt("pre_comment_id");
                content = rs.getString("content");
                Timestamp commentTime = rs.getTimestamp("comment_time");
                boolean isDeleted = rs.getBoolean("isdeleted");
                comments.add(new Comment(id, userId, rootFloorId, preCommentId, content, commentTime, isDeleted));
            }
            Collections.sort(comments);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public List<Post> searchPostByTitle(String title) {
        List<Post> posts = new ArrayList<>();
        String sql = "{call search_post_by_post_name(?)}";
        return addPostToList(title, posts, sql);
    }

    public List<Post> searchPostByContent(String content) {
        List<Post> posts = new ArrayList<>();
        String sql = "{call search_post_by_content(?)}";
        return addPostToList(content, posts, sql);
    }

    public List<Floor> searchFloorByContent(String content) {
        List<Floor> floors = new ArrayList<>();
        String sql = "{call search_floor_by_content(?)}";
        return addFloorToList(content, floors, sql);
    }

    public List<Comment> searchCommentByContent(String content) {
        List<Comment> comments = new ArrayList<>();
        String sql = "{call search_comment_by_content(?)}";
        return addCommentsToList(content, comments, sql);
    }
    private void addUserToList(ArrayList<User> users, CallableStatement search) throws SQLException {
        ResultSet rs = search.getResultSet();
        while (rs.next()) {
            int id = rs.getInt("id");
            String nickName = rs.getString("nickname");
            String profilePhoto = rs.getString("profile_photo_url");
            Timestamp registeredTime = rs.getTimestamp("registered_time");
            int type = User.phraseType(rs.getString("type"));
            User user = new User(id, nickName, profilePhoto, type, registeredTime);
            users.add(user);
        }
    }

    private List<Post> addPostToList(String content, List<Post> posts, String sql) {
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setString(1, content);
            addPostFromResult(posts, search);
            Collections.sort(posts);
        }
        catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    private List<Floor> addFloorToList(String content, List<Floor> floors, String sql) {
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setString(1, content);
            search.executeUpdate();
            addFloorToList(floors, search);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return floors;
    }


    private void addFloorToList(List<Floor> floors, CallableStatement search) throws SQLException {
        ResultSet rs = search.getResultSet();
        while (rs.next()) {
            int id = rs.getInt("floor_id");
            int floorNum = rs.getInt("floor_num");
            int parentPostId = rs.getInt("parent_post_id");
            int userId = rs.getInt("user_id");
            String floorContent = rs.getString("floor_content");
            Timestamp time = rs.getTimestamp("floor_time");
            floors.add(new Floor(id, floorNum, parentPostId, userId, floorContent, time));
        }
        Collections.sort(floors);
    }

    private void addPostFromResult(List<Post> posts, CallableStatement search) throws SQLException {
        ResultSet rs = search.getResultSet();
        while (rs.next()) {
            int id = rs.getInt("post_id");
            int userId = rs.getInt("user_id");
            String postName = rs.getString("post_name");
            String content = rs.getString("content");
            Timestamp postTime = rs.getTimestamp("post_time");
            posts.add(new Post(id, userId, postName, content, postTime));
        }
    }
}
