package indi.RDY.JavaWeb.servlet;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;

public class LoginServlet extends HttpServlet {
    private String dbDriver = "com.mysql.jdbc.Driver";
    private String dbUrl;
    private Connection conn = null;
    private String dbUserName;
    private String dbPassword;
    public LoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String URI = req.getRequestURI();
        if (URI.equals("/JavaWeb/index.jsp")) {

        } else if (URI.equals("/JavaWeb/main.jsp")) {

        } else if (URI.equals("/JavaWeb/profile.jsp")) {

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
}
