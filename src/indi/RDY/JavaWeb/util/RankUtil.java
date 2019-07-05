package indi.RDY.JavaWeb.util;

import java.sql.*;
import java.util.*;

public class RankUtil {

    private Connection conn = null;
    private HashMap<Integer, Integer> idPostNum;
    List<Map.Entry<Integer, Integer>> infoIds;
    public RankUtil() {
//        String dbUrl = "jdbc:mysql://localhost:3306/JavaWeb?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
//        String dbUserName = "cao";
//        String dbUserPassWord = "CaoXusheng136720";
//        try {
//            conn = DriverManager.getConnection(dbUrl, dbUserName, dbUserPassWord);
//        } catch (Exception e) {
//            System.out.println("can't connect to mysql");
//        }
        conn = DbUtil.getConnection();

    }
    public List<Map.Entry<Integer, Integer>> rank(/*HttpServletResponse resp, HttpServletRequest req*/) {
        try {
            System.out.println("inside rank");
//            req.setCharacterEncoding("UTF-8");
//            resp.setCharacterEncoding("UTF-8");
//            resp.setContentType("text/html; charset=UTF-8");

            idPostNum = new HashMap<>();

            Statement rk = conn.createStatement();
            String sql_read_post = "select user_id, post_id from post";
            rk.execute(sql_read_post);
            ResultSet rs = rk.getResultSet();
            while(rs.next()){
                int a = rs.getInt(1);
                int b = rs.getInt(2);
                if(idPostNum.containsKey(a)){
                    int oldValue = idPostNum.get(a);
                    idPostNum.replace(a,oldValue, oldValue+1);

                }
                else {
                    idPostNum.put(a,1);
                }
            }
            infoIds = new ArrayList<Map.Entry<Integer, Integer>>(idPostNum.entrySet());
            Collections.sort(infoIds, new Comparator<Map.Entry<Integer, Integer>>() {
                public int compare(Map.Entry<Integer, Integer> o1,
                                   Map.Entry<Integer, Integer> o2) {
                    return (o1.getValue()).toString().compareTo(o2.getValue().toString());
                }
            });



        }
        catch (Exception e) {
            System.out.println("error inside Rank");
            e.printStackTrace();
        }
        return infoIds;
    }
//    public static void main(String[] args) {
//        RankUtil ru = new RankUtil();
//        ru.rank();
//        for (int i = ru.infoIds.size() - 1; i >=0; i--) {
//            String id = ru.infoIds.get(i).toString();
//            System.out.print(id + "  ");
//        }
//    }

}
