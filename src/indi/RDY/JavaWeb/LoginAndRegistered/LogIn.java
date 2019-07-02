package indi.RDY.JavaWeb.LoginAndRegistered;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;

public class LogIn extends HttpServlet {
    private int id;
    private String password;
    private String dbDriver = "com.mysql.jdbc.Driver";
    private String dbUrl;
    private Connection conn = null;
    private String dbUserName;
    private String dbPassword;
    private Statement statement;
    public LogIn() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("name")) {
                    //如果cookie与保存的相等，即找到cookie
                    resp.sendRedirect("/JavaWeb/Main.jsp");
                    break;
                }
            }
        }
        try {
            statement = conn.prepareStatement("SELECT password FROM user WHERE id = ? AND password = ?");
            id = new Integer(req.getParameter("id"));
            password = req.getParameter("password");
            decodePassword();
            ((PreparedStatement) statement).setInt(1, id);
            ((PreparedStatement) statement).setString(2, password);
            ResultSet rs = statement.getResultSet();
            if (rs.next()) {
                System.out.println("User: " + id + "has logged in!");
                Cookie cookie = new Cookie("name", req.getParameter("id"));
                cookie.setPath(System.getProperty("file.separator"));
                if (req.getParameter("save") != null) {
                    //User chooses to save the password
                    resp.getWriter().append(req.getParameter("save"));
                    cookie.setMaxAge(60 * 60 * 24 * 2);
                } else {
                    //User doesn't choose to save the password
                    cookie.setMaxAge(60);
                }
                //Save the cookie
                resp.addCookie(cookie);
            } else {
                //Login failed!
                System.out.println("User: " + id + " failed!");
                resp.sendRedirect("/JavaWeb/error.jsp");
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    public void init() throws ServletException {
        String separator = System.getProperty("file.separator");
        File jsonFile = new File("." + separator + "bin" + separator + "config.json");
        try {
            String content = FileUtils.readFileToString(jsonFile, "UTF-8");
            JSONObject jsonObject = new JSONObject(content);
            dbPassword = jsonObject.getString("dbUserPassword");
            dbUserName = jsonObject.getString("dbUserName");
            conn = DriverManager.getConnection(dbUrl, dbUserName, dbPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void decodePassword() {
        char[] temp = new char[password.length()];
        //Use decode algorithm

        password = new String(temp);
    }

    public void encodePassowrd() {
        char[] temp = new char[password.length()];
        //Use encode algorithm

        password = new String(temp);
    }
}
