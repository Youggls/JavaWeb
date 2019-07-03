package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.User;

import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LogInUtil {
    private int id;
    private String password;
    private Connection conn = null;

    public LogInUtil() {
        DbUtil dbUtil = new DbUtil();
        conn = dbUtil.getConnection();
    }

    //If login failed will return null pointer
    public User login(HttpServletResponse resp, HttpServletRequest req) throws IOException {
        Cookie[] cookies = req.getCookies();
        User user = null;
        String nickName = "";
        String photoUrl = "";
        Timestamp time = null;
        int type = User.VISITOR;
        ResultSet rs = null;
        if (cookies != null && 1 == 0) {
            //The cookies existed
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    //The saved cookie existed id
                    System.out.println("use cookie to login" + id);
                    id = Integer.parseInt(cookie.getValue());
                    break;
                }
            }
            try {
                PreparedStatement login = conn.prepareStatement("SELECT * FROM user WHERE id = ?");
                login.setInt(1, id);
                login.execute();
                rs = login.getResultSet();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        } else {
            //Cookie doesn't exist, user should input the id and password
            try {
                PreparedStatement login = conn.prepareStatement("SELECT * FROM user WHERE id = ? AND password = ?");
                id = Integer.parseInt(req.getParameter("id"));
                password = req.getParameter("password");
                //decodePassword();
                login.setInt(1, id);
                login.setString(2, password);
                login.execute();
                rs = login.getResultSet();

                String info;
                if (rs.next()) {
                    //Login succeed!
                    info = "User: [" + id + "] successfully login!";
                    Cookie cookie = new Cookie("id", "" + id);
                    cookie.setPath(System.getProperty("file.separator"));
                    //resp.getWriter().append(req.getParameter("save"));
                    //Save two days
                    cookie.setMaxAge(2 * 24 * 60 * 60);
                    //Save the cookie
                    resp.addCookie(cookie);
                    rs.previous();
                } else {
                    info = "User: [" + id + "] login failed";
                }
                System.out.println(info);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        try {
            if (rs != null && rs.next()) {
                //Get user info from the database
                id = rs.getInt("id");
                nickName = rs.getString("nickname");
                password = rs.getString("password");
                photoUrl = rs.getString("profile_photo_url");
                time = rs.getTimestamp("registered_time");
                type = User.phraseType(rs.getString("type"));
                user = new User(id, nickName, password, photoUrl, type, time);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    private void decodePassword() {
        char[] temp = new char[password.length()];
        //Use decode algorithm

        password = new String(temp);
    }

    private void encodePassowrd() {
        char[] temp = new char[password.length()];
        //Use encode algorithm

        password = new String(temp);
    }
}
