package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.util.DbUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.List;

import static java.io.File.separator;
import static java.nio.charset.StandardCharsets.*;

public class UploadImageServlet extends HttpServlet {

    private boolean isAjax(HttpServletRequest request) {
        return (request.getHeader("X-Requested-With") != null && "XMLHttpRequest"
                .equals(request.getHeader("X-Requested-With").toString()));

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

        //为解析类提供配置信息
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //创建解析类的实例
        ServletFileUpload sfu = new ServletFileUpload(factory);
        //开始解析
        sfu.setFileSizeMax(1024 * 4000);
        String url = null;
        String nickname = null;
        try {
            List<FileItem> items = sfu.parseRequest(req);
            //区分表单域
            for (int i = 0; i < items.size(); i++) {
                FileItem item = items.get(i);
                //isFormField为true，表示这不是文件上传表单域
                if (!item.isFormField()) {
                    //获得文件名
                    String fileName = item.getName();
                    //该方法在某些平台(操作系统),会返回路径+文件名
                    fileName = fileName.substring(fileName.lastIndexOf("/") + 1);
                    int fileHash = fileName.hashCode();

                    String appendix = fileName.substring(fileName.indexOf("."));
                    fileName = fileHash + System.nanoTime() + "" + appendix;
                    File file = new File(ReadConfigServlet.IMAGEPATH + separator + fileName);
                    url = "http://" + req.getServerName() + ":" + req.getServerPort() + req.getContextPath() + "/Image" + "?name=" + fileName;
                    item.write(file);
                } else {
                    String fieldName = item.getFieldName();
                    String con = item.getString("UTF-8");
                    if (fieldName.equals("nickname")) {
                        nickname = con;
                    }

                }
            }
            if (nickname != null && url != null) {
                String sql = "UPDATE user SET profile_photo_url = ? WHERE nickname = ?";
                Connection conn = DbUtil.getConnection();
                PreparedStatement preparedStatement = null;
                try {
                    preparedStatement = conn.prepareStatement(sql);
                    preparedStatement.setString(1, url);
                    preparedStatement.setString(2, nickname);
                    preparedStatement.executeUpdate();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            System.out.println("error while uploading file");
            e.printStackTrace();
        }
        String revUrl = "{\"photoURL\":\"" + url + "\"}";
        System.out.println(revUrl);
        resp.getWriter().print(revUrl);
    }
}
