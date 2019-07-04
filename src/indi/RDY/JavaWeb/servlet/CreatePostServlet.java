package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.bean.User;
import indi.RDY.JavaWeb.util.DbUtil;
import indi.RDY.JavaWeb.util.SearchUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

import static java.nio.charset.StandardCharsets.ISO_8859_1;
import static java.nio.charset.StandardCharsets.UTF_8;

public class CreatePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //这里只是先这样获取，具体如何获取需要看前端
        String postContent = new String(req.getParameter("content").getBytes(ISO_8859_1), UTF_8);
        String nickName = new String(req.getParameter("nickname").getBytes(ISO_8859_1), UTF_8);
        String postName = new String(req.getParameter("postname").getBytes(ISO_8859_1), UTF_8);

        Timestamp time = new Timestamp(System.currentTimeMillis());

        Connection conn = DbUtil.getConnection();
        int id = 0;
        List<User> users = SearchUtil.searchUser(id, conn);
        id = users.get(0).getId();
        try {
            PreparedStatement insert = conn.prepareStatement("INSERT INTO post (user_id, post_name, content, post_time) VALUES(?, ?, ?, ?) ");
            insert.setInt(1, id);
            insert.setString(2, postName);
            insert.setString(3, postContent);
            insert.setTimestamp(4, time);
            insert.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
}
