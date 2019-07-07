package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.bean.User;
import indi.RDY.JavaWeb.util.DbUtil;
import indi.RDY.JavaWeb.util.SearchUtil;

import javax.print.attribute.standard.MediaSize;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static java.nio.charset.StandardCharsets.ISO_8859_1;
import static java.nio.charset.StandardCharsets.UTF_8;

public class ChangeProfileServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String gender = new String(req.getParameter("gender").getBytes(ISO_8859_1), UTF_8);
        String address = new String(req.getParameter("address").getBytes(ISO_8859_1), UTF_8);
        String phone = new String(req.getParameter("phone").getBytes(ISO_8859_1), UTF_8);
        String email = new String(req.getParameter("email").getBytes(ISO_8859_1), UTF_8);
        String nickName = new String(req.getParameter("nickname").getBytes(ISO_8859_1), UTF_8);
        Connection conn = DbUtil.getConnection();
        User user = SearchUtil.searchUser(nickName, conn).get(0);
        int id = user.getId();

        String sql = "UPDATE profile SET gender = ?, address = ?, phone = ?, email = ? WHERE id = ?";
        try {
            PreparedStatement update = conn.prepareStatement(sql);
            update.setString(1, gender);
            update.setString(2, address);
            update.setString(3, phone);
            update.setString(4, email);
            update.setInt(5, id);
            update.executeUpdate();
            String redirect = new String(nickName.getBytes(UTF_8), ISO_8859_1);
            resp.sendRedirect("/JavaWeb/profile.jsp?nickname=" + redirect);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
