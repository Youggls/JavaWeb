package indi.RDY.JavaWeb.util;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class LogInUtil {
    private int id;
    private String password;
    private final String dbDriver = "com.mysql.jdbc.Driver";
    private String dbUrl;
    private Connection conn = null;
    private String dbUserName;
    private String dbPassword;
    private Statement statement;

//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        Cookie[] cookies = req.getCookies();
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                if (cookie.getName().equals("name")) {
//                    //如果cookie与保存的相等，即找到cookie
//                    resp.sendRedirect("/JavaWeb/Main.jsp");
//                    break;
//                }
//            }
//        }
//        try {
//            statement = conn.prepareStatement("SELECT password FROM user WHERE id = ? AND password = ?");
//            id = new Integer(req.getParameter("id"));
//            password = req.getParameter("password");
//            decodePassword();
//            ((PreparedStatement) statement).setInt(1, id);
//            ((PreparedStatement) statement).setString(2, password);
//            ResultSet rs = statement.getResultSet();
//            if (rs.next()) {
//                System.out.println("User: " + id + "has logged in!");
//                Cookie cookie = new Cookie("name", req.getParameter("id"));
//                cookie.setPath(System.getProperty("file.separator"));
//                if (req.getParameter("save") != null) {
//                    //User chooses to save the password
//                    resp.getWriter().append(req.getParameter("save"));
//                    cookie.setMaxAge(60 * 60 * 24 * 2);
//                } else {
//                    //User doesn't choose to save the password
//                    cookie.setMaxAge(60);
//                }
//                //Save the cookie
//                resp.addCookie(cookie);
//            } else {
//                //Login failed!
//                System.out.println("User: " + id + " failed!");
//                resp.sendRedirect("/JavaWeb/error.jsp");
//            }
//        }
//        catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }

    public LogInUtil(Connection conn) {
        this.conn = conn;
    }

    public boolean login(HttpServletResponse resp, HttpServletRequest req) throws IOException {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            //The cookies existed
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    //The saved cookie existed id
                    resp.sendRedirect("/JavaWeb/main.jsp");
                    break;
                }
            }

            try {
                PreparedStatement login = conn.prepareStatement("SELECT * FROM user WHERE id = ? AND password = ?");
                id = Integer.parseInt(req.getParameter("id"));
                password = req.getParameter("password");
                decodePassword();
                login.setInt(1, id);
                login.setString(2, password);
                login.execute();
                ResultSet rs = login.getResultSet();
                Cookie cookie = new Cookie("id", req.getParameter("id"));
                cookie.setPath(System.getProperty("file.separator"));
                if (rs.next()) {
                    //Login succeed!
                    String info = "User: [" + id + "] successfully login!";
                    System.out.println(info);

                    if (req.getParameter("save") != null) {
                        //save cookie for two days
                        resp.getWriter().append(req.getParameter("save"));
                        cookie.setMaxAge(2 * 24 * 60 * 60);
                    } else {
                        //save for 60s
                        cookie.setMaxAge(60);
                    }
                    //Save the cookie
                    resp.addCookie(cookie);
                } else {
                    String info = "User: [" + id + "] login failed";
                }
            }
            catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return true;
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
