//package indi.RDY.JavaWeb.util;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.sql.Connection;
//import java.sql.Date;
//import java.sql.PreparedStatement;
//import java.sql.Statement;
//import java.text.SimpleDateFormat;
//
//public class RegisteredUtil {
//    private int id;
//    private String password;
//    private final String dbDriver = "com.mysql.jdbc.Driver";
//    private String dbUrl;
//    private Connection conn = null;
//    private String dbUserName;
//    private String dbPassword;
//    private Statement statement;
//
//    public RegisteredUtil(Connection conn) {
//        this.conn = conn;
//    }
//    public boolean register(HttpServletResponse resp, HttpServletRequest req) {
//        try {
//            req.setCharacterEncoding("UTF-8");
//            resp.setCharacterEncoding("UTF-8");
//            resp.setContentType("text/html; charset=UTF-8");
//
//            String nickName = req.getParameter("nickname");
//            String pwd = req.getParameter("password");
//            java.util.Date toDay = new java.util.Date();
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//            String date = dateFormat.format( toDay );
//            String type = "user";
//            PreparedStatement pstat = conn.prepareStatement("insert into " +
//                    "user(nickname, password, registered_date, type) values (?, ?,"+date+", "+type+")");
//
//        }
//        catch (Exception e) {
//
//            e.printStackTrace();
//        }
//
//    }
//    public static void main(String[] args) {
//
//    }
//}
package indi.RDY.JavaWeb.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.SimpleDateFormat;

public class RegisteredUtil {
    private int id;
    private String password;
    private final String dbDriver = "com.mysql.jdbc.Driver";
    private String dbUrl;
    private Connection conn = null;
    private String dbUserName;
    private String dbPassword;
    private Statement statement;

    public RegisteredUtil() {
        DbUtil dbUtil = new DbUtil();
        conn = dbUtil.getConnection();
    }
    public boolean register(HttpServletResponse resp, HttpServletRequest req) {
        try {
            System.out.println("inside util register");
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html; charset=UTF-8");

            String nickName = req.getParameter("nickname");
            String pwd = req.getParameter("password");
            java.util.Date toDay = new java.util.Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String date = dateFormat.format( toDay );
            String type = "user";

            String sql = "insert into user(nickname, password, registered_time, type) values(?,?,?,'user')";
//            Statement rg = conn.createStatement();
//            rg.execute(sql);
            PreparedStatement pstat = conn.prepareStatement(sql);
            pstat.setString(1, nickName);
            pstat.setString(2, pwd);
            pstat.setString(3, date);
            pstat.execute();


        }
        catch (Exception e) {
            System.out.println("error inside RegisteredUtil");
            e.printStackTrace();
        }
        return true;
    }
    public static void main(String[] args) {

    }
}
