package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortByTimeLine {
    private ArrayList<Post> posts;
    private Connection conn;

    public SortByTimeLine () {
        posts = new ArrayList<>();
        String dbUrl = "jdbc:mysql://localhost:3306/JavaWeb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String dbUserName = "cao";
        String dbUserPassWord = "CaoXusheng136720";
        try {
            conn = DriverManager.getConnection(dbUrl, dbUserName, dbUserPassWord);
        } catch (Exception e) {
            System.out.println("can't connect to mysql");
        }
        //conn = DbUtil.getConnection();
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
        Collections.sort(posts, new Comparator<Post>() {
            @Override
            public int compare(Post o1, Post o2) {
                return o1.getTime().toString() .compareTo(o2.getTime().toString()) ;
            }
        });
        return posts;
    }
    public static void main(String[] args) {
        SortByTimeLine sb = new SortByTimeLine();
        ArrayList<Post> p = sb.Sort();
        for(int i = 0; i < p.size(); i++) {
            System.out.println("时间：" + p.get(i).getTime()+"名字"+p.get(i).getPostName());
        }

    }
}
