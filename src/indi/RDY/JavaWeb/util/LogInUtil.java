package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.User;

import javax.servlet.http.*;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.*;

import static java.nio.charset.StandardCharsets.UTF_8;

public class LogInUtil {
    private String nickName;
    private String password;
    private Connection conn = null;

    public LogInUtil() {
        conn = DbUtil.getConnection();
    }

    //If login failed will return null pointer
    public User login(HttpServletResponse resp, HttpServletRequest req) throws IOException {
        Cookie[] cookies = req.getCookies();
        User user = null;
        String photoUrl = "";
        Timestamp time = null;
        int type = User.VISITOR;
        ResultSet rs = null;
        try {
            PreparedStatement login = conn.prepareStatement("SELECT * FROM user WHERE nickname = ? AND password = ?");
            nickName = new String(req.getParameter("nickname").getBytes(StandardCharsets.ISO_8859_1), UTF_8);
            password = req.getParameter("password");
            //decodePassword();
            login.setString(1, nickName);
            login.setString(2, password);
            login.execute();
            rs = login.getResultSet();

            String info;
            if (rs.next()) {
                info = "User: [" + nickName + "] successfully login!";
                Cookie cookie = new Cookie("nickname", nickName);
                cookie.setPath("/");
                //Save two days
                cookie.setMaxAge(2 * 24 * 60 * 60);
                //Save the cookie
                resp.addCookie(cookie);
                rs.previous();
            } else {
                info = "User: [" + nickName + "] login failed";
            }
            System.out.println(info);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (rs != null && rs.next()) {
                //Get user info from the database
                int id = rs.getInt("id");
                nickName = new String(rs.getString("nickname").getBytes(StandardCharsets.ISO_8859_1), UTF_8);
                password = rs.getString("password");
                photoUrl = rs.getString("profile_photo_url");
                time = rs.getTimestamp("registered_time");
                type = User.phraseType(rs.getString("type"));
                user = new User(id, nickName, password, photoUrl, type, time);
            }
            conn.close();
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
