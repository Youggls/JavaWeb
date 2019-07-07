package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.util.DbUtil;
import org.apache.commons.io.FileUtils;
import org.json.JSONObject;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

import static java.io.File.separator;

public class ReadConfigServlet extends HttpServlet {
    public static String IMAGEPATH;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Override
    public void init() throws ServletException {
        DbUtil.init(this);
        ServletContext ctx = this.getServletContext();
        File jsonFile = new File(ctx.getRealPath("WEB-INF" + separator + "classes" + separator  + "bin" + separator + "config.json"));
        try {
            String content = FileUtils.readFileToString(jsonFile, "UTF-8");
            JSONObject jsonObject = new JSONObject(content);
            IMAGEPATH = jsonObject.getString("imagePath");
        } catch (IOException e) {
            System.out.println("Can not file path");
            e.printStackTrace();
        }
    }
}
