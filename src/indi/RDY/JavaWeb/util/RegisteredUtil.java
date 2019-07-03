package indi.RDY.JavaWeb.util;

import java.sql.Connection;
import java.sql.Statement;
public class RegisteredUtil {
    private int id;
    private String password;
    private final String dbDriver = "com.mysql.jdbc.Driver";
    private String dbUrl;
    private Connection conn = null;
    private String dbUserName;
    private String dbPassword;
    private Statement statement;


}
