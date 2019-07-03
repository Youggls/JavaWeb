package indi.RDY.JavaWeb.servlet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import indi.RDY.JavaWeb.bean.User;
import indi.RDY.JavaWeb.util.DbUtil;
import indi.RDY.JavaWeb.util.LogInUtil;

public class LoginServlet extends HttpServlet {

    public LoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("get request");
        LogInUtil login = new LogInUtil();
        User user = login.login(resp, req);
        if (user != null) {
            resp.sendRedirect("/JavaWeb/main.jsp");
        } else {
            resp.sendRedirect("/JavaWeb/login_error.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //doPost(req, resp);
    }

    @Override
    public void init() throws ServletException {
        DbUtil.init(this);
    }
}
