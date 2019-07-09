package indi.RDY.JavaWeb.util;

import java.sql.*;
import java.util.*;

public class RankUtil {

    private Connection conn = null;
    private HashMap<Integer, Integer> idPostNum;
    List<Map.Entry<Integer, Integer>> infoIds;

    public RankUtil() {
        conn = DbUtil.getConnection();
    }

    public static List<Map.Entry<Integer, Integer>> rank() {
        HashMap<Integer, Integer> idPostNum;
        List<Map.Entry<Integer, Integer>> infoIds = new ArrayList<>();
        Connection conn = DbUtil.getConnection();
        try {
            idPostNum = new HashMap<>();
            Statement rk = conn.createStatement();
            String sql_read_post = "select user_id, post_id from post";
            rk.execute(sql_read_post);
            ResultSet rs = rk.getResultSet();
            while (rs.next()) {
                int a = rs.getInt(1);
                int b = rs.getInt(2);
                if (idPostNum.containsKey(a)) {
                    int oldValue = idPostNum.get(a);
                    idPostNum.replace(a, oldValue, oldValue + 1);
                } else {
                    idPostNum.put(a, 1);
                }
            }
            infoIds = new ArrayList<>(idPostNum.entrySet());
            infoIds.sort((o1, o2) -> -o1.getKey().compareTo(o2.getValue()));
            conn.close();
        } catch (Exception e) {
            System.out.println("error inside Rank");
            e.printStackTrace();
        }
        if (infoIds.size() < 30) {
            return infoIds;
        } else {
            return infoIds.subList(0, 30);
        }
    }

    public static List<Map.Entry<Integer, Integer>> rankByFloor() {
        Connection conn = DbUtil.getConnection();
        List<Map.Entry<Integer, Integer>> ranks = new ArrayList<>();
        HashMap<Integer, Integer> map = new HashMap<>();
        String sql = "SELECT COUNT(*), user_id FROM floor GROUP BY user_id";
        try {
            PreparedStatement count = conn.prepareStatement(sql);
            count.execute();
            ResultSet rs = count.getResultSet();
            while (rs.next()) {
                map.put(rs.getInt(2), rs.getInt(1));
            }
            ranks = new ArrayList<>(map.entrySet());
            ranks.sort((o1, o2) -> -o1.getKey().compareTo(o2.getValue()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ranks;
    }
}
