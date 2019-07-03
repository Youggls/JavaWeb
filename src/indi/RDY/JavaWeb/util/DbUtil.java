package indi.RDY.JavaWeb.util;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
public class DbUtil {
    private Connection conn;
    private static String dbUserName;
    private static String dbUserPassWord;
    private static String dbUrl;

    static {
        String separator = System.getProperty("file.separator");
        File jsonFile = new File("." + separator + "bin" + separator);
        try {
            String content = FileUtils.readFileToString(jsonFile, "UTF-8");
            JSONObject jsonObject = new JSONObject(content);
            dbUserPassWord = jsonObject.getString("dbUserPassword");
            dbUserName = jsonObject.getString("dbUserName");
            dbUrl = jsonObject.getString("dbUrl");
            Class.forName(dbUrl);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public DbUtil() {
        try {
            conn = DriverManager.getConnection(dbUrl, dbUserName, dbUserPassWord);
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection getConnectino() {
        return conn;
    }

    public ResultSet executeQuery(String sql) {
        ResultSet rs = null;
        Statement statement =null;
        try {
            statement = conn.createStatement();
            statement.executeQuery(sql);
            rs = statement.executeQuery(sql);
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
