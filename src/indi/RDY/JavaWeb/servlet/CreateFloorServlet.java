package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;


import static java.nio.charset.StandardCharsets.ISO_8859_1;
import static java.nio.charset.StandardCharsets.UTF_8;

public class CreateFloorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //这里只是先这样获取，具体如何获取需要看前端
        String floorContent = new String(req.getParameter("content").getBytes(ISO_8859_1), UTF_8);
        int parentPostId = Integer.parseInt(req.getParameter("parentPostId"));
        Connection conn = DbUtil.getConnection();
        int floorNum = 0;
        try {
            CallableStatement statement = null;
            if (conn != null) {
                statement = conn.prepareCall("{CALL find_max_floor(?, ?)}");
                statement.setInt(1, parentPostId);
                statement.setInt(2, Types.INTEGER);
                statement.execute();
                floorNum = statement.getInt(2);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        int userId = Integer.parseInt(req.getParameter("userId"));
        Timestamp floorTime = new Timestamp(System.currentTimeMillis());
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = conn.prepareStatement("INSERT INTO floor (floor_num, parent_post_id, user_id, floor_content, floor_time) VALUES (?, ?, ?, ?, ?)");
            preparedStatement.setInt(1, floorNum + 1);
            preparedStatement.setInt(2, parentPostId);
            preparedStatement.setInt(3, userId);
            preparedStatement.setString(4, floorContent);
            preparedStatement.setTimestamp(5, floorTime);
            preparedStatement.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
