package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.*;
import org.omg.CORBA.CODESET_INCOMPATIBLE;

import java.util.*;
import java.sql.*;

abstract public class SearchUtil {

    public static List<User> searchUser(String name, Connection conn) {
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

    public static List<User> searchUser(int id, Connection conn) {
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

    public static List<TextContainer> searchTextByUser(String nickName, Connection conn) {
        List<TextContainer> texts = new ArrayList<>();
        texts.addAll(searchPostByUser(nickName, conn));
        texts.addAll(searchFloorByUser(nickName, conn));
        texts.addAll(searchCommentByUser(nickName, conn));
        Collections.sort(texts);
        return texts;
    }

    //Only return the post and floor
    public static List<TextContainer> searchTextByContentAndTitle(String content, Connection conn) {
        List<TextContainer> texts = new ArrayList<>();
        texts.addAll(searchPostByContent(content, conn));
        texts.addAll(searchPostByTitle(content, conn));
        texts.addAll(searchFloorByContent(content, conn));
        return texts;
    }

    public static List<Post> searchPostByUser(String nickName, Connection conn) {
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

    public static List<Floor> searchFloorByUser(String nickName, Connection conn) {
        List<Floor> floors = new ArrayList<>();
        String sql1 = "{call search_floor_by_user(?)}";

        return addFloorToList(nickName, floors, sql1, conn);
    }

    public static List<Comment> searchCommentByUser(String nickName, Connection conn) {
        List<Comment> comments = new ArrayList<>();
        String sql = "{call search_comment_by_user(?)}";
        String content;
        return addCommentsToList(nickName, comments, sql, conn);
    }

    private static List<Comment> addCommentsToList(String nickName, List<Comment> comments, String sql, Connection conn) {
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

    public static List<Post> searchPostByTitle(String title, Connection conn) {
        List<Post> posts = new ArrayList<>();
        String sql = "{call search_post_by_post_name(?)}";
        return addPostToList(title, posts, sql, conn);
    }

    public static List<Post> searchPostByContent(String content, Connection conn) {
        List<Post> posts = new ArrayList<>();
        String sql = "{call search_post_by_content(?)}";
        return addPostToList(content, posts, sql, conn);
    }

    public static List<Floor> searchFloorByContent(String content, Connection conn) {
        List<Floor> floors = new ArrayList<>();
        String sql = "{call search_floor_by_content(?)}";
        return addFloorToList(content, floors, sql, conn);
    }

    public static List<Comment> searchCommentByContent(String content, Connection conn) {
        List<Comment> comments = new ArrayList<>();
        String sql = "{call search_comment_by_content(?)}";
        return addCommentsToList(content, comments, sql, conn);
    }
    private static void addUserToList(ArrayList<User> users, CallableStatement search) throws SQLException {
        ResultSet rs = search.getResultSet();
        while (rs.next()) {
            int id = rs.getInt("id");
            String nickName = rs.getString("nickname");
            String profilePhoto = rs.getString("profile_photo_url");
            Timestamp registeredTime = rs.getTimestamp("registered_time");
            int type = User.phraseType(rs.getString("type"));
            String gender = rs.getString("gender");
            String address = rs.getString("address");
            String email = rs.getString("email");
            String phone = rs.getString("phone");
            int following = rs.getInt("following_num");
            int follower = rs.getInt("follower_num");
            //System.out.println(address);
            User user = new User(id, nickName, profilePhoto, registeredTime, type, gender, address, email, phone, follower, following);
            users.add(user);
        }
    }

    private static List<Post> addPostToList(String content, List<Post> posts, String sql, Connection conn) {
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

    private static List<Floor> addFloorToList(String content, List<Floor> floors, String sql, Connection conn) {
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


    private static void addFloorToList(List<Floor> floors, CallableStatement search) throws SQLException {
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

    private static void addPostFromResult(List<Post> posts, CallableStatement search) throws SQLException {
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
