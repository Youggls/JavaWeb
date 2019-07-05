package indi.RDY.JavaWeb.servlet;

import com.sun.corba.se.impl.orbutil.ObjectWriter;
import indi.RDY.JavaWeb.bean.Post;
import indi.RDY.JavaWeb.util.SortByTimeLine;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectOutputStream;
import java.io.Writer;
import java.util.ArrayList;

@WebServlet(name = "SortByTimeServlet")
public class SortByTimeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SortByTimeLine sbtl = new SortByTimeLine();
        ArrayList<Post>p = sbtl.Sort();
        ObjectOutputStream oos = new ObjectOutputStream(response.getOutputStream());
        for(int i = 0; i < p.size(); i++) {
            oos.writeObject(p.get(i));
        }
        oos.flush();
        oos.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
