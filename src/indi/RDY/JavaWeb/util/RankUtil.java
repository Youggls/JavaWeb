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
            System.out.println("inside rank");
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
            infoIds.sort(Comparator.comparing(o -> (o.getValue()).toString()));
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
}
