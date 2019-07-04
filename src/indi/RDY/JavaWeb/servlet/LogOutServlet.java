package indi.RDY.JavaWeb.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogOutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("LogOut servlet");
        Cookie[] cookies = req.getCookies();
        for(Cookie cookie : cookies) {
            System.out.println(cookie.getName() + ": " + cookie.getValue());
            if (cookie.getName().equals("nickname")) {
                Cookie newCookie = new Cookie("nickname", "0");
                newCookie.setMaxAge(0);
                newCookie.setPath("/");
                resp.addCookie(newCookie);
                try {
                    Thread.sleep(50);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                break;
            }
        }
        resp.sendRedirect("/JavaWeb/index.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
}
