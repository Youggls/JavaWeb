package indi.RDY.JavaWeb.servlet;
import indi.RDY.JavaWeb.util.DbUtil;

import javax.management.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * Created by user on 17-7-20. * This Servlet suppport register page.
 */
@WebServlet(name = "CheckServlet", value = "/CheckServlet")
public class CheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = new String(request.getParameter("nickname").getBytes(UTF_8), UTF_8);
        Connection conn = DbUtil.getConnection();
        int count = 0;
        System.out.println(count);
        try {
            PreparedStatement search = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE nickname = ?");
            search.setString(1,  username);
            search.execute();
            ResultSet rs = search.getResultSet();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(count);

        if (count > 0) { //单纯测试，不进行连接数据库，，相同返回true
            response.getWriter().print(true);
        } else {
            //不同返回false;
            response.getWriter().print(false);
        }
    }

    @Override
    public void init() throws ServletException {
        DbUtil.init(this);
    }
}