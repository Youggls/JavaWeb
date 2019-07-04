package indi.RDY.JavaWeb.servlet;

import indi.RDY.JavaWeb.util.DbUtil;
import indi.RDY.JavaWeb.util.RegisteredUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisteredServlet extends HttpServlet {

    public RegisteredServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RegisteredUtil rg = new RegisteredUtil();
        if(rg.register(resp, req)) {
            resp.sendRedirect("/JavaWeb/register_to_login.jsp");
        } else {
            System.out.println("unexpected problems occur during register");
        }

    }

    @Override
    public void init() throws ServletException {
        DbUtil.init(this);
    }
}
