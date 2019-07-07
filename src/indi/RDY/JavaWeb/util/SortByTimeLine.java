package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;

public class SortByTimeLine {
    private ArrayList<Post> posts;
    private Connection conn;

    public SortByTimeLine () {
        posts = new ArrayList<>();
        conn = DbUtil.getConnection();
    }
    public ArrayList<Post> Sort() {
        try{
            Statement st = conn.createStatement();
            String sql = "select * from post";
            st.execute(sql);
            ResultSet rs = st.getResultSet();
            while(rs.next()) {
                int postID = rs.getInt(1);
                int UserID = rs.getInt(2);
                String postName = rs.getString("post_name");
                String content = rs.getString("content");
                Timestamp time = rs.getTimestamp(5);
                Post p = new Post();
                p.setId(postID);
                p.setUserId(UserID);
                p.setPostName(postName);
                p.setContent(content);
                p.setTime(time);
                posts.add(p);
            }
        } catch (Exception e) {
            System.out.println("error during SortByTimeLine");
            e.printStackTrace();
        }
        Collections.sort(posts);
        return posts;
    }
}
