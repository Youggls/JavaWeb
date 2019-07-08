package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.Comment;
import indi.RDY.JavaWeb.bean.Floor;
import indi.RDY.JavaWeb.bean.Post;
import indi.RDY.JavaWeb.bean.TextContainer;

import java.sql.*;
import java.util.*;

public class SortByTimeLine {
    private ArrayList<Post> posts;
    private Connection conn;

    public SortByTimeLine() {
        posts = new ArrayList<>();
        conn = DbUtil.getConnection();
    }

    public ArrayList<Post> Sort() {
        try {
            Statement st = conn.createStatement();
            String sql = "select * from post";
            st.execute(sql);
            ResultSet rs = st.getResultSet();
            while (rs.next()) {
                int postId = rs.getInt(1);
                int userId = rs.getInt(2);
                String postName = rs.getString("post_name");
                String content = rs.getString("content");
                Timestamp time = rs.getTimestamp(5);
                Post p = new Post(postId, userId, postName, content, time);
                System.out.println(p.getPostName());
                posts.add(p);
            }
            conn.close();
        } catch (Exception e) {
            System.out.println("error during SortByTimeLine");
            e.printStackTrace();

        }
        Collections.sort(posts);
        return posts;
    }

    public static List<Floor> sortFloor(int parentId) {
        List<Floor> floors = new ArrayList<>();
        Connection conn = DbUtil.getConnection();
        String sql = "SELECT * FROM floor WHERE parent_post_id = ?";
        try {
            PreparedStatement search = conn.prepareStatement(sql);
            search.setInt(1, parentId);
            search.execute();
            ResultSet rs = search.getResultSet();
            while (rs.next()) {
                floors.add(new Floor(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getTimestamp(6)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Collections.sort(floors, new Comparator<Floor>() {
            @Override
            public int compare(Floor o1, Floor o2) {
                return Integer.compare(o1.getFloorNum(), o2.getFloorNum());
            }
        });
        return floors;
    }

    public static List<Comment> sortComment(int rootFloorId) {
        List<Comment> comments = new ArrayList<>();
        Connection conn = DbUtil.getConnection();

        String sql = "SELECT * FROM comment WHERE root_floor_id=?";
        try {
            PreparedStatement search = conn.prepareStatement(sql);
            search.setInt(1, rootFloorId);
            search.execute();
            ResultSet rs = search.getResultSet();
            while (rs.next()) {
                comments.add(new Comment(rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getTimestamp(6),
                        rs.getBoolean(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        Collections.sort(comments, new Comparator<Comment>() {
            @Override
            public int compare(Comment o1, Comment o2) {
                return o1.getTime().compareTo(o2.getTime());
            }
        });

        return comments;
    }

    public static List<TextContainer> sortFollowing(int userId) {
        List<TextContainer> texts = new ArrayList<>();
        Connection conn = DbUtil.getConnection();
        String sql = "SELECT followed_id FROM follow where follower_id = ?";
        ArrayList<Integer> followingUser = new ArrayList<>();
        String nickName = "";
        try {
            PreparedStatement search = conn.prepareStatement(sql);
            search.setInt(1, userId);
            search.execute();
            ResultSet rs = search.getResultSet();
            while (rs.next()) {
                followingUser.add(rs.getInt(1));
            }

            for (Integer id : followingUser) {
                texts.addAll(SearchUtil.searchTextByUser(id, conn));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Collections.sort(texts);
        return texts;
    }
}
