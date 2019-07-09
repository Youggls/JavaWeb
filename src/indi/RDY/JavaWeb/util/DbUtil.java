package indi.RDY.JavaWeb.util;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.*;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

abstract public class DbUtil {
    private static String dbUserName;
    private static String dbUserPassWord;
    private static String dbUrl;

    public static void init(HttpServlet servlet) {
        String separator = System.getProperty("file.separator");
        ServletContext ctx = servlet.getServletContext();
        File jsonFile = new File(ctx.getRealPath("WEB-INF" + separator + "classes" + separator + "bin" + separator + "config.json"));
        try {
            String content = FileUtils.readFileToString(jsonFile, "UTF-8");
            JSONObject jsonObject = new JSONObject(content);
            dbUserPassWord = jsonObject.getString("dbUserPassword");
            dbUserName = jsonObject.getString("dbUserName");
            dbUrl = jsonObject.getString("dbUrl");
            Class.forName("com.mysql.cj.jdbc.Driver");
        }
        catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            Connection conn = DriverManager.getConnection(dbUrl, dbUserName, dbUserPassWord);
            return conn;
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
