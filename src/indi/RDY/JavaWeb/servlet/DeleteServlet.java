package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.bean.User;
import indi.RDY.JavaWeb.util.DbUtil;
import indi.RDY.JavaWeb.util.SearchUtil;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Map;

public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");

        int id = Integer.parseInt(req.getParameter("id"));
        String nickname = req.getParameter("nickname");
        Connection conn = DbUtil.getConnection();
        User requestUser = SearchUtil.searchUser(nickname, conn).get(0);
        int requestUserId = requestUser.getId();
        int requestUserType = requestUser.getType();
        try {
            String sql = "";
            String sql1 = "";
            if (type.equals("user")) {
                if (requestUserType >= User.OPERATOR) {
                    sql = "SELECT post_id FROM post WHERE user_id = ?";
                    PreparedStatement delete = conn.prepareStatement(sql);
                    delete.setInt(1, id);
                    delete.execute();
                    ResultSet rs = delete.getResultSet();
                    sql = "{CALL delete_post(?)}";
                    PreparedStatement p = conn.prepareStatement(sql);
                    while (rs.next()) {
                        p.setInt(1, rs.getInt(1));
                        p.executeUpdate();
                    }
                    sql = "SELECT floor_id FROM floor WHERE user_id = ?";
                    delete = conn.prepareStatement(sql);
                    delete.setInt(1, id);
                    delete.execute();
                    rs = delete.getResultSet();
                    sql = "{CALL delete_floor(?)}";
                    p = conn.prepareStatement(sql);
                    while (rs.next()) {
                        p.setInt(1, rs.getInt(1));
                        p.executeUpdate();
                    }
                    sql = "SELECT comment_id FROM comment WHERE user_id = ?";
                    delete = conn.prepareStatement(sql);
                    delete.setInt(1, id);
                    delete.execute();
                    rs = delete.getResultSet();
                    sql = "{CALL delete_comment(?)}";
                    p = conn.prepareStatement(sql);
                    while (rs.next()) {
                        p.setInt(1, rs.getInt(1));
                        p.executeUpdate();
                    }
                    sql = "DELETE FROM user WHERE id =";
                    p = conn.prepareStatement(sql);
                    p.setInt(1, id);
                    p.executeUpdate();
                    resp.getWriter().print("true");
                    return;
                } else {
                    resp.getWriter().print("false");
                }
            } else {
                System.out.println(type + ":" + requestUserType + ":" + id);
                if (type.equals("comment")) {
                    sql = "{CALL delete_comment(?)}";
                    sql1 = "SELECT user_id FROM comment WHERE comment_id = ?";
                } else if (type.equals("floor")) {
                    sql = "{CALL delete_floor(?)}";
                    sql1 = "SELECT user_id FROM floor WHERE floor_id = ?";
                } else if (type.equals("post")) {
                    sql = "{CALL delete_post(?)}";
                    sql1 = "SELECT user_id FROM post WHERE post_id = ?";
                } else {
                    resp.sendRedirect("/JavaWeb/error.jsp");
                }
                if (requestUserType >= User.OPERATOR) {
                    CallableStatement callableStatement = conn.prepareCall(sql);
                    callableStatement.setInt(1, id);
                    callableStatement.executeUpdate();
                    resp.getWriter().print("true");
                } else {
                    PreparedStatement search = conn.prepareCall(sql1);
                    search.setInt(1, id);
                    search.execute();
                    ResultSet rs = search.getResultSet();
                    int userId = 0;
                    while (rs.next()) {
                        userId = rs.getInt(1);
                    }
                    if (userId == requestUserId) {
                        CallableStatement callableStatement = conn.prepareCall(sql);
                        callableStatement.setInt(1, id);
                        callableStatement.executeUpdate();
                        resp.getWriter().print("true");
                    } else {
                        resp.getWriter().print("false");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
