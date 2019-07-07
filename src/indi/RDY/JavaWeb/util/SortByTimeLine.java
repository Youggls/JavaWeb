package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.Post;
import indi.RDY.JavaWeb.bean.TextContainer;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

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
