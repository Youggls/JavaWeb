package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FollowServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int followerId = Integer.parseInt(req.getParameter("follower_id"));
        int followedId = Integer.parseInt(req.getParameter("followed_id"));

        Connection conn = DbUtil.getConnection();
        String sql = "INSERT INTO follow VALUES(?, ?)";
        try {
            PreparedStatement insert = conn.prepareStatement(sql);
            insert.setInt(1, followerId);
            insert.setInt(2, followedId);
            insert.executeUpdate();
            resp.getWriter().print("ok");
        } catch (SQLException e) {
            e.printStackTrace();
            if (e.getErrorCode() == 1062) {
                resp.getWriter().print("followed!");
            }
        }
    }
}
