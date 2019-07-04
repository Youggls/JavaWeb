package indi.RDY.JavaWeb.servlet;
import javax.management.Query;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

import static java.nio.charset.StandardCharsets.UTF_8;

/**
 * Created by user on 17-7-20. * This Servlet suppport register page.
 */
@WebServlet(name = "CheckServlet", value = "/CheckServlet")
public class CheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("check");
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("check");
        String username = new String(request.getParameter("nickname").getBytes(StandardCharsets.ISO_8859_1), UTF_8);
        if (username.equals("test")) { //单纯测试，不进行连接数据库，，相同返回true
            response.getWriter().print(true);
        } else {
            //不同返回false;
            response.getWriter().print(false);
        }
    }
}