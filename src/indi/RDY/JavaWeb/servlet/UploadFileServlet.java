package indi.RDY.JavaWeb.servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.List;

public class UploadFileServlet extends HttpServlet {
    public UploadFileServlet() {
        super();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        //为解析类提供配置信息
        DiskFileItemFactory factory = new DiskFileItemFactory();
        //创建解析类的实例
        ServletFileUpload sfu = new ServletFileUpload(factory);
        //开始解析
        sfu.setFileSizeMax(1024*4000);
        //每个表单域中数据会封装到一个对应的FileItem对象上


        try {
            List<FileItem> items = sfu.parseRequest(req);
            //区分表单域
            for (int i = 0; i < items.size(); i++) {
                FileItem item = items.get(i);
                //isFormField为true，表示这不是文件上传表单域
                if(!item.isFormField()){
                    ServletContext sctx = getServletContext();
                    //获得存放文件的物理路径
                    //upload下的某个文件夹   得到当前在线的用户  找到对应的文件夹

                    String path = sctx.getRealPath("/upload");
                    System.out.println(path);
                    //获得文件名
                    String fileName = item.getName();
                    System.out.println(fileName);
                    //该方法在某些平台(操作系统),会返回路径+文件名
                    fileName = fileName.substring(fileName.lastIndexOf("/")+1);
                    int fileHash = fileName.hashCode();

                    String appendix = fileName.substring(fileName.indexOf("."));
                    ///System.out.println("appendix is "+appendix);
                    //String now = new Timestamp(System.currentTimeMillis()).toString();
                    fileName = fileHash+""+appendix;
                    File file = new File(path+"\\"+fileName);
                    String url="http://"+req.getServerName()+req.getServerPort()+req.getContextPath()+req.getServletPath()+"?"+fileHash+appendix;
                    System.out.println("url is "+url);

                    //File file = new File("D:"+"\\"+fileName);
                    System.out.println(file.getAbsolutePath()+" 存在吗："+file.exists());
                    if(!file.exists()){
                        System.out.println(item.getSize());
                        item.write(file);

                        //将上传图片的名字记录到数据库中

                        resp.sendRedirect("/JavaWeb/register_to_login.jsp");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("error while uploading file");
            e.printStackTrace();
        }

    }
}
