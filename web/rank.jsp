<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Map" %>
<%@ page import="indi.RDY.JavaWeb.util.RankUtil" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Raymond
  Date: 2019-07-04
  Time: 01:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>排行榜——JavaWeb论坛</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
  <script src="${pageContext.request.contextPath}/jquery-2.1.1/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <style>
    body {
      padding: 90px 30px;
    }

    a:link {
      color: #000000;
      text-decoration: none;
    }

    a:hover {
      color: #175199;
      text-decoration: none;
    }
  </style>
</head>
<body>
<%
  Cookie[] cookies = request.getCookies();
  boolean login = false;
  if (cookies != null) {
    for (Cookie cookie : cookies) {
      if (cookie.getName().equals("nickname")) {
        login = true;
        break;
      }
    }
    if (login) {%>
<div>
  <%@include file="head_login.jsp" %>
</div>
<%} else {%>
<div>
  <%@include file="head_visitor.jsp" %>
</div>
<%
    }
  }
%>
<div class="col-md-3"></div>
<div class="col-md-6">
  <div class="row">
    <%
      String type = request.getParameter("ranktype");
      String sql;
      Connection conn2 = DbUtil.getConnection();
      if (type.equals("post")) {
        List<Map.Entry<Integer, Integer>> rank = RankUtil.rank();
        for (Map.Entry<Integer, Integer> user_rank : rank) {
          int user_id = user_rank.getKey();
          int post_num = user_rank.getValue();
          User user = SearchUtil.searchUser(user_id, conn2).get(0);
          String detail = "发表了" + post_num + "篇帖子";
          pageContext.setAttribute("posturl", "/JavaWeb/profile.jsp?nickname=" + user.getNickName());
          pageContext.setAttribute("title", user.getNickName());
          pageContext.setAttribute("detail", detail);
          pageContext.setAttribute("currentUser", user);
    %>
    <div class="panel panel-default">
      <div class="panel-body">
        <img id="${currentUser.id}" class="img-thumbnail"
             align="center" width="50px" height="50px" alt="Me" src=${currentUser.photoUrl}>
        <a style="font-size: 25px;margin-top: 5px;height: 30px;font-weight: 900"
           href=${posturl}>${title}</a><br>
        <span style="margin-top: 30px">${title}：&nbsp;&nbsp;${detail}</span>
      </div>
    </div>


    <%
      }
    } else if (type.equals("floor")) {
      List<Map.Entry<Integer, Integer>> ranks = RankUtil.rankByFloor();
      for (Map.Entry<Integer, Integer> user_rank : ranks) {
        int user_id = user_rank.getKey();
        int post_num = user_rank.getValue();
        User user = SearchUtil.searchUser(user_id, conn2).get(0);
        String detail = "发表了" + post_num + "篇评论";
        pageContext.setAttribute("posturl", "/JavaWeb/profile.jsp?nickname=" + user.getNickName());
        pageContext.setAttribute("title", user.getNickName());
        pageContext.setAttribute("detail", detail);
        pageContext.setAttribute("currentUser", user);%>
    <div class="panel panel-default">
      <div class="panel-body">
        <img id="${currentUser.id}" class="img-thumbnail"
             align="center" width="50px" height="50px" alt="Me" src=${currentUser.photoUrl}>
        <a style="font-size: 25px;margin-top: 5px;height: 30px;font-weight: 900"
           href=${posturl}>${title}</a><br>
        <span style="margin-top: 30px">${title}：&nbsp;&nbsp;${detail}</span>
      </div>
    </div>
    <%
        }
      } else if (type.equals("registertime")) {
        sql = "SELECT * FROM user ORDER BY registered_time";
        List<User> users = new ArrayList<>();
        try {
          PreparedStatement statement = conn2.prepareStatement(sql);
          statement.execute();
          ResultSet rs = statement.getResultSet();
          int count = 0;
          while (rs.next()) {
            users.add(new User(rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    rs.getString(4),
                    User.phraseType(rs.getString(6)),
                    rs.getTimestamp(5)));
            count++;
            if (count >= 30) break;
          }
        } catch (SQLException e) {
          e.printStackTrace();
        }
        for (User user : users) {
            pageContext.setAttribute("currentUser", user);
            pageContext.setAttribute("userUrl", "/JavaWeb/profile.jsp?nickname=" + user.getNickName());
            pageContext.setAttribute("detail", "注册于" + user.getRegisteredTime());
            %>
    <div class="panel panel-default">
      <div class="panel-body">
        <img id="${currentUser.id}" class="img-thumbnail"
             align="center" width="50px" height="50px" alt="Me" src=${currentUser.photoUrl}>
        <a style="font-size: 25px;margin-top: 5px;height: 30px;font-weight: 900"
           href=${userUrl}>${currentUser.nickName}</a><br>
        <span style="margin-top: 30px">${currentUser.nickName}：&nbsp;&nbsp;${detail}</span>
      </div>
    </div>
    <%
        }
      }
      conn2.close();
    %>
  </div>
</div>
<div class="col-md-3"></div>
</body>
</html>
