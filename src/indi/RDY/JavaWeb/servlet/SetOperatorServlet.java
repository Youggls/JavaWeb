package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SetOperatorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        int id = Integer.parseInt(req.getParameter("id"));
        Connection conn = DbUtil.getConnection();
        if (type.equals("give")) {
            String sql = "UPDATE user SET type = 'operator' WHERE id = ?";
            try {
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setInt(1, id);
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                resp.getWriter().print("false");
            }
        } else if (type.equals("remove")) {
            String sql = "UPDATE user SET type = 'user' WHERE id = ?";
            try {
                PreparedStatement preparedStatement = conn.prepareStatement(sql);
                preparedStatement.setInt(1, id);
                preparedStatement.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                resp.getWriter().print("false");
            }
        } else {
            resp.getWriter().print("false");
        }
    }
}
