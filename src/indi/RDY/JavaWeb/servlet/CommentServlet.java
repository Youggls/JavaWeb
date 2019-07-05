package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.bean.User;
import indi.RDY.JavaWeb.util.DbUtil;
import jdk.nashorn.internal.runtime.ECMAException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;

import static java.nio.charset.StandardCharsets.UTF_8;

@WebServlet(name = "CommentServlet")
public class CommentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = new String(request.getParameter("nickname").getBytes(StandardCharsets.ISO_8859_1), UTF_8);
        int rootFloorId = Integer.parseInt(request.getParameter("rootFloorId"));
        int preCommentId = Integer.parseInt(request.getParameter("preCommentId"));
        String content = new String (request.getParameter("content").getBytes(StandardCharsets.ISO_8859_1), UTF_8);
        Timestamp time = new Timestamp(System.currentTimeMillis());
        int userId;
        Connection conn = DbUtil.getConnection();
        try {
            String sqlFindUser = " select id from user where nickname = ?";
            PreparedStatement pst = conn.prepareStatement(sqlFindUser);
            pst.setString(1, username);
            pst.execute();
            ResultSet rs = pst.getResultSet();
            if(rs.next()) {
                userId = rs.getInt(1);
            }
            else {
                userId = 0;
            }
            String sqlInseret = "insert into comment(user_id, root_floor_id, pre_comment_id, content, currrent_time,isdeleted) values(?,?,?,?,?,0)";
            PreparedStatement pst2 = conn.prepareStatement(sqlInseret);
            pst2.setInt(1, userId);
            pst2.setInt(2, rootFloorId);
            pst2.setInt(3,preCommentId);
            pst2.setString(4,content);
            pst2.setTimestamp(5, time);
            pst2.execute();
            System.out.println("评论成功");
        } catch (Exception e) {
            System.out.println("error inside CommentServlet");
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void init() throws ServletException {
        DbUtil.init(this);
    }
}
