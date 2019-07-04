package indi.RDY.JavaWeb.util;

import indi.RDY.JavaWeb.bean.*;

import javax.jws.soap.SOAPBinding;
import java.util.*;
import java.sql.*;

public class SearchUtil {
    private Connection conn;

    public SearchUtil() {
        DbUtil dbUtil = new DbUtil();
        this.conn = dbUtil.getConnection();
    }

    public List<User> searchUser(String name) {
        String sql = "{call search_user_by_name(?)}";
        ArrayList<User> users = new ArrayList<>();
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setString(1, name);
            search.executeUpdate();
            ResultSet rs = search.getResultSet();
            while (rs.next()) {
                int id = rs.getInt("id");
                String nickName = rs.getString("nickname");
                String profilePhoto = rs.getString("profile_photo_url");
                Timestamp registeredTime = rs.getTimestamp("registered_time");
                int type = User.phraseType(rs.getString("type"));
                User user = new User(id, nickName, profilePhoto, type, registeredTime);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchUser(int id) {
        String sql = "{call search_user_by_id(?)}";
        ArrayList<User> users = new ArrayList<>();
        try {
            CallableStatement search = conn.prepareCall(sql);
            search.setInt(1, id);
            search.executeUpdate();
            ResultSet rs = search.getResultSet();

            while (rs.next()) {
                int user_id = rs.getInt("id");
                String nickName = rs.getString("nickname");
                Timestamp registeredTime = rs.getTimestamp("registered_time");
                String profilePhoto = rs.getString("profile_photo_url");
                int type = User.phraseType(rs.getString("type"));
                User user = new User(user_id, nickName, profilePhoto, type, registeredTime);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }
}
